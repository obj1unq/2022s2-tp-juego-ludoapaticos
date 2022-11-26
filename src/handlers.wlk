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

object handlerVisuales {
	var property nivel
	method activar() {
		nivel.visuales()
		handlerMonstruos.activarVisuales()
		handlerPociones.activarVisuales()
	}
	method desactivar() {
		nivel.desactivarVisuales()
		handlerMonstruos.desactivarVisuales()
		handlerPociones.desactivarVisuales()
	}
}

object handlerMonstruos {
	const property factories = [esqueleto, zombie, fantasma]
	var property monstruos = #{} // Son los monstruos actuales en el juego

	method nuevo() { // Crea un monstruo random nuevo en el juego
		const monstruo = factories.anyOne().nuevo()
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
	method removerVisual(_monstruo) {
		game.removeVisual(self.get(_monstruo))
	}
	method activarVisualDe(_monstruo) {
		game.addVisual(self.get(_monstruo))
	}
	method darPasos() {
		monstruos.forEach({ monstruo => monstruo.darPaso()})
	}
	method get(_monstruo) {
		return monstruos.find({monstruo => monstruo == _monstruo})
	}
	method remover(monstruo) {
		self.removerVisual(monstruo)
		monstruos.remove(monstruo)
	}

}

object handlerOnTicks {
	// no se usa factories
	var property tipos = #{aparicionMonstruos, avanceMonstruos}
	var property onTicks = #{}

	method nuevo(onTick, valor) {
		const newOnTick = onTick.nuevo(valor)
		onTicks.add(newOnTick)
		newOnTick.aplicar()
	}

	// Delegar en nivel el activar
	method iniciar(valorAparicionMonstruos, valorAvanceMonstruos) {
		if (onTicks.isEmpty()) {
			self.nuevo(aparicionMonstruos, valorAparicionMonstruos)
			self.nuevo(avanceMonstruos, valorAvanceMonstruos)
		} else { self.reanudar() }
	}

	method reanudar() {
		onTicks.forEach({onTick => onTick.aplicar()})
	}
}


object handlerPociones {
	const property factories = [pocionSalud, pocionVeneno, cofre]
	var property pociones = #{}

	method nuevo() { // Crea una pocion random nuevo en el juego
		const pocion = factories.anyOne().nuevo()
		pociones.add(pocion)
		self.activarVisualDe(pocion)
		return pocion
	}

	method remover() {
		pociones.forEach({pocion => pocion.remover()})
	}

	method activarVisualDe(_pocion) {
		game.addVisual(_pocion)
	}

	method removerVisualDe(_pocion) {
		game.removeVisual(_pocion)
	}

	method activarVisuales() {
		pociones.forEach({pocion => self.activarVisualDe(pocion)})
	}

	method desactivarVisuales() {
		pociones.forEach({pocion => self.removerVisualDe(pocion)})
	}
}
//game.onTick(3000.randomUpTo(6000), "aparece pocion", {=> game.addVisual([ pocionSalud, pocionVeneno, cofre ].anyOne().nuevo()) })
//game.onTick(100000, "desaparece pocion", {=> game.allVisuals().forEach({ elemento => elemento.desaparecer()}) })