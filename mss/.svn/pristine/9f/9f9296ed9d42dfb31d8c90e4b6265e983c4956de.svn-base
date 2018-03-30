<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은행사마스터  > 협력사마스터관리
 * 작 성 일 : 2011.01.17
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : mcae1010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 특판매출이 발생하는 협력사정보를 관리한다
 * 이    력 : 2011.01.17 (김슬기) 신규작성
           2011.02.14 (김유완) 수정개발
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                 *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
	/*************************************************************************
	 * 0. 전역변수
	 *************************************************************************/

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
	 var top = 120;		//해당화면의 동적그리드top위치
	 
	function doInit() {
		
		 
		//Master 그리드 세로크기자동조정  2013-07-17
		 var obj   = document.getElementById("GD_MASTER"); 
		obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
		
		// Input Data Set Header 초기화
		DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_VEN_MST"/>');
		registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");

		//그리드 초기화
		gridCreate("MST"); //마스터

		// EMedit에 초기화  
		initEmEdit(EM_SEL_VEN_CD, "NUMBER3^6^2", NORMAL);// [조회용]협력사코드
		initEmEdit(EM_SEL_VEN_NAME, "GEN", READ); // [조회용]협력사명
		initEmEdit(EM_STR_CD, "GEN", READ); // 점
		initEmEdit(EM_STR_NM, "GEN", READ); // 점명
		initEmEdit(EM_VEN_CD, "GEN", READ); // 협력사코드
		initEmEdit(EM_VEN_NAME, "GEN", READ); // 협력사명
		initEmEdit(EM_BIZ_TYPE, "GEN", READ); // 거래형태
		initEmEdit(EM_COMP_NO, "000-00-00000", READ); // 사업자번호
		initEmEdit(EM_COMP_NAME, "GEN", READ); // 상호명
		initEmEdit(EM_REP_NAME, "GEN", READ); // 대표자명
		initEmEdit(EM_BIZ_STAT, "GEN", READ); // 업태
		initEmEdit(EM_BIZ_CAT, "GEN", READ); // 종목
		initEmEdit(EM_ADDR, "GEN", READ); // 주소
		initEmEdit(EM_PHONE_NO, "GEN", READ); // 전화번호
		initEmEdit(EM_FAX_NO, "GEN", READ); // FAX번호
		initEmEdit(EM_ACC_VEN_CD, "GEN", READ); // 거래선코드
		initEmEdit(EM_PAY_DT_FLAG, "GEN", READ); // 지불일
		initEmEdit(EM_PAY_WAY, "GEN", READ); // 지불방법

		//콤보 초기화
		initComboStyle(LC_SEL_STR_CD, DS_LC_SEL_STR, "CODE^0^30,NAME^0^80", 1, PK); // [조회용]점코드     
		initComboStyle(LC_SEL_BUY_SALE_FLAG, DS_LC_SEL_BUYSALE_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]매출매입구분
		initComboStyle(LC_SEL_VEN_FLAG, DS_LC_SEL_VEN_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]협력사 구분
		initComboStyle(LC_VEN_FLAG, DS_LC_VEN_FLAG, "CODE^0^30,NAME^0^80", 1, PK); // 협력사 구분
		initComboStyle(LC_CARD_COMP, DS_LC_CARD_COMP, "CODE^0^30,NAME^0^80", 1, PK); // 카드사정보
		//시스템 코드 공통코드에서 가지고 오기
		getStore("DS_LC_SEL_STR", "Y", "1", "N");
		LC_SEL_STR_CD.index = "0";
		getEtcCode("DS_LC_SEL_BUYSALE_FLAG", "D", "P017", "Y", "N", LC_SEL_BUY_SALE_FLAG);
		getEtcCode("DS_LC_SEL_VEN_FLAG", "D", "M001", "Y", "N", LC_SEL_VEN_FLAG);
		getEtcCode("DS_LC_VEN_FLAG", "D", "M001", "N");
		//getEtcCode("DS_LC_CARD_COMP", "D", "D005", "N");
		
		// 카드사 테이블에서 카드사 정보 조회 : 2011/04/28 김성미
		getComboCd("DS_LC_CARD_COMP", "", "SEL_CARD_COMP", "");

		enableControl(LC_VEN_FLAG, false);
	    enableControl(LC_CARD_COMP, false);
		//load 시 기본 포커스
		LC_SEL_STR_CD.Focus();

		//종료시 데이터 변경 체크 (common.js )
		registerUsingDataset("mcae101", "DS_IO_MASTER");
	}

	function gridCreate(gdGnb) {
		//마스터그리드
		if (gdGnb == "MST") {
			var hdrProperies = ''
					+ '<FC>ID={CURROW}   NAME="NO"'
					+ '                                  WIDTH=30   ALIGN=CENTER</FC>'
					+ '<FC>I D=STR_CD     NAME="점"'
					+ '                                  WIDTH=40   ALIGN=CENTER SHOW=FALSE</FC>'
					+ '<FC>ID=STR_NM     NAME="점명"'
					+ '                                  WIDTH=60   ALIGN=LEFT</FC>'
					+ '<FC>ID=VEN_CD     NAME="협력사코드"'
					+ '                                  WIDTH=70   ALIGN=LEFT SHOW=FALSE</FC>'
					+ '<FC>ID=VEN_NAME   NAME="협력사명"'
					+ '                                  WIDTH=110   ALIGN=LEFT</FC>'
					+ '<FC>ID=BUY_SALE_FLAG  NAME="매출매입구분"'
					+ '                                  WIDTH=80   ALIGN=CENTER EDITSTYLE=LOOKUP DATA="DS_LC_SEL_BUYSALE_FLAG:CODE:NAME"</FC>'
					+ '<FC>ID=BIZ_TYPE   NAME="거래형태"'
					+ '                                  WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>'
					+ '<FC>ID=COMP_NO    NAME="사업자번호"'
					+ '                                  WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>'
					+ '<FC>ID=COMP_NAME  NAME="상호명"'
					+ '                                  WIDTH=80   ALIGN=LEFT   SHOW=FALSE</FC>'
					+ '<FC>ID=REP_NAME   NAME="대표자명"'
					+ '                                  WIDTH=80   ALIGN=LEFT   SHOW=FALSE</FC>'
					+ '<FC>ID=BIZ_STAT   NAME="업태"'
					+ '                                  WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>'
					+ '<FC>ID=BIZ_CAT    NAME="종목"'
					+ '                                  WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>'
					+ '<FC>ID=ADDR       NAME="주소"'
					+ '                                  WIDTH=80   ALIGN=LEFT   SHOW=FALSE</FC>'
					+ '<FC>ID=PHONE_NO   NAME="전화번호"'
					+ '                                  WIDTH=80   ALIGN=LEFT   SHOW=FALSE</FC>'
					+ '<FC>ID=PAY_DT_FLAG    NAME="지불일자"'
					+ '                                  WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>'
					+ '<FC>ID=PAY_WAY    NAME="지불방법"'
					+ '                                  WIDTH=80   ALIGN=LEFT   SHOW=FALSE</FC>'
					+ '<FC>ID=FAX_NO     NAME="FAX번호"'
					+ '                                  WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>'
					+ '<FC>ID=ACC_VEN_CD NAME="거래선코드"'
					+ '                                  WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>'
					+ '<FC>ID=VEN_FLAG   NAME="협력사구분"'
					+ '                                  WIDTH=110   ALIGN=LEFT   EDITSTYLE=LOOKUP DATA="DS_LC_VEN_FLAG:CODE:NAME"</FC>'
					+ '<FC>ID=CARD_COMP  NAME="카드사정보"'
					+ '                                  WIDTH=80   ALIGN=CENTER SHOW=FALSE</FC>';
			initGridStyle(GD_MASTER, "COMMON", hdrProperies, false);
		}
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
	function btn_Search(preRowno) {
		//parameters
		var strStrCd       = LC_SEL_STR_CD.BindColVal; // 점코드
		var strBuySaleFlag = LC_SEL_BUY_SALE_FLAG.BindColVal; // 매입매출구분
		var strVenFlag     = LC_SEL_VEN_FLAG.BindColVal; // 협력사구분
		var strVenCd       = EM_SEL_VEN_CD.Text; // 협력사코드

		var goTo = "getMaster";
		var parameters = "" + "&strStrCd="       + encodeURIComponent(strStrCd) 
		                    + "&strBuySaleFlag=" + encodeURIComponent(strBuySaleFlag) 
		                    + "&strVenFlag="     + encodeURIComponent(strVenFlag) 
		                    + "&strVenCd="       + encodeURIComponent(strVenCd);
		TR_MAIN.Action = "/mss/mcae101.mc?goTo=" + goTo + parameters;
		TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";//조회:O 입력:I
		TR_MAIN.Post();

		// Row위치 적용
		if (preRowno > 0) {
			DS_IO_MASTER.RowPosition = preRowno;
		}

		// 조회결과 Return
		setPorcCount("SELECT", GD_MASTER);
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
	}

	/**
	 * btn_Save()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2010-12-12
	 * 개    요 : DB에 저장 / 수정 / 삭제 처리
	 * return값 : void
	 */
	function btn_Save() {

		if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
			//값체크
			if (!checkValidate())
				return;
		
			//변경또는 신규 내용을 저장하시겠습니까?
            if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
                GD_MASTER.Focus();
                return;
            }
			var goTo = "save";
			TR_MAIN.Action = "/mss/mcae101.mc?goTo=" + goTo;
			TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
			TR_MAIN.Post();

			//Row위치 저장
			var preRowno = DS_IO_MASTER.RowPosition;

		} else {
			showMessage(INFORMATION, OK, "USER-1028");
		}

		//저장 후 재 조회
		btn_Search(preRowno);
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
	 * callPopup()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2011.01.24
	 * 개    요 : 팝업 호출
	 * return값 :
	 */
	function callPopup(popupNm) {
		if (popupNm == "ven") {//협력사
			if (LC_SEL_STR_CD.BindColVal == ""
					|| LC_SEL_STR_CD.BindColVal == "%") {//점 미선택시
				showMessage(STOPSIGN, OK, "USER-1003", "점");
				LC_SEL_STR_CD.Focus();
				return;
			}
		
			getEvtVenPop( EM_SEL_VEN_CD, EM_SEL_VEN_NAME, 'S', LC_SEL_STR_CD.BindColVal, '');
		}
	}

	/**
	 * checkValidate()
	 * 작 성 자 : FKL
	 * 작 성 일 : 2011.02.21
	 * 개    요 : 값체크
	 * return값 :
	 */
	function checkValidate() {
				 
		for (i = 1; i <= DS_IO_MASTER.CountRow; i++) {
			
// 			alert(i);
// 			alert(DS_IO_MASTER.RowStatus(i));
// 			alert(DS_IO_MASTER.NameValue(i, "VEN_FLAG"));
// 			alert(DS_IO_MASTER.NameValue(i, "CARD_COMP"));
			
			if (DS_IO_MASTER.RowStatus(i) == 3
					&& DS_IO_MASTER.NameValue(i, "VEN_FLAG") == "01"
					&& (DS_IO_MASTER.NameValue(i, "CARD_COMP")).length < 1) {
				setTimeout("DS_IO_MASTER.RowPosition =" + i, 100);
				setTimeout("LC_CARD_COMP.Focus()", 120);
				showMessage(INFORMATION, OK, "USER-1002", "카드사 정보");
				return false;
			}
			
			
		}
		return true;
	}
