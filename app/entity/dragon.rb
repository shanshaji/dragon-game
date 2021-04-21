require 'app/entity/fire_ball.rb'
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
    @fire_balls =  Array.new(100) { FireBall.new()}
  end

  def animate(args)
    fly
		movement(args)
    # args.state.fire_balls = @fire_balls
		# attack(args)
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
			@x += @movement_speed
			@angle = 0
			@flip_vertically = false
		end
		if args.inputs.keyboard.w
			@y += @movement_speed
			@angle = 90
			@flip_vertically = false
		end
		if args.inputs.keyboard.a
			@x -= @movement_speed
			@angle = 180
			@flip_vertically = true
		end
		if args.inputs.keyboard.s
			@y -= @movement_speed
			@angle = 270
			@flip_vertically = false
		end
	end

	def attack(enemy, args)
    # if args.inputs.keyboard.key_down.space
		  fire_ball = @fire_balls.pop()
      # if fire_ball
      #   args.outputs.sprites << fire_ball.cast(@x, @y, @angle) 
      #   args.state.fire_ball = fire_ball
      # end
      args.state.fire_balls << fire_ball.cast(x: @x, y: @y, angle: @angle, e_x: enemy.x, e_y: enemy.y) if fire_ball
    # end
	end
end