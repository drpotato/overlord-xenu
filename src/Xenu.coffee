# This is the enemy.
class Game.Classes.Xenu extends Game.Classes.Entity

    constructor: (@game, x, y, update) ->
        super(@game, x, y, 'xenu', update)
        @sprite.scale.divide(4,4) # 1/4 the size
        @sprite.body.setRectangleFromSprite()

        # Add him to his collision group
        @sprite.body.setCollisionGroup(@game.xenu_collision_group)
        @sprite.body.collides([@game.t_wrecks_collision_group])

        @start_move()
        #test

    update: () =>
        

    start_move: () =>
        @place_box()
        target_x = Game.Functions.random_int_between(0, @game.width)
        target_y = Game.Functions.random_int_between(0, @game.height)
        time_to_next_box = Math.max(10, 2000 - @game.no_boxes * 50)
        @tween = @game.add.tween(@sprite.body).to({x: target_x, y: target_y}, time_to_next_box)
        @tween.onComplete.add(@start_move, this)
        @tween.start()

    place_box: () =>
        new_box = new Game.Classes.Box(@game, @sprite.position.x, @sprite.position.y)
        
        # keep xenu on top
        @sprite.bringToTop()
