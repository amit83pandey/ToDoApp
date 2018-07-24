var app = angular.module('ToDoApp',['ui.router','ngStorage']);

app.constant('urls', {
    BASE: 'http://localhost:8080/todo-util-0.0.1',
    TASK_SERVICE_API : 'http://localhost:8080/todo-util-0.0.1/api/todo/'
});

app.config(['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {

        $stateProvider
            .state('home', {
                url: '/',
                templateUrl: 'partials/list',
                controller:'ToDoController',
                controllerAs:'ctrl',
                resolve: {
                    users: function ($q, ToDoService) {
                        console.log('Load all tasks');
                        var deferred = $q.defer();
                        ToDoService.loadAllToDos().then(deferred.resolve, deferred.resolve);
                        return deferred.promise;
                    }
                }
            });
        $urlRouterProvider.otherwise('/');
    }]);

