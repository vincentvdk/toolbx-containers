# Toolbx containers
Source to build `toolbox` container images containing all tools and config that I use on a daily basis.

__DISCLAIMER__: This project is still in flux and should be used at your own risk

⚠️ ![toolbox](https://w7.pngwing.com/pngs/844/934/png-transparent-car-icon-toolbox-miscellaneous-brown-text-thumbnail.png) ⚠️

## What's in the toolboxes?

## How to use

## How binaries are managed.
A lot of the tools that I use can be installed by downloading a binary, make it executable and add it to a location in $PATH.
Example: Terraform, kubectl, ...

Adding all these to the container image would cause it to become quite big which is something I want to prevent. therefore the
usefule (asdf([https://github.com/asdf-vm/asdf] tool will be used. This tool will install and manage the versions of the binaries
we need on the host system (so not in the container). 

Based on what binary you need, you can configure asfd.

## References
- https://github.com/containers/toolbox
