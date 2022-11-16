
import monstruos.*
import wollok.game.*
import wolly.*

object visorPuntaje {
	
	method position() {
		return game.at(0,game.height() - 1)
	}
	
	method text() {
		return "" + wolly.puntos()
	}
	
	method textColor() {
		return "ff0000ff"
	}
	
	// por polimorfismo
	method matarA(personaje) {
		
	}
	
	method darPaso(){
		
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
