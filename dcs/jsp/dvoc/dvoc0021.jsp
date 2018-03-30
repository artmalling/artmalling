<!-- 
/*******************************************************************************
 * 시스템명 : 고객관리 >  VOC 관리  > 컴플레인 현황(POPUP)
 * 작 성 일 : 2016.11.15
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : DVOC0021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 : 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="common.util.Util, common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty" %>
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
<title>컴플레인 현황</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/jquery-1.4.2.min.js"   type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작 
<!--*************************************************************************-->
<script language="javascript" type="text/javascript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var strStrCd        = dialogArguments[0];
 var strCustId       = dialogArguments[1];
 var strRecDt        = dialogArguments[2];
 var strRecSeq       = dialogArguments[3];
 var strClmGrade       = dialogArguments[4];
 var strRecType        = dialogArguments[5];
 var strClmKind       = dialogArguments[6];
 var strProcDept        = dialogArguments[7];
 var strProcGbn        = dialogArguments[8];
 
 String.prototype.replaceAll = function(org, dest) {
	    return this.split(org).join(dest);
	}
 
 var g_strPid           = "<%=pageName%>";                 // PID
/**
 * doInit() 
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.25
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	 	DS_LOG.setDataHeader('DOWN_COND:STRING(1000),PID:STRING(1000)');
	    initComboStyle(LC_CLM_GRADE, DS_O_S_CLM_GRADE, "CODE^0^30,NAME^0^80", 1, READ);		//클레임 등급
	    initComboStyle(LC_REC_TYPE,  DS_O_S_REC_TYPE,  "CODE^0^30,NAME^0^80", 1, READ);		//접수 형태
	    initComboStyle(LC_STR_CD,	 DS_O_S_STR_CD,    "CODE^0^30,NAME^0^80", 1, READ);		//점 코드
	    initComboStyle(LC_CLM_KIND,  DS_O_S_CLM_KIND,  "CODE^0^30,NAME^0^80", 1, READ);		//클레임 종류
	    initComboStyle(LC_PROC_DEPT, DS_O_S_PROC_DEPT, "CODE^0^30,NAME^0^80", 1, READ);		//처리 부서
	    initComboStyle(LC_PROC_GBN,  DS_O_S_PROC_GBN,  "CODE^0^30,NAME^0^80", 1, READ);		//처리 구분
	    
	    initComboStyle(LC_JOJIK,     DS_O_S_PROC_GBN,  "CODE^0^30,NAME^0^80", 1, READ);		//처리 구분

	    RD_MBR_GBN.enable = false;

	    initEmEdit(EM_CUST_ID,   	 "GEN^40", READ); //회원 번호
	    initEmEdit(EM_CUST_NAME,  	 "GEN^40", READ); //회원 이름
	    initEmEdit(EM_MOBILE_PH1,    "GEN^40", READ); //전화번호
	    initEmEdit(EM_MOBILE_PH2,    "GEN^40", READ); //
	    initEmEdit(EM_MOBILE_PH3,    "GEN^40", READ); //
	    initEmEdit(EM_PROC_ID,       "GEN^40", READ); //처리자
	    initEmEdit(EM_PROC_NAME,       "GEN^40", READ); //처리자
	    initEmEdit(EM_REC_DT,  	     "YYYYMMDD", READ); //등록 일시
	    initEmEdit(EM_PROC_DT,       "YYYYMMDD", READ); //처리 일시
	    initEmEdit(EM_PUMBUN_CD,     "GEN^40", READ); //처리 일시
	    initEmEdit(EM_PUMBUN_NAME,   "GEN^40", READ); //처리 일시
	    
	    initEmEdit(EM_REC_ID,  		 "GEN^40", READ); //등록 아이디
	    initEmEdit(EM_REC_NAME,   	 "GEN^40", READ); //등록 아이디
		initEmEdit(TXT_REC_TITLE,    "GEN^400",  READ);          //제목
		initEmEdit(TXT_REC_CONT,     "GEN^400",  READ);          //내용
		initEmEdit(TXT_REC_SUMMARY,  "GEN^400",  READ);          //요약
		initEmEdit(TXT_PROC_CONT,    "GEN^400",  READ);          //요약


	    getStore("DS_O_S_STR_CD", "N", "", "N"); //점코드
	    getEtcCode("DS_O_S_CLM_GRADE",        "M", "M011", "N"); //클레임 등급
	    getEtcCode("DS_O_S_REC_TYPE",         "M", "M012", "N"); //접수형태
	    getEtcCode("DS_O_S_CLM_KIND",         "M", "M010", "N"); //클레임 종류
	    getEtcCode("DS_O_S_PROC_DEPT",        "M", "M016", "N"); //처리 부서
	    getEtcCode("DS_O_S_PROC_GBN",         "M", "M015", "N"); //처리 구분

	    
		LC_STR_CD.BindColVal = strStrCd;
		LC_CLM_KIND.BindColVal = strClmKind;
		LC_PROC_DEPT.BindColVal = strProcDept;
		LC_PROC_GBN.BindColVal = strProcGbn;

		btn_Search();
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

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * btn_Search()
  * 작 성 자 : FKL
  * 작 성 일 : 2010.04.19
  * 개    요 : 조회시 호출
  * return값 : void
  */
