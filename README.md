Phaser Bootstrap
================

This is a basic bootstrap to start developing games using the HTML5 game
framework, [Phaser](https://github.com/photonstorm/phaser).

Originally made for the SESA Game Jam 2014 by [Chris Morgan](https://github.com/drpotato).

## Setup

To use this bootstrap you’ll need to install a few things before you have a
working copy of the game.

### 1. Clone this repo:

Navigate into your workspace directory.

Run:

`git clone git@github.com:ausesa/phaser-bootstrap.git`

Windows users will need to install git. Despite my hatred for graphical clients,
I recommend the [Github client](https://windows.github.com).

### 2. Install node.js and npm:

This can usually be done in one step, see [here](http://nodejs.org) for details.

Windows users will have a harder time, but there are install instructions on the site.

### 3. Install grunt and the bootstrap requirements:

Windows users, open up the node.js terminal client to do this. Also, you might not have to use `sudo`.

Navigate to the cloned repo’s directory.

Run:

`sudo npm install -g grunt-cli`

`npm install`

### 4. Complile the CoffeeScript:

Run:

`grunt coffee`

This will compile all the `.Coffee` files in the src directory into `build/game.js`.

### 5. Run the server:

Run:

`node server.js`

This will run a server so you can run the game in a browser.

Open your browser and enter `localhost:12345` into the address bar.

## Grunt

To constantly compile the CoffeeScript, run:

`grunt watch`

This will watch the files in the src folder, if they change it will recompile
them and output any errors that occur.

## Resources

Here are some documentation links to help you with development and debugging:

* [Phaser Documentation](http://phaser.io/docs/)
* [Phaser Examples](http://phaser.io/examples/)
* [CoffeeScript syntax & documentation](http://coffeescript.org)
* [Awesome “Book” on CoffeeScript](http://arcturo.github.io/library/coffeescript)
* [Grunt Documentation](http://gruntjs.com)
* [Google](https://google.com) <= The most important one!
* [Pigvane](https://github.com/drpotato/pigvane), a game I made (along with
[Fred](https://github.com/fredrickgogerty) and [Oscar](https://github.com/xxnxT)) for Global Game Jam 2014.

Have fun!
