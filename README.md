Slipspace
=========

Simple deploys for your projects.

## Requirements

### Server

- SSH access
- Git

### Your Machine

- [jq](http://stedolan.github.io/jq/) for JSON parsing.
- Git

## Usage

The easiest way to use Slipspace is to copy the function from the `slipspace.sh` file into your bash profile and reload it (`source ~/.profile`). Next create a configuration file called `slipspace.json` somewhere in your project (the root is usually the best place). Have a look at the included config file to see how it should be structured.

Now you can `cd` into the directory where your config file lives and call `slipspace deploy your_environment`. The environment name should match the Git branch you use for a specific environment.

Need to run migrations? Add a `--migrate` flag at the end.

## Features

- Environment-based deploys via Git.
- Post-deploy commands.
- Optional ability to run a migration command.

## Todo

- Better error handling

