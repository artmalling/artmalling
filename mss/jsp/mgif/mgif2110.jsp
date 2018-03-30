<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 출/입고> 점내 불출신청 확정 확정
 * 작 성 일 : 2011.01.17
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif2110.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.17 (김성미) 신규작성
 *        2011.05.18 (신익수) 프로그램 작성 
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

//디테일 조회 두번 막기 위해 
var old_Row = 0;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strToday   ;
 var btnClickSave = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 435;		//해당화면의 동적그리드top위치
 var top2 = 435;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_CONF"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    // Input Data Set Header 초기화
    DS_IO_CONF.setDataHeader('<gauce:dataset name="H_CONF"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DT, "SYYYYMMDD", PK);                 						//기간 : 시작
    initEmEdit(EM_E_DT, "TODAY", PK);											//기간 : 종료
    initEmEdit(EM_OUT_DT,"TODAY",PK);
    
    initEmEdit(EM_O_ORG_CD, "GEN^10", NORMAL);  								//조직코드(조회)
    initEmEdit(EM_O_ORG_NM, "GEN^40", READ);  									//조직명 (조회)
    initEmEdit(EM_GIFT_S_NO, "GEN^18", NORMAL);           					//시작 번호
    initEmEdit(EM_GIFT_E_NO, "GEN^18", NORMAL);         					//종료번호
    //initEmEdit(EM_GIFT_S_NO, "NUMBER3^18", NORMAL);           					//시작 번호
    //initEmEdit(EM_GIFT_E_NO, "NUMBER3^18", NORMAL);         					//종료번호
    
    //initComboStyle(LC_O_CONF_FLAG,"", "CODE^0^30,NAME^0^60", 1, NORMAL);    	//확정구분(조회)
    initComboStyle(LC_REQ_STR,DS_O_REQ_STR, "CODE^0^30,NAME^0^80", 1, PK);      //점구분
    initComboStyle(LC_POUT_TYPE,DS_O_POUT_TYPE, "CODE^0^30,NAME^0^180", 1, NORMAL);  //불출유형   
    
    getStore("DS_O_REQ_STR", "Y", "", "N");
    getEtcCode("DS_O_POUT_TYPE","D", "M014", "Y","N",LC_POUT_TYPE);
    
    strToday   = getTodayDB("DS_O_RESULT");
    setObject(false);
  
    LC_REQ_STR.Index = 0;
    LC_POUT_TYPE.Index = 0;
    //LC_O_CONF_FLAG.Index = 0; //확정구분(조회)
    
    LC_REQ_STR.focus();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif211", "DS_IO_CONF");   
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"         width=30   align=center</FC>'
			    	+ '<FC>id=STR_CD        name="점코드"  show=false   </FC>'
			    	+ '<FC>id=STR_NAME      name="점"    sumtext="합계"   width=80  align=left </FC>'
			    	+ '<FC>id=ORG_CD        name="부서코드"     show=false</FC>'
			    	+ '<FC>id=ORG_NAME      name="신청부서"     width=180   align=left</FC>'
			    	+ '<FC>id=POUT_TYPE     name="불출유형코드"  show=false</FC>'
			    	+ '<FC>id=POUT_NAME     name="불출유형"     width=140   align=left</FC>'
                    + '<FC>id=EVENT_CD      name="행사코드"   width=100   align=center</FC>'
                    + '<FC>id=EVENT_NAME    name="행사명"     width=120   align=left</FC>'
			    	+ '<FC>id=POUT_REQ_DT   name="신청일자"    width=80 mask="XXXX/XX/XX" align=center</FC>'
			    	+ '<FC>id=POUT_REQ_SLIP_NO  name="순번"     width=80   align=center</FC>'
			    	+ '<FC>id=REQ_QTY       name="신청수량"  sumtext=@sum   width=80   align=right</FC>'
			    	+ '<FC>id=TOT_AMT       name="신청금액"  sumtext=@sum   width=100   align=right</FC>'
			    	+ '<FC>id=CONF_FLAG     name="확정구분코드"    show=false</FC>'
			    	;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			    	  + '<FC>id=GIFT_TYPE_NAME     name="상품권종류" width=90   show=true align=left</FC>'
			    	  + '<FC>id=ISSUE_TYPE     name="발행형태"  show=false</FC>'
			    	  + '<FC>id=GIFT_AMT_TYPE     name="금종"  show=false</FC>'
			    	  + '<FC>id=GIFT_AMT_NAME     name="금종명"  sumtext="합계"    width=70   align=left</FC>'
			    	  + '<FC>id=REQ_QTY           name="신청수량"  sumtext=@sum    width=70   align=right</FC>'
			    	  + '<FC>id=REQ_AMT           name="신청금액"  sumtext=@sum    width=70   align=right</FC>';
        
    initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
    
    var hdrProperies2 = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                        + '<FC>id=GIFT_TYPE_NAME     name="상품권종류" width=90 align=left</FC>'
				        + '<FC>id=GIFT_AMT_NAME         name="금종명"  sumtext="합계"   width=70   align=left</FC>'
				        + '<FC>id=GIFTCERT_AMT          name="상품권금액"       width=100  align=right</FC>'
				        + '<FC>id=GIFT_S_NO             name="시작번호"     width=140   align=center</FC>'
				        + '<FC>id=GIFT_E_NO             name="종료번호"     width=140   align=center</FC>'
				        + '<FC>id=CONF_QTY               name="수량"  sumtext=@sum   width=100   align=right</FC>'
				        + '<FC>id=CONF_AMT               name="불출금액"  sumtext=@sum   width=100   align=right</FC>'
				        ;
      		        
    initGridStyle(GD_CONF, "common", hdrProperies2, false);
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-26
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    /**
     if(DS_IO_CONF.IsUpdated){
        if(showMessage(QUESTION , YESNO, "USER-1072") != 1 ){
            return;
        }
    }**/
    
    // 조회조건 셋팅
    var strStrCd = LC_REQ_STR.BindColVal;     //점코드
    var strOrgCd = EM_O_ORG_CD.Text;        //부서
    var strSdt          = EM_S_DT.Text;     //신청기간 from
    var strEdt          = EM_E_DT.Text;       //신청기간 to
    var strPoutType = LC_POUT_TYPE.BindColVal;      //불출유형
    //var strConfGb =   LC_O_CONF_FLAG.BindColVal;      //확정구분
    
    if(strEdt < strSdt) {
        showMessage(EXCLAMATION , OK, "USER-1015");
        EM_S_DT.Focus();
        return;
    }
    
    //데이타 셋 클리어
    DS_O_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    DS_IO_CONF.ClearData();
  
    
    EM_OUT_DT.Text = "";
    EM_GIFT_S_NO.Text = "";
    EM_GIFT_E_NO.Text = "";
    
    setObject(false);
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strOrgCd="   + encodeURIComponent(strOrgCd)
                   + "&strSdt="     + encodeURIComponent(strSdt)
                   + "&strEdt="     + encodeURIComponent(strEdt)
                   + "&strPoutType="+ encodeURIComponent(strPoutType);
                   //+ "&strConfGb="+ encodeURIComponent(strConfGb);
    
    TR_MAIN.Action="/mss/mgif211.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    old_Row = 1;
    
    // 조회결과 Return
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
}

