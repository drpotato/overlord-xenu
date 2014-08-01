# This is the enemy.
class Game.Classes.Xenu extends Game.Classes.Entity

    constructor: (@game, x, y, update) ->
        super(@game, x, y, 'xenu', update)
        @sprite.scale.divide(4,4) # 1/4 the size
        target_x = Game.Functions.random_int_between(0, Game.game.width)
        target_y = Game.Functions.random_int_between(0, Game.game.height)
	

    update: () =>
	
        @game.add.tween(@sprite).to(x: 123, y: 234)

    do_nothing: (key) =>


        