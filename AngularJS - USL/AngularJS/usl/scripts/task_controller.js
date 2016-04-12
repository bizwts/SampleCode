get_task_model.controller('todo_list', ['getTodolist', 'getAgents', 'getMembs', 'getCompanies', 'getAttorney', 'getServices', 'getMatters', 'getEmployees', 'taskStorage', 'filterFilter', '$routeParams', '$scope', '$window', '$location', '$filter', '$cookieStore', '$modal', '$rootScope', '$http', 'logger', "$q", function(getTodolist, getAgents, getMembs, getCompanies, getAttorney, getServices, getMatters, getEmployees, taskStorage, filterFilter, $routeParams, $scope, $window, $location, $filter, $cookieStore, $modal, $rootScope, $http, logger, $q) {
        if ($filter("checkValidValue")($cookieStore.get('user_info')))
        {
            $scope.user_info = $cookieStore.get('user_info');
            $scope.logged_user = $scope.user_info.id;
            var user_id = $scope.user_info.id;
            var user_name = $scope.user_info.username;
        }
        var tasks;
        $scope.tasks = [];
        
        $scope.Config = {};
        $scope.Config.general = {};
        $scope.Config.list = {};
        
        $scope.init = function() {
            
            /* Start Config list for pagination*/
            $scope.Config.list.itemperPage = 20;
            /* End Config list for pagination */
            var filtobj_todo = "";
            if($routeParams.id){
                filtobj_todo = {filter:"(assign_to='"+$scope.user_info.id+"' || user_id='"+$scope.user_info.id+"')&& deleted!=1",order: "id desc"};
            } else if ($routeParams.entity && $routeParams.number)
            {
                filtobj_todo = {filter: $routeParams.entity + "=" + $routeParams.number+"&& deleted!=1", order: "id desc", limit: $scope.Config.list.itemperPage,'include_count': true};
            }
            else
            {
                filtobj_todo = {filter:"deleted!=1",order: "id desc", limit: $scope.Config.list.itemperPage,'include_count': true};
            }
            getTodolist.vwtodo_entity_res.get(filtobj_todo, function(data) {
                    $scope.total_notes = data.meta.count;
                    $.each(data.record, function(key, val) {
                        val.date_created = $filter('date')(val.date_created, 'MMM dd yyyy hh:mm a');
                        if (val.completed == "true")
                        {
                            val.completed = true;
                        }
                        else
                        {
                            val.completed = false;
                        }
                        //val.task_list = val.task_list.replace(/(\r\n|\n|\r)/gm,"<br>");
                        //val.task_list = val.task_list.replace(/\\/g, '&#92;');
                        val.task_list = removeSpecialCharacter(val.task_list);
                        val.task_list = $scope.pharseJson(val.task_list);
                        if(!$.isArray(val.task_list)){
                            val.task_list = [val.task_list];
                        }
                        
                        $.each(val.task_list, function(task_key, task_val) {
                            if ($filter("checkValidValue")(task_val.note))
                            {
                                task_val.note = task_val.note.replace(/&#92;n/g,"<br>");
                            }
                            if ($filter("checkValidValue")(task_val.user_id))
                            {
                                getEmployees.employees_resource.get({fields:'id,username',filter: "id="+task_val.user_id},
                                function(emp_data) {
                                    if(emp_data.record.length > 0)
                                    {
                                        task_val.user_name = emp_data.record[0].username;
                                    }
                                },function(){
                                    console.error(arguments);
                                });
                            }
                        });
                        getEmployees.employees_resource.get({fields:'id,username',filter: "id="+val.user_id},
                        function(emp_data) {
                            if(emp_data.record.length > 0)
                            {
                                val.user_name = emp_data.record[0].username;
                            }
                        },function(){
                            console.error(arguments);
                        });
                        $scope.tasks.push(val);
                    });

                    tasks = $scope.tasks;
                    $scope.remainingCount = filterFilter(tasks, {
                        completed: !1
                    }).length;
                    $scope.newTask = "";
                    $scope.editedTask = null, $scope.statusFilter = {
                        completed: !1
                    }, $scope.filter = function(filter) {
                        switch (filter) {
                            case "all":
                                return $scope.statusFilter = "";
                            case "active":
                                return $scope.statusFilter = {
                                    completed: !1
                                };
                            case "completed":
                                return $scope.statusFilter = {
                                    completed: !0
                                }
                        }
                    }, $scope.clearCompleted = function() {
                        return $scope.tasks = tasks = tasks.filter(function(val) {
                            return !val.completed
                        }), taskStorage.put(tasks)
                    }, $scope.$watch("remainingCount == 0", function(val) {
                        return $scope.allChecked = val
                    }), $scope.$watch("remainingCount", function(newVal) {
                        return $rootScope.$broadcast("taskRemaining:changed", newVal)
                    });
                    
                    /* Set config pagination parameters*/
                    $scope.Config.list.itemTotalCount = data.meta.count;
                
                    $scope.Config.list.preOffset = 0;
                    $scope.Config.list.itemFrom = 1;
                    $scope.Config.list.nextOffset = $scope.Config.list.itemperPage;
                    $scope.Config.list.itemTo = $scope.Config.list.itemperPage;
                    $scope.Config.list.itemTotalCount = $scope.Config.list.itemTotalCount;
                    $scope.Config.list.paginationCount = $window.Math.ceil($scope.Config.list.itemTotalCount / $scope.Config.list.itemperPage);
                    $scope.Config.list.currentPage = 1;
                    $scope.Config.list.limitstart = 0;
                    $scope.Config.list.limitend = 5;
                    $scope.Config.list.pagination = $scope.buildPagination($scope.Config.list.paginationCount);

                }, function() {
                    console.error(arguments);
                });
        }
        /*Pagination*/
        $scope.buildPagination = function(paginationCount) {
            var Temp = [];
            for (var i = 1; i <= paginationCount; i++) {
                Temp.push({offset: ((i - 1) * $scope.Config.list.itemperPage), number: i});
            }
            return Temp;
        };
        
        $scope.getNextData = function(offset) {// on pagination
            $scope.tasks = [];
            var filterObj;
            var searchParam = [];
            if($routeParams.id)
            {
                searchParam.push("(assign_to='"+$scope.user_info.id+"' || user_id='"+$scope.user_info.id+"')");
            }
            else if($routeParams.entity && $routeParams.number)
            {
                searchParam.push($routeParams.entity + "=" + $routeParams.number);
            }
            if ($filter("checkValidValue")($scope.Config.general.searchtasktodo))
            {
                searchParam.push("task_todo LIKE '%"+$scope.Config.general.searchtasktodo+"%'");
            }
            searchParam.push("deleted!=1");
            filter_str = searchParam.join(" and ");
            console.log(filter_str," filter_str");
            filterObj = {"filter": filter_str, 'limit': $scope.Config.list.itemperPage,'offset': offset, 'include_count': true, "order": "id desc",'include_count': true};
            getTodolist.vwtodo_entity_res.get(filterObj, function(data) {
                console.log(data,"getNextData");
                $.each(data.record, function(key, val) {
                    val.date_created = $filter('date')(val.date_created, 'MMM dd yyyy hh:mm a');
                    if (val.completed == "true")
                    {
                        val.completed = true;
                    }
                    else
                    {
                        val.completed = false;
                    }

                    val.task_list = removeSpecialCharacter(val.task_list);
                    val.task_list = $scope.pharseJson(val.task_list);
                    if(!$.isArray(val.task_list)){
                        val.task_list = [val.task_list];
                    }
                    $.each(val.task_list, function(task_key, task_val) {
                        if ($filter("checkValidValue")(task_val.note))
                        {
                            task_val.note = task_val.note.replace(/&#92;n/g,"<br>");
                        }
                        if ($filter("checkValidValue")(task_val.user_id))
                        {
                            getEmployees.employees_resource.get({fields:'id,username',filter: "id="+task_val.user_id},
                            function(emp_data) {
                                if(emp_data.record.length > 0)
                                {
                                    task_val.user_name = emp_data.record[0].username;
                                }
                            },function(){
                                console.error(arguments);
                            });
                        }
                    });
                    if ($filter("checkValidValue")(val.user_id))
                    {
                        getEmployees.employees_resource.get({fields:'id,username',filter: "id="+val.user_id},
                        function(emp_data) {
                            if(emp_data.record.length > 0)
                            {
                                val.user_name = emp_data.record[0].username;
                            }
                        },function(){
                            console.error(arguments);
                        });
                    }
                    $scope.tasks.push(val);
                });
                

                tasks = $scope.tasks;
                $scope.remainingCount = filterFilter(tasks, {
                    completed: !1
                }).length;
                $scope.newTask = "";
                $scope.editedTask = null, $scope.statusFilter = {
                    completed: !1
                }, $scope.filter = function(filter) {
                    switch (filter) {
                        case "all":
                            return $scope.statusFilter = "";
                        case "active":
                            return $scope.statusFilter = {
                                completed: !1
                            };
                        case "completed":
                            return $scope.statusFilter = {
                                completed: !0
                            }
                    }
                }, $scope.clearCompleted = function() {
                    return $scope.tasks = tasks = tasks.filter(function(val) {
                        return !val.completed
                    }), taskStorage.put(tasks)
                }, $scope.$watch("remainingCount == 0", function(val) {
                    return $scope.allChecked = val
                }), $scope.$watch("remainingCount", function(newVal) {
                    return $rootScope.$broadcast("taskRemaining:changed", newVal)
                });
                
                $scope.Config.list.itemFrom = parseInt(offset) + 1;
                $scope.Config.list.itemTo = parseInt(offset) + parseInt($scope.Config.list.itemperPage);
                //$scope.current_emails = emails_data.record;
                $scope.Config.list.preOffset = parseInt(offset) - parseInt($scope.Config.list.itemperPage);
                $scope.Config.list.nextOffset = parseInt(offset) + parseInt($scope.Config.list.itemperPage);
                $scope.Config.list.currentPage = (parseInt(offset) / parseInt($scope.Config.list.itemperPage)) + 1;
            });
        }
        $scope.updateTableData = function(isFilter) { // on limit change
            $scope.tasks = [];
            var filterObj;
            var searchParam = [];
            if($routeParams.id)
            {
                searchParam.push("(assign_to='"+$scope.user_info.id+"' || user_id='"+$scope.user_info.id+"')");
            }
            else if($routeParams.entity && $routeParams.number)
            {
                searchParam.push($routeParams.entity + "=" + $routeParams.number);
            }
            if ($filter("checkValidValue")($scope.Config.general.searchtasktodo))
            {
                searchParam.push("task_todo LIKE '%"+$scope.Config.general.searchtasktodo+"%'");
            }
            searchParam.push("deleted!=1");
            filter_str = searchParam.join(" and ");
            console.log(filter_str,"Filter");
            filterObj = {"filter": filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, "order": "id desc",'include_count': true};
            getTodolist.vwtodo_entity_res.get(filterObj, function(data) {
                $.each(data.record, function(key, val) {
                    val.date_created = $filter('date')(val.date_created, 'MMM dd yyyy hh:mm a');
                    if (val.completed == "true")
                    {
                        val.completed = true;
                    }
                    else
                    {
                        val.completed = false;
                    }

                    val.task_list = removeSpecialCharacter(val.task_list);
                    val.task_list = $scope.pharseJson(val.task_list);
                    if(!$.isArray(val.task_list)){
                        val.task_list = [val.task_list];
                    }
                    $.each(val.task_list, function(task_key, task_val) {
                        if ($filter("checkValidValue")(task_val.note))
                        {
                            task_val.note = task_val.note.replace(/&#92;n/g,"<br>");
                        }
                        if ($filter("checkValidValue")(task_val.user_id))
                        {
                            getEmployees.employees_resource.get({fields:'id,username',filter: "id="+task_val.user_id},
                            function(emp_data) {
                                if(emp_data.record.length > 0)
                                {
                                    task_val.user_name = emp_data.record[0].username;
                                }
                            },function(){
                                console.error(arguments);
                            });
                        }
                    });
                    if ($filter("checkValidValue")(val.user_id))
                    {
                        getEmployees.employees_resource.get({fields:'id,username',filter: "id="+val.user_id},
                        function(emp_data) {
                            if(emp_data.record.length > 0)
                            {
                                val.user_name = emp_data.record[0].username;
                            }
                        },function(){
                            console.error(arguments);
                        });
                    }
                    $scope.tasks.push(val);
                });

                tasks = $scope.tasks;
                $scope.remainingCount = filterFilter(tasks, {
                    completed: !1
                }).length;
                $scope.newTask = "";
                $scope.editedTask = null, $scope.statusFilter = {
                    completed: !1
                }, $scope.filter = function(filter) {
                    switch (filter) {
                        case "all":
                            return $scope.statusFilter = "";
                        case "active":
                            return $scope.statusFilter = {
                                completed: !1
                            };
                        case "completed":
                            return $scope.statusFilter = {
                                completed: !0
                            }
                    }
                }, $scope.clearCompleted = function() {
                    return $scope.tasks = tasks = tasks.filter(function(val) {
                        return !val.completed
                    }), taskStorage.put(tasks)
                }, $scope.$watch("remainingCount == 0", function(val) {
                    return $scope.allChecked = val
                }), $scope.$watch("remainingCount", function(newVal) {
                    return $rootScope.$broadcast("taskRemaining:changed", newVal)
                });

                /* Set config pagination parameters*/
                $scope.Config.list.itemTotalCount = data.meta.count;
                
                $scope.Config.list.preOffset = 0;
                $scope.Config.list.itemFrom = 1;
                $scope.Config.list.nextOffset = $scope.Config.list.itemperPage;
                $scope.Config.list.itemTo = $scope.Config.list.itemperPage;
                $scope.Config.list.itemTotalCount = $scope.Config.list.itemTotalCount;
                $scope.Config.list.paginationCount = $window.Math.ceil($scope.Config.list.itemTotalCount / $scope.Config.list.itemperPage);
                $scope.Config.list.currentPage = 1;
                $scope.Config.list.limitstart = 0;
                $scope.Config.list.limitend = 5;
                $scope.Config.list.pagination = $scope.buildPagination($scope.Config.list.paginationCount);

            }, function() {
                console.error(arguments);
            });
        };
        $scope.clearSearch = function() {
            $scope.Config.general.filterDBFieldname = "";
            $scope.Config.general.searchtasktodo = "";
            $scope.updateTableData();
        };
        $scope.init();
        $scope.designations = designations;
        $scope.assign_arr = [];
        $scope.get_employee = function() {
            getEmployees.employees_resource.get({filter: "status='Active'&&deleted!=1",order:"last_name"},
            function(emp_data) {
                if(emp_data.record.length > 0)
                {
                    $.each(emp_data.record, function(k, v) {
                        v.title = v.last_name + ' ' + v.first_name;
                        v.value = parseInt(v.id);
                        $scope.assign_arr.push(v);
                    });
                }
            },
            function(e)
            {
                console.error(e,"get_employee: employees_resource");
            }
            );
        }
        $scope.get_employee();

        $scope.reset = function() {
            $scope.tasks.length = 0;
            $scope.init();
        }

        $scope.isNormal = true;
        $scope.get_priority = function(prior, class_name) {
            if (class_name == 'isLow')
            {
                $scope.isLow = true;
                $scope.isNormal = false;
                $scope.isUrgent = false;
            }
            else if (class_name == 'isNormal')
            {
                $scope.isLow = false;
                $scope.isNormal = true;
                $scope.isUrgent = false;
            }
            else
            {
                $scope.isLow = false;
                $scope.isNormal = false;
                $scope.isUrgent = true;
            }
            $scope.task_priority = prior;
        }

        $scope.getAssociate = function(textVal) {
            if (textVal.indexOf(' ') > 0)
            {
                var first_name = textVal.substr(textVal.indexOf(' ') + 1);
                var last_name = textVal.substr(0, textVal.indexOf(' '));
                var filter = "(Fname like '%" + first_name + "%' && Lname like '%" + last_name + "%')&&deleted!=1";
            }
            else
            {
                var filter = "(Fname like '%" + textVal + "%' || Lname like '%" + textVal + "%')&&deleted!=1";
            }

            return $http.get(baseurl + '/rest/' + serviceName + '/associate/', {
                params: {
                    app_name: "usl",
                    fields: "Fname,Lname,id",
                    filter: filter,
                    limit: 15
                }
            }).then(function(response) {
                return response.data.record;
                return response.data.record.map(function(item) {
                    //console.log(item.name);
                    return item.name;
                });
            });
        }

        $scope.getMember = function(textVal) {
            if (textVal.indexOf(' ') > 0)
            {
                var first_name = textVal.substr(textVal.indexOf(' ') + 1);
                var last_name = textVal.substr(0, textVal.indexOf(' '));
                var filter = "(first_name like '%" + first_name + "%' && last_name like '%" + last_name + "%')&&deleted!=1";
            }
            else
            {
                var filter = "(first_name like '%" + textVal + "%' || last_name like '%" + textVal + "%')&&deleted!=1";
            }

            return $http.get(baseurl + '/rest/' + serviceName + '/member/', {
                params: {
                    app_name: "usl",
                    fields: "first_name,last_name,id",
                    filter: filter,
                    limit: 15
                }
            }).then(function(response) {
                return response.data.record;
                return response.data.record.map(function(item) {
                    //console.log(item.name);
                    return item.name;
                });
            });
        }

        $scope.getCompany = function(textVal) {
            return $http.get(baseurl + '/rest/' + serviceName + '/company/', {
                params: {
                    app_name: "usl",
                    fields: "name,id,ref_id",
                    filter: "name like '%" + textVal + "%'&&deleted!=1",
                    limit: 10
                }
            }).then(function(response) {
                return response.data.record;
                return response.data.record.map(function(item) {
                    //console.log(item.name);
                    return item.name;
                });
            });
        }

        $scope.getAttorney = function(textVal) {
            if (textVal.indexOf(' ') > 0)
            {
                var first_name = textVal.substr(textVal.indexOf(' ') + 1);
                var last_name = textVal.substr(0, textVal.indexOf(' '));
                var filter = "(first_name like '%" + first_name + "%' && last_name like '%" + last_name + "%')&&deleted!=1";
            }
            else
            {
                var filter = "(first_name like '%" + textVal + "%' || last_name like '%" + textVal + "%')&&deleted!=1";
            }

            return $http.get(baseurl + '/rest/' + serviceName + '/attorney/', {
                params: {
                    app_name: "usl",
                    fields: "first_name,last_name,id",
                    filter: filter,
                    limit: 15
                }
            }).then(function(response) {
                return response.data.record;
                return response.data.record.map(function(item) {
                    //console.log(item.name);
                    return item.name;
                });
            });
        }

        $scope.designations = designations;
        $scope.assign_arr = [];
        $scope.get_employee = function() {
            getEmployees.employees_resource.get({filter: "status='Active'&&deleted!=1"},
            function(emp_data) {
                $.each(emp_data.record, function(k, v) {
                    v.title = v.first_name + ' ' + v.last_name;
                    v.value = v.id;
                    $scope.assign_arr.push(v);
                });
            },
                    function()
                    {
                        console.error(arguments);
                    }
            );
        }

        $scope.cases = [];
        $scope.get_cases = function() {
            getTodolist.vwcases.get({filter: "deleted!=1"},
            function(case_cdl) {
                $scope.cases = case_cdl.record;
            }
            );
        }

        $scope.add = function() {
            $scope.formSubmited = false;
            $scope.showProgress = false;
            if (!$scope.form_constraints.$valid) {
                var error = $scope.form_constraints.$error;
                $scope.ngInvalidRequired = "ng-dirty";
                $scope.formSubmited = true;
                $scope.errorclass = "danger";
                if (error.pattern)
                {
                    if (error.pattern.length > 0)
                    {
                        $.each(error.pattern, function(k, v) {
                            return logger.logError("Please fill in appropriate field value!");
                        })

                    }
                }
                else
                {
                    return logger.logError("Please fill in all required (*) fields!");
                }
                return false;
            }

            var match = filterFilter($scope.designations, {value: $scope.assign_to});

            $scope.todo_fields.task_todo = $scope.todo_fields.newTask;
            $scope.todo_fields.priority = $scope.task_priority;
            if ($filter("checkValidValue")($scope.cdl_case_ref))
            {
                $scope.todo_fields.cdl_case_ref = $scope.cdl_case_ref.number;
            }
            if ($filter("checkValidValue")($scope.member_ref))
            {
                $scope.todo_fields.member_ref = $scope.member_ref.id;
            }
            if ($filter("checkValidValue")($scope.company_ref))
            {
                $scope.todo_fields.company_ref = $scope.company_ref.id;
            }
            if ($filter("checkValidValue")($scope.attorney_ref))
            {
                $scope.todo_fields.attorney_ref = $scope.attorney_ref.id;
            }
            if ($filter("checkValidValue")($scope.associate_ref))
            {
                $scope.todo_fields.associate_ref = $scope.associate_ref.id;
            }
            $scope.todo_fields.entity_area = 'Task';
            $scope.todo_fields.assign_to = $scope.assign_to;
            $scope.todo_fields.task_list = JSON.stringify([{"task": $scope.todo_fields.newTask, "note": $scope.todo_fields.note, "date": new Date(), "user_id": $scope.user_info.id}]);

            $scope.todo_fields.date_created = new Date();
            $scope.todo_fields.user_id = $scope.user_info.id;
            getTodolist.todo_note_res.save($scope.todo_fields,
                    function(data) {
                        logger.logSuccess('New Task created successfully!');
                        $scope.todo_fields.newTask = "", $scope.member_ref = "", $scope.assign_to = "", $scope.todo_fields.note = "", $scope.todo_fields.due_date = "", $scope.company_ref = "", $scope.attorney_ref = "", $scope.associate_ref = "", $scope.cdl_case_ref = "", $scope.remainingCount++;
                        $scope.form_constraints.$setPristine();
                        $scope.tasks.length = 0;
                        $scope.init();
                    },
                    function()
                    {
                        console.error(arguments);
                    }
            );
        }

        $scope.pharseJson = function(jsonString) {
            return angular.fromJson(jsonString);
        }

        $scope.remove = function(task) {
            console.log(task);
            $scope.rem_task = {"deleted":1};
            getTodolist.todo_note_res.update({id: task.id},$scope.rem_task,
            function(data) {
                logger.logError("Task removed");
                $scope.tasks.length = 0;
                $scope.init();
            },
                    function()
                    {
                        console.error(arguments);
                    }
            );
        }

        $scope.edit = function(task) {
            return $scope.editedTask = task;
        }
        $scope.doneEditing = function(task) {
            if (!$filter("checkValidValue")(task.task_todo))
            {
                logger.logError("Please fill in appropriate field value!");
                return false;
            }
            else
            {
                $scope.todo_fields = {};
                task_arr = [];
                newtask = {};
                data = {};
                $scope.todo_fields.task_todo = task.task_todo;
                $scope.todo_fields.note = task.note;
                data.task_todo =  $scope.todo_fields.task_todo;
                data.task_note = $scope.todo_fields.note;
                $scope.todo_fields.date_modified = new Date();
                task_arr = angular.fromJson(task.task_list);
                newtask = {"task": task.task_todo, "note": task.note, "date": new Date(), "user_id": $scope.user_info.id};
                task_arr.push(newtask);
                $scope.todo_fields.task_list = JSON.stringify(task_arr);
                $scope.todo_fields.assign_to = task.assign_to;
                
                if ($filter("checkValidValue")(task.assign_to) && task.email_emp == "true")
                {
                    getCompanies.contacts_resource.get({filter: "ref_id=" + task.assign_to + "&&ref='employee'&&type='Primary'"},
                    function(contact) {
                        if(contact.record.length > 0)
                        {
                            $scope.emp_email = contact.record[0].email;
                            getEmployees.employees_resource.get({id: task.assign_to},
                            function(emp_data) {
                                $scope.employee_name = emp_data.first_name +" "+ emp_data.last_name;
                                data.emp_email = $scope.emp_email;
                                data.employee_name = $scope.employee_name;
                                getTodolist.send_email_to_employee(data);
                            },function(){
                                console.error(arguments);
                            });
                        }
                        else
                        {
                            logger.logError("No email found, so email won't send!");
                        }
                    },function(){
                        console.error(arguments);
                    });
                }
                
                getTodolist.todo_note_res.update({id: task.id}, $scope.todo_fields,
                        function(data) {
                            console.log(data);
                            $scope.tasks.length = 0;
                            $scope.init();
                        },
                        function()
                        {
                            console.error(arguments);
                        }
                );
                $scope.todo_fields.note = "";
            }
        }
        $scope.markAll = function(completed) {
            if (completed == true)
            {
                completed = "true";
            }
            else
            {
                completed = "false";
            }
            var counter = 0;
            tasks.forEach(function(task) {
                counter++
                task.completed = completed;
                $scope.todo_fields = {};
                $scope.todo_fields.completed = completed;
                getTodolist.todo_note_res.update({id: task.id}, $scope.todo_fields,
                        function(data) {
                        },
                        function()
                        {
                            console.error(arguments);
                        }
                );
            });
            if (counter == tasks.length)
            {
                $scope.tasks.length = 0;
                $scope.init();
            }
        }
        $scope.confirmmodel = function(task) {
            var modalInstance;
            modalInstance = $modal.open({
                templateUrl: "confirmbox.html",
                controller: function($scope, $rootScope, $modalInstance, $location) {
                    if (task.completed == false || task.completed == "false")
                    {
                        $scope.alert_msg = "Are you sure this is completed ?";
                    }
                    else
                    {
                        $scope.alert_msg = "Are you sure this is not completed ?";
                    }
                    $scope.ok = function() {
                        $scope.todo_fields = {};
                        if (task.completed == true || task.completed == "true")
                        {
                            task.completed = "false";
                            $scope.todo_fields.date_completed = new Date();
                            $scope.todo_fields.user_id = user_id;
                            task.date_completed = new Date();
                            task.user_name = user_name;
                            task.checkinfo = false;
                        }
                        else
                        {
                            task.completed = "true";
                            $scope.todo_fields.date_completed = new Date();
                            $scope.todo_fields.user_id = user_id;
                            task.date_completed = new Date();
                            task.user_name = user_name;
                            task.checkinfo = false;
                        }
                        $scope.todo_fields.completed = task.completed;
                        getTodolist.todo_note_res.update({id: task.id}, $scope.todo_fields,
                                function(data) {
                                },
                                function()
                                {
                                    console.error(arguments);
                                }
                        );
                        $modalInstance.dismiss("cancel");
                    }
                    $scope.cancel = function() {
                        task.checkinfo = false;
                        $modalInstance.dismiss("cancel");
                    }
                }
            });
        }

    }])
.filter('nl2br', ['$sce', function ($sce) {
    return function (text) {
        return text ? $sce.trustAsHtml(text.replace(/\n/g, '<br/>')) : '';
    };
}])
get_task_model.controller('recent_todo', ['getTodolist', 'getAgents', 'getMembs', 'getCompanies', 'getAttorney', 'getServices', 'getMatters', 'getEmployees', 'filterFilter', '$routeParams', '$scope', '$window', '$location', '$filter', '$http', '$cookieStore', '$rootScope', 'logger', "$q", function(getTodolist, getAgents, getMembs, getCompanies, getAttorney, getServices, getMatters, getEmployees, filterFilter, $routeParams, $scope, $window, $location, $filter, $http, $cookieStore, $rootScope, logger, $q) {
        $scope.$on("todo_task", function (event, count) {
            if ($filter("checkValidValue")($cookieStore.get('user_info')))
            {
                $scope.user_info = $cookieStore.get('user_info');
                $scope.logged_user = $scope.user_info.id;
                getTodolist.vwtodo_entity_res.get({filter: "assign_to='"+$scope.user_info.id+"' || user_id='"+$scope.user_info.id+"'&&completed='false'&&status=1"}, function(data) {
                    $scope.active_todo = data.record;
                    $scope.count = data.record.length;
                },function(){
                    console.error(arguments);
                });
            }
            // return $scope.taskRemainingCount = $scope.count;
        });
}]);