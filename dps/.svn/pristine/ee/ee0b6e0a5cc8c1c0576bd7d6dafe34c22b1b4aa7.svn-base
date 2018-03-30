<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주결재 > 매입현황집계표
 * 작 성 일 : 2010.04.15
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord7010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매입현황집계표 
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
    request.setCharacterEncoding("utf-8");
%>
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var strToday        = "";                            // 현재날짜

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top  = 150;		//해당화면의 동적그리드top위치
 function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
     strToday        = getTodayDB("DS_O_RESULT")
     // Output Data Set Header 초기화
     DS_LIST.setDataHeader('<gauce:dataset name="H_LIST"/>');
     
     // 그리드 초기화
     gridCreate1(); //마스터
     
     //콤보 초기화
     initComboStyle(LC_O_STR,    DS_STR,           "CODE^0^30,NAME^0^80", 1, PK);              //조회용 점코드     

    getStore("DS_STR", "Y", "", "N");                                                          // 점        

    LC_O_STR.Index      = 0; 
    LC_O_STR.Focus();
   
    registerUsingDataset("pord701","DS_LIST");
 } 
 
function gridCreate1(){
     var hdrProperies = '<FC>id={currow}           name="NO"         width=30      edit=none align=center  </FC>'
    	              + '<FC>id=CHK                name="선택"       width=60                align=center  HeadCheckShow=true EditStyle=CheckBox </FC>'
                      + '<FC>id=STR_NM             name="점"         width=100     edit=none align=left    show=true</FC>'
                      + '<FC>id=VEN_CD             name="협력사"     width=70      edit=none align=center    show=true</FC>'
                      + '<FC>id=VEN_NAME           name="협력사명"   width=150     edit=none align=left    show=true</FC>'
                      + '<FC>id=PUMBUN_CD          name="브랜드"     width=70      edit=none align=center    show=true</FC>'
                      + '<FC>id=PUMBUN_NM          name="브랜드명"   width=150     edit=none align=left    show=true</FC>'
                      + '<FC>id=PUMMOK_NM          name="품목"       width=80      edit=none align=left    show=true</FC>'
                      + '<FC>id=PRINT_CD           name="발행코드"   width=150     edit=none align=center  show=true</FC>'
                      + '<FC>id=PRINT_CNT          name="발행매수"   width=80                align=right   show=true</FC>'
                      ;

     initGridStyle(GR_MASTER, "common", hdrProperies, true);     
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
//      if(checkValidation("Search")){
//      }

     getList();
     // 조회결과 Return
     setPorcCount("SELECT", GR_MASTER);
     if(DS_LIST.CountRow <= 0)
    	LC_O_STR.Focus();
}

/**
 * btn_New()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {  
    
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-10
 * 개    요    : 삭제버튼 클릭 (신규등록일 경우 DS_IO_MASTER 삭제, 기존데이터일 경우 삭제 Action실행)
 * return값 : void
 */
