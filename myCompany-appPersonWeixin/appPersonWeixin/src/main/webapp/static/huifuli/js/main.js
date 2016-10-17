$(function() {
    $('.h_back').click(function(e) {
        e.preventDefault();
        history.go(-1);
    });
});