---
title: About
layout: splash
classes: wide
permalink: /about/
---

## Computer

<html>
<head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
  google.charts.load("current", {packages:["timeline"]});
  google.charts.setOnLoadCallback(drawChart);
  function drawChart() {

    var container = document.getElementById('timeline');
    var chart = new google.visualization.Timeline(container);
    var dataTable = new google.visualization.DataTable();

    dataTable.addColumn({ type: 'string', id: 'Position' });
    dataTable.addColumn({ type: 'string', id: 'Name' });
    dataTable.addColumn({ type: 'date', id: 'Start' });
    dataTable.addColumn({ type: 'date', id: 'End' });
    dataTable.addRows([
    	[ 'CPU', 'AMD Athlon/Duron Socket 462', new Date(1999, 0, 1), new Date(2004, 6, 8) ],
    	[ 'CPU', 'AMD Athlon 64', new Date(2004, 6, 8), new Date(2007, 7, 25) ],
	    [ 'CPU', 'Intel Core 2 Duo E6750 2.66GHz', new Date(2007, 7, 25), new Date(2011, 8, 19) ],
	    [ 'CPU', 'Intel Pentium E6600', new Date(2011, 8, 19), new Date(2012, 11, 27) ],
	    [ 'CPU', 'Intel i5 3570k', new Date(2012, 11, 27), new Date() ],

	    [ 'Motherboard', 'ASUS A7M-266', new Date(1999, 0, 1), new Date(2004, 6, 8) ],
	    [ 'Motherboard', 'ASUS K8V-SE Deluxe S754', new Date(2004, 6, 8), new Date(2007, 7, 25) ],
	    [ 'Motherboard', 'ASUS P5B Socket 775', new Date(2007, 7, 25), new Date(2010, 7, 24) ],      
	    [ 'Motherboard', 'Asus P5Q SE Plus Socket 775', new Date(2010, 7, 24), new Date(2012, 11, 27) ],  
	    [ 'Motherboard', 'Asus P8Z77-V Motherboard LGA 1150', new Date(2012, 11, 27), new Date() ],       
	      
	    [	'GPU',	'PalitDaytona nVidia Riva TNT2 m64', new Date(1999, 0, 1), new Date(2000, 0, 1) ],
	 	[	'GPU',	'Geforce 2 mx400 64mb', new Date(2000, 0, 1), new Date(2001, 0, 1) ],
	 	[	'GPU',	'Geforce 4 4200Ti 128mb', new Date(2001, 0, 1), new Date(2004, 0, 1) ],
	 	[	'GPU',	'Sapphire 9800 Pro', new Date(2004, 0, 1), new Date(2006, 0, 1) ],     
		[	'GPU',	'BFG 7800 GS OC 256MB', new Date(2006, 0, 1), new Date(2007, 8, 22) ],
		[	'GPU',	'EVGA 8800GTS 320MB', new Date(2007, 8, 22), new Date(2012, 11, 27) ],
		[	'GPU',	'EVGA GTX 670 2GB', new Date(2012, 11, 27), new Date(2014, 6, 14) ],
		[ 	'GPU',	'Asus GeForce GTX 670 DirectCU II OC', new Date(2013,7,13), new Date(2016,7,8) ],
		[	'GPU',	'Asus GeForce GTX 670 DirectCU II OC', new Date(2014, 6, 9), new Date(2016, 7, 8)], 
	    [	'GPU',	'MSI 1080 Armor OC 8GB', new Date(2016, 7, 8), new Date() ],

	    [ 'RAM',	'Extra Value 1GB DDR2', new Date(2007,8,22), new Date(2012,11,27)],
	    [ 'RAM',	'Crucial 4GB DDR2', new Date(2009,4,19), new Date(2012,11,27)],
	    [ 'RAM', 	'Corsair 4GB DDR2', new Date(2011,11,22), new Date(2012,11,27)],
	    [ 'RAM',	'Corsair Vengeance 8GB DDR3', new Date(2017, 3, 14), new Date()],
	    [ 'RAM',	'Corsair Vengeance 8GB DDR3', new Date(2012, 11, 27), new Date()],
	      
	    [ 'Soundcard', 'M-Audio Audiophile 2496', new Date(2011, 3, 3), new Date(2014,6,22)],
	    [ 'Soundcard', 'Asus Xonar Essence STX', new Date(2014, 6, 22), new Date()],


	      //[	'Monitor',	'Dell 1907 fpt', new Date(2007,5,30), new Date(2015,8,9)],      
	    [	'Monitor',	'Dell Ultrasharp 2407WFP 24', new Date(2007,5,30), new Date(2015,8,9)],
	    [	'Monitor',	'Samsung 34 Curved Ultrawide S34E790C', new Date(2015,8,9), new Date()],  


	    [	'Mouse',	'Logitech Cordless Trackman Wheel', new Date(2004, 11, 11), new Date(2006,11,11)],
	    [	'Mouse',	'Logitech G7', new Date(2006, 11, 11), new Date(2008,5,9)],
	    [	'Mouse',	'Logitech MX Revolution', new Date(2008, 5, 9), new Date(2012,4,15)],
	    [	'Mouse',	'Logitech MX Performance', new Date(2012, 4, 15), new Date(2014,4,21)],
	    [	'Mouse',	'Logitech MX Performance', new Date(2014, 4, 21), new Date(2016,4,9)],
	    [	'Mouse',	'Logitech MX Master', new Date(2016, 4, 9), new Date()],

		[	'Keyboard',	'Logitech Wave', new Date(2009, 4, 21), new Date(2016,2,30)],
		[	'Keyboard',	'Corsair K70 Cherry MX Blue', new Date(2016, 2, 30), new Date()],


    ]);

    chart.draw(dataTable);
  }
