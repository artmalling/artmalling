<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 포인트관리 > 포인트 조회
 * 작  성  일 : 2010.01.14
 * 작  성  자 : 김영진
 * 수  정  자 : 
 * 파  일  명 : dctm3010.jsp
 * 버         전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개        요 : 
 * 이        력 :
 *           2010.01.14 (김영진) 신규작성
 *           2010.03.22 (김영진) 기능추가
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
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<%
    String strToMonth = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    strToMonth = strToMonth + "01";
%>
<script LANGUAGE="JavaScript">
<!--
var RD_COMP_PERS_FLAG_VALUE = "P";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-22
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 280;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


    //Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); 
    
    // EMedit에 초기화
    initEmEdit(EM_CUST_NAME,   "GEN^40",              READ);       //회원명 
    initEmEdit(EM_HOME_PH,     "GEN^40",              READ);       //자택전화
    initEmEdit(EM_HOME_PH1,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH2,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_HOME_PH3,    "GEN^40",              READ);       //자택전화hidden
    initEmEdit(EM_MOBILE_PH,   "GEN^40",              READ);       //이동전화 
    initEmEdit(EM_MOBILE_PH1,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH2,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_MOBILE_PH3,  "GEN^40",              READ);       //이동전화 hidden
    initEmEdit(EM_SS_NO,       "000000",      		  READ);       //생년월일
    initEmEdit(EM_HOME_ADDR,   "GEN^400",             READ);       //회원주소 
    initEmEdit(EM_POINT,       "NUMBER^9^0",          READ);       //누적포인트
    //initEmEdit(EM_OCCURS_POINT,"NUMBER^9^0", 		  READ);       //발생포인트
    //initEmEdit(EM_SUM_POINT,   "NUMBER^9^0",          READ);       //누적+발생포인트
    initEmEdit(EM_EMAIL,       "GEN^80",              READ);       //이메일주소
    initEmEdit(EM_EMAIL1,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_EMAIL2,      "GEN^80",              READ);       //이메일주소hidden
    initEmEdit(EM_CUST_GTADE,  "GEN^40",              READ);       //회원등급
    initEmEdit(EM_CUST_TYPE,   "GEN^40",     		  READ);       //회원유형
    initEmEdit(EM_ENTR_DT,    "YYYYMMDD",             READ);       //가입일자 추가 16.12.22    
 
    initEmEdit(EM_USE_F_DT,    "YYYYMMDD",            PK);         //조회 시작기간    
    initEmEdit(EM_USE_T_DT,    "TODAY",               PK);         //조회 종료기간
    initEmEdit(EM_CUST_ID_S,   "GEN^9",               NORMAL);     //회원코드
    initEmEdit(EM_CUST_NAME_S, "GEN^40",              READ);       //회원명
    initEmEdit(EM_SS_NO_S,     "000000",    	      NORMAL);     //생년월일
    initEmEdit(EM_CARD_NO_S,   "0000-0000-0000-0000", NORMAL);     //카드번호
    initEmEdit(EM_CARD_NO_CUT,    "00000000",            NORMAL);     //단축 카드번호
    initEmEdit(EM_CUST_ID_H,   "GEN^9",               NORMAL);     //회원코드_hidden
    initEmEdit(EM_SS_NO_H,     "#000000",     	      NORMAL);     //생년월일_hidden
    initEmEdit(EM_CARD_NO_H,   "0000000000000000",    NORMAL);     //카드번호_hidden
	initEmEdit(EM_ENTR_DT,    "YYYYMMDD",    READ);       //가입일자 추가 16.12.22
    
    EM_USE_F_DT.Text = addDate("M", "-1", '<%=strToMonth%>');
    //EM_CARD_NO_S.Focus();
    EM_CARD_NO_CUT.Focus();

    //활성화 비활성화 화면 초기 설정
    EM_HOME_PH1.style.display    = "none";
    EM_HOME_PH2.style.display    = "none"; 
    EM_HOME_PH3.style.display    = "none";
    EM_MOBILE_PH1.style.display  = "none";
    EM_MOBILE_PH2.style.display  = "none";
    EM_MOBILE_PH3.style.display  = "none";
    EM_EMAIL1.style.display      = "none"; 
    EM_EMAIL2.style.display      = "none";
    EM_CUST_ID_H.style.display   = "none";
    EM_CARD_NO_H.style.display   = "none";
    EM_SS_NO_H.style.display     = "none";
    

