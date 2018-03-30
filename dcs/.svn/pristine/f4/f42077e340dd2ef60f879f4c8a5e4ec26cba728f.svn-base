<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 회원관리 > 회원가입신청서이미지조회
 * 작 성 일 : 2010.04.04
 * 작 성 자 : 장형욱
 * 수 정 자 : 
 * 파 일 명 : dctm1140.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.04.04 (장형욱) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.ObjectInputStream" %>
<%@ page import="java.io.*" %>
<!--************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	request.setCharacterEncoding("utf-8"); 

	String dir = BaseProperty.get("context.common.dir");
	
	System.out.println(dir);
	String strSsno = "EM_SS_NO_S";
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-04-04
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>'); 
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_SS_NO_H,     "000000",     		  NORMAL);     //생년월일_hidden
    initEmEdit(EM_SS_NO_S,     "000000",      		  NORMAL);     //생년월일
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    
    //활성화 비활성화 화면 초기 설정
    EM_CUST_ID_H.style.display   = "none";
    EM_CARD_NO_H.style.display   = "none";
    EM_SS_NO_H.style.display     = "none";
        
    document.getElementById('titleSsno').innerHTML = "생년월일";
    document.getElementById('titleCust').innerHTML = "회원명";    
    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"           width=30    align=center</FC>'
                     + '<FC>id=CUST_NAME     name="회원명"        width=53    align=left</FC>'
                     + '<FC>id=SS_NO         name="생년월일,사업자번호"      width=100    align=center  mask={IF(COMP_PERS_FLAG="P","XXXXXX","XXX-XX-XXXXX")}</FC>'
                     + '<FC>id=IMAGE_FNAME   name="이미지화일명"   width=90    align=left</FC>'
                     + '<FC>id=COMP_PERS_FLAG  name="개인법인구분"  width=20    align=center  show=false</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-04-04
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	if (RD_COMP_PERS_FLAG_S.CodeValue == "P") {
        if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
                && trim(EM_CARD_NO_S.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
            EM_CARD_NO_S.Focus();
            return;
        } 
	} else {
        if(trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
                && trim(EM_CARD_NO_S.Text).length == 0){
            showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[사업자등록번호],[법인(단체)명] 중 1개는  반드시 입력해야 합니다.");
            EM_CARD_NO_S.Focus();
            return;
        } 		
	}
    
    strCustId = EM_CUST_ID_S.text;
    strCardNo = EM_CARD_NO_S.text;
    strSSNo   = EM_SS_NO_S.text;
    
    var strCompFlag = RD_COMP_PERS_FLAG_S.CodeValue;

    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strCustId="    + encodeURIComponent(strCustId)
                    + "&strCardNo="    + encodeURIComponent(strCardNo)
                    + "&strSSNo="      + encodeURIComponent(strSSNo)
                    + "&strCompFlag="  + encodeURIComponent(strCompFlag);

    TR_MAIN.Action  = "/dcs/dctm114.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();          
   
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 ) {
        GD_MASTER.Focus();        
    }
    else {
        EM_CARD_NO_S.Focus();
    }
}

