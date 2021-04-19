require 'app/engine/user_interface.rb'
require 'app/engine/screen_bound.rb'
require 'app/entity/dragon.rb'
require 'app/entity/enemy.rb'

class Game
  attr_accessor :my_sprites

  def initialize
  	@screen_bound_x = 1280
    @screen_bound_y = 550
  	@dragon = Dragon.new()
    @my_sprites = []
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
  	screen_bound(@dragon)
  end

  def inputs(args)
  	@dragon.animate(args)
  end

  def calc(args)
  end

  def render(args)
  	@my_sprites << @dragon
  	args.outputs.sprites << @my_sprites
  end
end
