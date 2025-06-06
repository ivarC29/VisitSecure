package pe.edu.utp.visit_secure.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table("condominios")
@Builder
public class Condominio {
    @Id
    private Integer idCondominio;
    private String nombre;
    private String direccion;
}
