<!--
/*******************************************************************************
 * 시스템명 : 사용자/그룹관리
 * 작 성 일 : 2010.06.24
 * 작 성 자 : Hseon
 * 수 정 자 :
 * 파 일 명 : tcom1030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 :
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8");  %>
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
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var strGlbOrgFlag  = ""; // 조직구분
var strGlbStrCd    = ""; // 점코드
var strGlbDeptCd   = ""; // 팀코드
var strGlbTeamCd   = ""; // 파트코드
var strGlbPcCd     = "";  // PC코드

var bfGroupRowPosition = 1; // 그룹리스트
var bfUserRowPosition  = 1; // 사용자리스트

var newMasterYn = false;

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 해당 페이지 LOAD 시
 * return값 : void
 */
 var top = 200;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_GROUP"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_USER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


	// Data Set Header 초기화
	DS_IO_GROUP.setDataHeader('<gauce:dataset name="H_SEL_GROUP"/>');
	DS_IO_USER.setDataHeader('<gauce:dataset name="H_SEL_USER"/>');

	//사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
	registerUsingDataset("tcom103","DS_IO_GROUP,DS_IO_USER" );

	//그리드 초기화
	gridCreate1(); //그룹
	gridCreate2(); //사용자

	//그리드에서 사용할 데이터셋 셋팅
	setGridDataSet();

	//콤보 초기화
	initComboStyle(LC_O_STR_CD,     DS_O_STR_CD,    "CODE^0^30,NAME^0^80",  1, NORMAL);     //점(조회)
	initComboStyle(LC_O_ORG_FLAG,   DS_O_ORG_FLAG,  "CODE^0^30,NAME^0^110", 1, NORMAL);     //조직구분(조회)
	initComboStyle(LC_O_USE_YN,     DS_O_USE_YN,    "CODE^0^30,NAME^0^80",  1, NORMAL);     //사용여부
	initComboStyle(LC_O_DEPT_CD,    DS_O_DEPT_CD,   "CODE^0^30,NAME^0^110", 1, NORMAL);     //팀
	initComboStyle(LC_O_TEAM_CD,    DS_O_TEAM_CD,   "CODE^0^30,NAME^0^110", 1, NORMAL);     //파트
	initComboStyle(LC_O_PC_CD,      DS_O_PC_CD,     "CODE^0^30,NAME^0^110", 1, NORMAL);     //PC

	// 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화
	DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
	DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
	DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');

	//점콤보 가져오기 ( gauce.js )
	getStore("DS_O_STR_CD", "N", "", "Y");

	//시스템 코드 공통코드에서 가지고 오기( popup.js )
	getEtcCode("DS_O_ORG_FLAG", "D", "P047", "Y");
	getEtcCode("DS_O_USE_YN",  "D", "D022", "Y");

	//콤보데이터 기본값 설정( gauce.js )
	var defaultOrg = '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';
	defaultOrg = (defaultOrg==""?"%":defaultOrg);
	setComboData(LC_O_ORG_FLAG, defaultOrg);
	setComboData(LC_O_STR_CD,"%");
	setComboData(LC_O_USE_YN,"%");

	// EMedit에 초기화
	initEmEdit(EM_USER_NAME, "GEN^30", NORMAL);    //사원번호/명
	

	//그룹코드 셋팅
	showGroupList();

	LC_O_ORG_FLAG.Focus();
	LC_O_STR_CD.Index = 0;
}

function gridCreate1(){

    var hdrProperies = '<FC>ID=GROUP_CD     width=35     align=Center   name="*그룹"    edit="AlphaNum"  </FC>'
                     + '<FC>ID=GROUP_NAME   width=110                   name="*그룹명"    </FC>' ;

    initGridStyle(GD_GROUP, "common", hdrProperies, true );
}

