class Flame 
	attr_sprite
	def initialize(x, y, angle)
		@x = x + 50
		@y = y + 3
		@angle = angle
		@w = 20
		@h = 20
		@path = 'mygame/sprites/misc/explosion-5.png'
	end
end