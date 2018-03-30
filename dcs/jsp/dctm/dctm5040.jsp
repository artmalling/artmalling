<!-- 
 * 시스템명 : 포인트카드 > 고객관리 > 회원관리 > 회원조회
 * 작 성 일 : 2016.11.01
 * 작 성 자 : KHJ
 * 수 정 자 : 
 * 파 일 명 : dctm5040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    request.setCharacterEncoding("utf-8");
    String dir = BaseProperty.get("context.common.dir");
    
    String fromDate = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());  
    fromDate = fromDate + "01";
    String toDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
 // PID 확인을 위한
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
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
var strCompPersFlag = "P";
var g_strPid           = "<%=pageName%>";                 // PID
var	now	= new Date();
var	mon	= now.getMonth()+1;
if(mon < 10)mon	= "0" +	mon;
var	day	= now.getDate();
if(day < 10)day	= "0" +	day;
var varbfYear= now.getYear()-1; //전년도
var	varToday = now.getYear().toString()+ mon + day;
var	varToMon = now.getYear().toString()+ mon;
var	varBf_Year_Mon = varbfYear.toString()+ mon;
var old_Row = 0;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 150;		//해당화면의 동적그리드top위치
function doInit(){

    //Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
    // Input Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    //-- 검색 필드
    
//    initComboStyle(LC_CUST_GRADE, DS_O_CUST_GRADE, "CODE^0^30,NAME^0^110", 1, PK); //회원등급
//    initComboStyle(LC_SEX_CD, DS_O_SEX_CD, "CODE^0^30,NAME^0^110", 1, PK); //성별
//     initComboStyle(LC_MOBILE_COMP, DS_O_MOBILE_COMP, "CODE^0^30,NAME^0^110", 1, PK); //통신사
//    initComboStyle(LC_BIR_MONTH_S, DS_O_BIR_MONTH, "CODE^0^0,NAME^0^60", 1, NORMAL); //생일월
//    initComboStyle(LC_STR_CD,	DS_IO_STR_CD,	"CODE^0^30,NAME^0^150", 1, PK);        // 점(조회)

//    initEmEdit(EM_ADDR,    "GEN^100",    NORMAL);     //주소
    // EMedit에 초기화
    initEmEdit(EM_FROM_DT, "YYYYMM", PK);            // 시작일
//    initEmEdit(EM_TO_DT, 	"YYYYMMDD", PK);            // 종료일

//    initEmEdit(EM_FROM_POINT, 	"NUMBER^9^0", NORMAL);            // 포인트
//    initEmEdit(EM_TO_POINT, 	"NUMBER^9^0", NORMAL);            // 포인트
	  initEmEdit(TXT_EM_MEMO,   "GEN^2000", NORMAL); //내용
      
//    getEtcCode("DS_O_CUST_GRADE", "D", "D011", "Y");
//    getEtcCode("DS_O_SEX_CD", "D", "D002", "Y");
//    getEtcCode("DS_O_MOBILE_COMP", "D", "D131", "Y");
//    getEtcCode("DS_O_BIR_MONTH", "D", "M100", "Y");
//    getStore("DS_IO_STR_CD",     "Y", "", "N");  
   
    //조회일자 초기값.
//    LC_CUST_GRADE.Index = 0;
//    LC_SEX_CD.Index = 0;
//     LC_MOBILE_COMP.Index = 0;
//    LC_BIR_MONTH_S.Index = 0;

//    EM_FROM_POINT.Text = 0;
//    EM_TO_POINT.Text = 999999999;
    
//    LC_STR_CD.index   = 0;
//    LC_STR_CD.Focus(); 
     
    EM_FROM_DT.Text = varToMon;
    TXT_EM_MEMO.Enable = true;
    TXT_EM_MEMO.Readonly = true;
    TXT_EM_MEMO.text="조회되는 내역을 선택하면 문자 내용을 확인할 수 있습니다.";
    
    //화면OPEN시 조회
    //btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"           	width=40    edit=none	align=center sumtext="합  계"</FC>'
                     + '<FC>id=GRP_SEQ      name="발송그룹순번"      	width=90    edit=none	show=false	</FC>'
                     + '<FC>id=TRAN_TYPE    name="발송형태" 			width=80   edit=none	align=center bgcolor={decode(TRAN_TYPE,"SMS","#4CAF50","LMS","#2196F3","MMS","#ff9800")} color ="#ffffff"</FC>'
                     + '<FC>id=TRAN_DATE    name="발송일자" 			width=100   edit=none	align=center mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=REG_DATE    	name="등록일자" 			width=100   edit=none	align=center mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=REQ_PART   	name="요청부서" 	     	width=60   edit=none	align=center show=false </FC>'
                     + '<FC>id=TRAN_GUBUN   name="발송구분"        	width=120   edit=none	align=center show=false </FC>'
                     + '<FC>id=SMS_SUBJ     name="제목"        		width=150   edit=none	align=left </FC>'
                     + '<FC>id=SMS_CONT  	name="내용"          	width=60    edit=none	align=left show=false </FC>'                     
                     + '<FC>id=TRAN_ID		name="발송자"			width=100	edit=none	align=center color ={if(SMS_YN="N","RED")} </FC>'
                     + '<FC>id=REG_ID      	name="등록자"       		width=100   edit=none	align=center</FC>'
                     + '<FC>id=TRAN_REQ_CNT name="발송요청"       	width=90   edit=none	align=right  sumtext={subsum(TRAN_REQ_CNT)} </FC>'
                     + '<FC>id=TRAN_CNT    	name="발송성공"       	width=90   edit=none	align=right sumtext={subsum(TRAN_CNT)} </FC>'
                     + '<FC>id=PURE_AMT     name="공급가액" 	     	width=80   edit=none	align=right  sumtext={subsum(PURE_AMT)} </FC>'
                     + '<FC>id=VAT        	name="VAT"        		width=70   edit=none	align=right	sumtext={subsum(VAT)}</FC>'
                     + '<FC>id=TOT_AMT   	name="발송비용"          width=100   edit=none	align=right  sumtext={subsum(TOT_AMT)}</FC>'

                     ;
                    
            
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true); 
    //합계표시
    GD_MASTER.ViewSummary = "1";
  
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

