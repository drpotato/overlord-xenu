# First state to run of the Pigvane.States, handles initialisation of display and interaction
class Game.States.Preloader
	# `@game` automatically creates `this.game = game`
    constructor: (@game) ->

    # Load in all the files required for the game.
    preload: () ->
        @game.stage.backgroundColor = '#FFF'
        # Use this to load in images.
        # @game.load.image('<IMAGE_NAME>', '<IMAGE_FILE>')
        @game.load.image('t_wrecks', 'res/t_wrecks.png')
        @game.load.image('circle', 'res/circle.png')
        @game.load.image('xenu', 'res/xenu.png')

    create: () ->
    	# Continue on to the `Preloader` state
        @game.state.start 'Run'


