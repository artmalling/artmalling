<!--
/**********************************************************************************
  * 시스템명 : 시스템관리 > 관리자메뉴> 메뉴및 프로그램관리
  * 작 성 일 : 2010.12.12
  * 작 성 자 : 정지인
  * 수 정 자 :
  * 파 일 명 : tcom1020.jsp
  * 버    전 : 1.0        → 버전은 1.0부터 시작하며 0.1씩 증가
  * 개    요 :
  * 이    력 :2010.05.24   HOSEON     공통 규약에 맞춰 소스 수정
  ********************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

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
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"  type="text/javascript"></script>

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var bfLCodeRowPosition = 0;
var bfMCodeRowPosition = 0;
var bfSCodeRowPosition = 0;
var bfPCodeRowPosition = 0;

var lastFocusGrid;  // 마지막 선택 되었던 그리드를 저장

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시
 * return값 : void
*/
var top = 400;		//해당화면의 동적그리드top위치
function doInit(){
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_LMENU"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MMENU"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_SMENU"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


	// Output Data Set Header 초기화
	DS_O_TREE_MAIN.setDataHeader('<gauce:dataset name="H_TREE_MAIN"/>');        //트리

	DS_IO_LMENU.setDataHeader('<gauce:dataset name="H_SEL_LMENU"/>');           //대분류
	DS_IO_MMENU.setDataHeader('<gauce:dataset name="H_SEL_MMENU"/>');           //중대분류
	DS_IO_SMENU.setDataHeader('<gauce:dataset name="H_SEL_SMENU"/>');           //소분류
	DS_IO_PROGRAM.setDataHeader('<gauce:dataset name="H_SEL_PROGRAM"/>');       //프로그램

	//사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
	registerUsingDataset("tcom102","DS_IO_LMENU,DS_IO_MMENU,DS_IO_SMENU,DS_IO_PROGRAM" );

	//그리드 초기화
	gridCreate1(); //대분류
	gridCreate2(); //중분류
	gridCreate3(); //소분류
	gridCreate4(); //프로그램 등록

	//콤보 초기화 : 시스템구분
	initComboStyle(LC_SUB_SYSTEM,   DS_O_SUBSYSTEM, "CODE^0^30,NAME^0^80", 1, PK);
	//서브시스템 공통 코드 에서 가져 오기
	getEtcCode("DS_O_SUBSYSTEM",   "D", "TC01", "N");
	//콤보 기본값셋팅 = 백화점
	setComboData(LC_SUB_SYSTEM, "P");

}

function gridCreate1(){
    var hdrProperies = '<FC>ID=LCODE        width=50     align=Center    name="*대분류"   edit="AlphaNum"    </FC>'
				     + '<FC>ID=LNAME        width=90                     name="*대분류명"    </FC>'
				     + '<FC>ID=SUB_SYSTEM   width=50     show=false      name="구분"       </FC>'
				     + '<FC>ID=SEQ          width=30     align=Center    name="순서"        </FC>';

    initGridStyle(GD_LMENU, "common", hdrProperies, true );

    //그리드 엔터시 로우 추가
    GD_LMENU.autorow     = "true";
    GD_LMENU.autoevent   = "btn_add1()";
}

function gridCreate2(){
	var hdrProperies = '<FC>ID=MCODE    width=50     align=Center   name="*중분류"  edit="AlphaNum"     </FC>'
				     + '<FC>ID=MNAME    width=107                   name="*중분류명"    </FC>'
				     + '<FC>ID=LCODE    width=50     show=false     name="대"          </FC>'
				     + '<FC>ID=SEQ      width=30     align=Center   name="순서"        </FC>';

	initGridStyle(GD_MMENU, "common", hdrProperies, true );

	//그리드 엔터시 로우 추가
	GD_MMENU.autorow     = "true";
	GD_MMENU.autoevent   = "btn_add2()";
}

function gridCreate3(){
	var hdrProperies = '<FC>ID=SCODE    width=55                    name="*소분류"  edit="AlphaNum"    </FC>'
				     + '<FC>ID=SNAME    width=123                   name="*소분류명"   </FC>'
				     + '<FC>ID=LCODE    width=50     show=false     name="대"         </FC>'
				     + '<FC>ID=MCODE    width=50     show=false     name="중"         </FC>'
				     + '<FC>ID=SEQ      width=30     align=Center   name="순서"       </FC>';

	initGridStyle(GD_SMENU, "common", hdrProperies, true );

	//그리드 엔터시 로우 추가
	GD_SMENU.autorow     = "true";
	GD_SMENU.autoevent   = "btn_add3()";
}

function gridCreate4(){
	var hdrProperies = '<FC>ID=PID            width=70     align=Center              name="프로그램ID"     edit=None </FC>'
		     		 + '<FC>ID=PNAME1         width=130                              name="*프로그램명"    </FC>'
		     		 + '<FC>ID=SCODE          width=50     show=false                ame="소"             </FC>'
		     		 + '<FC>ID=PID            width=50     show=false                name="PID"          </FC>'
		     		 + '<FC>ID=URL            width=168                              name="URL"          </FC>'
		    		 + '<FC>ID=IS_RET         width=29     EditStyle=CheckBox        name="조회"          </FC>'
		    		 + '<FC>ID=IS_NEW         width=29     EditStyle=CheckBox        name="신규"          </FC>'
		    		 + '<FC>ID=IS_DEL         width=29     EditStyle=CheckBox        name="삭제"          </FC>'
		    		 + '<FC>ID=IS_SAVE        width=29     EditStyle=CheckBox        name="저장"          </FC>'
		    		 + '<FC>ID=IS_EXCEL       width=29     EditStyle=CheckBox        name="엑셀"          </FC>'
		    		 + '<FC>ID=IS_PRINT       width=29     EditStyle=CheckBox        name="출력"          </FC>'
		    		 + '<FC>ID=IS_CONFIRM     width=29     EditStyle=CheckBox        name="확정"          </FC>'
		    		 + '<FC>ID=USE_YN         width=29     EditStyle=CheckBox        name="사용"          </FC>';

	initGridStyle(GD_PROGRAM, "common", hdrProperies, true );
}

