import wollok.game.*
import poderes.*

object personajePrincipal { // ver nombre
	// atributos

	var vida = 100 // por setearle un valor cualquiera
	var puntos = 0
	var poderes = [] // ver si conviene hacer una lista o métodos distintos
	var property position = game.center() // por setearle un valor cualquiera 
	
	// comportamiento
	
	method image() = "TomyPeque.png"

	method vida() = vida

	method pegar(poder_) { // lo hago para abrir el debate, si conviene modelarlo así o modelar distintos métodos para
	// cada tipo de golpe
		//poder.serUsado()
		const poder = poder_.nuevo()
		poder.position(position)
		poder.positionInicial(position)
		poder.disparar()
		game.onTick(500, "movimientoDisparo", { poder.movimientoProyectil()})
	}

	method cambiarPoder() {
	}

}

