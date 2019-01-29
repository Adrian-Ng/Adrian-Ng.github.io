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
      [ 'Motherboard', 'ASUS A7M-266', new Date(1999, 0, 1), new Date(2007, 7, 25) ],
      [ 'Motherboard', 'ASUS P5B Socket 775', new Date(2007, 7, 25), new Date(2010, 7, 24) ],      
      [ 'Motherboard', 'Asus P5Q SE Plus Socket 775', new Date(2010, 7, 24), new Date(2012, 11, 27) ],  
      [ 'Motherboard', 'Asus P8Z77-V Motherboard LGA 1150', new Date(2012, 11, 27), new Date() ], 
      [	'GPU',	'MSI 1080 Armor OC 8GB', new Date(2016, 7, 8), Date() ],
      [	'GPU',	'EVGA GTX 670 2GB', new Date(2012, 11, 27), new Date(2016, 7, 8) ],
      [	'GPU',	'EVGA 8800GTS 320MB', new Date(2007, 8, 22), new Date(2012, 11, 27) ],
      [	'GPU',	'BFG  7800 GS OC 256MB', new Date(2006, 0, 1), new Date(2007, 8, 22) ],
      [	'GPU',	'Sapphire 9800 Pro', new Date(2004, 0, 1), new Date(20076 0, 1) ],
      [	'GPU',	'Geforce 4 440mx', new Date(2001, 0, 1), new Date(2004, 0, 1) ],
      [	'GPU',	'PalitDaytona nVidia Riva TNT2 m64', new Date(1999, 0, 1), new Date(2001, 0, 1) ],
      [	'GPU',	'EVGA GTX 670 2GB', new Date(2014, 6, 9), new Date(2016, 7, 8)], 
     ]);

    chart.draw(dataTable);
  }
</script>


  </head>
  <body>
    <div id="example3.1" style="height: 200px;"></div>
  </body>
</html>