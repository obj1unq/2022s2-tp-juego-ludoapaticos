import wollok.game.*
import wolly.*
import direcciones.*


//factories
object calabaza {
	method nuevo() {
		return [ new Proyectil( imagen = "calabazaProyectil", direccion =  wolly.ultimoSentidoDeDireccionVisto(), fuerza = 10, velocidad = 200, id = "") ]
	}
}

class Manzana inherits Proyectil(imagen = "manzanita", direccion = wolly.ultimoSentidoDeDireccionVisto(), fuerza=15, velocidad=150){}

object manzanaDoble {
	method nuevo() = [ manzana.nuevo(), manzanaOpuesta.nuevo() ]
}

object manzana {
	method nuevo() = new Manzana(id = "comun")
}

object manzanaOpuesta {
	method nuevo() {
		const manzanaOp = manzana.nuevo()
		manzanaOp.id("opuesta")
		manzanaOp.direccion(manzanaOp.direccion().opuesto())
		return manzanaOp
	}
}

class Cuchillo inherits Proyectil(fuerza=20, velocidad=100){}

object cuchillos {
	method nuevo() {
		return [ new Cuchillo(imagen="cuchilloNorteG", direccion=norte, id="norte")
			   , new Cuchillo(imagen="cuchilloEsteG", direccion=este, id="este")
			   , new Cuchillo(imagen="cuchilloSurG", direccion=sur, id="sur")
			   , new Cuchillo(imagen="cuchilloOesteG", direccion=oeste, id="oeste") ]
	}
}

class Proyectil  {

	const  imagen
	var property lanzador = wolly
	var property position = lanzador.position()
	var property direccion
	var  distanciaPorRecorrer = 0
	const property alcance = 3
	const property fuerza 
	const property velocidad
	var property id 
	
	method distanciaPorRecorrer() = distanciaPorRecorrer
	
	method image() = imagen + ".png"

	method serDisparadoPor(personaje) {
		self.lanzador(personaje)
		self.visualDelMovimiento()
		self.eventoDelDisparo()
	}

	method eventoDelDisparo() {
		game.onTick(self.velocidad(), "movimientoDisparo" + id, {=> self.proyectar()})
	}

	method proyectar() {
		distanciaPorRecorrer += 1
		self.puedeImpactar()
	}
	
	method puedeImpactar(){
		if (not self.loQueHayAca().isEmpty()) {
			self.impactar()
		} else {
			self.continuarDisparo()
		}
	}
	
	method loQueHayAca() = game.colliders(self)
	
	method impactar() = game.colliders(self).forEach({ cosa => cosa.serImpactadoPor(self)})
		
	method continuarDisparo(){
		game.removeVisual(self)
		self.visualDelMovimiento()
		self.continuarMovimiento()
	}
		
	method visualDelMovimiento() {
		self.position(self.avanzarUno())
		game.addVisual(self)
	}
	
	method avanzarUno() = direccion.avanzar(position, 1)
	
	method continuarMovimiento() {
		if (self.limiteDelDisparo()) {
			self.finEventoDelDisparo()
		}
	}
	
	method limiteDelDisparo() = self.distanciaPorRecorrer() == alcance
	
	method finEventoDelDisparo() {
		game.removeTickEvent("movimientoDisparo" + id)
		game.removeVisual(self)		
	}

	// POR POLIMORFISMO
	method darPaso() {} // no hace nada
	method daniarA() {}
	method serImpactadoPor(arma) { arma.continuarDisparo() }
}