function gridCreate2(){

    var hdrProperies = '<FC>id={currow}         width=30   align=center     name="NO"              </FC>'
                     + '<FC>id=USER_ID          width=70                    name="*사용자ID"        </FC>'
                     + '<FC>id=USER_NAME        width=90                    name="*성명"            </FC>'
                     + '<FC>id=SUB_SYS          width=85    align=left      name="*시스템구분" EditStyle=Lookup   Data="DS_OG_SUB_SYS:CODE:NAME"</FC>'
                     + '<FC>id=VIEW_LEVEL       width=85    align=left      name="*뷰레벨"     EditStyle=Lookup   Data="DS_OG_VIEW_LEVEL:CODE:NAME"</FC>'
                     + '<FC>id=ORG_FLAG         width=85    align=left      name="*조직구분"   EditStyle=Lookup   Data="DS_OG_ORG_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=GROUP_CD         width=90                    name="*그룹"       EditStyle=Lookup   Data="DS_OG_GROUP:GROUP_CD:GROUP_NAME"</FC>'
                     + '<FC>id=STR_CD           width=90    align=left      name="*점"          EditStyle=Lookup   Data="DS_OG_STR_CD:CODE:NAME"</FC>'

                     + '<FG>                                                name="팀"'
                     + '<FC>id=DEPT_CD          width=40   align=center     name="코드"       EditStyle=popup     </FC>'
                     + '<FC>id=DEPT_NAME        width=80   align=left       name="명"         Edit = none         </FC>'
                     + '</FG>'
                     + '<FG>                                                name="파트"'
                     + '<FC>id=TEAM_CD          width=40   align=center     name="코드"       EditStyle=popup     </FC>'
                     + '<FC>id=TEAM_NAME        width=80   align=left       name="명"         Edit = none         </FC>'
                     + '</FG>'
                     + '<FG>                                                name="PC"'
                     + '<FC>id=PC_CD            width=40   align=center     name="코드"       EditStyle=popup     </FC>'
                     + '<FC>id=PC_NAME          width=80   align=left       name="명"         Edit = none         </FC>'
                     + '</FG>'
                     + '<FG>                                                 name="연락처"'
                     + '<FC>id=HP1_NO          width=40   align=center      edit=Numeric 	       </FC>'
                     + '<FC>id=HP2_NO          width=40   align=center      edit=Numeric           </FC>'
                     + '<FC>id=HP3_NO          width=40   align=center      edit=Numeric           </FC>'
                     + '</FG>'
                     + '<FC>id=V_EMP_GRADE      width=85    align=left      name="VOC등급"      show=false EditStyle=Lookup   Data="DS_OG_EMP_GRADE:CODE:NAME"</FC>'
                     + '<FC>id=V_FCL_CD         width=85    align=left      name="VOC처리시설"  show=false EditStyle=Lookup   Data="DS_OG_FCL_CD:CODE:NAME"</FC>'
                     + '<FC>id=V_DEPT_CD 	    width=85    align=left      name="VOC처리팀"  show=false EditStyle=Lookup   Data="DS_OG_VOC_DEPT_CD:CODE:NAME"</FC>'
                     + '<FC>id=V_TEAM_CD 	    width=85    align=left      name="VOC처리파트"    show=false EditStyle=Lookup   Data="DS_OG_VOC_TEAM_CD:CODE:NAME"</FC>'
                     + '<FC>id=V_CHAR_CD1      	width=85    align=left      name="VOC처리PC1"   show=false EditStyle=Lookup   Data="DS_OG_CHAR_CD:CODE:NAME"</FC>'
                     + '<FC>id=V_CHAR_CD2      	width=85    align=left      name="VOC처리PC2"   show=false EditStyle=Lookup   Data="DS_OG_CHAR_CD:CODE:NAME"</FC>'
                     + '<FC>id=V_CHAR_CD3      	width=85    align=left      name="VOC처리PC3"   show=false EditStyle=Lookup   Data="DS_OG_CHAR_CD:CODE:NAME"</FC>'
                     + '<FC>id=E_MAIL           width=150   align=left    name="이메일"           </FC>'
                     + '<FC>id=USE_YN           width=50    align=center    name="사용"         EditStyle=checkbox  </FC>'
                     + '<FC>id=MULTI_LOGIN      width=80    align=center    name="중복로그인"   EditStyle=checkbox  </FC>'
                     + '<FC>id=PWD_NO           width=90    Password=true   name="비밀번호(변경) " </FC>'
                     + '<FC>id=POSITION         width=90    align=left      name="직급명"  Edit = true </FC>'
                     + '<FC>id=INPUT_SYS        width=0                    name="등록시스템" </FC>'
                     + '<FC>id=CORNER_CD        width=0                    name=" " </FC>'
                     ;

    initGridStyle(GD_USER, "common", hdrProperies, true);

}

function setGridDataSet()
{
	//조직구분
	getEtcCode("DS_OG_ORG_FLAG", "D", "P047", "N");
	DS_OG_ORG_FLAG.insertRow(1);
	DS_OG_ORG_FLAG.NameValue(1,"CODE") = "";
	DS_OG_ORG_FLAG.NameValue(1,"NAME") = "";

	//점코드
	getStore("DS_OG_STR_CD", "N", "", "N");
	DS_OG_STR_CD.insertRow(1);
	DS_OG_STR_CD.NameValue(1,"CODE") = "";
	DS_OG_STR_CD.NameValue(1,"NAME") = "";
	DS_OG_STR_CD.NameValue(1,"GBN")  = "";

	//시스템구분
	getEtcCode("DS_OG_SUB_SYS",  "D", "TC01", "N");

	//뷰레벨
	getEtcCode("DS_OG_VIEW_LEVEL", "D", "TC03", "N");
	DS_OG_VIEW_LEVEL.insertRow(1);
	DS_OG_VIEW_LEVEL.NameValue(1,"CODE") = "";
	DS_OG_VIEW_LEVEL.NameValue(1,"NAME") = "";

	//VOC 등급
	getEtcCode("DS_OG_EMP_GRADE", "M", "M002", "N");
	DS_OG_EMP_GRADE.insertRow(1);
	DS_OG_EMP_GRADE.NameValue(1,"CODE") = "";
	DS_OG_EMP_GRADE.NameValue(1,"NAME") = "";

	//VOC 처리시설
	getEtcCode("DS_OG_FCL_CD", "M", "M003", "N");
	DS_OG_FCL_CD.insertRow(1);
	DS_OG_FCL_CD.NameValue(1,"CODE") = "";
	DS_OG_FCL_CD.NameValue(1,"NAME") = "";

	//VOC 처리팀
	getEtcCode("DS_OG_VOC_DEPT_CD", "M", "M004", "N");
	DS_OG_VOC_DEPT_CD.insertRow(1);
	DS_OG_VOC_DEPT_CD.NameValue(1,"CODE") = "";
	DS_OG_VOC_DEPT_CD.NameValue(1,"NAME") = "";
	DS_OG_VOC_DEPT_CD.UseFilter = true;

	//VOC 처리파트
	getEtcCode("DS_OG_VOC_TEAM_CD", "M", "M005", "N");
	DS_OG_VOC_TEAM_CD.insertRow(1);
	DS_OG_VOC_TEAM_CD.NameValue(1,"CODE") = "";
	DS_OG_VOC_TEAM_CD.NameValue(1,"NAME") = "";
	DS_OG_VOC_TEAM_CD.UseFilter = true;

	//VOC 처리PC
	getEtcCode("DS_OG_CHAR_CD", "M", "M006", "N");
	DS_OG_CHAR_CD.insertRow(1);
	DS_OG_CHAR_CD.NameValue(1,"CODE") = "";
	DS_OG_CHAR_CD.NameValue(1,"NAME") = "";
	DS_OG_CHAR_CD.UseFilter = true;

}

