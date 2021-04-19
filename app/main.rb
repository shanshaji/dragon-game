require 'app/game.rb'
require 'app/engine/user_interface.rb'
require 'app/entity/dragon.rb'
require 'app/entity/enemy.rb'

# def tick(args)
#   args.state.random ||= 1_000_000_000
#   user_interface args
#   Dragon.new(args).dragon
#   # enemy args
# end


def tick(args)
  if args.tick_count == 1
    $game = Game.new
  end
  $game&.perform_tick(args)
end
$gtk.reset



# 		if flame.direction    == 0
#       flame.y     += flame.speed
#     elsif flame.direction == 90
#       flame.x     -= flame.speed
#     elsif flame.direction == 180
#       flame.y     -= flame.speed
#     elsif flame.direction == 270
#       flame.x     += flame.speed
#     end

#     if flame.y <= 0
#       flame.y     = @screen_bound_y - flame.size
#     elsif  flame.y >= @screen_bound_y - flame.size
#       flame.y     = 0
#     elsif  flame.x <= 0
#       flame.x     = @screen_bound_x - flame.size
#     elsif  flame.x >= @screen_bound_x - flame.size
#       flame.x     = 0
#     end
#     flame.distance += flame.speed





# $args.serialize

# $gtk.notify! ‘message’


# defaults
# render
# input calc