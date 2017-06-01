

This tutorial is about editing an existing terraform provider to add another field. It is designed for people with a little bit of familiarity with go and terraform.

## Step 1

The first step is to install go and also get the projects into a state where they will build happily. 

If you haven't you need to do the general go setup 
- Install GO
- Setup your go path 

## Step 2 Make the provider

Perform the following steps

```
#Make a path for downloading the provider
mkdir $GOPATH/src/github.com/whpearson/
cd $GOPATH/src/github.com/whpearson

#Download the provider
git clone https://github.com/whpearson/terraform-provider-todo/
cd $GOPATH/src/github.com/whpearson/terraform-provider-todo

#Get the dependencies for the provider
go get ./...


cd $GOPATH/src/github.com/hashicorp/terraform

# We need to checkout the branch of terraform we are building against to be the version of terraform we actually have

git checkout $(terraform --version | cut -d' ' -f 2)
cd $GOPATH/src/github.com/whpearson/terraform-provider-todo

go install ./...
```
The executable will now be at $GOPATH/bin/terraform-provider-todo

## Step 3 Get the server

Now we need a server to test against. Luckily there is one already created for us.

```wget https://github.com/whpearson/todo-server/releases/download/0.0.2/simple-to-do-list-server```

## Step 4 Run the server

We need to run the server as something for the provider to run against. 

```./simple-to-do-list-server --scheme http --port 9001 ```

This server doesn't store any state. So it is just for testing purposes. Find etc just return a fixed list


## Step 5 Setup the terraform provider

Edit your `~/.terraformrc` to include the line in this directories `.terraformrc` replacing your $GOPATH with your $GOPATH

## Step 6 Try it out 

Now you should be in a position to try it out.

`terraform plan` etc

# Actual tutorial

The terraform provider is incomplete. You cannot control the `completed` parameter of a todo item in a resource.

Try and add the `completed` parameter to the terraform provider. It is worth looking at this [document](../anatomy-of-a-provider.md) for some more information. 


