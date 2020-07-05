->A shell script to create or open projects

->Creation of projects can created directory and a basic doc format and also upon choice can automatically setup the git repo for the project

->git repo is universal, no credential is hardcoded

->The PROJECTDIR var can be changed according to users env

SETUP:
For the script to run at login, place it under /etc/profile.d/

In order to run the script at Command, add the following alias to /etc/bash.bashrc
alias welcome=' . /etc/profile.d/welcome_me.sh'

NOTE:!! The execution by command exits the terminal. This is a limitation to be taken care of

Developed in Raspberrypi