/**
 * btn_ImgChange()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-04-04
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_ImgChange(row) {    
	document.form1.memberImg.value = DS_O_MASTER.NameValue(row ,"IMAGE_FNAME");
	document.form1.target = "iframeImg"; 
	document.form1.action="/dcs/jsp/dctm/dctm1141.jsp";
	
	document.form1.method= "post"; 
	document.form1.submit();
	
	//document.images.stage1.src = "/dcs/imgs/etc/1.jpg"; 
}
 
function btn_img(result) {  
	 
	if (result == "false")
		showMessage(EXCLAMATION, OK, "USER-1000",  "사진이 존재하지 않습니다.!");
	else if (result == "")
		document.images.stage1.src = "/dcs/imgs/etc/1.jpg";
	else 
	    document.images.stage1.src = result;
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/

-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
if (row  > 0) {
    btn_ImgChange();
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=RD_COMP_PERS_FLAG_S event=OnClick()>
    if (strCompPersFlag == this.CodeValue) return;
    if ("P" == this.CodeValue) { 
        document.getElementById('titleSsno').innerHTML         = "생년월일";
        document.getElementById('titleCust').innerHTML         = "회원명";

        initEmEdit(EM_SS_NO_H,     "000000",      NORMAL);     //생년월일_hidden
        initEmEdit(EM_SS_NO_S,     "000000",      NORMAL);     //생년월일
        
        strCompPersFlag = this.CodeValue;  
    } 
    else if ("C" == this.CodeValue) {
        document.getElementById('titleSsno').innerHTML         = "사업자등록번호";
        document.getElementById('titleCust').innerHTML         = "법인(단체)명";
        
        initEmEdit(EM_SS_NO_H,     "#00-00-00000",      NORMAL);     //사업자번호_hidden
        initEmEdit(EM_SS_NO_S,     "#00-00-00000",      NORMAL);     //사업자번호
        
        strCompPersFlag = this.CodeValue;  
    }
    DS_O_MASTER.ClearData();
    EM_CUST_ID_H.Text   = ""; 
    EM_CARD_NO_H.Text   = "";
    EM_SS_NO_H.Text     = "";
    EM_CUST_ID_S.Text   = ""; 
    EM_CUST_NAME_S.Text = "";
    EM_CARD_NO_S.Text   = "";
    EM_SS_NO_S.Text     = "";
</script>

<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()>
    if ((EM_CUST_ID_S.Modified) && (EM_CUST_ID_S.Text.length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CUST_ID_S.Text   = ""; 
        EM_CARD_NO_H.Text   = "";
        EM_SS_NO_H.Text     = "";
    } 
</script>
<script language=JavaScript for=EM_CUST_ID_S
	event=onKeyDown(kcode,scode)>
    if (!(kcode == 13 || kcode == 9)) EM_CUST_NAME_S.Text = "";
</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
    if (row  > 0) {
        btn_ImgChange();
    }
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_REASON_S" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">회원구분</th>
						<td colspan="5"><comment id="_NSID_"> <object
							id=RD_COMP_PERS_FLAG_S classid=<%=Util.CLSID_RADIO%>
							style="height: 20; width: 150" tabindex=1>
							<param name=Cols value="2">
							<param name=Format value="P^개인회원,C^법인회원">
							<param name=CodeValue value="P">
							<param name=AutoMargin value="true">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="77">카드번호</th>
						<td width="160"><comment id="_NSID_"> <object
							id=EM_CARD_NO_H width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_CARD_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S',strCompPersFlag);">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80"><span id="titleSsno" style="Color: 146ab9">사업자번호</span></th>
						<td width="160"><comment id="_NSID_"> <object
							id=EM_SS_NO_H width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_SS_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'<%=strSsno%>',strCompPersFlag);">
						</object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80"><span id="titleCust" style="Color: 146ab9">법인명</span></th>
						<td><comment id="_NSID_"> <object id=EM_CUST_ID_H
							width=0 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
							id="_NSID_"> <object id=EM_CUST_ID_S
							classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
							onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',strCompPersFlag);"
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,strCompPersFlag)" />
						<comment id="_NSID_"> <object id=EM_CUST_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=81 align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr valign="top">
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><object id=GD_MASTER width="310" height=478
							classid=<%=Util.CLSID_GRID%> tabindex=1>
							<param name="DataID" value="DS_O_MASTER" tabindex=1>
						</object></td>
					</tr>
				</table>
				</td>
				<td class="PL05" width="100%" valign="top">
				<table width="100%" height=470 border="0" cellspacing="0"
					cellpadding="0" class="BD2A">
					<tr>
						<td align="center">
						<div id="stage_1"
							style="overflow: scroll; width: 100%; height: 480px;"><img
							src="" id="stage1" /></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<form name="form1"><input name="memberImg" type="hidden" value="">
</form>
<iframe src="" width=0 height=0 scrolling=no frameborder=0
	name=iframeImg></iframe>
</body>
</html>

