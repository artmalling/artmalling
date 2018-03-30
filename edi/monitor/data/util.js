/** util.js : Created on 2008. 7. 29.
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

var httpRequest = null;

function sendRequest(url, params, callback, method) {
	
	httpRequest = getXMLHttpRequest();
	//response.setHeader("Content-Type", "text/xml");
	var httpMethod = method ? method : 'GET';
	if(httpMethod != 'GET' && httpMethod != 'POST') {
		httpMethod = 'GET';
	}
	var httpParams = (params == null || params == '') ? null :  params;
	var httpUrl	= url;
	if(httpParams != null) {
		httpUrl = httpUrl + "?" + httpParams;
	}
	
	try {
		httpRequest.open(httpMethod, httpUrl, true);
		//alert(httpUrl);
		httpRequest.setRequestHeader(
				'content-Type', 'application/x-www-form-urlencoded');
		httpRequest.onreadystatechange = callback;
		httpRequest.send(httpMethod == 'POST' ? httpParams : null);
		
	} catch (e) {
		alert(e.toString());
		response.getWriter().write("message");
	}
}

function getXMLHttpRequest() {
	if(window.ActiveXObject) {
		try{
			return new ActiveXObject("Microsoft.XMLHTTP");
		} catch(e) {
			try {
				return new ActivrXObject("Microsoft.XMLHTTP");
			} catch(e1) {
				return null;
			}
		}
		
	} else if(window.XMLHttpRequest) {
		return new XMLHttpRequest();
	} else {
		return null;
	}
}

//날짜 정보
function printTime() {
	
	var clock	= document.getElementById("clock");
	
	var now			= new Date();
	var hours		= now.getHours();
	var minutes = now.getMinutes();
	var seconds = now.getSeconds();
	
	var time_str = now.getFullYear() + "년 " + 
			(now.getMonth() + 1) + "월 " +
			now.getDate() + "일 ";
	
	time_str += ((hours > 12) ? hours - 12 : hours);
	time_str += ((minutes < 10) ? ":0" : ":") + minutes;
	time_str += ((seconds < 10) ? ":0" : ":") + seconds;
	time_str += (hours >= 12) ? " P.M" : " A.M";
		
	clock.innerHTML = time_str;
}	

function codeLoworCase(temp) {
	var str="";
	
	for(var i=0;i<temp.length;i++){
		
 		if(temp.charCodeAt(i)<90&&temp.charCodeAt(i)>65){ //대문자는
 			str += temp.charAt(i).toLowerCase(); //소문자로 			
 		} else {
 			str += temp.charAt(i);
 		}
	}
	return str;
}

function codeUpperCase(temp) {
	var str="";
	for(var i=0;i<temp.length;i++){
		if(temp.charCodeAt(i)>=90 || temp.charCodeAt(i)<=65) {	//소문자는 
			str += temp.charAt(i).toUpperCase(); //대문자로
		} else {
 			str += temp.charAt(i);
 		}
	}
	return str;
}

// " -> ' 로 변환
function codeChangeCase(temp) {
	var str="";
	
	for(var i=0;i<temp.length;i++){
		if(temp.charAt(i) == "\"") {
			str += "'";
			//alert("원본 [" + temp.charAt(i) + "] 바꿔서..[" + str + "]") ;
		} else  {
			str += temp.charAt(i);
		}
	}	
	return str;
}