//	var strStrCd  = LC_STR_CD.BindColVal;				//점
    var strFromDt = EM_FROM_DT.text;      				//시작일자
//	var strToDt   = EM_TO_DT.text;       				//종료일자
	var strChkGrp = "";
	 
//    var strCUST_GRADE = LC_CUST_GRADE.BindColVal;  		//회원등급
//    var strSEX_CD     = LC_SEX_CD.BindColVal;			//성별
//    var strPoint_from = EM_FROM_POINT.text;        		//포인트
//    var strPoint_to   = EM_TO_POINT.text;       		//포인트 

	if (document.getElementById("CHK_SUBJ_GRP").checked) {
		strChkGrp = "T"; 
	}
	else {
		strChkGrp = "F";
	}
    
    
    
    //strMOBILE_COMP = LC_MOBILE_COMP.BindColVal;
    
//    var strBIR_MONTH_S = LC_BIR_MONTH_S.BindColVal;     //생일월
//    var strHOME_ADDR   = EM_ADDR.Text;					//주소
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  =// "&strStrCd="     	   + encodeURIComponent(strStrCd)
			         "&strFromDt="        + encodeURIComponent(strFromDt)
			       + "&strChkGrp="        + encodeURIComponent(strChkGrp)
                    ;
                  
    TR_MAIN.Action  = "/dcs/dctm504.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 )
        GD_MASTER.Focus();
    
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

//	var strStrCd  = LC_STR_CD.Text; 			     	//점
    var strFromDt = EM_FROM_DT.text;      				//시작일자
//    var strToDt   = EM_TO_DT.text;       				//종료일자
	 
//    var strCUST_GRADE = LC_CUST_GRADE.Text;  		    //회원등급
//    var strSEX_CD     = LC_SEX_CD.Text;             	//성별
//    var strPoint_from = EM_FROM_POINT.text;      		//포인트
//    var strPoint_to   = EM_TO_POINT.text;       		//포인트 
    
    
    
//    var strBIR_MONTH_S = LC_BIR_MONTH_S.Text;           //생일월
//    var strHOME_ADDR   = EM_ADDR.Text;					//주소
    
    
    
    
    var ExcelTitle = "문자발송리스트"
    var parameters =  "발송 월="   + strFromDt;
				    
                    
    //openExcel2(GD_MASTER, ExcelTitle, parameters, true );
    openExcel5(GD_MASTER, ExcelTitle, parameters,true, "",g_strPid );
}

/**
 * btn_New()
 * 작 성 자     : 김영진
 * 작 성 일     : 2010-02-22
 * 개      요      : 신규추가 초기화
 * return값 : void
 */
function btn_New() {
	 
    //조회일자 초기값.   	    
//    EM_ADDR.Text = ""; 

}


/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
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

<!-- 매출시작일 -->
<script	language=JavaScript	for=EM_FROM_DT event=onKillFocus()>

	//영업조회일
	if (isNull(EM_FROM_DT.text) ==true ) {
		showMessage(Information, OK, "USER-1003","발송월"); 
		EM_FROM_DT.text =	varToMon;
		return ;
	}
	//영업조회일	자릿수, 공백	체크
	if (EM_FROM_DT.text.replace("	","").length !=	6 )	{
		showMessage(Information, OK, "USER-1027","발송월","6");
		EM_FROM_DT.text =	varToMon;
		return ;
	}
	//일자형식체크
	if (!checkYYYYMM(EM_FROM_DT.text)	) {
		showMessage(Information, OK, "USER-1069","발송월");
		EM_FROM_DT.text =	varToMon;
		return ;
	}

</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>
	if(row > 0 && old_Row > 0 ){
    	var strContent =  DS_O_MASTER.NameValue(row,"SMS_CONT");
    
    	TXT_EM_MEMO.text = strContent;
	}
	old_Row = row; 
//old_Row = row;

</script>

<!-- Grid sorting 기능  -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
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
<comment id="_NSID_">
<object id="DS_IO_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
 
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_CUST_GRADE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_SEX_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MOBILE_COMP" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_O_BIR_MONTH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
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
						
						<th width="80" class="point">발송월</th>
						<td width="150" > 
						 <comment id="_NSID_">
		                      <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('M',EM_FROM_DT)" align="absmiddle" />
			            </td> 
						<td colspain="3">
							<input type="checkbox" id="CHK_SUBJ_GRP" checked="true"> 동일제목 그룹으로 합치기
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
			<td width="70%"  >
				<object id=GD_MASTER width="100%" height="100%"
						classid=<%=Util.CLSID_GRID%> tabindex=1>
						<param name="DataID" value="DS_O_MASTER" tabindex=1>
				</object>
			</td>
			
				<td width="30%" height="100%">
				<br><center><b>발송 내용</b></center><br>
				<comment id="_NSID_"> <object
						id=TXT_EM_MEMO classid=<%=Util.CLSID_TEXTAREA%> 
						style="
							width: 100%;
							height: 100%;
						"
						align="absmiddle" ></object> </comment> <script> _ws_(_NSID_);</script> 
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
</body>
</html>
