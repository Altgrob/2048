extends Area2D


@onready var tile_size := 32 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event) -> void:
	
	var dir = Input.get_vector("LEFT","RIGHT","UP", "DOWN")
	
	
	position.x += dir.x * tile_size
	position.y += dir.y * tile_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


