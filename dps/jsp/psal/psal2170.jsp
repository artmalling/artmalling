<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리
 * 작 성 일 : 2016.11.18
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : psal2170.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매출수기등록 품목
 * 이    력 : 2016.11.18 박래형
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
	SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
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
<script language="javascript" src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

var top = 130;			// 해당화면의 동적그리드top위치
var gEvtFlag        = true;	// 데이터셋 이벤트 실행여부 

/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_HS_MG.setDataHeader('<gauce:dataset name="H_SEL_HS_MG"/>');
    DS_PAY_TYPE.setDataHeader('<gauce:dataset name="H_SEL_PAY_TYPE"/>');
    DS_O_BCOMP.setDataHeader('<gauce:dataset name="H_SEL_CARD_PBLSH"/>');
    DS_TRAN_FLAG.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    // 엑셀업로드
    DS_O_RESULT_EXCEL.setDataHeader('PUMBUN_CD:STRING(6), PUMMOK_CD:STRING(4),MG_CD:STRING(2), SALE_PRC:INT(9),SALE_QTY:INT(3),CUST_CNT:INT(3)');
    DS_O_EXCELTEMP.setDataHeader   ('<gauce:dataset name="H_UPLOAD"/>');
    DS_HS_EXCEL.setDataHeader      ('<gauce:dataset name="H_SEL_EXCEL"/>');
    
    // EMedit에 초기화
    initEmEdit(EM_SALE_DT, "YYYYMMDD", PK);		// 매출일자
    initEmEdit(EM_POS_NO,  "GEN",      READ);	// POS번호
    initEmEdit(EM_FILS_LOC, "GEN^500", READ); //EXCEL경로
    
    // 콤보 초기화
    initComboStyle(LC_STR_CD,    DS_STR_CD,    "CODE^0^30,NAME^0^80", 1, PK);	// 점(조회)
    initComboStyle(LC_TRAN_FLAG, DS_TRAN_FLAG, "CODE^0^30,NAME^0^80", 1, PK);	// 매출구분
    
    //그리드 초기화
    gridCreate1(); 		//마스터

    //현재년도 셋팅
    EM_SALE_DT.alignment = 1;
    EM_SALE_DT.text      =  varToday;
    EM_POS_NO.Text       = "9001";
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';		// 로그인 점코드   
	var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    getStore("DS_STR_CD", "Y", "", "N");			// 점
    
 	// 판매반품
    fnSetTranFlag();
    // 결제수단 조회
    searchPayType();
    //카드 매입사 조회
    getBcompCode("DS_O_BCOMP", "", "", "N");
    
    LC_STR_CD.BindColVal  = strcd;   
    LC_TRAN_FLAG.Index    = 0;   
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal217","DS_O_MASTER,DS_HS_MG" );
    LC_STR_CD.Focus();
}

// 마스터
function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"           width=30    align=center    </FC>'
                     + '<FC>id=CHK           name="선택"         width=60    align=center    HeadCheckShow=true EditStyle=CheckBox </FC>'
                     + '<FC>id=STR_CD        name="점"           width=100   align=left      suppress=1 EditStyle=Lookup Data="DS_STR_CD:CODE:NAME" Show=false </FC>'
                     + '<G> name="브랜드"'
                     + '<FC>id=PUMBUN_CD     name="코드"         width=90    align=center    EditStyle=Popup edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=PUMBUN_NAME   name="명"           width=120   align=left      edit=none</FC>'
                     + '</G>'
                     + '<G> name="품목"'
                     + '<FC>id=PUMMOK_CD     name="코드"         width=70    align=center    EditStyle=Popup edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=PUMMOK_NAME   name="명"           width=120   align=left      edit=none</FC>'
                     + '</G>'
                     + '<C>id=EVENT_FLAG     name="행사구분"     width=70    align=center    EditStyle=Lookup Data="DS_HS_MG:EVENT_FLAG:EVENT_FLAG" edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=EVENT_RATE     name="행사율"       width=60    align=center    edit=none   </C>'
                     + '<C>id=SALE_PRC       name="판매단가"     width=120   align=right     mask="###,###"   edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=SALE_QTY       name="판매수량"     width=120   align=right     mask="###,###"   edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=SALE_AMT       name="매출금액"     width=100   align=right     mask="###,###"   edit=none </C>'
                     + '<C>id=CUST_CNT       name="객수"         width=40    align=right     mask="###,###"   edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=PROC_FLAG      name="처리구분"     width=100   align=center    edit=none        show=false </C>'
                     + '<G>					 name="결제정보"	'
                     + '<C>id=PAY_NAME     	 name="수단명"     width=100    align=center    EditStyle=Lookup Data="DS_PAY_TYPE:PAY_NAME:PAY_NAME" edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=PAY_TYPE	     name="코드"   	   width=60    align=center    edit=none   </C>'
                     + '<C>id=CARD_NO        name="카드번호"   width=70    align=center        edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=CARD_PBLSH_NM  name="카드사"     width=70    align=center    EditStyle=Lookup Data="DS_O_BCOMP:NAME:NAME" edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=CARD_PBLSH_CD	 name="코드"   	   width=60    align=center    edit=none   </C>'
                     + '</G>'
                     ;
    			
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    
	//그리드 엔터시 로우 추가
	GD_MASTER.autorow     = "true";
	GD_MASTER.autoevent   = "btn_New()";
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    
    if(!chkValidation("search")) return;
    var strStrCd     = LC_STR_CD.BindColVal;
    var strSaleDt    = EM_SALE_DT.text;
    var strPosNo     = EM_POS_NO.text;
    var strTranFlag  = LC_TRAN_FLAG.BindColVal;
    var strEtcGbn    = "1";					// 품목
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strSaleDt="   + encodeURIComponent(strSaleDt)
                   + "&strPosNo="    + encodeURIComponent(strPosNo)
                   + "&strTranFlag=" + encodeURIComponent(strTranFlag)
                   + "&strEtcGbn="   + encodeURIComponent(strEtcGbn)
                   ;
    
    TR_MAIN.Action="/dps/psal217.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();

    GD_MASTER.focus();
    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);

    //매출기간 disable 처리
    enableCnt(true);
    
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    
    EM_FILS_LOC.TEXT ="";
}

