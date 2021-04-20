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
    @dragon = Dragon.new()
    @my_sprites = [@dragon]
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