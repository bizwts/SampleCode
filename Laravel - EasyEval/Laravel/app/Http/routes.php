<?php
Route::group(['middleware' => ['web']], function () {
    /*
     * Every URL defined here which will call specific controller
     * Here its calling TaskController methods which is described after @ like index, create 
     */

    /**
     * Accessible using root URL like "example.com"
     * Show Task Dashboard (Tasks listing)
     */

    Route::get('/','TasksController@index');
    
    /**
     * Accessible with root URL and page name like "example.com\task"
     * Add New Task (Saving add form)
     */
    Route::post('/task','TasksController@create');

    /**
     * Delete Task
     */
    Route::delete('/task/{id}','TasksController@delete_task');

    /**
     * Edit Task Form (HTML View)
     */
    Route::get('/task/{id}','TasksController@edit_view');

    /**
     * Updating Task data (Saving edit form)
     */
    
    Route::put('/task/{id}','TasksController@update_task');
});
