# RokuMaster
A shell script that interacts with a roku streaming device over ECP

## Description
This script is for controlling a roku device on a LAN. It's pretty basic. The script uses wget to send GET and POST requests to the roku on port 8060. Here's the Roku API guide: [Roku API](https://developer.roku.com/docs/developer-program/debugging/external-control-api.md).

## Features
* List installed applications
* Show app currently being used
* Show information about roku device
* Launch an installed app
* Lock down the roku device by keeping it on the home screen

## Installation
Only requires bash and wget. Cloning the whole repo isn't really necessary. You can download the script with the one liner below:
`curl https://raw.githubusercontent.com/ghostwalkr/RokuMaster/master/roku-master.sh; chmod 744 roku-master.sh`
Unfortunately, you have to manually open the script to put the IP/hostname of the roku device in. You could just make a seperate script for each roku you want to control if you have multiple. I'll add the option to specify IP/hostname from the command line in the future sometime.

## Usage
`./roku-master.sh <command>`

## Todo
- Press remote keys (up,down,left,right,etc.)
- Install apps
- Specify target via command line
