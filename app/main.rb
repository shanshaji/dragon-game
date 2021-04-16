require 'app/game.rb'
require 'app/engine/user_interface.rb'
require 'app/entity/dragon.rb'
require 'app/entity/enemy.rb'

$gtk.reset
def tick(args)
  args.state.random ||= 1_000_000_000
  user_interface args
  Dragon.new(args).dragon
  # enemy args
end


# def tick(args)
#   if args.tick_count == 1
#     $game = Game.new
#   end
#   $game&.perform_tick(args)
# end

