extends CharacterBody2D

@export var speed: float = 600.0
@export var acceleration: float = 0.25
@export var friction: float = 0.2

const PADDLE_WIDTH := 120
const PADDLE_HEIGHT := 20

var input_dir: float = 0.0


func _ready() -> void:
	$Sprite2D.texture = _create_paddle_texture(PADDLE_WIDTH, PADDLE_HEIGHT)

	var rect := RectangleShape2D.new()
	rect.size = Vector2(PADDLE_WIDTH, PADDLE_HEIGHT)
	$CollisionShape2D.shape = rect

	var viewport_size := get_viewport_rect().size
	global_position = Vector2(viewport_size.x * 0.5, viewport_size.y - 60.0)


func _create_paddle_texture(width: int, height: int) -> ImageTexture:
	var image := Image.create(width, height, false, Image.FORMAT_RGBA8)
	for x in width:
		for y in height:
			var hue := float(x) / float(width)
			var color := Color.from_hsv(hue, 0.85, 1.0)
			if y < height * 0.25:
				color = color.lightened(0.15)
			elif y > height * 0.75:
				color = color.darkened(0.2)
			image.set_pixel(x, y, color)
	return ImageTexture.create_from_image(image)


func _physics_process(delta: float) -> void:
	# 1. Gather Input
	input_dir = Input.get_axis("paddle_left", "paddle_right")

	# 2. Apply Movement Matrix
	if input_dir != 0:
		velocity.x = move_toward(velocity.x, input_dir * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed * friction)

	move_and_slide()

	# 3. Viewport Boundary Clamp Logic
	var half_width = $CollisionShape2D.shape.get_rect().size.x / 2.0
	var screen_width = get_viewport_rect().size.x
	global_position.x = clamp(global_position.x, half_width, screen_width - half_width)
