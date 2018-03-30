<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > POS기준정보> 판매사원조회
 * 작 성 일 : 2010.05.03
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod8060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 판매사원(POS사용자) 정보를 조회한다
 * 이    력 :
 *        pcod8060 (정진영) 신규작성
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

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var excelStr;
 var excelOrgCd;
 var excelOrgName;
 var excelSaleUserId;
 var excelEmpName;
 var excelPosAuthFlag;
 var excelEmpFlag;
 var excelPumbunCd;
 var excelPumbunName;
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

    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_ORG_CD      , "CODE^10" ,  NORMAL);  //조직코드
    initEmEdit(EM_ORG_NAME    , "GEN^40"  ,  NORMAL);  //조직명
    initEmEdit(EM_SALE_USER_ID, "CODE^9"  ,  NORMAL);  //사원번호
    initEmEdit(EM_EMP_NAME    , "GEN^10"  ,  NORMAL);  //사원명
    initEmEdit(EM_PUMBUN_CD   , "CODE^6^0",  NORMAL);  //브랜드코드
    initEmEdit(EM_PUMBUN_NAME , "GEN^40"  ,  NORMAL);  //브랜드명

    //콤보 초기화 
    initComboStyle(LC_STR_CD       , DS_STR_CD       , "CODE^0^30,NAME^0^140" , 1, PK);      //점(조회)
    initComboStyle(LC_POS_AUTH_FLAG, DS_POS_AUTH_FLAG, "CODE^0^30,NAME^0^180", 1, NORMAL);  //권한구분(조회)
    initComboStyle(LC_EMP_FLAG     , DS_EMP_FLAG     , "CODE^0^30,NAME^0^110", 1, NORMAL);  //사원구분(조회)

    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_POS_AUTH_FLAG"   , "D", "P083", "Y");
    getEtcCode("DS_EMP_FLAG"        , "D", "P025", "Y");
    /*
    getEtcCode("DS_I_POS_AUTH_FLAG" , "D", "P083", "N");
    getEtcCode("DS_I_EMP_FLAG"      , "D", "P025", "N");
    getEtcCode("DS_I_LUNAR_FLAG"    , "D", "P085", "N");
    */
    // 점코드 조회
    getStore("DS_STR_CD"  , "N", "1", "N");
    getStore("DS_I_STR_CD", "N", "1", "N");
    
    // 전점 추가(gauce.js )
    insComboData(LC_STR_CD,"**","전점");
    DS_I_STR_CD.AddRow();
    DS_I_STR_CD.NameValue(DS_I_STR_CD.CountRow, "CODE") = "**";
    DS_I_STR_CD.NameValue(DS_I_STR_CD.CountRow, "NAME") = "전점";
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_POS_AUTH_FLAG,'%');
    setComboData(LC_EMP_FLAG,'%');
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            width=30   align=center name="NO"                </FC>'
                     + '<FC>id=STR_CD              width=70   align=left   name="점"                EditStyle=Lookup data="DS_I_STR_CD:CODE:NAME" </FC>'
                     + '<FC>id=EMP_FLAG_NAME       width=110  align=left   name="사원구분"          </FC>'
                     + '<FC>id=SALE_USER_ID        width=80   align=center name="사원번호 "          </FC>'
                     + '<FC>id=EMP_NAME            width=100  align=left   name="사원명 "           </FC>'
                     + '<FC>id=PWD_NO              width=80   align=center name="패스워드 "          </FC>'
                     + '<FG>name="조직"'
                     + '<FC>id=ORG_CD              width=95  align=center name="코드 "              EditStyle=Popup</FC>'
                     + '<FC>id=ORG_NAME            width=120  align=left   name="명 "                </FC>'
                     + '</FG>'
                     + '<FG>name="브랜드"'
                     + '<FC>id=PUMBUN_CD           width=70   align=center name="코드 "               </FC>'
                     + '<FC>id=PUMBUN_NAME         width=130  align=left   name="명 "                 </FC>'
                     + '</FG>'
                     + '<FC>id=POS_AUTH_FLAG_NAME  width=130  align=left   name="권한구분 "           </FC>'
                     + '<FC>id=TEL_NO              width=130  align=left   name="전화번호 "           </FC>'
                     + '<FC>id=BIRTH_DT            width=80   align=center name="생년월일 "            mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=LUNAR_FLAG_NAME     width=70   align=left   name="양음력;구분 "        </FC>'
                     + '<FC>id=PWD_MOD_DT          width=85   align=center name="비밀번호;최종변경일 "  mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=USE_YN              width=70   align=center  name="사용여부 "           </FC>';

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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	//
    if( LC_STR_CD.BindColVal == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
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

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
    //openExcel2(GD_MASTER, "판매사원조회", getSearchValue2Excel(), true );
    openExcel5(GD_MASTER, "판매사원조회", getSearchValue2Excel(), true , "",g_strPid );

    if(DS_MASTER.CountRow < 1)
        LC_STR_CD.Focus();
    else
        GD_MASTER.Focus();
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
//
/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  판매사원 리스트 조회
 * return값 : void
 */
function searchMaster(){

    var strCd       = LC_STR_CD.BindColVal;
    var posAuthFlag = LC_POS_AUTH_FLAG.BindColVal;
    var empFlag     = LC_EMP_FLAG.BindColVal;
    var orgCd       = EM_ORG_CD.Text;
    var orgName     = EM_ORG_NAME.Text;
    var saleUserId  = EM_SALE_USER_ID.Text;
    var empName     = EM_EMP_NAME.Text;
    var pumbunCd    = EM_PUMBUN_CD.Text;
    var pumbunName  = EM_PUMBUN_NAME.Text;

    // 엑셀 다운을 위한 현재 조회 값 저장
    setSearchValue2Excel();
    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strSaleUserId="+encodeURIComponent(saleUserId)
                   + "&strEmpName="+encodeURIComponent(empName)
                   + "&strOrgCd="+encodeURIComponent(orgCd)
                   + "&strOrgName="+encodeURIComponent(orgName)
                   + "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strPumbunName="+encodeURIComponent(pumbunName)
                   + "&strPosAuthFlag="+encodeURIComponent(posAuthFlag)
                   + "&strEmpFlag="+encodeURIComponent(empFlag);
    TR_MAIN.Action="/dps/pcod806.pc?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  

} 
/**
 * getOrgCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 조직명을 등록한다.
 * return값 : void
 */
function getOrgCode(evnFlag){
	var codeObj = EM_ORG_CD;
	var nameObj = EM_ORG_NAME;

    if( evnFlag == 'POP'){
    	orgCornerOutPop(codeObj,nameObj,'N','','','','','',LC_STR_CD.BindColVal);
        codeObj.Focus();
        return;
    }

    if( codeObj.Text ==""){
        nameObj.Text = "";    
        return;
    }
    
    setOrgCornerOutNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 'N', 0,'','','','','',LC_STR_CD.BindColVal);
} 

