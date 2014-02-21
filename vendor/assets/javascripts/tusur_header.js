//= require bootstrap/button
//= require bootstrap/dropdown

//= require tusur_header_observer

$(function() {
  if ($('.tusur_header_wrapper').length) {
    init_tusur_header_observer();
  }
});
