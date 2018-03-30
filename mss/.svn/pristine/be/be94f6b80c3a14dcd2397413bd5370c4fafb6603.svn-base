<!-- 
/*******************************************************************************
 * 시스템명 : 약속변경 팝업
 * 작 성 일 : 2011.02.17
 * 작 성 자 : 김성미
 * 수 정 자 : 
 * 파 일 명 : mpro1011.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 약속 변경 팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>약속변경-POPUP</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var strTakeDt      = dialogArguments[0];
 var strStrCd       = dialogArguments[1];
 var strTakeSeq     = dialogArguments[2];
 var strProcStat    = dialogArguments[3];
/**
 * doInit()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-02-16
 * 개    요 : initialize
 * return값 : void
**/
function doInit() 
{     
	// Input Data Set Header 초기화 
	 DS_I_CHANGE.setDataHeader('<gauce:dataset name="H_CHANGE"/>');
	 DS_O_MASTER.setDataHeader('<gauce:dataset name="H_HIS_MASTER"/>');
	 
	 gridCreate1();
	 
	// 이전 약속내역 초기화
	 initEmEdit(EM_PROM_DT, "YYYYMMDD", READ);                  //이전 약속일
	 initEmEdit(EM_PROM_TIME, "HHMI", READ);                  //이전약속시간
	 initEmEdit(EM_IN_DELI_DT, "YYYYMMDD", READ);                  //이전 입고예정일
	 initEmEdit(EM_DELI_STR, "GEN", READ);                  //이전인도점
	 initEmEdit(EM_DELI_TYPE, "GEN", READ);                  //이전인도방식
	 
	 
	 // 약속일 변경
	 initEmEdit(EM_MOD_PROM_DT, "YYYYMMDD", NORMAL);                  //변경약속일
	 initComboStyle(LC_MOD_PROM_HH,DS_O_MOD_PROM_HH, "CODE^0^30,NAME^0^80", 1, PK);        //변경약속시간
	 initComboStyle(LC_MOD_PROM_MM,DS_O_MOD_PROM_MM, "CODE^0^30,NAME^0^80", 1, PK);                  //변경약속 분
	 initComboStyle(LC_MOD_REASON01,DS_O_MOD_REASON01, "CODE^0^30,NAME^0^80", 1, PK);                 //변경사유 
	 initTxtAreaEdit(EM_MOD_REASON_DTL01, NORMAL);                  //변경사유 상세
     initEmEdit(EM_MOD_TAKE_DT01, "YYYYMMDD", NORMAL);                  //변경접수일자
	 
	 // 입고예정일
	 initEmEdit(EM_MOD_IN_DELI_DT, "YYYYMMDD", NORMAL);                  //변경입고예정일
	 initComboStyle(LC_MOD_REASON02,DS_O_MOD_REASON02, "CODE^0^30,NAME^0^80", 1, PK);                   //변경사유
	 initTxtAreaEdit(EM_MOD_REASON_DTL02, NORMAL);                 //변경사유 상세
     initEmEdit(EM_MOD_TAKE_DT02, "YYYYMMDD", NORMAL);                  //변경접수일자
	 
	 // 인도점
	 initComboStyle(LC_MOD_DELI_STR,DS_O_MOD_DELI_STR, "CODE^0^30,NAME^0^80", 1, PK);                  //변경인도점
     initComboStyle(LC_MOD_REASON03,DS_O_MOD_REASON03, "CODE^0^30,NAME^0^80", 1, PK);                   //변경사유
     initTxtAreaEdit(EM_MOD_REASON_DTL03, NORMAL);                 //변경사유 상세
     initEmEdit(EM_MOD_TAKE_DT03, "YYYYMMDD", NORMAL);                  //변경접수일자
	 
	 // 인도방식
     initComboStyle(LC_MOD_DELI_TYPE,DS_O_MOD_DELI_TYPE, "CODE^0^30,NAME^0^80", 1, PK);             //변경인도방식
	 initComboStyle(LC_MOD_REASON04,DS_O_MOD_REASON04, "CODE^0^30,NAME^0^80", 1, PK);                   //변경사유
	 initTxtAreaEdit(EM_MOD_REASON_DTL04, NORMAL);                 //변경사유 상세
     initEmEdit(EM_MOD_TAKE_DT04, "YYYYMMDD", NORMAL);                  //변경접수일자
     
  // 인도방식
    // initComboStyle(LC_MOD_DELI_TYPE,DS_O_MOD_DELI_TYPE, "CODE^0^30,NAME^0^80", 1, PK);             //변경인도방식
     initComboStyle(LC_MOD_REASON05,DS_O_MOD_REASON05, "CODE^0^30,NAME^0^80", 1, PK);                   //변경사유
     initTxtAreaEdit(EM_MOD_REASON_DTL05, NORMAL);                  //변경사유 상세
     initEmEdit(EM_MOD_TAKE_DT05, "YYYYMMDD", NORMAL);                  //변경접수일자
     
     
     // 공통코드 데이터셋
     getEtcCode("DS_O_MOD_REASON01",   "D", "M023", "N", "Y");
     getEtcCode("DS_O_MOD_REASON02",   "D", "M023", "N", "Y");
     getEtcCode("DS_O_MOD_REASON03",   "D", "M023", "N", "Y");
     getEtcCode("DS_O_MOD_REASON04",   "D", "M023", "N", "Y");
     getEtcCode("DS_O_MOD_REASON05",   "D", "M023", "N", "Y");
     getEtcCode("DS_O_MOD_DELI_TYPE",   "D", "M022", "N", "Y");
     getEtcCode("DS_O_MOD_PROM_HH",   "D", "M059", "N", "Y");
     getEtcCode("DS_O_MOD_PROM_MM",   "D", "M060", "N", "Y");
     getEtcCode("DS_O_PRCO_STAT",   "D", "M024", "N", "Y");

     getStore("DS_O_MOD_DELI_STR", "Y", "", "N");

     
     btn_Search();
     
     // 취소시 입력 불가
     var contents = document.getElementsByName("CONTENTS");
     if(strProcStat == 4){
         for(var i=0;i<contents.length;i++){
             contents[i].Enable = false;
             enableControl(IMG_MOD_PRON_DT, false);
             enableControl(IMG_MOD_IN_DELI_DT, false);
             enableControl(IMG_MOD_TAKE_DT01, false);
             enableControl(IMG_MOD_TAKE_DT02, false);
             enableControl(IMG_MOD_TAKE_DT03, false);
             enableControl(IMG_MOD_TAKE_DT04, false);
             enableControl(IMG_MOD_TAKE_DT05, false);
             CHK_CANCEL.disabled = true;
         }
     }
} 

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}             name="NO"             width=30   align=center</FC>'
                     + '<FC>id=MOD_ITEM             name="항목"             width=120   align=left </FC>'
                     + '<FC>id=MOD_CONTENTS         name="변경내역"       width=200   align=left </FC>'
                     + '<FC>id=MOD_REASON           name="사유"            width=140   align=center</FC>'
                     + '<FC>id=MOD_REASON_DTL           name="변경사유상세"            width=320   align=left</FC>'
                     + '<FC>id=MOD_TAKE_DT           name="변경접수일자"            width=120   align=center</FC>';
                     
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
  * 작 성 자 : 
  * 작 성 일 : 2011-02-17
  * 개    요  : 약속 변경내용 조회
  * return값 : void
  */
  function btn_Search() 
  { 
	  var strParams = "&strTakeDt="  + encodeURIComponent(strTakeDt)
	                + "&strStrCd="   + encodeURIComponent(strStrCd)
	                + "&strTakeSeq=" + encodeURIComponent(strTakeSeq); 
      TR_MAIN.Action="/mss/mpro101.mp?goTo=getHistory"+strParams;
      TR_MAIN.KeyValue="SERVLET(O:DS_O_HISTORY=DS_O_HISTORY,O:DS_O_MASTER=DS_O_MASTER)";
      TR_MAIN.Post();  
      
      if(DS_O_HISTORY.CountRow != 1){
    	  showMessage(StopSign, OK, "USER-1000","변경이력을 가져오는데 실패했습니다.");
    	  this.close();
      }
      
      DS_I_CHANGE.AddRow();
      DS_O_HISTORY.UserStatus(1) = 1;
  }      
  
  /**
   * btn_Search()
   * 작 성 자 : 
   * 작 성 일 : 2011-02-17
   * 개    요  : 약속변경내용저장
   * return값 : void
   */
   function btn_Save() 
   { 
	   if(DS_I_CHANGE.NameValue(1, "MOD_PROM_DT") == ""    
			   && DS_I_CHANGE.NameValue(1, "MOD_PROM_HH") == ""
				   && DS_I_CHANGE.NameValue(1, "MOD_PROM_MM") == ""
					   && DS_I_CHANGE.NameValue(1, "MOD_DELI_TYPE") == ""
						   && DS_I_CHANGE.NameValue(1, "MOD_DELI_STR") == ""
							   && DS_I_CHANGE.NameValue(1, "MOD_IN_DELI_DT") == ""
								   && DS_I_CHANGE.NameValue(1, "MOD_CANCEL") == ""){
		   //저장할 내용이 없습니다
           showMessage(StopSign, OK, "USER-1028");
           return;  
	   }
	   if(DS_I_CHANGE.NameValue(1, "MOD_PROM_DT") == "" && DS_I_CHANGE.NameValue(1, "MOD_PROM_HH") != ""){
           showMessage(StopSign, OK, "USER-1000","약속일을 선택하세요");
           EM_MOD_PROM_DT.Focus();
           return;  
       }
       if(DS_I_CHANGE.NameValue(1, "MOD_PROM_DT") == "" && DS_I_CHANGE.NameValue(1, "MOD_PROM_MM") != ""){
           showMessage(StopSign, OK, "USER-1000","약속일을 선택하세요");
           EM_MOD_PROM_DT.Focus();
           return;  
       }
       if(DS_I_CHANGE.NameValue(1, "MOD_PROM_DT") == "" && DS_I_CHANGE.NameValue(1, "MOD_REASON01") != ""){
           showMessage(StopSign, OK, "USER-1000","약속일을 선택하세요");
           EM_MOD_PROM_DT.Focus();
            return;  
       }
       if(DS_I_CHANGE.NameValue(1, "MOD_PROM_DT") == "" && DS_I_CHANGE.NameValue(1, "MOD_TAKE_DT01") != ""){
           showMessage(StopSign, OK, "USER-1000","약속일을 선택하세요");
           EM_MOD_PROM_DT.Focus();
            return;  
       }
	   if(DS_I_CHANGE.NameValue(1, "MOD_PROM_DT") != "" ){  //    약속일 변경
		   if(DS_I_CHANGE.NameValue(1, "MOD_PROM_HH") == ""){
	               showMessage(StopSign, OK, "USER-1000","변경할 시간을 선택하세요.");
	               LC_MOD_PROM_HH.Focus();
	               return;  
           }
           if(DS_I_CHANGE.NameValue(1, "MOD_PROM_MM") == ""){
                   showMessage(StopSign, OK, "USER-1000","변경할 분을 선택하세요.");
                   LC_MOD_PROM_MM.Focus();
                   return;  
           }
           if(DS_I_CHANGE.NameValue(1, "MOD_REASON01") == ""){
                 showMessage(StopSign, OK, "USER-1000", "약속일 변경 사유를 선택하세요.");
                 LC_MOD_REASON01.Focus();
                 return;  
           }
           if(DS_I_CHANGE.NameValue(1, "MOD_TAKE_DT01") == ""){
                 showMessage(StopSign, OK, "USER-1000", "약속일 변경일자 선택하세요.");
                 EM_MOD_TAKE_DT01.Focus();
                 return;  
           }
	   }else if(DS_I_CHANGE.NameValue(1, "MOD_DELI_TYPE") != "" ){ //인도방식 변경
		   if(DS_I_CHANGE.NameValue(1, "MOD_REASON04") == ""){
               //저장할 내용이 없습니다
                 showMessage(StopSign, OK, "USER-1000", "인도방식 변경 사유를 선택하세요.");
                 LC_MOD_REASON04.Focus();
                 return;  
           }
           if(DS_I_CHANGE.NameValue(1, "MOD_TAKE_DT04") == ""){
               //저장할 내용이 없습니다
                 showMessage(StopSign, OK, "USER-1000", "인도방식 변경일자 선택하세요.");
                 EM_MOD_TAKE_DT04.Focus();
                 return;  
           }
	   }else if(DS_I_CHANGE.NameValue(1, "MOD_DELI_STR") != "" ){ // 인도점 변경
		   if(DS_I_CHANGE.NameValue(1, "MOD_REASON03") == ""){
               //저장할 내용이 없습니다
                 showMessage(StopSign, OK, "USER-1000", "인도점 변경 사유를 선택하세요.");
                 LC_MOD_REASON03.Focus();
                 return;  
           }
           if(DS_I_CHANGE.NameValue(1, "MOD_TAKE_DT03") == ""){
               //저장할 내용이 없습니다
                 showMessage(StopSign, OK, "USER-1000", "인도점 변경일자 선택하세요.");
                 EM_MOD_TAKE_DT03.Focus();
                 return;  
           }
	   }else if(DS_I_CHANGE.NameValue(1, "MOD_IN_DELI_DT") != ""){ // 입고예정일 변경
		   if(DS_I_CHANGE.NameValue(1, "MOD_REASON02") == ""){
               //저장할 내용이 없습니다
                 showMessage(StopSign, OK, "USER-1000", "입고예정일 변경 사유를 선택하세요.");
                 LC_MOD_REASON02.Focus();
                 return;  
           }
           if(DS_I_CHANGE.NameValue(1, "MOD_TAKE_DT02") == ""){
               //저장할 내용이 없습니다
                 showMessage(StopSign, OK, "USER-1000", "입고예정일  변경일자 선택하세요.");
                 EM_MOD_TAKE_DT02.Focus();
                 return;  
           }
	   }else if(DS_I_CHANGE.NameValue(1, "MOD_CANCEL") != ""){ // 취소여부 변경
		   if(DS_I_CHANGE.NameValue(1, "MOD_REASON05") == ""){
               //저장할 내용이 없습니다
                 showMessage(StopSign, OK, "USER-1000", "취소 변경 사유를 선택하세요.");
                 LC_MOD_REASON05.Focus();
                 return;  
           }
           if(DS_I_CHANGE.NameValue(1, "MOD_TAKE_DT05") == ""){
               //저장할 내용이 없습니다
                 showMessage(StopSign, OK, "USER-1000", "취소 변경일자 선택하세요.");
                 EM_MOD_TAKE_DT05.Focus();
                 return;  
           }
	   }
	   
       TR_MAIN.Action="/mss/mpro101.mp?goTo=saveHistory";
       TR_MAIN.KeyValue="SERVLET(I:DS_O_HISTORY=DS_O_HISTORY,I:DS_I_CHANGE=DS_I_CHANGE)";
       TR_MAIN.Post();  
   }    
