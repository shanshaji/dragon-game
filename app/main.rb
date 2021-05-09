require "app/autoloader.rb"
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
  	args.outputs.labels << { x: 640, y: 536, text: "#{args.state.dragon_lost.capitalize} Lost", size_enum: -1, alignment_enum: 1, r: 200, g: 0, b: 0,
                           a: 150 }
    args.state.fire_balls = nil
  	$game = nil
  end
  # args.outputs.debug << args.gtk.framerate_diagnostics_primitives
end
$gtk.reset
