<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use App\Http\Requests\TasksRequest;
use App\Task;

class TasksController extends Controller
{
    /**
     * Getting tasks list using model (in-built mapper functions)
     * Returning HTML view with fechted data from DB
     */
    
    public function index(){
    	$tasks = Task::latest('created_at')->get();
    	$data = ['tasks'=>$tasks];
    	return view('tasks',$data);
    }

    /**
     * Add form submitted here with values under $request object
     * TaskRequest automatically check for access of request and validate passed data
     * TaskRequest return true then create method will insert task else it will return back to view
     */
    
    public function create(TasksRequest $request){
    	Task::create($request->all());
    	return redirect('/');
    }

    /**
     * Fetch data of specific task using fingOrFail mapper function
     * Fetched data will be passed to HTML view 
     */
    
    public function edit_view($id){
    	$data['task'] = Task::findOrFail($id);
    	return view('edit_task',$data);
    }

    /**
     * Edit form submitted here
     * Update task record and redirect to main page
     */
    
    public function update_task(TasksRequest $request,$id){
    	$task = Task::findOrFail($id);
    	$task->update($request->all());
    	return redirect('/');
    }

    /**
     * Delete task 
     */
    
    public function delete_task($id){
    	Task::findOrFail($id)->delete();
        return redirect('/');
    }
}
