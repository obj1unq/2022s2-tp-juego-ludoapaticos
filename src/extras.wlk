import wolly.*
import wollok.game.*

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
	
	method matarA(personaje) {
		// No hace nada. Completitud por polimorfismo
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
