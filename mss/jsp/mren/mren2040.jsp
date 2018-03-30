<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 계약관리 > 임대차계약현황
 * 작 성 일 : 2010.01.14
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : MREN2040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 시설구분별관리기준
 * 이    력 : 2010.01.14(박래형) 신규작성
           2010.04.14 (김유완) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir"); 
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
   
	// Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MR_CNTRMST"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate(); 
   
    // COMBO 초기화,EM 초기화
    initComboStyle(LC_S_FCL_FLAG,DS_LC_FCL_FLAG,            "CODE^0^30,NAME^0^80", 1, PK);      // [조회용]시설구분(점코드) 
    initEmEdit(EM_S_VEN_CD,     "NUMBER3^6^0",NORMAL);                                          // [조회용]협력사
    initEmEdit(EM_S_VEN_NM,     "GEN",READ);                                                    // [조회용]협력사명
    initComboStyle(LC_S_RENT_TYPE,  DS_LC_S_RENT_TYPE,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // [조회용]임대형태
    DS_LC_S_RENT_TYPE.Filter();                                                                 // [조회용]임대형태 필터링
    DS_LC_S_RENT_TYPE.SortExpr = "+" + "CODE";
    DS_LC_S_RENT_TYPE.Sort();
    initComboStyle(LC_S_RENT_FLAG,  DS_LC_S_RENT_FLAG,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // [조회용]임대구분
    LC_S_RENT_FLAG.Enable = false;
    initComboStyle(LC_S_CNTR_TYPE,  DS_LC_S_CNTR_TYPE,      "CODE^0^30,NAME^0^80", 1, NORMAL);  // [조회용]계약유형
    initEmEdit(EM_S_DT,         "YYYYMMDD",READ);                                               // [조회용]기간S
    initEmEdit(EM_E_DT,         "YYYYMMDD",READ);                                               // [조회용]기간E
    
    
    
    //시스템 코드 공통코드에서 가지고 오기
    getFlc("DS_LC_FCL_FLAG",            "M", "1", "Y", "N");                    // [조회용]시설구분(점코드) 
    LC_S_FCL_FLAG.index = 0;                   
    LC_S_FCL_FLAG.Focus();          
    
    getEtcCode("DS_LC_S_RENT_TYPE",     "D", "P003", "Y", "N", LC_S_RENT_TYPE); // [조회용]임대형태      
    getEtcCode("DS_LC_S_RENT_FLAG",     "D", "P084", "Y", "N", LC_S_RENT_FLAG); // [조회용]임대구분      
    getEtcCode("DS_LC_S_CNTR_TYPE",     "D", "M042", "Y", "N", LC_S_CNTR_TYPE); // [조회용]계약유형      
    
}

function gridCreate() {
    var hdrProperies = '<FC>ID={CURROW}    NAME="NO" 		WIDTH=30    ALIGN=CENTER</FC>'
    				 + '<G> NAME="계약정보"'
    				 + '<C>ID=STR_CD       NAME="시설구분" 	WIDTH=130   ALIGN=CENTER	EDITSTYLE=LOOKUP	DATA="DS_LC_FCL_FLAG:CODE:NAME" </C>'                 
    				 + '<C>ID=CNTR_ID      NAME="계약ID" 	WIDTH=70    ALIGN=CENTER</C>'
                     + '<C>ID=VEN_CD       NAME="협력사코드"	WIDTH=70    ALIGN=CENTER</C>'
                     + '<C>ID=VEN_NM       NAME="협력사명"	WIDTH=150   ALIGN=LEFT</C>'
                     + '<C>ID=COMP_NO      NAME="사업자번호"	WIDTH=90   ALIGN=CENTER	MASK="XXX-XX-XXXXX"</C>'
                     + '<C>ID=REP_NAME     NAME="대표자"		WIDTH=80   ALIGN=LEFT</C>'
                     + '<C>ID=PHONE_NO     NAME="전화번호"	WIDTH=100   ALIGN=LEFT</C>'
                     + '<C>ID=BELONG_STR_CD       NAME="소속시설" 	WIDTH=130   ALIGN=CENTER	EDITSTYLE=LOOKUP	DATA="DS_LC_FCL_FLAG:CODE:NAME" </C>'                 
                     + '<C>ID=CHAR_NAME     NAME="담당자"		WIDTH=80   ALIGN=LEFT</C>'
                     + '<C>ID=PHONE_NO2     NAME="전화번호"	WIDTH=100   ALIGN=LEFT</C>'
                     + '<C>ID=CNTR_TYPE     NAME="계약유형"		WIDTH=60   ALIGN=CENTER</C>'
                     + '<C>ID=SAP_CNTR_ID     NAME="계약번호"		WIDTH=70   ALIGN=LEFT</C>'
                     + '<C>ID=CNTR_S_DT     NAME="계약시작일"		WIDTH=80   ALIGN=CENTER MASK="XXXX-XX-XX"</C>'
                     + '<C>ID=CNTR_E_DT     NAME="계약종료일"		WIDTH=80   ALIGN=CENTER MASK="XXXX-XX-XX"</C>'
                     + '<C>ID=RENT_TYPE     NAME="임대형태"		WIDTH=130   ALIGN=CENTER</C>'
                     + '<C>ID=RENT_FLAG     NAME="임대구분"		WIDTH=70   ALIGN=CENTER</C>'
                     + '<C>ID=CNTR_AREA     NAME="계약면적"		WIDTH=70   ALIGN=RIGHT</C>'
                     + '<C>ID=EXCL_AREA     NAME="전용면적"		WIDTH=70   ALIGN=RIGHT</C>'
                     + '<C>ID=SHR_AREA     NAME="공유면적"		WIDTH=70   ALIGN=RIGHT</C>'
                     + '<C>ID=RENT_DEPOSIT     NAME="임대보증금"		WIDTH=120   ALIGN=RIGHT</C>'
                     + '<C>ID=MM_RENTFEE     NAME="월임대료"		WIDTH=120   ALIGN=RIGHT</C>'
                     + '<C>ID=DONG     NAME="동"		WIDTH=50   ALIGN=CENTER</C>'
                     + '<C>ID=FLOOR_FLAG     NAME="층"		WIDTH=50   ALIGN=CENTER</C>'
                     + '<C>ID=HO     NAME="호"		WIDTH=50   ALIGN=CENTER</C>'
                     + '<C>ID=FILE_PATH     NAME="첨부파일"		WIDTH=200   ALIGN=LEFT</C>'
                     + '<C>ID=FCL_TYPE     NAME="임대시설종류"		WIDTH=80   ALIGN=CENTER</C>'
                     + '</G>'
                     + '<G> NAME="관리비부과정보"'
                     + '<C>ID=MNTN_CAL_YN     NAME="계산여부"		WIDTH=80   ALIGN=CENTER</C>'
                     + '<C>ID=CHRG_YN     NAME="청구내역관리여부"		WIDTH=100   ALIGN=CENTER</C>'
                     + '<C>ID=ARR_CAL_YN     NAME="연체계산여부"		WIDTH=80   ALIGN=CENTER</C>'
                     + '<C>ID=ARR_RATE     NAME="연체율(%)"		WIDTH=80   ALIGN=RIGHT</C>'
                     + '<C>ID=PAY_TERM_TYPE     NAME="납부구분"		WIDTH=80   ALIGN=CENTER</C>'
                     + '<C>ID=PAY_TERM_DD     NAME="납부기한일자"		WIDTH=80   ALIGN=CENTER</C>'
                     + '</G>'
                     + '<G> NAME="임대료부과정보"'
                     + '<C>ID=RENT_CAL_YN     NAME="계산여부"		WIDTH=80   ALIGN=CENTER</C>'
                     + '<C>ID=RENT_ARR_CAL_YN     NAME="연체계산여부"		WIDTH=80   ALIGN=CENTER</C>'
                     + '<C>ID=RENT_ARR_RATE     NAME="연체율(%)"		WIDTH=80   ALIGN=RIGHT</C>'
                     + '<C>ID=RENT_PAY_TERM_TYPE     NAME="납부구분"		WIDTH=80   ALIGN=CENTER</C>'
                     + '<C>ID=RENT_PAY_TERM_DD     NAME="납부기한일자"		WIDTH=80   ALIGN=CENTER</C>'                     
                     + '</G>'
                     ;
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
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
 * 작 성 일 : 2010.04.14
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search(row) {
	 
	if (!searchValidate()) return;
    
	var strFlcFlag  = LC_S_FCL_FLAG.BindColVal; // [조회용]시설구분(점코드)
    var strVenCd    = EM_S_VEN_CD.Text;         // [조회용]협력사
    var strStayNow  = "N";                      // [조회용]현거주여부
    if (CHK_STAY_NOW.checked) {
        strStayNow = "Y";
    }
    var strRentType = LC_S_RENT_TYPE.BindColVal;// [조회용]임대형태
    var strRentFlag = LC_S_RENT_FLAG.BindColVal;// [조회용]임대구분
    var strCntrType = LC_S_CNTR_TYPE.BindColVal;// [조회용]계약유형
    var strIOFlag   = LC_S_IN_OUT.BindColVal;   // [조회용]조회기간구분
    var strSdt      = EM_S_DT.Text;             // [조회용]기간S
    var strEdt      = EM_E_DT.Text;             // [조회용]기간E
            
    var goTo = "getMaster";
    var parameters = ""
        + "&strFlcFlag="    + encodeURIComponent(strFlcFlag)
        + "&strVenCd="      + encodeURIComponent(strVenCd)
        + "&strStayNow="    + encodeURIComponent(strStayNow)
        + "&strRentType="   + encodeURIComponent(strRentType)
        + "&strRentFlag="   + encodeURIComponent(strRentFlag)
        + "&strCntrType="   + encodeURIComponent(strCntrType)
        + "&strIOFlag="     + encodeURIComponent(strIOFlag)
        + "&strSdt="        + encodeURIComponent(strSdt)
        + "&strEdt="        + encodeURIComponent(strEdt);
    TR_MAIN.Action = "/mss/mren204.mr?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
    TR_MAIN.Post();
            
            // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);

}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.14
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
   
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.14
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
   
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * searchValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 값체크(저장)
 * return값 :
 */
function searchValidate() {
    // 시설구분
    if (LC_S_FCL_FLAG.BindColVal == "" || LC_S_FCL_FLAG.BindColVal == "%") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
        LC_S_FCL_FLAG.Focus();
        return;
    }  
    
    if (LC_S_IN_OUT.BindColVal != "%") {
	    // 기간(F)
	    if ((EM_S_DT.Text).length < 8) {
	        showMessage(INFORMATION, OK, "USER-1002", "조회기간(FROM)");
	        EM_S_DT.Focus();
	        return false;
	    }
	    
	    // 기간(T)
	    if ((EM_E_DT.Text).length < 8) {
	        showMessage(INFORMATION, OK, "USER-1002", "조회기간(TO)");
	        EM_E_DT.Focus();
	        return false;
	    }
	    
	    //전출일 등록
	    if ((EM_S_DT.Text).length == 8) {
	        if (EM_S_DT.Text > EM_E_DT.Text) {
	            showMessage(INFORMATION, OK, "USER-1000", "조회기간(TO)는 조회기간(FROM) 이후로 입력하세요.");
	            EM_E_DT.Focus();
	            return false;
	        } 
	    }
	}
    
    return true;
}
 
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.19
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    
	 if (popupNm == "sVen") { //[조회용]협력사
		if (LC_S_FCL_FLAG.BindColVal == ""
		    || LC_S_FCL_FLAG.BindColVal == "%") {//시설구분 미선택시
			showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
			LC_S_FCL_FLAG.Focus();
			  return;
		}

        var strOrgFlag = "2";
        var strBizType = "";
        
        venPop(EM_S_VEN_CD, EM_S_VEN_NM, LC_S_FCL_FLAG.BindColVal,"", "", strBizType, strOrgFlag, "", "T");
    }
}

