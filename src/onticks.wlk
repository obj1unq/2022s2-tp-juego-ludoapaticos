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
		game.onTick(valor, nombre, bloque)
	}
}


// factories
object aparicionMonstruos {
	method nuevo(_valor) {
		return new OnTick( nombre="nacimiento Monstruos"
						 , valor=self.tiempoRandomCon(_valor)
						 , bloque={=> handlerMonstruos.nuevo()})
	}
	method tiempoRandomCon(_valor) {
		return _valor.randomUpTo(_valor*3)
	}
}

object avanceMonstruos {
	method nuevo(_valor) {
		return new OnTick( nombre="avance de monstruos"
						 , valor=_valor
						 , bloque={=> handlerMonstruos.darPasos()})
	}
}

object aparecePocion {
	method nuevo(_valor) {
		return new OnTick( nombre="aparece pocion"
						 , valor=self.tiempoRandomCon(3000)
						 , bloque={=> handlerMonstruos.darPasos()})
	}
	method tiempoRandomCon(_valor) {
		return _valor.randomUpTo(_valor*2)
	}
}

game.onTick(3000.randomUpTo(6000), "aparece pocion", {=> game.addVisual([ pocionSalud, pocionVeneno, cofre ].anyOne().nuevo()) })
	game.onTick(100000, "desaparece pocion", {=> game.allVisuals().forEach({ elemento => elemento.desaparecer()}) })