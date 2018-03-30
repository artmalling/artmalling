<!--
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 공통코드관리
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 :
 * 파 일 명 : tcom1010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공통코드 관리
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                    *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                  *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var bfMasterRowPosition = 1;
 var newMasterYn = false;

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
	DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
	DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');

	//그리드 초기화
	gridCreate1(); //마스터
	gridCreate2(); //디테일

	// EMedit에 초기화
	initEmEdit(EM_SEARCH, "GEN^30", NORMAL);    //상세코드/명
	EM_SEARCH.UpperFlag=1;                      //입력가능 문자 = 대문자

	//콤보 초기화
	initComboStyle(LC_SYSPART, DS_O_SYSPART, "CODE^0^30,NAME^0^80", 1, PK);  //공통코드사용구분

	//시스템 코드 공통코드에서 가지고 오기( popup.js )
	getEtcCode("DS_O_SYSPART",   "D", "TC00", "N");     //조회조건
	getEtcCode("DS_I_SYSPART",   "D", "TC00", "N");     //그리드

	//콤보 초기값 설정 :
	setComboData(LC_SYSPART, "D");

	//사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
	registerUsingDataset("tcom101","DS_O_MASTER,DS_IO_DETAIL" );

	//마스터 리스트 조회
	btn_Search();
}

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}     width=30    align=center    name="NO"         </FC>'
					 + '<FC>id=SYS_PART     width=95    align=center    name="*공통코드구분" EditStyle=Lookup   Data="DS_I_SYSPART:CODE:NAME"</FC>'
					 + '<FC>id=COMM_CODE    width=45    align=center    name="*코드"       edit="AlphaNum"   </FC>'
					 + '<FC>id=COMM_NAME1   width=98    align=left      name="*코드명"     </FC>' ;

	initGridStyle(GD_MASTER, "common", hdrProperies, true);
}

function gridCreate2(){
	var hdrProperies = '<FC>id={currow}     width=30    align=center        name="NO"          </FC>'
					 + '<FC>id=SYS_PART     show=false                      name="공통코드구분"   </FC>'
					 + '<FC>id=COMM_PART    show=false                      name="구분코드"     </FC>'
					 + '<FC>id=COMM_CODE    width=65    align=center        name="*상세코드"     edit="AlphaNum" </FC>'
					 + '<FC>id=COMM_NAME1   width=110                       name="*코드명1"      </FC>'
					 + '<FC>id=COMM_NAME2   width=110                       name="코드명2"      </FC>'
					 + '<FC>id=USE_YN       width=50    editstyle=checkbox  name="사용"         </FC>'
					 + '<FC>id=REFER_CODE   width=80                        name="참조코드"     </FC>'
					 + '<FC>id=REFER_VALUE  width=80                        name="참조수치"     </FC>'
					 + '<FC>id=RESERVED1    width=80                        name="참조값1"     </FC>'
					 + '<FC>id=RESERVED2    width=80                        name="참조값2"     </FC>'
					 + '<FC>id=RESERVED3    width=80                        name="참조값3"     </FC>'
					 + '<FC>id=RESERVED4    width=80                        name="참조값4"     </FC>'
					 + '<FC>id=RESERVED5    width=80                        name="참조값5"     </FC>'
					 + '<FC>id=INQR_ORDER   width=50    align=center        name="순서"         </FC>';

	initGridStyle(GD_DETAIL, "common", hdrProperies, true);

	//그리드 엔터시 로우 추가
	GD_DETAIL.autorow	= "true";
	GD_DETAIL.autoevent	= "btn_Add1()";
}

