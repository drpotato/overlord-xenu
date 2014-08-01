# This is an basic entity class.
class Game.Classes.Entity

    constructor: (@game, x, y, name, updates) ->

        # Create sprite object and add it to the world.
        @sprite = @game.add.sprite(x, y, name)
        
        # Enable physics for the sprite if wanted.
        @game.physics.p2.enable(@sprite)

        # Subscribe to updates.
        if updates?
            updates.add(@update)

        @key_bindings = {}

    update: () =>

    add_key_bindings: (key_bindings) =>
        # Load key bindings into the keyboard controller.
        @key_bindings = Game.Functions.recursive_merge(@key_bindings, key_bindings)
        @game.keyboard.set_key_bindings(@key_bindings)
