#!/bin/bash
# 2/12/17 JLM
# ./provision.sh --> TO provision or deprovision nginx server.

# assign variables
ACTION=${1:--p}
VERSION="1.0.0"


#echo $ACTION

function provision_server() {
   	yum update -y           ## Update the system
	yum install git nginx -y  ## install git and nginx 
	service nginx start
	chkconfig nginx on       ## start service nginx start
	aws s3 --region us-east-2 cp s3://jlmoldan-assignment-4/index.html /usr/share/nginx/html/index.html  ## move index into place from S3
   
}

function show_version() {
echo  " version: $VERSION"
}

function remove_nginx() {
echo "removing nginx"
       	service nginx stop
	yum remove nginx -y
	rm -rf /usr/share/nginx/html/  # tries to remove files if for some reason they still exist. 

}


function display_help() {

cat << EOF

Usage: ${0} { (no option = provision)|| | -h|--help|-r|--remove|-v|--version} <filename>

OPTIONS:
	-p | --provision Either -p or no option will provision nginx server
        -h | --help     Display the command help
        -r | --remove   Removes Nginx
        -v | --version  Displays version

Examples:
        Provision the server:
                $ ${0} 

        Remove Nginx:
                $ ${0} -r

        Display help:
                $ ${0} -h

        Display Version
                $ ${0} -v
EOF
}

case "$ACTION" in
        -h|--help)
                display_help
                ;;
        -p|--provision)
                provision_server
                ;;
        -r|--remove)
                remove_nginx 
                ;;
        -v|--version)
                show_version 
                ;;
        *)
        echo "Usage ${0} {-p|-h|-r|-v}"
        exit 1
esac
