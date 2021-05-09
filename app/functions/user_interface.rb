
def user_interface(args)
  ticks = args.state.tick_count
  seconds = (ticks / 60).round(0)
  args.state.seconds ||= seconds
  args.state.seconds = seconds if ticks % 3 == 0
  render_title(args)
  # render_time_passed(args)
  render_stars(args) if ticks == 0
  render_background(args)
  render_start_screen(args) unless $game
  if ticks % 255 < 127
    a = ticks % 255
    render_game_instructions(args, a)
  else
    a = 255 - ticks % 255
    render_game_instructions(args, a)
  end
end

def render_game_instructions(args, a)
  args.outputs.labels << [x: 140, y: 655, text: 'Press WASD to Move', size_enum: 0, alignment_enum: 1, r: 255, g: 255, b: 255, a: a]
  args.outputs.labels << [x: 140, y: 625, text: 'Press Space to Shoot', size_enum: 0, alignment_enum: 1, r: 255, g: 255, b: 255, a: a]
  args.outputs.labels << [x: 1110, y: 655, text: 'Press Direction Keys to Move', size_enum: 0, alignment_enum: 1, r: 255, g: 255, b: 255, a: a]
  args.outputs.labels << [x: 1110, y: 625, text: 'Press Enter to Shoot', size_enum: 0, alignment_enum: 1, r: 255, g: 255, b: 255, a: a]
end

def render_stars(args)
  args.state.stars = STAR_COUNT.map { |i| Star.new args.grid }
  args.outputs.static_sprites << args.state.stars
end

def render_background(args)
  args.outputs.background_color = [0, 0, 0]
  if args.state.tick_count == 0
    args.outputs.static_sprites << { x: 0, y: 0, w: 1280, h: 720, path: 'sprites/shan/ground_2.png'}
  end
end

def render_title(args)
  args.outputs.borders << { x: 540, y: 668, w: 200, h: 45, r: 0, g: 0, b: 200, a: 255 }
  args.outputs.labels << { x: 640, y: 700, text: 'The Dragon Game', size_enum: -1, alignment_enum: 1, r: 0, g: 0, b: 0,
                           a: 150 }
  args.outputs.labels << { x: 642, y: 698, text: 'The Dragon Game', size_enum: -1, alignment_enum: 1, r: 0, g: 200,
                           b: 25 }
end

def render_start_screen(args)
  # args.outputs.solids << { x: 550, y: 408, w: 200, h: 45, r: 34, g: 49, b: 63, a: 255 }
  args.outputs.labels << { x: 640, y: 436, text: 'Click to Start', size_enum: -1, alignment_enum: 1, r: 0, g: 0, b: 0,
                           a: 150 }
  args.outputs.labels << { x: 642, y: 438, text: 'Click to Start', size_enum: -1, alignment_enum: 1, r: 0, g: 200,
                           b: 25 }
  
end

def render_time_passed(args)
  args.outputs.labels << { x: 770, y: 720, text: 'Time Elapsed:', size_enum: 8, alignment_enum: 0, r: 200, g: 0o50,
                           b: 100, a: 125 }
  args.outputs.labels << { x: 1000, y: 720, text: args.state.seconds, size_enum: 10, alignment_enum: 0, r: 200, g: 0o50,
                           b: 100, a: 125 }
end