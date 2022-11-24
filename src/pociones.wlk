import wollok.game.*
import wolly.*
import extras.*
import monstruos.*



class Pocion {
	const personaje = wolly
	const position = randomizer.position()
	
	method image()
	
	method fuerza()= 1.randomUpTo(3)
	
	method position()= position

	method causarEfecto(){
		game.removeVisual(self)	
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
		// por polimorfismo
	method daniarA() {
		self.causarEfecto()
	}
	
	method darPaso(){
		
	}
	
	method serImpactadoPor(arma) {
	}
	
	
}

class PocionSalud inherits Pocion{
	override method image(){
		return "pocionVida.png"
	}
	
	override method causarEfecto(){
		super()
		personaje.recuperarVida(self.fuerza())
		
	}
}

class PocionVeneno inherits Pocion{
	
	override method image(){
		return "pocionVeneno.png"
	}
	override method causarEfecto(){
		super()
		personaje.recibirDanio(self.fuerza())
	}
}

class Cofre inherits Pocion {
	

	override method image()= "cofreDanio.png"
	
	override method fuerza()=300
	
	override method causarEfecto(){
		super()
		game.addVisual(fuego)
		game.allVisuals().forEach({ elemento => elemento.serImpactadoPor(self)})
		game.schedule(500, {game.removeVisual(fuego)})
	}
}

object fuego {
	method image()= "fuego.png"
	method position()= game.origin()
	
		// por polimorfismo
	method daniarA() {
	
	}
	
	method desaparecer(){
		
	}
	
	
	method darPaso(){
		
	}
	
	method serImpactadoPor(arma) {
	}
}

//factories

object pocionSalud {
	method nuevo(){
		return new PocionSalud()
	}
}

object pocionVeneno {
	method nuevo(){
		return new PocionVeneno()
	}
}

object cofre {
	method nuevo(){
		return new Cofre()
	}
}