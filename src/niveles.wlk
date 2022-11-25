import wollok.game.*
import wolly.*
import proyectiles.*
import direcciones.*
import extras.*

object nivel1 {

	method nuevo() {
		return new Nivel1()
	}

}

class NivelBase { // clase abstracta

	method iniciar() {
		self.escenario()
		self.visuales()
		self.configuracion()
	}

	method configuracion() {
		self.teclas()
		self.terminarJuego()
	}

	method escenario() {
		game.title("Endless Wollokween")
	}

	method visuales() {
		game.addVisual(wolly)
		game.addVisual(visorPuntaje)
		game.addVisual(visorVida)
	}

	method teclas() {
		// Comandos de movimientos de Wolly
		keyboard.left().onPressDo({ wolly.moverse(oeste)})
		keyboard.right().onPressDo({ wolly.moverse(este)})
		keyboard.up().onPressDo({ wolly.moverse(norte)})
		keyboard.down().onPressDo({ wolly.moverse(sur)})
			// Comandos de disparo de Wolly
		keyboard.space().onPressDo({ wolly.disparar(calabaza)})
		keyboard.w().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(norte)})
		keyboard.a().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(oeste)})
		keyboard.s().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(sur)})
		keyboard.d().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(este)})
			// Comandos de acción de Wolly
		keyboard.enter().onPressDo({ game.say(wolly, "¡A cazar monstruos!")})
	}

	method terminarJuego()

}

class Nivel1 inherits NivelBase {

	override method escenario() {
		super()
		game.height(15)
		game.width(15)
		game.boardGround("lava.png")
	}

	override method teclas() {
		super()
		keyboard.c().onPressDo({ game.addVisual(calabaza.nuevo())})
	}

	override method terminarJuego() {
		game.onCollideDo(wolly, { monstruo => monstruo.daniarA()})
	}

}

