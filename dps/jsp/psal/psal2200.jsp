<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리
 * 작 성 일 : 2017.06.07
 * 작 성 자 : kjy
 * 수 정 자 : 
 * 파 일 명 : psal2200.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 규격단품 판매 엑셀 업로드등록
 * 이    력 : 2017.06.07 kjy
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
var gEvtFlag = true;	// 데이터셋 이벤트 실행여부 

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
	var strExcelHdr = "";
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader ('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_HS_MG.setDataHeader    ('<gauce:dataset name="H_SEL_HS_MG"/>');
    DS_TRAN_FLAG.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    // 엑셀업로드
    //DS_O_RESULT_EXCEL.setDataHeader('PUMBUN_CD:STRING(6), PUMMOK_CD:STRING(4), SKU_CD:STRING(13) ,SALE_PRC:INT(9),SALE_QTY:INT(3),CUST_CNT:INT(10)');
     strExcelHdr = '  SALE_DT:STRING(10) '
         		+  ', REG_NO:STRING(5) '
    			+  ', SALE_NO:STRING(10) '
    			+  ', SEQ_NO:STRING(10) '
    			+  ', EVT_CD:STRING(13) '
    			+  ', MODEL_NO:STRING(10) '
    			+  ', SKU_NAME:STRING(50) '
    			+  ', SALE_FLAG:STRING(10) '
    			+  ', SALE_TYPE:STRING(10) '
    			+  ', SALE_QTY:INT(13) '
    			+  ', COST_PRC:INT(13) '
    			+  ', SALE_RATE:INT(13) '
    			+  ', SALE_PRC:INT(13) '
    			+  ', CTG1:STRING(30) '
    			+  ', CTG2:STRING(30) '
    			+  ', CTG3:STRING(30) '
    			;
    DS_O_RESULT_EXCEL.setDataHeader(strExcelHdr);	
    
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
    EM_POS_NO.Text       = "9002";
    
    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';		// 로그인 점코드   
	var orgFlag = '<c:out value="${sessionScope.orgFlag}" />';
    getStore("DS_STR_CD", "Y", "", "N");			// 점
    
 	// 판매반품
    fnSetTranFlag();
    
    LC_STR_CD.BindColVal  = strcd;   
    LC_TRAN_FLAG.Index    = 0;   
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal220","DS_O_MASTER" );
    LC_STR_CD.Focus();
    
    
    document.getElementById("EM_POS_NO").style.display = "none";
    document.getElementById("LC_TRAN_FLAG").style.display = "none";
    
}

