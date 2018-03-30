<!-- 
/*******************************************************************************
 * 시스템명 : 영업지원 > 고객관리 > 회원관리 > 고객수신동의송신현황조회
 * 작 성 일 : 2012.05.23
 * 작 성 자 : 강진
 * 수 정 자 : 
 * 파 일 명 : dctm4270.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 고객수신동의송신현황조회
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"   src="/<%=dir%>/js/common.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/gauce.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/global.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/message.js"       type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_dcs.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--

var strToday          = "";                            // 현재날짜
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
   
     //그리드 초기화
     gridCreate1(); //마스터
     GR_MASTER.GTitleHeight = 20;
     GR_MASTER.TitleHeight  = 40;
     
     // EMedit에 초기화
     initEmEdit(EM_FROM_DT, "YYYYMMDD", PK);            // 시작일
     initEmEdit(EM_TO_DT, 	"YYYYMMDD", PK);            // 종료일   
     
     EM_FROM_DT.Text = strToday.substring(0,6)+"01";
     EM_TO_DT.Text   = strToday;
 }

 function gridCreate1(){
     var hdrProperies = '<C>id={currow}    			name="NO"					width=30     Edit=none  align=center</C>'  
			    	  + '<G> id=TITLE             	name="변경" 		edit=none 	align=center'  
			          + '<C>id=CHG_DT           	name="일자"      	width=80    Edit=none  Mask="XXXX-XX-XX" align=center</C>'  
					  + '<C>id=CHG_SEQ           	name="순번"        	width=60     Edit=none  align=center</C>'  
				      + '</G>'
				      + '<G> id=TITLE             	name="회원정보" 		edit=none 	align=center'  
			          + '<C>id=CUST_ID    			name="회원ID"        width=80    Edit=none  align=center</C>'  
					  + '<C>id=CUST_NAME         	name="회원명"        	width=70    Edit=none  align=center</C>'  
					  + '<C>id=CARD_NO     			name="카드번호"       width=120    Edit=none  Mask="XXXX-XXXX-XXXX-XXXX" align=center</C>'  
					  + '</G>'
					  + '<G> id=TITLE             	name="현재 수신 여부" 		edit=none 	align=center'  
				      + '<C>id=EMAIL_YN     		name="이메일;수신"    width=50    Edit=none  align=center</C>'
					  + '<C>id=EMAIL     			name="이메일"        	width=150    Edit=none  align=center</C>'
					  + '<C>id=SMS_YN     			name="SMS;수신"      width=50    Edit=none  align=center</C>'  
					  + '<C>id=MOBILE_PH     		name="전화번호"       width=100    Edit=none  align=center</C>'  
					  + '</G>'
					  + '<G> id=TITLE             	name="동기화 진행 현황" edit=none 	align=center '  
				      + '<C>id=SEND_DATE     		name="송신일시"       width=140    Edit=none   align=center</C>'  
					  + '<C>id=RECV_DATE     		name="수신일시"       width=140    Edit=none   align=center</C>'  
					  + '<C>id=APP_DATE     		name="적용일시"       width=140    Edit=none   align=center</C>'
					  + '<C>id=PROC_GB     			name="처리;구분"      width=40    Edit=none  align=center</C>'  
					  + '<C>id=PROC_GB_NM     		name="처리;현황"      width=60    Edit=none  align=center</C>'  
					  + '</G>'
					  + '<G> id=TITLE             	name="동기화 회원 정보" edit=none 	align=center show=false'  
					  + '<C>id=IF_CUST_ID     		name="회원ID"        width=80    Edit=none  align=center</C>'  
					  + '<C>id=IF_CARD_NO     		name="카드번호"       width=120    Edit=none  Mask="XXXX-XXXX-XXXX-XXXX" align=center</C>'  
					  + '<C>id=IF_USERID     		name="회원식별자"     width=100    Edit=none  align=center</C>'
					  + '</G>'
					  + '<G> id=TITLE             	name="이메일 수신여부" 	edit=none 	align=center'  
					  + '<C>id=EMAIL_YN_CHG_YN     	name="변경;구분"		width=40    Edit=none  align=center</C>'
					  + '<C>id=EMAIL_YN_CHG_YN_NM   name="변경;여부"		width=40    Edit=none  align=center show=false</C>'
					  + '<C>id=IF_EMAIL_YN          name="수신;구분" 		width=40    Edit=none  align=center</C>'
					  + '<C>id=EMAIL_YN_NM    		name="수신;여부"  	width=40    Edit=none  align=center</C>'
					  + '</G>'
					  + '<G> id=TITLE             	name="SMS 수신여부" 	edit=none 	align=center'  
					  + '<C>id=SMS_YN_CHG_YN    	name="변경;구분" 		width=40    Edit=none  align=center</C>'
					  + '<C>id=SMS_YN_CHG_YN_NM 	name="변경;여부" 		width=40    Edit=none  align=center show=false</C>'
					  + '<C>id=IF_SMS_YN     		name="수신;구분"  	width=40    Edit=none  align=center</C>'
					  + '<C>id=SMS_YN_NM    		name="수신;여부"  	width=40    Edit=none  align=center</C>'
					  + '</G>'
					  + '<G> id=TITLE             	name="자택주소 변경" 	edit=none 	align=center'  
					  + '<C>id=HOME_ADDR_CHG_YN     name="변경;구분" 		width=40    Edit=none  align=center</C>'
					  + '<C>id=HOME_ADDR_CHG_YN_NM  name="변경;여부" 		width=40    Edit=none  align=center  show=false</C>'
					  + '<C>id=HOME_ADDR     		name="집주소"  		width=400    Edit=none  align=left</C>'
					  + '</G>'
					  + '<G> id=TITLE             	name="이메일 변경" 	edit=none 	align=center'  
					  + '<C>id=EMAIL_CHG_YN     	name="변경;구분" 		width=40    Edit=none  align=center</C>'
					  + '<C>id=EMAIL_CHG_YN_NM  	name="변경;여부"  	width=40    Edit=none  align=center</C>'   	    
					  + '<C>id=IF_EMAIL     		name="이메일"  		width=150    Edit=none  align=center show=false</C>'
					  + '</G>'
					  + '<G> id=TITLE             	name="휴대전화 변경" 	edit=none 	align=center'  
					  + '<C>id=MOBILE_PH_CHG_YN     name="변경;구분" 		width=40    Edit=none  align=center</C>'
					  + '<C>id=MOBILE_PH_CHG_YN_NM  name="변경;여부" 		width=40    Edit=none  align=center show=false</C>'
					  + '<C>id=IF_MOBILE_PH     	name="휴대전화"  		width=100    Edit=none  align=center</C>'
					  + '</G>'
					  + '<G> id=TITLE             	name="새주소 변경" 	edit=none 	align=center show=false'  
					  + '<C>id=HNEW_ADDR_CHG_YN     name="변경;구분" 		width=40    Edit=none  align=center</C>'
					  + '<C>id=HNEW_ADDR_CHG_YN_NM  name="변경;여부"		width=40    Edit=none  align=center show=false</C>' 	
					  + '<C>id=HNEW_ADDR     		name="새주소"  		width=400    Edit=none  align=left</C>'	
					  + '</G>'
					  + '<G> id=TITLE             	name="변경자" 		edit=none 	align=center '  
					  + '<C>id=REG_DATE             name="변경일시" 		    width=140    Edit=none  align=center</C>'
					  + '<C>id=REG_ID               name="ID"		    width=60    Edit=none  align=center</C>' 	
					  + '</G>'
                	  ;                	  
              	  
     initGridStyle(GR_MASTER, "common", hdrProperies, false);
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
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 조회시 호출
 * return값 : void
 */
 function btn_Search() {
	 
		if(!checkValidation("search")) return;
		 
		DS_IO_MASTER.ClearData(); 
	    // 조회조건 셋팅
	    var strFromDt       = EM_FROM_DT.text;      // 시작일자
	    var strToDt         = EM_TO_DT.text;        // 종료일자
	    
	    var goTo       = "searchMaster" ;    
	    var action     = "O";     
	    var parameters =  "&strFromDt=" + encodeURIComponent(strFromDt)
					    + "&strToDt="   + encodeURIComponent(strToDt); 
	    
	    TR_MAIN.Action  = "/dcs/dctm427.dm?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
	    TR_MAIN.Post();
	 
	    GR_MASTER.focus();
	    // 조회결과 Return
	    setPorcCount("SELECT", DS_IO_MASTER.CountRow);    
	}

