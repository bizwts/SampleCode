<?php
require_once("config.php");
require_once(ROOT."include/functions.php");

require_once(ROOT."controller/property-detail.php");

//$css = array("multi-select");
//$js = array("jquery.multi-select");

$css = array("multi-select","checkbox_custom","checkbox_all");
$js = array("jquery.multi-select","icheck","property_detail");

$selected_menu = "property_detail";
$page_title = "Property Detail";

include_once(ROOT."header.php");
include_once(ROOT."view/property-detail.php");
include_once(ROOT."footer.php");
?>
