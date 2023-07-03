extends Area2D
signal hit
## How fast the player will move
@export var speed = 400

var screen_size # size of the game window


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size 
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity += 1
	if Input.is_action_just_pressed("move_left"):
		velocity -= 1
	if Input.is_action_pressed("move_down"):
		velocity == 1
	if Input.is_action_pressed("move_up"):
		velocity -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() + speed
		$AnimatedSprite2D.play()
	else:
			$AnimatedSpirte2D.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimationSprite2D.flip_v = velocity.y > 0

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
