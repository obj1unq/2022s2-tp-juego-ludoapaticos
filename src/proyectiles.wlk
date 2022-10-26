import wollok.game.*
import wolly.*

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
	
	method serDisparadoPor(personaje) {
		self.lanzador(personaje)
		const distancia = lanzador.distanciaDeDisparoDe(peso)
		self.moverse(distancia)
		self.impactar()
	}

	method moverse(distancia) {
		self.position(direccion.avanzar(position, distancia))
	}

	method lanzador(personaje) {
		lanzador = personaje
	}

	method impactar() {
		game.colliders(self).forEach({cosa => cosa.serImpactadoPor(self)})
		game.schedule(300, {game.removeVisual(self)}) // Mejorar el comportamiento de remover el objeto si durante ese tiempo algo lo choca
	}
	
	// POR POLIMORFISMO
	method darPaso(){
		//no hace nada
	}
}
