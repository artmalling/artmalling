<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 브랜드코드> PC별브랜드조회순서관리
 * 작 성 일 : 2010.03.04
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod2070.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : PC별브랜드조회순서를 관리한다.
 * 이    력 :
 *        2010.03.04 (정진영) 신규작성
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
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var btnClickSave = false;
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
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');

    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_DEPT_CD.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    DS_TEAM_CD.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    DS_PC_CD.setDataHeader('CODE:STRING(15),NAME:STRING(40)');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //상세

    // EMedit에 초기화

    //콤보 초기화
    initComboStyle(LC_STR_CD,   DS_STR_CD,   "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle(LC_ORG_FLAG, DS_ORG_FLAG, "CODE^0^30,NAME^0^80", 1, READ);  //조직구분(조회)
    initComboStyle(LC_DEPT_CD,  DS_DEPT_CD,  "CODE^0^30,NAME^0^80", 1, NORMAL);  //팀
    initComboStyle(LC_TEAM_CD,  DS_TEAM_CD,  "CODE^0^30,NAME^0^80", 1, NORMAL);  //파트
    initComboStyle(LC_PC_CD,    DS_PC_CD,    "CODE^0^30,NAME^0^80", 1, NORMAL);  //PC
    initComboStyle(LC_USE_YN,   DS_USE_YN,   "CODE^0^30,NAME^0^80", 1, NORMAL);  //사용여부

    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_ORG_FLAG", "D", "P047", "N");
    getEtcCode("DS_USE_YN", "D", "D022", "Y");

    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_ORG_FLAG,'<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />');
    setComboData(LC_USE_YN,'%');
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod207","DS_DETAIL" );
    
    LC_STR_CD.Focus()
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"     width=30   align=center</FC>'
                     + '<FC>id=TEAM_NAME   name="파트"     width=60   align=left</FC>'
                     + '<FG> name="PC" '
                     + '<FC>id=PC_ORG_CD   name="코드"   width=100   align=center</FC>'
                     + '<FC>id=PC_ORG_NAME name="명"     width=100   align=left</FC>'
                     + '</FG>';

    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}     name="NO"        width=30 edit="none" align=center  </FC>'
                     + '<FC>id=SORT_NO      name="정렬;순서"  width=50 edit="Numeric" align=right</FC>'
                     + '<FG> name="브랜드" '
                     + '<FC>id=PUMBUN_CD    name="코드"     width=80 edit="none" align=center</FC>'
                     + '<FC>id=PUMBUN_NAME  name="명"       width=130 edit="none" align=left</FC>'
                     + '</FG>'
                     + '<FG> name="협력사" '
                     + '<FC>id=VEN_CD       name="코드"     width=80 edit="none" align=center</FC>'
                     + '<FC>id=VEN_NAME     name="명"       width=150 edit="none" align=left</FC>'
                     + '</FG>'
                     + '<FG>id=G_CORNER name="코너" '
                     + '<FC>id=CORNER_CD    name="코드"     width=100 edit="none" align=center</FC>'
                     + '<FC>id=CORNER_NAME  name="명"       width=130 edit="none" align=left</FC>'
                     + '</FG>'
                     + '<FC>id=USE_YN      name="사용;여부"  width=45 edit="none" align=center</FC>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
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
function btn_Search() {

    if( LC_STR_CD.BindColVal == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "점");
        LC_STR_CD.Focus();
        return;
    }
    if( LC_ORG_FLAG.BindColVal == '') {
        // ()은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "조직구분");
        LC_ORG_FLAG.Focus();
        return;
    }
    if(DS_DETAIL.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회 하시겠습니까?
        if(showMessage(QUESTION, YESNO, "USER-1059")!= 1){
            setFocusGrid(GD_DETAIL,DS_DETAIL,DS_DETAIL.RowPosition,"SORT_NO");
            return ;       
        }
    }
    searchMaster();
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

    // 저장할 데이터 없는 경우
    if (!DS_DETAIL.IsUpdated  ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_MASTER.CountRow < 1){
        	LC_STR_CD.Focus();
        	return;
        }
        setFocusGrid(GD_DETAIL,DS_DETAIL,DS_DETAIL.RowPosition,"SORT_NO");
        return;
    }
    
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','01','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        setFocusGrid(GD_DETAIL,DS_DETAIL,DS_DETAIL.RowPosition,"SORT_NO");
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        setFocusGrid(GD_DETAIL,DS_DETAIL,DS_DETAIL.RowPosition,"SORT_NO");
        return;    	
    }

    var strStrCd = LC_STR_CD.BindColVal;
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd);
    btnClickSave = true;
    TR_MAIN.Action="/dps/pcod207.pc?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    btnClickSave = false;

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        searchDetail();
        GD_MASTER.Focus();
    }
    GD_MASTER.Focus();
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
  * searchMaster
  * 작 성 자 : 
  * 작 성 일 : 2010-03-04
  * 개    요 : 마스터을 조회한다.
  * return값 : void
 **/
 function searchMaster() {

     DS_MASTER.ClearData();
     DS_DETAIL.ClearData();
     
     var strStrCd = LC_STR_CD.BindColVal;
     var strOrgFlag = LC_ORG_FLAG.BindColVal;
     var strOrgCd = strStrCd;
     
     if(LC_DEPT_CD.BindColVal != '%'){
    	 strOrgCd += LC_DEPT_CD.BindColVal;
         if(LC_TEAM_CD.BindColVal != '%'){
             strOrgCd += LC_TEAM_CD.BindColVal;
             if(LC_PC_CD.BindColVal != '%'){
                 strOrgCd += LC_PC_CD.BindColVal;
             }
         }
     }
     
     var goTo       = "searchMaster" ;    
     var action     = "O";
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    + "&strOrgCd="+encodeURIComponent(strOrgCd)
                    + "&strOrgFlag="+encodeURIComponent(strOrgFlag);
     TR_MAIN.Action="/dps/pcod207.pc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
     TR_MAIN.Post();
     
     //조회후 결과표시
     setPorcCount("SELECT",GD_MASTER); 
 }
 

 /**
  * searchDetail
  * 작 성 자 : 
  * 작 성 일 : 2010-03-02
  * 개    요 : 상세내역을 조회한다.
  * return값 : void
 **/
 function searchDetail() {

     if( LC_STR_CD.BindColVal == '') {
         // ()은/는 반드시 입력해야 합니다.
         showMessage(EXCLAMATION, OK, "USER-1003", "점");
         LC_STR_CD.Focus();
         return;
     }
     if( LC_ORG_FLAG.BindColVal == '') {
         // ()은/는 반드시 입력해야 합니다.
         showMessage(EXCLAMATION, OK, "USER-1003", "조직구분");
         LC_ORG_FLAG.Focus();
         return;
     }

     var strStrCd = LC_STR_CD.BindColVal;
     var strOrgFlag = LC_ORG_FLAG.BindColVal;
     var strOrgCd = DS_MASTER.NameValue( DS_MASTER.RowPosition, "PC_ORG_CD");
     var strUseYn = LC_USE_YN.BindColVal;

     DS_DETAIL.ClearData();
         
     var goTo       = "searchDetail" ;    
     var action     = "O";
     var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    + "&strOrgFlag="+encodeURIComponent(strOrgFlag)
                    + "&strOrgCd="+encodeURIComponent(strOrgCd)
                    + "&strUseYn="+encodeURIComponent(strUseYn);
     TR_SUB.Action="/dps/pcod207.pc?goTo="+goTo+parameters;  
     TR_SUB.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
     TR_SUB.Post();

     //조회후 결과표시
     setPorcCount("SELECT",GD_DETAIL); 
 }
 
 
