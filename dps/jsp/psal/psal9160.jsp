<!-- 
/*******************************************************************************
 * 시스템명 : 타사카드  > 청구관리 > 청구대상 데이터 마감
 * 작  성  일  : 2010.05.31
 * 작  성  자  : 
 * 수  정  자  : 
 * 파  일  명  : psal9160.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.05.31 (김영진) 신규작성
 *           2011.07.28 fkl 수정
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var strExlParam = "";
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday = '<%=Util.getToday("yyyyMMdd")%>'
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.05.31
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input, Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_RESULT.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    //EMedit에 초기화
    initEmEdit(EM_RCV_DT,    "TODAY",               NORMAL);  

    initComboStyle(LC_STR_CD,   DS_STR_CD,   "CODE^0^30,NAME^0^80", 1, PK);

    getStore("DS_STR_CD", "Y", "", "N");

    //초기값설정
    setComboData(LC_STR_CD,  DS_STR_CD.NameValue(0, "CODE"));    

    //showMaster();
}

function gridCreate1(){
    var hdrProperies    = '<FC>id={currow}     name="NO"           width=30   edit=none  align=center</FC>'
    	                + '<FC>id=CHECK1       name="선택"         width=40    align=center   HeadCheckShow=false EditStyle=CheckBox  edit=true</FC>'
    	                + '<FC>id=SALE_DT      name="매출일자"     width=80  edit=none  align=center    mask="XXXX-XX-XX"</FC>'
    	                + '<FC>id=WORK_FLAG    name="작업구분"     width=60  edit=none  align=center  </FC>'
                        + '<FC>id=CARD_NO      name="카드번호"     width=165  edit=none  align=center   mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                        + '<FC>id=EXP_DT       name="유효기간"     width=60  edit=none  align=center   mask="XX/XX"</FC>'
                        + '<FC>id=DIV_MONTH    name="할부개월"     width=60  edit=none  align=center</FC>'                        
                        + '<FC>id=APPR_AMT     name="승인금액"     width=80  edit=none  align=right</FC>'
                        + '<FC>id=SVC_AMT      name="봉사료"       width=80  edit=none  align=right</FC>'
                        + '<FC>id=APPR_NO      name="승인번호"     width=80    align=center   edit=none</FC>'
                        + '<FC>id=APPR_DT      name="승인일자"     width=80    align=center   edit=none  mask="XXXX-XX-XX"</FC>'
                        + '<FC>id=APPR_TIME    name="승인시간"     width=70    align=center   edit=none  mask="XX:XX:XX"</FC>'
                        + '<FC>id=CAN_DT       name="취소일자"     width=80    align=center   edit=none  mask="XXXX-XX-XX"</FC>'
                        + '<FC>id=CAN_TIME     name="취소시간"     width=70    align=center   edit=none  mask="XX:XX:XX"</FC>'
                        + '<FC>id=DOLLAR_FLAG  name="달러구분"     width=80    align=center   edit=none</FC>'
                        + '<FC>id=FILLER       name="FILLER"      width=160    align=center   edit=none</FC>'
                        + '<FC>id=POS_NO       name="POS번호"      width=60    align=center   edit=none</FC>'
                        + '<FC>id=TRAN_NO      name="거래번호"     width=60    align=center   edit=none</FC>'
                        + '<FC>id=POS_SEQ_NO   name="일련번호"     width=60    align=center   edit=none</FC>'
                        + '<FC>id=PAY_TYPE     name="결제구분"     width=60    align=center   edit=none</FC>'
                        + '<FC>id=RCV_DT       name="수신일자"     width=80    align=center   edit=none show="false"</FC>'
                        + '<FC>id=STR_CD       name="점코드"       width=80    align=center   edit=none show="false"</FC>'
                        + '<FC>id=SEQ_NO       name="SEQ_NO"       width=80    align=center   edit=none show="false"</FC>';
                        
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
}
/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.05.31
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(trim(LC_STR_CD.BindColVal).length == 0){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "점포명");
	    LC_STR_CD.Focus();
	    return false;
	}
	
	if(trim(EM_RCV_DT.Text).length == 0 || trim(EM_RCV_DT.Text).length != 8){
	    showMessage(EXCLAMATION, OK, "USER-1003",  "수신일자");
	    EM_RCV_DT.Focus();
	    return false;
	}
   
    //조회
    showMaster();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {
	// 저장할 데이터 없는 경우
    if (!DS_O_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION , OK, "USER-1028"); 
        return;
    } 
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION , YESNO, "USER-1010") != 1 )
        return;
    
    var strStrCd   = LC_STR_CD.BindColVal;
    var strRcvDt   = EM_RCV_DT.Text;
    
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd);
    
    TR_MAIN.Action="/dps/psal916.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();        
    }else{
    	setFocusGrid(GD_MASTER,DS_O_MASTER,DS_O_MASTER.RowPosition,"CHECK1");
    }
 }
 
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.25
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {	
	 
	var delRow = 0;
    var delNewRow = 0;
    var noNewData = 0;
    var newInsData = '';
    for( var i=1; i<=DS_O_MASTER.CountRow; i++){
        if( DS_O_MASTER.NameValue(i,"CHECK1")=='T'){         	
        	DS_O_MASTER.RowMark(i) = 1;          
        	if(DS_O_MASTER.RowStatus(i)!='1')
        		noNewData++;
        	
            delRow++;
        }else{
            if(DS_O_MASTER.RowStatus(i)=='1')
            	newInsData += DS_O_MASTER.ExportData(i,1,true);
        	DS_O_MASTER.RowMark(i) = 0;
        }
    }
    if( delRow < 1){
    	DS_O_MASTER.ClearAllMark();
        showMessage(INFORMATION, OK, "USER-1019");
        
        
        return;
    }
	    // 선택한 항목을 삭제하겠습니까?
	    if( showMessage(INFORMATION, YESNO, "USER-1023") != 1 ){
	        GD_MASTER.Focus();
	        return;
	    }  
	    
	    DS_O_MASTER.DeleteMarked();
	    
	    if(noNewData <1 )
	    	return;
	    //DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition); 
	    
	    // parameters
	    //alert(2);
	    var goTo = "delete";
	    
	    TR_MAIN.Action = "/dps/psal916.ps?goTo=" + goTo;
	    TR_MAIN.KeyValue = "SERVLET(I:DS_O_MASTER=DS_O_MASTER)";
	    TR_MAIN.Post();
	    //alert(3);
	
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010.05.31
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
/*
    var ExcelTitle = "청구대상 데이터 마감";
    
    openExcel2(GD_MASTER, ExcelTitle, strExlParam, true );
    GD_MASTER.Focus();*/
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010.05.31
 * 개       요     : 청구대상 데이터 조회 
 * return값 : void
 */
