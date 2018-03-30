<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품재고관리 > 사은품 LOSS등록
 * 작 성 일 : 2011.04.29
 * 작 성 자 : 김정민
 * 수 정 자 : 
 * 파 일 명 : MCAE5020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.04.29 (김정민) 신규작성
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
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var strSaveFlag = false;

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
 var top = 130;		//해당화면의 동적그리드top위치
function doInit() {

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	// Input Data Set Header 초기화
   DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');

	// Output Data Set Header 초기화

	//그리드 초기화
	gridCreate1(); //마스터

	// EMedit에 초기화    
	initEmEdit(EM_S_EVENT_CD, "NUMBER3^11^0", PK); //행사코드
	initEmEdit(EM_S_EVENT_NAME, "GEN^40", READ); //행사명
	initEmEdit(EM_SALE_DT, "YYYYMMDD", READ); //LOSS등록일자   
    initEmEdit(EM_DATE, "YYYYMMDD", PK); //일자

	//콤보 초기화
	initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30,NAME^0^80", 1, PK); //점

    EM_SALE_DT.Text          = getTodayFormat("YYYYMMDD");     //LOSS등록일자
    EM_DATE.Text          = getTodayFormat("YYYYMMDD");     //일자(조회)
	 // 공통에서 가져오기
    getStore("DS_STR_CD", "Y", "1", "N");   //점(조회)//점(조회) 
    LC_STR_CD.Index = 0;
    LC_STR_CD.Focus();
}

function gridCreate1() {
	var hdrProperies = '<FC>id={currow}    name="NO"          width=30    align=center EDIT=NONE </FC>'
	        + '<FC>id=EVENT_CD             name="행사코드"     width=70    align=center  Show=false EDIT=NONE </FC>'
			+ '<FC>id=EVENT_NAME           name="행사명"       width=130    align=LEFT EDIT=NONE </FC>' 
			+ '<FC>id=SKU_CD               name="사은품코드"    width=80   align=center   Show=false EDIT=NONE </FC>'
			+ '<FC>id=SKU_NAME             name="사은품명"     width=100    align=LEFT EDIT=NONE SumText="합계"   </FC>'
               + '<FC>id=BUY_COST_PRC      name="단가"        width=50    align=RIGHT EDIT=NONE  </FC>'
			+ '<FC>id=IN_QTY               name="입고"        width=50    align=RIGHT EDIT=NONE sumtext=@sum </FC>'
			+ '<FC>id=RFD_QTY              name="반품"        width=50    align=RIGHT EDIT=NONE sumtext=@sum </FC>'
			+ '<FG>id=STR_CD               name="지급"        width=70    align=center'
			+ '<FC>id=PRSNT_QTY            name="정상지급"     width=60    align=RIGHT EDIT=NONE sumtext=@sum </FC>'
			+ '<FC>id=EXCP_PRSNT_QTY       name="예외지급"     width=60    align=RIGHT EDIT=NONE sumtext=@sum </FC>'
			+ '<FC>id=ETC_PRSNT            name="기타지급"     width=60    align=RIGHT EDIT=NONE sumtext=@sum </FC></FG>'
			+ '<FG>id=STR_NAME             name="지급취소"     width=90    align=center'
			+ '<FC>id=RECOVERY_QTY         name="정상취소"     width=80    align=RIGHT EDIT=NONE sumtext=@sum </FC>'
			+ '<FC>id=POS_NDRAWL_CAN_QTY   name="미회수취소"   width=80    align=RIGHT EDIT=NONE sumtext=@sum </FC></FG>'
			+ '<FC>id=ALLQTY               name="총지급"      width=70    align=RIGHT EDIT=NONE sumtext=@sum </FC>'
            + '<FC>id=LOSSQTY              name="LOSS"       width=60    align=RIGHT EDIT=NONE sumtext=@sum </FC>'
			+ '<FC>id=QTY                  name="현재고"      width=60    align=RIGHT EDIT=NONE sumtext=@sum </FC>'
			+ '<FC>id=SRVY_QTY             name="실사재고"     width=50   align=RIGHT EDIT=Numeric sumtext=@sum </FC>'
			+ '<FG>id=STR_CD               name="LOSS"       width=70   align=center'
			+ '<FC>id=LOSS_QTY             name="수량"        width=60   align=RIGHT EDIT=NONE sumtext=@sum </FC>'
			+ '<FC>id=LOSS_AMT             name="금액"        width=80   align=RIGHT EDIT=NONE sumtext=@sum </FC></FG>'
			+ '<FC>id=FLAG        name="선택"       width=50   align=center   EditStyle=CheckBox  HeadCheckShow=true </FC>';
            
	initGridStyle(GD_MASTER, "common", hdrProperies, true);
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

    EM_SALE_DT.Text = EM_DATE.Text;
    // 조회조건 셋팅
    var strStrCd        = LC_STR_CD.BindColVal;
    var strEventCd      = EM_S_EVENT_CD.Text; 
    var strDate         = EM_DATE.Text; 
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strEventCd="+ encodeURIComponent(strEventCd)
                   + "&strDate="   + encodeURIComponent(strDate);
    TR_MAIN.Action="/mss/mcae502.mc?goTo="+goTo+parameters;  
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
	if (!DS_MASTER.IsUpdated){
        showMessage(StopSign, OK, "USER-1028");
        return;
    }
	var strCnt=0; 
	for(var i=1; i<=DS_MASTER.Countrow; i++) {
		if(DS_MASTER.NameValue(i,"FLAG")== "T") {
		//	alert(strCnt);
			strCnt = strCnt+1;
		}
	}
	
	if(strCnt==0) {
	   showMessage(INFORMATION, OK, "USER-1000", "선택된 항목이 없습니다. 선택 후 저장하세요"); 
       return; 
	}
	var strStrCd    = LC_STR_CD.BindColVal;  // 점
    var strEventCd  = EM_S_EVENT_CD.Text;    // 행사코드
    var strSaleDt   = EM_SALE_DT.Text;       // LOSS등록일자
    
    getEventMagam();
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
        GD_DETAIL.Focus();
        return;
    } 
    
    strSaveFlag = true;
    var goTo = "save";
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strEventCd=" + encodeURIComponent(strEventCd)
                   + "&strSaleDt="  + encodeURIComponent(strSaleDt);
    TR_MAIN.Action = "/mss/mcae502.mc?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_MASTER=DS_MASTER)";
    TR_MAIN.Post();
   
    DS_MASTER.ClearData();
    btn_Search();
    strSaveFlag = false;

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
  * getEventMagam()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-25
  * 개    요 : 사은품 마감 체크
  * return값 : void
  */
 function getEventMagam() {
     var strEventCd = EM_S_EVENT_CD.Text;        // 행사코드
         
     var goTo = "getEventMagam";
     var action = "O";
     var parameters = "&strEventCd=" + encodeURIComponent(strEventCd);
     TR_MAIN.Action = "/mss/mcae502.mc?goTo=" + goTo + parameters;
     TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_RETURN=DS_O_RETURN)";
     TR_MAIN.Post();
   //  alert();
     if(DS_O_RETURN.NameValue(DS_O_RETURN.RowPosition,"CONF_FLAG") == "1") { 
         showMessage(INFORMATION, OK, "USER-1000", "사은품 행사가 확정된 행사코드 입니다.");
         //EM_I_EVENT_CD.Text = ""; 
         //setTimeout(" EM_I_EVENT_CD.Focus();",50);
         return;
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

<!-- 조회 후 DETAIL 수정 후 MASTER 클릭시 이벤트 발생  -->
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)> 
/*if (!strSaveFlag) {
    if (DS_MASTER.CountRow > 0) {
        if (DS_MASTER.RowStatus(row) == 1) { // 신규행작성시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
            	DS_MASTER.DeleteRow(row);
                return true;    
            } else {
                return false;   
            }
        } else if (DS_MASTER.RowStatus(row) == 3) { //데이터 변경시
            var ret = showMessage(Question, YesNo, "USER-1049");
            if (ret == "1") {
                rollBackRowData(DS_MASTER, row);
                return true;    
            } else {
                return false;   
            }
        }
        return true;
    }
    return true;
}*/
</script>