/**
 * btn_Save()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-26
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-04-26
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
     // 저장할 데이터 없는 경우
    if (DS_IO_CONF.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
     
    
    if(EM_OUT_DT.Text == ""){
        showMessage(EXCLAMATION , OK, "USER-1003", "불출일자");
        EM_OUT_DT.Focus();
        return;
    }
    
    var strReqDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_DT");
    if(EM_OUT_DT.Text < strReqDt){
    	showMessage(EXCLAMATION, OK, "USER-1008", "불출일자", "신청일자");
        //showMessage(EXCLAMATION , OK, "USER-1000", "불출일자는 오늘 이후로 선택하셔야합니다.");
        EM_OUT_DT.Text = strReqDt;
        EM_OUT_DT.Focus();
        return;
    }
    
    
    // 필수 입력 사항 체크 
//   if(!checkDSBlank( GD_CONF, "1,2,3,4,5")) return;    
 
    // 신청내역과 확정내역 수량 체크
    for(var i=1;i<=DS_O_DETAIL.CountRow;i++){
        if(DS_O_DETAIL.NameValue(i,"REQ_QTY") != DS_O_DETAIL.NameValue(i,"CONF_QTY")){
             showMessage(EXCLAMATION , OK, "USER-1000", DS_O_DETAIL.NameValue(i,"GIFT_AMT_NAME") + "의 신청수량과 출고수량을 확인해주세요.");
             return;
        }
    }
    
    //확정 확인
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    btnClickSave = true;
  
    var row = DS_O_MASTER.RowPosition;
    var strReqDt = DS_O_MASTER.NameValue(row, "POUT_REQ_DT");
    var strReqStr = DS_O_MASTER.NameValue(row, "STR_CD");
    var strReqSlipNo = DS_O_MASTER.NameValue(row, "POUT_REQ_SLIP_NO");
    var strConfDt = EM_OUT_DT.Text;
    var strOrgCd = DS_O_MASTER.NameValue(row, "ORG_CD");
    //alert("strOrgCd===="+strOrgCd);
    var parameters = "&strReqDt="     + encodeURIComponent(strReqDt)
                    + "&strReqStr="   + encodeURIComponent(strReqStr)
                    + "&strReqSlipNo="+ encodeURIComponent(strReqSlipNo)
                    + "&strConfDt="   + encodeURIComponent(strConfDt)
                    + "&strOrgCd="    + encodeURIComponent(strOrgCd); 
    
    TR_MAIN.Action="/mss/mgif211.mg?goTo=save"+parameters;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_CONF=DS_IO_CONF)";
    TR_MAIN.Post();
    btnClickSave = false;
    if(TR_MAIN.ErrorCode == 0) btn_Search();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getDetail()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-18
  * 개    요 : 하단 상세 조회
  * return값 : void
  */
 function getDetail () {
    var row = DS_O_MASTER.RowPosition;
    var strReqDt = DS_O_MASTER.NameValue(row, "POUT_REQ_DT");
    var strReqStr = DS_O_MASTER.NameValue(row, "STR_CD");
    var strReqSlipNo = DS_O_MASTER.NameValue(row, "POUT_REQ_SLIP_NO");
    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strReqDt="     + encodeURIComponent(strReqDt)
                    + "&strReqStr="   + encodeURIComponent(strReqStr)
                    + "&strReqSlipNo="+ encodeURIComponent(strReqSlipNo);
    
    TR_DETAIL.Action="/mss/mgif211.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_O_DETAIL.CountRow > 0 )  
	
    	//확정일경우 
    if (DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CONF_FLAG") == "1") {
    	setObject(false);
    } else {
    	setObject(true);
    }
    	
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
    
    var goTo       = "getConf" ;    
    var action     = "O";     
    
    //마스트 그리드 정보 
    var strStrCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");
    var strPoutDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_DT");
    var strSlipNo = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_SLIP_NO");
    var strOutDt = EM_OUT_DT.Text;
    var strGiftNo = strGiftNo;
    
    var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)
                   + "&strGiftNo="+ encodeURIComponent(strGiftNo)
                   + "&strPoutDt="+ encodeURIComponent(strPoutDt)
                   + "&strSlipNo="+ encodeURIComponent(strSlipNo)
                   + "&strGiftNo="+ encodeURIComponent(strGiftNo)
                   + "&strOutDt=" + encodeURIComponent(strOutDt)
                   ;
    TR_DETAIL.Action="/mss/mgif211.mg?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_CONF_S=DS_IO_CONF_S)"; //조회는 O
    TR_DETAIL.Post();
    
    if(DS_IO_CONF_S.CountRow == 0){
        showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호가 없거나 신청내역에 없는 상품권 번호 입니다.");
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
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "EVENT_CD") = DS_IO_CONF_S.NameValue(1,"EVENT_CD");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_S_NO") = strGiftNo;
        
    }else{
    	if(!CHK_SINGLE.checked){
	        if((DS_IO_CONF.NameValue(DS_IO_CONF.CountRow,"GIFT_TYPE_CD") != DS_IO_CONF_S.NameValue(1, "GIFT_TYPE_CD"))
	                || (DS_IO_CONF.NameValue(DS_IO_CONF.CountRow,"ISSUE_TYPE") != DS_IO_CONF_S.NameValue(1, "ISSUE_TYPE"))
	                || (DS_IO_CONF.NameValue(DS_IO_CONF.CountRow,"GIFT_AMT_TYPE") != DS_IO_CONF_S.NameValue(1, "GIFT_AMT_TYPE"))){
	            showMessage(EXCLAMATION , OK, "USER-1000", "상품권 금종을 확인하세요.");
	            EM_GIFT_E_NO.Text = "";
	            setTimeout("EM_GIFT_E_NO.Focus();",100);
	            return;
	        }
    	}else{
    		DS_IO_CONF.AddRow();
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_TYPE_CD") = DS_IO_CONF_S.NameValue(1,"GIFT_TYPE_CD");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_TYPE_NAME") = DS_IO_CONF_S.NameValue(1,"GIFT_TYPE_NAME");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "ISSUE_TYPE") = DS_IO_CONF_S.NameValue(1,"ISSUE_TYPE");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_AMT_TYPE") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_TYPE");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_AMT_NAME") = DS_IO_CONF_S.NameValue(1,"GIFT_AMT_NAME");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFTCERT_AMT") = DS_IO_CONF_S.NameValue(1,"GIFTCERT_AMT");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "EVENT_CD") = DS_IO_CONF_S.NameValue(1,"EVENT_CD");
            DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_S_NO") = strGiftNo;
            
    		DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_S_NO") = strGiftNo;
    	}
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_E_NO") = strGiftNo;

        var parameters = "&strSGiftNo=" + encodeURIComponent(DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_S_NO"))
                       + "&strEGiftNo=" + encodeURIComponent(DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_E_NO"))
                       + "&strStrCd="   + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD"))
                       + "&strPoutDt="  + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_DT"))
                       + "&strSlipNo="  + encodeURIComponent(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_SLIP_NO"))
                       + "&strOutDt="   + encodeURIComponent(strOutDt)
                       ;
        TR_DETAIL.Action="/mss/mgif211.mg?goTo=getCnt"+parameters;  
        TR_DETAIL.KeyValue="SERVLET(O:DS_IO_CONF_CNT=DS_IO_CONF_CNT)"; //조회는 O
        TR_DETAIL.Post();
        
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
             setTimeout("EM_GIFT_E_NO.Focus();", 100);
             return;
        }
        
        var strSum = 0;
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_QTY") = DS_IO_CONF_CNT.NameValue(1,"GIFTCARD_CNT");
        DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_AMT") = DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_QTY") * DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFTCERT_AMT");
        for(var i=1;i<=DS_O_DETAIL.CountRow;i++){
            if((DS_O_DETAIL.NameValue(i,"GIFT_TYPE_CD") == DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_TYPE_CD"))
                    && (DS_O_DETAIL.NameValue(i,"ISSUE_TYPE") == DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "ISSUE_TYPE"))
                    && (DS_O_DETAIL.NameValue(i,"GIFT_AMT_TYPE") == DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_AMT_TYPE"))){
                strSum = DS_O_DETAIL.NameValue(i,"CONF_QTY") + DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_QTY");
                
                DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "POUT_REQ_DT") = DS_O_DETAIL.NameValue(i,"POUT_REQ_DT");
                DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "STR_CD") = DS_O_DETAIL.NameValue(i,"STR_CD");
                DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "POUT_REQ_SLIP_NO") = DS_O_DETAIL.NameValue(i,"POUT_REQ_SLIP_NO");
                DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "POUT_REQ_SEQ_NO") = DS_O_DETAIL.NameValue(i,"POUT_REQ_SEQ_NO");
                DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "POUT_TYPE") = DS_O_DETAIL.NameValue(i,"POUT_TYPE");
                
                if(strSum > DS_O_DETAIL.NameValue(i,"REQ_QTY")){
                    showMessage(EXCLAMATION , OK, "USER-1000", "확정수량이 신청수량보다 많습니다. 수량을 확인하세요.");
                    DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "GIFT_E_NO") = "";
                    DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_QTY") = "";
                    DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_AMT") = "";
                    EM_GIFT_E_NO.Text = "";
                    setTimeout("EM_GIFT_E_NO.Focus();",100);
                    return;
                }else{
                    DS_O_DETAIL.NameValue(i,"CONF_QTY") = DS_O_DETAIL.NameValue(i,"CONF_QTY") + DS_IO_CONF.NameValue(DS_IO_CONF.CountRow, "CONF_QTY");
                    EM_GIFT_S_NO.Text = "";
                    EM_GIFT_E_NO.Text = "";
                    if(!CHK_SINGLE.checked){
                        EM_GIFT_S_NO.Enable = true;
                        setTimeout("EM_GIFT_S_NO.Focus();",100);
                    }else{
                    	 setTimeout("EM_GIFT_E_NO.Focus();",100);
                    }
                    DS_O_DETAIL.ResetStatus();
                }
                
            }
        }
        
    }
 }
 
 function setObject(flag){
	enableControl(IMG_CAL, flag);
	enableControl(IMG_DELROW, flag);
	
    EM_OUT_DT.Enable = flag;
    
    if(flag)      
        CHK_SINGLE.disabled = false;
    else
        CHK_SINGLE.disabled = true;
    
    if(CHK_SINGLE.checked || !flag) 
    	EM_GIFT_S_NO.Enable = false;
    else
    	EM_GIFT_S_NO.Enable = true;
    
    EM_GIFT_E_NO.Enable = flag;
    
    if(flag){        
        EM_OUT_DT.Text = strToday;
    }
    
}

 function delRow(){
     for(var i=1;i<=DS_O_DETAIL.CountRow;i++){
         if((DS_O_DETAIL.NameValue(i,"GIFT_TYPE_CD") == DS_IO_CONF.NameValue(DS_IO_CONF.Rowposition, "GIFT_TYPE_CD"))
                 && (DS_O_DETAIL.NameValue(i,"ISSUE_TYPE") == DS_IO_CONF.NameValue(DS_IO_CONF.Rowposition, "ISSUE_TYPE"))
                 && (DS_O_DETAIL.NameValue(i,"GIFT_AMT_TYPE") == DS_IO_CONF.NameValue(DS_IO_CONF.Rowposition, "GIFT_AMT_TYPE"))){
             DS_O_DETAIL.NameValue(i,"CONF_QTY") = DS_O_DETAIL.NameValue(i,"CONF_QTY") - DS_IO_CONF.NameValue(DS_IO_CONF.Rowposition, "CONF_QTY");
         }
     }
     DS_IO_CONF.DeleteRow(DS_IO_CONF.CountRow);
     
     EM_GIFT_S_NO.Text = "";
     EM_GIFT_E_NO.Text = "";
     if(CHK_SINGLE.checked){
    	 EM_GIFT_S_NO.Enable = false; 
    	 EM_GIFT_E_NO.Enable = true;
         EM_GIFT_E_NO.Focus();
     }else{
    	 EM_GIFT_S_NO.Enable = true; 
    	 EM_GIFT_E_NO.Enable = true;
         EM_GIFT_S_NO.Focus();
     }
     
 } 
 
 function chkOutDt(){
     if(!checkDateTypeYMD(EM_OUT_DT)) return;
     
     var strReqDt = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"POUT_REQ_DT");
     if(EM_OUT_DT.Text < strReqDt){
         showMessage(EXCLAMATION, OK, "USER-1008", "불출일자", "신청일자");
         //showMessage(EXCLAMATION , OK, "USER-1000", "불출일자는 오늘 이후로 선택하셔야합니다.");
         EM_OUT_DT.Text = strReqDt;
         EM_OUT_DT.Focus();
         return;
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
         EM_GIFT_E_NO.Focus();
     }else{
         EM_GIFT_E_NO.Text = "";
         EM_GIFT_S_NO.Enable = true;
         EM_GIFT_S_NO.Focus();
     }
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

