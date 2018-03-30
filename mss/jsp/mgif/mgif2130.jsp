<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 입/출고> 상품권반납등록
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2130.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김성미) 신규작성
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
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>   

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

var strToday   ;
var btnClickSave = false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 165;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_IO_CONF.setDataHeader('<gauce:dataset name="H_CONF"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_RFD_DT, "TODAY", PK);                 //반납일자
    initEmEdit(EM_GIFT_S_NO, "GEN^18", NORMAL);           //시작 번호
    initEmEdit(EM_GIFT_E_NO, "GEN^18", NORMAL);         //종료번호
    //initEmEdit(EM_GIFT_S_NO, "NUMBER3^18", NORMAL);           //시작 번호
    //initEmEdit(EM_GIFT_E_NO, "NUMBER3^18", NORMAL);         //종료번호
   
    //콤보 초기화
    initComboStyle(LC_REQ_STR,DS_O_REQ_STR, "CODE^0^30,NAME^0^80", 1, PK);              //점구분
    initComboStyle(LC_POUT_TYPE,DS_O_POUT_TYPE, "CODE^0^30,NAME^0^180", 1, PK);  //반납유형
    initEmEdit(EM_O_EVENT_CD,   "GEN^11", NORMAL);         //행사코드(조회)
    initEmEdit(EM_O_EVENT_NAME, "GEN^40", READ);           //행사명(조회)
    
    
    getStore("DS_O_REQ_STR", "Y", "", "N");
    getEtcCode("DS_O_POUT_TYPE","D", "M014", "N","N",LC_POUT_TYPE);
    DS_O_REQ_STR.Filter();     // 점 : 본사점 제외 셋팅
    strToday   = getTodayDB("DS_O_RESULT");
    
    // 불출유형중 재무강제불출(특판)(6) 삭제
    //DS_O_POUT_TYPE.DeleteRow(DS_O_POUT_TYPE.NameValueRow("CODE","6"));
    
    LC_REQ_STR.Index = 0;
    LC_POUT_TYPE.Index = 0;
    
    LC_REQ_STR.focus();
    
    registerUsingDataset("mgif213","DS_IO_CONF");
} 

