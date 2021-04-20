require 'app/engine/user_interface.rb'
require 'app/engine/screen_bound.rb'
require 'app/entity/dragon.rb'
require 'app/entity/enemy.rb'
require 'app/engine/star.rb'

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
  	@enemy_dragon.animate
  	screen_bound(@enemy_dragon)
  	screen_bound(@dragon)
  end

  def inputs(args)
  	@dragon.animate(args)
  	if args.inputs.keyboard.space
  		@my_sprites<< @dragon.attack
  	end
  end

  def calc(args)
  end

  def render(args)
  	args.outputs.background_color = [0, 0, 0]
  	args.outputs.primitives << args.gtk.current_framerate_primitives
  	args.outputs.sprites << [@my_sprites]
  end
end