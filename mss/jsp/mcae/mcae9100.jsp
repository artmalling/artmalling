<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품지급정산 > 사은행사 브랜드 부담예정 현황
 * 작 성 일 : 2016.11.18
 * 작 성 자 : 윤지영
 * 수 정 자 :  
 * 파 일 명 : MCAE9100.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 사은행사 브랜드 부담예정 현황을 조회한다. 
 * 이    력 :
 *        2016.11.18 (윤지영) 신규작성 
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
<%
	String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        									*-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_select =false;


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 /**
 * doInit()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-11-18
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 400;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_PRSNTCAL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    //그리드 초기화
    gridCreate1(); 
    gridCreate2();
    
    // EMedit에 초기화
    initEmEdit(EM_S_EVENT_CD, "NUMBER3^11", NORMAL);//행사코드 
      
    //콤보 초기화
    initComboStyle(LC_S_STR, DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK); //점(조회)
    initEmEdit(EM_END_YM,                       "YYYYMM", PK);                      // 행사종료년월
    EM_END_YM.Text = getTodayFormat("YYYYMM");
    
    getStore("DS_O_STR", "Y", "1", "N");
    LC_S_STR.Index = 0;
    LC_S_STR.Focus();
}
 
function gridCreate1(){
    var hdrProperies ='<FC>id={currow}     	 name="NO"           width=30   align=center </FC>'
			        + '<FC>id=STR_CD     	 name="점코드"       width=100  align=left	   show=false</FC>'
                    + '<FC>id=STR_NM     	 name="점명"         width=100  align=left   </FC>' 
                    + '<FC>id=EVENT_TYPE_NM  name="행사유형"     width=100  align=left   </FC>'
                    + '<FC>id=EVENT_CD       name="행사코드"     width=100  align=left   </FC>'
                    + '<FC>id=EVENT_NAME     name="행사명"       width=100  align=left   </FC>'
                    + '<FC>id=EVENT_S_DT     name="행사시작일"   width=100  align=center   mask="XXXX/XX/XX"</FC>'
                    + '<FC>id=EVENT_E_DT     name="행사종료일"   width=100  align=center   mask="XXXX/XX/XX"</FC>' 
                    + '<FC>id=PRSNT_AMT      name="지급금액"     width=120  align=right  </FC>'
                    + '<FC>id=PB_APP_RATE    name="브랜드부담율" width=90   align=right  </FC>'
                    + '<FC>id=PRSNT_AMT_B    name="브랜드부담지급금액"     width=120  align=right  </FC>'
                    + '<FC>id=PRSNT_AMT_M    name="POS미회수취소금액"  width=120  align=right  show=false</FC>'
                    ;
    initGridStyle(GD_CARDCAL, "common", hdrProperies, false);
} 

function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}           name="NO"               width=30   align=center</FC>'
			        + '<FC>id=PUMBUN_CD           name="브랜드코드"       width=90   align=center </FC>'
			        + '<FC>id=PUMBUN_NM           name="브랜드명"         width=90   align=left</FC>'
                    + '<FC>id=NET_SALE_AMT_TAX    name="매출액"           width=120  align=right     sumtext="@sum"    </FC>'
                    + '<FC>id=APP_RATE            name="인정율"           width=90   align=right                       </FC>'
                    + '<FC>id=MC_AMT              name="인정금액"         width=120  align=right     sumtext="@sum"    </FC>'
                    + '<FC>id=MC_RATE             name="비중"             width=90   align=right    sumtext="@sum"    </FC>'
                    + '<FC>id=PRSNT_AMT           name="부담금액"         width=120  align=right     sumtext="@sum"    </FC>' 
                    ;
    GD_PRSNTCAL.ViewSummary = "1";                
    initGridStyle(GD_PRSNTCAL, "common", hdrProperies2, false);
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
/*  사은품정산내역임.
    사은품지급시 기타지급은 별도 테이블()에 누적
    사은품지급테이블의 내역에서 지급 - 취소(POS미회수취소를 제외한 나머지 취소구분)를 한것이 지급금액임.
    
    POS미회수취소금액은 지급금액에서 빼지 않음. 브랜드정산에 포함됨. 
*/
 
 /**
 * btn_Search()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-11-18
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	DS_IO_MASTER.ClearData(); 
	DS_IO_DETAIL.ClearData(); 
	
    if(LC_S_STR.BindColVal.length == 0){  // 점코드
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_S_STR.focus();
        return;
    } 

	 if(EM_END_YM.Text.length < 6){
 		showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "행사종료년월");
 		EM_END_YM.Focus();
         return;
 	}
	 
    // 조회조건 셋팅
    var strStrCd   = LC_S_STR.BindColVal; //점코드
    var strEND_YM  = EM_END_YM.Text;      //행사종료년월
    var strEventCd = EM_S_EVENT_CD.Text;  //행사코드
    
    var goTo       = "getEventInfo";    
    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strEND_YM="+ encodeURIComponent(strEND_YM)
                   + "&strEventCd="+ encodeURIComponent(strEventCd)
                   ;
    
    TR_MAIN.Action="/mss/mcae910.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    g_select =true;
    TR_MAIN.Post(); 
    g_select =false;
    
    if(DS_IO_MASTER.CountRow == 0){
    	showMessage(EXCLAMATION , OK, "USER-1000","사은행사  브랜드 부담예정 현황정보가 없습니다.");
    	EM_S_EVENT_CD.Text = ""; 
    	LC_S_STR.focus();
        return;
    } else { 
    	getDetail();
    }
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 김성미 
 * 작 성 일 : 2011-03-21
 * 개    요 :  사은행사 정산 저장
 * return값 : void
 */
