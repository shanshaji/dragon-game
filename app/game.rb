require 'app/engine/user_interface.rb'
require 'app/entity/dragon.rb'
require 'app/entity/enemy.rb'

class Game
  attr_accessor :my_sprites
  def initialize
  	@dragon = Dragon.new
    @my_sprites = []
  end

  def perform_tick(args)
  	@dragon.fly(args)
    args.outputs.sprites << @dragon
  end
end
