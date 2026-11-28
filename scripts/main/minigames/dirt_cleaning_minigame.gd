extends Minigame
class_name DirtCleaningMinigame

@export var dirt_bg_full_alpha: float = 0.9
@export var dirt_bg_clean_alpha: float = 0.0

@export var dirt_color: Color = Color(0.0, 0.334, 0.0, 1.0)

@export var cursor_cleaning_radius: float = 30.0
@export var margin: float = 50.0 # For keeping points off the screen edge
@export var pixel_scale: int = 2

@onready var dirt_bg_texture_rect: TextureRect = %DirtLayerBG
@onready var texture_rect: TextureRect = %DirtLayer

var progress: float = 0.0 # 0 to 1.0
var dirt_image: Image
var dirt_texture: ImageTexture
var total_dirty_pixels: int = 0
var remaining_dirty_pixels: int = 0
var erased_color: Color
var is_cleaning: bool = false
var last_mouse_pos: Vector2

func _ready() -> void:
	texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	erased_color = Color(dirt_color.r, dirt_color.g, dirt_color.b, 0.0)
	_setup_dirt()

func _setup_dirt() -> void:
	progress = 0.0
	
	var screen_size := get_viewport_rect().size
	var img_w := int(screen_size.x / pixel_scale)
	var img_h := int(screen_size.y / pixel_scale)
	var scaled_margin := int(margin / pixel_scale)
	
	dirt_image = Image.create(img_w, img_h, false, Image.FORMAT_RGBA8)
	dirt_image.fill(erased_color)
	
	var dirty_rect := Rect2i(
		scaled_margin,
		scaled_margin,
		img_w - (scaled_margin * 2),
		img_h - (scaled_margin * 2)
	)
	dirt_image.fill_rect(dirty_rect, dirt_color)
	
	total_dirty_pixels = dirty_rect.size.x * dirty_rect.size.y
	remaining_dirty_pixels = total_dirty_pixels
	
	dirt_texture = ImageTexture.create_from_image(dirt_image)
	texture_rect.texture = dirt_texture

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_cleaning = true
			last_mouse_pos = event.position
			clean_line(last_mouse_pos, event.position)
		else:
			is_cleaning = false
	elif event is InputEventMouseMotion and is_cleaning:
		clean_line(last_mouse_pos, event.position)
		last_mouse_pos = event.position

func _process(_delta: float) -> void:
	if dirt_bg_texture_rect:
		dirt_bg_texture_rect.modulate.a = lerpf(dirt_bg_full_alpha, dirt_bg_clean_alpha, clampf(progress, 0.0, 1.0))
	if progress >= 0.999:
		completed.emit(true, rewards)

func clean_line(from: Vector2, to: Vector2) -> void:
	if remaining_dirty_pixels <= 0:
		return
	
	var dist := from.distance_to(to)
	var step_size := maxf(1.0, cursor_cleaning_radius * 0.25)
	var steps := maxi(1, int(ceil(dist / step_size)))
	
	var any_changed: bool = false
	for i in range(steps + 1):
		var t := float(i) / float(steps)
		var sample_pos := from.lerp(to, t)
		if _erase_circle_at(sample_pos):
			any_changed = true
	
	if any_changed:
		dirt_texture.update(dirt_image)
		progress = 1.0 - (float(remaining_dirty_pixels) / float(total_dirty_pixels))

func _erase_circle_at(screen_pos: Vector2) -> bool:
	
	var center := Vector2i(screen_pos / pixel_scale)
	var r := int(cursor_cleaning_radius / pixel_scale)
	var r_sq := r * r
	var changed := false
	
	var min_x := maxi(0, center.x - r)
	var max_x := mini(dirt_image.get_width() - 1, center.x + r)
	var min_y := maxi(0, center.y - r)
	var max_y := mini(dirt_image.get_height() - 1, center.y + r)
	
	for y in range(min_y, max_y + 1):
		for x in range(min_x, max_x + 1):
			var dx := x - center.x
			var dy := y - center.y
			if (dx * dx + dy * dy) <= r_sq:
				if dirt_image.get_pixel(x, y).a > 0.0:
					dirt_image.set_pixel(x, y, erased_color)
					remaining_dirty_pixels -= 1
					changed = true
	
	return changed
