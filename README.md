# SelfGeneratingCli

SelfGeneratingCli is an example of how you might build a Ruby based CLI that gets generated entirely by the Yard code comments on methods

## Using the CLI
```
$ git clone https://github.com/bretts/self_generating_cli.git
$ cd self_generating_cli
$ gem install bundler
$ bundle install
$ ./bin/sgcli
```

Type 'sgcli' in the console to enter the self_generating_cli CLI. They type 'help' or '?' to get help
```
sgcli> ?
=>
Module Name        Description
------------------------------
movement           commands related to movement
speech             commands related to speech
```

Type the module name followed '?' to see all the available commands
```
sgcli> movement ?
=>
Command Name              Example
------------------------------------------------------------
move-forward              move-forward 2
move-backwards            move-backwards 2
```

Type the module name followed by the command with the expected params to execute the method
```
sgcli> movement move-forward 2
=> I take 2 steps forward
```