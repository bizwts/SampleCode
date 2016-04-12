get_states_model.controller('state', ['get_States', 'getOrgs', 'getEmployees', '$routeParams', '$scope', '$rootScope', '$window', '$location', '$filter', '$cookieStore', 'filterFilter', 'logger', function(get_States, getOrgs, getEmployees, $routeParams, $scope, $rootScope, $window, $location, $filter, $cookieStore, filterFilter, logger) {
        if ($filter("checkValidValue")($cookieStore.get('user_info')))
        {
            $scope.user_info = $cookieStore.get('user_info');
            $scope.logged_user = $scope.user_info.id;
        }
        getOrgs.orgs_resource.get({filter: "deleted!=1"},
        function(org_details) {
            $scope.orgs = org_details.record;
        },
                function()
                {
                    console.log(arguments);
                }
        );
        $scope.last_update = "Record is not added yet. Click on SAVE button to add record";
        if (!$routeParams.id)
        {
            var planclass = get_States.plan_class_res.get({filter: "status=1"}, function() {
                $scope.planclass_list = planclass.record;
            });
        }

        $scope.$watch(function(newValues, oldValues) {
            if ($scope.form_state.$pristine == false)
            {
                $rootScope.notify = true;
            }
        })

        $scope.init = function() {
            $scope.ctrl_disable = false;
            if ($routeParams.id)
            {
                if($routeParams.mode){
                    $scope.ctrl_disable = true;
                }
                $scope.action_label = 'SAVE';
                get_States.states_resource.get({id: $routeParams.id},
                function(state_details) {
                    $scope.state = state_details;
                    $scope.planclass_list = [];
                    get_States.plan_class_res.get({filter: "status=1"}, function(planclasses) {
                        $.each(planclasses.record, function(key, val) {
                            get_States.state_planclass_res.get({filter: "state_id=" + $routeParams.id + "&&planclass_id=" + val.id},
                            function(state_plans)
                            {
                                val.value = state_plans.record[0].value;
                            }
                            );
                            $scope.planclass_list.push(val);
                        });
                    });
                    getEmployees.employees_resource.get({id: state_details.user_id},
                    function(emp_data) {
                        $scope.user_name = emp_data.username;
                        var last_mod = $filter('date')(state_details.datemodified, 'MMM dd yyyy');
                        if (last_mod)
                        {
                            $scope.last_update = "Last updated on " + last_mod + " by " + $scope.user_name;
                        }
                        else
                        {
                            var create_mod = $filter('date')(state_details.datecreated, 'MMM dd yyyy');
                            $scope.last_update = "Created on " + create_mod + " by " + $scope.user_name;
                        }
                    }, function() {
                        console.error(arguments);
                    });

                    $scope.state.org_id = state_details.org_id;
                },
                        function()
                        {
                            console.log(arguments);
                        }
                );
            }
        }
        $scope.init();
        $scope.stateList = [];

        $scope.get_states = function()
        {
            var statelist = get_States.all_state.get(function() {
                $scope.stateList = statelist.record;
            });
        }

        $scope.add_state = function() {

            $scope.formSubmited = false;
            $scope.showProgress = false;
            if (!$scope.form_state.$valid) {

                $scope.ngInvalidRequired = "ng-dirty";
                $scope.formSubmited = true;
                $scope.errorclass = "danger";
                return logger.logError("Please fill in all required (*) fields!");
                return false;
            }
            $scope.form_state.$pristine = true;
            $scope.state.user_id = $scope.logged_user;
            if ($routeParams.id)
            {
                $rootScope.notify = false;
                $scope.action_label = "SAVE";
                select_planclass = filterFilter($scope.planclass_list, {value: 'Yes'});
                if (select_planclass.length > 0)
                {
                    get_States.all_state.get({filter: "STATECD='" + $scope.state.code + "'"}, function(state_data) {
                        if (state_data.record.length > 0)
                        {
                            get_States.states_resource.get({id: $routeParams.id},
                            function(data) {
                                console.log(data);
                                if ($scope.state.code == data.code)
                                {
                                    $scope.state.datemodified = new Date();

                                    get_States.states_resource.update({id: $routeParams.id}, $scope.state,
                                            function(data) {
                                                getEmployees.employees_resource.get({id: data.user_id},
                                                function(emp_data) {
                                                    $scope.user_name = emp_data.username;
                                                    var last_mod = $filter('date')(data.datemodified, 'MMM dd yyyy');
                                                    if (last_mod)
                                                    {
                                                        $scope.last_update = "Last updated on " + last_mod + " by " + $scope.user_name;
                                                    }
                                                    else
                                                    {
                                                        var create_mod = $filter('date')(data.datecreated, 'MMM dd yyyy');
                                                        $scope.last_update = "Created on " + create_mod + " by " + $scope.user_name;
                                                    }
                                                }, function() {
                                                    console.error(arguments);
                                                });
                                                console.log(data);
                                                state_id = $routeParams.id;
                                                get_States.state_planclass_res.remove({filter: "state_id=" + $routeParams.id},
                                                function(remove_data)
                                                {
                                                    state_class_arr = [];
                                                    $.each($scope.planclass_list, function(key, val) {
                                                        val.state_id = state_id;
                                                        val.planclass_id = val.id;
                                                        state_class_arr.push(val);
                                                    });
                                                    get_States.state_planclass_res.save(state_class_arr,
                                                            function(state_plan)
                                                            {
                                                                console.log(state_plan);
                                                            },
                                                            function()
                                                            {
                                                                console.error(arguments);
                                                            }
                                                    );
                                                }
                                                );
                                                $scope.form_state.$pristine = true;
                                                $scope.state.name = data.name;
                                                return logger.logSuccess("State details updated successfully!");
                                            },
                                            function() {
                                                console.log(arguments);
                                                return logger.logError("Please fill in appropriate field value!");
                                            }
                                    );
                                }
                                else
                                {
                                    get_States.states_resource.get({filter: "code='" + $scope.state.code + "'&&deleted!=1"},
                                    function(state_details) {

                                        if (state_details.record.length > 0)
                                        {
                                            return logger.logError("State is already selected");
                                        }
                                        else
                                        {
                                            $scope.state.datemodified = new Date();

                                            get_States.states_resource.update({id: $routeParams.id}, $scope.state,
                                                    function(data) {
                                                        console.log(data);
                                                        $scope.state.name = data.name;
                                                        return logger.logSuccess("State details updated successfully!");
                                                    },
                                                    function() {
                                                        console.log(arguments);
                                                        return logger.logError("Please fill in appropriate field value!");
                                                    }
                                            );
                                        }


                                    },
                                            function()
                                            {
                                                console.log(arguments);
                                            }
                                    );
                                }
                            },
                                    function() {
                                        console.log(arguments);
                                        return logger.logError("Please fill in appropriate field value!");
                                    }
                            );
                        }
                        else
                        {
                            $scope.validinfo = "ng-invalid";
                            return logger.logError("Please fill in appropriate field value!");
                            return false;
                        }
                    });
                }
                else
                {
                    return logger.logError("Select at least one plan class!");
                    return false;
                }
            }
            else
            {
                $rootScope.notify = false;
                $scope.action_label = "SAVE";
                select_planclass = filterFilter($scope.planclass_list, {value: 'Yes'});
                if (select_planclass.length > 0)
                {
                    get_States.all_state.get({filter: "STATECD='" + $scope.state.code + "'"}, function(state_data) {
                        if (state_data.record.length > 0)
                        {
                            get_States.states_resource.get({filter: "code='" + $scope.state.code + "'&&deleted!=1"},
                            function(state_details) {
                                if (state_details.record.length > 0)
                                {
                                    return logger.logError("State is already selected");
                                }
                                else
                                {

                                    $scope.state.datecreated = new Date();
                                    get_States.states_resource.save($scope.state,
                                            function(data) {
                                                state_id = data.id;
                                                state_class_arr = [];
                                                $.each($scope.planclass_list, function(key, val) {
                                                    val.state_id = state_id;
                                                    val.planclass_id = val.id;
                                                    state_class_arr.push(val);
                                                });
                                                get_States.state_planclass_res.save(state_class_arr,
                                                        function(state_plan)
                                                        {
                                                            console.log(state_plan);
                                                        },
                                                        function()
                                                        {
                                                            console.error(arguments);
                                                        }
                                                );
                                                $location.path("/usl/add_state/" + data.id);
                                                $location.replace();
                                                return logger.logSuccess("New State created successfully!");
                                            },
                                            function() {
                                                console.log(arguments);
                                                return logger.logError("Please fill in appropriate field value!");
                                            }
                                    );
                                }

                            },
                                    function()
                                    {
                                        console.log(arguments);
                                    }
                            );
                        }
                        else
                        {
                            $scope.validinfo = "ng-invalid";
                            return logger.logError("Please fill in appropriate field value!");
                            return false;
                        }
                    },
                            function()
                            {
                                console.log(arguments);
                            }
                    );
                }
                else
                {
                    return logger.logError("Select at least one plan class!");
                    return false;
                }
            }

        }
        $scope.reset = function() {
            if ($routeParams.id)
            {
                $rootScope.notify = false;
                $location.path("/usl/add_state/" + $routeParams.id + "/");
                $location.replace();
            }
            else
            {
                $rootScope.notify = false;
                $location.path("/usl/add_state/");
                $location.replace();
            }
        }
        $scope.cancel = function() {
            $rootScope.notify = false;
            $location.path("/usl/state_master/");
            $location.replace();
        }
    }])

