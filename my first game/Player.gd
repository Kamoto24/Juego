extends Area2D

export (int) var velocidad #Creo una variable llamada Velocidad
var Movimiento = Vector2()  # la posicion del personaje = vector2
var limite
signal Golpe

func _ready():
	#hide() #Ocultar el personaje
	limite = get_viewport_rect().size
func _process(delta):
	Movimiento = Vector2() #Reiniciar el valor
	if Input.is_action_pressed("ui_right"): #Cuando presione a la derecha
		Movimiento.x +=1 #Se desliza en esa direccion
	if Input.is_action_pressed("ui_left"): #Izquierda
		Movimiento.x -=1
	if Input.is_action_pressed("ui_down"): #Abajo
		Movimiento.y += 1
	if Input.is_action_pressed("ui_up"): #Arriba
		Movimiento.y -= 1
	if Movimiento.length() > 0 : #Verificar si se esta moviendo
		Movimiento = Movimiento.normalized() * velocidad #Normaliza la velocidad
		
	position += Movimiento * delta #Actualizar los movimientos
	position.x = clamp(position.x, 0, limite.x)#Limitar las paredes x
	position.y = clamp(position.y, 0, limite.y)#Limitar las paredes y
	
	if Movimiento.x !=0: #Si el movimiento no es igual a cero
		$AnimatedSprite.animation = "Derecha" #Inserte la animacion a la derecha
		$AnimatedSprite.flip_h = Movimiento.x < 0 #Volviendo al movimiento normal girandolo horizontalmente
	elif Movimiento.y != 0:
		$AnimatedSprite.animation = "Frente"
		$AnimatedSprite.flip_v = Movimiento.y > 0
	
func _on_Player_body_entered(): #Cuando haya una colision con un cuerpo
	hide()
	emit_signal("Golpe")
	$CollisionShape2D.disabled = true #Desactiva la collision para que no reciba mas golpes
func inicio(pos):
	position = pos
	show() #Mostrar el player
	$CollisionShape2D.disabled = false #No es cierto que desactive la funcion cuando inicie el juego
