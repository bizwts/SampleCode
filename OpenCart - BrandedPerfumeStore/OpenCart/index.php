<?php
//getCategories function from catalog/controller/module/category.php. 
//Here it is:
protected function getCategories($parent_id, $current_path = '') {
	$category_id = array_shift($this->path);
	$output = '';
	$results = $this->model_catalog_category->getCategories($parent_id);
	if ($results) {
		$output .= '<ul>';
	}
	foreach ($results as $result) {
		if (!$current_path) {
			$new_path = $result['category_id'];
		} else {
			$new_path = $current_path . '_' . $result['category_id'];
		}
	$output .= '<li>';
	$children = '';
	if ($category_id == $result['category_id']) {
		$children = $this->getCategories($result['category_id'], $new_path);
	}
	if ($this->category_id == $result['category_id']) {
		$output .= '<a href="' . $this->model_tool_seo_url->rewrite(HTTP_SERVER . 'index.php?route=product/category&path=' . $new_path) . '"><b>' . $result['name'] . '</b></a>';
	} else {
		$output .= '<a href="' . $this->model_tool_seo_url->rewrite(HTTP_SERVER . 'index.php?route=product/category&path=' . $new_path) . '">' . $result['name'] . '</a>';
	}
	$output .= $children;
	$output .= '</li>';
	}
	if ($results) {
		$output .= '</ul>';
	}
	return $output;
}

//getTotalProducts() method was being called on a single page
public function getTotalProducts($data = array()) {
   $cacheid='product.gettotalproducts.'.md5($sql).(int)$customer_group_id;
   $total=$this->cache->get($cacheid);
   if ($total === null ) {
       $query = $this->db->query($sql);
       $total = $query->row['total'];
       $this->cache->set($cacheid,$total);
   }
   return $total;
}
//End
?>

<?php  
//setting Up the Controller
class ControllerCustompageMycustompage extends Controller {
  public function index() {
    // set title of the page
    $this->document->setTitle("My Custom Page");
     
    // define template file
    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/custompage/mycustompage.tpl')) {
      $this->template = $this->config->get('config_template') . '/template/custompage/mycustompage.tpl';
    } else {
      $this->template = 'default/template/custompage/mycustompage.tpl';
    }
     
    // define children templates
    $this->children = array(
      'common/column_left',
      'common/column_right',
      'common/content_top',
      'common/content_bottom',
      'common/footer',
      'common/header'
    );
     
    // set data to the variable
    $this->data['my_custom_text'] = "This is my custom page.";
 
    // call the "View" to render the output
    $this->response->setOutput($this->render());
  }
}
?>

//Opencart add Google rich snippets
<div class="breadcrumb"><div xmlns:v="http://rdf.data-vocabulary.org/#">
<?php $seocrumbs = array_pop($breadcrumbs); ?>
<?php foreach($breadcrumbs as $seocrumb) { ?>
<span typeof="v:Breadcrumb"><?php echo $seocrumb['separator']; ?><a href="<?php echo $seocrumb['href']; ?>" rel="v:url" property="v:title"><?php echo $seocrumb['text'];?></a></span>
<?php } ?>
<?php echo $seocrumb['separator'];?> <p><?php echo $seocrumbs['text']; ?></p>
</div>
?>
//End