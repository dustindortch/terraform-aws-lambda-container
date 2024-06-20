# variables.tf

## Guidelines

## Create variables for as many values as possible. This will make it easier to update values in the future.

## Use intuitive names for variables. This will make it easier for others to understand your code.

## The principal resource of the module should have a variable called 'name' associated with it, not 'resource_name'.

## Only one prinicpal instance of a principal resource should be created within its module.  If multiple instances are required, the calling module can implement it through a `count` or `for_each` meta-argument.

## Use input validation on variables.  It limits the logic and code required within the rest of the configuration.

## Use types.
