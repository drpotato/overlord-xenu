
class Game.Classes.Circle

    constructor: (@game) ->
        
        # Add a basic sprite to the game.
        @sprite = @game.add.sprite(0, 0, 'circle')

        # Enable physics for the sprite.
        @game.physics.p2.enable(@sprite)
        
        @key_bindings = {
            'up': @move(0),
            'right': @move(1),
            'down': @move(2),
            'left': @move(3)
        }

        @game.keyboard.setKeyBindings(@key_bindings)

    move: (direction) ->
        
        console.log(direction)
        
        switch direction
            when 0 then @sprite.body.moveUp(400)
            when 1 then @sprite.body.moveRight(400)
            when 2 then @sprite.body.moveDown(400)
            when 3 then @sprite.body.moveLeft(400)