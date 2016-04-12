<!DOCTYPE HTML>
<html class="no-js">
   <head>
      <!-- Basic Page Needs
        ================================================== -->
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <title>anfiRENT</title>
      <meta name="description" content="">
      <meta name="keywords" content="">
      <meta name="author" content="">
      <!-- Mobile Specific Metas-->
      
      <LINK REL="SHORTCUT ICON" HREF="images/favicon.ico" /> 
       <!--- ================================================== -->
      <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">
      <meta name="format-detection" content="telephone=no">
      <!-- CSS
        ================================================== -->
      <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
      <link href="css/style.css" rel="stylesheet" type="text/css">

      <link href="plugins/prettyphoto/css/prettyPhoto.css" rel="stylesheet" type="text/css">
      <link href="plugins/owl-carousel/css/owl.carousel.css" rel="stylesheet" type="text/css">
      <link href="plugins/owl-carousel/css/owl.theme.css" rel="stylesheet" type="text/css">
      <!--[if lte IE 8]><link rel="stylesheet" type="text/css" href="css/ie8.css" media="screen" /><![endif]-->
      <!-- Color Style -->
      <link class="alt" href="colors/color1.css" rel="stylesheet" type="text/css">
      <link href="style-switcher/css/style-switcher.css" rel="stylesheet" type="text/css">
      <!-- SCRIPTS
        ================================================== -->
      <script src="js/modernizr.js"></script><!-- Modernizr -->

   </head>
   <body class="home">
      <!--[if lt IE 7]>
              <p class="chromeframe">You are using an outdated browser. <a href="http://browsehappy.com/">Upgrade your browser today</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to better experience this site.</p>
      <![endif]-->
      <div class="body">
         <!-- Start Site Header -->
         <header class="site-header">
            <div class="top-header hidden-xs">
               <div class="container">
                  <div class="row">
                     <div class="col-md-4 col-sm-6">&nbsp;</div>
                     <div class="col-md-8 col-sm-6">
                        <?php if (!isset($_SESSION[PREFIX . 'user_id']) || $_SESSION[PREFIX . 'user_id'] == "" || !isset($_SESSION[PREFIX . 'email']) || $_SESSION[PREFIX . 'email'] == "") { ?>
                           <ul class="horiz-nav pull-right">
                              <li><a href="<?= HOST ?>how_it_works.php"><img src="<?= HOST ?>/images/icons/how_it_work.png" /> How it works </a></li>
                              <li><a href="<?= HOST ?>login.php"><i class="fa fa-user"></i> Login </a></li>
                              <li><a href="<?= HOST ?>register.php"><i class="fa fa-check-circle"></i> Register</a></li>
                           </ul>
                        <?php } else { ?>
                           <ul class="horiz-nav pull-right">
                              <li><a href="<?= HOST ?>how_it_works.php"><img src="<?= HOST ?>/images/icons/how_it_work.png" /> How it works </a></li>
                              <li class="dropdown"><a data-toggle="dropdown"><i class="fa fa-user"></i> Welcome <?= $_SESSION[PREFIX . 'first_name'] ?> <b class="caret"></b></a>
                                 <ul class="dropdown-menu">
                                    <li><a href="<?= HOST ?>profile.php"><i class="fa fa-check-circle"></i> My Profile</a></li>
                                    <li><a href="<?= HOST ?>logout.php"><i class="fa fa-check-circle"></i> Logout</a></li>
                                    <!--<li><a href="#">Add a property</a></li>-->
                                 </ul>
                              </li>
                           </ul>
                        <?php } ?>
                     </div>
                  </div>
               </div>
            </div>
            <div class="middle-header">
               <div class="container">
                  <div class="row">
                     <div class="col-md-4 col-sm-8 col-xs-8">
                        <h1 class="logo"> <a href="<?= HOST ?>"><img src="images/logo.png" alt="Logo"></a> </h1>
                     </div>
                     <div class="col-md-8 col-sm-4 col-xs-4">
                        <div class="contact-info-blocks hidden-sm hidden-xs">
                           <div>
                              <i class="fa fa-phone"></i> Free Line For You
                              <span>+47 95009500</span>
                           </div>
                           <div>
                              <i class="fa fa-envelope"></i> Email Us
                              <span><a href="mailto:info@anfirent.com">info@anfirent.com</a></span>
                           </div>

                        </div>
                        <a href="#" class="visible-sm visible-xs menu-toggle"><i class="fa fa-bars"></i></a>
                     </div>
                  </div>
               </div>
            </div>
            <div class="main-menu-wrapper">
               <div class="container">
                  <div class="row">
                     <div class="col-md-12">
                        <nav class="navigation">
                           <ul class="sf-menu">

                              <?php if (isset($_SESSION[PREFIX . "user_id"]) && !empty($_SESSION[PREFIX . "user_id"])) { ?>
                                 <li><a href="<?= HOST ?>dashboard.php">Dashboard</a> </li>
                                 <li> <a href="<?= HOST ?>view_properties.php">My Properties <?php if(CountPropertyByUserID($_SESSION[PREFIX . "user_id"]) > 0) { ?><span class="badge"><?=CountPropertyByUserID($_SESSION[PREFIX . "user_id"]); ?></span><?php } ?></a></li>
                                 <li><a href="<?= HOST ?>inquiries.php">My Inquiries <?php if(CountInquiryByUserID($_SESSION[PREFIX . "user_id"]) > 0) { ?><span class="badge"><?=CountInquiryByUserID($_SESSION[PREFIX . "user_id"]); ?></span><?php } ?></a></li>
                              <?php } else { ?>
                                 <li><a href="<?= HOST ?>properties_list_view.php">Properties</a> </li>
                                 <li><a href="<?= HOST ?>gallery.php">Gallery</a></li>
                                 <li><a href="<?= HOST ?>about_us.php">About Us</a></li>
                                 <li><a href="<?= HOST ?>contact_us.php">Contact Us</a></li>
                              <?php } ?>


                           </ul>
                        </nav>
                     </div>
                  </div>
               </div>
            </div>
         </header>