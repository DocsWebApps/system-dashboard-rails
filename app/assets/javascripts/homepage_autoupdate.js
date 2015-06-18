(function poll() {
  setTimeout(function() {
    $.get('/api/v1/systems', function(data) {
      var sectionID;
      data['systems'].forEach(function(value, index, array) {
        sectionID=value.name.replace(/\s+/g,'');
        $("#"+sectionID).find("img").attr({src:"/assets/"+value.status+".png", alt: value.status});
        $("#"+sectionID).find("h5").attr({class: value.color})
        $("#"+sectionID).find("h5").text(value.message);
      });
      poll();
    });
  },30000);
})();

$(document).ready(function() {
  poll();
});