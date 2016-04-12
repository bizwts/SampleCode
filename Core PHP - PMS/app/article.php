<div id="content">
    <section class="style-default-bright">
        <div class="section-header">
            <h3 class="text-light text-info">
                <div class="project-title project-breadcrumb border-none p-left-0">
                    <div class="btn-group">
                        <a href="javascript:;" class="project-breadcrumb-link">Articles</a>
                    </div>
                    <div class="btn-group pull-right">
                        <ul class="project-actions">
                            <li><i class="fa fa-search font-12 color-light-grey"></i></li>
                            <li><input type="search" id="article-tags-search" class="form-control font-12 article-search-input" placeholder="Search by tags / title"></li>
                            <li>
                                <a href="javascript:void(0)" onclick="MakePageBookmark(this,'article','Articles','fa fa-quote-left article')" class="btn btn-sm btn-default text-default-light"><i class="fa fa-star font-16 <?=$fav_class?>"></i></a>
                            </li>
                            <li>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-sm btn-default text-default-light article-filter dropdown-toggle" data-toggle="dropdown"><i class="fa fa-filter"></i></button>
                                    <ul class="dropdown-menu dropdown-menu-right dropdown-menu-subscription" role="menu">
                                        <?php
                                        $objArticleSubscription = new Article_subscription();
                                        $objArticleSubscription->load(array('uid=?',$f3->get("SESSION.wpms_id")));
                                        $subscriptionArray = array();
                                        if($objArticleSubscription->categories)
                                        {
                                            $subscriptionArray = explode(",",$objArticleSubscription->categories);
                                        }
                                        ?>
                                        <li>
                                            <label class="checkbox-inline checkbox-styled checkbox-success">
                                                <input type="checkbox" class="subscription-checkbox" name="category" value="Technical" <?=(in_array("Technical",$subscriptionArray))?"checked":""?>><span class="text-black">Technical</span>
                                            </label>
                                        </li>
                                        <li>
                                            <label class="checkbox-inline checkbox-styled checkbox-success">
                                                <input type="checkbox" class="subscription-checkbox" name="category" value="Functional" <?=(in_array("Functional",$subscriptionArray))?"checked":""?>><span class="text-black">Functional</span>
                                            </label>
                                        </li>
                                        <li>
                                            <label class="checkbox-inline checkbox-styled checkbox-success">
                                                <input type="checkbox" class="subscription-checkbox" name="category" value="Code" <?=(in_array("Code",$subscriptionArray))?"checked":""?>><span class="text-black">Code</span>
                                            </label>
                                        </li>
                                        <li>
                                            <label class="checkbox-inline checkbox-styled checkbox-success">
                                                <input type="checkbox" class="subscription-checkbox" name="category" value="Testing" <?=(in_array("Testing",$subscriptionArray))?"checked":""?>><span class="text-black">Testing</span>
                                            </label>
                                        </li>
                                        <li>
                                            <label class="checkbox-inline checkbox-styled checkbox-success">
                                                <input type="checkbox" class="subscription-checkbox" name="category" value="Management" <?=(in_array("Management",$subscriptionArray))?"checked":""?>><span class="text-black">Management</span>
                                            </label>
                                        </li>
                                        <li>
                                            <label class="checkbox-inline checkbox-styled checkbox-success">
                                                <input type="checkbox" class="subscription-checkbox" name="category" value="Business" <?=(in_array("Business",$subscriptionArray))?"checked":""?>><span class="text-black">Business</span>
                                            </label>
                                        </li>
                                        <li>
                                            <label class="checkbox-inline checkbox-styled checkbox-success">
                                                <input type="checkbox" class="subscription-checkbox" name="category" value="Logic" <?=(in_array("Logic",$subscriptionArray))?"checked":""?>><span class="text-black">Logic</span>
                                            </label>
                                        </li>
                                        <li>
                                            <label class="checkbox-inline checkbox-styled checkbox-success">
                                                <input type="checkbox" class="subscription-checkbox" name="category" value="Leisure" <?=(in_array("Leisure",$subscriptionArray))?"checked":""?>><span class="text-black">Leisure</span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li><a href="#offcanvas-article" id="article_add_href" class="btn btn-sm btn-default text-default-light" data-toggle="offcanvas" data-original-title="Tasks" data-placement="bottom" data-toggle="tooltip">Add new...</a></li>
                        </ul>
                    </div>
                </div>
            </h3>
        </div>
        <div class="section-body">
            <div class="row">
                <div class="row">
                    <div id="columns" data-columns class="col-md-12"></div>
                </div>
            </div>
        </div>
        <!--end .section-body -->
    </section>
</div>
<div class="offcanvas">
    <div id="offcanvas-article" class="offcanvas-pane width-12" style="width:450px">
        <form role="form" class="form" id="ArticleForm" novalidate="novalidate">
            <div class="row">
                <div class="col-md-12">
                    <div class="offcanvas-head offcanvas-title">
                        <div class="row">
                            <div class="col-md-5 col-xs-6">
                                <h4 class="header article-offcanvas-title text-primary">Add Article</h4>
                            </div>
                            <div class="col-md-7 col-xs-6">
                                <div class="pull-right m-top-3">
                                    <button class="btn btn-sm ink-reaction btn-raised btn-info submit-btns" type="submit">Save</button>
                                    <button type="reset" id="reset-button" class="btn btn-default hidden">Cancel</button>
                                    <button class="btn btn-sm ink-reaction btn-icon-toggle-square btn-raised btn-default-light" data-dismiss="offcanvas" id="close-button" type="button"> <i class="md md-close"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="loader" style="display:none">
                                    <i class="fa-spin fa fa-spinner fa-3x"></i>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-body project-details">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <input type="text" class="form-control input-sm" id="article-title" name="article-title" required>
                                                    <label>Title <strong class="text-danger-mandatory">*</strong></label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <select class="form-control select2-list input-sm" id="article-category" name="article-category" required>
                                                        <option value="">Select category</option>
                                                        <option value="Technical">Technical</option>
                                                        <option value="Functional">Functional</option>
                                                        <option value="Code">Code</option>
                                                        <option value="Testing">Testing</option>
                                                        <option value="Management">Management</option>
                                                        <option value="Business">Business</option>
                                                        <option value="Logic">Logic</option>
                                                        <option value="Leisure">Leisure</option>
                                                    </select>
                                                    <label>Category <strong class="text-danger-mandatory">*</strong></label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <input type="text" class="form-control input-sm" id="article-tags" name="article-tags" placeholder="Add multiple tags seperated by comma(,)">
                                                    <label>Tags</label>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <textarea rows="3" class="form-control input-sm input-email-body autosize" id="article-description" name="article-description" required></textarea>
                                                    <input type="hidden" id="article_id" name="article_id" value="0">
                                                    <input type="hidden" id="action" name="action" value="SaveArticle">
                                                    <label>Description <strong class="text-danger-mandatory">*</strong></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="modal fade" id="ArticleDelete" role="dialog" aria-labelledby="simpleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Delete Article</h4>
            </div>
            <div class="modal-body">
                <p><?=MESSAGE_DELETE_CONFIRMATION?>article?</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="delete-article-id" value="">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <button type="button" class="btn <?=BTN_DELETE_CONFIRMATION?>" onclick="DeleteArticle(this);">Yes, sure</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="ArticleDetail" role="dialog" aria-labelledby="simpleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="full-article-title"></h4>
            </div>
            <div class="modal-body" id="full-article-description">
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    var SESS_ID = <?=$f3->get("SESSION.wpms_id")?>;
</script>