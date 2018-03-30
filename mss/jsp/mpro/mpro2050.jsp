<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 경영관리 > 약속관리 > 약속분석 
 * 작 성 일 : 2011.03.10
 * 작 성 자 : 오형규
 * 수 정 자 : 
 * 파 일 명 : mpro2050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 해피콜미이행조회
 * 이    력 :
 *        
          2011.03.10 오형규(프로그램 작성) 
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
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");    
	String userid = sessionInfo.getUSER_ID();  
    String dir = BaseProperty.get("context.common.dir");
    
 // PID 확인을 위한
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
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
var userid = '<%=userid%>';
var g_strPid           = "<%=pageName%>";                 // PID

<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-10
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');//조직
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_SALE_S_DT, "SYYYYMMDD", PK);          //기간 시작일
    initEmEdit(EM_SALE_E_DT, "TODAY", PK);          //기간 종료일

    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);     //점(조회)
    
    getStore("DS_O_STR_CD", "Y", "1", "Y");            //점코드
    
    LC_O_STR_CD.Index = 0;
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"              width=30   align=center SubBgColor=#99FFCC</FC>'
                     + '<FC>id=STRNM            name="점"              SubSumText="점별소계" SumText="총합계" width=70   align=left SubBgColor=#99FFCC</FC>'
                     + '<FC>id=PROM_TYPE_NM     name="약속유형"        width=120  align=left SubBgColor=#99FFCC</FC>'
                     + '<FG>                    name="인도방식"        width=120'       
                     + '<FC>id=DELI_RECEIVE     name="내방"            width=60    sumtext={subsum(DELI_RECEIVE)}  SubBgColor=#99FFCC align=rigth</FC>'
                     + '<FC>id=DELI_CALL        name="수령"            width=60    sumtext={subsum(DELI_CALL)} SubBgColor=#99FFCC  align=rigth</FC>'
                     + '</FG>'
                     + '<FG>                    name="해피콜 이행상태"  width=100'   
                     + '<FC>id=HAPPYOK          name="이행"            width=60     sumtext={subsum(HAPPYOK)} SubBgColor=#99FFCC align=rigth</FC>'
                     + '<FC>id=HAPPYNO          name="미이행"          width=60    COLOR={IF(HAPPYNO > 0, "RED", "BLACK")} sumtext={subsum(HAPPYNO)} SubBgColor=#99FFCC  align=rigth</FC>'
                     + '</FG>'
                     + '<FC>id=CNT1             name="총건수"          width=60    sumtext={subsum(CNT1)} SubBgColor=#99FFCC  align=rigth</FC>'
                     + '<FG>                    name="미이행경과일"     width=120'       
                     + '<FC>id=DAY01            name="0~1일"             width=50     sumtext={subsum(DAY01)} SubBgColor=#99FFCC  align=rigth</FC>'
                     + '<FC>id=DAY02            name="2일"             width=50     sumtext={subsum(DAY02)} SubBgColor=#99FFCC  align=rigth</FC>'
                     + '<FC>id=DAY03            name="3일"             width=50     sumtext={subsum(DAY03)} SubBgColor=#99FFCC  align=rigth</FC>'
                     + '<FC>id=DAY04            name="4일이상"         width=50     sumtext={subsum(DAY04)} SubBgColor=#99FFCC  align=rigth</FC>'
                     + '</FG>'
                     + '<FC>id=CNT2             name="총건수"          width=60    sumtext={subsum(CNT2)} SubBgColor=#99FFCC  align=rigth</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
    DS_O_MASTER.SubsumExpr = "STRNM";
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
 * 작 성 일 : 2011-03-10
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     
     if( EM_SALE_S_DT.Text.length == 0 ){
         showMessage(STOPSIGN, OK, "USER-1001", "기간 시작일");
         EM_SALE_S_DT.Foucs();
         return;
     }
     if( EM_SALE_E_DT.Text.length == 0 ){
         showMessage(STOPSIGN, OK, "USER-1001", "기간 종료일");
         EM_SALE_E_DT.Foucs();
         return;
     }
     
     var sDate = (trim(EM_SALE_S_DT.Text)).replace(' ','');
     var eDate = (trim(EM_SALE_E_DT.Text)).replace(' ', '');
     
     if( sDate > eDate ){
         showMessage(STOPSIGN, OK, "USER-1015");
         EM_SALE_S_DT.Focus();
         return;
     }
     
     
     getSearch();
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
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : 오형규
 * 작 성 일 : 2011-03-10
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
     
     var ExcelTitle = "해피콜미이행조회"
         
     var excel_strCd = LC_O_STR_CD.Text;
     var excel_sDate = EM_SALE_S_DT.Text;
     var excel_eDate = EM_SALE_E_DT.Text;
     
     var parameters = "점=" + excel_strCd
                    + " - 기간=" + excel_sDate + "~" + excel_eDate;
     
     //openExcel2(GD_MASTER, ExcelTitle, parameters, true );
     openExcel5(GD_MASTER, ExcelTitle, parameters, true , "",g_strPid );

     GD_MASTER.Focus();
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
  * getSearch()
  * 작 성 자 : 오형규
  * 작 성 일 : 2011-03-10
  * 개    요 : master 조회
  * return값 : void
  */
  
