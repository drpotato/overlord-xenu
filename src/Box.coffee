
class Game.Classes.Box
    
    @boxes: null
    @number_of_boxes: 0
    
    constructor: (@game, x, y) ->
        
        if not @boxes?
                @boxes = @game.add.group()
                @boxes.enableBody = true;
                @boxes.physicsBodyType = Phaser.Physics.P2JS;
                
        @number_of_boxes += 1
        
        @sprite = @boxes.create(x, y, 'box')
        @sprite.scale.divide(6,6)
        # Enable physics for the sprite.
        @game.physics.p2.enable(@sprite)
        @sprite.body.setRectangleFromSprite()
        @sprite.body.static = true
        # Add to its collision group
        @sprite.body.setCollisionGroup(@game.boxes_collision_group)
        @sprite.body.collides([@game.t_wrecks_collision_group, @game.boxes_collision_group])
        
    @get_number: () ->
        return @number_of_boxes