extends Node2D

@onready var anim = $AnimationPlayer
@onready var label = $Label

var speed: int = 10
var dir: Vector2 = Vector2.ZERO
var rng = RandomNumberGenerator.new()

var type = [
	"Normal",
	"Critical",
	"Crushing",
	"Glancing",
	"Miss",
	"Dodge",
	"Parry",
	"Block",
	"Absorb",
	"Resist",
	"Immune",
	"Deflect",
	"Reflect"
]

func _ready():
	pass

func _process(delta):
	self.global_position += dir * speed * delta

func init( pos: Vector2, val: String, t: int ):
	self.global_position = pos
	self.dir = Vector2( 0, -1 ) * speed
	label.scale = Vector2(3,3)
	if t == 0:
		label.text = val
	else:
		label.text = val + " " + type[t]
	anim.play( type[t] )

