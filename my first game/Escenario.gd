extends Node
export (PackedScene) var Roca
var Score

func _ready():
	randomize()

func nuevo_juego():
	Score = 0 #Score que empieza a cero
	$Player.inicio($PosiciondeInicio.position) #Posicion de inico del Player
	$InicioTimer.start() #Iniciara el temporizador para cargar el juego

func game_over():
	$Score.stop() #Se apaga todos los temporizadores
	$Roca_timer.stop()
func _on_InicioTimer_timeout():
	$Roca_timer.start() #Inicia todos los temporizadores
	$Score.start()


func _on_Score_timeout():
	#Score += 1 #Cuenta los puntos
	pass

func _on_Roca_timer_timeout():
	$Camino/RocaPosicion.set_offset(randi()) #Seleccionar un lugar aleatorio
	
	#Seleccionar una direccion
	var R = Roca.instance()
	add_child(R)
	
	#Seleccionar una direccion
	var d = $Camino/RocaPosicion.rotation + PI /2
	R.position = $Camino/RocaPosicion.position
	d += rand_range(-PI /4, PI / 4)
	R.rotation = d
	R.set_linear_velocity(Vector2(rand_range(R.Velocidad_min, R.Velocidad_max), 0).rotated(d))
	
	