//      EM_OCCURS_POINT.style.display    = "none";
//      EM_SUM_POINT.style.display    = "none";
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"              width=30        align=center</FC>'
                     + '<FC>id=PROC_DT          name="처리일자"         width=80        align=center      mask="XXXX/XX/XX" SumText="합계" </FC>'
                     + '<FC>id=PROC_TIME        name="처리시간"         width=70        align=center      mask="XX:XX:XX"</FC>'
                     + '<FC>id=CARD_NO          name="카드번호"         width=140       align=center      mask="XXXX-XXXX-XXXX-XXXX"</FC>'
                     + '<FC>id=BRCH_ID          name="가맹점ID"         width=60        align=center      show=false</FC>'
                     + '<FC>id=BRCH_NAME        name="가맹점명"         width=106       align=left</FC>'
                     + '<FC>id=ADD_POINT        name="적립포인트"       width=75        align=right SumText=@sum </FC>'
                     + '<FC>id=ADD_TYPE         name="적립유형"         width=90        align=center      show=false</FC>'
                     + '<FC>id=ADD_TYPE_NM      name="적립유형"         width=90        align=left</FC>'
                     + '<FC>id=USE_POINT        name="사용포인트"       width=75        align=right SumText=@sum </FC>'
                     + '<FC>id=USE_TYPE         name="사용유형"         width=100       align=center      show=false</FC>'
                     + '<FC>id=USE_TYPE_NM      name="사용유형"         width=170      align=left</FC>'
                     + '<FC>id=RECP_NO          name="거래고유번호"     width=150       align=center</FC>'
                     + '<FC>id=REAL_SALE_AMT    name="실매출액"         width=100       align=right SumText=@sum </FC>'; 
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, false);

    GR_MASTER.ViewSummary = "1";
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-22
 * 개        요    : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if(trim(EM_USE_F_DT.Text).length == 0){          // 조회시작일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_USE_F_DT.Focus();
        return;
    }
    if(trim(EM_USE_T_DT.Text).length == 0){    // 조회 종료일
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_USE_T_DT.Focus();
        return;
    }
    if(EM_USE_F_DT.Text > EM_USE_T_DT.Text){      // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_USE_F_DT.Focus();
        return;
    } 
    if(RD_COMP_PERS_FLAG.CodeValue == "P" && trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[회원명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else if(RD_COMP_PERS_FLAG.CodeValue == "C" && trim(EM_SS_NO_S.Text).length == 0 && trim(EM_CUST_ID_S.Text).length == 0 
            && trim(EM_CARD_NO_S.Text).length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000",  "조회시 [카드번호],[생년월일],[법인명] 중 1개는  반드시 입력해야 합니다.");
        EM_CARD_NO_S.Focus();
        return;
    }else{
        // MARIO OUTLET
    	//if (trim(EM_CARD_NO_S.Text).length > 0 && trim(EM_CARD_NO_S.Text).length < 16) {
        if(trim(EM_CARD_NO_S.Text).length != 0 && trim(EM_CARD_NO_S.Text).length != 13 && trim(EM_CARD_NO_S.Text).length != 16 ) {	
            showMessage(EXCLAMATION, OK, "USER-1000",  "카드번호는 13자리 또는 16자리입니다.");
            EM_CARD_NO_S.Focus();
            return;
        }
        if (RD_COMP_PERS_FLAG.CodeValue == "P" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 6)) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "생년월일은 6자리입니다.");
            EM_SS_NO_S.Focus();
            return;
        }else if (RD_COMP_PERS_FLAG.CodeValue == "C" && (trim(EM_SS_NO_S.Text).length > 0 && trim(EM_SS_NO_S.Text).length < 10)) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "사업자등록번호는 10자리입니다.");
            EM_SS_NO_S.Focus();
            return;
        }
        if (RD_COMP_PERS_FLAG.CodeValue == "P" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "회원은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }else if (RD_COMP_PERS_FLAG.CodeValue == "C" && trim(EM_CUST_ID_S.Text).length > 0 && trim(EM_CUST_ID_S.Text).length < 9) {
            showMessage(EXCLAMATION, OK, "USER-1000",  "법인(단체)은 9자리입니다.");
            EM_CUST_ID_S.Text = "";
            EM_CUST_ID_S.Focus();
            return;
        }
    }

    if(srchEvent(RD_COMP_PERS_FLAG.CodeValue))showMaster();
}
    
