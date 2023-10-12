# Terraform Beginner Bootcamp 2023

## Semantic versioning :mage:

This project is going to utilize semantic versioning for its tagging. 
[semver.org](https://semver.org/)

The general format: 

**MAJOR.MINOR.PATCH**, eg `1.0.1`


- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Considerations for Linux Distribution


This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs.

[How to check OS version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:
```sh
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we noticed the installation steps were a considerable amount more code so we decided to create a bash script to install the Terraform CLI. 

This bash script is located here[./bin/install_terraform_cli](./bin/install_terraform_cli):

- This will keep the Gitpod Task File tidy. ([.gitpod.yml](.gitpod.yml))
- This allows us an easier to debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI.

#### Shebang

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script. eg `!#/bin/bash`

ChatGPT recommended this format for bash:
`#!/usr/bin/env bash`

- for portability for different OS distributions
- will search the user's PATH for the bash executable

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

[Shebang Wiki](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it. 

eg. `source.bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the file to be executable at the user mode. 

```
chmod u+u ./bin/install_terraform_cli
```

We could also alternatively 
```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod


### Github Lifecycle (Before, Init, Command)

We need to be careful when using the init because it will not rerun if we restart and existing workspace.
[Gitpod Docs](https://www.gitpod.io/docs/configure/workspaces/tasks)



### Working Env Vars

#### env command 
We can list out all Environment Variables (Env Vars) using the ´env´ command

We can filter specific env vars using grep eg. ´eng | grep AWS_´

#### Setting and Unsetting Env Vars

In the terminal we can set using ´export HELLO='world'´

In the terminal we can unset using ´unset HELLO´

We can set an env var temporarily when just running a command

´´´sh
HELLO='world' ./bin/print_message
´´´

Within a bash script we can sent env var without writing export eg.
´´´sh

#!/usr/bin/env bash
HELLO='world'

echo $HELLO
´´´

## Printing Vars

We can print an env var using echo code eg. ´echo $HELLO´


#### Scopring of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile eg. ´.bash_profile´


#### Persisting Env Vars in Gitpod

We can persist env vars in gitpod by storing them in Gitpod Secrets Storage

´´´
gp env HELLO='world'
´´´

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the ´.gitpod.yml´ but this can only contain non-sensitive.