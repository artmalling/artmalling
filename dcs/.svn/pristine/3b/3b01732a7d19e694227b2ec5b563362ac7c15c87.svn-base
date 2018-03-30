<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 가맹점관리 > 실적조회 > 가맹점 입금관리
 * 작  성  일  : 2010.01.14
 * 작  성  자  : 김영진
 * 수  정  자  : 
 * 파  일  명  : dbri2030.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *           2010.01.14 (김영진) 신규작성
 *           2010.02.17 (김영진) 기능추가
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
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
%>
<script LANGUAGE="JavaScript">
<!--
//엑셀조회용
var strBrchId   = "";
var strBrchNm   = "";
var strMonth    = "";
var strCompNo   = "";
var strFlagText = "";
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-17
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_MONTH_S,     "YYYYMM",       PK);           //적립년월
    initEmEdit(EM_BRCH_ID_S,   "GEN^10",       NORMAL);       //가맹점ID
    initEmEdit(EM_BRCH_NAME_S, "GEN^40",       READ);         //가맹점명
    initEmEdit(EM_COMP_NO_S,   "#00-00-00000", NORMAL);       //사업자번호
    initComboStyle(LC_FLAG_S, DS_FLAG, "CODE^0^30,NAME^0^64", 1, NORMAL);    //조회구분
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_FLAG", "D", "D036", "Y");
    
    //초기값설정
    setComboData(LC_FLAG_S, "%");
    //조회년월 초기값.
    EM_MONTH_S.text = addDate("M", "0", '<%=strToMonth%>');

    //화면오픈시 조회
    showMaster();
    
    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dbri203","DS_IO_MASTER");
}


function gridCreate1(){
    var hdrProperies = '<FC>id={currow}      name="NO"            width=30      align=center</FC>'
                     + '<FC>id=CHK_BOX       name=""              width=20      align=center  HeadCheckShow=true Edit={IF(FLAG="1","true","false")}  EditStyle=CheckBox  </FC>'
                     + '<FC>id=BRCH_ID       name="가맹점ID"      width=90      align=center  edit=none show=false</FC>'
                     + '<FC>id=BRCH_NAME     name="가맹점명"      width=94      align=left    edit=none</FC>'
                     + '<FC>id=COMP_NO       name="사업자번호"    width=90      align=center  edit=none mask="XXX-XX-XXXXX"</FC>'
                     + '<FC>id=REP_BRAND_NM  name="대표브랜드"    width=90      align=left    edit=none </FC>'
                     + '<FC>id=S_DT          name="적립시작일자"  width=82      align=center  edit=none mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=E_DT          name="적립종료일자"  width=82      align=center  edit=none mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=ADD_POINT     name="적립포인트"    width=73      align=right   edit=none</FC>'
                     + '<FC>id=PAY_DT        name="입금예정일"    width=82      align=center  edit=none mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=FLAG          name="입금여부"      width=56      align=center  edit=none value={IF(FLAG="1","미입금","입금")}</FC>'
                     + '<FC>id=REAL_DT       name="*실입금일자"   width=83      align=center  Edit={IF(FLAG="1","true","false")} EditStyle=Popup  mask="XXXX/XX/XX" Pointer=Hand</FC>';
                    
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 저장       - btn_Save()
     (3) 엑셀       - btn_Excel()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-17
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	
	if (DS_IO_MASTER.IsUpdated){
	    if(showMessage(EXCLAMATION, YESNO, "USER-1073") != 1 ){
	        setTimeout("GR_MASTER.Focus();",50);
	        return false;
	    }
	}
    if(trim(EM_MONTH_S.Text).length == 0){   // 적립년월
        showMessage(EXCLAMATION, OK, "USER-1001","적립년월");
        EM_MONTH_S.Focus();
        return;
    }
    showMaster();
}

/**
 * btn_Save()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-17
 * 개       요     : DB에 저장
 * return값 : void
 */
