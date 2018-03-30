<!-- monitor.jsp : Created on 2008. 7. 29.
 * 
 *   Copyright (c) 2000-2008 Shift Information & Communication Co.
 *   5F, Seongsu Venture town, 231-1, Seongsu2-Ga Seongdong-Gu, Seoul, Korea 133-826
 *   All rights reserved.
 *
 *   This software is the confidential and proprietary information of
 *   Shift Information & Communication Co. ("Confidential Information").
 *   You shall not disclose such Confidential Information and shall use 
 *   it only in accordance with the terms of the license agreement you 
 *   entered into with Shift Information & Communication.
-->

<!--
 *   GAUCE-Server의 모니터링 화면을 제어한다.
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.util.*"%>
<%@ include file="inc/session_check.jsp" %>
<%@ include file="inc/config_read.jsp" %>

<script type="text/javascript" src="data/script.js"></script>
<script type="text/javascript" src="data/util.js"></script>
<script language="JavaScript" src="FusionChartsFree/JSClass/FusionCharts.js"></script>
<script language="JavaScript"> 

	var reloadTime	= <%=session.getAttribute("reloadTime")%>;	
	var chartSize		= <%=session.getAttribute("chartSize")%>;
	var overTime		= <%=session.getAttribute("overTime")%>;
	var log_path		= "<%=session.getAttribute("logPath")%>";
	//var home_path		= "<%=session.getAttribute("homePath")%>";
	var timer;
	
	var filterErrMsg = "";
	var isFilterCondition = true;
	var isStart = false;
	var chartDataSet = "";
	
	// Servlet(FilterDataLoader) 호출을 위한 Parameter 생성 및 Send
	function filterDataLoader(temp) {
	
		var param = "filePath=" + log_path + "&size=" + chartSize
								+ "&time=" + reloadTime + "&over=" + overTime;
		if(temp == "start") {
			param += "&close=false";
		} else {
			param += "&close=true";
		}
		sendRequest("FilterDataLoader", param, servletResult, "POST");
	}
	
	
	// Servlet(FilterDataLoader)으로 부터 받은 result 처리
	function servletResult() {
		if(httpRequest.readyState == 4) {
		
			if(httpRequest.status == 200) {
					
					var pageTable		= "";
					//alert(httpRequest.responseText);
					var xmlDoc		= httpRequest.responseXML;
					var datasNode	= xmlDoc.getElementsByTagName("datas");	//<datas>
					var datasType = datasNode[0].getAttribute("type");
					var datasFile = datasNode[0].getAttribute("file");
					//차트를 그리기 위해 innerHTML 설정 할 수 없음.
					//if(datasFile == "false") divServiceChart.innerHTML = "<br>" + CHART_CHECK;
					
					var dataNode	= datasNode[0].getElementsByTagName("filter");	//<filter>
					var vError		= dataNode[0].getElementsByTagName("error")[0].firstChild.nodeValue;
					filterErrMsg	= dataNode[0].getElementsByTagName("message")[0].firstChild.nodeValue;
					
					if(datasType == "start") {
						dataNode				= datasNode[0].getElementsByTagName("graph"); //<chart>
						updateChartXML('ChartId', codeChangeCase(dataNode[0].xml));
						
						dataNode				= datasNode[0].getElementsByTagName("service"); //<chart>
						var cPageCount	= dataNode[0].getAttribute("count");
						var cPageUrl = "";
						var cPageTime = "";
						if(cPageCount > 0) { 
							pageTable = "";
							for(var i = 0; i < cPageCount; i++) {
								cPageUrl		= dataNode[0].getElementsByTagName("pageUrl")[i].firstChild.nodeValue;
								cPageTime		= dataNode[0].getElementsByTagName("pageTime")[i].firstChild.nodeValue;
								pageTable		+= "<tr> <td> " + cPageUrl + " </td>"
								pageTable		+= "<td> <center>" + cPageTime + "초 </center></td> </tr>"
							}
						}
						dataNode				= datasNode[0].getElementsByTagName("data"); //<data>
						var cTopTime		= dataNode[0].getElementsByTagName("topTime")[0].firstChild.nodeValue;
						var cMeanTime		= dataNode[0].getElementsByTagName("meamTime")[0].firstChild.nodeValue;
						var cLogCount		= dataNode[0].getElementsByTagName("logCount")[0].firstChild.nodeValue;
						var cErrCount		= dataNode[0].getElementsByTagName("errCount")[0].firstChild.nodeValue;
						
					} 
					
					divTopTime.innerHTML = cTopTime;
					divMeanTime.innerHTML = cMeanTime;
					divLogCount.innerHTML = cLogCount;
					divErrCount .innerHTML = cErrCount;
					
					divServiceList.innerHTML	= "<table> <tr>"
							+ "		<td width='300'> <center> Service URL </center> </td>"
							+ "		<td width='60'> <center> 처리시간 </center> </td>"
							+ "	</tr>" 
							+ pageTable
							+ "</table>";						
																			
					if(vError != "success"){
						divFilterCheck.innerHTML = FILTER_ERROR
									+ "&nbsp; &nbsp; &nbsp;"
									+ "<input type='button' value='오류 확인' onclick=filterErrorViewBox();>"
									+ "</input>";
						stopTimer();
						//timer stop
					} else {
						if(isStart == false) {
							divFilterCheck.innerHTML = FILTER_START;
							stopTimer();
						} else {
							divFilterCheck.innerHTML = FILTER_OK;
						}
					}
											
			}else { //FilterDataLoader Servlet 호출 결과 비정상.
				alert(httpRequest.responseText);
				//timer stop
				stopTimer();
				var xmlErr = httpRequest.responseXML;
				var errMsg = CONF_CHECK + "<br/>" + httpRequest.responseText;
				divServiceChart.innerHTML = errMsg;	//@@@
				divFilterCheck.innerHTML = FILTER_CHECK;
				
			} // status Check end
		} // readyState Check end
	} // servletResult Function end
	
	//멀티 차트 생성
	function SetMultiChartType(type) {
		chart = new FusionCharts(type, "ChartId", "1000", "300");
		chart.setDataXML(getXMLData());
		chart.render("divServiceChart");
	}
	
	// 데이터셋 데이터 업데이트
	function UpdateDataSet(data) {
		chartDataSet = codeChangeCase(data);
		return chartDataSet
	}
	
	function getXMLData() {
		var xmlData = "<graph caption='' PYAxisName='Service Count' SYAxisName='Servicing Time' numberPrefix='' showvalues='0' numDivLines='4' formatNumberScale='0' decimalPrecision='0' anchorSides='5' anchorRadius='3' rotateNames='1' anchorBorderColor='009900' animation='0'>"
                + " <categories>"
                + "  <category name='00:00:00'/>"
                + " </categories>"
                + " <dataset seriesName='Servicing Time Mean' color='F6BD0F' showValues='0' parentYAxis='S'>"
                + "  <set value='0'/>"
                + " </dataset>"
                + " <dataset seriesName='ServiceCount' color='AFD8F8' showValues='0'>"
                + "  <set value='0'/>"
                + " </dataset>"
                + " <dataset seriesName='Error Service Count' color='D64646' showValues='0'>"
                + "  <set value='0'/>"
                + " </dataset>"
                + "</graph>";
		return xmlData;
	}
		
	// 에러 메시지를 보여주기 위한 메시지 박스 생성
	function filterErrorViewBox() {
	
		alert(filterErrMsg);
	}

	function dataLoadTimer() {
		
		filterDataLoader('start')
		var time = reloadTime * 1000;
		if(time < 0) time = 5000;
		timer = setTimeout("dataLoadTimer()", time);
	}
	
	// 모니터링 start
	function startButton() {
		SetMultiChartType('FusionChartsFree/Charts/FCF_MSColumn2DLineDY.swf');
		isStart = true;
		printTime();
		dataLoadTimer();
		divMonitorControl.innerHTML = MONITOR_STOP;
	}
	
	// 모니터링 stop
	function stopButton() {
	
		stopTimer();
		filterDataLoader("end");
	}
	
	// 타이머 stop
	function stopTimer() {
	
		isStart = false;
		clearTimeout(timer);
		divMonitorControl.innerHTML = MONITOR_START;
	}
	
	window.onunload = function() {	
		filterDataLoader("end");
	}