/*************************************************************************
 * 2. 공통버튼
     (1) 조회 - btn_Search()
     (2) 신규 - btn_New()
     (3) 삭제 - btn_Delete()
     (4) 저장 - btn_Save()
     (5) 엑셀 - btn_Excel()
     (6) 출력 - btn_Print()
     (7) 행추가    - btn_SubAdd()
     (8) 행삭제    - btn_SubDel()
 *************************************************************************/
/**
 * btn_Search()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-10
 * 개    요 : 조회시 호출 (타겟: 프로그램 그리드 )
 * return값 : void
 */
function btn_Search() {

	// 마지막 선택 되었던 그리드
	var lastFocus = getLastFocusGrid();

	//alert(lastFocus);

	// 변경 데이터가 있다면 UNDO
	DS_IO_LMENU.UndoAll();
	DS_IO_MMENU.UndoAll();
	DS_IO_SMENU.UndoAll();
	DS_IO_PROGRAM.UndoAll();

	if(lastFocus=='L')
	{//대분류 선택시
		showProgram(getValueCurrRowInLmenu("LCODE"), '', '');
	}
	else if(lastFocus=='M')
	{//중분류 선택시
		showProgram(getValueCurrRowInMmenu("LCODE"), getValueCurrRowInMmenu("MCODE"), '');
	}
	else if(lastFocus=='S')
	{//소분류 선택시
		showProgram('', '', getValueCurrRowInSmenu("SCODE"));
	}
	else
	{//그리드선택x 조회인경우 : undefiend
		showLmenu(getSubSystemCode());
		showTreeView();

	}
}

/**
 * btn_Save()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-10
 * 개    요 : DB에 입력 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

	var lastFocus = getLastFocusGrid();

	// 저장할 데이터 없는 경우
	if (!DS_IO_LMENU.IsUpdated && !DS_IO_MMENU.IsUpdated && !DS_IO_SMENU.IsUpdated && !DS_IO_PROGRAM.IsUpdated ){
		//저장할 내용이 없습니다
		showMessage(INFORMATION, OK, "USER-1028");
		if(DS_IO_LMENU.CountRow < 1){
			LC_SUB_SYSTEM.Focus();
		}else{
			GD_LMENU.Focus();
		}
		return;
	}

	if(!checkValidation()) return;

	//변경또는 신규 내용을 저장하시겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
		return;
	}

	// 변경이 일어난 데이터 재로딩 위하여
	var gL = "", gLval ="";
	var gM = "", gMcode=""  , gMval="";
	var gS = "", gScode1="" , gScode2 ="", gSval ="";

	if (DS_IO_LMENU.IsUpdated)
	{
		gL    = "T";
		gLval = getValueCurrRowInLmenu("LCODE");  // 대분류코드
	}

	if (DS_IO_MMENU.IsUpdated)
	{
		gM     = "T";
		gMcode = getValueCurrRowInLmenu("LCODE");  // 대분류코드
		gMval  = getValueCurrRowInMmenu("MCODE");  // 중분류코드
	}

	if (DS_IO_SMENU.IsUpdated)
	{
		gS      = "T";
		gScode1 = getValueCurrRowInMmenu("LCODE");  // 대분류코드
		gScode2 = getValueCurrRowInMmenu("MCODE");  // 중분류코드
		gSval   = getValueCurrRowInSmenu("SCODE");  // 소분류코드
	}

	var goTo       = "saveAll";
	var parameters = "&strSubSystem="+encodeURIComponent(getSubSystemCode()) ;
	var action     = "I";

	TR_MAIN.Action="/pot/tcom102.tc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET(" +action+":DS_IO_LMENU    =DS_IO_LMENU, "
							    +action+":DS_IO_MMENU    =DS_IO_MMENU, "
							    +action+":DS_IO_SMENU    =DS_IO_SMENU, "
							    +action+":DS_IO_PROGRAM  =DS_IO_PROGRAM)";

	TR_MAIN.Post();

	// 저장 후 처리
	if(TR_MAIN.ErrorCode == 0)
	{
		// 변경이 일어난 화면 재로딩
		if(gL=="T")
		{
			showLmenu(getSubSystemCode());
			DS_IO_LMENU.RowPosition = DS_IO_LMENU.NameValueRow("LCODE",gLval);
		}
		if(gM=="T")
		{
			showMmenu(gMcode);
			DS_IO_MMENU.RowPosition = DS_IO_MMENU.NameValueRow("MCODE",gMval);
		}
		if(gS=="T")
		{
			showSmenu(gScode1,gScode2);
			DS_IO_SMENU.RowPosition = DS_IO_SMENU.NameValueRow("SCODE",gSval);
		}

		//트리 다시 보여주기
		showTreeView();
	}
}

/**
 * btn_New()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-10
 * 개    요 : 선택된 Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-10
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

 }
/**
 * btn_Excel()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
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

	//대분류
	dupRow = checkDupKey(DS_IO_LMENU,"LCODE");
	if( dupRow > 0){
		showMessage(EXCLAMATION, OK, "USER-1044");
		setFocusGrid(GD_LMENU, DS_IO_LMENU, dupRow, "LCODE");
		return false;
	}

	for(var i=1; i<=DS_IO_LMENU.CountRow; i++)
	{
		objDS = DS_IO_LMENU;
		objGD = GD_LMENU;

		var rowStatus = objDS.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;
		row = i;
		if( objDS.NameValue(i,"LCODE")==""  ){
			showMessage(EXCLAMATION, OK, "USER-1003", "대분류코드");
			errYn = true;
			colid = "LCODE";
			break;
		}
		if( objDS.NameValue(i,"LNAME")==""){
			showMessage(EXCLAMATION, OK, "USER-1003", "대분류명");
			errYn = true;
			colid = "LNAME";
			break;
		}

		if( (objDS.NameValue(i,"LCODE")).length != 4 ){
			showMessage(EXCLAMATION, OK, "USER-1027", "대분류코드", "4");
			errYn = true;
			colid = "LCODE";
			break;
		}

		if( !checkInputByte( objGD, objDS, i, "LNAME", "대분류명", null,50)){
			errYn = true;
			colid = "LNAME";
			break;
		}

	}
	if(errYn){
		setFocusGrid(objGD, objDS, row, colid);
		return false;
	}

	//중분류
	dupRow = checkDupKey(DS_IO_MMENU,"MCODE");
	if( dupRow > 0){
		showMessage(EXCLAMATION, OK, "USER-1044");
		setFocusGrid(GD_MMENU, DS_IO_MMENU, dupRow, "MCODE");
		return false;
	}

	for(var i=1; i<=DS_IO_MMENU.CountRow; i++)
	{

		objDS = DS_IO_MMENU;
		objGD = GD_MMENU;

		var rowStatus = objDS.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;
		row = i;
		if( objDS.NameValue(i,"MCODE")==""  ){
			showMessage(EXCLAMATION, OK, "USER-1003", "중분류코드");
			errYn = true;
			colid = "MCODE";
			break;
		}
		if( objDS.NameValue(i,"MNAME")==""){
			showMessage(EXCLAMATION, OK, "USER-1003", "중분류명");
			errYn = true;
			colid = "MNAME";
			break;
		}

		if( (objDS.NameValue(i,"MCODE")).length > 4 ){
			showMessage(EXCLAMATION, OK, "USER-1027", "중분류코드", "4");
			errYn = true;
			colid = "MCODE";
			break;
		}

		if( !checkInputByte( objGD, objDS, i, "MNAME", "중분류명", null,50)){
			errYn = true;
			colid = "MNAME";
			break;
		}

	}
	if(errYn){
		setFocusGrid(objGD, objDS, row, colid);
		return false;
	}

	//소분류
	dupRow = checkDupKey(DS_IO_SMENU,"SCODE");
	if( dupRow > 0){
		showMessage(EXCLAMATION, OK, "USER-1044");
		setFocusGrid(GD_SMENU, DS_IO_SMENU, dupRow, "SCODE");
		return false;
	}

	for(var i=1; i<=DS_IO_SMENU.CountRow; i++)
	{
		objDS = DS_IO_SMENU;
		objGD = GD_SMENU;

		var rowStatus = objDS.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;
		row = i;
		if( objDS.NameValue(i,"SCODE")==""  ){
			showMessage(EXCLAMATION, OK, "USER-1003", "소분류코드");
			errYn = true;
			colid = "SCODE";
			break;
		}
		if( objDS.NameValue(i,"SNAME")==""){
			showMessage(EXCLAMATION, OK, "USER-1003", "소분류명");
			errYn = true;
			colid = "SNAME";
			break;
		}


		if( (objDS.NameValue(i,"SCODE")).length > 7 ){
			showMessage(EXCLAMATION, OK, "USER-1027", "소분류코드", "7");
			errYn = true;
			colid = "SCODE";
			break;
		}

		if( !checkInputByte( objGD, objDS, i, "SNAME", "소분류명", null,50)){
			errYn = true;
			colid = "SNAME";
			break;
		}
	}
	if(errYn){
		setFocusGrid(objGD, objDS, row, colid);
		return false;
	}

	//프로그램
	dupRow = checkDupKey(DS_IO_PROGRAM,"PID");
	if( dupRow > 0){
		showMessage(EXCLAMATION, OK, "USER-1044");
		setFocusGrid(GD_PROGRAM, DS_IO_PROGRAM, dupRow,"PID");
		return false;
	}

	for(var i=1; i<=DS_IO_PROGRAM.CountRow; i++)
	{

		objDS = DS_IO_PROGRAM;
		objGD = GD_PROGRAM;

		var rowStatus = objDS.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;
		row = i;
		if( objDS.NameValue(i,"PID")==""  ){
			showMessage(EXCLAMATION, OK, "USER-1003", "프로그램ID");
			errYn = true;
			colid = "PID";
			break;
		}
		if( objDS.NameValue(i,"PNAME1")==""){
			showMessage(EXCLAMATION, OK, "USER-1003", "프로그램명");
			errYn = true;
			colid = "PNAME1";
			break;
		}
		if( !checkInputByte( objGD, objDS, i, "PNAME1", "프로그램명", null,50)){
			errYn = true;
			colid = "PNAME1";
			break;
		}
		if( !checkInputByte( objGD, objDS, i, "URL", "URL", null,100)){
			errYn = true;
			colid = "URL";
			break;
		}
	}

	if(errYn){
		setFocusGrid(objGD, objDS, row, colid);
		return false;
	}

	return true;

}

/*
 * btn_add1()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 : 대분류 행추가
 * return값 : void
 */