function btn_Excel() {

    if(DS_IO_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "임대차 계약현황";

    var strFlcFlag  = LC_S_FCL_FLAG.Text; // [조회용]시설구분(점코드)
    var strVenCd    = EM_S_VEN_CD.Text;         // [조회용]협력사
    var strVenNm    = EM_S_VEN_NM.Text;         // [조회용]협력사
    
    var strStayNow  = "";                      // [조회용]현거주여부
    if (CHK_STAY_NOW.checked) {
        strStayNow = "* 현계약만조회";
    }
    var strRentType = LC_S_RENT_TYPE.Text;// [조회용]임대형태
    var strRentFlag = LC_S_RENT_FLAG.Text;// [조회용]임대구분
    var strCntrType = LC_S_CNTR_TYPE.Text;// [조회용]계약유형
    var strIOFlag   = LC_S_IN_OUT.Text;   // [조회용]조회기간구분
    var strSdt      = EM_S_DT.Text;             // [조회용]기간S
    var strEdt      = EM_E_DT.Text;             // [조회용]기간E
    
    var parameters = "" +strStayNow
    	           + "시설구분 "                   + strFlcFlag
                   + ",   협력사 "             + strVenCd
                   + " "                    + strVenNm
                   + ",   임대형태 "             + strRentType
                   + ",   임대구분 "             + strRentFlag
                   + ",   계약유형 "             + strCntrType
                   + ",   조회기간구분 "             + strIOFlag
                   + ",   조회기간 "          + strSdt + "~" + strEdt
                   ;
    
    openExcel2(GD_MASTER, strTitle, parameters, true );
    
}
 

-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝-
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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


<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=LC_S_IN_OUT event=OnSelChange()>
//조회조건초기화
if (LC_S_IN_OUT.BindColVal == "%") {
    EM_S_DT.Text = "";
    EM_E_DT.Text = "";
    EM_S_DT.Enable      = false;           
    EM_E_DT.Enable      = false;           
    enableControl(IMG_S_DT,false); // 조회기간 비활성화(팝업)
    enableControl(IMG_E_DT,false); // 조회기간 비활성화(팝업)
} else {
    initEmEdit(EM_S_DT,         "SYYYYMMDD",NORMAL); // [조회용]기간S
    initEmEdit(EM_E_DT,         "EYYYYMMDD",NORMAL); // [조회용]기간E
    enableControl(IMG_S_DT,true); // 조회기간 비활성화(팝업)
    enableControl(IMG_E_DT,true); // 조회기간 비활성화(팝업)
}
</script>


<script language=JavaScript for=DS_LC_CNTR_TYPE event=OnFilter(row)>
// 계약유형 필터
if (g_cntrFilter) {
    if (DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"CNTR_TYPE") == "01") {
        if (DS_LC_CNTR_TYPE.NameValue(row,"CODE") == "03") {
            return false;
        } else { 
            return true;
        }
    } else if (DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"CNTR_TYPE") == "02") {
        if (DS_LC_CNTR_TYPE.NameValue(row,"CODE") == "02") {
            return true;
        } else { 
            return false;
        }
    } else if (DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,"CNTR_TYPE") == "03") {
        if (DS_LC_CNTR_TYPE.NameValue(row,"CODE") == "01") {
            return false;
        } else { 
            return true;
        }
    } else {
    	return true;
    }
} else {
    return true;
}