/*************************************************************************
  * 2. 공통버튼
	 (1) 조회	- btn_Search(), subQuery()
	 (2) 신규	- btn_New()
	 (3) 삭제	- btn_Delete()
	 (4) 저장	- btn_Save()
	 (5) 엑셀	- btn_Excel()
	 (6) 출력	- btn_Print()
	 (7) 확정	- btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

	showMaster();
	showDetail();
	setPorcCount("SELECT", DS_O_MASTER.CountRow);
 }

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	//기존의 신규로우 존재 시 초기화
	if( newMasterYn )
	{
		if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
			GD_MASTER.Focus();
			return;
		}
		DS_IO_DETAIL.ClearData();
		DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "SYS_PART")   = "D";
		DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "COMM_CODE")  = "";
		DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "COMM_NAME1") = "";
		bfMasterRowPosition = DS_O_MASTER.CountRow;
		setFocusGrid(GD_MASTER,DS_O_MASTER,DS_O_MASTER.CountRow,"SYS_PART");
		return;
	}

	if( DS_IO_DETAIL.IsUpdated ){
		if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
			GD_DETAIL.Focus();
			return;
		}
	}

	DS_IO_DETAIL.ClearData();
	DS_O_MASTER.Addrow();
	DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "SYS_PART")   = "D";
	DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "COMM_CODE")  = "";
	DS_O_MASTER.NameValue(DS_O_MASTER.CountRow, "COMM_NAME1") = "";
	bfMasterRowPosition = DS_O_MASTER.CountRow;
	newMasterYn = true;
	setFocusGrid(GD_MASTER, DS_O_MASTER, DS_O_MASTER.CountRow, "SYS_PART");

}


/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

	// 삭제할 데이터 없는 경우
	if ( DS_O_MASTER.CountRow < 1){
		//삭제할 내용이 없습니다
		showMessage(INFORMATION, OK, "USER-1019");
		LC_SYSPART.Focus();
		return;
	}

	// 상세에 변경내역있을  경우
	if( DS_IO_DETAIL.IsUpdated){
		showMessage(INFORMATION , OK, "USER-1091");
		GD_DETAIL.Focus();
		return;
	}

	//선택한 항목을 삭제하겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
		GD_MASTER.Focus();
		return;
	}

	DS_IO_DETAIL.ClearData();
	DS_O_MASTER.DeleteMarked();

	TR_MAIN.Action  ="/pot/tcom101.tc?goTo=save";
	TR_MAIN.KeyValue="SERVLET(I:DS_O_MASTER=DS_O_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
	TR_MAIN.Post();

	// 삭제 후 처리
	btn_Search();
	GD_MASTER.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

	// 저장할 데이터 없는 경우
	if (!DS_IO_DETAIL.IsUpdated && !DS_O_MASTER.IsUpdated ){
		//저장할 내용이 없습니다
		showMessage(INFORMATION, OK, "USER-1028");
		if(DS_O_MASTER.CountRow < 1){
			LC_SYSPART.Focus();
		}else{
			GD_MASTER.Focus();
		}
		return;
	}

	if(!checkValidation()) return;

	//변경또는 신규 내용을 저장하시겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
		GD_MASTER.Focus();
		return;
	}

	var msgId = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"COMM_CODE");

	TR_MAIN.Action  ="/pot/tcom101.tc?goTo=save";
	TR_MAIN.KeyValue="SERVLET(I:DS_O_MASTER=DS_O_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
	TR_MAIN.Post();

	// 저장 후 처리
	if(TR_MAIN.ErrorCode == 0){
		showMaster();

		if(msgId != ""){
			DS_O_MASTER.RowPosition = DS_O_MASTER.NameValueRow("COMM_CODE",msgId);
		}else{
			DS_O_MASTER.RowPosition = DS_O_MASTER.CountRow;
		}

		setFocusGrid(GD_MASTER,DS_O_MASTER,DS_O_MASTER.RowPosition,"SYS_PART");

		showDetail();
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
/*
	var strTmpCd = EM_SEARCH.text;
	var strSysCd = LC_SYSPART.BindColVal;
	var params   = "&strTmpCd="+strTmpCd + "&strSysCd="+strSysCd;

	window.open("/pot/tcom101.tc?goTo=print"+params,"OZREPORT", 1000, 700);
*/

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
 * showMaster()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
