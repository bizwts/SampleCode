var get_orgs_model = angular.module("app.getorgs", []).factory('getOrgs', ['$resource', function($resource) {
        return{
            orgs_resource: $resource(baseurl + '/rest/' + serviceName + '/organization/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            vwcnt_org: $resource(baseurl + '/rest/' + serviceName + '/vwcnt_org/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}})
        }
    }]);
