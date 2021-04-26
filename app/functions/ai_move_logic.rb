def dragon_move_logic
	Proc.new do |dragon|
		dragon.x += dragon.movement_speed
		if dragon.x >= 780
			dragon.angle = 0
			dragon.movement_speed = -1
			dragon.flip_vertically = false
		elsif dragon.x <= 600
			dragon.angle = 180
			dragon.movement_speed  = 1
			dragon.flip_vertically = true
		end
	end
end