<?php
$objUser = new Users();
$objArticle = new Articles();
$objArticleTags = new Articles_tags();
$objArticleSubscription = new Article_subscription();
$objArticleLike = new Article_like();
if (isset($_POST['action']) && $_POST['action'] == "SaveArticle"){
    $id = $_REQUEST['article_id'];
    if($id==0){
        $objArticle->title= $_REQUEST['article-title'];
        $objArticle->category= $_REQUEST['article-category'];
        $objArticle->tags= $_REQUEST['article-tags'];
        $objArticle->description= $_REQUEST['article-description'];
        $objArticle->status='1';
        $objArticle->created_by = $f3->get("SESSION.wpms_id");
        $objArticle->datecreated = date(DATE_DB_INSERT);
        $objArticle->datemodified = date(DATE_DB_INSERT);
        $objArticle->insert();
        $articleTags = explode(",",$_REQUEST['article-tags']);
        foreach($articleTags as $tags)
        {
            if(trim($tags) != "")
            {
                $objArticleTags->load(array("tags=?",trim($tags)));
                if(!$objArticleTags->id){
                    $objArticleTags->reset();
                    $objArticleTags->tags = trim($tags);
                    $objArticleTags->datecreated = date(DATE_DB_INSERT);
                    $objArticleTags->datemodified = date(DATE_DB_INSERT);
                    $objArticleTags->insert();
                }
                $objArticleTags->reset();
            }
        }
        $objUser->load(array('id=?',$f3->get("SESSION.wpms_id")));
        
        $objData = array(
            "created_user"=>'#'.$f3->get("SESSION.wpms_id").'#',
            "created_email"=>$objUser->email,
            "title"=>$objArticle->title,
            "category"=>$objArticle->category,
            "posted_by"=>$objUser->firstname." ".substr($objUser->lastname,0,1),
            "posted_date"=>date_convert($objArticle->datecreated,DATE_DISPLAY_FORMAT),
            "url"=>'article'
        );
        $email = send_email("new-article",$objData,$f3);
        $notification = create_notification("new-article",$objData,$f3);
        
        $output = array("message"=>'success',
                        "id"=>$objArticle->id,
                        "title"=>$objArticle->title,
                        "category"=>$objArticle->category,
                        "description"=>makeClickableLinks($objArticle->description),
                        "created_by"=>$objArticle->created_by,
                        "datecreated"=>$objArticle->datecreated,
                        "user_fullname"=>$objUser->firstname." ".$objUser->lastname,
                );
    }else{
        $objArticle->load(array("id=?",$id));
        $objArticle->title= $_REQUEST['article-title'];
        $objArticle->category= $_REQUEST['article-category'];
        $objArticle->tags= $_REQUEST['article-tags'];
        $objArticle->description= $_REQUEST['article-description'];
        $objArticle->status='1';
        $objArticle->datemodified = date(DATE_DB_INSERT);
        $objArticle->update();
        $articleTags = explode(",",$_REQUEST['article-tags']);
        foreach($articleTags as $tags)
        {
            if(trim($tags) != "")
            {
                $objArticleTags->load(array("tags=?",trim($tags)));
                if(!$objArticleTags->id){
                    $objArticleTags->reset();
                    $objArticleTags->tags = trim($tags);
                    $objArticleTags->datecreated = date(DATE_DB_INSERT);
                    $objArticleTags->datemodified = date(DATE_DB_INSERT);
                    $objArticleTags->insert();
                }
                $objArticleTags->reset();
            }
        }
        $tags = explode(",",$objArticle->tags);
        $tagHTML = "";
        foreach($tags as $t){
            if(trim($t)!=''){
                $tagHTML.='<span class="label project-tags label-default">'.$t.'</span>';
            }
        }
        $output = array("message"=>'update_success',"id"=>$objArticle->id,"title"=>$objArticle->title,"description"=>makeClickableLinks($objArticle->description),"tags_html"=>$tagHTML);
    }
    echo json_encode($output);
}
if (isset($_POST['action']) && $_POST['action'] == "GetArticleDetails"){
    $id = $_REQUEST['Id'];
    $campaindetails=$f3->get('DB')->exec("select * from articles where id = '$id'");
    $output=array("article_data"=>$campaindetails[0],"message"=>'success');
    echo json_encode($output);
    exit;
}
if (isset($_POST['action']) && $_POST['action'] == "GetArticle"){
    $articleTags = explode(",",$_REQUEST['search']);
    $searchFilter = array();
    foreach($articleTags as $tags)
    {
        if(trim($tags) != "")
        {
            $searchFilter[] = "a.tags LIKE '%".trim($tags)."%'";
        }
    }
    $searchFilter[] = "a.title LIKE '%".trim($_REQUEST['search'])."%'";
    $WHERE = "";
    if(count($searchFilter)>0){ $WHERE = "WHERE (".implode(" OR ",$searchFilter).")";}
    
    # Add category filter
    $objArticleSubscription->load(array('uid=?',$f3->get("SESSION.wpms_id")));
    $subscriptionArray = array();
    $categoryFilter = "";
    if($objArticleSubscription->categories)
    {
        $subscriptionArray = explode(",",$objArticleSubscription->categories);
        $i=0;
        foreach($subscriptionArray as $category)
        {
            $i++;
            $categoryFilter .= "'".$category."',";
        }
        if($i>0)
            $WHERE .= " AND a.category IN(".rtrim($categoryFilter,',').")";
    }
    
    $start = trim($_POST['start']);
    $articles= $f3->get('DB')->exec("SELECT a.*, concat(b.firstname,' ',b.lastname) as user_fullname,c.id as `like`,d.totalLike FROM `articles` a left join user b ON a.created_by=b.id left join article_like c on a.id=c.article_id and c.uid='".$f3->get("SESSION.wpms_id")."' left join (select article_id,count(*) as totalLike from article_like group by article_id) d ON d.article_id = a.id $WHERE order by a.id desc limit $start,10");
    $articlesWrap = array();
    foreach($articles as $article)
    {
        $article['description'] = makeClickableLinks($article['description']);
        if(strlen(strip_tags($article['description'])) > 500)
        {
            $article['description'] =  html::trim($article['description'], 500).'<p class="text-left"><a href="javascript:void(0)" class="article-readmore" onclick="loadFullArticle(\''.$article['id'].'\')">read more </a></p>';
        }
        array_push($articlesWrap,$article);
    }
    echo json_encode($articlesWrap);
}
if (isset($_POST['action']) && $_POST['action'] == "DeleteArticle"){
    $objArticle->erase(array("id=? AND created_by=".$f3->get("SESSION.wpms_id"),$_REQUEST['id']));
    $output = array("message"=>'success');
    echo json_encode($output);
}
if (isset($_POST['action']) && $_POST['action'] == "GetArticleTags"){
    $tags= $f3->get('DB')->exec("select tags from articles_tags order by tags asc");
    $displayTags = array();
    foreach($tags as $tag)
    {
        $displayTags[] = $tag['tags'];
    }
    echo json_encode($displayTags);
}
if(isset($_POST['action']) && $_POST['action'] == "SaveSubscription")
{
    $userId = $f3->get("SESSION.wpms_id");
    $objArticleSubscription->total_count = 'COUNT(*)';
    $objArticleSubscription->load(array('uid=?',$userId));
    if($objArticleSubscription->total_count)
    {
        $objArticleSubscription->categories = rtrim($_POST['categories'],",");
        $objArticleSubscription->update();
    }
    else
    {
        $objArticleSubscription->reset();
        $objArticleSubscription->uid = $f3->get('SESSION.wpms_id');
        $objArticleSubscription->categories = rtrim($_POST['categories'],",");
        $objArticleSubscription->insert();
    }
    $output = array("message"=>'success');
    echo json_encode($output);
}
if(isset($_POST['action']) && $_POST['action'] == "LikeArticle")
{
    $aid = $_POST['aid'];
    $userId = $f3->get("SESSION.wpms_id");
    $objArticleLike->total_count = 'COUNT(*)';
    $objArticleLike->load(array('uid='.$userId.' AND article_id=?',$aid));
    if($objArticleLike->total_count)
    {
        $aid = $objArticleLike->id;
        $objArticleLike->reset();
        $objArticleLike->erase(array("id=?",$aid));
    }
    else
    {
        $objArticleLike->reset();
        $objArticleLike->uid = $f3->get('SESSION.wpms_id');
        $objArticleLike->article_id = $aid;
        $objArticleLike->insert();
    }
    $output = array("message"=>'success');
    echo json_encode($output);
}
class Html{

