<?php
require_once("config.php");
require_once(ROOT."include/functions.php");

require_once(ROOT."controller/index.php");

$css = array();
$js = array();
$selected_menu = "dashboard";
$page_title = "Home";

include_once(ROOT."header.php");
include_once(ROOT."view/properties.php");
include_once(ROOT."footer.php");
?>
