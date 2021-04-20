require 'app/entity/flame.rb'
class Dragon < Game
  attr_sprite
  def initialize(x: 100, y: 300, w: 50, h: 50, path: "sprites/misc/dragon-0.png", movement_speed: 1)
    @x = x
    @y = y
    @w = w
    @h = h
    @path = path
    @angle = 0
    @movement_speed = movement_speed
    @flip_vertically = false
  end

  def animate(args)
    fly
		movement(args)
		attack
  end

  def fly
  	start_looping_at = 0
  	number_of_sprites = 5
  	number_of_frames_to_show_each_sprite = 4
  	does_sprite_loop = true
  	sprite_index = start_looping_at.frame_index number_of_sprites,
                                              number_of_frames_to_show_each_sprite,
                                              does_sprite_loop
    file_name = path.split(".")[0]
    file_name[-1] = sprite_index.to_s
  	@path = "#{file_name}.png"
  end

  def movement(args)
		if args.inputs.keyboard.d
			self.x += @movement_speed
			self.angle = 0
			self.flip_vertically = false
		end
		if args.inputs.keyboard.w
			self.y += @movement_speed
			self.angle = 90
			self.flip_vertically = false
		end
		if args.inputs.keyboard.a
			self.x -= @movement_speed
			self.angle = 180
			self.flip_vertically = true
		end
		if args.inputs.keyboard.s
			self.y -= @movement_speed
			self.angle = 270
			self.flip_vertically = false
		end
	end

	def attack
		Flame.new(@x, @y, @angle)
	end
end