function btn_Search() {
	var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)
					+ "&strCustId=" + encodeURIComponent(strCustId)
					+ "&strRecDt="+ encodeURIComponent(strRecDt)
			        + "&strRecSeq="+ encodeURIComponent(strRecSeq);

 	TR_MAIN.Action   = "/dcs/dvoc002.dv?goTo=searchDetail" + parameters;
 	TR_MAIN.KeyValue = "SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)";
 	TR_MAIN.Post();  
 	
	var ClmGrade = DS_IO_MASTER.NameValue(1, "CLM_GRADE");
	var RecType = DS_IO_MASTER.NameValue(1, "REC_TYPE");
	var MbrGbn = DS_IO_MASTER.NameValue(1, "MBR_GBN");
	
    LC_CLM_GRADE.BindColVal = DS_IO_MASTER.NameValue(1, "CLM_GRADE");
    LC_REC_TYPE.BindColVal  = DS_IO_MASTER.NameValue(1, "REC_TYPE");	
    LC_STR_CD.BindColVal 	= DS_IO_MASTER.NameValue(1, "STR_CD");	
    LC_CLM_KIND.BindColVal  = DS_IO_MASTER.NameValue(1, "CLM_KIND");	
    LC_PROC_DEPT.BindColVal = DS_IO_MASTER.NameValue(1, "PROC_DEPT");	
    LC_PROC_GBN.BindColVal  = DS_IO_MASTER.NameValue(1, "PROC_GBN");	 
    	    
    EM_CUST_ID.Text = DS_IO_MASTER.NameValue(1, "CUST_ID");
    EM_CUST_NAME.Text = DS_IO_MASTER.NameValue(1, "CUST_NAME");
    EM_MOBILE_PH1.Text = DS_IO_MASTER.NameValue(1, "MOBILE_PH1");
    EM_MOBILE_PH2.Text = DS_IO_MASTER.NameValue(1, "MOBILE_PH2");
    EM_MOBILE_PH3.Text = DS_IO_MASTER.NameValue(1, "MOBILE_PH3");
    EM_REC_ID.Text = DS_IO_MASTER.NameValue(1, "REC_ID");
    EM_REC_NAME.Text = DS_IO_MASTER.NameValue(1, "REC_NAME");
    
    
    EM_PROC_ID.Text = DS_IO_MASTER.NameValue(1, "PROC_ID");
    EM_REC_DT.Text = DS_IO_MASTER.NameValue(1, "REC_DT");
    EM_PROC_DT.Text = DS_IO_MASTER.NameValue(1, "PROC_DT");
    EM_PUMBUN_CD.Text = DS_IO_MASTER.NameValue(1, "BRAND_CD");
    EM_PUMBUN_NAME.Text = DS_IO_MASTER.NameValue(1, "PUMBUN_NAME");
    
	TXT_REC_TITLE.Text = DS_IO_MASTER.NameValue(1, "REC_TITLE");
	TXT_REC_CONT.Text = DS_IO_MASTER.NameValue(1, "REC_CONT");
	TXT_REC_SUMMARY.Text = DS_IO_MASTER.NameValue(1, "REC_SUMMARY");
	TXT_PROC_CONT.Text = DS_IO_MASTER.NameValue(1, "PROC_CONT");
	
	
	TXT_REC_CONT2.Text = DS_IO_MASTER.NameValue(1, "REC_CONT2");
	TXT_REC_SUMMARY2.Text = DS_IO_MASTER.NameValue(1, "REC_SUMMARY2");
	TXT_PROC_CONT2.Text = DS_IO_MASTER.NameValue(1, "PROC_CONT2");

	LC_CLM_GRADE.BindColVal = ClmGrade;
	LC_REC_TYPE.BindColVal = RecType;
	RD_MBR_GBN.CodeValue = MbrGbn;
	


  }
