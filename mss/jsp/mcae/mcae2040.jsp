<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 상품권관리 > 상품권판매/회수 > 상품권 판매 내역조회
 * 작 성 일 : 2011.05.12
 * 작 성 자 : 김정민
 * 수 정 자 : 
 * 파 일 명 : mcae2040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경품행사 응모자를 조회/삭제 한다.
 * 이    력 : 2011.05.12 (김정민) 신규개발
 *         
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정 
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
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_select = false;
var g_select2 = false;
var g_strPid           = "<%=pageName%>";                 // PID

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 480;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	  // Input Data Set Header 초기화 
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_MASTER_EVENT.setDataHeader('<gauce:dataset name="H_MASTER_EVENT"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); //마스터
    
 // EMedit에 초기화
    initEmEdit(EM_S_S_DT, "SYYYYMMDD", PK);                //기간FROM(조회)
    initEmEdit(EM_S_E_DT, "YYYYMMDD", PK);                 //기간TO(조회) 
    initEmEdit(EM_S_EVENT_CD,   "NUMBER3^11^0", NORMAL);    //행사코드(조회)
    initEmEdit(EM_S_EVENT_NAME, "GEN^40", READ);           //행사명(조회)   
    
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회) 
   
    //공통코드에서 가져 오기
    getStore("DS_S_STR_CD", "Y", "1", "N"); 
     
    EM_S_E_DT.Text   = getTodayFormat("YYYYMMDD");  
    LC_S_STR_CD.Index    = 0  
    LC_S_STR_CD.Focus();
    
}

