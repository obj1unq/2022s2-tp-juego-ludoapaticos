import wollok.game.*
import wolly.*
import proyectiles.*

object demo1 {
	method nueva() {
		return new Demo1()
	}
}

class Demo { // clase abstracta
	method iniciar() {
		self.escenario()
		self.visuales()
		self.configuracion()
	}

	method configuracion() // metodo abstracto

	method escenario() {
		game.title("Endless Wollokween")
	}

	method visuales() {
		game.addVisual(wolly)
	}
}

class Demo1 inherits Demo {
	override method escenario() {
		super()
		game.height(15)
		game.width(15)
		game.ground("ground.png")
	}

	override method configuracion() {
		const config = new ConfigDemo1()
		config.teclas()
		config.gameOver()
	}
}


class Config { // clase abstracta
	method teclas() {
		keyboard.enter().onPressDo({game.say(wolly, "¡A cazar monstruos!")})
		keyboard.space().onPressDo({wolly.disparar(calabaza)})
	}
	method gameOver()
}


class ConfigDemo1 inherits Config {
	override method teclas() {
		super()
		keyboard.c().onPressDo({game.addVisual(calabaza.nuevo())})
		keyboard.r().onPressDo({wolly.rotarSentidoAntihorario()})
		keyboard.f().onPressDo({wolly.rotarSentidoHorario()})
	}
	override method gameOver() {
		game.onCollideDo(wolly, {monstruo => monstruo.matarA(wolly)})
	}
}