function showMaster(){    
	 
	var strStrCd   = LC_STR_CD.BindColVal;
	var strRcvDt   = EM_RCV_DT.Text;
	
	strExlParam = "점포명="       + LC_STR_CD.Text
                + "수신일자="     + EM_RCV_DT.Text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strRcvDt="   + encodeURIComponent(strRcvDt);
    
    TR_MAIN.Action  ="/dps/psal916.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //그리드 첫 row 상세조회
    if(DS_O_MASTER.CountRow > 0){
        GD_MASTER.Focus();        
    }else{
    	LC_STR_CD.Focus();
    }
    
    bfListRowPosition = 0;

    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * loadExcelData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function excelDown(){
	var sampleUrl = "#";
	sampleUrl = "/dps/samplefiles/BUY_REQ_UPLOAD(Sample).xls";
	document.getElementById("A_EXCEL_DOWN").href = sampleUrl;
	var href = document.getElementById("A_EXCEL_DOWN").href;
	
    //EM_PUMBUN_CD.Focus();
	if( href.substring(href.length-1) != "#"){
        return;
	}
    //showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
}

/**
 * loadExcelData()
 * 작 성 자 : 이재득
 * 작 성 일 : 2010-04-25
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {
	 
	INF_EXCELUPLOAD.Open();
	
	//loadExcelData 옵션처리
	var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
	if (strExcelFileName == "''")
	    return;
	
	//EM_FILS_LOC.text  = strExcelFileName;  //경로명 표기
	
	var strStartRow = 0; //시작Row
   var strEndRow = 0; //끝Row
   var strReadType = 0; //읽기모드
   var strBlankCount = 0; //공백row개수
   var strLFTOCR = 0; //줄바꿈처리 
   var strFireEvent = 1; //이벤트발생
   var strSheetIndex = 1; //Sheet Index 추가
   var strtrEtc = "1";//엑셀 컬럼에 1000단위 구분기호(,)가 있을 경우, 구분기호를 무시하고 데이터를 가져온다. (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,72    UMX: 2,0,1,72 이상버전 사용가능)
   var strtrcol = 0;//Excel 파일에서 읽어 들일 시작 Col 위치 (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,80    UMX: 2,0,1,80 이상버전 사용가능)

   var strOption = strExcelFileName
   + "," + strStartRow + "," + strEndRow + "," + strReadType 
   + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
   + "," + strSheetIndex + "," + strtrEtc+ "," + strtrcol;
	
	DS_O_RESULT.ClearData();
	DS_O_MASTER.ClearData();
	// Excel파일 DateSet에 저장               
   DS_O_RESULT.Do("Excel.Application", strOption);
	
   DS_O_RESULT.DeleteRow(1);
	// Excel에서 가져온 DATASET을 화면에 보여줄 DATASET에 복사한다.
	var strData = DS_O_RESULT.ExportData(1,DS_O_RESULT.CountRow, true );
	DS_O_MASTER.ImportData(strData);

	// 중복체크 후 구별을 쉽게하기 위해 정렬한다.
	//DS_O_SKU.SortExpr = "+" + "SKU_CD";
	//DS_O_SKU.Sort();

	// Excel에서 가져온 데이터의 정합성 체크를 한다.
	//errorChk();
}

/**
 * errorChk()
 * 작 성 자     : 이재득
 * 작 성 일     : 2010-04-25
 * 개    요        : UPLOAD된 값 체크 
 * return값 : void
 */
function errorChk(){ 
	 
    //var errorCnt = 0;
    for(i=0; i <= DS_O_SKU.CountRow; i++){
        j = i;
        var txtStrCd        = strStrCd;//점
        var txtPumbunCd     = strPumbunCdA;//점
        var txtStkYm        = strPrcAppDt;//점
          
          var strStrCd        = DS_O_MASTER.NameValue(i,"");  
          
          var strPumbunCd     = DS_O_MASTER.NameValue(i,"PUMBUN_CD");         //조직코드
          var strSkuCd        = DS_O_MASTER.NameValue(i,"SKU_CD");
          var strStkYm        = DS_O_MASTER.NameValue(i,"STK_YM");
          var strPummokCd     = DS_O_MASTER.NameValue(i,"PUMMOK_CD");           
          
          if(strStrCd.length == 2 && strPumbunCd.length == 6 && strSkuCd.length == 13 && strStkYm.length == 6 && strPummokCd.length ==8
                  && !isNull(strStrCd)    && !isNull(strPumbunCd) && !isNull(strSkuCd) && !isNull(strStkYm) && !isNull(strPummokCd)    
                  && txtStrCd == strStrCd && strPumbunCd == txtPumbunCd && strStkYm == txtStkYm){
              
              var goTo       = "searchSkuCheck" ;    
              var action     = "O";    
              var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                             + "&strSkuCd="           +encodeURIComponent(strSkuCd);
              
              TR_MAIN.Action="/dps/psal916.pt?goTo="+goTo+parameters;  
              TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SKUCHECK=DS_IO_SKUCHECK)"; //조회는 O
              TR_MAIN.Post();
              i = j;              
              
              if (DS_IO_SKUCHECK.NameValue(1 , "CNT") == 0) {
            	  DS_O_MASTER.NameValue(i,"ERROR_CHECK")= "T";   
                  errorCnt = 1;                   
              }
              DS_IO_SKUCHECK.ClearData();
          }else{
        	  DS_O_MASTER.NameValue(i,"ERROR_CHECK")= "T";
              errorCnt = 1;               
          }          
     }
 }

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.05.31
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
	 /*
     EM_CCOMP_NM.Text = "";//조건입력시 코드초기화
    if (EM_CCOMP_CD.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_CCOMP_CD.Text.length == 2) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_CARDBIN", EM_CCOMP_CD.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_CCOMP_CD.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_CCOMP_NM.Text   = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getCcompPop(EM_CCOMP_CD, EM_CCOMP_NM);
            }
        }
    }
     */
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                        *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!-- 카드발급사 onKillFocus() 
<script language=JavaScript for=EM_CCOMP_CD event=onKillFocus()>
    if ((EM_CCOMP_CD.Modified) && (EM_CCOMP_CD.Text.length != 2)) {
        EM_CCOMP_NM.Text = "";
    }
