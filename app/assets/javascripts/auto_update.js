var AUTO_UPDATE={
  init: function() {
    return 1;
  },

  fetchSystems: function() {
    $.get('/api/v1/systems', function(data) {
      data['systems'].forEach(function(value, index, array) {
        //$("#"+value.name).find("img").attr("src","/assets/green.png");
        //$("#"+value.name).find("h3").text('Dave');
        alert(value.name);
      });
    });
  }
};

$(document).ready(function() {
  //AUTO_UPDATE.init();
  AUTO_UPDATE.fetchSystems();
});