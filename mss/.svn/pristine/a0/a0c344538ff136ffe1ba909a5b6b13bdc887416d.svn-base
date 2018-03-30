<!-- 
/*******************************************************************************
 * 시스템명 : 사은행사관리 > 경품행사> 경품행사 당첨자등록
 * 작 성 일 : 2011.05.16
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mcae2050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경품행사 당첨자를 등록 조회한다.
 * 이    력 : 2011.05.16 (김정민) 신규개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<% request.setCharacterEncoding("utf-8"); %>

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

<script LANGUAGE="JavaScript"><!--

/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_select = false; 
var strKey = true;
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
 var top = 480;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');

    // Output Data Set Header 초기화 

    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_S_DT, "SYYYYMMDD", PK);                //기간FROM(조회)
    initEmEdit(EM_S_E_DT, "YYYYMMDD", PK);                 //기간TO(조회) 
    initEmEdit(EM_S_EVENT_CD,   "NUMBER3^6^0", NORMAL);    //행사코드(조회)
    initEmEdit(EM_S_EVENT_NAME, "GEN^40", READ);           //행사명(조회)  
    
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회) 
   
    //공통코드에서 가져 오기
    getStore("DS_S_STR_CD", "Y", "1", "N"); 
    getEtcCodeSub("DS_RANK");                // 순위
    EM_S_E_DT.Text   = getTodayFormat("YYYYMMDD");  
    LC_S_STR_CD.Index    = 0;  
    LC_S_STR_CD.Focus();
    
 //   chkEnable(false);
}

function gridCreate1(){ 
    var hdrProperies = '<FC>id={currow}     name="NO"          width=25     align=center</FC>' 
                     + '<FC>id=STR_CD       name="점"           width=170    align=LEFT  EDITSTYLE=LOOKUP   DATA="DS_S_STR_CD:CODE:NAME" </FC>'
                     + '<FC>id=EVENT_CD     name="행사코드"      width=180    align=center MASK="XXXXXX-XXXXX" </FC>'
                     + '<FC>id=EVENT_NAME   name="행사명"        width=300    align=LFET </FC>'
                     + '<FC>id=EVENT        name="추첨여부"      width=100    align=center </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false); 
     
    var hdrProperies1 = '<FC>id={currow}    name="NO"            width=25   align=center</FC>'
    	+ '<FC>id=RANK_SEQ_NO               name="*순위"          width=150   align=LEFT EDITSTYLE=LOOKUP   DATA="DS_RANK:CODE:NAME" </FC>'
        + '<FC>id=WIN_NAME                  name="*이름"          width=60   align=LEFT </FC>' 
        + '<FC>id=SS_NO                     name="생년월일"       width=100  align=LEFT MASK="XXXXXX" edit=numeric  </FC>' 
        + '<FG>id=STR_NAME                  name="연락처"         align=center >'
        + '<FC>id=PHONE1_NO                 name="지역"           width=30  align=RIGHT edit=numeric </FC>'
        + '<FC>id=PHONE2_NO                 name="국번"           width=40  align=RIGHT edit=numeric  </FC>'
        + '<FC>id=PHONE3_NO                 name="번호"           width=40  align=RIGHT edit=numeric  </FC>'
        + '</FG>' 
        + '<FG>id=STR_NAME                  name="휴대폰번호"       align=center >'
        + '<FC>id=HP1_NO                    name="통신사"          width=50  align=RIGHT edit=numeric  </FC>'
        + '<FC>id=HP2_NO                    name="국번"            width=40  align=RIGHT edit=numeric  </FC>'
        + '<FC>id=HP3_NO                    name="번호"            width=40  align=RIGHT edit=numeric  </FC>' 
        + '</FG>' 
        + '<FC>id=ADDR                      name="주소"            width=150  align=LEFT </FC>' 
        + '<FC>id=EMAIL                     name="이메일주소"       width=90  align=LEFT </FC>'
        + '<FC>id=TAX_AMT                   name="제세;공과금"       width=70  align=RIGHT  edit=numeric </FC>'  
        ;
        
   initGridStyle(GD_DETAIL, "common", hdrProperies1, true); 
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
	    if (DS_O_DETAIL.IsUpdated) {
	        if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요 
	         //   DS_O_DETAIL.RowPosition = gv_preRownoDetail;
	            return;
	        }      
	    } 
	   // chkEnable(false);
	    if (EM_S_S_DT.Text > EM_S_E_DT.Text){ 
	        showMessage(INFORMATION, OK, "USER-1008", "행사종료기간", "행사시작기간");
	        EM_S_E_DT.Focus();
	        return;
	    }
	    
	    DS_O_MASTER.ClearData();
	    DS_O_DETAIL.ClearData();
	    
	    var strStrCd   = LC_S_STR_CD.BindColVal;    //점
	    var strSdt     = EM_S_S_DT.Text;            //시작기간
	    var strEdt     = EM_S_E_DT.Text;            //종료기간    
	    var strEventCd = EM_S_EVENT_CD.Text;        //행사   
	       
	    var goTo = "getMaster";
	    var action = "O";
	    var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
	                   + "&strSdt="      + encodeURIComponent(strSdt)
	                   + "&strEdt="      + encodeURIComponent(strEdt)
	                   + "&strEventCd="  + encodeURIComponent(strEventCd);
	    TR_MAIN.Action = "/mss/mcae205.mc?goTo=" + goTo + parameters;
	    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_MASTER=DS_O_MASTER)";
	    g_select = true;
	    TR_MAIN.Post();
	    g_select = false;

	    // 조회결과 Return
	    setPorcCount("SELECT", GD_MASTER); 
	    
	    if(DS_O_MASTER.CountRow !=0) {
	    	getDetail2();
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
		if (!DS_O_DETAIL.IsUpdated){
	        showMessage(StopSign, OK, "USER-1028");
	        return;
	    }
		 
        var strStrCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD"); 
        var strEventCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"EVENT_CD");  

        for(var i=0; i <= DS_O_DETAIL.CountRow; i++) {
            if(DS_O_DETAIL.NameValue(i,"RANK_SEQ_NO") == "") {  
                showMessage(StopSign, OK, "USER-1002", "순위"); 
                setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "RANK_SEQ_NO");
                return;
            }
            if(DS_O_DETAIL.NameValue(i,"WIN_NAME") == "") {  
                showMessage(StopSign, OK, "USER-1003", "이름"); 
                setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "WIN_NAME");
                return;
            } 
        } 
        
        for (i=1; i<=DS_O_DETAIL.CountRow; i++) { 
            
            // 이름
            var strName = checkLenByte(DS_O_DETAIL, i, "WIN_NAME");
            if (strName > 10) {
                showMessage(STOPSIGN, OK, "USER-1048", "이름을 10");
                DS_O_DETAIL.RowPosition = i; 
                setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "WIN_NAME");
                return false;
            } 
            
            //주소      
              var strAddr = checkLenByte(DS_O_DETAIL, i, "ADDR");
              if (strAddr > 80) {
                  showMessage(STOPSIGN, OK, "USER-1048", "주소를 80");
                  DS_O_DETAIL.RowPosition = i; 
                  setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "ADDR");
                  return false;
              } 
            
              // 이메일
              var strEmail = checkLenByte(DS_O_DETAIL, i, "EMAIL");
              if (strEmail > 40) {
                  showMessage(STOPSIGN, OK, "USER-1048", "이메일을 40");
                  DS_O_DETAIL.RowPosition = i; 
                  setFocusGrid(GD_DETAIL, DS_O_DETAIL, i, "EMAIL");
                  return false;
              }
          }
 
      //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_DETAIL.Focus();
            return;
        } 
        
        var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                       + "&strEventCd="  + encodeURIComponent(strEventCd);
        
        var goTo = "save"; 
        TR_MAIN.Action = "/mss/mcae205.mc?goTo=" + goTo + parameters;  
        TR_MAIN.KeyValue = "SERVLET(I:DS_O_DETAIL=DS_O_DETAIL)";
        TR_MAIN.Post();
       
        DS_O_MASTER.ClearData();
        DS_O_DETAIL.ClearData();
        btn_Search();  
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
 * btn_AddRow()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.03.10
 * 개    요 : 행추가
 * return값 :
 */
