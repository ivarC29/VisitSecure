package pe.edu.utp.visit_secure.config;

import io.r2dbc.spi.ConnectionFactory;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;
import org.springframework.r2dbc.connection.init.ScriptUtils;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.util.Arrays;

@Configuration
@RequiredArgsConstructor
public class DataInitializer {

    private final ConnectionFactory connectionFactory;

    @Bean
    public ApplicationRunner initializeDatabase() {
        return args -> {
            ClassPathResource resource = new ClassPathResource("data/init.sql");
            String sql = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);

            // Divide el script en sentencias por ';'
            String[] statements = Arrays.stream(sql.split(";"))
                    .map(String::trim)
                    .filter(s -> !s.isEmpty() && !s.startsWith("--"))
                    .toArray(String[]::new);

            Mono.from(connectionFactory.create())
                    .flatMapMany(connection ->
                            Flux.fromArray(statements)
                                    .concatMap(stmt -> Mono.from(connection.createStatement(stmt).execute())
                                            .onErrorResume(e -> {
                                                // Puedes loguear el error aquí si lo deseas
                                                return Mono.empty();
                                            })
                                    )
                                    .then(Mono.from(connection.close()))
                    )
                    .blockLast();
        };
    }
}