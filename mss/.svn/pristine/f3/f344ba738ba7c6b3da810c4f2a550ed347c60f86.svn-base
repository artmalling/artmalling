<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 경품행사 > 경품행사 마스터 등록
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.17 (정진영) 신규작성
 *        2011.04.04 (김정민) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"          prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"       prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"           prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"        prefix="button" %>

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
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/ 
var strSaveFlag = false; 
var g_select =false;
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
 var top = 110;		//해당화면의 동적그리드top위치
 var top2 = 265;		//해당화면의 동적그리드top위치
function doInit(){
	 	
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";

    // Input Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');


    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터    
    gridCreate2();
    
    // EMedit에 초기화
    initEmEdit(EM_S_S_DT,           "SYYYYMMDD",    PK);          //행사기간FROM (조회)
    initEmEdit(EM_S_E_DT,           "YYYYMMDD",     PK);          //행사기간TO (조회)    
    initEmEdit(EM_S_EVENT_CD,       "NUMBER3^11^0", NORMAL);      //행사코드 (조회)
    initEmEdit(EM_S_EVENT_NAME,     "GEN^40",       READ);        //행사명 (조회)
     
    initEmEdit(EM_I_EVENT_CD,       "000000-00000",       READ);        //행사코드
    initEmEdit(EM_I_EVENT_NAME,     "GEN^40",       READ);        //행사명
    initEmEdit(EM_I_EVENT_S_DT,     "YYYYMMDD",     READ);        //행사시작일
    initEmEdit(EM_I_EVENT_E_DT,     "YYYYMMDD",     READ);        //행사종료일
   // initEmEdit(EM_EVENT_MNG_FLAG,   "GEN",          READ);      //행사주관구분
    initEmEdit(EM_EVENT_USER,       "GEN^40",       READ);        //행사담당자
    initEmEdit(EM_EVENT_L_CD,       "GEN^40",       READ);        //행사테마(대)
    initEmEdit(EM_EVENT_S_CD,       "GEN^40",       READ);        //행사테마(중)
    initEmEdit(EM_EVENT_M_CD,       "GEN^40",       READ);        //행사테마(소)

    //콤보 초기화
    initComboStyle(LC_S_STR_CD, DS_I_STR_CD, "CODE^0^30,NAME^0^80", 1, PK); //점(조회)
    initComboStyle(LC_I_STR_CD, DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, READ); //점
    initComboStyle(LC_EVENT_MNG_FLAG, DS_EVENT_MNG_FLAG, "CODE^0^30,NAME^0^80", 1, READ); //행사주관구분
     
    EM_S_E_DT.Text          = getTodayFormat("YYYYMMDD");     //기간TO(조회)
    EM_I_EVENT_CD.Alignment = 1;
    // 공통에서 가져오기
    getStore("DS_S_STR_CD", "Y", "1", "N");   //점(조회) 
    getStore("DS_I_STR_CD", "Y", "1", "N");   //점(조회) 
    getEtcCode("DS_EVENT_MNG_FLAG", "D", "P073", "N", "N", LC_EVENT_MNG_FLAG);   //행사주관구분
    LC_S_STR_CD.Index = 0;
    LC_EVENT_MNG_FLAG.BindColVal = "";
    enableControl(Addrow, false);
    enableControl(Delrow, false); 
    LC_S_STR_CD.Focus();
}


