import wollok.game.*
import wolly.*
import monstruos.*
import proyectiles.*
import direcciones.*
import extras.*

class OnTick {
	var property nombre
	var property valor
}

object handlerOnTick {
	var property nivel
	var property onTicks = #{}
	const property onTicksMonstruos = #{}
	var property enPausa = false

	method crearOnTick(_onTick) {
		if (_onTick.nombre() == "nacimiento Monstruos") { self.crearMonstruos(_onTick.valor()) } else { self.moverMonstruos(_onTick.valor()) }
	}

	method crearMonstruos(_valor)	{
//		const onTick = new OnTick(nombre="nacimiento Monstruos", valor=_valor.randomUpTo(_valor*3))
		const valor=_valor.randomUpTo(_valor*3)
		game.onTick(valor, "nacimiento Monstruos", {=> game.addVisual([ esqueleto, zombie, fantasma ].anyOne().nuevo()) })
		onTicks.add("nacimiento Monstruos")
	}

	method moverMonstruos(_valor)	{
//		const onTick = new OnTick(nombre="avance de monstruos", valor=_valor)
		game.onTick(_valor, "avance de Monstruos", {=> game.allVisuals().forEach({ elemento => elemento.darPaso()}) })
		onTicks.add("avance de Monstruos")
	}

	method pararJuego()	{
		enPausa = not enPausa
		onTicks.forEach({onTickName => game.removeTickEvent(onTickName)})
		nivel.pausar()
	}

	method reanudarJuego()	{
		enPausa = not enPausa
		nivel.reanudar()
	}

	method iniciar(nacimientoMonstruos, movimientoMonstruos)	{
		self.crearMonstruos(nacimientoMonstruos)
		self.moverMonstruos(movimientoMonstruos)
	}

	// Sistema on/off (switch)
	method switch() {
		return if (enPausa) {
			self.reanudarJuego()
		} 
		else { 
			self.pararJuego()
		}
	}
}