require 'app/engine/animation_generator.rb'
class FireBall 
	attr_sprite
	attr_accessor :active, :move_logic, :e_x, :e_y
	def initialize(speed: 2, size: 20, path: 'mygame/sprites/misc/explosion-0.png', distance: 300, move_logic: nil)
		@x = nil
		@y = nil
		@angle = nil
		@w = size
		@h = size
		@path = path
		@speed = speed
		@active = true
		@distance = distance
		@distance_travelled = 0
		@e_x = nil
		@e_y = nil
		@move_logic = move_logic
	end

	def cast(x:, y:, angle:, e_x:, e_y:)
		@x = x + 50 + @w
		@y = y + 3 + @w
		@angle = angle
		@e_x = e_x
		@e_y = e_y
		self
	end

	def move
		fire_ball_move_logic
		is_fire_ball_active
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