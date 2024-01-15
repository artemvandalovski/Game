extends CharacterBody2D


const JUMP_VELOCITY = -400.0

@onready var animation_player = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")

	if direction:
		punch(direction)

	move_and_slide()


func punch(direction):
	animation_player.play("punch_right" if direction == 1 else "punch_left")


func _arm_hit(body):
	if body.name == "enemy":
		body.hurt(1)
