<%
/*******************************************************************************
 * 시스템명 : 후지쯔 통합정보시스템
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 :
 * 파 일 명 : login.jsp
 * 버    전 : 1.0
 * 개    요 : 로그인 화면
 * 이    력 : 
 *****************************************************************************/
%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="common.util.Util" %>

<HTML>
<HEAD>
<TITLE>한국후지쯔 통합정보시스템 </TITLE>
<link rel="stylesheet" fhref="/mss/css/mds.css" type="text/css"> 
<meta http-equiv="pragma" content="no-cache">
<script language="javascript">
<!-- 
self.moveTo(0,0); 
self.resizeTo(screen.availWidth,screen.availHeight); 
self.opener = "";
//--> 
</script>   
<script language="javascript"  src="/mss/js/common.js"  type="text/javascript"></script>
<script language="javascript">
//var myWinLocal  = "";
var myWinServer = "";

function doInit() {
   // --------- 공지 사항 쿠키가 있는지 확인
   setFocus(document.myForm);
   window.dialogLeft = 0
}

// ------------- 아이디 셋팅 및 포커스
function setFocus(form) {
   
}

//------------- 윈도우 오픈
function winOpen(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable) {
    toolbar_str    = toolbar   ? 'yes' : 'no';
    menubar_str    = menubar   ? 'yes' : 'no';
    statusbar_str  = statusbar ? 'yes' : 'no';
    scrollbar_str  = scrollbar ? 'yes' : 'no';
    resizable_str  = resizable ? 'yes' : 'no';
    
    //height = height - 55 ;
    //width  = width  - 10;       
    
    height = height - 55 ;
    width  = width  - 8;    
    
    myWin = window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);

    //----------- 팝업 차단 설정이 되어 있는 경우
    if(!myWin) {
        alert("팝업 차단 상태입니다. [도구] >> [팝업차단] >> 팝업 차단 사용 안함으로 설정하십시오.");
    } 

    return myWin;            
}

//------------- 로그인 버튼을 눌렀을 때
function chk() {

    var winName = document.myForm.inputId.value;
            
    if(document.myForm.inputId.value == "") {
        alert(" ID를 입력 해 주세요. ");
        return;
    }
/*    
    if(document.myForm.inputPwd.value == "") {
        alert(" Password를 입력 해 주세요. ");
        return;
    }    
*/
    myWinServer = winOpen(winName,'', 0, 0, 1024, 768, 0, 0, 1, 0, 1);
    
    
    document.myForm.target = winName;
    document.myForm.action = '/mss/tcom001.tc?goTo=login';
    document.myForm.id.value = document.myForm.inputId.value;
    document.myForm.pwd.value = document.myForm.inputPwd.value;
    document.myForm.submit();
    
    myWinServer.focus();
    
    self.close();
}

//----------- Enter Key를 입력 했을 때
function enter () {
    if(event.keyCode == 13) {
        chk();
    }
}    

//--------- 승인 요청 팝업 화면
function showRequest() {     
}

//--------- 조직 변경 팝업 화면
function showJojikChange() {     
}

//--------- 쿠키 설정하기
function setCookie (name, value, expires) {
}

//--------- 쿠키 가져오기
function getCookie(Name) {
}

function saveid(form) {
}

function getid(form) {
     
}    

</script>
<!-- ============== Output용 -->
<comment id="_NSID_">
    <object id="DS_O_SEL_GONGJI" classid="<%=Util.CLSID_DATASET%>"></object>
</comment>
<script> _ws_(_NSID_);</script>
<!-----------------------------------------------------------------------------
  Gauce Transaction Component Declaration
------------------------------------------------------------------------------>
<object id="TR_MAIN"    classid="<%=Util.CLSID_TRANSACTION%>">
  <param name="KeyName" value="Toinb_dataid4">
</object>
</HEAD>

<BODY  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="doInit();">
<form  name="myForm" method="post">
<TABLE width="711" height="119" border="0" cellspacing="0" cellpadding="0" align=center>
<TR>
    <TD><BR><BR><IMG SRC="../imgs/comm/logo_temp.JPG" WIDTH="194" HEIGHT="64" BORDER=0 ALT=""></TD>
</TR>
</TABLE>

<TABLE width="711" height="350" border="0" cellspacing="0" cellpadding="0" align=center>
<TR>
    <TD><IMG SRC="../imgs/comm/login_temp.GIF" WIDTH="363" HEIGHT="350" BORDER=0 ALT=""></TD>
    <TD WIDTH="348" HEIGHT="350" style="padding-left:55px">
    
    <BR><BR><BR><BR><BR><BR>
    <TABLE border="0" cellspacing="0" cellpadding="2">
    <TR>
        <TD WIDTH="56" HEIGHT="19" BORDER=0 ALT=""></TD>
        <TD><input type="text" name="inputId" size="13" value="" class="input1" tabindex="1"><input type="hidden" name="id">
        </TD>
        <TD rowspan=2>
        <a href="javascript:chk()">
            <IMG SRC="/mss/imgs/comm/login_08_temp.jpg" WIDTH="61" HEIGHT="45" BORDER=0 ALT="" tabindex="3" 
                      onmouseover="this.src='../imgs/comm/login_08on_temp.jpg'" 
                      onmouseout="this.src='../imgs/comm/login_08_temp.jpg'" style="cursor:hand" ></a>
        </TD>
    </TR>
    <TR>
        <TD><IMG SRC="/mss/imgs/comm/login_07_temp.jpg" WIDTH="56" HEIGHT="19" BORDER=0 ALT=""></TD>
        <TD><input type="password" name="inputPwd"  size="13"  class="input1" tabindex="2" onKeyDown="javascript:enter();"><input type="hidden" name="pwd"></TD>
    </TR>
    <TR>
        <TD></TD>
        <TD colspan=2>
        </TD>
    </TR>
    </TABLE></TD>
</TR>
</TABLE>

</BODY>
</HTML>