</script>

<script language=JavaScript for=LC_S_RENT_TYPE event=OnSelChange()>
//[조회용]임대형태 - 임대을일 경우만 임대구분선택가능
if (LC_S_RENT_TYPE.BindColVal == "3") {
	LC_S_RENT_FLAG.Enable = true;
	LC_S_RENT_FLAG.Index = 0;
} else {
	LC_S_RENT_FLAG.Enable = false;
	LC_S_RENT_FLAG.Index = 0;
}
</script>

<script language=JavaScript for=DS_LC_S_RENT_TYPE event=OnFilter(row)>
// [조회용]임대형태
if (DS_LC_S_RENT_TYPE.NameValue(row,"CODE") == "%" 
		|| DS_LC_S_RENT_TYPE.NameValue(row,"CODE") == "3" 
		|| DS_LC_S_RENT_TYPE.NameValue(row,"CODE") == "4"
		|| DS_LC_S_RENT_TYPE.NameValue(row,"CODE") == "5"
		) { //임대갑, 임대을만
    return true;
} else { 
    return false;
}
</script>

<script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//[조회용]협력사 코드 자동완성 및 팝업호출
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_S_VEN_NM.Text = "";
        return;
    }
    
    if (LC_S_FCL_FLAG.BindColVal == "") {//점 미선택시
        showMessage(STOPSIGN, OK, "USER-1003", "시설구분");
        LC_S_FCL_FLAG.Focus();
        return;
    }
    
    var strOrgFlag = "2";
    var strBizType = "";
    
    
    //단일건 체크 
    setVenNmWithoutPop("DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM , 1, LC_S_FCL_FLAG.BindColVal, "", "", strBizType, strOrgFlag, "", "T");
</script>
    
<!-- 시설구분 OnSelChange() -->
<script language=JavaScript for=LC_S_FCL_FLAG event=OnSelChange()>
    EM_S_VEN_CD.Text = "";
    EM_S_VEN_NM.Text = "";
</script>


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용  -->
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_FCL_FLAG"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_LC_S_RENT_FLAG"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_S_CNTR_TYPE"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- 임대형태  -->
<comment id="_NSID_">
<object id="DS_LC_S_RENT_TYPE"    classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter   value=true>
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<iframe id=iFrame name=iFrame src="about:blank" width=0 height=0></iframe>
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
						<th class="point" width="80">시설구분</th>
						<td width="120"><comment id="_NSID_"> <object
							id=LC_S_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width="120"
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">협력사</th>
						<td width="205"><comment id="_NSID_"> <object
							id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup('sVen')" align="absmiddle" /> <comment
							id="_NSID_"> <object id=EM_S_VEN_NM
							classid=<%=Util.CLSID_EMEDIT%> width=110 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="90">현계약만조회</th>
						<td><input type="checkbox" id="CHK_STAY_NOW" tabindex=1></td>
					</tr>
					<tr>
						<th>임대형태</th>
						<td><comment id="_NSID_"> <object id=LC_S_RENT_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> width="120" tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>임대구분</th>
						<td><comment id="_NSID_"> <object id=LC_S_RENT_FLAG
							classid=<%=Util.CLSID_LUXECOMBO%> width="200" tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th>계약유형</th>
						<td><comment id="_NSID_"> <object id=LC_S_CNTR_TYPE
							classid=<%=Util.CLSID_LUXECOMBO%> width="120" tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>조회기간구분</th>
						<td><comment id="_NSID_"> <object id=LC_S_IN_OUT
							classid=<%=Util.CLSID_LUXECOMBO%> width="120" height=120
							tabindex=1 align="absmiddle">
							<param name=CBData value="%^전체,1^계약시작일,2^계약종료일">
							<param name=CBDataColumns value="CODE,NAME">
							<param name=SearchColumn value="NAME">
							<param name=ListExprFormat value="CODE^2^30,NAME^1^100">
							<param name=BindColumn value="CODE">
							<param name=Index value="0">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>조회기간</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_S_DT classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object> </comment> <script>_ws_(_NSID_);</script> <img id=IMG_S_DT
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_S_DT)" /> ~ <comment
							id="_NSID_"> <object id=EM_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1 align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this);"> </object> </comment> <script>_ws_(_NSID_);</script>
						<img id=IMG_E_DT src="/<%=dir%>/imgs/btn/date.gif"
							align="absmiddle" onclick="javascript:openCal('G',EM_E_DT)" /></td>
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
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td width="100%"><comment id="_NSID_"><OBJECT
							id=GD_MASTER width=100% height=454 tabindex=1
							classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</OBJECT></comment> <script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</body>
</html>
