<?php

require_once("../includes/session.php");
require_once("../includes/config.php");
require_once("../includes/functions.php");
require_once("../phpexcel/PHPExcel.php");
require_once("../classes/tbl_projects.class.php");
require_once("../classes/tbl_spots.class.php");
require_once("../classes/tbl_spot_tasks.class.php");
require_once("../classes/tbl_spot_tasks_answers.class.php");
require_once("../classes/tbl_spot_tasks_images.class.php");
ini_set('memory_limit', '5000M');
error_reporting(E_ALL);

ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
define('EOL', (PHP_SAPI == 'cli') ? PHP_EOL : '<br />');

// Initiate cache
$cacheMethod = PHPExcel_CachedObjectStorageFactory::cache_to_phpTemp;
$cacheSettings = array('memoryCacheSize' => '5GB');
PHPExcel_Settings::setCacheStorageMethod($cacheMethod, $cacheSettings);

// Create new PHPExcel object
$objPHPExcel = new PHPExcel();
$objRichText = new PHPExcel_RichText();
$objPHPExcel->getDefaultStyle()->getFont()->setName('Arial')
        ->setSize(10);
// Set document properties
$objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
        ->setLastModifiedBy("Maarten Balliauw")
        ->setTitle("Office 2007 XLSX Test Document")
        ->setSubject("Office 2007 XLSX Test Document")
        ->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")
        ->setKeywords("office 2007 openxml php")
        ->setCategory("Test result file");
// Add some data

