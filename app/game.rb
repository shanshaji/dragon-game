require 'app/engine/user_interface.rb'
require 'app/engine/screen_bound.rb'
require 'app/entity/dragon.rb'
require 'app/entity/enemy.rb'

class Game
  attr_accessor :my_sprites

  def initialize
  	@screen_bound_x = 1280
    @screen_bound_y = 550
    @star_count = 100
    @game_type = nil
    @player_1 = Dragon.new
    @player_2 = Dragon.new(x: 780, y: 380, w: 100, h: 100, path: "sprites/shan/dragon/Walk1.png", movement_speed: 1, keys: {forward: :right, up: :up, left: :left, down: :down, fire_key: :enter})
    @enemy_dragon = Dragon.new(type: :ai, flip_horizontally: true, x: 680, y: 180, w: 150, h: 150, path: "sprites/shan/dragon/Walk1.png", movement_speed: 1)
    @my_sprites = [@player_1, @enemy_dragon, @player_2]
  end

  def perform_tick(args)
  	setup(args)
  	inputs(args)
  	calc(args)
  	render(args)
  end

  def setup(args)
  	user_interface args
  	args.state.fire_balls ||= []
  	args.state.cool_down_time ||= @enemy_dragon.cool_down_time
  	@enemy_dragon.animate(args)
  	screen_bound(@enemy_dragon)
  	screen_bound(@player_1)
  	screen_bound(@player_2) if @player_2
  end

  def inputs(args)
  	@player_2.animate(args) if @player_2
  	@player_1.animate(args)
  	if args.inputs.keyboard.key_down.space
      @player_1.attack(@enemy_dragon, args)
      @my_sprites << [args.state.fire_balls]
    end
    if @player_2 && args.inputs.keyboard.key_down.send(@player_2.keys[:fire_key])
    	@player_2.attack(@player_1, args)
    	@my_sprites << [args.state.fire_balls]
    end
  end

  def calc(args)
  	delta_x = @player_1.x - @enemy_dragon.x
  	delta_y = @player_1.y - @enemy_dragon.y
  	args.state.delta_distance = delta_x + delta_y
  	args.state.cool_down_time -= 1
  	if args.state.delta_distance.abs < 100 && args.state.cool_down_time <= 0
  		@enemy_dragon.attack(@player_1, args)
  	end
  	move_fire_balls(args.state.fire_balls)
  end

  def move_fire_balls(fire_balls)
  	unless fire_balls.empty?
		fire_balls.each(&:move)
		fire_balls.delete_if { |fire_ball| fire_ball.active == false }
  	end
  end

  def render(args)
  	args.outputs.background_color = [0, 0, 0]
  	args.outputs.primitives << args.gtk.current_framerate_primitives
  	args.outputs.sprites << [@my_sprites]
  end
end