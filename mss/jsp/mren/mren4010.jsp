<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 관리비청구/입금관리 >관리비청구서관리
 * 작 성 일 : 2010.05.16
 * 작 성 자 : 김유완
 * 수 정 자 : 
 * 파 일 명 : MREN401.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 관리비청구서를 조회/출력한다
 * 이    력 : 2010.05.16 (김유완) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                    *-->
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
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                 *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
	/*************************************************************************
	 * 0. 전역변수
	 *************************************************************************/
	var g_autoFlag = false;
	/*************************************************************************
	 * 1. 초기설정
	 *************************************************************************/
	/**
	 * doInit()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 해당 페이지 LOAD 시  
	 * return값 : void
	 */
	var top = 165;		//해당화면의 동적그리드top위치
	var g_strPid           = "<%=pageName%>";                 // PID

	function doInit() {
		
		//Master 그리드 세로크기자동조정  2013-07-17
		 var obj   = document.getElementById("GD_MASTER"); 
		obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

		// 입력 Data Set Header 초기화
		DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CALMST"/>');
		DS_CHECKMASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CALMST"/>');
		DS_I_PARAMATER.setDataHeader('<gauce:dataset name="H_PARAMATER"/>');

		DS_PRINT.setDataHeader('<gauce:dataset name="H_PRINT"/>');

		//그리드 초기화
		gridCreate();

		// EMedit에 초기화
		initComboStyle(LC_S_STR_CD, DS_STR_CD, "CODE^0^30,NAME^0^100", 1, PK); // [조회용]시설구분
		initEmEdit(EM_S_CAL_YM, "YYYYMM", PK); // [조회용]부과년월
		initEmEdit(EM_S_VEN_CD, "NUMBER3^6^0", NORMAL); // [조회용]협력사
		initEmEdit(EM_S_VEN_NM, "GEN", READ); // [조회용]협력사명
		initComboStyle(LC_S_RENT_TYPE, DS_RENT_TYPE, "CODE^0^30,NAME^0^100", 1,
				NORMAL); // [조회용]임대형태

		initComboStyle(LC_STR_CD, DS_STR_CD, "CODE^0^30,NAME^0^100", 1, PK); // 시설구분
		initEmEdit(EM_CAL_YM, "YYYYMM", PK); // 부과년월

		//콤보 초기화
		getFlc("DS_STR_CD", "M", "1", "Y", "N"); // [조회용]시설구분  
		getEtcCode("DS_RENT_TYPE", "D", "P003", "Y"); // [조회용]임대형태  
		LC_S_STR_CD.Focus();
		EM_S_CAL_YM.Text = getTodayFormat("YYYYMM");
		EM_CAL_YM.Text = getTodayFormat("YYYYMM");

		//등록 비활성화

		//종료시 데이터 변경 체크 (common.js )
		registerUsingDataset("mren401", "DS_O_MASTER");

		LC_S_STR_CD.Index = 0;
		LC_STR_CD.BindColVal = LC_S_STR_CD.BindColVal;
		objectControlDefault(false);

	}

	/**
	 * gridCreate("대상그리드")
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 그리드SET
	 * return값 : void
	 */
	function gridCreate() {
		var hdrProperies = ''
				+ '<FC>ID={CURROW}          NAME=NO'
				+ '                                         WIDTH=30    ALIGN=CENTER EDIT=NONE</FC>'
				+ '<FC>ID=CHECK1            NAME=선택'
				+ '                                         width=45    align=center EditStyle=CheckBox  HeadCheckShow="true"</FC>'
				+ '<FC>ID=STR_CD            NAME=점코드'
				+ '                                         WIDTH=70    ALIGN=CENTER EDIT=NONE SHOW="FALSE"</FC>'
				+ '<FC>ID=VEN_CD            NAME=협력사코드'
				+ '                                         WIDTH=70    ALIGN=CENTER EDIT=NONE</FC>'
				+ '<FC>ID=VEN_NM            NAME=협력사명'
				+ '                                         WIDTH=190   ALIGN=LEFT SUMTEXT="합계" EDIT=NONE</FC>'
				+ '<FC>ID=CNTR_ID           NAME=계약ID'
				+ '                                         WIDTH=190   ALIGN=LEFT SHOW="FALSE" EDIT=NONE</FC>'
				+ '<FC>ID=RENT_TYPE         NAME=임대형태'
				+ '                                         WIDTH=90    ALIGN=LEFT  EDITSTYLE=LOOKUP   DATA="DS_RENT_TYPE:CODE:NAME" EDIT=NONE</FC>'
				+ '<FC>ID=CAL_YM            NAME=부과년월'
				+ '                                         WIDTH=80    ALIGN=LEFT  EDIT=NONE SHOW="FALSE"</FC>'
				+ '<FC>ID=RENT_AMT          NAME=임대료(VAT포함)'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE  show=false   </FC>'
				+ '<FC>ID=RENT_SUPPLY_AMT   NAME=임대료공급가(VAT제외)'
				+ '                                         WIDTH=150   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE  show=false   </FC>'
				+ '<FC>ID=RENT_VAT_AMT      NAME=임대료VAT'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE  show=false   </FC>'
				+ '<FC>ID=RENT_BAL_AMT      NAME=미수임대료'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE  show=false   </FC>'
				+ '<FC>ID=MOD_RENT_ARREAR_AMT   NAME=미수임대료연체료'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE  show=false   </FC>'
				+ '<FC>ID=MOD_RENT_TOT_BAL_AMT  NAME=미수임대료합계'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE  show=false   </FC>'
				+ '<FC>ID=TAX_SUPPLY_AMT    NAME=과세관리비공급가(VAT제외)'
				+ '                                         WIDTH=160   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=TAX_VAT_AMT       NAME=과세액VAT'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=TAX_AMT           NAME=과세관리비(VAT포함)'
				+ '                                         WIDTH=130   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=NTAX_AMT          NAME=면세관리비'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=BAL_AMT           NAME=미수관리비'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=ARREAR_AMT        NAME=미수관리비연체료'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=TOT_BAL_AMT       NAME=미수관리비합계'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=MOD_AMT           NAME=조정금액'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=REAL_CHAREG_AMT   NAME=관리비실청구액'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT=@SUM EDIT=NONE</FC>'
				+ '<FC>ID=CNTR_AREA         NAME=계약면적'
				+ '                                         WIDTH=100   ALIGN=RIGHT SUMTEXT="" EDIT=NONE</FC>'
				+ '<FC>ID=MNTN_CAL_YN       NAME=관리비계산여부'
				+ '                                         WIDTH=100   ALIGN=CENTER SUMTEXT="" EDIT=NONE</FC>'
				+ '<FC>ID=RENT_CAL_YN       NAME=임대료계산여부'
				+ '                                         WIDTH=100   ALIGN=CENTER SUMTEXT="" EDIT=NONE   show=false   </FC>'
				+ '<FC>ID=CHRG_YN           NAME=청구내역생성여부'
				+ '                                         WIDTH=100   ALIGN=CENTER SUMTEXT="" EDIT=NONE</FC>'
				+ '<FC>ID=CNTR_S_DT         NAME=계약시작일'
				+ '                                         WIDTH=80   ALIGN=CENTER SUMTEXT="" EDIT=NONE MASK="XXXX/XX/XX"</FC>'
				+ '<FC>ID=CNTR_E_DT         NAME=계약종료일'
				+ '                                         WIDTH=80   ALIGN=CENTER SUMTEXT="" EDIT=NONE MASK="XXXX/XX/XX"</FC>'
				+ '<FC>ID=MNTN_CAL_DT       NAME=관리비산출일수'
				+ '                                         WIDTH=100   ALIGN=CENTER SUMTEXT="" EDIT=NONE   </FC>'
				+ '<FC>ID=RENT_CAL_DT       NAME=임대료산출일수'
				+ '                                         WIDTH=100   ALIGN=CENTER SUMTEXT="" EDIT=NONE   show=false   </FC>';
		initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
		GD_MASTER.ViewSummary = "1";
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
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 조회시 호출
	 * return값 : void
	 */
	function btn_Search() {
		/*
		 if (DS_O_MASTER.IsUpdated) {//변경데이터 있을 시 확인
		    var ret = showMessage(Question, YesNo, "USER-1059");
		    if (ret == "1") {
		        if (!checkValidateSearch()) return;
		        //입금등록관련 정산마감 관련 내역 초기화
		        DS_O_MASTER.ClearData();
		        objectControlDefault(false);
		        
		        // parameters
		        var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
		        var strCalYM    = EM_S_CAL_YM.Text;             // 부과년월
		        var strRentType = LC_S_RENT_TYPE.BindColVal;    // 임대형태
		        var strVenCd    = EM_S_VEN_CD.Text;             // 계약ID
		        
		        var goTo = "getMaster";
		        var parameters = ""
		            + "&strStrCd="      + encodeURIComponent(strStrCd)
		            + "&strCalYM="      + encodeURIComponent(strCalYM)
		            + "&strRentType="   + encodeURIComponent(strRentType)
		            + "&strVenCd="      + encodeURIComponent(strVenCd);
		        TR_MAIN.Action = "/mss/mren401.mr?goTo=" + goTo + parameters;
		        TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
		        TR_MAIN.Post();
		        
		        // 조회결과 Return
		        setPorcCount("SELECT", DS_O_MASTER.RealCount(1,DS_O_MASTER.CountRow) );
		        GD_MASTER.Focus();
		    } else {
		        return;
		    }
		}  else {
		    if (!checkValidateSearch()) return;
		    //입금등록관련 정산마감 관련 내역 초기화
		    DS_O_MASTER.ClearData();
		    objectControlDefault(false);
		    
		    // parameters
		    var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
		    var strCalYM    = EM_S_CAL_YM.Text;             // 부과년월
		    var strRentType = LC_S_RENT_TYPE.BindColVal;    // 임대형태
		    var strVenCd    = EM_S_VEN_CD.Text;             // 계약ID
		    
		    var goTo = "getMaster";
		    var parameters = ""
		        + "&strStrCd="      + encodeURIComponent(strStrCd)
		        + "&strCalYM="      + encodeURIComponent(strCalYM)
		        + "&strRentType="   + encodeURIComponent(strRentType)
		        + "&strVenCd="      + encodeURIComponent(strVenCd);
		    TR_MAIN.Action = "/mss/mren401.mr?goTo=" + goTo + parameters;
		    TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
		    TR_MAIN.Post();
		    
		    // 조회결과 Return
		    setPorcCount("SELECT", DS_O_MASTER.RealCount(1,DS_O_MASTER.CountRow) );
		    GD_MASTER.Focus();
		}*/

		if (!checkValidateSearch())
			return;

		searchMaster();
	}

	/**
	 * btn_New()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 초기화
	 * return값 : void
	 */
	function btn_New() {
	}

	/**
	 * btn_Delete()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : Grid 레코드 삭제
	 * return값 : void
	 */
	function btn_Delete() {
	}

	/**
	 * btn_Save()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : DB에 저장 / 수정 / 삭제 처리
	 * return값 : void
	 */
	function btn_Save() {
	}

	/**
	 * btn_Excel()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 엑셀로 다운로드
	 * return값 : void
	 */
	function btn_Excel() {
		if (DS_O_MASTER.CountRow > 0) {
			var ExcelTitle = "관리비청구서관리"

			var excel_strcd = LC_S_STR_CD.BindColVal; // [조회용]시설구분
			var excel_sGoal = EM_S_CAL_YM.Text; // [조회용]부가년월FROM
			var excel_venCd = EM_S_VEN_NM.Text; // [조회용]협력사명
			var excel_rentTp = LC_S_RENT_TYPE.BindColVal;// [조회용]임대형태

			var parameters = "시설구분=" + excel_strcd + " - 부과년월=" + excel_sGoal
					+ " - 협력사=" + excel_venCd + " - 임대형태=" + excel_rentTp;

			//openExcel2(GD_MASTER, ExcelTitle, parameters, true);
			openExcel5(GD_MASTER, ExcelTitle, parameters, true, "",g_strPid );

			GD_MASTER.Focus();
		} else {
			showMessage(INFORMATION, OK, "USER-1000", "조회 후 가능합니다.");
		}
	}

	/**
	 * btn_Print()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 출력
	 * return값 : void
	 */
	function btn_Print() {
		// 변경된 내역 존재
		if (!DS_O_MASTER.Isupdated) {
			showMessage(EXCLAMATION, OK, "USER-1000", "반드시 선택 후 출력하십시오.");
			return;
		}

		var strStr2 = "str";
		// 선택된 데이터셋 Copy(DS_CHECKMASTER)
		setMasterDs();

		var goTo = "getPrintList";
		var strVenCd = "";
		var strCntrId = "";

		for (var nRow = 1; nRow <= DS_CHECKMASTER.CountRow; nRow++) {

			strCntrId = DS_CHECKMASTER.NameValue(nRow, "CNTR_ID");
			strVenCd = DS_CHECKMASTER.NameValue(nRow, "VEN_CD");
			strCalYm = DS_CHECKMASTER.NameValue(nRow, "CAL_YM");

			var parameters = "&strCntrId=" + encodeURIComponent(strCntrId)
					+ "&strVenCd=" + encodeURIComponent(strVenCd)
					+ "&strCalYm=" + encodeURIComponent(strCalYm);
			TR_PRINT.Action = "/mss/mren401.mr?goTo=" + goTo + parameters;
			TR_PRINT.KeyValue = "SERVLET(O:DS_PRINT=DS_PRINT)"; //조회는 O
			TR_PRINT.Post();

			outPrint(nRow);
		}

	}
	/**
	 * outPrint()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010-04-26
	 * 개    요 : 페이지 프린트 인쇄
	 * return값 : void
	 */
	function outPrint(nRow) {

		var strVenNm = DS_CHECKMASTER.NameValue(nRow, "VEN_NM");
		var strRepName = DS_CHECKMASTER.NameValue(nRow, "REP_NAME");
		var strCompNo = DS_CHECKMASTER.NameValue(nRow, "COMP_NO");
		var strCntrArea = DS_CHECKMASTER.NameValue(nRow, "CNTR_AREA");
		var strBalAmt = DS_CHECKMASTER.NameValue(nRow, "BAL_AMT");
		var strArrearAmt = DS_CHECKMASTER.NameValue(nRow, "ARREAR_AMT");
		var strModAmt = DS_CHECKMASTER.NameValue(nRow, "MOD_AMT");
		var strRealCharegAmt = DS_CHECKMASTER.NameValue(nRow, "REAL_CHAREG_AMT");
		var strCalYm = DS_CHECKMASTER.NameValue(nRow, "CAL_YM");

		strBalAmt = comma(strBalAmt);
		strArrearAmt = comma(strArrearAmt);
		strRealCharegAmt = comma(strRealCharegAmt);

		var strCalYm1 = strCalYm.substring(0, 4);
		var strCalYm2 = strCalYm.substring(4, 6);
		var strCompNoD = strCompNo.substring(0, 3) + '-'
				+ strCompNo.substring(3, 5) + '-' + strCompNo.substring(5, 10);

		var PR_format = "";
		

		var strBANK        = DS_CHECKMASTER.NameValue(nRow, "BANK");
		var strACCOUNT_NUM = DS_CHECKMASTER.NameValue(nRow, "ACCOUNT_NUM");
		var strACCOUNT_HDR = DS_CHECKMASTER.NameValue(nRow, "ACCOUNT_HDR");
		var strPAY_TERM_DD = DS_CHECKMASTER.NameValue(nRow, "PAY_TERM_DD");
		var strPAY_TERM_DD = strPAY_TERM_DD.substring(0, 4) + '년 '+ strPAY_TERM_DD.substring(4, 6) + '월 ' +strPAY_TERM_DD.substring(6, 8) + '일';
				
		

		// 헤더 시작
		PR_format += "<B>id=Header,                       left=0,     top=0,     right=2100,    bottom=365,  face='Tahoma', size=10, penwidth=1 ";
		PR_format += "  <T>id='"
				+ strCalYm1
				+ "년"
				+ strCalYm2
				+ "월 관리비 청구서',    left=500,      top=0,       right=1500,    bottom=120,           face='Tahoma',   size=20,         bold=true,    align='center',    underline=false,   italic=false,forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='부과대상',                 left=300,   top=185,   right=450,     bottom=305,  face='Tahoma', size=10, bold=true,   align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='협력사',                   left=450,   top=185,   right=750,     bottom=245,  face='Tahoma', size=10, bold=true,   align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='사업자등록번호',           left=450,   top=245,   right=750,     bottom=305,  face='Tahoma', size=10, bold=true,   align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='"
				+ strVenNm
				+ "',             left=750,   top=185,   right=1100,    bottom=245,  face='Tahoma', size=10, bold=false,  align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='"
				+ strCompNoD
				+ "',           left=750,   top=245,   right=1100,    bottom=305,  face='Tahoma', size=10, bold=false,  align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='대표자',                   left=1100,  top=185,   right=1400,    bottom=245,  face='Tahoma', size=10, bold=true,   align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='계약면적',                 left=1100,  top=245,   right=1400,    bottom=305,  face='Tahoma', size=10, bold=true,   align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='"
				+ strRepName
				+ "',           left=1400,  top=185,   right=1700,    bottom=245,  face='Tahoma', size=10, bold=false,  align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "  <T>id='"
				+ strCntrArea
				+ "',          left=1400,  top=245,   right=1700,    bottom=305,  face='Tahoma', size=10, bold=false,  align='center',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "</B>";
		// 헤더 종료

		// 반복구간 시작
		PR_format += "<A>id=Area2,                        left=0,    top=0,    right=0,  bottom=0,  RecCount=17";
		PR_format += "   <R>id='전표출력',                left=0,    top=0,    right=0,  bottom=2970,  DetailDataID='DS_PRINT', MasterDataID='DS_PRINT', SuppressColumns='1:MNTN_TYPE_NM'";

		// 디테일 그리드 시작
		PR_format += "<B>id=DHeader,                      left=0,     top=0,    right=2100,  bottom=60,     face='Arial',  size=10, penwidth=1 ";
		PR_format += "    <X>                             left=300,   top=0,    right=1700,  bottom=60,     backcolor=#C0C0C0, border=true, penstyle=solid,     penwidth=1 </X> ";
		PR_format += "    <T>id='항목',                   left=300,   top=0,    right=1100,  bottom=60,     face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> ";
		PR_format += "    <T>id='금액',                   left=1100,  top=0,    right=1400,  bottom=60,     face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> ";
		PR_format += "    <T>id='부가세',                 left=1400,  top=0,    right=1700,  bottom=60,     face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0 </T> ";
		PR_format += "    <L>                             left=1100,  top=0,    right=1100,  bottom=60      </L> "; // |
		PR_format += "    <L>                             left=1400,  top=0,    right=1400,  bottom=60      </L> "; // |
		PR_format += "</B>";

		PR_format += "<B>id=default,                      left=0,    top=0,    right=2100,  bottom=60,   face='Arial', size=10, penwidth=1 ";
		PR_format += "    <X>                             left=300,  top=0,    right=1700,  bottom=0     </X> ";
		PR_format += "    <C>id='MNTN_TYPE_NM',           left=300,  top=0,    right=550,   bottom=60,   face='굴림',   size=10,  bold=true,  align='center',   underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, supplevel=1  </C> ";
		PR_format += "    <C>id='MNTN_ITEM_NM',           left=550,  top=0,    right=1100,  bottom=60,   face='굴림',   size=10,  bold=true,  align='left',     underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> ";
		PR_format += "    <C>id='USE_AMT_NOVAT',          left=1100, top=0,    right=1400,  bottom=60,   face='굴림',   size=9,   bold=false, align='right',    underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> ";
		PR_format += "    <C>id='VAT_AMT',                left=1400, top=0,    right=1700,  bottom=60,   face='굴림',   size=9,   bold=false, align='right',    underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> ";
		PR_format += "    <L>                             left=550,  top=0,    right=550,   bottom=60    </L> ";
		PR_format += "    <L>                             left=550,  top=60,   right=1700,  bottom=60    </L> ";
		PR_format += "    <L>                             left=1100, top=0,    right=1100,  bottom=60    </L> ";
		PR_format += "    <L>                             left=1400, top=0,    right=1400,  bottom=60    </L> ";
		PR_format += "    <L>                             left=300,  top=0,    right=300,   bottom=60    </L> ";
		PR_format += "    <L>                             left=1700, top=0,    right=1700,  bottom=60    </L> ";
		PR_format += "    <L>                             left=300,  top=0,    right=1700,  bottom=0,  supplevel=1   </L> ";
		PR_format += "</B>";

		PR_format += "    </R> ";

		// 디테일 그리드 합계
		PR_format += "<B>id=Tail,                          left=0,    top=150,  right=2100,  bottom=65,   face='Arial',  size=10, penwidth=1 ";
		PR_format += "    <X>                              left=300,  top=0,    right=1700,  bottom=60,   border=true    bold=false </X>";
		PR_format += "    <T>id='합계',                    left=300,  top=0,    right=550,   bottom=60,   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id=' ',                       left=550,  top=0,    right=1101,  bottom=60,   face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "    <T>id=' ',                       left=550,  top=0,    right=1101,  bottom=60,   face='Tahoma', size=9,  bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000 </T> ";
		PR_format += "    <C>id='{Sum(USE_AMT_NOVAT)}',    left=1100, top=0,    right=1400,  bottom=60,   face='굴림',   size=10, bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> ";
		PR_format += "    <C>id='{Sum(VAT_AMT)}',          left=1400, top=0,    right=1700,  bottom=60,   face='굴림',   size=10, bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </C> ";
		PR_format += "    <T>id='부과내역',                left=300,  top=90,   right=500,   bottom=150   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='전월미수금',              left=500,  top=90,   right=700,   bottom=150   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='"
				+ strBalAmt
				+ "',           left=700,  top=90,   right=1100,  bottom=150   face='굴림',   size=10, bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='연체이자',                left=1100, top=90,   right=1300,  bottom=150   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='"
				+ strArrearAmt
				+ "',     left=1300, top=90,   right=1700,  bottom=150   face='굴림',   size=10, bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='조정금액',                left=500,  top=150,  right=700,   bottom=210   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='"
				+ strModAmt
				+ "',           left=700,  top=150,  right=1700,  bottom=210   face='굴림',   size=10, bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='청구액',                  left=500,  top=210,  right=700,   bottom=270   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='"
				+ strRealCharegAmt
				+ "',    left=700,  top=210,  right=1700,  bottom=270   face='굴림',   size=10, bold=false, align='right',  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='입금계좌',                left=300,  top=300,  right=500,   bottom=360   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='은행명',                  left=500,  top=300,  right=700,   bottom=360   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='" + strBANK + "',         left=700,  top=300,  right=1100,  bottom=360   face='굴림',   size=10, bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='입금계좌',                left=1100, top=300,  right=1300,  bottom=360   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='" + strACCOUNT_NUM + "',  left=1300, top=300,  right=1700,  bottom=360   face='굴림',   size=10, bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='예금주',                  left=500,  top=360,  right=700,   bottom=420   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='" + strACCOUNT_HDR + "',  left=700,  top=360,  right=1100,  bottom=420   face='굴림',   size=10, bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='납부기한',                left=1100, top=360,  right=1300,  bottom=420   face='굴림',   size=10, bold=true,                  underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <T>id='" + strPAY_TERM_DD + "',  left=1300, top=360,  right=1700,  bottom=420   face='굴림',   size=10, bold=false,                 underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF  </T> ";
		PR_format += "    <L>                              left=1400, top=0,    right=1400,  bottom=60     </L> ";
		PR_format += "    <L>                              left=300,  top=90,   right=1700,  bottom=90     </L> ";
		PR_format += "    <L>                              left=300,  top=270,  right=1700,  bottom=270    </L> ";
		PR_format += "    <L>                              left=500,  top=360,  right=1700,  bottom=360    </L> ";
		PR_format += "    <L>                              left=500,  top=150,  right=1700,  bottom=150    </L> ";
		PR_format += "    <L>                              left=300,  top=420,  right=1700,  bottom=420    </L> ";
		PR_format += "    <L>                              left=500,  top=210,  right=1700,  bottom=210    </L> ";
		PR_format += "    <L>                              left=300,  top=300,  right=1700,  bottom=300    </L> ";
		PR_format += "    <L>                              left=300,  top=90,   right=300,   bottom=270    </L> ";
		PR_format += "    <L>                              left=1700, top=90,   right=1700,  bottom=270    </L> ";
		PR_format += "    <L>                              left=500,  top=90,   right=500,   bottom=270    </L> ";
		PR_format += "    <L>                              left=700,  top=90,   right=700,   bottom=270    </L> ";
		PR_format += "    <L>                              left=300,  top=300,  right=300,   bottom=420    </L> ";
		PR_format += "    <L>                              left=500,  top=300,  right=500,   bottom=420    </L> ";
		PR_format += "    <L>                              left=700,  top=300,  right=700,   bottom=420    </L> ";
		PR_format += "    <L>                              left=1700, top=300,  right=1700,  bottom=420    </L> ";
		PR_format += "    <L>                              left=1100, top=90,   right=1100,  bottom=150    </L> ";
		PR_format += "    <L>                              left=1300, top=90,   right=1300,  bottom=150    </L> ";
		PR_format += "    <L>                              left=1100, top=300,  right=1100,  bottom=420    </L> ";
		PR_format += "    <L>                              left=1300, top=300,  right=1300,  bottom=420    </L> ";

		PR_format += "</B>";

		// 하단 정보 종료
		PR_format += "    </R> ";

		PR_format += "</A> ";
		// 반복구간 종료

		// 하단 정보 시작
		//  PR_format += "<B>id=footer,                        left=0,    top=0,    right=2100,  bottom=2500, face='Tahoma', size=10, penwidth=1 " ;
		// PR_format += "</B>" ;

		PR_List.PaperSize = "A4"; // 용지크기 
		PR_List.LandScape = false; // 용지모양  
		PR_List.MasterDataID = "DS_PRINT"; // 사용데이타셋
		PR_List.DetailDataID = "DS_PRINT"; // 사용데이타셋       
		PR_List.PrintMargine = false; // 프린트 자체마진    
		PR_List.format = PR_format; // 레포트 포멧
		PR_List.PrintSetupDlgFlag = false; // 인쇄도구상자 
		PR_List.Preview(); // 미리보기
		//PR_List.Print();                       			// 바로출력
	}

	/*************************************************************************
	 * 3. 함수
	 *************************************************************************/
	/**
	 * searchMaster()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010-04-26
	 * 개    요 : 마스터 조회
	 * return값 : void
	 */
	function searchMaster() {
		//입금등록관련 정산마감 관련 내역 초기화
		DS_O_MASTER.ClearData();
		objectControlDefault(false);

		// parameters
		var strStrCd = LC_S_STR_CD.BindColVal; // 시설구분
		var strCalYM = EM_S_CAL_YM.Text; // 부과년월
		var strRentType = LC_S_RENT_TYPE.BindColVal; // 임대형태
		var strVenCd = EM_S_VEN_CD.Text; // 계약ID

		var goTo = "getMaster";
		var parameters = "" + "&strStrCd=" + encodeURIComponent(strStrCd)
				+ "&strCalYM=" + encodeURIComponent(strCalYM) + "&strRentType="
				+ encodeURIComponent(strRentType) + "&strVenCd="
				+ encodeURIComponent(strVenCd);
		TR_MAIN.Action = "/mss/mren401.mr?goTo=" + goTo + parameters;
		TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
		TR_MAIN.Post();

		// 조회결과 Return
		setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));
		GD_MASTER.Focus();

		//그리드 CHEKCBOX헤더 체크해제
		GD_MASTER.ColumnProp('CHECK1', 'HeadCheck') = "false";
	}

	/**
	 * outputPrint()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010-04-26
	 * 개    요 : 페이지 프린트 인쇄
	 * return값 : void
	 */
	/*   function outputPrint() {
	 if (!checkValidateSearch()) return;
	
	 var strCount    = 0;
	 var arrStrCd    = new Array();      //점코드       변수 담을 배열
	 var arrCntrId   = new Array();      //협력사코드  변수 담을 배열
	 var arrCalYm    = new Array();      //부과년월       변수 담을 배열
	 var arrRentType = new Array();      //임대형태       변수 담을 배열
	
	 var totCount = 0;                 // 총 출력 건수
	 var tmpCnt = 0;                   // 출력구분 전체건수
	
	 var strPrintFlag = RD_PRINT_FLAG.CodeValue;
	
	 for(var i = 1; i <= DS_O_MASTER.CountRow; i ++) 
	 {
	 if(strCount <= 100){
	 if(DS_O_MASTER.NameValue(i, "CHECK1") == "T"){
	 arrStrCd[strCount]     = DS_O_MASTER.NameValue(i, "STR_CD");
	 arrCntrId[strCount]    = DS_O_MASTER.NameValue(i, "CNTR_ID");
	 arrCalYm[strCount]     = DS_O_MASTER.NameValue(i, "CAL_YM");
	 arrRentType[strCount]  = DS_O_MASTER.NameValue(i, "RENT_TYPE");
	
	 //if(strPrintFlag == "A"){
	 tmpCnt++;
	 //}
	
	 strCount = strCount+1;
	 DS_O_MASTER.NameValue(i, "CHECK1") = "F";                 
	 }	             
	 }else{
	 /*if(strPrintFlag == "A")
	 totCount = tmpCnt*2;
	 else*/
	/*  totCount = tmpCnt;
	
	  var parameters = "&strStrCd="      + arrStrCd
	               + "&strCalYM="      + arrCalYm
	               + "&strRentType="   + arrRentType
	               + "&strCntrId="     + arrCntrId
	               + "&Loop="          + strCount
	               + "&strPrintFlag="  + strPrintFlag
	               + "&totCount="      + totCount;
	/*
	var g_popUp = window.showModalDialog("/mss/mren401.mr?goTo=print"+parameters,"OZREPORT",
	             "width:0px;height:0px;scroll:no;" +
	             "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	 */
	/*  window.open("/mss/mren401.mr?goTo=print"+parameters, "OZREPORT", 1000, 700);
	
	btn_Print();
	return;
	}
	}
	/*
	if(strPrintFlag == "A")
	totCount = tmpCnt*2;
	else*/
	/*totCount = tmpCnt;
	
	if(totCount == 0){
	 showMessage(INFORMATION, OK, "USER-1031");  
	 return;
	}
	
	//var strStrCd    = LC_S_STR_CD.BindColVal;       // 시설구분
	//var strCalYM    = EM_S_CAL_YM.Text;             // 부과년월
	//var strRentType = LC_S_RENT_TYPE.BindColVal;    // 임대형태
	//var strVenCd    = EM_S_VEN_CD.Text;             // 계약ID
	/*var parameters = "&strStrCd="      + arrStrCd
	               + "&strCalYM="      + arrCalYm
	               + "&strRentType="   + arrRentType
	               + "&strCntrId="     + arrCntrId
	               + "&Loop="          + strCount
	               + "&strPrintFlag="  + strPrintFlag
	               + "&totCount="      + totCount;
	/*
	var g_popUp = window.showModalDialog("/mss/mren401.mr?goTo=print"+parameters,"OZREPORT",
	        "width:0px;height:0px;scroll:no;" +
	        "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	 */
	/*window.open("/mss/mren401.mr?goTo=print"+parameters, "OZREPORT", 1000, 700);
	
	//그리드 CHEKCBOX헤더 체크해제
	GD_MASTER.ColumnProp('CHECK1','HeadCheck')= "false";
	}    */

	/**
	 * callPopup()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.02
	 * 개    요 : 팝업 호출
	 * return값 :
	 */
	function callPopup(popupNm) {
		if (popupNm == "sVen") { //[조회용]협력사
			if (LC_S_STR_CD.BindColVal == "" || LC_S_STR_CD.BindColVal == "%") {//시설구분 미선택시
				showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
				LC_S_STR_CD.Focus();
				return;
			}

			var strOrgFlag = "2";
			var strBizType = "";
			/*
			if (LC_S_STR_CD.ValueOfIndex("FCL_FLAG", LC_S_STR_CD.Index) == "1") {
			    // 백화점일경우 매입매춝구분:매출, 거래형태:임대을 ,임대갑
			    strOrgFlag = "2";
			    strBizType = "";
			} else {
			    // 그 외            매입매춝구분:매출, 거래형태:임대갑
			    strOrgFlag = "2";
			    strBizType = "4";
			}
			 */

			venPop(EM_S_VEN_CD, EM_S_VEN_NM, LC_S_STR_CD.BindColVal, "", "",
					strBizType, strOrgFlag, "", "T");
		} else if (popupNm == "cYM") {
			openCal('M', EM_CAL_YM);
		}
	}

	/**
	 * getCheckClose()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 마감여부체크
	 * return값 :
	 */
	function getCheckClose() {
		//마감체크
		if (getCloseYN() == "TRUE") {
			objectControlDefault(false);
			var strCalY = (EM_CAL_YM.Text).substring(0, 4);
			var strCalM = (EM_CAL_YM.Text).substring(5, 6);
			showMessage(INFORMATION, OK, "USER-1000", "선택한 시설의 " + strCalY
					+ "년" + strCalM + "월은 이미 정산마감 되었습니다.");
			DS_O_MASTER.ClearData();
		} else {
			var strStrCd = LC_STR_CD.BindColVal; // 시설구분
			var strCalYM = EM_CAL_YM.Text; // 부과년월
			var strRentType = ""; // 임대형태
			var strVenCd = ""; // 계약ID
			var goTo = "getMaster";
			var parameters = "" + "&strStrCd=" + encodeURIComponent(strStrCd)
					+ "&strCalYM=" + encodeURIComponent(strCalYM)
					+ "&strRentType=" + encodeURIComponent(strRentType)
					+ "&strVenCd=" + encodeURIComponent(strVenCd);
			TR_MAIN.Action = "/mss/mren401.mr?goTo=" + goTo + parameters;
			TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
			TR_MAIN.Post();

			// 조회결과 Return
			setPorcCount("SELECT", DS_O_MASTER.RealCount(1,
					DS_O_MASTER.CountRow));
			GD_MASTER.Focus();

			//DS_O_MASTER.ClearData();
			objectControlDefault(true);
		}
	}

	/**
	 * getCloseYN()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 마감여부체크
	 * return값 :
	 */
	function getCloseYN() {
		var strStrCd = LC_STR_CD.BindColVal; // 시설구분
		var strCalYM = EM_CAL_YM.Text; // 부과년월
		var goTo = "getCheckClose";
		var parameters = "" + "&strStrCd=" + encodeURIComponent(strStrCd)
				+ "&strCalYM=" + encodeURIComponent(strCalYM);
		TR_MAIN.Action = "/mss/mren401.mr?goTo=" + goTo + parameters;
		TR_MAIN.KeyValue = "SERVLET(O:DS_O_CLOSE_YN=DS_O_CLOSE_YN)";
		TR_MAIN.Post();

		var rtValue = "TRUE";
		if (DS_O_CLOSE_YN.CountRow == 1) {
			rtValue = DS_O_CLOSE_YN.NameValue(1, "CLOSE_YN");
		} else {
			rtValue = "TRUE";
		}

		return rtValue;
	}

	/**
	 * billingProcess()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 청구내역생성/취소 처리
	 * return값 :
	 */
	function billingProcess(strYN) {
		DS_I_PARAMATER.ClearData();
		DS_I_PARAMATER.Addrow();
		DS_I_PARAMATER.NameValue(1, "CAL_YM") = EM_CAL_YM.Text;
		DS_I_PARAMATER.NameValue(1, "STR_CD") = LC_STR_CD.BindColVal;
		DS_I_PARAMATER.NameValue(1, "CHRG_YN") = strYN;

		var goTo = "billingProcess";
		TR_SAVE.Action = "/mss/mren401.mr?goTo=" + goTo;
		TR_SAVE.KeyValue = "SERVLET(I:DS_I_PARAMATER=DS_I_PARAMATER)";
		TR_SAVE.Post();
	}

	/**
	 * checkValidateSearch()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 값체크
	 * return값 :
	 */
	function checkValidateSearch() {
		if (LC_S_STR_CD.BindColVal == "") {
			showMessage(INFORMATION, OK, "USER-1000", "시설(구분)을 선택하세요");
			LC_S_STR_CD.Focus();
			return false;
		}

		if (EM_S_CAL_YM.Text == "") {
			showMessage(INFORMATION, OK, "USER-1000", "부과년월(FROM) 입력 하세요");
			EM_S_CAL_YM.Focus();
			return false;
		}

		return true;
	}

	/**
	 * objectControlDefault()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010.05.16
	 * 개    요 : 관리비청구서관리 생성 부 컨트롤
	 * return값 :
	 */
	function objectControlDefault(objBoolean) {
		if (objBoolean) {
			//이미지
			enableControl(IMG_CREATE_CHRG, true);
			enableControl(IMG_CANCEL_CHRG, true);
		} else {
			EM_CAL_YM.Text = "";
			//이미지
			enableControl(IMG_CREATE_CHRG, false);
			enableControl(IMG_CANCEL_CHRG, false);
		}
	}

	/**
	 * setMasterDs()
	 * 작 성 자 : 박래형
	 * 작 성 일 : 2010-03-17
	 * 개    요 : 행사구분 데이터셋 복사
	 * return값 : void
	 */
	function setMasterDs() {

		DS_CHECKMASTER.ClearData(); //복사될 데이터셋 초기화

		/*마스터에서 선택된 데이터만 Copy */
		for (var i = 1; i <= DS_O_MASTER.CountRow; i++) {
			if (DS_O_MASTER.NameValue(i, "CHECK1") == "T") {

				DS_CHECKMASTER.Addrow();

				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "VEN_NM")     = DS_O_MASTER.NameValue(i, "VEN_NM");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "VEN_CD")     = DS_O_MASTER.NameValue(i, "VEN_CD");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "CNTR_ID")    = DS_O_MASTER.NameValue(i, "CNTR_ID");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "REP_NAME")   = DS_O_MASTER.NameValue(i, "REP_NAME");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "COMP_NO")    = DS_O_MASTER.NameValue(i, "COMP_NO");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "CNTR_AREA")  = DS_O_MASTER.NameValue(i, "CNTR_AREA");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "BAL_AMT")    = DS_O_MASTER.NameValue(i, "BAL_AMT");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "ARREAR_AMT") = DS_O_MASTER.NameValue(i, "ARREAR_AMT");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "MOD_AMT")    = DS_O_MASTER.NameValue(i, "MOD_AMT");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "REAL_CHAREG_AMT") = DS_O_MASTER.NameValue(i, "REAL_CHAREG_AMT");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "CAL_YM")      = DS_O_MASTER .NameValue(i, "CAL_YM");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "BANK")        = DS_O_MASTER .NameValue(i, "BANK");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "ACCOUNT_NUM") = DS_O_MASTER.NameValue(i, "ACCOUNT_NUM");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "ACCOUNT_HDR") = DS_O_MASTER.NameValue(i, "ACCOUNT_HDR");
				DS_CHECKMASTER.NameValue(DS_CHECKMASTER.RowPosition, "PAY_TERM_DD") = DS_O_MASTER.NameValue(i, "PAY_TERM_DD");

			}

		}
	}
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                          *-->
<!--*    1. TR Success 메세지 처리                                                                                         *-->
<!--*    2. TR Fail 메세지 처리                                                                                               *-->
<!--*    3. DataSet Success 메세지 처리                                                                               *-->
<!--*    4. DataSet Fail 메세지 처리                                                                                     *-->
<!--*    5. DataSet 이벤트 처리                                                                                               *-->
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
	for (i = 0; i < TR_MAIN.SrvErrCount('UserMsg'); i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg', i));
	}
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
	for (i = 0; i < TR_SAVE.SrvErrCount('UserMsg'); i++) {
		showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg', i));
	}

	//저장 후 조회    
	if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
		//입금등록관련 정산마감 관련 내역 초기화
		// parameters
		LC_S_STR_CD.BindColVal = LC_STR_CD.BindColVal;
		EM_S_CAL_YM.Text = EM_CAL_YM.Text;

		DS_O_MASTER.ClearData();
		objectControlDefault(false);
	}

	var strStrCd = LC_S_STR_CD.BindColVal; // 시설구분
	var strCalYM = EM_S_CAL_YM.Text; // 부과년월
	var strRentType = LC_S_RENT_TYPE.BindColVal; // 임대형태
	var strVenCd = EM_S_VEN_CD.Text; // 계약ID
	var goTo = "getMaster";
	var parameters = "" + "&strStrCd=" + encodeURIComponent(strStrCd)
			+ "&strCalYM=" + encodeURIComponent(strCalYM) + "&strRentType="
			+ encodeURIComponent(strRentType) + "&strVenCd="
			+ encodeURIComponent(strVenCd);
	TR_MAIN.Action = "/mss/mren401.mr?goTo=" + goTo + parameters;
	TR_MAIN.KeyValue = "SERVLET(O:DS_O_MASTER=DS_O_MASTER)";
	TR_MAIN.Post();

	// 조회결과 Return
	setPorcCount("SELECT", DS_O_MASTER.RealCount(1, DS_O_MASTER.CountRow));
	GD_MASTER.Focus();
