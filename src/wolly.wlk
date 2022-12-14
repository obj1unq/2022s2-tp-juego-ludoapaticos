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
	var property image    = "wolly.png"
	var property puntos   = 0
	var property nivel = null
	var property ultimoSentidoDeDireccionVisto = norte
	var property proyectilActual = null


	var vida = 5

	method vida() = vida
	

	method disparar() {
		const proyectiles = proyectilActual.nuevo()
		proyectiles.forEach({ proyectil => proyectil.serDisparadoPor(self)})
	}

	method cuandoColisiona() {
		game.onCollideDo(self, {objeto => objeto.daniarA()} )
	}

	


	method morir() {
		handlerJuego.fin()
		game.schedule(5000, {handlerJuego.parar()} )
	}

	method moverse(direccion) {
		if (self.puedeMover(direccion)) {
			position = direccion.avanzar(position, 1)
		}
	}

	method puedeMover(direccion) {
		return direccion.avanzar(position, 1).y() <= limite.superior().y()   and
			   direccion.avanzar(position, 1).y() >= limite.inferior().y()   and
			   direccion.avanzar(position, 1).x() >= limite.lateralIzq().x() and
			   direccion.avanzar(position, 1).x() <= limite.lateralDer().x()
	}

	method sumarPuntos(monstruo) {
		puntos += monstruo.puntosQueOtorga()
		nivel.pasarAlSiguienteNivelSiPuede()
	}

	method recibirDanio(danio) {
		vida = (vida - danio).max(0)
		self.morirSiDebe()
	}
	
	method efectoRecibirGolpe(){
		game.onTick(100, "wolly segunda imagen", {image = "wolly2.png"} )
		game.onTick(200, "wolly primera imagen", {image = "wolly.png"} )
		game.schedule(500, {game.removeTickEvent("wolly segunda imagen")} )
		game.schedule(500, {game.removeTickEvent("wolly primera imagen")} )
		game.schedule(600, {image = "wolly.png"} )
	}




	method serImpactadoPor(arma) {
		arma.continuarDisparo()
	}
	method recuperarVida(cantidad) { vida = (vida + cantidad).min(5) }
	
	method morirSiDebe() {
		if (self.debeMorir()) {
			self.morir()
		} else {self.efectoRecibirGolpe()}
	}
	
	method debeMorir() = vida == 0

	// Polimorfismo
	method darPaso()      {}
	method daniarA()      {} 
	method causarEfecto() {} 

}

