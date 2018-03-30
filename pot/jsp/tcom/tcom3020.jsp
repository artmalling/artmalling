<!-- 
/*******************************************************************************
 * 시스템명 : 시스템관리 > 로그관리> 프로그램사용로그
 * 작 성 일 : 2010.06.28
 * 작 성 자 : Hseon
 * 수 정 자 : 
 * 파 일 명 : tcom3020.jsp
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
    DS_O_LIST.setDataHeader('<gauce:dataset name="H_SEL_LIST"/>');
    DS_O_LCODE.setDataHeader('CODE:STRING(10),NAME:STRING(50)');
    DS_O_MCODE.setDataHeader('CODE:STRING(10),NAME:STRING(50)');
    DS_O_SCODE.setDataHeader('CODE:STRING(10),NAME:STRING(50)');
    
    //그리드 초기화
    gridCreate();

    //콤보 초기화 : 시스템구분
    initComboStyle(LC_SUB_SYSTEM,   DS_O_SUBSYSTEM, "CODE^0^20,NAME^0^80" , 1, NORMAL);
    initComboStyle(LC_LCODE		,   DS_O_LCODE    , "CODE^0^45,NAME^0^80" , 1, NORMAL);
    initComboStyle(LC_MCODE		,   DS_O_MCODE    , "CODE^0^30,NAME^0^80" , 1, NORMAL);
    initComboStyle(LC_SCODE		,   DS_O_SCODE    , "CODE^0^60,NAME^0^120", 1, NORMAL);
    
    
    //서브시스템 공통 코드 에서 가져 오기
    getEtcCode("DS_O_SUBSYSTEM",   "D", "TC01", "Y");  
    
    //콤보 기본값셋팅 = 백화점
    setComboData(LC_SUB_SYSTEM, "P");  
    

    // EMedit에 초기화 (조회용)
    initEmEdit(EM_S_DATE    , "TODAY"   , PK);          // 조회기간1
    initEmEdit(EM_E_DATE    , "TODAY"   , PK);          // 조회기간2
    initEmEdit(EM_USER_NAME , "GEN^20"  , NORMAL);    	//사원번호/명
    
    LC_SUB_SYSTEM.Focus(); 
}

function gridCreate(){

    var hdrProperies = '<FC>id={currow}     width=30   align=center     			name="NO"          	</FC>'
        			 + '<FC>id=SUB_SYSTEM   width=70                    suppress=1 	name="시스템구분"   	</FC>'
                     + '<FC>id=LNAME        width=80                    suppress=2	name="대분류"     	</FC>'
                     + '<FC>id=MNAME        width=80                    suppress=3	name="중분류"		</FC>'
                     + '<FC>id=PID        	width=70   align=center     suppress=4	name="프로그램ID"	</FC>'
                     + '<FC>id=PNAME1		width=130                   suppress=4	name="프로그램명" 	</FC>'
                    // + '<FC>id=USER_ID      width=70                    			name="사용자ID"  	</FC>'
                     + '<FC>id=USER_NAME    width=202                    			name="방문자 (점/팀/파트/PC)"       	</FC>'
                     + '<FC>id=VISIT_DATE   width=170  align=center     			name="방문시간"  	</FC>'
                     + '<FC>id=USER_IP   	width=130  align=center     			name="접속 IP"  	</FC>'
                     ;
    initGridStyle(GD_LIST, "common", hdrProperies, false); 
                     
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
	if (EM_S_DATE.text == "" || EM_S_DATE.text.length < 8) 
    {
        showMessage(STOPSIGN, OK, "USER-1003", "게시시작일");
        EM_S_DATE.focus();
        return false;
    }
    
    if (EM_E_DATE.text == "" || EM_E_DATE.text.length < 8 ) 
    {
        showMessage(STOPSIGN, OK, "USER-1003", "게시종료일");
        EM_E_DATE.focus();
        return false;
    }
    
    if(EM_S_DATE.Text > EM_E_DATE.Text){                              // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_DATE.Focus();
        return false;
    }
    
    var strSystemGbn	= LC_SUB_SYSTEM.BindColVal;	// 시스템구분
    var strLcode  		= LC_LCODE.BindColVal;    	// 대분류
	var strMcode   		= LC_MCODE.BindColVal;     	// 중분류
	var strScode   		= LC_SCODE.BindColVal;     	// 소분류 
	var strSdate   		= EM_S_DATE.Text;     		// 기간1 
	var strEdate   		= EM_E_DATE.Text;     		// 기간2
	var strUserCd   	= EM_USER_NAME.text;
     
 	var goTo       = "selectList" ;    
	var action     = "O";     
	var parameters = "&strSystemGbn="   +encodeURIComponent(strSystemGbn)
                   + "&strLcode="		+encodeURIComponent(strLcode)
                   + "&strMcode=" 		+encodeURIComponent(strMcode)
                   + "&strScode=" 		+encodeURIComponent(strScode)
                   + "&strSdate=" 		+encodeURIComponent(strSdate)
                   + "&strEdate=" 		+encodeURIComponent(strEdate)
                   + "&strUserCd="   	+encodeURIComponent(strUserCd);

	TR_MAIN.Action="/pot/tcom302.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_LIST=DS_O_LIST)"; //조회는 O
    TR_MAIN.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", DS_O_LIST.CountRow);  
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
// 시스템구분 -> 대분류조회
function getLcode(strSubSystem)
{
    var goTo       = "selectLcode" ;    
    var action     = "O";     
    var parameters = "&strSubSystem="  +encodeURIComponent(strSubSystem) ;

    TR_MAIN.Action="/pot/tcom301.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_LCODE=DS_O_LCODE)"; //조회는 O
    TR_MAIN.Post(); 
    
	insComboData(LC_LCODE, "%", "전체", 1);	
	LC_LCODE.Index = 0; 
}

//대분류 -> 중분류조회
function getMcode(strLcode)
{
    var goTo       = "selectMcode" ;    
    var action     = "O";     
    var parameters = "&strLcode="  +encodeURIComponent(strLcode) ;

    TR_MAIN.Action="/pot/tcom301.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MCODE=DS_O_MCODE)"; //조회는 O
    TR_MAIN.Post(); 
    
	insComboData(LC_MCODE, "%", "전체", 1);	
	LC_MCODE.Index = 0;
    
}

//중분류 -> 소분류조회
function getScode(strLcode, strMcode)
{
    var goTo       = "selectScode" ;    
    var action     = "O";     
    var parameters = "&strLcode="  +encodeURIComponent(strLcode) + "&strMcode="  +encodeURIComponent(strMcode) ;

    TR_MAIN.Action="/pot/tcom301.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_SCODE=DS_O_SCODE)"; //조회는 O
    TR_MAIN.Post(); 
    
	insComboData(LC_SCODE, "%", "전체", 1);	
	LC_SCODE.Index = 0;
    
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
<script language=JavaScript for=GD_LIST event=OnClick(row,colid)>
	if(row<1)sortColId(eval(this.DataID), row, colid);
</script>  

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------> 
<script language=JavaScript for=LC_SUB_SYSTEM event=OnSelChange>
    DS_O_LCODE.ClearData();
	DS_O_MCODE.ClearData();
	DS_O_SCODE.ClearData();
	
    if (this.BindColVal == '%'){
        insComboData(LC_LCODE, "%", "전체", 1);
        setComboData(LC_LCODE, "%");
        return;    	
    }
    
    getLcode(this.BindColVal); 
</script>
<script language=JavaScript for=LC_LCODE event=OnSelChange>
	DS_O_MCODE.ClearData();
	DS_O_SCODE.ClearData();
	
    if (this.BindColVal == '%'){
        insComboData(LC_MCODE, "%", "전체", 1);
        setComboData(LC_MCODE, "%");
        return;    	
    }
    
    getMcode(this.BindColVal); 
</script> 
<script language=JavaScript for=LC_MCODE event=OnSelChange> 
	DS_O_SCODE.ClearData();
	
    if (this.BindColVal == '%'){
        insComboData(LC_SCODE, "%", "전체", 1);
        setComboData(LC_SCODE, "%");
        return;    	
    }
    
    getScode(LC_LCODE.BindColVal, this.BindColVal); 
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
<comment id="_NSID_"><object id="DS_O_SUBSYSTEM"  	classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_LCODE" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MCODE" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
<comment id="_NSID_"><object id="DS_O_SCODE" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_LIST" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
		                <th width="70" >시스템구분</th> 
		                <TD>
		                    <comment id="_NSID_">
		                        <object id=LC_SUB_SYSTEM classid=<%= Util.CLSID_LUXECOMBO %> width=100 align="absmiddle">
		                        </object>
		                    </comment><script>_ws_(_NSID_);</script>
		                </TD>
		                <th width="70">대분류</th>  
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_LCODE classid=<%= Util.CLSID_LUXECOMBO %> height=110 width=100 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		                
		                <th width="70">중분류</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_MCODE classid=<%= Util.CLSID_LUXECOMBO %> height=110 width=110 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		                <th width="70">소분류</th>
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_SCODE classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=120 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td>
		            </tr>
					<tr>
						<th width="70" class="point">기간</th>
		   				<td colspan="3">
		                   <comment id="_NSID_"> 
		                       <object id=EM_S_DATE classid=<%=Util.CLSID_EMEDIT%> width=97 align="absmiddle"> </object> 
		                   </comment><script> _ws_(_NSID_);</script>
		                   <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_START_DT onclick="javascript:openCal('G',EM_S_DATE)" align="absmiddle" />
		                   ~ 
		                   <comment id="_NSID_"> 
		                       <object id=EM_E_DATE classid=<%=Util.CLSID_EMEDIT%> width=97 align="absmiddle"> </object> 
		                   </comment><script> _ws_(_NSID_);</script> 
		                   <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_END_DT onclick="javascript:openCal('G',EM_E_DATE)" align="absmiddle" />
		                </td>
			            <th width="70">성명/사용자ID</th>
	                    <TD width="120" colspan="3">
	                        <comment id="_NSID_">
	                          <object id=EM_USER_NAME classid=<%=Util.CLSID_EMEDIT%> width=110>
	                            </object>
	                         </comment>
	                        <script> _ws_(_NSID_);</script>
	                    </TD>
		            </tr>
		            
		         </table> 
		    </td></tr>
		</table>
	</td></tr>
	<tr><td class="dot" ></td>

	<tr><td class="PT01 PB03" valign="top">
		<table cellpadding="0" border="0" cellspacing="0" class="BD4A"  width="100%">
		<tr><td>
			<comment id="_NSID_"><OBJECT id=GD_LIST width=100% height="478" classid=<%=Util.CLSID_GRID%>>
			<param name=DataID   value="DS_O_LIST"> 
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