/**
 * setPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.
 * return값 : void
 */
function setPumbunCode(evnflag){
	var codeObj = EM_PUMBUN_CD;
	var nameObj = EM_PUMBUN_NAME;
    if( codeObj.Text == "" && evnflag != "POP" ){
    	nameObj.Text = "";
        return;     
    }
    
    if( evnflag == "POP" ){
        strPbnPop(codeObj,nameObj,'N','', LC_STR_CD.BindColVal);
        codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"N", 0,'', LC_STR_CD.BindColVal);
    }    
}

/**
 * setSearchValue2Excel()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀다운시 조회조건 입력을 위한 값 바인드
 * return값 : void
 */
function setSearchValue2Excel(){
    
    excelStr         = LC_STR_CD.Text;
    excelOrgCd       = EM_ORG_CD.Text;
    excelOrgName     = EM_ORG_NAME.Text;
    excelSaleUserId  = EM_SALE_USER_ID.Text;
    excelEmpName     = EM_EMP_NAME.Text;
    excelPosAuthFlag = LC_POS_AUTH_FLAG.Text;
    excelEmpFlag     = LC_EMP_FLAG.Text;
    excelPumbunCd    = EM_PUMBUN_CD.Text;
    excelPumbunName  = EM_PUMBUN_NAME.Text;    
}

/**
 * getSearchValue2Excel()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회조건 입력 값 조회
 * return값 : void
 */
function getSearchValue2Excel(){
    //
    var parameters = "점="+nvl(excelStr,'전체')                    
                   + " -조직코드="+nvl(excelOrgCd,'전체')    
                   + " -조직명="+nvl(excelOrgName,'전체')     
                   + " -사원번호="+nvl(excelSaleUserId,'전체')    
                   + " -사원명="+nvl(excelEmpName,'전체')   
                   + " -권한구분="+nvl(excelPosAuthFlag,'전체')   
                   + " -사원구분="+nvl(excelEmpFlag,'전체')     
                   + " -브랜드코드="+nvl(excelPumbunCd,'전체')    
                   + " -브랜드명="+nvl(excelPumbunName,'전체');
    return parameters;
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
</script>
<!-- 조직(조회) -->
<script language=JavaScript for=EM_ORG_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    getOrgCode('NAME');
</script>
<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setPumbunCode('NAME');
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
<comment id="_NSID_"><object id="DS_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POS_AUTH_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EMP_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80">조직</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_ORG_CD classid=<%=Util.CLSID_EMEDIT%>  width=80  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:getOrgCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_ORG_NAME classid=<%=Util.CLSID_EMEDIT%>  width=110  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">사원번호</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_SALE_USER_ID classid=<%=Util.CLSID_EMEDIT%>  width=140  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >사원명</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_EMP_NAME classid=<%=Util.CLSID_EMEDIT%>  width=135  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th >권한구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_POS_AUTH_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=215 tabindex=1  align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >사원구분</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_EMP_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >브랜드</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=118  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script><img 
              src="/<%=dir%>/imgs/btn/detail_search_s.gif"   onclick="javascript:setPumbunCode('POP');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=319  tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=457 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>
