<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 가맹점관리 > 회원현황(일)
 * 작  성  일  : 2012.05.30
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3110.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *          2012.05.30 (kj) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util,  
   																	   common.vo.SessionInfo, 
   																	   kr.fujitsu.ffw.base.BaseProperty,
   																	   kr.fujitsu.ffw.util.*"%>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
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
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                   *-->
<!--*************************************************************************-->
<%
	String strFromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    strFromDate = strFromDate + "01";
    String strToDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
           
	String dateToyy = strToDate.substring(0,4);
	String dateTommdd   = strToDate.substring(4,8);  
	
	String dateFromyy = strFromDate.substring(0,4);
	String dateFrommmdd   = strFromDate.substring(4,8);  
	 
%>
<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 300;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	 

	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GR_DETAIL"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
    //Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_DETAIL.setDataHeader('<gauce:dataset name="H_DETAIL"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //detail
    
    GR_MASTER.TitleHeight  = 60;
    GR_DETAIL.TitleHeight  = 60;
    
    // EMedit에 초기화
    initEmEdit(EM_FROM_BS_DT, "YYYYMMDD",  PK);           // 기준조회일
    initEmEdit(EM_TO_BS_DT, "YYYYMMDD",  PK);           // 기준조회일
    initEmEdit(EM_FROM_CS_DT, "YYYYMMDD",  PK);           // 대비조회일
    initEmEdit(EM_TO_CS_DT, "YYYYMMDD",  PK);           // 대비조회일    
    
    //조회기간 초기값.
    EM_FROM_BS_DT.text = <%=strFromDate%>;
    EM_TO_BS_DT.text = <%=strToDate%>;
    EM_FROM_CS_DT.text = <%=strFromDate%>;
    EM_TO_CS_DT.text = <%=strToDate%>;     
    
    //전년대비일자(전년으로 처리 16/12/19)
    var date_To_yy = <%=dateToyy%>-01; 
    var date_To_mmdd = date_To_yy + "<%=dateTommdd%>";
    
    var date_From_yy = <%=dateFromyy%>-01;  
    var date_From_mmdd = date_From_yy + "<%=dateFrommmdd%>";
    
    EM_FROM_CS_DT.text = date_From_mmdd;
    EM_TO_CS_DT.text = date_To_mmdd;  
    
     
    //화면 OPEN시 자동 조회
    //btn_Search();
}

function gridCreate1(){

     var hdrProperies = '<FC>id={currow}      		name="NO"             		width=30     align=center</FC>'
                      + '<FC>id=ENTR_CNT       		name="가입기간;신규회원수"     	width=100    align=right SumText=@sum</FC>'
                      + '<FC>id=PRE_ENTR_CNT    	name="대비기간;신규회원수"     	width=100    align=right SumText=@sum</FC>'
                      + '<FC>id=ADD_ENTR_CNT    	name="신규회원;증감수"      	width=100    align=right SumText=@sum</FC>'
                      + '<FC>id=ADD_ENTR_RATE     	name="신규회원;증감율"   	    width=100    align=right </FC>'
                      + '<FC>id=ENTR_RATE   		name="구성비"   				width=100    align=right </FC>'
                      + '<FC>id=ENTR_TOT_CNT   		name="총회원수"     			width=100    align=right SumText=@sum </FC>';                      
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}


