# def tick args
#   args.outputs.labels  << [640, 500, 'Hello Shan!', 5, 1]
#   args.outputs.labels  << [640, 460, 'Go to docs/docs.html and read it!', 5, 1]
#   args.outputs.labels  << [640, 420, 'Join the Discord! http://discord.dragonruby.org', 5, 1]
#   args.outputs.sprites << [576, 280, 128, 101, 'dragonruby.png']
# end


$gtk.reset
def tick args

  if !args.state.sprite_x

    args.state.sprite_x = 100
    args.state.sprite_y = 80
    args.state.sprite_size = 100

    args.state.sprite_movement_speed = 1
    args.state.direction = 0
    args.state.dragon = 0
  end

  if args.inputs.keyboard.key_held.a || args.inputs.keyboard.key_held.w || args.inputs.keyboard.key_held.d || args.inputs.keyboard.key_held.s
    args.state.dragon += 0.1
  end

  if args.state.dragon >= 5
   	args.state.dragon = 0
  end
  args.outputs.sprites << [args.state.sprite_x,
  args.state.sprite_y, args.state.sprite_size,
  args.state.sprite_size, "sprites/misc/dragon-#{args.state.dragon.to_i}.png", args.state.direction]

   if args.inputs.keyboard.d
    args.state.sprite_x += args.state.sprite_movement_speed
    args.state.direction = 0
  end
  if args.inputs.keyboard.w
    args.state.sprite_y += args.state.sprite_movement_speed
    args.state.direction = 90
  end
  if args.inputs.keyboard.a
    args.state.sprite_x -= args.state.sprite_movement_speed
    args.state.direction = 360
  end
  if args.inputs.keyboard.s
    args.state.sprite_y -= args.state.sprite_movement_speed
    args.state.direction = 270
  end

  screen_bound_y = 600
  screen_bound_x = 800
  if  args.state.sprite_y <= 0
    args.state.sprite_y= screen_bound_y
  elsif  args.state.sprite_y >= screen_bound_y
    args.state.sprite_y = 1
  elsif  args.state.sprite_x <= 0
    args.state.sprite_x = screen_bound_x
  elsif  args.state.sprite_x >= screen_bound_x
    args.state.sprite_x = 1
  end

end