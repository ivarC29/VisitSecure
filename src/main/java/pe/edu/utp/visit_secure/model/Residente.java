package pe.edu.utp.visit_secure.model;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table("residentes")
@Builder
public class Residente {
    @Id
    private Integer idResidente;
    private Integer idCondominio;
    private Integer idPersona;
    private String torre;
    private String numeroDpto;
}
