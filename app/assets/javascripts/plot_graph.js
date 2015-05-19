var PLOT_GRAPH={
  plot: function (data, targetDiv, label, color) {
    var options, plot,
        targetDiv=$(targetDiv);

    options= {
      xaxis: {mode: 'time', minTickSize: [1, 'hour'], timezone: 'browser'},
      crosshair: { mode: 'xy'},
      selection: { mode: 'xy'},
      grid: {hoverable: true, clickable: true, backgroundColor: '#FFFFED'},
      yaxis: { min: 0 }
    };  

    targetDiv.bind("plotselected", function (event, ranges) {
      $.each(plot.getXAxes(), function (_, axis) {
        var opts = axis.options;
        opts.min = ranges.xaxis.from;
        opts.max = ranges.xaxis.to;
      });
      $.each(plot.getYAxes(), function (_, axis) {
        var opts = axis.options;
        opts.min = ranges.yaxis.from;
        opts.max = ranges.yaxis.to;
      });
      plot.setupGrid();
      plot.draw();
      plot.clearSelection();
    });

    $("<div id='tooltip'></div>").css({
      position: "absolute",
      display: "none",
      border: "1px solid #fdd",
      padding: "2px",
      "background-color": "#fee",
      opacity: 0.80
    }).appendTo("body");

    targetDiv.bind("plothover", function (event, pos, item) {
      if (item) {
        var x = new Date(item.datapoint[0]),
          y = item.datapoint[1].toFixed(2)+' %';
        $("#tooltip").html(y + " , " + x)
          .css({top: item.pageY+10, left: item.pageX+10})
          .fadeIn(200);
      } else {
        $("#tooltip").hide();
      }
    });

    plot=$.plot(targetDiv, [{data: data, label: label, color: color}], options);
  }
}