function btn_New() {
	doInit();
	
    DS_O_RESULT.ClearData();
    DS_O_MASTER.ClearData();
    EM_CUST_ID_H.Text   = ""; 
    EM_CARD_NO_CUT.Text   = "";
    EM_CARD_NO_H.Text   = "";
    EM_SS_NO_H.Text     = "";
    EM_HOME_PH.Text     = ""; 
    EM_MOBILE_PH.Text   = ""; 
    EM_EMAIL.Text       = ""; 
    EM_CUST_ID_S.Text   = ""; 
    EM_CUST_NAME_S.Text = ""; 
    EM_CUST_NAME.Text   = "";
    EM_SS_NO.Text       = "";
    EM_CARD_NO_S.Text   = "";
    EM_SS_NO_S.Text     = "";
    EM_HOME_ADDR.Text   = "";
    EM_CUST_GTADE.Text  = "";
    EM_CUST_TYPE.Text  = "";
    EM_POINT.Text       = "";
}


function btn_Excel() {

	if(DS_O_MASTER.CountRow	<= 0){
	  showMessage(INFORMATION, OK, "USER-1000","다운 할	내용이 없습니다. 조회 후 엑셀다운 하십시오.");
		return;
	}
	var	strTitle = "포인트조회";

	var	strCust_Id		= EM_CUST_NAME.text;		//
	

	var	strCmprDtS1		 = EM_USE_F_DT.text;		//시작년월
	var	strCmprDtE1		 = EM_USE_T_DT.text;		//종료년월
	
	var	parameters = "회원명	-	"			 + strCust_Id
				   + " ,   조회기간	-	"  + strCmprDtS1
				   + " ~ "  + strCmprDtE1;
	
	

	GR_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";	   // GridToExcel 사용시 숨길 컬럼지정
	//openExcel2(GR_MASTER, strTitle,	parameters,	true );
	openExcel5(GR_MASTER, strTitle,	parameters,	true , "",g_strPid );

	
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-03-22
 * 개       요     : 포인트조회
 * return값 : void
 */
function showMaster(){

    var strUseFDt  = EM_USE_F_DT.Text;
    var strUseTDt  = EM_USE_T_DT.Text
    var strCardNo  = EM_CARD_NO_S.Text;
    var strSsNo    = EM_SS_NO_S.Text;
    var strCustId  = EM_CUST_ID_S.Text;
    var strCompPersFlag = RD_COMP_PERS_FLAG.CodeValue;
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strUseFDt=" + encodeURIComponent(strUseFDt)
                    + "&strUseTDt=" + encodeURIComponent(strUseTDt)
                    + "&strCardNo=" + encodeURIComponent(strCardNo)
                    + "&strSsNo="   + encodeURIComponent(strSsNo)
                    + "&strCustId=" + encodeURIComponent(strCustId)
                    + "&strCompPersFlag=" + encodeURIComponent(strCompPersFlag);    
    TR_MAIN.Action  ="/dcs/dctm301.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //Focus이동
    if(DS_O_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
        EM_CARD_NO_S.Focus();
    }
  
    //조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));
    
}

/**
 * gourl()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-03-29
 * 개      요  : 화면 이동
 * return값 : void
 */
function gourl(go,nm,s){
	try{
		frame01 = window.external.GetFrame(window);
		frame01.Provider('../').OuterWindow.showStatusBar(strMsg); 
	} catch(e){		
	}
	frame01.Provider('../').OuterWindow.top.leftFrame.urlLink(go.toUpperCase().substring(0,7),"/dcs/"+go+"?goTo=list&strCardNo="+EM_CARD_NO_S.Text+"&strSsNo="+EM_SS_NO_S.Text,s,"01",nm);
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=RD_COMP_PERS_FLAG event=OnClick()>
    if (this.CodeValue == RD_COMP_PERS_FLAG_VALUE) return;
    RD_COMP_PERS_FLAG_VALUE = this.CodeValue ;
    if ("P" == this.CodeValue) 
    {
        document.getElementById('titleSsno1').innerHTML        = "생년월일";
        document.getElementById('titleSsno2').innerHTML        = "생년월일";
        document.getElementById('titleCustName1').innerHTML    = "회원명";
        document.getElementById('titleCustName').innerHTML     = "회원명";
        document.getElementById('titleHomeAddr').innerHTML     = "회원주소";
        document.getElementById('titleMobileOffiPH').innerHTML = "이동전화";
        document.getElementById('titleHomePH').innerHTML       = "자택전화";
        
        initEmEdit(EM_SS_NO_S,      "000000",      NORMAL);//생년월일
        initEmEdit(EM_SS_NO,        "000000",      READ);  //생년월일
    } 
    else if ("C" == CodeValue) 
    {
        document.getElementById('titleSsno1').innerHTML        = "사업자등록번호";
        document.getElementById('titleSsno2').innerHTML        = "사업자등록번호";
        document.getElementById('titleCustName1').innerHTML    = "법인(단체)명";
        document.getElementById('titleCustName').innerHTML     = "법인(단체)명";
        document.getElementById('titleHomeAddr').innerHTML     = "사업장주소";
        document.getElementById('titleMobileOffiPH').innerHTML = "담당자전화";
        document.getElementById('titleHomePH').innerHTML       = "대표전화";

        initEmEdit(EM_SS_NO_S,     "#00-00-00000",        NORMAL);     //사업자번호
        initEmEdit(EM_SS_NO,       "#00-00-00000",        READ);       //사업자번호
    }
    DS_O_RESULT.ClearData();
    DS_O_MASTER.ClearData();
    EM_CUST_ID_H.Text   = ""; 
    EM_CARD_NO_H.Text   = "";
    EM_SS_NO_H.Text     = "";
    EM_HOME_PH.Text     = ""; 
    EM_MOBILE_PH.Text   = ""; 
    EM_EMAIL.Text       = ""; 
    EM_CUST_ID_S.Text   = ""; 
    EM_CUST_NAME_S.Text = ""; 
    EM_CUST_NAME.Text   = "";
    EM_SS_NO.Text       = "";
    EM_CARD_NO_S.Text   = "";
    EM_SS_NO_S.Text     = "";
    EM_HOME_ADDR.Text   = "";
    EM_CUST_GTADE.Text  = "";
    EM_CUST_TYPE.Text  = "";
    EM_POINT.Text       = "";
</script>

<!-- 단축카드번호 onKillFocus() -->
<script language=JavaScript for=EM_CARD_NO_CUT event=onKillFocus()>
	//EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);  
	if ( trim(EM_CARD_NO_CUT.Text).length != 0 ) {
    	EM_CARD_NO_S.Text = cardCheckDigit(EM_CARD_NO_CUT.Text);
    	getCustInfoSrch(13,EM_CARD_NO_S,'EM_CARD_NO_S','');
    }
</script>


<script language=JavaScript for=EM_SS_NO_H event=onKillFocus()>
	//EM_SS_NO_S.Text = cardCheckDigit(EM_SS_NO_H.Text);  
	if ( trim(EM_SS_NO_H.Text).length != 0 ) {
		EM_SS_NO_S.Text = cardCheckDigit(EM_SS_NO_H.Text);
    	getCustInfoSrch(6,EM_SS_NO_S,'EM_SS_NO_S','');
    }
</script>


<!-- 회원ID onKillFocus() -->
<script language=JavaScript for=EM_CUST_ID_S event=onKillFocus()> 
    if ((EM_CUST_ID_S.Modified) && (trim(EM_CUST_ID_S.Text).length != 9)) {
        EM_CUST_NAME_S.Text = ""; 
        EM_CARD_NO_H.Text   = ""; 
        EM_SS_NO_H.Text     = ""; 
    } 
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_USE_F_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_USE_F_DT)){
        EM_USE_F_DT.Text = addDate("M", "-1", '<%=strToMonth%>');
    }
