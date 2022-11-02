import wollok.game.*
import wolly.*
import proyectiles.*
import direcciones.*


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
	}


	method teclas() {
		// Comandos de movimientos de Wolly
		keyboard.left().onPressDo({ wolly.moverse(oeste) })
		keyboard.right().onPressDo({ wolly.moverse(este) })
		keyboard.up().onPressDo({ wolly.moverse(norte) })
		keyboard.down().onPressDo({ wolly.moverse(sur) })
		// Comandos de disparo de Wolly
		keyboard.space().onPressDo({ wolly.disparar(calabaza)})
		keyboard.w().onPressDo({ wolly.ultimaSentidoDeDireccionVisto(norte) })
		keyboard.a().onPressDo({ wolly.ultimaSentidoDeDireccionVisto(oeste) })
		keyboard.s().onPressDo({ wolly.ultimaSentidoDeDireccionVisto(sur) })
		keyboard.d().onPressDo({ wolly.ultimaSentidoDeDireccionVisto(este) })		
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
		game.ground("lava.png")
	}


	override method teclas() {
		super()
		keyboard.c().onPressDo({ game.addVisual(calabaza.nuevo())})
		keyboard.r().onPressDo({ wolly.rotarSentidoAntihorario()}) //TODO: hay que borrar estos 2 comandos de rotación
		keyboard.f().onPressDo({ wolly.rotarSentidoHorario()})
	}

	override method terminarJuego() {
		game.onCollideDo(wolly, { monstruo => monstruo.matarA(wolly)})
	}

}
