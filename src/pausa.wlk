import wollok.game.*
import wolly.*
import monstruos.*
import proyectiles.*
import direcciones.*
import extras.*


object handlerOnTick {
	var property onTicks = #{}
	const property onTicksMonstruos = #{} 

	method crearMonstruos(_valor)	{
		game.onTick(_valor.randomUpTo(_valor*3), "nace Monstruo", {=> game.addVisual([ esqueleto, zombie, fantasma ].anyOne().nuevo()) })
		onTicks.add(["nace Monstruo",_valor)
		onTicksMonstruos.add("nace Monstruo")
	}
	method moverMonstruos(_valor)	{
		game.onTick(_valor, "monstruos avanzan", {=> game.allVisuals().forEach({ elemento => elemento.darPaso()}) })
		onTicks.add("monstruos avanzan")
		onTicksMonstruos.add("monstruos avanzan")
	}
	method pararMonstruos()	{
		onTicks.forEach({onTickName => game.removeTickEvent(onTickName)})
	}
	method reanudarMonstruos()	{
		onTicks.forEach({onTickName => game.removeTickEvent(onTickName)})
	}
	method eliminarMonstruos() {
		onTicks.map({onTickName => onTicks.remove(onTickName)})
		onTicksMonstruos.clear()
	}
}