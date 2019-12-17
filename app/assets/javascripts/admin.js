//= require jquery.raty.js


$(document).ready(function(){
    // Activate tooltip
    $('[data-toggle="tooltip"]').tooltip();

    // Select/Deselect checkboxes
    var checkbox = $('table tbody input[type="checkbox"]');
    $("#selectAll").click(function(){
        if(this.checked){
            checkbox.each(function(){
                this.checked = true;
            });
        } else{
            checkbox.each(function(){
                this.checked = false;
            });
        }
    });
    checkbox.click(function(){
        if(!this.checked){
            $("#selectAll").prop("checked", false);
        }
  });
      $('.navbar-toggle-sidebar').click(function () {
          $('.navbar-nav').toggleClass('slide-in');
          $('.side-body').toggleClass('body-slide-in');
          $('#search').removeClass('in').addClass('collapse').slideUp(200);
      });

      $('#search-trigger').click(function () {
          $('.navbar-nav').removeClass('slide-in');
          $('.side-body').removeClass('body-slide-in');
          $('.search-input').focus();
      });
});