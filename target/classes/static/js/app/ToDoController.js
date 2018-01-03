'use strict';

angular.module('ToDoApp').controller('ToDoController',
    ['ToDoService', '$scope',  function( ToDoService, $scope) {

        var self = this;
        self.todo = {};
        self.todos=[];

        self.submit = submit;
        self.getAllToDos = getAllToDos;
        self.createTodo = createTodo;
        self.updateTodo = updateTodo;
        self.markAsDone = markAsDone;
        self.removeTodo = removeTodo;
        self.editTodo = editTodo;
        self.reset = reset;
        self.showAll = showAll;
        self.showActive = showActive;
        self.showInactive = showInactive;
        self.getFilter = getFilter;
        self.filter = "$";
        self.taskListDesc = "List of All Tasks";
        self.successMessage = '';
        self.errorMessage = '';
        self.done = false;

        self.onlyIntegers = /^\d+$/;
        self.onlyNumbers = /^\d+([,.]\d+)?$/;
        
        function showAll(){
        	self.filter = "$";
        	self.taskListDesc = " All Tasks";
        }
        
        function showActive(){
        	self.filter = "active";
        	self.taskListDesc = " Pending Tasks ";
        }
        
        function showInactive(){
        	self.filter = "inactive";
        	self.taskListDesc = " Completed Tasks ";
        }
        
        function getFilter(){
        	if(self.filter === "active"){
        		return { state : 1 } ;
        	}else if(self.filter === "inactive"){
        		return { state : 2 } ;
        	}
        }
        
        function submit() {
            console.log('Submitting');
            if (self.todo.id === undefined || self.todo.id === null) {
                console.log('Saving New Task', self.todo);
                createTodo(self.todo);
            } else {
                updateTodo(self.todo, self.todo.id);
                console.log('Task updated with id ', self.todo.id);
            }
        }

        function createTodo(todo) {
            console.log('About to create task');
            todo.state = 1;
            ToDoService.createToDo(todo)
                .then(
                    function (response) {
                        console.log('Task created successfully');
                        self.successMessage = 'Task created successfully';
                        self.errorMessage='';
                        self.done = true;
                        self.todo={};
                        $scope.myForm.$setPristine();
                    },
                    function (errResponse) {
                        console.error('Error while creating task');
                        self.errorMessage = 'Error while creating Task: ' + errResponse.data.errorMessage;
                        self.successMessage='';
                    }
                );
        }


        function updateTodo(todo, id){
            console.log('About to update task');
            ToDoService.updateToDo(todo, id)
                .then(
                    function (response){
                        console.log('task updated successfully');
                        self.successMessage='task updated successfully';
                        self.errorMessage='';
                        self.done = true;
                        $scope.myForm.$setPristine();
                    },
                    function(errResponse){
                        console.error('Error while updating Task');
                        self.errorMessage='Error while updating Task '+errResponse.data;
                        self.successMessage='';
                    }
                );
        }
        
        function markAsDone(todo){
            console.log('About to update task');
            todo.state = 2;
            updateTodo(todo, todo.id);
        }        


        function removeTodo(id){
            console.log('About to remove task with id '+id);
            ToDoService.removeToDo(id)
                .then(
                    function(){
                        console.log('Task '+id + ' removed successfully');
                    },
                    function(errResponse){
                        console.error('Error while removing task '+id +', Error :'+errResponse.data);
                    }
                );
        }


        function getAllToDos(){
            return ToDoService.getAllToDos();
        }

        function editTodo(id) {
            self.successMessage='';
            self.errorMessage='';
            ToDoService.getToDo(id).then(
                function (todo) {
                    self.todo = todo;
                },
                function (errResponse) {
                    console.error('Error while removing task ' + id + ', Error :' + errResponse.data);
                }
            );
        }
        function reset(){
            self.successMessage='';
            self.errorMessage='';
            self.todo={};
            $scope.myForm.$setPristine(); //reset Form
        }
    }


    ]);