function gridCreate1(){

	
    var hdrProperies = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
			    	 + '<FC>id=FLAG                name="삭제"       EditStyle=checkbox width=50 HeadCheckShow=true  align=center</FC>'                
			         + '<FC>id=GIFT_TYPE_CD      name="상품권종류코드" SHOW=FALSE</FC>'
                     + '<FC>id=GIFT_TYPE_NAME      name="상품권종류" sumtext="합계"  edit=none   width=140   align=left sumtext="합계"</FC>'
                     + '<FC>id=GIFT_AMT_TYPE    name="금종" SHOW=FALSE</FC>'
                     + '<FC>id=GIFT_AMT_NAME    name="금종명"    edit=none width=140   align=left</FC>'
                     + '<FC>id=GIFT_S_NO    name="시작번호"    edit=none width=120   align=center</FC>'
                     + '<FC>id=GIFT_E_NO    name="종료번호"    edit=none width=120   align=center</FC>'
                     + '<FC>id=CONF_QTY    name="수량" sumtext=@sum   edit=none width=80   align=right sumtext=@sum</FC>'
                     + '<FC>id=CONF_AMT    name="반납금액" sumtext=@sum  edit=none  width=100   align=right sumtext=@sum</FC>'
                     + '<FC>id=EVENT_CD    name="행사코드" width=90   edit=none </FC>'
                     ;
                     
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
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    setObject(true);
    document.getElementById("CHK_SINGLE").checked = false;
    
    EM_O_EVENT_CD.Enable = false;
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
	var strPoutDt = EM_RFD_DT.Text;
    var strPoutType = LC_POUT_TYPE.BindColVal;      //반납유형
    var strStrCd = LC_REQ_STR.BindColVal;     
	 // 저장할 데이터 없는 경우
    if (DS_IO_CONF.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
    
    if(EM_RFD_DT.Text == ""){
        showMessage(EXCLAMATION , OK, "USER-1003", "반납일자");
        EM_RFD_DT.Focus();
        return;
    }
    
    /**
    if(EM_RFD_DT.Text < strToday){
        showMessage(EXCLAMATION , OK, "USER-1000", "반납일자는 오늘 이후로 선택하셔야합니다.");
        EM_RFD_DT.Focus();
        return;
    }
    **/
    // 필수 입력 사항 체크 
    if(!checkDSBlank( GD_MASTER, "6,7")) return;    
    
    //저장 
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    btnClickSave = true;
    
    var parameters = "&strPoutType="+ encodeURIComponent(strPoutType)
				   + "&strStrCd="   + encodeURIComponent(strStrCd)
				   + "&strPoutDt="  + encodeURIComponent(strPoutDt);
				    
    TR_MAIN.Action="/mss/mgif213.mg?goTo=save"+parameters;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_CONF=DS_IO_CONF)";
    TR_MAIN.Post();
    btnClickSave = false;

    //시작번호 초기화
    DS_IO_CONF_S.ClearData();
    DS_IO_CONF.ClearData();
   if(!CHK_SINGLE.checked){
       EM_GIFT_S_NO.Enable = true;
       EM_GIFT_E_NO.Enable = true;
       EM_GIFT_S_NO.Text = "";
       EM_GIFT_E_NO.Text = "";
   } else {
       EM_GIFT_S_NO.Enable = false;
       EM_GIFT_E_NO.Enable = true;
       EM_GIFT_S_NO.Text = "";
       EM_GIFT_E_NO.Text = "";
   }
    
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
 function setObject(flag) {
	
	if(DS_IO_CONF.CountRow > 0 && showMessage(QUESTION , YESNO, "USER-1050") != 1){
        return;
    }
 
	DS_IO_CONF_S.ClearData();
	DS_IO_CONF.ClearData();
	EM_GIFT_S_NO.Text = "";
	EM_GIFT_E_NO.Text = "";
	EM_GIFT_S_NO.Enable = flag;
	EM_GIFT_E_NO.Enable = flag;
	LC_REQ_STR.Enable = flag;
	EM_RFD_DT.Enable = flag;
	enableControl(IMG_DATE, flag);
	setTimeout("EM_GIFT_S_NO.Focus();",100);
	
    LC_POUT_TYPE.Enable = flag;
    EM_O_EVENT_CD.Enable = flag;
}
 
 /**
  * getConf()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-26
  * 개    요 : 확정내역 조회
  * return값 : void
  */
 function getConf (strFlag) {
    var strGiftNo = strFlag.Text;
    DS_IO_CONF_S.ClearData();
    
    var strRfdDt = EM_RFD_DT.Text;
    var strEvenCd = EM_O_EVENT_CD.Text; //행사
    var strPoutType = LC_POUT_TYPE.BindColVal;      //반납유형
    
    if(strRfdDt == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "반납일자");
        EM_GIFT_S_NO.Text = "";
        EM_RFD_DT.Focus();
        return false;
    }
    
    //alert(strEvenCd);
    if(strPoutType == "3"){
    	if (strEvenCd == "") {
	        showMessage(EXCLAMATION, OK, "USER-1000", "반납 유형이 사은행사지급용 일경우 행사는 필수 입력입니다.");
	        EM_GIFT_S_NO.Text = "";
	        EM_O_EVENT_CD.Focus();
	        return false;
    	}
    }
    
    var goTo       = "getConf" ;    
    var action     = "O";     
    
    //조회조건 
    var strGiftNo = strGiftNo;
    var strStrCd = LC_REQ_STR.BindColVal;      //반납유형
    var strPoutDt = EM_RFD_DT.Text ;           // 반납일자
    
    var parameters = "&strGiftNo="  + encodeURIComponent(strGiftNo)
                   + "&strPoutType="+ encodeURIComponent(strPoutType)
                   + "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strPoutDt="  + encodeURIComponent(strPoutDt)
                   ;
    TR_MAIN.Action="/mss/mgif213.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CONF_S=DS_IO_CONF_S)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_IO_CONF_S.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호가 없거나 불출유형이 반납유형과 다른 상품권번호 입니다.");
        if(strFlag.id == "EM_GIFT_S_NO"){
            EM_GIFT_S_NO.Text = "";
            setTimeout("EM_GIFT_S_NO.Focus();",100);
        }else{
            EM_GIFT_E_NO.Text = "";
            setTimeout("EM_GIFT_E_NO.Focus();",100);
        }
        
        return;
    }
    
    if(strFlag.id == "EM_GIFT_S_NO"){
        EM_GIFT_S_NO.Enable = false;
        DS_IO_CONF.AddRow();
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_TYPE_CD") = DS_IO_CONF_S.NameValue(1,"GIFT_TYPE_CD");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_TYPE_NAME") = DS_IO_CONF_S.NameValue(1,"GIFT_TYPE_NAME");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "ISSUE_TYPE") = DS_IO_CONF_S.NameValue(1,"ISSUE_TYPE");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_AMT_TYPE") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_TYPE");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_AMT_NAME") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_NAME");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFTCERT_AMT") = DS_IO_CONF_S.NameValue(1,"GIFTCERT_AMT");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_S_NO") = strGiftNo;
        
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "STR_CD") = LC_REQ_STR.BindColVal;
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "POUT_TYPE") = strPoutType;
        
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_DT") = strRfdDt;
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "EVENT_CD") = strEvenCd;
        
        
       
    }else{
    	if(!CHK_SINGLE.checked){
    		DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_E_NO") = strGiftNo;
    	} else {
    		DS_IO_CONF.AddRow();
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_TYPE_CD") = DS_IO_CONF_S.NameValue(1,"GIFT_TYPE_CD");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_TYPE_NAME") = DS_IO_CONF_S.NameValue(1,"GIFT_TYPE_NAME");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "ISSUE_TYPE") = DS_IO_CONF_S.NameValue(1,"ISSUE_TYPE");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_AMT_TYPE") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_TYPE");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_AMT_NAME") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_NAME");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFTCERT_AMT") = DS_IO_CONF_S.NameValue(1,"GIFTCERT_AMT");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "STR_CD") = LC_REQ_STR.BindColVal;
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "POUT_TYPE") = strPoutType;
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_S_NO") = strGiftNo;
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_E_NO") = strGiftNo;
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_DT") = strRfdDt;
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "EVENT_CD") = strEvenCd;
    	}
    	
        var parameters = "&strSGiftNo=" + encodeURIComponent(DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_S_NO"))
                       + "&strEGiftNo=" + encodeURIComponent(DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_E_NO"))
                       + "&strPoutType="+ encodeURIComponent(strPoutType)
                       + "&strPoutDt="  + encodeURIComponent(EM_RFD_DT.Text)
                       + "&strStrCd="   + encodeURIComponent(LC_REQ_STR.BindColVal)
                       ;
        TR_MAIN.Action="/mss/mgif213.mg?goTo=getCnt"+parameters;  
        TR_MAIN.KeyValue="SERVLET(O:DS_IO_CONF_CNT=DS_IO_CONF_CNT)"; //조회는 O
        TR_MAIN.Post();
        
        if(DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_CNT") == 0){
            showMessage(EXCLAMATION , OK, "USER-1000", "상품권 번호를 확인하세요.");
            EM_GIFT_E_NO.Text = "";
           setTimeout("EM_GIFT_E_NO.Focus();",100);
           return;
        }
        
        if(DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_CNT") != DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_ALL_CNT")){
           showMessage(STOPSIGN, OK, "USER-1000", "연속되지 않는 상품권 번호 입니다.");
           EM_GIFT_E_NO.Text = "";
           DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_E_NO") = "";
           setTimeout("EM_GIFT_E_NO.Focus();",100);
           return;
        }
        
        //수량 금액 셋팅
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_QTY") = DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_CNT");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_AMT") = DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_QTY") * DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFTCERT_AMT");        
        
        //시작번호 초기화
        if(!CHK_SINGLE.checked){
	        EM_GIFT_S_NO.Enable = true;
	        EM_GIFT_E_NO.Enable = true;
	        EM_GIFT_S_NO.Text = "";
	        EM_GIFT_E_NO.Text = "";
        } else {
        	EM_GIFT_S_NO.Enable = false;
        	EM_GIFT_E_NO.Enable = true;
            EM_GIFT_S_NO.Text = "";
            EM_GIFT_E_NO.Text = "";
        }
    }
    
    if(DS_IO_CONF.CountRow > 0 ) {
    	LC_REQ_STR.Enable = false;
	    EM_RFD_DT.Enable = false;
	    LC_POUT_TYPE.Enable = false;
	    EM_O_EVENT_CD.Enable = false;
	    enableControl(IMG_DATE, false);
    }else{ 
    	LC_REQ_STR.Enable = true;
	    EM_RFD_DT.Enable = true;
		LC_POUT_TYPE.Enable = true;
		EM_O_EVENT_CD.Enable = true;
	    enableControl(IMG_DATE, true);
    }
 }


 /**
  * onSingle()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-09
  * 개    요 : 한장씩 판매 등록
  * return값 : void
  */ 
 function onSingle(){
     if(CHK_SINGLE.checked){
         EM_GIFT_S_NO.Text = "";
         EM_GIFT_S_NO.Enable = false; 
         setTimeout("EM_GIFT_E_NO.Focus();",100);  
     }else{
         EM_GIFT_E_NO.Text = "";
         EM_GIFT_S_NO.Enable = true;
         setTimeout("EM_GIFT_S_NO.Focus();",100);  
     }
 }

 /**
  * delRow()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-09
  * 개    요 : 판매내역 삭제
  * return값 : void
  */ 
 function delRow(){
     if(DS_IO_CONF.CountRow == 0){
         showMessage(EXCLAMATION, OK, "USER-1019");
         return;
     }
     var strCnt = DS_IO_CONF.CountRow;
     var strDelCnt = 0;
     for(var i=1;i<=strCnt;i++){
         if(DS_IO_CONF.NameValue(i,"FLAG") == "T"){
             strDelCnt += 1;
             DS_IO_CONF.DeleteRow(i);     
             i = i -1;
         }
     }
     
     if(strDelCnt == 0){
         showMessage(EXCLAMATION, OK, "USER-1019");
         return;
     }
     
     GD_MASTER.ColumnProp('FLAG','HeadCheck')= "FALSE";
     if(DS_IO_CONF.CountRow > 0 ){
    	 LC_REQ_STR.Enable = false;
    	 EM_RFD_DT.Enable = false;
         LC_POUT_TYPE.Enable = false;
         EM_O_EVENT_CD.Enable = false;
         enableControl(IMG_DATE, false);
     } else {
    	 LC_REQ_STR.Enable = true;
    	 EM_RFD_DT.Enable = true;
         LC_POUT_TYPE.Enable = true;
         EM_O_EVENT_CD.Enable = true;
         enableControl(IMG_DATE, true);
     }
     
     if(CHK_SINGLE.checked){
         EM_GIFT_S_NO.Text = "";
         EM_GIFT_S_NO.Enable = false;
     }else{
    	 EM_GIFT_S_NO.Text = "";
         EM_GIFT_E_NO.Text = "";
         EM_GIFT_S_NO.Enable = true;
     }
     
     setTimeout("EM_GIFT_S_NO.Focus();",100);
 }

