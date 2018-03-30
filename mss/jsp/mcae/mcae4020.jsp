<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급/취소 > 사은품지급취소
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : MCAE4020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김슬기) 신규작성
 *        2011.03.10 (김성미) 프로그램 작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var strUserID = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
 var strUserNM = '<c:out value="${sessionScope.sessionInfo.USER_NAME}" />';
 var strToday    = getTodayFormat("yyyymmdd");
 /**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터    
    gridCreate2();
    gridCreate3();
    
    // EMedit에 초기화
    initEmEdit(EM_REG_DT, "TODAY", READ);               //등록일자
    initEmEdit(EM_REG_NM, "GEN", READ);                 //등록자
    initEmEdit(EM_RECEIPT_NO, "GEN^24", NORMAL);        //영수증번호
    initEmEdit(EM_STR_NM, "GEN", READ);                 //지급점
    initEmEdit(EM_PRSNT_DT, "YYYYMMDD", READ);          //지급일자
    initEmEdit(EM_PRSNT_FLAG_NM, "GEN", READ);          //지급구분
    initEmEdit(EM_EVENT_NM, "GEN", READ);               //행사명
    initEmEdit(EM_EVENT_S_DT, "YYYYMMDD", READ);        //행사 시작일
    initEmEdit(EM_EVENT_E_DT, "YYYYMMDD", READ);        //행사 종료일
    initEmEdit(EM_TOT_SALE_AMT, "NUMBER^12^0", READ);   //총 인정 매출금액
    initEmEdit(EM_EVENT_TYPE_NM, "GEN", READ);          //사은행사 유형

    //콤보 초기화
    initComboStyle(LS_S_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);      //점코드
    initComboStyle(LC_CARD_COMP,DS_O_CARD_COMP, "CODE^0^30,NAME^0^80", 1, READ);    //카드사
    getStore("DS_O_STR", "Y", "1", "N");
    LS_S_STR.Index = 0;
    EM_RECEIPT_NO.Focus();
    EM_REG_NM.Text = strUserNM;
}


function gridCreate1(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=STR_NM      name="점"           width=70   align=left  </FC>'
			        + '<FC>id=SALE_DT    name="영수증일자"    mask="XXXX/XX/XX"   width=80  align=center</FC>'
                    + '<FC>id=TRAN_NO    name="영수증번호"       width=80  align=left</FC>'
                    + '<FC>id=TOT_SALE_AMT    name="매출금액"       width=70  align=right</FC>'
                    + '<FC>id=SALE_AMT    name="인정금액"       width=80  align=right</FC>'
                    + '<FC>id=DIV_AMT    name="지급안분금액"       width=90  align=right</FC>';
                     
    initGridStyle(GD_PRSNT, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies2 ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
			        + '<FC>id=TRG_NAME    name="대상범위"       width=70  align=left</FC>'
			        + '<FC>id=SKU_NAME    name="증정품명"     width=70   align=left</FC>'
			        + '<FC>id=PRSNT_AMT    name="매입원가"       width=80  align=right</FC>';
                     
    initGridStyle(GD_PRSNTRECP, "common", hdrProperies2, false);
}

function gridCreate3(){
    var hdrProperies ='<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                    + '<FC>id=STR_NM      name="점"           width=70   align=left  </FC>'
                    + '<FC>id=SALE_DT    name="영수증일자"    mask="XXXX/XX/XX"   width=80  align=center</FC>'
                    + '<FC>id=TRAN_NO    name="영수증번호"       width=80  align=left</FC>'
                    + '<FC>id=TOT_SALE_AMT    name="매출금액"       width=70  align=right</FC>'
                    + '<FC>id=CARD_COMP_NM    name="카드사"       width=70  align=right</FC>'
                    + '<FC>id=SALE_AMT    name="인정금액"       width=80  align=right</FC>'
                    + '<FC>id=DIV_AMT    name="지급안분금액"       width=90  align=right</FC>';
                     
    initGridStyle(GD_PRSNT_CARD, "common", hdrProperies, false);
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
	 DS_IO_EVENT_INFO.ClearData();
     DS_IO_PRSNT.ClearData();
     DS_IO_PRSNT_CARD.ClearData();
     DS_IO_PRSNTRECP.ClearData();
     DS_O_CARD_COMP.ClearData();
     EM_RECEIPT_NO.Text = "";
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
 * 작 성 일 : 2011-03-10
 * 개    요 : 지급품 취소 내용 저장 
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_EVENT_INFO.CountRow == 0 || (DS_IO_PRSNT.CountRow == 0 && DS_IO_PRSNT_CARD.CountRow == 0) || DS_IO_PRSNTRECP.CountRow == 0){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
    
    if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
    
    var strParams = "&strPrsntDt="  + encodeURIComponent(EM_REG_DT.Text)
                  + "&strEventType="+ encodeURIComponent(DS_IO_EVENT_INFO.NameValue(1,"EVENT_TYPE"))
                  + "&strPrsntFlag="+ encodeURIComponent(DS_IO_EVENT_INFO.NameValue(1,"PRSNT_FLAG"));
    TR_MAIN.Action="/mss/mcae402.mc?goTo=save"+strParams; 
    if(DS_IO_EVENT_INFO.NameValue(1,"EVENT_TYPE") == "02"){
    	TR_MAIN.KeyValue="SERVLET(I:DS_IO_EVENT_INFO=DS_IO_EVENT_INFO,I:DS_IO_PRSNT_CARD=DS_IO_PRSNT_CARD,I:DS_IO_PRSNTRECP=DS_IO_PRSNTRECP)"; 
    }else{
    	TR_MAIN.KeyValue="SERVLET(I:DS_IO_EVENT_INFO=DS_IO_EVENT_INFO,I:DS_IO_PRSNT=DS_IO_PRSNT,I:DS_IO_PRSNTRECP=DS_IO_PRSNTRECP)"; 
    }
    TR_MAIN.Post();
 // 정상 처리일 경우 초기화
    if( TR_MAIN.ErrorCode == 0){
    	getEventInfo();// 20141112_강연식 영수증 중복 행사건
    	btn_New(); 
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
 /**
  * getEventInfo()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-08
  * 개    요 : 영수증 번호 스캔시 행사 정보 조회
  * return값 : void
  */

 function getEventInfo() {
      
      // 조회조건 셋팅
       var strReceiptNo   = EM_RECEIPT_NO.Text;
       var strStrCd       = LS_S_STR.BindColVal; //strReceiptNo.substring(1,3);
       var strSaleDt      = strToday.substring(0,2) + strReceiptNo.substring(1,7);
       var strPosNo       = strReceiptNo.substring(7,11);
       var strTranNo      = strReceiptNo.substring(11,16);
       
      /* if(strStrCd != LS_S_STR.BindColVal){
    	   showMessage(EXCLAMATION , OK, "USER-1000", LS_S_STR.Text+" 영수증을 입력하세요.");
    	   EM_RECEIPT_NO.Text = "";
    	   return;
       }*/
       var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                      + "&strSaleDt=" + encodeURIComponent(strSaleDt)
                      + "&strPosNo="  + encodeURIComponent(strPosNo)
                      + "&strTranNo=" + encodeURIComponent(strTranNo);
       TR_MAIN.Action="/mss/mcae402.mc?goTo=getEventInfo"+parameters;  
       TR_MAIN.KeyValue="SERVLET(O:DS_IO_EVENT_INFO=DS_IO_EVENT_INFO)"; //조회는 O
       TR_MAIN.Post();
       
       if(DS_IO_EVENT_INFO.CountRow == 0){
           showMessage(EXCLAMATION , OK, "USER-1000", "지급 내역이 없습니다.");
           btn_New();
       }else{
    	   if(DS_IO_EVENT_INFO.NameValue(1,"EVENT_TYPE") == "02"){
    		   getCardComp();  
    		   LC_CARD_COMP.Enable = true;
    		   DIV_PRSNT_CARD.style.display = '';
    		   DIV_PRSNT.style.display = 'none';
    	   }else{
    		   LC_CARD_COMP.Enable = false;
    		   DIV_PRSNT_CARD.style.display = 'none';
    		   DIV_PRSNT.style.display = '';
    	   }
    	   getPrsntInfo();
           //EM_RECEIPT_NO.Text = "";
       }
 }
 
 /**
  * getCardComp()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-21
  * 개    요 : 카드 행사인경우 카드사 콤보조회
  * return값 : void
  */
 function getCardComp() {
      DS_O_CARD_COMP.ClearData();
      // 조회조건 셋팅
       var parameters = "&strEventCd="+ encodeURIComponent(DS_IO_EVENT_INFO.NameValue(1,"EVENT_CD"))
                      + "&strStrCd="  + encodeURIComponent(DS_IO_EVENT_INFO.NameValue(1,"STR_CD"));
       
       TR_MAIN.Action="/mss/mcae402.mc?goTo=getCardComp"+parameters;  
       TR_MAIN.KeyValue="SERVLET(O:DS_O_CARD_COMP=DS_O_CARD_COMP)"; //조회는 O
       TR_MAIN.Post();
       if(DS_O_CARD_COMP.CountRow == 0){
           return false;
       }
       LC_CARD_COMP.Index = 0;
 }
 
 /**
  * getPrsntInfo()
  * 작 성 자 : 
  * 작 성 일 : 2011-03-07
  * 개    요 : 영수증 번호 스캔시 사은품 지급 정보 조회
  * return값 : void
  */
 function getPrsntInfo() {
      // 조회조건 셋팅
       var strEventCd       = DS_IO_EVENT_INFO.NameValue(1,"EVENT_CD");
       var strStrCd         = DS_IO_EVENT_INFO.NameValue(1,"STR_CD");
       var strPrsntDt       = DS_IO_EVENT_INFO.NameValue(1,"PRSNT_DT");
       var strPrsntNo       = DS_IO_EVENT_INFO.NameValue(1,"PRSNT_NO");
       var strEventType     = DS_IO_EVENT_INFO.NameValue(1,"EVENT_TYPE");
       var parameters = "&strStrCd="    + encodeURIComponent(strStrCd)
                      + "&strEventCd="  + encodeURIComponent(strEventCd)
                      + "&strPrsntDt="  + encodeURIComponent(strPrsntDt)
                      + "&strPrsntNo="  + encodeURIComponent(strPrsntNo)
                      + "&strEventType="+ encodeURIComponent(strEventType)
                      + "&strCardComp=" + encodeURIComponent(LC_CARD_COMP.BindColVal);
       
       TR_MAIN.Action="/mss/mcae402.mc?goTo=getPrsntInfo"+parameters;  
       if(strEventType == "02"){
    	   TR_MAIN.KeyValue="SERVLET(O:DS_IO_PRSNT_CARD=DS_IO_PRSNT_CARD,O:DS_IO_PRSNTRECP=DS_IO_PRSNTRECP)"; //조회는 O
       }else{
    	   TR_MAIN.KeyValue="SERVLET(O:DS_IO_PRSNT=DS_IO_PRSNT,O:DS_IO_PRSNTRECP=DS_IO_PRSNTRECP)"; //조회는 O  
       }
       
       TR_MAIN.Post();
       if(DS_IO_PRSNT.CountRow == 0 && DS_IO_PRSNT_CARD.CountRow == 0){
           showMessage(EXCLAMATION , OK, "USER-1000", "영수증 번호를 확인하세요.");
           btn_New();
       }else{
    	   DS_IO_EVENT_INFO.UserStatus(1) =1;
           DS_IO_PRSNTRECP.UserStatus(1) =1;
           
           if(strEventType == "02"){
        	   var strDataSet = "DS_IO_PRSNT_CARD";
           }else{
        	   var strDataSet = "DS_IO_PRSNT";
        	   //EM_RECEIPT_NO.Text = ""; 20141112_강연식 영수증 중복 행사건
           }
           eval(strDataSet).UserStatus(1) = 1;
           
           GD_PRSNT.Focus();
       }
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
 <script language=JavaScript for=DS_IO_PRSNTRECP event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<script language=JavaScript for=DS_IO_PRSNT_CARD event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<script language=JavaScript for=DS_IO_PRSNT event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_PRSNTRECP event=OnClick(row,colid)>
   if(row == 0) sortColId( eval(this.DataID), row, colid);
</script>   
<script language=JavaScript for=GD_PRSNT_CARD event=OnClick(row,colid)>
   if(row == 0) sortColId( eval(this.DataID), row, colid);
</script> 
<script language=JavaScript for=GD_PRSNT event=OnClick(row,colid)>
   if(row == 0) sortColId( eval(this.DataID), row, colid);
</script> 
<script language=JavaScript for=EM_RECEIPT_NO event=OnKillFocus()>
	if(this.Text.length == 24){
	//	getEventInfo();
	}
</script>
<script language=JavaScript for=EM_RECEIPT_NO event=OnKeyUp(kcode,scode)>
	if(this.Text.length == 24){
	    getEventInfo();
	}
</script>

<script language=JavaScript for=LS_S_STR event=OnSelChange()>
	if(DS_IO_PRSNT.CountRow != 0){
		 if(showMessage(QUESTION , YESNO, "USER-1000", "등록된 영수증 정보가 있습니다. 점을 변경하시면 초기화 됩니다."
				                                       +" <br><br> 초기화 하시겠습니까?") != 1 ){
             return;
         }else{
        	 DS_IO_EVENT_INFO.ClearData();
        	 DS_IO_PRSNT.ClearData();
        	 DS_IO_PRSNTRECP.ClearData();
        	 EM_RECEIPT_NO.Text = "";
         }
	}
</script>
<script language=JavaScript for=LC_CARD_COMP event=OnSelChange()>
    if(EM_RECEIPT_NO.Text.length == 24){
    	getPrsntInfo();
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
<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_O_CARD_COMP classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_EVENT_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_PRSNT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_PRSNT_CARD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_PRSNTRECP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

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
						<th width="80" class="point">점</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LS_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
							tabindex=1 width=140 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">등록일자</th>
						<td width="140"><comment id="_NSID_"> <object
							id=EM_REG_DT classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">등록자</th>
						<td><comment id="_NSID_"> <object id=EM_REG_NM
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="83" class="point">영수증번호</th>
						<td><comment id="_NSID_"> <object id=EM_RECEIPT_NO
							classid=<%=Util.CLSID_EMEDIT%> width=260 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="5"></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="83">지급점</th>
						<td width="140"><comment id="_NSID_"> <object
							id=EM_STR_NM classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">지급일자</th>
						<td width="140"><comment id="_NSID_"> <object
							id=EM_PRSNT_DT classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">지급유형</th>
						<td><comment id="_NSID_"> <object
							id=EM_PRSNT_FLAG_NM classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
					</tr>
					<tr>
						<th>행사명</th>
						<td><comment id="_NSID_"> <object id=EM_EVENT_NM
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="100">행사기간</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_EVENT_S_DT classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						~ <comment id="_NSID_"> <object id=EM_EVENT_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>총인정금액</th>
						<td width="140"><comment id="_NSID_"> <object
							id=EM_TOT_SALE_AMT classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th>사은행사유형</th>
                        <td width="140"><comment id="_NSID_"> <object
                            id=EM_EVENT_TYPE_NM classid=<%=Util.CLSID_EMEDIT%> width=140
                            tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        </td>
                        <th>카드사</th>
                        <td><comment id="_NSID_"> <object
                            id=LC_CARD_COMP classid=<%=Util.CLSID_LUXECOMBO%> width=140
                            tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
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
			<tr valign="top">
				<td width="65%" class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PT10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
									align="absmiddle" class="PR03" />영수증정보</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<div id=DIV_PRSNT >
                        <table width="100%" border="0" cellspacing="0" cellpadding="0"
                            class="BD4A">
                            <tr>
                                <td><comment id="_NSID_"><object id=GD_PRSNT
                                    width=100% height=365 classid=<%=Util.CLSID_GRID%>>
                                    <param name="DataID" value="DS_IO_PRSNT">
                                </object></comment><script>_ws_(_NSID_);</script></td>
                            </tr>
                        </table>
                        </div>
                        <div id=DIV_PRSNT_CARD style="Display='none'">
                       <table width="100%" border="0" cellspacing="0" cellpadding="0"
                            class="BD4A">
                            <tr>
                                <td><comment id="_NSID_"><object id=GD_PRSNT_CARD
                                    width=100% height=365 classid=<%=Util.CLSID_GRID%>>
                                    <param name="DataID" value="DS_IO_PRSNT_CARD">
                                </object></comment><script>_ws_(_NSID_);</script></td>
                            </tr>
                        </table>
                        </div>
						</td>
					</tr>
				</table>
				</td>
				<td width="35%" class="PL05">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="PT10">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12"
									align="absmiddle" class="PR03" />지급내역</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="BD4A">
							<tr>
								<td><comment id="_NSID_"><object id=GD_PRSNTRECP
									width=100% height=365 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_IO_PRSNTRECP">
								</object></comment><script>_ws_(_NSID_);</script></td>
							</tr>
						</table>
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
<comment id="_NSID_">
<object id=BD_EVENT_INFO classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_EVENT_INFO>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>Col=STR_NM          Ctrl=EM_STR_NM           param=Text</c>
        <c>Col=PRSNT_DT        Ctrl=EM_PRSNT_DT         param=Text</c>
        <c>Col=PRSNT_FLAG_NM   Ctrl=EM_PRSNT_FLAG_NM    param=Text</c>
        <c>Col=EVENT_NAME      Ctrl=EM_EVENT_NM         param=Text</c>
        <c>Col=EVENT_S_DT      Ctrl=EM_EVENT_S_DT       param=Text</c>
        <c>Col=EVENT_E_DT      Ctrl=EM_EVENT_E_DT       param=Text</c>
        <c>Col=TOT_SALE_AMT    Ctrl=EM_TOT_SALE_AMT     param=Text</c>
        <c>Col=EVENT_TYPE_NM    Ctrl=EM_EVENT_TYPE_NM   param=Text</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

