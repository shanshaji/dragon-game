class FireBall 
	attr_sprite
	attr_accessor :active
	def initialize(type: "normal", size: 20, path: 'mygame/sprites/misc/explosion-5.png')
		@type = type
		@x = nil
		@y = nil
		@angle = nil
		@w = size
		@h = size
		@path = 'mygame/sprites/misc/explosion-0.png'
		@speed = 2
		@active = true
	end

	def cast(x:, y:, angle:, e_x:, e_y:)
		@x = x + 50
		@y = y + 3
		@angle = angle
		self
	end

	def move
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
		if @x >=1280 || @x <= 0 || @y >= 720 || @y <= 0
			@active = false
		end
		start_looping_at = 0
  		number_of_sprites = 6
  		number_of_frames_to_show_each_sprite = 4
  		does_sprite_loop = true
  		sprite_index = start_looping_at.frame_index number_of_sprites,
                                              number_of_frames_to_show_each_sprite,
                                              does_sprite_loop
        file_name = path.split(".")[0]
    	file_name[-1] = sprite_index.to_s
  		@path = "#{file_name}.png"
	end
end