/**
 * cpContent(obj)
 * 작 성 자 : jyk
 * 작 성 일 : 2017.11.16
 * 개    요 : 내역 복사
 * return값 : void
 */  
  function cpContent(obj) {
	  window.clipboardData.setData("Text", obj.text);
	  alert("복사되었습니다.");
  }
  
  
  /**
   * exportExcel()
   * 작 성 자 : jyk
   * 작 성 일 : 2017.11.27
   * 개    요 : table tag 내역 엑셀로 변환.
   * return값 : void
   */  
  function exportExcel() {
		// table 태그 생성
	  	var strFileNm = genTableTag();
		 //alert(strFileNm);
		// 생성 내역 전달하여 excel 다운로드로 변환.
		 var goTo       	= "excelExport";				// Action 명 
		 $('#excelSource').val($('#excelexport').html());
		 
		 document.excelForm.action = "/dcs/dvoc002.dv?";
		 document.excelForm.goTo.value = goTo;
		 document.excelForm.fileName.value = encodeURIComponent(strFileNm);
		 document.excelForm.submit();
		 
		 // 엑별 변환 내역 log 기록
		 saveExcelLog(strFileNm);
		 
}
  /**
   * exportExcel()
   * 작 성 자 : jyk
   * 작 성 일 : 2017.11.27
   * 개    요 : table tag 내역 생성.
   * return값 : string
   */
