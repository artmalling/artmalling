<!-- config_innoxync_add.jsp : Created on 2008. 7. 29.
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
 *   GAUCE Server의 환경 설정 파일을 추가 하는 페이지 이다.
 *   사용자 정의 혹은 디폴트 파일을 추가할 수 있다.
-->

<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<%@ include file="inc/session_check.jsp" %>
<%@ include file="inc/config_read.jsp" %>
<html>
<head>
	<meta http-equiv=Content-Type content="text/html; charset=euc-kr">
	<title>GAUCE Administration</title>
	<link rel="Stylesheet" href="data/style.css">
	<style>
		fieldset {
			padding-top : 5px;
		}
	</style>
	<script type="text/javascript" src="data/script.js"></script>
	<script type="text/javascript" src="data/util.js"></script>
	<script type="text/javascript" src="data/config_ui.js"></script>
	<script type="text/javascript">
	<!--
		function OnLoad_window() {
			InitTooltip();
			galobal_table();
			type_Check();
			
		}
	//-->
	var homePath = "<%=session.getAttribute("homePath")%>";
	var homeMode = "<%=session.getAttribute("homeMode")%>";
	
	
	// 사용자 정의 or default 인지 확인
	function type_Check() {
	
		var domain_types = document.getElementsByName('domain_type');
		var domain_in = "";
		if(domain_types[1].checked) {
			domain_in = "<input type='text' name='domain' value='default' size='10' disabled='true'> </input>";
			default_table();
		}
		else {
			domain_in = "<input type='text' name='domain' size='10'> </input>";
			default_commend.innerHTML = "";
		}
		domain_input.innerHTML = domain_in;
		
		
	}
	
	// 해당 도메인 이름의 환경설정 파일이 존재 하는지 체크
	function domain_Check() {
	
	}
	
	//내용 저장
	function config_Add() {
		document.config.domain_name.value = document.getElementById('domain').value;
		window.document.config.submit();
	}
			
	</script>
</head>
<body onload="OnLoad_window();">
<div id="pageTitle">
	&nbsp;&nbsp;<a href='config_gauce_modify.jsp'> >서버 환경설정 파일 수정</a>
	&nbsp;&nbsp;<a href='config_gauce_add.jsp'> >서버 환경설정 파일 추가</a>
</div>
<div class="description">
	<table> 
		<tr> 
			<td colspan='3'>
				현재 web.xml 에는 <script>document.write(homeMode)</script>-filter가 등록되어 있습니다.</br>
				GAUCE 서버의 환경 정보를 추가합니다. &nbsp;&nbsp;
				<input type='radio' name='domain_type' value='etc' checked='checked' onclick='type_Check();'>사용자정의 <span class='help'>(?)
								<span class='helptext'>사용자 정의 환경 설정이 가능합니다.<br>
									데이터 압축 여부/ First Row 갯수/ 인코딩/ 데이터셋 컬럼 설정값/ 암호화 모듈을 설정할 수 있습니다.<br></span>
							</span> 
				</input> &nbsp;
				<input type='radio' name='domain_type' value='default' onclick='type_Check();'>default <span class='help'>(?)
								<span class='helptext'>GAUCE 서버가 동작하는데 필요한 기본적인 환경을 설정합니다.<br></span>
							</span> 
				</input> &nbsp;
			</td>
		</tr>
		<tr> 
			<td>환경파일 - <script>document.write(homePath)</script>/<script>document.write(homeMode)</script>_conf/<script>document.write(homeMode)</script>-
			</td>
			<td>
				<div id='domain_input'></div>				
			</td>
			<td>.xml  &nbsp;&nbsp;</td>
		</tr>
		<tr> 
			<td align='center'>
			</td>
		</tr>
	</table>
</div>

<div>
<fieldset>
	<form name="config" action="inc/gauce_config_add.jsp" method="post" onsubmit="return config_Add()" style="margin:0px; margin-top:10px;">
	<input type='hidden' name='domain_name'></input>
	<table border='0'>
		<tr>
			<td colspan='2' align='center'><b>global</b><td>
		</tr>
		<tr> <td colspan='2'>
			<div id='dlobal_commend'> 
			</div>
		</td> </tr>
		<tr> 
			<td colspan='2'>
			<div id='default_commend'>
			</div>
			</td>
		</tr>
		<tr>
			<td colspan='2' align='center'><input type="button" value="저 장" onclick=config_Add();></td>
		</tr>
	</table>
	</form>
</fieldset>
</div>

</body>
</html>