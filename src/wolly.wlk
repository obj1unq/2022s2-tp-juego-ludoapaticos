import wollok.game.*
import direcciones.*
import monstruos.*
import proyectiles.*
import extras.*
import pociones.*

object wolly {

	var property position = game.center()
	var property image = "wolly.png" 
	var property puntos = 0
	var property ultimoSentidoDeDireccionVisto = norte
	var property proyectilActual
	var vida = 5

	method vida() = vida
	
	method disparar(tipoDeProyectil) { // un proyectil puede ser la calabaza
		proyectilActual = calabaza.nuevo()
		game.addVisual(proyectilActual)
		proyectilActual.serDisparadoPor(self)
	}

	method cuandoColisiona() {
		game.onCollideDo(self, { objeto => objeto.daniarA()})
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
			vida = 0
			self.morir()
		} else {
			vida -= danio
		}
	}
	
	method recuperarVida(cantidad){
		if((vida + cantidad) <=5){
			vida += cantidad
		} else {vida = 5}
	}

	// por polimorfismo
	method darPaso() {
	// no hace nada
	}
	
	method daniarA(){
		// no hace nada
	}
	
	method causarEfecto(){
		// no hace nada
	}
	
	method desaparecer(){
		
	}
}
