require 'app/entity/flame.rb'
class EnemyDragon < Game
  attr_sprite
  def initialize(x: 100, y: 100, w: 50, h: 50, path: "sprites/misc/dragon-0.png", movement_speed: 1)
    @x = x
    @y = y
    @w = w
    @h = h
    @path = path
    @angle = 0
    @movement_speed = movement_speed
    @angle = 0
    @flip_horizontally = true
  end

  def animate()
    fly
    move
    attack
  end

  def fly
    start_looping_at = 0
    number_of_sprites = 4
    number_of_frames_to_show_each_sprite = 4
    does_sprite_loop = true
    sprite_index = start_looping_at.frame_index number_of_sprites,
                                              number_of_frames_to_show_each_sprite,
                                              does_sprite_loop
    file_name = path.split(".")[0]
    file_name[-1] = sprite_index.to_s
    @path = "#{file_name}.png"
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

  def attack
    Flame.new(@x, @y, @angle)
  end
end