function setGroupGrid()
{
	//그룹
	var goTo       = "selectGroupGrid" ;
	var action     = "O";

	TR_MAIN.Action="/pot/tcom103.tc?goTo="+goTo;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_OG_GROUP=DS_OG_GROUP)"; //조회는 O
	TR_MAIN.Post();
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
 * 작 성 일 : 2010-02-24
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

	showGroupList();
	showUserList();
	setPorcCount("SELECT", DS_IO_GROUP.CountRow);

}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

	//기존의 신규로우 존재 시 초기화
	if( newMasterYn )
	{
		if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){
			GD_GROUP.Focus();
			return;
		}
		DS_IO_USER.ClearData();

		DS_IO_GROUP.NameValue(DS_IO_GROUP.CountRow, "GROUP_CD")   = "";
		DS_IO_GROUP.NameValue(DS_IO_GROUP.CountRow, "GROUP_NAME") = "";

		bfGroupRowPosition = DS_IO_GROUP.CountRow;
		setFocusGrid(GD_GROUP, DS_IO_GROUP, DS_IO_GROUP.CountRow,   "GROUP_CD");
		return;
	}

	if( DS_IO_USER.IsUpdated ){
		if( showMessage(QUESTION, YESNO, "USER-1050") != 1 ){
			GD_USER.Focus();
			return;
		}
	}

	DS_IO_USER.ClearData();

	DS_IO_GROUP.Addrow();
	DS_IO_GROUP.NameValue(DS_IO_GROUP.CountRow, "GROUP_CD")   = "";
	DS_IO_GROUP.NameValue(DS_IO_GROUP.CountRow, "GROUP_NAME") = "";

	bfGroupRowPosition = DS_IO_GROUP.CountRow;
	newMasterYn = true;

	setFocusGrid(GD_GROUP, DS_IO_GROUP, DS_IO_GROUP.CountRow,   "GROUP_CD");
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	// 삭제할 데이터 없는 경우
	if ( DS_IO_GROUP.CountRow < 1){
		//삭제할 내용이 없습니다
		showMessage(INFORMATION, OK, "USER-1019");
		LC_O_ORG_FLAG.Focus();
		return;
	}

	// 사용자리스트에  변경 내역있을  경우
	if( DS_IO_USER.IsUpdated){
		showMessage(INFORMATION , OK, "USER-1091");
		GD_USER.Focus();
		return;
	}
	// 전체그룹인 경우 삭제불가
	if( DS_IO_GROUP.NameValue(DS_IO_GROUP.rowposition, "GROUP_CD") == "998"){
		showMessage(EXCLAMATION, OK, "USER-1000", "전체그룹은 삭제할 수 없습니다.");
		GD_USER.Focus();
		return;
	}

	// 미그룹인 경우 삭제불가
	if( DS_IO_GROUP.NameValue(DS_IO_GROUP.rowposition, "GROUP_CD") == "999"){
		showMessage(EXCLAMATION, OK, "USER-1000", "미그룹은 삭제할 수 없습니다.");
		GD_USER.Focus();
		return;
	}

	//선택한 항목을 삭제하겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
		GD_GROUP.Focus();
		return;
	}

	DS_IO_USER.ClearData();
	DS_IO_GROUP.DeleteMarked();

	var goTo       = "save";
	var action     = "I";

	TR_MAIN.Action="/pot/tcom103.tc?goTo="+goTo;
	TR_MAIN.KeyValue="SERVLET(" +action+":DS_IO_GROUP    =DS_IO_GROUP, "
								+action+":DS_IO_USER     =DS_IO_USER  )";
	TR_MAIN.Post();

	// 삭제 후 처리
	btn_Search();
	GD_GROUP.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

	// 저장할 데이터 없는 경우
	if (!DS_IO_USER.IsUpdated && !DS_IO_GROUP.IsUpdated ){
		//저장할 내용이 없습니다
		showMessage(INFORMATION, OK, "USER-1028");
		if(DS_IO_GROUP.CountRow < 1){
			LC_O_ORG_FLAG.Focus();
		}else{
			GD_GROUP.Focus();
		}
		return;
	}

	if(!checkValidation()) return;

	//변경또는 신규 내용을 저장하시겠습니까?
	if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
		GD_GROUP.Focus();
		return;
	}
	var groupVal = DS_IO_GROUP.NameValue(DS_IO_GROUP.RowPosition,"GROUP_CD");
	var userVal  = DS_IO_USER.NameValue(DS_IO_USER.RowPosition,"USER_ID");

	TR_MAIN.Action  ="/pot/tcom103.tc?goTo=save";
	TR_MAIN.KeyValue="SERVLET(I:DS_IO_GROUP=DS_IO_GROUP,I:DS_IO_USER=DS_IO_USER)";
	TR_MAIN.Post();

	// 저장 후 처리
	if(TR_MAIN.ErrorCode == 0){

		// 그룹 재조회
		showGroupList();

		if(groupVal != "" && groupVal != "undefiend")
			DS_IO_GROUP.RowPosition = DS_IO_GROUP.NameValueRow("GROUP_CD",groupVal);
		else
			DS_IO_GROUP.RowPosition = DS_IO_GROUP.CountRow;

		setFocusGrid(GD_GROUP, DS_IO_GROUP, DS_IO_GROUP.RowPosition, "GROUP_CD");

		// 사용자 재조회
		showUserList(groupVal);

		if(userVal != "" && userVal != "undefiend")
			DS_IO_USER.RowPosition = DS_IO_USER.NameValueRow("USER_ID",userVal);
		else
			DS_IO_USER.RowPosition = DS_IO_USER.CountRow;
	}

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-24
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {

}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * showGroupList()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-05-30
  * 개    요 : 그룹코드셋팅
  * return값 : void
  */
function showGroupList() {

	var goTo       = "selectGroupList" ;
	var action     = "O";

	TR_MAIN2.Action="/pot/tcom103.tc?goTo="+goTo;
	TR_MAIN2.KeyValue="SERVLET("+action+":DS_IO_GROUP=DS_IO_GROUP)"; //조회는 O
	TR_MAIN2.Post();

	newMasterYn = false;
	// 조회결과 Return
	setPorcCount("SELECT", DS_IO_GROUP.CountRow);

	setGroupGrid();
}
/**
 * showUserCd()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-05-30
 * 개    요 : 그룹코드셋팅
 * return값 : void
 */
