<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 고객관리 > VOC관리 > 컴플레인등록 > 조치등록 (POPUP)
 * 작 성 일 : 2016.11.28
 * 작 성 자 : 윤지영
 * 수 정 자 : 
 * 파 일 명 : dvoc0011.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 컴플레인 조치결과를 등록한다.
 * 이    력 :
 *        2016.11.28 (윤지영) 신규작성 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>조치등록-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script LANGUAGE="JavaScript"> 

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/ 
 
 var strStrCd    = dialogArguments[0]; //점
 var strRecDt    = dialogArguments[1]; //접수일자
 var strRecSeq   = dialogArguments[2]; //접수번호
 var strProcDept = dialogArguments[3]; //처리부서
 var strRecId    = dialogArguments[4]; //처리담당자
 var strProcGbn  = dialogArguments[5]; //처리구분
 
 /**
  * doInit()
  * 작 성 자     : 윤지영
  * 작 성 일     : 2016-11-28
  * 개       요     : 해당 페이지 LOAD 시  
  * return값 : void
  */
 function doInit(){    
	//그리드 초기화 
	    
	strToday = getTodayDB("DS_O_RESULT");
	
	strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
	strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
	 
    //콤보 초기화  
    initComboStyle(LC_PROC_DEPT, DS_I_PROC_DEPT, "CODE^0^30,NAME^0^80", 1, PK);//처리부서 M016 
    initComboStyle(LC_PROC_GBN, DS_I_PROC_GBN, "CODE^0^30,NAME^0^80", 1, PK);  //처리구분 M015
	
    initEmEdit(EM_REC_ID,     "GEN^10" , READ);   //접수자사번(세션접속자 자동셋팅) 
    initEmEdit(EM_REC_NAME,   "GEN^30" , READ);   //접수자명(세션접속자 자동셋팅)
    initEmEdit(EM_REC_DT,     "YYYYMMDD"   , PK);  //처리일자 
    initEmEdit(TXT_MEMO,   	  "GEN^1000", PK);     //처리내역 
    
    getEtcCode("DS_I_PROC_DEPT", "M", "M016", "N"); 
    getEtcCode("DS_I_PROC_GBN", "M", "M015", "N");     
	
	btn_Search(); 
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
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개       요     : 조회시 호출
 * return값 : void
 */
 function btn_Search() {  

	DS_IO_MASTER.Cleardata(); 
	
	//조회
	var strStr_Cd       = strStrCd; //점
	var strRec_Dt       = strRecDt; //접수일자
	var strRec_Seq      = strRecSeq;//접수번호      
	  
    var parameters  = "&strStr_Cd=" 	+ encodeURIComponent(strStr_Cd) 
                    + "&strRec_Dt=" 	+ encodeURIComponent(strRec_Dt)
                    + "&strRec_Seq="    + encodeURIComponent(strRec_Seq) 
    				 ;
	 
    TR_MAIN.Action  = "/dcs/dvoc001.dv?goTo=searchMaster_Pop"+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();   
    
    //신규 등록시 
    if (DS_IO_MASTER.NameValue(1, "PROC_ID")==""){  
    	 EM_REC_ID.Text = strUserID;  //처리담당자
    	 EM_REC_NAME.Text = strUserNM;//처리담당자명
	 	 LC_PROC_DEPT.Index = 0;      //처리부서
	 	 LC_PROC_GBN.Index = 1;       //처리구분
	 	 EM_REC_DT.Text = strToday;   //처리일자
	 	 TXT_MEMO.focus(); 
    } else {
	 	 LC_PROC_DEPT.BindColVal = DS_IO_MASTER.NameValue(1, "PROC_DEPT");//처리부서
	   	 EM_REC_ID.Text = DS_IO_MASTER.NameValue(1, "PROC_ID");  	 	  //처리담당자  
	 	 LC_PROC_GBN.BindColVal = DS_IO_MASTER.NameValue(1, "PROC_GBN");  //처리구분
	 	 EM_REC_DT.Text = DS_IO_MASTER.NameValue(1, "PROC_DT");      //처리일자
	 	 TXT_MEMO.Text = DS_IO_MASTER.NameValue(1, "PROC_CONT");     //처리내역
    }
 } 

 /**
 * btn_Save()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
 function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }  

    if(!checkValidation("Save"))    // validation 체크
        return;
    
    if(DS_IO_MASTER.CountRow <= 0){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "데이터 입력 후 저장하십시오."); 
        GR_DETAIL.Focus();
        return;
    } 
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){ 
    	
        var params = "&strFlag=save_Pop"; 
        TR_SAVE.Action="/dcs/dvoc001.dv?goTo=save"+params;  
        TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_SAVE.Post();

    }   
 } 
  
/**
 * btn_Close()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개    요 : Close
 * return값 : void
 */  
 function btn_Close()
 {
     window.close();
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
 * checkValidation()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개    요        : 조회조건 값 체크 
 * return값 : void
 */
 function checkValidation(Gubun) {
      
      var messageCode = "USER-1001";  
      
      // 저장버튼 클릭시 Validation Check
      if(Gubun == "Save"){
     	
          if(LC_PROC_DEPT.Text.length == 0){                                 // 클레임등급
              showMessage(EXCLAMATION, OK, "USER-1002", "처리부서");
              LC_PROC_DEPT.Focus();
              return false;
          }
           
          if(LC_PROC_GBN.Text.length == 0){                                  // 접수형태
             showMessage(EXCLAMATION, OK, "USER-1002", "처리구분");
             LC_PROC_GBN.Focus();
             return false;
          }  
          if(EM_REC_DT.Text.length == 0){                                    // 처리일자
             showMessage(EXCLAMATION, OK, "USER-1002", "처리일자");
             EM_REC_DT.Focus(); 
             return false;
          }   
          
          if(TXT_MEMO.Text.length == 0){                                     // 처리내역
              showMessage(EXCLAMATION, OK, "USER-1002", "처리내역"); 
              TXT_MEMO.Focus(); 
              return false;
           }   
      } 
      return true; 
 }
 
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
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_SAVE.SrvErrMsg('UserMsg',i).split('|'); 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[0]);
    }
    btn_Search();
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script> 
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->   

