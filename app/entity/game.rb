require 'app/functions/screen_bound.rb'
require 'app/entity/dragon.rb'

class Game

  def initialize(game_type)
    @game_type = game_type
    @player_1 = Dragon.new
    @player_2 = Dragon.new(r: 0, x: 780, y: 380, movement_speed: 1, keys: {forward: :right, up: :up, left: :left, down: :down, fire_key: :enter})
    @enemy_dragon = Dragon.new(type: :bot, flip_horizontally: true, x: 680, y: 180, w: 150, h: 150, path: "sprites/shan/dragon/Walk1.png", movement_speed: 1)
    @players = [@player_1, @enemy_dragon, @player_2]
  end

  def perform_tick(args)
  	setup(args)
  	ready_player @player_1, args
    ready_player @player_2, args
    ready_player @enemy_dragon, args
  	render(args)
  end

  def setup(args)
    args.state.fire_balls ||= []
  	args.state.cool_down_time ||= @enemy_dragon.cool_down_time
    args.state.cool_down_time -= 1
    move_fire_balls(args.state.fire_balls)
  end


  def render(args)
  	args.outputs.background_color = [0, 0, 0]
  	args.outputs.primitives << args.gtk.current_framerate_primitives
  	args.outputs.primitives << [@players]
    args.outputs.primitives << [args.state.fire_balls]
  end


  private

  def player_in_range?(player)
  	flag = (player.x.between?(@enemy_dragon.x - 100, @enemy_dragon.x + 100) || player.y.between?(@enemy_dragon.y - 100, @enemy_dragon.y + 100))
  	$gtk.notify! "#{flag}  #{player.x} #{player.y} #{@enemy_dragon.x} #{@enemy_dragon.y}"
  	flag
  end

  def move_fire_balls(fire_balls)
  	unless fire_balls.empty?
		fire_balls.each(&:move)
		fire_balls.delete_if { |fire_ball| fire_ball.active == false }
  	end
  end

  def ready_player(player, args)
  	if player
      screen_bound(player)
  		player.animate(args)
	  	if player.type == :bot && args.state.cool_down_time <= 0
			 player.attack(@player_1, args) if player_in_range? @player_1
			 player.attack(@player_2, args) if player_in_range? @player_2
		  elsif player.type == :player
        if args.inputs.keyboard.key_down.send(player.keys[:fire_key])
          player.attack(@enemy_dragon, args)
        end
      end
  	end
  end
end