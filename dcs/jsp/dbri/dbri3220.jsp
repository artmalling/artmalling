<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 > 가맹점관리 > 회원 매출 순위 현황
 * 작  성  일  : 2012.05.30
 * 작  성  자  : kj
 * 수  정  자  : 
 * 파  일  명  : dbri3220.jsp
 * 버         전  : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개         요  : 
 * 이         력  :
 *          2012.05.30 (kj) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
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
 var top = 150;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
 function doInit(){
	 
		//Master 그리드 세로크기자동조정  2013-07-17
		var obj   = document.getElementById("GR_MASTER"); 
		obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	    //Output Data Set Header 초기화
	    DS_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
	    
	    //그리드 초기화
	    gridCreate1(); //마스터
	    
	    // EMedit에 초기화
	    
    	initComboStyle(LC_STR_CD,	DS_IO_STR_CD,	"CODE^0^30,NAME^0^150", 1, PK);        // 점(조회)
    
	    initEmEdit(EM_FROM_BS_DT, "YYYYMMDD",  PK);           // 기준조회일
	    initEmEdit(EM_TO_BS_DT, "YYYYMMDD",  PK);           // 기준조회일
	    //initEmEdit(EM_FROM_CS_DT, "YYYYMMDD",  PK);           // 대비조회일
	    //initEmEdit(EM_TO_CS_DT, "YYYYMMDD",  PK);           // 대비조회일    
	    	    
	    initEmEdit(EM_RANK, 	"NUMBER^3^0", NORMAL);            // 순위
	    initEmEdit(EM_FROM_AMT, 	"NUMBER^13^0", NORMAL);            // 매출금액
	    initEmEdit(EM_TO_AMT, 	"NUMBER^13^0", NORMAL);            // 매출금액  

	    getEtcCode("DS_O_CUST_GRADE", "D", "D011", "Y");
    	getStore("DS_IO_STR_CD",     "Y", "", "N");  

        LC_STR_CD.index   = 0;
        LC_STR_CD.Focus(); 

        EM_RANK.Text = 100;
        EM_FROM_AMT.Text = 0;
        EM_TO_AMT.Text = 9999999999999;
         
	    //조회기간 초기값.
	    EM_FROM_BS_DT.text = <%=strFromDate%>;
	    EM_TO_BS_DT.text = <%=strToDate%>;  
	    
	    //화면 OPEN시 자동 조회
	    //btn_Search();
	    
	    
	}

function gridCreate1(){
     var hdrProperies = '<FC>id={currow}      			name="NO"             	    width=30    align=center  show=false </FC>'
                      + '<FC>id=NUM      			    name="순위"                 width=30    align=center</FC>'
                      + '<FC>id=CUST_NO          		name="회원번호"       		width=100   align=center </FC>'
                      + '<FC>id=CUST_NAME          		name="회운명"       		width=100   align=center </FC>'
                      + '<FC>id=CUST_GRADE              name="회원등급"       		width=100   align=center   EditStyle=Lookup	Data="DS_O_CUST_GRADE:CODE:NAME"  </FC>'
                      + '<FC>id=CUST_SALE_AMT     		name="매출금액"     		width=100   align=right SumText=@sum</FC>'
                      + '<FC>id=CUST_SALE_RATE     		name="구성비"   			width=80   	align=right SumText=@sum </FC>'
                      + '<FC>id=POINT     	         	name="잔여POINT"     		width=100   align=right SumText=@sum</FC>'
                      
    initGridStyle(GR_MASTER, "common", hdrProperies, false);
    GR_MASTER.ViewSummary = "1";
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
	    /*
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
	    */

	    GR_MASTER.ReDraw = "false";
	    showMaster();
	    //조회결과 Return
	    setPorcCount("SELECT", DS_MASTER.RealCount(1, DS_MASTER.CountRow));

	    GR_MASTER.ReDraw = "true";
	}

/**
 * btn_Excel()
 * 작 성 자     : kj
 * 작 성 일     : 2012.05.30
 * 개       요     : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	var strStrCd  = LC_STR_CD.Text;				//점

    var strFromDt = EM_FROM_BS_DT.text;      				//시작일자
    var strToDt   = EM_TO_BS_DT.text;       				//종료일자
    
	var strRank = EM_RANK.text;        					//순위
    var str_from_amt = EM_FROM_AMT.text;        		//매출금액
    var str_to_amt   = EM_TO_AMT.text;       			//매출금액 
    
        
    var ExcelTitle = "회원 매출 순위 현황"
    var parameters = "점="        + strStrCd
				    + " ,매출일자="   + strFromDt + "~" + strToDt
				    + " ,순위TOP="       + strRank
				    + " ,매출금액="   + str_from_amt + "~" + str_to_amt
					;
    //openExcel2(GR_MASTER, ExcelTitle, parameters, true );
    openExcel5(GR_MASTER, ExcelTitle, parameters, true , "",g_strPid );
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * showMaster()
 * 작 성 자     : kj
 * 작 성 일     : 2010-02-16
 * 개       요     : 일단위 포인트 현황 조회 
 * return값 : void
 */