// 마스터
function gridCreate1(){
   /*
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
                     + '<G> name="상품코드"'
                     + '<FC>id=ITEM_CD       name="코드"         width=120   align=center    EditStyle=Popup edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=ITEM_NAME     name="명"           width=140   align=left      edit=none</FC>'
                     + '</G>'
                     + '<C>id=SALE_PRC       name="판매단가"     width=120   align=right     edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=SALE_QTY       name="판매수량"     width=120   align=right     edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=SALE_AMT       name="매출금액"     width=100   align=right     edit=none </C>'
                     + '<C>id=CUST_CNT       name="객수"         width=40    align=right     edit={IF(SysStatus="I","true","false")}</C>'
                     + '<C>id=PROC_FLAG      name="처리구분"     width=100   align=center    edit=none show=false </C>'
                     ;
    */
    
	var hdrProperies = '<FC>id={currow}      name="NO"           	width=20    align=center   </FC>'
			         + '<FC>id=CHK           name="선택"         	width=50    align=center    HeadCheckShow=true EditStyle=CheckBox </FC>'
			         + '<FC>id=STR_CD        name="점코드"           width=90   	align=center    edit=none   color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=SALE_DT       name="판매일자"         width=80   	align=center   displayformat="XXXX/XX/XX"  edit=none color={if(PROC_FLAG<>"","red")} </FC>'
			         + '<FC>id=REG_NO        name="레지번호"         width=80   	align=center   edit=none color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=SALE_NO       name="판매번호"         width=80   	align=center    edit=none  color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=SEQ_NO        name="명세순번"         width=80   	align=center  edit=none  color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=EVT_CD        name="행사코드"         width=80   	align=center   edit=none show=false </FC>'
			         + '<FC>id=PUMBUN_CD     name="브랜드코드"       width=80    align=center    EditStyle=Popup edit={IF(SysStatus="I","true","false")} edit=none color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=PUMBUN_NAME   name="브랜드명"         width=120   align=center      edit=none color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=SKU_CD        name="상품코드"         width=120    align=center  edit=none color={if(PROC_FLAG<>"","red")} </FC>'
			         + '<FC>id=MODEL_NO      name="브랜드상품코드"	width=100    align=center  edit=none color={if(PROC_FLAG<>"","red")} </FC>'
			         + '<FC>id=SKU_NAME      name="상품명"         	width=210    align=left    edit=none color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=SALE_FLAG  	 name="판매구분"         width=80   align=center		edit=none color={if(PROC_FLAG<>"","red")} </FC>'
			         + '<FC>id=SALE_TYPE 	 name="판매형태"       	width=80   	align=center  edit=none color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=SALE_QTY		 name="판매수량"         width=60   	align=center edit=none color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=COST_PRC		 name="판매단가"         width=80   align=center edit=none color={if(PROC_FLAG<>"","red")} </FC>'
			         + '<FC>id=SALE_RATE	 name="할인율"          	width=80   align=center edit=none color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=SALE_PRC		 name="판매금액"         width=80   align=center edit=none color={if(PROC_FLAG<>"","red")}</FC>'
			         + '<FC>id=CTG1			 name="대분류"          	width=120   align=center show = false </FC>'
			         + '<FC>id=CTG2			 name="중분류"         	width=120   align=center show = false </FC>'
			         + '<FC>id=CTG3			 name="소분류"          	width=120   align=center show = false </FC>'
			         + '<FC>id=PROC_FLAG     name="오류내용"     		width=500	align=left    edit=none color = "red" </FC>'
        			 ;
			         

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    GD_MASTER.Editable = "true";
	//그리드 엔터시 로우 추가
	//GD_MASTER.autorow     = "true";
	//GD_MASTER.autoevent   = "btn_New()";
	
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
    var strEtcGbn    = "2";					// 단품
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strSaleDt="   + encodeURIComponent(strSaleDt)
                   + "&strPosNo="    + encodeURIComponent(strPosNo)
                   + "&strTranFlag=" + encodeURIComponent(strTranFlag)
                   + "&strEtcGbn="   + encodeURIComponent(strEtcGbn)
                   ;
    
    TR_MAIN.Action="/dps/psal220.ps?goTo="+goTo+parameters;  
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
		
	DS_O_MASTER.Addrow();
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "STR_CD")    = strStrCd;
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "SALE_DT")   = strSaleDt;
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "POS_NO")    = strPosNo;
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "TRAN_FLAG") = strTrFlag;
	DS_O_MASTER.NameValue(DS_O_MASTER.Rowposition, "CUST_CNT")  = 1;

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
    TR_SAVE.Action="/dps/psal220.ps?goTo="+goTo+parameters;  
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
	            showMessage(Information, OK, "USER-1003","판매일자"); 
	            EM_SALE_DT.focus();
	            return false;
	        }
	        
	        //년월 자릿수, 공백 체크
	        if (EM_SALE_DT.text.replace(" ","").length != 8 ) {
	            showMessage(Information, OK, "USER-1027","판매일자","8");
	            EM_SALE_DT.focus();
	            return false;
	        }
	        
	        if(!checkYYYYMMDD(EM_SALE_DT.text)){
	        	showMessage(Information, OK, "USER-1004","판매일자");
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
                if (DS_O_MASTER.RowStatus(nRow)=="T") { 
	                var strRowStatus = DS_O_MASTER.RowStatus(nRow);
	                var strPbCd      = DS_O_MASTER.NameValue(nRow, "PUMBUN_NAME");
	                var strPmCd      = DS_O_MASTER.NameValue(nRow, "PUMMOK_NAME");
	                var strItemCd    = DS_O_MASTER.NameValue(nRow, "ITEM_NAME");
	                var strEvtFlag   = DS_O_MASTER.NameValue(nRow, "EVENT_FLAG");
	                var strEvtRate   = DS_O_MASTER.NameValue(nRow, "EVENT_RATE");
	                var nSalePrc     = DS_O_MASTER.NameValue(nRow, "SALE_PRC");
	                var nSaleQty     = DS_O_MASTER.NameValue(nRow, "SALE_QTY");
	                var nCustCnt     = DS_O_MASTER.NameValue(nRow, "CUST_CNT");
	                
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
	                    
	                    if(strItemCd == ""){
	                        showMessage(EXCLAMATION, OK, "USER-1003", "상품코드");
	                    	setFocusGrid(GD_MASTER, DS_O_MASTER, nRow, "ITEM_CD");
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
		    var OBJPARAMS = { PID     : "PSAl220"
			                , EVTFLAG : strEvt
			                , MULTI   : strMulti
					        , PARAMS  : { STR_CD      : objDs.NameValue(nDsRow, "STR_CD")
		      	                        , PUMBUN_CD   : objDs.NameValue(nDsRow, "PUMBUN_CD")
		    	                        , PUMBUN_TYPE : "0"
		    	                        , SKU_FLAG    : "1"
		    	                        , SKU_TYPE    : "1"
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
* getSkuPop(row, colid)
* 작 성 자 : 김경은
* 작 성 일 : 2010-02-28
* 개    요 :  단품 팝업  관련 데이터 조회 및 세팅
* return값 : void
*/
function getSkuPop(row, colid , popFlag){
    
    var strSkuCd        = DS_O_MASTER.NameValue(row, colid);
    var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
    var strStrCd        = DS_O_MASTER.NameValue(row, "STR_CD");
    var strPumbunCd     = DS_O_MASTER.NameValue(row, "PUMBUN_CD");
    var strPummokCd     = DS_O_MASTER.NameValue(row, "PUMMOK_CD");
    var strPumbunType   = "";                                     		// 브랜드유형
    var strBizType      = "1";                                          // 거래형태(1:직매입)
    var strUseYn        = "Y";                                        	// 사용여부   
    
    if (strPumbunCd == ""){
        showMessage(EXCLAMATION, Ok, "USER-1045", "브랜드"); 
        setFocusGrid(GD_MASTER, DS_O_MASTER, row, "PUMBUN_CD");
        return;
    }
    
//     if (strPummokCd == ""){
//         showMessage(EXCLAMATION, Ok, "USER-1045", "품목"); 
//         setFocusGrid(GD_MASTER, DS_O_MASTER, row, "PUMMOK_CD");
//         return;
//     }

	gEvtFlag = false;
    
    if(strPumbunCd != "" && popFlag != "1"){        
        var rtnMap = setStrSkuNmWithoutToGridPop( "DS_O_RESULT", strSkuCd, "", "Y", "1",
                strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType,
                strUseYn);
        if(rtnMap != null){
            DS_O_MASTER.NameValue(row, "ITEM_CD")   = rtnMap.get("SKU_CD");
            DS_O_MASTER.NameValue(row, "ITEM_NAME") = rtnMap.get("SKU_NAME");
        }       
    }else{
        if (popFlag =="1"){
    		var rtnMap = strSkuToGridPop(strSkuCd, "", "Y",
                    strUsrCd, strStrCd, strPumbunCd, strPumbunType, strBizType,
                    strUseYn);
    		
            if(rtnMap != null){         
        		
				DS_O_MASTER.NameValue(row, "ITEM_CD")   = rtnMap.get("SKU_CD");
				DS_O_MASTER.NameValue(row, "ITEM_NAME") = rtnMap.get("SKU_NAME");
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
    
    TR_MAIN.Action="/dps/psal220.ps?goTo="+goTo+parameters;  
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

	INF_EXCELUPLOAD.Value = "";
	EM_FILS_LOC.text = "";
	DS_O_RESULT_EXCEL.ClearData();
	DS_O_EXCELTEMP.ClearData();
	DS_O_MASTER.ClearData();
	
	INF_EXCELUPLOAD.Open();
	
	if (INF_EXCELUPLOAD.Value == "") return;
	
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
	

	searchSetWait("B");
	// Excel파일 DateSet에 저장               
    DS_O_RESULT_EXCEL.Do("Excel.Application", strOption);
	// Excel에서 가져온 DATASET을 화면에 보여줄 DATASET에 복사한다.
	var strData = DS_O_RESULT_EXCEL.ExportData(1,DS_O_RESULT_EXCEL.CountRow, true );
	DS_O_RESULT_EXCEL.Do("Excel.Close");
	DS_O_EXCELTEMP.ImportData(strData);
	
	//alert(DS_O_EXCELTEMP.CountRow);
	//return;

	gEvtFlag = false;
	
	var strStrCd  = LC_STR_CD.BindColVal;
	var strPosNo  = EM_POS_NO.Text;
	var strSaleDt = EM_SALE_DT.Text;
	var strTrFlag = LC_TRAN_FLAG.BindColVal;
	
	var strOrdFlag = "";
	var nFailCnt = 0;
	var strFailMsg = "";
	
	/* 엑셀Temp 데이터셋에 데이터를 Master에 넣어준다.  */
	for(nRow = 1; nRow <= DS_O_EXCELTEMP.CountRow; nRow++){
		/* 행추가 */
		
 		if (DS_O_EXCELTEMP.NameValue(nRow, "REG_NO") =="") {
 				DS_O_EXCELTEMP.DeleteRow(nRow);		
 		}
 		else {
		
// 			DS_O_MASTER.Addrow();
// 			/* 조회조건의 Key 값 세팅  */
 			DS_O_EXCELTEMP.NameValue(nRow, "CHK")       = "T";
 			DS_O_EXCELTEMP.NameValue(nRow, "STR_CD")    = strStrCd;
// 			//DS_O_MASTER.NameValue(nRow, "SALE_DT")   = strSaleDt;
// 			//DS_O_MASTER.NameValue(nRow, "POS_NO")    = strPosNo;
// 			//DS_O_MASTER.NameValue(nRow, "TRAN_FLAG") = strTrFlag;
// 			/* 엑셀 업로드 Master 데이터셋에 import */ 
			DS_O_EXCELTEMP.NameValue(nRow, "SALE_DT")   = DS_O_EXCELTEMP.NameValue(nRow, "SALE_DT").replace(/-/gi, "");
// 			DS_O_MASTER.NameValue(nRow, "REG_NO")    = DS_O_EXCELTEMP.NameValue(nRow, "REG_NO");
// 			DS_O_MASTER.NameValue(nRow, "SALE_NO")   = DS_O_EXCELTEMP.NameValue(nRow, "SALE_NO");
// 			DS_O_MASTER.NameValue(nRow, "SEQ_NO")    = DS_O_EXCELTEMP.NameValue(nRow, "SEQ_NO");
// 			DS_O_MASTER.NameValue(nRow, "EVT_CD")    = DS_O_EXCELTEMP.NameValue(nRow, "EVT_CD");
// 			DS_O_MASTER.NameValue(nRow, "MODEL_NO")  = DS_O_EXCELTEMP.NameValue(nRow, "MODEL_NO");
// 			DS_O_MASTER.NameValue(nRow, "SKU_NAME")  = DS_O_EXCELTEMP.NameValue(nRow, "SKU_NAME");
// 			DS_O_MASTER.NameValue(nRow, "SALE_FLAG") = DS_O_EXCELTEMP.NameValue(nRow, "SALE_FLAG");
// 			DS_O_MASTER.NameValue(nRow, "SALE_TYPE") = DS_O_EXCELTEMP.NameValue(nRow, "SALE_TYPE");
// 			DS_O_MASTER.NameValue(nRow, "SALE_QTY")  = DS_O_EXCELTEMP.NameValue(nRow, "SALE_QTY");
// 			DS_O_MASTER.NameValue(nRow, "COST_PRC")  = DS_O_EXCELTEMP.NameValue(nRow, "COST_PRC");
// 			DS_O_MASTER.NameValue(nRow, "SALE_RATE") = DS_O_EXCELTEMP.NameValue(nRow, "SALE_RATE");
// 			DS_O_MASTER.NameValue(nRow, "SALE_PRC")  = DS_O_EXCELTEMP.NameValue(nRow, "SALE_PRC");
// 			DS_O_MASTER.NameValue(nRow, "CTG1")    	 = DS_O_EXCELTEMP.NameValue(nRow, "CTG1");
// 			DS_O_MASTER.NameValue(nRow, "CTG2")    	 = DS_O_EXCELTEMP.NameValue(nRow, "CTG2");
// 			DS_O_MASTER.NameValue(nRow, "CTG3")    	 = DS_O_EXCELTEMP.NameValue(nRow, "CTG3");

				
		
			/* 브랜드명, 품목명, 행사구분, 행사율 값 조회 */
			searchExcel(nRow);
			
	        if(DS_HS_EXCEL.CountRow > 0){
	        /* 브랜드명, 품목명, 행사구분, 행사율 값 조회된 값 넣기 */
	        //alert( DS_HS_EXCEL.NameValue(1, "PUMBUN_NAME"));
	        	DS_O_EXCELTEMP.NameValue(nRow, "PUMBUN_CD") 		= DS_HS_EXCEL.NameValue(1, "PUMBUN_CD");
	        	DS_O_EXCELTEMP.NameValue(nRow, "PUMBUN_NAME") 		= DS_HS_EXCEL.NameValue(1, "PUMBUN_NAME");
	        	DS_O_EXCELTEMP.NameValue(nRow, "SKU_CD")    		= DS_HS_EXCEL.NameValue(1, "SKU_CD");
	        	//DS_O_MASTER.NameValue(nRow, "SAL_COST_PRC")		= DS_HS_EXCEL.NameValue(1, "SAL_COST_PRC");
	    		//DS_O_MASTER.NameValue(nRow, "SALE_PRC")    		= DS_HS_EXCEL.NameValue(1, "SALE_PRC");
	    		//DS_O_MASTER.NameValue(nRow, "TOT_SALE_PRC") 	= DS_HS_EXCEL.NameValue(1, "SALE_PRC") * DS_O_EXCELTEMP.NameValue(nRow, "ORD_QTY");
	    		//DS_O_MASTER.NameValue(nRow, "ITEM_NAME")    	= DS_HS_EXCEL.NameValue(1, "SKU_NAME");
        	}

			
	        
	        if (DS_O_EXCELTEMP.NameValue(nRow, "SKU_CD")=="") {
			
	        	DS_O_EXCELTEMP.NameValue(nRow, "PROC_FLAG") = "점내 등록된 상품이 없습니다.";
	        	DS_O_EXCELTEMP.NameValue(nRow, "CHK") = "F";
	        	nFailCnt++;
			
			}
	        
		}
	}
	
	strData = DS_O_EXCELTEMP.ExportData(1,DS_O_EXCELTEMP.CountRow, true );
	
	DS_O_MASTER.ImportData(strData);
	DS_O_EXCELTEMP.ClearData();
	DS_HS_EXCEL.ClearData();
	//매출기간 disable 처리
    enableCnt(false);
	gEvtFlag = true;
	sortColId(DS_O_MASTER , 0, "CHK")
	searchDoneWait();
	
	if (nFailCnt!=0) {
		strFailMsg = "  이 중 " + nFailCnt + "건의 오류 자료가 존재합니다.";
	} 
	
	showMessage(INFORMATION, OK, "USER-1000", DS_O_MASTER.CountRow + "건 업로드 완료하였습니다.<br><br>"+strFailMsg);
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

    var strStrCd        = DS_O_EXCELTEMP.NameValue(nRow, "STR_CD");
    var strSkuCd        = DS_O_EXCELTEMP.NameValue(nRow, "MODEL_NO");
    var strOrdDt        = DS_O_EXCELTEMP.NameValue(nRow, "SALE_DT");
    
    
    var goTo       = "searchExcel" ;    
    var action     = "O";     
    var parameters = "&strStrCd="       + encodeURIComponent(strStrCd)
                   + "&strSkuCd="       + encodeURIComponent(strSkuCd)
                   + "&strOrdDt="       + encodeURIComponent(strOrdDt)
                   ;
    
    TR_MAIN.Action="/dps/psal220.ps?goTo="+goTo+parameters;  
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
    //alert(eval(this.DataID)+" "+ row + " " + colid)
</script>

<!-- 그리드 헤더 체크박스 클릭시 -->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

	var objDs = eval(this.DataID);
	var strProcFlag = "";
	
	this.redraw = false;
    switch(Colid){
        case "CHK":
            for (var row = 1; row <= objDs.CountRow; row++) {
            	
            	strProcFlag = DS_O_MASTER.NameValue(row,"PROC_FLAG");
            	
            	if(strProcFlag == "") {
	            
            		if(bCheck){
	                	objDs.NameValue(row, "CHK") = "T";
	                }else{
	                	objDs.NameValue(row, "CHK") = "F";
	                }
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
        	break;
            break;

        case "ITEM_CD":			// 상품코드
        	getSkuPop(row ,colid ,'1');
        	break;
        default:
        	break;
    }
</script>

<!-- 데이터셋 값 변경 후 -->
<script language=JavaScript for=DS_O_MASTER event=OnColumnChanged(row,colid)>
    if(!gEvtFlag) return;
    
    switch(colid){
        
        case "PUMBUN_CD":		// 브랜드코드

            this.NameValue(row, "PUMBUN_NAME")  = "";
            this.NameValue(row, "PUMMOK_CD")    = "";
            this.NameValue(row, "PUMMOK_NAME")  = "";
            this.NameValue(row, "ITEM_CD")      = "";
            this.NameValue(row, "ITEM_NAME")    = "";
            this.NameValue(row, "ITEM_CD_TYPE") = "";
        	if(this.NameValue(row, colid) == "") return;
        
        	fnCallPopup("PUMBUN_CD", GD_MASTER, "EVT", "S");
            break;
            
        case "PUMMOK_CD":		// 품목코드
            this.NameValue(row, "PUMMOK_NAME") = "";
        	if(this.NameValue(row, colid) == "") return;
            getPummokPop(row , colid , "2");
            break;
            
        case "ITEM_CD":			// 상품코드
            this.NameValue(row, "ITEM_NAME") = "";
        	if(this.NameValue(row, colid) == "") return;
        	getSkuPop(row , colid , "2");
            break;

		// 판매금액 계산
        case "SALE_PRC":
        case "SALE_QTY":
        	var nSalePrc = this.NameValue(row, "SALE_PRC");
        	var nSaleQty = this.NameValue(row, "SALE_QTY");
        	this.NameValue(row, "SALE_AMT") = nSalePrc * nSaleQty;
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

<script language="javascript"  for=GD_MASTER event=OnCheckClick(Row,Colid,Check)>

    if (DS_O_MASTER.countrow >0) {
    	//alert("Occur OnCheckClick Event :" + "<ROW :" + Row +">"
        //     + "<Colid :" + Colid + ">" + "<CheckState :" + Check + ">")
        var strProcFlag = DS_O_MASTER.NameValue(Row, "PROC_FLAG");
        
    	if (strProcFlag != "") {
    		showMessage(Information, OK, "USER-1000","해당 데이터는 등록 대상으로 지정할 수 없습니다." 
    											   + "<br><b><font color=red> 〃" + strProcFlag + "〃</b>");
    		DS_O_MASTER.NameValue(Row, "CHK") = "F";
        }
        
    }
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

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TRAN_FLAG"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POP"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_HS_MG"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
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
								<th width="90" class="point">판매일자</th>
								<td width="105">
									<comment id="_NSID_">
										<object id=EM_SALE_DT classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1 align="absmiddle">
										</object> 
									</comment><script> _ws_(_NSID_);</script>
									<img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_SALE_DT)" align="absmiddle" />
								</td>
								<th width="90" class="point"></th>
								<td width="80">
									<comment id="_NSID_">
										<object id=LC_TRAN_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=75 tabindex=1 align="absmiddle">
										</object>
									</comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="90" class="point"></th>
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
            <th width="100" >파일선택</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_FILS_LOC classid=<%=Util.CLSID_EMEDIT%> width=500 tabindex=1 align="absmiddle" ></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/file_search.gif" border="0"  id="IMG_FILE_SEARCH"  onclick="javascript:loadExcelData();" align="absmiddle" hspace="3">
              <a href="/dps/samplefiles/SALE_SKUCD_UPLOAD(Sample).xls" align="absmiddle" id=A_EXCEL_DOWN>
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