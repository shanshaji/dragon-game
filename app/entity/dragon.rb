require 'app/entity/flame.rb'
class Dragon
  attr_sprite
  def initialize
    @x = 100
    @y = 100
    @w = 50
    @h = 50
    @path = "sprites/misc/dragon-0.png"
    @angle = 0
    @wing_position = 0
    @movement_speed = 1
  end

  def animate(args)
    fly
		movement(args)
		attack(args)
  end

  def fly
  	@wing_position += 0.1
		@wing_position = 0 if @wing_position >= 5
  	self.path = "sprites/misc/dragon-#{@wing_position.to_i}.png"
  end

  def movement(args)
		if args.inputs.keyboard.d
			self.x += @movement_speed
			self.angle = 0
		end
		if args.inputs.keyboard.w
			self.y += @movement_speed
			self.angle = 90
		end
		if args.inputs.keyboard.a
			self.x -= @movement_speed
			self.angle = 180
		end
		if args.inputs.keyboard.s
			self.y -= @movement_speed
			self.angle = 270
		end
	end

	def attack(args)
		if args.inputs.keyboard.space
	  	flame = Flame.new(@x, @y, @angle)
	  	args.outputs.sprites << flame
		end
	end
end

# class Dragon
# 	attr_sprite
# 	def initialize(args, size=50)
# 		@args = args
# 		@size = size
# 		@screen_bound_x = 1280
# 		@screen_bound_y = 550
# 	end

# 	def dragon
# 		@args.state.size = @size
# 		@args.state.highscore ||= 0
# 		if !@args.state.dragon_x && @args.state.lives <= 0
# 			@args.state.dragon_x = 100
# 			@args.state.dragon_y = 100
# 			@args.state.dragon_wing_position = 0
# 			@args.state.direction = 0
# 			@args.state.dragon_movement_speed = 1
# 			@args.state.lives = 4
# 			@args.state.kills = 0
# 			@args.state.current_score = 0
# 		end

# 		@args.state.dragon_wing_position += 0.1

# 		@args.state.dragon_wing_position = 0 if @args.state.dragon_wing_position >= 5
# 		@args.outputs.sprites << { x: @args.state.dragon_x,
# 															y: @args.state.dragon_y, w: @args.state.size,
# 															h: @args.state.size, path: "sprites/misc/dragon-#{@args.state.dragon_wing_position.to_i}.png", angle: @args.state.direction }

# 		movement
# 		attack
# 		screen_bound
# 		@args
# 	end

# def movement
# 			if @args.inputs.keyboard.d
# 			@args.state.dragon_x += @args.state.dragon_movement_speed
# 			@args.state.direction = 0
# 		end
# 		if @args.inputs.keyboard.w
# 			@args.state.dragon_y += @args.state.dragon_movement_speed
# 			@args.state.direction = 90
# 		end
# 		if @args.inputs.keyboard.a
# 			@args.state.dragon_x -= @args.state.dragon_movement_speed
# 			@args.state.direction = 360
# 		end
# 		if @args.inputs.keyboard.s
# 			@args.state.dragon_y -= @args.state.dragon_movement_speed
# 			@args.state.direction = 270
# 		end
# end

# def screen_bound
# 		if @args.state.dragon_y <= 0
# 			@args.state.dragon_y = @screen_bound_y
# 		elsif  @args.state.dragon_y >= @screen_bound_y
# 			@args.state.dragon_y = 1
# 		elsif  @args.state.dragon_x <= 0
# 			@args.state.dragon_x = @screen_bound_x
# 		elsif  @args.state.dragon_x >= @screen_bound_x
# 			@args.state.dragon_x = 1
# 		end
# 	end
# end

# def attack
# 	if @args.inputs.keyboard.space
#   	flame = Flame.new(@args.state.dragon_x, @args.state.dragon_y, @size, @args.state.direction)
# 		@args.outputs.sprites << { x: flame.x , y: flame.y, w: flame.w, h: flame.h, path: flame.path, angle: flame.direction }
# 	end
# end

# class Flame
# 	attr_accessor :x, :y, :size, :direction, :w, :h, :path, :speed, :distance
# 	def initialize(x,y,size,direction)
# 		@x = x + size
# 		@y = y + 3
# 		@size = size
# 		@direction = direction
# 		@w = 20
# 		@h = 20
# 		@path = 'mygame/sprites/misc/explosion-5.png'
# 		@speed = 2
# 		@distance = 0
# 	end
# end

