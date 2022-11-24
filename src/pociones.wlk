import wollok.game.*
import wolly.*
import extras.*

class Pocion {
	const personaje = wolly
	const potencia = 1.randomUpTo(3)
	const position = randomizer.position()
	
	method image()
	
	method position()= position

	method causarEfecto(){
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
	
	method desaparecer(){
		game.removeVisual(self)
	}
}

class PocionSalud inherits Pocion{
	override method image(){
		return "pocionVida.png"
	}
	
	override method causarEfecto(){
		personaje.recuperarVida(potencia)
		super()
	}
}

class PocionVeneno inherits Pocion{
	
	override method image(){
		return "pocionVeneno.png"
	}
	override method causarEfecto(){
		personaje.recibirDanio(potencia)
		super()
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