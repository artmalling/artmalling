<!-- 
/*******************************************************************************
 * 시스템명 : 시스템관리 > 로그관리> 실시간로그인현황
 * 작 성 일 : 2010.06.23
 * 작 성 자 : Hseon
 * 수 정 자 : 
 * 파 일 명 : tcom3040.jsp
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
<%@ page import="common.dao.CCom900DAO"%>

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
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
 
    // Data Set Header 초기화
    DS_IO_USER.setDataHeader('<gauce:dataset name="H_SEL_USER"/>');
    
    //그리드 초기화
    gridCreate();

    //콤보 초기화
    initComboStyle(LC_O_STR_CD,     DS_O_STR_CD,    "CODE^0^30,NAME^0^80",  1, NORMAL);     //점(조회)
    initComboStyle(LC_O_ORG_FLAG,   DS_O_ORG_FLAG,  "CODE^0^30,NAME^0^110", 1, NORMAL);     //조직구분(조회)
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
    
    //콤보데이터 기본값 설정( gauce.js )
    var defaultOrg = '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />';
    defaultOrg = (defaultOrg==""?"%":defaultOrg);
    setComboData(LC_O_ORG_FLAG, defaultOrg);
    //setComboData(LC_O_STR_CD,"%");
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정

    LC_O_ORG_FLAG.Focus();
}

function gridCreate(){

    var hdrProperies = '<FC>id={currow}         width=30   align=center     name="NO"              		</FC>'
                     + '<FC>id=USER_ID          width=70                    name="사용자ID"        		</FC>'
                     + '<FC>id=USER_NAME        width=90                    name="성명"            		</FC>'
                     + '<FC>id=LOGIN_DATE       width=130  align=center     name="로그인시간"      		</FC>'
                     + '<FC>id=ORG_NAME         width=80   align=left       name="조직"         	   		</FC>'
                     + '<FC>id=STR_NAME         width=80   align=left       name="점"         	   		</FC>'
                     + '<FC>id=DEPT_NAME        width=90   align=left       name="팀"         	  		 </FC>'
                     + '<FC>id=TEAM_NAME        width=90   align=left       name="파트"         	   		</FC>'
                     + '<FC>id=PC_NAME          width=90   align=left       name="PC"              		</FC>'
                     + '<FC>id=MONTH_LOG_CNT	width=120  align=right       name="최근1개월로그인횟수"	</FC>'
                     ;

    initGridStyle(GD_USER, "common", hdrProperies, false); 
                     
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
     var strBindStrCd    = LC_O_STR_CD.BindColVal;      // 점
     var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;    // 조직
     var strBindDeptCd   = LC_O_DEPT_CD.BindColVal;     // 팀
     var strBindTeamCd   = LC_O_TEAM_CD.BindColVal;     // 파트
     var strBindPcCd     = LC_O_PC_CD.BindColVal;       // PC 
     
     var goTo       = "selectList" ;    
     var action     = "O";     
     var parameters = "&strStrCd="  +encodeURIComponent(strBindStrCd)
                    + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag)
                    + "&strDeptCd=" +encodeURIComponent(strBindDeptCd)
                    + "&strTeamCd=" +encodeURIComponent(strBindTeamCd)
                    + "&strPcCd="   +encodeURIComponent(strBindPcCd);

     TR_MAIN.Action="/pot/tcom304.tc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_USER=DS_IO_USER)"; //조회는 O
     TR_MAIN.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", DS_IO_USER.CountRow); 
      
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
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
  * btn_Add()
  * 작 성 자 : 
  * 작 성 일 : 2010-09-08
  * 개    요 : 사용자 그리드 Row추가 
  * return값 : void
*/
function btn_Add(){  
}

/**
  * btn_Del1()
  * 작 성 자 : 엄준석
  * 작 성 일 : 2010-09-08
  * 개    요 : 광역 그리드 Row 삭제 
  * return값 : void
*/
function btn_Del(){
}


/*************************************************************************
 * 3. 함수
 *************************************************************************/  
