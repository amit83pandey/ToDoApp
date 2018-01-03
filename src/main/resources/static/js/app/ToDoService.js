'use strict';

angular.module('ToDoApp').factory('ToDoService',
    ['$localStorage', '$http', '$q', 'urls',
        function ($localStorage, $http, $q, urls) {

            var factory = {
                loadAllToDos: loadAllToDos,
                getAllToDos: getAllToDos,
                getToDo: getToDo,
                createToDo: createToDo,
                updateToDo: updateToDo,
                removeToDo: removeToDo
            };

            return factory;

            function loadAllToDos() {
                console.log('Fetching all tasks');
                var deferred = $q.defer();
                $http.get(urls.TASK_SERVICE_API)
                    .then(
                        function (response) {
                            console.log('Fetched successfully all tasks');
                            $localStorage.todos = response.data;
                            deferred.resolve(response);
                        },
                        function (errResponse) {
                            console.error('Error while loading taks');
                            deferred.reject(errResponse);
                        }
                    );
                return deferred.promise;
            }

            function getAllToDos(){
                return $localStorage.todos;
            }

            function getToDo(id) {
                console.log('Fetching task with id :'+id);
                var deferred = $q.defer();
                $http.get(urls.TASK_SERVICE_API + id)
                    .then(
                        function (response) {
                            console.log('Fetched successfully task with id :'+id);
                            deferred.resolve(response.data);
                        },
                        function (errResponse) {
                            console.error('Error while loading task with id :'+id);
                            deferred.reject(errResponse);
                        }
                    );
                return deferred.promise;
            }

            function createToDo(todo) {
                console.log('Creating task');
                var deferred = $q.defer();
                $http.post(urls.TASK_SERVICE_API, todo)
                    .then(
                        function (response) {
                            loadAllToDos();
                            deferred.resolve(response.data);
                        },
                        function (errResponse) {
                           console.error('Error while creating task : '+errResponse.data.errorMessage);
                           deferred.reject(errResponse);
                        }
                    );
                return deferred.promise;
            }

            function updateToDo(todo, id) {
                console.log('Updating task with id '+id);
                var deferred = $q.defer();
                $http.put(urls.TASK_SERVICE_API + id, todo)
                    .then(
                        function (response) {
                            loadAllToDos();
                            deferred.resolve(response.data);
                        },
                        function (errResponse) {
                            console.error('Error while updating task with id :'+id);
                            deferred.reject(errResponse);
                        }
                    );
                return deferred.promise;
            }

            function removeToDo(id) {
                console.log('Removing task with id '+id);
                var deferred = $q.defer();
                $http.delete(urls.TASK_SERVICE_API + id)
                    .then(
                        function (response) {
                            loadAllToDos();
                            deferred.resolve(response.data);
                        },
                        function (errResponse) {
                            console.error('Error while removing task with id :'+id);
                            deferred.reject(errResponse);
                        }
                    );
                return deferred.promise;
            }

        }
    ]);