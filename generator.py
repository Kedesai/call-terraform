import os
import subprocess
import json
import requests
from jinja2 import Template

def run_git_command(command):
    """Helper to run git commands and return output."""
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Git Error: {result.stderr}")
    return result.stdout

def create_github_pr(token, repo_full_name, head_branch, base_branch, title, body):
    """Uses GitHub REST API to create a Pull Request."""
    url = f"https://api.github.com/repos/{repo_full_name}/pulls"
    headers = {
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github.v3+json"
    }
    payload = {
        "title": title,
        "body": body,
        "head": head_branch,
        "base": base_branch
    }
    response = requests.post(url, headers=headers, json=payload)
    if response.status_code == 201:
        print(f"PR Created Successfully: {response.json().get('html_url')}")
    else:
        print(f"Failed to create PR: {response.text}")

def generate_terraform(project_name, environment="dev", technologies=None, instance_count=0, 
                       owner="platform-team", visibility="internal", state_bucket="my-org-tf-state",
                       git_push=False, github_token=None, repo_full_name=None):
    if technologies is None:
        technologies = ["vpc"] # Default

    # Ensure VPC is present if networking-dependent services are requested
    if any(t in ["ec2", "lambda", "rds"] for t in technologies) and "vpc" not in technologies:
        technologies.append("vpc")

    # This template calls the modules you've already defined
    template_hcl = """
terraform {
  backend "s3" {
    bucket = "{{ state_bucket }}"
    key    = "deployments/{{ environment }}/{{ project_name }}/terraform.tfstate"
    region = "us-east-1"
  }
}

{% if "kms" in technologies %}
module "kms_key" {
  source      = "{{ kms_module_path }}"
  key_name    = "{{ project_name }}-key"
  environment = "{{ environment }}"
  tags = {
    Project     = "{{ project_name }}"
    Environment = "{{ environment }}"
    ManagedBy   = "Terraform-Generator"
    Owner       = "{{ owner }}"
  }
}
{% endif %}

{% if "s3" in technologies %}
module "s3_bucket" {
  source      = "{{ s3_module_path }}"
  bucket_name = "{{ project_name }}-data-{{ environment }}"
  environment = "{{ environment }}"
  tags = {
    Project     = "{{ project_name }}"
    Environment = "{{ environment }}"
    ManagedBy   = "Terraform-Generator"
    Owner       = "{{ owner }}"
  }
}
{% endif %}

{% if "vpc" in technologies %}
module "vpc" {
  source = "{{ vpc_module_path }}"
  vpc_cidr    = "10.0.0.0/16"
  environment = "{{ environment }}"
  availability_zones = ["us-east-1a", "us-east-1b"]
  tags = {
    Application = "{{ project_name }}"
    Project     = "{{ project_name }}"
    Environment = "{{ environment }}"
    ManagedBy   = "Terraform-Generator"
    Owner       = "{{ owner }}"
  }
}
{% endif %}

{% if "ec2" in technologies %}
{% for i in range(instance_count|int) %}
module "ec2_{{ i }}" {
  source        = "{{ ec2_module_path }}"
  instance_name = "{{ project_name }}-vm-{{ i }}"
  environment   = "{{ environment }}"
  {% if visibility == "external" %}
  subnet_id           = module.vpc.public_subnet_ids[0]
  associate_public_ip = true
  {% else %}
  subnet_id           = module.vpc.private_subnet_ids[0]
  associate_public_ip = false
  {% endif %}
  tags = {
    Application = "{{ project_name }}"
    Project     = "{{ project_name }}"
    Environment = "{{ environment }}"
    ManagedBy   = "Terraform-Generator"
    Owner       = "{{ owner }}"
    Visibility  = "{{ visibility }}"
  }
}
{% endfor %}
{% endif %}

{% if "lambda" in technologies %}
module "lambda_function" {
  source        = "{{ lambda_module_path }}"
  function_name = "{{ project_name }}-func"
  environment   = "{{ environment }}"
  runtime       = "python3.11"
  handler       = "index.handler"
  role_arn      = "arn:aws:iam::123456789012:role/lambda-role" # Example
  tags = {
    Project     = "{{ project_name }}"
    Environment = "{{ environment }}"
    ManagedBy   = "Terraform-Generator"
    Owner       = "{{ owner }}"
  }
}
{% endif %}

{% if "dynamodb" in technologies %}
module "dynamodb_table" {
  source      = "{{ dynamodb_module_path }}"
  table_name  = "{{ project_name }}-table"
  environment = "{{ environment }}"
  hash_key    = "id"
  tags = {
    Application = "{{ project_name }}"
    Project     = "{{ project_name }}"
    Environment = "{{ environment }}"
    ManagedBy   = "Terraform-Generator"
    Owner       = "{{ owner }}"
  }
}
{% endif %}
"""
    
    context = {
        "project_name": project_name,
        "instance_count": instance_count,
        "environment": environment,
        "state_bucket": state_bucket,
        "technologies": technologies,
        "owner": owner,
        "visibility": visibility,
        "vpc_module_path": "../../vpc",
        "ec2_module_path": "../../ec2",
        "dynamodb_module_path": "../../dynamodb",
        "s3_module_path": "../../s3",
        "kms_module_path": "../../kms",
        "lambda_module_path": "../../lambda"
    }

    t = Template(template_hcl)
    rendered = t.render(context)

    # Create directory and write file
    output_path = f"./deployments/{project_name}"
    os.makedirs(output_path, exist_ok=True)
    with open(f"{output_path}/main.tf", "w") as f:
        f.write(rendered)
    
    print(f"Terraform code generated at {output_path}/main.tf")

    # Git Automation Logic
    if git_push and github_token and repo_full_name:
        branch_name = f"infra/{project_name}-{environment}"
        
        print(f"Preparing branch: {branch_name}")
        run_git_command(f"git checkout -B {branch_name}")
        run_git_command(f"git add {output_path}/main.tf")
        run_git_command(f"git commit -m 'feat: auto-generated infra for {project_name}'")
        run_git_command(f"git push origin {branch_name}")
        
        pr_title = f"🚀 Infra Provisioning: {project_name} ({environment})"
        pr_body = f"Automated infrastructure request for **{project_name}**.\n\n- **Env:** {environment}\n- **Owner:** {owner}\n- **Services:** {', '.join(technologies)}"
        
        create_github_pr(github_token, repo_full_name, branch_name, "main", pr_title, pr_body)

if __name__ == "__main__":
    # Fetch secrets from environment variables for security
    GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
    REPO = os.getenv("GITHUB_REPOSITORY", "your-org/your-repo") # Format: owner/repo

    # Example call for a project needing VPC, 3 EC2s, and DynamoDB
    generate_terraform("customer-app", "production", ["vpc", "ec2", "dynamodb"], 3, 
                       "marketing-dept", "external", git_push=True, 
                       github_token=GITHUB_TOKEN, repo_full_name=REPO)