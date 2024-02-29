extends Control

@export_range(0, 10000) var health_value_healthy: int
@export var health_color_healthy: Color
@export_range(0, 10000) var health_value_caution: int
@export var health_color_caution: Color
@export_range(0, 10000) var health_value_critical: int
@export var health_color_critical: Color

@onready var hp_overlay = $TextureProgressBar_Top
@onready var hp_underlay = $TextureProgressBar_Bottom

var hp_percent: int = 100

func _ready():
	hp_underlay.value = 100
	hp_overlay.value = 100

func _process(_delta):
	if hp_underlay.value < hp_percent:
		hp_underlay.value = hp_percent

func update_percent(val: int):
	var percent = clamp(val, 0, 100)
	hp_percent = percent
	hp_overlay.value = percent

	if percent < hp_underlay.value:
		get_tree().create_tween().tween_property(hp_underlay, "value", percent, 0.5).set_trans(Tween.TRANS_LINEAR)

	if percent <= health_value_critical:
		hp_overlay.tint_progress = health_color_critical
	elif percent <= health_value_caution:
		hp_overlay.tint_progress = health_color_caution
	elif percent <= health_value_healthy:
		hp_overlay.tint_progress = health_color_healthy

func update_size(val: Vector2):
	hp_overlay.size = val
	hp_underlay.size = val

func update_position(val: Vector2):
	self.set_global_position(val, true)
