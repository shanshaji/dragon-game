class Dragon
	def initialize(args, size=50)
		@args = args
		@size = size
	end

	def dragon
		@args.state.size = @size
		# Screen Boundries set to not interfear with the user interface
		@args.state.highscore ||= 0
		if !@args.state.dragon_x && @args.state.lives <= 0
			@args.state.dragon_x = 100
			@args.state.dragon_y = 100
			@args.state.dragon_wing_position = 0
			@args.state.direction = 0
			@args.state.dragon_movement_speed = 1
			@args.state.lives = 4
			@args.state.kills = 0
			@args.state.current_score = 0
		end

		@args.state.dragon_wing_position += 0.1

		@args.state.dragon_wing_position = 0 if @args.state.dragon_wing_position >= 5
		@args.outputs.sprites << { x: @args.state.dragon_x,
															y: @args.state.dragon_y, w: @args.state.size,
															h: @args.state.size, path: "sprites/misc/dragon-#{@args.state.dragon_wing_position.to_i}.png", angle: @args.state.direction }

		movement
		attack
		screen_bound
		@args
	end

def movement
			if @args.inputs.keyboard.d
			@args.state.dragon_x += @args.state.dragon_movement_speed
			@args.state.direction = 0
		end
		if @args.inputs.keyboard.w
			@args.state.dragon_y += @args.state.dragon_movement_speed
			@args.state.direction = 90
		end
		if @args.inputs.keyboard.a
			@args.state.dragon_x -= @args.state.dragon_movement_speed
			@args.state.direction = 360
		end
		if @args.inputs.keyboard.s
			@args.state.dragon_y -= @args.state.dragon_movement_speed
			@args.state.direction = 270
		end
end

def screen_bound
		screen_bound_x = 1280
		screen_bound_y = 550
		if @args.state.dragon_y <= 0
			@args.state.dragon_y = screen_bound_y
		elsif  @args.state.dragon_y >= screen_bound_y
			@args.state.dragon_y = 1
		elsif  @args.state.dragon_x <= 0
			@args.state.dragon_x = screen_bound_x
		elsif  @args.state.dragon_x >= screen_bound_x
			@args.state.dragon_x = 1
		end
	end
end

def attack
	if @args.inputs.keyboard.space
		@args.outputs.sprites << [@args.state.dragon_x + @size , @args.state.dragon_y + 3, 20, 20, 'mygame/sprites/misc/explosion-5.png', @args.state.direction]
	end
end

