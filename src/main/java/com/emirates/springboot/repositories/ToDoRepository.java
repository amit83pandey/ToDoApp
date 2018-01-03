package com.emirates.springboot.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.emirates.springboot.model.ToDo;

@Repository
public interface ToDoRepository  extends JpaRepository<ToDo, Long> {
	
	ToDo findByDesc(String desc);

}
