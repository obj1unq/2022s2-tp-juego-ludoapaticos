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
	}

	method anterior() {
		index -= 1
		nivel = niveles.get(index)
	}

	method iniciar() {
		nivel.nuevo().activar()
	}
	method configurar(_nivel) {
		pausa.nivel(_nivel)
		handlerOnTicks.nivel(_nivel)
		handlerVisuales.nivel(_nivel)
		wolly.nivel(_nivel)
	}

	method start() {
		self.iniciar()
		handlerJuego.iniciar()
	}

}

