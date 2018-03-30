<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 기초자료> 경영계획지침관리
 * 작 성 일 : 2011.05.19
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0212.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영계획지침관리(전년동월계획)
 * 이    력 :
 *        2011.05.19 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
    String strPlanYm  = request.getParameter("strPlanYm");
%>
<html>
<head>
<title>경영계획지침관리(전년동월계획)</title>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단 
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-19
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    
    //EMEDIT 설정

    //콤보 초기화
    setCombo();

    //그리드 초기화
    gridCreate();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0212","DS_BIZ_MST" );
    
    btn_Search();
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-05-19
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-19
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
     getEtcCode("DS_ACC_FLAG", "D", "M092", "N"); //계정/예산항목 구분콤보 데이터가져오기 ( gauce.js )
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-19
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
    var hdrProperies = '<C>id={currow}     width=30  align=center name="NO"</C>'
                     + '<C>id=CHECK_FLAG   width=20  align=center name="" EditStyle=checkbox HeadCheck=false HeadCheckShow=true</C>'
                     + '<C>id=PRT_SEQ      width=60  align=right  name="출력순서" edit="None"</C>'
                     + '<C>id=BIZ_CD       width=65  align=center name="항목코드" edit="None"</C>'
                     + '<C>id=BIZ_CD_NM    width=80  align=left   name="항목명"  edit="None"</C>'
                     + '<C>id=BIZ_CD_LEVEL width=60  align=center name="항목레벨" edit="None"</C>'
                     + '<G> name="대분류"'
                     + '<C>id=BIZ_L_CD     width=45  align=center name="코드" edit="None"</C>'
                     + '<C>id=BIZ_L_NM     width=80  align=left   name="명" edit="None"</C>'
                     + '</G>'
                     + '<G> name="중분류"'
                     + '<C>id=BIZ_M_CD     width=45  align=center name="코드" edit="None"</C>'
                     + '<C>id=BIZ_M_NM     width=80  align=left   name="명"  edit="None"</C>'
                     + '</G>'
                     + '<G> name="소분류"'
                     + '<C>id=BIZ_S_CD     width=45  align=center name="코드" edit="None"</C>'
                     + '<C>id=BIZ_S_NM     width=80  align=left   name="명"  edit="None"</C>'
                     + '</G>'
                     + '<C>id=RPT_YN       width=55  align=center name="보고서;사용구분" edit="None"</C>'
                     + '<C>id=USE_YN       width=55  align=center name="사용여부" edit="None"</C>'
                     ;
        
    initGridStyle(GD_BIZ_MST, "common", hdrProperies, true);
    
    var hdrProperies1 = '<C>id={currow}  width=35  align=center name="NO"</C>'
                      + '<C>id=ACC_FLAG  width=100 align=center name="계정/예산구분" EditStyle=Lookup data="DS_ACC_FLAG:CODE:NAME"</C>'
                      + '<C>id=ACC_CD    width=110 align=center name="계정/예산항목" </C>'
                      + '<C>id=ACC_CD_NM width=200 align=left   name="항목명" </C>'
        ;

    initGridStyle(GD_BIZ_DTL, "common", hdrProperies1, false);
}

/**
 * btn_Search()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-19
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    //2. 데이터셋 초기화
    DS_BIZ_MST.ClearData();
    DS_BIZ_DTL.ClearData();
    
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    
    DS_BIZ_MST.DataID = "/mss/meis021.me?goTo=searchPre&strPlanYm=<%=strPlanYm%>"; 
    DS_BIZ_MST.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-19
 * 개    요 : 
 * return값 : void
 */
function subQuery(row){
    DS_BIZ_DTL.ClearData();
    var goTo          = "searchPreDtl";
    var parameters    = "&strPlanYm=<%=strPlanYm%>"
                      + "&strBizCd=" + DS_BIZ_MST.NameValue(row,"BIZ_CD"); //항목코드
   
    DS_BIZ_DTL.DataID = "/mss/meis021.me?goTo="+goTo+parameters;
    DS_BIZ_DTL.Reset();  
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_Apply()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-19
 * 개       요 : 선택된 항목을 적용한다.
 * return값 : void
 */
function btn_Apply(){
    if (DS_BIZ_MST.NameValueRow("CHECK_FLAG","T") == 0){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    TR_MAIN.Action   = "/mss/meis021.me?goTo=copyBizMst&strPlanYm=<%=strPlanYm%>"; 
    TR_MAIN.KeyValue = "SERVLET(I:DS_BIZ_MST=DS_BIZ_MST)"; 
    TR_MAIN.Post();
    
    if( TR_MAIN.ErrorCode == 0){
        window.returnValue = "1";
        window.close();
    }
}
-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    if(this.SrvErrCount("USER") > 0 ){
        showMessage(EXCLAMATION, OK, "USER-1000", this.SrvErrMsg("USER",1) );
        var bizCd = this.SrvErrMsg("USER",0).split(",");
        for(i=0; i < bizCd.length; i++){
            var rowNo = DS_BIZ_MST.NameValueRow("BIZ_CD", bizCd[i]);
            if(rowNo != 0){
                DS_BIZ_MST.NameValue(rowNo, "CHECK_FLAG") = "F";
            }
        }
    } else {
        trFailed(TR_MAIN.ErrorMsg);
    }
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_BIZ_MST event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_BIZ_MST.Focus();
</script>

<script language=JavaScript for=DS_BIZ_DTL event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_BIZ_MST  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_BIZ_DTL  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--로우변경시 디테일정보 로딩-->
<script language=JavaScript for=DS_BIZ_MST event=OnRowPosChanged(row)>
     if (this.CountRow >0) {
    	 if(row>0) subQuery(row);
    	 else showMessage(EXCLAMATION, OK, "USER-1000", "전녀동월 데이터가 없습니다." );
     }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_BIZ_MST event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_BIZ_MST.CountRow; i++) DS_BIZ_MST.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for(var i=1; i<=DS_BIZ_MST.CountRow; i++) DS_BIZ_MST.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <!--[그리드]경영실적항목 Master데이터 -->
    <object id="DS_BIZ_MST"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]경영실적항목 Detail데이터 -->
    <object id="DS_BIZ_DTL"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]계정/예산항목 구분코드 -->
    <object id="DS_ACC_FLAG"  classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
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
<body  onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <SPAN id="title1" class="PL03">경영계획지침관리(전년동월계획) </SPAN>
            </td>
            <td class="right PB02">
              <img src="/<%=dir%>/imgs/btn/apply.gif" onclick="javascript:btn_Apply();" align="absmiddle"/>
            </td>
          </tr>
        </table></td>
      </tr>
      <tr><td class="dot"></td></tr>
      <tr>
        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">      
          <tr>
            <td>
              <!-- 마스터 -->
              <comment id="_NSID_">
                <OBJECT id=GD_BIZ_MST height="205px" width="100%" classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_BIZ_MST">
                </OBJECT>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>  
        </table></td>
      </tr>
      <tr><td class="dot"></td></tr>
      <tr>
        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">      
          <tr>
            <td>
              <!-- 마스터 -->
              <comment id="_NSID_">
                <OBJECT id=GD_BIZ_DTL height="165px" width="100%" classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_BIZ_DTL">
                </OBJECT>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>  
        </table></td>
      </tr>
    </table></td>
    <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table>
</body>
</html>
