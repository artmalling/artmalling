/** script.js : Created on 2008. 7. 29.
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
 */

var MONITOR_START	= "<button onclick=startButton();><font color='#034d98'>����͸� ���� ��</font></button>"
									+ "<button onclick=stopButton();><font color='#CC0000'>����͸� ���� ��</font></button>"									
									;
										
var MONITOR_STOP	= "<button disabled='true'><font color='#034d98'>����͸� ���� ��</font></button>"
									+ "<button onclick=stopButton();><font color='#CC0000'>����͸� ���� ��</font></button>"									
									;
									
var FILTER_START	= "&nbsp;[InnoXync-Server]<br/> <H3>üũ�� �������ּ���.</H3>"
var FILTER_OK			= "&nbsp;[InnoXync-Server]<br/> <H3>���Ͱ� ���������� �����ϰ� �ֽ��ϴ�.</H3>"
var FILTER_CHECK	= "&nbsp;[InnoXync-Server]<br/> <H3>���� üũ�� ���������� ������ �� �����ϴ�.</H3>";
var FILTER_ERROR	= "&nbsp;[InnoXync-Server]<br/> <H3>������ ���¸� Ȯ���� �ּ���.</H3>"

var CHART_CHECK		= "&nbsp;* ��Ʈ ������ ���� �α� ������ �������� �ʾҽ��ϴ�.";
var CONF_CHECK		= "InnoXync-Filter�� ��Ʈ ������ Ȯ���� �ּ���.";

function getElementsByClassName(clsName,parentNode) {
	var arr = new Array();
	if (parentNode == null) {
		var elems = document.getElementsByTagName("*");
	} else {
		var elems = parentNode.getElementsByTagName("*");
	}
	for ( var cls,i=0; (elem=elems[i]); i++ ) {
		if ( elem.className == clsName ) {
			arr[arr.length] = elem;
		}
	}
	return arr;
}

// ���� ����
function InitTooltip() {
	var tooltipObjects = getElementsByClassName("help");
	var max = tooltipObjects.length;
	
	for(var i=0; i<max; i++) {
		tooltipObjects[i].onmouseover = ShowTooltip;
		tooltipObjects[i].onmouseout = HideTooltip;
	}
	
	document.body.insertAdjacentHTML("beforeEnd", '<div id="tooltip_div" style="display:none; position:absolute; "><div id="tooltip_div_left" class="tooltip_div_left"></div><div id="tooltip_div_content" class="tooltip_div_content"></div></div>');
}
function ShowTooltip() {
	//alert();
	var obj = event.srcElement;
	var helpObj = getElementsByClassName("helptext", obj)[0];
	
	if( helpObj && helpObj.innerHTML != "") {
		var tooltipObj = document.getElementById("tooltip_div");

		helpText = helpObj.innerHTML;
		document.getElementById("tooltip_div_content").innerHTML = helpText;
		
		var offsetParentObj, tmpObj;
		var leftPos = obj.offsetLeft + obj.offsetWidth;
		tmpObj = obj;
		while( (offsetParentObj = tmpObj.offsetParent) != null ) {
			if( offsetParentObj.tagName != 'HTML' ) leftPos += offsetParentObj.offsetLeft;
			tmpObj = offsetParentObj;
		}
		
		var topPos = obj.offsetTop;
		tmpObj = obj;
		while( (offsetParentObj = tmpObj.offsetParent) != null ) {
			if( offsetParentObj.tagName != 'HTML' ) topPos += offsetParentObj.offsetTop;
			tmpObj = offsetParentObj;
		}
		
		tooltipObj.style.left = leftPos + 'px';
		tooltipObj.style.top = topPos + 'px';
		tooltipObj.style.display = "";
	}
}
function HideTooltip() {
	//var obj = event.srcElement;
	var tooltipObj = document.getElementById("tooltip_div");
	tooltipObj.style.display = "none";
}