<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000",TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_REQ_STR event=OnFilter(row)>
if (DS_O_REQ_STR.NameValue(row, "GBN") == "0") {// 매장점 만 셋팅
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(row > 0 && old_Row != row ){
	if (DS_O_MASTER.CountRow > 0) {
		
	    //디테일 조회
	    getDetail();
	    // 조회결과 Return
	    setPorcCount("SELECT", GD_DETAIL);
	 
	    EM_OUT_DT.Text = strToday;
    }
}
old_Row = row;
</script>
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
if(DS_IO_CONF.IsUpdated && !btnClickSave){
    if(showMessage(QUESTION , YESNO, "USER-1049") == 1 ){
        DS_IO_CONF.ClearData();
        return true;
    }else{
        return false;
    }
}
return true;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row ==0) sortColId( eval(this.DataID), row , colid ); return;
</script>
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
if(row ==0) sortColId( eval(this.DataID), row , colid ); return;
</script>
<script language=JavaScript for=GD_CONF event=OnClick(row,colid)>
if(row ==0) sortColId( eval(this.DataID), row , colid ); return;
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
}
</script>
<script language=JavaScript for=EM_GIFT_E_NO event=onKillFocus()>
if(!this.Modified)
    return;
if( EM_GIFT_E_NO.Text ==""){
       return;
   }

