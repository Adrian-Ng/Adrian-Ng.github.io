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
      [ 'President', 'George Washington', new Date(1789, 3, 30), new Date(1797, 2, 4) ],
      [ 'President', 'John Adams', new Date(1797, 2, 4), new Date(1801, 2, 4) ],
      [ 'President', 'Thomas Jefferson', new Date(1801, 2, 4), new Date(1809, 2, 4) ],
      [ 'Vice President', 'John Adams', new Date(1789, 3, 21), new Date(1797, 2, 4)],
      [ 'Vice President', 'Thomas Jefferson', new Date(1797, 2, 4), new Date(1801, 2, 4)],
      [ 'Vice President', 'Aaron Burr', new Date(1801, 2, 4), new Date(1805, 2, 4)],
      [ 'Vice President', 'George Clinton', new Date(1805, 2, 4), new Date(1812, 3, 20)],
    ]);

    chart.draw(dataTable);
  }
</script>


  </head>
  <body>
    <div id="example3.1" style="height: 200px;"></div>
  </body>
</html>