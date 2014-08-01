# Keyboard interface for the game.
#
# To bind keys, pass an object to set_key_bindings of the format:
# {
#   key : {
#       event: callback_function,
#       ...
#       },
#   ...
#   }
# }
#
# Key can be one of: 'a', 'b', 'c', ..., 'z', '1', ..., '0', 'up', 'down', 'left', 'right', 'space'.
# Event can be one of:  'onHold', 'onDown', 'onUp'.
# The event callback is called when they event for that key is sent.
#
# See Game.Classes.Circle for an example of binding keys.

class Game.Classes.Keyboard

    constructor: (@game) ->

        @keys = @game.input.keyboard.createCursorKeys()

        # Awesome way to binding most of the keys on the keyboard.
        for key in "abcdefghijklmnopqrstuvwxyz1234567890".split("")
            @keys[key] = @game.input.keyboard.addKey(Phaser.Keyboard[key.toUpperCase()])

        # Some of the other keys aren't so easy.
        @keys.space = @game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR)

        @key_bindings = {}

    set_key_bindings: (key_bindings) =>
        @key_bindings = Game.Functions.recursive_merge(@key_bindings, key_bindings)
        @update_key_bindings()

    reset_key_bindings: () =>
        @key_bindings = {}
        for key of @keys
            for event in ['onDown', 'onUp']
                @keys[key][event].removeAll()
            @keys[key].onHoldCallback = null

    update_key_bindings: () =>

        for key of @keys
            if @keys[key]? and @key_bindings[key]?
                for event in ['onDown', 'onUp']
                    if @key_bindings[key][event]?
                        @keys[key][event].removeAll()
                        @keys[key][event].add(@key_bindings[key][event])
                if @key_bindings[key]['onHold']?
                    @keys[key].onHoldCallback = @key_bindings[key]['onHold']