function btn_add1() {

	if( DS_IO_MMENU.IsUpdated || DS_IO_SMENU.IsUpdated || DS_IO_PROGRAM.IsUpdated )
	{
		// 변경된 내역 있을경우 rtn
		if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )  return;
	}

	// 하위 그리드 초기화
	DS_IO_MMENU.ClearData();
	DS_IO_SMENU.ClearData();
	DS_IO_PROGRAM.ClearData();

	DS_IO_LMENU.AddRow();
	bfLCodeRowPosition = DS_IO_LMENU.CountRow;

	// 시스템구분 셋팅
	DS_IO_LMENU.NameValue(DS_IO_LMENU.CountRow, "SUB_SYSTEM") = getSubSystemCode();

	// 그리드  포커스
	setFocusGrid(GD_LMENU, DS_IO_LMENU, DS_IO_LMENU.CountRow,  "LCODE");
	setLastFocusGrid('L');          // 마지막 선택 그리드지정
}

/*
 * btn_add2()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 : 중분류 행추가
 * return값 : void
 */
function btn_add2() {

	if( DS_IO_SMENU.IsUpdated || DS_IO_PROGRAM.IsUpdated )
	{
		// 변경된 내역 있을경우 rtn
		if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )  return;
	}

	if ( DS_IO_LMENU.RowPosition < 1)
	{
		showMessage(STOPSIGN, OK, "USER-1045", "대분류");
		return;
	}

	if ( DS_IO_LMENU.NameValue(DS_IO_LMENU.RowPosition,"LCODE") == "")
	{
		showMessage(EXCLAMATION, OK, "USER-1003", "대분류코드");
		setFocusGrid(GD_LMENU, DS_IO_LMENU, DS_IO_LMENU.RowPosition, "LCODE");
		return;
	}

	// 하위 그리드 초기화
	DS_IO_SMENU.ClearData();
	DS_IO_PROGRAM.ClearData();

	DS_IO_MMENU.AddRow();
	bfMCodeRowPosition = DS_IO_MMENU.CountRow;

	// 대/중분류값 셋팅
	DS_IO_MMENU.NameValue(DS_IO_MMENU.CountRow, "LCODE")  = DS_IO_LMENU.NameValue(DS_IO_LMENU.RowPosition,"LCODE");

	// 그리드  포커스
	setFocusGrid(GD_MMENU, DS_IO_MMENU, DS_IO_MMENU.CountRow,  "MCODE");
}

