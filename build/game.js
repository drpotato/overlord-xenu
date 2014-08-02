(function() {
  Game.Classes.Box = (function() {
    Box.boxes = null;

    function Box(game, x, y) {
      this.game = game;
      if (this.boxes == null) {
        this.boxes = this.game.add.group();
        this.boxes.enableBody = true;
        this.boxes.physicsBodyType = Phaser.Physics.P2JS;
      }
      this.sprite = this.boxes.create(x, y, 'box');
      this.sprite.scale.divide(6, 6);
      this.game.physics.p2.enable(this.sprite);
      this.sprite.body.setRectangleFromSprite();
      this.sprite.body["static"] = true;
      this.sprite.body.setCollisionGroup(this.game.boxes_collision_group);
      this.sprite.body.collides([this.game.t_wrecks_collision_group, this.game.boxes_collision_group]);
      this.game.no_boxes += 1;
    }

    return Box;

  })();

}).call(this);

(function() {
  Game.Classes.Crater = (function() {
    function Crater(game) {
      this.game = game;
      this.sprite = this.game.add.sprite(this.game.width / 2, this.game.height / 2, 'crater');
      this.game.physics.p2.enable(this.sprite);
      this.sprite.body["static"] = true;
      this.sprite.body.clearShapes();
      this.sprite.body.addShape(new p2.Circle(3), -310, 40);
      this.sprite.body.addShape(new p2.Circle(5), -250, 40);
      this.sprite.body.addShape(new p2.Rectangle(24, 8), -20, 58);
      this.sprite.body.addShape(new p2.Circle(7), 230, 0);
      this.sprite.body.addShape(new p2.Rectangle(18, 8), 52, -55);
      this.sprite.body.addShape(new p2.Rectangle(6, 9), -180, -40, 1.1);
      this.sprite.body.addShape(new p2.Circle(8), -25, 5);
      this.sprite.body.addShape(new p2.Circle(8.2), 25, 0);
      this.sprite.body.addShape(new p2.Circle(8.2), 100, 0);
      this.sprite.body.setCollisionGroup(this.game.crater_collision_group);
      this.sprite.body.collides([this.game.t_wrecks_collision_group, this.game.boxes_collision_group]);
    }

    return Crater;

  })();

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Game.Classes.Entity = (function() {
    function Entity(game, x, y, name, updates) {
      this.game = game;
      this.add_key_bindings = __bind(this.add_key_bindings, this);
      this.update = __bind(this.update, this);
      this.sprite = this.game.add.sprite(x, y, name);
      this.game.physics.p2.enable(this.sprite);
      if (updates != null) {
        updates.add(this.update);
      }
      this.key_bindings = {};
    }

    Entity.prototype.update = function() {};

    Entity.prototype.add_key_bindings = function(key_bindings) {
      this.key_bindings = Game.Functions.recursive_merge(this.key_bindings, key_bindings);
      return this.game.keyboard.set_key_bindings(this.key_bindings);
    };

    return Entity;

  })();

}).call(this);

(function() {
  Game.Functions = (function() {
    function Functions() {}

    Functions.recursive_merge = function(object_1, object_2) {
      var e, property;
      for (property in object_2) {
        try {
          if (object_2[property].constructor === Object) {
            object_1[property] = this.recursive_merge(object_1[property], object_2[property]);
          } else {
            object_1[property] = object_2[property];
          }
        } catch (_error) {
          e = _error;
          object_1[property] = object_2[property];
        }
      }
      return object_1;
    };

    Functions.random_int_between = function(min, max) {
      return Math.floor(Math.random() * (max - min) + min);
    };

    return Functions;

  })();

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Game.Classes.Keyboard = (function() {
    function Keyboard(game) {
      var key, _i, _len, _ref;
      this.game = game;
      this.update_key_bindings = __bind(this.update_key_bindings, this);
      this.reset_key_bindings = __bind(this.reset_key_bindings, this);
      this.set_key_bindings = __bind(this.set_key_bindings, this);
      this.keys = this.game.input.keyboard.createCursorKeys();
      _ref = "abcdefghijklmnopqrstuvwxyz1234567890".split("");
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        key = _ref[_i];
        this.keys[key] = this.game.input.keyboard.addKey(Phaser.Keyboard[key.toUpperCase()]);
      }
      this.keys.space = this.game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR);
      this.key_bindings = {};
    }

    Keyboard.prototype.set_key_bindings = function(key_bindings) {
      this.key_bindings = Game.Functions.recursive_merge(this.key_bindings, key_bindings);
      return this.update_key_bindings();
    };

    Keyboard.prototype.reset_key_bindings = function() {
      var event, key, _i, _len, _ref, _results;
      this.key_bindings = {};
      _results = [];
      for (key in this.keys) {
        _ref = ['onDown', 'onUp'];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          event = _ref[_i];
          this.keys[key][event].removeAll();
        }
        _results.push(this.keys[key].onHoldCallback = null);
      }
      return _results;
    };

    Keyboard.prototype.update_key_bindings = function() {
      var event, key, _i, _len, _ref, _results;
      _results = [];
      for (key in this.keys) {
        if ((this.keys[key] != null) && (this.key_bindings[key] != null)) {
          _ref = ['onDown', 'onUp'];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            event = _ref[_i];
            if (this.key_bindings[key][event] != null) {
              this.keys[key][event].removeAll();
              this.keys[key][event].add(this.key_bindings[key][event]);
            }
          }
          if (this.key_bindings[key]['onHold'] != null) {
            _results.push(this.keys[key].onHoldCallback = this.key_bindings[key]['onHold']);
          } else {
            _results.push(void 0);
          }
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    return Keyboard;

  })();

}).call(this);