$objPHPExcel->setActiveSheetIndex(0);
$spotlist = advancedSearch('SELECT s.spot_id, s.spot_name, s.spot_description, s.spot_GPS, s.spot_GPS_completed, p.project_id, p.project_title, s.client_id, s.spot_completed_device_date FROM tbl_spots as s, tbl_projects p WHERE p.project_id = s.project_id AND s.progress_status_id = "' . $_REQUEST['status'] . '" AND s.project_id = "' . $_REQUEST['pid'] . '"');
$array = array("0" => "A", "1" => "B", "2" => "C", "3" => "D", "4" => "E", "5" => "F", "6" => "G", "7" => "H", "8" => "I", "9" => "J", "10" => "K", "11" => "L", "12" => "M", "13" => "N", "14" => "O", "15" => "P", "16" => "Q", "17" => "R", "18" => "S", "19" => "T", "20" => "U", "21" => "U", "22" => "V", "23" => "W", "24" => "X", "25" => "Y", "26" => "Z", "27" => "AA", "28" => "AB", "29" => "AC", "30" => "AD", "31" => "AE", "32" => "AF", "33" => "AG", "34" => "AH", "35" => "AI", "36" => "AJ", "37" => "AK", "38" => "AL", "39" => "AM", "40" => "AN", "41" => "AO", "42" => "AP", "43" => "AQ", "44" => "AR", "45" => "AS", "46" => "AT", "47" => "AU", "48" => "AV", "49" => "AW", "50" => "AX", "51" => "AY", "52" => "AZ", "53" => "BA", "54" => "BB", "55" => "BC", "56" => "BD", "57" => "BE", "58" => "BF", "59" => "BG", "60" => "BH", "61" => "BI", "62" => "BJ", "63" => "BK", "64" => "BL", "65" => "BM", "66" => "BN", "67" => "BO", "68" => "BP", "69" => "BQ", "70" => "BR", "71" => "BS", "72" => "BT", "73" => "BU", "74" => "BV", "75" => "BW", "76" => "BX", "77" => "BY", "78" => "BZ");
$row_position = 0;
$objPHPExcel->getDefaultStyle()->getAlignment()->setWrapText(true);
for ($j = 0; $j < count($spotlist); $j++) {

//    if ($j == 0) {
    $row_position = $row_position + 2;
//    } else {
//        $row_position = $row_position + 5;
//    }

    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('A' . $row_position, 'POI ID')
            ->setCellValue('B' . $row_position, 'Project Name')
            ->setCellValue('C' . $row_position, 'Spot Name')
            ->setCellValue('D' . $row_position, 'Client Name')
            ->setCellValue('E' . $row_position, 'GeoLocation')
            ->setCellValue('F' . $row_position, 'Device Date');

    $objPHPExcel->setActiveSheetIndex(0)->getStyle('A' . $row_position)->getFont()->setBold(true)->setSize(13);
    $objPHPExcel->setActiveSheetIndex(0)->getStyle('B' . $row_position)->getFont()->setBold(true)->setSize(13);
    $objPHPExcel->setActiveSheetIndex(0)->getStyle('C' . $row_position)->getFont()->setBold(true)->setSize(13);
    $objPHPExcel->setActiveSheetIndex(0)->getStyle('D' . $row_position)->getFont()->setBold(true)->setSize(13);
    $objPHPExcel->setActiveSheetIndex(0)->getStyle('E' . $row_position)->getFont()->setBold(true)->setSize(13);
    $objPHPExcel->setActiveSheetIndex(0)->getStyle('F' . $row_position)->getFont()->setBold(true)->setSize(13);

    $row_position = $row_position + 1;

    list($first_one, $geolocation, $third_blank) = explode(";", $spotlist[$j]->spot_GPS_completed);
    $objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('A' . $row_position, $spotlist[$j]->spot_description)
            ->setCellValue('B' . $row_position, $spotlist[$j]->project_title)
            ->setCellValue('C' . $row_position, $spotlist[$j]->spot_name)
            ->setCellValue('D' . $row_position, getUserNameId(getUserIDbyClientID($spotlist[$j]->client_id)))
            ->setCellValue('E' . $row_position, $geolocation)
            ->setCellValue('F' . $row_position, $spotlist[$j]->spot_completed_device_date);

    $tasks = new Tbl_spot_tasks();
    $tasks = $tasks->search('project_id = "' . $spotlist[$j]->project_id . '"');
    for ($k = 0; $k < count($tasks); $k++) {
        $objPHPExcel->setActiveSheetIndex(0)->getStyle($array[($k + 6)] . ($row_position - 1))->getFont()->setBold(true)->setSize(11);
        $objPHPExcel->getActiveSheet()->getColumnDimension($array[($k + 6)])->setWidth(30);
        if ($tasks[$k]->task_type == 1) {
            $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue($array[($k + 6)] . ($row_position - 1), $tasks[$k]->photo_instructions);
            $objPHPExcel->getActiveSheet()->getRowDimension($row_position)->setRowHeight(150);
            $task_image_answers = new Tbl_spot_tasks_images();
            $task_image_answers = $task_image_answers->search('task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '" AND image_status = 0');
            if (count($task_image_answers) > 0) {
//                for ($l = 0; $l < count($task_image_answers); $l++) {
                for ($l = 0; $l < 1; $l++) {
                    $mobihostiimagepath = $mobihost . 'images/spot_images/' . urlencode($task_image_answers[$l]->image_path);
                    $bizhostiimagepath = $host . 'images/temp/' . urlencode($task_image_answers[$l]->image_path);
                    if (fileExists($mobihostiimagepath) && $task_image_answers[$l]->image_path != "") {

                        if (!fileExists($bizhostiimagepath)) {
                            copy($mobihostiimagepath, '../images/temp/' . urlencode($task_image_answers[$l]->image_path));
                        }
                        //$ext = pathinfo($mobihostiimagepath, PATHINFO_EXTENSION);
                        //createThumbnail(ROOT . 'images/temp/' . urlencode($task_image_answers[$l]->image_path), $ext, '../images/temp/' . urlencode($task_image_answers[$l]->image_path));
//                        $dime = (chr(ord('C') + 1 + $l));
                        $dime = $array[($k + 6)];
                        $objDrawing = new PHPExcel_Worksheet_Drawing();
                        $objDrawing->setName('Thumb');
                        $objDrawing->setDescription('Thumbnail Image');
                        //$objDrawing->setPath('/var/www/spottersmobi/images/spot_images/' . $task_image_answers[$l]->image_path);
                        //$objDrawing->setPath('/home/spotmobi/public_html/images/spot_images/' . urlencode($task_image_answers[$l]->image_path));
                        $objDrawing->setPath(ROOT . 'images/temp/' . urlencode($task_image_answers[$l]->image_path));

                        $objDrawing->setHeight(200);
                        $objDrawing->setWidth(200);
                        $objDrawing->setCoordinates($dime . ($row_position));
                        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet());
                        $objDrawing->setRotation(25);
                        $objPHPExcel->getActiveSheet()->getRowDimension($row_position)->setRowHeight(150);
                        $objPHPExcel->getActiveSheet()->getColumnDimension($dime)->setWidth(40);
                    }
                }
            }
        } else if ($tasks[$k]->task_type == 2) {
            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
            $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue($array[($k + 6)] . ($row_position - 1), $tasks[$k]->ma_question)
                    ->setCellValue($array[($k + 6)] . ($row_position), $ans);
        } else if ($tasks[$k]->task_type == 3) {
            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
            $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue($array[($k + 6)] . ($row_position - 1), $tasks[$k]->dd_question)
                    ->setCellValue($array[($k + 6)] . ($row_position), $ans);
        } else if ($tasks[$k]->task_type == 4) {
            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
            $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue($array[($k + 6)] . ($row_position - 1), $tasks[$k]->yesno_question)
                    ->setCellValue($array[($k + 6)] . ($row_position), $ans);
        } else if ($tasks[$k]->task_type == 5) {
            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
            $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue($array[($k + 6)] . ($row_position - 1), $tasks[$k]->text_question)
                    ->setCellValue($array[($k + 6)] . ($row_position), $ans);
        } else if ($tasks[$k]->task_type == 6) {
            
        }


//
//        if (count($tasks) == 1) {
//            $row_position = $row_position + $k + 1;
//        } else {
//            $row_position = $row_position + 1;
//        }
//        if ($k == 0) {
//            $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A' . ($row_position + 1), 'Task Question')->setCellValue('D' . ($row_position + 1), 'Task Answer');
//            $objPHPExcel->setActiveSheetIndex(0)->getStyle('A' . ($row_position + 1))->getFont()->setBold(true)->setSize(13);
//            $objPHPExcel->setActiveSheetIndex(0)->getStyle('D' . ($row_position + 1))->getFont()->setBold(true)->setSize(13);
//        }
//        if ($tasks[$k]->task_type == 1) {
//            $objPHPExcel->setActiveSheetIndex(0)
//                    ->setCellValue('A' . ($row_position + 2), $tasks[$k]->photo_instructions);
//            $objPHPExcel->getActiveSheet()->getRowDimension($row_position + 2)->setRowHeight(150);
//            $task_image_answers = new Tbl_spot_tasks_images();
//            $task_image_answers = $task_image_answers->search('task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '" AND image_status = 0');
//            if (count($task_image_answers) > 0) {
//                for ($l = 0; $l < count($task_image_answers); $l++) {
//                    $mobihostiimagepath = $mobihost . 'images/spot_images/' . urlencode($task_image_answers[$l]->image_path);
//                    $bizhostiimagepath = $host . 'images/temp/' . urlencode($task_image_answers[$l]->image_path);
//                    if (fileExists($mobihostiimagepath) && $task_image_answers[$l]->image_path != "") {
//
//                        if (!fileExists($bizhostiimagepath)) {
//                            copy($mobihostiimagepath, '../images/temp/' . urlencode($task_image_answers[$l]->image_path));
//                        }
//                        //$ext = pathinfo($mobihostiimagepath, PATHINFO_EXTENSION);
//                        //createThumbnail(ROOT . 'images/temp/' . urlencode($task_image_answers[$l]->image_path), $ext, '../images/temp/' . urlencode($task_image_answers[$l]->image_path));
//                        $dime = (chr(ord('C') + 1 + $l));
//                        $objDrawing = new PHPExcel_Worksheet_Drawing();
//                        $objDrawing->setName('Thumb');
//                        $objDrawing->setDescription('Thumbnail Image');
//                        //$objDrawing->setPath('/var/www/spottersmobi/images/spot_images/' . $task_image_answers[$l]->image_path);
//                        //$objDrawing->setPath('/home/spotmobi/public_html/images/spot_images/' . urlencode($task_image_answers[$l]->image_path));
//                        $objDrawing->setPath(ROOT . 'images/temp/' . urlencode($task_image_answers[$l]->image_path));
//
//                        $objDrawing->setHeight(200);
//                        $objDrawing->setWidth(200);
//                        $objDrawing->setCoordinates($dime . ($row_position + 2));
//                        $objDrawing->setWorksheet($objPHPExcel->getActiveSheet());
//                        $objDrawing->setRotation(25);
//                        $objPHPExcel->getActiveSheet()->getRowDimension($row_position + 2)->setRowHeight(150);
//                        $objPHPExcel->getActiveSheet()->getColumnDimension($dime)->setWidth(40);
//                    }
//                }
//            }
//        } else if ($tasks[$k]->task_type == 2) {
//            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
//            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
//            $objPHPExcel->setActiveSheetIndex(0)
//                    ->setCellValue('A' . ($row_position + 2), $tasks[$k]->ma_question)
//                    ->setCellValue('D' . ($row_position + 2), $ans);
//        } else if ($tasks[$k]->task_type == 3) {
//            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
//            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
//            $objPHPExcel->setActiveSheetIndex(0)
//                    ->setCellValue('A' . ($row_position + 2), $tasks[$k]->dd_question)
//                    ->setCellValue('D' . ($row_position + 2), $ans);
//        } else if ($tasks[$k]->task_type == 4) {
//            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
//            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
//            $objPHPExcel->setActiveSheetIndex(0)
//                    ->setCellValue('A' . ($row_position + 2), $tasks[$k]->yesno_question)
//                    ->setCellValue('D' . ($row_position + 2), $ans);
//        } else if ($tasks[$k]->task_type == 5) {
//            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
//            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
//            $objPHPExcel->setActiveSheetIndex(0)
//                    ->setCellValue('A' . ($row_position + 2), $tasks[$k]->text_question)
//                    ->setCellValue('D' . ($row_position + 2), $ans);
//        } else if ($tasks[$k]->task_type == 6) {
//            $task_answers = getSingleRecord('SELECT task_answer FROM tbl_spot_tasks_answers WHERE task_id = "' . $tasks[$k]->task_id . '" AND spot_id = "' . $spotlist[$j]->spot_id . '"');
//            $ans = isset($task_answers->task_answer) ? $task_answers->task_answer : "";
//            $dime = (chr(ord('C') + 1));
//            $objPHPExcel->setActiveSheetIndex(0)
//                    ->setCellValue('A' . ($row_position + 2), $tasks[$k]->survey_question);
//            $objDrawing = new PHPExcel_Worksheet_Drawing();
//            $objDrawing->setName('Thumb');
//            $objDrawing->setDescription('Thumbnail Image');
//            if ($ans == 1) {
//                $photo_path = $task_image_question->survey_photo1;
//            } else {
//                $photo_path = $task_image_question->survey_photo2;
//            }
//            //$objDrawing->setPath('/var/www/spottersbiz/images/survey_photo/' . $photo_path);
//            $objDrawing->setPath('/home/spotbiz/public_html/images/survey_photo/' . $photo_path);
//            $objDrawing->setHeight(200);
//            $objDrawing->setWidth(200);
//            $objDrawing->setCoordinates($dime . ($row_position + 2));
//            $objDrawing->setWorksheet($objPHPExcel->getActiveSheet());
//
//            $objPHPExcel->getActiveSheet()->getRowDimension($row_position + 2)->setRowHeight(150);
//            $objPHPExcel->getActiveSheet()->getColumnDimension($dime)->setWidth(40);
//        }
    }
}
//exit;
$objPHPExcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
$objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(30);
$objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(30);
$objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(20);
$objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(20);
$objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(20);

header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="download.xls"');
header('Cache-Control: max-age=0');
// If you're serving to IE 9, then the following may be needed
header('Cache-Control: max-age=1');

// If you're serving to IE over SSL, then the following may be needed
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT'); // always modified
header('Cache-Control: cache, must-revalidate'); // HTTP/1.1
header('Pragma: public'); // HTTP/1.0

$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
$objWriter->save('php://output');
exit;
