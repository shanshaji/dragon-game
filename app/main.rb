require 'app/constants/constants.rb'
require 'app/functions/user_interface.rb'
require 'app/entity/game.rb'


def tick(args)
  user_interface(args)
  args.state.game_type ||= :pvp 
  args.state.dragon_lost ||= nil
  if args.inputs.mouse.click
  	$game ||= Game.new(args.state.game_type )
  	args.state.dragon_lost = nil
  end
  unless args.state.dragon_lost
  	$game&.perform_tick(args)
  else
  	args.outputs.labels << { x: 640, y: 536, text: "#{args.state.dragon_lost} Dragon Lost", size_enum: -1, alignment_enum: 1, r: 200, g: 0, b: 0,
                           a: 150 }
    args.state.fire_balls = nil
  	$game = nil
  end
  args.outputs.debug << args.gtk.framerate_diagnostics_primitives
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