#Intro

In order to understand how to make a terraform provider. I'm having a look at a relatively simple one that interacts with pingdom

https://github.com/russellcardullo/terraform-provider-pingdom

Things I should have read first but did not

https://www.hashicorp.com/blog/writing-custom-terraform-providers/
http://container-solutions.com/write-terraform-provider-part-1/



##File structure


### /main.go

This is pretty simple. It imports terraform/plugin and pingdom and then calls plugin.Serve passing in some ServeOpts where the ProviderFunc is defined as the provider below.

ServeOpts can have provisioners as well.

The structure of a ResourceProvider is defined here 

https://github.com/hashicorp/terraform/blob/master/terraform/resource_provider.go


### /main_test.go

### /pingdom/config.go

This imports a go library to interact with pingdom. 

It defines a structure Config  with fields like username and password. It is what would be passed to a provider to set it up.

The only function it defines is a method on the config and  that returns an initialised pingdom client from the go library. 


### /pingdom/provider.go

This imports terraform schema, the go terraform library and mapstructure library.

It defines a single structure which is a terraform.resourceProvider. It generates it using schema.Provider by passing in a Schema, ResourcesMap and ConfigureFunc.

Schema: This appears to define the types of variables in the Config. E.g. username = string and whether they are optional.

ResourcesMap: This is a map from string to resourceFunction. 

ConfgureFunc: This function is defined in the code. It is passed in some ResourceData this is then partially converted into a map of key to interface. It is then further converted using mapstructure to a config object. Then config.Client() is called to return the api that has been setup.

### /pingdom/provider_test.go


### /pingdom/resource_pingdom_check.go

This has the single main function resourcePingdomCheck that is used by the provider.

This returns a schema.resource . Resources have 5 properties (CRUD methods, and schema). The schema is defined in-line and the functions are defined later. There is also a helper function that takes ResourceData and creates a check called checkForResource. There is a struct commonCheckParams which is seems to be used to initialise a starting check structure

Create 

Read

Update

Delete

Schema: This defines the types of the variables inside the resource. E.g. sendtoemail is an optional bool that defaults to false.

The CRUD operations are passed some resource data and a meta object (which is just a normal interface{}). This meta object is converted to a pingdom.client. Using a type assertion  https://newfivefour.com/golang-interface-type-assertions-switch.html

From the documentation of https://github.com/hashicorp/terraform/blob/master/helper/schema/provider.go

// Meta returns the metadata associated with this provider that was

// returned by the Configure call. It will be nil until Configure is called. 

So that all makes sense.

In the Read operation the ResourceData is populated from what is in comes back from a read operation on the client. The create and update operations use the checkForResource function to create an object that is that passed to client. Delete only cares about the id.


##Further questions

What are provisioners? 

How to define datasources? 

##General Go Notes

The stuff about assertions is worth knowing  https://newfivefour.com/golang-interface-type-assertions-switch.html

Maps are weird. Their type signatures are map[int]string which is a map with a key of type int and a value of type string.