function addRow() { 
	 if(DS_O_MASTER.CountRow == 0){
	       return;
	   } 
	 if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"RANK_SEQ_NO") == "") {
         showMessage(StopSign, OK, "USER-1002", "순위"); 
         setFocusGrid(GD_DETAIL, DS_O_DETAIL, DS_O_DETAIL.CountRow, "RANK_SEQ_NO");
         return;
      }
	 
	 if(DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"WIN_NAME") == "") {
         showMessage(StopSign, OK, "USER-1003", "이름"); 
         setFocusGrid(GD_DETAIL, DS_O_DETAIL, DS_O_DETAIL.CountRow, "WIN_NAME");
         return;
      }
	 
	 getEtcCodeSub("DS_RANK"); 
    DS_O_DETAIL.AddRow();        
}

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행삭제
 * return값 : void
 */

function delRow() {

    if(DS_O_DETAIL.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1019");
           return;
       }
        DS_O_DETAIL.DeleteRow(DS_O_DETAIL.RowPosition); 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getEtcCodeSub()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.03.10
  * 개    요 : 공통코드가져오기
  * return값 :
  */
 function getEtcCodeSub(objDateSet) {  
     
     var strStrCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD"); 
     var strEventCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"EVENT_CD"); 
     
     var goTo = "getEtcCodeSub";
     var parameters = ""
         + "&strDSName="     + encodeURIComponent(objDateSet)
         + "&strStrCd="      + encodeURIComponent(strStrCd)
         + "&strEventCd="    + encodeURIComponent(strEventCd); 
      //   alert(parameters);
     TR_MAIN.Action = "/mss/mcae205.mc?goTo=" + goTo + parameters; 
     TR_MAIN.KeyValue = "SERVLET(O:"+objDateSet+"="+objDateSet+")";
     TR_MAIN.StatusResetType= "2";
     TR_MAIN.Post();
 } 
 
 /**
  * getDetail()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-05-06
  * 개    요 : DETAIL조회
  * return값 : void
  */
 function getDetail() {  
      if (DS_O_DETAIL.IsUpdated) {
             if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요 
              //   DS_O_DETAIL.RowPosition = gv_preRownoDetail;
                 return;
             }      
         }  
      getEtcCodeSub("DS_RANK");    

      var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");
      var strEventCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"EVENT_CD"); 
     
      var goTo       = "getDetail" ;    
      var action     = "O";     
      var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                     + "&strEventCd="  + encodeURIComponent(strEventCd);
     
      TR_MAIN.Action="/mss/mcae205.mc?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
      TR_MAIN.Post();
      
      setPorcCount("SELECT", GD_DETAIL);   
 
 }
 
 /**
  * getDetail()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-05-06
  * 개    요 : DETAIL조회
  * return값 : void
  */
 function getDetail2() {  
       
      getEtcCodeSub("DS_RANK");    
 
       var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");
       var strEventCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"EVENT_CD"); 
      
       var goTo       = "getDetail" ;    
       var action     = "O";     
       var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                      + "&strEventCd="  + encodeURIComponent(strEventCd);
      
       TR_MAIN.Action="/mss/mcae205.mc?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
       TR_MAIN.Post();
        
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
<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>

