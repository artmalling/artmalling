<!-- 
/*******************************************************************************
 * 시스템명 : 시스템관리 > 로그관리> 배치실행로그
 * 작 성 일 : 2010.07.28
 * 작 성 자 : Hseon
 * 수 정 자 : 
 * 파 일 명 : tcom3030.jsp
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
    DS_O_BATCH.setDataHeader('<gauce:dataset name="H_SEL_BATCH"/>'); 
    
    
    //그리드 초기화
    gridCreate();
    
    //콤보 초기화 : 시스템구분
    initComboStyle(LC_SUBSYS,   DS_O_SUBSYS, "CODE^0^30,NAME^0^80" , 1, NORMAL);
    initComboStyle(LC_BATCH,    DS_O_BATCH , "CODE^0^0,NAME^0^200" , 1, NORMAL);  
    
    //서브시스템 공통 코드 에서 가져 오기
    getEtcCode("DS_O_SUBSYS",   "D", "TC07", "Y");  
    
    //콤보 기본값셋팅 
    setComboData(LC_SUBSYS, "%");   
    setComboData(LC_SUCS_YN, "%");    
    
    // EMedit에 초기화 (조회용)
    initEmEdit(EM_S_DATE    , "TODAY"   , PK);          // 조회기간1
    initEmEdit(EM_E_DATE    , "TODAY"   , PK);          // 조회기간2 
    
    //EM_S_DATE.Focus(); 
}

function gridCreate(){

    var hdrProperies = '<FC>id={currow}     width=30   align=center     name="NO"          	</FC>'
        			 + '<FC>id=RUN_DATE   	width=135  align=center     name="시간"   		</FC>'
                     + '<FC>id=SYS_GBN    	width=90                    name="구분"   	    </FC>'
                     + '<FC>id=COMM_NAME2   width=250                   name="프로세스"	    </FC>'
                     + '<FC>id=SUCC_YN 		width=70   align=center     name="성공여부"		</FC>'
                     + '<FC>id=TOT_CNT		width=70   align=right      name="총건수" 		</FC>' 
                     + '<FC>id=SUC_CNT		width=70   align=right      name="성공건수"      </FC>'
                     + '<FC>id=ERR_CNT		width=70   align=right      name="실패건수"  	</FC>' 
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
        showMessage(STOPSIGN, OK, "USER-1003", "시작일");
        EM_S_DATE.focus();
        return false;
    }
    
    if (EM_E_DATE.text == "" || EM_E_DATE.text.length < 8 ) 
    {
        showMessage(STOPSIGN, OK, "USER-1003", "종료일");
        EM_E_DATE.focus();
        return false;
    }
    
    if(EM_S_DATE.Text > EM_E_DATE.Text){                              // 조회일 정합성
        showMessage(EXCLAMATION, OK, "USER-1015");
        EM_S_DATE.Focus();
        return false;
    }
    
    var strSys		= LC_SUBSYS.BindColVal;		// 시스템구분
    var strBatch 	= LC_BATCH.BindColVal;    	// 프로세스id 
	var strSdate   	= EM_S_DATE.Text;     		// 기간1 
	var strEdate   	= EM_E_DATE.Text;     		// 기간2 
    var strSucsYn   = LC_SUCS_YN.BindColVal;    // 성공여부  
	
 	var goTo       = "selectList" ;    
	var action     = "O";     
	var parameters = "&strSys="  	+encodeURIComponent(strSys)
                   + "&strBatch="	+encodeURIComponent(strBatch)
                   + "&strSdate=" 	+encodeURIComponent(strSdate)
                   + "&strEdate=" 	+encodeURIComponent(strEdate)
                   + "&strSucsYn=" 	+encodeURIComponent(strSucsYn);

	TR_MAIN.Action="/pot/tcom303.tc?goTo="+goTo+parameters;  
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
//시스템구분 -> 프로세스ID
function setBatchCd(strSysGbn)
{
	//그룹 
    var goTo       = "selectBatchCd" ;    
    var action     = "O";     
    var parameters = "&strSysGbn="  +encodeURIComponent(strSysGbn)
    
    TR_MAIN.Action="/pot/tcom303.tc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_BATCH=DS_O_BATCH)"; //조회는 O
    TR_MAIN.Post();
     
	insComboData(LC_BATCH, "%", "전체", 1);	
	LC_BATCH.Index = 0;
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
<script language=JavaScript for=LC_SUBSYS event=OnSelChange>
    DS_O_BATCH.ClearData(); 
	
    if (this.BindColVal == '%'){
        insComboData(LC_BATCH, "%", "전체", 1);
        setComboData(LC_BATCH, "%");
        return;    	
    }
    
    setBatchCd(this.BindColVal); 
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
<comment id="_NSID_"><object id="DS_O_SUBSYS"  		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BATCH" 		classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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
						<th width="40px" class="point">기간</th>
		   				<td width="220">
		                   <comment id="_NSID_"> 
		                       <object id=EM_S_DATE classid=<%=Util.CLSID_EMEDIT%> width=75 align="absmiddle"> </object> 
		                   </comment><script> _ws_(_NSID_);</script>
		                   <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_START_DT onclick="javascript:openCal('G',EM_S_DATE)" align="absmiddle" />
		                   ~ 
		                   <comment id="_NSID_"> 
		                       <object id=EM_E_DATE classid=<%=Util.CLSID_EMEDIT%> width=75 align="absmiddle"> </object> 
		                   </comment><script> _ws_(_NSID_);</script> 
		                   <img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_S_END_DT onclick="javascript:openCal('G',EM_E_DATE)" align="absmiddle" />
		                </td>
		                
		                
		                
		                <th width="40px" >구분</th> 
		                <TD width="100px">
		                    <comment id="_NSID_">
		                        <object id=LC_SUBSYS classid=<%= Util.CLSID_LUXECOMBO %> width=80 align="absmiddle">
		                        </object>
		                    </comment><script>_ws_(_NSID_);</script>
		                </TD>
		                <th width="60">프로세스ID</th>  
		                <TD width="100px">
		                    <comment id="_NSID_">
		                    <object id=LC_BATCH classid=<%= Util.CLSID_LUXECOMBO %> width=160 align="absmiddle"> </object> 
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td> 
		                <th width="50">성공여부</th>  
		                <td>
		                    <comment id="_NSID_">
		                    <object id=LC_SUCS_YN classid=<%= Util.CLSID_LUXECOMBO %> width=60 align="absmiddle">  
		                       <param name=CBDataColumns    value="CODE,NAME"> 
		                       <param name=ListExprFormat   value="CODE^0^15,NAME^0^35"> 
		                       <param name="EditExprFormat" value="%;NAME">    
		                       <param name=CBData           value="%^전체,Y^성공,N^실패">  
		                       <param name=BindColumn       value="CODE">
		                    </object>    
		                    </comment><script>_ws_(_NSID_);</script> 
		                </td> 
		            </tr> 
		            
		         </table> 
		    </td></tr>
		</table>
	</td></tr>
	<tr><td class="dot" ></td>

	<tr><td class="PT01 PB03" valign="top">
		<table cellpadding="0" border="0" cellspacing="0" class="BD4A"  width="100%">
		<tr><td>
			<comment id="_NSID_"><OBJECT id=GD_LIST width=100% height="504" classid=<%=Util.CLSID_GRID%>>
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

