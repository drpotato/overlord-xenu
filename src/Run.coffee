# Main state for game, might split up into levels later.
class Game.States.Run
    # `@game` automatically creates `this.game = game`
    constructor: (@game) ->

    # Load in all the files required for the game.
    preload: () ->

    create: () ->
        # Start the game's physics.
        @game.physics.startSystem(Phaser.Physics.P2JS)
        @game.physics.p2.defaultRestitution = 0.2
        
        # 
        @game.sprite = @game.add.sprite(0, 0, 'circle')

        @game.physics.p2.enable(@game.sprite)

        @game.cursors = @game.input.keyboard.createCursorKeys()

    update: () ->
        if @game.cursors.left.isDown
            @game.sprite.body.moveLeft(400)
        if @game.cursors.right.isDown
            @game.sprite.body.moveRight(400)
        if @game.cursors.up.isDown
            @game.sprite.body.moveUp(400)
        if @game.cursors.down.isDown
            @game.sprite.body.moveDown(400)

