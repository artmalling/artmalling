<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 품목코드> 품목코드조회
 * 작 성 일 : 2010.03.15
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pcod4020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 품목코드를 조회한다.
 * 이    력 :
 *        2010.03.15 (이재득) 신규작성
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

var strLCd          = "";
var strMCd          = "";
var strSCd          = "";
var strFclFlag      = "";
var strFreshYn      = "";
var strPummokCd     = "";
var strPummokNm     = "";
var g_strPid           = "<%=pageName%>";                 // PID

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_I_PMK_COND.setDataHeader(   
            'FCL_FLAG:STRING(1)'            
            +',PUMMOK_CD:STRING(8)'
            +',PUMMOK_NM:STRING(40)'
            +',FRESH_YN:STRING(1)'
            +',L_CD:STRING(2)'
            +',M_CD:STRING(2)'
            +',S_CD:STRING(2)'); 
    DS_I_PMK_COND.ClearData();
    DS_I_PMK_COND.Addrow();
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화 
    initEmEdit(EM_O_PUMMOK_CD, "CODE^8^#", NORMAL);   //브랜드코드
    initEmEdit(EM_O_PUMMOK_NM, "GEN^40", NORMAL);  //브랜드명   
    
    //콤보 초기화     
    initComboStyle(LC_O_L_CD,DS_O_L_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //대분류
    initComboStyle(LC_O_M_CD,DS_O_M_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //중분류
    initComboStyle(LC_O_S_CD,DS_O_S_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);  //소분류
    initComboStyle(LC_O_FCL_FLAG,DS_O_FCL_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //시설구분
    initComboStyle(LC_O_FRESH_YN,DS_O_FRESH_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);  //신선식품여부
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )      
    getEtcCode("DS_O_FCL_FLAG", "D", "P034", "Y");     //시설구분  (조회)  
    getEtcCode("DS_O_FRESH_YN", "D", "D022", "Y");     //신선식품여부 (조회)
    getEtcCode("DS_I_TAG_FLAG", "D", "P063", "N");     //택구분    
    getEtcCode("DS_I_UNIT_CD", "D", "P013", "N");     //단위코드 
    getEtcCode("DS_I_FCL_FLAG", "D", "P034", "N");     //시설구분     
    
    //대분류 가지고 오기(popup_dps.js)
    getPmkLCode("DS_O_L_CD" , "Y"); 
    
 // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_M_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_S_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');     
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_FCL_FLAG,"%");
    setComboData(LC_O_FRESH_YN,"%");
    setComboData(LC_O_L_CD,"%");    

    LC_O_L_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"             width=30   align=center  </FC>' 
                     + '<FC>id=PUMMOK_CD       name="품목코드"       width=70   align=center   </FC>'
                     + '<FC>id=PUMMOK_NAME     name="품목명"         width=100  align=left     </FC>'
                     + '<FC>id=PUMMOK_SRT_CD   name="품목;단축코드"   width=60  align=center   </FC>' 
                     + '<FC>id=RECP_NAME       name="영수증명"       width=80   align=left     </FC>'
                     + '<FG>                   name="대분류"'
                     + '<FC>id=L_CD            name="코드"           width=45   align=center   </FC>'
                     + '<FC>id=L_NAME          name="코드명"         width=100  align=left     </FC>'
                     + '</FG>' 
                     + '<FG>                   name="중분류"'
                     + '<FC>id=M_CD            name="코드"           width=45   align=center   </FC>'                     
                     + '<FC>id=M_NAME          name="코드명"         width=100  align=left     </FC>'
                     + '</FG>'
                     + '<FG>                   name="소분류"'
                     + '<FC>id=S_CD            name="코드"           width=45   align=center   </FC>' 
                     + '<FC>id=S_NAME          name="코드명"         width=100  align=left     </FC>'
                     + '<FG>                   name="세분류"'
                     + '<FC>id=D_CD            name="코드"           width=45   align=center   </FC>'
                     + '<FC>id=D_NAME          name="코드명"         width=100  align=left     </FC>' 
                     + '</FG>'
                     + '<FC>id=TAG_FLAG        name="택구분"         width=100   align=left   EditStyle=Lookup   Data="DS_I_TAG_FLAG:CODE:NAME"</FC>'                     
                     + '<FC>id=FRESH_YN        name="신선식품;여부"  width=55   align=center   </FC>'
                     + '<FC>id=UNIT_CD         name="단위"           width=45   align=left   EditStyle=Lookup   Data="DS_I_UNIT_CD:CODE:NAME"</FC>' 
                     + '<FC>id=FCL_FLAG        name="시설구분"       width=55   align=left   EditStyle=Lookup   Data="DS_I_FCL_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=USE_YN          name="사용여부"       width=55   align=center </FC>';  
      
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
 * 작 성 일 : 2010.03.15
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	DS_IO_MASTER.ClearData();
	DS_I_PMK_COND.UserStatus(1) = '1';

	strLCd          = LC_O_L_CD.Text;
    strMCd          = LC_O_M_CD.Text;
    strSCd          = LC_O_S_CD.Text;
    strFclFlag      = LC_O_FCL_FLAG.Text;
    strFreshYn      = LC_O_FRESH_YN.Text;
    strPummokCd     = EM_O_PUMMOK_CD.Text;
    strPummokNm     = EM_O_PUMMOK_NM.Text;	

	var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_MAIN.Action="/dps/pcod402.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_I_PMK_COND=DS_I_PMK_COND,"+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 if (strMCd == "")
		 strMCd = "전체";
     if (strSCd == "")
    	 strSCd = "전체"; 
	 if (strPummokCd == "")
		 strPummokCd = "전체";
     if (strPummokNm == "")
    	 strPummokNm = "전체";  
     
     var parameters = "대분류="+strLCd
    	            + " -중분류="+strMCd
                    + " -소분류="+strSCd                   
                    + " -시설구분="+strFclFlag
                    + " -신선식품여부="+strFreshYn  
                    + " -품목코드="+strPummokCd
                    + " -품목명="+strPummokNm ;
       
   //openExcel2(GD_MASTER, "품목코드조회", parameters, true );
   openExcel5(GD_MASTER, "품목코드조회", parameters, true , "",g_strPid );

   
   GD_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

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

<!-- 품목코드 변경시 -->
<script language=JavaScript for=EM_O_PUMMOK_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_PUMMOK_NM.Text = "";
        return;
    }   
    setPummokNmWithoutPop( "DS_O_PUMMOK_CD", this, EM_O_PUMMOK_NM, '0');
