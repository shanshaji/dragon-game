require 'app/functions/screen_bound.rb'
require 'app/entity/dragon.rb'
require 'app/functions/dragon_info.rb'
require 'app/entity/special_power.rb'

class Game

  def initialize(game_type)
    @game_type = game_type
    @player_1 = Dragon.new
    @player_2 = Dragon.new(name: "fire", r: 200,g: 247, b: 0, x: 1110, y: 500, keys: {forward: :right, up: :up, left: :left, down: :down, fire_key: :enter})
    @enemy_dragon = Dragon.new(type: :bot, flip_horizontally: true, x: 590, y: 180, w: 150, h: 150, path: "sprites/shan/dragon/Walk1.png", movement_speed: 1)
    # @players = [@player_1, @enemy_dragon, @player_2]
    @players = [@player_1, @player_2]
    @special_powers = []
  end

  def perform_tick(args)
  	setup(args)
  	ready_player @player_1, args
    ready_player @player_2, args
    # ready_player @enemy_dragon, args
  	render(args)
  end

  def setup(args)
    args.state.fire_balls ||= []
  	# args.state.cool_down_time ||= @enemy_dragon.cool_down_time
    # args.state.cool_down_time -= 1
    move_fire_balls(args.state.fire_balls)
    spawn_special(args)
  end


  def render(args)
  	args.outputs.background_color = [0, 0, 0]
  	dragon_info args, @players
  	args.outputs.primitives << [@players]
    args.outputs.primitives << [args.state.fire_balls]
    args.outputs.primitives << [@special_powers]
  end


  private

  def player_in_range?(player)
    (player.x.between?(@enemy_dragon.x - 100, @enemy_dragon.x + 100) || player.y.between?(@enemy_dragon.y - 100, @enemy_dragon.y + 100))
  end

  def spawn_special(args)
    random_x = args.grid.w.randomize:ratio
    random_y = args.grid.h.randomize:ratio
    if args.state.tick_count % 1000 == 0
      @special_powers.shift if @special_powers.length >= 2
      @special_powers << SpecialPower.new
    end
    @special_powers.each do |special_power|
      special_power.activate(@player_1, @player_2) if @player_1.picked_special_power? special_power
      special_power.activate(@player_2, @player_1) if @player_2.picked_special_power? special_power
    end
    @special_powers.delete_if { |special_power| special_power.active == false }
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