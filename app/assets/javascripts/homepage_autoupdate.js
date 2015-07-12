(function poll() {
  setTimeout(function() {
    $.get('/api/v1/systems', function(data) {
      var sectionID, dt;
      data['systems'].forEach(function(value, index, array) {
        sectionID=value.name.replace(/\s+/g,'');
        $("#"+sectionID).find("img").attr({src:"/assets/"+value.status+".png", alt: value.status});
        $("#"+sectionID).find("h5").attr({class: value.color})
        $("#"+sectionID).find("h5").text(value.message);
        dt=value.time;
      });
      $('#refresh').text('Last Refreshed: '+ dt);
      poll();
    });
  },30000);
})();

$(document).ready(function() {
  poll();
});