function genTableTag(){
	// 변수 선언
	  var strClmGrade 	= LC_CLM_GRADE.Text;
	  var strRecType 	= LC_REC_TYPE.Text;
	  var strMbrGbn		= RD_MBR_GBN.DataValue;
	  var strCustId		= EM_CUST_ID.Text;
	  var strCustName	= EM_CUST_NAME.Text;
	  var strMobilePh	= EM_MOBILE_PH1.Text + "-" + EM_MOBILE_PH2.Text + "-" + EM_MOBILE_PH3.Text;
	  var strStrCd		= LC_STR_CD.Text;
	  var strJojik		= LC_JOJIK.Text;
	  var strRecId		= EM_REC_ID.Text;
	  var strRecName	= EM_REC_NAME.Text;
	  if (strRecName.length != 0)
		  strRecName = " - " + strRecName;
	  var strPumbunCd	= EM_PUMBUN_CD.Text;
	  var strPumbunNm	= EM_PUMBUN_NAME.Text;
	  if (strPumbunNm.length != 0)
		  strPumbunNm = " - " + strPumbunNm;
	  var strClmKind	= LC_CLM_KIND.Text;
	  var strRecDt		= EM_REC_DT.Text;
	  var strRecTitle	= TXT_REC_TITLE.Text;
	  //var strRecCont	= TXT_REC_CONT.Text;
	  //var strRecSummary	= TXT_REC_SUMMARY.Text;
	  var strRecCont	= TXT_REC_CONT2.Text;
	  var strRecSummary	= TXT_REC_SUMMARY2.Text;
	  var strProcDept	= LC_PROC_DEPT.Text;
	  var strProcId		= EM_PROC_ID.Text;
	  var strProcName	= EM_PROC_NAME.Text;
	  if (strProcName.length != 0)
		  strProcName = " - " + strProcName;
	  var strProcGbn	= LC_PROC_GBN.Text;
	  var strProcDt		= EM_PROC_DT.Text;
	  //var strProcCont	= TXT_PROC_CONT.Text;
	  var strProcCont	= TXT_PROC_CONT2.Text;
	  
	// 스타일 변수 선언
	  var PT01 = "padding-top:1px;";
	  var PB03 = "padding-bottom:3px;";
	  var o_table = "Border:solid 2px #f2f2f2; padding:2px; background-color:#ebf2f8; font-size:12px;";
	  var s_table = "Border:solid 1px #b4d0e1; padding-left:2px; font-size:12px;"	
	  var s_table_TH = s_table + "Border:solid 1px #b4d0e1; background-color:#ebf2f8;  color:#146ab9; height:22px; letter-spacing: -0.1ex; font-size:12px; font-weight:100; text-align:left; padding-left:10px; padding-right:5px;"; 
	  var s_table_TH_point = s_table + s_table_TH +"background-image:url(../imgs/comm/point.gif); background-repeat:no-repeat; Border:solid 1px #b4d0e1; background-color:#ebf2f8;  color:#146ab9; height:22px; letter-spacing: -0.1ex; font-size:12px; font-weight:100; text-align:left; padding-left:10px; padding-right:5px; vertical-align:center;";  
	  var s_table_TD = "Border:solid 1px #b4d0e1;  padding-right:2px; padding-left:2px; background-color:#ffffff;  height:25px; letter-spacing:-0.1ex;  font-size:12px; width=10px;";
	
	  // TAG 생성 
	 var strHtml = "";
		 strHtml = strHtml + " <table width='60%' border='0' cellspacing='0' cellpadding='0'>	";
		 strHtml = strHtml + "     <tr>	";
		 strHtml = strHtml + "         <td class='PT01 PB03' style='"+PT01+PB03+"'>	";
		 strHtml = strHtml + "                         <table width='100%' border='0' cellpadding='0' cellspacing='0' class='s_table' style='"+s_table+"'>	";
		 strHtml = strHtml + "                             <tr>	";
		 strHtml = strHtml + "                                 <th width='100' class='point' style='"+s_table_TH_point+"'>클레임등급</th>	";
		 strHtml = strHtml + "                                 <td style='"+ s_table_TD +"'>	&nbsp;";
		 strHtml = strHtml + "                                     "+ strClmGrade;
		 strHtml = strHtml + "                                 </td>	";
		 strHtml = strHtml + "                                 <th width='100' class='point' style='"+s_table_TH_point+"'>접수형태</th>	";
		 strHtml = strHtml + "                                 <td style='"+ s_table_TD +"'>	&nbsp;";
		 strHtml = strHtml + "                                     "+ strRecType;
		 strHtml = strHtml + "                                 </td>	";
		 strHtml = strHtml + "                                 <th width='100' class='point' style='"+s_table_TH_point+"'>고객구분</th>	";
		 strHtml = strHtml + "                                 <td style='"+ s_table_TD +"'>	&nbsp;";
		 strHtml = strHtml + "                                 	"+ strMbrGbn;
		 strHtml = strHtml + "                                 </td>	";
		 strHtml = strHtml + "                             </tr>	";
		 strHtml = strHtml + "                             <tr>	";
		 strHtml = strHtml + "                                 <th width='100' style='"+s_table_TH+"'>회원번호</th>	";
		 strHtml = strHtml + "                                 <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                                     "+ strCustId;
		 strHtml = strHtml + "                                 </td>	";
		 strHtml = strHtml + "                                 <th width='100' class='point' style='"+s_table_TH_point+"'>고객명</th>	";
		 strHtml = strHtml + "                                 <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                                     "+ strCustName;
		 strHtml = strHtml + "                                 </td>	";
		 strHtml = strHtml + "                                 <th width='100' class='point' style='"+s_table_TH_point+"'>전화번호</th>	";
		 strHtml = strHtml + "                                 <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                                     "+ strMobilePh;
		 strHtml = strHtml + "                                 </td>	";
		 strHtml = strHtml + "                             </tr>	";
		 strHtml = strHtml + "                         </table>	";
		 strHtml = strHtml + "             <table width='100%' border='0' cellpadding='0' cellspacing='0' class='s_table' style='"+s_table+"'>	";
		 strHtml = strHtml + "                 <tr>	";
		 strHtml = strHtml + "                     <th width='100' class='point' style='"+s_table_TH_point+"'>점</th>	";
		 strHtml = strHtml + "                     <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                     	"+ strStrCd;
		 strHtml = strHtml + "                     </td>	";
		 strHtml = strHtml + "         <th width='100' class='point' style='"+s_table_TH_point+"'>조직정보</th>	";
		 strHtml = strHtml + "         	<td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "         		"+ strJojik;
		 strHtml = strHtml + "         	</td>	";
		 strHtml = strHtml + " 		<th width='100' class='point' style='"+s_table_TH_point+"'>접수자</th>	";
		 strHtml = strHtml + "             <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                 	" + strRecId + strRecName;	
		 strHtml = strHtml + "             </td>	";
		 strHtml = strHtml + "         </tr>	";
		 strHtml = strHtml + "         <tr>	";
		 strHtml = strHtml + "             <th width='100' style='"+s_table_TH+"'>브랜드</th>	";
		 strHtml = strHtml + "             <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                 " + strPumbunCd + strPumbunNm;
		 strHtml = strHtml + "             </td>	";
		 strHtml = strHtml + "             <th width='100' style='"+s_table_TH+"'>클레임종류</th>	";
		 strHtml = strHtml + "             <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                 " +strClmKind;
		 strHtml = strHtml + "             </td>	";
		 strHtml = strHtml + "             <th width='100' class='point' style='"+s_table_TH_point+"'>접수일자</th>	";
		 strHtml = strHtml + "             <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                 	" + strRecDt;
		 strHtml = strHtml + "             </td>	";
		 strHtml = strHtml + "         </tr>	";
		 strHtml = strHtml + "         <tr>	";
		 strHtml = strHtml + "             <th width='80' style='height: 40px;' class='point' style='"+s_table_TH_point+"'  >제목</th>	";
		 strHtml = strHtml + "             <td colspan='5'  valign='top'   style='"+ s_table_TD +" height: 40px; ' >	";
		 strHtml = strHtml + "                " + strRecTitle;
		 strHtml = strHtml + "             </td>	";
		 strHtml = strHtml + "         </tr>	";
		 strHtml = strHtml + "         <tr>	";
		 strHtml = strHtml + "             <th width='80' style='height: 160px;' class='point' style='"+s_table_TH_point+"'>내용</th>	";
		 strHtml = strHtml + "             <td colspan='5' valign='top' style='"+ s_table_TD +" overflow:auto; ' >	";
		 strHtml = strHtml + "                 " + strRecCont;
		 strHtml = strHtml + "             </td>	";
		 strHtml = strHtml + "         </tr>	";
		 strHtml = strHtml + "         <tr>	";
		 strHtml = strHtml + "             <th width='80' style='height: 50px;' class='point' style='"+s_table_TH_point+"' >요약</th>	";
		 strHtml = strHtml + "             <td colspan='5'  valign='top'  style='"+ s_table_TD +" overflow:auto;' >	";
		 strHtml = strHtml + "                 " + strRecSummary;
		 strHtml = strHtml + "             </td>	";
		 strHtml = strHtml + "         </tr>	";
	 	 strHtml = strHtml + "         </table>&nbsp	";
	 	 strHtml = strHtml + "         <table width='100%' border='0' cellpadding='0' cellspacing='0' class='s_table' style='"+s_table+"'>	";
		 strHtml = strHtml + "             <tr>	";
		 strHtml = strHtml + "                 <th width='100' style='"+s_table_TH+"'>처리부서</th>	";
		 strHtml = strHtml + "                 <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                     " + strProcDept;	
		 strHtml = strHtml + "                 </td>	";
		 strHtml = strHtml + "                 <th width='100' class='point' style='"+s_table_TH_point+"'>처리담당자</th>	";
		 strHtml = strHtml + "                 <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                     " + strProcId + strProcName; 	
		 strHtml = strHtml + "                 </td>	";
		 strHtml = strHtml + "                 <th width='100' style='"+s_table_TH+"'>처리구분</th>	";
		 strHtml = strHtml + "                 <td style='"+ s_table_TD +"'> &nbsp;	";
		 strHtml = strHtml + "                     " + strProcGbn;	
		 strHtml = strHtml + "                 </td>	";
		 strHtml = strHtml + "             </tr>	";
		 strHtml = strHtml + "             <tr>	";
		 strHtml = strHtml + "                 <th width='100' class='point' style='"+s_table_TH_point+"'>처리일자</th>	";
		 strHtml = strHtml + "                 <td style='"+ s_table_TD +"' colspan='5'> &nbsp;	";
		 strHtml = strHtml + " 					" + strProcDt;	
		 strHtml = strHtml + " 					</td>	";
		 //strHtml = strHtml + "                 <th width='100'></th>	";
		 //strHtml = strHtml + "                 <td width='200'></td>	";
		 //strHtml = strHtml + "                 <th width='100'></th>	";
		 //strHtml = strHtml + "                 <td width='200'></td>	";
		 strHtml = strHtml + "             </tr>	";
		 strHtml = strHtml + "             <tr>	";
		 strHtml = strHtml + "                 <th width='80' style='height: 40px;' class='point' style='"+s_table_TH_point+"' >처리 내역</th>	";
		 strHtml = strHtml + "                 <td colspan='5'  valign='top'  style='"+ s_table_TD +" overflow:auto;'>	";
		 strHtml = strHtml + "                     " + strProcCont;
		 strHtml = strHtml + "                 </td>	";
		 strHtml = strHtml + "             </tr>	";
		 strHtml = strHtml + "         </table>	";
		 strHtml = strHtml + "         </td>	";
		 strHtml = strHtml + "     </tr>	";
		 strHtml = strHtml + " </table>	";
		 
		 
		 
		 document.getElementById("excelexport").innerHTML = strHtml;
		 
		 // 엑셀 파일명 
		 var strFileNm	= strRecDt + "_" + strRecSeq + "_" + strRecTitle.replaceAll("/","");
		 
		 return strFileNm;
}
/**
 * saveExcelLog(str : 조회조건)
 * 작 성 자 : jyk
 * 작 성 일 : 2017.11.27
 * 개    요 : 엑셀 변환 log 기록.
 * return값 : void
 */
