extends CharacterBody2D

@onready var pscene_health_bar = preload("res://game/scenes/healthbar/healthbar.tscn")
@onready var pscene_combat_text = preload("res://game/scenes/combat_text/combat_text.tscn")

@onready var player_sprite = $Sprite2D

@onready var laser = $Laser

var health_bar
var combat_text
var hp = 100
var hp_min = 0
var hp_max = 100
var speed_max = 600
var acceleration_speed = 600
var deceleration_speed = 1600
var rotation_speed = 400

func take_damage(val: int, type: int):
	self.hp = clamp(self.hp - val, 0, self.hp_max)
	health_bar.update_percent(self.hp)
	combat_text = pscene_combat_text.instantiate()
	get_tree().get_root().add_child(combat_text)
	combat_text.init(self.position + Vector2(0, -120), str(val), type)
	if self.hp <= 0:
		health_bar.queue_free()
		self.queue_free()

func gain_health(number: int):
	hp = clamp(hp + number, hp_min, hp_max)
	health_bar.update_percent(self.hp)

func accelerate_forward(delta):
	velocity = (velocity + self.transform.x.normalized() * acceleration_speed * delta).limit_length(speed_max)

func decelerate(delta: float):
	if velocity.length() <= 2:
		velocity = Vector2.ZERO
	else:
		velocity += (Vector2.ZERO - velocity).normalized() * deceleration_speed * delta

func rotate_towards_vector(vec: Vector2, delta: float):
	var dir = vec - self.position
	var ang_to = self.transform.x.angle_to(dir)
	var new_rot = sign(ang_to) * min(rotation_speed * delta, abs(ang_to))
	self.rotate(new_rot)

func _ready():
	health_bar = pscene_health_bar.instantiate()
	get_tree().get_root().add_child.call_deferred(health_bar)
	health_bar.global_position = self.position + Vector2(0,-90)

func _process(delta):
	self.move_and_slide()
	health_bar.global_position = self.position + Vector2(0,-90)
