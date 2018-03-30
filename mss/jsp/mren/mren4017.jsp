<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 임대관리 > 관리비청구/입금관리 >관리비청구서관리
 * 작 성 일 : 2010.05.16
 * 작 성 자 : 김유완
 * 수 정 자 : 홍종영
 * 파 일 명 : MREN401.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 관리비청구서를 출력한다
 * 이    력 : 2010.05.16 (김유완) 신규작성
 		   2012.06.20 (홍종영) 수정 mren4019 -> mren4017
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo, 
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*,
                                                                       java.text.SimpleDateFormat,
                                                                       java.util.Date,
                                                                       java.util.Locale"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
    //String url = "http://localhost:81"; 
    
    //String printMode  ="preview";
    String printMode  ="print";   //print   프린트모드 
    String concatpage = "false";
    
    /*
    String[] reportodi = new String[]{
            "mren4018"
      };
      String[] reportozr = new String[]{
            "mss/mren4018"
      };*/
    String reportname = "관리비청구서관리";
    
    String[] arrStrCd      = request.getParameter("strStrCd").split(",");
    String[] arrCalYm      = request.getParameter("strCalYM").split(",");
    String[] arrRentType   = request.getParameter("strRentType").split(",");
    String[] arrCntrId     = request.getParameter("strCntrId").split(",");
    String   strLoop       = String2.trimToEmpty(request.getParameter("Loop"));
    String   strPrintFlag  = String2.trimToEmpty(request.getParameter("strPrintFlag"));
    String   totCount      = String2.trimToEmpty(request.getParameter("totCount")); 
    
    int intTotCount        = Integer.valueOf(strLoop);
    
    int j = 0; 
        
    int ozReportCnt        = Integer.valueOf(totCount);
    
    String[] reportodi     = new String[ozReportCnt];   
    String[] reportozr     = new String[ozReportCnt];
    String[][] params      = new String[ozReportCnt][4];
    /*
    String strStrCd = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strCalYM = String2.trimToEmpty(request.getParameter("strCalYM"));
    String strRentType = String2.trimToEmpty(request.getParameter("strRentType"));
    String strVenCd = String2.trimToEmpty(request.getParameter("strVenCd"));
    */
    
    
    System.out.println("intTotCount" + intTotCount);
    System.out.println("ozReportCnt" + ozReportCnt);
    System.out.println(strPrintFlag);
    
    for (int k=0; k < intTotCount; k++) {  
    	//if("B".equals(strPrintFlag)){                          //관리비출력
        	System.out.println(arrStrCd[k]);
            System.out.println(arrCalYm[k]);
            System.out.println(arrCntrId[k]);
            System.out.println(arrRentType[k]);
            System.out.println("J= " + j); 
            System.out.println("mren4017");
                
            reportodi[j]  = "mren4017";
            reportozr[j]  = "mss/mren4017";
            params[j][0]  = "STR_CD="  + arrStrCd[k];
            params[j][1]  = "CAL_YM=" + arrCalYm[k];
            params[j][2]  = "CNTR_ID="  + arrCntrId[k];
            params[j][3]  = "RENT_TYPE=" + arrRentType[k];
                            
            j++;        	
        //}
/*     	if("C".equals(strPrintFlag)){                   //임대료출력    		
    		System.out.println(arrStrCd[k]);
            System.out.println(arrCalYm[k]);
            System.out.println(arrCntrId[k]);
            System.out.println(arrRentType[k]);
            System.out.println("J= " + j);
            System.out.println("mren4018");
                
            reportodi[j]  = "mren4018";
            reportozr[j]  = "mss/mren4018";
            params[j][0]  = "STR_CD="  + arrStrCd[k];
            params[j][1]  = "CAL_YM=" + arrCalYm[k];
            params[j][2]  = "CNTR_ID="  + arrCntrId[k];
            params[j][3]  = "RENT_TYPE=" + arrRentType[k];            
                
            j++;    		
        } */
    }
    
    //odi 파라미터
    /*
    String[][] params  = new String[][]{
		   //{"STR_CD=" + strStrCd, "CALYM="  + strCalYM, "VEN_CD=" + strVenCd, "RENT_TYPE=" + strRentType}
		};*/

    //ozr파라미터
    String[][] formparams = new String[][]{
    };
%>
<script>
    var g_showFlag = true; // 자동팝업창의 닫힘의 유무를 위함
//var g_showFlag = false; // 자동팝업창의 닫힘의 유무를 위함(미리보기)
</script>

<%@ include file="/jsp/report.jsp"%>