/*
 * btn_add3()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 : 소분류 행추가
 * return값 : void
 */
function btn_add3() {

	if( DS_IO_PROGRAM.IsUpdated )
	{  // 변경된 내역 있을경우 rtn
		if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )  return;
	}

	if ( DS_IO_MMENU.RowPosition < 1)
	{
		showMessage(STOPSIGN, OK, "USER-1045", "중분류");
		return;
	}

	if ( DS_IO_MMENU.NameValue(DS_IO_MMENU.RowPosition,"MCODE") == "" )
	{
		showMessage(EXCLAMATION, OK, "USER-1003", "중분류코드");
		setFocusGrid(GD_MMENU, DS_IO_MMENU, DS_IO_MMENU.RowPosition, "MCODE");
		return;
	}

	// 하위 그리드 초기화
	DS_IO_PROGRAM.ClearData();

	DS_IO_SMENU.AddRow();
	bfSCodeRowPosition = DS_IO_SMENU.CountRow;

	// 대/중분류값 셋팅
	DS_IO_SMENU.NameValue(DS_IO_SMENU.CountRow, "LCODE")  = DS_IO_MMENU.NameValue(DS_IO_MMENU.RowPosition,"LCODE");
	DS_IO_SMENU.NameValue(DS_IO_SMENU.CountRow, "MCODE")  = DS_IO_MMENU.NameValue(DS_IO_MMENU.RowPosition,"MCODE");

	setFocusGrid(GD_SMENU, DS_IO_SMENU, DS_IO_SMENU.CountRow,  "SCODE"); // 그리드  포커스
}

/*
 * btn_add4()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 : 프로그램 행추가
 * return값 : void
 */
function btn_add4() {
	if (getLastFocusGrid() != "S")
	{
		showMessage(STOPSIGN, OK, "USER-1045", "소분류");
		return;
	}

	if (DS_IO_SMENU.NameValue(DS_IO_SMENU.RowPosition,"SCODE") == "")
	{
		showMessage(STOPSIGN, OK, "USER-1045", "소분류");
		return;
	}

	// alert(DS_O_PROGRAM_ID.NameValueRow("PID",getScode()) + "//"+ DS_IO_PROGRAM.CountRow);

	if( DS_IO_PROGRAM.CountRow > 0 )
	{
		showMessage(EXCLAMATION, OK, "USER-1000", "프로그램은 각 소분류당 하나만 등록할 수 있습니다");
		return;
	}

	DS_IO_PROGRAM.AddRow();
	DS_IO_PROGRAM.NameValue(DS_IO_PROGRAM.RowPosition, "PID")   = DS_IO_SMENU.NameValue(DS_IO_SMENU.RowPosition,"SCODE");
	DS_IO_PROGRAM.NameValue(DS_IO_PROGRAM.RowPosition, "SCODE") = DS_IO_SMENU.NameValue(DS_IO_SMENU.RowPosition,"SCODE");
	DS_IO_PROGRAM.NameValue(DS_IO_PROGRAM.RowPosition, "PNAME1") = DS_IO_SMENU.NameValue(DS_IO_SMENU.RowPosition,"SNAME");

	setFocusGrid(GD_PROGRAM, DS_IO_PROGRAM, DS_IO_PROGRAM.CountRow,  "PNAME1"); // 그리드  포커스

}


/*
 * btn_del1()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 : 대분류 행삭제
 * return값 : void
 */
function btn_del1(){
	var objDS = getLastFocusGridDS(); //선택된 Grid의 DS값을 가져온다.

	//메뉴 선택 했는지 확인하기
	if( getLastFocusGridDS()==undefined ){
		showMessage(STOPSIGN, OK, "USER-1045", "삭제할 메뉴");
		return;
	}

	setLastFocusGrid('L');
	//삭제시 하위 단계의 값이 있는지 여부 확인 : 있으면 삭제 못함 - 메세지를 보여줌.
	if( isColumnBelowThis() ) {
		showMessage(STOPSIGN, OK, "USER-1046" );
		return;
	}
	DS_IO_LMENU.DeleteRow(DS_IO_LMENU.RowPosition);
}


/*
 * btn_del2()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 : 중분류 행삭제
 * return값 : void
 */
function btn_del2(){
	//삭제시 하위 단계의 값이 있는지 여부 확인 : 있으면 삭제 못함 - 메세지를 보여줌.
	if( isColumnBelowThis() ) {
		showMessage(STOPSIGN, OK, "USER-1046" );
		return;
	}

	setLastFocusGrid('M');
	//삭제시 하위 단계의 값이 있는지 여부 확인 : 있으면 삭제 못함 - 메세지를 보여줌.
	if( isColumnBelowThis() ) {
		showMessage(STOPSIGN, OK, "USER-1046" );
		return;
	}
	DS_IO_MMENU.DeleteRow(DS_IO_MMENU.RowPosition);
}


/*
 * btn_del3()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 : 소분류 행삭제
 * return값 : void
 */
function btn_del3(){
	//메뉴 선택 했는지 확인하기
	if( getLastFocusGridDS() == undefined ){
		showMessage(STOPSIGN, OK, "USER-1045", "삭제할 메뉴");
		return;
	}

	setLastFocusGrid('S');
	//삭제시 하위 단계의 값이 있는지 여부 확인 : 있으면 삭제 못함 - 메세지를 보여줌.
	if( isColumnBelowThis() ) {
		showMessage(STOPSIGN, OK, "USER-1046" );
		return;
	}
	DS_IO_SMENU.DeleteRow(DS_IO_SMENU.RowPosition);
}

