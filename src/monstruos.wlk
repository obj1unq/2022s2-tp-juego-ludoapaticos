import wollok.game.*
import wolly.*
import direcciones.*
import proyectiles.*
import niveles.*

class Monstruo {

	var property vida
	var property position
	var property image
	const enemigo = wolly

	method matarA() {
		enemigo.morir()
	}

	method serImpactadoPor(arma) {
		vida -= arma.fuerza() 
		if (vida <= 0) {
			self.morir()
		}
	}

	method serDaniado() {
		vida -= self.elementoEnColision().fuerza() // ver como se le llama en los poderes. hacer polimorfismo en personaje y otros monstruos
		if (vida <= 0) {
			self.morir()
		}
	}

	method morir() {
		enemigo.sumarPuntos(self)
		game.removeVisual(self)
	}

	method elementoEnColision() {
		return game.uniqueCollider(self)
	}

	method fuerza() {
		return 0
	}

	method puntosQueOtorga()
	method darPaso()

}


class Esqueleto inherits Monstruo(vida = 30, position = limite.inferior(), image = "esqueleto.jpg") {

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
	
	  override method puntosQueOtorga() = 300
}

class Fantasma inherits Monstruo(vida = 20, position = limite.superior(), image = "Fantasma_izquierda.jpg") {

	const direcciones = [ norte, este, sur, oeste ]

	override method darPaso() {
		position = direcciones.anyOne().avanzar(position, 1)
	}

	
	override method puntosQueOtorga() = 200

}

class Zombie inherits Monstruo(vida = 10, position = limite.lateralDer(), image = "Zombie_izquierda.png") {


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