function showMaster(){
    
	var strStrCd  = LC_STR_CD.BindColVal;				//점

    var strFromDt = EM_FROM_BS_DT.text;      				//시작일자
    var strToDt   = EM_TO_BS_DT.text;       				//종료일자
    
	var strRank = EM_RANK.text;        					//순위
    var str_from_amt = EM_FROM_AMT.text;        		//매출금액
    var str_to_amt   = EM_TO_AMT.text;       			//매출금액 
    
    var goTo        = "searchMaster";    
    var action      = "O";
    var parameters  = "&strStrCd="     + encodeURIComponent(strStrCd)
					+ "&strFromDt="    + encodeURIComponent(strFromDt)
					+ "&strToDt="      + encodeURIComponent(strToDt)
					+ "&strRank="      + encodeURIComponent(strRank)
					+ "&str_from_amt=" + encodeURIComponent(str_from_amt)
					+ "&str_to_amt="   + encodeURIComponent(str_to_amt)
					;
    TR_MAIN.Action  ="/dcs/dbri322.db?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    if(DS_MASTER.CountRow > 0){
        GR_MASTER.Focus();
              
  		 var irow = DS_MASTER.CountRow;
  		 
  		 //금액 합계
  		 var strTot_Amt = DS_MASTER.NameSum('CUST_SALE_AMT',1, DS_MASTER.CountRow); 
	       		 
  		 for(i=1; i<=DS_MASTER.CountRow; i++){ 
  			 //비중 = (매출금액/매출금액합계) *100
//   			 alert((DS_MASTER.NameValue(i, "CUST_SALE_AMT")/strTot_Amt)*100);
//   			 alert(Math.round((DS_MASTER.NameValue(i, "CUST_SALE_AMT")/strTot_Amt)*100));
//   			 alert(Math.round((DS_MASTER.NameValue(i, "CUST_SALE_AMT")/strTot_Amt)*10000)/100);
  			 //DS_MASTER.NameValue(i, "CUST_SALE_RATE") = Math.round((DS_MASTER.NameValue(i, "CUST_SALE_AMT")/strTot_Amt)*10000)/100; 
  			 DS_MASTER.NameValue(i, "CUST_SALE_RATE") = (DS_MASTER.NameValue(i, "CUST_SALE_AMT")/strTot_Amt)*100; 
  			 // Math.round(2.49);

  		 }
  		 
  		DS_MASTER.ResetStatus();
       
        
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
    //sortColId( eval(this.DataID), row, colid);
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
//    if(!checkDateTypeYMD(EM_FROM_CS_DT)){
    	//EM_FROM_CS_DT.text = <%=strFromDate%>;
    //}
</script>
    
<!-- 대비조회기간 End onKillFocus() -->
<script language=JavaScript for=EM_TO_CS_DT event=onKillFocus()>
	//if(!checkDateTypeYMD(EM_TO_CS_DT)){
//		EM_TO_CS_DT.text = <%=strToDate%>;
//	}
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
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_IO_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object>
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

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    

}
</script>

<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>


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
						<th width="80" class="point">점</th>
						<td width="170">  
							<comment id="_NSID_">
		                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=130 tabindex=1 align="absmiddle">
		                        </object>
		                    </comment><script>_ws_(_NSID_);</script> 
                  		</td> 
						<th width="100" class="point">매출일자</th>
						<td><comment id="_NSID_"> <object
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
							<!-- 
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
							 -->							
					</tr>
					<tr>
						<th width="80" class="point">순위</th>
						<td ><comment id="_NSID_">
		                      <object id=EM_RANK classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
						</td>
						<th width="80" >매출금액</th>
						<td  > 
						 <comment id="_NSID_">
		                      <object id=EM_FROM_AMT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                 ~
		                  <comment id="_NSID_">
		                      <object id=EM_TO_AMT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
			            </td> 
			            
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
		<td class="PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><object id=GR_MASTER width="100%" height=500
					 classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_MASTER" tabindex=1>
				</object></td>
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
