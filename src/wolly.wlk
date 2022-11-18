import wollok.game.*
import direcciones.*
import monstruos.*
import proyectiles.*
import extras.*

object wolly {

	var property position = game.center()
	var property image = "wolly.png"
	var property puntos = 0
	var property ultimoSentidoDeDireccionVisto = norte
	var property proyectilActual
	var vida = 5

	method vida() = vida

	method disparar(tipoDeProyectil) { // un proyectil puede ser la calabaza
		self.agregar(tipoDeProyectil)
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
		game.onCollideDo(self, { monstruo => monstruo.daniarA()})
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

	method recibirDanio(danio) {
		if (vida <= danio) {
			self.morir()
			//visorVida.longitud(0)
		} else {
			vida -= danio
			//visorVida.perderVidas(danio)
		}
	}
	
	method recuperarVida(cantidad){
		if(vida + cantidad<=5){
			vida += cantidad
		} else {vida = 5}
	}
	
	method perderVida(cantidad){
		if (vida - cantidad >0){
			vida -= cantidad
		} else {self.morir()}
	}

	// por polimorfismo
	method darPaso() {
	// no hace nada
	}

}

