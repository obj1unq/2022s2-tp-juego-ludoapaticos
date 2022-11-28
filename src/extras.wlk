import monstruos.*
import wollok.game.*
import wolly.*
import pociones.*
import consola.*

class Visor {

	method image()

	method position()

	method textColor() {
		return "ff0000ff"
	}

	// por polimorfismo
	method daniarA() {
	}

	method darPaso() {
	}

	method serImpactadoPor(algo) {
	}

}

object visorPuntaje inherits Visor {

	override method image() = "visorPuntaje.png"

	override method position() {
		return game.at(0, game.height() - 1)
	}

	method text() {
		return "" + wolly.puntos()
	}

}

object visorVida inherits Visor {

	method longitud() = wolly.vida()

	override method image() = "vida" + self.longitud() + ".png"

	override method position() = game.at(game.width() - 4, game.height() - 1)

}

object visorNivel inherits Visor {
	
	override method image() = "" + consola.nivel() + ".png"
	
	override method position() = game.at(7, game.height() - 1)
}

object randomizer {

	method position() {
		return game.at((0 .. game.width() - 1 ).anyOne(), (0 .. game.height() - 1).anyOne())
	}

	method emptyPosition() {
		const position = self.position()
		if (game.getObjectsIn(position).isEmpty()) {
			return position
		} else {
			return self.emptyPosition()
		}
	}

}

object cartelFinal inherits Visor {
	
	override method image() = "fin.png"
	
	override method position() = game.center()
}