function forcedLogOutPopUp()
{
	var strUserId = DS_IO_USER.NameValue(DS_IO_USER.RowPosition, "USER_ID");

	if(DS_IO_USER.CountRow < 1 ||  strUserId =="")
	{
	    showMessage(STOPSIGN, OK, "USER-1000", "로그아웃 대상자를 선택하여 주십시오.");
	    GD_USER.focus();
	    return;
	}
	if(strUserId == '<%=Util.getUsrCd(request)%>')
	{
	    showMessage(STOPSIGN, OK, "USER-1000", "해당 사용자는 본인입니다.");
	    GD_USER.focus();
	    return;
		
	} 
	
	if( showMessage(QUESTION, YESNO, "USER-1000","해당 사용자를 로그아웃하시겠습니까?	") != 1 ) return;  
    iFrame.location.href="/pot/jsp/tcom/tcom3042.jsp?strUserId="+strUserId;  
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<script language=JavaScript for=DS_IO_USER event=OnLoadCompleted(rowcnt)> 
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->   
<script language=JavaScript for=GD_USER event=OnClick(row,colid)>
	if(row<1)sortColId(eval(this.DataID), row, colid);
</script>  

<script language=JavaScript for=GD_USER event=OnDblClick(row,colid)>
	if(row < 1 ) return;
	var strUserId = DS_IO_USER.NameValue(row, "USER_ID");
	
	if(strUserId =="")
	{
	    showMessage(STOPSIGN, OK, "USER-1000", "사용자를 선택하십시오.");
	    GD_USER.focus();
	    return;
	}
	window.showModalDialog("/pot/tcom304.tc?goTo=logHistoryPop"
			                , strUserId
			                , "dialogWidth:420px;dialogHeight:450px;scroll:no;" +
			                  "resizable:no;help:no;unadorned:yes;center:yes;status:no");
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange>
    DS_O_DEPT_CD.ClearData();
	DS_O_TEAM_CD.ClearData();
	DS_O_PC_CD.ClearData();
    if (LC_O_STR_CD.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "",
            LC_O_ORG_FLAG.BindColVal);
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
    
	getDept("DS_O_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y", "",
			LC_O_ORG_FLAG.BindColVal);
	if(DS_O_DEPT_CD.CountRow < 1){
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
    
	getTeam("DS_O_TEAM_CD", "N", LC_O_STR_CD.BindColVal,
				LC_O_DEPT_CD.BindColVal, "Y", "", LC_O_ORG_FLAG.BindColVal);

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
	getPc("DS_O_PC_CD", "N", LC_O_STR_CD.BindColVal,
				LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y", "",
				LC_O_ORG_FLAG.BindColVal);

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
<comment id="_NSID_"><object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
<comment id="_NSID_"><object id="DS_O_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC_CD" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_USER" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

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

<DIV id="testdiv" class="testdiv">
<iframe id=iFrame  name=iFrame src="about:blank" width=0 height=0 ></iframe>     
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
			<tr><td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
					<tr>
		                <th width="80" >조직구분</th> 
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 align="absmiddle" tabindex=1> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td> 
		                <th width="60">점</th>  
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 align="absmiddle" tabindex=2> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		                
		                <th width="60">팀</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_DEPT_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 align="absmiddle" tabindex=3> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		                <th width="55">파트</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_TEAM_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 align="absmiddle" tabindex=4> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		                <th width="55">PC</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_O_PC_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle" tabindex=5> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		            </tr>
		         </table> 
		    </td></tr>
		</table>
	</td></tr>
	<tr><td class="dot" ></td>
	<tr><td align = "right" >
		<input type="button" value="로그아웃시키기" onclick="forcedLogOutPopUp()" > 
		<!-- img src="./imgs/btn/btn_fLogout.gif"  style="cursor:hand" align=center onclick="forcedLogOutPopUp()"  -->
    </td></tr>
    
	<tr><td class="PT01 PB03" valign="top">
		<table cellpadding="0" border="0" cellspacing="0" class="BD4A"  width="100%">
		<tr><td>
			<comment id="_NSID_"><OBJECT id=GD_USER width=100% height="485" classid=<%=Util.CLSID_GRID%>>
			<param name=DataID   value="DS_IO_USER"> 
		</OBJECT></comment><script>_ws_(_NSID_);</script>
		</td></TR>
        </table>
	</TD></tr>
	</table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