//-->
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
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    /*showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
if (DS_IO_MASTER.CountRow > 0) {
	if (DS_IO_MASTER.RowStatus(row) == 0) {
		enableControl(LC_CARD_COMP, false);
		if (DS_IO_MASTER.NameValue(row, "VEN_FLAG") == "99") {
			enableControl(LC_VEN_FLAG, true);
		} else {
			enableControl(LC_VEN_FLAG, false);
		}
	} else {
		enableControl(LC_VEN_FLAG, true);
        if (DS_IO_MASTER.NameValue(row, "VEN_FLAG") == "01") {
            enableControl(LC_CARD_COMP, true);
        } else {
            enableControl(LC_CARD_COMP, false);
            LC_CARD_COMP.DefaultString   = "==선택하세요==";
            LC_CARD_COMP.Index = -1;
        }
	}
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=LC_VEN_FLAG event=OnSelChange()>
if (DS_IO_MASTER.CountRow > 0) {
    if (LC_VEN_FLAG.BindColVal == "01") { //협력사 구분이 카드협력사 일경우만  카드사 정보 활성화
        enableControl(LC_CARD_COMP, true);

    } else {
        enableControl(LC_CARD_COMP, false);
        LC_CARD_COMP.DefaultString   = "==선택하세요==";
        LC_CARD_COMP.Index = -1;
    }
}
</script>
 
<script language=JavaScript for=EM_SEL_VEN_CD event=OnKillFocus()>
//[조회용]협력사 코드 자동완성 및 팝업호출
//if (EM_SEL_VEN_CD.Text.length > 0 ) {
	if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_SEL_VEN_NAME.Text = "";
        return;
    }
    
    if (LC_SEL_STR_CD.BindColVal == "") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "점");
        LC_SEL_STR_CD.Focus();
        return;
    }
	
    //단일건 체크 
    getEvtVenNonPop("DS_O_RESULT", EM_SEL_VEN_CD, EM_SEL_VEN_NAME, "E" , "Y" , LC_SEL_STR_CD.BindColVal,  '');
//}
</script>

<!-- 점 OnSelChange() -->
<script language=JavaScript for=LC_SEL_STR_CD event=OnSelChange()>
   EM_SEL_VEN_CD.Text = "";
   EM_SEL_VEN_NAME.Text = "";
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction                                                     *-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- ===============- Input용  -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_">
<object id="DS_LC_SEL_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_LC_SEL_BUYSALE_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_LC_SEL_VEN_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_LC_VEN_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_LC_CARD_COMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
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
						<td width="170"><comment id="_NSID_"> <object
							id=LC_SEL_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=165 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">매출매입구분</th>
						<td width="170"><comment id="_NSID_"> <object
							id=LC_SEL_BUY_SALE_FLAG classid=<%=Util.CLSID_LUXECOMBO%>
							height=100 width=165 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">협력사구분</th>
						<td ><comment id="_NSID_"> <object
							id=LC_SEL_VEN_FLAG classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=165 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>협력사</th>
						<td colspan=5><comment id="_NSID_"> <object
							id=EM_SEL_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=60
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup('ven')" align="absmiddle" /> <comment
							id="_NSID_"> <object id=EM_SEL_VEN_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=183 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
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
				<td width="330">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td width="100%"><comment id="_NSID_"><OBJECT
							id=GD_MASTER width=420 height=780 tabindex=1
							classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="s_table">
									<tr>
										<th width="80">점</th>
										<td width="140"><comment id="_NSID_"> <object
											id=EM_STR_CD classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
										<th width="80">점명</th>
										<td><comment id="_NSID_"> <object id=EM_STR_NM
											classid=<%=Util.CLSID_EMEDIT%> width=130 tabindex=1
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>협력사코드</th>
										<td><comment id="_NSID_"> <object id=EM_VEN_CD
											classid=<%=Util.CLSID_EMEDIT%> width=130 align="absmiddle">
										</object> </comment><script>_ws_(_NSID_);</script></td>
										<th>협력사명</th>
										<td><comment id="_NSID_"> <object
											id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>거래형태</th>
										<td><comment id="_NSID_"> <object
											id=EM_BIZ_TYPE classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
										<th>사업자번호</th>
										<td><comment id="_NSID_"> <object id=EM_COMP_NO
											classid=<%=Util.CLSID_EMEDIT%> width=130 align="absmiddle">
										</object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>상호명</th>
										<td><comment id="_NSID_"> <object
											id=EM_COMP_NAME classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
										<th>대표자명</th>
										<td><comment id="_NSID_"> <object
											id=EM_REP_NAME classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>업태</th>
										<td><comment id="_NSID_"> <object
											id=EM_BIZ_STAT classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
										<th>종목</th>
										<td><comment id="_NSID_"> <object id=EM_BIZ_CAT
											classid=<%=Util.CLSID_EMEDIT%> width=130 align="absmiddle">
										</object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>주소</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%> width=371
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>전화번호</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_PHONE_NO classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>지불일</th>
										<td><comment id="_NSID_"> <object
											id=EM_PAY_DT_FLAG classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
										<th>지불방법</th>
										<td><comment id="_NSID_"> <object id=EM_PAY_WAY
											classid=<%=Util.CLSID_EMEDIT%> width=130 align="absmiddle">
										</object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th>FAX번호</th>
										<td><comment id="_NSID_"> <object id=EM_FAX_NO
											classid=<%=Util.CLSID_EMEDIT%> width=130 align="absmiddle">
										</object> </comment><script>_ws_(_NSID_);</script></td>
										<th>거래선코드</th>
										<td><comment id="_NSID_"> <object
											id=EM_ACC_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=130
											align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
									<tr>
										<th class="point">협력사구분</th>
										<td><comment id="_NSID_"> <object
											id=LC_VEN_FLAG classid=<%=Util.CLSID_LUXECOMBO%> height=100
											width=135 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
										<th>카드사정보</th>
										<td><comment id="_NSID_"> <object
											id=LC_CARD_COMP classid=<%=Util.CLSID_LUXECOMBO%> height=100
											width=135 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
										</td>
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
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>Col=STR_CD           Ctrl=EM_STR_CD          param=Text</c>
        <c>Col=STR_NM           Ctrl=EM_STR_NM          param=Text</c>
        <c>Col=VEN_CD           Ctrl=EM_VEN_CD          param=Text</c>
        <c>Col=VEN_NAME         Ctrl=EM_VEN_NAME        param=Text</c>
        <c>Col=BIZ_TYPE         Ctrl=EM_BIZ_TYPE        param=Text</c>
        <c>Col=COMP_NO          Ctrl=EM_COMP_NO         param=Text</c>
        <c>Col=COMP_NAME        Ctrl=EM_COMP_NAME       param=Text</c>
        <c>Col=REP_NAME         Ctrl=EM_REP_NAME        param=Text</c>
        <c>Col=BIZ_STAT         Ctrl=EM_BIZ_STAT        param=Text</c>
        <c>Col=BIZ_CAT          Ctrl=EM_BIZ_CAT         param=Text</c>
        <c>Col=ADDR             Ctrl=EM_ADDR            param=Text</c>
        <c>Col=PHONE_NO         Ctrl=EM_PHONE_NO        param=Text</c>
        <c>Col=PAY_DT_FLAG      Ctrl=EM_PAY_DT_FLAG     param=Text</c>
        <c>Col=PAY_WAY          Ctrl=EM_PAY_WAY         param=Text</c>
        <c>Col=FAX_NO           Ctrl=EM_FAX_NO          param=Text</c>
        <c>Col=VEN_FLAG         Ctrl=LC_VEN_FLAG        param=BindColVal</c>
        <c>Col=CARD_COMP        Ctrl=LC_CARD_COMP       param=BindColVal</c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

