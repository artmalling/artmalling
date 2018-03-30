/** minder97@naver.com **
 * 
 * 사용방법
 * 1. 사용하고자 하는 HTML에 이 파일을 include한다
 *
 *		<script language="javascript" src="경로/ajax.js"></script>
 *
 *
 * 2. HTML에 div 선언
 *
 *		<div id='test'></id>
 *
 *
 * 3. script내에서 forwardPage() function 호출하기 (매개변수는 필요에 따라 입력한다. 매겨변수 id만 필수)
 *
 *		forwardPage( [div의 id], [서블릿 또는 jsp의 경로], [파라메터값], [액션방법(POST or GET)] )
 * 
 *
 *	예)
 *		forwardPage('test');	
 *			=> 'test'라는 div에 현재 경로의 "test.jsp"파일을 "GET" 방법으로 파라메터없이 포워딩
 *		forwardPage('test','/action.do?cmd=test');	
 *			=> 'test'라는 div에 "/action.do?cmd=test"을 "GET" 방법으로 파라메터없이 포워딩
 *		forwardPage('test','/action.do?cmd=test','param1=val1&param2=val2');
 *			=> 'test'라는 div에 "/action.do?cmd=test"을 "GET" 방법으로 'param1=val1&param2=val2' 파라메터와 같이 포워딩
 *		forwardPage('test','/action.do?cmd=test','param1=val1&param2=val2','POST');
 *			=> 'test'라는 div에 "/action.do?cmd=test"을 "POST" 방법으로 'param1=val1&param2=val2' 파라메터와 같이 포워딩
 *
 *
 */

function forwardPage(id, action, param, method) {
	//default setting..
	if(action==undefined) action = id+".jsp";
	if(param==undefined) param=null;
	if(method==undefined) method="GET";

	//start forwarding..
	//1)
	var xmlhttp = getXmlHttpRequest();
	//2)
	xmlhttp.open(method, action, true);
	//3)
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState == 4){
			if(xmlhttp.status == 200){
				document.getElementById(id).innerHTML = xmlhttp.responseText;
			}else{
				document.getElementById(id).innerHTML = "loading..failed...";
			}
		}
	}
	//4)
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	//5)
	xmlhttp.send(param);
}


function getXmlHttpRequest(){
	var xmlhttp = false;

	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

	return xmlhttp;
}
