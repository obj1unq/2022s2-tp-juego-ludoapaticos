import wollok.game.*
import poderes.*
import poderes.*

object wolly { // ver nombre
	// atributos

	var vida = 100 // por setearle un valor cualquiera
	var puntos = 0
	var poderes = [calabaza.nuevo()] // ver si conviene hacer una lista o métodos distintos
	var property position = game.center() // por setearle un valor cualquiera 
	var poder = 0
	// comportamiento
	
	method image() = "TomyPeque.png"

	method vida() = vida

	method pegar() { 
		self.poderActual().serUsado()

	}
	
	method poderActual(){
		return poderes.get(poder)
	}

	method cambiarPoder() {
		poder +=1
	}
	
	method darPaso(){
		
	}

}

