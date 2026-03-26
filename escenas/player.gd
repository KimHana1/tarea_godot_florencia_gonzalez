extends Area2D
signal hit
@export var speed = 400
var screen_size

func _ready(): 
	screen_size= get_viewport_rect() .size
	
func _process(delta):
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("derecha"):
		velocity.x += 1
	if Input.is_action_pressed("izquierda"):
		velocity.x -= 1
	if Input.is_action_pressed("abajo"):
		velocity.y += 1
	if Input.is_action_pressed("arriba"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "caminar"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "arriba"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		hide()
func _on_body_entered_body(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
