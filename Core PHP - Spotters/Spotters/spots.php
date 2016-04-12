<?php
require_once("../includes/session.php");
require_once("../includes/config.php");
require_once("../includes/functions.php");
$page_for_head = 'spots';
require_once("includes/head.php");
$page_name = 'projects';
require_once("includes/header.php");

//require_once("includes/tablehead.php");
// Get class here
require_once("../classes/tbl_spots.class.php");
require_once("../classes/tbl_projects.class.php");

$projectlist = new Tbl_projects();
$getproject = $projectlist->getById($_REQUEST['pid']);
?>
<!--<script src="js/jquery-1.9.1.js"></script>-->
<script src="js/jquery-ui.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/date.js"></script>
<div class="container-fluid">
    <div class="page-header">

    </div>
    <div class="breadcrumbs">
        <ul>
            <li>
                <a href="dashboard.php">Home</a>
                <i class="icon-angle-right"></i>
            </li>
            <li>
                <a href="projects.php">Project</a>
                <i class="icon-angle-right"></i>
            </li>
            <li>
                <a href="spots.php?pid=<?= $_REQUEST['pid'] ?>">Spots</a>
            </li>
        </ul>
        <div class="close-bread">
            <a href="#"><i class="icon-remove"></i></a>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <a class="btn btn-primary" href="projects.php" style="float: right;margin-top: 10px;">Back</a>
        </div>
    </div>
    <!--SPOTS COMPLETED Start-->
    <div class="row-fluid">
        <div class="span12">
            <div class="box box-color box-bordered">
                <?php if (isset($_REQUEST['err'])) { ?>
                    <div class="alert alert-success" style="text-align: center;">
                        <?php
                        if ($_REQUEST['err'] == 1) {
                            echo "Spot confirmed successfully.";
                        } else if ($_REQUEST['err'] == 2) {
                            echo "Spot rejected successfully.";
                        }
                        ?>
                    </div>
                <?php } ?>
                <div class="box-title">
                    <h3>
                        <i class="icon-table"></i>
                        Completed Spots of <?= $getproject->project_title ?>
                    </h3>
                    <?php if ($getproject->project_location_based == 1) { ?><a class="btn" style="float: right;margin-right: 10px;" onclick="location.href = 'excel_download_tomtom.php?pid=<?= $_REQUEST['pid'] ?>&status=1'">Export to excel (TomTom)</a><?php } ?>
                    <a class="btn" style="float: right;margin-right: 10px;" onclick="location.href = 'excel_download.php?pid=<?= $_REQUEST['pid'] ?>&status=1'">Export to excel</a>
                </div>
                <div class="box-content nopadding">
                    <table class="table table-hover table-nomargin table-bordered">
                        <?php
                        $spotslist = new Tbl_spots();
                        $spotslist = $spotslist->search("project_id = " . $_REQUEST['pid'] . " and progress_status_id = 1 and spot_status = 1",'spot_completed_date DESC');
                        if ($spotslist != '') {
                            ?>
                            <thead>
                                <tr>
                                    <th>Name</th>
									<th>Spot Ref</th>
                                    <!--<th>Client</th>-->
                                    <th>Spotter</th>
                                    <th class='hidden-350'>Price</th>
                                    <th class='hidden-1024'>EP</th>
                                    <?php if ($getproject->project_location_based != 3) { ?>
                                        <th class='hidden-480'>Spot/Spotter Location</th>
                                    <?php } ?>
                                    <th class='hidden-1024'>Source</th>
                                    <th class='hidden-1024'>Completed Device Date</th>
                                    <th class='hidden-1024'>Completed Date</th>
                                    
                                    <th class='hidden-1024'>DATA</th>
                                    <th class='hidden-350'>Spots Actions</th>
                                    <!--<th>ACTIONS</th>-->
                                </tr>
                            </thead>
                            <tbody> 
                                <?php
                                for ($i = 0; $i < count($spotslist); $i++) {
                                    if (strlen($spotslist[$i]->spot_location) > 1) {
                                        $spot_location = substr($spotslist[$i]->spot_location, -1);
                                    } else {
                                        $spot_location = $spotslist[$i]->spot_location;
                                    }
                                    ?>
                                    <tr>
                                        <td><?= $spotslist[$i]->spot_name?></td>
                                        <td><?= $spotslist[$i]->spot_description ?></td>
                                        <?php $userID = getUserIDbySpotterID($spotslist[$i]->spotter_id); ?>
                                        <td>
                                            <a class="btn" href="send_message.php?user_id=<?= $userID; ?>&user_type=2" target="_blank"><i class="glyphicon-message_plus"></i></a> &nbsp;
                                            <?php
                                            if (getUserDetailId($userID, "fname") != '') {
                                                echo getUserDetailId($userID, "fname");
                                            } else {
                                                echo getUserNameId($userID);
                                            }
                                            ?>

                                        </td>
                                        <td class='hidden-350'><?= $spotslist[$i]->spot_price ?></td>
                                        <td class='hidden-1024'><?= $spotslist[$i]->experience_points ?></td>
                                        <?php if ($getproject->project_location_based == 1) { ?>
                                            <td class='hidden-480'><a href="spotter_view_location.php?pid=<?php echo $_REQUEST['pid']; ?>&spot_id=<?php echo $spotslist[$i]->spot_id; ?>"><?php echo getProvinceNameByID($spotslist[$i]->spot_location) ?></a></td>
                                        <?php } else if ($getproject->project_location_based == 2) { ?>
                                            <td class='hidden-480'><a href="spotter_view_location.php?pid=<?php echo $_REQUEST['pid']; ?>&spot_id=<?php echo $spotslist[$i]->spot_id; ?>"><?php echo getProvinceNameByPRVID($spotslist[$i]->spot_location) ?></a></td>
                                        <?php } ?>
                                        <td class='hidden-1024'><?= $spotslist[$i]->spot_source == 0 ? "APP" : "MOBI" ?></td>
                                        <td class='hidden-1024'><?= $spotslist[$i]->spot_completed_device_date ?></td>
                                        <td class='hidden-1024'><?= $spotslist[$i]->spot_completed_date ?></td>
                                        
                                        <td class='hidden-1024'><a href="spot_data.php?spot_id=<?= $spotslist[$i]->spot_id ?>&pid=<?php echo $_REQUEST['pid']; ?>">DATA</a></td>
                                        <td><a href="javascript:void(0)" onClick="ConfirmSpot(<?= $spotslist[$i]->spot_id ?>)">CONFIRM</a> |
                                            <a href="javascript:void(0);" onclick="confirmReject('<?= $spotslist[$i]->spot_id ?>')">REJECT</a></td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        <?php } else { ?>
                            <tr>
                                <td align="center" style="text-align:center !important;">
                                    <b > There are no completed spots.</b>
                                </td>
                            </tr>
                        <?php } ?> 
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!--SPOTS COMPLETED Start-->
    <!--SPOTS Outstanding Start-->
    <div class="row-fluid">
        <div class="span12">
            <div class="box box-color box-bordered">
                <div class="box-title">
                    <h3>
                        <i class="icon-table"></i>
                        Outstanding Spots of <?= $getproject->project_title ?>
                    </h3>
                    <button name="delete_spots" id="delete_spots" class="btn btn-purple pull-right" onclick="deleteMultipleSpots()">Delete Spots</button>
                    <div class="pull-right" style="margin-right: 30px">
                        <form name="import_project_spots" action="projects_ajax.php" method="post" id="import_project_spots" enctype="multipart/form-data" style="margin-bottom: 0px;">

                            <input type="hidden" name="project_id" id="project_id" value="<?= $_REQUEST['pid'] ?>"/>
                            <input type="hidden" name="action" id="action" value="import_more_spots"/>
                            <input type="file" class="styled" name="spot_import_csv" id="spot_import_csv"/>
                            <button name="import_spots" id="import_spots" class="btn btn-darkblue">Import Spots</button>
                        </form>
                    </div>
                </div>
                <div class="box-content nopadding">
                    <form name="outstanding_spots" id="outstanding_spots">
                        <table class="table table-hover table-nomargin table-bordered">
                            <?php
                            $outstandingspotslist = new Tbl_spots();
                            $outstandingspotslist = $outstandingspotslist->search("project_id = " . $_REQUEST['pid'] . " and progress_status_id = 0 and spot_status = 0");
                            if ($outstandingspotslist != '') {
                                ?>
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" name="selecctall" id="selecctall" /></th>
                                        <th>Name</th>
										<th>Spot Ref.</th>
                                        <!--<th>Client</th>-->
                                        <th class='hidden-350'> Price</th>
                                        <th class='hidden-1024'>EP</th>
                                        <?php if ($getproject->project_location_based != 3) { ?>
                                            <th class='hidden-480'>Spot Location</th>
                                        <?php } ?>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php for ($i = 0; $i < count($outstandingspotslist); $i++) { ?>
                                        <tr>
                                            <td><input type="checkbox" name="spot_id[]" id="spot_id" class="checkbox1" value="<?php echo $outstandingspotslist[$i]->spot_id; ?>" /></td>
                                            <td><?= $outstandingspotslist[$i]->spot_name ?></td>
											<td><?= $outstandingspotslist[$i]->spot_description ?></td>
                                            <!--<td><?= getUserNameId(getUserIDbyClientID($outstandingspotslist[$i]->client_id)) ?></td>-->
                                            <td class='hidden-350'><?= $outstandingspotslist[$i]->spot_price ?></td>
                                            <td class='hidden-1024'><?= $outstandingspotslist[$i]->experience_points ?></td>
                                            <?php if ($getproject->project_location_based == 1) { ?>
                                                <td class='hidden-480'><a href="view_location.php?spot_id=<?php echo $outstandingspotslist[$i]->spot_id; ?>&pid=<?php echo $_REQUEST['pid']; ?>"><?php echo getProvinceNameByID($outstandingspotslist[$i]->spot_location) ?></a></td>
                                            <?php } else if ($getproject->project_location_based == 2) { ?>
                                                <td class='hidden-480'><a href="view_location.php?spot_id=<?php echo $outstandingspotslist[$i]->spot_id; ?>&pid=<?php echo $_REQUEST['pid']; ?>"><?php echo getProvinceNameByPRVID($outstandingspotslist[$i]->spot_location) ?></a></td>
                                            <?php } ?>
                                        </tr>
                                    <?php } ?>
                                </tbody>
                            <?php } else { ?> 
                                <tr>
                                    <td align="center" style="text-align:center !important;">
                                        <b > There are no outstanding spots.</b>
                                    </td>
                                </tr>
                            <?php } ?> 
                        </table>
                    </form>
                    <script>
                        $(document).ready(function () {
                            $('#selecctall').click(function (event) {  //on click
                                if (this.checked) { // check select status
                                    $('.checkbox1').each(function () { //loop through each checkbox
                                        this.checked = true;  //select all checkboxes with class "checkbox1"              
                                    });
                                } else {
                                    $('.checkbox1').each(function () { //loop through each checkbox
                                        this.checked = false; //deselect all checkboxes with class "checkbox1"                      
                                    });
                                }
                            });

                        });
                        function deleteMultipleSpots() {
                            var ids = [];
                            if ($('.checkbox1:checked').length == 0) {
                                alert('Please select atleast one spot to delete.');
                                return false;
                            }
                            $('.checkbox1:checked').each(function () {
                                ids.push(this.value);
                            })
                            $.ajax({
                                type: "POST",
                                url: "projects_ajax.php",
                                data: "action=delete_multiple_spots&spot_id=" + ids.join(','),
                                success: function (html)
                                {
                                    location.reload();
                                }
                            });
                        }
                    </script>
                </div>
            </div>
        </div>
    </div>
    <!--SPOTS Outstanding Start-->
    <!--SPOTS Confirmed Start-->

    <div class="row-fluid">
        <div class="span12" style="margin-top: 20px;">
            <a target="_blank" class="btn btn-primary pull-right" href="http://spotters.biz/office/excel_download_spots.php?pid=<?= $_REQUEST['pid'] ?>&status=2">Export Spot with Location</a>
            <a class="btn pull-right" style="margin-right: 10px;" href="confirm_spotter_location.php?project_id=<?= $_REQUEST['pid'] ?>">Spotter Location</a>
            <a class="btn pull-right" style="margin-right: 10px;" href="confirm_spot_location.php?project_id=<?= $_REQUEST['pid'] ?>">Spot Location</a>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <div class="box box-color box-bordered">
                <div class="box-title">
                    <h3>
                        <i class="icon-table"></i>
                        Confirmed Spots of <?= $getproject->project_title ?>
                    </h3>
                    <?php if ($getproject->project_location_based == 1) { ?>
                        <div style="float: right;margin-right: 10px;" >
                            <table>
                                <tr>
                                    <td><b>From</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td>

                                        <div style="margin:0px" class="input-append date datepicker pull-left" data-date="" data-date-format="yyyy-mm-dd" id="report_start_date_container">
                                            <input size="10" class="span8" type="text" value="" name="report_start_date" id="report_start_date" readonly>
                                            <span class="add-on"><i class="icon-th"></i></span>
                                        </div>
                                    </td>
                                    <td><b>to</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                        <div style="margin:0px" class="input-append date datepicker pull-left" data-date="" data-date-format="yyyy-mm-dd" id="report_end_date_container">
                                            <input size="10" class="span8" accept=""type="text" value="" name="report_end_date" id="report_end_date" readonly>
                                            <span class="add-on"><i class="icon-th"></i></span>
                                        </div>
                                    </td>
                                    <td>
                                        <a class="btn" onclick="downloadTomtomExcelReport('<?= $_REQUEST['pid'] ?>')">Export (TomTom)</a>
                                    </td>
                                    <!--<td><a class="btn" href="confirm_spot_location.php?project_id=<?= $_REQUEST['pid'] ?>">Location</a></td>-->
                                </tr>
                            </table>
                        </div>
                        <script type="text/javascript">
                            function downloadTomtomExcelReport(pid) {
                                var report_start_date = $('#report_start_date').val();
                                var report_end_date = $('#report_end_date').val();
                                location.href = "excel_download_tomtom.php?pid=" + pid + "&status=2&report_start_date=" + report_start_date + "&report_end_date=" + report_end_date;
                            }
                            $('#report_start_date_container').datepicker().on('changeDate', function (ev) {
                                $(this).datepicker('hide');
                            });
                            $('#report_end_date_container').datepicker().on('changeDate', function (ev) {
                                $(this).datepicker('hide');
                            });
                        </script>
                    <?php } ?>
                    <a class="btn" style="float: right;margin-right: 10px;" onclick="location.href = 'excel_download.php?pid=<?= $_REQUEST['pid'] ?>&status=2'">Export to excel</a>
                </div>
                <div class="box-content nopadding">
                    <table class="table table-hover table-nomargin table-bordered">
                        <?php
                        $completespotslist = new Tbl_spots();
                        $completespotslist = $completespotslist->search("project_id = " . $_REQUEST['pid'] . " and progress_status_id = 2");
                        if ($completespotslist != '') {
                            ?>
                            <thead>
                                <tr>
                                    <th>Name</th>
									<th>Spot Ref.</th>
                                    <th>Spotter</th>
                                    <th class='hidden-350'>Price</th>
                                    <th class='hidden-1024'>EP</th>
                                    <?php if ($getproject->project_location_based != 3) { ?>
                                        <th class='hidden-480'>Spot/Spotter Location</th>
                                    <?php } ?>
                                    <th class='hidden-1024'>Source</th>
                                    <th class='hidden-350'>Completed Date</th>
									<th class='hidden-350'>Device Date</th>
                                    <th class='hidden-1024'>DATA</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php for ($i = 0; $i < count($completespotslist); $i++) { 
                                    list($a, $spotter_location, $b) = explode(';', $completespotslist[$i]->spot_GPS_completed);
                                    ?>
                                    <tr>
                                        <td><a href="#" class="spot_name" data-pk="<?= $completespotslist[$i]->spot_id; ?>" data-type="text" data-placement="right" data-placeholder="Required" data-url="ajax_functions.php?spot_id=<?php echo $completespotslist[$i]->spot_id; ?>&action=edit_spot_name" data-original-title="Please enter Spot Name"><?= $completespotslist[$i]->spot_name ?></a></td>
                                        <!--<td><?= $completespotslist[$i]->spot_name ?></td>-->
										<td><?= $completespotslist[$i]->spot_description ?></td>
                                        <?php $userID = getUserIDbySpotterID($completespotslist[$i]->spotter_id); ?>
                                        <td>
                                            <a class="btn" href="send_message.php?user_id=<?= $userID; ?>&user_type=2" target="_blank"><i class="glyphicon-message_plus"></i></a> &nbsp;
                                            <?php
                                            if (getUserDetailId($userID, "fname") != '') {
                                                echo getUserDetailId($userID, "fname");
                                            } else {
                                                echo getUserNameId($userID);
                                            }
                                            ?>

                                        </td>
                                        <td class='hidden-350'><?= $completespotslist[$i]->spot_price ?></td>
                                        <td class='hidden-1024'><?= $completespotslist[$i]->experience_points ?></td>
                                        <?php if ($getproject->project_location_based == 1) { ?>
                                            <td class='hidden-480'>
                                                <a href="spotter_view_location.php?pid=<?php echo $_REQUEST['pid']; ?>&spot_id=<?php echo $completespotslist[$i]->spot_id; ?>"><?php echo getProvinceNameByID($completespotslist[$i]->spot_location) ?></a><br/>
                                                <a href=""class="spotter_location" data-pk="<?= $completespotslist[$i]->spot_id; ?>" data-type="text" data-placement="right" data-placeholder="Required" data-url="ajax_functions.php?spot_id=<?php echo $completespotslist[$i]->spot_id; ?>&action=edit_spotte_location" data-original-title="Please enter Spotter Location"><?php echo $spotter_location ?></a>
                                            </td>
                                        <?php } else if ($getproject->project_location_based == 2) { ?>
                                            <td class='hidden-480'><a href="spotter_view_location.php?pid=<?php echo $_REQUEST['pid']; ?>&spot_id=<?php echo $completespotslist[$i]->spot_id; ?>"><?php echo getProvinceNameByPRVID($completespotslist[$i]->spot_location) ?></a></td>
                                        <?php } ?>
                                        <td class='hidden-1024'><?= $completespotslist[$i]->spot_source == 0 ? "APP" : "MOBI" ?></td>
                                        <td class='hidden-350'><?= $completespotslist[$i]->spot_completed_date ?></td>
										<td class='hidden-1024'><?= $completespotslist[$i]->spot_completed_device_date ?></td>
                                        <td class='hidden-1024'><a href="spot_data.php?spot_id=<?= $completespotslist[$i]->spot_id ?>&pid=<?php echo $_REQUEST['pid']; ?>">DATA</a></td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        <?php } else { ?> 
                            <tr>
                                <td align="center" style="text-align:center !important;">
                                    <b > There are no confirmed spots.</b>
                                </td>
                            </tr>
                        <?php } ?> 
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!--SPOTS Confirmed Start-->

    <!--SPOTS Rejected Start-->
    <div class="row-fluid">
        <div class="span12">
            <div class="box box-color box-bordered">
                <div class="box-title">
                    <h3>
                        <i class="icon-table"></i>
                        Rejected Spots of <?= $getproject->project_title ?>
                    </h3>
                </div>
                <div class="box-content nopadding">
                    <table class="table table-hover table-nomargin table-bordered">
                        <?php
                        $rejectedspotslist = new Tbl_spots();
                        $rejectedspotslist = $rejectedspotslist->search("project_id = " . $_REQUEST['pid'] . " and progress_status_id = 3");
                        if ($rejectedspotslist != '') {
                            ?>
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Spotter</th>
                                    <th class='hidden-350'>Price</th>
                                    <th class='hidden-350'>Source</th>
                                    <th class='hidden-1024'>DATA</th>
                                    <?php if ($getproject->project_location_based != 3) { ?>
                                        <th class='hidden-480'>Spot/Spotter Location</th>
                                    <?php } ?>
                                </tr>
                            </thead>
                            <tbody>
                                <?php for ($i = 0; $i < count($rejectedspotslist); $i++) { ?>
                                    <tr>
                                        <td><?= $rejectedspotslist[$i]->spot_name ?></td>
                                        <?php $userID = getUserIDbySpotterID($rejectedspotslist[$i]->spotter_id); ?>
                                        <td>
                                            <a class="btn" href="send_message.php?user_id=<?= $userID; ?>&user_type=2" target="_blank"><i class="glyphicon-message_plus"></i></a> &nbsp;
                                            <?php
                                            if (getUserDetailId($userID, "fname") != '') {
                                                echo getUserDetailId($userID, "fname");
                                            } else {
                                                echo getUserNameId($userID);
                                            }
                                            ?>
                                        </td>
                                        <td class='hidden-350'><?= $rejectedspotslist[$i]->spot_price ?></td>
                                        <td class='hidden-1024'><?= $rejectedspotslist[$i]->spot_source == 0 ? "APP" : "MOBI" ?></td>
                                        <td class='hidden-1024'><a href="spot_data.php?spot_id=<?= $rejectedspotslist[$i]->spot_id ?>&pid=<?php echo $_REQUEST['pid']; ?>">DATA</a></td>
                                        <?php if ($getproject->project_location_based == 1) { ?>
                                            <td class='hidden-480'>
                                                <a href="view_location.php?spot_id=<?php echo $rejectedspotslist[$i]->spot_id; ?>&pid=<?php echo $_REQUEST['pid']; ?>"><?php echo getProvinceNameByID($rejectedspotslist[$i]->spot_location) ?></a>
                                            </td>
                                            <!--<td class='hidden-480'><a href="view_location.php?spot_id=<?php echo $rejectedspotslist[$i]->spot_id; ?>&pid=<?php echo $_REQUEST['pid']; ?>"><?php echo getProvinceNameByID($rejectedspotslist[$i]->spot_location) ?></a></td>-->
                                        <?php } else if ($getproject->project_location_based == 2) { ?>
                                            <td class='hidden-480'><a href="view_location.php?spot_id=<?php echo $rejectedspotslist[$i]->spot_id; ?>&pid=<?php echo $_REQUEST['pid']; ?>"><?php echo getProvinceNameByPRVID($rejectedspotslist[$i]->spot_location) ?></a></td>
                                        <?php } ?>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        <?php } else { ?> 
                            <tr>
                                <td align="center" style="text-align:center !important;">
                                    <b > There are no rejected spots.</b>
                                </td>
                            </tr>
                        <?php } ?> 
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!--SPOTS Rejected Start-->
</div>

<script type="text/javascript">
    hideNav();

//    function confirmReject(spot_id)
//    {
//        var reason = prompt("Please enter reason to reject spot.");
//        if (reason != null) {
//            location.href = 'spots_conformation.php?spot_id=' + spot_id + '&status=reject&reason=' + reason;
//        }
//    }
//    function ConfirmSpot()
//    {
//        var x = confirm("Are you sure this spot is confirm?");
//        if (x)
//            return true;
//        else
//            return false;
//    }
</script>
<script type="text/javascript">

    function confirmReject(spot_id)
    {
        $("#myModal").bind("show", function () {
            $("#myModal a.btn").click(function (e) {
                if ($('#reason').val() != '') {
                    location.href = 'spots_conformation.php?spot_id=' + spot_id + '&status=reject&reason=' + escape($('#reason').val());
                } else {
                    $(".error").html("Please enter reason to reject spot.");
                }

            });
            $("#myModal a.cancel").click(function (e) {
                $(".error").html("");
                $("#myModal").modal('hide');
            });
        });

        $("#myModal").bind("hide", function () {

            $("#myModal a.btn").unbind();
        });

        $("#myModal").modal({
            "backdrop": "static",
            "keyboard": true,
            "show": true // this parameter ensures the modal is shown immediately
        });
    }
    function ConfirmSpot(spot_id)
    {
        bootbox.confirm("Are you sure this spot is confirm?", "Cancel", "Yes, confirm",
                function (e) {
                    if (e) {
                        location.href = 'spots_conformation.php?spot_id=' + spot_id + '&status=confirm';
                    }
                });
    }
</script>
<div id="myModal" class="modal fade">
    <!-- dialog contents -->
    <div class="modal-body">Do you want to reject this spot? If yes, Please enter reason.<br/><textarea name="reason" id="reason" class="input-xlarge"></textarea><br/><span class="error"></span></div>
    <!-- dialog buttons -->
    <div class="modal-footer"><a href="javascript:void(0)" class="btn cancel">Cancel</a><a class='btn btn-primary' href="javascript:void(0)">Yes, Reject</a></div>
</div>
</div>
</div>
</body>
</html>
<link rel="stylesheet" href="css/plugins/xeditable/bootstrap-editable.css">
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/momentjs/jquery.moment.js"></script>
<script src="js/plugins/mockjax/jquery.mockjax.js"></script>
<script src="js/plugins/xeditable/bootstrap-editable.min.js"></script>
<script type="text/javascript">
    jQuery.noConflict();
    jQuery(function () {
        jQuery.fn.editable.defaults.url = "/post";
        $("#enable").click(function () {
            jQuery("#user .editable").editable("toggleDisabled")
        });
        jQuery(".spot_name").editable({validate: function (e) {
                if ($.trim(e) == "")
                    return"Please Enter Spot Name."
            }, success: function (e) {
                $("#project-title").show().delay(3e3).fadeOut(1500)
            }});
        jQuery(".spotter_location").editable({validate: function (e) {
                if ($.trim(e) == "")
                    return"Please Enter Spotter Location."
            }, success: function (e) {
                $("#project-title").show().delay(3e3).fadeOut(1500)
            }});
        jQuery(".expiry_date").editable({validate: function (e) {
                if ($.trim(e) == "")
                    return"Please select Expiry Date."
            }, success: function (e) {
                $("#project-expiry-date").show().delay(3e3).fadeOut(1500)
            }})
    });
</script>