/*
 * btn_del4()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010-12-31
 * 개    요 : 행추가
 * return값 : void
 */
function btn_del4(){
	DS_IO_PROGRAM.DeleteRow(DS_IO_PROGRAM.RowPosition);
}


/**
* showTreeView()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : 트리 형태로 값을 뿌려줍니다.
* return값 : void
*/
function showTreeView(){
	TV_MAIN.ClearAll();

	var goTo       = "treeview";
	var parameters = "&strSubSystem="+encodeURIComponent(getSubSystemCode()) ;
	var action     = "O";

	TR_MAIN.Action="/pot/tcom102.tc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_O_TREE_MAIN=DS_O_TREE_MAIN)"; //조회는 O
	TR_MAIN.Post();
}

/**
* showLmenu()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 :  대분류 메뉴를 그리드에 뿌려줍니다.
* return값 : void
*/
function showLmenu(SUB_SYSTEM){
	//하위 메뉴 초기화
	showMmenu('');

	var goTo       = "selectLmenu";
	var parameters = "&strSubSystem="+encodeURIComponent(SUB_SYSTEM) ;
	var action     = "O";

	TR_MAIN.Action="/pot/tcom102.tc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_LMENU=DS_IO_LMENU)"; //조회는 O
	TR_MAIN.Post();

	setPorcCount("SELECT", DS_IO_LMENU.CountRow);
}

/**
* showMmenu()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-07
* 개    요 : 중분류 메뉴를 그리드에 뿌려줍니다.
* return값 : void
*/
function showMmenu(LCODE){

	showSmenu('','');

	var goTo       = "selectMmenu";
	var parameters = "&strLCode="+encodeURIComponent(LCODE) ;
	var action     = "O";

	TR_MAIN.Action="/pot/tcom102.tc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MMENU=DS_IO_MMENU)"; //조회는 O
	TR_MAIN.Post();

	setPorcCount("SELECT", DS_IO_MMENU.CountRow);
}

/**
* showSmenu()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-10
* 개    요 : 소분류 메뉴를 그리드에 뿌려줍니다.
* return값 : void
*/
function showSmenu(LCODE,MCODE){
	//하위 메뉴 초기화
	showProgram('','','');

	var goTo       = "selectSmenu";
	var parameters = "&strLCode="+encodeURIComponent(LCODE)+"&strMCode="+encodeURIComponent(MCODE);
	var action     = "O";

	TR_MAIN.Action="/pot/tcom102.tc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SMENU=DS_IO_SMENU)"; //조회는 O
	TR_MAIN.Post();

	setPorcCount("SELECT", DS_IO_SMENU.CountRow);
}

/**
* showProgram()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-10
* 개    요 : 선택된 프로그램을 그리드에 뿌려줍니다.
* return값 : void
*/
function showProgram(){
	var args = showProgram.arguments;
	//alert(args.length);
	var LCODE = args[0];
	var MCODE = args[1];
	var SCODE = args[2];

	//alert(LCODE + " - " + MCODE + " - " + SCODE + " - "  );

	var goTo       = "selectProgram";
	var parameters = "&strLCode="+encodeURIComponent(LCODE)+"&strMCode="+encodeURIComponent(MCODE)+"&strSCode="+encodeURIComponent(SCODE);
	var action     = "O";

	TR_MAIN.Action="/pot/tcom102.tc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_PROGRAM=DS_IO_PROGRAM)"; //조회는 O
	TR_MAIN.Post();

	setPorcCount("SELECT", DS_IO_PROGRAM.CountRow);
}


/**
* setLastFocusGrid()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-10
* 개    요 : 마지막 선택 되었던 그리드를 저장해놓는다.
* return값 : void
*/
function setLastFocusGrid(last){
	lastFocusGrid = last;
}

/**
* getLastFocusGrid()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-10
* 개    요 : 마지막 선택 되었던 그리드를 리턴한다.
* return값 : lastFocusGrid
*/
function getLastFocusGrid(){
	return lastFocusGrid;
}

/**
* getLastFocusGridDS()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-10
* 개    요 : 마지막 선택 되었던 그리드의 DS를 리턴한다.
* return값 : objDS
*/
function getLastFocusGridDS(){
	var objDS, lastFocus = getLastFocusGrid();
	if(lastFocus=='L'){
		objDS = DS_IO_LMENU;
	}else if(lastFocus=='M'){
		objDS = DS_IO_MMENU;
	}else if(lastFocus=='S'){
		objDS = DS_IO_SMENU;
	}else if(lastFocus=='P'){
		objDS = DS_IO_PROGRAM;
	}
	return objDS;
}

/**
* getObjGridLastFocus()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-12
* 개    요 : 마지막 선택 되었던 그리드 Object를 리턴한다.
* return값 : objDS
*/
function getObjGridLastFocus(){
	var objDS, lastFocus = getLastFocusGrid();
	if(lastFocus=='L'){
		objDS = GD_LMENU;
	}else if(lastFocus=='M'){
		objDS = GD_MMENU;
	}else if(lastFocus=='S'){
		objDS = GD_SMENU;
	}else if(lastFocus=='P'){
		objDS = GD_PROGRAM;
	}
	return objDS;
}

/**
* chgLRowPosition()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : Row의 위치가 변경되었을 때 발생한다. (대분류)
*/
function chgLRowPosition(Row)
{
	if( DS_IO_MMENU.IsUpdated || DS_IO_SMENU.IsUpdated || DS_IO_PROGRAM.IsUpdated )
	{
		if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )
		{
			DS_IO_LMENU.RowPosition = bfLCodeRowPosition;
			return;
		}
		else
			DS_IO_LMENU.UndoAll();
	}

	bfLCodeRowPosition = Row;
	eventLmenuGrid();
}

/**
* chgMRowPosition()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : Row의 위치가 변경되었을 때 발생한다. (중분류)
*/
function chgMRowPosition(Row)
{
	if( DS_IO_SMENU.IsUpdated || DS_IO_PROGRAM.IsUpdated )
	{
		if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )
		{
			DS_IO_MMENU.RowPosition = bfMCodeRowPosition;
			return;
		}
		else
			DS_IO_MMENU.UndoAll();
	}

	bfMCodeRowPosition = Row;
	eventMmenuGrid();
}

