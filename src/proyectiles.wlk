import wollok.game.*
import wolly.*
import direcciones.*

//factories
object calabaza {

	method nuevo() {
		return new Calabaza()
	}

}

class Calabaza {

	const property peso = 2
	const property image = "cacac.png"
	var property lanzador = wolly
	var property position = lanzador.position()
	var property direccion = lanzador.ultimaDireccionVista()
	const distancia = lanzador.distanciaDeDisparoDe(peso)
	const property fuerza = 10

	method serDisparadoPor(personaje) {
		self.lanzador(personaje)
		self.moverse(distancia)
		game.schedule(300, { game.removeVisual(self)})
	}

	method moverse(distanciaAMover) {
		if (distanciaAMover != 0) {
			self.position(direccion.avanzar(position, 1))
			self.impactar()
			self.moverse(distanciaAMover - 1)
		}
	}

	method lanzador(personaje) {
		lanzador = personaje
	}

	method impactar() {
		game.colliders(self).forEach({ cosa => cosa.serImpactadoPor(self)})
	}

	// POR POLIMORFISMO
	method darPaso() {
	// no hace nada
	}

	method matarA() {
	}

	method serImpactadoPor(arma) {
	}

}

