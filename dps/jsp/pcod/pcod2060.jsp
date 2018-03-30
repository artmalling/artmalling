<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 브랜드코드> 브랜드이동조회
 * 작 성 일 : 2010.03.04
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pcod2060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 브랜드이동내역을 조회한다.
 * 이    력 :
 *        2010.03.04 (이재득) 작성
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
<!--* A. 로그인 유무, 기본설정                                                *-->
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
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var strStrCd      = "";
var strOrgFlag    = "";     
var strProcYn     = "";
var strBfDeptCd   = "";
var strBfTeamCd   = "";
var strBfPcCd     = "";
var strAftDeptCd  = "";
var strAftTeamCd  = "";
var strAftPcCd    = "";
var strStratDt    = "";
var strEndDt      = "";
var strPumBunCd   = "";
var strPumBunNm   = "";
var g_strPid           = "<%=pageName%>";                 // PID

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_I_PUM_COND.setDataHeader(
            'STR_CD:STRING(2)'
            +',ORG_FLAG:STRING(1)'
            +',PROC_YN:STRING(1)'
            +',BF_DEPT_CD:STRING(2)'
            +',BF_TEAM_CD:STRING(2)'
            +',BF_PC_CD:STRING(2)'
            +',AFT_DEPT_CD:STRING(2)'
            +',AFT_TEAM_CD:STRING(2)'
            +',AFT_PC_CD:STRING(2)'
            +',START_DT:STRING(8)'
            +',END_DT:STRING(8)'
            +',PUMBUN_CD:STRING(6)'
            +',PUMBUN_NM:STRING(6)'); 
    DS_I_PUM_COND.ClearData();
    DS_I_PUM_COND.Addrow();

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_APP_S_DT,  "TODAY",   PK);  // 조회기간1
    initEmEdit(EM_APP_E_DT,    "TODAY",   PK);  // 조회기간2
    initEmEdit(EM_O_PUMBUN_CD, "CODE^6^0", NORMAL); //브랜드코드
    initEmEdit(EM_O_PUMBUN_NM, "GEN^40", NORMAL);   //브랜드명

    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_O_ORG_FLAG,DS_O_ORG_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //조직구분(조회)
    initComboStyle(LC_O_PROC_YN,DS_O_PROC_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);  //처리여부
    initComboStyle(LC_O_BF_DEPT_CD,DS_O_BF_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //변경전 팀
    initComboStyle(LC_O_BF_TEAM_CD,DS_O_BF_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //변경점 파트
    initComboStyle(LC_O_BF_PC_CD,DS_O_BF_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //변경전 PC
    initComboStyle(LC_O_AF_DEPT_CD,DS_O_AF_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //변경전 팀
    initComboStyle(LC_O_AF_TEAM_CD,DS_O_AF_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //변경점 파트
    initComboStyle(LC_O_AF_PC_CD,DS_O_AF_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //변경전 PC

    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_BF_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_BF_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_BF_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_AF_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_AF_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_AF_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_O_STR_CD", "Y", "", "N");
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_ORG_FLAG", "D", "P047", "N");    
    getEtcCode("DS_O_PROC_YN",  "D", "D022", "Y"); 
    getEtcCode("DS_I_ORG_FLAG", "D", "P047", "N");
    
    EM_APP_S_DT.Text = EM_APP_S_DT.Text.substring(0,6)+'01';
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_O_STR_CD.Index < 0){
        LC_O_STR_CD.Index= 0;
    }
    setComboData(LC_O_ORG_FLAG,"1");
    setComboData(LC_O_PROC_YN,"%");
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}            name="NO"         width=30   align=center</FC>'
		             + '<FC>id=STR_CD              name="점"          width=80   align=center  show=false</FC>'
                     + '<FC>id=MOD_DT              name="변경일자"       width=90   align=center   Mask="XXXX/XX/XX"</FC>'
    	             + '<FG>                       name="브랜드" '
                     + '<FC>id=PUMBUN_CD           name="코드"         width=60    align=center</FC>'
                     + '<FC>id=PUMBUN_NAME         name="명"          width=150   align=left</FC>'
                     + '</FG>'
                     + '<FC>id=ORG_FLAG            name="조직구분"       width=100   align=left    EditStyle=Lookup    Data="DS_I_ORG_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=PROC_YN             name="적용여부"       width=60   align=center</FC>'
                     + '<FG>                       name="변경전" '
                     + '<FC>id=MOD_BF_ORG_CD       name="조직코드"       width=90   align=center</FC>'
                     + '<FC>id=MOD_BF_ORG_NM       name="조직명"        width=200   align=left</FC>'
                     + '<FC>id=MOD_BF_ORG_SRT_NM   name="조직명"        width=200   align=left  show=false</FC>'
                     + '<FC>id=MOD_BF_BUYER_CD     name="바이어(SM)코드"         width=100   align=center</FC>'
                     + '<FC>id=MOD_BF_BUYER_NM     name="바이어(SM)명"          width=100   align=left</FC>'
                     + '</FG>'
                     + '<FG>                       name="변경후" '
                     + '<FC>id=MOD_AFT_ORG_CD      name="조직코드"       width=90   align=center</FC>'
                     + '<FC>id=MOD_AFT_ORG_NM      name="조직명"        width=200   align=left</FC>'
                     + '<FC>id=MOD_AFT_ORG_SRT_NM  name="조직명"        width=200   align=left  show=false</FC>'
                     + '<FC>id=MOD_AFT_BUYER_CD    name="바이어(SM)코드"         width=100   align=center</FC>'
                     + '<FC>id=MOD_AFT_BUYER_NM    name="바이어(SM)명"          width=100   align=left</FC>'
                     + '</FG>';

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
 * 작 성 일 : 2010.03.04
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(EM_APP_S_DT.Text > EM_APP_E_DT.Text){       // 조회일 정합성
        showMessage(INFORMATION, OK, "USER-1015");
        EM_APP_E_DT.Text = EM_APP_S_DT.Text;
        EM_APP_S_DT.Focus();
        return ;
    }
	if (EM_APP_S_DT.Text == "" || EM_APP_E_DT.Text == ""){
		showMessage(INFORMATION, OK, "GAUCE-1005", "변경일");    // 조회일 필수입력체크
		if (EM_APP_S_DT.Text == ""){
			EM_APP_S_DT.Text = EM_APP_E_DT.Text;
			EM_APP_S_DT.Focus();
		}else
			EM_APP_E_DT.Focus();
		
	    return ;
	}
	
	DS_IO_MASTER.ClearData();
    DS_I_PUM_COND.UserStatus(1) = '1';
    
    strStrCd      = LC_O_STR_CD.Text;
    strOrgFlag    = LC_O_ORG_FLAG.Text;     
    strProcYn     = LC_O_PROC_YN.Text;
    strBfDeptCd   = LC_O_BF_DEPT_CD.Text;
    strBfTeamCd   = LC_O_BF_TEAM_CD.Text;
    strBfPcCd     = LC_O_BF_PC_CD.Text;
    strAftDeptCd  = LC_O_AF_DEPT_CD.Text;
    strAftTeamCd  = LC_O_AF_TEAM_CD.Text;
    strAftPcCd    = LC_O_AF_PC_CD.Text;
    strStratDt    = EM_APP_S_DT.Text;
    strEndDt      = EM_APP_E_DT.Text;
    strPumBunCd   = EM_O_PUMBUN_CD.Text;
    strPumBunNm   = EM_O_PUMBUN_NM.Text;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";    
    TR_MAIN.Action="/dps/pcod206.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_I_PUM_COND=DS_I_PUM_COND,"+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();  
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.04
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.04
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.04
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.04
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	if (strPumBunCd == "")
		strPumBunCd = "전체";
    if (strPumBunNm == "")
    	strPumBunNm = "전체";
      
    var parameters = "점="+strStrCd
                   + " -조직구분="+strOrgFlag                                     
                   + " -변경전팀="+strBfDeptCd
                   + " -변경전파트="+strBfTeamCd
                   + " -변경전PC="+strBfPcCd
                   + " -변경후팀="+strAftDeptCd
                   + " -변경후파트="+strAftTeamCd
                   + " -변경후PC="+strAftPcCd
                   + " -조회일부터="+strStratDt
                   + " -조회일까지="+strEndDt
                   + " -브랜드코드="+strPumBunCd
                   + " -브랜드명="+strPumBunNm
                   + " -처리여부="+strProcYn;
      
  //openExcel2(GD_MASTER, "브랜드이동조회", parameters, true );
  openExcel5(GD_MASTER, "브랜드이동조회", parameters, true , "",g_strPid );

  GD_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.04
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010.03.04
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    DS_O_BF_TEAM_CD.ClearData();
    DS_O_BF_PC_CD.ClearData();
    DS_O_AF_TEAM_CD.ClearData();
    DS_O_AF_PC_CD.ClearData();
    
    getDept("DS_O_BF_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "",
            LC_O_ORG_FLAG.BindColVal);
    getDept("DS_O_AF_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "",
            LC_O_ORG_FLAG.BindColVal);
    
    if(DS_O_BF_DEPT_CD.CountRow < 1){
        insComboData(LC_O_BF_DEPT_CD, "%", "전체", 1);       
    }
    if(DS_O_AF_DEPT_CD.CountRow < 1){
        insComboData(LC_O_AF_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_BF_DEPT_CD.Index = 0;
    LC_O_AF_DEPT_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_BF_DEPT_CD event=OnSelChange>
    DS_O_BF_TEAM_CD.ClearData();
    DS_O_BF_PC_CD.ClearData();    
    if (this.BindColVal == '%'){
        insComboData(LC_O_BF_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_BF_TEAM_CD, "%");
        return;     
    }
    getTeam("DS_O_BF_TEAM_CD", "N", LC_O_STR_CD.BindColVal, LC_O_BF_DEPT_CD.BindColVal, "Y", "",LC_O_ORG_FLAG.BindColVal);

    if(DS_O_BF_TEAM_CD.CountRow < 1){
        insComboData(LC_O_BF_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_BF_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_BF_TEAM_CD event=OnSelChange>
    DS_O_BF_PC_CD.ClearData(); 
    if (this.BindColVal == '%'){
        insComboData(LC_O_BF_PC_CD, "%", "전체", 1);
        setComboData(LC_O_BF_PC_CD, "%");
        return;     
    }
    getPc("DS_O_BF_PC_CD", "N", LC_O_STR_CD.BindColVal, LC_O_BF_DEPT_CD.BindColVal, LC_O_BF_TEAM_CD.BindColVal, "Y", "",LC_O_ORG_FLAG.BindColVal);

    if(DS_O_BF_PC_CD.CountRow < 1){
        insComboData(LC_O_BF_PC_CD, "%", "전체", 1);       
    }
    LC_O_BF_PC_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_AF_DEPT_CD event=OnSelChange>
    DS_O_AF_TEAM_CD.ClearData();
    DS_O_AF_PC_CD.ClearData();    
    if (this.BindColVal == '%'){
        insComboData(LC_O_AF_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_AF_TEAM_CD, "%");
        return;     
    }
    getTeam("DS_O_AF_TEAM_CD", "N", LC_O_STR_CD.BindColVal, LC_O_AF_DEPT_CD.BindColVal, "Y", "",LC_O_ORG_FLAG.BindColVal);

    if(DS_O_AF_TEAM_CD.CountRow < 1){
        insComboData(LC_O_AF_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_AF_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_AF_TEAM_CD event=OnSelChange>
    DS_O_AF_PC_CD.ClearData(); 
    if (this.BindColVal == '%'){
        insComboData(LC_O_AF_PC_CD, "%", "전체", 1);
        setComboData(LC_O_AF_PC_CD, "%");
        return;     
    }
    getPc("DS_O_AF_PC_CD", "N", LC_O_STR_CD.BindColVal, LC_O_AF_DEPT_CD.BindColVal, LC_O_AF_TEAM_CD.BindColVal, "Y", "",LC_O_ORG_FLAG.BindColVal);

    if(DS_O_AF_PC_CD.CountRow < 1){
        insComboData(LC_O_AF_PC_CD, "%", "전체", 1);       
    }
    LC_O_AF_PC_CD.Index = 0;
</script>


<!-- 협력사코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD  event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_PUMBUN_NM.Text = "";
        return;
    }  
    setStrPbnNmWithoutPop( "DS_O_PUM_CD", this, EM_O_PUMBUN_NM, '0');
</script>

<!-- 적용시작일 -->
<script language=JavaScript for=EM_APP_S_DT event=onKillFocus()>
    if(!checkDateTypeYMD(this,getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')))))
        return;
</script>
<!-- 적용종료일 -->
<script language=JavaScript for=EM_APP_E_DT event=onKillFocus()>
    if(!checkDateTypeYMD(this,getRawData(addDate('D',0,getTodayFormat('YYYYMMDD'))),"DS_IO_MASTER","APP_E_DT"))
        return;
</script>

<!-- 조회기간 종료일 변경시 기간체크-->
<script language=JavaScript for=EM_APP_E_DT event=onSetFocus()>
if(EM_APP_S_DT.Text > EM_APP_E_DT.Text){
    EM_APP_E_DT.Text = EM_APP_S_DT.Text;
    showMessage(INFORMATION, OK, "USER-1015");  
}
</script>
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_BF_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_BF_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_BF_PC_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_AF_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_AF_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_AF_PC_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PROC_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PUM_COND" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
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
						<td width="165"><comment id="_NSID_"> <object id=LC_O_STR_CD
							classid=<%= Util.CLSID_LUXECOMBO %> width=165 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">변경일</th>
						<td colspan="3"><comment id="_NSID_"> <object
							id=EM_APP_S_DT classid=<%=Util.CLSID_EMEDIT%> width=80
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
							onclick="javascript:openCal('G',EM_APP_S_DT)" align="absmiddle" />
						~ <comment id="_NSID_"> <object id=EM_APP_E_DT
							classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle">
						</object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
							onclick="javascript:openCal('G',EM_APP_E_DT)" align="absmiddle" />
						</td>
					</tr>
					<tr>
						<th width="80">조직구분</th>
						<td width="165"><comment id="_NSID_"> <object id=LC_O_ORG_FLAG
							classid=<%= Util.CLSID_LUXECOMBO %> width=165 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">브랜드</th>
						<td width="170"><comment id="_NSID_"> <object id=EM_O_PUMBUN_CD
							classid=<%= Util.CLSID_EMEDIT %> width=55 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: strPbnPop(EM_O_PUMBUN_CD, EM_O_PUMBUN_NM,'N'); EM_O_PUMBUN_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_PUMBUN_NM classid=<%= Util.CLSID_EMEDIT %> width=80
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">적용여부</th>
						<td><comment id="_NSID_"> <object id=LC_O_PROC_YN
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80">변경전 팀</th>
						<td><comment id="_NSID_"> <object
							id=LC_O_BF_DEPT_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100
							width=165 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">파트</th>
						<td><comment id="_NSID_"> <object
							id=LC_O_BF_TEAM_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100
							width=165 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						<th width="80">PC</th>
						<td><comment id="_NSID_"> <object id=LC_O_BF_PC_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<th width="80">변경후 팀</th>
					<td><comment id="_NSID_"> <object id=LC_O_AF_DEPT_CD
						classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
						align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					<th width="80">파트</th>
					<td><comment id="_NSID_"> <object id=LC_O_AF_TEAM_CD
						classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
						align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					<th width="80">PC</th>
					<td><comment id="_NSID_"> <object id=LC_O_AF_PC_CD
						classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=431 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
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
<object id=BO_PUM_COND classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_I_PUM_COND>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=STR_CD          ctrl=LC_O_STR_CD          param=BindColVal </c>            
            <c>col=ORG_FLAG        ctrl=LC_O_ORG_FLAG        param=BindColVal </c>
            <c>col=PROC_YN         ctrl=LC_O_PROC_YN         param=BindColVal </c>            
            <c>col=BF_DEPT_CD      ctrl=LC_O_BF_DEPT_CD      param=BindColVal </c>            
            <c>col=BF_TEAM_CD      ctrl=LC_O_BF_TEAM_CD      param=BindColVal </c>
            <c>col=BF_PC_CD        ctrl=LC_O_BF_PC_CD        param=BindColVal </c>            
            <c>col=AFT_DEPT_CD     ctrl=LC_O_AF_DEPT_CD      param=BindColVal </c>            
            <c>col=AFT_TEAM_CD     ctrl=LC_O_AF_TEAM_CD      param=BindColVal </c>
            <c>col=AFT_PC_CD       ctrl=LC_O_AF_PC_CD        param=BindColVal </c>            
            <c>col=START_DT        ctrl=EM_APP_S_DT        param=Text </c>
            <c>col=END_DT          ctrl=EM_APP_E_DT          param=Text </c>
            <c>col=PUMBUN_CD       ctrl=EM_O_PUMBUN_CD       param=Text </c>
            <c>col=PUMBUN_NM       ctrl=EM_O_PUMBUN_NM       param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