</script>

<script language=JavaScript for=LC_O_L_CD event=OnSelChange>
    DS_O_M_CD.ClearData();
    DS_O_S_CD.ClearData();
    getPmkMCode("DS_O_M_CD", LC_O_L_CD.BindColVal , "N" );     
        
    // 기본값 입력( gauce.js )
    insComboData( LC_O_M_CD, "%", "전체", 1 );    
    setComboData(LC_O_M_CD,"%");
</script>

<script language=JavaScript for=LC_O_M_CD event=OnSelChange>   
    DS_O_S_CD.ClearData();       
    getPmkSCode("DS_O_S_CD", LC_O_L_CD.BindColVal , LC_O_M_CD.BindColVal , "N" );    
    
    // 기본값 입력( gauce.js )
    insComboData( LC_O_S_CD, "%", "전체", 1 );    
    setComboData(LC_O_S_CD,"%");          
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
<object id="DS_O_FCL_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_L_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_M_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_S_CD" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_O_PUMMOK_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_FRESH_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_I_TAG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_UNIT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_FCL_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PMK_COND" classid=<%= Util.CLSID_DATASET %>></object>
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
						<th width="80">대분류</th>
						<td width="165"><comment id="_NSID_"> <object id=LC_O_L_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">중분류</th>
						<td width="165"><comment id="_NSID_"> <object id=LC_O_M_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">소분류</th>
						<td><comment id="_NSID_"> <object id=LC_O_S_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80">시설구분</th>
						<td><comment id="_NSID_"> <object id=LC_O_FCL_FLAG
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">신선식품여부</th>
						<td><comment id="_NSID_"> <object id=LC_O_FRESH_YN
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">품목</th>
						<td><comment id="_NSID_"> <object id=EM_O_PUMMOK_CD
							classid=<%= Util.CLSID_EMEDIT %> width=60 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: pummokPop(EM_O_PUMMOK_CD,EM_O_PUMMOK_NM ); EM_O_PUMMOK_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_PUMMOK_NM classid=<%= Util.CLSID_EMEDIT %> width=75
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
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width="100%" height=481 classid=<%=Util.CLSID_GRID%>>
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
<object id=BO_PMK_COND classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_I_PMK_COND>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='            
            <c>col=FCL_FLAG         ctrl=LC_O_FCL_FLAG        param=BindColVal </c>
            <c>col=PUMMOK_CD        ctrl=EM_O_PUMMOK_CD       param=Text </c>
            <c>col=PUMMOK_NM        ctrl=EM_O_PUMMOK_NM       param=Text </c>
            <c>col=FRESH_YN         ctrl=LC_O_FRESH_YN        param=BindColVal </c>
            <c>col=L_CD             ctrl=LC_O_L_CD            param=BindColVal </c>
            <c>col=M_CD             ctrl=LC_O_M_CD            param=BindColVal </c>
            <c>col=S_CD             ctrl=LC_O_S_CD            param=BindColVal </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