function showUserList() {

	var strBindStrCd    = LC_O_STR_CD.BindColVal;      // 점
	var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;    // 조직
	var strBindUseYn    = LC_O_USE_YN.BindColVal;      // 사용여부
	var strBindDeptCd   = LC_O_DEPT_CD.BindColVal;     // 팀
	var strBindTeamCd   = LC_O_TEAM_CD.BindColVal;     // 파트
	var strBindPcCd     = LC_O_PC_CD.BindColVal;       // PC
	var strGroupCd      = arguments[0] ==undefined ? DS_IO_GROUP.NameValue(DS_IO_GROUP.rowposition,"GROUP_CD"): arguments[0] ;  // 그룹
		strGroupCd      = strGroupCd =="998" ? "" : strGroupCd      ;
	var strBindUserCd   = EM_USER_NAME.text;

	var goTo       = "selectUserList" ;
	var action     = "O";
	var parameters = "&strStrCd="  +encodeURIComponent(strBindStrCd)
					+ "&strOrgFlag="+encodeURIComponent(strBindOrgFlag)
					+ "&strUseYn="  +encodeURIComponent(strBindUseYn)
					+ "&strDeptCd=" +encodeURIComponent(strBindDeptCd)
					+ "&strTeamCd=" +encodeURIComponent(strBindTeamCd)
					+ "&strPcCd="   +encodeURIComponent(strBindPcCd)
					+ "&strGroupCd="+encodeURIComponent(strGroupCd)
					+ "&strUserCd=" +encodeURIComponent(strBindUserCd) ;

	TR_MAIN.Action="/pot/tcom103.tc?goTo="+goTo+parameters;
	TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_USER=DS_IO_USER)"; //조회는 O
	TR_MAIN.Post();

	// 조회결과 Return
	setPorcCount("SELECT", DS_IO_USER.CountRow);
}


/**
 * btn_Add()
 * 작 성 자 :
 * 작 성 일 : 2010-09-08
 * 개    요 : 사용자 그리드 Row추가
 * return값 : void
 */
function btn_Add(){
	var vRow = DS_IO_GROUP.RowPosition;
	var vRowStatus = DS_IO_GROUP.RowStatus(vRow)
	var vGroupCd = DS_IO_GROUP.NameValue(vRow,"GROUP_CD");


	if(DS_IO_GROUP.CountRow > 0) {
		if(vRowStatus != "1") {
			DS_IO_USER.Addrow();
			DS_IO_USER.NameValue(DS_IO_USER.RowPosition,"CORNER_CD") = "00";
			DS_IO_USER.NameValue(DS_IO_USER.RowPosition,"USE_YN") = "T";
			setFocusGrid(GD_USER, DS_IO_USER, DS_IO_USER.CountRow,   "USER_ID");
		} else {
			showMessage(INFORMATION, OK, "USER-1000","그룹 생성 후 입력하십시요.");
		}
	}
}

