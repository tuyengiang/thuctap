/**Menu */
jQuery(document).ready(function ($) {
    $('#bar-mobile').click(function () {
        $('.header-menu').fadeIn('slow');
    });
    $("#exit").click(function () {
        $('.header-menu').fadeOut('slow');
    });
});