</script>
</head>
<body>
<div id="timeline" style="height: 500px;"></div>
</body>
</html>

## Phones

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

		[	'Phone',	'Sony Ericsson k700i', new Date(2004,10,14), new Date(2006,4,14)],
		[	'Phone',	'Sony Ericsson k750i', new Date(2006,4,14), new Date(2007,10,14)],
		[	'Phone',	'Sony Ericsson V640i', new Date(2007,10,14), new Date(2009,4,14)],
		[	'Phone',	'Nokia 5800 Music Xpress', new Date(2009,4,14), new Date(2010,7,23)],
		[	'Phone',	'Samsung Galaxy SI', new Date(2010,7,23), new Date(2012,1,16)],
		[	'Phone',	'Samsung Galaxy SII', new Date(2012,1,16), new Date(2013,9,31)],
		[	'Phone',	'Nexus 5', new Date(2013,9,31), new Date(2016,4,30)],
		[	'Phone',	'HTC 10', new Date(2016,4,30), new Date(2018,0,30)],
	    [	'Phone',	'Sony Xperia XZ1 Compact', new Date(2018,0,30), new Date()],

	    [	'Headphones',	'Sony MDR EX90LP',	new Date(2008, 3, 18), new Date(2009, 2, 3)]
	    [	'Headphones',	'Sony MDR EX90LP',	new Date(2009, 2, 3), new Date(2009, 2, 10)]
	    [	'Headphones',	'Sony MDR-EX500LP', new Date(2009, 2, 10), new Date(2011, 9,1)]
	    [	'Headphones',	'Sony MDR EX510LPB', new Date(2011, 9,1), new Date()],
	    [	'Headphones',	'Philips X1', new Date(2012, 9,30), new Date(2013,3,29)],
	    [	'Headphones',	'Philips X1', new Date(2012, 9,30), new Date()],
	    [	'Headphones',	'AGK K550', new Date(2013, 8,1), new Date()],

     ]);

    chart.draw(dataTable);
  }
</script>


  </head>
  <body>
    <div id="Computer Timeline" style="height: 1000px;"></div>
  </body>
</html>
