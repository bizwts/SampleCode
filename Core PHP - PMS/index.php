<?php
$f3=require('lib/base.php');
define('TEST_MODE','1');

$root = $_SERVER['DOCUMENT_ROOT'].'/';
$host = "http://".$_SERVER['HTTP_HOST'].'/';

// Set database
$dbhost = "localhost";
$dbname = "DB_NAME";
$dbuser = "DB_USER";
$dbpassword = "DB_PASSWORD";

$title = "SITE TITLE";
/* Define general variable*/    
define('ROOT',$root);
define('HOST',$host);
define('CSS',$host."booster/css/");
define('JS',$host."booster/js/");
define('IMG',$host."img/");

$f3->set('DEBUG',3); # Set debug level 0=production
if ((float)PCRE_VERSION<7.9)
	trigger_error('PCRE version is out of date');

// Load configuration
$f3->config('config.ini');
$f3->set('DB',new \DB\SQL('mysql:host='.$dbhost.';dbname='.$dbname.'',$dbuser,$dbpassword,array(PDO::ATTR_PERSISTENT=>TRUE)));

include_once 'classes/tables.class.php';
include_once 'include/variables_config.php';
include_once 'include/emailer.php';
include_once 'include/notification.php';
include_once 'booster/booster_inc.php';

/* Dashboard */
$f3->route('GET /',
    function($f3) {
        if($f3->get("SESSION.wpms_id")==''){
            $f3->reroute('/login');
        }else{
            $f3->reroute('/dashboard');
        }
    }
);
/* Article */
$f3->route('GET /article',
    function($f3) {
        global $title;
        if(!$f3->exists('SESSION.wpms_id')){$f3->reroute("/");} /* redirect to root if user is not logged in.*/
        $f3->set('js',array("custom/article"));/* Include js file for article page*/
        include_once('app/header.php');
        include_once('app/article.php');
        include_once('app/footer.php');
    }
);
$f3->route('POST /article',
    function($f3) {
        global $title;
        if(!$f3->exists('SESSION.wpms_id')){$f3->reroute("/");}
        include_once('api/article.php');
    }
);
/* 404 page */
$f3->route('GET /404',
    function($f3) {
        global $title;
        $page = "404";
        include_once('app/404.php');
    }
);
$f3->run();
