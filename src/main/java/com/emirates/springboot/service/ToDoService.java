package com.emirates.springboot.service;

import java.util.List;

import com.emirates.springboot.model.ToDo;


public interface ToDoService {
	
	ToDo findById(Long id);

	ToDo findByDesc(String desc);

	void saveToDo(ToDo todo);

	void updateToDo(ToDo todo);

	void deleteToDoById(Long id);

	void deleteAllToDos();

	List<ToDo> findAllToDos();
	
	boolean isToDoExist(ToDo todo);

}
