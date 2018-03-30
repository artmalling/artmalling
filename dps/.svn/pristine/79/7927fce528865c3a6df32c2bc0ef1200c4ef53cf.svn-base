<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 2010.06.20
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal3071.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 추세율현황(월별)
 * 이    력 :2010.06.20 박종은
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8" 
    import="common.util.Util, 
            common.vo.SessionInfo , 
            java.net.URLDecoder, 
            kr.fujitsu.ffw.base.BaseProperty,
            kr.fujitsu.ffw.util.*,
            com.softwarefx.chartfx.server.*,
            com.softwarefx.chartfx.server.dataproviders.*"%>


                                                          

<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="javax.naming.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>


<%
ChartServer chart1 = new ChartServer(pageContext,request,response);

chart1.setWidth(795);
chart1.setHeight(235);


InitialContext    ctx = null;
DataSource        ds = null;
Connection        con = null;
ResultSet rs = null;
Connection conn = null;
String query = "";

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");

    ctx = new InitialContext();
    
    ds = (DataSource) ctx.lookup("pot");
    con = (Connection) ds.getConnection();
    
    PreparedStatement stmt = null;

    String strStrCd         = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strDeptCd        = String2.trimToEmpty(request.getParameter("strDeptCd"));
    String strTeamCd        = String2.trimToEmpty(request.getParameter("strTeamCd"));
    String strPCCd          = String2.trimToEmpty(request.getParameter("strPCCd"));
    String strSaleDtS       = String2.trimToEmpty(request.getParameter("strSaleDtS"));
    String strSaleCmprDtS   = String2.trimToEmpty(request.getParameter("strSaleCmprDtS"));
    String strUserId        = String2.trimToEmpty(request.getParameter("strUserId"));

          query =  " SELECT B.ORG_SHORT_NAME                            AS ORG_NAME \n"
                 + "       , SUM(A.TOT_SALE_AMT)                         AS TOT_SALE_AMT \n"
                 + "       , SUM(A.CMPR_TOT_SALE_AMT)                    AS CMPR_TOT_SALE_AMT \n"
                 + "    FROM ( \n"
                 + "      SELECT SUBSTR(A.ORG_CD, 0,8) || '00'    AS PC_CD \n"
                 + "           , SUM(A.TOT_SALE_AMT)              AS TOT_SALE_AMT \n"
                 + "           , 0                                AS CMPR_TOT_SALE_AMT \n"
                 + "        FROM DPS.PS_MONTHPBN   A \n"
                 + "           , DPS.PC_ORGMST     B \n"
                 + "   WHERE A.ORG_CD     = B.ORG_CD" + " \n"
                 + "     AND B.STR_CD     = '" + strStrCd  + "' \n"
                 + "     AND B.DEPT_CD    = '" + strDeptCd + "' \n"
                 + "     AND B.TEAM_CD    = '" + strTeamCd + "' \n"
                 + "     AND B.PC_CD      LIKE '" + strPCCd + "' || '%'" + " \n"
                 + "     AND A.SALE_YM    = '" + strSaleDtS + "' \n"
                 + "     AND EXISTS ( SELECT MYORG.USER_ID FROM COM.V_MYORG MYORG WHERE MYORG.STR_CD      = B.STR_CD AND MYORG.DEPT_CD     = B.DEPT_CD" + " \n"
                 + "                 AND MYORG.TEAM_CD     = B.TEAM_CD AND MYORG.PC_CD       = B.PC_CD AND MYORG.USER_ID     = '" + strUserId + "' \n"
                 + "                 )" + " \n"
                 + "   GROUP BY \n"
                 + "         SUBSTR(A.ORG_CD, 0,8) \n"
                 + "   UNION ALL \n"
                 + "      SELECT SUBSTR(A.ORG_CD, 0,8) || '00'    AS PC_CD \n"
                 + "           , 0                                AS TOT_SALE_AMT \n"
                 + "           , SUM(A.TOT_SALE_AMT)              AS CMPR_TOT_SALE_AMT \n"
                 + "        FROM DPS.PS_MONTHPBN   A \n"
                 + "           , DPS.PC_ORGMST     B \n"
                 + "   WHERE A.ORG_CD     = B.ORG_CD" + " \n"
                 + "     AND B.STR_CD     = '" + strStrCd  + "' \n"
                 + "     AND B.DEPT_CD    = '" + strDeptCd + "' \n"
                 + "     AND B.TEAM_CD    = '" + strTeamCd + "' \n"
                 + "     AND B.PC_CD      LIKE '" + strPCCd + "' || '%'" + " \n"
                 + "     AND A.SALE_YM    = '" + strSaleCmprDtS + "' \n"
                 + "     AND EXISTS ( SELECT MYORG.USER_ID FROM COM.V_MYORG MYORG WHERE MYORG.STR_CD      = B.STR_CD AND MYORG.DEPT_CD     = B.DEPT_CD" + " \n"
                 + "                 AND MYORG.TEAM_CD     = B.TEAM_CD AND MYORG.PC_CD       = B.PC_CD AND MYORG.USER_ID     = '" + strUserId + "' \n"
                 + "                 )" + " \n"
                 + "   GROUP BY \n"
                 + "         SUBSTR(A.ORG_CD, 0,8) \n"
                 + "          ) A" + " \n"
                 + "        , DPS.PC_ORGMST B" + " \n"
                 + "    WHERE A.PC_CD   = B.ORG_CD" + " \n"
                 + "    GROUP BY A.PC_CD, B.ORG_SHORT_NAME" + " \n"
                 + "    ORDER BY A.PC_CD" + " \n";
    
    
          
    stmt = con.prepareStatement(query);
    rs = stmt.executeQuery();
    
} 
catch (Exception e) {
    out.println(e.getMessage());
}



JDBCDataProvider provider = new JDBCDataProvider(rs);

chart1.getDataSourceSettings().getFields().add(new FieldMap("ORG_NAME",FieldUsage.LABEL));
chart1.getDataSourceSettings().getFields().add(new FieldMap("TOT_SALE_AMT",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("CMPR_TOT_SALE_AMT", FieldUsage.VALUE));
chart1.getDataSourceSettings().setDataSource(provider);

SeriesAttributes series0 = chart1.getSeries().get(0);
series0.setGallery(Gallery.BAR); 
series0.getLine().setWidth((short) 2);
series0.setAxisY(chart1.getAxisY());

SeriesAttributes series1 = chart1.getSeries().get(1);
series1.setGallery(Gallery.BAR); 
series1.getLine().setWidth((short) 2);
series1.setAxisY(chart1.getAxisY());

chart1.getAxisY().getGrids().getMajor().setVisible(true);

chart1.recalculateScale();
chart1.setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 12));

chart1.getAllSeries().getPointLabels().setVisible(true);
chart1.getAllSeries().getPointLabels().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 12));
chart1.getAllSeries().getPointLabels().setTextColor(java.awt.Color.BLACK);

chart1.getLegendBox().setVisible(true);
chart1.getLegendBox().setDock(DockArea.RIGHT);    //범례 위치
chart1.getLegendBox().setFont(new java.awt.Font("Malgun Gothic",java.awt.Font.PLAIN, 14));

chart1.getAxisY().getLabelsFormat().setCustomFormat("###,###");      //숫자형식

chart1.getSeries().get(0).setText("매출월");
chart1.getSeries().get(1).setText("대비월");

chart1.renderControl();
con.close(); 
%> 
