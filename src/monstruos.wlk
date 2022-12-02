import wollok.game.*
import wolly.*
import direcciones.*
import proyectiles.*
import niveles.*
import handlers.*
import pociones.*
import extras.*

class Monstruo {
	var vida
	var property position
	var property image
	const enemigo = wolly

	method vida() = vida

	method daniarA() {
		enemigo.recibirDanio(self.poderDeDanio())
		self.morir()
	}

	method poderDeDanio() = 1

	method serImpactadoPor(arma) {
		vida -= arma.fuerza()
		if (vida <= 0) {
			self.morir()
		}
		arma.finEventoDelDisparo()
	}

	method morir() {
		handlerMonstruos.remover(self)
		enemigo.sumarPuntos(self)
		sonidoMuerteMonstruo.nuevo().sonar()
		
	}

	method elementoEnColision() {
		return game.uniqueCollider(self)
	}

	method fuerza() {
		return 0
	}

	method puntosQueOtorga()

	method darPaso()
	
	method causarEfecto(){
	//por polimorfismo, no hace nada
	}
}

class Esqueleto inherits Monstruo(vida = 30, position = limite.inferior(), image = "esqueletoParca.png") {

	override method darPaso() {
		self.acercarseAWolly()
	}

	method acercarseAWolly() {
		if (wolly.position().x() < self.position().x()) {
			position = oeste.avanzar(position, 1)
		} else {
			position = este.avanzar(position, 1)
		}
		if (wolly.position().y() < self.position().y()) {
			position = sur.avanzar(position, 1)
		} else {
			position = norte.avanzar(position, 1)
		}
	}

	override method serImpactadoPor(arma) {
		self.efectoGolpe()
		super(arma)
	}

	override method puntosQueOtorga() = 300

	override method poderDeDanio() = super() + 2

	method efectoGolpe() {
		game.onTick(100, "esqueleto segunda imagen", { image = "esqueletoParca2.png"})
		game.onTick(200, "esqueleto primera imagen", { image = "esqueletoParca.png"})
		game.schedule(500, { game.removeTickEvent("esqueleto segunda imagen")})
		game.schedule(500, { game.removeTickEvent("esqueleto primera imagen")})
		game.schedule(550, { image = "esqueletoParca.png"})
	}
}

class Fantasma inherits Monstruo(vida = 20, position = limite.superior(), image = "fantasmita.png") {

	const direcciones = [ norte, este, sur, oeste ]

	override method darPaso() {
		position = direcciones.anyOne().avanzar(position, 1)
	}

	override method serImpactadoPor(arma) {
		self.efectoGolpe()
		super(arma)
	}

	override method puntosQueOtorga() = 200

	override method poderDeDanio() = super() + 1

	method efectoGolpe() {
		game.onTick(100, "fantasmita segunda imagen", { image = "fantasmita2.png"})
		game.onTick(200, "fantasmita primera imagen", { image = "fantasmita.png"})
		game.schedule(500, { game.removeTickEvent("fantasmita segunda imagen")})
		game.schedule(500, { game.removeTickEvent("fantasmita primera imagen")})
		game.schedule(550, { image = "fantasmita.png"})
	}
}

class Zombie inherits Monstruo(vida = 10, position = limite.lateralDer(), image = "Zombie.png") {

	override method darPaso() {
		position = oeste.avanzar(position, 1)
	}

	override method puntosQueOtorga() = 100

}

// factories
object esqueleto {
	method nuevo() {
		return new Esqueleto()
	}
}

object fantasma {
	method nuevo() {
		return new Fantasma()
	}
}

object zombie {
	method nuevo() {
		return new Zombie()
	}
}

object limite {
	method superior() {
		return game.at(0.randomUpTo(game.width() - 1), game.height() - 1)
	}

	method inferior() {
		return game.at(0.randomUpTo(game.width() - 1), 0)
	}

	method lateralIzq() {
		return game.at(0, 0.randomUpTo(game.height() - 1))
	}

	method lateralDer() {
		return game.at(game.width() - 1, 0.randomUpTo(game.height() - 1))
	}
}