<!-- 조회 후 DETAIL 수정 후 MASTER 클릭시 이벤트 발생  -->
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if(DS_O_DETAIL.CountRow > 1){ 
        if (DS_O_DETAIL.IsUpdated) {
            var ret = showMessage(Question, YesNo, "USER-1059");
            if (ret != "1") {
                DS_O_DETAIL.RowPosition = gv_preRowno;
                return;
            }
        } 
    } 
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (row > 0 && g_select == false) {   
        setTimeout("getDetail()",50);
    }    
</script>

<script language="javascript"  for=GD_DETAIL event=CanColumnPosChange(row,Colid)>
//전화번호1
if (Colid == "PHONE1_NO") {
    var tmpLen = checkLenByte(DS_O_DETAIL, row, Colid)
    if (tmpLen > 3 ) {
        showMessage(STOPSIGN, OK, "USER-1048", "연락처(지역)를 3"); 
        DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"PHONE1_NO") = "";
        return false;
    }  else {
        return true;
    }
}

//전화번호2
if (Colid == "PHONE2_NO") {
    var tmpLen = checkLenByte(DS_O_DETAIL, row, Colid)
    if (tmpLen > 4 ) {
        showMessage(STOPSIGN, OK, "USER-1048", "연락처(국번)를 4"); 
        DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"PHONE2_NO") = "";
        return false;
    }  else {
        return true;
    }
}

