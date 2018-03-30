<!-- 
/*******************************************************************************
 * 시스템명 : 시스템관리 > 게시물관리 > 공지사항관리
 * 작 성 일 : 2010.06.09
 * 작 성 자 : HSEON
 * 수 정 자 : 
 * 파 일 명 : tcom2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공지사항을 관리한다.
 * 이    력 : 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty, kr.fujitsu.ffw.util.*"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
    String noticeFlag = String2.trimToEmpty(request.getParameter("noticeFlag"));
  //  System.out.println(">>>>>>>>>>>>>>>>>>>>. : " + noticeFlag);
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"> 
var strGlbOrgFlag  = ""; // 조직구분                                                                                                                  
var strGlbStrCd    = ""; // 점코드                                                                                                                    
var strGlbDeptCd   = ""; // 팀코드                                                                                                                  
var strGlbTeamCd   = ""; // 파트코드                                                                                                                    
var strGlbPcCd     = "";  // PC코드                                 

// 신규버튼 사용자만 팝업시 수정가능하도록 변경
var btnAuth 	= '<c:out value="${sessionScope.buttonPermission}"/>'; 
var chrAuthNew 	= btnAuth.substring(1, 2);
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit()
{
    // Output Data Set Header 초기화
    DS_O_NOTI_LIST.setDataHeader('<gauce:dataset name="H_NOTI_LIST"/>');

    initComboStyle(LC_O_ORG_FLAG,   DS_O_ORG_FLAG,  "CODE^0^20,NAME^0^90", 1, NORMAL);	//조직구분(조회)
    initComboStyle(LC_O_STR_CD,     DS_O_STR_CD,    "CODE^0^20,NAME^0^80", 1, NORMAL);  //점(조회)
    initComboStyle(LC_O_DEPT_CD,    DS_O_DEPT_CD,   "CODE^0^20,NAME^0^90", 1, NORMAL);  //팀     
    initComboStyle(LC_O_NOTI_FLAG,  DS_O_NOTI_FLAG, "CODE^0^20,NAME^0^80", 1, NORMAL);  //게시분류

    //그리드 초기화
    gridCreate(); 

    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_O_STR_CD", "N", "", "Y");  
    DS_O_STR_CD.insertRow(1);
    DS_O_STR_CD.NameValue(1, "CODE") = "%";
    DS_O_STR_CD.NameValue(1, "NAME") = "전체";
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_ORG_FLAG", "D", "P047", "Y");
    getEtcCode("DS_O_NOTI_FLAG", "D", "TC05", "Y");

    // EMedit에 초기화 (조회용)
    initEmEdit(EM_S_DATE,   "SYYYYMMDD" ,PK);         // 조회기간1
    initEmEdit(EM_E_DATE,   "TODAY"     ,PK);         // 조회기간2
    initEmEdit(EM_P_TITLE,  "GEN^50"    ,NORMAL);      // 제목
    initEmEdit(EM_P_CONTENT,"GEN^50"    ,NORMAL);      // 내용

    setComboData(LC_O_ORG_FLAG, "%");
    setComboData(LC_O_NOTI_FLAG,"%"); 
    setComboData(LC_O_STR_CD,"%"); 
    
    // 공지구분 기본값 : 전체
    LC_SEND_TO_ALL.BindColVal = "<%=noticeFlag%>"==""? "%" : "<%=noticeFlag%>";
    
    btn_Search();

}

function gridCreate(){

    var hdrProperies =  '<FC>id={currow}        width=30   align=center     name="NO"          </FC>'
       				  + '<FC>id=CHK          	width=30    				name="선택"        editstyle=checkbox  </FC>'
                      + '<FC>ID=NOTI_GBN        width=70   align=center     name="공지구분"    edit=none</FC>' 
                      + '<FC>ID=NOTI_FLAG       width=70                    name="게시분류"    edit=none</FC>' 
                      + '<FC>ID=NOTI_TITLE      width=200                   name="제목"        edit=none</FC>'  
                      + '<FC>ID=STR_NAME        width=100                   name="점"          edit=none</FC>' 
                      + '<FC>ID=DEPT_NAME       width=100                   name="팀"         edit=none</FC>' 
                      + '<FC>ID=S_DATE          width=90  align=center      name="게시시작일"   edit=none    Mask="XXXX/XX/XX"   </FC>' 
                      + '<FC>ID=E_DATE          width=90  align=center      name="게시종료일"   edit=none   Mask="XXXX/XX/XX"   </FC>' 
                      + '<FC>ID=USER_NAME       width=140                   name="작성자"    	edit=none</FC>' 
                      + '<FC>ID=REG_DATE        width=130                   name="작성일시"  	edit=none</FC>' ; 
    initGridStyle(GD_NOTI_LIST, "common", hdrProperies, true );  
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
    
	var strBindSdate    = EM_S_DATE.Text;                                   // 게시시작일
    var strBindEdate    = EM_E_DATE.Text;                                   // 게시종료일
    var strBindStrCd    = LC_O_STR_CD.BindColVal;                           // 점
    var strBindDeptCd   = LC_O_DEPT_CD.BindColVal;                          // 팀
    var strBindTitle    = EM_P_TITLE.text;   // 제목
    var strBindContent  = EM_P_CONTENT.text; // 내용
    var strBindGbn      = LC_SEND_TO_ALL.BindColVal;                        // 공지구분 
    var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;                         // 조직
    var strBindNotiFlag = LC_O_NOTI_FLAG.BindColVal;                         // 게시분류
    
     var goTo       = "selectNotiList" ;    
     var action     = "O";      
 
     var parameters = "&strSdate="  +encodeURIComponent(strBindSdate)
                    + "&strEdate="  +encodeURIComponent(strBindEdate)
                    + "&strStrCd="  +encodeURIComponent(strBindStrCd)
                    + "&strDeptCd=" +encodeURIComponent(strBindDeptCd)
                    + "&strTitle="  +encodeURIComponent(strBindTitle)
                    + "&strContent="+encodeURIComponent(strBindContent)
                    + "&strGbn="    +encodeURIComponent(strBindGbn) 
                    + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag) 
                    + "&strNotiFlag="+encodeURIComponent(strBindNotiFlag) ; 
     
     TR_MAIN.Action="/pot/tcom201.tc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_O_NOTI_LIST=DS_O_NOTI_LIST)"; //조회는 O
     TR_MAIN.Post();
     
     // 조회결과 Return 
     setPorcCount("SELECT", DS_O_NOTI_LIST.CountRow); 
             
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 writePopUp();
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
	if(DS_O_NOTI_LIST.CountRow < 1 || DS_O_NOTI_LIST.NameValue(DS_O_NOTI_LIST.RowPostion, "NOTI_ID") == "" ||!(DS_O_NOTI_LIST.IsUpdated)) 
	{ 
	    showMessage(INFORMATION, OK, "USER-1019");  
	    return;
	}
	
	if( showMessage(QUESTION, YESNO, "USER-1023") != 1 )return;
	
	var goTo       = "deleteNotiList";
    var action     = "I";

    TR_MAIN.Action="/pot/tcom201.tc?goTo="+goTo;   
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_NOTI_LIST=DS_O_NOTI_LIST)"; 
    TR_MAIN.Post();
     
    btn_Search(); 
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
function writePopUp()
{
    var arrArg  = new Array(); 
    arrArg.push("NEW");
    arrArg.push(""); 
    arrArg.push(window.self);  
   
    var returnVal =  window.showModalDialog("/pot/tcom201.tc?goTo=writePop"
                    , arrArg
                    , "dialogWidth:900px;dialogHeight:795px;scroll:no;" +
                      "resizable:no;help:no;unadorned:yes;center:yes;status:y"); 
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
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->   
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------> 
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_NOTI_LIST event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>  

<script language=JavaScript for=GD_NOTI_LIST event=OnDblClick(row,colid)>

	// 신규버튼 사용자만 팝업시 수정가능하도록 변경 
    var arrArg  = new Array(); 
    if(chrAuthNew == "1")
    	arrArg.push("MODIFY");
    else
    	arrArg.push("READ");
    	
    arrArg.push(DS_O_NOTI_LIST.NameValue(DS_O_NOTI_LIST.RowPosition , "NOTI_ID")); 
    arrArg.push(window.self);  
	
	var returnVal =  window.showModalDialog("/pot/tcom201.tc?goTo=writePop"
	                , arrArg
	                , "dialogWidth:900px;dialogHeight:795px;scroll:no;" +
	                  "resizable:no;help:no;unadorned:yes;center:yes;status:no");  
</script>


<script language=JavaScript for=LC_SEND_TO_ALL event=OnSelChange>
    // 공지구분이 팀공지일 경우만 점/팀 선택
    LC_O_STR_CD.BindColVal = "%";
    
    if (this.BindColVal == "N")
    {
        //콤보데이터 기본값 설정( gauce.js )
        setComboData(LC_O_ORG_FLAG, '<c:out value="${sessionScope.sessionInfo.ORG_FLAG}" />');
        
    	LC_O_ORG_FLAG.Enable         = true;
    	LC_O_STR_CD.Enable           = true;
    	LC_O_DEPT_CD.Enable          = true;

    }
    else
    {
        setComboData(LC_O_ORG_FLAG, "%"); 
        
        LC_O_ORG_FLAG.Enable         = false;
        LC_O_STR_CD.Enable           = false;
        LC_O_DEPT_CD.Enable          = false; 
    }
</script>

<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange>
    DS_O_DEPT_CD.ClearData(); 
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
    LC_O_STR_CD.Index = 0;
    LC_O_DEPT_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    DS_O_DEPT_CD.ClearData(); 
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
<comment id="_NSID_"><object id="DS_O_ORG_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_NOTI_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_NOTI_LIST" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>  
 
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
<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="PT01 PB03">
	        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
	            <tr><td>
	            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
	            	<tr>
		                 <th width="60">공지구분</th>
		                 <td width="105"> 
		                    <comment id="_NSID_">
		                    <object id=LC_SEND_TO_ALL classid=<%= Util.CLSID_LUXECOMBO %> width="110" tabindex=1 align="absmiddle">
		                       <param name=CBDataColumns    value="CODE,NAME"> 
		                       <param name=ListExprFormat   value="CODE^0^20,NAME^0^90"> 
		                       <param name="EditExprFormat" value="%;NAME">    
		                       <param name=CBData           value="%^전체,Y^전체공지,N^팀공지">  
		                       <param name=BindColumn       value="CODE">
		                    </object>
		                    </comment><script>_ws_(_NSID_);</script>
		                 </th> 
		                    
		                 <th width="60" >조직구분</th>
		                 <td width="120">
		                    <comment id="_NSID_"> 
		                        <object id=LC_O_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=120 align="absmiddle"  tabindex=2 > </object> 
		                    </comment><script>_ws_(_NSID_);</script></td>
		                    
		                 <th width="60">점</th>
		                 <td width="110">
		                    <comment id="_NSID_"> 
		                        <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 align="absmiddle" tabindex=3 > </object> 
		                    </comment><script>_ws_(_NSID_);</script></td>
		                
		                <th width="60">팀</th>
		                <td>
		                    <comment id="_NSID_"> 
		                        <object id=LC_O_DEPT_CD tabindex=4 classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=120 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script></td> 
	                </tr> 
	                
	                <tr> 
	                   <th width="60" class="point">게시기간</th>
	                   <td colspan=3>
	                         <comment id="_NSID_"> 
	                             <object id=EM_S_DATE classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=4 align="absmiddle"> </object> 
	                         </comment><script> _ws_(_NSID_);</script>
	                         <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_START_DT onclick="javascript:openCal('G',EM_S_DATE)" align="absmiddle" />
	                         ~ 
	                         <comment id="_NSID_"> 
	                             <object id=EM_E_DATE classid=<%=Util.CLSID_EMEDIT%> width=110 tabindex=5 align="absmiddle"> </object> 
	                         </comment><script> _ws_(_NSID_);</script> 
	                         <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_END_DT onclick="javascript:openCal('G',EM_E_DATE)" align="absmiddle" />
	                    </td>
	                   <th width="60">게시분류</th>
	                   <td width="235" colspan=3>
		                 	<comment id="_NSID_"> 
		                 		<object id=LC_O_NOTI_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle"> </object> 
		                 	</comment><script>_ws_(_NSID_);</script> 
					    </td>
	                </tr>
	                
	                <tr>
	                    <th width="60">제목</th>
	                    <td width="130" colspan=3>
	                        <comment id="_NSID_">
	                             <object id=EM_P_TITLE classid=<%=Util.CLSID_EMEDIT%> width=277></object>
	                        </comment>
	                        <script> _ws_(_NSID_);</script>
	                    </td>
	                    <th width="60">내용</th>
	                    <td colspan=3> 
	                        <comment id="_NSID_">
	                             <object id=EM_P_CONTENT classid=<%=Util.CLSID_EMEDIT%> width=308></object>
	                        </comment>
	                        <script> _ws_(_NSID_);</script>
	                    </td> 
	                </TR>  
	        </table>
	        </td></tr> 
	     </table>
	</td></tr>
        
    <tr><td class="dot" ></td></tr> 
     
    <tr><td class="PT01 PB03" valign="top">
		<table cellpadding="0" border="0" cellspacing="0" class="BD4A"  width="100%">
		<tr><td>
			<comment id="_NSID_"><OBJECT id=GD_NOTI_LIST width="100%" height="453" classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_NOTI_LIST">
            </OBJECT></comment><script>_ws_(_NSID_);</script> 
		</td></TR>
        </table>
	</TD></tr>

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

