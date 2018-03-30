<!-- 
 * 시스템명 : 포인트카드 > 고객관리 > 회원관리 > 회원조회
 * 작 성 일 : 2016.11.01
 * 작 성 자 : KHJ
 * 수 정 자 : 
 * 파 일 명 : dctm5010.jsp
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
 var g_strPid           = "<%=pageName%>";                 // PID
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
    
    initComboStyle(LC_CUST_GRADE, DS_O_CUST_GRADE, "CODE^0^30,NAME^0^110", 1, PK); //회원등급
    initComboStyle(LC_SEX_CD, DS_O_SEX_CD, "CODE^0^30,NAME^0^110", 1, PK); //성별
//     initComboStyle(LC_MOBILE_COMP, DS_O_MOBILE_COMP, "CODE^0^30,NAME^0^110", 1, PK); //통신사
    initComboStyle(LC_BIR_MONTH_S, DS_O_BIR_MONTH, "CODE^0^0,NAME^0^60", 1, NORMAL); //생일월
    initComboStyle(LC_STR_CD,	DS_IO_STR_CD,	"CODE^0^30,NAME^0^150", 1, PK);        // 점(조회)

    initEmEdit(EM_ADDR,    "GEN^100",    NORMAL);     //주소
    // EMedit에 초기화
    initEmEdit(EM_FROM_DT, "YYYYMMDD", PK);            // 시작일
    initEmEdit(EM_TO_DT, 	"YYYYMMDD", PK);            // 종료일

    initEmEdit(EM_FROM_POINT, 	"NUMBER^9^0", NORMAL);            // 포인트
    initEmEdit(EM_TO_POINT, 	"NUMBER^9^0", NORMAL);            // 포인트    
      
    getEtcCode("DS_O_CUST_GRADE", "D", "D011", "Y");
    getEtcCode("DS_O_SEX_CD", "D", "D002", "Y");
    getEtcCode("DS_O_MOBILE_COMP", "D", "D131", "Y");
    getEtcCode("DS_O_BIR_MONTH", "D", "M100", "Y");
    getStore("DS_IO_STR_CD",     "Y", "", "N");  
   
    //조회일자 초기값.
    LC_CUST_GRADE.Index = 0;
    LC_SEX_CD.Index = 0;
