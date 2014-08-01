# Phaser Bootstrap - A Game Template
# Developed by Chris Morgan (@dr__potato)

# Config variables to create the game object.
width = window.innerWidth
height = window.innerHeight
renderer = Phaser.CANVAS
parent = 'game-div'
state = null # We assign states later
transparent = true
antialias = true
physics_config = null

# Initialise the gamme
Game.game = new Phaser.Game(width, height, renderer, parent, transparent, antialias, physics_config)


# Add the states from the Game.States object
# The last boolean value determines which will run on startup
Game.game.state.add('Preloader', Game.States.Preloader, true) # This state will run first.
Game.game.state.add('Run', Game.States.Run, false)
