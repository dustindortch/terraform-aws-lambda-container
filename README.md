# template-terraform

This repository is a template for creating new Terraform root modules.  It includes the basic files and workflows for GitHub Actions that would be necessary for a new Terraform root module.

## Usage

Clone the repository to your target location and update this README file with the appropriate information for your new code.

```bash
git clone git@github.com:dustindortch/template-terraform.git <new-repo-name>
```

## Files

- `README.md`: Repository README file.
- `main.tf`: The main Terraform configuration file.
- `variables.tf`: The Terraform variables file.
- `outputs.tf`: The Terraform outputs file.
- `.github/actions/terraform_apply/action.yml`: GitHub Actions composite reusable action for running `terraform apply` with option for destroy.  *WARNING* This action implies `-auto-approve` behavior and will modify infrastructure, including destroying resources, as required.
- `.github/actions/terraform_fmt/action.yml`: GitHub Actions composite reusable action for running `terraform fmt`.
- `.github/actions/terraform_install/action.yml`: GitHub Actions composite reusable action for installing Terraform with tfenv.
- `.github/actions/terraform_plan/action.yml`: GitHub Actions composite reusable action for running `terraform plan`.
- `.github/actions/terraform_validate/action.yml`: GitHub Actions composite reusable action for running `terraform validate`.
- `.github/workflows/pull_request.yml`: GitHub Actions workflow for running Terraform plan on pull requests.
