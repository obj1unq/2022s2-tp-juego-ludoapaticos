import wolly.*

object izquierda {

	method siguientes(pos) {
		return pos.left(1)
	}

}

object derecha {

	method siguientes(pos) {
		return pos.right(1)
	}

}

object arriba {

	method siguientes(pos) {
		return pos.up(1)
	}

}

object abajo {

	method siguientes(pos) {
		return pos.down(1)
	}

}

//factories
object norte {

	var property siguiente = oeste
	var property anterior = este
	var property opuesto = sur

	method avanzar(_position, cantidad) {
		return _position.up(cantidad)
	}

}

object oeste {

	var property siguiente = sur
	var property anterior = norte
	var property opuesto = este

	method avanzar(_position, cantidad) {
		return _position.left(cantidad)
	}

}

object sur {

	var property siguiente = este
	var property anterior = oeste
	var property opuesto = norte

	method avanzar(_position, cantidad) {
		return _position.down(cantidad)
	}

}

object este {

	var property siguiente = norte
	var property anterior = sur
	var property opuesto = oeste

	method avanzar(_position, cantidad) {
		return _position.right(cantidad)
	}

}

