<!-- Start Site Footer -->
<footer class="site-footer-bottom">
    <div class="container">
        <div class="row">
            <div class="copyrights-col-left col-md-6 col-sm-6">
                <p>&copy; 2014 anfiRENT.com. All Rights Reserved</p>
            </div>
            <div class="copyrights-col-right col-md-6 col-sm-6">
                <div class="social-icons">
                    <a href="#" ><i class="fa fa-facebook"></i></a>
                    <a href="#" ><i class="fa fa-twitter"></i></a>

                    <a href="#" ><i class="fa fa-google-plus"></i></a>


                </div>
            </div>
        </div>
    </div>
</footer>
<!-- End Site Footer -->
<a id="back-to-top"><i class="fa fa-angle-double-up"></i></a>
</div>
<script src="js/jquery-2.0.0.min.js"></script> <!-- Jquery Library Call --> 
<script src="plugins/prettyphoto/js/prettyphoto.js"></script> <!-- PrettyPhoto Plugin --> 
<script src="plugins/owl-carousel/js/owl.carousel.min.js"></script> <!-- Owl Carousel --> 
<script src="plugins/flexslider/js/jquery.flexslider.js"></script> <!-- FlexSlider --> 
<script src="js/helper-plugins.js"></script> <!-- Plugins --> 
<script src="js/bootstrap.js"></script> <!-- UI --> 
<script src="js/waypoints.js"></script> <!-- Waypoints --> 
<script src="js/init.js"></script> <!-- All Scripts --> 
<script src="style-switcher/js/jquery_cookie.js"></script> 
<script src="style-switcher/js/script.js"></script> 
<!-- Style Switcher Start -->

<!-- Validation JS -->
<script src="js/jquery.validate.min.js"></script>
<script src="js/additional-methods.min.js"></script>

<?php foreach($css as $css_line): ?>
    <link rel="stylesheet" type="text/css" href="<?php echo CSS.$css_line; ?>.css" />
<?php endforeach; ?>

<?php foreach($js as $js_line): ?>
	<script src="<?php echo JS.$js_line; ?>.js" type="text/javascript"></script>
<?php endforeach; ?>


<script type="text/javascript">
$(".multiselect").length > 0 && $(".multiselect").each(function() {
        var e = $(this), t = e.attr("data-selectableheader"), n = e.attr("data-selectionheader");
        t != undefined && (t = "<div class='multi-custom-header'>" + t + "</div>");
        n != undefined && (n = "<div class='multi-custom-header'>" + n + "</div>");
        e.multiSelect({selectionHeader: n, selectableHeader: t})
    });
</script>

<script>
   $(document).ready(function() {
      $('.skin-line input').each(function() {
         var self = $(this),
                 label = self.next(),
                 label_text = label.text();

         label.remove();
         self.iCheck({
            checkboxClass: 'icheckbox_line-blue',
            radioClass: 'iradio_line-blue',
            insert: label_text
         });
      });
   });
</script>

<!-- Initialize the plugin: -->
<script type="text/javascript">
 $(document).ready(function() {
$('.multiselect').multiselect({
maxHeight: 200,
nonSelectedText: 'Select Week(s)'
});
});

</script>

</body>
</html>