function gridCreate2(){

     var hdrProperies = '<FC>id={currow}      	name="NO"             		    width=30     align=center</FC>'
    	              + '<FC>id=ENTR_DT         name="일자"                     width=100    align=center      mask="XXXX/XX/XX"</FC>'
                      + '<FC>id=ENTR_CNT    	name="가입회원수"     	        width=100    align=right SumText=@sum</FC>'
                      + '<FC>id=POINT_CNT    	name="가입회원중;거래회원수"    width=100    align=right SumText=@sum</FC>'
                      + '<FC>id=ADD_CNT     	name="당일거래회원수"   	    width=100    align=right SumText=@sum</FC>';   
                      
                      
                      
    initGridStyle(GR_DETAIL, "common", hdrProperies, false);
    GR_DETAIL.ViewSummary = "1";
}
/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 엑셀       - btn_Excel()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if(trim(EM_FROM_BS_DT.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_FROM_BS_DT.Focus();
        return;
    }
    if(trim(EM_TO_BS_DT.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_TO_BS_DT.Focus();
        return;
    }
    if(trim(EM_FROM_CS_DT.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_FROM_CS_DT.Focus();
        return;
    }
    if(trim(EM_TO_CS_DT.Text).length == 0){   // 조회기간
        showMessage(EXCLAMATION, OK, "USER-1001","조회기간");
        EM_TO_CS_DT.Focus();
        return;
    } 
    showMaster();
    //조회결과 Return
    setPorcCount("SELECT", DS_MASTER.RealCount(1, DS_MASTER.CountRow));
    
    
	//detail 조회
    var goTo        = "searchDetail";    
    var action      = "O";
    var parameters  = "&strFromBSDate="+ encodeURIComponent(EM_FROM_BS_DT.Text)
    				+ "&strToBSDate="  + encodeURIComponent(EM_TO_BS_DT.Text);
    TR_MAIN.Action  ="/dcs/dbri311.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();

    setPorcCount("SELECT", DS_DETAIL.RealCount(1, DS_DETAIL.CountRow));
}

/**
 * btn_Excel()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	var objGrd = "";
	var rtnVal = showMessage(STOPSIGN, CHOOSEUD, "USER-1000", "다운로드 할 그리드를 선택해 주세요.");
    var strDt    = "";	              //기간
    var strEvent = "";				//행사
    var strVen = "";				//협력사
    
	if(rtnVal == "1"){
		objGrd = GR_MASTER;
		

	    var parameters = "가입일자="     + EM_FROM_BS_DT.Text  + " ~ " + EM_TO_BS_DT.Text
	    			   + ",  대비일자="     + EM_FROM_CS_DT.Text  + " ~ "  + EM_TO_CS_DT.Text;
	    
	    var ExcelTitle = "회원현황(일)"
	    
		
	}else if(rtnVal == "2"){
		objGrd = GR_DETAIL;


	    var parameters = "가입일자="    + EM_FROM_BS_DT.Text  + " ~ " + EM_TO_BS_DT.Textt;
	    
	    var ExcelTitle = "일자별 회원 현황"
	    
		
	}else{
		return;
	}
	//openExcel2(objGrd, ExcelTitle, parameters, true);
	openExcel5(objGrd, ExcelTitle, parameters, true, "",g_strPid );
    
    GR_MASTER.Focus();
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 회원현황(일)
 * return값 : void
 */
function showMaster(){
    var goTo        = "searchMaster";    
    var action      = "O";
    var parameters  = "&strFromBSDate="+ encodeURIComponent(EM_FROM_BS_DT.Text)
    				+ "&strToBSDate="  + encodeURIComponent(EM_TO_BS_DT.Text)
    				+ "&strFromCSDate="+ encodeURIComponent(EM_FROM_CS_DT.Text)
    				+ "&strToCSDate="  + encodeURIComponent(EM_TO_CS_DT.Text);
    TR_MAIN.Action  ="/dcs/dbri311.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
   
    if(DS_MASTER.CountRow > 0){
        GR_MASTER.Focus();
    }else{
    	EM_FROM_BS_DT.Focus();
    }
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                        *-->
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
<!-- Head sort oneClick event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!-- 기준조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_BS_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_BS_DT)){
    	EM_FROM_BS_DT.text = <%=strFromDate%>;
    }
</script>
    
<!-- 기준조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_BS_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_TO_BS_DT)){
		EM_TO_BS_DT.text = <%=strToDate%>;
	}
</script>

<!-- 대비조회기간 Start onKillFocus() -->
<script language=JavaScript for=EM_FROM_CS_DT event=onKillFocus()>
    if(!checkDateTypeYMD(EM_FROM_CS_DT)){
    	EM_FROM_CS_DT.text = <%=strFromDate%>;
    }
</script>
    
<!-- 대비조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_CS_DT event=onKillFocus()>
	if(!checkDateTypeYMD(EM_TO_CS_DT)){
		EM_TO_CS_DT.text = <%=strToDate%>;
	}
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
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_MASTER" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_DETAIL" classid=<%= Util.CLSID_DATASET %>> </object>
</comment>
<script>_ws_(_NSID_);</script>


<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<script language='javascript'>
window.onresize = function(){

    var obj   = document.getElementById("GR_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="100" class="point">가입일자</th>
						<td width="200"><comment id="_NSID_"> <object
							id=EM_FROM_BS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_BS_DT)" />-
							<comment id="_NSID_"> <object 
							id=EM_TO_BS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_BS_DT)" /></td>
						<th width="100" class="point">대비일자</th>
						<td><comment id="_NSID_"> <object
							id=EM_FROM_CS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_FROM_CS_DT)" />-
							<comment id="_NSID_"> <object 
							id=EM_TO_CS_DT classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
							onclick="javascript:openCal('G',EM_TO_CS_DT)" /></td>							
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
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GR_MASTER
					width=100% height=150 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_MASTER">
				</OBJECT></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
	 	
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">                
        <td><table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GR_DETAIL width=100% height=300 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_DETAIL">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
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