function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=STR_CD      name="점"          width=55   align=LEFT EDITSTYLE=LOOKUP   DATA="DS_I_STR_CD:CODE:NAME" </FC>'
			        + '<FC>id=EVENT_CD    name="행사코드"     width=85  align=center MASK="XXXXXX-XXXXX"</FC>'
                    + '<FC>id=EVENT_NAME  name="행사명"       width=110  align=LEFT</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}   name="NO"           width=70    align=center</FC>'
                    + '<FC>id=SEQ_NO      name="SEQ_NO"       width=120   align=center Show=false </FC>'
			        + '<FC>id=RANK        name="*순위명"       width=120   align=LEFT</FC>'
			        + '<FC>id=PRMM_NAME   name="*경품명"       width=140   align=LEFT</FC>'
			        + '<FC>id=WIN_CNT     name="*당첨인원"      width=130   align=RIGHT edit=numeric </FC>';
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies2, true);
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
	
	 if (DS_DETAIL.IsUpdated) {
         if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요 
          //   DS_O_DETAIL.RowPosition = gv_preRownoDetail;
             return;
         }      
     } 
	 
	if (EM_S_S_DT.Text > EM_S_E_DT.Text){ 
        showMessage(INFORMATION, OK, "USER-1008", "행사종료기간", "행사시작기간");
        EM_S_E_DT.Focus();
        return;
    }
     
    // 조회조건 셋팅
    var strStrCd        = LC_S_STR_CD.BindColVal;
    var strSdt          = EM_S_S_DT.Text;
    var strEdt          = EM_S_E_DT.Text;
    var strEventCd      = EM_S_EVENT_CD.Text;
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  +encodeURIComponent(strStrCd)
                   + "&strSdt="    +encodeURIComponent(strSdt)
                   + "&strEdt="    +encodeURIComponent(strEdt)
                   + "&strEventCd="+encodeURIComponent(strEventCd);
    TR_MAIN.Action="/mss/mcae201.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    g_select =true;
    TR_MAIN.Post();
    g_select = false;
    
    setPorcCount("SELECT", GD_MASTER);
    
    if(DS_MASTER.CountRow !=0) {
        getDetail2();
    }
    else{ 
        DS_MASTER.ClearData();
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
	if (!DS_DETAIL.IsUpdated){
        showMessage(StopSign, OK, "USER-1028");
        return;
    }
	 
     for(var i=0; i <= DS_DETAIL.CountRow; i++) {
            if(DS_DETAIL.NameValue(i,"RANK") == "") {  
                showMessage(StopSign, OK, "USER-1003", "순위명"); 
                setFocusGrid(GD_DETAIL, DS_DETAIL, i, "RANK");
                return;
            }
            if(DS_DETAIL.NameValue(i,"PRMM_NAME") == "") {  
                showMessage(StopSign, OK, "USER-1003", "경품명"); 
                setFocusGrid(GD_DETAIL, DS_DETAIL, i, "PRMM_NAME");
                return;
            }
            if(DS_DETAIL.NameValue(i,"WIN_CNT") == 0) {  
                showMessage(StopSign, OK, "USER-1003", "당첨인원"); 
                setFocusGrid(GD_DETAIL, DS_DETAIL, i, "WIN_CNT");
                return;
            }
        } 
   /*  var Today = getTodayFormat("YYYYMMDD");   
     if(Today < EM_I_EVENT_S_DT.Text || Today > EM_I_EVENT_E_DT.Text) {
        showMessage(INFORMATION, OK, "USER-1000", "행사기간에 포함되지 않아 저장 할 수 없습니다."); 
        setTimeout("LC_I_STR_CD.Focus();",50); 
        return;
     }
*/
     if(DS_DETAIL.CountRow == "0") {
           showMessage(INFORMATION, OK, "USER-1000", "상세내역을 입력 하셔야 합니다."); 
           return;
       } 
     
     for (i=1; i<=DS_DETAIL.CountRow; i++) {
	   //순위명      
	     var strRank = checkLenByte(DS_DETAIL, i, "RANK");
	     if (strRank > 10) {
	    	 showMessage(STOPSIGN, OK, "USER-1048", "순위명을 10");
	         DS_DETAIL.RowPosition = i; 
	         setFocusGrid(GD_DETAIL, DS_DETAIL, i, "RANK");
	         return false;
	     } 
	   
	     // 경품명
	     var strName = checkLenByte(DS_DETAIL, i, "PRMM_NAME");
	     if (strName > 40) {
	         showMessage(STOPSIGN, OK, "USER-1048", "경품명을 40");
	         DS_DETAIL.RowPosition = i; 
	         setFocusGrid(GD_DETAIL, DS_DETAIL, i, "PRMM_NAME");
	         return false;
	     } 
     }
     
    var strStrCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
    var strEventCd = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD");
     
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
        GD_DETAIL.Focus();
        return;
    } 
    strSaveFlag = true;
    var goTo = "save";
    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                   + "&strEventCd="  + encodeURIComponent(strEventCd);
    TR_MAIN.Action = "/mss/mcae201.mc?goTo=" + goTo + parameters;  
    TR_MAIN.KeyValue = "SERVLET(I:DS_DETAIL=DS_DETAIL)";
    TR_MAIN.Post();
   
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
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

