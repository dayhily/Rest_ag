// "(document).on('turbolinks:load', function() {})"
// hook in to an event fired by Turbolinks for every page visit
$(document).on('turbolinks:load', function selectcountry() {
  var areas = $('#administrative_area').html();
  console.log(areas);
  return $('#country').change(function() {
  var country_select, options1;
   country_select = $(this).find("option:selected").text();
   escaped_country = country_select.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
   console.log(country_select);
    options1 = $(areas).filter("optgroup[label=" + escaped_country + "]").html();
    console.log(options1);
    if (options1) {
      return $('#administrative_area').html('<option value="">Select area').append(options1);
    } else {
      return $('#administrative_area').empty();
    }
  })
});

$(document).on('turbolinks:load', function selectarea() {
  var localities = $('#locality').html();
  console.log(localities);
    return $('#administrative_area').change(function() {
    var area_select, options2;
     area_select = $(this).find("option:selected").text();
     escaped_area = area_select.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
     console.log(area_select);
      options2 = $(localities).filter("optgroup[label=" + escaped_area + "]").html();
      console.log(options2);
      if (options2) {
        return $('#locality').html('<option value="">Select locality').append(options2);
      } else {
        return $('#locality').empty();
      }
    })
});