package com.emirates.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.emirates.springboot.model.ToDo;
import com.emirates.springboot.repositories.ToDoRepository;


@Service("todoService")
@Transactional
public class ToDoServiceImpl implements  ToDoService{

	@Autowired
	private ToDoRepository todoRepository;
	
	@Override
	public ToDo findById(Long id) {
		return todoRepository.findOne(id);
	}

	@Override
	public ToDo findByDesc(String desc) {
		return todoRepository.findByDesc(desc);
	}

	@Override
	public void saveToDo(ToDo todo) {
		todoRepository.save(todo);		
	}

	@Override
	public void updateToDo(ToDo todo) {
		saveToDo(todo);		
	}

	@Override
	public void deleteToDoById(Long id) {
		todoRepository.delete(id);		
	}

	@Override
	public void deleteAllToDos() {
		todoRepository.deleteAll();		
	}

	@Override
	public List<ToDo> findAllToDos() {
		return todoRepository.findAll();
	}
	
	public boolean isToDoExist(ToDo todo) {
		return findByDesc(todo.getDesc()) != null;
	}	

}
