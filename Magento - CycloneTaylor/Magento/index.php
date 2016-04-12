<?php

//Here's an example how to get the site navigation.
require_once('app/Mage.php'); //Path to Magento
umask(0);
$app = Mage::app('default'); 
$_layout  = Mage::getSingleton('core/layout');
$_block   = $_layout->createBlock('catalog/navigation')->setTemplate('catalog/navigation/left.phtml');
echo $_block->toHtml();

//End
?>

<?php
//Get The Root Category In Magento
$rootCategoryId = Mage::app()->getStore()->getRootCategoryId();
$_category = Mage::getModel('catalog/category')->load($rootCategoryId);
$_subcategories = $_category->getChildrenCategories(); 
//End

//Load category by id
$_category = Mage::getModel('catalog/category')->load(89);
$_category_url = $_category->getUrl();
//End

//Load product by id or Sku
$_product_1 = Mage::getModel('catalog/product')->load(12);
$_product_2 = Mage::getModel('catalog/product')->loadByAttribute('sku','cordoba-classic-6-String-guitar');
//End
?>

<?php
//Call Static Block
echo $this->getLayout()->createBlock('cms/block')->setBlockId('block-name')->toHtml();
?>

<?php
//Get the current category/product/cms page
$currentCategory = Mage::registry('current_category');
$currentProduct = Mage::registry('current_product');
$currentCmsPage = Mage::registry('cms_page');
//End
?>

<?php
//Load Products by Category ID
$_category = Mage::getModel('catalog/category')->load(47);
$_productCollection = $_category->getProductCollection();
if($_productCollection->count()) {
    foreach( $_productCollection as $_product ):
        echo $_product->getProductUrl();
        echo $this->getPriceHtml($_product, true);
        echo $this->htmlEscape($_product->getName());
    endforeach;
}
//End
?>

<?php
//Check if customer is logged in
$_customer = Mage::getSingleton('customer/session')->isLoggedIn();
if ($_customer) {
	// code here
}
?>

<?php
//Get actual price and special price of a product

$_productId = 52;
$_product = Mage::getModel('catalog/product')->load($_productId);

// without currency sign
$_actualPrice = number_format($_product->getPrice(), 2);
// with currency sign
$_formattedActualPrice = Mage::helper('core')->currency(number_format($_product->getPrice(), 2),true,false);


// without currency sign
$_specialPrice = $_product->getFinalPrice();
// with currency sign
$_formattedSpecialPrice = Mage::helper('core')->currency(number_format($_product->getFinalPrice(), 2),true,false);

//End
?>

<?php
//Get order information on success.phtml
$_customerId = Mage::getSingleton('customer/session')->getCustomerId();
$lastOrderId = Mage::getSingleton('checkout/session')->getLastOrderId();
$order = Mage::getSingleton('sales/order');
$order->load($lastOrderId);
$_totalData =$order->getData();
$_grand = $_totalData['grand_total'];
//End
?>

<?php
//insert template in cms page

{{block type="core/template" name="my.block.name" template="myfolder/newfile.phtml"}}

//End
