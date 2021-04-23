require 'app/entity/fire_ball.rb'
require 'app/engine/animation_generator.rb'
class EnemyDragon < Game
  attr_sprite
  attr_accessor :cool_down_time
  def initialize(x: 100, y: 100, w: 50, h: 50, path: "sprites/misc/dragon-0.png", movement_speed: 1, no_of_sprites: 4)
    @x = x
    @y = y
    @w = w
    @h = h
    @path = path
    @angle = 0
    @movement_speed = movement_speed
    @no_of_sprites = no_of_sprites
    @flip_horizontally = true
    @cool_down_time = 100
    @fire_ball_move_logic = Proc.new do |fire_ball|
        unless fire_ball.x == fire_ball.e_x
          fire_ball.x += 1 if fire_ball.x < fire_ball.e_x
          fire_ball.x -= 1 if fire_ball.x > fire_ball.e_x
        end

        unless fire_ball.y == fire_ball.e_y
          fire_ball.y += 1 if fire_ball.y < fire_ball.e_y
          fire_ball.y -= 1 if fire_ball.y > fire_ball.e_y
        end

        if ((fire_ball.x == fire_ball.e_x) && (fire_ball.y == fire_ball.e_y))
          fire_ball.x += 1 if x < fire_ball.e_x
          fire_ball.x -= 1 if x > fire_ball.e_x
          fire_ball.y -= 1 if y > fire_ball.e_y
          fire_ball.y += 1 if y < fire_ball.e_y
        end
      end
    @fire_balls =  Array.new(100) { FireBall.new(path: 'mygame/sprites/shan/dragon/Fire_Attack-0.png', size: 50, move_logic: @fire_ball_move_logic)}
  end

  def animate
    fly
    move
  end

  def fly
    @path = animation_generator(number_of_sprites: @no_of_sprites)
  end

  def move
    @x += @movement_speed
    if @x >= 780
      @angle = 0
      @movement_speed = -1
      @flip_vertically = false
    elsif @x <= 600
      @angle = 180
      @movement_speed  = 1
      @flip_vertically = true
    end
  end

  def attack(dragon, args)
    if (args.state.delta_distance > 0 && @angle == 180) || (args.state.delta_distance > 0 && @angle == 0)
      fire_ball = FireBall.new(path: 'mygame/sprites/shan/dragon/Fire_Attack-0.png', size: 50, move_logic: @fire_ball_move_logic)
      args.state.en_fire_ball = fire_ball
      args.state.fire_balls << fire_ball.cast(x: @x, y: @y, angle: @angle, e_x: dragon.x, e_y: dragon.y)
      args.state.cool_down_time = cool_down_time
    end
  end
end