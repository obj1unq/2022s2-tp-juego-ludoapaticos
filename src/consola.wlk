import wollok.game.*
import wolly.*
import proyectiles.*
import direcciones.*
import extras.*
import handlers.*
import niveles.*



object consola {
	var property nivel = nivel1
	var property index = 0
	var property niveles = [nivel1, nivel2, nivel3]


	method siguiente() {
		nivel = niveles.get(index + 1)
	}
	
	method anterior() {
		nivel = niveles.get(index - 1)
	}
	
	method iniciar() {
		nivel.nuevo().iniciar()
	}
	
	
}