function saveExcelLog(str) {
	
	
	DS_LOG.ClearData();
    DS_LOG.AddRow();
    DS_LOG.NameValue(1,"DOWN_COND") = str;
    DS_LOG.NameValue(1,"PID") = g_strPid;
    TR_MAIN.Action   = "/<%=dir%>/ccom900.cc?goTo=saveExcelDownLog";
    TR_MAIN.KeyValue = "SERVLET(I:DS_LOG=DS_LOG)";
    TR_MAIN.Post();
	
}
  
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리
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

<!--------------------- 6. 컴포넌트 이벤트 처리  -------------------------------->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝 
<!--*************************************************************************-->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<!-- =============== Input용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"  classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_LOG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->

<!-- =============== ONLOAD용 -->
<comment id="_NSID_"><object id="DS_O_S_STR_CD" 		classid=<%=Util.CLSID_DATASET%>><param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_CLM_GRADE" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_REC_TYPE" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_CLM_KIND" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PROC_DEPT" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PROC_GBN" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_CUST_ID" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_CUST_NAME" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_REC_ID" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PROC_ID" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_REC_DT" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PROC_DT" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_REC_TITLE" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_REC_CONT" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_REC_SUMMARY" 	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PROC_CONT" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_S_PUMBUN_CD" 		classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>