/**
  * btn_Del1()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010-09-08
  * 개    요 : 광역 그리드 Row 삭제
  * return값 : void
*/
function btn_Del(){
	var vRow = DS_IO_USER.RowPosition;
	var vInputSys = DS_IO_USER.NameValue(vRow,"INPUT_SYS");
	var vRowStatus = DS_IO_USER.RowStatus(vRow)

	 //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
	if( vRowStatus == "1"){
		DS_IO_USER.DeleteRow(vRow);
	} else {
		if(vInputSys != "HAM") {
			DS_IO_USER.NameValue(vRow,"USE_YN") = "F";
		} else {
			showMessage(INFORMATION, OK, "USER-1000","해당사용자는 삭제 할 수 없습니다.");
		}
	}

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

	//Group
	dupRow = checkDupKey(DS_IO_GROUP,"GROUP_CD");  //그룹코드 체크
	if( dupRow > 0){
		showMessage(EXCLAMATION, OK, "USER-1044");
		setFocusGrid(GD_GROUP, DS_IO_GROUP, dupRow,"GROUP_CD");
		return false;
	}

	for(var i=1; i<=DS_IO_GROUP.CountRow; i++){

		objDS = DS_IO_GROUP;
		objGD = GD_GROUP;

		var rowStatus = DS_IO_GROUP.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;

		row = i;
		if( DS_IO_GROUP.NameValue(i,"GROUP_CD")=="" ){
			showMessage(EXCLAMATION, OK, "USER-1003", "그룹코드");
			errYn = true;
			colid = "GROUP_CD";

			break;
		}
		if( DS_IO_GROUP.NameValue(i,"GROUP_NAME")=="" ){
			showMessage(EXCLAMATION, OK, "USER-1003", "그룹명");
			errYn = true;
			colid = "GROUP_NAME";
			break;
		}

		if( (DS_IO_GROUP.NameValue(i,"GROUP_CD")).length != 3 ){
			showMessage(EXCLAMATION, OK, "USER-1027", "그룹코드", "3");
			errYn = true;
			colid = "GROUP_CD";
			break;
		}

		if( !checkInputByte( objGD, objDS, i, "GROUP_NAME", "그룹명", null,100)){
			errYn = true;
			colid = "GROUP_NAME";
			break;
		}
		
	}

	//User
	dupRow = checkDupKey(DS_IO_USER,"USER_ID");
	if( dupRow > 0){
		showMessage(EXCLAMATION, OK, "USER-1044");
		setFocusGrid(GD_USER, DS_IO_USER, dupRow,"USER_ID");
		return false;
	}

	for(var i=1; i<=DS_IO_USER.CountRow; i++){

		objDS = DS_IO_USER;
		objGD = GD_USER;

		var rowStatus = DS_IO_USER.RowStatus(i);
		if( !(rowStatus == "1" || rowStatus == "3") )
			continue;
		row = i;


		if( DS_IO_USER.NameValue(i,"USER_ID")=="" ){
			showMessage(EXCLAMATION, OK, "USER-1003", "사원번호");
			errYn = true;
			colid = "USER_ID";

			break;
		}
		if( DS_IO_USER.NameValue(i,"USER_NAME")=="" ){
			showMessage(EXCLAMATION, OK, "USER-1003", "사원명");
			errYn = true;
			colid = "USER_NAME";
			break;
		}


		if( !checkInputByte( objGD, objDS, i, "USER_NAME", "사원명","",20) ) return false;


		if ( DS_IO_USER.NameValue(i,"SUB_SYS") == "" )
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "시스템구분");
			errYn = true;
			colid = "SUB_SYS";

			break;
		}

		if ( DS_IO_USER.NameValue(i,"VIEW_LEVEL") == "" || DS_IO_USER.NameValue(i,"VIEW_LEVEL") == "%" )
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "뷰레벨");
			errYn = true;
			colid = "VIEW_LEVEL";

			break;
		}

		if ( DS_IO_USER.NameValue(i,"ORG_FLAG") == "" || DS_IO_USER.NameValue(i,"ORG_FLAG") == "%" )
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "조직");
			errYn = true;
			colid = "ORG_FLAG";

			break;
		}
		if ( DS_IO_USER.NameValue(i,"GROUP_CD") == "" || DS_IO_USER.NameValue(i,"GROUP_CD") == "999" )
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "그룹");
			errYn = true;
			colid = "GROUP_CD";

			break;
		}


		if ( DS_IO_USER.NameValue(i,"STR_CD") == "" || DS_IO_USER.NameValue(i,"STR_CD") == "%" )
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "점");
			errYn = true;
			colid = "STR_CD";

			break;
		}


		if ( ( DS_IO_USER.NameValue(i,"DEPT_CD") !="" && DS_IO_USER.NameValue(i,"DEPT_NAME") =="" )
				&& ( DS_IO_USER.NameValue(i,"DEPT_CD") =="" && DS_IO_USER.NameValue(i,"DEPT_NAME") !="" ))
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "팀코드");
			errYn = true;
			colid = "DEPT_CD";

			break;
		}

		if ( ( DS_IO_USER.NameValue(i,"TEAM_CD") !="" && DS_IO_USER.NameValue(i,"TEAM_NAME") =="" )
				&& ( DS_IO_USER.NameValue(i,"TEAM_CD") =="" && DS_IO_USER.NameValue(i,"TEAM_NAME") !="" ))
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "파트코드");
			errYn = true;
			colid = "TEAM_CD";

			break;
		}
		if ( ( DS_IO_USER.NameValue(i,"PC_CD") !="" && DS_IO_USER.NameValue(i,"PC_NAME") =="" )
				&& ( DS_IO_USER.NameValue(i,"PC_CD") =="" && DS_IO_USER.NameValue(i,"PC_NAME") !="" ))
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "PC코드");
			errYn = true;
			colid = "PC_CD";

			break;
		}

		if ( DS_IO_USER.NameValue(i,"VIEW_LEVEL") == "" || DS_IO_USER.NameValue(i,"VIEW_LEVEL") == "%" )
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "뷰레벨");
			errYn = true;
			colid = "VIEW_LEVEL";

			break;
		}
		
		/* 2016-01-03 아트몰링 비밀번호는 4자리 and 숫자형태만   */
		if(DS_IO_USER.NameValue(i,"PWD_NO").length != 4){
			showMessage(EXCLAMATION, OK, "USER-1000",  "비밀번호는 4자리입니다.");
			errYn = true;
			colid = "PWD_NO";
			break;
		}
		
		if(!isNumberStr(DS_IO_USER.NameValue(i,"PWD_NO"))){
			showMessage(EXCLAMATION, OK, "USER-1005",  "비밀번호");
			errYn = true;
			colid = "PWD_NO";
			break;
		}

	}

	if(errYn){
		setFocusGrid(objGD, objDS, row, colid);
		return false;
	}

	return true;

}

// 현재 행의데이터를 글로벌에 담아 사용
function getNowVal(row)
{
	strGlbOrgFlag  = DS_IO_USER.NameValue(row, "ORG_FLAG") == "" ? "" : DS_IO_USER.NameValue(row, "ORG_FLAG");   // 조직구분
	strGlbStrCd    = DS_IO_USER.NameValue(row, "STR_CD")   == "" ? "" : DS_IO_USER.NameValue(row, "STR_CD");     // 점코드
	strGlbDeptCd   = DS_IO_USER.NameValue(row, "DEPT_CD")  == "" ? "" : DS_IO_USER.NameValue(row, "DEPT_CD");    // 팀코드
	strGlbTeamCd   = DS_IO_USER.NameValue(row, "TEAM_CD")  == "" ? "" : DS_IO_USER.NameValue(row, "TEAM_CD");    // 파트코드
	strGlbPcCd     = DS_IO_USER.NameValue(row, "PC_CD")    == "" ? "" : DS_IO_USER.NameValue(row, "PC_CD");       // PC코드
}

//그리드 데이터 초기화
function clearGrid(objDS, row, gbn)
{
	if (gbn =="DEPT_CD")
	{
		objDS.NameValue(row,"TEAM_CD")  = "";
		objDS.NameValue(row,"TEAM_NAME")= "";
		objDS.NameValue(row,"PC_CD")    = "";
		objDS.NameValue(row,"PC_NAME")  = "";
	}
	if (gbn =="TEAM_CD")
	{
		objDS.NameValue(row,"PC_CD")    = "";
		objDS.NameValue(row,"PC_NAME")  = "";
	}
}

