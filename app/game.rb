require 'app/engine/user_interface.rb'
require 'app/engine/screen_bound.rb'
require 'app/entity/dragon.rb'
require 'app/entity/enemy.rb'
require 'app/engine/star.rb'
# require 'app/engine/fire_ball_physics.rb'

class Game
  attr_accessor :my_sprites

  def initialize
  	@screen_bound_x = 1280
    @screen_bound_y = 550
    @star_count = 100
    @dragon = Dragon.new
    # @enemy_dragon = Dragon.new(x: 300, y: 200, w: 150, h: 150, path: "sprites/shan/dragon/Walk1.png", movement_speed: 1)
    @enemy_dragon = EnemyDragon.new(x: 680, y: 180, w: 150, h: 150, path: "sprites/shan/dragon/Walk1.png", movement_speed: 1)
    @my_sprites = [@dragon, @enemy_dragon]
  end

  def perform_tick(args)
  	setup(args)
  	inputs(args)
  	calc(args)
  	render(args)
  end

  def setup(args)
  	user_interface args
  	args.state.dragon ||= @dragon
  	args.state.fire_balls ||= []
  	@enemy_dragon.animate
  	screen_bound(@enemy_dragon)
  	screen_bound(@dragon)
  end

  def inputs(args)
  	@dragon.animate(args)
  	if args.inputs.keyboard.key_down.space
  		@dragon.attack(@enemy_dragon, args)
  		@my_sprites << [args.state.fire_balls]

  	end
  end

  def calc(args)
  	delta_x = @dragon.x - @enemy_dragon.x
  	delta_y = @dragon.y - @enemy_dragon.y
  	args.state.delta_distance = delta_x + delta_y

  	if args.state.delta_distance.abs < 100
  		@enemy_dragon.attack(@dragon, args)
  		@my_sprites << [args.state.fire_balls]
  	end

  	unless args.state.fire_balls.empty?
  		# @my_sprites << args.state.fire_balls
  		args.state.fire_balls.each(&:move)
  		args.state.fire_balls.delete_if { |fire_ball| fire_ball.active == false }
  	end
  end

  def render(args)
  	args.outputs.background_color = [0, 0, 0]
  	args.outputs.primitives << args.gtk.current_framerate_primitives
  	args.outputs.sprites << [@my_sprites]
  end
end