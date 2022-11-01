import wollok.game.*
import direcciones.*
import monstruos.*
import proyectiles.*

object wolly {

	var property position = game.center()
	var property image = "wolly.png" 
	var property puntos = 0
	var property ultimaDireccionVista = norte
	var property proyectilActual

	method rotarSentidoHorario() {
		self.ultimaDireccionVista(ultimaDireccionVista.anterior())
	}

	method rotarSentidoAntihorario() {
		self.ultimaDireccionVista(ultimaDireccionVista.siguiente())
	}

	method disparar(tipoDeProyectil) { // un proyectil puede ser la calabaza
		self.sacar(tipoDeProyectil)
		self.cargarProyectil()
		proyectilActual.serDisparadoPor(self)
	}

	method sacar(tipoDeProyectil) {
		self.agregar(tipoDeProyectil)
	}

	method cargarProyectil() {
		proyectilActual = game.uniqueCollider(self)
	}

	method agregar(unaCosa) {
		self.validarAgregar()
		const cosa = unaCosa.nuevo()
		cosa.position(position)
		game.addVisual(cosa)
	}

	method hayMonstruo() {
		game.onCollideDo(self, { monstruo => monstruo.matarA()})
	}

	method distanciaDeDisparoDe(_peso) {
		return 6 / _peso
	}

	method morir() = game.stop()

	method validarAgregar() {
		if (not game.colliders(self).isEmpty()) {
			self.error("Hay algo sobre mí que no me deja accionar.")
		}
	}

	method moverse(direccion) {
		if (self.puedeMover(direccion)) {
			position = direccion.avanzar(position, 1)
		}
	}

	method puedeMover(direccion) {
		return direccion.avanzar(position, 1).y() <= limite.superior().y() and direccion.avanzar(position, 1).y() >= limite.inferior().y() and direccion.avanzar(position, 1).x() >= limite.lateralIzq().x() and direccion.avanzar(position, 1).x() <= limite.lateralDer().x()
	}

	method sumarPuntos(monstruo) {
		puntos += monstruo.puntosQueOtorga()
	}

	// por polimorfismo
	method darPaso() {
	// no hace nada
	}

}

// ############################################################################################
// Objeto controlador
//method tirarAgua() { // 
//	todos.forEach({aspersor => aspersor.tirarAgua()})
//}
// definición en Class
//method tirarAgua() {
//	
//	(-1..1).forEach( { x =>
//		 (-1..1).forEach ( {y =>
//		 	 self.tirarAgua(x,y)
//		})
//	})
//}
//
//method tirarAgua(dx,dy) {
//	const positionARegar = game.at( position.x() + dx, position.y() + dy)
//	game.getObjectsIn(positionARegar).forEach( { posibleCultivo => posibleCultivo.regar() })
//}
