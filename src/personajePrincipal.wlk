import wollok.game.*
import direcciones.*

object personajePrincipal { // ver nombre
	//atributos

	var vida = 100 //por setearle un valor cualquiera
	var puntos = 0
	var poderes = [] // ver si conviene hacer una lista o métodos distintos
	var position = game.center() //por setearle un valor cualquiera 
	//comportamiento
	
	method position() = position

	method image() = "pepita.png"
	
	method vida() = vida
	
	method mover(direccion){
		if (self.puedeMover(direccion)) {
			position = direccion.siguientes(position)
		}
	}
	
	method puedeMover(direccion){
		return (direccion == izquierda and self.position().x() != 0) or 
		(direccion == derecha and self.position().x() != game.height()-1) or
		(direccion == arriba and self.position().y() != game.width()-1) or
		(direccion == abajo and self.position().y() != 0)
	}
	
	method pegar(poder){ //lo hago para abrir el debate, si conviene modelarlo así o modelar distintos métodos para
	//cada tipo de golpe
		poder.serUsado()
	}
	
	method cambiarPoder(){
		
	}
	
}