function showMaster(){
	var strTmpCd = EM_SEARCH.text;
	var strSysCd = LC_SYSPART.BindColVal;

	var goTo		= "searchMaster" ;
	var action		= "O";
	var parameters	= "&strTmpCd="+encodeURIComponent(strTmpCd) + "&strSysCd="+encodeURIComponent(strSysCd);

	TR_MAIN.Action="/pot/tcom101.tc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	TR_MAIN.Post();

	newMasterYn = false;

	//조회후 결과표시
	setPorcCount("SELECT", DS_O_MASTER.CountRow);
}

/**
 * showDetail()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 :  디테일 리스트 조회
 * return값 : void
 */
function showDetail(){

	var strCommPart = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"COMM_CODE");
	var strSysCd = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SYS_PART");

	var goTo		= "searchDetail" ;
	var action		= "O";
	var parameters	= "&strCommPart="+encodeURIComponent(strCommPart) + "&strSysCd="+encodeURIComponent(strSysCd);

	TR_DETAIL.Action="/pot/tcom101.tc?goTo="+goTo+parameters;
	TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
	TR_DETAIL.Post();

	// 조회결과 Return
	setPorcCount("SELECT", DS_IO_DETAIL.CountRow);

}

 /**
  * btn_Add1()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010-09-08
  * 개    요 : 광역 그리드 Row추가
  * return값 : void
*/
function btn_Add1(){
	DS_IO_DETAIL.Addrow();

	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "SYS_PART") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SYS_PART");		//시스템코드
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "COMM_PART") = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"COMM_CODE");	//구분코드
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "INQR_ORDER") = "0";  	//순서
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.CountRow, "USE_YN") = "T";  		//사용여부

	// 상세코드  포커스
	setFocusGrid(GD_DETAIL,DS_IO_DETAIL, DS_IO_DETAIL.CountRow,  "COMM_CODE");
}

/**
 * btn_Del1()
 * 작 성 자 : 엄준석
 * 작 성 일 : 2010-09-08
 * 개    요 : 광역 그리드 Row 삭제
 * return값 : void
 */