</script>


<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
	trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
	trFailed(TR_SAVE.ErrorMsg);
</script>
<script language=JavaScript for=TR_PRINT event=onFail>
	trFailed(TR_PRINT.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--  ===================DS_O_MASTER============================ -->
<!--  DS_LIST 변경시 -->
<script language=JavaScript for=DS_O_MASTER
	event=OnColumnChanged(row,colid)>
	switch (colid) {
	case "CHECK1":
		var count = 0;
		for (var i = 1; i <= DS_O_MASTER.CountRow; i++) {
			if (DS_O_MASTER.NameValue(i, "CHECK1") == "T") {
				count++
			}
		}
		// 			if(count >1){
		// 				showMessage(INFORMATION, OK, "USER-1000","한건만 출력이 가능합니다.");
		// 				DS_LIST.NameValue(row, "CHECK1")="F";
		// 				count = 0;
		// 				return;
		// 			}
		break;
	}
</script>
<!-- <script language="javascript"  for=GD_MASTER event=OnCheckClick(Row,Colid,Check)>
    if(DS_O_MASTER.CountRow)
</script> -->
<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	if (clickSORT)
		return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
	if (colid == "CHECK1" && DS_O_MASTER.NameValue(row, colid) == "T") {
		var pringFlag = RD_PRINT_FLAG.CodeValue;
		if (DS_O_MASTER.NameValue(row, "CHRG_YN") == "Y") {
			if (pringFlag == "B") {
				if (DS_O_MASTER.NameValue(row, "MNTN_CAL_YN") == "Y") {
					return;
				} else {
					DS_O_MASTER.NameValue(row, colid) = "F";
					showMessage(INFORMATION, OK, "USER-1000", "관리비 산출 대상이 아닙니다.");
				}
			} else if (pringFlag == "C") {
				if (DS_O_MASTER.NameValue(row, "RENT_CAL_YN") == "Y") {

					return;
				} else {
					DS_O_MASTER.NameValue(row, colid) = "F";
					showMessage(INFORMATION, OK, "USER-1000", "임대료 산출 대상이 아닙니다.");
				}
			}
		} else{
	 		DS_O_MASTER.NameValue(row, colid) = "F";
	 		showMessage(INFORMATION, OK, "USER-1000", "청구내역생성후 출력 가능합니다.");
	 	} 

	}

	//그리드 정렬기능
	if (row < 1) {
		sortColId(eval(this.DataID), row, colid);
	}
</script>
<script language=JavaScript for=RD_PRINT_FLAG event=OnSelChange()>
	//searchMaster();
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
	//[조회용]시설구분 변경시
	LC_S_RENT_TYPE.Index = 0;
</script>

<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
	//시설구분 변경시
	//마감여부체크
	/* if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
		getCheckClose();
	} */
</script>

<script language=JavaScript for=EM_CAL_YM event=OnKillFocus()>
	// 마감여부체크
	if (!this.Modified)
		return;

	if (EM_CAL_YM.Text.replace(/^\s*|\s*$/g, "").length == 6) {
		getCheckClose();
	} else {
		if (DS_O_MASTER.IsUpdated) {
			objectControlDefault(false);
			DS_O_MASTER.ClearData();
		}
	}
</script>

<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
	//[조회용]협력사 코드 자동완성 및 팝업호출
	if (!this.Modified)
		return;

	if (this.text == '') {
		EM_S_VEN_NM.Text = "";
		return;
	}

	if (LC_S_STR_CD.BindColVal == "") {//점 미선택시
		showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
		LC_S_STR_CD.Focus();
		return;
	}

	var strOrgFlag = "2";
	var strBizType = "";
	/*
	if (LC_S_STR_CD.ValueOfIndex("FCL_FLAG", LC_S_STR_CD.Index) == "1") {
	    // 백화점일경우 매입매춝구분:매출, 거래형태:임대을 ,임대갑
	    strOrgFlag = "2";
	    strBizType = "";
	} else {
	    // 그 외            매입매춝구분:매출, 거래형태:임대갑
	    strOrgFlag = "2";
	    strBizType = "4";
	}
	 */

	//단일건 체크 
	setVenNmWithoutPop("DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, 1,
			LC_S_STR_CD.BindColVal, "", "", strBizType, strOrgFlag, "", "T");
</script>

<script language="javascript" for=GD_MASTER
	event=OnHeadCheckClick(Col,Colid,bCheck)>
	//헤더 전체 체크/체크해제 컨트롤
	this.ReDraw = "false";

	if (bCheck == '1') { // 전체체크
		for (var i = 1; i <= DS_O_MASTER.CountRow; i++) {
			if (DS_O_MASTER.NameValue(i, "CHRG_YN") == "Y") {
				DS_O_MASTER.NameValue(i, "CHECK1") = 'T';
			}
		}
	} else { // 전체체크해제
		for (var i = 1; i <= DS_O_MASTER.CountRow; i++) {
			DS_O_MASTER.NameValue(i, "CHECK1") = 'F';
		}
	}

	this.ReDraw = "true";
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
<comment id="_NSID_"> <object id="DS_O_MASTER"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_O_CLOSE_YN"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"> <object id="PR_List"
	classid=<%=Util.CLSID_REPORT%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_I_PARAMATER"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"> <object id="DS_STR_CD"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_S_MR_MNTNITEM"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_RENT_TYPE"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_PRINT"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_CLOSE_YN"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_CHECKMASTER"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"> <object id="DS_I_COMMON"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_I_CONDITION"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<comment id="_NSID_"> <object id="DS_O_RESULT"
	classid=<%=Util.CLSID_DATASET%>></object></comment>
<script>
	_ws_(_NSID_);
</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"> <object id="TR_MAIN"
	classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="TR_SAVE"
	classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object> </comment>
<script>
	_ws_(_NSID_);
</script>

<comment id="_NSID_"> <object id="TR_PRINT"
	classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object> </comment>
<script>
	_ws_(_NSID_);
</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                     *-->
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
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                         *-->
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
										<th width="80" class="point">시설구분</th>
										<td width="115"><comment id="_NSID_"> <object
												id=LC_S_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width="110"
												tabindex=1 align="absmiddle"> </object></comment> <script>
													_ws_(_NSID_);
												</script></td>
										<th width="80" class="point">부과년월</th>
										<td width="100"><comment id="_NSID_"> <object
												id=EM_S_CAL_YM classid=<%=Util.CLSID_EMEDIT%> width="70"
												tabindex=1 onblur="javascript:checkDateTypeYM(this);"
												align="absmiddle"> </object></comment> <script>
													_ws_(_NSID_);
												</script><img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
											onclick="javascript:openCal('M',EM_S_CAL_YM);" /></td>
										<th width="80">협력사</th>
										<td><comment id="_NSID_"> <object
												id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width="80"
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script> <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"
											class="PR03" onclick="javascript:callPopup('sVen');"
											align="absmiddle" /> <comment id="_NSID_"> <object
												id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width="180"
												tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script></td>
									</tr>
									<tr>
										<th>임대형태</th>
										<td><comment id="_NSID_"> <object
												id=LC_S_RENT_TYPE classid=<%=Util.CLSID_LUXECOMBO%>
												width=110 tabindex=1 align="absmiddle"> </object> </comment> <script>
													_ws_(_NSID_);
												</script></td>
										<th>출력구분</th>
										<td colspan="3"><comment id="_NSID_"> <object
												id=RD_PRINT_FLAG classid=<%=Util.CLSID_RADIO%> tabindex=1
												style="height: 20; width: 120">
												<param name=Cols value="2">
												<param name=Format value="B^관리비">
												<param name=CodeValue value="B">
											</object> </comment> <script>
												_ws_(_NSID_);
											</script></td>

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
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="PT01 PB03">
								<table width="460" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
										<th width="80" class="point">시설구분</th>
										<td width="145"><comment id="_NSID_"> <object
												id=LC_STR_CD
												classid=CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E
												width="143" tabindex=1 align="absmiddle"> </object></comment> <script>
													_ws_(_NSID_);
												</script></td>
										<th width="80" class="point">부과년월</th>
										<td width="110"><comment id="_NSID_"> <object
												id=EM_CAL_YM
												classid=CLSID:D7779973-9954-464E-9708-DA774CA50E13
												width="85" tabindex=1
												onblur="javascript:checkDateTypeYM(this);" align="absmiddle">
											</object></comment> <script>
												_ws_(_NSID_);
											</script><img src="/pot/imgs/btn/date.gif" align="absmiddle"
											onclick="javascript:openCal('M',EM_CAL_YM);" /></td>
									</tr>
								</table>
							</td>
							<td class="right"><img id="IMG_CREATE_CHRG"
								src="/<%=dir%>/imgs/btn/claim_list.gif" hspace="2"
								onclick="javascript:billingProcess('Y');" /> <img
								id="IMG_CANCEL_CHRG"
								src="/<%=dir%>/imgs/btn/claim_list_cancel.gif" hspace="2"
								onclick="javascript:billingProcess('N');" /></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="PT05">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="BD4A">
						<tr>
							<td><comment id="_NSID_"> <object id=GD_MASTER
									width="100%" height=720 classid=<%=Util.CLSID_GRID%>>
									<param name="DataID" value="DS_O_MASTER">
								</object></comment> <script>
									_ws_(_NSID_);
								</script></td>
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
