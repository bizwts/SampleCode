<?php

//Here's an example how to import products into datbase via csv file.
set_time_limit(0);
ini_set('memory_limit', '1024M');
include_once "app/Mage.php";   // Path to Magento
include_once "downloader/Maged/Controller.php"; 
Mage::init();

$app = Mage::app('default'); 
//The category names should be exactly the same name from the csv file where the id is the corresponding category id in magento. This is done when the csv file doesn't contain ids for categories but the name of categories.
$categories = array(
    'Shirts' => 3,
    'TShirts' => 4,
    'Paint' => 5,
    'Accessory' => 6,
);

$row = 0;
if (($handle = fopen("catalog_product.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 10000, ",")) !== FALSE) {
        $num = count($data);
        $row++;
        for ($c=0; $c < $num; $c++) {
          $col[$c] = $data[$c];
        }
     
         
        if ($row == 1)
            continue;

        echo "<pre>";
        print_r ($col);
        
        /*$product = Mage::getModel('catalog/product');
        $product->setSku($data[0]);
        $product->setName($data[37]);
        $product->setDescription($data[18]);
        $product->setShortDescription($data[45]);
        $product->setManufacturer($data[28]);
        $product->setPrice($data[43]);
        $product->setTypeId('simple');
    
        $product->setAttributeSetId(4); // need to look this up
        $product->setCategoryIds(array($categories[$data[4]])); // need to look these up
        $product->setWeight($data[62]);
        $product->setTaxClassId($data[55]); // taxable goods
        $product->setVisibility($data[61]); // catalog, search
        $product->setStatus(1); // enabled
        // assign product to the default website
        $product->setWebsiteIds(array(Mage::app()->getStore(true)->getWebsite()->getId()));


        $stockData = $product->getStockData();
        $stockData['qty'] = $data[63];
        $stockData['is_in_stock'] = $data[73];
        $stockData['manage_stock'] = $data[76];
        $stockData['use_config_manage_stock'] = $data[77];
        $product->setStockData($stockData);
        $product->save();*/
    }
    fclose($handle);
}
?>