function btn_Del1(){
	DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * checkValidation()
 * 작 성 자 :
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkValidation(){

	var row;
	var colid;
	var errYn = false;
	var dupRow;
	var objDS, objGD;

	//Master
	dupRow = checkDupKey(DS_O_MASTER,"COMM_CODE");  //구분코드 체크

	if( dupRow > 0){
		showMessage(EXCLAMATION, OK, "USER-1044");
		setFocusGrid(GD_MASTER,DS_O_MASTER,dupRow,"COMM_CODE");
		return false;
	}

	for(var i=1; i<=DS_O_MASTER.CountRow; i++){

		objDS = DS_O_MASTER;
		objGD = GD_MASTER;

		var rowStatus = DS_O_MASTER.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;

		row = i;

		if(DS_O_MASTER.NameValue(i,"SYS_PART")==""){
			showMessage(EXCLAMATION, OK, "USER-1003", "시스템코드");
			errYn = true;
			colid = "SYS_PART";
			break;
		}

		if(DS_O_MASTER.NameValue(i,"COMM_CODE")==""){
			showMessage(EXCLAMATION, OK, "USER-1003", "구분코드");
			errYn = true;
			colid = "COMM_CODE";
			break;
		}

		if((DS_O_MASTER.NameValue(i,"COMM_CODE")).length != 4){
			showMessage(EXCLAMATION, OK, "USER-1027", "구분코드", "4");
			errYn = true;
			colid = "COMM_CODE";
			break;
		}

		if(DS_O_MASTER.NameValue(i,"COMM_NAME1")==""){
			showMessage(EXCLAMATION, OK, "USER-1003", "코드명");
			errYn = true;
			colid = "COMM_NAME1";
			break;
		}

		if(!checkInputByte( objGD, objDS, i, "COMM_NAME1", "코드명1", null,30)){
			errYn = true;
			colid = "COMM_NAME1";
			break;
		}
	}

	//Detail
	dupRow = checkDupKey(DS_IO_DETAIL,"COMM_CODE");
	if(dupRow > 0){
		showMessage(EXCLAMATION, OK, "USER-1044");
		setFocusGrid(GD_DETAIL,DS_IO_DETAIL,dupRow,"COMM_CODE");
		return false;
	}

	for(var i=1;i<=DS_IO_DETAIL.CountRow; i++){

		objDS = DS_IO_DETAIL;
		objGD = GD_DETAIL;

		var rowStatus = DS_IO_DETAIL.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;

		row = i;

		if( DS_IO_DETAIL.NameValue(i,"COMM_CODE")=="" ){
			showMessage(EXCLAMATION, OK, "USER-1003", "상세코드");
			errYn = true;
			colid = "COMM_CODE";
			break;
		}

		if( DS_IO_DETAIL.NameValue(i,"COMM_NAME1")=="" ){
			showMessage(EXCLAMATION, OK, "USER-1003", "코드명1");
			errYn = true;
			colid = "COMM_NAME1";
			break;
		}

		if( !checkInputByte( objGD, objDS, i, "COMM_NAME1", "코드명1", null,30)){
			errYn = true;
			colid = "COMM_NAME1";
			break;
		}

		if( !checkInputByte( objGD, objDS, i, "COMM_NAME2", "코드명2", null,60) ){
			errYn = true;
			colid = "COMM_NAME2";
			break;
		}

		if( !checkInputByte( objGD, objDS, i, "REFER_CODE", "참조코드", null,20) ){
			errYn = true;
			colid = "REFER_CODE";
			break;
		}

		if ( DS_IO_DETAIL.NameValue(i,"INQR_ORDER") < 0 ){
			showMessage(EXCLAMATION, OK, "USER-1000", "순서는 0 이상 입력하세요.");
			errYn = true;
			colid = "INQR_ORDER";
			break;
		}

		// MST코드가 변경됐을경우 DTL도 변경(신규등록일경우)
		var mstVal1 = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"COMM_CODE");  //구분코드
		if ( mstVal1 != DS_IO_DETAIL.NameValue(i,"COMM_PART"))
		{
			DS_IO_DETAIL.NameValue(i,"COMM_PART") = mstVal1;
		}

		var mstVal2 = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition ,"SYS_PART")    //시스템코드
		if ( mstVal2 != DS_IO_DETAIL.NameValue(i,"SYS_PART"))
		{
			DS_IO_DETAIL.NameValue(i,"SYS_PART") = mstVal2;
		}
	}

	if(errYn){
		setFocusGrid(objGD, objDS, row, colid);
		return false;
	}


	return true;

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
<script language=JavaScript for=TR_DETAIL event=onSuccess>
	for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
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
<script language=JavaScript for=DS_O_MASTER event=OnLoadCompleted(rowcnt)>
	if(rowcnt > 0) {
		DS_O_MASTER.RowPosition = bfMasterRowPosition;
	}
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- 중복 체크-->
<script language=JavaScript for=DS_O_MASTER  event=OnDataError(row,colid)>
	var errorCode = DS_O_MASTER.ErrorCode;

	if(errorCode == "50019")
		showMessage(EXCLAMATION, OK, "USER-1044");

</script>
<script language=JavaScript for=DS_IO_DETAIL event=OnDataError(row,colid)>
	var errorCode = DS_IO_DETAIL.ErrorCode;

	if(errorCode == "50019"){
		showMessage(EXCLAMATION, OK, "USER-1044");
	}else if( errorCode == "50018"){
		showMessage(EXCLAMATION, OK, "USER-1003", "상세코드");
	}else{
		showMessage(EXCLAMATION, OK, "USER-1000",DS_IO_DETAIL.ErrorMsg);
	}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
	if( row < 1) {
		sortColId( eval(this.DataID), row , colid );
	} else {
		if( bfMasterRowPosition == row)
			return;

		if( DS_IO_DETAIL.IsUpdated || DS_O_MASTER.IsUpdated ) {
			if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
				DS_O_MASTER.RowPosition = bfMasterRowPosition;
				return;
			}
		}

		DS_O_MASTER.UndoAll();

		bfMasterRowPosition = row;
		newMasterYn = false;
		showDetail();
	}
