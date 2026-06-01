import solicitantes.*
import asociacionLitoral.*

class Universidad {
    var property provincia
    var property honorariosRecomendados
    var property donacionesRecibidas = 0

    method recibirDonacion(unValor) {
        donacionesRecibidas += unValor
    }
}

class ProfesionalVinculado {
    var property universidad
    method honorarios() = universidad.honorariosRecomendados()
    method provincias() = [universidad.provincia()]  // ojo: colección con un elemento


    method cobrarImporte(unValor) {
      universidad.recibirDonacion(unValor / 2)
    }

}

class ProfesionalLitoral {
    var property universidad
    method honorarios() = 3000
    method provincias() = ["Entre Ríos", "Santa Fe", "Corrientes"]


    method cobrarImporte(unValor) {
      asLitoral.recaudarFondos(unValor)
    }

}

class ProfesionalLibre {
    var property universidad
    var property honorarios
    var property provincias   // colección
    var property dineroAcumulado = 0

    method agregarProvincia(unaProvicia) {
        provincias.add(unaProvicia)
    }

    method cobrarImporte(unValor) {
        dineroAcumulado += unValor
    }

    method recibirTransferencia(unValor) {
        dineroAcumulado += unValor
    }

    method pasarDinero(unProfesional, unValor) {
        if (dineroAcumulado >= unValor) {
            unProfesional.recibirTransferencia(unValor)
            dineroAcumulado -= unValor
        } else {
            self.error("Fondos insuficientes")
        }
    }

}

class Empresa {
    var profesionales = []
    var honorariosDeReferencia
    var clientes = #{}

    method contratarProfesional(unProfesional) {
        profesionales.add(unProfesional)
    }

    method cantProfesionalesContratadosEn(unaUniversidad) {
        return profesionales.count({p => p.universidad() == unaUniversidad})
    }

    method profesionalesCaros() {
        return profesionales.filter({p => p.honorarios() > honorariosDeReferencia})
    }

    method universidadesFormadoras() {
        return profesionales.map({ p => p.universidad() }).asSet()
    }

    method profesionalMasBarato() {
        return profesionales.min({p => p.honorarios()})
    }

    method esDeGenteAcotada() {
        return profesionales.all({p => p.provincias().size() <= 3})
    }

    method puedeSatisfacer(unSolicitante) {
        return profesionales.any({p => unSolicitante.puedeSerAtendidaPor(p)})
    }

    method darServicio(unSolicitante) {
        const profesional = profesionales.find({ p => unSolicitante.puedeSerAtendidaPor(p) })
        profesional.cobrarImporte(profesional.honorarios())
        clientes.add(unSolicitante)
    }

    method cantidadDeClientes() {
        return clientes.size()
    } 

    method tieneAlCliente(unSolicitante) {
        return clientes.contains(unSolicitante)
    }

    method esPocatractivoParaLaEmpresa(unProfesional) {
        return unProfesional.provincias().all({ provincia =>
            profesionales.any({ otroProfesional =>
                otroProfesional != unProfesional &&
                otroProfesional.provincias().contains(provincia) &&
                otroProfesional.honorarios() < unProfesional.honorarios()
            })
        })
    }   

}

