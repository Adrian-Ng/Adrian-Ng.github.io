---
title: Phone
layout: single
permalink: /phone/
classes: wide
---

<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
  google.charts.load("current", {packages:["timeline"]});
  google.charts.setOnLoadCallback(drawChart);
  function drawChart() {

    var container = document.getElementById('Computer Timeline');
    var chart = new google.visualization.Timeline(container);
    var dataTable = new google.visualization.DataTable();

    dataTable.addColumn({ type: 'string', id: 'Position' });
    dataTable.addColumn({ type: 'string', id: 'Name' });
    dataTable.addColumn({ type: 'date', id: 'Start' });
    dataTable.addColumn({ type: 'date', id: 'End' });
    dataTable.addRows([

		[	'Phone',	'Samsung Galaxy SI', new Date(2010,7,23), new Date(2012,1,16)],
		[	'Phone',	'Samsung Galaxy SII', new Date(2012,1,16), new Date(2013,9,31)],
		[	'Phone',	'Nexus 5', new Date(2013,9,31), new Date(2016,4,30)],
		[	'Phone',	'HTC 10', new Date(2016,4,30), new Date(2018,0,30)],
	    [	'Phone',	'Sony Xperia XZ1 Compact', new Date(2018,0,30), new Date()],

     ]);

    chart.draw(dataTable);
  }
</script>


  </head>
  <body>
    <div id="Computer Timeline" style="height: 2000px;"></div>
  </body>
</html>