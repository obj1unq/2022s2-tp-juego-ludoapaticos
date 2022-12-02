import wollok.game.*
import wolly.*
import direcciones.*

//factories
object calabaza {

	method nuevo() {
		return #{ new Proyectil( imagen = "calabazaProyectil", direccion =  wolly.ultimoSentidoDeDireccionVisto(), fuerza = 10, velocidad = 200) }
	}

}

object manzanaDoble {

	method nuevo() {
		return #{ manzana.nuevo(), manzanaOpuesta.nuevo() }
	}

}

object manzana {

	method nuevo() {
		return new Proyectil(imagen = "manzanita", direccion = wolly.ultimoSentidoDeDireccionVisto(), fuerza = 15, velocidad = 250)
	}

}

object manzanaOpuesta {

	method nuevo() {
		return new Proyectil(imagen = "manzanita", direccion = wolly.ultimoSentidoDeDireccionVisto().opuesto(), fuerza = 15, velocidad = 250)
	}

}

object cuchilloNorte {

	method nuevo() {
		return new Proyectil(imagen = "cuchilloNorteG", direccion = norte, fuerza = 20, velocidad = 350)
	}

}

object cullichoEste {

	method nuevo() {
		return new Proyectil(imagen = "cuchilloEsteG", direccion = este, fuerza = 20, velocidad = 350)
	}

}

object cullichoSur {

	method nuevo() {
		return new Proyectil(imagen = "cuchilloSurG", direccion = sur, fuerza = 20, velocidad = 350)
	}

}

object cullichoOeste {

	method nuevo() {
		return new Proyectil(imagen = "cuchilloOesteG", direccion = oeste, fuerza = 20, velocidad = 350)
	}

}

object cuchillos {

	method nuevo() {
		return #{ cuchilloNorte.nuevo(), cullichoEste.nuevo(), cullichoSur.nuevo(), cullichoOeste.nuevo() }
	}

}

class Proyectil  {

	const  imagen
	var property lanzador = wolly
	var property position = lanzador.position()
	const property direccion
	var  distanciaPorRecorrer = 0
	const property alcance = 3
	const property fuerza
	const property velocidad
	
	method distnaciaPorRecorrer() = distanciaPorRecorrer
	
	method image(){
		return imagen + ".png"
	}



	method serDisparadoPor(personaje) {
		self.lanzador(personaje)
		self.visualDelMovimiento()
		self.eventoDelDisparo()
	}

	method eventoDelDisparo() {
		game.onTick(self.velocidad(), "movimientoDisparo", {=> self.proyectar()})
	}

	method proyectar() {
		distanciaPorRecorrer += 1
		self.puedeImpactar()
		
	}
	
	method puedeImpactar(){
		if (not self.loQueHayAca().isEmpty()) { self.impactar()} else {self.continuarDisparo()}
	}
	
	method loQueHayAca(){
		return game.colliders(self)
	}
	
	method impactar() {
		game.colliders(self).forEach({ cosa => cosa.serImpactadoPor(self)})
		}
		
	method continuarDisparo(){
		game.removeVisual(self)
		self.visualDelMovimiento()
		self.continuarMovimiento()
	}
		
	method visualDelMovimiento() {
		self.position(self.avanzarUno())
		game.addVisual(self)
		
	}
	
	method avanzarUno(){
		return direccion.avanzar(position, 1)
		
	}
	
	method continuarMovimiento() {
		if (self.limiteDelDisparo()) {
			self.finEventoDelDisparo()
		}
	}
	
	method limiteDelDisparo() {
		return self.distnaciaPorRecorrer() == alcance
	}
	
	method finEventoDelDisparo() {
		game.removeVisual(self)
		game.removeTickEvent("movimientoDisparo")
	}
	


	// POR POLIMORFISMO
	method darPaso() {
	// no hace nada
	}
	

	method daniarA() {
	}

	method serImpactadoPor(arma) {
		self.loQueHayAca().forEach({cosa => game.removeVisual(cosa)})
		self.finEventoDelDisparo()
	}

}