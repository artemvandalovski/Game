extends RigidBody2D

@export var lives = 3
@export var speed = 1200

enum STATES {
	ATTACK,
	HURT,
	IDLE,
	MOVE,
}

var current_state := STATES.MOVE
var direction : int = sign(448 - global_position.x)
var moving_force := Vector2(direction * speed, 0)
var knockback_force := Vector2(-direction * randi_range(500,600), -randi_range(400,600))
var knockback_timer = 0

func _physics_process(delta):
	if current_state == STATES.IDLE:
		knockback_timer += delta
	else:
		knockback_timer = 0
	
	
func _integrate_forces(state):
	if current_state == STATES.IDLE:
		if knockback_timer > 1:
			current_state = STATES.MOVE
	if current_state == STATES.MOVE:
		state.apply_central_force(moving_force)
	elif  current_state == STATES.HURT:
		state.apply_central_impulse(knockback_force)
		current_state = STATES.IDLE

func hurt(damage):
	current_state = STATES.HURT
	lives -= damage
	if !lives:
		queue_free()
