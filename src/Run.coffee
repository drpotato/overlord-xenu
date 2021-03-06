# Main state for game, might split up into levels later.
class Game.States.Run
    # `@game` automatically creates `this.game = game`
    
    constructor: (@game) ->

    # Load in all the files required for the game.
    preload: () ->
        # Set up cross Class communication as we cannot access parent classes
        # in javascript.
        Game.Global = @

        # Setup global update signal.
        # We use this to update all the entities in the game (maybe...)
        @onUpdate = new Phaser.Signal()

        # Set the keyboard.
        @game.keyboard = new Game.Classes.Keyboard(@game)

        # Create a sound manager and add music.
        @sound_manager = new Phaser.SoundManager(@game)
        # I haven't enabled this because there currently exists no music.
        # It's added in a similar way to images.
        # @sound_manager.music = @soundmanager.add('music', 1, true)

    create: () ->
        
        @game.stage.backgroundColor = '#0000000'
        
        # Start the game's physics.
        @game.physics.startSystem(Phaser.Physics.P2JS)
        @game.physics.p2.defaultRestitution = 0.2
        
        @game.physics.p2.setImpactEvents(true);

        # Create collision groups for objects
        @game.t_wrecks_collision_group = @game.physics.p2.createCollisionGroup()
        @game.xenu_collision_group = @game.physics.p2.createCollisionGroup()
        @game.boxes_collision_group = @game.physics.p2.createCollisionGroup()
        @game.crater_collision_group = @game.physics.p2.createCollisionGroup()
        # Still want to collide with world bounds
        @game.physics.p2.updateBoundsCollisionGroup()

        # Create our objects in the world.
        @game.crater = new Game.Classes.Crater(@game)
        @game.t_wrecks = new Game.Classes.TWrecks(@game, 200, 200, @onUpdate)
        @game.xenu = new Game.Classes.Xenu(@game, 300, 300, @onUpdate)
        
        @game.t_wrecks.sprite.body.setCollisionGroup(@game.t_wrecks_collision_group)
        @game.t_wrecks.sprite.body.collides([@game.xenu_collision_group, @game.crater_collision_group])
        @game.t_wrecks.sprite.body.collides(@game.boxes_collision_group, @check_box_collision)
        
        # Text/Interface
        @style = { font: "20px Arial", fill: "#ff0044", align: "left" };
        @score = 0
        @score_string = 'Score: 0'
        @game.score_display = @game.add.text(0, 0, @score_string, @style)
        
        @game.no_boxes = 0
        @game.score = 0
        @game.max_boxes = 30
        @boxes_string = 'Boxes: ' + @game.no_boxes.toString() + '/' + @game.max_boxes.toString()
        @game.boxes_display = @game.add.text(0, 20, @boxes_string, @style)
    
    update_score_string: () =>
        @score_string = 'Score: ' + @score.toString()
        @game.score_display.text = @score_string
        
    update_boxes_string: () =>
        @boxes_string = 'Boxes: ' + @game.no_boxes.toString() + '/' + @game.max_boxes.toString()
        @game.boxes_display.text = @boxes_string

    update: () ->
        # Send the update signal to all subscribers.
        if @game.no_boxes == @game.max_boxes
            @game.paused = true 
        
        @onUpdate.dispatch()

    check_box_collision: (object_1, object_2) =>
        if @game.t_wrecks.attacking and object_2.sprite?
            @score += 1
            @game.score = @score
            @game.no_boxes -= 1
            @update_score_string()
            @update_boxes_string()
            object_2.sprite.destroy()
            object_2 = null
