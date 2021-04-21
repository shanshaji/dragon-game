require 'app/entity/fire_ball.rb'
class EnemyDragon < Game
  attr_sprite
  def initialize(x: 100, y: 100, w: 50, h: 50, path: "sprites/misc/dragon-0.png", movement_speed: 1)
    @x = x
    @y = y
    @w = w
    @h = h
    @path = path
    @angle = 0
    @movement_speed = movement_speed
    @flip_horizontally = true
  end

  def animate()
    fly
    move
  end

  def fly
    start_looping_at = 0
    number_of_sprites = 4
    number_of_frames_to_show_each_sprite = 4
    does_sprite_loop = true
    sprite_index = start_looping_at.frame_index number_of_sprites,
                                              number_of_frames_to_show_each_sprite,
                                              does_sprite_loop
    file_name = path.split(".")[0]
    file_name[-1] = sprite_index.to_s
    @path = "#{file_name}.png"
  end

  def move
    @x += @movement_speed
    if @x >= 780
      @angle = 0
      @movement_speed = -1
      @flip_vertically = false
    elsif @x <= 600
      @angle = 180
      @movement_speed  = 1
      @flip_vertically = true
    end
  end

  def attack(dragon, args)
    # if args.inputs.keyboard.key_down.space
    # fire_time = args.state.tick_count % 90
    # if fire_time == 7
    #   fire_ball = FireBall.new
    #   args.state.fire_balls << fire_ball.cast(x: @x, y: @y, angle: @angle, e_x: dragon.x, e_y: dragon.y)
    # end
      
      # if fire_ball
      #   args.outputs.sprites << fire_ball.cast(@x, @y, @angle) 
      #   args.state.fire_ball = fire_ball
      # end
      
    # end
  end
end