import wollok.game.*
import wolly.*
import extras.*
import monstruos.*
import handlers.*

class Pocion {

	const personaje = wolly
	const position = randomizer.position()

	method image()

	method fuerza() = [ 1, 2, 3 ].anyOne()

	method position() = position

	method causarEfecto() 

	method desaparecer() {
		handlerPociones.remover(self)
		
	}
	
	method hacerSonido(){
		sonidoBeberPocion.nuevo().sonar()
	}

	// por polimorfismo
	method daniarA() {
		self.causarEfecto()
	}

	method darPaso() {
	}

	method serImpactadoPor(arma) {
		arma.continuarDisparo()
	}

}

class PocionSalud inherits Pocion {

	override method image() {
		return "pocionVida.png"
	}

	override method causarEfecto() {
		self.desaparecer()
		personaje.recuperarVida(self.fuerza())
		self.hacerSonido()
	}

}

class PocionVeneno inherits Pocion {

	override method image() {
		return "pocionVeneno.png"
	}

	override method causarEfecto() {
		self.desaparecer()
		personaje.recibirDanio(self.fuerza())
	}

}

class Cofre inherits Pocion {

	override method image() = "cofreDanio.png"

	override method fuerza() = 300

	override method causarEfecto() {
		self.desaparecer()
		self.hacerSonido()
		game.addVisual(fuego)
		game.allVisuals().forEach({ elemento => elemento.serImpactadoPor(self)})
		game.schedule(300, { game.removeVisual(fuego)})
	}
	
	method continuarDisparo(){

	}
	
	
	override method hacerSonido(){
		sonidoCofre.nuevo().sonar()
	}
	method finEventoDelDisparo(){
	
	}

}

object fuego {

	method image() = "fuego.png"

	method position() = game.origin()

	// por polimorfismo
	method daniarA() {
	}

	method darPaso() {
	}

	method serImpactadoPor(arma) {
		arma.continuarDisparo()
	}

}

//factories
object pocionSalud {

	method nuevo() {
		return new PocionSalud()
	}

}

object pocionVeneno {

	method nuevo() {
		return new PocionVeneno()
	}

}

object cofre {

	method nuevo() {
		return new Cofre()
	}

}

