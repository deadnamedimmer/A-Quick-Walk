extends CharacterBody3D

@export var speed := 7.0
@export var jump_strength := 20.0
@export var gravity := 50.0

var _working_velocity := Vector3.ZERO

@onready var _spring_arm: SpringArm3D = $SpringArm3D
@onready var _model: MeshInstance3D = $CharModel

func _physics_process(delta):
	var move_direction := Vector3.ZERO
	
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.y = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	_working_velocity.x = move_direction.x * speed
	_working_velocity.z = move_direction.z * speed
	_working_velocity.y -= gravity * delta
	
	set_velocity(_working_velocity)
	move_and_slide()
	
	if get_velocity().length() > .2:
		var look_direction = Vector2(get_velocity().z, get_velocity().x)
		_model.rotation.y = look_direction.angle()

func _process(delta):
	_spring_arm.position = position


















