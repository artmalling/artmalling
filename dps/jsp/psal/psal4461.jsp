<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출실적 > 마진별매출실적(협력사)
 * 작 성 일 : 2010.06.08
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4460.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS별 정산/마감현황
 * 이    력 :2010.06.08 박종은
 * 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo , java.net.URLDecoder, 
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"     prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"  prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%

    String dir = BaseProperty.get("context.common.dir");

    //String url = "http://" + BaseProperty.get("ip") + ":" + BaseProperty.get("port") ;
    int ozReportCnt = 1;

    String printMode  ="preview";

    String concatpage = "true";
    String reportname    = "마진별매출실적(협력사)";
   
    
    
    String[] reportodi = new String[]{
            "psal4460"
    };
    String[] reportozr = new String[]{
            "dps/psal4460"
    };
    System.out.println("리포트시작");
    

   	reportodi[0] = "psal4460";
    reportozr[0] = "dps/psal4460";
    
    
    String strStrCd = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strStrNm = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strStrNm")), "UTF-8");
    String strSaleDtS = String2.trimToEmpty(request.getParameter("strSaleDtS"));
    String strSaleDtE = String2.trimToEmpty(request.getParameter("strSaleDtE"));
    String strVenCd = String2.trimToEmpty(request.getParameter("strVenCd"));
    String strVenNm = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strVenNm")), "UTF-8");
    String strUserId = String2.trimToEmpty(request.getParameter("strUserId"));
    String strDeptCd = String2.trimToEmpty(request.getParameter("strDeptCd"));
    String strDeptNm = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strDeptNm")), "UTF-8");
    String strTeamCd = String2.trimToEmpty(request.getParameter("strTeamCd"));
    String strTeamNm = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strTeamNm")), "UTF-8");
    String strPCCd = String2.trimToEmpty(request.getParameter("strPCCd"));
    String strPCNm = URLDecoder.decode(String2.trimToEmpty(request.getParameter("strPCNm")), "UTF-8");
    String strUnit = String2.trimToEmpty(request.getParameter("strEmUnit"));
    String strUnitNm =  URLDecoder.decode(String2.trimToEmpty(request.getParameter("strEmUnitNm")), "UTF-8");
    
    String[][] params  = new String[][]{
              { "STR_CD1="      + strStrCd
              , "STR_NM1="      + strStrNm
              , "S_DT1="        + strSaleDtS
              , "E_DT1="        + strSaleDtE
              , "VEN_CD1="		+ strVenCd
              , "VEN_NM1="		+ strVenNm
              , "USERID1="		+ strUserId
              , "DEPT_CD1="		+ strDeptCd
              , "DEPT_NM1="		+ strDeptNm
              , "TEAM_CD1="		+ strTeamCd
              , "TEAM_NM1="		+ strTeamNm
              , "PC_CD1="		+ strPCCd
              , "PC_NM1="		+ strPCNm
              , "UNIT="			+ strUnit
              , "UNIT_NM="		+ strUnitNm
              }
    }; 
    System.out.println(strStrCd);
    System.out.println(strStrNm);
    System.out.println(strSaleDtS);
    System.out.println(strSaleDtE);
    System.out.println(strVenCd);
    System.out.println(strVenNm);
    System.out.println(strUserId);
    System.out.println(strDeptCd);
    System.out.println(strDeptNm);
    System.out.println(strTeamCd);
    System.out.println(strTeamNm);
    System.out.println(strPCCd);
    System.out.println(strPCNm);
    System.out.println(strUnit);
    System.out.println(strUnitNm);
    //ozr파라미터
    String[][] formparams = new String[][]{ 
    
    };
    
%>
<%@ include file="/jsp/report.jsp"%>