function gridCreate(){
    var hdrProperies = '<FC>id={currow}     name="NO"          width=25    align=center</FC>'
                     + '<FC>id=STR_CD       name="점"          width=60    align=left  EDITSTYLE=LOOKUP   DATA="DS_S_STR_CD:CODE:NAME" </FC>' 
                     + '<FC>id=EVENT_CD     name="행사코드"     width=100    align=center  MASK="XXXXXX-XXXXX"  </FC>'
                     + '<FC>id=EVENT_NAME   name="행사명"       width=120   align=left</FC>'
                     + '<FC>id=EVENT        name="추첨여부"     width=70    align=left</FC>' 
                     ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    
    var hdrProperies1 = '<FC>id={currow}            name="NO"           width=25   align=center Edit=none  </FC>'
    	                + '<FC>id=FLAG              name=""             width=20   align=center   EditStyle=CheckBox  HeadCheckShow=true </FC>'
                        + '<FC>id=EVENT_CD          name="행사코드"       width=100   align=center  Edit=none   MASK="XXXXXX-XXXXX"  </FC>'
                        + '<FC>id=EVENT_NAME        name="행사명"         width=150  align=left Edit=none   </FC>'
                        + '<FC>id=ENTRY_DT          name="응모일자"       width=80   align=center  Mask="XXXX/XX/XX" Edit=none  </FC>' 
                        ;
    initGridStyle(GD_MASTER_EVENT, "common", hdrProperies1, true);

    var hdrProperies2 = '<FC>id={currow}      name="NO"          width=25      align=center</FC>'
			          + '<FC>id=ENTY_NAME     name="고객명"       width=100     align=LEFT </FC>'  
                      + '<FC>id=SS_NO         name="생년월일"      width=110     align=LEFT Mask="XXXXXX"  </FC>'
			          + '<FC>id=PHONE_NO      name="전화번호"      width=100     align=LEFT Value={decode(PHONE_NO, "" ,(PHONE1_NO&&"-"&&PHONE2_NO&&"-"&&PHONE3_NO),"")} </FC>'  
			          + '<FC>id=HP_NO         name="휴대폰번호"    width=110     align=LEFT Value={decode(HP_NO, "" ,(HP1_NO&&"-"&&HP2_NO&&"-"&&HP3_NO),"")} </FC>' 
			          + '<FC>id=ADDR          name="주소"         width=400     align=LEFT   </FC>'
			          + '<FC>id=EMAIL         name="이메일주소"    width=140     align=LEFT   </FC>';
				        ;
   initGridStyle(GD_DETAIL, "common", hdrProperies2, false);
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
 * 작 성 일 : 2011.02.21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    DS_MASTER.ClearData();
    DS_MASTER_EVENT.ClearData();
    DS_DETAIL.ClearData();
    
    var strStrCd   = LC_S_STR_CD.BindColVal;    //점
    var strSdt     = EM_S_S_DT.Text;            //시작기간
    var strEdt     = EM_S_E_DT.Text;            //종료기간    
    var strEventCd = EM_S_EVENT_CD.Text;        //행사   
       
    var goTo = "getMaster";
    var action = "O";
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strSdt="     + encodeURIComponent(strSdt)
                   + "&strEdt="     + encodeURIComponent(strEdt)
                   + "&strEventCd=" + encodeURIComponent(strEventCd);
    TR_MAIN.Action = "/mss/mcae204.mc?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_MASTER=DS_MASTER)";
    g_select = true;
    TR_MAIN.Post();
    g_select = false;

    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER); 
    
    if(DS_MASTER.CountRow != 0) {
    	getMaster_Event2();
    }
    else {
    	DS_MASTER_EVENT.ClearData();
        DS_DETAIL.ClearData();
    }
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
 * 작 성 일 : 2011.02.21
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
   if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT") == "미완료"){
	   showMessage(StopSign, OK, "USER-1000", "해당행사는 추첨이 완료되지 않아 삭제할 수 없습니다"); 
       return; 
   }
   
   var Cnt =0;
   for(var i = 0; i<= DS_MASTER_EVENT.CountRow; i++) {
	   if(DS_MASTER_EVENT.NameValue(i,"FLAG") == "T"){
		   Cnt = Cnt+1;
	   }
   }
   
   if(Cnt == 0) {
	   showMessage(StopSign, OK, "USER-1019");
       return;
   }
   
   if(showMessage(QUESTION , YESNO, "USER-1023") != 1){ 
       return;
   }
   
   var strEntryDt = DS_MASTER_EVENT.NameValue(DS_MASTER_EVENT.RowPosition,"ENTRY_DT");
   var strStrCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
   var strEventCd = DS_MASTER_EVENT.NameValue(DS_MASTER_EVENT.RowPosition,"EVENT_CD");  
   
   var goTo = "delete";
   var parameters = "&strEntryDt="     + encodeURIComponent(strEntryDt) 
                  + "&strStrCd="       + encodeURIComponent(strStrCd)
                  + "&strEventCd="     + encodeURIComponent(strEventCd);
   TR_MAIN.Action = "/mss/mcae204.mc?goTo=" + goTo + parameters;  
   TR_MAIN.KeyValue = "SERVLET(I:DS_MASTER_EVENT=DS_MASTER_EVENT)";
   TR_MAIN.Post(); 
   
   DS_MASTER.ClearData();
   DS_MASTER_EVENT.ClearData();
   DS_DETAIL.ClearData();
   btn_Search();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
   
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() { 
 
    var parameters = "점="     		+ LC_S_STR_CD.ValueOfIndex("NAME", LC_S_STR_CD.Index)
	   				+ "행사시작일자="   + EM_S_S_DT.Text
	   				+ "행사종료일자="   + EM_S_E_DT.Text;

	var ExcelTitle = "응모자 리스트"
	
	//openExcel2(GD_DETAIL, ExcelTitle, parameters, true );
		openExcel5(GD_DETAIL, ExcelTitle, parameters, true , "",g_strPid );

	GD_DETAIL.Focus();   
}


/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.21
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011.02.21
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getMaster_Event()
  * 작 성 자 : 
  * 작 성 일 : 2011-05-12
  * 개    요 :  응모마스터 조회
  * return값 : void
  */
