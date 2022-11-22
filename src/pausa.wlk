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
	const property tipoMonstruos = #{esqueleto, zombie, fantasma}
	var property monstruosCreados = #{}
	var property enPausa = false

	method crearOnTick(_onTick) {
		if (_onTick.nombre() == "nacimiento Monstruos") { self.creardorMonstruos(_onTick.valor()) } else { self.moverMonstruos(_onTick.valor()) }
	}

	method creardorMonstruos(_valor)	{
//		const onTick = new OnTick(nombre="nacimiento Monstruos", valor=_valor.randomUpTo(_valor*3))
		const valor=_valor.randomUpTo(_valor*3)
		game.onTick(valor, "nacimiento Monstruos", {=> game.addVisual(self.unNuevoMonstruoRandom()) })
		onTicks.add("nacimiento Monstruos")
	}

	method moverMonstruos(_valor)	{
//		const onTick = new OnTick(nombre="avance de monstruos", valor=_valor)
		game.onTick(_valor, "avance de Monstruos", {=> game.allVisuals().forEach({ elemento => elemento.darPaso()}) })
		onTicks.add("avance de Monstruos")
	}

	method iniciar(nacimientoMonstruos, movimientoMonstruos)	{
		self.creardorMonstruos(nacimientoMonstruos)
		self.moverMonstruos(movimientoMonstruos)
	}

	method remover() {
		onTicks.forEach({onTickName => game.removeTickEvent(onTickName)})
	}

	// Sistema on/off (switch)
	method switch() {
		if (enPausa) { nivel.reanudar() } 
		else { nivel.pausar() }
		enPausa = not enPausa
	}
	method unNuevoMonstruoRandom() {
		const monstruo = self.unMonstruo()
		self.agregarMonstruo(monstruo)
		return monstruo
	}
	method unMonstruo() {
		return tipoMonstruos.anyOne().nuevo()
	}
	method agregar() {
		monstruosCreados.forEach({monstruo => game.addVisual(monstruo)})
	}
	method agregarMonstruo(_monstruo) {
		monstruosCreados.add(_monstruo)
	}
	method removerMonstruo(_monstruo) {
		monstruosCreados.remove(_monstruo)
	}
}