/**
 * btn_New()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자     : 강진
 * 작 성 일     : 2012.05.23
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
    
}


/**
 * btn_Excel()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	var strStrCd		= "02";						 
    var strFromDt       = EM_FROM_DT.Text;         // 시작일자
    var strToDt         = EM_TO_DT.Text;           // 종료일자
    
	var parameters = "";
		parameters  = "조회구분="+strStrCd                    
			    	+ " -조회기간="+ strFromDt
			    	+ "~"+ strToDt
			    	;
	openExcel2(GR_MASTER, "고객수신동의송신현황조회", parameters, true );
}

/**
 * btn_Print()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * checkValidation()
  * 작 성 자     : 강진
  * 작 성 일     : 2012.05.23
  * 개    요        : 조회조건 값 체크 
  * return값 : void
  */	 
 function checkValidation(Gubun) {
	 switch (Gubun){
	    case "search" :
	        
			//매출일자
	        if (isNull(EM_FROM_DT.Text) ==true ) {
	            showMessage(Information, OK, "USER-1003","시작일자"); 
	            EM_FROM_DT.focus();
	            return false;
	        }
	        //년월 자릿수, 공백 체크
	        if (EM_FROM_DT.Text.replace(" ","").length != 8 ) {
	            showMessage(Information, OK, "USER-1027","시작일자","8");
	            EM_FROM_DT.focus();
	            return false;
	        }
	        if(!checkYYYYMMDD(EM_FROM_DT.Text)){
	        	showMessage(Information, OK, "USER-1004","시작일자");
	        	EM_FROM_DT.focus();
	            return false;
	        }
	        	
	        if (isNull(EM_TO_DT.Text) ==true ) {
	            showMessage(Information, OK, "USER-1003","종료일자"); 
	            EM_TO_DT.focus();
	            return false;
	        }
	        //년월 자릿수, 공백 체크
	        if (EM_TO_DT.Text.replace(" ","").length != 8 ) {
	            showMessage(Information, OK, "USER-1027","종료일자","8");
	            EM_TO_DT.focus();
	            return false;
	        }
	        if(!checkYYYYMMDD(EM_TO_DT.Text)){
	            showMessage(Information, OK, "USER-1004","종료일자");
	            EM_TO_DT.focus();
	            return false;
	        }
	        
	        if(!isBetweenFromTo(EM_FROM_DT.Text, EM_TO_DT.Text)){
	            showMessage(INFORMATION, OK, "USER-1015"); 
	            EM_FROM_DT.focus();
	            return false;
	        }
	        /*
	        if(daysBetween(EM_FROM_DT.Text, EM_TO_DT.Text) >= 31){
	        	showMessage(INFORMATION, OK, "USER-1000","조회기간은 30일을 넘을 수 없습니다."); 
	        	EM_FROM_DT.focus();
	            return false;
	        }
	        */
	        break;
	   
	    }
	    return true;
      
  }
 
 

-->
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
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
	
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60" class="point">변경일자</th>
            <td colspan="3">
                  <comment id="_NSID_">
                      <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_FROM_DT)" align="absmiddle" />
                  ~
                  <comment id="_NSID_">
                      <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TO_DT" onclick="javascript:openCal('G',EM_TO_DT)" align="absmiddle" />
            </td>
            
            <!--  
            <th width="10" class="point"></th>
            <td width="150"></td>
            -->            
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td class="dot"></td>
  </tr>

  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
          <tr>
            <td width="100%">
                <comment id="_NSID_">
                    <OBJECT id=GR_MASTER width=100% height=500 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                        <Param Name="ViewSummary"   value="1" >
                    </OBJECT>
                </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>  
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>

