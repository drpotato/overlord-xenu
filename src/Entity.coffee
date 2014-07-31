# This is an basic player class.
class Game.Classes.Entity extends Phaser.Sprite

    constructor: (@game, x, y, name, updates) ->

        # Create sprite object
        super(@game, x, y, name)

        # Add itself to the world.
        @game.add.existing @

        # Enable physics for the sprite if wanted.
        @game.physics.p2.enable(@)
        @body.collideWorldBounds

        # Subscribe to updates.
        if updates?
            updates.add(@update)

        @key_bindings = {}

    update: () =>

    add_key_bindings: (key_bindings) =>
        # Load key bindings into the keyboard controller.
        @key_bindings = Game.Functions.recursive_merge(@key_bindings, key_bindings)
        @game.keyboard.set_key_bindings(@key_bindings)
