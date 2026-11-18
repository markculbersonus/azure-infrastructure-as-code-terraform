# Evidence checklist

Add sanitized screenshots with clear captions:

- [ ] `01-resource-group-plan.png` — initial Terraform plan (1 to add)
- [ ] `02-resource-group-apply.png` — successful resource group creation
- [ ] `03-manual-tag.png` — `billingTag=WHOP` set in Azure
- [ ] `04-drift-detection.png` — Terraform plan removing the manually added tag
- [ ] `05-storage-apply.png` — storage account creation and tag reconciliation
- [ ] `06-network-and-nsg.png` — VNet, two subnets, NSG verified
- [ ] `07-provider-registration-error.png` — HTTP 409 `MissingSubscriptionRegistration`
- [ ] `08-provider-registered.png` — `Microsoft.OperationalInsights` registered
- [ ] `09-log-analytics-apply.png` — successful workspace creation
- [ ] `10-azure-resource-overview.png` — deployed resources in portal
- [ ] `11-final-plan.png` — no-change verification (capture if run)
- [ ] `12-cleanup.png` — destroy confirmation (capture only if performed)
