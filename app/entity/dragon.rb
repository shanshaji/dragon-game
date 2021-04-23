require 'app/entity/fire_ball.rb'
require 'app/engine/animation_generator.rb'
require 'app/engine/ai_move_logic.rb'
require 'app/engine/ai_fire_ball_logic.rb'

class Dragon < Game
  attr_sprite
  attr_accessor :keys, :cool_down_time, :movement_speed
  def initialize(type: :normal, flip_horizontally: false, x: 100, y: 300, w: 50, h: 50, path: "sprites/misc/dragon-0.png", cool_down_time: 100, movement_speed: 1, no_of_sprites: 5, keys: {forward: :d, up: :w, left: :a, down: :s, fire_key: :space})
    @x = x
    @y = y
    @w = w
    @h = h
    @path = path
    @angle = 0
    @movement_speed = movement_speed
    @flip_vertically = false
    @flip_horizontally = flip_horizontally
    @keys = keys
    @no_of_sprites = no_of_sprites
    @cool_down_time = cool_down_time
    @type = type
    if type == :normal
      @fire_balls =  Array.new(100) { FireBall.new()}
    else
      @fire_balls =  Array.new(100) { FireBall.new(path: 'mygame/sprites/shan/dragon/Fire_Attack-0.png', size: 50, move_logic: fire_ball_move_logic)}
      @move_logic = dragon_move_logic
    end
  end

  def animate(args)
    fly
		movement(args)
  end

  def fly
  	@path = animation_generator(number_of_sprites: @no_of_sprites)
  end

  def movement(args)
    if @move_logic
      @move_logic.call(self)
    else
  		if args.inputs.keyboard.key_held.send(@keys[:forward])
  			@x += @movement_speed
  			@angle = 0
  			@flip_vertically = false
  		end
  		if args.inputs.keyboard.key_held.send(@keys[:up])
  			@y += @movement_speed
  			@angle = 90
  			@flip_vertically = false
  		end
  		if args.inputs.keyboard.key_held.send(@keys[:left])
  			@x -= @movement_speed
  			@angle = 180
  			@flip_vertically = true
  		end
  		if args.inputs.keyboard.key_held.send(@keys[:down])
  			@y -= @movement_speed
  			@angle = 270
  			@flip_vertically = false
  		end
    end
	end

	def attack(enemy, args)
    fire_ball = @fire_balls.pop
    if @type == :normal
      args.state.fire_balls << fire_ball.cast(x: @x, y: @y, angle: @angle, e_x: enemy.x, e_y: enemy.y) if fire_ball
    else
      if (args.state.delta_distance > 0 && @angle == 180) || (args.state.delta_distance > 0 && @angle == 0)
        args.state.fire_balls << fire_ball.cast(x: @x, y: @y, angle: @angle, e_x: enemy.x, e_y: enemy.y)
        args.state.cool_down_time = cool_down_time
      end
    end
	end
end