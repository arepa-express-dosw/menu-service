package edu.dosw.arepas.menu;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI menuOpenApi() {
        return new OpenAPI().info(new Info()
                .title("Arepa Express - Menu API")
                .version("1.0.0")
                .description("Consulta del menu de arepas."));
    }
}
