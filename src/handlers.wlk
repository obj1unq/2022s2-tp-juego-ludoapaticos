import wollok.game.*
import wolly.*
import monstruos.*
import proyectiles.*
import direcciones.*
import extras.*
import onticks.*


object pausa {
	var property nivel
	var property enPausa = false
	// Sistema on/off (switch)
	method switch() {
		if (enPausa) { nivel.reanudar() } 
		else { nivel.pausar() }
		enPausa = not enPausa
	}
}

object handlerMonstruos {
	const property tipos = [esqueleto, zombie, fantasma]
	var property monstruos = #{} // Son los monstruos actuales en el juego

	method nuevo() { // Crea un monstruo random nuevo en el juego
		const monstruo = tipos.anyOne().nuevo()
		monstruos.add(monstruo)
		self.activarVisualDe(monstruo)
		return monstruo
	}
	method nuevo(monstruo) { // Crea un nuevo monstruo dado en el juego
		monstruos.add(monstruo)
		self.activarVisualDe(monstruo)
		return monstruo
	}
	method activarVisuales() {
		monstruos.forEach({monstruo => game.addVisual(monstruo)})
	}
	method desactivarVisuales() {
		monstruos.forEach({monstruo => game.removeVisual(monstruo)})
	}
	method desactivarVisualDe(_monstruo) {
		game.removeVisual(self.get(_monstruo))
	}
	method activarVisualDe(_monstruo) {
		game.addVisual(self.get(_monstruo))
	}
	method get(_monstruo) {
		return monstruos.find({monstruo => monstruo == _monstruo})
	}
	method darPasos() {
		monstruos.forEach({ monstruo => monstruo.darPaso()})
	}
}

object handlerOnTicks {
	var property tipos = #{aparicionMonstruos, avanceMonstruos}
	var property onTicks = #{}
	var property enPausa = false

	method nuevo(onTick, valor) {
		const newOnTick = onTick.nuevo(valor)
		self.agregar(newOnTick)
		newOnTick.aplicar()
	}

	method aplicarOnTicks() {
		onTicks.forEach({onTick => onTick.aplicar()})
	}

	method agregar(_onTick) {
		onTicks.add(_onTick)
	}

	method remover(_onTick) {
		onTicks.remove(_onTick)
	}

	method iniciar(valorAparicionMonstruos, valorAvanceMonstruos) {
		if (onTicks.isEmpty()) {
			self.nuevo(aparicionMonstruos, valorAparicionMonstruos)
			self.nuevo(avanceMonstruos, valorAvanceMonstruos)
		} else { self.reanudar() }
	}

	method reanudar() {
		self.aplicarOnTicks()
		self.aplicarVisuales()
	}

	method aplicarVisuales() {
		handlerMonstruos.activarVisuales()
//		game.allVisuals().forEach({objeto => game.addVisual(objeto)})
	}

}