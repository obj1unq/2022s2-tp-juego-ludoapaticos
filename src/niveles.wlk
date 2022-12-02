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
		keyboard.left().onPressDo({ wolly.moverse(oeste) })
		keyboard.right().onPressDo({ wolly.moverse(este) })
		keyboard.up().onPressDo({ wolly.moverse(norte)   })
		keyboard.down().onPressDo({ wolly.moverse(sur)   })
		// Comandos de disparo de Wolly
		keyboard.space().onPressDo({ wolly.disparar() })
		keyboard.w().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(norte) })
		keyboard.a().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(oeste) })
		keyboard.s().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(sur)   })
		keyboard.d().onPressDo({ wolly.ultimoSentidoDeDireccionVisto(este)  })
		// Comandos de acción de Wolly
		keyboard.enter().onPressDo({ game.say(wolly, "¡A cazar monstruos!") })
	}


	method teclaPausa() {
		keyboard.p().onPressDo({ pausa.switch() })
	}

	method pausar() {
		handlerJuego.borrar()
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

	method vaciarNivel() {
		handlerJuego.borrar()
		handlerPociones.clear()
		handlerMonstruos.clear()
		wolly.puntos(0)
	}

	method pasarAlSiguienteNivelSiPuede() {
		if (self.hayPuntosSuficientesParaPasarDeNivel()){
			game.schedule(700, {self.pasarNivel()})
		}
	}

	method hayPuntosSuficientesParaPasarDeNivel() {
		return visorPuntaje.puntos() > self.puntosParaPasarDeNivel()
	}

	// Métodos abstractos
	method activarOnTicks()
	method puntosParaPasarDeNivel()

	// Polimorfismo
	method colisionesWolly() {
	}

}

class Nivel1 inherits NivelBase {
	method nacimientoMonstruos() = 3000
	method movimientoMonstruos() = 2000
	method nacimientoPociones()  = 3000
	method remocionPociones()    = 11999
	method musicaEnFondo() = 1
	override method puntosParaPasarDeNivel() = 1000
	

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
	override method puntosParaPasarDeNivel() = super()*1.5
	override method nacimientoMonstruos()    = super() / 2
	override method movimientoMonstruos()    = super() / 2

}

class Nivel3 inherits Nivel2 {
	override method puntosParaPasarDeNivel() = null
	override method nacimientoMonstruos()    = super() / 2
	override method movimientoMonstruos()    = super() / 2
	override method nacimientoPociones()     = super() / 2


  override method pasarNivel() {}
	// no hace nada, es el último nivel del juego.
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
		keyboard.enter().onPressDo({ self.pasarNivel() })
	}

	override method teclaPausa() {}
	override method activarOnTicks() {}
	override method puntosParaPasarDeNivel() {}
}

// factories
object nivel1 {
	method nuevo() = new Nivel1()
	method id()    = "1"
}

object nivel2 {
	method nuevo() = new Nivel2()
	method id()    = "2"
}

object nivel3 {
	method nuevo() = new Nivel3()
	method id()    = "3"
}

object pantallaInicio {
	method nuevo() = new PantallaInicio()
	method id()    = "0"
}

