package com.emirates.springboot.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.emirates.springboot.model.ToDo;
import com.emirates.springboot.service.ToDoService;
import com.emirates.springboot.util.CustomErrorType;


@RestController
@RequestMapping("/api")
public class ToDoRequestController {
	
	public static final Logger logger = LoggerFactory.getLogger(ToDoRequestController.class);
	
	@Autowired
	ToDoService todoService;	
	
	@RequestMapping( value = "/todo" , method = RequestMethod.GET)
	public ResponseEntity<List<ToDo>> listAllToDos(){

		List<ToDo> todos = todoService.findAllToDos();
		if (todos.isEmpty()) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<ToDo>>(todos, HttpStatus.OK);		
	}
	
	@RequestMapping( value = "/todo/{id}" , method = RequestMethod.GET)
	public ResponseEntity<?> getToDo(@PathVariable("id") long id){
		logger.info("Fetching task with id {}", id);
		ToDo todo = todoService.findById(id);
		if (todo == null) {
			logger.error("Task with id {} not found.", id);
			return new ResponseEntity(new CustomErrorType("Task with id " + id 
					+ " not found"), HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<ToDo>(todo, HttpStatus.OK);		
	}
	
	@RequestMapping( value = "/todo" , method = RequestMethod.POST)
	public ResponseEntity<?> createToDo(@RequestBody ToDo todo, UriComponentsBuilder ucBuilder){
		logger.info("Creating Task : {}", todo);

		if (todoService.isToDoExist(todo)) {
			logger.error("Unable to create. A Task with desc {} already exist", todo.getDesc());
			return new ResponseEntity(new CustomErrorType("Unable to create. A task with desc " + 
			todo.getDesc() + " already exist."),HttpStatus.CONFLICT);
		}
		todoService.saveToDo(todo);

		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(ucBuilder.path("/api/todo/{id}").buildAndExpand(todo.getId()).toUri());
		return new ResponseEntity<String>(headers, HttpStatus.CREATED);		
	}
	
	@RequestMapping( value = "/todo/{id}" , method = RequestMethod.PUT)
	public ResponseEntity<?> updateToDo(@PathVariable("id") long id, @RequestBody ToDo todo){
		logger.info("Updating task with id {}", id);

		ToDo currentTask = todoService.findById(id);

		if (currentTask == null) {
			logger.error("Unable to update. Task with id {} not found.", id);
			return new ResponseEntity(new CustomErrorType("Unable to upate. Task with id " + id + " not found."),
					HttpStatus.NOT_FOUND);
		}

		currentTask.setDesc(todo.getDesc());
		currentTask.setState(todo.getState());

		todoService.updateToDo(currentTask);
		return new ResponseEntity<ToDo>(currentTask, HttpStatus.OK);		
		
	}
	
	@RequestMapping( value = "/todo/{id}" , method = RequestMethod.DELETE)
	public ResponseEntity<?> deleteToDo(@PathVariable("id") long id){
		logger.info("Fetching & Deleting task with id {}", id);

		ToDo task = todoService.findById(id);
		if (task == null) {
			logger.error("Unable to delete. task with id {} not found.", id);
			return new ResponseEntity(new CustomErrorType("Unable to delete. task with id " + id + " not found."),
					HttpStatus.NOT_FOUND);
		}
		todoService.deleteToDoById(id);
		return new ResponseEntity<ToDo>(HttpStatus.NO_CONTENT);		
		
	}
	
	@RequestMapping(  value = "/todo/" , method = RequestMethod.PUT )
	public ResponseEntity<ToDo> deleteAllToDos(){
		logger.info("Deleting All Tasks");

		todoService.deleteAllToDos();
		return new ResponseEntity<ToDo>(HttpStatus.NO_CONTENT);		
	}
	
	

}