function getSearch(){
    
    var strCd = LC_O_STR_CD.BindColVal;
    var em_sDate = EM_SALE_S_DT.Text;
    var em_eDate = EM_SALE_E_DT.Text;
    
    var goTo = "getMaster"
    var paraments = "&strCd="    + encodeURIComponent(strCd)
                  + "&em_sDate=" + encodeURIComponent(em_sDate)
                  + "&em_eDate=" + encodeURIComponent(em_eDate);    
    
    TR_MAIN.Action = "/mss/mpro205.mp?goTo=" + goTo + paraments + "&userid=" + encodeURIComponent(userid);
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";//조회:O 입력:I
    TR_MAIN.Post();
    
    setPorcCount("SELECT", GD_MASTER);
        
}
 
function getDetailPopup(row){
	
	var happyNo =  DS_O_MASTER.NameValue(row, "HAPPYNO");
	
	if( Number(happyNo) > 0  ){
		
        
		var strCd = DS_O_MASTER.NameValue(row, "STR_CD");
		var takeDt = DS_O_MASTER.NameValue(row, "TAKE_DT");
		
		var arrArg  = new Array();
		arrArg.push(strCd);
		arrArg.push(takeDt);
		arrArg.push(userid);
		
		var returnVal= window.showModalDialog("/mss/mpro205.mp?goTo=listDtl",
			           arrArg,
	                   "dialogWidth:850px;dialogHeight:710px;scroll:no;" +
	                   "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	}else {
		return;
	}
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 해피콜 미이행 조회  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    
    if(row < 1){        
        sortColId( eval(this.DataID), row, colid);   
    }else {
    	
    	if( colid == "HAPPYNO" ){
    		 		
    		if( GD_MASTER.VirtualString2(row,"STRNM",0) != "점별소계" ){    			
    			getDetailPopup(row);
    		}else {
    			return;
    		}
    	}
    	
    }
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

if(clickSORT) return;

</script>


<script language=JavaScript for=EM_SALE_S_DT event=onKillFocus()>
    //[조회용]시작일 체크
   
    checkDateTypeYMD( EM_SALE_S_DT );

</script>

<script language=JavaScript for=EM_SALE_E_DT event=onKillFocus()>
    //[조회용]종료일 체크
   
    checkDateTypeYMD( EM_SALE_E_DT );

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
<comment id="_NSID_"><object id=DS_I_CONDITION  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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


<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
          <!-- search start -->
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="100">점</th>
                <td width="140">
                        <comment id="_NSID_">
                            <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
    
                </td>
                <th width="100" class="POINT">접수일</th>
                <td>
                      <comment id="_NSID_">
                          <object id=EM_SALE_S_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_S_DT)" align="absmiddle"/>
                      ~
                      <comment id="_NSID_">
                          <object id=EM_SALE_E_DT classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_E_DT)" align="absmiddle"/>
                </td>
                
          </table>
        </td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"  ></td>
  </tr> 
  <tr>
    <td class="red FS11 spec_1 " align="right"">
      <img src='/<%=dir%>/imgs/comm/square_red.gif' align=absmiddle hspace='2'>        
                붉은 색으로 표시된 미이행 내역을 클릭하시면 상세내역을 보실수 있습니다.
    </td>
  </tr>
  <tr valign="top">    
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
          <tr>
            <td width="100%">
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=493 classid=<%=Util.CLSID_GRID%> tabindex=1 >
                <param name="DataID" value="DS_O_MASTER">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>
