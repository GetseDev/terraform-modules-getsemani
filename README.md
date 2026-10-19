# Terraform Modules — Getsemani

A personal collection of reusable Terraform modules for AWS, built as a learning project.

This repository is my hands-on space for learning Terraform: writing modules, testing them
locally, and improving them through pull requests. Every change goes through a branch and a
PR, so the Git history doubles as a record of what I learned and why.

## Purpose

- Practice writing reusable, well-documented Terraform modules.
- Learn Terraform fundamentals: providers, variables, outputs, state, and module composition.
- Learn a professional Git workflow based on short-lived branches and pull requests.
- Keep infrastructure definitions small, readable, and easy to review.

## Repository structure

```
.
├── aws-ec2/            # EC2 instance module (work in progress)
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── test-local.tf       # Local scratch configuration for testing modules
├── AGENTS.md           # Git and contribution rules
└── README.md
```

Each module lives in its own directory and follows the standard Terraform module layout:
`main.tf`, `variables.tf`, and `outputs.tf`.

> `test-local.tf` is a local playground for validating modules. It is not intended to be a
> long-lived example and may change at any time.

## Requirements

| Tool      | Version   |
|-----------|-----------|
| Terraform | >= 1.6.0  |
| AWS CLI   | >= 2.x    |
| AWS provider | >= 5.0.0 |

You also need AWS credentials configured locally (`aws configure`, SSO, or environment
variables). Never commit credentials or Terraform state to this repository — both are
ignored by `.gitignore`.

## Usage

Run Terraform from the directory of the module or test configuration you want to apply:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

To clean up resources created during a test:

```bash
terraform destroy
```

## Modules

| Module     | Description                                              | Status         |
|------------|----------------------------------------------------------|----------------|
| `aws-ec2`  | EC2 instance module for AWS (variables and outputs TBD)  | Work in progress |

## Workflow

Changes are made on a branch and merged through a pull request:

```bash
git switch -c feat/short-description
# make changes
git add .
git commit -m "feat(ec2): add instance type variable"
git push -u origin feat/short-description
gh pr create --fill
```

Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/) and are
written in English. See [`AGENTS.md`](./AGENTS.md) for the full set of Git rules used in this
repository.

## Notes

- This is a learning project, not production-ready infrastructure.
- Modules may introduce breaking changes without notice.
- State is stored locally for now. A remote backend may be added later as part of the
  learning path.
