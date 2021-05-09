module BotLogic
		FIRE_BALL = Proc.new do |fire_ball|

			# fire_ball.x = (fire_ball.x).send(fire_ball.x_projection, 1) if fire_ball.x_projection
			# fire_ball.y = (fire_ball.y).send(fire_ball.y_projection, 1) if fire_ball.y_projection
			
			unless fire_ball.x == fire_ball.e_x
				fire_ball.x += 1 if fire_ball.x < fire_ball.e_x
				fire_ball.x -= 1 if fire_ball.x > fire_ball.e_x
			end

			unless fire_ball.y == fire_ball.e_y
				fire_ball.y += 1 if fire_ball.y < fire_ball.e_y
				fire_ball.y -= 1 if fire_ball.y > fire_ball.e_y
			end

			# if ((fire_ball.x == fire_ball.e_x) && (fire_ball.y == fire_ball.e_y))
			# 	$gtk.notify! `equal (${fire_ball.x},${fire_ball.y}) - (${fire_ball.e_x},${fire_ball.e_y}) - (${fire_ball.t_x}, ${fire_ball.t_y})`
			# 	fire_ball.x += 1 if fire_ball.t_x <= fire_ball.e_x
			# 	fire_ball.x -= 1 if fire_ball.t_x > fire_ball.e_x
			# 	fire_ball.y -= 1 if fire_ball.t_y > fire_ball.e_y
			# 	fire_ball.y += 1 if fire_ball.t_y <= fire_ball.e_y
			# end
		end
end
