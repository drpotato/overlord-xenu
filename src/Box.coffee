
class Game.Classes.Box

    constructor: (@game, x, y) ->
        @sprite = @game.add.sprite(x, y, 'box')
        @sprite.scale.divide(6,6)
        # Enable physics for the sprite.
        @game.physics.p2.enable(@sprite)
        @sprite.body.setRectangleFromSprite()
        # Add to its collision group
        @sprite.body.setCollisionGroup(@game.boxes_collision_group)
        @sprite.body.collides([@game.t_wrecks_collision_group, @game.boxes_collision_group])
        
