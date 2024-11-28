# Terraform-AWS-Services
This repository offers examples and best practices for deploying AWS infrastructure with Terraform. It includes configurations for EC2, S3, VPC, IAM, and RDS, designed as reusable modules for quick setup and customization. Ideal for automating AWS environments, managing infrastructure-as-code, and ensuring scalability and reliability.

## Introduction
Terraform is an open-source tool that enables you to define and provision infrastructure using a declarative configuration language. This repository provides practical examples and detailed explanations to help you:
- Understand the core concepts of Terraform.
- Implement reusable and modular infrastructure.
- Manage state files and workspaces.

---
## Documentation link
  ```bash
  https://docs.google.com/document/d/1Fe0qAdfffXSNy_5xRSjLgNTc8adcleGc_dIeeLw76as/edit?usp=sharing
  ```

## Setup

### AWS Credentials Configuration
To interact with AWS, set up your AWS credentials in your terminal session:

1. Store the following lines in a `.env` file:
    ```bash
    export AWS_ACCESS_KEY_ID=your_secret_key
    export AWS_SECRET_ACCESS_KEY=your_access_key
    ```
2. Execute the `.env` file:
    ```bash
    source path_to_.env
    ```
   This will temporarily set the credentials for the active terminal session.

---

## Major Terraform Commands

### Validation and Planning
- **`terraform validate`**  
  Validates the configuration files for syntax errors.
  
- **`terraform plan`**  
  Reviews the changes that Terraform will make before applying them.

### Execution
- **`terraform apply`**  
  Executes the configuration and applies changes to the infrastructure.  
  Use the `--auto-approve` flag to skip the manual confirmation step.

- **`terraform destroy`**  
  Removes all resources defined in the configuration.  
  Use the `--auto-approve` flag for non-interactive execution.

### State File Management
- **`terraform state list`**  
  Lists all resources tracked in the current state.

- **`terraform state show <resource_name>`**  
  Shows detailed information about a specific resource.

- **`terraform state rm <resource_name>`**  
  Stops Terraform from managing a specific resource.

- **Modify state with:**  
  ```bash
  terraform state mv <current_resource_location> <new_resource_location>


### Workspace Management

Terraform workspaces allow you to manage multiple state files within a single configuration. Here are the essential commands for managing workspaces:

- **List all Workspaces**  
  Lists all the available workspaces in your Terraform setup:
  ```bash
  terraform workspace list
  
- **Show Current Workspace**  
  Displays the name of the currently active workspace:
  ```bash
  terraform workspace show

- **Create a New Workspace**
  Creates a new workspace with the specified name:
  ```bash
  terraform workspace new <workspace_name>

- **Switch to a Workspace**
  Switches to the specified workspace:
  ```bash
  terraform workspace select <workspace_name>

- **Delete a Workspacee**
  Deletes the specified workspace. Before deleting, ensure that no resources are being tracked in this workspace:
  ```bash
  terraform workspace delete [OPTIONS] <workspace_name>
  ```
  - Options for Deleting Workspaces:
  - ```bash
    --force: Forces deletion without prompt. 
    --lock=false: Prevents locking the workspace during deletion. 
    --lock-timeout=0s: Specifies the duration to wait for the lock to be released.
    ```
