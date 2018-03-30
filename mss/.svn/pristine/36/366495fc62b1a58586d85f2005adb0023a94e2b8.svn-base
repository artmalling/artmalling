<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 >  협력사EDI >  협력사EDI 커뮤니티 > E-Mail전송
 * 작 성 일 : 2011.08.12
 * 작 성 자 : 김정민
 * 수 정 자 : 
 * 파 일 명 : medi1060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 협력사에 Email을 보낸다.
 * 이    력 :
 *        
          2011.08.12 (김정민) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	//session 정보
	SessionInfo sessionInfo = (SessionInfo) session
			.getAttribute("sessionInfo");
	String userid = sessionInfo.getUSER_ID();
	String org_falg = sessionInfo.getORG_FLAG();

	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var userid = '<%=userid%>';         //사용자아이디
var org_flag = '<%=org_falg%>';     //매장정보
var g_saveFlag = false;

<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
	DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>'); 
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
     
    initEmEdit(EM_TITLE,  "GEN", NORMAL);              // 제목     
    initTxtAreaEdit(TEXT_LIST, NORMAL);              //내용 
    initComboStyle(LC_IO_STRCD,DS_I_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점
       
    getStore("DS_I_STR_CD", "Y", "1", "N"); 
    
    LC_IO_STRCD.Index = 0;
    LC_IO_STRCD.Focus();
    
    btn_Search();
       
}

function gridCreate(){      
       
           var hdrProperies = ''
               + '<FC>ID=CHK            NAME=" "'
               + '                                         WIDTH=20    ALIGN=CENTER     EDITSTYLE=CHECKBOX  HEADCHECKSHOW=TRUE </FC>'   
               + '<FC>ID=VEN_CD         NAME="협력사코드"'
               + '                                         WIDTH=70    ALIGN=LEFT       EDIT="NONE" </FC>'
               + '<FC>ID=VEN_NM         NAME="협력사명"'
               + '                                         WIDTH=105   ALIGN=LEFT       EDIT="NONE" </FC>';
           initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
        
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
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {    

	var strcd = LC_IO_STRCD.BindColVal;
	    
    var goTo = "getMaster";      
    var parameters = "&strcd="+encodeURIComponent(strcd);
 
    TR_MAIN.Action = "/mss/medi106.md?goTo="+goTo+parameters;
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    setPorcCount("SELECT", GD_MASTER); 
}

/**
 * btn_New()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-21
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
     
}
 
/**
 * btn_Save()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     
    //저장 시  CanRowPosChange 이벤트 우회 flag
    g_saveFlag = true; 
    
    if( !DS_IO_MASTER.IsUpdated  ){
        //showMessage(StopSign, OK, "USER-1028"); 
        showMessage(EXCLAMATION , OK, "USER-1000", "협력사를 하나이상 선택해야 합니다.");
        return;
    } 
    
    var strTitle = EM_TITLE.Text;
    var strList = TEXT_LIST.Text;
     
    if(trim(strTitle) == "" ) {
    	showMessage(EXCLAMATION , OK, "USER-1000", "제목을 입력 해야 합니다.");
    	EM_TITLE.focus();
    	return;
    }  
    if(trim(strList) == "" ) {
        showMessage(EXCLAMATION , OK, "USER-1000", "내용을 입력 해야 합니다.");
        TEXT_LIST.focus();
        return;
    }  
    
    var goTo = "Email";
    var paraments = "&strTitle=" + encodeURIComponent(strTitle)
                  + "&strList="  + encodeURIComponent(strList);
   // alert(encodeURI(encodeURIComponent(strList)));
    TR_MAIN.Action = "/mss/medi106.md?strFlg=save&goTo=" + goTo + paraments; 
    TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();
    
    clear_click();
     
} 
/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
     
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * clear_click()
  * 작 성 자 : 
  * 작 성 일 : 2010-12-12
  * 개    요 : 메일전송 후 초기화
  * return값 : void
  */
 function clear_click() {
	 btn_Search();
	
	 LC_IO_STRCD.Index = 0;

	EM_TITLE.Text = "";
	TEXT_LIST.Text = "";
	 
}

-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_S_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_S_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_S_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_S_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>   
if(clickSORT) return; 
</script>

<script language=JavaScript for=LC_IO_STRCD event=OnSelChange()>
    if( LC_IO_STRCD.Text != "" ){
    	EM_TITLE.Text="";
        TEXT_LIST.Text="";
    	btn_Search();
    }

</script>

<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
        strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_IO_MASTER.CountRow;i++){
    	DS_IO_MASTER.NameValue(i,"CHK") = strFlag;
    }
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(Row)>
// row변경 전
if (g_saveFlag) return;

