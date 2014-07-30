
class Game.Classes.Keyboard
    
    constructor: (@game) ->
        
        @cursors = @game.input.keyboard.createCursorKeys()
        
        Game.Global.onUpdate.add(@update, @)
        
    update: () ->
        if @game.cursors.left.isDown
            @game.sprite.body.moveLeft(400)
        if @game.cursors.right.isDown
            @game.sprite.body.moveRight(400)
        if @game.cursors.up.isDown
            @game.sprite.body.moveUp(400)
        if @game.cursors.down.isDown
            @game.sprite.body.moveDown(400)