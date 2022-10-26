import wollok.game.*

object wolly {
	var property position = game.center() // arbitrario
	var property image = "player.png" //"wolly.png"
	var property puntos = 0
	var property ultimaDireccionVista = norte
	var property proyectilActual
	
	method rotarSentidoHorario() {
		self.ultimaDireccionVista(ultimaDireccionVista.anterior())
	}

	method rotarSentidoAntihorario() {
		self.ultimaDireccionVista(ultimaDireccionVista.siguiente())
	}

	method disparar(tipoDeProyectil){ // un proyectil puede ser la calabaza
		self.sacar(tipoDeProyectil)
		self.cargarProyectil()
		proyectilActual.serDisparadoPor(self)
	}

	method sacar(tipoDeProyectil) {
		self.agregar(tipoDeProyectil)
	}

	method cargarProyectil() {
		proyectilActual = game.uniqueCollider(self)
	}

	method agregar(unaCosa) {
		self.validarAgregar()
		const cosa = unaCosa.nuevo()
		cosa.position(position)
		game.addVisual(cosa)
	}

	method hayMonstruo() {
		game.onCollideDo(self, {monstruo => monstruo.matarA(self)})
	}

	method distanciaDeDisparoDe(_peso) {
		return 6/_peso
	}

	method morir() = game.stop()

	method validarAgregar() {
		if (not game.colliders(self).isEmpty()) {
			self.error("Hay algo sobre mí que no me deja accionar.")
		}
	}
}

// ############################################################################################
// Objeto controlador
//method tirarAgua() { // 
//	todos.forEach({aspersor => aspersor.tirarAgua()})
//}

// definición en Class
//method tirarAgua() {
//	
//	(-1..1).forEach( { x =>
//		 (-1..1).forEach ( {y =>
//		 	 self.tirarAgua(x,y)
//		})
//	})
//}
//
//method tirarAgua(dx,dy) {
//	const positionARegar = game.at( position.x() + dx, position.y() + dy)
//	game.getObjectsIn(positionARegar).forEach( { posibleCultivo => posibleCultivo.regar() })
//}
//############################################################################################

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
	var property anterior = este
	var property opuesto = sur

	method avanzar(_position, cantidad) {
		return _position.right(cantidad)
	}
}