/*************************************************************************
 * 3. 함수
*************************************************************************/

   /**
    * btn_Close()
    * 작 성 자 : ckj
    * 작 성 일 : 2006.07.12
    * 개    요 : Close
    * return값 : void
    */  
    function btn_Close()
    {
        window.close();
    }
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
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
        window.returnValue = "save";
        window.close();
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <script language=JavaScript for=GD_SEARCH event=OnDblClick(row,colid)>
<!--// 그리드 double 클릭이벤트에서 처리 할 내역 추가        
    doDoubleClick(row);    
//-->
</script> 

 <script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row , colid );
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

<!-- =============== Input용 -->
<comment id="_NSID_"><object id=DS_I_COND classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_I_CHANGE classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_HISTORY classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id=DS_O_MOD_REASON01 classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MOD_REASON02 classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MOD_REASON03 classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MOD_REASON04 classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MOD_REASON05 classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MOD_DELI_TYPE classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MOD_DELI_STR classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MOD_PROM_HH classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MOD_PROM_MM classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_PRCO_STAT classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <object id="TR_MAIN"        classid="<%=Util.CLSID_TRANSACTION%>">
      <param name="KeyName"   value="Toinb_dataid4">
    </object>
</comment>
<script> _ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body  onLoad="doInit();">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <SPAN id="title1" class="PL03">약속변경</SPAN>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/save.gif" width="50" height="22" onClick="btn_Save()"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
                
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr height=5>
      <td>
      </td>
      </tr>
      <tr>
        <td class="popT01 PB03">
           <table width="100%" border="0" cellspacing="0" cellpadding="0" >
            <tr>
                <td width=25%  valign="top">
                     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
			          <tr>
			            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
			              <tr>
			                <th width="60">항목</th>
			                <th width="80">이전약속</th>
			              </tr>
			              <tr>
			                <th>약속일</th>
			                <td><comment id="_NSID_">
                           <object id=EM_PROM_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width="80" tabindex=1 align="absmiddle">
                          </object>
                          <object id=EM_PROM_TIME name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width="40" tabindex=1 align="absmiddle">
                          </object>
                          </comment>
                      <script> _ws_(_NSID_);</script></td>
			              </tr>
			              <tr>
			                <th>입고예정일</th>
			                <td><comment id="_NSID_">
                          <object id=EM_IN_DELI_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width="100" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
			              </tr>
			              <tr>
			                <th>인도점</th>
			                <td><comment id="_NSID_">
                          <object id=EM_DELI_STR name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width="100" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
			              </tr>
			              <tr>
			                <th>인도방식</th>
			                <td><comment id="_NSID_">
                          <object id=EM_DELI_TYPE name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%>  width="100" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
			              </tr>
			            </table></td>
			          </tr>
			        </table>
                </td>
                <td>
                     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
			          <tr>
			            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
			              <tr>
			                <th></th>
			                <th>변경약속</th>
			                <th>변경사유</th>
			                <th>변경사유 상세</th>
			                <th>변경접수일자</th>
			              </tr>
			              <tr><!--  약속일 -->
			              <th>변경약속일</th>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_PROM_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="80" tabindex=1 align="absmiddle">
                          </object>
                           </comment>
                          <script> _ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_MOD_PRON_DT onclick="javascript:openCal('G',EM_MOD_PROM_DT)" align="absmiddle"/>
                          <comment id="_NSID_">
                          <object id=LC_MOD_PROM_HH name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="60" tabindex=1 align="absmiddle">
                          </object>
                          <object id=LC_MOD_PROM_MM name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="60" tabindex=1 align="absmiddle">
                          </object>
	                      </comment>
	                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=LC_MOD_REASON01 name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="120" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_REASON_DTL01 name="CONTENTS" classid=<%=Util.CLSID_TEXTAREA%> onKeyup="javascript:checkByteStr(this, 100, 'Y');" width="140" height="40" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      
                      </td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_TAKE_DT01 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="80" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_MOD_TAKE_DT01 onclick="javascript:openCal('G',EM_MOD_TAKE_DT01)" align="absmiddle"/></td>
                          </tr>
                         <tr><!--  입고예정일 -->
                         <th>변경 입고예정일</th>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_IN_DELI_DT name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="80" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_MOD_IN_DELI_DT onclick="javascript:openCal('G',EM_MOD_IN_DELI_DT)" align="absmiddle"/></td>
                            <td><comment id="_NSID_">
                          <object id=LC_MOD_REASON02 name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="120" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_REASON_DTL02 name="CONTENTS" classid=<%=Util.CLSID_TEXTAREA%> onKeyup="javascript:checkByteStr(this, 100, 'Y');" width="140" height="40" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_TAKE_DT02 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);"  width="80" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_MOD_TAKE_DT02 onclick="javascript:openCal('G',EM_MOD_TAKE_DT02)" align="absmiddle"/></td>
                          </tr>
                           <tr><!--  인도점 -->
                           <th>변경 인도점</th>
                            <td><comment id="_NSID_">
                          <object id=LC_MOD_DELI_STR name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="100" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=LC_MOD_REASON03 name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="120" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_REASON_DTL03 name="CONTENTS" classid=<%=Util.CLSID_TEXTAREA%> onKeyup="javascript:checkByteStr(this, 100, 'Y');" width="140" height="40" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_TAKE_DT03 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="80" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_MOD_TAKE_DT03  onclick="javascript:openCal('G',EM_MOD_TAKE_DT03)" align="absmiddle"/></td>
                          </tr>
                           <tr><!--  인도방식 -->
                           <th>변경 인도방식</th>
                            <td><comment id="_NSID_">
                          <object id=LC_MOD_DELI_TYPE name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="100" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=LC_MOD_REASON04 name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="120" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_REASON_DTL04 name="CONTENTS" classid=<%=Util.CLSID_TEXTAREA%> onKeyup="javascript:checkByteStr(this, 100, 'Y');" width="140" height="40" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_TAKE_DT04 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="80" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_MOD_TAKE_DT04  onclick="javascript:openCal('G',EM_MOD_TAKE_DT04)" align="absmiddle"/></td>
                          </tr>
                          <tr> <!--  취소 -->
                          <th>취소</th>
                            <td><input id=CHK_CANCEL name="CONTENTS" type="checkbox"/> 취소</td>
                            <td><comment id="_NSID_">
                          <object id=LC_MOD_REASON05 name="CONTENTS" classid=<%=Util.CLSID_LUXECOMBO%>  width="120" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_REASON_DTL05 name="CONTENTS" classid=<%=Util.CLSID_TEXTAREA%> onKeyup="javascript:checkByteStr(this, 100, 'Y');" width="140" height="40" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script></td>
                            <td><comment id="_NSID_">
                          <object id=EM_MOD_TAKE_DT05 name="CONTENTS" classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="80" tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_MOD_TAKE_DT05 onclick="javascript:openCal('G',EM_MOD_TAKE_DT05)" align="absmiddle"/></td>
                          </tr>
			            </table></td>
			          </tr>
			        </table>
                </td>
            </tr>
           </table>
        </td>
      </tr>
      <tr>
        <td class="popT01 PB03">
           <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
                 <tr>
                     <td width="100%">
                         <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=120 classid=<%=Util.CLSID_GRID%>>
                             <param name="DataID" value="DS_O_MASTER">
                         </OBJECT></comment><script>_ws_(_NSID_);</script>
                     </td>
                 </tr>
             </table>
        </td>
      </tr>
    </table></td>
     <td class="pop06" ></td>
  </tr>
