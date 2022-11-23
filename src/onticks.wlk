import wollok.game.*
import wolly.*
import monstruos.*
import proyectiles.*
import direcciones.*
import extras.*
import handlers.*


class OnTick {
	var property nombre
	var property valor = null
	var property bloque

	method aplicar() {
		game.onTick(valor, nombre, bloque.apply())
	}
}

object aparicionMonstruos {
	method nuevo(_valor) {
		return new OnTick( nombre="nacimiento Monstruos"
						 , valor=self.tiempoRandomCon(_valor)
						 , bloque={handleMonstruos.nuevo()})
	}
	method tiempoRandomCon(_valor) {
		return _valor.randomUpTo(_valor*3)
	}
}

object avanceMonstruos {
	method nuevo(_valor) {
		return new OnTick( nombre="avance de monstruos"
						 , valor=_valor
						 , bloque={handleMonstruos.monstruos().forEach({ monstruo => monstruo.darPaso()})})
	}
}