</script> 

<html>
<head>
	<meta http-equiv=Content-Type content="text/html; charset=euc-kr">
	<title>GAUCE Administration</title>
	<link rel="Stylesheet" href="data/style.css">
	<style>
	</style>
	<script type="text/javascript">
	<!--
		function OnLoad_window() {
			InitTooltip();
			divMonitorControl.innerHTML = MONITOR_START;
			divFilterCheck.innerHTML = FILTER_START;
			
		}
		
		function Onunload_window() {
			alert("end");
		}
	//-->
	</script>
</head>
<body onload="OnLoad_window();">
<div id="pageTitle">서버 모니터링</div>
<div class="description">
	* 서버 Servlet filter를 실시간으로 모니터링합니다.	[시작] 버튼을 눌러 모니터링을 시작합니다.<br>
	 (<font color='red'>주의!</font> 모니터링 하는 모든 데이터는 시작 시점부터 수집됩니다) <br>
	* 로그 파일 경로 : <script> document.write(log_path);</script> <br>
	<!--* Monitoring View에 관한 자세한 안내사항을 <a href='manual_monitor.html' target='blank'> 메뉴얼</a>에서 확인하실 수 있습니다. <br>-->
</div>

<div id='divMonitorControl'>
<!--a href="config_monitor.html">서버 모니터링 설정(옵션)</a-->
</div>

