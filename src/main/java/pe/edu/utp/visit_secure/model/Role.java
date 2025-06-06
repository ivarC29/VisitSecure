package pe.edu.utp.visit_secure.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@NoArgsConstructor
@AllArgsConstructor
@Table("roles")
public class Role {
    @Id
    private Integer idRole;
    private String roleName;
}