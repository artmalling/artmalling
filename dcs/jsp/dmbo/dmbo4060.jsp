<!-- 
/*******************************************************************************
 * 시스템명 : 영업지원 > 고객관리 > 멤버쉽운영 > 기간별전자쿠폰사용내역
 * 작 성 일 : 2010.05.03
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : dmbo4060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 기간별전자쿠폰사용내역
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
   
     //그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(EM_FROM_DT, "YYYYMMDD", PK);            // 매입기간 시작일
     initEmEdit(EM_TO_DT, 	"YYYYMMDD", PK);            // 매입기간 종료일

     //콤보 초기화
     initComboStyle(LC_STR_CD,	DS_IO_STR_CD,	"CODE^0^30,NAME^0^150", 1, PK);        // 점(조회)
     initComboStyle(LC_GB_CD,	DS_IO_GB_CD,	"CODE^0^30,NAME^0^150", 1, PK);        // 
     
     getStore("DS_IO_STR_CD",     "Y", "", "N");   
     getEtcCode("DS_IO_GB_CD", "D", "D110", "Y");
     
     EM_FROM_DT.Text = strToday;
     EM_TO_DT.Text = strToday;
     
     LC_STR_CD.index   = 0;
     LC_GB_CD.index   = 0;
     LC_STR_CD.Focus(); 
 
 }

 function gridCreate1(){
	 var hdrProperies = '<C>id={currow}    name="NO"			width=30    Edit=none  align=center</C>'
			         + '<C>id=USE_DT      name="매출일자"    width=80    Edit=none mask="XXXX-XX-XX" align=center</C>'
			         + '<C>id=POS_NO     name="POS번호"      width=60    Edit=none align=center</C>'
			         + '<C>id=TRAN_NO		name="거래번호"    width=60    Edit=none  align=center</C>'
			         + '<C>id=SALE_TIME     name="시간"      width=70    Edit=none mask="XX:XX:XX" align=center</C>'
			         + '<C>id=CPN_NM    name="쿠폰명"      width=160    Edit=none sumtext="합계" align=left </C>'
			         + '<C>id=BRAND_NM    name="브랜드명"      width=100    Edit=none align=left</C>'
			         + '<C>id=PBN_NM    name="품번명"      width=100    Edit=none align=left</C>'
			         + '<C>id=SALE_TOT_AMT  name="매출"     width=80    Edit=none sumtext=@sum align=right</C>'
			         + '<C>id=DC_TOT_AMT  name="에누리"         width=80    Edit=none  sumtext=@sum align=right</C>'
			         + '<C>id=ADD_POINT  name="포인트"          	width=80    Edit=none  sumtext=@sum align=right</C>'
			         + '<C>id=CUST_ID       name="회원번호"          width=80    Edit=none align=center</C>'
			         + '<C>id=CUST_NAME     name="성명"      width=60    Edit=none align=center</C>'
			         + '<C>id=CPN_TYPE_NM     name="쿠폰종류"      width=140    Edit=none align=center</C>'
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	if(!checkValidation("search")) return;
	 
	DS_IO_MASTER.ClearData(); 
    // 조회조건 셋팅
    var strStrCd   		= LC_STR_CD.BindColVal;	// 점
    var strFromDt       = EM_FROM_DT.text;      // 시작일자
    var strToDt         = EM_TO_DT.text;        // 종료일자
    var strGbFlag       = LC_GB_CD.BindColVal;        //
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters =  "&strStrCd="	+encodeURIComponent(strStrCd)
				    + "&strFromDt=" +encodeURIComponent(strFromDt)
				    + "&strToDt="   +encodeURIComponent(strToDt)
				    + "&strGbFlag="   +encodeURIComponent(strGbFlag);
    
    TR_MAIN.Action  = "/dcs/dmbo406.do?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();
 
    GR_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);

    //스크롤바 위치 조정
    GR_MASTER.SETVSCROLLING(0);
    GR_MASTER.SETHSCROLLING(0);
    
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-05-03
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
    
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
	var strStrCd   		= LC_STR_CD.Text;          // 점
    var strFromDt       = EM_FROM_DT.Text;         // 시작일자
    var strToDt         = EM_TO_DT.Text;           // 종료일자
    var strGbFlag         = LC_GB_CD.Text;        // 구분
    
	var parameters = "";
		parameters  = "점="+strStrCd                    
			    	+ " -조회기간="+ strFromDt
			    	+ "~"+ strToDt
			    	+ " -쿠폰종류="+ strGbFlag
			    	;
	openExcel2(GR_MASTER, "기간별전자쿠폰사용내역", parameters, true );
}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-03
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
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-04-13
  * 개    요        : 조회조건 값 체크 
  * return값 : void
  */	 
 function checkValidation(Gubun) {
	 switch (Gubun){
	    case "search" :

	        //점 체크
	        if (isNull(LC_STR_CD.BindColVal)==true ) {
	            showMessage(Information, OK, "USER-1003","점");
	            LC_STR_CD.focus();
	            return false;
	        }
	        
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
<comment id="_NSID_"><object id="DS_IO_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_GB_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
            <th width="60" class="point">점</th>
            <td width="150">
                    <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=150 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
            <th width="60" class="point">사용기간</th>
            <td >
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
            <th width="60" class="point">쿠폰종류</th>
            <td width="130">
                    <comment id="_NSID_">
                        <object id=LC_GB_CD classid=<%= Util.CLSID_LUXECOMBO %> width=130 tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
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

