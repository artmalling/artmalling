<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품재고관리 > 사은품 일수불 조회
 * 작 성 일 : 2011.01.19
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE5030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.19 (김슬기) 신규작성
 *        2011.05.03 (김정민) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<%
    request.setCharacterEncoding("utf-8");
%>

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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
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
 var top = 115;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
 // EMedit에 초기화    
    initEmEdit(EM_S_EVENT_CD, "NUMBER3^11^0", PK); //행사코드
    initEmEdit(EM_S_EVENT_NAME, "GEN^40", READ); //행사명

    initEmEdit(EM_DATE, "YYYYMMDD", PK); //일자

    //콤보 초기화
    initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30,NAME^0^80", 1, PK); //점


    EM_DATE.Text          = getTodayFormat("YYYYMMDD");     //일자(조회)
     // 공통에서 가져오기
    getStore("DS_STR_CD", "Y", "1", "N");   //점(조회) 
    LC_STR_CD.Index = 0;
    LC_STR_CD.Focus();
} 

function gridCreate1(){
    var hdrProperies ='<FC>id={currow}              name="NO"              width=30   align=center</FC>'
                    + '<FC>id=EVENT_CD              name="행사명"           width=140   align=center Show=false</FC>'
			        + '<FC>id=EVENT_NAME            name="행사명"           width=140   align=left </FC>'
			        + '<FC>id=SKU_GB                name="사은품구분"        width=80   align=center EDITSTYLE=COMBO   DATA="1:물품,2:상품권"  </FC>'
                    + '<FC>id=SKU_CD                name="사은품코드"        width=120   align=center</FC>'
                    + '<FC>id=SKU_NAME              name="사은품명"          width=90   align=left SumText="합계"  </FC>'
                    + '<FC>id=IN_QTY                name="입고"             width=80   align=right sumtext=@sum </FC>'
                    + '<FC>id=RFD_QTY               name="반품"             width=80   align=right sumtext=@sum </FC>'
                    + '<FG>id=STR_CD                name="지급"             width=80   align=center'
                    + '<FC>id=PRSNT_QTY             name="정상지급"          width=80   align=right sumtext=@sum </FC>'
                    + '<FC>id=EXCP_PRSNT_QTY        name="사후지급"          width=80   align=right sumtext=@sum </FC>'
                    + '<FC>id=ETC_PRSNT             name="기타지급"          width=80   align=right sumtext=@sum </FC></FG>'
                    + '<FG>id=STR_NAME              name="취소"             width=90   align=center'
                    + '<FC>id=RECOVERY_QTY          name="정상+사후"          width=80   align=right sumtext=@sum </FC>'
                    + '<FC>id=POS_NDRAWL_CAN_QTY    name="미회수취소"        width=80   align=right sumtext=@sum  show=false  </FC></FG>'
                    + '<FC>id=NQTY                  name="누적지급"          width=80   align=right sumtext=@sum </FC>'
                    + '<FC>id=DQTY                  name="당일지급"          width=80   align=right sumtext=@sum </FC>'
                    + '<FC>id=INFRR_QTY             name="불량"             width=60   align=right sumtext=@sum </FC>'
                    + '<FC>id=LOSS_QTY              name="LOSS"            width=60   align=right sumtext=@sum </FC>'
                    + '<FC>id=QTY                   name="현재고"           width=60   align=right sumtext=@sum </FC>';
                     
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

    if(LC_STR_CD.BindColVal == "") {
       showMessage(INFORMATION, OK, "USER-1000", "점을 선택해 주세요");
       setTimeout("LC_STR_CD.Focus();",50);
       return; 
    }
    
    if(EM_S_EVENT_CD.Text == ""){
       showMessage(INFORMATION, OK, "USER-1000", "행사코드를 입력해 주세요");
       setTimeout("EM_S_EVENT_CD.Focus();",50);
       return; 
    }
    
    if(EM_DATE.Text == "") {
           showMessage(INFORMATION, OK, "USER-1000", "일자를 입력해 주세요");
           setTimeout("EM_DATE.Focus();",50);
           return; 
        }
     
    // 조회조건 셋팅
    var strStrCd        = LC_STR_CD.BindColVal;
    var strEventCd      = EM_S_EVENT_CD.Text; 
    var strDate         = EM_DATE.Text; 
    var strAQ           = RD_S_AQ.CodeValue; 
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strEventCd="+ encodeURIComponent(strEventCd)
                   + "&strDate="   + encodeURIComponent(strDate)
                   + "&strAQ="     + encodeURIComponent(strAQ);
    TR_MAIN.Action="/mss/mcae503.mc?goTo="+goTo+parameters;  
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
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }    
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------> 

<!-- 구분에 따른 조회기준 변경 -->
<script language=JavaScript for=RD_S_AQ event=OnSelChange()>
    btn_Search();
</script>

<script language=JavaScript for=EM_S_EVENT_CD event=onKillFocus()>
  //  if (EM_O_EVENT_CD.Text.length > 0 ) { 
      if(!this.Modified)
                return;
                
            if(this.text==''){
                EM_S_EVENT_NAME.Text = "";
                return;
            }
         
            if(LC_STR_CD.BindColVal == "%"){
                showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
                LC_STR_CD.Focus();
                return;
            }
        
        setMssEvtNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NAME, '', '', 'Y', LC_STR_CD.BindColVal);
        if (DS_O_RESULT.CountRow == 1 ) {  
            EM_S_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
            EM_S_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출 
            mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,'','','Y',LC_STR_CD.BindColVal, '', ''); 
        }
  //  }  
     
</script>

<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    EM_S_EVENT_CD.Text = "";
    EM_S_EVENT_NAME.Text = "";
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
<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
	          <th width="60" class="point">점</th>
               <td width="100"><comment id="_NSID_"> <object
                   id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100  tabindex=1 
                   width=100 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
               </td>
               <th width="80" class="point">행사코드</th>
               <td width="250"><comment id="_NSID_"> <object id=EM_S_EVENT_CD
                   classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
                   align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
                   src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                   class="PR03"
                   onclick="javascript:mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,'','','Y',LC_STR_CD.BindColVal, '', '');"
                   id=popEventS /> <comment id="_NSID_"> <object
                   id=EM_S_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=120
                   tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
               </td>
               <th width="80" class="point">일자</th>
               <td>  
                   <comment id="_NSID_">
                           <object id=EM_DATE classid=<%=Util.CLSID_EMEDIT%>   width=90 tabindex=1 
                            onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
                           </object>
                            </comment><script>_ws_(_NSID_);</script>
                           <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_DATE)" align="absmiddle" />
               </td>    
          </tr> 
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="right"><comment id="_NSID_"> <object
                   id=RD_S_AQ classid=<%=Util.CLSID_RADIO%>
                   style="height: 20; width: 103" tabindex=1> 
                   <param name=Cols value="2">
                   <param name=Format value="1^수량,2^금액">
                   <param name=CodeValue value="1">
                   <param name=AutoMargin  value="true">
               </object> </comment> <script> _ws_(_NSID_);</script></td> 
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr>
                <td>
		            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=770 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_MASTER">
                    </OBJECT></comment><script>_ws_(_NSID_);</script>
		        </td>  
	          </tr>
	        </table></td>
	      </tr>
	    </table></td>
	  </tr>
	</table></td>
  </tr>
</table>
</DIV>
</body>
</html>

