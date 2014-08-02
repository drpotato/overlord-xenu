
class Game.Classes.Box

    constructor: (@game, x, y) ->
        @sprite = @game.add.sprite(x, y, 'box')
        @sprite.scale.divide(6,6)
        # Enable physics for the sprite.
        @game.physics.p2.enable(@sprite)
        @sprite.body.setRectangleFromSprite()
        @sprite.body.static = true