<div>
<fieldset>
	<legend><span style="font-weight:bold;">Summary</span> (<span id="clock"> </span> ~ 현재)</legend>
	<table>
		<tr>
			<td width='400'> 
				<table> 
					<tr>
						<td width='100' >총 요청 건수<span class='help'>(?)
								<span class='helptext'>모니터링 시작 이후 GAUCE-Filter에서 처리된 총 서비스 수 입니다.<br></span>
							</span> :</td>
						<td width='100'> <div id='divLogCount'></div> </td>
						<td> 평균 처리 시간 <span class='help'>(?)
						<span class='helptext'>서비스 처리에 소요된 평균 시간입니다.<br>(서버 소요 시간)</span></span> :</td>
						<td> <div id='divMeanTime'></div> </td>
					</tr>
					<tr>
						<td  width='100'>오류 건수 <span class='help'>(?)<span class='helptext'>서비스 처리 중 오류가 난 서비스의 수 입니다.</span></span> :</td>
						<td  width='100'> <div id='divErrCount'></div> </td>
						<td> 최대 처리 시간 <span class='help'>(?)<span class='helptext'>서비스 처리가 가장 오래 걸린 시간입니다.</span></span> :</td>
						<td> <div id='divTopTime'></div> </td>
					</tr> 
				</table>
			</td>
			<td> 
				<div id='divFilterCheck'>
				</div>
			</td>
		</tr>
	</table>
</fieldset>
</div>

<div>
<fieldset>
	<legend><span style="font-weight:bold;">Service Chart </span>(<script> document.write(chartSize);</script>개의 데이터가 표시됩니다.)</legend>
		<div id='divServiceChart' style="border:1px solid #E7E7E7; background-color:#F4F4F4; width:100%; height:300px;">
		</div>
</fieldset>
</div>

<fieldset>
	<legend><span style="font-weight:bold;">Service List </span>(<script> document.write(overTime);</script>초를 기준으로 표시됩니다.)</legend>
<div>
	<div id='divServiceList' style="border:1px solid #E7E7E7; background-color:#F4F4F4; width:100%; height:180px;"></div>
</div>
</fieldset>
</body>
</html>