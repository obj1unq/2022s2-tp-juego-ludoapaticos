import wollok.game.*
import wolly.*
import proyectiles.*
import direcciones.*
import extras.*
import onticks.*
import handlers.*
import consola.*

class NivelBase {

	method activar() {
		self.base()
		self.teclaPausa()
	}

	method base() {
		self.escenario()
		self.activarVisuales()
		self.configuracion()
	}

	method escenario() {
		game.title("Endless Wollokween")
		game.boardGround("lava.png")
	}

	method activarVisuales() {
		game.addVisual(wolly)
		game.addVisual(visorPuntaje)
		game.addVisual(visorVida)
		game.addVisual(visorNivel)
	}

	method desactivarVisuales() {
		game.removeVisual(wolly)
		game.removeVisual(visorPuntaje)
		game.removeVisual(visorVida)
		game.removeVisual(visorNivel)
	}

	method configuracion() {
		self.teclas()
		self.colisionesWolly()
	}

	method teclas() {
		// Comandos de movimientos de Wolly
		keyboard.left().onPressDo({ wolly.moverse(oeste)})
		keyboard.right().onPressDo({ wolly.moverse(este)})
		keyboard.up().onPressDo({ wolly.moverse(norte)})
		keyboard.down().onPressDo({ wolly.moverse(sur)})
			// Comandos de disparo de Wolly
		keyboard.space().onPressDo({ wolly.disparar()})
		keyboard.w().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(norte)})
		keyboard.a().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(oeste)})
		keyboard.s().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(sur)})
		keyboard.d().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(este)})
			// Comandos de acción de Wolly
		keyboard.enter().onPressDo({ game.say(wolly, "¡A cazar monstruos!")})
	}

	method colisionesWolly() {
	}

	method teclaPausa() {
		keyboard.p().onPressDo({ pausa.switch()})
	}

	method pausar() {
		game.clear()
		self.teclaPausa()
		handlerVisuales.activar()
	}

	method reanudar() {
		self.escenario()
		self.configuracion()
	}

	method reanudarAlMorir() {
		self.escenario()
	}

	method pasarNivel() {
		self.vaciarNivel()
		consola.siguiente()
		consola.iniciar()
	}

	method activarOnTicks()

	method vaciarNivel() {
		game.clear()
		handlerPociones.clear()
		handlerMonstruos.clear()
		wolly.puntos(0)
	}

}

class Nivel1 inherits NivelBase {

//	const nacimientoMonstruos = 2000
//	const movimientoMonstruos = 1000
//	const nacimientoPociones = 3000
//	const remocionPociones = 6000

	method nacimientoMonstruos() = 3000

	method movimientoMonstruos() = 2000

	method nacimientoPociones() = 3000

	method remocionPociones() = 11999
	
	method musicaEnFondo() = 1

	override method escenario() {
		super()
		game.height(15)
		game.width(15)
		consola.configurar(self)
		self.activarOnTicks()
	}

	override method colisionesWolly() {
		game.onCollideDo(wolly, { monstruo => monstruo.daniarA()})
	}

	override method activarOnTicks() {
		handlerOnTicks.nuevo(aparicionMonstruos, self.nacimientoMonstruos())
		handlerOnTicks.nuevo(avanceMonstruos, self.movimientoMonstruos())
		handlerOnTicks.nuevo(aparicionPociones, self.nacimientoPociones())
		handlerOnTicks.nuevo(desaparicionPociones, self.remocionPociones())
		handlerOnTicks.nuevo(musicaDeFondo, self.musicaEnFondo())
	}

}

class Nivel2 inherits Nivel1 {

	override method nacimientoMonstruos() {
		return super() / 2
	}

	override method movimientoMonstruos() {
		return super() / 2
	}


}

class Nivel3 inherits Nivel2 {

	override method nacimientoMonstruos() {
		return super() / 2
	}

	override method nacimientoPociones() {
		return super() / 2
	}

	override method pasarNivel() {
	// no hace nada, es el último nivel del juego.
	}

}

class PantallaInicio inherits NivelBase {

	override method escenario() {
		super()
		game.height(15)
		game.width(15)
	}

	method image() = "pantallaInicio.png"

	override method activarVisuales() {
		game.addVisualIn(self, game.origin())
	}

	override method teclas() {
		keyboard.enter().onPressDo({ self.pasarNivel()})
	}

	override method teclaPausa() {
	}

	override method activarOnTicks() {
	}

}

// factories
object nivel1 {

	method nuevo() {
		return new Nivel1()
	}

	method id() = "1"

}

object nivel2 {

	method nuevo() {
		return new Nivel2()
	}

	method id() = "2"

}

object nivel3 {

	method nuevo() {
		return new Nivel3()
	}

	method id() = "3"

}

object pantallaInicio {

	method nuevo() {
		return new PantallaInicio()
	}

	method id() = "0"

}

