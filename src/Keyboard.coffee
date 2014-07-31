
class Game.Classes.Keyboard

    constructor: (@game) ->

        @keys = @game.input.keyboard.createCursorKeys()

        @key_bindings = {}

    setKeyBindings: (key_bindings) =>
        @key_bindings = Game.Functions.recursive_merge(@key_bindings, key_bindings)
        @update_key_bindings()

    reset_key_bindings: () =>
        @key_bindings = {}
        @update_key_bindings()

    update_key_bindings: () =>

        for key of @keys
            if @keys[key]? and @key_bindings[key]?
                for event in ['onDown', 'onUp']
                    if @key_bindings[key][event]?
                        @keys[key][event].removeAll()
                        @keys[key][event].add(@key_bindings[key][event])
                if @key_bindings[key]['onHold']?
                    @keys[key].onHoldCallback = @key_bindings[key]['onHold']