(function() {
  Game.States.Preloader = (function() {
    function Preloader(game) {
      this.game = game;
    }

    Preloader.prototype.preload = function() {
      this.game.stage.backgroundColor = '#FFF';
      this.game.load.image('t_wrecks', 'res/t_wrecks.png');
      this.game.load.image('circle', 'res/circle.png');
      this.game.load.image('xenu', 'res/xenu.png');
      this.game.load.image('box', 'res/box.jpg');
      return this.game.load.image('crater', 'res/crater.jpg');
    };

    Preloader.prototype.create = function() {
      return this.game.state.start('Run');
    };

    return Preloader;

  })();

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Game.States.Run = (function() {
    function Run(game) {
      this.game = game;
      this.check_box_collision = __bind(this.check_box_collision, this);
      this.update_boxes_string = __bind(this.update_boxes_string, this);
      this.update_score_string = __bind(this.update_score_string, this);
    }

    Run.prototype.preload = function() {
      Game.Global = this;
      this.onUpdate = new Phaser.Signal();
      this.game.keyboard = new Game.Classes.Keyboard(this.game);
      return this.sound_manager = new Phaser.SoundManager(this.game);
    };

    Run.prototype.create = function() {
      this.game.stage.backgroundColor = '#0000000';
      this.game.physics.startSystem(Phaser.Physics.P2JS);
      this.game.physics.p2.defaultRestitution = 0.2;
      this.game.physics.p2.setImpactEvents(true);
      this.game.t_wrecks_collision_group = this.game.physics.p2.createCollisionGroup();
      this.game.xenu_collision_group = this.game.physics.p2.createCollisionGroup();
      this.game.boxes_collision_group = this.game.physics.p2.createCollisionGroup();
      this.game.crater_collision_group = this.game.physics.p2.createCollisionGroup();
      this.game.physics.p2.updateBoundsCollisionGroup();
      this.game.crater = new Game.Classes.Crater(this.game);
      this.game.t_wrecks = new Game.Classes.TWrecks(this.game, 200, 200, this.onUpdate);
      this.game.xenu = new Game.Classes.Xenu(this.game, 300, 300, this.onUpdate);
      this.game.t_wrecks.sprite.body.setCollisionGroup(this.game.t_wrecks_collision_group);
      this.game.t_wrecks.sprite.body.collides([this.game.xenu_collision_group, this.game.crater_collision_group]);
      this.game.t_wrecks.sprite.body.collides(this.game.boxes_collision_group, this.check_box_collision);
      this.style = {
        font: "20px Arial",
        fill: "#ff0044",
        align: "left"
      };
      this.score = 0;
      this.score_string = 'Score: 0';
      this.game.score_display = this.game.add.text(0, 0, this.score_string, this.style);
      this.game.no_boxes = 0;
      this.game.score = 0;
      this.game.max_boxes = 30;
      this.boxes_string = 'Boxes: ' + this.game.no_boxes.toString() + '/' + this.game.max_boxes.toString();
      return this.game.boxes_display = this.game.add.text(0, 20, this.boxes_string, this.style);
    };

    Run.prototype.update_score_string = function() {
      this.score_string = 'Score: ' + this.score.toString();
      return this.game.score_display.text = this.score_string;
    };

    Run.prototype.update_boxes_string = function() {
      this.boxes_string = 'Boxes: ' + this.game.no_boxes.toString() + '/' + this.game.max_boxes.toString();
      return this.game.boxes_display.text = this.boxes_string;
    };

    Run.prototype.update = function() {
      if (this.game.no_boxes === this.game.max_boxes) {
        this.game.paused = true;
      }
      return this.onUpdate.dispatch();
    };

    Run.prototype.check_box_collision = function(object_1, object_2) {
      if (this.game.t_wrecks.attacking && (object_2.sprite != null)) {
        this.score += 1;
        this.game.score = this.score;
        this.game.no_boxes -= 1;
        this.update_score_string();
        this.update_boxes_string();
        object_2.sprite.destroy();
        return object_2 = null;
      }
    };

    return Run;

  })();

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Game.Classes.TWrecks = (function(_super) {
    __extends(TWrecks, _super);

    function TWrecks(game, x, y, update) {
      this.game = game;
      this.update = __bind(this.update, this);
      this.attack = __bind(this.attack, this);
      this.move = __bind(this.move, this);
      TWrecks.__super__.constructor.call(this, this.game, x, y, 't_wrecks', update);
      this.name = 't_wrecks';
      this.add_key_bindings({
        'up': {
          'onHold': this.move
        },
        'right': {
          'onHold': this.move
        },
        'down': {
          'onHold': this.move
        },
        'left': {
          'onHold': this.move
        },
        'a': {
          'onDown': this.attack
        }
      });
      this.sprite.body.damping = 0.99;
      this.sprite.body.angularDamping = 0.999;
      this.attacking = false;
      this.rotation_speed = 100;
      this.forward_speed = 500;
      this.backward_speed = 200;
    }

    TWrecks.prototype.move = function(key) {
      var key_name;
      if (this.attacking) {
        return;
      }
      key_name = key.event.keyIdentifier.toLowerCase();
      switch (key_name) {
        case 'up':
          return this.sprite.body.moveForward(this.forward_speed);
        case 'right':
          return this.sprite.body.rotateRight(this.rotation_speed);
        case 'down':
          return this.sprite.body.moveBackward(this.backward_speed);
        case 'left':
          return this.sprite.body.rotateLeft(this.rotation_speed);
      }
    };

    TWrecks.prototype.attack = function(key) {
      var new_angle, tween;
      new_angle = this.sprite.body.angle + 360;
      tween = this.game.add.tween(this.sprite.body).to({
        angle: new_angle
      }, 500, Phaser.Easing.Linear.None);
      tween.onStart.add((function(_this) {
        return function() {
          return _this.attacking = true;
        };
      })(this));
      tween.onComplete.add((function(_this) {
        return function() {
          return _this.attacking = false;
        };
      })(this));
      return tween.start();
    };

    TWrecks.prototype.update = function() {};

    return TWrecks;

  })(Game.Classes.Entity);

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Game.Classes.Xenu = (function(_super) {
    __extends(Xenu, _super);

    function Xenu(game, x, y, update) {
      this.game = game;
      this.place_box = __bind(this.place_box, this);
      this.start_move = __bind(this.start_move, this);
      this.update = __bind(this.update, this);
      Xenu.__super__.constructor.call(this, this.game, x, y, 'xenu', update);
      this.sprite.scale.divide(4, 4);
      this.sprite.body.setRectangleFromSprite();
      this.sprite.body.setCollisionGroup(this.game.xenu_collision_group);
      this.sprite.body.collides([this.game.t_wrecks_collision_group]);
      this.start_move();
    }

    Xenu.prototype.update = function() {};

    Xenu.prototype.start_move = function() {
      var target_x, target_y, time_to_next_box;
      this.place_box();
      target_x = Game.Functions.random_int_between(0, this.game.width);
      target_y = Game.Functions.random_int_between(0, this.game.height);
      time_to_next_box = Math.max(10, 2000 - this.game.score * 50);
      this.tween = this.game.add.tween(this.sprite.body).to({
        x: target_x,
        y: target_y
      }, time_to_next_box);
      this.tween.onComplete.add(this.start_move, this);
      return this.tween.start();
    };

    Xenu.prototype.place_box = function() {
      var new_box;
      new_box = new Game.Classes.Box(this.game, this.sprite.position.x, this.sprite.position.y);
      return this.sprite.bringToTop();
    };

    return Xenu;

  })(Game.Classes.Entity);

}).call(this);

(function() {
  var antialias, height, parent, physics_config, renderer, state, transparent, width;

  width = window.innerWidth;

  height = window.innerHeight;

  renderer = Phaser.CANVAS;

  parent = 'game-div';

  state = null;

  transparent = true;

  antialias = true;

  physics_config = null;

  Game.game = new Phaser.Game(width, height, renderer, parent, transparent, antialias, physics_config);

  Game.game.state.add('Preloader', Game.States.Preloader, true);

  Game.game.state.add('Run', Game.States.Run, false);

}).call(this);