function applySort() { 
	
	if(DS_DETAIL.CountRow > 0) {
		for(var i=1;i<=DS_DETAIL.CountRow;i++)
		{
			DS_DETAIL.NameValue(i,"SORT_NO") = i;
		}
	}
	
}
 
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

<script language=JavaScript for=TR_SUB event=onSuccess>
    for(i=0;i<TR_SUB.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SUB.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
  

<script language=JavaScript for=TR_SUB event=onFail>
    trFailed(TR_SUB.ErrorMsg);
</script>
  
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<script language=JavaScript for=DS_MASTER event=CanRowPosChange(row)>
    if(DS_DETAIL.IsUpdated && !btnClickSave){
    	// 변경된 상세내역이 존재합니다. 이동 하시겠습니까?
        if(showMessage(QUESTION, YESNO, "USER-1049")!= 1){
            setFocusGrid(GD_DETAIL,DS_DETAIL,DS_DETAIL.RowPosition,"SORT_NO");
            return false;       
        }
    }
    return true;
</script>
<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if( row > 0 ) { 
        searchDetail();
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //if(colid == "{currow}" && row == "0") fn_sortChange();
    
    sortColId( eval(this.DataID), row , colid );
    
</script>
 

<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    DS_DEPT_CD.ClearData();
    DS_TEAM_CD.ClearData();
    DS_PC_CD.ClearData();
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "Y");
    LC_DEPT_CD.Index = 0;
    //setComboData(LC_DEPT_CD,'%');
</script>
<script language=JavaScript for=LC_ORG_FLAG event=OnSelChange()>
    DS_MASTER.ClearData();
    DS_DETAIL.ClearData();
    if(  this.BindColVal == '1'  ){
    	GD_DETAIL.ColumnProp("G_CORNER", "Show") = true;
    }else{
        GD_DETAIL.ColumnProp("G_CORNER", "Show") = false;
    }
</script>

<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    DS_TEAM_CD.ClearData();
    DS_PC_CD.ClearData();
    
    if( this.BindColVal == '%'){
        insComboData(LC_TEAM_CD, "%", "전체", 1 );;
        setComboData(LC_TEAM_CD,'%');
        return;    	
    }
    
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");
    LC_TEAM_CD.Index = 0;
    //setComboData(LC_TEAM_CD,'%');
</script>

<script language=JavaScript for=LC_TEAM_CD event=OnSelChange()>
    DS_PC_CD.ClearData();

    if( this.BindColVal == '%'){
        insComboData(LC_PC_CD, "%", "전체", 1 );;
        setComboData(LC_PC_CD,'%');
        return;     
    }
    getPc("DS_PC_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, LC_TEAM_CD.BindColVal, "Y");
    LC_PC_CD.Index = 0;
    //setComboData(LC_PC_CD,'%');
</script>
<script language=JavaScript for=LC_PC_CD event=OnSelChange()>
</script>
<script language=JavaScript for=LC_USE_YN event=OnSelChange()>
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
<object id="DS_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_PC_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
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
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_DETAIL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_SUB" classid=<%=Util.CLSID_TRANSACTION%>>
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
						<td width="150"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=150
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">조직구분</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=150
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">팀</th>
						<td><comment id="_NSID_"> <object id=LC_DEPT_CD
							classid=<%= Util.CLSID_LUXECOMBO %> width=150 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th>파트</th>
						<td><comment id="_NSID_"> <object id=LC_TEAM_CD
							classid=<%= Util.CLSID_LUXECOMBO %> width=150 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>PC</th>
						<td><comment id="_NSID_"> <object id=LC_PC_CD
							classid=<%= Util.CLSID_LUXECOMBO %> width=150 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>사용여부</th>
						<td><comment id="_NSID_"> <object id=LC_USE_YN
							classid=<%= Util.CLSID_LUXECOMBO %> width=150 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/apply.gif"
                     	onclick="applySort();" align="absmiddle"" /></td>
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
			<tr>
				<td width="300">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><object id=GD_MASTER
							width=100% height=479 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_MASTER">
						</object></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><object id=GD_DETAIL
							width=100% height=479 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_DETAIL">
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

</body>
</html>

