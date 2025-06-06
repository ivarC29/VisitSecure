package pe.edu.utp.visit_secure.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table("Persona")
@Builder
public class Persona {
    @NoArgsConstructor
    @AllArgsConstructor
    @Table("Usuario")
    public class Usuario {
        @Id
        private Integer idUsuario;
        private String usuario;
        private String contraseña;
        private Integer idPersona;
    }
}
