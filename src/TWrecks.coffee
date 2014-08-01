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
        
        @sprite.body.damping = 0.9
        @sprite.body.angularDamping = 0.99


    move: (key) =>
        # When we handle a keypress, a key object representing the key pressed
        # is passed to this function.

        # Grab the name of the key.
        key_name = key.event.keyIdentifier.toLowerCase()
        switch key_name
            when 'up' then @sprite.body.thrust(500)
            when 'right' then @sprite.body.rotateRight(50)
            when 'down' then @sprite.body.reverse(20)
            when 'left' then @sprite.body.rotateLeft(50)

    attack: (key) =>
        new_angle = @sprite.body.angle + 360
        tween = @game.add.tween(@sprite.body).to({angle: new_angle}, 500, Phaser.Easing.Linear.None)
        tween.start()
        
        
    update: () =>