function getMaster_Event() {
	var strStrCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
	var strEventCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD");
	
	if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT") == "미완료") {
		GD_MASTER_EVENT.ColumnProp('FLAG',   'Edit') = "NONE";   // 선택
	}
	else { 
        GD_MASTER_EVENT.ColumnProp('FLAG',   'Edit') = "";   // 선택
	}
	
	var goTo       = "getMaster_Event" ;    
    var action     = "O";     
    var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                   + "&strEventCd=" + encodeURIComponent(strEventCd);
    
    TR_MAIN2.Action="/mss/mcae204.mc?goTo="+goTo+parameters;  
    TR_MAIN2.KeyValue="SERVLET("+action+":DS_MASTER_EVENT=DS_MASTER_EVENT)"; //조회는 O
    g_select2 = true;
    TR_MAIN2.Post();
    g_select2 = false;
     
    // 조회결과 Return
    setPorcCount("SELECT",GD_MASTER_EVENT);
    
    if(DS_MASTER_EVENT.CountRow != 0) {
    	getDetail2();
    }
    else {
    	DS_DETAIL.ClearData();
    }
}

/**
 * getMaster_Event()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-12
 * 개    요 :  응모마스터 조회
 * return값 : void
 */
function getMaster_Event2() {
   var strStrCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
   var strEventCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD");
   
   if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT") == "미완료") {
       GD_MASTER_EVENT.ColumnProp('FLAG',   'Edit') = "NONE";   // 선택
   }
   else { 
       GD_MASTER_EVENT.ColumnProp('FLAG',   'Edit') = "";   // 선택
   }
   
   var goTo       = "getMaster_Event" ;    
   var action     = "O";     
   var parameters = "&strStrCd="   + encodeURIComponent(strStrCd)
                  + "&strEventCd=" + encodeURIComponent(strEventCd);
   
   TR_MAIN2.Action="/mss/mcae204.mc?goTo="+goTo+parameters;  
   TR_MAIN2.KeyValue="SERVLET("+action+":DS_MASTER_EVENT=DS_MASTER_EVENT)"; //조회는 O
   g_select2 = true;
   TR_MAIN2.Post();
   g_select2 = false; 
   
   if(DS_MASTER_EVENT.CountRow != 0) {
       getDetail2();
   }
   else {
       DS_DETAIL.ClearData();
   }
}

/**
 * getDetail()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-12
 * 개    요 :  응모자 정보 조회
 * return값 : void
 */
function getDetail() {

    var strEntryDt = DS_MASTER_EVENT.NameValue(DS_MASTER_EVENT.RowPosition,"ENTRY_DT");
    var strStrCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var strEventCd = DS_MASTER_EVENT.NameValue(DS_MASTER_EVENT.RowPosition,"EVENT_CD");
	
	var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strEntryDt="+ encodeURIComponent(strEntryDt)
                   + "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strEventCd="+ encodeURIComponent(strEventCd);
    
    TR_MAIN3.Action="/mss/mcae204.mc?goTo="+goTo+parameters;  
    TR_MAIN3.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN3.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_DETAIL);
}

/**
 * getDetail2()
 * 작 성 자 : 
 * 작 성 일 : 2011-05-12
 * 개    요 :  응모자 정보 조회
 * return값 : void
 */