// 그리드 데이터적합성 체크
function popUpValid(colid)
{
	if (colid == "DEPT_CD")
	{
		if (strGlbOrgFlag == "" || strGlbStrCd == "")
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "조직구분 또는 점");
			return false;
		}
	}
	else if (colid == "TEAM_CD")
	{
		if (strGlbDeptCd == "")
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "팀코드");
			return false;
		}
	}
	else if (colid == "PC_CD")
	{
		if (strGlbTeamCd == "")
		{
			showMessage(EXCLAMATION, OK, "USER-1003", "파트코드");
			return false;
		}
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
<script language=JavaScript for=TR_MAIN2 event=onSuccess>
	for(i=0;i<TR_MAIN2.SrvErrCount('UserMsg');i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN2.SrvErrMsg('UserMsg',i));
	}
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_MAIN2 event=onFail>
	trFailed(TR_MAIN2.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_IO_GROUP event=OnLoadCompleted(rowcnt)>
	if(rowcnt > 0) {
		DS_IO_GROUP.RowPosition = bfGroupRowPosition;
	}
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- 사용자 정보 변경시 데이터 초기화 -->
<script language=JavaScript for=DS_IO_USER event=onColumnChanged(row,colid)>

	if (colid == 'ORG_FLAG' || colid == 'STR_CD'  )
	{
		DS_IO_USER.NameValue(row,"DEPT_CD")  = "";
		DS_IO_USER.NameValue(row,"DEPT_NAME")= "";
		DS_IO_USER.NameValue(row,"TEAM_CD")  = "";
		DS_IO_USER.NameValue(row,"TEAM_NAME")= "";
		DS_IO_USER.NameValue(row,"PC_CD")    = "";
		DS_IO_USER.NameValue(row,"PC_NAME")  = "";
	}

	// VOC처리시설 변경 시 하위 팀, 파트, PC초기화
	if (colid == "V_FCL_CD" )
	{
		DS_OG_VOC_DEPT_CD.Filter();
		DS_IO_USER.NameValue(row,"V_DEPT_CD")  = "";
		DS_IO_USER.NameValue(row,"V_TEAM_CD")  = "";
		DS_IO_USER.NameValue(row,"V_CHAR_CD1") = "";
		DS_IO_USER.NameValue(row,"V_CHAR_CD2") = "";
		DS_IO_USER.NameValue(row,"V_CHAR_CD3") = "";
	}

	// VOC팀 변경 시 하위  파트, PC초기화
	if (colid == "V_DEPT_CD")
	{
		DS_OG_VOC_TEAM_CD.Filter();
		DS_IO_USER.NameValue(row,"V_TEAM_CD")  = "";
		DS_IO_USER.NameValue(row,"V_CHAR_CD1") = "";
		DS_IO_USER.NameValue(row,"V_CHAR_CD2") = "";
		DS_IO_USER.NameValue(row,"V_CHAR_CD3") = "";
	}

	// VOC파트 변경 시 하위 PC초기화
	if (colid == "V_TEAM_CD")
	{
		DS_OG_CHAR_CD.Filter();
		DS_IO_USER.NameValue(row,"V_CHAR_CD1") = "";
		DS_IO_USER.NameValue(row,"V_CHAR_CD2") = "";
		DS_IO_USER.NameValue(row,"V_CHAR_CD3") = "";
	}
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_USER event=OnClick(row,colid)>
	if(row<1) sortColId(eval(this.DataID), row, colid);

	if (colid=="V_DEPT_CD")
	{
		if(DS_IO_USER.NameValue(row, "V_FCL_CD") =="")
			this.ColumnProp(colid,"Edit")   = "None";
		else
		{
			DS_OG_VOC_DEPT_CD.Filter();
			this.ColumnProp(colid,"Edit")="Any";
		}
	}
	else if (colid=="V_TEAM_CD")
	{
		if(DS_IO_USER.NameValue(row, "V_DEPT_CD") =="")
			this.ColumnProp(colid,"Edit")   = "None";
		else
		{
			DS_OG_VOC_TEAM_CD.Filter();
			this.ColumnProp(colid,"Edit")="Any";
		}
	}
	else if (colid=="V_CHAR_CD1" || colid=="V_CHAR_CD2" || colid=="V_CHAR_CD3")
	{
		if(DS_IO_USER.NameValue(row, "V_TEAM_CD") =="")
			this.ColumnProp(colid,"Edit")   = "None";
		else
		{
			DS_OG_CHAR_CD.Filter();
			this.ColumnProp(colid,"Edit")="Any";
		}
	}
</script>

<!-- Grid : VOC처리시설 선택 -> VOC처리팀 데이터 셋팅-->
<script language=JavaScript for=DS_OG_VOC_DEPT_CD event=OnFilter(row)>

	var value = DS_IO_USER.NameValue(DS_IO_USER.rowposition, "V_FCL_CD");

	if( value != (this.NameValue(row,"CODE")).substring(0,1)  && "" != (this.NameValue(row,"CODE")).substring(0,1)  )
		 return false;

	return true;
</script>

<!-- Grid : VOC처리팀  선택 -> VOC처리파트데이터 셋팅-->
<script language=JavaScript for=DS_OG_VOC_TEAM_CD event=OnFilter(row)>

	var value = DS_IO_USER.NameValue(DS_IO_USER.rowposition, "V_DEPT_CD");

	if( value != (this.NameValue(row,"CODE")).substring(0,2)  && "" != (this.NameValue(row,"CODE")).substring(0,2)  )
		 return false;

	return true;
</script>

<!-- Grid : VOC처리파트 선택 -> VOC처리PC데이터 셋팅-->
<script language=JavaScript for=DS_OG_CHAR_CD event=OnFilter(row)>

	var value = DS_IO_USER.NameValue(DS_IO_USER.rowposition, "V_TEAM_CD");

	if( value != (this.NameValue(row,"CODE")).substring(0,4)  && "" != (this.NameValue(row,"CODE")).substring(0,4)  )
		 return false;

	return true;
</script>




<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_GROUP event=OnClick(row,colid)>
	if( row < 1) {
		sortColId( eval(this.DataID), row , colid );
	} else {
		if( bfGroupRowPosition == row ) return;
		
		if( DS_IO_USER.IsUpdated || DS_IO_GROUP.IsUpdated)
		{
			if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )
			{
				DS_IO_GROUP.RowPosition = bfGroupRowPosition ;
				return;
			}
		}
		DS_IO_GROUP.UndoAll();
		
		bfGroupRowPosition = row;

		newMasterYn = false;
		showUserList(DS_IO_GROUP.NameValue(row, "GROUP_CD"));
	}