function btn_Save() {
     
    var intRowStatus = 1;
    var intUpCnt     = 0;
    var intFlagCnt   = 0;
    //DS Row 상태 초기화
    DS_IO_MASTER.ResetStatus();
    
    // 조회 내역이 없을 경우
    if(DS_IO_MASTER.CountRow == 0){
         showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다
         return;
    }else{
    	//조회 내용이 전체 입금일 경우 저장할 내용 없음 메세지 처리
    	for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            if(DS_IO_MASTER.NameValue(i, "CHK_BOX") != 'T'){
                var strRealFlag = DS_IO_MASTER.NameValue(i, "FLAG");   
                if(strRealFlag == 2){
                    intFlagCnt++; 
                }

            }
        }
    	if(intFlagCnt == DS_IO_MASTER.CountRow){
    		showMessage(EXCLAMATION, OK, "USER-1028"); //저장할 내용이 없습니다
            return;
    	}
    	
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            if(DS_IO_MASTER.NameValue(i, "CHK_BOX") == 'T'){
            	
                var strRealDt = DS_IO_MASTER.NameValue(i, "REAL_DT");
                if ( trim(strRealDt).length == 0) {
                    showMessage(EXCLAMATION, OK, "USER-1003", "실입금일자");
                    GR_MASTER.SetColumn("REAL_DT");  
                    DS_IO_MASTER.RowPosition = i;
                    return;
                }               
                intUpCnt++; 
                DS_IO_MASTER.UserStatus(i) = intRowStatus;
            }else{
                DS_IO_MASTER.UserStatus(i) = 0;
            }
        }
    }

    // 저장할 데이터 없는 경우
    if (intUpCnt == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "저장할 자료를 선택하세요."); //저장할 자료를 선택하세요.
        return;
    }
    
    //저장여부 QUESTION
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    saveData();
    showMaster();
}

/**
 * btn_Excel()
 * 작   성   자 : 김영진
 * 작   성   일 : 2010-03-04
 * 개           요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	
	if (strBrchId == "")   strBrchId   = "전체";
	if (strBrchNm == "")   strBrchNm   = "전체";
    if (strCompNo == "")   strCompNo   = "전체";
    if (strFlagText == "") strFlagText = "전체";

	var parameters = "적립년월="     + strMonth
	               + " -가맹점코드=" + strBrchId
                   + " -가맹점명="   + strBrchNm
                   + " -사업자번호=" + strCompNo
                   + " -조회구분="   + strFlagText;
	
    var ExcelTitle = "가맹점 입금관리"
        
    openExcel2(GR_MASTER, ExcelTitle, parameters, true );
    
    GR_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-17
 * 개       요     : 가맹점 입금 관리 현황 조회 
 * return값 : void
 */
function showMaster(){

    strBrchId   = EM_BRCH_ID_S.Text;
    strBrchNm   = EM_BRCH_NAME_S.Text;
    strMonth    = EM_MONTH_S.Text;
    strCompNo   = EM_COMP_NO_S.Text;
    strFlag     = LC_FLAG_S.BindColVal;
    strFlagText = LC_FLAG_S.Text;
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strBrchId="   + encodeURIComponent(strBrchId)
                    + "&strMonth="    + encodeURIComponent(strMonth)
                    + "&strCompNo="   + encodeURIComponent(strCompNo)
                    + "&strFlag="     + encodeURIComponent(strFlag);
    TR_MAIN.Action  ="/dcs/dbri203.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O, 저장은 I
    TR_MAIN.Post();
    
    //그리드 CHEKCBOX헤더 체크해제
    GR_MASTER.ColumnProp('CHK_BOX','HeadCheck')= "false";
    
    if(DS_IO_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_MONTH_S.Focus();
    }
    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
}

/**
 * saveData()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-15
 * 개       요     : 가맹점코드 저장
 * return값 : void
 */
function saveData(){
   var goTo        = "save";
   var action      = "I";  //조회는 O, 저장은 I
   TR_MAIN.Action  ="/dcs/dbri203.db?goTo="+goTo;   
   TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; 
   TR_MAIN.Post();

   showMaster();
}