/**
 * btn_New()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :   
 * return값 : 
 */
function btn_New() {

	var strStrCd  = LC_STR_CD.BindColVal;
	var strPosNo  = EM_POS_NO.Text;
	var strSaleDt = EM_SALE_DT.Text;
	var strTrFlag = LC_TRAN_FLAG.BindColVal;
	
	var strUsrId   = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';		// 로그인 사번
	//alert(strUsrId);
	
	var strStdTime = 11;

	
	if (strUsrId!='17010138'&&strUsrId!='fkl') {
	
		if (strSaleDt <= varPostday) {			// 등록일자와 전일자 비교 - 전일포함 이전의 날짜일 경우.
			
			if (strSaleDt < varPostday) {		// 등록일자와 전일자 비교 - 전일 이전의 날짜일 경우.
				alert("전일자 외 과거 날짜로 매출을 등록하실 수 없습니다.");
				return false;
			}
			
			if (time >= strStdTime) {					// 등록일자와 전일자 비교 - 전일일 경우 현재 시간 체크
				alert(strStdTime+"시 이후부터 전일 등록이 불가 합니다.");
				return false;
			}
		}
	}

	
	DS_O_MASTER.Addrow();
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "STR_CD")    = strStrCd;
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "SALE_DT")   = strSaleDt;
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "POS_NO")    = strPosNo;
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "TRAN_FLAG") = strTrFlag;
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "CUST_CNT")  = 1;
	//DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "PAY_TYPE")  = DS_PAY_TYPE.NameValue(1,"PAY_TYPE");
	//DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "PAY_TYPE")  = DS_O_BCOMP.NameValue(1,"CODE");


	//매출기간 disable 처리
	enableCnt(false);
	
	// 포커스
	setFocusGrid(GD_MASTER, DS_O_MASTER, DS_O_MASTER.Rowposition, "PUMBUN_CD");
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {
	 
	GD_MASTER.redraw = false;
    var strChk       = "";
    var strRowStatus = "";
    
    for(var i=DS_O_MASTER.CountRow; i>0; --i){
        strRowStatus = DS_O_MASTER.RowStatus(i);
        strChk       = DS_O_MASTER.NameValue(i, "CHK");
        if(strRowStatus != "1") continue;
        if(strChk       != "T") continue;
        
        DS_O_MASTER.DeleteRow(i);
    }
    
    //매출기간 enable 처리
    enableCnt(true);
    
    GD_MASTER.redraw = true;
}

