def fire_ball_move_logic
	Proc.new do |fire_ball|
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
end
