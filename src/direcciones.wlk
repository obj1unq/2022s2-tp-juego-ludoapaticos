

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