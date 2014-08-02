
class Game.Classes.Crater

    constructor: (@game) ->
        @sprite = @game.add.sprite(@game.width / 2, @game.height / 2, 'crater')
        # Enable physics for the sprite.
        @game.physics.p2.enable(@sprite)
        @sprite.body.static = true
        @sprite.body.clearShapes()
        @sprite.body.addShape(new p2.Circle(3), -310, 40) #left edge
        #Game.game.crater.sprite.body.addShape(new p2.Circle(5), -250, 40)
        @sprite.body.addShape(new p2.Circle(5), -250, 40) #left side
        @sprite.body.addShape(new p2.Rectangle(24, 8), -20, 58) #bottom edge
        @sprite.body.addShape(new p2.Circle(7), 230, 0) # right side
        @sprite.body.addShape(new p2.Rectangle(18, 8), 52, -55) # top side
        @sprite.body.addShape(new p2.Rectangle(6, 9), -180, -40, 1.1) # top left edge
        @sprite.body.addShape(new p2.Circle(8), -25, 5) # middle left
        @sprite.body.addShape(new p2.Circle(8.2), 25, 0) # middle centre
        @sprite.body.addShape(new p2.Circle(8.2), 100, 0) # middle right
        
        # Add to its collision group
        @sprite.body.setCollisionGroup(@game.crater_collision_group)
        @sprite.body.collides([@game.t_wrecks_collision_group, @game.boxes_collision_group])
        
