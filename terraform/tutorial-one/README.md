

This tutorial is about editing an existing terraform provider to add another field. It is designed for people with a little bit of familiarity with go and terraform.

Step 1

Install GO

Setup your go path 

Step 2 Make the provider

Clone 

mkdir $GOPATH/src/github.com/whpearson/
cd $GOPATH/src/github.com/whpearson

cd $GOPATH/src/github.com/whpearson/terraform-provider-todo
git clone https://github.com/whpearson/terraform-provider-todo/

cd $GOPATH/src/github.com/whpearson/terraform-provider-todo

go get ./...

cd $GOPATH/src/github.com/hashicorp/terraform

git checkout $(terraform --version | cut -d' ' -f 2)

cd $GOPATH/src/github.com/whpearson/terraform-provider-todo

go install ./...

The executable will now be at $GOPATH/bin/terraform-provider-todo

Step 3 Get the server

wget https://github.com/whpearson/todo-server/releases/download/0.0.2/simple-to-do-list-server

Step 4 Run the server

./simple-to-do-list-server --scheme http --port 9001

This server doesn't store any state. So it is just for testing purposes. Find etc just return a fixed list


Step 5 Setup the terraform provider

Edit your ~/.terraformrc to have something like the .terraformrc in this directory.

Step 6 Try it out with

terraform plan etc

Step 7

The terraform provider is incomplete. You cannot control the completed variable of a todo item in a resource.

Try and add the `completed` parameter to the terraform provider. 


