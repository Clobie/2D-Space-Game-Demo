extends Node2D

@onready var pscene_health_bar = preload("res://game/scenes/healthbar/healthbar.tscn")
@onready var pscene_combat_text = preload("res://game/scenes/combat_text/combat_text.tscn")

var health_bar
var combat_text

var health: int

func _ready():
	self.health = 100
	health_bar = pscene_health_bar.instantiate()
	self.add_child(health_bar)
	health_bar.position = Vector2(0,-90)

func _process(delta):
	if Input.is_action_pressed("d"):
		self.position = self.position + Vector2(3,0)
	if Input.is_action_pressed("a"):
		self.position = self.position + Vector2(-3,0)
	if Input.is_action_pressed("w"):
		self.position = self.position + Vector2(0,-3)
	if Input.is_action_pressed("s"):
		self.position = self.position + Vector2(0,3)

func take_damage(val: int, type: int):
	if type == 1:
		val = val * 1.5
	self.health -= val
	health_bar.update_percent(self.health)
	combat_text = pscene_combat_text.instantiate()
	get_tree().get_root().add_child(combat_text)
	combat_text.init(self.position + Vector2(0, -120), str(val), type)
