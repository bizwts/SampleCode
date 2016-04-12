var get_states_model = angular.module("app.get_states", []).factory('get_States', ['$resource', function($resource) {
        return{
            states_resource: $resource(baseurl + '/rest/' + serviceName + '/state/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            all_state: $resource(baseurl + '/rest/' + serviceName + '/t_state/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            state_view: $resource(baseurl + '/rest/' + serviceName + '/vwstate/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            plan_class_res: $resource(baseurl + '/rest/' + serviceName + '/plan_class/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            state_planclass_res: $resource(baseurl + '/rest/' + serviceName + '/state_plan_class/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}})
        };
    }]);
