extends KinematicBody2D

export(int) var maxMoveSpeed = 800
export(int) var maxFallSpeed = 1500
export(int) var friction = 0.4

var velocity = Vector2();
var acceleration = Vector2();

const GRAVITY = 98
const ACCEL = 1500
const JUMP_VEL = -1500
const UP = Vector2(0, -1)

func _ready():
	pass

func _physics_process(delta):
	acceleration.y = GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		acceleration.x = ACCEL
	elif Input.is_action_pressed("ui_left"):
		acceleration.x = -ACCEL
	else:
		acceleration.x = 0
		
	if $GroundDetection.is_colliding():
		if Input.is_action_pressed("ui_up"):
			velocity.y = JUMP_VEL
	
	velocity += acceleration
	
	if acceleration.x == 0:
		velocity.x *= friction

	velocity.x = clamp(velocity.x, -maxMoveSpeed, maxMoveSpeed)
	velocity.y = clamp(velocity.y, -maxFallSpeed, maxFallSpeed)
	
	if velocity.length() < 0.2:
		velocity = Vector2()

	velocity = move_and_slide(velocity, UP)
	animate()
	
	
func animate():
	if velocity.y > 0 && !$GroundDetection.is_colliding():
		$Sprite.play("fall")
	elif velocity.y < 0 && !$GroundDetection.is_colliding():
		$Sprite.play("jump")
	elif velocity.x > 0:
		$Sprite.play("run")
	elif velocity.x < 0:
		$Sprite.play("run")
	elif velocity.x == 0:
		$Sprite.play("idle") 
		
	$Sprite.flip_h = velocity.x < 0
	