</script>
-->

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    switch (colid) { 
    case "DUE_DT":
        openCal(GD_MASTER, row, colid, "G");   //그리드 달력    
        break;
} 
</script>

<script language=JavaScript for=DS_O_MASTER event=OnColumnChanged(row,colid)> 
    if(row < 1)
        return true;
    
    switch(colid){
    case "DUE_DT":    	
        if (DS_O_MASTER.NameValue(row, "DUE_DT") == ""){
        	setFocusGrid(GD_MASTER,DS_O_MASTER,row,"DUE_DT");
        	return true;  
        }       
            
        if(!checkDateTypeYMD(GD_MASTER,colid,'')) {
        	setFocusGrid(GD_MASTER,DS_O_MASTER,row,"DUE_DT");
        	DS_O_MASTER.NameValue(row, "DUE_DT") = strToday;
        	return;
        }    
            
        if(DS_O_MASTER.NameValue(row, "DUE_DT") < strToday) {
        	setFocusGrid(GD_MASTER,DS_O_MASTER,row,"DUE_DT");
        	showMessage(EXCLAMATION, Ok,  "USER-1030", "청구예정일자");
        	DS_O_MASTER.NameValue(row, "DUE_DT") = strToday;
        	return;
        }    
        break; 
    }
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)> 
    
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                                                                                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                             *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_BCOMP_CD" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                              *-->
<!--*************************************************************************-->

<body onLoad="doInit();" class="PL10 PT15">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점포명</th>
						<td width="170"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=165
							align="absmiddle" tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>		
						<th width="80" class="point">수신일자</th>
                        <td>
                        <comment id="_NSID_">
                        <object id=EM_RCV_DT classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=1 align="absmiddle">
                        </object>
                        </comment>
                        <script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_RCV_DT)"  align="absmiddle"/>
                        </td>
                        <td colspan="2"><img src="/<%=dir%>/imgs/btn/excel_s.gif" id="Excel_Up_Load"
                        onclick="loadExcelData();" align="absmiddle" />
                        <a href="#" align="absmiddle" id=A_EXCEL_DOWN onClick="javascript:excelDown();">
                        <img src="/<%=dir%>/imgs/btn/excel_down.gif" border="0" align="absmiddle" >
                        </a>
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
        <td></td>
    </tr>
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GD_MASTER
                    width="100%" height=500 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</div>
<body>
</html>

