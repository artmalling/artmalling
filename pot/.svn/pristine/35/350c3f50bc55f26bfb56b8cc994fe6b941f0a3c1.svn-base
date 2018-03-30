<%
/*******************************************************************************
  * 시스템명  : MDI 기초 페이지
  * 작 성 일 : 2010.09.18
  * 작 성 자 : 엄준석
  * 수 정 자 :
  * 파 일 명 : mdiFrame.jsp
  * 버    전 : 1.0
  * 개    요 : MDI 페이지의 기본 페이지
  * 이    력 :
  *****************************************************************************/
%>
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce40"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<link href="/pot/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/pot/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/pot/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/pot/js/gauce.js"   type="text/javascript"></script>
<script language="javascript"  src="/pot/js/message.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                          *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                          *-->
<!--*************************************************************************-->
<script>//try{frame = window.external.GetFrame(window);} catch(e) { alert(e); }</script>
<script type="text/javascript">

var f = document.all;
var objMasterFrame; // 마스터 프레임 지역 변수
var mdiNum = 0;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
  * onStart()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.09.18
  * 개    요 : 페이지 처음 오픈시 실행
  * return값 : void
*/
function onStart(){
	//frame.jsp 에 정의 되어 있는 Ajax DB 일자 가져오기 실행(MDI 경우)
//	setFrameDBTodayMDI();
	// MDI 윈도우 정보를 저장할 데이터셋 정의
	// 2011.08.04 L_CODE ADD(MARIO OUTLET)
	DS_MdiInfo.SetDataHeader("PG_ID:STRING,PG_NM:STRING,PG_URL:STRING,MDI_ID:STRING,DS_NO:STRING,BT_PER:STRING,L_CODE:STRING,REG_DATASET:STRING");

	// 마스터 프레임 정의
	objMasterFrame = document.getElementById("PT_MdiForm").Provider;

	// MDI 데이터셋 기본 세팅
	for (var i = 1; i <= 11; i++) {
		DS_MdiInfo.AddRow();
		DS_MdiInfo.NameValue(i, "DS_NO") = i;
	}


	/* 메인 화면 세팅 */
	var programUrl = "tcom101.tc";
	var programID = "list";
	var programNM = "메인화면";
	var button = "10000000";
	// 2011.08.04 L_CODE ADD(MARIO OUTLET)
	var lcode = "";
	var url = "/pot/"+programUrl+"?goTo="+programID;


	try{
		// 초기화면 MDI 데이터셋에 정보 세팅 - 2011.08.04 lcode ADD(MARIO OUTLET)
		fn_setMdiDataSet(1, "mainPage", programID, programNM, url, button, lcode );
//		parent.mainFrame.fn_CreateWin(programID,programNM,url);

	} catch(e) {}

	// 화면하단 MDI 윈도우 타이틀 세팅
//	parent.topFrame.setMdiPopupInfo();

	// 자식 윈도우 상태 변경 시  fn_getWinStat 호출 설정
	objMasterFrame.SetEvent("onwinstat", fn_getWinStat);

	// 상태바 Setting
	window.status   = "";
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
  * showStatusBar()
  * 작 성 자 : 정지인
  * 작 성 일 : 2010.05.08
  * 개    요 : 상태바에 표시하는 함수
  * return값 : void
  */
function showStatusBar(strMsg){
	window.status = strMsg;
}

/**
  * fn_getOpenMdiPopupCount()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.10.08
  * 개    요 : 열려있는 MDI Window 갯수를 구한다.
  * return값 : void
*/
function fn_getOpenMdiPopupCount() {
	objMasterFrame.ChildWndCollection();
	return objMasterFrame.CollectionLength;
}

/**
  * fn_CreateWin()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.09.18
  * 개    요 : MDI Window 신규 생성/갱신
  * return값 : void
*/
function fn_CreateWin(pg_id, pg_nm, pg_url, bt_per, l_title, l_code){

	var actMdiId; // 활성화 MDI 창
	var row = 0;
	var popupLimitCnt = 11; // MDI 팝업 제한 갯수
	var strMdiId = new Date().getTime() + ""; // MDI창 ID 생성

	// 내부적으로 새창열기 기능을 가져가기 위해 창 갯수에 따라 자동 플래그 처리
/*	if (fn_getOpenMdiPopupCount() >= popupLimitCnt) {
		parent.leftFrame.SH_POPUPVIEW.checked = false;
	} else {
		parent.leftFrame.SH_POPUPVIEW.checked = true;
	}
*/
	row = DS_MdiInfo.NameValueRow("PG_ID", pg_id);

	// 새창열기 옵션에 체크했거나 열린창이 한개도 없을 경우
	//if (parent.leftFrame.SH_POPUPVIEW.checked || objMasterFrame.CollectionLength == 0) {
		// 해당창이 존재하지 않을 경우만 생성
		if (row < 1) {
			// 프로그램 최대 실행가능 갯수 체크
			if (fn_getOpenMdiPopupCount() >= popupLimitCnt) {
				//showMessage(Information, OK, "USER-1000","화면은 최대 10개까지만 가능합니다.<br>다른 화면을 종료 후  시도하세요");
				
				//활성화된 팝업창 넘버
				var strMdiRow = fn_getActiveMdiPopup();
				
				//작업중
				strMdiIdTemp = DS_MdiInfo.NameValue(strMdiRow, "MDI_ID");
				
				//alert("strMdiRow : " + strMdiRow + "\nstrMdiIdTemp : " + strMdiIdTemp + "\npg_url : " + pg_url);
				
				objMasterFrame.Provider("/" + strMdiIdTemp).srcUrl = pg_url;
				objMasterFrame.Provider("/" + strMdiIdTemp).FrameModify("border",0);
				objMasterFrame.Provider("/" + strMdiIdTemp).FrameShow("maximize");
				
				// MDI 데이터셋에 정보 세팅 - 2011.08.04 l_code add(MARIO OUTLET)
				fn_setMdiDataSet(strMdiRow, strMdiIdTemp, pg_id, pg_nm, pg_url, bt_per, l_code);
				
				// 화면하단 MDI 윈도우 타이틀 세팅
				parent.topFrame.setMdiPopupInfo();
				objMasterFrame.Provider("/" + strMdiIdTemp).FrameModify("sysmenu",0);
				
			} else {

				// 비어있는 MDI 공간 찾기
				for (var i = 1; i <= DS_MdiInfo.CountRow; i++) {
					if (DS_MdiInfo.NameValue(i, "MDI_ID") == "") {
						dsNum = i;
						break;
					}
				}
			
				objMasterFrame.CreateFrame(strMdiId, pg_url, pg_nm, 0, 0, "100%", "100%", "window",0, "showmaximized", true);
				// 최대화되면 타이틀바 보이지 않도록 설정
				objMasterFrame.Provider("/" + strMdiId).ShowMaxCaption= false;
				// 윈도우 상태 변경 이벤트 발생시 부모님께 연락드리도록 설정
				objMasterFrame.Provider("/" + strMdiId).EventChainEnable= true;
	
				//로딩바 시작 - 2011.08.05 COMMENT 처리
				//searchSetWait("S");
	
				// MDI 데이터셋에 정보 세팅 - 2011.08.04 l_code add(MARIO OUTLET)
				fn_setMdiDataSet(dsNum, strMdiId, pg_id, pg_nm, pg_url, bt_per, l_code);
	
				//로딩바 끝 - 2011.08.05 COMMENT 처리
				//searchDoneWait();
	
				// 화면하단 MDI 윈도우 타이틀 세팅
				parent.topFrame.setMdiPopupInfo();
				objMasterFrame.Provider("/" + strMdiId).FrameModify("sysmenu",0);
	
			}
			
			return true;

		// 해당창이 존재
		} else {
			//해당창을 닫고 다시연다.
			if(pg_id == "DCTM112" || pg_id == "DCTM201" || pg_id == "DCTM203" || pg_id == "DMBO622"){
				fn_destroyMdiPopup(row);
			
				// 프로그램 최대 실행가능 갯수 체크
				if (fn_getOpenMdiPopupCount() >= popupLimitCnt) {
					//showMessage(Information, OK, "USER-1000","화면은 최대 10개까지만 가능합니다.<br>다른 화면을 종료 후  시도하세요");
					
					//활성화된 팝업창 넘버
					var strMdiRow = fn_getActiveMdiPopup();
					
					//작업중
					strMdiIdTemp = DS_MdiInfo.NameValue(strMdiRow, "MDI_ID");
					
					//alert("strMdiRow : " + strMdiRow + "\nstrMdiIdTemp : " + strMdiIdTemp + "\npg_url : " + pg_url);
					
					objMasterFrame.Provider("/" + strMdiIdTemp).srcUrl = pg_url;
					objMasterFrame.Provider("/" + strMdiIdTemp).FrameModify("border",0);
					objMasterFrame.Provider("/" + strMdiIdTemp).FrameShow("maximize");
					
					// MDI 데이터셋에 정보 세팅 - 2011.08.04 l_code add(MARIO OUTLET)
					fn_setMdiDataSet(strMdiRow, strMdiIdTemp, pg_id, pg_nm, pg_url, bt_per, l_code);
					
					// 화면하단 MDI 윈도우 타이틀 세팅
					parent.topFrame.setMdiPopupInfo();
					objMasterFrame.Provider("/" + strMdiIdTemp).FrameModify("sysmenu",0);
					
				} else {
	
					// 비어있는 MDI 공간 찾기
					for (var i = 1; i <= DS_MdiInfo.CountRow; i++) {
						if (DS_MdiInfo.NameValue(i, "MDI_ID") == "") {
							dsNum = i;
							break;
						}
					}
				
					objMasterFrame.CreateFrame(strMdiId, pg_url, pg_nm, 0, 0, "100%", "100%", "window",0, "showmaximized", true);
					// 최대화되면 타이틀바 보이지 않도록 설정
					objMasterFrame.Provider("/" + strMdiId).ShowMaxCaption= false;
					// 윈도우 상태 변경 이벤트 발생시 부모님께 연락드리도록 설정
					objMasterFrame.Provider("/" + strMdiId).EventChainEnable= true;
		
					//로딩바 시작 - 2011.08.05 COMMENT 처리
					//searchSetWait("S");
		
					// MDI 데이터셋에 정보 세팅 - 2011.08.04 l_code add(MARIO OUTLET)
					fn_setMdiDataSet(dsNum, strMdiId, pg_id, pg_nm, pg_url, bt_per, l_code);
		
					//로딩바 끝 - 2011.08.05 COMMENT 처리
					//searchDoneWait();
		
					// 화면하단 MDI 윈도우 타이틀 세팅
					parent.topFrame.setMdiPopupInfo();
					objMasterFrame.Provider("/" + strMdiId).FrameModify("sysmenu",0);
		
				}
				
				return true;
				
			//해당창을 갱신한다.	
			} else {			

				actMdiId = objMasterFrame.ActiveFrame.FrameID; // 활성 MDI 창
				strMdiId = DS_MdiInfo.NameValue(row, "MDI_ID");

				// 이미 활성화된 창이 새로 활성화시키려는 창과 같을때는 새로 갱신
				if (actMdiId == strMdiId) {

					//objMasterFrame.Provider("/" + actMdiId).srcUrl = pg_url;
					//objMasterFrame.Provider("/" + actMdiId).Title = pg_nm;

				// 이미 활성화된 창이 새로 활성화시키려는 창과 다를때는 새로 활성화
				} else {

					objMasterFrame.Provider("/" + strMdiId).FrameShow("maximize");

				}

				// 화면하단 MDI 윈도우 타이틀 세팅
				parent.topFrame.setMdiPopupInfo();
				objMasterFrame.Provider("/" + strMdiId).FrameModify("sysmenu",0);

				return false;				
			}

		}
	//}
}

/**
 * fn_getButtonPermission()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010.05.26
 * 개    요 : MDI Window 활성화
 * return값 : void
*/
function fn_getButtonPermission(strPId){

	var row = DS_MdiInfo.NameValueRow("PG_ID", strPId.toUpperCase());
	if( row < 1)
		return;
	return DS_MdiInfo.NameValue( row, "BT_PER" );
}

/**
 * fn_getButtonPermission()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010.05.26
 * 개    요 : MDI Window 활성화
 * return값 : void
*/
function fn_getProgramName(strPId){

	var row = DS_MdiInfo.NameValueRow("PG_ID", strPId.toUpperCase());
	if( row < 1)
		return;
	return DS_MdiInfo.NameValue( row, "PG_NM" );
}

/**
 * fn_getWinStat()
 * 작 성 자 : 정지인
 * 작 성 일 : 2010.05.26
 * 개    요 : 자식 MDI창 Window 활성화 된 경우 Tab 설정변경
 * return값 : void
*/
function fn_getWinStat(strID, winstat){
	if(winstat == "activate"){
		if(DS_MdiInfo.NameValue(2, "MDI_ID").length > 1 ){
			for (var i = 1; i <= DS_MdiInfo.CountRow; i++) {
				if (DS_MdiInfo.NameValue(i, "MDI_ID") == strID){
					parent.topFrame.ActiveMdiPopupStyle(DS_MdiInfo.NameValue(i,"DS_NO"));
					//setTimeout("parent.topFrame.ActiveMdiPopupStyle(DS_MdiInfo.NameValue(" + i + ", 'DS_NO'))", 100);
				}
			}
		}
	}
}

/*
function fn_getWinStat(strID, winstat){
	if(winstat == "activate"){
		// 2011.08.05 LOGIN 후 SERVER에서 SCRIPT ERROR 발생에 대한 대응.
		if(DS_MdiInfo.NameValue(2, "MDI_ID").length > 1 ){
			for (var i = 1; i <= DS_MdiInfo.CountRow; i++) {
				if (DS_MdiInfo.NameValue(i, "MDI_ID") == strID){
					//세션 저장
					// MARIO OUTLET START 2011.08.04 -- COMMENT 삭제
					var parameters = "&strBtnPer=" + DS_MdiInfo.NameValue(DS_MdiInfo.NameValue(i, "DS_NO"), "BT_PER")   //버튼권한
							   + "&strTitle="  + encodeURIComponent(DS_MdiInfo.NameValue(DS_MdiInfo.NameValue(i, "DS_NO"), "PG_NM")) //프로그램명
							   + "&strPid="    + DS_MdiInfo.NameValue(DS_MdiInfo.NameValue(i, "DS_NO"), "PG_ID")    //프로그램ID
							   ;

					DS_SESSION.DataID = "/pot/tcom001.tc?goTo=setSession"+parameters;
					DS_SESSION.SyncLoad = "true";
					DS_SESSION.Reset();
					// MARIO OUTLET START 2011.08.04  -- COMMENT 삭제

					if(DS_MdiInfo){
						parent.topFrame.ActiveMdiPopupStyle(DS_MdiInfo.NameValue(i, "DS_NO"));
					}
				}

			}
		}
	}
}
*/

/**
  * fn_activeMdiPopup()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.10.05
  * 개    요 : MDI Window 활성화
  * return값 : void
*/
function fn_activeMdiPopup(row) {
	  
	var strMdiId = DS_MdiInfo.NameValue(row, "MDI_ID");
	
	if(row==1 && strMdiId=="mainPage") {
		objMasterFrame.Provider("/" + strMdiId).srcUrl = "/pot/tcom001.tc?goTo=mainFrame";
	}

	objMasterFrame.Provider("/" + strMdiId).FrameModify("border",0);
	objMasterFrame.Provider("/" + strMdiId).FrameShow("maximize");

	// 상태바 Setting
	window.status   = "";
}

/**
 * 로고 선택시 메인 팝업 호출
 * 1. 전체창 닫기
 * 2. 메인창 호출
 */
function fn_activeMdiClear() {
	
	//전체 자식 윈도우 닫기
	objMasterFrame.CloseFrameAll();

	// MDI Dataset 초기화
	for (var i = 1; i <= DS_MdiInfo.CountRow; i++) {
		fn_setMdiDataSet(i, "", "", "", "", "", "");
	}
	
	setTimeout("fn_activeMdiMainCreate()", 100);
}

/**
 * 메인 화면 셋팅
 */
function fn_activeMdiMainCreate() {
	var pg_nm = "메인화면";
	var pg_url = "/pot/tcom001.tc?goTo=mainFrame";
	var strMdiId = "mainPage";
	var dsNum = 1;
	
	//alert("dsNum : " + dsNum + "\nstrMdiId : " + strMdiId + "\npg_url : " + pg_url + "\npg_nm : " + pg_nm);
	
	//자식창 생성
	objMasterFrame.CreateFrame(strMdiId, pg_url, pg_nm, 0, 0, "100%", "100%", "window",0, "showmaximized", true);

	// 최대화되면 타이틀바 보이지 않도록 설정
	objMasterFrame.Provider("/" + strMdiId).ShowMaxCaption= false;
	
	// 윈도우 상태 변경 이벤트 발생시 부모님께 연락드리도록 설정
	objMasterFrame.Provider("/" + strMdiId).EventChainEnable= true;

	// MDI 데이터셋에 정보 세팅 - 2011.08.04 l_code add(MARIO OUTLET)
	fn_setMdiDataSet(dsNum, strMdiId, "list", pg_nm, pg_url, "10000000", "");
	
	// 화면하단 MDI 윈도우 타이틀 세팅
	parent.topFrame.setMdiPopupInfo();
	objMasterFrame.Provider("/" + strMdiId).FrameModify("sysmenu",0);	
}

/**
  * fn_registerUsingDataset()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.10.05
  * 개    요 : MDI Window 활성화
  * return값 : void
*/
function fn_registerUsingDataset(strPId, dataSetStr){

	var row = DS_MdiInfo.NameValueRow("PG_ID", strPId.toUpperCase());
	if( row < 1)
		return;
	DS_MdiInfo.NameValue( row, "REG_DATASET" ) = dataSetStr;
}

/**
  * fn_destroyMdiPopup()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.10.05
  * 개    요 : MDI Window 제거(닫기)
  * return값 : void
*/
function fn_destroyMdiPopup(row) {

	var strMdiId = DS_MdiInfo.NameValue(row, "MDI_ID");
	var dataSetList = DS_MdiInfo.NameValue(row, "REG_DATASET");

	var modifYn = false;
	if( dataSetList != ""){
		var dataSetArr = dataSetList.split(',');
		for(var i=0,len=dataSetArr.length; i < len; i++){
			try{
				var dataSet = eval("objMasterFrame.Provider('/" + strMdiId+"')."+dataSetArr[i]);
				if(dataSet.CountRow < 1)
					continue;
				if(dataSet.isUpdated){
					modifYn = true;
					break;
				}
			}catch(e){}
		}
	}
	if( modifYn ){
		if( showMessage(QUESTION, YESNO, "USER-1095") !=1){
			objMasterFrame.Provider("/" + strMdiId).FrameShow("maximize");
			return;
		}
	}
	objMasterFrame.Provider("/" + strMdiId).FrameShow("maximize");
	objMasterFrame.ActiveFrame.CloseFrame();

	// MDI 데이터셋 정보 세팅
	for (var i = row; i <= DS_MdiInfo.CountRow; i++) {

		if (i == DS_MdiInfo.CountRow) {

			DS_MdiInfo.NameValue(i, "PG_ID") = "";
			DS_MdiInfo.NameValue(i, "PG_NM") = "";
			DS_MdiInfo.NameValue(i, "PG_URL") = "";
			DS_MdiInfo.NameValue(i, "MDI_ID") = "";
			DS_MdiInfo.NameValue(i, "BT_PER") = "";

		} else {

			DS_MdiInfo.NameValue(i, "PG_ID") = DS_MdiInfo.NameValue(i + 1, "PG_ID");
			DS_MdiInfo.NameValue(i, "PG_NM") = DS_MdiInfo.NameValue(i + 1, "PG_NM");
			DS_MdiInfo.NameValue(i, "PG_URL") = DS_MdiInfo.NameValue(i + 1, "PG_URL");
			DS_MdiInfo.NameValue(i, "MDI_ID") = DS_MdiInfo.NameValue(i + 1, "MDI_ID");
			DS_MdiInfo.NameValue(i, "BT_PER") = DS_MdiInfo.NameValue(i + 1, "BT_PER");
			DS_MdiInfo.NameValue(i, "REG_DATASET") = DS_MdiInfo.NameValue(i + 1, "REG_DATASET");

		}
	}

	parent.topFrame.setMdiPopupInfo();
}

/**
  * fn_setMdiDataSet()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.10.05
  * 개    요 : MDI Dataset 세팅
  * return값 : void
  * 2011.08.04 lcode ADD(MARIO OUTLET)
*/
function fn_setMdiDataSet(dsNum, mdiId, pgId, pgNm, pgUrl, btPer, lcode) {

	var row = DS_MdiInfo.NameValueRow("DS_NO", dsNum);

	DS_MdiInfo.NameValue(row, "PG_ID") = pgId;
	DS_MdiInfo.NameValue(row, "PG_NM") = pgNm;
	DS_MdiInfo.NameValue(row, "PG_URL") = pgUrl;
	DS_MdiInfo.NameValue(row, "MDI_ID") = mdiId;
	DS_MdiInfo.NameValue(row, "BT_PER") = btPer;
	DS_MdiInfo.NameValue(row, "L_CODE") = lcode;

}

/**
  * fn_initMdiDataSet()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.10.04
  * 개    요 : MDI 팝업 Dataset 초기화
  * return값 : void
*/
function fn_initMdiDataSet() {

	// MDI Dataset 초기화
	for (var i = 1; i <= DS_MdiInfo.CountRow; i++) {

		fn_setMdiDataSet(i, "", "", "", "", "", "");
	}

	// 화면상단 MDI 윈도우 타이틀 세팅
	parent.topFrame.setMdiPopupInfo();

}

/**
  * fn_getActiveMdiPopup()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010.10.05
  * 개    요 : MDI Window DS_NO 를 구한다.
  * return값 : int
*/
function fn_getActiveMdiPopup() {

	var actMdiId = objMasterFrame.ActiveFrame.FrameID; // 활성 MDI 창

	return DS_MdiInfo.NameValueRow("MDI_ID", actMdiId); // 기존 pg_id

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

<script language=JavaScript for=TR_Search event=OnSuccess()>
	trCompleted(TR_Search, true);
</script>

<script language=JavaScript for=TR_Search event=OnFail()>
	trCompleted(TR_Search,false);
</script>

<script language=JavaScript for=DS_HIGH_MENU_AUTH event=OnLoadCompleted(rowcnt)>
	queryCompleted(rowcnt, DS_HIGH_MENU_AUTH);

	if (DS_HIGH_MENU_AUTH.CountRow > 0) {
		for (var i = 1; i <= DS_HIGH_MENU_AUTH.CountRow; i++) {
			HIGH_MENU_AUTH[i - 1] = DS_HIGH_MENU_AUTH.NameValue(i, "PRG_GRP");
		}
	}
</script>



<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리     끝                                                                                                  *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                         *-->
<!--*    1. DataSet                                                         *-->
<!--*    2. Transaction                                                     *-->
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
	<object id="DS_MdiInfo" classid="<%=Util.CLSID_DATASET%>"></object>
</comment>
<script> _ws_(_NSID_);</script>

<comment id="_NSID_">
	<!--세션 -->
	<object id="DS_SESSION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                           *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                       *-->
<!--*************************************************************************-->

<BODY onload="onStart();" scroll="no">
<!-- 클라이언트 윈도 영역 (Potential 컴포넌트) -->
<object id="PT_MdiForm" classid="<%=Util.CLSID_POTENTIAL%>" style="width:100%; height:100%;">
	<param name="src" value= "/pot/jsp/portal.jsp">
</object>
<!-- 클라이언트 윈도 영역 (Potential 컴포넌트) // -->

</BODY>
</html>
