<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급/취소 > 사은품지급내역조회(영수증별)
 * 작 성 일 : 2011.09.25
 * 작 성 자 : 하진영
 * 수 정 자 : 
 * 파 일 명 : MCAE4130.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.09.25 (하진영) 신규작성
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
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
 var top = 135;		//해당화면의 동적그리드top위치
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1();     
    //gridCreate2();
    
    // EMedit에 초기화
    //initEmEdit(EM_S_DATE,       "SYYYYMMDD",    PK);            //기간S
    //initEmEdit(EM_E_DATE,       "YYYYMMDD",     PK);            //기간E
    initEmEdit(EM_SALE_DATE,    "YYYYMMDD",         PK);            //기간 - 매출일
    initEmEdit(EM_POS_CD,       "NUMBER3^4",    NORMAL);        //POS코드
    initEmEdit(EM_POS_NM,       "GEN",          READ);          //POS명
    initEmEdit(EM_TRAN_NO,      "GEN^6",    NORMAL);        //POS코드
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점
     
    EM_SALE_DATE.Text         = getTodayFormat("YYYYMMDD");     //기간E
    
    getStore("DS_S_STR_CD", "Y", "1", "N");   //점(조회) 
    LC_S_STR_CD.Index = 0;
    LC_S_STR_CD.Focus();
}


function gridCreate1(){ 
    var hdrProperies ='<FC>id={currow}          name="NO"           width=50   align=center </FC>'
			        + '<FC>id=STR_CD            name="점"           width=100  align=center EDITSTYLE=LOOKUP   DATA="DS_S_STR_CD:CODE:NAME" show=false</FC>'
			        + '<FC>id=STR_NM            name="점명"         width=150  align=left   show=false </FC>'
			        + '<FC>id=SALE_DT           name="매출일"       width=100  align=center MASK="XXXX/XX/XX" show=true sumtext="합계" </FC>'
			        + '<FC>id=POS_NO            name="POS_NO"       width=80   align=center   show=true </FC>'
			        + '<FC>id=TRAN_NO           name="TRAN_NO"      width=80   align=center  show=true </FC>'
			        + '<C>id=EVENT_CD          name="행사코드"     width=100  align=left   show=true </C>'
			        + '<C>id=EVENT_NAME        name="행사명"       width=200  align=left   show=true </C>'
			        + '<C>id=SALE_AMT          name="인정매출액"   width=100  align=right            sumtext=@sum </C>'
			        + '<C>id=DIV_AMT           name="지급안분금액" width=100  align=right            sumtext=@sum </C>'
			        + '<C>id=PRSNT_DT          name="지급일"       width=100  align=center show=true  </C>'
			        + '<C>id=PRSNT_NO          name="지급번호"     width=100  align=center show=true  </C>'
			        + '<C>id=SEQ_NO            name="순번"         width=50   align=center show=true </C>'
			        + '<C>id=SKU_CD            name="단품코드"     width=150  align=center show=true  </C>'
                    + '<C>id=SKU_NAME          name="단품명"       width=200  align=left   show=true  </C>'
                    + '<C>id=BUY_COST_PRC      name="원가"         width=100  align=right            sumtext=@sum </C>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
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
    if( EM_SALE_DATE.TEXT == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "기준일");
        EM_DATE_DT.Focus();
        return;
    }
    
     
    // 조회조건 셋팅
    var strStrCd       = LC_S_STR_CD.BindColVal;
    var strSaledt      = EM_SALE_DATE.Text;
    var strPosno       = EM_POS_CD.Text;
    var strTranno      = EM_TRAN_NO.Text;
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd ="+ encodeURIComponent(strStrCd)
                   + "&strSaledt="+ encodeURIComponent(strSaledt)
                   + "&strPosno ="+ encodeURIComponent(strPosno)
                   + "&strTranno="+ encodeURIComponent(strTranno);
    
    TR_MAIN.Action="/mss/mcae413.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    g_select =true;
    TR_MAIN.Post();
    g_select = false;
    
    setPorcCount("SELECT", GD_MASTER);
    
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

/**
 * openPosPop()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-15, 2011-09-26
 * 개    요 : 포스팝업 오픈
 * return값 : void
 */
function openPosPop() {
   
     posNoPop(EM_POS_CD,EM_POS_NM,LC_S_STR_CD.BindColVal,"");
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

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>

<script language=JavaScript for=GD_DETAIL event=OnDblClick(row,colid)>
if(row == 0) return; 
openPop();
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 포스 조회 -->
<script language=JavaScript for=EM_POS_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_POS_CD.Text ==""){
    EM_POS_NM.Text = "";
       return;
   }

   if(EM_POS_CD.Text != null){
        if(EM_POS_CD.Text.length > 0){
            
            setPosNoNmWithoutPop("DS_O_RESULT", EM_POS_CD, EM_POS_NM , 1, LC_S_STR_CD.BindColVal, "");
            if(DS_O_RESULT.CountRow == 1){
                EM_POS_CD.Text = DS_O_RESULT.NameValue(1, "POS_NO");
                EM_POS_NM.Text = DS_O_RESULT.NameValue(1, "POS_NAME");
            }
        }
    } 
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
EM_POS_CD.Text = "";
EM_POS_NM.Text = ""; 
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
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
	          <th width="60" class="point">점</th>
	          <td width="120" >
	              <comment id="_NSID_">
                      <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1  height=100 width=120 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>   
	          </td>
	          <th width="60" class="point">매출일자</th>
	          <td width="100" > 
	              <comment id="_NSID_">
	                      <object id=EM_SALE_DATE classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
	                      </object>
	              </comment><script>_ws_(_NSID_);</script>
	              <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_SALE_DATE)" />
	              
	          </td>  
	          <th width="60" >POS_NO</th>
              <td>
                  <comment id="_NSID_">
                          <object id=EM_POS_CD classid=<%= Util.CLSID_EMEDIT %> width=60 tabindex=1 align="absmiddle">
                          </object>
			                  </comment><script>_ws_(_NSID_);</script>  
			                  <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:openPosPop();"  align="absmiddle"/>
			                  <comment id="_NSID_">
                          <object id=EM_POS_NM classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1 align="absmiddle"></object>
                  </comment><script>_ws_(_NSID_);</script>  
              </td>
          </tr>
          <tr>
                <!--   <tr>  -->
              <th>TRAN_NO</th>
              <td colspan="5" align="absmiddle">
                  <comment id="_NSID_">
                          <object id=EM_TRAN_NO classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1 align="absmiddle">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                        
              </td>
          
          
          <!--  </tr>  -->
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
                <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=760 classid=<%=Util.CLSID_GRID%>>
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