</script>
<!-- Grid GROUP 상하키 event 처리 -->
<script language=JavaScript for=GD_GROUP event=onKeyPress(keycode)>
	if ((keycode == 38) || (keycode == 40) || (keycode == 255 && GD_GROUP.GetColumn() =="GROUP_NAME" && DS_IO_GROUP.NameValue(DS_IO_GROUP.RowPosition, "GROUP_NAME") != "" )
	)
	{
		if (DS_IO_GROUP.RowPosition > 0 ){
			bfGroupRowPosition = DS_IO_GROUP.RowPosition;
			newMasterYn = false;
			showUserList(DS_IO_GROUP.NameValue(DS_IO_GROUP.RowPosition, "GROUP_CD"));
		}
	}
</script>

<script language=JavaScript for=GD_USER event=OnDblClick(row,colid)>
	//sbcho 왜 존재하는지 모름.
	//alert("'" + DS_IO_USER.OrgNameValue(row,"PWD_NO_ORG") +"'");
</script>

<script language=JavaScript for=GD_USER event=OnPopup(row,colid,data)>
	// 팀, 파트, PC 그리드 팝업
	var popupData  = "";

	// 현재 행의데이터를 글로벌에 담아 사용
	getNowVal(row);

	// 그리드 데이터적합성 체크
	if (!popUpValid(colid, row)) return;

	if (colid == "DEPT_CD")
		popupData = orgMstToGridPop( data, '', '', colid, strGlbOrgFlag, strGlbStrCd, strGlbDeptCd, '', '', 'Y', '');
	else if (colid == "TEAM_CD")
		popupData = orgMstToGridPop( data, '', '', colid, strGlbOrgFlag, strGlbStrCd, strGlbDeptCd, strGlbTeamCd, '', 'Y', '');
	else if (colid == "PC_CD")
		popupData = orgMstToGridPop( data, '', '', colid, strGlbOrgFlag, strGlbStrCd, strGlbDeptCd, strGlbTeamCd, strGlbTeamCd, 'Y', '');

	var colCd = colid.split("_");

	if (popupData==null)
	{
		// 리턴값이 없을경우 CLEAR ALL
		eval(this.DataID).NameValue(row,colid)              = "";
		eval(this.DataID).NameValue(row,colCd[0]+"_NAME")   = "";
	}
	else
	{
		eval(this.DataID).NameValue(row,colid)              = popupData.get("CODE");
		eval(this.DataID).NameValue(row,colCd[0]+"_NAME")   = popupData.get("NAME");
	}
	// 조직 /점 -> 팀 -> 파트 -> PC 순이므로 팀 값이 없을경우 나머지 파트/PC클리어
	clearGrid(eval(this.DataID), row, colid);

</script>


<script language=JavaScript for=GD_USER event=OnExit(row,colid,oldData)>
	if (colid == "DEPT_CD" || colid == "TEAM_CD" || colid == "PC_CD")
	{
		var orgValue = DS_IO_USER.OrgNameValue(row,colid);
		var newValue = DS_IO_USER.NameValue(row,colid);

		var changeFlag = oldData != newValue  ;

		var colCd = colid.split("_");

		var popupData ;

		if (changeFlag)
		{
			// 파라메터 값을 조회한다
			getNowVal(row);

			// 그리드 데이터적합성 체크
			if (!popUpValid(colid, row))
			{
				DS_IO_USER.NameValue(row,colCd) = "";
				return;
			}

			// 이름을 클리어 한다.
			DS_IO_USER.NameValue(row,colCd[0]+"_NAME") = "";

			// 코드가 비어있을 경우 무시
			if(newValue == '')
			{
				clearGrid(DS_IO_USER, row, colid);
				return true;
			}


			// 이름을 가져온다.없을시 팝업 실행 (popup_dps.js)
			switch(colid)
			{
				case 'DEPT_CD':
					popupData = orgMstWithoutToGridPop('DS_GRID_NM', newValue, colid, '1', strGlbOrgFlag, strGlbStrCd, strGlbDeptCd, '', '', 'Y', '');
				break;

				case 'TEAM_CD':
				   popupData = orgMstWithoutToGridPop('DS_GRID_NM', newValue, colid, '1', strGlbOrgFlag, strGlbStrCd, strGlbDeptCd, strGlbTeamCd, '', 'Y', '');
				break;

				case 'PC_CD':
					popupData = orgMstWithoutToGridPop('DS_GRID_NM', newValue, colid, '1', strGlbOrgFlag, strGlbStrCd, strGlbDeptCd, strGlbTeamCd, strGlbPcCd, 'Y', '');
				break;
			}

			if(popupData != null)
			{
				// 팝업에서 값을 선택하거나 명이 존재할 시 값을 입력한다.
				DS_IO_USER.NameValue(row,colid)             = popupData.get("CODE");
				DS_IO_USER.NameValue(row,colCd[0]+"_NAME")  = popupData.get("NAME");
			}
			else
			{
				// 값이 존재하지 않거나 아무것도 선택하지 않을시 클리어
				DS_IO_USER.NameValue(row,colid)              = "";
				DS_IO_USER.NameValue(row,colCd[0]+"_NAME")   = "";

				setTimeout("setFocusGrid(GD_USER, DS_IO_USER,"+row+",'"+colid+"');",50);
			}

			// 조직 /점 -> 팀 -> 파트 -> PC 순이므로 팀 값이 없을경우 나머지 파트/PC클리어
			clearGrid(DS_IO_USER, row, colid);
			return true;
		}
	}

	if(colid == "E_MAIL") {

		var orgValue = DS_IO_USER.OrgNameValue(row,colid);
		var newValue = DS_IO_USER.NameValue(row,colid);

		var changeFlag = oldData != newValue  ;

		if(newValue == "")
			return;

		if (changeFlag)
		{

			if(!isValidStrEmail(newValue)){
				showMessage(EXCLAMATION, OK, "USER-1004", "이메일");
				DS_IO_USER.NameValue(row,colid) = "";
				setTimeout("setFocusGrid(GD_USER, DS_IO_USER,"+row+",'"+colid+"');",50);
			}
		}
	}



