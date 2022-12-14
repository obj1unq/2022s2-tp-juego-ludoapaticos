import wollok.game.*
import wolly.*
import monstruos.*
import proyectiles.*
import direcciones.*
import extras.*
import onticks.*
import pociones.*
import consola.*

object pausa {

	var property nivel = null
	var property enPausa = false

	// Sistema on/off (switch)
	method switch() {
		if (enPausa) {
			nivel.reanudar()
		} else {
			nivel.pausar()
		}
		enPausa = not enPausa
	}

}

object handlerJuego {

	method iniciar() {
		game.start()
	}

	method borrar() {
		game.clear()
	}

	method parar() {
		game.stop()
	}

	method fin() {
		self.borrar()
		handlerVisuales.fin()
	}

}

object handlerVisuales {

	var property nivel = null

	method activar() {
		nivel.activarVisuales()
		handlerMonstruos.activarVisuales()
		handlerPociones.activarVisuales()
	}

	method desactivar() {
		nivel.desactivarVisuales()
		handlerMonstruos.removerVisuales()
		handlerPociones.removerVisuales()
	}

	method fin() {
		self.activar()
		game.removeVisual(visorVida)
		game.addVisual(cartelFinal)
	}

}

class Handler {

	const property factories = []
	var property elementos = #{}

	method nuevo() { // Crea un elemento nuevo en el juego
		const elemento = factories.anyOne().nuevo()
		self.agregar(elemento)
		return elemento
	}

	method nuevo(_elemento) { // Crea un nuevo 'elemento' dado en el juego
		const elemento = _elemento.nuevo()
		self.agregar(elemento)
		return elemento
	}

	method agregar(elemento) {
		elementos.add(elemento)
		self.activarVisualDe(elemento)
	}

	method hayElementosCreados() = not elementos.isEmpty()

	method estaCreado(_elemento) = elementos.any({ elemento => elemento == _elemento })

	method clear() {
		elementos.clear()
	}

	method activarVisuales() {
		elementos.forEach({ elemento => self.activarVisualDe(elemento)})
	}

	method activarVisualDe(elemento) {
		game.addVisual(elemento)
	}

	method removerVisuales() {
		elementos.forEach({ elemento => self.removerVisualDe(elemento)})
	}

	method removerVisualDe(elemento) {
		game.removeVisual(elemento)
	}

	method remover()

	method remover(elemento) {
		self.removerVisualDe(elemento)
		elementos.remove(elemento)
	}

}

object handlerMonstruos inherits Handler(factories = [ esqueleto, zombie, fantasma ]) {

	method darPasos() {
		elementos.forEach({ monstruo => monstruo.darPaso()})
	}

	// Polimorfismo
	override method remover() {
		elementos.forEach({ monstruo => self.remover(monstruo)})
	}

}

object handlerPociones inherits Handler(factories = [ pocionSalud, pocionVeneno, cofre ]) {

	override method remover() {
		elementos.forEach({ pocion => pocion.desaparecer()})
	}

}

object handlerOnTicks inherits Handler {

	var property nivel = null

	method nuevo(onTick, valor) {
		if (not self.estaCreado(onTick)) {
			self.agregar(onTick, valor)
		}
	}

	method agregar(onTick, valor) {
		const newOnTick = onTick.nuevo(valor)
		elementos.add(newOnTick)
		newOnTick.aplicar()
	}

	method activar() {
		if (not self.hayElementosCreados()) {
			nivel.activarOnTicks()
		} else {
			self.reanudar()
		}
	}

	method reanudar() {
		elementos.forEach({ onTick => onTick.aplicar()})
	}

	// por Polimorfismo
	override method factories() {
	}

	override method nuevo() = null

	override method nuevo(elem) = null

	override method agregar(elem) {
	}

	override method remover() {
	}

	override method remover(elem) {
	}

}

