---
title: Chart Test
layout: single
permalink: /chart/
---

<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
  google.charts.load("current", {packages:["timeline"]});
  google.charts.setOnLoadCallback(drawChart);
  function drawChart() {

    var container = document.getElementById('example3.1');
    var chart = new google.visualization.Timeline(container);
    var dataTable = new google.visualization.DataTable();

    dataTable.addColumn({ type: 'string', id: 'Position' });
    dataTable.addColumn({ type: 'string', id: 'Name' });
    dataTable.addColumn({ type: 'date', id: 'Start' });
    dataTable.addColumn({ type: 'date', id: 'End' });
    dataTable.addRows([
      [ 'CPU', 'Intel Core 2 Duo E6750 2.66GHz', new Date(2007, 7, 25), new Date(2011, 8, 19) ],
      [ 'CPU', 'Intel Pentium E6600', new Date(2011, 8, 19), new Date(2012, 11, 27) ],
      [ 'CPU', 'Intel i5 3570k', new Date(2012, 11, 27), new Date() ],
            
     ]);

    chart.draw(dataTable);
  }
</script>


  </head>
  <body>
    <div id="example3.1" style="height: 200px;"></div>
  </body>
</html>