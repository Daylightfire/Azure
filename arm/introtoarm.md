# Introduction to ARM templates

## Overview

ARM(Azure Resource Manager) is the deployment an d management service for Azure. You can use it to secure and organise your resources after deployment. So of these features are:

* access control
* auditing
* tagging

You can access ARM via 
- the portal
- Powershell
- Azure CLI
- REST apis
- Client SDKs

When you access ARM the ARM Api hadles the request. This allows for consistancy in results and capabilities no matter what tool you use.

### Terminiology 

- resource - A manageable item in Azure ( VMs, storage accounts, web apps etc)
- resource group - A container that holds related resources
- resource proivder - A service that supplies Azure resources for example **Microsoft.Compute** which supplies the virtual machine resouce, **Microsoft.Storage** is another resouce provider
- Resource Manager Template - A JSON (javascript notation object) file that defines a single or multiple resources to be deployed multiple times, consistantly.
- declarative syntax - Syntax that allows you to state "Here is what I intend to create" without having to write lines and lines of code. The Resource manager template is an example of this

### Benefits

- Deploy, Manage,Monitor resources as a group
- deploy repeatedly consistantly
- Manage through templates rather than scripts
- Define dependencies between resources so things are deployed in the correct order
- Apply access control to all resources like RBAC(Role-Based Access Control)
- organise resources using tags
- Clarify billing by viewing costs for a groups of resources sharing a tag

### Scope

Azure provides four levels of scope

1. management groups
2. subscriptions
3. resource groups
4. resources

Lower levels inheirit settings from higher levels.