/*if (DS_IO_MASTER.CountRow > 0) {
    // 선택 시 상세조회(선택 Row) 미사용
    if (DS_IO_MASTER.IsUpdated) {// 컬럼변경전 변경데이터 있을 시 이동할것인지 확인
         var ret = showMessage(Question, YESNO, "USER-1049");
         if (ret == "1") {
            rollbackDate(Row);              
            return true;
         }else {
            return false;
         }
   }
    return true;
}
return true;*/
</script>


<!--  GD_MASTER 소팅 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    
    if( row < 1 ){      
        sortColId( eval(this.DataID), row, colid);   
    }
    
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->

<script language=JavaScript for=EM_S_DATE event=onKillFocus()>
    //[조회용]시작일 체크
    checkDateTypeYMD( EM_S_DATE );
</script>

<script language=JavaScript for=EM_E_DATE event=onKillFocus()>
    //[조회용]종료일 체크
    checkDateTypeYMD( EM_E_DATE );
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_I_CONDITION  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_I_STR_CD  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>  
<!-- =============== ONLOAD용 -->


<!-- =============== 공통함수용 -->

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--------------------- 3. Fileupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_FILEUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
    <param name="FileFilterString"  value=1>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝  
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<iframe id=iFrame name=iFrame src="about:blank" width=0 height=0>
</iframe>
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    <tr>
        <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
            <tr>
            <td style="width: 30%">
               <table width="100%" border="0" cellpadding="0" cellspacing="0"  class="s_table">
                   <tr>
                       <th class="point" width="30">점</th>
                       <td>
                           <comment id="_NSID_"> 
                                <object id=LC_IO_STRCD classid=<%=Util.CLSID_LUXECOMBO%> width=99% tabindex=1 align="absmiddle"> </object> 
                            </comment>
                            <script>_ws_(_NSID_);</script>   
                       </td>
                   </tr>
                   <tr>
                       <td colspan="2">
                           <table width="100%" border="0" cellspacing="0" cellpadding="0"
		                        class="BD4A">
		                        <tr>
		                            <td width="100%"><comment id="_NSID_"><OBJECT
		                                id=GD_MASTER width=100% height=518 classid=<%=Util.CLSID_GRID%>>
		                                <param name="DataID" value="DS_IO_MASTER">
		                            </OBJECT></comment><script>_ws_(_NSID_);</script></td>
		                        </tr>
		                    </table>
                       </td>
                   </tr>
               </table>
            </td> 
            <td style="width: 1%"></td>
            <td style="width: 69%">
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  class="s_table">
                    <tr>
                       <th class="point" width="80">제목</th>
                       <td>
                           <comment id="_NSID_">
                               <object id=EM_TITLE classid=<%=Util.CLSID_EMEDIT%> width=99% tabindex=1 align="absmiddle">
                               </object> 
                           </comment>
                           <script>_ws_(_NSID_);</script>
                       </td>
                   </tr>
                   <tr>
                       <th class="point" width="80">내용</th>
                       <td style="height:526px">
                           <comment id="_NSID_">
                               <object id=TEXT_LIST classid=<%=Util.CLSID_TEXTAREA%> height=518 align="absmiddle" width=99% tabindex=1 > 
                               </object> 
                           </comment>
                           <script>_ws_(_NSID_);</script>
                       </td>
                   </tr>  
                </table>
            </td>
            </tr>
        </table>
    </tr>
</table>
</div>  
</body>
</html>

