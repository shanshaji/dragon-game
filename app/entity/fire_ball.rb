require 'app/functions/animation_generator.rb'
class FireBall 
	attr_sprite
	attr_accessor :active, :move_logic, :e_x, :e_y, :x_projection, :y_projection
	def initialize(speed: 2, size: 20, path: 'mygame/sprites/misc/explosion-0.png', distance: 300, move_logic: nil)
		@x = nil
		@y = nil
		@angle = nil
		@w = size
		@h = size
		@path = path
		@rect = nil
		@speed = speed
		@active = true
		@distance = distance
		@distance_travelled = 0
		@x_projection = nil
		@y_projection = nil
		@e_x = nil
		@e_y = nil
		@move_logic = move_logic
	end
  # dest   = destination_rect(state)
  # source = source_rect(state),
  # outputs.sprites << create_sprite(
  #   'sprites/86.png',
  #   x: dest.x,
  #   y: dest.y,
  #   w: dest.w,
  #   h: dest.h,
  #   angle: state.angle,
  #   source_x: source.x,
  #   source_y: source.y,
  #   source_w: source.w,
  #   source_h: source.h,
  #   flip_h: false,
  #   flip_v: false,
  #   rotation_anchor_x: 0.7,
  #   rotation_anchor_y: 0.5
  # )

	def cast(x:, y:, angle:, e_x:, e_y:)
		if angle == 0
			@x = x + 30 + @w
			@y = y
		elsif angle == 90
			@x = x
			@y = y + 10 + @w
		elsif angle == 180
			@x = x - 30 + @w
			@y = y
		elsif angle == 270
			@x = x
			@y = y - 10 + @w
		end
		# @x = angle == 180 ? (x - 50 + @w) : (x + 50 + @w)
		# @y = angle == 270 ? (y - 3 + @w): (y + 3 + @w)
		@angle = angle
		if x > e_x
			@x_projection = :+
		elsif x < e_x
			@x_projection = :-
		end
		if y > e_y
			@y_projection = :+
		elsif y < e_y
			@y_projection = :-
		end
		@e_x = e_x
		@e_y = e_y
		self
	end

	def move
		fire_ball_move_logic
		is_fire_ball_active
		@rect = [@x, @y, @w, @h]
  		@path = animation_generator(number_of_sprites: 6, does_sprite_loop: true)
	end


	private


	def is_fire_ball_active
		if @x >=1280 || @x <= 0 || @y >= 720 || @y <= 0 || @distance_travelled >= @distance
			@active = false
		end
	end

	def fire_ball_move_logic
		@distance_travelled += 1
		if @move_logic
			@move_logic.call(self)
		else
			if @angle == 0
				@x += @speed
			end
			if @angle == 90
				@y += @speed
			end
			if @angle == 180
				@x -= @speed
			end
			if @angle == 270
				@y -= @speed
			end
		end
	end
end