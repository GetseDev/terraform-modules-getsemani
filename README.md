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
├── aws-ssh-key/          # SSH key pair module
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

| Tool             | Version  |
|------------------|----------|
| Terraform        | >= 1.6.0 |
| AWS CLI          | >= 2.x   |
| AWS provider     | >= 5.0.0 |
| `tls` provider   | >= 4.4.2 |
| `local` provider | >= 2.9.1 |

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

| Module        | Description                                                                                         | Status           |
|---------------|-----------------------------------------------------------------------------------------------------|------------------|
| `aws-ec2`     | EC2 instance module for AWS (variables and outputs TBD)                                             | Work in progress |
| `aws-ssh-key` | RSA key pair: generates the key, registers the public key in AWS, and saves the private key locally | Working          |

### `aws-ssh-key`

Creates three resources that work as a chain:

1. `tls_private_key` generates an RSA key pair in memory.
2. `aws_key_pair` registers **only the public key** in AWS, tagged with a `Name`.
3. `local_file` writes the private key to disk with a `.pem` extension.

The public/private split is the point of the module: AWS never receives the private key, and
the private key never leaves your machine (except in Terraform state, see [Notes](#notes)).

#### Variables

| Name | Type | Default | Description |
|---|---|---|---|
| `getsemani_ssh_key_rsa_bits` | `number` | `4096` | RSA key size in bits |
| `getsemani_ssh_key_aws_key_name` | `string` | `"key"` | Key pair name in AWS |
| `getsemani_ssh_key_directory` | `string` | `"./"` | Directory where the private key file is written |
| `getsemani_ssh_key_file_permission` | `number` | `0400` | Permissions for the private key file |

> Set `getsemani_ssh_key_aws_key_name` to something specific. Key pair names are unique per
> account and region, and `"key"` collides easily.

#### Outputs

| Name | Description |
|---|---|
| `getsemani_ssh_key_name` | Key pair name in AWS. Pass it to `aws_instance.key_name`. |
| `getsemani_ssh_key_private_key_path` | Private key file path on disk, relative to the working directory |
| `getsemani_ssh_key_public_key_openssh` | Public key in OpenSSH format, safe to share |

#### Usage

```hcl
module "aws-ssh-key" {
  source = "./aws-ssh-key"

  getsemani_ssh_key_aws_key_name = "nautilos-dev"
  getsemani_ssh_key_directory    = "${path.module}/keys"
}
```

The generated private key is ignored by Git (`aws-ssh-key/key` and `*.pem` in `.gitignore`),
but it is still a local file: keep the directory out of synced or shared folders.

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
- `aws-ssh-key` stores the private key in Terraform state, because `tls_private_key` exposes
  it as an attribute. With local state it stays on this machine; a remote backend would need
  encryption and access control. Losing the state means the next `apply` generates a new key
  and existing instances keep only the old one.
