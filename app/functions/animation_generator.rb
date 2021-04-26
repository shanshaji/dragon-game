def animation_generator(start_looping_at: 0, number_of_sprites: 5, number_of_frames_to_show_each_sprite: 4, does_sprite_loop: true)
	sprite_index = start_looping_at.frame_index number_of_sprites,
                                            number_of_frames_to_show_each_sprite,
                                            does_sprite_loop
  file_name = path.split(".")[0]
  file_name[-1] = sprite_index.to_s
	"#{file_name}.png"
end