</table>
  </td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_HISTORY classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_O_HISTORY>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=LAST_PROM_DT         Ctrl=EM_PROM_DT       param=Text</c>
        <c>Col=LAST_PROM_TIME       Ctrl=EM_PROM_TIME     param=Text</c>
        <c>Col=IN_DELI_DT           Ctrl=EM_IN_DELI_DT      param=Text</c>
        <c>Col=DELI_STR_NM          Ctrl=EM_DELI_STR      param=Text</c>
        <c>Col=DELI_TYPE_NM         Ctrl=EM_DELI_TYPE     param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=BO_CHANGE classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_I_CHANGE>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        <c>Col=MOD_PROM_DT          Ctrl=EM_MOD_PROM_DT         param=Text</c>
        <c>Col=MOD_PROM_HH          Ctrl=LC_MOD_PROM_HH         param=BindColVal</c>
        <c>Col=MOD_PROM_MM          Ctrl=LC_MOD_PROM_MM         param=BindColVal</c>
        <c>Col=MOD_REASON01         Ctrl=LC_MOD_REASON01        param=BindColVal</c>
        <c>Col=MOD_REASON_DTL01     Ctrl=EM_MOD_REASON_DTL01    param=Text</c>
        <c>Col=MOD_TAKE_DT01        Ctrl=EM_MOD_TAKE_DT01       param=Text</c>
        <c>Col=MOD_DELI_TYPE        Ctrl=LC_MOD_DELI_TYPE       param=BindColVal</c>
        <c>Col=MOD_REASON02         Ctrl=LC_MOD_REASON02        param=BindColVal</c>
        <c>Col=MOD_REASON_DTL02     Ctrl=EM_MOD_REASON_DTL02    param=Text</c>
        <c>Col=MOD_TAKE_DT02        Ctrl=EM_MOD_TAKE_DT02       param=Text</c>
        <c>Col=MOD_DELI_STR         Ctrl=LC_MOD_DELI_STR        param=BindColVal</c>
        <c>Col=MOD_REASON03         Ctrl=LC_MOD_REASON03        param=BindColVal</c>
        <c>Col=MOD_REASON_DTL03     Ctrl=EM_MOD_REASON_DTL03    param=Text</c>
        <c>Col=MOD_TAKE_DT03        Ctrl=EM_MOD_TAKE_DT03       param=Text</c>
        <c>Col=MOD_IN_DELI_DT       Ctrl=EM_MOD_IN_DELI_DT      param=Text</c>
        <c>Col=MOD_REASON04         Ctrl=LC_MOD_REASON04        param=BindColVal</c>
        <c>Col=MOD_REASON_DTL04     Ctrl=EM_MOD_REASON_DTL04    param=Text</c>
        <c>Col=MOD_TAKE_DT04        Ctrl=EM_MOD_TAKE_DT04       param=Text</c>
        <c>Col=MOD_CANCEL           Ctrl=CHK_CANCEL             param=Checked</c>
        <c>Col=MOD_REASON05         Ctrl=LC_MOD_REASON05        param=BindColVal</c>
        <c>Col=MOD_REASON_DTL05     Ctrl=EM_MOD_REASON_DTL05    param=Text</c>
        <c>Col=MOD_TAKE_DT05        Ctrl=EM_MOD_TAKE_DT05       param=Text</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
