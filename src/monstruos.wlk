import wollok.game.*
import direcciones.*

//class Monstruo { // superclase para uso de herencia, sé que no lo vimos aún pero seguro en las próximas clases sí
//
//	var vida
//	var position
//	var image
//
//	method atacar() {
//	}
//
//}

class Esqueleto  {
 
}

class Vampiro  {

}

class Zombie  {
	var property position = game.at((game.width() -1), (0.randomUpTo(game.height()-1)))
	method image() = "Zombie_izquierda.png"
	
	method darPaso(){
		position = izquierda.siguientes(position)
	}

}

object esqueleto {

	method nuevo() {
		return new Esqueleto() 
	}

}

object vampiro {

	method nuevo() {
		return new Vampiro()
	}

}

object zombie {

	method nuevo() {
		return new Zombie() 
	}

}