<!-- =============== 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝 
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* E. 본문시작 
<!--*************************************************************************-->

<body  onload="doInit();" class="PL10 PT15">

<img src="/<%=dir%>/imgs/btn/excel.gif" onclick="exportExcel();"><a style="color:red"> * Excel 변환시, 변환 일시, 내역에 대해 저장됩니다.</a>
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="PT01 PB03">
            
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
                <tr>
                    <td>
                        <!-- search start -->

                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">

                            <tr>
                                <th width="100" class="point">클레임등급</th>
                                <td>
                                    <comment id="_NSID_"> <object id=LC_CLM_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=140
								tabindex=1></object> </comment>
                                    <script>
                                        _ws_(_NSID_);
                                    </script>
                                </td>
                                <th width="100" class="point">접수형태</th>
                                <td>
                                    <comment id="_NSID_">
                                        <object id=LC_REC_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1> </object> </comment>
                                    <script>
                                        _ws_(_NSID_);
                                    </script>
                                </td>
                                <th width="100" class="point">고객구분</th>
                                <td>
                                    <comment id="_NSID_"><object id=RD_MBR_GBN classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 100"
								align="absmiddle" tabindex=5>
								<param name=Cols value="2">
								<param name=Format value="0^일반,1^회원">
								<param name="AutoMargin" value="true"></object></comment>
                                    <script>
                                        _ws_(_NSID_);
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <th width="100">회원번호</th>
                                <td>
                                    <comment id="_NSID_"> <object id=EM_CUST_ID classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=5
							    align="absmiddle"></object>
                                    </comment>
                                    <script>
                                        _ws_(_NSID_);
                                    </script>
                                </td>
                                <th width="100" class="point">고객명</th>
                                <td>
                                    <comment id="_NSID_"> <object id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=138
								tabindex=5
								onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"
								align="absmiddle"></object> </comment>
                                    <script>
                                        _ws_(_NSID_);
                                    </script>
                                </td>
                                <th width="100" class="point">전화번호</th>
                                <td>
                                    <comment id="_NSID_">
                                        <comment id="_NSID_"> <object id=EM_MOBILE_PH1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
								align="absmiddle"></object> </comment>
                                        <script>
                                            _ws_(_NSID_);
                                        </script>-
                                        <comment id="_NSID_"> <object id=EM_MOBILE_PH2 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=5
								align="absmiddle"></object> </comment>
                                        <script>
                                            _ws_(_NSID_);
                                        </script>-
                                        <comment id="_NSID_"> <object id=EM_MOBILE_PH3 classid=<%=Util.CLSID_EMEDIT%> width=40 tabindex=5
								align="absmiddle"></object> </comment>
                                        <script>
                                            _ws_(_NSID_);
                                        </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                    <th width="100" class="point">점</th>
                    <td>
                        <comment id="_NSID_"> <object id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%>
									 align="absmiddle" width=140 tabindex=1> </object> </comment>
                        <script>
                            _ws_(_NSID_);
                        </script>
                    </td>
        <th width="100" class="point">조직정보</th>
        <td>
            <comment id="_NSID_"> <object id=LC_JOJIK classid=<%=Util.CLSID_LUXECOMBO%>
									width=140 align="absmiddle" tabindex=1> </object> </comment>
            <script>
                _ws_(_NSID_);
            </script>
        </td>