</script>

<!-- Grid master 상하키 event 처리 -->
<script language=JavaScript for=GD_MASTER event=onKeyPress(keycode)>
	if ((keycode == 38) || (keycode == 40) || (keycode == 255 && GD_MASTER.GetColumn() =="COMM_NAME1" && DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "COMM_NAME1") != "" ))
	{
		if (DS_O_MASTER.RowPosition > 0){
			//alert(DS_O_MASTER.RowPosition);
			bfMasterRowPosition = DS_O_MASTER.RowPosition;
			newMasterYn = false;
			showDetail();
		}
	}
</script>

<!-- Grid Master oneClick event 처리 -- >
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	if(row < 1) return;

	if( bfMasterRowPosition == row)
		return;
	if( DS_IO_DETAIL.IsUpdated || DS_O_MASTER.IsUpdated ) {
		if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
			DS_O_MASTER.RowPosition = bfMasterRowPosition;
			return;
		}
	}
	DS_O_MASTER.UndoAll();

	bfMasterRowPosition = row;
	showDetail();
</script -->

<!-- Grid 정렬처리 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
	if( row < 1)
		sortColId( eval(this.DataID), row , colid );
</script>

<!-- 서브시스템 LUXCOMBO 상태 변경시   -->
<script language=JavaScript for=LC_SYSPART event=onSelChange()>
	btn_Search();
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                      *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction                                                     *-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id=DS_MAIL_TEST classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_MASTER  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_IO_DETAIL classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SYSPART"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SYSPART"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN"   classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                     *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                         *-->
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
						<td>
							<!-- search start -->
							<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table ">
								<tr>
									<th width="100" class="point">공통코드구분</th>
									<TD width="140">
										<comment id="_NSID_">
											<object id=LC_SYSPART classid=<%= Util.CLSID_LUXECOMBO%> height=100 width=130 align="absmiddle" tabindex=1></object>
										</comment>
										<script>_ws_(_NSID_);</script>
									</TD>
									<th width="100">코드/명</th>
									<TD>
										<comment id="_NSID_">
											<object id=EM_SEARCH classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=2></object>
										</comment>
										<script> _ws_(_NSID_);</script>
									</TD>
								</tr>
							</table>
							<!-- search end -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="dot"></td>
		</tr>
		<tr>
			<td class="PB01 PT01" align="right"><img src="/<%=dir%>/imgs/btn/add_row.gif"  class="PR03" onclick="javascript:btn_Add1();" />
				<img src="/<%=dir%>/imgs/btn/del_row.gif"  class="PR03"  onclick="javascript:btn_Del1();" />
			</td>
		</tr>
		<tr>
			<td class="PB03 PL03" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
					<tr>
						<TD width="304">
							<table border="0" width="100%" cellspacing="0" cellpadding="0" class="BD4A" >
								<tr>
									<td>
										<!-- 마스터 -->
										<comment id="_NSID_">
											<OBJECT id=GD_MASTER width="100%" height="482" classid=<%=Util.CLSID_GRID%>>
												<param name="DataID" value="DS_O_MASTER">
											</OBJECT>
										</comment><script>_ws_(_NSID_);</script>
									</td>
								</tr>
							</table>
						</TD>
						<TD class="PL10" valign="top">
							<table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%">
								<tr>
									<TD>
										<!-- 디테일 -->
										<comment id="_NSID_">
											<OBJECT id=GD_DETAIL width=100% height="482" classid=<%=Util.CLSID_GRID%>>
												<param name=DataID   value="DS_IO_DETAIL">
												<param name=Sort     value=True>
											</OBJECT>
										</comment><script>_ws_(_NSID_);</script>
									</TD>
								</tr>
							</table>
						</TD>
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
<object id=BD_HEADER classid=<%= Util.CLSID_BIND %>>
	<param name=DataID          value=DS_I_HEADER>
	<param name="ActiveBind"    value=true>
	<param name=BindInfo        value='<c>col=UPMU_GB          ctrl=LC_SYSPART        param=BindColVal</c>'>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