/**
* chgSRowPosition()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : Row의 위치가 변경되었을 때 발생한다. (소분류)
*/
function chgSRowPosition(Row)
{
	if( DS_IO_PROGRAM.IsUpdated )
	{
		if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )
		{
			DS_IO_SMENU.RowPosition = bfSCodeRowPosition;
			return;
		}
		else
			DS_IO_SMENU.UndoAll();
	}
	bfSCodeRowPosition = Row;
	eventSmenuGrid();
}

/**
* setLcode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-12
* 개    요 : 선택된 대분류의 코드를 기억해놓는다.
* return값 : void
*/
var lcode;
function setLcode() {
	lcode = getValueCurrRowInLmenu("LCODE");
}

/**
* getLcode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-12
* 개    요 : 선택된 대분류의 코드를 리턴한다.
* return값 : LCODE
*/
function getLcode() {
	return lcode;
}

/**
* setMcode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-12
* 개    요 : 선택된 중분류의 코드를 기억해놓는다.
* return값 : void
*/
var mcode;
function setMcode() {
	mcode = getValueCurrRowInMmenu("MCODE");
}

/**
* getMcode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-12
* 개    요 : 선택된 중분류의 코드를 리턴한다.
* return값 : MCODE
*/
function getMcode() {
	return mcode;
}

/**
* setScode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-12
* 개    요 : 선택된 소분류의 코드를 기억해놓는다.
* return값 : void
*/
var scode;
function setScode() {
	scode = getValueCurrRowInSmenu("SCODE");
	//alert(scode);
}

/**
* getScode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-12
* 개    요 : 선택된 소분류의 코드를 리턴한다.
* return값 : SCODE
*/
function getScode() {
	return scode;
}

/**
* clearScode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-12
* 개    요 : 선택된 소분류의 코드를   초기화한다.
* return값 : void
*/
function clearScode() {
	scode = '';
}

/**
* isColumnBelowThis()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-13
* 개    요 : 메뉴 삭제시 하위 메뉴가 포함되어 있는지 확인하기.
* return값 : boolean
*/
function isColumnBelowThis() {
	var ret = false;
	var belowDsObj, lastFocus = getLastFocusGrid();

	if(lastFocus!='P'){
		if(lastFocus=='L'){
			showMmenu(getValueCurrRowInLmenu("LCODE"));
			belowDsObj = DS_IO_MMENU;
		}else if(lastFocus=='M'){
			showSmenu(getValueCurrRowInMmenu("LCODE"),getValueCurrRowInMmenu("MCODE"));
			belowDsObj = DS_IO_SMENU;
		}else if(lastFocus=='S'){
			showProgram('','',getValueCurrRowInSmenu("SCODE"));
			belowDsObj = DS_IO_PROGRAM;
		}
		if (belowDsObj !=undefined){
			if( belowDsObj.CountRow > 0 )
				ret = true;
		}
	}

	return ret;
}

/**
 * getValueCurrRowInLmenu()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-13
 * 개    요 : 현재 선택되어 있는 LMENU의 데이타셋에서 해당되는 컬럼의 값을 리턴한다.
 * return값 : value
 */
function getValueCurrRowInLmenu(column)
{
	return DS_IO_LMENU.NameValue(DS_IO_LMENU.RowPosition,column);
}

/**
 * getValueCurrRowInMmenu()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-13
 * 개    요 : 현재 선택되어 있는 MMENU의 데이타셋에서 해당되는 컬럼의 값을 리턴한다.
 * return값 : value
 */
function getValueCurrRowInMmenu(column)
{
	return DS_IO_MMENU.NameValue(DS_IO_MMENU.RowPosition,column);
}

/**
 * getValueCurrRowInSmenu()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-13
 * 개    요 : 현재 선택되어 있는 SMENU의 데이타셋에서 해당되는 컬럼의 값을 리턴한다.
 * return값 : value
 */
function getValueCurrRowInSmenu(column)
{
	return DS_IO_SMENU.NameValue(DS_IO_SMENU.RowPosition,column);
}

/**
* getSubSystemCode()
* 작 성 자 : ckj
* 작 성 일 : 2006-07-11
* 개    요 : 현재 선택된 SUB_SYSTEM의 코드값을 리턴한다.
* return값 : SUB_SYSTEM (P,G,A or C)
*/
function getSubSystemCode()
{
	return LC_SUB_SYSTEM.ValueOfIndex("CODE", LC_SUB_SYSTEM.Index);
}

/**
 * eventLmenuGrid()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-18
 * 개    요 : 대분류 Grid 이벤트 처리
 * return값 : void
 */
function eventLmenuGrid() {
	var lcode ;
	var args=eventLmenuGrid.arguments;

	if(args[0]==undefined)
	{
		//Grid에서 이벤트 일어날 경우
		lcode = getValueCurrRowInLmenu("LCODE");
	}
	else
	{
		//Tree에서 이벤트 일어날 경우
		lcode = args[0];
		DS_IO_LMENU.RowPosition = DS_IO_LMENU.NameValueRow("LCODE",lcode);
	}

	showMmenu(lcode);               // 중분류리스트 조회

	setLastFocusGrid('L');          // 마지막 선택 그리드지정

	setLcode();//중분류,소분류  뉴레코드 입력시 사용
	clearScode();
}

/**
 * eventMmenuGrid()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-18
 * 개    요 : 중분류 Grid 이벤트 처리
 * return값 : void
 */
function eventMmenuGrid() {
	var lcode, mcode;
	var args = eventMmenuGrid.arguments;

	if(args[0]==undefined)
	{
		//Grid에서 이벤트 일어날 경우
		lcode = getValueCurrRowInLmenu("LCODE");
		mcode = getValueCurrRowInMmenu("MCODE");
	}
	else
	{
		//Tree에서 이벤트 일어날 경우
		lcode = args[0].substring(0,4);
		mcode = args[0].substring(4);

		eventLmenuGrid(lcode);    //다른 대분류 하위의 중분류를 선택했을때..대분류 포커스도 같이 변경.
		DS_IO_MMENU.RowPosition = DS_IO_MMENU.NameValueRow("MCODE",mcode);
	}

	showSmenu(lcode,mcode);         // 소분류리스트 조회

	setLastFocusGrid('M');          // 마지막 선택 그리드지정

	setMcode();//소분류  뉴레코드 입력시 사용
	clearScode();
}

