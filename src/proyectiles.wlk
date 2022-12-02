import wollok.game.*
import wolly.*
import direcciones.*

class Calabaza {

	const property peso = 2
	const property image = "calabazaProyectil.png"
	var property lanzador = wolly
	var property position = lanzador.position()
	var property direccion = lanzador.ultimoSentidoDeDireccionVisto()
	const distancia = lanzador.distanciaDeDisparoDe(peso)
	const property fuerza = 10

	method serDisparadoPor(personaje) {
		self.lanzador(personaje)
		self.moverse(distancia)
		
	}

	method moverse(distanciaAMover) {
		if (distanciaAMover != 0) {
			self.position(direccion.avanzar(position, 1))
			if (self.hayParaImpactar()){	self.impactar()}
			else{
				self.moverse(distanciaAMover - 1)}
		} else {
			self.romperse()
		}
	}

	method lanzador(personaje) {
		lanzador = personaje
	}
	
	method hayParaImpactar(){
		return not game.colliders(self).isEmpty()
	}
	
	method impactar() {
		game.colliders(self).forEach({ cosa => cosa.serImpactadoPor(self)})

	}
	
	method romperse(){
		game.schedule(300, { game.removeVisual(self)})
	}

	// Polimorfismo
	method darPaso() {} // no hace nada
	method daniarA() {}
	method serImpactadoPor(arma) { arma.romperse() }
}

//factories
object calabaza {
	method nuevo() = new Calabaza()
}