<th width="100" class="point">접수자</th>
            <td>
                <comment id="_NSID_"> <object id=EM_REC_ID classid=<%=Util.CLSID_EMEDIT%> width=70
                        align="absmiddle" tabindex=1></object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
                <comment id="_NSID_"> <object id=EM_REC_NAME classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle"
                        tabindex=1></object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
            </td>
        
        </tr>
        <tr>
            <th width="100">브랜드</th>
            <td>
                <comment id="_NSID_"> <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=45
											tabindex=1 align="absmiddle"> </object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
                <comment id="_NSID_"> <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=115
										tabindex=1 align="absmiddle"> </object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
            </td>
            <th width="100">클레임종류</th>
            <td>
                <comment id="_NSID_"> <object id=LC_CLM_KIND classid=<%=Util.CLSID_LUXECOMBO%> width=120
									tabindex=1></object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
            </td>
            <th width="100" class="point">접수일자</th>
            <td>
                <comment id="_NSID_"> <object id=EM_REC_DT classid=<%=Util.CLSID_EMEDIT%> tabindex=1
                        				align="absmiddle" width="118"></object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
            </td>
        </tr>
        
        <tr>
            <th width="80" class="point" ondblclick="javascript:cpContent(TXT_REC_TITLE);" >제목</th>
            <td colspan="7">
                <comment id="_NSID_"> <object id=TXT_REC_TITLE classid=<%=Util.CLSID_TEXTAREA%>
					style="width: 100%; height: 40px;" tabindex=1 >
				</object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
            </td>
        </tr>
        <tr>
            <th width="80" class="point" ondblclick="javascript:cpContent(TXT_REC_CONT);">내용</th>
            <td colspan="7">
                <comment id="_NSID_"> <object id=TXT_REC_CONT classid=<%=Util.CLSID_TEXTAREA%>
					style="width: 100%; height: 160px;" tabindex=1 >
				</object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
            </td>
        </tr>
        <tr>
            <th width="80" class="point" ondblclick="javascript:cpContent(TXT_REC_SUMMARY);">요약</th>
            <td colspan="7">
                <comment id="_NSID_"> <object id=TXT_REC_SUMMARY classid=<%=Util.CLSID_TEXTAREA%>
					style="width: 100%; height: 120px;" tabindex=1>
				</object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
            </td>
        </tr>

        </table>&nbsp
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th width="100">처리부서</th>
                <td>
                    <comment id="_NSID_"> <object id=LC_PROC_DEPT classid=<%=Util.CLSID_LUXECOMBO%>
									width=140 tabindex=1> </object> </comment>
                    <script>
                        _ws_(_NSID_);
                    </script>
                </td>
                <th width="100" class="point">처리담당자</th>
                <td>
                    <comment id="_NSID_"> <object id=EM_PROC_ID classid=<%=Util.CLSID_EMEDIT%> width=70
                        align="absmiddle" tabindex=1></object> </comment>
                    <script>
                        _ws_(_NSID_);
                    </script>
                    <comment id="_NSID_"> <object id=EM_PROC_NAME classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle"
                        tabindex=1></object> </comment>
                <script>
                    _ws_(_NSID_);
                </script>
                </td>
                <th width="100">처리구분</th>
                <td>
                    <comment id="_NSID_"> <object id=LC_PROC_GBN classid=<%=Util.CLSID_LUXECOMBO%>
									width=140 tabindex=1> </object> </comment>
                    <script>
                        _ws_(_NSID_);
                    </script>
                </td>
            </tr>
            <tr>
                <th width="100" class="point">처리일자</th>
                <td>
                    <comment id="_NSID_"> <object id=EM_PROC_DT classid=<%=Util.CLSID_EMEDIT%> width=118 tabindex=1
                      	  		align="absmiddle"></object> </comment>
                    <script>
                        _ws_(_NSID_);
                    </script></td>


                <th width="100"></th>
                <td width="200"></td>
                <th width="100"></th>
                <td width="200"></td>
            </tr>
            <tr>
                <th width="80" class="point" ondblclick="javascript:cpContent(TXT_PROC_CONT);" >처리내역</th>
                <td colspan="7">
                    <comment id="_NSID_"> <object id=TXT_PROC_CONT classid=<%=Util.CLSID_TEXTAREA%>
					style="width: 100%; height: 60px;" tabindex=1>
				</object> </comment>
                    <script>
                        _ws_(_NSID_);
                    </script>
                </td>
            </tr>
        </table>
        </td>

    </tr>