if(EM_GIFT_E_NO.Text.length == 12 || EM_GIFT_E_NO.Text.length == 13 || EM_GIFT_E_NO.Text.length == 16 || EM_GIFT_E_NO.Text.length == 18){
	if(!CHK_SINGLE.checked){
    if(EM_GIFT_S_NO.Text == ""){
        showMessage(EXCLAMATION , OK, "USER-1000", "시작번호를 먼저 스캔해 주세요.");
        this.Text = "";
        setTimeout("EM_GIFT_S_NO.Focus();",100);
        return;
    }
	}
    if(EM_GIFT_E_NO.Text < EM_GIFT_S_NO.Text){
        showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호를 확인해 주세요.");
        this.Text = "";
        setTimeout("EM_GIFT_E_NO.Focus();",100);
        return;
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
}

</script>

<script language=JavaScript for=LC_REQ_STR event=OnSelChange()>
    EM_O_ORG_CD.Text = "";
    EM_O_ORG_NM.Text = "";
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
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_REQ_STR" classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_POUT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_CONF");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
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
            <th width="70" class="point">점</th>
            <td width="120">
                <comment id="_NSID_">
                   <object id=LC_REQ_STR classid=<%= Util.CLSID_LUXECOMBO %>  tabindex=1 height=100 width=120 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">신청기간</th>
            <td >
                <comment id="_NSID_">
                <object id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle">
                </object></comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_DT)" align="absmiddle" /> ~ 
               <comment id="_NSID_">
                <object id=EM_E_DT classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle">
                </object>
                 </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_E_DT)" align="absmiddle" />
           </td>
           
          </tr>  
          <tr> 
            <th>불출유형</th>
             <td width="120">
               <comment id="_NSID_">
                       <object id=LC_POUT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle">
                       </object>
                 </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th>신청부서</th> 
             <td colspan=3>
                 <comment id="_NSID_">
                <object id=EM_O_ORG_CD classid=<%= Util.CLSID_EMEDIT %> width=80 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript: orgPop(EM_O_ORG_CD,EM_O_ORG_NM, 'N','','','','3','',LC_REQ_STR.BindColVal)"   align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_ORG_NM classid=<%= Util.CLSID_EMEDIT %> width=150 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>    
          
    </table></td>
  </tr>
    </table></td>
  </tr>
  <tr valign="bottom">
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td class="PB05">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=240 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_MASTER">
                <Param Name="ViewSummary"   value="1" >
            </OBJECT></comment><script>_ws_(_NSID_);</script>
        </td>  
         </tr>
        </table>
       </td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
              <th width="70" class="point">불출일자</th>
            <td width="110">
                 <comment id="_NSID_">
                <object id=EM_OUT_DT classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:chkOutDt();"  width=85 tabindex=1 align="absmiddle">
                </object>
                 </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_CAL onclick="javascript:openCal('G',EM_OUT_DT)" align="absmiddle" />
              </td>
            <th width="70">시작번호</th>
            <td width="140" >
                <comment id="_NSID_">
                  <object id=EM_GIFT_S_NO classid=<%=Util.CLSID_EMEDIT%>   width=140 tabindex=1>
                  </object></comment><script>_ws_(_NSID_);</script>
              </td>
             <th width="70">종료번호</th>
            <td width="140">
                <comment id="_NSID_">
                  <object id=EM_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=140 tabindex=1>
                  </object></comment><script>_ws_(_NSID_);</script>
              </td>
            <th width="70">개별등록</th>
            <td>
                <input type="checkbox" id=CHK_SINGLE align="absmiddle" onclick="javascript:onSingle();" tabindex=1 > 
              </td>
          </tr>         
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr valign="bottom">
    <td class="dot"></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
    <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td class="sub_title">
            <img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/> 신청내역
        </td>
         <td></td>
         <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="sub_title">
                    <img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/> 확정내역
                </td>
                <td class="right">
                    <img src="/<%=dir%>/imgs/btn/del_row.gif" id=IMG_DELROW onclick="javascript:delRow();" width="52" height="18" />
                </td>
            </tr>
            </table>
        </td>
        </tr>
        <tr>
        <td width="280">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	        <tr>
	        <td>
	            <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=370 classid=<%=Util.CLSID_GRID%>>
	                <param name="DataID" value="DS_O_DETAIL">
	                <Param Name="ViewSummary"   value="1" >
	            </OBJECT></comment><script>_ws_(_NSID_);</script>
	        </td>  
	         </tr>
	        </table>
        </td>
        <td width="2">
        </td>
        <td >
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
        <tr>
        <td>
            <comment id="_NSID_"><OBJECT id=GD_CONF width=100% height=370 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_IO_CONF">
                <Param Name="ViewSummary"   value="1" >
            </OBJECT></comment><script>_ws_(_NSID_);</script>
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
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

