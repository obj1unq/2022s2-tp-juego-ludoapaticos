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
	const property tipoMonstruos = [esqueleto, zombie, fantasma]
	var property monstruosCreados = #{}
	var property enPausa = false

	method creardorMonstruos(_valor) {
		const valorRandom=_valor.randomUpTo(_valor*3)
		const onTick = new OnTick(nombre="nacimiento Monstruos", valor=valorRandom)
		self.agregarOnTickSiNoEsta(onTick)
		self.aplicarOnTick(onTick)
	}

	method moverMonstruos(_valor) {
		const onTick = new OnTick(nombre="avance de monstruos", valor=_valor)
		self.agregarOnTickSiNoEsta(onTick)
		self.aplicarOnTick(onTick)
	}

	method iniciar(nacimientoMonstruos, movimientoMonstruos) {
		if (onTicks.isEmpty()) {
			self.creardorMonstruos(nacimientoMonstruos)
			self.moverMonstruos(movimientoMonstruos)
		} else { self.reanudar() }
	}

//	method remover() {
//		onTicks.forEach({onTick => game.removeTickEvent(onTick.nombre())})
//	}

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

	method reanudar() {
		self.aplicarOnTicks()
		self.aplicarVisuales()
	}

	method agregarMonstruo(_monstruo) {
		monstruosCreados.add(_monstruo)
	}

	method removerMonstruo(_monstruo) {
		monstruosCreados.remove(_monstruo)
	}

	method agregarOnTickSiNoEsta(_onTick) {
		if (not self.estaOnTick(_onTick)) {
			onTicks.add(_onTick)
		}
	}

	method estaOnTick(_onTick) {
		return not onTicks.filter({onTick => onTick == _onTick}).isEmpty()
	}

	method aplicarOnTick(_onTick) {
		if (_onTick.nombre() == "nacimiento Monstruos") {
			self.aplicarOnTickMonstruo(_onTick)
		} else { self.aplicarOnTickMoverMonstruo(_onTick) }
	}
	method aplicarOnTickMonstruo(_onTick) {
		game.onTick(_onTick.valor(), _onTick.nombre(), {=> const monstruo = self.unMonstruo(); game.addVisual(monstruo); self.agregarMonstruo(monstruo) })
	}

	method aplicarOnTickMoverMonstruo(_onTick) {
		game.onTick(_onTick.valor(), _onTick.nombre(), {=> game.allVisuals().forEach({ elemento => elemento.darPaso()}) })
	}

	method aplicarOnTicks() {
		onTicks.forEach({onTick => self.aplicarOnTick(onTick)})
	}

	method aplicarVisuales() {
		monstruosCreados.forEach({monstruo => game.addVisual(monstruo)})
	}
}