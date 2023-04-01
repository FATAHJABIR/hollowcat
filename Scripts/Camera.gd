extends Camera2D

var world

# Called when the node enters the scene tree for the first time.
func _ready():
	world = $Viewports/ViewportContainer1/Viewport1/World
	set_camera_limits()
	
func set_camera_limits():
	var map_limits = world.get_used_rect()
	var map_cellsize = world.cell_size
	limit_left = map_limits.position.x * map_cellsize.x
	limit_right = map_limits.end.x * map_cellsize.x
	limit_top = map_limits.position.y * map_cellsize.y
	limit_bottom = map_limits.end.y * map_cellsize.y
