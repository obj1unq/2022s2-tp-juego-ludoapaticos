import wollok.game.*
import wolly.*
import proyectiles.*
import direcciones.*
import extras.*
import handlers.*


class NivelBase { // clase abstracta


	method iniciar() {
		self.base()
		self.pausaJuego()
	}

	method base() {
		self.escenario()
		self.visuales()
		self.configuracion()
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

	method pausaJuego () {
		// Comandos de usuario
		keyboard.p().onPressDo({ pausa.switch() })
	}

	method pausar() {
		game.clear()
		self.pausaJuego()
	}

	method reanudar() {
		self.base()
	}

	method nacimientoMonstruos()

	method movimientoMonstruos()
}

class Nivel1 inherits NivelBase {
	const property nacimientoMonstruos = 2000
	const property movimientoMonstruos = 1000

	override method escenario() {
		super()
		game.height(15)
		game.width(15)
		game.ground("lava.png")
		pausa.nivel(self)
		handlerOnTicks.iniciar(nacimientoMonstruos, movimientoMonstruos)
	}

	override method teclas() {
		super()
		keyboard.c().onPressDo({ game.addVisual(calabaza.nuevo())})
	}

	override method terminarJuego() {
		game.onCollideDo(wolly, { monstruo => monstruo.matarA()})
	}

	override method nacimientoMonstruos() {
		return nacimientoMonstruos
	}

	override method movimientoMonstruos() {
		return movimientoMonstruos
	}	
}

class Nivel2 inherits Nivel1 {

	override method nacimientoMonstruos() {
		return super()/2
	}

	override method movimientoMonstruos() {
		return super()/2
	}	
}

class Nivel3 inherits Nivel2 {

	override method nacimientoMonstruos() {
		return super()/2
	}

	override method movimientoMonstruos() {
		return super()/2
	}	
}

// factories
object nivel1 {

	method nuevo() {
		return new Nivel1()
	}

}

object nivel2 {

	method nuevo() {
		return new Nivel2()
	}
}

object nivel3 {

	method nuevo() {
		return new Nivel3()
	}
}