function btn_Delete() {
    
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
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

	/* 값체크 시작 */
	var nChkCnt      = 0
	var nChkPrintCnt = 0;

	for(var i=1; i<=DS_LIST.CountRow; i++){
		if(DS_LIST.NameValue(i, "CHK") == "T"){
			
			nChkPrintCnt = DS_LIST.NameValue(i, "PRINT_CNT");
			
// 			alert("nChkPrintCnt = " + nChkPrintCnt);
			if(nChkPrintCnt == 0){
			    showMessage(EXCLAMATION, OK, "USER-1000", "매수를 입력하세요.");
			    DS_LIST.SetColumn("PRINT_CNT");  
			    DS_LIST.RowPosition = i;  
				return;
			}
			nChkCnt++
		}
	}
	
// 	alert("nChkCnt = " + nChkCnt);
	
	if(nChkCnt == 0){
	    showMessage(EXCLAMATION, OK, "USER-1000", "선택 된 데이터가 없습니다.");
		return;
	}
	/* 값체크 종료 */
    
// 	return;
	 
	var strChk = "";
	var nCount  = 0;
	
	var arrLines1   = new Array();
	var arrLines2   = new Array();
	var arrLines3   = new Array();
	var arrLines4   = new Array();
	var arrCnts     = new Array();
	var strChkDigit = "";

	for(var i=1; i<=DS_LIST.CountRow; i++){
		strChk = DS_LIST.NameValue(i, "CHK");
		
		if(strChk == "F") continue;

		arrLines1[nCount] = DS_LIST.NameValue(i, "STR_NM");
		arrLines2[nCount] = DS_LIST.NameValue(i, "PUMBUN_NM");
		arrLines3[nCount] = DS_LIST.NameValue(i, "PUMMOK_NM");
		strChkDigit       = getSkuCdCheckSum(DS_LIST.NameValue(i, "PRINT_CD"));
		arrLines4[nCount] = DS_LIST.NameValue(i, "PRINT_CD") + "" + strChkDigit;
		arrCnts[nCount]   = DS_LIST.NameValue(i, "PRINT_CNT");

        if(arrCnts[nCount] % 2 == 0){
            arrCnts[nCount] = arrCnts[nCount] / 2;
        }else{
            arrCnts[nCount] = (arrCnts[nCount] + 1) / 2;
        }
        
		nCount++;
		DS_LIST.NameValue(i, "CHK") = "F";
	}

// 	alert("arrLines1 = " + arrLines1);
// 	alert("arrLines2 = " + arrLines2);
// 	alert("arrLines3 = " + arrLines3);
// 	alert("arrLines4 = " + arrLines4);
// 	alert("arrCnts   = " + arrCnts);

	// 출력 모듈 호출
   gfnToshibaTegPrint_pbnpmk(arrLines1, arrLines2, arrLines3, arrLines4, arrCnts);
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
 * getList()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-15
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getList(){
     
    // 조회조건 셋팅
    var strStrCd         = LC_O_STR.BindColVal;        //점
    
    var goTo        = "getList" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="		+encodeURIComponent(strStrCd)     
                    ; 
    TR_L_MAIN.Action="/dps/pord701.po?goTo="+goTo+parameters;  
    TR_L_MAIN.KeyValue="SERVLET("+action+":DS_LIST=DS_LIST)"; //조회는 O
    TR_L_MAIN.Post();   
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
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_IO_MASTER============================ -->
<!-- Grid DS_IO_MASTER 변경시 DS_LIST의 마스터 내용 변경 -->

<!--  ===================DS_IO_MASTER============================ -->

<script language=JavaScript for=DS_LIST event=CanRowPosChange(row)>

</script>

<script language=JavaScript for=DS_LIST event=onRowPosChanged(row)>

</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
</script>
<script language=JavaScript for=DS_IO_MASTER event=onRowPosChanged(row)>
</script>

<script language=JavaScript for=DS_LIST event=OnColumnChanged(row,colid)>

if(colid == "PRINT_CNT"){
	var nPrintCnt = DS_LIST.NameValue(row, "PRINT_CNT");
	if(nPrintCnt == 0){
		DS_LIST.NameValue(row, "CHK") = "F";
	}else{
		DS_LIST.NameValue(row, "CHK") = "T";
	}
}

</script>
<!--  ===================DS_LIST============================ -->
<!--  DS_LIST 변경시 -->
<script language=JavaScript for=DS_LIST
    event=OnColumnChanged(row,colid)>

</script>

<!-- 디테일 삭제시 컴퍼넌트 총금액-->
<script language=JavaScript for=DS_LIST event=OnRowDeleted(row)>   
 
</script>


<!-- GR_MASTER CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_MASTER event=CanColumnPosChange(Row,Colid)>

</script>

<!-- 디테일 선택시 전체 선택/해제 -->
<script language=JavaScript for=GR_MASTER
    event="OnHeadCheckClick(Col,Colid,bCheck)">       
    if (Colid == "CHK") {
        if (bCheck == 1) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHK") = "T";
            }    
            GR_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GR_MASTER.Redraw = false;
            for (var i = 0; i < DS_LIST.CountRow; i++)
            {
                DS_LIST.NameValue(i + 1, "CHK") = "F";
            }
            GR_MASTER.Redraw = true;
            DS_LIST.ResetStatus();
        }
    }
</script>

<!--  ===================GR_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); 
</script>



<!--*************************************************************************-->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

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
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DEPT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_TEAM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PC" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_GJDATE_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PROC_STAT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_LIST" classid=<%=Util.CLSID_DATASET%>>
    <Param Name="SubsumExpr" VALUE="3:SALE_ORG_BM,2:SALE_ORG_TEAM,1:SALE_ORG_PC">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_L_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>


<!-- 택발행 OCX  -->  
<comment id="_NSID_">
	<OBJECT classid="clsid:E76C9051-A8C4-458E-9F60-3C14DB9EECF9"
            CODEBASE="/<%=dir%>/ocx/TEC_dol.cab#version=1,0,0,0"
		    name="TEC_DO1" id="TEC_DO1" width=0 height=0 hspace=0 vspace=0>
		<PARAM Name="PrinterName" Value="TEC B-SX5T (305 dpi)"> 
	</OBJECT>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
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
<!--* E. 본문시작        *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

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
                        <th class="point" width="100">점</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_O_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=100 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script>
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
    <tr valign="top">
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td><comment id="_NSID_"> <OBJECT id=GR_MASTER
                            width=100% height=750 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID"     value="DS_LIST">
                        </OBJECT> </comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</div>
<body>
</html>