<!--------------------- 6. 컴포넌트 이벤트 처리  --------------------------------> 

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
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PROC_DEPT"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_PROC_GBN"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->

<!-- =============== ONLOAD용 --> 

<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->
<body onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="pop01"></td>
        <td class="pop02"></td>
        <td class="pop03"></td>
    </tr>
    <tr>
        <td class="pop04"></td>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
				        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
				          <tr>
				            <td width="" class="title">
				              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
				              <SPAN id="title1" class="PL03">조치등록 (POP-UP)</SPAN>
				            </td>
				            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
				              <tr>
				                <td><img src="/<%=dir%>/imgs/btn/search.gif" width="50" height="22" onClick="btn_Search();"/></td>
				                <td><img src="/<%=dir%>/imgs/btn/save.gif" width="50" height="22" onClick="btn_Save();"/></td>
				                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
				                
				                </tr>
				            </table></td>
				          </tr>
				        </table></td>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td class="popT01 PB03">
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="o_table">
                    <tr>
                        <td>
			                <table width="100%" border="0" cellpadding="0" cellspacing="0"
			                    class="s_table">
			                    <tr>
			                        <th width="80">처리부서</th>
			                        <td width="160"><comment id="_NSID_"> <object
			                            id=LC_PROC_DEPT classid=<%= Util.CLSID_LUXECOMBO %>
			                            width="160" height=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
			                        </td> 
								 	<th width="100" class="point">접수자</th>
						                <td><comment id="_NSID_"> <object
						                    id=EM_REC_ID classid=<%=Util.CLSID_EMEDIT%> width=70
						                    align="absmiddle" tabindex=1></object> </comment><script> _ws_(_NSID_);</script>  
						                    <comment id="_NSID_"> <object id=EM_REC_NAME
						                    classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle"
						                    tabindex=1></object> </comment><script>_ws_(_NSID_);</script></td> 
			                        <th width="80">처리구분</th>
								    <td ><comment id="_NSID_"> <object
										id=LC_PROC_GBN classid=<%=Util.CLSID_LUXECOMBO%> height=100
										width=140 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
									 </td>	
			                    </tr>
			                    <tr> 
			                        <th>처리일자</th>
				                    <td colspan="5"><comment id="_NSID_"> <object
				                        id=EM_REC_DT classid=<%=Util.CLSID_EMEDIT%> width=118 tabindex=1
				                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
				                        src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
				                        onclick="javascript:openCal('G',EM_REC_DT)" />
				                 	 </td> 
			                    </tr> 
			                    <tr> 
			                        <th>처리내역</th>
				                    <td colspan="5"><comment id="_NSID_"> <object
				                        id=TXT_MEMO classid=<%=Util.CLSID_TEXTAREA%> style="width: 100%; height: 100px;" tabindex=1
				                        onkeyup="javascript:checkByteStr(TXT_MEMO, 1000, 'Y');" 
				                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
				                 	 </td> 
			                    </tr>
			                </table>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>  
        </table>
        </td>
        <td class="pop06"></td>
    </tr>
    <tr>
        <td class="pop07"></td>
        <td class="pop08"></td>
        <td class="pop09"></td>
    </tr>
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='    
        <c>Col=PROC_DEPT        Ctrl=LC_PROC_DEPT       param=BindColVal</c>
        <c>Col=PROC_GBN         Ctrl=LC_PROC_GBN       	param=BindColVal</c>   
        <c>Col=PROC_DT          Ctrl=EM_REC_DT       	param=Text</c>  
        <c>Col=PROC_CONT        Ctrl=TXT_MEMO       	param=Text</c> 
        <c>Col=PROC_ID          Ctrl=EM_REC_ID       	param=Text</c>  
        '>
</object>
</comment> 
<script>_ws_(_NSID_);</script>
</body>
</html>

