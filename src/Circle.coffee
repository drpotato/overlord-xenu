# This is an example class of how to set up a Entity.
class Game.Classes.Circle

    constructor: (@game) ->

        # Add a basic sprite to the game.
        @sprite = @game.add.sprite(0, 0, 'circle')

        # Enable physics for the sprite.
        @game.physics.p2.enable(@sprite)

        # Set up the key bindings for the entity.
        @key_bindings = {
            'up': {
                'onHold': @handle_keypress,
                'onUp' : @do_nothing,
                'onDown': @do_nothing,
            },
            'right': {
                'onHold': @handle_keypress,
                'onUp' : @do_nothing,
                'onDown': @do_nothing,
            },
            'down': {
                'onHold': @handle_keypress,
                'onUp' : @do_nothing,
                'onDown': @do_nothing,
            },
            'left': {
                'onHold': @handle_keypress,
                'onUp' : @do_nothing,
                'onDown': @do_nothing,
            },
            'a': {
                'onHold': @do_nothing
            },
            'space': {
                'onDown': @handle_keypress
            }
        }
        # Load key bindings into the keyboard controller.
        @game.keyboard.set_key_bindings(@key_bindings)

    handle_keypress: (key) =>
        # When we handle a keypress, a key object representing the key pressed
        # is passed to this function.

        # Grab the name of the key.
        key_name = key.event.keyIdentifier.toLowerCase()

        switch key_name
            when 'up' then @sprite.body.moveUp(400)
            when 'right' then @sprite.body.moveRight(400)
            when 'down' then @sprite.body.moveDown(400)
            when 'left' then @sprite.body.moveLeft(400)

    do_nothing: (key) =>