get_states_model.controller('list_states', ['get_States', 'getStates', '$routeParams', '$window', '$scope', '$rootScope', '$filter', '$cookieStore', '$modal', function(get_States, getStates, $routeParams, $window, $scope, $rootScope, $filter, $cookieStore, $modal) {

        /* @WTS User Access */
        $scope.state_edit_user_access = [{"value": "All Access"}];
        $scope.state_add_user_access = [{"value": "All Access"}];
        $scope.state_del_user_access = [{"value": "All Access"}];
        $scope.state_view_user_access = [{"value":"Accounting Clerk"},{"value":"Accounting Supervisor"}, {"value": "Administrative"}];

        if ($filter("checkValidValue")($cookieStore.get('user_info')))
        {
            $scope.user_info = $cookieStore.get('user_info');
        }
        $scope.date = $filter('date')(new Date(), 'yyyy-MM-dd');
        
        var statelist = getStates.get(function() {
            $scope.stateList = statelist.record;
        });

        $scope.Config = {};
        $scope.Config.general = {};
        $scope.Config.list = {};

        $scope.init = function() {
            var init;
            $rootScope.notify = false;

            get_States.state_view.get({'filter': 'deleted!=1', 'include_count': true}, function(data) {
                $scope.total_state = data.meta.count;

                $scope.Config.list.itemperPage = 10;
                $scope.Config.list.itemFrom = 1;
                $scope.Config.list.preOffset = 0;
                $scope.Config.list.nextOffset = $scope.Config.list.itemperPage;
                $scope.Config.list.itemTo = $scope.Config.list.itemperPage;
                $scope.Config.list.itemTotalCount = $scope.total_state;//data.record.length;
                $scope.Config.list.paginationCount = $window.Math.ceil($scope.Config.list.itemTotalCount / $scope.Config.list.itemperPage);
                $scope.Config.list.currentPage = 1;
                $scope.Config.list.limitstart = 0;
                $scope.Config.list.limitend = $scope.Config.list.limitstart + 5;
                $scope.Config.general.searchtxt = "";
                $scope.Config.general.filterDBField = "";
                $scope.Config.general.filterDBOptions = [];
                $scope.Config.general.filterDBOptionsname = [];
                $scope.Config.list.pagination = $scope.buildPagination($scope.Config.list.paginationCount);
                
                filterObj = {'filter': 'deleted!=1', 'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': 'id desc'};
                get_States.state_view.get(filterObj,
                        function(data) {
                            $scope.current_states = data.record;
                        },
                        function() {

                        }
                )

            }, function() {
                console.error(arguments);
            })
        }
        filter_str = "";

        $scope.getNextData = function(offset) {
            if (!$filter("checkValidValue")(filter_str))
            {
                filter_str = "deleted != 1";
            }
            else
            {
                filter_str = filter_str + " && deleted != 1";
            }
            if ($scope.sortme) {
                filterObj = {'filter': filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, 'offset': offset, 'order': $scope.sortField + ' ' + $scope.sortType};
            } else {
                filterObj = {'filter': filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, 'offset': offset, 'order': 'id desc'};
            }

            get_States.state_view.get(filterObj, function(data) {
                $scope.Config.list.itemFrom = parseInt(offset) + 1;
                $scope.Config.list.itemTo = parseInt(offset) + parseInt($scope.Config.list.itemperPage);
                $scope.current_states = data.record;
                $scope.Config.list.preOffset = parseInt(offset) - parseInt($scope.Config.list.itemperPage);
                $scope.Config.list.nextOffset = parseInt(offset) + parseInt($scope.Config.list.itemperPage);
                $scope.Config.list.currentPage = (parseInt(offset) / parseInt($scope.Config.list.itemperPage)) + 1;
                if ($scope.Config.list.currentPage > 4)
                {
                    $scope.Config.list.limitstart = (parseInt(offset) / parseInt($scope.Config.list.itemperPage));
                    $scope.Config.list.limitend = $scope.Config.list.limitstart + 5;
                }
            })
        }

        $scope.indexValue = function(arr, txt) {

            var index_val = arr.indexOf(txt);
            var indx;
            if (index_val == -1) {
                indx = "";
            } else {
                indx = $scope.Config.general.filterDBOptionsname[index_val]['name'];
            }
            return indx;

        }

        $scope.buildPagination = function(paginationCount) {
            console.log(paginationCount);
            var Temp = [];
            for (var i = 1; i <= paginationCount; i++) {

                Temp.push({offset: ((i - 1) * $scope.Config.list.itemperPage), number: i});

            }
            console.log(Temp);
            return Temp;
        }

        $scope.updateTableData = function(isFilter) { 

            filter_str = " && deleted != 1";
            if ($filter("checkValidValue")($scope.Config.general.searchtxt))
            {
                filter_str += " && code = '" + $scope.Config.general.searchtxt + "'";
            }

            filter_str = filter_str.slice(3, filter_str.length);
            console.log(filter_str);

            var filterObj;


            $scope.Config.general.filterDBField = $scope.indexValue($scope.Config.general.filterDBOptions, $scope.Config.general.filterDBFieldname);

            if ($scope.Config.general.searchtxt && $scope.Config.general.filterDBField) {
                isFilter = true;
            }

            if (isFilter && !$scope.Config.general.filterDBField) {

                if ($scope.sortme) {

                    filterObj = {'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': $scope.sortField + ' ' + $scope.sortType, 'filter': filter_str};

                } else {
                    filterObj = {'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': 'id desc', 'filter': filter_str};
                }

            } else if (isFilter && $scope.Config.general.filterDBField) {

                if ($scope.sortme) {

                    filterObj = {'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': $scope.sortField + ' ' + $scope.sortType, 'filter': $scope.Config.general.filterDBField + ' like "%' + $scope.Config.general.searchtxt + '%"'};

                } else {
                    filterObj = {'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': 'id desc', 'filter': $scope.Config.general.filterDBField + ' like "%' + $scope.Config.general.searchtxt + '%"'};
                }

            } else {
                if ($scope.sortme) {
                    filterObj = {'filter': filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': $scope.sortField + ' ' + $scope.sortType};
                } else {
                    filterObj = {'filter': filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': 'id desc'};
                }
            }
            
            get_States.state_view.get(filterObj, function(data) {
                $scope.Config.list.itemTotalCount = data.meta.count;
                $scope.current_states = data.record;
                $scope.Config.list.preOffset = 0;
                $scope.Config.list.itemFrom = 1;
                $scope.Config.list.nextOffset = $scope.Config.list.itemperPage;
                $scope.Config.list.itemTo = $scope.Config.list.itemperPage;
                $scope.Config.list.paginationCount = $window.Math.ceil($scope.Config.list.itemTotalCount / $scope.Config.list.itemperPage);
                $scope.Config.list.currentPage = 1;
                $scope.Config.list.limitstart = 0;
                $scope.Config.list.limitend = 5;
                $scope.Config.list.pagination = $scope.buildPagination($scope.Config.list.paginationCount);
                console.log($scope.Config)
            }, function() {
                console.error(arguments);
            })
        }

        $scope.updatePageShow = function(isFilter) {

            filter_str = " && deleted != 1";

            if ($filter("checkValidValue")($scope.Config.general.searchtxt))
            {
                filter_str += " && code = '" + $scope.Config.general.searchtxt + "'";
            }

            filter_str = filter_str.slice(3, filter_str.length);
            console.log(filter_str);

            var filterObj;


            $scope.Config.general.filterDBField = $scope.indexValue($scope.Config.general.filterDBOptions, $scope.Config.general.filterDBFieldname);

            if ($scope.Config.general.searchtxt && $scope.Config.general.filterDBField) {
                isFilter = true;
            }

            if (isFilter && !$scope.Config.general.filterDBField) {

                if ($scope.sortme) {

                    filterObj = {'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': $scope.sortField + ' ' + $scope.sortType, 'filter': filter_str};

                } else {
                    filterObj = {'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': 'id desc', 'filter': filter_str};
                }

            } else if (isFilter && $scope.Config.general.filterDBField) {

                if ($scope.sortme) {

                    filterObj = {'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': $scope.sortField + ' ' + $scope.sortType, 'filter': $scope.Config.general.filterDBField + ' like "%' + $scope.Config.general.searchtxt + '%"'};

                } else {
                    filterObj = {'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': 'id desc', 'filter': $scope.Config.general.filterDBField + ' like "%' + $scope.Config.general.searchtxt + '%"'};
                }

            } else {
                if ($scope.sortme) {
                    filterObj = {'filter': filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': $scope.sortField + ' ' + $scope.sortType};
                } else {
                    filterObj = {'filter': filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, 'order': 'id desc'};
                }
            }
            
            get_States.state_view.get(filterObj, function(data) {
                $scope.current_states = data.record;
                $scope.Config.list.preOffset = 0;
                $scope.Config.list.itemFrom = 1;
                $scope.Config.list.nextOffset = $scope.Config.list.itemperPage;
                $scope.Config.list.itemTo = $scope.Config.list.itemperPage;
                $scope.Config.list.paginationCount = $window.Math.ceil($scope.Config.list.itemTotalCount / $scope.Config.list.itemperPage);
                $scope.Config.list.currentPage = 1;
                $scope.Config.list.limitstart = 0;
                $scope.Config.list.limitend = 5;
                $scope.Config.list.pagination = $scope.buildPagination($scope.Config.list.paginationCount);
                console.log($scope.Config)
            })
        }

        $scope.clearSearch = function() {
            $scope.Config.general.filterDBFieldname = "";
            $scope.Config.general.searchtxt = "";
            $scope.Config.general.searchdesc = "";
            $scope.Config.general.searchstate = "";
            $scope.Config.list.itemTotalCount = $scope.total_state;
            $scope.updateTableData();
        }
        $scope.sortType = "desc";
        $scope.sortMe = function(fieldName, thisClass) {

            jQuery(".sortable i").addClass("fa-sort");
            jQuery(".sortable i").removeClass("fa-sort-down");
            jQuery(".sortable i").removeClass("fa-sort-up");
            $scope.sortme = true;
            $scope.sortField = fieldName;


            if ($scope.sortType == "asc") {
                $scope.sortType = "desc";
                jQuery("." + thisClass + " i").removeClass("fa-sort");
                jQuery("." + thisClass + " i").removeClass("fa-sort-up");
                jQuery("." + thisClass + " i").addClass("fa-sort-down");
            } else if ($scope.sortType == "desc") {
                $scope.sortType = "asc";
                jQuery("." + thisClass + " i").removeClass("fa-sort");
                jQuery("." + thisClass + " i").removeClass("fa-sort-down");
                jQuery("." + thisClass + " i").addClass("fa-sort-up");
            }
            $scope.updateTableData();

            //console.log(Element.currentTarget);
        }

        $scope.$on('confirm_box', function(event, args) {
            $scope.del_conf = false;
        });

        $scope.del_conf = false;
        $scope.remove_record = function(state_id, index, items) {
            $scope.del_conf = true;
            var modalInstance;
            modalInstance = $modal.open({
                templateUrl: "delConfirm.html",
                controller: function($scope, $rootScope, $modalInstance, $location, logger) {
                    $scope.ok = function() {
                        $scope.state_update = {"deleted": 1};
                        get_States.states_resource.update({id: state_id}, $scope.state_update, function(state_data) {
                            console.log(state_data);
                            return logger.logSuccess("State deleted successfully!");
                        }, function() {
                            console.error(arguments);
                            return logger.logError("State could not delete!");
                        });
                        $scope.current_states = items.splice(index, 1);
                        $rootScope.$broadcast('confirm_box');
                        $modalInstance.dismiss("cancel");
                    }

                    $scope.cancel = function() {
                        $rootScope.$broadcast('confirm_box');
                        $modalInstance.dismiss("cancel");
                    }
                },
                resolve: {
                    items: function() {
                        //return $scope.items
                    }
                }
            });
        }
        
        $scope.init();

    }]);