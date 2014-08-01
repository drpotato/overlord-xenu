# This is an basic player class.
class Game.Classes.TWrecks extends Game.Classes.Entity

    constructor: (@game, x, y, update) ->

        super(@game, x, y, 't_wrecks', update)
        
        # Set up the key bindings for the entity.
        @add_key_bindings({
            'up': {
                'onHold': @move
            },
            'right': {
                'onHold': @move
            },
            'down': {
                'onHold': @move
            },
            'left': {
                'onHold': @move
            },
            'a': {
                'onDown': @attack
            }
        })


    move: (key) =>
        # When we handle a keypress, a key object representing the key pressed
        # is passed to this function.

        # Grab the name of the key.
        key_name = key.event.keyIdentifier.toLowerCase()

        switch key_name
            when 'up' then @sprite.body.moveUp(500)
            when 'right' then @sprite.body.moveRight(500)
            when 'down' then @sprite.body.moveDown(500)
            when 'left' then @sprite.body.moveLeft(500)

    attack: (key) =>
        console.log 'Attacking!'
        tween = @game.add.tween(@sprite).to({angle: 360}, 500, Phaser.Easing.Linear.None)
        tween.start()
        
        
    update: () =>
        # Chuck some friction in'
        @sprite.body.velocity.x /= 1.01
        @sprite.body.velocity.y /= 1.01
        
        