/**
 * eventSmenuGrid()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-07-18
 * 개    요 : 중분류 Grid 이벤트 처리
 * return값 : void
 */
function eventSmenuGrid() {
	var lmcode, scode, args=eventSmenuGrid.arguments;
	if(args[0]==undefined){                            //Grid에서 이벤트 일어날 경우
		scode = getValueCurrRowInSmenu("SCODE");
	}else{                                            //Tree에서 이벤트 일어날 경우
		lmcode = args[0].substring(0,6);
		scode  = args[0].substring(6);
		eventMmenuGrid(lmcode);    //다른 대분류 또는 중분류 하위의 소분류를 선택했을때..대분류 또는 중분류 포커스도 같이 변경.
		DS_IO_SMENU.RowPosition = DS_IO_SMENU.NameValueRow("SCODE",scode);
	}

	showProgram('','',scode);
	setLastFocusGrid('S');
	setScode();//소분류 뉴레코드 입력시 사용

}

-->
</script>
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
	for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++)
	{
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
	}
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- 서브시스템 LUXCOMBO 상태 변경시   -->
<script language=JavaScript for=LC_SUB_SYSTEM event=onSelChange()>
	showLmenu(getSubSystemCode());
	showTreeView();
</script>

<!-- 트리 메뉴 클릭시 이벤트 : Grid와 연동(Tree=>Grid)하기   -->
<script language=JavaScript for=TV_MAIN event=OnClick()>
	var code = DS_O_TREE_MAIN.NameValue(DS_O_TREE_MAIN.RowPosition, "CODE");
	if( TV_MAIN.ItemLevel==2 ){
		eventLmenuGrid(code);
	} else if( TV_MAIN.ItemLevel==3 ){
		eventMmenuGrid(code);
	} else if( TV_MAIN.ItemLevel==4 ){
		eventSmenuGrid(code);
	}
</script>

<!-- 대분류 액션 처리 -->
<script language="javascript"  for=DS_IO_LMENU event=OnLoadCompleted(rowcnt)>
	// 페이지 ONLOAD 후 조회버튼 누르는 경우 첫번째 대메뉴의 프로그램리스트 조회
	if (rowcnt > 0 ) setLastFocusGrid('L');
</script>

<!-- 대분류 액션 처리 -->
<script language="javascript"  for=GD_LMENU event=OnClick(Row,Colid)>
	if( Row > 0) chgLRowPosition(Row);
</script>

<!-- 중분류 액션 처리 -->
<script language="javascript"  for=GD_MMENU event=OnClick(Row,Colid)>
	if( Row > 0) chgMRowPosition(Row);
</script>

<!-- 소분류 액션 처리 -->
<script language="javascript"  for=GD_SMENU event=OnClick(Row,Colid)>
	if( Row > 0) chgSRowPosition(Row);
</script>

<!-- 프로그램 액션 처리 -->
<script language="javascript"  for=GD_PROGRAM event=OnClick(Row,Colid)>
    setLastFocusGrid('P');
</script>

<!-- Grid 대분류 상하키 event 처리 -->
<script language=JavaScript for=GD_LMENU event=onKeyPress(keycode)>
	if ((keycode == 38) || (keycode == 40) || (keycode == 255 && GD_LMENU.GetColumn() =="LNAME" && DS_IO_LMENU.NameValue(DS_IO_LMENU.RowPosition, "LNAME") != "" ))
	{
		var Row = DS_IO_LMENU.RowPosition;
		if( Row > 0) chgLRowPosition(Row);
	}
</script>

<!-- Grid 중분류 상하키 event 처리 -->
<script language=JavaScript for=GD_MMENU event=onKeyPress(keycode)>
	if ((keycode == 38) || (keycode == 40) || (keycode == 255 && GD_MMENU.GetColumn() =="MNAME" && DS_IO_MMENU.NameValue(DS_IO_MMENU.RowPosition, "MNAME") != "" ))
	{
		var Row = DS_IO_MMENU.RowPosition;
		if( Row > 0) chgMRowPosition(Row);
	}
</script>

<!-- Grid 소분류 상하키 event 처리 -->
<script language=JavaScript for=GD_SMENU event=onKeyPress(keycode)>
	if ((keycode == 38) || (keycode == 40) || (keycode == 255 && GD_SMENU.GetColumn() =="SNAME" && DS_IO_SMENU.NameValue(DS_IO_SMENU.RowPosition, "SNAME") != "" ))
	{
		var Row = DS_IO_SMENU.RowPosition;
		if( Row > 0) chgSRowPosition(Row);
	}
</script>

<!--------------------- 사용자처리 스크립트 끝------------------------>

<comment id="_NSID_">
	<object id="TR_MAIN" classid="<%=Util.CLSID_TRANSACTION%>"><param name="KeyName" value="Toinb_dataid4"></object>
</comment><script>_ws_(_NSID_);</script>

<!-- 대분류 조회용  데이타셋  -->
<comment id="_NSID_"><object id=DS_IO_LMENU classid=<%=Util.CLSID_DATASET%>></object></comment> <script>_ws_(_NSID_);</script>
<!-- 중분류 조회용  데이타셋  -->
<comment id="_NSID_"><object id=DS_IO_MMENU classid=<%=Util.CLSID_DATASET%>></object></comment> <script>_ws_(_NSID_);</script>
<!-- 소분류 조회용  데이타셋  -->
<comment id="_NSID_"><object id=DS_IO_SMENU classid=<%=Util.CLSID_DATASET%>></object></comment> <script>_ws_(_NSID_);</script>
<!-- 프로그램 조회용  데이타셋  -->
<comment id="_NSID_"><object id=DS_IO_PROGRAM classid=<%=Util.CLSID_DATASET%>></object></comment> <script>_ws_(_NSID_);</script>
<!-- 콤보박스  데이타셋  -->
<comment id="_NSID_"><object id="DS_O_SUBSYSTEM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 트리뷰용 데이터셋 -->
<comment id="_NSID_"><object id="DS_O_TREE_MAIN" classid=<%=Util.CLSID_DATASET%>></object></comment> <script> _ws_(_NSID_);</script>

