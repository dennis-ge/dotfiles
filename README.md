# dotfiles
My dotfiles for setting up a new Ubuntu/Ubuntu WSL environment. 

## Setup
Executing the [setup script](https://github.com/dennis-ge/dotfiles/blob/master/setup) with no arguments will list all available options.
All possible options are listed below:
```
Usage: setup  [options]

Options:
      ide                  Install some Jetbrains IDE (only Desktop Version)
      system               Basic System Installation
      favorite-apps        Update your Favorite Apps (only Desktop Version)
      docker-compose       Install Docker-Compose
      vscode               Install VSCode with some extensions (only Desktop Version)
      go                   Install Go
      dotfiles             Link dotfiles to home directory
      docker               Install Docker
```
It is possible to specifiy multiple options, so  `setup system vscode docker` is a valid command.  