--></script>


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
<script language=JavaScript for=DS_O_REQ_STR event=OnFilter(row)>
if (DS_O_REQ_STR.NameValue(row, "GBN") != "0") {// 본사점 제외
    return true;
}
return false;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=LC_POUT_TYPE event=OnSelChange()>
    if(LC_POUT_TYPE.BindColVal == "3") {
        EM_O_EVENT_CD.Text = "";
        EM_O_EVENT_NAME.Text = "";
        EM_O_EVENT_CD.Enable = true;
        enableControl(EventImg, true);
    }
    else {
        EM_O_EVENT_CD.Text = "";
        EM_O_EVENT_NAME.Text = "";
        EM_O_EVENT_CD.Enable = false;
        enableControl(EventImg, false);
        
    }
</script> 

<script language=JavaScript for=EM_GIFT_S_NO event=onKillFocus()>
if(!this.Modified)
    return;
if( EM_GIFT_S_NO.Text ==""){
       return;
   }
if(EM_GIFT_S_NO.Text.length == 12 || EM_GIFT_S_NO.Text.length == 13 || EM_GIFT_S_NO.Text.length == 16 || EM_GIFT_S_NO.Text.length == 18){
    for(var i=1;i<=DS_IO_CONF.CountRow;i++){
        if( DS_IO_CONF.NameValue(i,"GIFT_S_NO")<=EM_GIFT_S_NO.Text &&  EM_GIFT_S_NO.Text <=DS_IO_CONF.NameValue(i,"GIFT_E_NO")) {
            showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호가 중복됩니다.");
            this.Text = "";
            setTimeout("EM_GIFT_S_NO.Focus();",100);
            return;
        }
    }
    //하단 확정 내역 조회 
    getConf(this);
 //   setTimeout("EM_GIFT_S_NO.Focus();",100);
}
</script>
<script language=JavaScript for=EM_GIFT_E_NO event=onKillFocus()>
if(!this.Modified)
    return;
