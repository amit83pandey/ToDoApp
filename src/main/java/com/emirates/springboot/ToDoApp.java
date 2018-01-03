package com.emirates.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;

import com.emirates.springboot.configuration.JpaConfiguration;


@Import(JpaConfiguration.class)
@SpringBootApplication(scanBasePackages={"com.emirates.springboot"})
public class ToDoApp {
	
	public static void main (String args[]){
		SpringApplication.run(ToDoApp.class,args);		
	}

}
