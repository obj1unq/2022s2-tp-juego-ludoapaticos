import wollok.game.*
import wolly.*

class Monstruo {

	var property vida
	var property position
	var property image
	const enemigo = wolly

	method matarA() {
		enemigo.morir()
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
	
	method darPaso()

}

class Esqueleto inherits Monstruo(vida = 100, position = tablero.bordeInferior(), image = "esqueleto.jpg") {

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

}

class Fantasma inherits Monstruo(vida = 100, position = tablero.bordeSuperior(), image = "Fantasma_izquierda.jpg") {

	const direcciones = [ norte, este, sur, oeste ]

	override method darPaso() {
		position = direcciones.anyOne().avanzar(position, 1)
	}


}

class Zombie inherits Monstruo(vida = 10, position = tablero.bordeDerecha(), image = "Zombie_izquierda.png") {

	override method darPaso() {
		position = oeste.avanzar(position, 1)
	}

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

object tablero{
	method bordeSuperior(){
		return game.at(0.randomUpTo(game.width()-1),game.height()-1)
	}
	method bordeInferior(){
		return game.at(0.randomUpTo(game.width()-1),0)
	}
	method bordeIzquierda(){
		return game.at(0,0.randomUpTo(game.height()-1))
	}
	method bordeDerecha(){
		return game.at(game.width()-1,0.randomUpTo(game.height()-1))
	}
}

