extends Area2D


@onready var raycast = $RayCast2D


@export var tile_size := 32 
@export var level: int = 1 : set = set_level, get = get_level

var is_moving: bool = false : set = set_is_moving, get = get_is_moving

######## ACCESSOR ########

func set_level(value: int) -> void:
	if level != value:
		level = value

func get_level() -> int:
	return level

func set_is_moving(value: bool) -> void:
	if is_moving != value:
		is_moving = value

func get_is_moving() -> bool:
	return is_moving
	
	
######## BASE ########

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)

func _input(event) -> void:
	var dir = Input.get_vector("LEFT","RIGHT","UP", "DOWN")
	var next_tile = Vector2(dir.x * tile_size, dir.y * tile_size)
	
	if get_is_moving() || dir == Vector2.ZERO  : return
	
	if is_next_tile_wall(next_tile): return
	set_is_moving(true)
	position.x += next_tile.x
	position.y += next_tile.y
	await get_tree().create_timer(0.5).timeout
	set_is_moving(false)
	
	
######## LOGIC ########

func is_next_tile_wall(dir: Vector2) -> bool:
	raycast.set_target_position(dir)
	raycast.force_raycast_update()
	return raycast.is_colliding()


######## SIGNALS ########

func _on_area_entered(area: Area2D) -> void:
	if get_level() == area.get_level():
		area.queue_free()
		set_level(get_level() + 1)
