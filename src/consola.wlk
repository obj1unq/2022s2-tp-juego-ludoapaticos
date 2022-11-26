import wollok.game.*
import wolly.*
import proyectiles.*
import direcciones.*
import extras.*
import handlers.*
import niveles.*



object consola {
	var nivel = nivel1
	var index = 0
	const niveles = [nivel1, nivel2, nivel3]

	method siguiente() {
		index += 1
		nivel = niveles.get(index)
	}
	
	method anterior() {
		index -= 1
		nivel = niveles.get(index)
	}
	
	method iniciar() {
		nivel.nuevo().activar()
	}
	
	
}