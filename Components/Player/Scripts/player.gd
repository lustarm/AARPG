class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var move_speed : float = 100.0

var state = State.IDLE_DOWN

enum State {
    IDLE_UP,
    IDLE_DOWN,
    IDLE_SIDE,
    WALK_UP,
    WALK_DOWN,
    WALK_SIDE
}

# @onready shorthand for 
# var animation_player
# func _read() -> void:
#	animation_player = $AnimationPlayer

# $NodePath
# Shorthand for get_node("NodePath")

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $PlayerSprite02

# Called every frame. 'delta' is the elapsed time since the previous frame.
# update()
func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * move_speed

	set_state()
	update_animation()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction() -> bool:
	return true

func set_state() -> void:
	# moving
	if velocity.x > 0: 
		state = State.WALK_SIDE
		cardinal_direction = Vector2.RIGHT
		sprite.flip_h = false
	elif velocity.x < 0:
		state = State.WALK_SIDE
		cardinal_direction = Vector2.LEFT
		# flip sprite
		sprite.flip_h = true
	elif velocity.y < 0:
		state = State.WALK_UP
		cardinal_direction = Vector2.UP
	elif velocity.y > 0:
		state = State.WALK_DOWN
		cardinal_direction = Vector2.DOWN

	# not moving
	elif !velocity:
		match cardinal_direction:
			Vector2.UP:
				state = State.IDLE_UP
			Vector2.DOWN:
				state = State.IDLE_DOWN
			Vector2.RIGHT:
				state = State.IDLE_SIDE
			Vector2.LEFT:
				state = State.IDLE_SIDE


func update_animation() -> void:
	animation_player.play( get_animation_string() )

func get_animation_string() -> String:
	print(state)
	match state:
		State.IDLE_DOWN:
			return "Idle_Down"
		State.IDLE_UP:
			return "Idle_Up"
		State.IDLE_SIDE:
			return "Idle_Side"
		State.WALK_DOWN:
			return "Walk_Down"
		State.WALK_UP:
			return "Walk_Up"
		State.WALK_SIDE:
			return "Walk_Side"
		_:
			return "Idle_Down"
