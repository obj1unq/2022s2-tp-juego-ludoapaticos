import wollok.game.*
import wolly.*
import proyectiles.*


object nivel1 {

	method nueva() {
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
		keyboard.enter().onPressDo({ game.say(wolly, "¡A cazar monstruos!")})
		keyboard.space().onPressDo({ wolly.disparar(calabaza)})
	}

	method terminarJuego()

}

class Nivel1 inherits NivelBase {


	override method escenario() {
		super()
		game.height(15)
		game.width(15)
		game.ground("ground.png")
	}


	override method teclas() {
		super()
		keyboard.c().onPressDo({ game.addVisual(calabaza.nuevo())})
		keyboard.r().onPressDo({ wolly.rotarSentidoAntihorario()})
		keyboard.f().onPressDo({ wolly.rotarSentidoHorario()})
	}

	override method terminarJuego() {
		game.onCollideDo(wolly, { monstruo => monstruo.matarA(wolly)})
	}

}

//	override method configuracion() {
//		const config = new ConfigDemo1()
//		config.teclas()
//		config.gameOver()
//	}
//}


class Config { // clase abstracta
	method teclas() {
		keyboard.enter().onPressDo({game.say(wolly, "¡A cazar monstruos!")})
		keyboard.space().onPressDo({wolly.disparar(calabaza)})
	}
	method gameOver()
}


}

