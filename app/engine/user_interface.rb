require 'app/engine/star.rb'

def user_interface(args)
  ticks = args.state.tick_count
  seconds = (ticks / 60).round(0)
  args.state.seconds ||= seconds
  args.state.seconds = seconds if ticks % 3 == 0
  render_title(args)
  render_game_data(args)
  render_time_passed(args)
  render_stars(args)
  if ticks % 255 < 127
    a = ticks % 255
    render_game_instructions(args, a)
  else
    a = 255 - ticks % 255
    render_game_instructions(args, a)
  end
end

def render_game_instructions(args, a)
  args.outputs.labels << [x: 640, y: 655, text: 'Press WASD to Move', size_enum: 0, alignment_enum: 1, r: 255, g: 255, b: 255, a: a]
  args.outputs.labels << [x: 640, y: 625, text: 'Press Space to Shoot', size_enum: 0, alignment_enum: 1, r: 255, g: 255, b: 255, a: a]
end

def render_stars(args)
  if args.state.tick_count == 1
    args.state.stars = @star_count.map { |i| Star.new args.grid }
  end
  args.state.stars.each(&:move)
  args.outputs.sprites << args.state.stars
  args.outputs.sprites << { x: 0, y: 0, w: 1280, h: 720, path: 'mygame/sprites/shan/ground_2.png'}
end

def render_title(args)
  args.outputs.borders << { x: 540, y: 668, w: 200, h: 45, r: 0, g: 0, b: 200, a: 255 }
  args.outputs.labels << { x: 640, y: 700, text: 'The Dragon Game', size_enum: -1, alignment_enum: 1, r: 0, g: 0, b: 0,
                           a: 150 }
  args.outputs.labels << { x: 642, y: 698, text: 'The Dragon Game', size_enum: -1, alignment_enum: 1, r: 0, g: 200,
                           b: 25 }
end

def render_game_data(args)
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
  args.state.lives = 0 if args.state.lives < 0 || !args.state.lives

  if args.state.lives == 1

    args.outputs.labels << {x: 640, y: 590, text: 'Game over', size_enum: 0, alignment_enum: 1}
    args.state.dragon_x = nil
    args.state.dragon_y = nil
    args.state.lives = nil if args.state.ticks_since_nil + 120 < args.state.tick_count
  end
  args.outputs.static_sprites << { x: 60, y: 697.5, w: 10, h: 10, path: 'mygame/sprites/circle/green.png', angle: 90 } if args.state.lives > 1
  args.outputs.static_sprites << { x: 75, y: 697.5, w: 10, h: 10, path: 'mygame/sprites/circle/green.png', angle: 90 } if args.state.lives > 2
  args.outputs.static_sprites << { x: 90, y: 697.5, w: 10, h: 10, path: 'mygame/sprites/circle/green.png', angle: 90 } if args.state.lives > 3
end

def render_time_passed(args)
  args.outputs.labels << { x: 770, y: 720, text: 'Time Elapsed:', size_enum: 8, alignment_enum: 0, r: 200, g: 0o50,
                           b: 100, a: 125 }
  args.outputs.labels << { x: 1000, y: 720, text: args.state.seconds, size_enum: 10, alignment_enum: 0, r: 200, g: 0o50,
                           b: 100, a: 125 }
end