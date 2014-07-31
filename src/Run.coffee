# Main state for game, might split up into levels later.
class Game.States.Run
    # `@game` automatically creates `this.game = game`
    constructor: (@game) ->

    # Load in all the files required for the game.
    preload: () ->
        # Set up cross Class communication as we cannot access parent classes in js
        Game.Global = @
        
        # Setup global update signal.
        @onUpdate = new Phaser.Signal()
        
        # Set the keyboard.
        @game.keyboard = new Game.Classes.Keyboard(@game)

    create: () ->
        # Start the game's physics.
        @game.physics.startSystem(Phaser.Physics.P2JS)
        @game.physics.p2.defaultRestitution = 0.2
        
        @game.circle = new Game.Classes.Circle(@game)

    update: () ->
        
        # Send the update signal to all subcribers.
        @onUpdate.dispatch()