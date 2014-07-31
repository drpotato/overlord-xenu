
class Game.Classes.Circle

    constructor: (@game) ->
        
        # Add a basic sprite to the game.
        @sprite = @game.add.sprite(0, 0, 'circle')

        # Enable physics for the sprite.
        @game.physics.p2.enable(@sprite)
        
        @key_bindings = {
            'up': @handle_keypress,
            'right': @handle_keypress,
            'down': @handle_keypress,
            'left': @handle_keypress
        }

        @game.keyboard.setKeyBindings(@key_bindings)

    handle_keypress: (key) =>
        switch key
            when 'up' then @sprite.body.moveUp(400)
            when 'right' then @sprite.body.moveRight(400)
            when 'down' then @sprite.body.moveDown(400)
            when 'left' then @sprite.body.moveLeft(400)
