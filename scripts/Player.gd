extends KinematicBody2D

var direction
var state
var box

var idles = ["fwd_idle", "left_idle", "back_idle", "right_idle"]
var dirs = ["fwd", "left", "back", "right"]
onready var boxes = [$"0", $"1", $"2", $"3"]

var WALK_SPEED = 30
var velocity = Vector2()
var slide = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_direction(0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	
	if event.is_action_pressed("ui_down"):
		set_direction(0, 0)
	if event.is_action_pressed("ui_left"):
		set_direction(1, 0)
	if event.is_action_pressed("ui_up"):
		set_direction(2, 0)
	if event.is_action_pressed("ui_right"):
		set_direction(3, 0)
		
	if event.is_action_released("ui_down"):
		set_direction(0, 1)
	if event.is_action_released("ui_left"):
		set_direction(1, 1)
	if event.is_action_released("ui_up"):
		set_direction(2, 1)
	if event.is_action_released("ui_right"):
		set_direction(3, 1)
		
	if event.is_action_pressed("ui_accept"):
		check_interact()
		
func check_interact():
	if box.get_overlapping_areas():
		Dialogic.play_timeline(box.get_overlapping_areas()[0].name)
	
func set_direction(var dir, var s):
	direction = dir
	state = s
	
	box = boxes[direction]
	if state == 0:
		$AnimatedSprite.play(dirs[direction])
	else:
		$AnimatedSprite.play(idles[direction])
		
func _physics_process(delta):

	if state == 0:
		if direction == 1:
			velocity.x -= WALK_SPEED
		elif direction == 3:
			velocity.x += WALK_SPEED
		elif direction == 2:
			velocity.y -= WALK_SPEED
		elif direction == 0:
			velocity.y += WALK_SPEED
	else:
		velocity.x = 0
		velocity.y = 0

	slide = move_and_slide(velocity * delta)

	
