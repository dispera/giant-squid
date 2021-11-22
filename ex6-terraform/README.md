# AWS Octopus Terraform test

This is to define and user a module as part of the interview tests.

I did not choose to make the suffixes toggleable, but instead thought it would be more useful to  
let the CI tool be specified. Considering we use a CI tool called `octopus` now, the module will name  
it's resources based on the contents `ci_name` variable. And I chose to append "-ci" then to that name.

E.g. here we use `ci_name` of `octopus`, and end up with resources named `octopus-ci`.

---
I tested it on my personal AWS account.  
For examples I just used the official terraform documentation.