/**
 * btn_Save()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Save() {

	// 값 체크
	if(!chkValidation("save")) return;
	
	var parameters = "";
    var goTo       = "save";    
    var action     = "I";  
    TR_SAVE.Action="/dps/psal217.ps?goTo="+goTo+parameters;  
    TR_SAVE.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_SAVE.Post();
    
    // 저장 후 재조회
    btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {
	 
}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */

 function btn_Conf() {
	 
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * fnSetTranFlag()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-14
  * 개    요 : 판매구분 세팅
  * return값 : void
  */
 function fnSetTranFlag(){
 	DS_TRAN_FLAG.ClearData();
 	DS_TRAN_FLAG.AddRow();
 	DS_TRAN_FLAG.NameValue(DS_TRAN_FLAG.Rowposition, "CODE") = "0";
 	DS_TRAN_FLAG.NameValue(DS_TRAN_FLAG.Rowposition, "NAME") = "판매";
 	DS_TRAN_FLAG.AddRow();
 	DS_TRAN_FLAG.NameValue(DS_TRAN_FLAG.Rowposition, "CODE") = "1";
 	DS_TRAN_FLAG.NameValue(DS_TRAN_FLAG.Rowposition, "NAME") = "반품";
 }
 
/**
 * chkValidation(gbn)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(gbn){
	 
    switch (gbn){
	    case "search" :
	
	        //점 체크
	        if (isNull(LC_STR_CD.BindColVal)==true ) {
	            showMessage(Information, OK, "USER-1003","점");
	            LC_STR_CD.focus();
	            return false;
	        }
	
	        //매출일자
	        if (isNull(EM_SALE_DT.text) ==true ) {
	            showMessage(Information, OK, "USER-1003","매출일자"); 
	            EM_SALE_DT.focus();
	            return false;
	        }
	        
	        //년월 자릿수, 공백 체크
	        if (EM_SALE_DT.text.replace(" ","").length != 8 ) {
	            showMessage(Information, OK, "USER-1027","매출일자","8");
	            EM_SALE_DT.focus();
	            return false;
	        }
	        
	        if(!checkYYYYMMDD(EM_SALE_DT.text)){
	        	showMessage(Information, OK, "USER-1004","매출일자");
	            EM_SALE_DT.focus();
	            return false;
	        }
	        break;

	    // 저장
		case "save":
	        // 저장할 내용이 없습니다.
		    if(!DS_O_MASTER.IsUpdated){
		        showMessage(INFORMATION, OK, "USER-1028");
		        return false;
		    }
	        
	        // POS별 브랜드그룹 관리
            for(nRow = 1; nRow <= DS_O_MASTER.CountRow; nRow++){
                
                var strRowStatus = DS_O_MASTER.RowStatus(nRow);
                var strPbCd      = DS_O_MASTER.NameValue(nRow, "PUMBUN_NAME");
                var strPmCd      = DS_O_MASTER.NameValue(nRow, "PUMMOK_NAME");
                var strEvtFlag   = DS_O_MASTER.NameValue(nRow, "EVENT_FLAG");
                var strEvtRate   = DS_O_MASTER.NameValue(nRow, "EVENT_RATE");
                var strPayType   = DS_O_MASTER.NameValue(nRow, "PAY_TYPE");
                var strCardCd    = DS_O_MASTER.NameValue(nRow, "CARD_PBLSH_CD");
                var strCardNo    = DS_O_MASTER.NameValue(nRow, "CARD_NO");
                
                var nSalePrc     = DS_O_MASTER.NameValue(nRow, "SALE_PRC");
                var nSaleQty     = DS_O_MASTER.NameValue(nRow, "SALE_QTY");
                var nCustCnt     = DS_O_MASTER.NameValue(nRow, "CUST_CNT");
                var nCardLen	 = strCardNo.length;
                
                // 입력 수정시에만 체크한다.
                if (strRowStatus == 1 || strRowStatus == 3) {

                    // 마감체크
                    if(!closeCheck())
                    	return false;
                    
                    if(strPbCd == ""){
                        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드코드");
                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "PUMBUN_CD");
                        return false;
                    }
                    
                    if(strPmCd == ""){
                        showMessage(EXCLAMATION, OK, "USER-1003", "품목코드");
                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "PUMMOK_CD");
                        return false;
                    }
                    
                    if(strEvtFlag == ""){
                        showMessage(EXCLAMATION, OK, "USER-1003", "행사구분");
                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "EVENT_FLAG");
                        return false;
                    }
                    
                    if(nSalePrc == "" || nSalePrc <= "0"){
                        showMessage(EXCLAMATION, OK, "USER-1003", "판매단가");
                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "SALE_PRC");
                        return false;
                    }
                    
                    if(nSaleQty == "" || nSaleQty <= "0"){
                        showMessage(EXCLAMATION, OK, "USER-1003", "판매수량");
                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "SALE_QTY");
                        return false;
                    }       
                    
                    if(nCustCnt == "" || nCustCnt <= "0"){
                        showMessage(EXCLAMATION, OK, "USER-1003", "객수");
                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "CUST_CNT");
                        return false;
                    } 
                    
                    if(strPayType == ""){
                        showMessage(EXCLAMATION, OK, "USER-1003", "결제 구분");
                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "PAY_NAME");
                        return false;
                    }
                    
                    if (strPayType=="10"||strPayType=="13") {	// 카드결제일때 체크
                    	if(strCardNo == ""){
	                        showMessage(EXCLAMATION, OK, "USER-1003", "카드 번호");
	                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "CARD_NO");
	                        return false;
	                    }
                    
                    	if (nCardLen < 6) {
                    		showMessage(EXCLAMATION, OK, "USER-1000", "카드번호 앞 6자리를 입력해주세요.");
	                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "CARD_NO");
	                        return false;
                    	}
	                    
	                    if(strCardCd == ""){
	                        showMessage(EXCLAMATION, OK, "USER-1003", "카드사 코드");
	                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "CARD_PBLSH_NM");
	                        return false;
	                    }
                    }
                }
            }
	        
		    //변경또는 신규 내용을 저장하시겠습니까?
		    if(showMessage(QUESTION, YESNO, "USER-1010") == 1){
    		    return true;
		    }else{
                return false;
		    }
			break;
    }
    return true;
}


/**
* closeCheck()
* 작 성 자 : 박래형
* 작 성 일 : 2010-03-10
* 개    요    : 저장시 일마감체크를 한다.
* return값 : void
*/
function closeCheck(){
    var strStrCd         = LC_STR_CD.BindColVal;   // 점
    var strCloseDt       = EM_SALE_DT.Text;        // 마감체크일자
    var strCloseTaskFlag = "PSAL";                 // 업무구분(매출월마감)
    var strCloseUnitFlag = "42";                   // 단위업무
    var strCloseAcntFlag = "0";                    // 회계마감구분(0:일반마감)          
    var strCloseFlag     = "M";                    // 마감구분(월마감:M)
   
    var closeFlag = getCloseCheck( "DS_O_CLOSE", strStrCd , strCloseDt , strCloseTaskFlag 
                                  , strCloseUnitFlag , strCloseAcntFlag , strCloseFlag);
    
    if(closeFlag == "TRUE"){
        showMessage(EXCLAMATION, OK, "USER-1068", "매출일","매출");
        return false;
    }else{
        return true;
    }
}   

/**
 * fnCallPopup()
 * 작 성 자 : 박래형
 * 작 성 일 : 2016-10-24
 * 개    요 : 점별 브랜드 POPUP
 * return값 : void
 */
function fnCallPopup(strPopId, objGrd, strEvt, strMulti){
	
	var objDs  = eval(objGrd.DataID);	// 그리드에 바인딩된 데이터셋
	var nDsRow = objDs.Rowposition;		// 그리드에 바인딩된 데이터셋의 현재row

	switch(strPopId){
		
		// 브랜드 팝업
		case "PUMBUN_CD":
		    var OBJPARAMS = { PID     : "PSAL212"	// 강제로 박아둠
			                , EVTFLAG : strEvt
			                , MULTI   : strMulti
					        , PARAMS  : { STR_CD      : objDs.NameValue(nDsRow, "STR_CD")
		      	                        , PUMBUN_CD   : objDs.NameValue(nDsRow, "PUMBUN_CD")
		    	                        , PUMBUN_TYPE : "0"
		    	                        , SKU_FLAG    : "2"
		    	                        , BIZE_TYPE   : "'2','3','5'"		// 2, 3, 5
		                                }
                };
			var returnList = gfnCallByPopUpPumbunCd("DS_POP", OBJPARAMS);	// 브랜드 조회
			
			gEvtFlag = false;
			if(returnList == undefined || returnList.length <= 0){
			    gEvtFlag = true;
				return;
			}
			
			for(var i = 0; i < returnList.length; i++){
				if(i != 0) objDs.AddRow();
			    objDs.NameValue(objDs.Rowposition, "PUMBUN_CD")    = returnList[i]["PUMBUN_CD"];
			    objDs.NameValue(objDs.Rowposition, "PUMBUN_NAME")  = returnList[i]["PUMBUN_NAME"];
			    objDs.NameValue(objDs.Rowposition, "ITEM_CD_TYPE") = returnList[i]["SKU_FLAG"];
			}
			
			// 행사구분 마진(행사율)정보 조회
        	searchMgHs(objDs.Rowposition);
            
            if(DS_HS_MG.CountRow > 0){
            	objDs.NameValue(objDs.Rowposition, "EVENT_FLAG") = DS_HS_MG.NameValue(1, "EVENT_FLAG");
            	objDs.NameValue(objDs.Rowposition, "EVENT_RATE") = DS_HS_MG.NameValue(1, "EVENT_RATE");
            }
        	
			gEvtFlag = true;
			break
			
		default:
			break;
	}
}

/**
 * getPummokPop()
 * 작 성 자 : 
 * 작 성 일 : 2010.03.28
 * 개    요 : 품목GridPopup
 * return값 : void
 */
function getPummokPop(row, colid , popFlag){   
    var strStrCd     = DS_O_MASTER.NameValue(row, "STR_CD");
    var strPumbunCd  = DS_O_MASTER.NameValue(row, "PUMBUN_CD");
    
    if (strPumbunCd == ""){
        showMessage(EXCLAMATION, Ok, "USER-1045", "브랜드"); 
        setFocusGrid(GD_MASTER, DS_O_MASTER, row, "PUMBUN_CD");
        return;
    }

	gEvtFlag = false;
	
    var strPummokCd  = DS_O_MASTER.NameValue(row,"PUMMOK_CD");
    var strPummokNm  ="";  
    DS_O_MASTER.NameValue(row,"PUMMOK_NAME") = "";
    
    if(strPumbunCd != "" && popFlag != "1"){        
        var rtnMap = setPbnPmkNmWithoutToGridPop("DS_O_RESULT", strPummokCd, strPummokNm , strPumbunCd , '1');
        if(rtnMap != null){
            DS_O_MASTER.NameValue(row, "PUMMOK_CD")    = rtnMap.get("PUMMOK_SRT_CD");
            DS_O_MASTER.NameValue(row, "PUMMOK_NAME")  = rtnMap.get("PUMMOK_NAME");
            strPummokCd = DS_O_MASTER.NameValue(row, "PUMMOK_CD");
        }       
    }else{
        if (popFlag =="1"){
            var rtnMap = pbnPmkToGridPop(strPummokCd , strPummokNm , strPumbunCd);
            if(rtnMap != null){         
                DS_O_MASTER.NameValue(row, "PUMMOK_CD")    = rtnMap.get("PUMMOK_SRT_CD");
                DS_O_MASTER.NameValue(row, "PUMMOK_NAME")  = rtnMap.get("PUMMOK_NAME");
                strPummokCd = DS_O_MASTER.NameValue(row, "PUMMOK_SRT_CD");
               // searchMargin(strStrCd , strPumbunCd , strPummokCd, row);
               // searchMg(strStrCd , strPumbunCd , strPummokCd , row);
            }
        }
    }   

	gEvtFlag = true;
 }
 
 

/**
 * searchMgHs()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 행사구분 마진 조회
 * return값 : void
 */
function searchMgHs(nRow) {
    
    // 행사구분 데이터셋 클리어
    DS_HS_MG.ClearData();

    var strStrCd     = DS_O_MASTER.NameValue(nRow, "STR_CD");
    var strPumBunCd  = DS_O_MASTER.NameValue(nRow, "PUMBUN_CD");
    var strSaleDt    = DS_O_MASTER.NameValue(nRow, "SALE_DT");
    
    var goTo       = "searchMgHs" ;    
    var action     = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strPumBunCd=" + encodeURIComponent(strPumBunCd)
                   + "&strSaleDt="   + encodeURIComponent(strSaleDt)
                   ;
    
    TR_MAIN.Action="/dps/psal217.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_HS_MG=DS_HS_MG)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * loadExcelData()
 * 작 성 자 : 김광래
 * 작 성 일 : 2016.12.26
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {

	INF_EXCELUPLOAD.Open();
	
	//loadExcelData 옵션처리
	var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
	if (strExcelFileName == "''")
	    return;
	
	EM_FILS_LOC.text  = strExcelFileName;  //경로명 표기
	var strStartRow   = 1;                 //시작Row
	var strEndRow     = 0;                 //끝Row
	var strReadType   = 0;                 //읽기모드
	var strBlankCount = 0;                 //공백row개수
	var strLFTOCR     = 0;                 //줄바꿈처리 
	var strFireEvent  = 1;                 //이벤트발생
	var strSheetIndex = 1;                 //Sheet Index 추가

	
	var strOption = strExcelFileName
	    + "," + strStartRow + "," + strEndRow + "," + strReadType 
	    + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
	    + "," + strSheetIndex;
	
	DS_O_RESULT_EXCEL.ClearData();
	DS_O_EXCELTEMP.ClearData();
	DS_O_MASTER.ClearData();
	
	// Excel파일 DateSet에 저장               
    DS_O_RESULT_EXCEL.Do("Excel.Application", strOption);
	

//    return false;
	// Excel에서 가져온 DATASET을 화면에 보여줄 DATASET에 복사한다.
	var strData = DS_O_RESULT_EXCEL.ExportData(1,DS_O_RESULT_EXCEL.CountRow, true );
	DS_O_EXCELTEMP.ImportData(strData);

	gEvtFlag = false;
	
	var strStrCd  = LC_STR_CD.BindColVal;
	var strPosNo  = EM_POS_NO.Text;
	var strSaleDt = EM_SALE_DT.Text;
	var strTrFlag = LC_TRAN_FLAG.BindColVal;
	
	/* 엑셀Temp 데이터셋에 데이터를 Master에 넣어준다.  */
	for(nRow = 1; nRow <= DS_O_EXCELTEMP.CountRow; nRow++){
		/* 행추가 */
		DS_O_MASTER.Addrow();
		/* 조회조건의 Key 값 세팅  */
		DS_O_MASTER.NameValue(nRow, "CHK")       = "T";
		DS_O_MASTER.NameValue(nRow, "STR_CD")    = strStrCd;
		DS_O_MASTER.NameValue(nRow, "SALE_DT")   = strSaleDt;
		DS_O_MASTER.NameValue(nRow, "POS_NO")    = strPosNo;
		DS_O_MASTER.NameValue(nRow, "TRAN_FLAG") = strTrFlag;
		/* 엑셀 업로드 Master 데이터셋에 import */ 
		DS_O_MASTER.NameValue(nRow, "PUMBUN_CD")    = DS_O_EXCELTEMP.NameValue(nRow, "PUMBUN_CD");
		DS_O_MASTER.NameValue(nRow, "PUMMOK_CD")    = DS_O_EXCELTEMP.NameValue(nRow, "PUMMOK_CD");
		DS_O_MASTER.NameValue(nRow, "EVENT_FLAG")    = DS_O_EXCELTEMP.NameValue(nRow, "MG_CD");
		
		/* 브랜드명, 품목명, 행사구분, 행사율 값 조회 */
		searchExcel(nRow);
		
        if(DS_HS_EXCEL.CountRow > 0){
        	/* 브랜드명, 품목명, 행사구분, 행사율 값 조회된 값 넣기 */
        	DS_O_MASTER.NameValue(nRow, "PUMBUN_NAME") = DS_HS_EXCEL.NameValue(1, "PUMBUN_NAME");
        	DS_O_MASTER.NameValue(nRow, "PUMMOK_NAME") = DS_HS_EXCEL.NameValue(1, "PUMMOK_NAME");
        	DS_O_MASTER.NameValue(nRow, "EVENT_FLAG")  = DS_HS_EXCEL.NameValue(1, "EVENT_FLAG");
        	DS_O_MASTER.NameValue(nRow, "EVENT_RATE")  = DS_HS_EXCEL.NameValue(1, "EVENT_RATE");
        }
        
		DS_O_MASTER.NameValue(nRow, "SALE_PRC")     = DS_O_EXCELTEMP.NameValue(nRow, "SALE_PRC");
		DS_O_MASTER.NameValue(nRow, "SALE_QTY")     = DS_O_EXCELTEMP.NameValue(nRow, "SALE_QTY");
		DS_O_MASTER.NameValue(nRow, "SALE_AMT")     = DS_O_EXCELTEMP.NameValue(nRow, "SALE_PRC") * DS_O_EXCELTEMP.NameValue(nRow, "SALE_QTY");
		DS_O_MASTER.NameValue(nRow, "CUST_CNT")     = DS_O_EXCELTEMP.NameValue(nRow, "CUST_CNT");
	}
	
	//매출기간 disable 처리
    enableCnt(false);
	gEvtFlag = true;
}

/**
 * searchMgHs()
 * 작 성 자 : 감광래
 * 작 성 일 : 2016-12-26
 * 개    요 : 행사구분 마진 조회
 * return값 : void
 */
function searchExcel(nRow) {
    // 행사구분 데이터셋 클리어
    DS_HS_EXCEL.ClearData();

    var strPumBunCd     = DS_O_MASTER.NameValue(nRow, "PUMBUN_CD");
    var strPumPokSrtCd  = DS_O_MASTER.NameValue(nRow, "PUMMOK_CD");
    var strStrCd        = DS_O_MASTER.NameValue(nRow, "STR_CD");
    var strSaleDt       = DS_O_MASTER.NameValue(nRow, "SALE_DT");
    var strSaleDt       = DS_O_MASTER.NameValue(nRow, "SALE_DT");
    var strEvtflg 	    = DS_O_MASTER.NameValue(nRow, "EVENT_FLAG");
    
    var goTo       = "searchExcel" ;    
    var action     = "O";     
    var parameters = "&strPumBunCd="    + encodeURIComponent(strPumBunCd)
                   + "&strPumPokSrtCd=" + encodeURIComponent(strPumPokSrtCd)
                   + "&strStrCd="       + encodeURIComponent(strStrCd)
                   + "&strSaleDt="      + encodeURIComponent(strSaleDt)
                   + "&strEvtflg="      + encodeURIComponent(strEvtflg)
                   ;
    
    TR_MAIN.Action="/dps/psal217.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_HS_EXCEL=DS_HS_EXCEL)"; //조회는 O
    TR_MAIN.Post();
}

/**
 * enableCnt()
 * 작 성 자 : 김광래
 * 작 성 일 :2017.01.01
 * 개    요 : 마스터 신규행 추가시 매출기간 수정불가능
 * return값 : void
 */
function enableCnt(flag){
	 
	var strRowStatus = "";//상태값 여부
	var newCount     = 0; //신규행 존재 여부
	
	if(flag){
		/* 신규행 존재 여부 체크 신규행이 있으면 newCount 숫자 증가 */
		for(i = 1; i <= DS_O_MASTER.CountRow; i++){
			if(DS_O_MASTER.RowStatus(i)=="1")newCount++;
		}
		if(newCount>0){
			EM_SALE_DT.enable = false;
		}else{
			EM_SALE_DT.enable = true;
		}
	}else{
		//매출기간 enable처리
		EM_SALE_DT.enable = false;
	}
}


/**
 * searchPayType()
 * 작 성 자 : jyk
 * 작 성 일 : 2018-01-29
 * 개    요 : 결제 수단 조회
 * return값 : void
 */
function searchPayType() {
    
    // 행사구분 데이터셋 클리어
    DS_PAY_TYPE.ClearData();

    var goTo       = "searchPayType" ;    
    var action     = "O";     
    var parameters = "";
    
    TR_MAIN.Action="/dps/psal217.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_PAY_TYPE=DS_PAY_TYPE)"; //조회는 O
    TR_MAIN.Post();
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

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<!-- 그리드 헤더 체크박스 클릭시 -->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

	var objDs = eval(this.DataID);
	
	this.redraw = false;
    switch(Colid){
        case "CHK":
            for (var row = 1; row <= objDs.CountRow; row++) {
                if(bCheck){
                	objDs.NameValue(row, "CHK") = "T";
                }else{
                	objDs.NameValue(row, "CHK") = "F";
                }
            }
            break;
            
        default:
            break;
    }
    this.redraw = true;
</script>

<!-- 팝업  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if(row <= 0) return;

    switch(colid){
        case "PUMBUN_CD":		// 브랜드코드 
        	fnCallPopup("PUMBUN_CD", GD_MASTER, "POP", "S");
            break;

        case "PUMMOK_CD":		// 품목코드
        	getPummokPop(row ,colid ,'1');
        default:
        	break;
    }
</script>

<!-- 데이터셋 값 변경 후 -->
<script language=JavaScript for=DS_O_MASTER event=OnColumnChanged(row,colid)>
    
    if(!gEvtFlag) return;
	
  	//로컬 함수, 카드 구분 외에는 정보를 지운다.
    function lfCardInfoClear(dsObj,nRow) {	
    	if(dsObj.NameValue(nRow, "PAY_TYPE") != "10"&&dsObj.NameValue(nRow, "PAY_TYPE") != "13") {
    		dsObj.NameValue(nRow, "CARD_PBLSH_NM") = "";
    		dsObj.NameValue(nRow, "CARD_PBLSH_CD") = "";
    		dsObj.NameValue(nRow, "CARD_NO") = "";
    		return false;
    	}
    	return true;
    }
    
    switch(colid){
        
        case "PUMBUN_CD":		// 브랜드코드

            this.NameValue(row, "PUMBUN_NAME")  = "";
            this.NameValue(row, "PUMMOK_CD")    = "";
            this.NameValue(row, "PUMMOK_NAME")  = "";
            this.NameValue(row, "EVENT_FLAG")   = "";
            this.NameValue(row, "EVENT_RATE")   = "";
            this.NameValue(row, "ITEM_CD_TYPE") = "";
        	if(this.NameValue(row, colid) == "") return;
        
        	fnCallPopup("PUMBUN_CD", GD_MASTER, "EVT", "S");
            break;
            
        case "PUMMOK_CD":		// 품목코드
            this.NameValue(row, "PUMMOK_NAME") = "";
        	if(this.NameValue(row, colid) == "") return;
            getPummokPop(row , colid , "2");
            break;

		// 판매금액 계산
        case "SALE_PRC":
        case "SALE_QTY":
        	var nSalePrc = this.NameValue(row, "SALE_PRC");
        	var nSaleQty = this.NameValue(row, "SALE_QTY");
        	this.NameValue(row, "SALE_AMT") = nSalePrc * nSaleQty;
            break;
            
        case "PAY_NAME":
        	var strPayName = this.NameValue(row, "PAY_NAME");
        	var nPayRowIdx = DS_PAY_TYPE.NameValueRow("PAY_NAME",strPayName);
        	this.NameValue(row, "PAY_TYPE") =  DS_PAY_TYPE.NameValue(nPayRowIdx,"PAY_TYPE");
        	lfCardInfoClear(this,row);
        	break;
        	
        case "CARD_PBLSH_NM":
        	if (!lfCardInfoClear(this,row))
        		break;
        	var strCdPblshNm 	= this.NameValue(row, "CARD_PBLSH_NM");
        	var nCdPblshRowIdx 	= DS_O_BCOMP.NameValueRow("NAME",strCdPblshNm);
        	this.NameValue(row, "CARD_PBLSH_CD") =  DS_O_BCOMP.NameValue(nCdPblshRowIdx,"CODE");
        	break;
        case "CARD_NO":
        	lfCardInfoClear(this,row);
        	break;

        default :
            break;
    }
</script>

<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
    var time = now.getHours();
     
    // 어제자 셋팅
	
	//var yester = new Date("4/1/2017");
	var yester = new Date();
	var postDt = yester.getDate();
	yester.setDate(postDt - 1);
	
	var postmon = yester.getMonth()+1;
    if(postmon < 10) postmon = "0" + postmon;
    var postday = yester.getDate();
    if(postday < 10)postday = "0" + postday;
    var varPostday = yester.getYear().toString()+ postmon + postday;
    var varPostMon = yester.getYear().toString()+ postmon;
    
    

	
</script>

<!-- 매출시작일 -->
<script language=JavaScript for=EM_SALE_DT event=onKillFocus()>

    //영업조회일
    if (isNull(EM_SALE_DT.text) ==true ) {
        showMessage(Information, OK, "USER-1003","매출기간"); 
        EM_SALE_DT.text = varToMon+"01";
        return false;
    }
    //영업조회일 자릿수, 공백 체크
    if (EM_SALE_DT.text.replace(" ","").length != 8 ) {
        showMessage(Information, OK, "USER-1027","매출기간","8");
        EM_SALE_DT.text = varToMon+"01";
        return false;
    }
    //일자형식체크
    if (!checkYYYYMMDD(EM_SALE_DT.text) ) {
        showMessage(Information, OK, "USER-1069","매출기간");
        EM_SALE_DT.text = varToMon+"01";
        return false;
    }
    //오늘 이후는 입력 불가능
    if (EM_SALE_DT.text > varToday ) {
        showMessage(Information, OK, "USER-1000","매출기간은 금일 이후는 입력이 불가능합니다.");
        EM_SALE_DT.text = varToMon+"01";
        return false;
    }
	return true;
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
<comment id="_NSID_"><object id="DS_STR_CD"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CLOSE"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BCOMP"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TRAN_FLAG"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POP"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_HS_MG"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PAY_TYPE"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_HS_EXCEL"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT_EXCEL" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_EXCELTEMP" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
   <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
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
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
							<tr>
								<th width="70" class="point">점</th>
								<td width="105">
									<comment id="_NSID_">
										<object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 align="absmiddle">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="90" class="point">매출기간</th>
								<td width="105">
									<comment id="_NSID_">
										<object id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1 align="absmiddle">
										</object> 
									</comment><script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT)" align="absmiddle" />
								</td>
								<th width="90" class="point">매출구분</th>
								<td width="80">
									<comment id="_NSID_">
										<object id=LC_TRAN_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=75 tabindex=1 align="absmiddle">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="90" class="point">POS번호</th>
								<td>
									<comment id="_NSID_">
										<object id=EM_POS_NO classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle">
										</object>
									</comment> <script> _ws_(_NSID_);</script>
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
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
      <tr>
        <td class="PT03"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="100" style="display:none;" >파일선택</th>
            <td style="display:none;">
              <comment id="_NSID_">
                <object id=EM_FILS_LOC classid=<%=Util.CLSID_EMEDIT%> width=500 tabindex=1 align="absmiddle" style="display:none;"></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/file_search.gif" border="0"  id="IMG_FILE_SEARCH"  onclick="javascript:loadExcelData();" align="absmiddle" hspace="3">
              <a href="/dps/samplefiles/SALE_BRAND_UPLOAD(Sample).xls" align="absmiddle" id=A_EXCEL_DOWN >
                <img src="/<%=dir%>/imgs/btn/excel_down.gif" border="0" align="absmiddle" >
              </a>
            </td >
          </tr>
        </table></td>
      </tr>
    </table></td>
  	</tr>
	<tr valign="top">
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
							<tr>
							<td width="100%">
								<comment id="_NSID_">
									<object id=GD_MASTER width=100% height=186 classid=<%=Util.CLSID_GRID%> tabindex=1>
										<param name="DataID" value="DS_O_MASTER">
									</object>
								</comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
<body>
</html>

