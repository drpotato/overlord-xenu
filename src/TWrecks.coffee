# This is an basic player class.
class Game.Classes.TWrecks extends Game.Classes.Entity

    constructor: (@game, x, y, update) ->

        super(@game, x, y, 't_wrecks', update)

        @name = 't_wrecks'
        
        # Add him to his collision group
        @sprite.body.setCollisionGroup(@game.t_wrecks_collision_group)
        @sprite.body.collides([@game.xenu_collision_group, @game.boxes_collision_group])
        
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
        # Body constants:
        @sprite.body.damping = 0.99
        @sprite.body.angularDamping = 0.999
        @attacking = false
        @rotation_speed = 100
        @forward_speed = 500
        @backward_speed = 200


    move: (key) =>
        # When we handle a keypress, a key object representing the key pressed
        # is passed to this function.
        
        # Can't move if attacking.
        if @attacking
            return

        # Grab the name of the key.
        key_name = key.event.keyIdentifier.toLowerCase()
        switch key_name
            when 'up' then @sprite.body.moveForward(@forward_speed)
            when 'right' then @sprite.body.rotateRight(@rotation_speed)
            when 'down' then @sprite.body.moveBackward(@backward_speed)
            when 'left' then @sprite.body.rotateLeft(@rotation_speed)

    attack: (key) =>
        new_angle = @sprite.body.angle + 360
        tween = @game.add.tween(@sprite.body).to({angle: new_angle}, 500, Phaser.Easing.Linear.None)
        tween.onStart.add(() => @attacking = true)
        tween.onComplete.add(() => @attacking = false)
        tween.start()

    update: () =>
        
