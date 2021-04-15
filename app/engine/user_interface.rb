def user_interface(args)
  ticks = args.state.tick_count
  seconds = (ticks / 60).round(0)
  args.state.seconds = seconds unless args.state.seconds

  args.outputs.labels << { x: 770, y: 720, text: 'Time Elapsed:', size_enum: 8, alignment_enum: 0, r: 200, g: 0o50,
                           b: 100, a: 125 }
  args.state.seconds = seconds if ticks % 3 == 0
  args.outputs.labels << { x: 1000, y: 720, text: args.state.seconds, size_enum: 10, alignment_enum: 0, r: 200, g: 0o50,
                           b: 100, a: 125 }
  args.outputs.labels << { x: 640, y: 700, text: 'The Dragon Game', size_enum: -1, alignment_enum: 1, r: 0, g: 0, b: 0,
                           a: 150 }
  args.outputs.labels << { x: 642, y: 698, text: 'The Dragon Game', size_enum: -1, alignment_enum: 1, r: 0, g: 200,
                           b: 25 }
  args.outputs.labels << { x: 10, y: 710, text: 'Lives:', size_enum: -3, alignment_enum: 0, r: 155, g: 50,  b: 50 }

  args.outputs.labels << { x: 10, y: 690, text: 'Score:', size_enum: -3, alignment_enum: 0, r: 155, g: 50, b: 50 }
  if args.state.current_score
    args.outputs.labels << { x: 60, y: 690, text: args.state.current_score, size_enum: -3, alignment_enum: 0, r: 155,
                             g: 50, b: 50 }
  end
  args.outputs.labels << { x: 10, y: 670, text: 'Highscore:', size_enum: -3, alignment_enum: 0, r: 155, g: 50, b: 50 }
  if args.state.highscore
    args.outputs.labels << { x: 90, y: 670, text: args.state.highscore, size_enum: -3, alignment_enum: 0, r: 155, g: 50,
                             b: 50 }
  end
  args.outputs.lines << {x: 0, y: 600, x2: 1280, y2: 600, r: 0, g: 0, b: 0, a: 255}
  board_x = 540
  board_y = 668
  board_w = 200
  board_h = 45
  echo = 4
  args.outputs.borders << { x: board_x, y: board_y, w: board_w, h: board_h, r: 0, g: 0, b: 200, a: 255 }
  args.outputs.borders << { x: board_x - echo, y: board_y - echo, w: board_w + echo * 2, h: board_h + echo * 2, r: 200, g: 0, b: 0,
                            a: 255 }
  args.outputs.solids << { x: board_x - echo, y: board_y - echo, w: board_w + echo * 2, h: board_h + echo * 2, r: 35, g: 0, b: 50,
                           a: 255 }
  echo -= 5
  args.outputs.solids << { x: board_x - echo, y: board_y - echo, w: board_w + echo * 2, h: board_h + echo * 2, r: 25,
                           g: 100, b: 40 }
  args.state.lives = 0 if args.state.lives < 0 || !args.state.lives

  if args.state.lives == 1

    args.outputs.labels << {x: 640, y: 590, text: 'Game over', size_enum: 0, alignment_enum: 1}
    args.state.dragon_x = nil
    args.state.dragon_y = nil
    args.state.lives = nil if args.state.ticks_since_nil + 120 < args.state.tick_count
  end
  args.outputs.sprites << { x: 60, y: 697.5, w: 10, h: 10, path: 'mygame/sprites/circle/green.png', angle: 90 } if args.state.lives > 1
  args.outputs.sprites << { x: 75, y: 697.5, w: 10, h: 10, path: 'mygame/sprites/circle/green.png', angle: 90 } if args.state.lives > 2
  args.outputs.sprites << { x: 90, y: 697.5, w: 10, h: 10, path: 'mygame/sprites/circle/green.png', angle: 90 } if args.state.lives > 3
  if ticks % 255 < 127
    args.outputs.labels << [640, 655, 'Press WASD to Move', 0, 1, 0, 0, 0, ticks % 255]
    args.outputs.labels << [640, 625, 'Press Space to Shoot', 0, 1, 0, 0, 0, ticks % 255]
  else
    args.outputs.labels << [640, 655, 'Press WASD to Move', 0, 1, 0, 0, 0, 255 - ticks % 255]
    args.outputs.labels << [640, 625, 'Press Space to Shoot', 0, 1, 0, 0, 0, 255 - ticks % 255]
  end
end