</script>

<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange>
	DS_O_DEPT_CD.ClearData();
	DS_O_TEAM_CD.ClearData();
	DS_O_PC_CD.ClearData();
	if (LC_O_STR_CD.BindColVal == '%'){
		insComboData(LC_O_DEPT_CD, "%", "전체", 1);
		setComboData(LC_O_DEPT_CD, "%");
		return;
	}

	getDept("DS_O_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "", LC_O_ORG_FLAG.BindColVal);
	if(DS_O_DEPT_CD.CountRow < 1){
		insComboData(LC_O_DEPT_CD, "%", "전체", 1);
	}
	LC_O_DEPT_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
	DS_O_DEPT_CD.ClearData();
	DS_O_TEAM_CD.ClearData();
	DS_O_PC_CD.ClearData();
	if (this.BindColVal == '%'){
		insComboData(LC_O_DEPT_CD, "%", "전체", 1);
		setComboData(LC_O_DEPT_CD, "%");
		return;
	}

	getDept("DS_O_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "", LC_O_ORG_FLAG.BindColVal);
	if(DS_O_DEPT_CD.CountRow < 1) {
		insComboData(LC_O_DEPT_CD, "%", "전체", 1);
	}
	LC_O_DEPT_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
	DS_O_TEAM_CD.ClearData();
	DS_O_PC_CD.ClearData();
	if (this.BindColVal == '%'){
		insComboData(LC_O_TEAM_CD, "%", "전체", 1);
		setComboData(LC_O_TEAM_CD, "%");
		return;
	}

	getTeam("DS_O_TEAM_CD", "N", LC_O_STR_CD.BindColVal, LC_O_DEPT_CD.BindColVal, "Y", "", LC_O_ORG_FLAG.BindColVal);

	if(DS_O_TEAM_CD.CountRow < 1){
		insComboData(LC_O_TEAM_CD, "%", "전체", 1);
	}
	LC_O_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange>
	DS_O_PC_CD.ClearData();
	if (this.BindColVal == '%'){
		insComboData(LC_O_PC_CD, "%", "전체", 1);
		setComboData(LC_O_PC_CD, "%");
		return;
	}
	getPc("DS_O_PC_CD", "N", LC_O_STR_CD.BindColVal, LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y", "", LC_O_ORG_FLAG.BindColVal);

	if(DS_O_PC_CD.CountRow < 1){
		insComboData(LC_O_PC_CD, "%", "전체", 1);
	}
	LC_O_PC_CD.Index = 0;
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
<comment id="_NSID_"><object id="DS_O_STR_CD" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORG_FLAG"	 	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_USE_YN" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT_CD" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM_CD" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC_CD" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 그리드용 -->
<comment id="_NSID_"><object id="DS_OG_GROUP"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_STR_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_ORG_FLAG"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_USE_YN"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_DEPT_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_TEAM_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_PC_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_GROUOP_CD"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_SUB_SYS"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_VIEW_LEVEL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_FCL_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_EMP_GRADE"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_VOC_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_VOC_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_OG_CHAR_CD"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GRID_NM"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_GROUP" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_USER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_FLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_MAIN2" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_GROUP");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GD_USER");
    
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
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
						<th width="80" >조직구분</th>
						<td width="165"><comment id="_NSID_"> <object id=LC_O_ORG_FLAG
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">점</th>
						<td width="165"><comment id="_NSID_"> <object id=LC_O_STR_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">팀</th>
						<td><comment id="_NSID_"> <object id=LC_O_DEPT_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>파트</th>
						<td><comment id="_NSID_"> <object id=LC_O_TEAM_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">PC</th>
						<td><comment id="_NSID_"> <object id=LC_O_PC_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						<th width="80">사용여부</th>
						<td><comment id="_NSID_"> <object id=LC_O_USE_YN
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="70">성명/사용자ID</th>
						<TD width="120">
							<comment id="_NSID_">
								<object id=EM_USER_NAME classid=<%=Util.CLSID_EMEDIT%> width=165></object>
							</comment>
							<script> _ws_(_NSID_);</script>
						</TD>
						<td colspan=4><B>캐셔아이디 생성시 YYYYMM000 뒷자리3자리 시퀀스번호를 900번대로 생성해주세요   예)201310901          000번대일경우 더존아이디와 겹침</B></td>
						</TR>
				</TABLE>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot" ></td>
	</tr>
	<tr>
		<td class="PB03 PL03" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
			<tr>
				<TD width="180">
					<table border="0" width="100%" cellspacing="0" cellpadding="0" class="BD4A" >
						<tr><td>
						<!-- 그룹 -->
							<comment id="_NSID_"><OBJECT id=GD_GROUP width="100%" height="455" classid=<%=Util.CLSID_GRID%>>
								<param name="DataID" value="DS_IO_GROUP">
							</OBJECT></comment><script>_ws_(_NSID_);</script>
						</td></tr>
					</table>
				</TD>
				<TD class="PL10" valign="top">

					<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
						<tr>
							<td class="right PB02" valign="bottom">
								<img src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18" onclick="javascript:btn_Add();" hspace="2" />
								<img src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="javascript:btn_Del();" />
							</td>
						</tr>

						<tr>
							<td width="100%" align=center  >
								<!-- 프로그램 -->
								<table cellpadding="0" border="0" cellspacing="0" class="BD4A"  width="100%">
									<tr>
										<td>
										<!-- 디테일 -->
											<comment id="_NSID_"><OBJECT id=GD_USER width=100% height="440" classid=<%=Util.CLSID_GRID%>>
												<param name=DataID   value="DS_IO_USER">
											</OBJECT></comment><script>_ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</TD>
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