  protected
    $reachedLimit = false,
    $totalLen     = 0,
    $maxLen       = 25,
    $toRemove     = array();

  public static function trim($html, $maxLen = 25){

    $dom = new DomDocument();
    @$dom->loadHTML(@$html);

    $html = new static();
    $toRemove = $html->walk($dom, $maxLen);

    // remove any nodes that passed our limit
    foreach($toRemove as $child) 
      $child->parentNode->removeChild($child);
  
    // remove wrapper tags added by DD (doctype, html...)
    if(version_compare(PHP_VERSION, '5.3.6') < 0){
      // http://stackoverflow.com/a/6953808/1058140
      $dom->removeChild($dom->firstChild);            
      $dom->replaceChild($dom->firstChild->firstChild->firstChild, $dom->firstChild);
      return $dom->saveHTML();
    }

    return $dom->saveHTML($dom->getElementsByTagName('body')->item(0));   
  }

  protected function walk(DomNode $node, $maxLen){

    if($this->reachedLimit){
      $this->toRemove[] = $node;

    }else{
      // only text nodes should have text,
      // so do the splitting here
      if($node instanceof DomText){
        $this->totalLen += $nodeLen = strlen($node->nodeValue);

        // use mb_strlen / mb_substr for UTF-8 support
        if($this->totalLen > $maxLen){
          $node->nodeValue = substr($node->nodeValue, 0, $nodeLen - ($this->totalLen - $maxLen)) . '...';
          $this->reachedLimit = true;
        }

      }

      // if node has children, walk its child elements 
      if(isset($node->childNodes))
        foreach($node->childNodes as $child)
          $this->walk($child, $maxLen);
    }  

    return str_replace("<br>","",$this->toRemove);
  }  
}
?>