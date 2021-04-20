class Star
  attr_sprite

  def initialize grid
    @grid = grid
    @x = (rand @grid.w) * -1
    @y = (rand @grid.h) * -1
    @w    = 4
    @h    = 4
    @s    = 1 + (4.randomize :ratio)
    @path = "sprites/misc/tiny-star.png"
  end

  def move
    @x += @s
    @y += @s
    @x = (rand @grid.w) * -1 if @x > @grid.right
    @y = (rand @grid.h) * -1 if @y > @grid.top
  end
end