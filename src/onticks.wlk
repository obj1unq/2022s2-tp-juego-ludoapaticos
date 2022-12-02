import wollok.game.*
import wolly.*
import monstruos.*
import proyectiles.*
import direcciones.*
import extras.*
import handlers.*
import pociones.*

// Reificación (programación) o cosificación; técnica de
// programación orientada a objetos que consiste en tener
// un tipo de datos para una abstracción 
class OnTick {
	var property nombre
	var property valor = null
	var property bloque

	method aplicar() { game.onTick(valor, nombre, bloque) }
}


// factories
object aparicionMonstruos {
	method nuevo(_valor) {
		return new OnTick( nombre="nacimiento Monstruo"
						 , valor=self.tiempoRandomCon(_valor)
						 , bloque={=> handlerMonstruos.nuevo()})
	}
	method tiempoRandomCon(_valor) {
		return _valor.randomUpTo(_valor*3)
	}
}

object avanceMonstruos {
	method nuevo(_valor) {
		return new OnTick( nombre="avance de monstruo"
						 , valor=_valor
						 , bloque={=> handlerMonstruos.darPasos()})
	}
}

object aparicionPociones {
	method nuevo(_valor) {
		return new OnTick( nombre="aparece pocion"
						 , valor=self.tiempoRandomCon(_valor)
						 , bloque={=> handlerPociones.nuevo()})
	}
	method tiempoRandomCon(_valor) {
		return _valor.randomUpTo(_valor*2)
	}
}

object desaparicionPociones {
	method nuevo(_valor) {
		return new OnTick( nombre="desaparece pocion"
						 , valor=_valor
						 , bloque={=> handlerPociones.remover()})
	}
}