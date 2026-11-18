# Azure Infrastructure as Code with Terraform

Provisioning, drift detection, and troubleshooting of Azure resources using HashiCorp Terraform.

## Overview

This project demonstrates managing Azure infrastructure declaratively with Terraform. It began with a resource group, then expanded to Azure Storage, networking, network security, and a Log Analytics workspace.

## Architecture

![Terraform-provisioned Azure infrastructure architecture](docs/azure-terraform-infrastructure-architecture.svg)

The diagram shows the deployed resource group, storage account, VNet and subnets, NSG, and Log Analytics workspace. It also summarizes drift detection and resource provider registration troubleshooting.

- **Resource group:** `example-resources` (East US)
- **Storage account:** `storageaccountname156435` (StorageV2, Standard GRS; `environment=staging`)
- **Virtual network:** `example-network` (`10.0.0.0/16`)
- **Subnets:** `subnet1` (`10.0.1.0/24`) and `subnet2` (`10.0.2.0/24`)
- **Network Security Group:** `example-security-group`, associated with one subnet; no custom security rules shown
- **Log Analytics workspace:** `example`, 30-day retention, pay-as-you-go

## Implementation and verification

1. Defined the resource group in Terraform and confirmed `terraform plan` proposed one addition.
2. Applied the configuration and verified the resource group in the Azure Portal.
3. Added `billingTag=WHOP` manually in the Azure Portal. A subsequent plan proposed an in-place update removing that tag (`0 add, 1 change, 0 destroy`).
4. Added an Azure Storage account. `terraform apply` reported `1 added, 1 changed, 0 destroyed`, reconciling the tag difference while provisioning storage.
5. Expanded the configuration with a virtual network, two subnets, an NSG, and a Log Analytics workspace.
6. An initial apply created the VNet and NSG but failed on Log Analytics with `409 MissingSubscriptionRegistration` for `Microsoft.OperationalInsights`.
7. Registered the required resource provider, reran the apply, and successfully created the Log Analytics workspace (`1 added, 0 changed, 0 destroyed`).
8. Verified the deployed resources in the Azure Portal.

## Troubleshooting: Azure resource provider registration

**Symptom:** Terraform returned HTTP 409 (`MissingSubscriptionRegistration`) while creating `azurerm_log_analytics_workspace.example`.

**Cause:** The subscription had not registered the `Microsoft.OperationalInsights` resource provider namespace.

**Resolution:** Registered `Microsoft.OperationalInsights` under Azure subscription → Resource providers, confirmed status **Registered**, and reran Terraform successfully.

**Lesson:** Terraform can be syntactically correct while subscription prerequisites block deployment. Check provider registration, policies, permissions, regions, and quotas.

## Security and operational considerations

This is a learning deployment, **not a production-hardened architecture**. Screenshots show storage public network access and shared-key access enabled, Standard GRS replication, and an NSG with zero custom rules. Before production use, review network restrictions, identity-based storage access, security rules, cost, monitoring, and remote state protections.

## Terraform commands

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
terraform plan
# Review managed resources carefully before any cleanup:
terraform destroy
```

Avoid using `-auto-approve` in shared or production environments without a reviewed plan.

## Repository contents

- `main.tf`: Sanitized reconstruction from screenshots; verify against local working files before reuse.
- `provider.tf`: AzureRM provider example without hardcoded subscription ID.
- `.gitignore`: Excludes state, plans, credentials, and Terraform working directories.
- `docs/azure-terraform-infrastructure-architecture.svg`: Architecture diagram.
- `docs/evidence-checklist.md`: Screenshot checklist.
- `screenshots/`: Upload **redacted** deployment evidence; see `screenshots/README.md`.

> **Important:** Original local `variables.tf`, `outputs.tf`, and full provider configuration were not available for inspection. Use your actual verified local files when publishing the final implementation.