if( EM_GIFT_E_NO.Text ==""){
       return;
   }
if(EM_GIFT_E_NO.Text.length == 12 || EM_GIFT_E_NO.Text.length == 13 || EM_GIFT_E_NO.Text.length == 16 || EM_GIFT_E_NO.Text.length == 18){
	//개별 등록 일경우는 그냥 추가 
	if(!CHK_SINGLE.checked){
	    if(EM_GIFT_S_NO.Text == ""){
	        showMessage(EXCLAMATION , OK, "USER-1000", "시작번호를 먼저 스캔해 주세요.");
	        this.Text = "";
	        setTimeout("EM_GIFT_S_NO.Focus();",100);
	        return;
	    }
	    if(EM_GIFT_E_NO.Text < EM_GIFT_S_NO.Text){
	        showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호를 확인해 주세요.");
	        this.Text = "";
	        setTimeout("EM_GIFT_E_NO.Focus();",100);
	        return;
	    }
	} 
	
    for(var i=1;i<=DS_IO_CONF.CountRow;i++){
        if( DS_IO_CONF.NameValue(i,"GIFT_S_NO")<=EM_GIFT_E_NO.Text &&  EM_GIFT_E_NO.Text <=DS_IO_CONF.NameValue(i,"GIFT_E_NO")) {
            showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호가 중복됩니다.");
            this.Text = "";
            setTimeout("EM_GIFT_E_NO.Focus();",100);
            return;
        }
    }
    getConf(this); 
    
    if(!CHK_SINGLE.checked){ 
	    if(EM_GIFT_S_NO.Text != ""){ 
	        setTimeout("EM_GIFT_E_NO.Focus();",100); 
	    }
	    else { 
	        setTimeout("EM_GIFT_S_NO.Focus();",100);  
	    }
	 }
    else {
        setTimeout("EM_GIFT_E_NO.Focus();",100);  
    }
    	
}
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
        strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_IO_CONF.CountRow;i++){
    	DS_IO_CONF.NameValue(i,"FLAG") = strFlag;
    }
