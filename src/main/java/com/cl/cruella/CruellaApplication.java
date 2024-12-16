package com.cl.cruella;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class CruellaApplication {

	public static void main(String[] args) {
		SpringApplication.run(CruellaApplication.class, args);
	}

}
