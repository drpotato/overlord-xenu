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

    update: () =>
        

    start_move: () =>
        @place_box()
        target_x = Game.Functions.random_int_between(0, Game.game.width)
        target_y = Game.Functions.random_int_between(0, Game.game.height)
        @tween = @game.add.tween(@sprite.body).to({x: target_x, y: target_y}, 1000)
        @tween.onComplete.add(@start_move, this)
        @tween.start()

    place_box: () =>
        new Game.Classes.Box(@game, @sprite.position.x, @sprite.position.y)
        # keep xenu on top
        @sprite.bringToTop()
