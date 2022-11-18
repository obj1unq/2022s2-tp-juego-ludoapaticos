
import monstruos.*
import wollok.game.*
import wolly.*


class Visor {
	method image()
	
	method position()
	
	method textColor() {
		return "ff0000ff"
	}
		
		// por polimorfismo
	method daniarA() {
		
	}
	
	method darPaso(){
		
	}
	method serImpactadoPor(algo){
		
	}
}
object visorPuntaje inherits Visor{
	
	override method image()="visorPuntaje.png"
	override method position() {
		return game.at(0,game.height()-1)
	}
	
	method text() {
		return "" + wolly.puntos()
	}
}

object visorVida inherits Visor{
	var property longitud = 5
	
	override method image()= "vida"+ wolly.vida() +".png"
	
	override method position()=game.at(game.width()-6, game.height()-1)
	

	
	method perderVidas(cantidad){
		longitud -= cantidad
	}
	
}

object randomizer {
		
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
}
