<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급 > 사은행사지급내역(사원별)
 * 작 성 일 : 2011.09.24
 * 작 성 자 : 하진영
 * 수 정 자 : 
 * 파 일 명 : MCAE4120.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 사은행사지급내역에서 (사원별)로 분류하여 관리한다.
 * 이    력 :
 *            2011.09.24 하진영 - 신규개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

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
<script language="javascript" src="/<%=dir%>/js/common.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--


/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_select =false;
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
 var top = 100;		//해당화면의 동적그리드top위치
function doInit(){
	 
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');    
    //그리드 초기화
    gridCreate1();         
    
    // EMedit에 초기화
    initEmEdit(EM_S_DATE,       "SYYYYMMDD",    PK);            //기간S
    initEmEdit(EM_E_DATE,       "YYYYMMDD",     PK);            //기간E

    //콤보 초기화
     
    EM_E_DATE.Text          = getTodayFormat("YYYYMMDD");     //기간E
    
    EM_S_DATE.Focus();
}


function gridCreate1(){ 
    var hdrProperies ='<FC>id={currow}         name="NO"             width=40   align=center SubBgColor=#FFFFE0               </FC>'
			        + '<FC>id=MOD_ID           name="사번"           width=80  align=left    suppress="1"  SubBgColor=#FFFFE0 </FC>'
			        + '<FC>id=USER_CD          name="행사관"         width=100  align=left   suppress="1"   SubBgColor=#FFFFE0              </FC>' // // 20140304 강연식 추가 관별 합계
                    + '<FC>id=USER_NAME        name="사원명"         width=100  align=left   suppress="2"   SubBgColor=#FFFFE0              </FC>'
			        + '<C>id=EVENT_CD          name="행사코드"       width=100  align=center suppress="2"  SubBgColor=#FFFFE0 </C>'
                    + '<C>id=EVENT_NAME        name="행사명"         width=200  align=left   suppress="2"  SubBgColor=#FFFFE0              </C>'
                    + '<C>id=SKU_CD            name="단품코드"       width=100  align=center SubBgColor=#FFFFE0               </C>'
                    + '<C>id=SKU_NAME          name="단품명"         width=200  align=left   SubBgColor=#FFFFE0               </C>'
                    + '<C>id=PRICE             name="단가"           width=100  align=right  gte_columntype="number:0:true"  gte_Summarytype="number:0:true"	SubBgColor=#FFFFE0               </C>'
                    + '<C>id=NOR_PRSNT_QTY     name="정상지급"       width=80  align=right   gte_columntype="number:0:true"  gte_Summarytype="number:0:true" sumtext={subsum(NOR_PRSNT_QTY)}  subsumtext={subsum(NOR_PRSNT_QTY)}  SubBgColor=#FFFFE0   </C>'
                    + '<C>id=EXCP_PRSNT_QTY    name="예외지급"       width=80  align=right   gte_columntype="number:0:true"  gte_Summarytype="number:0:true" sumtext={subsum(EXCP_PRSNT_QTY)} subsumtext={subsum(EXCP_PRSNT_QTY)} SubBgColor=#FFFFE0   </C>'
                    + '<C>id=CAN_PRSNT_QTY     name="지급취소"       width=80  align=right   gte_columntype="number:0:true"  gte_Summarytype="number:0:true" sumtext={subsum(CAN_PRSNT_QTY)}  subsumtext={subsum(CAN_PRSNT_QTY)}  SubBgColor=#FFFFE0   </C>'
                    + '<C>id=PRSNT_QTY         name="실지급수량"     width=80  align=right   gte_columntype="number:0:true"  gte_Summarytype="number:0:true" sumtext={subsum(PRSNT_QTY)}      subsumtext={subsum(PRSNT_QTY)}      SubBgColor=#FFFFE0   </C>'
                    + '<C>id=PRSNT_AMT         name="실지급액"       width=100 align=right   gte_columntype="number:0:true"  gte_Summarytype="number:0:true" sumtext={subsum(PRSNT_AMT)}      subsumtext={subsum(PRSNT_AMT)}      SubBgColor=#FFFFE0   </C>'
                    + '<C>id=TOT_SALE_AMT      name="매출금액"       width=100 align=right   gte_columntype="number:0:true"  gte_Summarytype="number:0:true" sumtext={subsum(TOT_SALE_AMT)}   subsumtext={subsum(TOT_SALE_AMT)}   SubBgColor=#FFFFE0   </C>'
                    + '<C>id=PRSNT_CNT         name="5000원권수량"   width=100 align=right   gte_columntype="number:0:true"  gte_Summarytype="number:0:true" sumtext={subsum(PRSNT_AMT)/5000} subsumtext={subsum(PRSNT_AMT)/5000} SubBgColor=#FFFFE0   </C>';
                 // 20140304 강연식 5000원권수량 합계 추가
                    
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
    //DS_MASTER.SubSumExpr  = "2:SKU_CD, 1:EVENT_CD" ;
    DS_MASTER.SubSumExpr  = "2:EVENT_NAME, 1:USER_CD"; // 20140304 강연식 추가 관별 합계
    GD_MASTER.ColumnProp("EVENT_NAME", "subsumtext")    = "행사별 소계";
    GD_MASTER.ColumnProp("USER_NAME", "sumtext")        = "합계";
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if (EM_S_DATE.Text > EM_E_DATE.Text){ 
        showMessage(INFORMATION, OK, "USER-1008", "행사종료기간", "행사시작기간");
        EM_S_E_DT.Focus();
        return;
    }
     
    // 조회조건 셋팅
    var strSdt          = EM_S_DATE.Text;
    var strEdt          = EM_E_DATE.Text;
    
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strSdt="+ encodeURIComponent(strSdt)
                   + "&strEdt="+ encodeURIComponent(strEdt);
    TR_MAIN.Action="/mss/mcae412.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    //g_select =true;
    TR_MAIN.Post();
    //g_select = false;
    
    setPorcCount("SELECT", GD_MASTER);
    /*
    if(DS_MASTER.CountRow !=0) {
     //   getDetail();
    }
    else{ 
        DS_MASTER.ClearData();
        //DS_DETAIL.ClearData();
    } 
    */
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

    if(DS_MASTER.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }
      var strTitle = "사은행사지급내역(사원별)";

      var strSdt          = EM_S_DATE.Text;
      var strEdt          = EM_E_DATE.Text;
      
      var parameters = "일자(FROM) " + strSdt
                      +" 일자(TO)   " + strEdt;
      
     // GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
      openExcel2(GD_MASTER, strTitle, parameters, true );
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
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }    
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;    
</script>


<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

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
<!-- 
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
 -->
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- 공통 -->
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
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
              <th width="40" class="point">기간</th>
	          <td width="400" > 
	              <comment id="_NSID_">
	                      <object id=EM_S_DATE classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
	                      </object>
	              </comment><script>_ws_(_NSID_);</script>
	              <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DATE)" />
	              ~
	              <comment id="_NSID_">
                          <object id=EM_E_DATE classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DATE)" />
	          </td>  

          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>   
  <tr>
    <td class="dot"></td>
  </tr>   
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">                
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=486 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_MASTER">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  </table>
</DIV>
</body>
</html>