/**
 * addRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행추가
 * return값 : void
 */

function addRow() {
   if(DS_MASTER.CountRow == 0){
       return;
   }  
  if(DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"RANK") == "") {
	       showMessage(StopSign, OK, "USER-1003", "순위명"); 
	       setFocusGrid(GD_DETAIL, DS_DETAIL, DS_DETAIL.CountRow, "RANK");
           return;
  }
  else if (DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"PRMM_NAME") == "") {
      showMessage(StopSign, OK, "USER-1003", "경품명"); 
      setFocusGrid(GD_DETAIL, DS_DETAIL, DS_DETAIL.CountRow, "PRMM_NAME");
      return;
  } 
  else if (DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"WIN_CNT") == "" || DS_DETAIL.NameValue(DS_DETAIL.RowPosition,"WIN_CNT") == 0) {
      showMessage(StopSign, OK, "USER-1003", "당첨인원"); 
      setFocusGrid(GD_DETAIL, DS_DETAIL, DS_DETAIL.CountRow, "WIN_CNT");
      return;
  }
  else {
	     DS_DETAIL.AddRow();
  } 
}

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행삭제
 * return값 : void
 */

function delRow() {
    if(DS_DETAIL.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1019");
           return;
       }
        DS_DETAIL.DeleteRow(DS_DETAIL.RowPosition); 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getDetail()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-05-06
  * 개    요 : DETAIL조회
  * return값 : void
  */
 function getDetail() { 
	  
	  if (DS_DETAIL.IsUpdated) {
	         if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요 
	          //   DS_O_DETAIL.RowPosition = gv_preRownoDetail;
	             return;
	         }      
	     } 
	  
	  var Today = getTodayFormat("YYYYMMDD");   
     if(DS_MASTER.CountRow >= 1) { 
        // if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= Today && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= Today) {
             enableControl(Addrow, true);
             enableControl(Delrow, true); 
             GD_DETAIL.Editable = true; 
         /*}
         else {
              enableControl(Addrow, false);
              enableControl(Delrow, false); 
              GD_DETAIL.Editable = false;
         }*/
 
            var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
            var strEventCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD"); 
           
            var goTo       = "getDetail" ;    
            var action     = "O";     
            var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                           + "&strEventCd="  + encodeURIComponent(strEventCd);
           
            TR_MAIN.Action="/mss/mcae201.mc?goTo="+goTo+parameters;  
            TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
            TR_MAIN.Post();
            
            setPorcCount("SELECT", GD_DETAIL);   
     } 
     else {
         return;
     }
 }

 /**
  * getDetail()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-05-06
  * 개    요 : DETAIL조회
  * return값 : void
  */
 function getDetail2() { 
 
      var Today = getTodayFormat("YYYYMMDD");   
     if(DS_MASTER.CountRow >= 1) { 
    	 enableControl(Addrow, true);
         enableControl(Delrow, true); 
        /* if(DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_S_DT") <= Today && DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_E_DT") >= Today) {
             enableControl(Addrow, true);
             enableControl(Delrow, true); 
         }
         else {
              enableControl(Addrow, false);
              enableControl(Delrow, false); 
         }
 */
            var strStrCd     = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD");
            var strEventCd   = DS_MASTER.NameValue(DS_MASTER.RowPosition,"EVENT_CD"); 
           
            var goTo       = "getDetail" ;    
            var action     = "O";     
            var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                           + "&strEventCd="  + encodeURIComponent(strEventCd);
           
            TR_MAIN.Action="/mss/mcae201.mc?goTo="+goTo+parameters;  
            TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
            TR_MAIN.Post(); 
     } 
     else {
         return;
     }
 }
 
 
 /**
  * checkLenByte()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.10
  * 개    요 : 문자열 Byte체크
  * return값 :
  */
 function checkLenByte(objDateSet, row, colid) {
    //byte체크
    var intByte = 0;
    var strTemp = objDateSet.NameValue(row, colid);

    for (k = 0; k < strTemp.length; k++) {
        var onechar = strTemp.charAt(k);
        if (escape(onechar).length > 4) {
            intByte += 2;
        } else {
            intByte++;
        }
    }
    return intByte;
}
 
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

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }    
</script>


