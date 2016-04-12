var get_task_model = angular.module("app.gettodolist", []).factory('getTodolist', ['$resource', '$http', '$filter', '$rootScope', 'logger', function($resource, $http, $filter,$rootScope, logger) {
        return{
            task_view: $resource(baseurl + '/rest/' + serviceName + '/vwtask_todo/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            todo_note_res: $resource(baseurl + '/rest/' + serviceName + '/todo_note/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            vwtodo_entity_res: $resource(baseurl + '/rest/' + serviceName + '/vwtodo_entity/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            vwcases: $resource(baseurl + '/rest/' + serviceName + '/vwcases/:id/?app_name=' + appName + '&fields=*', null, {'update': {method: 'PUT'}}),
            send_email_to_employee: function(data_obj) {
                console.log(data_obj,"Before email data");
                //return false;
                data_obj.email_send_to = "Employee";
                $http.post(bitnamiurl + '/tools/template_email/todo_note_email.php', data_obj).success(function(edata, status, headers, config) {
                    console.log(edata,"Success");
                    if(edata.email_send == "yes")
                    {
                        if(edata.email_valid == "yes")
                        {
                            var mailform = {};
                            mailform.mail_to = edata.email_to;
                            mailform.mail_subject = edata.email_subject;
                            mailform.mailContent = edata.email_body;
                            console.log(mailform);
                            delete $http.defaults.headers.common['X-DreamFactory-Session-Token'];
                            $http.post(bitnamiurl + '/tools/mail.php', mailform).success(function(data, status, headers, config) {
                                console.log(data,"success");
                                return logger.logSuccess("Email sent successfully to "+data_obj.email_send_to+"!");
                            }).error(function(data, status) {
                                console.error(data,"Error");
                                return logger.logError("Email sent error");
                            });
                            $http.defaults.headers.common['X-DreamFactory-Session-Token'] = $rootScope.sess_id;
                        }
                        else
                        {
                            return logger.logError(data_obj.email_send_to+" email not available.");
                        }
                    }
                }).error(function(data, status) {
                    console.error(data,"Error");
                });
            },
        };
    }]);
