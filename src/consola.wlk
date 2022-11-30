import wollok.game.*
import wolly.*
import proyectiles.*
import direcciones.*
import extras.*
import handlers.*
import niveles.*

object consola {

	var nivel = nivel1
	var index = 0
	const niveles = [ nivel1, nivel2, nivel3 ]

	method nivel() = nivel

	method siguiente() {
		index += 1
		nivel = niveles.get(index)
		game.clear()
		self.iniciar()
	}

	method anterior() {
		index -= 1
		nivel = niveles.get(index)
	}

	method iniciar() {
		nivel.nuevo().activar()
	}

	method start() {
		self.iniciar()
		handlerJuego.iniciar()
	}

}

