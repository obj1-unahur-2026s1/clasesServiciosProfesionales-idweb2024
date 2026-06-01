class Persona {
    var provincia

    method puedeSerAtendidaPor(unProfesional) {
        return unProfesional.provincias().contains(provincia)
    }
}

class Institucion {
    var universidades = []

    method puedeSerAtendidaPor(unProfesional){
        return universidades.contains(unProfesional.universidad())
    } 
}

class Club {
    var provincias = []

    method puedeSerAtendidaPor(unProfesional) {
        return provincias.any({ p =>
            unProfesional.provincias().contains(p)
        })
    }
}