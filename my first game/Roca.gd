extends RigidBody2D

export (int) var Velocidad_min
export (int) var Velocidad_max
var tipo_roca = ["Grande", "Pequeño"]

func _ready():
	$AnimatedSprite.animation = tipo_roca[randi() % tipo_roca.size()]#Escojera un tamaño random de la roca
	
	if $AnimatedSprite.animation == "Grande":
		$CollisionShape2D.scale.x = 4
		$CollisionShape2D.scale.y = 4

func _on_visibilidad_screen_exited():
	queue_free() #Elimina la roca :P