<!-- 조회 후 DETAIL 수정 후 MASTER 클릭시 이벤트 발생  -->
<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)> 
if (!strSaveFlag) {
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
}
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (row > 0 && g_select==false) {  
    	
        setTimeout("getDetail()",50);
    //    GD_DETAIL.SetColumn("RANK");
    }    
</script>

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
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
         
            if(LC_S_STR_CD.BindColVal == "%"){
                showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
                LC_S_STR_CD.Focus();
                return;
            }
        
       // setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NAME, LC_S_STR_CD.BindColVal, '5');
        setEventNmWithoutPop( 'DS_O_RESULT', EM_S_EVENT_CD, EM_S_EVENT_NAME, 1, LC_S_STR_CD.BindColVal, "", "5","", EM_S_S_DT.Text, EM_S_E_DT.Text);
        if (DS_O_RESULT.CountRow == 1 ) {  
            EM_S_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
            EM_S_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출 
          //  mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal, '5');
        }
  //  }  
     
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
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
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_MNG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
    
	var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2+150) {
    	grd_height = top;    	
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
             <th width="100" class="point">점</th>
             <td width="200"><comment id="_NSID_"> <object
                 id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100 tabindex=1
                 width=197 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
             </td>
             <th width="100" class="point">행사기간</th>
             <td align="absmiddle"><comment id="_NSID_">
             <object id=EM_S_S_DT classid=<%= Util.CLSID_EMEDIT %> width=150
                 tabindex=1 align="absmiddle"
                 onblur="javascript:checkDateTypeYMD(this);"> </object> </comment><script>_ws_(_NSID_);</script>
             <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                 onclick="javascript:openCal('G',EM_S_S_DT)" /> ~ <comment
                 id="_NSID_"> <object id=EM_S_E_DT
                 classid=<%= Util.CLSID_EMEDIT %> width=150 tabindex=1
                 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
             </object> </comment><script>_ws_(_NSID_);</script> <img
                 src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                 onclick="javascript:openCal('G',EM_S_E_DT)" /></td> 
         </tr>
         <tr>
            <th>행사코드</th>
             <td colspan=3><comment id="_NSID_"> <object id=EM_S_EVENT_CD
                 classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1
                 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
                 src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
                 class="PR03"
                 onclick="javascript:eventPop( EM_S_EVENT_CD, EM_S_EVENT_NAME, LC_S_STR_CD.BindColVal, '', '5', '', EM_S_S_DT.Text, EM_S_E_DT.Text);"
                 id=popEventS /> <comment id="_NSID_"> <object
                 id=EM_S_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=203
                 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
              </td>
         </tr>
      </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="300" class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_MASTER width=310 height=760 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_MASTER">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
        <td width="5">
        </td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr>
		        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
			      <tr>
		            <th width="90">점</th>
		            <td width="145">
		                <comment id="_NSID_"> <object
                            id=LC_I_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100 tabindex=1
                            width=142 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
		            </td>
		            <th width="90">행사담당자</th>
                    <td>
                        <comment id="_NSID_">
                                <object id=EM_EVENT_USER classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle">
                                </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td> 
                  </tr>
                  <tr>                
		            <th>행사코드</th>
		            <td> 
		                <comment id="_NSID_">
		                        <object id=EM_I_EVENT_CD classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle" >
		                        <param name=Alignment   value=1>
		                        </object>
		                </comment><script>_ws_(_NSID_);</script>
		            </td>
		            <th>행사명</th>
		            <td> 
		                <comment id="_NSID_">
		                    <object id=EM_I_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%>   width=140 tabindex=1 align="absmiddle">
		                    </object>
		                </comment>
		                <script> _ws_(_NSID_);</script>   
		            </td>
		          </tr>
		          <tr>
		            <th>행사시작일</th>
	                <td> 
	                   <object id=EM_I_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%>   width=140 tabindex=1 
                         onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
                        </object>  
	                </td> 
	                <th>행사종료일</th>
	                <td> 
                       <object id=EM_I_EVENT_E_DT classid=<%=Util.CLSID_EMEDIT%>   width=140 tabindex=1 
                         onblur="javascript:checkDateTypeYMD(this);" align="absmiddle">
                        </object> 
                    </td> 
	              </tr>
	              <tr>
	                <th>행사주관구분</th>
	                <td> 
	                   <comment id="_NSID_"> <object
                            id=LC_EVENT_MNG_FLAG classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=142 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
	                </td> 
	                <th>행사테마(대)</th>
                    <td> 
                        <comment id="_NSID_">
                                <object id=EM_EVENT_L_CD classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle">
                                </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td> 
	              </tr>
	              <tr> 
	                <th>행사테마(중)</th>
	                <td> 
	                    <comment id="_NSID_">
	                            <object id=EM_EVENT_M_CD classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle">
	                            </object>
	                    </comment><script>_ws_(_NSID_);</script>
	                </td> 
	                 <th>행사테마(소)</th>
                    <td> 
                        <comment id="_NSID_">
                                <object id=EM_EVENT_S_CD classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle">
                                </object>
                        </comment><script>_ws_(_NSID_);</script>
                    </td> 
	              </tr>
	              <tr>
	               
	              </tr>
		        </table></td>
		      </tr>
		      <tr>
		        <td class="PL02"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		          <tr>
		            <td class="PT02"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		              <tr>
		                <td class="sub_title">
		                  <img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/>경품정보</td>
		                <td class="right PB03">
		                  <img src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"  hspace="2"  id="Addrow" onClick="javascript:addRow();" />
		                  <img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" id="Delrow" onClick="javascript:delRow();" />
		                </td>
		              </tr>
		            </table></td>
		          </tr>
		          <tr>
		            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
			          <tr>
			            <td>
			                <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=605 classid=<%=Util.CLSID_GRID%>>
			                    <param name="DataID" value="DS_DETAIL">
			                </OBJECT></comment><script>_ws_(_NSID_);</script>
		                </td>  
		              </tr>
		            </table></td>
		          </tr>
		        </table></td>
	          </tr>
	        </table></td>
	      </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_MASTER>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=STR_CD           Ctrl=LC_I_STR_CD        param=BindColVal</c>
        <c>Col=EVENT_CD         Ctrl=EM_I_EVENT_CD      param=Text</c> 
        <c>Col=EVENT_NAME       Ctrl=EM_I_EVENT_NAME    param=Text</c> 
        <c>Col=EVENT_S_DT       Ctrl=EM_I_EVENT_S_DT    param=Text</c> 
        <c>Col=EVENT_E_DT       Ctrl=EM_I_EVENT_E_DT    param=Text</c> 
        <c>Col=EVENT_MNG_FLAG   Ctrl=LC_EVENT_MNG_FLAG  param=BindColVal</c> 
        <c>Col=EVENT_CHAR_ID    Ctrl=EM_EVENT_USER      param=Text</c>  
        <c>Col=EVENT_L_CD       Ctrl=EM_EVENT_L_CD      param=Text</c> 
        <c>Col=EVENT_M_CD       Ctrl=EM_EVENT_M_CD      param=Text</c> 
        <c>Col=EVENT_S_CD       Ctrl=EM_EVENT_S_CD      param=Text</c> 
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script> 
</body>
</html>

