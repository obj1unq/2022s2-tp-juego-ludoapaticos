import wollok.game.*
import wolly.*
import proyectiles.*
import direcciones.*
import extras.*
import pausa.*


object nivel1 {

	method nuevo() {
		return new Nivel1()
	}

}

class NivelBase { // clase abstracta


	method base() {
		self.escenario()
		self.visuales()
		self.configuracion()
	}

	method iniciar() {
		self.base()
		self.pausa()
	}

	method escenario() {
		game.title("Endless Wollokween")
	}

	method visuales() {
		game.addVisual(wolly)
		game.addVisual(visorPuntaje)
	}

	method configuracion() {
		self.teclas()
		self.terminarJuego()
	}

	method teclas() {
		// Comandos de movimientos de Wolly
		keyboard.left().onPressDo({ wolly.moverse(oeste) })
		keyboard.right().onPressDo({ wolly.moverse(este) })
		keyboard.up().onPressDo({ wolly.moverse(norte) })
		keyboard.down().onPressDo({ wolly.moverse(sur) })
		// Comandos de disparo de Wolly
		keyboard.space().onPressDo({ wolly.disparar(calabaza)})
		keyboard.w().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(norte) })
		keyboard.a().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(oeste) })
		keyboard.s().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(sur) })
		keyboard.d().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(este) })		
		// Comandos de acción de Wolly
		keyboard.enter().onPressDo({ game.say(wolly, "¡A cazar monstruos!")})
	}

	method terminarJuego()

	method pausa () {
		// Comandos de usuario
		keyboard.p().onPressDo({ handlerOnTick.switch() })
	}

	method pausar() {
		game.clear()
		self.pausa()
	}

	method reanudar() {
		self.base()
	}
}

class Nivel1 inherits NivelBase {
	const property nacimientoMonstruos = 2000
	const property movimientoMonstruos = 1000

	override method escenario() {
		super()
		game.height(15)
		game.width(15)
		game.ground("lava.png")
		handlerOnTick.nivel(self)
		handlerOnTick.iniciar(nacimientoMonstruos, movimientoMonstruos)
	}

	override method teclas() {
		super()
		keyboard.c().onPressDo({ game.addVisual(calabaza.nuevo())})
	}

	override method terminarJuego() {
		game.onCollideDo(wolly, { monstruo => monstruo.matarA()})
	}

}