function getDetail2() {

    var strEntryDt = DS_MASTER_EVENT.NameValue(DS_MASTER_EVENT.RowPosition,"ENTRY_DT");
    var strStrCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var strEventCd = DS_MASTER_EVENT.NameValue(DS_MASTER_EVENT.RowPosition,"EVENT_CD");
    
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strEntryDt="+encodeURIComponent(strEntryDt)
                   + "&strStrCd="  +encodeURIComponent(strStrCd)
                   + "&strEventCd="+encodeURIComponent(strEventCd);
    
    TR_MAIN3.Action="/mss/mcae204.mc?goTo="+goTo+parameters;  
    TR_MAIN3.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN3.Post();
     
}
 -->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
    for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_MAIN3 event=onSuccess>
    for(i=0;i<TR_MAIN3.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN3.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN2 event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN2.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN2.ErrorMsg);
    for(i=1;i<TR_MAIN2.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN2.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN2.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN3 event=onFail>
  /*  showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN3.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN3.ErrorMsg);
    for(i=1;i<TR_MAIN3.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN3.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN3.ErrorMsg);
</script>


<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
	if (row > 0 && g_select == false) {  
		setTimeout("getMaster_Event()",50); 
	}  
</script>

<script language=JavaScript for=DS_MASTER_EVENT event=OnRowPosChanged(row)>
if(clickSORT) return;
	if (row > 0 && g_select2 == false) {  
	    setTimeout("getDetail()",50); 
	}  
</script>

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=EM_S_EVENT_CD event=onKillFocus()>
  //  if (EM_O_EVENT_CD.Text.length > 0 ) { 
      if(!this.Modified)
                return;
                
            if(this.text==''){
                EM_S_EVENT_NAME.Text = "";
                return;
            }
         
            if(LC_S_STR_CD.BindColVal == "%"){
                showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
                LC_S_STR_CD.Focus();
                return;
            }
        setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NAME, LC_S_STR_CD.BindColVal, '5');  
        if (DS_O_RESULT.CountRow == 1 ) {  
            EM_S_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
            EM_S_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출  
            mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal, '5');
        }
  //  }  
     
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    EM_S_EVENT_CD.Text = "";
    EM_S_EVENT_NAME.Text = "";
</script>
 
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
   //그리드 정렬기능
   if( row < 1) {
       sortColId( eval(this.DataID), row , colid );
   }
</script><script language=JavaScript for=GD_MASTER_EVENT event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script><script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_MASTER"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MASTER_EVENT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN3" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
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
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="PT01 PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
                <td><!-- search start -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
              <th width="100" class="point">점</th>
              <td width="200"><comment id="_NSID_"><object
                  id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="197" tabindex=1
                  align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
              <th width="100" class="point">행사기간</th>
              <td ><comment id="_NSID_">
                <object id=EM_S_S_DT classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                </object></comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_S_DT)" align="absmiddle" /> ~ 
               <comment id="_NSID_">
                <object id=EM_S_E_DT classid=<%=Util.CLSID_EMEDIT%>   width=150 tabindex=1 align="absmiddle"
                onblur="javascript:checkDateTypeYMD(this);" >
                </object>
                 </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_E_DT)" align="absmiddle" /></td>
	          </tr>
	          <tr> 
              <th>행사코드</th>
              <td colspan="3"><comment id="_NSID_"> <object id=EM_S_EVENT_CD
                classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
                src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                class="PR03"
                onclick="javascript:mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal, '5');"
                id=popEventS /> <comment id="_NSID_"> <object
                id=EM_S_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=201
                tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
        <td class="PB03">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 행사정보</td>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 응모 마스터</td>
            </tr>
            <tr valign="top">
                <td width="400">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                        <td width="100%">
                          <comment id="_NSID_"><OBJECT id=GD_MASTER width=410 height=320 classid=<%=Util.CLSID_GRID%>>
                                  <param name="DataID" value="DS_MASTER"> 
                          </OBJECT></comment><script>_ws_(_NSID_);</script>
                        </td>
                    </tr>
                </table>
                </td>
                <td class="PL05">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                         <td width="100%">
                          <comment id="_NSID_"><OBJECT id=GD_MASTER_EVENT width=100% height=320 classid=<%=Util.CLSID_GRID%>>
                                  <param name="DataID" value="DS_MASTER_EVENT"> 
                          </OBJECT></comment><script>_ws_(_NSID_);</script>
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
        <tr>
                <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03" align="absmiddle" /> 응모자 정보</td> 
            </tr>
            <tr valign="top">
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                    <tr>
                        <td width="100%">
                          <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=400 classid=<%=Util.CLSID_GRID%>>
                              <param name="DataID" value="DS_DETAIL"> 
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
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
