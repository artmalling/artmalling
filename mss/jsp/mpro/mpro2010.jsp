<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 경영관리 > 약속관리 > 약속분석 
 * 작 성 일 : 2011.03.03
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : mpro2010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 약속현황관리
 * 이    력 :
 *         2011.03.03 오형규(신규작성)
           2011.03.03 오형규(프로그램작성)
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
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
var syear;
var smon;
var strOrgCd;
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	 
	today = new Date();
    var year = today.getYear();      //현재 년
    var month = today.getMonth()+1;   //현재 월
    var day = today.getDate();
	    
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_Detail.setDataHeader('<gauce:dataset name="H_PROMI_CALENDAL"/>');//조직
    //그리드 초기화
   // gridCreate1(); //마스터
    
    // EMedit에 초기화
    
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);     //점(조회)
    initComboStyle(LC_O_CALSSIFYCD,DS_LC_DEPT_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // 팀     
    initComboStyle(LC_O_TEAM_CD,DS_LC_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL); // 파트    
    initComboStyle(LC_O_PC_CD,DS_LC_PC_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);   //pc(조회)
    
    getStore("DS_O_STR_CD", "Y", "1", "N");          //점코드
    getDept("DS_LC_DEPT_CD", "N", LC_O_STR_CD.BindColVal, "Y");
    getTeam("DS_LC_TEAM_CD", "N", LC_O_STR_CD.BindColVal, LC_O_CALSSIFYCD.BindColVal, "Y");
    getPc("DS_LC_PC_CD", "N", LC_O_STR_CD.BindColVal, LC_O_CALSSIFYCD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y");
    
    LC_O_STR_CD.Index = 0;
    LC_O_CALSSIFYCD.Index = 0;
    LC_O_TEAM_CD.Index = 0;
    LC_O_PC_CD.Index = 0;
    LC_O_STR_CD.Focus();
    
    enableControl(LC_O_TEAM_CD, false);
    enableControl(LC_O_PC_CD, false);
    
    getCalandal(year, month);      //달력 
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	var year = document.getElementById("selyear").value;
	var month = document.getElementById("selmon").value;	
	getCalandal(year, month);
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
function getDetail(year, month){   //값을 가지고 오기
    
	var months;
	if( String(month).length == 1 ){
		months = "0" + String(month);
	}
	
	var YearMon = String(year) + months;
	 
	
		
	strOrgCd = LC_O_STR_CD.BindColVal;//점코드
	
    if( LC_O_CALSSIFYCD.BindColVal == "" || LC_O_CALSSIFYCD.BindColVal == "%"  ){
    	strOrgCd += "";
    }else {
    	strOrgCd += LC_O_CALSSIFYCD.BindColVal;
    	
    	if( LC_O_TEAM_CD.BindColVal == "" || LC_O_TEAM_CD.BindColVal == "%" ){
    		strOrgCd += "";	
    	}else {
    		strOrgCd += LC_O_TEAM_CD.BindColVal;
    		
    		if( LC_O_PC_CD.BindColVal == "" || LC_O_PC_CD.BindColVal == "%" ){
    			strOrgCd += "";	
    		}else {
    			strOrgCd += LC_O_TEAM_CD.BindColVal;
    		}
    	}
    }

	var goTo = "getDetail";        
    TR_MAIN.Action = "/mss/mpro201.mp?goTo="+goTo+"&strOrgCd="+encodeURIComponent(strOrgCd)+"&YearMon="+encodeURIComponent(YearMon);
    TR_MAIN.KeyValue="SERVLET(O:DS_Detail=DS_Detail)"; //조회는 O
    TR_MAIN.Post();
    
    
} 

function callDetailPop(year , month , day){
	
	var mon = String(month);
	var day = String(day);
	
	if( mon.length == 1 ){
		mon = "0" + mon;
	}
	if( day.length == 1 ){
		day = "0" + day;
	}
	
	var date = String(year) + mon + day;	
	var arrArg  = new Array();
	
	arrArg.push(strOrgCd);
	arrArg.push(date);
	
	var returnVal= window.showModalDialog("/mss/mpro201.mp?goTo=listDtl",
            arrArg,
            "dialogWidth:840px;dialogHeight:710px;scroll:no;" +
            "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	
}

function getCalandal(year, month){
    
	getDetail(year, month);
    
    var firstday = new Date(parseInt(year), parseInt(month)-1, 1);    
    var firstdayweek = firstday.getDay();    
    var Lday = new Date(year, month, 0);
    var lastday = Lday.getDate();        
    var tempRow;
    count = 0;
    line = 1;
    var h=1;
    
    var content = "";
    content = "<table width='100%' height='100%' cellpadding=0 cellspacing=0 style='border-collapse:collapse; empty-cells:show; ' >";
    content += "<tr>";
    content += "<td COLSPAN=7 class='d_date' width='100%'  align='center'>";
    content += "<table width='100%' align='center'>";
    content += "<td>";
    
    content += "<a href='javascript:void(0);' onclick='perYear("+year+", "+month+");'><img src='/<%=dir%>/imgs/btn/first.gif' align=absmiddle hspace='2'></a><a href='javascript:void(0);' onclick='PerMonth("+year+","+month+");'><img src='/<%=dir%>/imgs/btn/before2.gif' align=absmiddle hspace='2'></a> ";
    content += "<input type='text' id='selyear' ReadOnly value='"+year+"' class='d_nu' >";
    content += "<input type='text' id='selmon' ReadOnly value='"+month+"' class='d_nu' >";
    content += "<a href='javascript:void(0);' onclick='nextMonth("+year+","+month+");' ><img src='/<%=dir%>/imgs/btn/next2.gif' align=absmiddle hspace='2'></a><a href='javascript:void(0);' onclick='nextYear("+year+", "+month+");' ><img src='/<%=dir%>/imgs/btn/last.gif' align=absmiddle hspace='2'></a>";
    
    content +="</td>"
   	content += "<td  class='right b' valign='bottom'>" 
	content += "<img src='/<%=dir%>/imgs/comm/square_red.gif' align=absmiddle hspace='2'>접수건수(<span class='red'>처리예정건수</span> / <span class='sky'>완료건수</span>)</td>";
	content += "</table>"
    content +="</td>"
			 
  
    content += "</tr>";
    content += "<tr><td class='d_red' >일</td><td class='d_com'>월</td><td class='d_com'>화</td><td class='d_com'>수</td><td class='d_com'>목</td><td class='d_com'>금</td><td class='d_blue'>토</td></Tr>";
    content += "<tr align=center>";
    
    for( i = 0; i < firstdayweek; i++ ){
    content += "<td class='d_day'>&nbsp;</td>";   
       line++;  
    }
    for(j = 1; j <= lastday; j++ ){
        if( line == 8 ){
    content += "</tr><tr align=center>";
            line = 1;
        }
           
        if(DS_Detail.CountRow < 1 ){
        	content += "<td id='td"+j+"' class='d_day'>"+j+"<br><span class=''>0</span> (<span class='red'>0</span>/0)</span></td>";
        }else {
	        for(k = h; k <= DS_Detail.CountRow; k++ ){
	        	
	        	if( DS_Detail.NameValue(k, "DAYS") == j ){
	        		tempRow = k;
	        		break;
	        	}else {
	        		tempRow = 0;
	        	}
	        }
	        
	        if ( tempRow != 0 ){
	            content += "<td id='td"+j+"' class='d_day' >"+j+"<br><a href='javascript:void(0);' onclick='callDetailPop("+year+", "+month+", "+j+");' ><span class='red'>"+DS_Detail.NameValue(tempRow, "PROMISS")+"</sapn></a></td>";	
	        	
	        }else {
	        	content += "<td id='td"+j+"' class='d_day'>"+j+"<br> 0 (0/0) </td>";
	        }        
        }
        
        line++;  
    }
    content += "</tr>"        
        
    content += "</tr>";
    content += "</table>"
    
    document.getElementById('calandal').innerHTML = content;    
}

function perYear(year, month){
	
	var cYear;
	var cMonth;
	
	cYear = round(year, 0) - 1;
	cMonth = month;
	
	getCalandal(cYear, cMonth);
	
}
function PerMonth( year , month ){
    
    var mm = month;  
    var cYear;
    var cMonth;
    
    if( mm == "1" ){    
       cYear = round(document.getElementById('selyear').value, 0) - 1;
       cMonth = "12"; 
       
    }else {     
        cYear = document.getElementById('selyear').value;
        cMonth = round(document.getElementById('selmon').value, 0) - 1;
             
    }
   
    getCalandal(cYear, cMonth);
    
}
function nextMonth(year, month){
	var mm = month;  
    var cYear;
    var cMonth;    
    
    if( mm == "12" ){
    	cYear = round(document.getElementById('selyear').value, 0) + 1;
    	cMonth = "1";
    }else {
    	cYear = document.getElementById('selyear').value;
    	cMonth = round(document.getElementById('selmon').value, 0) + 1;
    }
        
    getCalandal(cYear, cMonth);
}
function nextYear(year, month){
    var cYear;
    var cMonth;
    
    cYear = round(year, 0) + 1;
    cMonth = month;
    
    getCalandal(cYear, cMonth);
}

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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange()>

    getDept("DS_LC_DEPT_CD", "Y", LC_O_STR_CD.BindColVal, "Y");
    
    if( LC_O_STR_CD.BindColVal == "" || LC_O_STR_CD.BindColVal == "%" ){
    	/* 팀  비활성화*/
    	enableControl(LC_O_CALSSIFYCD, false);    	
    	LC_O_CALSSIFYCD.Index = 0;
    	
    	/* 파트 비활성화 */
    	enableControl(LC_O_TEAM_CD, false);    	
    	LC_O_TEAM_CD.Index = 0;
    	
    	/* pc 비활성화 */
    	enableControl(LC_O_PC_CD, false);    	
    	LC_O_PC_CD.Index = 0;
    }else {
    	/* 팀 활성화*/
    	enableControl(LC_O_CALSSIFYCD, true);    	
    	LC_O_CALSSIFYCD.Index = 0;    	
    	
    }

</script>

<script language=JavaScript for=LC_O_CALSSIFYCD event=OnSelChange()>

    getTeam("DS_LC_TEAM_CD", "Y", LC_O_STR_CD.BindColVal, LC_O_CALSSIFYCD.BindColVal, "Y");
    
    if( LC_O_CALSSIFYCD.BindColVal == "" || LC_O_CALSSIFYCD.BindColVal == "%" ){
    	/* 파트 비활성화 */
        enableControl(LC_O_TEAM_CD, false);        
        LC_O_TEAM_CD.Index = 0;
        
        /* pc 비활성화 */
        enableControl(LC_O_PC_CD, false);        
        LC_O_PC_CD.Index = 0;
    }else {
    	/* 파트 활성화 */
        enableControl(LC_O_TEAM_CD, true);        
        LC_O_TEAM_CD.Index = 0;
        
        
    }

</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange()>

    getPc("DS_LC_PC_CD", "Y", LC_O_STR_CD.BindColVal, LC_O_CALSSIFYCD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y"); 
    
    if( LC_O_TEAM_CD.BindColVal == "" || LC_O_TEAM_CD.BindColVal == "%" ){
    	/* pc 비활성화 */
        enableControl(LC_O_PC_CD, false);
        LC_O_PC_CD.Index = 0;
    }else {
    	 /* pc 비활성화 */
        enableControl(LC_O_PC_CD, true);        
        LC_O_PC_CD.Index = 0;
    }
    
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

<comment id="_NSID_"><object id=DS_I_CONDITION  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_DEPT_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_TEAM_CD"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LC_PC_CD"       classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_Detail"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

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
<table width="100%"  border="0" cellspacing="0"  cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0"  cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td>
          <!-- search start -->
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>            
                <th width="80">점</th>
                <td>
                        <comment id="_NSID_">
                            <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=140 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>    
                </td>
                <th width="80">팀</th>
                <td>
                        <comment id="_NSID_">
                            <object id=LC_O_CALSSIFYCD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=140 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="80">파트</th>
                <td>
                        <comment id="_NSID_">
                            <object id=LC_O_TEAM_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=140 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                </td>
                <th width="80">PC</th>
                <td>
                        <comment id="_NSID_">
                            <object id=LC_O_PC_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1 width=140 align="absmiddle">
                            </object>
                        </comment><script>_ws_(_NSID_);</script>
                </td>                   
          </table>
        </td>
        </tr>
    </table></td>
  </tr> 
  <tr>
    <td class="dot"  ></td>
  </tr>  
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><div id="calandal"></div>
        </td>
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