</script>
<!-- 조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_USE_T_DT event=onKillFocus()>
    checkDateTypeYMD(EM_USE_T_DT);
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_CUSTDETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="o_table">
            <tr>
                <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"
                    class="s_table"> 
                    <tr>
                    <th width="77">카드번호</th>
                    <td width="170"><comment id="_NSID_"> <object style="display:none" 	
					id=EM_CARD_NO_CUT classid=<%=Util.CLSID_EMEDIT%> width="55"
					tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
					<comment id="_NSID_"> <object
                        id=EM_CARD_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                        id="_NSID_"> <object id=EM_CARD_NO_S
                        classid=<%=Util.CLSID_EMEDIT%> width=155 tabindex=1
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CARD_NO_S','');">
                    </object> </comment> <script> _ws_(_NSID_);</script></td>
                    <th width="77" style="display:none">회원구분</th>
                        <td width="160" style="display:none"><comment id="_NSID_"> <object
                            id=RD_COMP_PERS_FLAG classid=<%=Util.CLSID_RADIO%>
                            style="height: 20; width: 140" tabindex=1>
                            <param name=Cols value="2">
                            <param name=Format value="P^개인카드,C^법인카드">
                            <param name=CodeValue value="P">
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
                        <th width="76" class="point">조회기간</th>
                        <td colspan="3"><comment id="_NSID_"> <object
                            id=EM_USE_F_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle">
                        </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_USE_F_DT)" />- <comment
                            id="_NSID_"> <object id=EM_USE_T_DT
                            classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
                            align="absmiddle">
                        </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                            onclick="javascript:openCal('G',EM_USE_T_DT)" /></td>
                        
                    </tr>
                    <tr> 
                    <th width="80"><span id="titleSsNo1" style="Color: 146ab9">생년월일</span></th>
                    <td width="150"><comment id="_NSID_"> <object
                        id=EM_SS_NO_H classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <comment
                        id="_NSID_"> <object id=EM_SS_NO_S
                        classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_SS_NO_S','');">
                    </object> </comment> <script> _ws_(_NSID_);</script></td>
                    <th width="80"><span id="titleCustName1" style="Color: 146ab9">회원명</span></th>
                    <td><comment id="_NSID_"> <object id=EM_CUST_ID_H
                        classid=<%=Util.CLSID_EMEDIT%> tabindex=1 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script> <comment id="_NSID_"> <object
                        id=EM_CUST_ID_S classid=<%=Util.CLSID_EMEDIT%> width=66 tabindex=1
                        onKeyUp="javascript:getCustInfoSrch(event.keyCode,this,'EM_CUST_ID_S',RD_COMP_PERS_FLAG.CodeValue);"
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                        onclick="getCompPop(EM_CUST_ID_S,EM_CUST_NAME_S,RD_COMP_PERS_FLAG.CodeValue)" /> <comment
                        id="_NSID_"> <object id=EM_CUST_NAME_S
                        classid=<%=Util.CLSID_EMEDIT%> width=81 align="absmiddle"></object>
                    </comment> <script> _ws_(_NSID_);</script></td>
                </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr> 
	<tr>
	    <td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
			  <tr>
			  	<td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dmbo602.do','영수증사후적립','DMBO')">영수증사후적립</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l" style="display:none"> </td>
			    <td class="btn_c" style="display:none"><a href="#" onclick="gourl('dmbo622.do','영수증사후적립(회원미등록)','DMBO')">영수증사후적립(회원미등록)</a></td>
			    <td class="btn_r" style="display:none"></td>
			  	<td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm116.dm','회원메모관리(신규)','DCTM')">회원메모관리(신규)</a></td>
			    <td class="btn_r"></td>		
			    <td class="btn_l"> </td>
			    <td class="btn_c"><a href="#" onclick="gourl('dctm203.dm','개인회원조회/수정','DCTM')">개인회원조회/수정</a></td>
			    <td class="btn_r"></td>
			    <td class="btn_l" style="display:none"> </td>
			    <td class="btn_c" style="display:none"><a href="#" onclick="gourl('dmbo999.do','회원정보안내(소멸예정)','DMBO')">회원정보안내(소멸예정)</a></td>
			    <td class="btn_r" style="display:none"></td>
			 </tr>
			</table>                
	    </td>	
	</tr>   
    <tr>
        <td class="dot"></td>
    </tr>
    <tr>
        <td> <%@ include file="/jsp/common/memView.jsp"%>
        </td>
    </tr>
    
    <tr valign="top">
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
            class="BD4A">
            <tr>
                <td><comment id="_NSID_"> <object id=GR_MASTER
                    width="100%" height=352 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_O_MASTER">
                </object> </comment> <script>_ws_(_NSID_);</script></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_CUSTDETAIL classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_CUSTDETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=CUST_NAME     ctrl=EM_CUST_NAME    Param=Text</c>
            <c>col=HOME_PH1      ctrl=EM_HOME_PH1     Param=Text</c>
            <c>col=HOME_PH2      ctrl=EM_HOME_PH2     Param=Text</c>
            <c>col=HOME_PH3      ctrl=EM_HOME_PH3     Param=Text</c>
            <c>col=MOBILE_PH1    ctrl=EM_MOBILE_PH1   Param=Text</c>
            <c>col=MOBILE_PH2    ctrl=EM_MOBILE_PH2   Param=Text</c>
            <c>col=MOBILE_PH3    ctrl=EM_MOBILE_PH3   Param=Text</c>
            <c>col=SS_NO         ctrl=EM_SS_NO        Param=Text</c>
            <c>col=HOME_ADDR     ctrl=EM_HOME_ADDR    Param=Text</c>
            <c>col=POINT         ctrl=EM_POINT        Param=Text</c>
            <c>col=OCCURS_POINT  ctrl=EM_OCCURS_POINT Param=Text</c>
            <c>col=SUM_POINT     ctrl=EM_SUM_POINT    Param=Text</c>
            <c>col=EMAIL1        ctrl=EM_EMAIL1       Param=Text</c>
            <c>col=EMAIL2        ctrl=EM_EMAIL2       Param=Text</c>
            <c>col=GRADE_NAME    ctrl=EM_CUST_GTADE   Param=Text</c>
            <c>col=CUST_TYPE_NM  ctrl=EM_CUST_TYPE    Param=Text</c>
            <c>col=ENTR_DT  	 ctrl=EM_ENTR_DT    Param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