</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_REQ_STR" classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_POUT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_I_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CONF"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CONF_S"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_CONF_CNT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

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
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="150">
                <comment id="_NSID_">
                   <object id=LC_REQ_STR classid=<%= Util.CLSID_LUXECOMBO %>  tabindex=1 height=100 width=120 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script>
              </td>
            <th width="80" class="point">반납일자</th>
            <td width="150">
                <comment id="_NSID_">
                  <object id=EM_RFD_DT classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_DATE" onclick="javascript:openCal('G',EM_RFD_DT)" align="absmiddle" />
            </td>
            <th width="80" class="point">반납유형</th>
            <td>
                <comment id="_NSID_">
                       <object id=LC_POUT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1  height=100 width=150 align="absmiddle">
                       </object>
                 </comment><script>_ws_(_NSID_);</script> 
            </td>
          </tr> 
          <tr>
         <th width="80">행사</th>
         <td colspan=5>
                 <comment id="_NSID_">
                       <object id=EM_O_EVENT_CD classid=<%=Util.CLSID_EMEDIT%>   width=90 tabindex=1 align="absmiddle">
                       </object>
                 </comment><script>_ws_(_NSID_);</script> 
                 <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"  id=EventImg  
                      onclick="javascript:mssEventMstPop('SEL_STR_EVENT_POP',EM_O_EVENT_CD,EM_O_EVENT_NAME,LC_REQ_STR.BindColVal, '4/6');"  class="PR03"/> 
                 <comment id="_NSID_">
                       <object id=EM_O_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%>   width=300 tabindex=1 align="absmiddle">
                       </object>
                 </comment><script>_ws_(_NSID_);</script>
            </td>
         </tr>
        </table>
        </td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
    <td class="PB05">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
               <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
	          <tr>
	            <th width="80">시작번호</th>
	            <td width="150">
	                <comment id="_NSID_">
	                  <object id=EM_GIFT_S_NO classid=<%=Util.CLSID_EMEDIT%>   width=140 tabindex=1 align="absmiddle">
	                  </object></comment><script>_ws_(_NSID_);</script>
	              </td>
	            <th width="80">종료번호</th>
	            <td width="150">
	                <comment id="_NSID_">
	                  <object id=EM_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=140 tabindex=1 align="absmiddle">
	                  </object></comment><script>_ws_(_NSID_);</script>
	            </td>
	            <th  width="80">개별 등록</th>
                <td>
                <input type="checkbox" id=CHK_SINGLE align="absmiddle" onclick="javascript:onSingle();" tabindex=1 > 
                </td>
	          </tr> 
	        </table>
            </td>
             <td class="right">
                 <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="javascript:delRow();" />
             </td>
       </tr>
        </table>
    </td>
  </tr>
    <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" onclick="javascript:delRow();">
     <tr>
     <td>
         <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=720 classid=<%=Util.CLSID_GRID%>>
             <param name="DataID" value="DS_IO_CONF">
         </OBJECT></comment><script>_ws_(_NSID_);</script>
     </td>  
      </tr>
     </table> 
    </td>
    </tr>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

