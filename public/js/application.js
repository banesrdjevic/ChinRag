$(document).ready(function() {
  $('form').on('submit', function(e){
    e.preventDefault();
    var dataOutput = $('form').serialize();
    var request = $.ajax({
      url: '/links',
      method: 'get',
      data: dataOutput
    })

    request.done(function(response){
      $('ul').html(response)
    })
  })
});
