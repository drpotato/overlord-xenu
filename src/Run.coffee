# Main state for game, might split up into levels later.
class Game.States.Run
    # `@game` automatically creates `this.game = game`
    constructor: (@game) ->

    # Load in all the files required for the game.
    preload: () ->
        # Set up cross Class communication as we cannot access parent classes
        # in javascript.
        Game.Global = @

        # Setup global update signal.
        # We use this to update all the entities in the game (maybe...)
        @onUpdate = new Phaser.Signal()

        # Set the keyboard.
        @game.keyboard = new Game.Classes.Keyboard(@game)

        # Create a sound manager and add music.
        @sound_manager = new Phaser.SoundManager(@game)
        # I haven't enabled this because there currently exists no music.
        # It's added in a similar way to images.
        # @sound_manager.music = @soundmanager.add('music', 1, true)

    create: () ->
        # Start the game's physics.
        @game.physics.startSystem(Phaser.Physics.P2JS)
        @game.physics.p2.defaultRestitution = 0.2

        # Create our first object in the world.
        @game.player = new Game.Classes.Player(@game, 200, 200, @onUpdate)
        @game.circle = new Game.Classes.Entity(@game, 100, 100, 'circle')

    update: () ->
        # Send the update signal to all subscribers.
        @onUpdate.dispatch()
