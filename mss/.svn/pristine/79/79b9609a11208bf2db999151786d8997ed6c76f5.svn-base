<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은행사마스터 > 인정율 마스터관리
 * 작 성 일 : 2011.01.19
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : mcae1040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :  2011.01.19 (김슬기) 신규작성
            2011.02.15 (김유완) 수정개발
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"   %>
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
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                 *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.15
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var top = 145;		//해당화면의 동적그리드top위치
function doInit(){
	
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_APPRATE"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER");
    
    //그리드 초기화
    gridCreate("MST"); //마스터
    
    // EMedit에 초기화  
    initEmEdit(EM_SEL_PUMBUN_CD, "NUMBER3^6^2",NORMAL); // [조회용]브랜드
    initEmEdit(EM_SEL_PUMBUN_NM, "GEN",READ);           // [조회용]품명
    initEmEdit(EM_SEL_APPRATE, "NUMBER^3^0",NORMAL);    // [조회용]인정률
    initEmEdit(EM_APPRATE_CONF, "NUMBER^3^0 ",NORMAL);   // 인정률
    
    //콤보 초기화
    initComboStyle(LC_SEL_STR_CD,DS_LC_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);       // [조회용]점코드     
    initComboStyle(LC_SEL_DEPT_CD,DS_LC_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]팀     
    initComboStyle(LC_SEL_TEAM_CD,DS_LC_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // [조회용]파트    
    initComboStyle(LC_SEL_PC_CD,DS_LC_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);     // [조회용]PC    

    //시스템 코드 공통코드에서 가지고 오기
    getStore("DS_LC_STR_CD", "Y", "1", "N");
    getDept("DS_LC_DEPT_CD", "N", LC_SEL_STR_CD.BindColVal, "Y");
    getTeam("DS_LC_TEAM_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, "Y");
    getPc("DS_LC_PC_CD",     "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, LC_SEL_TEAM_CD.BindColVal, "Y");
    //load 시 기본 포커스
    LC_SEL_STR_CD.Focus();
    LC_SEL_STR_CD.Index = 0;
    LC_SEL_DEPT_CD.Index = 0;
    LC_SEL_TEAM_CD.Index = 0;
    LC_SEL_PC_CD.Index = 0;
    //팀,파트,PC 초기 Load시 비활성화
    //enableControl(LC_SEL_DEPT_CD, false);
    enableControl(LC_SEL_TEAM_CD, false);
    enableControl(LC_SEL_PC_CD, false);
    
    
    //종료시 데이터 변경 체크 (common.js )
    registerUsingDataset("mcae104","DS_IO_MASTER" );
}


function gridCreate(gdGnb){
    //마스터그리드
    if (gdGnb == "MST") {
        var hdrProperies = ''
            + '<FC>ID={CURROW}  NAME="NO"'
            + '                                  WIDTH=40   ALIGN=CENTER</FC>'
            + '<FC>ID=CHK_BOX   NAME=""'
            + '                                  WIDTH=18   ALIGN=CENTER    EDITSTYLE=CHECKBOX  HEADCHECKSHOW=TRUE</FC>'
            + '<C>ID=STR_NM    NAME="점"'
            + '                                  WIDTH=80   ALIGN=LEFT      EDIT="NONE"</C>'
            + '<C>ID=DEPT_NM   NAME="팀"'
            + '                                  WIDTH=80   ALIGN=LEFT      EDIT="NONE"</C>'
            + '<C>ID=TEAM_NM   NAME="파트"'
            + '                                  WIDTH=120  ALIGN=LEFT      EDIT="NONE"</C>'
            + '<C>ID=PC_NM     NAME="PC"'
            + '                                  WIDTH=170  ALIGN=LEFT      EDIT="NONE"</C>'
            + '<C>ID=PUMBUN_CD  NAME="브랜드코드"'
            + '                                  WIDTH=60   ALIGN=CENTER    EDIT="NONE"</C>'
            + '<C>ID=PUMBUN_NM  NAME="브랜드명"'
            + '                                  WIDTH=147  ALIGN=LEFT      EDIT="NONE"</C>'
            + '<C>ID=APP_RATE   NAME="인정률(%)"'
            + '                                  WIDTH=70   ALIGN=RIGHT     EDIT="NUMERIC"</C>';
        initGridStyle(GD_MASTER, "COMMON", hdrProperies, true);
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
 * 작 성 일 : 2011.02.15
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    if (DS_IO_MASTER.IsUpdated) {//변경데이터 있을 시 확인
        var ret = showMessage(Question, YesNo, "USER-1059");
        if (ret == "1") {
		    if (LC_SEL_STR_CD.BindColVal == "") {//점 미선택시
		        showMessage(STOPSIGN, OK, "USER-1003", "점");
		        LC_SEL_STR_CD.Focus();
		        return;
		    }   
		    //parameters
		    var strStrCd = LC_SEL_STR_CD.BindColVal;    // 점코드
		    var strDeptCd = LC_SEL_DEPT_CD.BindColVal;  // 부문
		    var strTeamCd = LC_SEL_TEAM_CD.BindColVal;  // 팀
		    var strPcCd = LC_SEL_PC_CD.BindColVal;      // PC
		    var strPumbunCd = EM_SEL_PUMBUN_CD.Text;    // 브랜드코드
		    var strApprate = EM_SEL_APPRATE.Text        // 인정률
		    
		    var goTo = "getMaster";
		    var parameters = ""
		        + "&strStrCd="      + encodeURIComponent(strStrCd)
		        + "&strDeptCd="     + encodeURIComponent(strDeptCd)
		        + "&strTeamCd="     + encodeURIComponent(strTeamCd)
		        + "&strPcCd="       + encodeURIComponent(strPcCd)
		        + "&strPumbunCd="   + encodeURIComponent(strPumbunCd)
		        + "&strApprate="    + encodeURIComponent(strApprate) ;
		    TR_MAIN.Action = "/mss/mcae104.mc?goTo=" + goTo + parameters;
		    TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";//조회:O 입력:I
		    TR_MAIN.Post();
		    
		    // 조회결과 Return
		    setPorcCount("SELECT", GD_MASTER);
		    //그리드 CHEKCBOX헤더 체크해제
		    GD_MASTER.ColumnProp('CHK_BOX','HeadCheck')= "false";
        } else {
        	return;	
        }
    } else {
        if (LC_SEL_STR_CD.BindColVal == "") {//점 미선택시
            showMessage(STOPSIGN, OK, "USER-1003", "점");
            LC_SEL_STR_CD.Focus();
            return;
        }   
        //parameters
        var strStrCd = LC_SEL_STR_CD.BindColVal;    // 점코드
        var strDeptCd = LC_SEL_DEPT_CD.BindColVal;  // 팀
        var strTeamCd = LC_SEL_TEAM_CD.BindColVal;  // 파트
        var strPcCd = LC_SEL_PC_CD.BindColVal;      // PC
        var strPumbunCd = EM_SEL_PUMBUN_CD.Text;    // 브랜드코드
        var strApprate = EM_SEL_APPRATE.Text        // 인정률
        
        var goTo = "getMaster";
        var parameters = ""
            + "&strStrCd="      + encodeURIComponent(strStrCd)
            + "&strDeptCd="     + encodeURIComponent(strDeptCd)
            + "&strTeamCd="     + encodeURIComponent(strTeamCd)
            + "&strPcCd="       + encodeURIComponent(strPcCd)
            + "&strPumbunCd="   + encodeURIComponent(strPumbunCd)
            + "&strApprate="    + encodeURIComponent(strApprate) ;
        TR_MAIN.Action = "/mss/mcae104.mc?goTo=" + goTo + parameters;
        TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";//조회:O 입력:I
        TR_MAIN.Post();
        
        // 조회결과 Return
        setPorcCount("SELECT", GD_MASTER);
        //그리드 CHEKCBOX헤더 체크해제
        GD_MASTER.ColumnProp('CHK_BOX','HeadCheck')= "false";
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
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.15
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.15
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
 */
function btn_Save() {
    if (DS_IO_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장
    	//인정률 체크
        if (!checkValidate()) return;
    
        //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
            GD_MASTER.Focus();
            return;
        }
    	
        var goTo = "save";
        TR_MAIN.Action = "/mss/mcae104.mc?goTo=" + goTo;
        TR_MAIN.KeyValue = "SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)";
        TR_MAIN.Post();
    } else {
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    //저장 후 재 조회
    btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.15
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.02.15
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011.02.15
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * allRowSetDate()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 선택된 모든 행에 인정률 적용
 * return값 :
 */
function allRowSetDate() {
    for (i=1; i<=DS_IO_MASTER.CountRow; i++) {
        if (DS_IO_MASTER.NameValue(i, "CHK_BOX") == "T") {
            DS_IO_MASTER.NameValue(i, "APP_RATE") = EM_APPRATE_CONF.Text;
        }
    }
}
/**
 * callPopup()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 팝업 호출
 * return값 :
 */
function callPopup(popupNm) {
    if (popupNm == "pumbun") {//브랜드
    	if (LC_SEL_STR_CD.BindColVal == "") {//점 미선택시
    	    showMessage(STOPSIGN, OK, "USER-1003", "점");
    	    LC_SEL_STR_CD.Focus();
    	    return;
    	}  
    
        var strOrgCd = LC_SEL_STR_CD.BindColVal;
        if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
        	strOrgCd +=  "00000000";
        } else {
        	strOrgCd += LC_SEL_DEPT_CD.BindColVal;
        	if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
        		strOrgCd +=  "000000";
        	} else {
	        	strOrgCd += LC_SEL_TEAM_CD.BindColVal;
                if (LC_SEL_PC_CD.BindColVal == "" || LC_SEL_PC_CD.BindColVal == "%") {
                	strOrgCd +=  "0000";
                } else {
                    strOrgCd += LC_SEL_TEAM_CD.BindColVal + "00";
                }
        	}
        }
    	strPbnPop( EM_SEL_PUMBUN_CD, EM_SEL_PUMBUN_NM, 'N', '', LC_SEL_STR_CD.BindColVal, strOrgCd, '','','','','','','','','1');
    }
}


/**
 * checkValidate()
 * 작 성 자 : FKL
 * 작 성 일 : 2011.01.24
 * 개    요 : 값체크(저장)
 * return값 :
 */
function checkValidate() {
	var chkCnt = 0
	for (i=0; i<DS_IO_MASTER.CountRow; i++) {
		if (DS_IO_MASTER.NameValue(i,"CHK_BOX") == "T") {
			chkCnt++
			if (DS_IO_MASTER.NameValue(i,"APP_RATE") > 100 || DS_IO_MASTER.NameValue(i,"APP_RATE") < 0) {
	            setTimeout("DS_IO_MASTER.RowPosition ="+i,100);
	            setTimeout("GD_MASTER.SetColumn('APP_RATE')",100);
	            showMessage(INFORMATION, OK, "USER-1017", "100%초과 또는 공백");
				return false;
			}
		}
	} 
	//체크항목건수체크
	if (chkCnt < 1) {
        showMessage(INFORMATION, OK, "USER-1028");
        return false;
	}
	
    return true;
}
-->
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
 /*   showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
//인정률 변경/입력시
if (colid == "APP_RATE") {
    if (DS_IO_MASTER.RowStatus(row) == 3) {
    	if (olddata != DS_IO_MASTER.NameValue(row, "APP_RATE")) {
			//값이 변경될시 체크
			DS_IO_MASTER.NameValue(row, "CHK_BOX")  = "T";
    	}
    }
}
</script>


<script language="javascript" for=GD_MASTER event=CanColumnPosChange(Row,Colid)>
// 인정률 변경/입력시
    if (Colid == "APP_RATE") {
    	if (DS_IO_MASTER.RowStatus(Row) == 3) {
	    	var strRate = DS_IO_MASTER.NameValue(Row, Colid);
	    	if (eval(strRate) > 100) {
	            showMessage(INFORMATION, OK, "USER-1017", "100%초과");
	            //DS_IO_MASTER.NameValue(Row, Colid) = "100";
	            return false;
	    	} else {
	    		return true;
	    	}
    	}
    }
    return true;
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>

<script language=JavaScript for=EM_SEL_PUMBUN_CD event=OnKillFocus()>
//[조회용]브랜드코드입력 시 자동입력 및 기본체크
//if (EM_SEL_PUMBUN_CD.Text.length > 0 ) {
	 if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_SEL_PUMBUN_NM.Text = "";
        return;
    }   
     
	if (LC_SEL_STR_CD.BindColVal == "") {//점 미선택시
	    EM_SEL_PUMBUN_CD.Text = "";
	    showMessage(STOPSIGN, OK, "USER-1003", "점");
	    LC_SEL_STR_CD.Focus();
	    return;
	} 
	
    //1건 이외의 내역이 조회 시 팝업 호출
    var strOrgCd = LC_SEL_STR_CD.BindColVal;
    if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
        strOrgCd +=  "00000000";
    } else {
        strOrgCd += LC_SEL_DEPT_CD.BindColVal;
        if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
            strOrgCd +=  "000000";
        } else {
            strOrgCd += LC_SEL_TEAM_CD.BindColVal;
            if (LC_SEL_PC_CD.BindColVal == "" || LC_SEL_PC_CD.BindColVal == "%") {
                strOrgCd +=  "0000";
            } else {
                strOrgCd += LC_SEL_TEAM_CD.BindColVal + "00";
            }
        }
    }
	
	//데이터 조회
    setStrPbnNmWithoutPop("DS_O_RESULT", EM_SEL_PUMBUN_CD, EM_SEL_PUMBUN_NM, "N", 1, '', LC_SEL_STR_CD.BindColVal, strOrgCd, '','','','','','','','','1');
//} 
</script>

<!-- 점 OnSelChange() -->
<script language=JavaScript for=LC_SEL_STR_CD event=OnSelChange()>
	EM_SEL_PUMBUN_CD.Text = "";
	EM_SEL_PUMBUN_NM.Text = "";
</script>  

<script language=JavaScript for=EM_SEL_APPRATE event=OnKillFocus()>
//[조회용]인정률 입력이 100을 넘지 않게 체크
if (EM_SEL_APPRATE.Text.length > 0 ) {
    if (EM_SEL_APPRATE.Text > 100) {
    	setTimeout("EM_SEL_APPRATE.Focus()",100);
        EM_SEL_APPRATE.Text = "100";
        showMessage(INFORMATION, OK, "USER-1017", "100%초과");
        return;
    }
}
</script>

<script language=JavaScript for=EM_APPRATE_CONF event=OnKillFocus()>
//인정률 입력이 100을 넘지 않게 체크
if (EM_APPRATE_CONF.Text.length > 0 ) {
    if (EM_APPRATE_CONF.Text > 100) {
        setTimeout("EM_APPRATE_CONF.Focus()",100);
        EM_APPRATE_CONF.Text = "100";
        showMessage(INFORMATION, OK, "USER-1017", "100%초과");
        return;
    }
    //선택된 내역에 인정률 일괄적용
    allRowSetDate();
}
</script>

<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
//헤더 전체 체크/체크해제 컨트롤
	if (bCheck == '1'){ // 전체체크
		GD_MASTER.Redraw = false;
	    for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
	    	DS_IO_MASTER.NameValue(i, "CHK_BOX") = 'T';
	    }
		GD_MASTER.Redraw = true;
	}else{  // 전체체크해제
		GD_MASTER.Redraw = false;
	    for (var i=1; i<=DS_IO_MASTER.CountRow; i++){
	    	DS_IO_MASTER.NameValue(i, "CHK_BOX") = 'F';
	    }
	    GD_MASTER.Redraw = true;
	}
</script>
<script language=JavaScript for=LC_SEL_STR_CD event=OnSelChange()>
//[점]콤보 변경
	//시스템 코드 공통코드에서 가지고 오기
	getDept("DS_LC_DEPT_CD", "N", LC_SEL_STR_CD.BindColVal, "Y");
	if (LC_SEL_STR_CD.BindColVal == "" || LC_SEL_STR_CD.BindColVal == "%") {
		// 팀비활성화   
	    enableControl(LC_SEL_DEPT_CD, false);
	    LC_SEL_DEPT_CD.Index = 0;
		// 파트비활성화   
	    enableControl(LC_SEL_TEAM_CD, false);
	    LC_SEL_TEAM_CD.Index = 0;
		// PC비활성화   
	    enableControl(LC_SEL_PC_CD, false);
	    LC_SEL_PC_CD.Index = 0;
	} else {
        // 팀활성화   
        enableControl(LC_SEL_DEPT_CD, true);
        LC_SEL_DEPT_CD.Index = 0;
        // 파트비활성화   
        enableControl(LC_SEL_TEAM_CD, false);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
	}
</script>
<script language=JavaScript for= LC_SEL_DEPT_CD event=OnSelChange()>
//[팀]콤보 변경
	//시스템 코드 공통코드에서 가지고 오기
	getTeam("DS_LC_TEAM_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, "Y");
    if (LC_SEL_DEPT_CD.BindColVal == "" || LC_SEL_DEPT_CD.BindColVal == "%") {
        // 파트비활성화   
        enableControl(LC_SEL_TEAM_CD, false);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    } else {
        // 파트활성화   
        enableControl(LC_SEL_TEAM_CD, true);
        LC_SEL_TEAM_CD.Index = 0;
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    }
</script>
<script language=JavaScript for= LC_SEL_TEAM_CD event=OnSelChange()>
//[파트]콤보 변경
	//시스템 코드 공통코드에서 가지고 오기
	getPc("DS_LC_PC_CD", "N", LC_SEL_STR_CD.BindColVal, LC_SEL_DEPT_CD.BindColVal, LC_SEL_TEAM_CD.BindColVal, "Y");
    if (LC_SEL_TEAM_CD.BindColVal == "" || LC_SEL_TEAM_CD.BindColVal == "%") {
        // PC비활성화   
        enableControl(LC_SEL_PC_CD, false);
        LC_SEL_PC_CD.Index = 0;
    } else {
        // PC활성화   
        enableControl(LC_SEL_PC_CD, true);
        LC_SEL_PC_CD.Index = 0;
    }
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
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<!-- ===============- ONLOAD용 -->
<comment id="_NSID_"><object id="DS_LC_STR_CD"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_DEPT_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_TEAM_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PC_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

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
						<th width="70" class="point">점</th>
						<td width="105"><comment id="_NSID_"> <object
							id=LC_SEL_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="70">팀</th>
						<td width="105"><comment id="_NSID_"> <object
							id=LC_SEL_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="70">파트</th>
						<td width="105"><comment id="_NSID_"> <object
							id=LC_SEL_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=100 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">PC</th>
						<td><comment id="_NSID_"> <object id=LC_SEL_PC_CD
							classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>브랜드</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_SEL_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:callPopup('pumbun')" align="absmiddle" /> <comment
							id="_NSID_"> <object id=EM_SEL_PUMBUN_NM
							classid=<%=Util.CLSID_EMEDIT%> width=197 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>인정율</th>
						<td colspan="3" align="absmiddle"><comment id="_NSID_">
						<object id=EM_SEL_APPRATE classid=<%=Util.CLSID_EMEDIT%> width=137
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>%
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
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="260">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="120">인정율 일괄적용</th>
						<td width="160" align="absmiddle"><comment id="_NSID_">
						<object id=EM_APPRATE_CONF classid=<%=Util.CLSID_EMEDIT%>
							width=140 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>%
						</td>
					</tr>
				</table>
				</td>
				<td width="5"></td>
				<td align="left"><img src="/<%=dir%>/imgs/btn/sub_apply.gif"
					class="PR03" onclick="javascript:allRowSetDate();"
					align="absmiddle" /></td>
				<td class="right red">**인정율이 등록되지 않은 브랜드은 0% 인정</font></td>  
			</tr>
		</table>
		</td>
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
							id=GD_MASTER width=100% height=735 tabindex=1
							classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</OBJECT></comment><script>_ws_(_NSID_);</script></td>
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
</body>
</html>

