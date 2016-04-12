<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    /**
     * array of fields which will be saved among passed array of inputs from $request
     * remove possibility of mass assignment vulnerability
     * @return array
     */
    
    protected $fillable =['name'];
    
}
