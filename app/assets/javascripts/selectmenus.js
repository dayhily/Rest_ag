// "(document).on('turbolinks:load', function() {})"
// hook in to an event fired by Turbolinks for every page visit
$(document).on('turbolinks:load', function() {
  var areas = $('#administrative_area').html();
  console.log(areas);
  return $('#country').change(function() {
    var countries, options;
   countries = $(this).find("option:selected").text();
   escaped_country = countries.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
   console.log(country);
    options = $(areas).filter("optgroup[label=" + escaped_country + "]").html();
    console.log(options);
    if (options) {
      return $('#administrative_area').html(options);
    } else {
      return $('#administrative_area').empty();
    }
  })
});