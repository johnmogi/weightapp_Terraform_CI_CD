# CI CD using azure Devops - building the Terraform infrastructure

this repository is the starting point in Sela's week 12 bootcamp.
in this repository we control the infrastructure as code for the actual assets on the azure cloud.
if you have a clue on how to use the terraform in order to build the cloud you can skip the following section directly to WORKING instructions for the terraform CI CD..

if not - follow the following:

## Stage 1 - create the AKS in Azure cloud.
you'll need to setup the following services:
1. a Terraform Backend - manually create a new storage account and populate the backend.tf file (not included)"
redundency - LRS } performance standard
regarding backend - read more here on hiw to manage it securely:
https://www.terraform.io/language/settings/backends/configuration
<pre>
terraform init \
    -backend-config="address=demo.consul.io" \
    -backend-config="path=example_app/terraform_state" \
    -backend-config="scheme=https"
</pre>

2. now at that storage create a container, create a public as you can then go to shared access tokens and fill the key info on file-
terraform {
backend "azurerm" {
resource_group_name = "group-name"
storage_account_name = "accountname"
container_name = "datestorage"
key = "keyname"
access_key = "hlongstringaccessname"
}
}
3. for local dev, you can supply your subscription_id + tenant_id into the providers file
provider "azurerm" {
  features {}
  subscription_id = ""
  # client_id       = ""
  # client_secret   = ""
  tenant_id       = ""
}
, can be found here (use CLI az login - it would hand you out the info)

<pre>
terraform init \
    -backend-config="subscription_id=d" \
    -backend-config="tenant_id=" \
</pre>

1. create a new Kubernetes cluster in Azure cloud
2. Azure Container Registry (ACR).
3. Azure Managed PostgreSQL Service.

__Create a "FILE_NAME.tfvars" file:__

        pg_user          = "Postgres SQL user name"<br/>
        pg_database      = "Postgres SQL database name"<br/>
        pg_password      = "Postgres SQL password"<br/>
        cluster_name     = "AKS cluster name"<br/>
        acr_name         = "ACR name"<br/>
        rg_name          = "Resource group name"<br/>
        env              = "Environment name"


To deploy the infrastructure follow these steps:
1. Clone the repository.
2. Run: 
<pre>
        $ cd <repo name> terraform init // + backend config.
      </pre>
3. Run:

 tf plan -var-file="staging.tfvars" -out=planfile
 tf destroy -var-file="staging.tfvars" -auto-approve
        $ terraform apply -var-file="FILE_NAME.tfvars" -auto-approve
        
Follow these steps before creating the pipeline:
1. Follow this [link](https://kubernetes.io/docs/tasks/tools/) to install `kubectl' on your agent.<br/>
1. Follow this [link](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt) to install Azure CLI on LINUX.<br/>
1. Follow this [link](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli) to login to Azure CLI.<br/>
1. Run the following command to get access credentials for a managed Kubernetes cluster.


## WORKING instructions for the terraform CI CD
in addition we are using infracost to calculate any price change.

by commiting and approving the process in azure devops the build stage will begin.
also - please supply your backend details at the library variable group - Terraform

to manually view price of current plan
## install infracost:

- then run - infracost breakdown --path .

<img src="images/breakdown.png" width="800" height="400" alt="result">

- infracost breakdown --path . --format json --out-file infracost-base.json
+ suggest changes in the infrastructure (add resources etc.)

- infracost diff --path . --compare-to infracost-base.json

you will see the price change.


## SETUP phase for the 2nd CI CD : Azure DevOps + AKS kubectl connection

        az login
        az account show
        az aks get-credentials --name k8sweight --resource-group weightapp
         kubectl config view --minify 
         server: https://weightdns-26ca6af0.hcp.eastus.azmk8s.io:443

         manuallly create a new namespace
         k create namespace weightapp
         kubectl config set-context --current --namespace=weightapp



kubectl get secret default -n weightapp -o json


kubectl get serviceAccounts k8sweight -n default -o=jsonpath={.secrets[*].name}
kubectl get serviceAccounts default -n default -o=jsonpath={.secrets[*].name}

Create an environment and connect it with AKS cluster that created with Terraform.





<!-- <img src="" width="800" height="400" alt="result"> -->


# weightapp_Terraform_CI_CD

@ if using your own azure devops- the terraform extenstion:
https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks
