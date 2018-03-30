<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 정산관리> 제휴상품권(쿠폰) 매출입금관리
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif6110.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 : 2011.01.18 (김성미) 신규작성
 *         2011.04.21 (김정민) 수정개발
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
var g_Today = "";
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

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');

    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_CAL_YM, "THISMN", PK);                //정산월

    initEmEdit(EM_I_PAY_DT, "YYYYMMDD", PK);               //입금일자
    initEmEdit(EM_S_VEN_CD, "NUMBER3^6^0", NORMAL);        //제휴협력사코드(조회)
    initEmEdit(EM_S_VEN_NM, "GEN^40", READ);               //제휴협력사코드(조회)
    initEmEdit(EM_I_VEN_CD, "NUMBER3^6^0", READ);            //제휴협력사코드 
    initEmEdit(EM_I_VEN_NM, "GEN^40", READ);               //제휴협력사코드 
    initEmEdit(EM_I_PAY_AMT, "NUMBER^12^0", PK);           //입금액
    initEmEdit(EM_I_FEE_PAY_AMT, "NUMBER^12^0", PK);       //수수료금액
   
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점(조회)
    initComboStyle(LC_I_STR_CD,DS_I_STR_CD, "CODE^0^30,NAME^0^80", 1, READ);      //점(조회)
   
    //공통코드에서 가져 오기
    getStore("DS_S_STR_CD", "Y", "1", "N");
    getStore("DS_I_STR_CD", "Y", "1", "N");
     
    g_Today = getTodayDB("DS_O_RESULT");
    EM_I_PAY_DT.Text = g_Today;

    LC_S_STR_CD.Index    = 0  
    LC_S_STR_CD.Focus();
    
    chkEnable(true);
}

function gridCreate1(){ 
    var hdrProperies = '<FC>id={currow}     name="NO"             width=25    align=center</FC>'
                     + '<FC>id=CAL_YM       name="정산년월"       width=80    align=center              MASK="XXXX/XX" </FC>'
                     + '<FC>id=STR_NM       name="점"             width=80    align=center              </FC>'
                     + '<FC>id=VEN_NM       name="제휴협력사"     width=140   align=LFET                SumText="합계" </FC>'
                     + '<FC>id=PAYREC_FLAG_NM     name="지금/수취구분"   width=90    align=left </FC>'
                     + '<FC>id=CAL_FLAG_NM      name="정산구분"   width=90    align=left</FC>'
                     + '<FC>id=CAL_AMT          name="입금예정금액"       width=90    align=RIGHT  sumtext=@sum </FC>'
                     + '<FC>id=PAY_AMT          name="입금액"       width=90    align=RIGHT  sumtext=@sum </FC>'
                     + '<FC>id=FEE_PAY_AMT          name="수수료입금액"    width=90    align=RIGHT sumtext=@sum </FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";   
     
    var hdrProperies1 = '<FC>id={currow}    name="NO"           width=25   align=center</FC>'
        + '<FC>id=VEN_NM                  name="제휴협력사"     width=200   align=LEFT</FC>'
        + '<FC>id=STR_CD                    name="점"            width=120  align=LEFT EDITSTYLE=LOOKUP DATA="DS_I_STR_CD:CODE:NAME" </FC>'
        + '<FC>id=PAY_DT                    name="입금일자"       width=120   align=center MASK="XXXX/XX/XX"   SumText="합계"  </FC>'
        + '<FC>id=SEQ_NO                name="순번"          width=70     align=CENTER</FC>'
        + '<FC>id=PAY_AMT                   name="입금금액"       width=120   align=RIGHT sumtext=@sum </FC>'
        + '<FC>id=FEE_PAY_AMT               name="수수료금액"     width=120   align=RIGHT  sumtext=@sum </FC>';
        
   initGridStyle(GD_DETAIL, "common", hdrProperies1, false);
   GD_DETAIL.ViewSummary = "1";   
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
	    
	    chkEnable(false);
	    
	    DS_O_MASTER.ClearData();
	    DS_O_DETAIL.ClearData();
	    
	    var strStrCd   = LC_S_STR_CD.BindColVal;    //점
	    var strSCalYm  = EM_S_CAL_YM.Text;            //시작기간
	    var strVenCd   = EM_S_VEN_CD.Text;          //제휴협력사   
	       
	    var goTo = "getMaster";
	    var action = "O";
	    var parameters = "&strStrCd="     + encodeURIComponent(strStrCd)
	                   + "&strSCalYm="    + encodeURIComponent(strSCalYm) 
	                   + "&strVenCd="     + encodeURIComponent(strVenCd);
	    TR_MAIN.Action = "/mss/mgif611.mg?goTo=" + goTo + parameters;
	    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_MASTER=DS_O_MASTER)";
	    g_select = true;
	    TR_MAIN.Post();
	    g_select = false;

	    // 조회결과 Return
	    setPorcCount("SELECT", GD_MASTER);

	    if (DS_O_MASTER.CountRow != 0) {
	       // GD_MASTER.Focus();      
            getDetail2();
            //setNew(1);
	    }else {
	       //showMessage(STOPSIGN, OK, "GAUCE-1003", TR_MAIN.SrvErrMsg('GAUCE',i));
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
	if(DS_O_MASTER.CountRow ==0){
		showMessage(EXCLAMATION, Ok,  "USER-1000", " 정산내역을 먼저 조회해 주세요.");
		return;
	}
	 if (DS_O_DETAIL.IsUpdated){  
		  if (showMessage(Question, YesNo, "USER-1050") != "1") { //아니요 
	             //   DS_O_DETAIL.RowPosition = gv_preRownoDetail;
	                return;
	            }      
    }
	if(DS_O_DETAIL.SysStatus(DS_O_DETAIL.RowPosition) == "1"){
		DS_O_DETAIL.DeleteRow(DS_O_DETAIL.RowPosition);
	}
	
	DS_O_DETAIL.Addrow(); 
	DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"STR_CD") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");
	DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"VEN_CD") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"VEN_CD");
	DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"VEN_NM") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"VEN_NM");
	DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"CAL_YM") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CAL_YM");
	DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"CAL_TYPE") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CAL_TYPE");
    DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"PAYREC_FLAG") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PAYREC_FLAG");
    DS_O_DETAIL.NameValue(DS_O_DETAIL.RowPosition,"CAL_FLAG") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CAL_FLAG");
	chkEnable(true); 
	EM_I_PAY_AMT.Focus();
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
  	if(LC_I_STR_CD.BindColVal == "") {
  		showMessage(StopSign, Ok,  "USER-1002", "점코드");
  		return;	
  	}
  	if(EM_I_PAY_DT.Text == "") {
  		showMessage(StopSign, Ok,  "USER-1003", "입금일자");
          return;
  	}
  	if(EM_I_VEN_CD.Text == "") {
  		showMessage(StopSign, Ok,  "USER-1003", "제휴협력사");
          return;
  	}
  	if(EM_I_PAY_AMT.Text == "") {
  		showMessage(StopSign, Ok,  "USER-1003", "입금액");
          return;
  	}
  	if(EM_I_FEE_PAY_AMT.Text == "") {
          showMessage(StopSign, Ok,  "USER-1003", "수수료금액");
          return;
      }
  	
  	 //마감체크
    if(getCloseCheck('DS_CLOSECHECK',LC_I_STR_CD.BindColVal,EM_I_PAY_DT.Text,'MGIF','47','0','M') == 'TRUE') {
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }
  	 
  	//변경또는 신규 내용을 저장하시겠습니까?
      if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
          LC_I_STR_CD.Focus();
          return;
      }
  	
       
      var strPayAmt = GD_DETAIL.SummaryString("PAY_AMT", 1);
      var strFeeAmt = GD_DETAIL.SummaryString("FEE_PAY_AMT", 1);
      
      var parameters = "&strPayAmt="  + encodeURIComponent(strPayAmt) 
                     + "&strFeeAmt="  + encodeURIComponent(strFeeAmt);
      
      var goTo = "save"; 
      TR_MAIN.Action = "/mss/mgif611.mg?goTo=" + goTo + parameters;  
      TR_MAIN.KeyValue = "SERVLET(I:DS_O_DETAIL=DS_O_DETAIL)";
      TR_MAIN.Post();
     
      DS_O_MASTER.ClearData();
      DS_O_DETAIL.ClearData();
      //정상 처리일 경우 조회
      if( TR_MAIN.ErrorCode == 0) btn_Search();
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
 /**
  * getVenCd_S()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-06
  * 개    요 : 제휴사 팝업 오픈시 점코드 필수
  * return값 : void
  */
 function getVenCd_S(){
     if(LC_S_STR_CD.BindColVal == "%"){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            LC_S_STR.Focus();
            return;
        }
     getMssEvtVenPop( EM_S_VEN_CD, EM_S_VEN_NM, 'S', '1', '', LC_S_STR_CD.BindColVal, '');
 }
 
 /**
  * getVenCd_I()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-06
  * 개    요 : 제휴사 팝업 오픈시 점코드 필수
  * return값 : void
  */
 function getVenCd_I(){
     if(LC_I_STR_CD.BindColVal == "%"){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            LC_S_STR.Focus();
            return;
        }
     getEvtVenPop( EM_I_VEN_CD, EM_I_VEN_NM, 'S', '1', '', LC_I_STR_CD.BindColVal, '')
 }
 
 /**
  * chkEnable()
  * 작 성 자 : 
  * 작 성 일 : 2011-04-21
  * 개    요 : 컨트롤 제어
  * return값 : void
  */
 function chkEnable(flag) {
	 if(flag == true) { 
         EM_I_PAY_DT.Enable = true;
         EM_I_PAY_AMT.Enable = true;
         EM_I_FEE_PAY_AMT.Enable = true;
         enableControl(imgDt, true);
         
         if(DS_O_DETAIL.SysStatus(DS_O_DETAIL.RowPosition) == "1"){
        	 EM_I_PAY_DT.Text = g_Today; 
             EM_I_PAY_AMT.Text = "";
             EM_I_FEE_PAY_AMT.Text = "";
         }
	 }
	 else {
		 EM_I_PAY_DT.Text = "";
	     EM_I_PAY_DT.Enable = false;
	     EM_I_PAY_AMT.Enable = false;
	     EM_I_FEE_PAY_AMT.Enable = false;
	     enableControl(imgDt, false);
		 
	 }
 }
 
 /**
  * getDetail()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-21
  * 개    요 : DETAIL조회
  * return값 : void
  */
 function getDetail() { 
    var strStrCd   = LC_S_STR_CD.BindColVal;    //점
    var strSCalYm     = EM_S_CAL_YM.Text;            //시작기간
    var strVenCd   = EM_S_VEN_CD.Text;          //제휴협력사   
      
    var goTo        = "getDetail" ;    
    var action      = "O";     
    var parameters  = "&strStrCd="   + encodeURIComponent(strStrCd)
                    + "&strSCalYm="  + encodeURIComponent(strSCalYm)
                    + "&strVenCd="   + encodeURIComponent(strVenCd);
         
    TR_MAIN.Action="/mss/mgif611.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_MAIN.Post(); 
   
    setPorcCount("SELECT", GD_DETAIL);  
    
 }
 
 /**
  * getDetail2()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-21
  * 개    요 : DETAIL조회
  * return값 : void
  */
 function getDetail2() { 
  	var strStrCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");    //점
    var strSCalYm  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CAL_YM");            //시작기간
    var strVenCd   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"VEN_CD");          //제휴협력사
    var strPayRecFlag   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PAYREC_FLAG");          //제휴협력사
    var strCalFlag   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CAL_FLAG");          //제휴협력사
        
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
				   + "&strSCalYm="     + encodeURIComponent(strSCalYm)
				   + "&strVenCd="      + encodeURIComponent(strVenCd)
				   + "&strPayRecFlag=" + encodeURIComponent(strPayRecFlag)
				   + "&strCalFlag="    + encodeURIComponent(strCalFlag);
        
    TR_MAIN.Action="/mss/mgif611.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
    TR_MAIN.Post();   
    
    if(DS_O_DETAIL.CountRow > 0){
    	 chkEnable(true);
    }else{
    	chkEnable(false);
    }
 
 }

 
 function setNew(row){
	 LC_I_STR_CD.BindColVal = DS_O_MASTER.NameValue(row,"STR_CD");
     EM_I_VEN_CD.Text = DS_O_MASTER.NameValue(row,"VEN_CD");
     EM_I_VEN_NM.Text = DS_O_MASTER.NameValue(row,"VEN_NM");
     chkEnable(true);
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
<script language=JavaScript for=DS_O_MASTER event=CanRowPosChange(row)>
    if(DS_O_DETAIL.CountRow > 0){ 
        if (DS_O_DETAIL.IsUpdated) {
            var ret = showMessage(Question, YesNo, "USER-1074");
            if (ret != "1") {
                //DS_O_DETAIL.RowPosition = gv_preRowno;
                return false;
            }
        }
    }
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (row > 0 && g_select == false) {  
    	getDetail2();
    	
  //      setTimeout("getDetail()",50);
      //  GD_DETAIL.SetColumn("GIFT_TYPE_CD");
    }    
</script>  

<script language=JavaScript for=DS_O_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script> 

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( this.Text ==""){
    EM_S_VEN_NM.Text = "";
       return;
   }
if(this.Text.length > 0){
    if(LC_S_STR_CD.BindColVal == "%"){
        showMessage(EXCLAMATION , OK, "USER-1001", "점코드");
        LC_S_STR_CD.Focus();
        return;
    }
    getMssEvtVenNonPop( "DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, "E", "Y", "1", '', LC_S_STR_CD.BindColVal, '');
}
return true;
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
 EM_S_VEN_CD.Text = "";
 EM_S_VEN_NM.Text = "";
</script>

<script language=JavaScript for=EM_I_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( this.Text ==""){
    EM_I_VEN_NM.Text = "";
       return;
   }
if(this.Text.length > 0){
    if(LC_I_STR_CD.BindColVal == "%"){
        showMessage(EXCLAMATION , OK, "USER-1001", "점코드");
        LC_I_STR_CD.Focus();
        return;
    }
    getMssEvtVenNonPop("DS_O_RESULT_NO", EM_I_VEN_CD, EM_I_VEN_NM, "E", "Y", "1", '', LC_I_STR_CD.BindColVal, '');
}
return true;
</script>

<script language=JavaScript for=LC_I_STR_CD event=OnSelChange()>
 EM_I_VEN_CD.Text = "";
 EM_I_VEN_NM.Text = "";
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
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_AREA_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_MNG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_I_CONDITION  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT_NO"  classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


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
             <th width="80" class="point">점</th>
            <td width="125">
               <comment id="_NSID_">
                   <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100  tabindex=1  width=120 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th width="80" class="point">정산월</th>
            <td width="200">
               <comment id="_NSID_">
                <object id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle"
                onblur="javascript:checkDateTypeYM(this);" >
                </object></comment><script>_ws_(_NSID_);</script>
                 <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_CAL_YM)" align="absmiddle" />
            </td>
            <th width="80">제휴협력사</th>
            <td >
                <comment id="_NSID_">
                  <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=60 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" class="PR03"  onclick="javascript:getVenCd_S();" id=imgVenS/>
                  <comment id="_NSID_">
                  <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=95 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>  
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
     <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>정산내역</td>
      </tr>
    </table></td>
  </tr>  
  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=170 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_MASTER">
          </OBJECT></comment><script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
   <tr>
    <td class="PT01 PB05">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
             <th width="80" class="point">점</th>
            <td width="130">
                <comment id="_NSID_">
                   <object id=LC_I_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100  tabindex=1  width=125 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
             <th width="83" class="point">제휴협력사</th>
            <td colspan=3>
                <comment id="_NSID_">
                  <object id=EM_I_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=85 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                  <comment id="_NSID_">
                 <!-- <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" class="PR03" id=imgVenI onclick="javascript:getVenCd_I();" />--> 
                  <object id=EM_I_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=135 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
            </td>
          </tr> 
          <tr> 
           <th class="point">입금일자</th>
            <td >
                <comment id="_NSID_">
                <object id=EM_I_PAY_DT classid=<%=Util.CLSID_EMEDIT%>   width=100 tabindex=1 align="absmiddle"
                onblur="javascript:checkDateTypeYMD(this);" >
                </object>
                 </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_I_PAY_DT)" align="absmiddle" id=imgDt />
            </td>
            <th class="point">입금액</th>
            <td >
                <comment id="_NSID_">
                  <object id=EM_I_PAY_AMT classid=<%=Util.CLSID_EMEDIT%>   width=122 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>&nbsp;
            </td>
            <th  class="point">수수료금액</th>
            <td >
                <comment id="_NSID_">
                  <object id=EM_I_FEE_PAY_AMT classid=<%=Util.CLSID_EMEDIT%>   width=121 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>&nbsp;
            </td>
          </tr>
        </table>
    </td>
  </tr>
 <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot" ></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
     <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>입금내역</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=228 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_DETAIL">
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
<comment id="_NSID_">
<object id=BD_DETAIL classid=<%=Util.CLSID_BIND%>>
    <param name=DataID value=DS_O_DETAIL>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
        <c>Col=STR_CD       Ctrl=LC_I_STR_CD        param=BindColVal</c>  
        <c>Col=PAY_DT       Ctrl=EM_I_PAY_DT        param=Text</c>   
        <c>Col=VEN_CD       Ctrl=EM_I_VEN_CD        param=Text</c>  
        <c>Col=VEN_NAME     Ctrl=EM_I_VEN_NM        param=Text</c>    
        <c>Col=PAY_AMT      Ctrl=EM_I_PAY_AMT       param=Text</c>    
        <c>Col=FEE_PAY_AMT  Ctrl=EM_I_FEE_PAY_AMT   param=Text</c>      
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

