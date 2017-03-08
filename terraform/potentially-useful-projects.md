# Introduction and Motivation

Terraform is a tool that allows you to specify the desired state of many systems (hosting providers/monitoring solutions) and then make changes to that state over time.

One compelling use case is adding and removing users. A team can specify their list of users once and then apply terraform to make the changes required. On GOV.UK Pay we have a checklist of around 9 services that we have to remove people from when people leave the team. This is a manual and error prone process. If terraform controlled some of these it would allow you to remove the person from one list and they would be removed the next time terraform was run.

Most of the services we interact with do not have terraform providers. We do not create terraform providers to allow teams that use us to manage their teams within our services.

What are the things we can do to make this process of creating terraform providers easier?
 

##Shims to allow other languages to be used


###Description

Operations people aren't very good at go. Can we we write go code to allow them to write the provider in a different language?

###Current Status

Highly speculative. You would require some sort of specification of a type that is then converted into go code. You would either have to have a language agnostic way of specifying a type or pick a single language to support. 

## OpenApi specifcation to Terraform Provider

###Description

An Api description has a lot of the information required to write a terraform provider. It knows the fields in the requests and responses, what is required and what is not. So can we use an OpenApi description to bootstrap a terraform provider? 

###Current Status

Uncertain. It relies on there being reliable OpenApi definitions. How prevalent will that be? Go code generation seems doable. I've not looked heavily at the openapi specification. How many corner cases do we need to cover?

Can we get tools that we use (on the paved path) to give us and maintain OpenApi definitions?  How easily can our teams generate OpenApi definitions for user management, more or less easily than hand crafting terraform providers?