<!-- Grid 실사재고 입력시 LOSS수량&금액 계산 -->
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
if(colid == "SRVY_QTY"){  
	DS_MASTER.NameValue(DS_MASTER.RowPosition,"LOSS_QTY") = DS_MASTER.NameValue(DS_MASTER.RowPosition,"QTY") - DS_MASTER.NameValue(DS_MASTER.RowPosition,"SRVY_QTY");
    DS_MASTER.NameValue(DS_MASTER.RowPosition,"LOSS_AMT") = DS_MASTER.NameValue(DS_MASTER.RowPosition,"BUY_COST_PRC") * DS_MASTER.NameValue(DS_MASTER.RowPosition,"LOSS_QTY");
    DS_MASTER.NameValue(DS_MASTER.RowPosition,"FLAG") = "T";
} 
</script>
 
<script language=javascript  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
//헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_MASTER.CountRow; i++){ 
            DS_MASTER.NameValue(i, "FLAG") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_MASTER.CountRow; i++){
            DS_MASTER.NameValue(i, "FLAG") = 'F';
        }
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
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
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 공통 -->  
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment> 
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RETURN" classid=<%=Util.CLSID_DATASET%>></object>
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

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="60" class="point">점</th>
						<td width="130"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100  tabindex=1 
							width=120 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			class="s_table">
			<tr>
				<th width="80">LOSS등록일자</th>
				<td>  
				<comment id="_NSID_">
                        <object id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%>   width=117 tabindex=1 
                         onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
                        </object>
                         </comment><script>_ws_(_NSID_);</script>
                     </td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr height=5>
		<td></td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PL05">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td><comment id="_NSID_"><OBJECT id=GD_MASTER
									width=100% height=750 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_MASTER">
								</OBJECT></comment><script>
	_ws_(_NSID_);
</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</DIV>
</body>
</html>

