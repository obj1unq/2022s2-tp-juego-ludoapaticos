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


object handleMonstruos {
	const property tipos = [esqueleto, zombie, fantasma]
	var property monstruos = #{} // Son los monstruos actuales en el juego

	method nuevo() { // Crea un monstruo random nuevo en el juego
		const monstruo = tipos.anyOne().nuevo()
		self.agregar(monstruo)
		self.activarVisualDe(monstruo)
		return monstruo
	}
	method nuevo(monstruo) { // Crea un nuevo monstruo dado en el juego
		self.validarCreacion(monstruo)
		self.agregar(monstruo)
		self.activarVisualDe(monstruo)
		return monstruo
	}
	method agregar(monstruo) {
		monstruos.add(monstruo)
	}
	method remover(_monstruo) {
		monstruos.remove(_monstruo)
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
	method esTipoMonstruo(_monstruo) {
		return tipos.any({tipo => tipo == _monstruo})
	}
	method validarCreacion(_monstruo) {
		if (not self.esTipoMonstruo(_monstruo)) {
			self.error("Error: "+_monstruo+" no es un tipo de monstruo válido. Opciones válidas: "+tipos)
		}
	}
}

object handlerOnTicks {
	var property tipos = #{aparicionMonstruos, avanceMonstruos}
	var property onTicks = #{}
	var property enPausa = false

	method nuevo(onTick, valor) {
		self.validarOnTick(onTick)
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

	method agregarOnTickSiNoEsta(_onTick) {
		if (not self.esTipoOnTick(_onTick)) {
			onTicks.add(_onTick)
		}
	}

	method aplicarVisuales() {
		game.allVisuals().forEach({objeto => game.addVisual(objeto)})
	}
	method validarOnTick(onTick) {
		if (not self.esTipoOnTick(onTick)) {
			self.error("Error: "+onTick+" no es un tipo de OnTick válido. Opciones válidas: "+tipos)
		}
	}
	method esTipoOnTick(_onTick) {
		return tipos.any({onTick => onTick == _onTick})
	}

}