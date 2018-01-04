<div class="generic-container">
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"><span class="lead">Task Form</span></div>
		<div class="panel-body">
	        <div class="formcontainer">
	            <div class="alert alert-success" role="alert" ng-if="ctrl.successMessage">{{ctrl.successMessage}}</div>
	            <div class="alert alert-danger" role="alert" ng-if="ctrl.errorMessage">{{ctrl.errorMessage}}</div>
	            <form ng-submit="ctrl.submit()" name="myForm" class="form-horizontal">
	                <input type="hidden" ng-model="ctrl.todo.id" />
	                <div class="row">
	                    <div class="form-group col-md-12">
	                        <label class="col-md-2 control-lable" for="uname">Description</label>
	                        <div class="col-md-7">
	                            <input type="text" ng-model="ctrl.todo.desc" id="desc" class="form-control input-sm" placeholder="Enter your task" required ng-minlength="3"/>
	                        </div>
	                    </div>
	                </div>

	                <div class="row">
	                    <div class="form-actions floatRight">
	                        <button type="submit" title="Add/Update Tasks" class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid || myForm.$pristine">
	                          <div ng-show="ctrl.showButton(ctrl.todo.id)">
	                            <i class="fa fa-plus-square" aria-hidden="true"></i>
	                          </div>
	                          <div ng-hide="ctrl.showButton(ctrl.todo.id)">  
	                            <i class="fa fa-pencil" aria-hidden="true"></i>
	                          </div>  
	                        </button>
	                        <button type="button" title="Clear Form" ng-click="ctrl.reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine"><i class="fa fa-eraser" aria-hidden="true"></i></button>
	                    </div>
	                </div>
	            </form>
    	    </div>
		</div>	
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"><span class="lead">{{ ctrl.taskListDesc }}</span>
	        <div class="form-actions floatRight">
	    	    	<lable ng-click="ctrl.showAll()" title="Show All Tasks" class="btn label label-primary custom-width lb-sm">All</lable>
	            	<lable ng-click="ctrl.showInactive()" title="Show Completed Tasks" class="btn label label-success custom-width lb-sm">Done</lable>
		        	<lable ng-click="ctrl.showActive()" title="Show Pending Tasks" class="btn label label-warning custom-width lb-sm">Pending</lable>
	        </div> 	
        </div>
		<div class="panel-body">
			<div class="table-responsive">
		        <table class="table table-hover">
		            <thead>
		            <tr>
		                <th>ID</th>
		                <th>DESC</th>
		                <th>STATUS</th>
		                <th width="20"></th>
		                <th width="20"></th>
		                <th width="20"></th>
		            </tr>
		            </thead>
		            <tbody>
		            <tr ng-repeat="u in ctrl.getAllToDos() | filter : ctrl.getFilter() ">
		                <td>{{u.id}}</td>
		                <td>{{u.desc}}</td>
		                <td>{{u.state === 1 ? "Pending" : "Done" }}</td>
		                <td><button type="button" ng-click="ctrl.markAsDone(u)" title="Mark this task as completed" class="btn btn-primary btn-sm" ng-disabled="u.state === 2" ><i class="fa fa-check-square" aria-hidden="true"></i></button></td>
		                <td><button type="button" ng-click="ctrl.editTodo(u.id)" title="Edit this task" class="btn btn-success btn-sm" ng-disabled="u.state === 2" ><i class="fa fa-pencil" aria-hidden="true"></i></button></td>
		                <td><button type="button" ng-click="ctrl.removeTodo(u.id)" title="Delete this task" class="btn btn-danger btn-sm" ng-disabled="u.state === 2"><i class="fa fa-window-close" aria-hidden="true"></i></button></td>
		            </tr>
		            </tbody>
		        </table>		
			</div>
		</div>
    </div>
</div>