def dragon_info args, dragons
	args.outputs.labels << {
	  x:              0,
	  y:              680,
	  text:           "#{dragons[0].name.capitalize} Dragon",
	  r:              155,
	  g:              50,
	  b:              50,
	  a:              255
	}
	args.outputs.solids << {
	  x:    0,
	  y:    680,
	  w:  dragons[0].health,
	  h:  30,
	  r:    0,
	  g:  255,
	  b:    0,
	  a:  255
	}
	args.outputs.borders << {
	  x: 0,
	  y: 680,
	  w: 100,
	  h: 30,
	  r: 0,
	  g: 255,
	  b: 0,
	  a: 255
	}
	args.outputs.labels << {
	  x:              1170,
	  y:              680,
	  text:           "#{dragons[1].name.capitalize} Dragon",
	  r:              155,
	  g:              50,
	  b:              50,
	  a:              255
	}
	args.outputs.solids << {
	  x:    1180,
	  y:    680,
	  w:  dragons[1].health,
	  h:  30,
	  r:    0,
	  g:  255,
	  b:    0,
	  a:  255
	}
	args.outputs.borders << {
	  x: 1180,
	  y: 680,
	  w: 100,
	  h: 30,
	  r: 0,
	  g: 255,
	  b: 0,
	  a: 255
	}
end