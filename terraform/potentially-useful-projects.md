# Introduction and Motivation

I like to have a concrete problem to work on when learning something. For go this will be the problem. It is not an official thing being solved/discovered. Just something that I think exploring might be useful.

Terraform is a tool that allows you to specify the desired state of many systems (hosting providers/monitoring solutions/dns) and then make changes to that state over time.

One compelling use case is adding and removing users. A team can specify their list of users once and then apply terraform to make the changes required. On GOV.UK Pay we have a checklist of around 9 services that we have to remove people from when people leave the team. This is a manual and error prone process. If terraform controlled some of these it would allow you to remove the person from one list and they would be removed the all the services the next time terraform was run.

Most of the services we interact with do not have terraform providers. We also do not create terraform providers to allow teams that use us to manage their teams within our services.

What are the things we can do to make this process of creating terraform providers easier?
 



## OpenApi specifcation to Terraform Provider

###Description

An Api description has a lot of the information required to write a terraform provider. It knows the fields in the requests and responses, what is required and what is not. So can we use an OpenApi description to bootstrap a terraform provider? 

###Current Status

Uncertain. It relies on there being reliable OpenApi definitions. How prevalent will that be? Go code generation seems doable. I've not looked heavily at the openapi specification. How many corner cases do we need to cover? Can we get something useful to cover the majority usecases.

Can we get tools that we use (on the paved path) to give us and maintain OpenApi definitions? Or can we make them ourselves?  How easily can our teams generate OpenApi definitions for user management, more or less easily than hand crafting terraform providers?


###Rough pseduo code for what this would look like


For a swagger file, generate a main.go and a  name/provider.go  

For each tag in a swagger file with find, updateOne, destroyOne, add addOne. Generate a resource (also add that resource to the provider.go). 

Make a structure for each definition in the definitions. And a schema!

Create a function associated with find that gets a single object and makes a terraform resource structure. 

Create a function associated with updateOne that takes a terrraform resource structure and generates a client stucture that is passed to the client.

Create a function associated with addOne that takes a terrraform resource structure and generates a client stucture that is passed to the client.


Create a function associated with destroyOne that takes an id and passes that to a client stucture. Then the client is called.

Create a resource using the above functions and the schema.

###Next steps

* Write a terraform provider that can interact with the client/server created by the go-swagger to do list app.
* Play around with generating that code from go templates using parameter names similar to those used in go-swagger/generate/client.go   

####Unknowns
- Generating the login info for initialised the provider. Swagger can deal with things like basic-auth and api tokens. 


##Shims to allow other languages to be used


###Description

Operations people aren't very good at go. Can we we write go code to allow them to write the provider in a different language? I've read some things that suggest that providers are talked to over http. So a correctly shaped python program should be able to act as a terraform provider.

###Current Status

No go code is needed, so this is less interesting. Knowing go to understand the shape a terraform provider would be useful. This is put on the back burner unless the openapi specification ends up being decidedly non-trivial.

 
