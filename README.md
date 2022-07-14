<br>

# Amnic-Terraform

- This is the terraform code for the Deployment of nginx Server. <br>
- Its divided in 2 modules. Network and Compute. <br>
- You should Provide values in `env` folder. for environment specific variables.<br>

Terraform Commands
```
terraform init
terraform plan -var-file="env/dev.tfvars"
terraform apply -var-file="env/dev.tfvars" -auto-approve
```
<br>
Note: Use any type of authentication to AWS:
- CLI 
- profile in Provider Block 
- Access key and Secret Key in the Provider Block