/**
 * keyPressEvent()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010.02.24
 * 개      요  : Enter, Tab키 이벤트
 * return값 :
 */
function keyPressEvent(kcode) {
    EM_BRCH_NAME_S.Text = "";//조건입력시 코드초기화
    if (EM_BRCH_ID_S.Text.length > 0 ) {
        if (kcode == 13 || kcode == 9 || EM_BRCH_ID_S.Text.length == 10) { //TAB,ENTER 키 실행시에만 
            setNmToDataSet("DS_O_RESULT", "SEL_BRANCH", EM_BRCH_ID_S.Text);
            if (DS_O_RESULT.CountRow == 1 ) {
                EM_BRCH_ID_S.Text   = DS_O_RESULT.NameValue(1, "CODE_CD");
                EM_BRCH_NAME_S.Text = DS_O_RESULT.NameValue(1, "CODE_NM");
            } else {
                //1건 이외의 내역이 조회 시 팝업 호출
                getBrchPop(EM_BRCH_ID_S,EM_BRCH_NAME_S);
            }
        }
    }
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
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
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
   /* if ( DS_IO_MASTER.IsUpdated ){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            setTimeout("GR_MASTER.Focus();",50);
            return false;
        }
        return true;
    }else{
         return true;
    }*/
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 가맹점명 onKillFocus() -->
<script language=JavaScript for=EM_BRCH_ID_S event=onKillFocus()>
    if ((EM_BRCH_ID_S.Modified) && (EM_BRCH_ID_S.Text.length != 10)) {
    	EM_BRCH_NAME_S.Text = "";
    }
</script>
<!-- 그리드 실입금일자 클릭시 달력 OPEN -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
    openCal(this,row,colid);
</script>
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript" for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            if(DS_IO_MASTER.NameValue(i, "FLAG") != "2"){
                DS_IO_MASTER.NameValue(i, "CHK_BOX") = 'T';
            }
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++){
        	if(DS_IO_MASTER.NameValue(i, "FLAG") != "2"){
                DS_IO_MASTER.NameValue(i, "CHK_BOX") = 'F';
        	}
        }
    }
</script>
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    if(colid == "CHK_BOX")return;
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- 적립년월 onKillFocus() -->
<script language=JavaScript for=EM_MONTH_S event=onKillFocus()>
    if(!checkDateTypeYM(EM_MONTH_S)){
        EM_MONTH_S.text = addDate("M", "0", '<%=strToMonth%>');
    };
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                  *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
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
<!-- =============== 공통콤보용 -->
<comment id="_NSID_">
<object id="DS_FLAG" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
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
						<th width="80" class="point">적립년월</th>
						<td width="160"><comment id="_NSID_"> <object
							id=EM_MONTH_S classid=<%=Util.CLSID_EMEDIT%>
							width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('M',EM_MONTH_S)" /></td>
						<th width="80">가맹점명</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_BRCH_ID_S classid=<%=Util.CLSID_EMEDIT%> width=71
							onKeyUp="javascript:keyPressEvent(event.keyCode);" tabindex=1>
						</object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle"
							onclick="getBrchPop(EM_BRCH_ID_S,EM_BRCH_NAME_S)" /> <comment
							id="_NSID_"> <object id=EM_BRCH_NAME_S
							classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">사업자번호</th>
						<td><comment id="_NSID_"> <object id=EM_COMP_NO_S
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>
					</tr>
					<tr>
					  <th width="80">조회구분</th>
                        <td colspan="5"><comment id="_NSID_"> <object id=LC_FLAG_S
                            classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=94 tabindex=1>
                        </object> </comment> <script> _ws_(_NSID_);</script></td>
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"> <object id=GR_MASTER
					width="100%" height=478 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_IO_MASTER">
				</object> </comment> <script> _ws_(_NSID_);</script></td>
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