<!-- 현재 선택된 서브시스템 : LUXCOMBO(LC_SUB_SYSTEM)의 선택된 값에 의해 정해짐) -->
<comment id="_NSID_"><object id="DS_I_SUB_SYSTEM" classid=<%=Util.CLSID_DATASET%>></object></comment> <script> _ws_(_NSID_);</script>

<!-- 프로그램 등록여부 확인용 데이터셋 -->
<comment id="_NSID_"><object id="DS_O_PROGRAM_ID" classid=<%=Util.CLSID_DATASET%>></object></comment> <script> _ws_(_NSID_);</script>
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->

</head>

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_LMENU");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_MMENU");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_SMENU");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">

	<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
		<TR>
			<td class="PT01 PB03">
				<TABLE width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
					<TR><TD>
						<!-- search start -->
						<TABLE width="98%" border="0" cellpadding="0" cellspacing="0" class="s_table ">
						<TR>
							<th width="100" class="point">시스템구분</th>
							<TD>
								<comment id="_NSID_">
									<object id=LC_SUB_SYSTEM classid=<%= Util.CLSID_LUXECOMBO %> width=120 align="absmiddle">
									</object>
								</comment><script>_ws_(_NSID_);</script>
							</TD>
						</TR>
						</TABLE>
						<!-- search end -->
					</TD></TR>
				</TABLE>
			</TD>
		</TR>
		<TR><td class="dot"></TD></TR>
		<TR>
			<td valing="top" >
				<TABLE height="100%" width="100%" border="0" cellspacing="0" cellpadding="0"  >
					<TR>
						<!-- 메뉴트리 -->
						<TD width="180" align=center valign="top" class="BD2A"  >
							<comment id="_NSID_">
							  <object id=TV_MAIN classid=<%=Util.CLSID_TREEVIEW%>  width=100% height=100%>
								<param name=DataID          value="DS_O_TREE_MAIN">
								<param name=TextColumn      value="TXT">
								<param name=LevelColumn     value="LVL">
								<param name=UseImage        value="false">
								<param name=ExpandOneClick  value="true">
								<param name=BorderStyle     value="0">
							  </object>
							  </comment><script>_ws_(_NSID_);</script>
						</TD>

						<TD class="PL05" valign="top" height=100%  valign ="top">
							<TABLE width="100%" border="0" cellspacing="0" cellpadding="1" >
								<TR>
								<!-- 행추가/삭제버튼  -->
								<td class="right" >
									<img src="/pot/imgs/btn/add_row.gif"    class="PR03"    onclick="javascript:btn_add1();" />
									<img src="/pot/imgs/btn/del_row.gif"    class="PR03"    onclick="javascript:btn_del1();" />
								</TD>
								<td class="right ">
									<img src="/pot/imgs/btn/add_row.gif"    class="PR03"    onclick="javascript:btn_add2();" />
									<img src="/pot/imgs/btn/del_row.gif"    class="PR03"    onclick="javascript:btn_del2();" />
								</TD>
								<td class="right ">
									<img src="/pot/imgs/btn/add_row.gif"    class="PR03"    onclick="javascript:btn_add3();" />
									<img src="/pot/imgs/btn/del_row.gif"    class="PR03"    onclick="javascript:btn_del3();" />
								</TD>
								</TR>

								<TR>
								<TD width="190" align=center  valign ="top">
									<!-- 대분류 -->
									<TABLE cellpadding="0" border="0" cellspacing="0" class="BD4A" width="100%">
									<TR>
									<TD>
										<comment id="_NSID_">
											<object id=GD_LMENU classid=<%=Util.CLSID_GRID%> width=100% height="270">
												<param name=DataID        value=DS_IO_LMENU>
											</object>
										</comment><script>_ws_(_NSID_);</script>
									</TD>
									</TR>
									</TABLE>
								</TD>

								<TD width="210" align=center  valign ="top">
									<!-- 중분류 -->
									<TABLE cellpadding="0" border="0" cellspacing="0" class="BD4A" width="100%">
									<TR>
									<TD>
										<comment id="_NSID_">
											<object id=GD_MMENU classid=<%=Util.CLSID_GRID%> width=100% height="270">
												<param name=DataID        value=DS_IO_MMENU>
											</object>
										</comment><script>_ws_(_NSID_);</script>
									</TD>
									</TR>
									</TABLE>
								</TD>

								<TD align=center  valign ="top">
									<!-- 소분류 -->
									<TABLE cellpadding="0" border="0" cellspacing="0" class="BD4A" width="100%">
									<TR>
									<TD>
										<comment id="_NSID_">
											<object id=GD_SMENU classid=<%=Util.CLSID_GRID%> width=100% height="270">
												<param name=DataID        value=DS_IO_SMENU>
											</object>
										</comment><script>_ws_(_NSID_);</script>
									</TD>
									</TR>
									</TABLE>
								</TD>
								</TR>
							</TABLE>

							<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
								<TR><TD height=5></TD></TR>
							</TABLE>

							<TABLE width="100%" border="0" cellspacing="0" cellpadding="0"  >
								<TR><td class="right">
									<img src="/pot/imgs/btn/add_row.gif"  class="PR03" onclick="javascript:btn_add4();" />
									<img src="/pot/imgs/btn/del_row.gif" class="PR03"  onclick="javascript:btn_del4();" />
								</td></TR>

								<TR>
									<td width="100%" align=center  >
										<!-- 프로그램 -->
										<TABLE cellpadding="0" border="0" cellspacing="0" class="BD4A"  width="100%">
										<TR><TD>
											<comment id="_NSID_">
												<object id=GD_PROGRAM classid=<%=Util.CLSID_GRID%> height=100 width=100% >
													<param name=DataID      value=DS_IO_PROGRAM>
												</object>
											</comment><script>_ws_(_NSID_);</script>
										</TD></TR>
										</TABLE>
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</TABLE>
</div>
</body>
</html>
