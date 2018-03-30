<!-- 
/*******************************************************************************
 * 시스템명 : 시스템명 : EDI > EDI > 전표출력
 * 작 성 일 : 2011.06.16 
 * 작 성 자 : 김정민
 * 수 정 자 : 
 * 파 일 명 : eord1021.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전표출력 전표 출력
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"    prefix="c" %>  
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>

<!--*************************************************************************-->   
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<% 
    String dir = BaseProperty.get("context.common.dir");
//    int intTotCount = 2; 
    //print/preview
    String printMode  ="print";   //print   프린트모드 
//    String printMode  ="preview";   //preview 미리보기모드 
    //true/false
    String concatpage = "false";                 
    String reportname  = "발주명세서출력";
    
    String[] arrStrCd    = request.getParameter("StrCd").split(","); 
    String[] arrSlipNo   = request.getParameter("SlipNo").split(","); 
    String[] arrSlipFlag = request.getParameter("SlipFlag").split(","); 
    String[] arrSkuFlag  = request.getParameter("SkuFlag").split(","); 
    String   strLoop     = String2.trimToEmpty(request.getParameter("Loop"));       //출력할 전표수 
    String   totCount    = String2.trimToEmpty(request.getParameter("totCount")); 
    
    int intTotCount      = Integer.valueOf(strLoop);
    int ozReportCnt      = Integer.valueOf(totCount);    
    String[] reportodi   = new String[ozReportCnt];   
    String[] reportozr   = new String[ozReportCnt];
    String[][] params    = new String[ozReportCnt][3];  // 오즈에 넘길 변수 3개(전표별)
    String strSlipFlag   = "";
    String strSkuflag    = "";
    
    
    int j = 0;                  // 전표별 건수에 따라 출력장수가 달라진다.
    
    for (int k=0; k < intTotCount; k++) 
    {           
        strSlipFlag = arrSlipFlag[k];
        strSkuflag  = arrSkuFlag[k];
         
        if("1".equals(strSkuflag)){     //1.단품 구분(단품) 
            if("A".equals(strSlipFlag)){          //1-1 매입
                for(int rep = 0; rep < 3; rep++){
//                  System.out.println("j = " + j);
System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + "1");
                    reportodi[j]  = "eord1023";
                    reportozr[j]  = "edi/eord1023";
                    params[j][0]  = "STR_CD="  + arrStrCd[k];
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 

                    if(rep == 0)
                        params[j][2]  = "TITLE=(매입사용)"; 
                    else if(rep == 1)
                        params[j][2]  = "TITLE=(협력사용)"; 
                    else if(rep == 2)
                    	params[j][2]  = "TITLE=(재무팀용)"; 
                    j++;
                }
                
            }else if("B".equals(strSlipFlag)){    //1-2.반품
                for(int rep = 0; rep < 3; rep++){
                	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + "2");
                    reportodi[j]  = "eord1024";
                    reportozr[j]  = "edi/eord1024";
                    params[j][0]  = "STR_CD="  + arrStrCd[k];
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];

                    if(rep == 0)
                        params[j][2]  = "TITLE=(매입사용)"; 
                    else if(rep == 1)
                        params[j][2]  = "TITLE=(협력사용)"; 
                    else if(rep == 2)
                        params[j][2]  = "TITLE=(재무팀용)"; 
                    j++;
                }
               
            }            
        }else{                          //2.단품 구분(비단품)       
            if("A".equals(strSlipFlag)){         //2-1.품목 매입 
                for(int rep = 0; rep < 3; rep++){
 
                	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + "3");
                    reportodi[j]  = "eord1021";
                    reportozr[j]  = "edi/eord1021";
                    params[j][0]  = "STR_CD="  + arrStrCd[k];                         
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 

                    if(rep == 0)
                        params[j][2]  = "TITLE=(매입사용)"; 
                    else if(rep == 1)
                        params[j][2]  = "TITLE=(협력사용)"; 
                    else if(rep == 2)
                        params[j][2]  = "TITLE=(재무팀용)"; 
                    j++;
                } 
                
            }else if("B".equals(strSlipFlag)){   //2-2.품목 반품
                for(int rep = 0; rep < 3; rep++){

                	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + "4");
                    reportodi[j]  = "eord1022";
                    reportozr[j]  = "edi/eord1022";   
                    params[j][0]  = "STR_CD="  + arrStrCd[k];
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                     
                    if(rep == 0)
                        params[j][2]  = "TITLE=(매입사용)"; 
                    else if(rep == 1)
                        params[j][2]  = "TITLE=(협력사용)"; 
                    else if(rep == 2)
                        params[j][2]  = "TITLE=(재무팀용)"; 
                    j++;
                }       
            }
        }
    }    
    
    //ozr파라미터
    String[][] formparams = new String[][]{
    
    };    
    //String prgName = "prod1201";
%>

<script>
    var g_showFlag = true; // 자동팝업창의 닫힘의 유무를 위함
</script>

<%@ include file="/jsp/report.jsp"%>
<%
//out.println("<script>window.close();</script>");
%>