//     LC_MOBILE_COMP.Index = 0;
    LC_BIR_MONTH_S.Index = 0;

    EM_FROM_POINT.Text = 0;
    EM_TO_POINT.Text = 999999999;
    
    LC_STR_CD.index   = 0;
    LC_STR_CD.Focus(); 
     
    EM_FROM_DT.Text = <%=fromDate%>;
    EM_TO_DT.Text = <%=toDate%>;
    
    //화면OPEN시 조회
    //btn_Search();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"           	 width=40    edit=none	align=center sumtext="회원수"</FC>'
                     + '<FC>id=CUST_ID      name="회원ID"        	 width=90    edit=none	align=center sumtext={count(CUST_ID)}</FC>'
                     + '<FC>id=CUST_NAME    name="회원명"       	 width=94    edit=none	align=left </FC>'
                     + '<FC>id=SEX_NM       name="성별"       	     width=60    edit=none	align=left </FC>'
                     + '<FC>id=BIRTH_DT     name="생년월일" 	     width=100   edit=none	align=center mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=AGE   	    name="나이" 	         width=60   edit=none	align=center mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=MOBILE_PH    name="핸드폰번호"        width=120   edit=none	align=center mask="XXX-XXXX-XXXX"</FC>'
                     + '<FC>id=EMAIL        name="이메일주소"        width=150   edit=none	align=left</FC>'
                     + '<FC>id=HNEW_ZIP_CD  name="우편번호"          width=60    edit=none	align=center</FC>'                     
                     + '<FC>id=HNEW_ADDR    name="도로명주소"        width=300   edit=none	align=left</FC>'
                     + '<FC>id=HOME_ADDR    name="지번주소"       	 width=300   edit=none	align=left</FC>'
                     
                     + '<FC>id=ENTR_DT      name="가입일자" 	     width=100   edit=none	align=center mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=POINT        name="누적포인트"        width=100   edit=none	align=right</FC>'
                     + '<FC>id=CUST_GRADE   name="회원등급"          width=100   edit=none	align=center  EditStyle=Lookup	Data="DS_O_CUST_GRADE:CODE:NAME" </FC>'
                     + '<FC>id=CARD_NO      name="카드번호"       	 width=150   edit=none	align=left</FC>'
                     + '<FC>id=SMS_YN		name="문자수신"	width=80	edit=none	align=center color ={if(SMS_YN="N","RED")} </FC>'
                     + '<FC>id=POST_RCV_CD	name="우편물수신"	width=80	edit=none	align=center color ={if(POST_RCV_CD="N","RED")} </FC>'
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

	var strStrCd  = LC_STR_CD.BindColVal;				//점
    var strFromDt = EM_FROM_DT.text;      				//시작일자
    var strToDt   = EM_TO_DT.text;       				//종료일자
	 
    var strCUST_GRADE = LC_CUST_GRADE.BindColVal;  		//회원등급
    var strSEX_CD     = LC_SEX_CD.BindColVal;			//성별
    var strPoint_from = EM_FROM_POINT.text;        		//포인트
    var strPoint_to   = EM_TO_POINT.text;       		//포인트 
    
    var strSMs        = "";								//SMS수신거부제외
    
    if (CHK_SMS.checked == true) {
    	strSMs        = "Y";	
    }
    
    var strDM         = "";								//우편수신거부제외 
    if (CHK_DM.checked == true) {
    	strDM        = "H";	
    }
    
    //strMOBILE_COMP = LC_MOBILE_COMP.BindColVal;
    
    var strBIR_MONTH_S = LC_BIR_MONTH_S.BindColVal;     //생일월
    var strHOME_ADDR   = EM_ADDR.Text;					//주소
    
    var goTo        = "searchMaster";    
    var action      = "O";     
    var parameters  = "&strStrCd="     	   + encodeURIComponent(strStrCd)
			        + "&strFromDt="        + encodeURIComponent(strFromDt)
			        + "&strToDt="     	   + encodeURIComponent(strToDt) 
			        + "&strCUST_GRADE="    + encodeURIComponent(strCUST_GRADE)
                    + "&strSEX_CD="        + encodeURIComponent(strSEX_CD)
                    + "&strPoint_from="    + encodeURIComponent(strPoint_from)
                    + "&strPoint_to="      + encodeURIComponent(strPoint_to)
                    + "&strSMs="           + encodeURIComponent(strSMs)
                    + "&strBIR_MONTH_S="   + encodeURIComponent(strBIR_MONTH_S)
                    + "&strHOME_ADDR="     + encodeURIComponent(strHOME_ADDR)
                    + "&strDM="           + encodeURIComponent(strDM)
                    ;
                  
    TR_MAIN.Action  = "/dcs/dctm501.dm?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    
    if (DS_O_MASTER.CountRow > 0 )
        GD_MASTER.Focus();
    else 
    	EM_ADDR.Focus();    
}

