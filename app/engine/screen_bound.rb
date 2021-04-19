
def screen_bound(sprite)
	if sprite.y <= 0
		sprite.y = @screen_bound_y
	elsif  sprite.y >= @screen_bound_y
		sprite.y = 1
	elsif  sprite.x <= 0
		sprite.x = @screen_bound_x
	elsif  sprite.x >= @screen_bound_x
		sprite.x = 1
	end
end