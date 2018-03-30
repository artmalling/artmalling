<!-- 
/*******************************************************************************
 * 시스템명 : 시스템관리 > 로그관리> EOD 로그현황
 * 작 성 일 : 2010.06.23
 * 작 성 자 : Hseon
 * 수 정 자 : 
 * 파 일 명 : tcom3050.jsp
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

<script language="javascript">

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var varYesterday = addDate("d", -1, varToday)
    
</script>

<script LANGUAGE="JavaScript"> 

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.24
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 var top = 100;		//해당화면의 동적그리드top위치
 
function doInit(){
 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_EODLOG"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
    // Data Set Header 초기화
    DS_IO_EODLOG.setDataHeader('<gauce:dataset name="H_SEL_EODLOG"/>');
    
    //그리드 초기화
    gridCreate();

    // EMedit에 초기화
    initEmEdit(EM_EOD_DT, "YYYYMMDD", PK);   //EOD일자
    EM_EOD_DT.alignment = 1;
    
    EM_EOD_DT.text =  varToday;

    EM_EOD_DT.Focus();
}

function gridCreate(){

    var hdrProperies = '<FC>id={currow}		width=30   align=center     name="NO"		    bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} </FC>'
                     + '<FC>id=BLD_DT		width=90   align=center     name="실행일자"	    bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} sumtext="합계"	MASK="XXXX/XX/XX" </FC>'
                     + '<FC>id=BLD_TIME		width=100  align=center     name="실행일시"	    bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} MASK="XX:XX:XX:XXX" </FC>'
                     + '<FC>id=STR_CD		width=130  align=center     name="점코드"		bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} show="false" </FC>'
                     + '<FC>id=STR_NAME		width=50   align=left       name="점명"		    bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} show="false" </FC>'
                     + '<FC>id=PROC_ID		width=200  align=left       name="프로세스ID"	bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} </FC>'
                     + '<FC>id=PROCESS_DESC	width=220  align=left       name="프로세스설명"	bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} </FC>'
                     + '<FC>id=LOG_CD		width=70   align=center     name="작업진행"	    bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} </FC>'
                     + '<FG> name="건수"'
                     + '<FC>id=TRG_CNT		width=40   align=right      name="대상"	        bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} sumtext=@sum </FC>'
                     + '<FC>id=SKIP_CNT		width=40   align=right		name="SKIP"	        bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} sumtext=@sum </FC>'
                     + '<FC>id=EXE_CNT		width=40   align=right		name="실행"	        bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} sumtext=@sum </FC>'
                     + '<FC>id=ERR_CNT		width=40   align=right		name="에러"	        bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} sumtext=@sum </FC>'
                     + '<FC>id=CMPL_CNT		width=40   align=right		name="완료"         bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} sumtext=@sum </FC>'
                     + '</FG>'
                     + '<FC>id=LOG_MSG		width=300  align=left 		name="로그메세지"	bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} </FC>'
                     + '<FC>id=ERR_CD		width=70   align=left		name="에러코드"	    bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} </FC>'
                     + '<FC>id=ERR_MSG		width=200  align=left		name="에러메세지"	bgcolor={IF(ERR_CNT > 0 , "red" , IF(SKIP_CNT>0, "yellow", "#FFFFFF") )} </FC>'
                     ;
                     

    initGridStyle(GD_EODLOG, "common", hdrProperies, false); 
    GD_EODLOG.ViewSummary = "1";
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
	 var strEodDt   = EM_EOD_DT.text;         //시작년월
     
     var goTo       = "selectList" ;    
     var action     = "O";     
     var parameters = "&strEodDt="  +encodeURIComponent(strEodDt) ;

     TR_MAIN.Action="/pot/tcom305.tc?goTo="+goTo+parameters;  
     TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_EODLOG=DS_IO_EODLOG)"; //조회는 O
     TR_MAIN.Post();
     
     // 조회결과 Return
     setPorcCount("SELECT", DS_IO_EODLOG.CountRow); 
      
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
<script language=JavaScript for=DS_IO_EODLOG event=OnLoadCompleted(rowcnt)> 
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->   
<script language=JavaScript for=GD_EODLOG event=OnClick(row,colid)>
	if(row<1)sortColId(eval(this.DataID), row, colid);
</script>  

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
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

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_EODLOG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
		                <th width="80" >EOD일자</th> 
                        <td>
                          <comment id="_NSID_">
                            <object id=EM_EOD_DT classid=<%=Util.CLSID_EMEDIT%> width=72 tabindex=1 align="absmiddle"> </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_EOD_DT)" align="absmiddle" />
                        </td>

		            </tr>
		         </table> 
		    </td></tr>
		</table>
	</td></tr>
	<tr><td class="dot" ></td></tr>
    
	<tr><td class="PT01 PB03" valign="top">
		<table cellpadding="0" border="0" cellspacing="0" class="BD4A"  width="100%">
		<tr><td>
			<comment id="_NSID_"><OBJECT id=GD_EODLOG width=100% height="500" classid=<%=Util.CLSID_GRID%>>
			<param name=DataID   value="DS_IO_EODLOG"> 
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