/**
 * btn_Excel()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	var strStrCd  = LC_STR_CD.Text; 			     	//점
    var strFromDt = EM_FROM_DT.text;      				//시작일자
    var strToDt   = EM_TO_DT.text;       				//종료일자
	 
    var strCUST_GRADE = LC_CUST_GRADE.Text;  		    //회원등급
    var strSEX_CD     = LC_SEX_CD.Text;             	//성별
    var strPoint_from = EM_FROM_POINT.text;        		//포인트
    var strPoint_to   = EM_TO_POINT.text;       		//포인트 
    
    var strSMs        = "";								//SMS수신거부제외 
    if (CHK_SMS.checked == true) {
    	strSMs        = "SMS수신거부제외 ";	
    }
    //strMOBILE_COMP = LC_MOBILE_COMP.BindColVal;
    
    var strDM         = "";								//우편수신거부제외 
    if (CHK_DM.checked == true) {
    	strDM        = "우편수신거부제외";	
    }
    
    var strBIR_MONTH_S = LC_BIR_MONTH_S.Text;           //생일월
    var strHOME_ADDR   = EM_ADDR.Text;					//주소
    
    
    
    
    var ExcelTitle = "회원 조회"
    var parameters = "가입점="        + strStrCd
				    + " ,가입기간="   + strFromDt + "~" + strToDt
				    + " ,회원등급="   + strCUST_GRADE
                    + " ,성별="       + strSEX_CD
				    + " ,포인트="     + strPoint_from + "~" + strPoint_to
				    + " ,"            + strSMs
				    + " ,"            + strDM
                    + " ,생일월="     + strBIR_MONTH_S
                    + " ,주소="       + strHOME_ADDR;
    //openExcel2(GD_MASTER, ExcelTitle, parameters, true );
    openExcel5(GD_MASTER, ExcelTitle, parameters, true , "",g_strPid );

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
    EM_ADDR.Text = ""; 

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
						<th width="80" class="point">가입점</th>
						<td width="170">  
							<comment id="_NSID_">
		                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=130 tabindex=1 align="absmiddle">
		                        </object>
		                    </comment><script>_ws_(_NSID_);</script> 
                  		</td> 
						<th width="80" class="point">가입기간</th>
						<td width="350" > 
						 <comment id="_NSID_">
		                      <object id=EM_FROM_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_FROM_DT" onclick="javascript:openCal('G',EM_FROM_DT)" align="absmiddle" />
		                  ~
		                  <comment id="_NSID_">
		                      <object id=EM_TO_DT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                  <img src="/<%=dir%>/imgs/btn/date.gif" id="IMG_TO_DT" onclick="javascript:openCal('G',EM_TO_DT)" align="absmiddle" />
			            </td> 
						<th width="80" class="point">회원등급</th>
						<td><comment id="_NSID_"> <object
							id=LC_CUST_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=130
							tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
						</td>
					</tr>
					<tr>
						<th width="80" class="point">성별</th>
						<td ><comment id="_NSID_"> <object
							id=LC_SEX_CD classid=<%=Util.CLSID_LUXECOMBO%> width=130
							tabindex=5></object> </comment> <script> _ws_(_NSID_);</script></td>
						</td>
						<th width="80" > 포인트</th>
						<td  > 
						 <comment id="_NSID_">
		                      <object id=EM_FROM_POINT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
		                 ~
		                  <comment id="_NSID_">
		                      <object id=EM_TO_POINT classid=<%=Util.CLSID_EMEDIT%>  width=110 tabindex=1 align="absmiddle">
		                      </object>
		                  </comment><script> _ws_(_NSID_);</script>
			            </td> 
			            
						<td  colspan="2" ><input type="checkbox" id=CHK_SMS value="F"   align="absmiddle"  tabindex=1 >SMS수신거부제외
							<input type="checkbox" id=CHK_DM value="F"   align="absmiddle"  tabindex=1 >우편수신거부제외
						</td>
					</tr>
					<tr>
						<th width="80" >생일월</th>
						<td><comment id="_NSID_"> <object
							id=LC_BIR_MONTH_S classid=<%=Util.CLSID_LUXECOMBO%> width=130
							tabindex=5></object> </comment><script> _ws_(_NSID_);</script>
						</td>
						<th width="80" >주소</th>
						<td colspan="3"><comment id="_NSID_"> <object id=EM_ADDR
							width=280 classid=<%=Util.CLSID_EMEDIT%> tabindex=1
							align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
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
				<td><object id=GD_MASTER width="100%" height=500
					classid=<%=Util.CLSID_GRID%> tabindex=1>
					<param name="DataID" value="DS_O_MASTER" tabindex=1>
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
