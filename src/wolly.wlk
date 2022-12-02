import wollok.game.*
import direcciones.*
import monstruos.*
import proyectiles.*
import extras.*
import pociones.*
import consola.*
import niveles.*
import handlers.*

object wolly {

	var property position = game.center()
	var property image = "wolly.png"
	var property puntos = 0
	var property ultimoSentidoDeDireccionVisto = norte
	var property proyectilActual = calabaza
	var property nivel
	var vida = 5

	method vida() = vida

	method disparar() {
		const proyectiles = proyectilActual.nuevo()
		proyectiles.forEach({ proyectil => proyectil.serDisparadoPor(self)})
	}

	method cuandoColisiona() {
		game.onCollideDo(self, { objeto => objeto.daniarA()})
	}

	

//	method morir() = game.stop()

	method morir() {
		handlerJuego.fin()
		game.schedule(5000, {game.stop()})
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
		if (puntos > 1000){
			game.schedule(700, {nivel.pasarNivel()})
		}
	}

	method recibirDanio(danio) {
		if (vida <= danio) {
			vida = 0
			self.morir()
		} else {
			vida -= danio
			self.efectoRecibirGolpe()
		}
	}
	
	method efectoRecibirGolpe(){
		game.onTick(100, "wolly segunda imagen", { image = "wolly2.png"})
		game.onTick(200, "wolly primera imagen", { image = "wolly.png"})
		game.schedule(500, { game.removeTickEvent("wolly segunda imagen")})
		game.schedule(500, { game.removeTickEvent("wolly primera imagen")})
		game.schedule(600, { image = "wolly.png"})
	}

	method recuperarVida(cantidad) {
		if ((vida + cantidad) <= 5) {
			vida += cantidad
		} else {
			vida = 5
		}
	}

	// por polimorfismo
	method darPaso() {
	// no hace nada
	}

	method daniarA() {
	// no hace nada
	}

	method causarEfecto() {
	// no hace nada
	}

	method serImpactadoPor(arma) {
	}

}

