<?php
require '../includes/SimpleImage.php';
$img = new SimpleImage();
if ($_REQUEST['action'] == 'survey_photo') {
    $fileName = $_FILES['myfile']['name'];
    $ext = pathinfo($fileName, PATHINFO_EXTENSION);
    $ext = strtolower($ext);
    $basefilename = strtolower(rand() . "_" . str_replace(' ', '_', $fileName));
    $photo_path = '../images/survey_photo/' . $basefilename;
    $img->load($_FILES['myfile']['tmp_name'])->fit_to_width(100)->save($photo_path);
//    copy($_FILES['myfile']['tmp_name'], $photo_path);
    echo $basefilename;
}

if ($_REQUEST['action'] == 'spot_task_photos') {
    $fileName = $_FILES['myfile']['name'];
    $ext = pathinfo($fileName, PATHINFO_EXTENSION);
    $ext = strtolower($ext);
    $basefilename = strtolower(rand() . "_" . str_replace(' ', '_', $fileName));
//    $photo_path = '../images/' . $basefilename;
    $photo_path = '../images/spot_task_photos/' . $basefilename;
    //copy($_FILES['myfile']['tmp_name'], $photo_path);
    $img->load($_FILES['myfile']['tmp_name'])->fit_to_width(100)->save($photo_path);
    
    echo $basefilename;
}

if ($_REQUEST['action'] == 'edit_spot_task_photos') {
    $fileName = $_FILES['myfile']['name'];
    $ext = pathinfo($fileName, PATHINFO_EXTENSION);
    $ext = strtolower($ext);
    $basefilename = strtolower(rand() . "_" . str_replace(' ', '_', $fileName));
    $photo_path = '../images/spot_task_photos/' . $basefilename;
//    copy($_FILES['myfile']['tmp_name'], $photo_path);
    $img->load($_FILES['myfile']['tmp_name'])->fit_to_width(100)->save($photo_path);
    echo $basefilename;
}
?>