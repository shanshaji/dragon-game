require "app/constants/special_powers.rb"
require 'app/entity/fire_ball.rb'
class SpecialPower
	attr_sprite
	attr_accessor :rect, :active
	def initialize
		@x = rand(1200)
		@y = rand(550)
		@w = 40
		@h = 40
		file_name = SPECIAL_POWERS.keys.sample
		@type = SPECIAL_POWERS[file_name]
		@path = "sprites/shan/special_powers/#{file_name}.png"
		@rect = [@x,@y,@w,@h]
		@active = true
	end


	def activate(player, target)
		@active = false
		case @type
		when :health
			player.health = 100
		when :speed_increase
			player.movement_speed += 1 unless player.movement_speed == 4
		when :speed_decrease
			target.movement_speed -= 1 unless target.movement_speed == 1
		when :damage_bonus
			5.times{ player.fire_balls.push(FireBall.new(path: 'sprites/shan/dragon/Fire_Attack-0.png', size: 40, power: 10, speed: 7))}
		when :rocket
			5.times{ player.fire_balls.push(FireBall.new(path: 'sprites/shan/special-fire-ball/FB-0.png', size: 30, number_of_sprites: 5, power: 15))}
		end
	end
end