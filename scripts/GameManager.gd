extends Node

var curr_scene
var viewport_node

''' Scene management '''
''' Day/night cycle '''
''' Game state management '''

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count() - 1)
	if (curr_scene.name == "Root"):
		viewport_node = curr_scene.get_node("%Viewport")
		
	curr_scene = ResourceLoader.load("res://Scenes/testscene.tscn").instance()
	viewport_node.add_child(curr_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_scene(path):
	curr_scene.queue_free()
	var scene = ResourceLoader.load(path).instance()
	viewport_node.add_child(scene)
