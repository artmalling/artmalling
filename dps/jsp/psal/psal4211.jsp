<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출속보
 * 작 성 일 : 2010.06.20
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal4211.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사일자별매출현황
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
JDBCDataProvider provider = null;

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
    String strEventCd       = String2.trimToEmpty(request.getParameter("strEventCd"));
    String strSaleDtS       = String2.trimToEmpty(request.getParameter("strSaleDtS"));
    String strSaleDtE       = String2.trimToEmpty(request.getParameter("strSaleDtE"));
    String strPumbunCd      = String2.trimToEmpty(request.getParameter("strPumbunCd"));
    String strUserId        = String2.trimToEmpty(request.getParameter("strUserId"));

    

    query = "            SELECT C.PUMBUN_NAME                                                                                               \n"
          + "                 , NVL(D.ORIGIN_SALE_TAMT,0) AS   ORIGIN_SALE_TAMT                                                                                        \n"
          + "                 , A.TOT_SALE_AMT                                                                                              \n" 
          + "              FROM (                                                                                                           \n"
          + "                     SELECT A.STR_CD                                                                                           \n"
          + "                          , A.PUMBUN_CD                                                                                        \n"
          + "                          , LPAD(A.ORG_CD, 8)||'00' AS  ORG_CD																	\n"         
          + "                          , SUM(NVL(A.TOT_SALE_AMT,0))                                          AS TOT_SALE_AMT                \n"     
          + "                       FROM DPS.PS_DAYEVENT  A                                                                                \n"
          + "                          , DPS.PC_ORGMST     F                                                                                \n"
          + "                      WHERE A.ORG_CD     = F.ORG_CD                                                                            \n" 
          + "                        AND F.STR_CD     = '" + strStrCd + "'                                                                  \n"
          + "                        AND F.DEPT_CD    = '" + strDeptCd + "'                                                                 \n"
          + "                        AND F.TEAM_CD    = '" + strTeamCd + "'                                                                 \n" 
          + "                        AND F.PC_CD      = '" + strPCCd + "'                                                                   \n" 
          + "                        AND A.PUMBUN_CD  LIKE '" + strPumbunCd + "' || '%'                                                     \n"
          + "                        AND A.EVENT_CD   = '" + strEventCd + "'                                                                \n"
          + "                        AND A.SALE_DT    >= '" + strSaleDtS + "'                                                               \n"
          + "                        AND A.SALE_DT    <= '" + strSaleDtE + "'                                                               \n"
          + "                        AND A.EVENT_CD    <> '00000000000'                                                                     \n"
          + "                        AND EXISTS ( SELECT MYORG.USER_ID                                                                      \n"
          + "                                       FROM COM.V_MYORG MYORG                                                                  \n"
          + "                                      WHERE MYORG.STR_CD      = F.STR_CD                                                       \n" 
          + "                                        AND MYORG.DEPT_CD     = F.DEPT_CD                                                      \n"
          + "                                        AND MYORG.TEAM_CD     = F.TEAM_CD                                                      \n" 
          + "                                        AND MYORG.PC_CD       = F.PC_CD                                                        \n"
          + "                                        AND MYORG.PUMBUN_CD   = A.PUMBUN_CD                                                    \n"
          + "                                        AND MYORG.USER_ID     = '" + strUserId + "'                                            \n"
          + "                                   )                                                                                           \n" 
          + "                      GROUP BY                                                                                                 \n" 
          + "                            A.STR_CD                                                                                           \n" 
          + "                          , A.PUMBUN_CD                                                                                        \n" 
          + "                          , LPAD(A.ORG_CD, 8)                                                                                  \n" 
          + "                   ) A                                                                                                         \n" 
          + "                 , DPS.PC_STRPBN    C                                                                                          \n" 
          + "               , (SELECT STR_CD,ORG_CD, PUMBUN_CD                                                                              \n"
          + "      					 ,SUM(NVL(ORIGIN_SALE_TAMT,0))  AS ORIGIN_SALE_TAMT     												\n"                                                       
          + "        			FROM DPS.PS_ACTPUMBUN                              															\n"                                             
          + "       		   WHERE EXE_DT BETWEEN  '" + strSaleDtS + "' AND '" + strSaleDtE + "'      									\n"                       
          + "       		   GROUP BY STR_CD, ORG_CD, PUMBUN_CD    ) D                												 	\n"      
          + "             WHERE A.STR_CD    = C.STR_CD                                                                                      \n"     
          + "               AND A.PUMBUN_CD = C.PUMBUN_CD                                                                                   \n"     
          + "  				AND A.STR_CD    = D.STR_CD(+)    																					\n"
          + "  				AND A.ORG_CD    = D.ORG_CD(+)     																					\n"
          + "  				AND A.PUMBUN_CD = D.PUMBUN_CD(+)     																				 \n"
          + "             ORDER BY                                                                                                          \n"
          + "                   A.PUMBUN_CD                                                                                                 \n"                                 
          ;
    System.out.println(query);      
    stmt = con.prepareStatement(query);
    rs = stmt.executeQuery();
} 
catch (Exception e) {
    out.println(e.getMessage());
}



provider = new JDBCDataProvider(rs);
chart1.getDataSourceSettings().getFields().add(new FieldMap("PUMBUN_NAME",FieldUsage.LABEL));
chart1.getDataSourceSettings().getFields().add(new FieldMap("ORIGIN_SALE_TAMT",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("TOT_SALE_AMT", FieldUsage.VALUE));
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

chart1.getSeries().get(0).setText("목표");
chart1.getSeries().get(1).setText("실적");

chart1.renderControl();
con.close(); 
%> 
