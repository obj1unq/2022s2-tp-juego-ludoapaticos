import wollok.game.*
import personajePrincipal.*

object calabaza {

	method nuevo() {
		return new Calabaza()
	}

}

class Calabaza { //elegir los poderes a crear

	const property danio = 10
	var property position = game.at(0, 0)
	const property image = "cacac.png"
	var property positionInicial = game.at(5,5)
	
	
	method serUsado(){
		self.position(personajePrincipal.position())
		self.positionInicial(personajePrincipal.position())
		self.disparar()
		game.onTick(500, "movimientoDisparo", { self.movimientoProyectil()})
	}
	method disparar() {
		position = game.at((position.x() + 1), position.y())
		game.addVisual(self)
	}

	method movimientoProyectil() {
		game.removeVisual(self)
		if (self.limiteDelDisparo()) {
			game.removeTickEvent("movimientoDisparo")
		} else {
			self.disparar()
		}
	}
	
	method limiteDelDisparo(){
		return position.x() == positionInicial.x() + 3
	}
	
	method darPaso(){
		//por polimorfismo
	}
}

