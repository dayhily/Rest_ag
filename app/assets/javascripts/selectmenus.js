// "(document).on('turbolinks:load', function() {})"
// hook in to an event fired by Turbolinks for every page visit
$(document).on('turbolinks:load', function selectcountry() {
  $('#administrative_area').prop('disabled', true);
  var areas = $('#administrative_area').html();
  console.log(areas);
  return $('#country').change(function() {
  var country_select, options1;
   country_select = $('#country :selected').text();
   escaped_country = country_select.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
   console.log(country_select);
    options1 = $(areas).filter("optgroup[label=" + escaped_country + "]").html();
    console.log(options1);
    if (options1) {
      $('#administrative_area').html('<option value="">Select area').append(options1);
      return $('#administrative_area').prop('disabled', false);
    } else {
      $('#administrative_area').empty();
      return $('#administrative_area').prop('disabled', true);
    }
  });
});

$(document).on('turbolinks:load', function selectarea() {
  $('#locality').prop('disabled', true);
  var localities = $('#locality').html();
  console.log(localities);
    return $('#administrative_area').change(function() {
    var area_select, options2;
     area_select = $('#administrative_area :selected').text();
     escaped_area = area_select.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
     console.log(area_select);
      options2 = $(localities).filter("optgroup[label=" + escaped_area + "]").html();
      console.log(options2);
      if (options2) {
        $('#locality').html('<option value="">Select locality').append(options2);
        return $('#locality').prop('disabled', false);
      } else {
        $('#locality').empty();
        return $('#locality').prop('disabled', true);
      }
    });
});