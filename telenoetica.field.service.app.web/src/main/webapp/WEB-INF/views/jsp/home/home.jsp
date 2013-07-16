<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page session="false"%>
<html>
<head>
<spring:url value="/resources/css/jquery.jqplot.min.css" var="resourceJqplotCssUrl"/>

<spring:url value="/resources/js/jqplot.pieRenderer.min.js" var="piRendererUrl"/>
<spring:url value="/resources/js/jqplot.meterGaugeRenderer.min.js" var="meterGaugeRendererUrl"/>
<spring:url value="/resources/js/jqplot.barRenderer.min.js" var="barRendererUrl"/>
<spring:url value="/resources/js/jqplot.categoryAxisRenderer.min.js" var="categoryAxisRendererUrl"/>
<spring:url value="/resources/js/jqplot.pointLabels.min.js" var="pointLabelsUrl"/>
<spring:url value="/resources/js/jquery.jqplot.min.js" var="jqplotUrl"/>

<link href="${resourceJqplotCssUrl}" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${jqplotUrl}"></script>
<script type="text/javascript" src="${meterGaugeRendererUrl}"></script>
<script type="text/javascript" src="${barRendererUrl}"></script>
<script type="text/javascript" src="${categoryAxisRendererUrl}"></script>
<script type="text/javascript" src="${pointLabelsUrl}"></script>

<script type="text/javascript" src="${piRendererUrl}"></script>


<script type="text/javascript">

	$().ready(function() {

		var jsonurl = webContextPath + "/rest/webHomeData";
		var homePageData = populateDataForHomeScreen(jsonurl);
		populateRoutineTableData(homePageData.routineVisits);
		populateCalloutTableData(homePageData.callOutVisits);
		populateDieselTableData(homePageData.dieselVisits);
		populateMaintenanceTableData(homePageData.maintenanceVisits);
		drawGraph(homePageData.chartData);
		drawGraph1();
		drawGraph2();
	});

	function populateDataForHomeScreen(url) {
		var ret = null;
		$.ajax({
			// have to use synchronous here, else the function 
			// will return before the data is fetched
			async : false,
			url : url,
			success : function(data) {
				ret = data;
			}
		});
		return ret;
	}

	function populateRoutineTableData(input) {
		$.each(input, function(i, row) {
			$('[name="routineTable"]').append(
					"<tr><td>" + row.siteId + "</td><td>" + row.createdAt
							+ "</td></tr>");
		});
	}
	function populateCalloutTableData(input) {
		$.each(input, function(i, row) {
			$('[name="calloutTable"]').append(
					"<tr><td>" + row.siteId + "</td><td>" + row.createdAt
							+ "</td></tr>");
		});
	}
	function populateDieselTableData(input) {
		$.each(input, function(i, row) {
			$('[name="dieselTable"]').append(
					"<tr><td>" + row.siteId + "</td><td>" + row.createdAt
							+ "</td></tr>");
		});
	}

	function populateMaintenanceTableData(input) {

		$.each(input, function(i, row) {
			$('[name="maintenanceTable"]').append(
					"<tr><td>" + row.siteId + "</td><td>" + row.createdAt
							+ "</td></tr>");
		});

	}
	function drawGraph(input) {
		$.jqplot.config.enablePlugins = true;
		var ticks = [ 'Routine Visit', 'Callout Visit', 'Diesel Visit',
				'Maintenance Visit' ];
		plot1 = $.jqplot('chartdiv', [ input ], {
			// Only animate if we're not using excanvas (not in IE 7 or IE 8)..
			title : "Visit Analysis Chart(Last 30 Days)",
			seriesDefaults : {
				renderer : $.jqplot.BarRenderer,
				pointLabels : {
					show : true
				}
			},
			axes : {
				xaxis : {
					renderer : $.jqplot.CategoryAxisRenderer,
					ticks : ticks
				}
			},
			seriesColors : [ "#04acec" ],
			highlighter : {
				show : false
			}
		});

	}
	function drawGraph1() {
		$.jqplot('pie1', [[['KickStarter',25],['AirFilter',14],['Tophose',7]]], {
	        gridPadding: {top:0, bottom:38, left:0, right:0},
	        label : "Top 3 parts(Used in last 30 Days)",
	        seriesDefaults:{
	            renderer:$.jqplot.PieRenderer, 
	            trendline:{ show:false }, 
	            rendererOptions: { padding: 8, showDataLabels: true }
	        },
	        legend:{
	            show:true, 
	            placement: 'outside', 
	            rendererOptions: {
	                numberRows: 1
	            }, 
	            location:'s',
	            marginTop: '15px'
	        }       
	    });
	}	
	function drawGraph2(){
		
		 var s1 = [52200];
		   $.jqplot('chart4',[s1],{
		       seriesDefaults: {
		           renderer: $.jqplot.MeterGaugeRenderer,
		           rendererOptions: {
		               label: 'Diesel Recieved',
		               labelPosition: 'bottom',
		               labelHeightAdjust: -5,
		               intervalOuterRadius: 85,
		               ticks: [10000, 30000, 50000, 70000],
		               intervals:[22000, 55000, 70000],
		               intervalColors:['#66cc66', '#E7E658', '#cc6666']
		           }
		       }
		   });
	}
</script>
</head>
<body>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	<div style="height: 1000px;">
	<div id="chartdiv" style="height:200px;width:600px; margin-left:10px;">
	<div id="pie1" style="margin-top:20px; margin-left:650px; width:200px; height:200px;"></div>
	</div>
	<div id="chart4" style="width:500px;height:300px;"></div>
	<br>
		<div class="col_w420 lp_box float_l">
			<h5>Routine Visit</h5>
			<table id="newspaper-b" name="routineTable">
				<thead>
					<tr>
						<th scope="col">Site</th>
						<th scope="col">Visit Time</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
			<a href="${contextPath}/routine/list" style="float:right; font-weight: bold">View All</a>
		</div>
		<div class="col_w420 float_r">
			<h5>Callout Visit</h5>
			<table id="newspaper-b" name="calloutTable" style="float: right">
				<thead>
					<tr>
						<th scope="col">Site</th>
						<th scope="col">Visit Time</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<a href="${contextPath}/callout/list" style="float:right; font-weight: bold">View All</a>
		</div>
		<br/>
		<div class="col_w420 lp_box float_l">
			<h5>Diesel Visit</h5>
			<table id="newspaper-b" name="dieselTable">
				<thead>
					<tr>
						<th scope="col">Site</th>
						<th scope="col">Visit Time</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
			<a href="${contextPath}/diesel/list" style="float:right; font-weight: bold">View All</a>
		</div>
		<div class="col_w420 float_r">
			<h5>Maintenance Visit</h5>
			<table id="newspaper-b" name="maintenanceTable" style="float: right">
				<thead>
					<tr>
						<th scope="col">Site</th>
						<th scope="col">Visit Time</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<a href="${contextPath}/maintenance/list" style="float:right; font-weight: bold">View All</a>
		</div>
	</div>
</body>
</html>
