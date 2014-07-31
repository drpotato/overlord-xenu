# This is an basic player class.
class Game.Classes.Player extends Game.Classes.Entity

    constructor: (@game, x, y, update) ->

        super(@game, x, y, 'circle', update)
        
        # Set up the key bindings for the entity.
        @add_key_bindings({
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
        })


    handle_keypress: (key) =>
        # When we handle a keypress, a key object representing the key pressed
        # is passed to this function.

        # Grab the name of the key.
        key_name = key.event.keyIdentifier.toLowerCase()

        switch key_name
            when 'up' then @body.moveUp(500)
            when 'right' then @body.moveRight(500)
            when 'down' then @body.moveDown(500)
            when 'left' then @body.moveLeft(500)

    do_nothing: (key) =>
