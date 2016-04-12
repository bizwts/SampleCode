get_orgs_model.controller('organization', ['getOrgs', 'zip_codes', 'getAttorney', 'getEmployees', 'getCompanies', '$routeParams', '$timeout', '$scope', '$rootScope', '$window', '$location', '$filter', '$modal', '$cookieStore', 'logger', function(getOrgs, zip_codes, getAttorney, getEmployees, getCompanies, $routeParams, $timeout, $scope, $rootScope, $window, $location, $filter, $modal, $cookieStore, logger) {
        if ($filter("checkValidValue")($cookieStore.get('user_info')))
        {
            $scope.user_info = $cookieStore.get('user_info');
            $scope.logged_user = $scope.user_info.id;
        }
        $scope.telePhoneValidation = /^\([0-9]{3}\)[0-9]{3}-[0-9]{4}$/;
        $scope.pinvalidation = /^\d{5}(-\d{4})?$/;
        $scope.DecimalNumber = /^[0-9]{1,9}(\.[0-9]{0,5})?$/;
        $scope.email_validation = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

        $scope.addresses = [{type: '', address1: '', address2: '', city: '', state: '', county: '', zip: ''}];
        $scope.add_address = function() {
            $scope.addresses.push({type: '', address1: '', address2: '', city: '', state: '', county: '', zip: ''});
        };

        $scope.contacts = [{type: '', title: '', name: '', email: '', phone: ''}];
        $scope.add_cont = function() {
            $scope.contacts.push({type: '', title: '', name: '', email: '', phone: ''});
        };

        $scope.$watch(function(newValues, oldValues) {
            if ($scope.form_constraints.$pristine == false)
            {
                $rootScope.notify = true;
            }
        });

        $scope.last_update = "Record is not added yet. Click on SAVE button to add record";

        $scope.check_avail = function()
        {
            if (!$filter("checkValidValue")($routeParams.id))
            {
                var cond = "name='" + $scope.org.name + "'";
            } else
            {
                var cond = "name='" + $scope.org.name + "'&&id!=" + $routeParams.id;
            }

            getOrgs.orgs_resource.get({filter: cond},
            function(org_details) {
                if (org_details.record.length > 0)
                {
                    $scope.ngOrgName = "ng-invalid";
                    $scope.errorclass = "danger";
                    return logger.logError("Organization name not available.");
                } else
                {
                    $scope.ngOrgName = "ng-valid";
                }
            },
            function()
            {
                console.log(arguments);
            }
            );
        };

        $scope.check_code = function() {

            if (!$filter("checkValidValue")($routeParams.id))
            {
                var cond = "code='" + $scope.org.code + "'";
            } 
            else
            {
                var cond = "code='" + $scope.org.code + "'&&id!=" + $routeParams.id;
            }

            getOrgs.orgs_resource.get({filter: cond},
            function(org_details) {
                if (org_details.record.length > 0)
                {
                    $scope.ngOrgCode = "ng-invalid";
                    $scope.errorclass = "danger";
                    return logger.logError("Organization code not available.");
                } else
                {
                    $scope.ngOrgCode = "ng-valid";
                }
            },
                    function()
                    {
                        console.log(arguments);
                    }
            );
        };

        $scope.get_state_county = function() {
            $.each($scope.addresses, function(k, v) {
                if (v.zip != '')
                {
                    zip_codes.get({filter: "Zipcode='" + v.zip +"'"},
                        function(data)
                        {
                            if (data.record.length > 0)
                            {
                                v.city = data.record[0].City;
                                v.state = data.record[0].State;
                                v.county = data.record[0].County;
                            } else
                            {
                                return logger.logWarning("ZIP Code not found");
                            }

                        },
                        function()
                        {
                            console.error(arguments);
                        }
                    );
                }
            });
        };
        
        $scope.$on('del_plan', function(event, args, arr_assoc) {
            $scope.show_box = false;
            arr_assoc.splice(args, 1);
            //$scope.check_cdl();
        });
        $scope.$on('cancel', function(event, args) {
            $scope.show_box = false;
        });
        
        $scope.show_box = false;
        $scope.remove_this = function(ind,arr_rec) {
            $scope.show_box = true;
            var modalInstance;
            modalInstance = $modal.open({
                templateUrl: "delConfirm.html",
                controller: function($scope, $rootScope, $modalInstance, $location, logger) {
                    $scope.ok = function() {
                        $rootScope.$broadcast('del_plan',ind,arr_rec);
                        $modalInstance.dismiss("cancel");
                    }
                    $scope.cancel = function() {
                        $rootScope.$broadcast('cancel');
                        $modalInstance.dismiss("cancel");
                    }
                },
                resolve: {
                    items: function() {
                    }
                }
            });
        }

        $scope.init = function() {
            $scope.ctrl_disable = false;
            if ($routeParams.id)
            {
                if($routeParams.mode){
                    $scope.ctrl_disable = true;
                }
                $scope.action_label = 'SAVE';
                getOrgs.orgs_resource.get({id: $routeParams.id},
                function(org_details) {
                    $scope.org = org_details;
                    $scope.org.max_overpayment = $filter('number')(org_details.max_overpayment, 2);

                    getEmployees.employees_resource.get({id: org_details.user_id},
                    function(emp_data) {
                        $scope.user_name = emp_data.username;
                        var last_mod = $filter('date')(org_details.datemodified, 'MMM dd yyyy');
                        if (last_mod)
                        {
                            $scope.last_update = "Last updated on " + last_mod + " by " + $scope.user_name;
                        }
                        else
                        {
                            var create_mod = $filter('date')(org_details.datecreated, 'MMM dd yyyy');
                            $scope.last_update = "Created on " + create_mod + " by " + $scope.user_name;
                        }
                    }, function() {
                        console.error(arguments);
                    });

                },
                        function()
                        {
                            console.log(arguments);
                        }
                );
                getCompanies.addresses_resource.get({filter: "ref_id=" + $routeParams.id + "&&ref='organization'"},
                function(mul_add) {
                    $scope.addresses = mul_add.record;
                    if ($scope.addresses.length < 1)
                    {
                        $scope.addresses = [{type: '', address1: '', address2: '', city: '', state: '', county: '', zip: ''}];
                    }
                },
                        function() {
                            console.error(arguments);
                        }
                );
                getCompanies.contacts_resource.get({filter: "ref_id=" + $routeParams.id + "&&ref='organization'"},
                function(mul_cont) {
                    $scope.contacts = mul_cont.record;
                    if ($scope.contacts.length < 1)
                    {
                        $scope.contacts = [{type: '', title: '', name: '', email: '', phone: ''}];
                    }
                },
                        function() {
                            console.error(arguments);
                        }
                );
            }
        };

        $scope.init();
        $scope.showBtn = false;
        $scope.stateList = [];

        $scope.get_states = function()
        {
            var statelist = getCompanies.all_state.get(function() {
                $scope.stateList = statelist.record;
            });
        };

        $scope.Counties = [];
        $scope.get_county = function()
        {
            getCompanies.all_state.get({filter: "STATECD='" + $scope.addresses[0].state + "'"}, function(state_name) {

                getAttorney.all_counties.get({filter: "usstate='" + state_name.record[0].STATENAME + "'"},
                    function(cnts)
                    {
                        $scope.Counties = cnts.record;
                    },
                    function()
                    {
                        console.error(arguments, "Cnt Error!");
                    }
                );
            });
        };

        $scope.displayDecimal = function(vals) {
            $scope.org.max_overpayment = $filter('number')(vals, 2);
        };
        $scope.add_org = function() {
            $scope.showBtn = true;
            $timeout(function() {
                $scope.showBtn = false;
            }, 4000);
            if (!$scope.form_constraints.$valid) {
                var error = $scope.form_constraints.$error;
                $scope.ngInvalidRequired = "ng-dirty";
                $scope.formSubmited = true;
                $scope.errorclass = "danger";
                if (error.pattern)
                {
                    if (error.pattern.length > 0)
                    {
                        return logger.logError("Please fill in appropriate field value!");
                    }
                }
                else
                {
                    return logger.logError("Please fill in all required (*) fields!");
                }
                return false;
            }


            if (!$filter("checkValidValue")($routeParams.id))
            {
                var cond = "name='" + $scope.org.name + "'";
            } else
            {
                var cond = "name='" + $scope.org.name + "'&&id!=" + $routeParams.id;
            }
            for (var i = 0; i < $scope.contacts.length; i++)
            {
                if ($scope.contacts[i].type == "" && $scope.contacts[i].name == "" && $scope.contacts[i].title == "" && $scope.contacts[i].email == "" && $scope.contacts[i].phone == "")
                {
                    $scope.contacts.splice(i, 1);
                    i--;
                }
            }
            $scope.form_constraints.$pristine = true;
            getOrgs.orgs_resource.get({filter: cond},
            function(org_details) {

                if (org_details.record.length > 0)
                {
                    $scope.ngOrgName = "ng-invalid";
                    $scope.errorclass = "danger";
                    return logger.logError("Organization name not available.");
                    return false;
                } else
                {
                    if (!$filter("checkValidValue")($routeParams.id))
                    {
                        var cond = "code='" + $scope.org.code + "'";
                    } else
                    {
                        var cond = "code='" + $scope.org.code + "'&&id!=" + $routeParams.id;
                    }
                    getOrgs.orgs_resource.get({filter: cond},
                    function(org_details) {
                        if (org_details.record.length > 0)
                        {
                            $scope.ngOrgCode = "ng-invalid";
                            $scope.errorclass = "danger";
                            return logger.logError("Organization code not available.");
                            return false;
                        } else
                        {
                            $scope.ngOrgCode = "ng-valid";
                            $scope.formSubmited = false;
                            $scope.showProgress = false;
                            $scope.org.user_id = $scope.logged_user;
                            if ($routeParams.id)
                            {
                                $rootScope.notify = false;
                                $scope.action_label = "SAVE";
                                $scope.org.datemodified = new Date();
                                getOrgs.orgs_resource.update({id: $routeParams.id}, $scope.org,
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
                                            $scope.org_id = data.id;
                                            if ($scope.addresses.length > 0)
                                            {
                                                getCompanies.addresses_resource.remove({filter: "ref_id=" + data.id + "&&ref='organization'"},
                                                function(data) {
                                                    $scope.add_arr = []
                                                    $.each($scope.addresses, function(k, v) {
                                                        delete v.id;
                                                        v.ref_id = $scope.org_id;
                                                        v.ref = "organization";
                                                        $scope.add_arr.push(v)
                                                    })

                                                    getCompanies.addresses_resource.save($scope.add_arr,
                                                            function(data) {
                                                                console.log(data);
                                                            },
                                                            function() {
                                                                console.error(arguments);
                                                            }
                                                    )
                                                },
                                                        function() {
                                                            console.error(arguments);
                                                        }
                                                );
                                            }
                                            else
                                            {
                                                getCompanies.addresses_resource.remove({filter: "ref_id=" + data.id + "&&ref='organization'"},
                                                function(data) {
                                                    console.log("delete");
                                                },
                                                        function() {
                                                            console.error(arguments);
                                                        }
                                                );
                                            }
                                            if ($scope.contacts.length > 0)
                                            {
                                                getCompanies.contacts_resource.remove({filter: "ref_id=" + data.id + "&&ref='organization'"},
                                                function(data) {
                                                    $scope.cont_arr = []
                                                    $.each($scope.contacts, function(k, v) {
                                                        delete v.id;
                                                        v.ref_id = $scope.org_id;
                                                        v.ref = "organization";
                                                        $scope.cont_arr.push(v)
                                                    })
                                                    console.log($scope.cont_arr);
                                                    getCompanies.contacts_resource.save($scope.cont_arr,
                                                            function(data) {
                                                                console.log(data);
                                                            },
                                                            function() {
                                                                console.error(arguments);
                                                            }
                                                    )
                                                },
                                                        function() {
                                                            console.error(arguments);
                                                        }
                                                );
                                            }
                                            else
                                            {
                                                getCompanies.contacts_resource.remove({filter: "ref_id=" + data.id + "&&ref='organization'"},
                                                function(data) {
                                                    console.log("delete");
                                                },
                                                        function() {
                                                            console.error(arguments);
                                                        }
                                                );
                                            }
                                            $scope.form_constraints.$pristine = true;

                                            return logger.logSuccess("Organization details updated successfully!");
                                        },
                                        function() {
                                            console.log(arguments);
                                            return logger.logError("Please fill in appropriate field value!");
                                        }
                                );
                            }
                            else
                            {
                                $rootScope.notify = false;
                                $scope.action_label = "SAVE";
                                $scope.org.datecreated = new Date();
                                getOrgs.orgs_resource.save($scope.org,
                                        function(data) {
                                            $scope.org_id = data.id;

                                            $scope.add_arr = []
                                            $.each($scope.addresses, function(k, v) {
                                                v.ref_id = $scope.org_id;
                                                v.ref = "organization";
                                                $scope.add_arr.push(v)
                                            })

                                            getCompanies.addresses_resource.save($scope.add_arr,
                                                    function(data) {
                                                        console.log(data);
                                                    },
                                                    function() {
                                                        console.error(arguments);
                                                    }
                                            )

                                            $scope.cont_arr = []
                                            $.each($scope.contacts, function(k, v) {
                                                v.ref_id = $scope.org_id;
                                                v.ref = "organization";
                                                $scope.cont_arr.push(v)
                                            })

                                            getCompanies.contacts_resource.save($scope.cont_arr,
                                                    function(data) {
                                                        console.log(data);
                                                    },
                                                    function() {
                                                        console.error(arguments);
                                                    }
                                            )
                                            $scope.form_constraints.$pristine = true;
                                            $location.path("/usl/organization/" + data.id);
                                            $location.replace();
                                            return logger.logSuccess("New Organization created successfully!");
                                        },
                                        function() {
                                            console.log(arguments);
                                            return logger.logError("Please fill in appropriate field value!");
                                        }
                                );
                            }
                        }
                    },
                            function()
                            {
                                console.log(arguments);
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
        $scope.reset = function() {
            if ($routeParams.id)
            {
                $rootScope.notify = false;
                $location.path("/usl/organization/" + $routeParams.id + "/");
                $location.replace();
            }
            else
            {
                $rootScope.notify = false;
                $location.path("/usl/organization/");
                $location.replace();
            }
        }
        $scope.cancel = function() {
            $rootScope.notify = false;
            $location.path("/usl/organizations/");
            $location.replace();
        }
    }])

get_orgs_model.filter('getAdressName', function() {
    return function(input1, input, refId) {
        var temp = "";
        if (input) {
            for (var i = 0; i < input.length; i++) {

                if (input[i]["ref_id"] == refId) {

                    temp = input[i]["address1"] + " " + input[i]["address2"] + " " + input[i]["city"] + " " + input[i]["state"] + " " + input[i]["zip"];


                }

            }
        }
        return temp;

    };
}).controller('list_orgs', ['getOrgs', 'get_States', 'getMembs', 'getCompanies', '$routeParams', '$window', '$scope', '$rootScope', '$filter', '$cookieStore', '$modal', function(getOrgs, get_States, getMembs, getCompanies, $routeParams, $window, $scope, $rootScope, $filter, $cookieStore, $modal) {

        /* @WTS User Access */
        $scope.organization_edit_user_access = [{"value": "All Access"}];
        $scope.organization_add_user_access = [{"value": "All Access"}];
        $scope.organization_del_user_access = [{"value": "All Access"}];
        $scope.organization_view_user_access = [{"value":"Accounting Clerk"}, {"value":"Accounting Supervisor"}, {"value": "Administrative"}];

        if ($filter("checkValidValue")($cookieStore.get('user_info')))
        {
            $scope.user_info = $cookieStore.get('user_info');
        }

        $scope.date = $filter('date')(new Date(), 'yyyy-MM-dd');
        $scope.Config = {};
        $scope.Config.general = {};
        $scope.Config.list = {};

        $scope.init = function() {
            $rootScope.notify = false;
            var init;
            $scope.Config.list.itemperPage = 10;
            filterObj = {'filter': 'deleted!=1', 'limit': $scope.Config.list.itemperPage, "order": "id desc", 'include_count': true};
            getOrgs.orgs_resource.get(filterObj,function(data) {
                $scope.total_orgs = data.meta.count;

                    var orgData = data;
                    var orgIds = getAsArray(data.record, "id");
                    
                    if (data.record.length < 1) {
                        $scope.current_orgs = orgData.record;
                        return false;
                    }

                    filterObj_Address = {"fields": "ref_id,address1,address2,city,state,zip", "filter": "ref_id in (" + orgIds.join(',') + ") and ref = 'organization'"};
                    getCompanies.addresses_resource.get(filterObj_Address, function(data) {
                        $scope.address_list = data.record;
                        
                        for (var j = 0; j < orgData.record.length; j++) {
                            orgData.record[j]["AddressFull"] = $filter('getAdressName')($scope.address_list, $scope.address_list, orgData.record[j]['id']);
                        }
                        $scope.Config.list.itemFrom = 1;
                        $scope.Config.list.preOffset = 0;
                        $scope.Config.list.nextOffset = $scope.Config.list.itemperPage;
                        $scope.Config.list.itemTo = $scope.Config.list.itemperPage;
                        $scope.Config.list.itemTotalCount = $scope.total_orgs;
                        $scope.Config.list.paginationCount = $window.Math.ceil($scope.Config.list.itemTotalCount / $scope.Config.list.itemperPage);
                        $scope.Config.list.currentPage = 1;
                        $scope.Config.list.limitstart = 0;
                        $scope.Config.list.limitend = $scope.Config.list.limitstart + 5;
                        $scope.Config.general.searchtxt = "";
                        $scope.Config.general.filterDBField = "";
                        $scope.Config.general.filterDBOptions = [];
                        $scope.Config.general.filterDBOptionsname = [];
                        $scope.Config.list.pagination = $scope.buildPagination($scope.Config.list.paginationCount);
                    })
                    $.each(data, function(k, v) {
                        var today = $filter('date')(new Date(), 'yyyy-MM-dd');
                        var otherDay = $filter('date')(v.datecreated, 'yyyy-MM-dd');
                        v.createdon = $filter('date')(v.datecreated, 'MMM dd yyyy');
                        if (today == otherDay)
                        {
                            v.today = "Yes";
                        }
                        else
                        {
                            v.today = "No";
                        }
                    });
                    $scope.current_orgs = data.record;
                
            }, function() {
                console.error(arguments);
            })
        }


        /*
         Start
         WTS 09 Oct 2014 by Dhaval
         Desc: Functions for Pagination
         */
        filter_str = "";
        $scope.getNextData = function(offset) {
            
            var filter_str = $scope.filter_str;
            if (!$filter("checkValidValue")(filter_str))
            {
                filter_str = "deleted != 1";
            }
            else
            {
                filter_str = filter_str + " && deleted != 1";
            }
            if ($scope.sortme) {
                filterObj = {'filter': filter_str, 'limit': $scope.Config.list.itemperPage, 'offset': offset, "order": "" + $scope.sortField + " " + $scope.sortType + ""};
            } else {
                filterObj = {'filter': filter_str, 'limit': $scope.Config.list.itemperPage, 'offset': offset, "order": "id desc"};
            }

            getOrgs.orgs_resource.get(filterObj, function(data) {

                var orgData = data;
                var orgIds = getAsArray(data.record, "id");
                
                if (data.record.length < 1) {
                    $scope.current_orgs = orgData.record;
                    return false;
                }

                filterObj_Address = {"fields": "ref_id,address1,address2,city,state,zip", "filter": "ref_id in (" + orgIds.join(',') + ") and ref = 'organization'"};
                getCompanies.addresses_resource.get(filterObj_Address, function(data) {
                    $scope.address_list = data.record;
                    
                    $scope.Config.list.itemFrom = parseInt(offset) + 1;
                    $scope.Config.list.itemTo = parseInt(offset) + parseInt($scope.Config.list.itemperPage);
                    $scope.current_orgs = orgData.record;
                    $scope.Config.list.preOffset = parseInt(offset) - parseInt($scope.Config.list.itemperPage);
                    $scope.Config.list.nextOffset = parseInt(offset) + parseInt($scope.Config.list.itemperPage);
                    $scope.Config.list.currentPage = (parseInt(offset) / parseInt($scope.Config.list.itemperPage)) + 1;

                })
            })
        }

        $scope.buildPagination = function(paginationCount) {
            var Temp = [];
            
            for (var i = 1; i <= paginationCount; i++) {
                Temp.push({offset: ((i - 1) * $scope.Config.list.itemperPage), number: i});
            }
            return Temp;
        }

        $scope.updateTableData = function(isFilter) {

            var filter_e_str = "";
            var filter_c_str = "";
            var filter_s_str = "";
            var filter_z_str = "";
            var filter_str = "";
            var filterObj;

            if ($filter("checkValidValue")($scope.Config.general.searchtxt))
            {

                if ($scope.Config.general.searchtxt.indexOf(",") > -1) {
                    filter_e_str = " and (name like '%" + $scope.Config.general.searchtxt + "%' and code like '%" + $scope.Config.general.searchtxt + "%')";

                } else {
                    filter_e_str = " and (name like '%" + $scope.Config.general.searchtxt + "%' or code like '%" + $scope.Config.general.searchtxt + "%')";
                }
            }

            filter_str = filter_e_str + filter_c_str + filter_s_str;
            filter_str = filter_str.slice(4, filter_str.length);

            $scope.filter_str = filter_str;
            if (!$filter("checkValidValue")($scope.filter_str))
            {
                filter_str = "deleted != 1";
            }
            else
            {
                filter_str = filter_str + " && deleted != 1";
            }

            if ($scope.sortme) {
                filterObj = {"filter": filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, "order": "" + $scope.sortField + " " + $scope.sortType + ""};
            } else {
                filterObj = {"filter": filter_str, 'limit': $scope.Config.list.itemperPage, 'include_count': true, "order": "id desc"};
            }
            
            getOrgs.orgs_resource.get(filterObj, function(data) {

                var orgData = data;
                var orgIds = getAsArray(data.record, "id");
                
                if (data.record.length < 1) {
                    $scope.current_orgs = orgData.record;
                    return false;
                }

                filterObj_Address = {"fields": "ref_id,address1,address2,city,state,zip", "filter": "ref_id in (" + orgIds.join(',') + ") and ref = 'organization'"};
                getCompanies.addresses_resource.get(filterObj_Address, function(data) {
                    $scope.address_list = data.record;
                    
                    $scope.Config.list.itemTotalCount = orgData.meta.count;
                    $scope.current_orgs = orgData.record;
                    $scope.Config.list.preOffset = 0;
                    $scope.Config.list.itemFrom = 1;
                    $scope.Config.list.nextOffset = $scope.Config.list.itemperPage;
                    $scope.Config.list.itemTo = $scope.Config.list.itemperPage;
                    $scope.Config.list.paginationCount = $window.Math.ceil($scope.Config.list.itemTotalCount / $scope.Config.list.itemperPage);
                    $scope.Config.list.currentPage = 1;
                    $scope.Config.list.limitstart = 0;
                    $scope.Config.list.limitend = 5;
                    $scope.Config.list.pagination = $scope.buildPagination($scope.Config.list.paginationCount);
                })
            })
        }

        $scope.clearSearch = function() {
            $scope.Config.general.filterDBFieldname = "";
            $scope.Config.general.searchtxt = "";
            $scope.Config.general.searchcmp = "";
            $scope.Config.general.searchstate = "";
            $scope.Config.general.searchStatus = "";
            $scope.Config.general.searchzip = "";
            $scope.Config.list.itemTotalCount = $scope.total_orgs;
            $scope.updateTableData();
        }
        $scope.sortType = "desc";
        $scope.sortMe = function(fieldName, thisClass) {

            //$scope.empSearchOption = helper.arr.multisort($scope.empSearchOptionUnsorted, ['name'], ['ASC']);


            jQuery(".sortable .th i").addClass("fa-sort");
            jQuery(".sortable .th i").removeClass("fa-sort-down");
            jQuery(".sortable .th i").removeClass("fa-sort-up");
            $scope.sortme = true;
            $scope.sortField = fieldName;


            if ($scope.sortType == "asc") {
                $scope.sortType = "desc";
                jQuery("." + thisClass + " .th i").removeClass("fa-sort");
                jQuery("." + thisClass + " .th i").removeClass("fa-sort-up");
                jQuery("." + thisClass + " .th i").addClass("fa-sort-down");
            } else if ($scope.sortType == "desc") {
                $scope.sortType = "asc";
                jQuery("." + thisClass + " .th i").removeClass("fa-sort");
                jQuery("." + thisClass + " .th i").removeClass("fa-sort-down");
                jQuery("." + thisClass + " .th i").addClass("fa-sort-up");
            }
            $scope.updateTableData();
        }

        /*
         End
         WTS 09 Oct 2014 by Dhaval
         Desc: Functions for Pagination
         */

        $scope.$on('confirm_box', function(event, args) {
            $scope.del_conf = false;
        });

        $scope.del_conf = false;
        $scope.remove_record = function(org_id, index, items) {
            $scope.del_conf = true;
            var modalInstance;
            modalInstance = $modal.open({
                templateUrl: "delConfirm.html",
                controller: function($scope, $rootScope, $modalInstance, $location, logger) {
                    $scope.ok = function() {
                        $scope.org_update = {"deleted": 1};
                        getOrgs.orgs_resource.update({id: org_id}, $scope.org_update, function(org_data) {
                            console.log(org_data);
                            get_States.states_resource.update({filter:"org_id='"+org_id+"'"},$scope.org_update,function(state_data){
                                console.log(state_data);
                            },function(){
                                console.error(arguments);
                            })
                            return logger.logSuccess("Organization deleted successfully!");
                        }, function() {
                            console.error(arguments);
                            return logger.logError("Organization could not delete!");
                        });
                        $scope.current_orgs = items.splice(index, 1);
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