</table>
</div>

<comment id="_NSID_">
<object id=TXT_REC_CONT2 classid=<%=Util.CLSID_EMEDIT%> width=118 tabindex=1 align="absmiddle" style="display:none"></object> </comment>
<script>
_ws_(_NSID_);
</script>


<comment id="_NSID_">
<object id=TXT_REC_SUMMARY2 classid=<%=Util.CLSID_EMEDIT%> width=118 tabindex=1 align="absmiddle" style="display:none"></object> </comment>
<script>
_ws_(_NSID_);
</script>

<comment id="_NSID_">
<object id=TXT_PROC_CONT2 classid=<%=Util.CLSID_EMEDIT%> width=118 tabindex=1 align="absmiddle" style="display:none"></object> </comment>
<script>
_ws_(_NSID_);
</script>

<div id="excelexport" style="display:none">
<!-- 엑셀출력할 양식. -->
</div>

<iframe id="xlsFrame" name="xlsFrame" style="width: 0px; height: 0px; border: 0px;"></iframe>
<form id="excelForm" name="excelForm" method="post" target="xlsFrame" action="">
 <input type="hidden" name="goTo">
 <input type="hidden" name="fileName">	
 <input type="hidden" id="excelSource" name="excelSource">
</form>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_CUSTDETAIL classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=PROC_CONT  		 ctrl=TET_PROC_CONT      Param=Text</c>
            
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

