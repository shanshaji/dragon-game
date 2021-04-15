def enemy(args)
  args.state.enemy_time ||= args.state.tick_count

  if args.state.circle_x && ((args.state.tick_count - args.state.enemy_time) / 60 > 3)
    unless args.state.e1_x
      args.state.e1_x = (args.state.tick_count * rand(args.state.random)) % args.state.screen_bound_x
      args.state.e1_y = (args.state.tick_count * rand(args.state.random)) % args.state.screen_bound_y
      args.state.e1_size = 75
      bound(args, args.state.e1_x, args.state.e1_y, args.state.e1_size)
      args.state.e1_x = args.state.x
      args.state.e1_y = args.state.y
    end
    if args.state.e1_x
      args.state.e1_direction = args.state.tick_count % 90
      args.outputs.sprites << [args.state.e1_x, args.state.e1_y, args.state.e1_size, args.state.e1_size,
                               'mygame/circle/black.png', args.state.e1_direction]
      collision(args, args.state.e1_x, args.state.circle_x, args.state.e1_y, args.state.circle_y, args.state.e1_size,
                args.state.sprite_size)
      if args.state.collisions == 1
        ouch args
        args.state.enemy_time = args.state.tick_count
        args.state.e1_x = nil
        args.state.e1_y = nil
        args.state.kills += 1
        score args
      end
    end
    args.state.bullets.each do |e|
      next unless e.exists && args.state.e1_x

      collision(args, args.state.e1_x, e.x, args.state.e1_y, e.y, args.state.e1_size, e.size)
      next unless args.state.collisions == 1

      args.state.kills += 1
      score args
      args.state.enemy_time = args.state.tick_count
      args.state.e1_x = nil
      args.state.e1_y = nil
      e.y = nil
      e.x = nil
      e.exists = nil
    end
    args
  end
end
