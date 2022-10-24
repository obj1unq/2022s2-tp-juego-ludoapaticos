class Monstruo { // superclase para uso de herencia, sé que no lo vimos aún pero seguro en las próximas clases sí

	var vida
	var position
	var image

	method atacar() {
	}

}

class Esqueleto inherits Monstruo {

}

class Vampiro inherits Monstruo {

}

class Zombie inherits Monstruo {

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