//전화번호3
if (Colid == "PHONE3_NO") {
    var tmpLen = checkLenByte(DS_O_DETAIL, row, Colid)
    if (tmpLen > 4 ) {
        showMessage(STOPSIGN, OK, "USER-1048", "연락처(번호)를 4"); 
        DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"PHONE3_NO") = "";
        return false;
    }  else {
        return true;
    }
}

//휴대폰번호1
if (Colid == "HP1_NO") {
    var tmpLen = checkLenByte(DS_O_DETAIL, row, Colid)
    if (tmpLen > 3 ) {
        showMessage(STOPSIGN, OK, "USER-1048", "휴대폰번호(통신사)를 3"); 
        DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"HP1_NO") = "";
        return false;
    }  else {
        return true;
    }
}

//휴대폰번호2
if (Colid == "HP2_NO") {
    var tmpLen = checkLenByte(DS_O_DETAIL, row, Colid)
    if (tmpLen > 4 ) {
        showMessage(STOPSIGN, OK, "USER-1048", "휴대폰번호(국번)를 4"); 
        DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"HP2_NO") = "";
        return false;
    }  else {
        return true;
    }
}

//휴대폰번호3
if (Colid == "HP3_NO") {
    var tmpLen = checkLenByte(DS_O_DETAIL, row, Colid)
    if (tmpLen > 4 ) {
        showMessage(STOPSIGN, OK, "USER-1048", "휴대폰번호(번호)를 4"); 
        DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"HP3_NO") = "";
        return false;
    }  else {
        return true;
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
<object id="DS_S_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_RANK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MBSH_NO" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
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
						<th width="100" class="point">점</th>
						<td width="200"><comment id="_NSID_"><object
							id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="197"
							tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script></td>
						<th width="100" class="point">행사기간</th>
						<td><comment id="_NSID_"> <object id=EM_S_S_DT
							classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1 onblur="javascript:checkDateTypeYMD(this);"
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_S_DT)" align="absmiddle" />
						~ <comment id="_NSID_"> <object id=EM_S_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=150 tabindex=1
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_E_DT)" align="absmiddle" /></td>
					</tr>
					<tr>
						<th>행사코드</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=90
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
							align="absmiddle" class="PR03"
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
	<!--  그리드의 구분dot & 여백  -->
	<tr height=2>
		<td></td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="PT5" colspan=2>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
					align="absmiddle" class="PR03" />행사정보</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=300 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_MASTER">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr height=2>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="PT5" colspan=2>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="sub_title"><img
					src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
					align="absmiddle" class="PR03" />당첨자 정보</td>
				<td class="right"><img id=Addrow
					src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18"
					hspace="2" onClick="javascript:addRow();" /> <img id=Delrow
					src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
					onClick="javascript:delRow();" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<td class="PT01 PB03">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="BD4A">
		<tr>
			<td><comment id="_NSID_"><OBJECT id=GD_DETAIL
				width=100% height=410 classid=<%=Util.CLSID_GRID%>>
				<param name="DataID" value="DS_O_DETAIL">
			</OBJECT></comment><script>_ws_(_NSID_);</script></td>
		</tr>
	</table>
	</td>
	</tr>
</table>
</DIV>

</body>
</html>

