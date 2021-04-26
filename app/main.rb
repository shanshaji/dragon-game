require 'app/constants/constants.rb'
require 'app/functions/user_interface.rb'
require 'app/entity/game.rb'


def tick(args)
  user_interface(args)
  args.state.game_type ||= :pvp 
  if args.inputs.keyboard.key_down.enter
  	$game ||= Game.new(args.state.game_type )
  end
  $game&.perform_tick(args)
end
$gtk.reset


# $args.serialize

# $gtk.notify! ‘message’

# def tick_instructions args, text, y = 715
#   return if args.state.key_event_occurred
#   if args.inputs.mouse.click ||
#      args.inputs.keyboard.directional_vector ||
#      args.inputs.keyboard.key_down.enter ||
#      args.inputs.keyboard.key_down.escape
#     args.state.key_event_occurred = true
#   end

#   args.outputs.debug << [0, y - 50, 1280, 60].solid
#   args.outputs.debug << [640, y, text, 1, 1, 255, 255, 255].label
#   args.outputs.debug << [640, y - 25, "(click to dismiss instructions)" , -2, 1, 255, 255, 255].label
# end


# if args.state.box_collision_one && args.state.box_collision_two
#     if args.state.box_collision_one.intersect_rect? args.state.box_collision_two
#       args.outputs.labels << small_label(args, x, 4, 'The boxes intersect.')
#     else
#       args.outputs.labels << small_label(args, x, 4, 'The boxes do not intersect.')
#     end
#   else
#     args.outputs.labels << small_label(args, x, 4, '--')
#   end