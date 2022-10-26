import wollok.game.*
import direcciones.*
import personajePrincipal.*

//class Monstruo { // superclase para uso de herencia, sé que no lo vimos aún pero seguro en las próximas clases sí
//
//	var vida
//	var position
//	var image
//
//	method atacar() {
//	}
//
//}
class Esqueleto {

	var vida = 100
	var property position = game.at(0.randomUpTo(game.width() - 1), 0)
	const direcciones = [ derecha, izquierda ]

	method image() = "esqueleto.jpg"

	method darPaso() {
		self.acercarseAWolly()
	}

	method acercarseAWolly() {
		if (wolly.position().x() < self.position().x()) {
			position = izquierda.siguientes(position)
		} else {
			position = derecha.siguientes(position)
		}
		if (wolly.position().y() < self.position().y()) {
			position = abajo.siguientes(position)
		} else {
			position = arriba.siguientes(position)
		}
	}

	method serDaniado() {
		vida -= self.elementoEnColision().fuerza() // ver como se le llama en los poderes. hacer polimorfismo en personaje y otros monstruos
		if (vida <= 0) {
			self.morir()
		}
	}

	method morir() {
		game.removeVisual(self)
	}

	method elementoEnColision() {
		return game.uniqueCollider(self)
	}

	method fuerza() {
		return 0
	}

}

class Fantasma {

	var vida = 50
	var property position = game.at(0.randomUpTo(game.width() - 1), (game.height() - 1))
	const direcciones = [ izquierda, derecha, arriba, abajo ]

	method image() = "Fantasma_izquierda.jpg"

	method darPaso() {
		position = direcciones.anyOne().siguientes(position)
	}

	method serDaniado() {
		vida -= self.elementoEnColision().fuerza() // ver como se le llama en los poderes. hacer polimorfismo en personaje y otros monstruos
		if (vida <= 0) {
			self.morir()
		}
	}

	method morir() {
		game.removeVisual(self)
	}

	method elementoEnColision() {
		return game.uniqueCollider(self)
	}

	method fuerza() {
		return 0
	}

}

class Zombie {

	var vida = 10
	var property position = game.at((game.width() - 1), (0.randomUpTo(game.height() - 1)))

	method image() = "Zombie_izquierda.png"

	method darPaso() {
		position = izquierda.siguientes(position)
	}

	method serDaniado() {
		vida -= self.elementoEnColision().fuerza() // ver como se le llama en los poderes. hacer polimorfismo en personaje y otros monstruos
		if (vida <= 0) {
			self.morir()
		}
	}

	method morir() {
		game.removeVisual(self)
	}

	method elementoEnColision() {
		return game.uniqueCollider(self)
	}

	method fuerza() {
		return 0
	}

}

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

