class_name ScenePool

const METHOD_IS_READY = "pool_is_ready"
const METHOD_POOL_ACTIVATE = "pool_activate"


var _scene_list: Array[Node3D]
var _container: Node3D
var _packed_scene: PackedScene
var _name_prefix: String


func _init(num: int, scn: PackedScene, cont: Node3D, prefix: String):
	_container = cont
	_name_prefix = prefix
	_packed_scene = scn
	
	for i in range(num):
		add_new_scene()


func add_new_scene():
	var scene = _packed_scene.instantiate()
	scene.hide()
	
	if !scene.has_method(METHOD_IS_READY) or !scene.has_method(METHOD_POOL_ACTIVATE):
		push_error("%s: Missing a pool method" % scene.name)
		return
	
	if _name_prefix:
		scene.name = "%s_%d" % [_name_prefix, _scene_list.size()]
	
	_container.add_child(scene)
	_scene_list.append(scene)
	
	return scene


func activate_next_scene(pos: Vector3):
	for i in range(_scene_list.size()):
		var scene_from_list = _scene_list[i]
		if scene_from_list.pool_is_ready():
			scene_from_list.pool_activate(pos)
			return
	
	var new_scene: Node3D = add_new_scene()
	if new_scene: new_scene.pool_activate(pos)