function btn_Save() {
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() { 
	    
    var ExcelTitle = "브랜드 부담예정 현황";
 
    var parameters = "점="+ LC_S_STR.ValueOfIndex("NAME", LC_S_STR.Index)
					+ "행사년월="   + EM_END_YM.Text
					+ "행사코드명="   + EM_S_EVENT_CD.Text;
				    
    //openExcel2(GD_PRSNTCAL, ExcelTitle, parameters, true );
    openExcel5(GD_PRSNTCAL, ExcelTitle, parameters, true , "",g_strPid );
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
 * getDetail()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-11-18
 * 개    요 : 하단 상세 조회
 * return값 : void
 */
function getDetail() {
    var row = DS_IO_MASTER.RowPosition;
     
    var strStrCd = DS_IO_MASTER.NameValue(row, "STR_CD");
    var strEventCd = DS_IO_MASTER.NameValue(row, "EVENT_CD"); 
    
    var goTo       = "getDetail";  
    var parameters =  "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strEventCd=" + encodeURIComponent(strEventCd) 
                   ; 
    
    TR_DETAIL.Action="/mss/mcae910.mc?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O 
    TR_DETAIL.Post();
    
    if (DS_IO_DETAIL.CountRow > 0) {
		 var irow = DS_IO_DETAIL.CountRow;
    	
		 var strPRSNT_AMT_B = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRSNT_AMT_B");       //지급금액
		 var strPB_APP_RATE = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PB_APP_RATE");   //브랜드부담율
		 
		 //인정금액 합계
		 var strMc_Amt = DS_IO_DETAIL.NameSum('MC_AMT',1,DS_IO_DETAIL.CountRow); 

		 var strMC_RATE = "";
		 
		 for(i=1; i<=DS_IO_DETAIL.CountRow; i++){ 
			 //비중 = (인정금액/인정금액합계) *100
			 DS_IO_DETAIL.NameValue(i, "MC_RATE") = (DS_IO_DETAIL.NameValue(i, "MC_AMT")/strMc_Amt)*100; 
			 
			 strMC_RATE = DS_IO_DETAIL.NameValue(i, "MC_RATE"); 
			 DS_IO_DETAIL.NameValue(i, "PRSNT_AMT") = strPRSNT_AMT_B * strMC_RATE /100;
		 }
		 
		 DS_IO_DETAIL.ResetStatus();
    }
    
    
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
    }
</script>

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>

<script	language=JavaScript	for=TR_DETAIL	event=onFail>
	trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------> 
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row,colid)>
	if(clickSORT) return;

	if(row != 0 && g_select==false) {
		getDetail();
	} 
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row,colid)> 

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
<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>    

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>    


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_PRSNTCAL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
	          <th width="80" class="point">점</th>
	          <td width="160">
	              <comment id="_NSID_">
                      <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=140 tabindex=1 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>
			   	  <th width="100" class="point">행사종료년월</th>
				  <td width="130"><comment id="_NSID_">
				  		<object id=EM_END_YM classid=<%=Util.CLSID_EMEDIT%> width="85" tabindex=1
					  		onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
					  	</object></comment><script>_ws_(_NSID_);</script><img
					  src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
					  onclick="javascript:openCal('M',EM_END_YM);" />
				  </td>
		          <th width="100" >행사코드/명</th> 
		          <td><comment id="_NSID_"> <object
                     id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>  
  <tr valign="top">
    <td width="100%"  class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height=18><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="sub_title">
              <img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>행사정보내역</td>                
          </tr>
        </table></td>
      </tr> 
      <tr>             
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_CARDCAL width=100% height=250 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_MASTER">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td width="100%" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr height=18>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="sub_title">
              <img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>상세내역</td>                
          </tr>
        </table></td>
      </tr>   
      <tr>           
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_PRSNTCAL width=100% height=500 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_DETAIL">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div> 
</body>
</html>

