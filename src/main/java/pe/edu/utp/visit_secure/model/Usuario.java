package pe.edu.utp.visit_secure.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@NoArgsConstructor
@AllArgsConstructor
@Table("usuarios")
public class Usuario {
    @Id
    private Integer idUsuario;
    private String usuario;
    private String contraseña;
    private Integer idPersona;
}