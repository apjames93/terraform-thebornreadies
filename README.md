SETUP
install aws-cli

> [install aws-cli ](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

> sh ./install_terraform.sh
> terraform init .
> terraform plan -out=tfplan -input=false .
> terraform apply -input=false tfplan
