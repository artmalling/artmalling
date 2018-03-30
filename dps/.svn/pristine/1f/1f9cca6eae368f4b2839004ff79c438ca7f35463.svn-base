<!-- 
/*******************************************************************************
 * 시스템명 : 시스템명 : 영업관리 > 발주결재 > 전표출력
 * 작 성 일 : 2010.04.19 
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord1201.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전표출력 전표 출력   
 * 이    력 : 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*,
                                                                       java.util.HashMap"%>
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
//    int intTotCount = 2; 
    //print/preview
    String printMode  ="print";   //print   프린트모드 
    //String printMode  ="preview";   //preview 미리보기모드 
    //true/false
    String concatpage = "false";  
    //String concatpage = "true";  
    
    String reportname = "전표출력";
    
    String[] arrStrCd      = request.getParameter("StrCd").split(",");
    String[] arrSlipNo     = request.getParameter("SlipNo").split(",");
    String[] arrSlipFlag   = request.getParameter("SlipFlag").split(",");
    String[] arrSkuFlag    = request.getParameter("SkuFlag").split(",");
    String   strLoop       = String2.trimToEmpty(request.getParameter("Loop"));
    String   strOutPutFlag = String2.trimToEmpty(request.getParameter("strOutPutFlag"));
    String   totCount      = String2.trimToEmpty(request.getParameter("totCount")); //미리보기모드
    String[] arrBizType    = request.getParameter("BizType").split(",");
    
    //  String   totCount      = String2.trimToEmpty(request.getParameter("TotCount")); //프린트 모드
    
    int intTotCount        = Integer.valueOf(strLoop);
    int ozReportCnt        = Integer.valueOf(totCount);    
    String[] reportodi     = new String[ozReportCnt];   
    String[] reportozr     = new String[ozReportCnt];
    String[][] params      = new String[ozReportCnt][3];
    String strSlipFlag     = "";
    String strSkuflag      = "";
    String strBizType      = "";
    
    int j = 0; 

    System.out.println(arrSlipNo[0]);
    
    HashMap<String, String> map = null;
    map = new HashMap<String, String>();
    map.put("01", "영업부용");            
    map.put("02", "백화점용");            
    map.put("03", "협력사용");            
    map.put("04", "대출매장용");           
    map.put("05", "대입매장용");
    map.put("06", "점출매장용");
    map.put("07", "점출재무팀용");
    map.put("08", "점입매장용");
    map.put("09", "점입재무팀용");
    
  
 
    for (int k=0; k < intTotCount; k++) {           
        strSlipFlag = arrSlipFlag[k];
        strSkuflag  = arrSkuFlag[k];
        strBizType  = arrBizType[k];
        
        if("1".equals(strSkuflag)){     //1.단품 구분(단품)
            
            if("A".equals(strSlipFlag)){          //1-1 매입
            	if("%".equals(strOutPutFlag)){
            		if("1".equals(strBizType)){
	            		for(int rep = 0; rep < 3; rep++){
		            		//System.out.println("j = " + j);
		                    if(rep == 0){
		                    	reportodi[j]  = "pord1203";
			                    reportozr[j]  = "dps/pord1203";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
		                    	params[j][2]  = "TITLE=("+map.get("02")+")";	
		                    }
		                    else if(rep == 1){
		                    	reportodi[j]  = "pord1203";
			                    reportozr[j]  = "dps/pord1203";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
		                    	params[j][2]  = "TITLE=("+map.get("01")+")";
		                    }
		                    else if(rep == 2){
		                    	reportodi[j]  = "pord1203_01";
			                    reportozr[j]  = "dps/pord1203_01";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
			                    params[j][2]  = "TITLE=("+map.get("03")+")";
			                }
		                    
		                    j++; 
		            	}
            		} else {
            			for(int rep = 0; rep < 2; rep++){
		            		
		                    if(rep == 0){
		                    	reportodi[j]  = "pord1203";
			                    reportozr[j]  = "dps/pord1203";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
		                    	params[j][2]  = "TITLE=("+map.get("02")+")";	
		                    }
		                    else if(rep == 1){
		                    	reportodi[j]  = "pord1203_01";
			                    reportozr[j]  = "dps/pord1203_01";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
		                    	params[j][2]  = "TITLE=("+map.get("03")+")";
		                    }
		                    j++; 
		            	}
            		}
            	}else{
            		
                    if( "01".equals(strOutPutFlag) || "02".equals(strOutPutFlag) || "03".equals(strOutPutFlag)) {
                    
                       if("03".equals(strOutPutFlag)){
                    	   reportodi[j]  = "pord1203_01";
                           reportozr[j]  = "dps/pord1203_01";
                           params[j][0]  = "STR_CD="  + arrStrCd[k];
                           params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                           params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")";
                       } else {
                    	   reportodi[j]  = "pord1203";
                           reportozr[j]  = "dps/pord1203";
                           params[j][0]  = "STR_CD="  + arrStrCd[k];
                           params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                           params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")";   
                       }
                    }                  
                    j++;
            	}
                
                
            }else if("B".equals(strSlipFlag)){    //1-2.반품
            	if("%".equals(strOutPutFlag)){
            		
            		if("1".equals(strBizType)){
						for(int rep = 0; rep < 3; rep++){
    	                    if(rep == 0){
		                    	reportodi[j]  = "pord1204";
			                    reportozr[j]  = "dps/pord1204";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
		                    	params[j][2]  = "TITLE=("+map.get("02")+")";	
		                    }
		                    else if(rep == 1){
		                    	reportodi[j]  = "pord1203";
			                    reportozr[j]  = "dps/pord1203";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
		                    	params[j][2]  = "TITLE=("+map.get("01")+")";
		                    }
		                    else if(rep == 2){
		                    	reportodi[j]  = "pord1204_01";
			                    reportozr[j]  = "dps/pord1204_01";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
			                    params[j][2]  = "TITLE=("+map.get("03")+")";
			                }
    	                    j++;
    	                }
            		} else {
            			for(int rep = 0; rep < 2; rep++){
		            		
            				if(rep == 0){
		                    	reportodi[j]  = "pord1204";
			                    reportozr[j]  = "dps/pord1204";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
		                    	params[j][2]  = "TITLE=("+map.get("02")+")";	
		                    }
		                    else if(rep == 1){
		                    	reportodi[j]  = "pord1204_01";
			                    reportozr[j]  = "dps/pord1204_01";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
		                    	params[j][2]  = "TITLE=("+map.get("03")+")";
		                    }
		                    j++; 
		            	}
            		}
            	}else{
            		
            		if( "01".equals(strOutPutFlag) || "02".equals(strOutPutFlag) || "03".equals(strOutPutFlag)) {
                    	if("03".equals(strOutPutFlag)){
                     	   reportodi[j]  = "pord1204_01";
                           reportozr[j]  = "dps/pord1204_01";
                           params[j][0]  = "STR_CD="  + arrStrCd[k];
                           params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
                           params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")";
                        } else {
                        	reportodi[j]  = "pord1204";
                            reportozr[j]  = "dps/pord1204";
                            params[j][0]  = "STR_CD="  + arrStrCd[k];
                            params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
                            params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")";
                        }
                    }
                    j++;
            	}
            }else if("C".equals(strSlipFlag)){    //1-3.대출
            	if("%".equals(strOutPutFlag)){
	                for(int rep = 0; rep < 3; rep++){
	                    reportodi[j]  = "pord1205";
	                    reportozr[j]  = "dps/pord1205";
	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
	                    
	                    if(rep == 0)
	                    	params[j][2]  = "TITLE=("+map.get("02")+")"; 
	                    else if(rep == 1)
	                    	params[j][2]  = "TITLE=("+map.get("04")+")"; 
	                    else if(rep == 2)
	                    	params[j][2]  = "TITLE=("+map.get("05")+")"; 
	                    
	                    j++;
	                }     
            	}else{
            		reportodi[j]  = "pord1205";
                    reportozr[j]  = "dps/pord1205";
                    params[j][0]  = "STR_CD="  + arrStrCd[k];
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                    
                    
                    if( "02".equals(strOutPutFlag) || "04".equals(strOutPutFlag) || "05".equals(strOutPutFlag))
                        params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")"; 

                    j++;
                }
                
            }else if("D".equals(strSlipFlag)){    //1-4.대입
            	if("%".equals(strOutPutFlag)){
	                for(int rep = 0; rep < 3; rep++){
	                    reportodi[j]  = "pord1206";
	                    reportozr[j]  = "dps/pord1206";  
	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
	                    
	                    if(rep == 0)
                            params[j][2]  = "TITLE=("+map.get("02")+")"; 
                        else if(rep == 1)
                            params[j][2]  = "TITLE=("+map.get("04")+")"; 
                        else if(rep == 2)
                            params[j][2]  = "TITLE=("+map.get("05")+")"; 
	                    
	                    j++;
	                }    
            	}else{
            		reportodi[j]  = "pord1206";
                    reportozr[j]  = "dps/pord1206";  
                    params[j][0]  = "STR_CD="  + arrStrCd[k];
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                    
                    if( "02".equals(strOutPutFlag) || "04".equals(strOutPutFlag) || "05".equals(strOutPutFlag))
                        params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")"; 
                                 
                    j++;
                }
                
            }else if("E".equals(strSlipFlag)){    //1-5.점출
            	if("%".equals(strOutPutFlag)){
	                for(int rep = 0; rep < 4; rep++){
	//                	System.out.println("전표번호  =  " + arrSlipNo[k]);
	                    reportodi[j]  = "pord1207";
	                    reportozr[j]  = "dps/pord1207";  
	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
	                    
	                    if(rep == 0)
	                    	params[j][2]  = "TITLE=("+map.get("06")+")";
	                    else if(rep == 1)
	                    	params[j][2]  = "TITLE=("+map.get("07")+")";
	                    else if(rep == 2)
	                    	params[j][2]  = "TITLE=("+map.get("08")+")"; 
	                    else if(rep == 3)
	                    	params[j][2]  = "TITLE=("+map.get("09")+")";
	                    
	                    j++;
	                }  
            	}else{
            		reportodi[j]  = "pord1207";
                    reportozr[j]  = "dps/pord1207";  
                    params[j][0]  = "STR_CD="  + arrStrCd[k];
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                    
                    if( "06".equals(strOutPutFlag) || "07".equals(strOutPutFlag) 
                    		|| "08".equals(strOutPutFlag)|| "09".equals(strOutPutFlag))
                        params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")"; 
                    
                    j++;
                }
                
            }else if("F".equals(strSlipFlag)){    //1-6.점입
            	if("%".equals(strOutPutFlag)){
	                for(int rep = 0; rep < 4; rep++){
	                    reportodi[j]  = "pord1208";
	                    reportozr[j]  = "dps/pord1208";  
	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
	                    
	                    if(rep == 0)
                            params[j][2]  = "TITLE=("+map.get("06")+")";
                        else if(rep == 1)
                            params[j][2]  = "TITLE=("+map.get("07")+")";
                        else if(rep == 2)
                            params[j][2]  = "TITLE=("+map.get("08")+")"; 
                        else if(rep == 3)
                            params[j][2]  = "TITLE=("+map.get("09")+")";
	                    
	                    j++;
	                } 
            	}else{
            		reportodi[j]  = "pord1208";
                    reportozr[j]  = "dps/pord1208";  
                    params[j][0]  = "STR_CD="  + arrStrCd[k];
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                    
                    if( "06".equals(strOutPutFlag) || "07".equals(strOutPutFlag) 
                            || "08".equals(strOutPutFlag)|| "09".equals(strOutPutFlag))
                        params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")"; 
                    
                    j++;
                }
                
            }else if("G".equals(strSlipFlag)){    //1-7.매가인상하
            	if("%".equals(strOutPutFlag)){
	                for(int rep = 0; rep < 2; rep++){
	                    reportodi[j]  = "pord1209";
	                    reportozr[j]  = "dps/pord1209";  
	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
	                    
	                    if(rep == 0)
                            params[j][2]  = "TITLE=("+map.get("02")+")"; 
                        else if(rep == 1)
                            params[j][2]  = "TITLE=("+map.get("01")+")"; 
	                    
	                    j++;
	                }
            	}else{
            		reportodi[j]  = "pord1209";
                    reportozr[j]  = "dps/pord1209";  
                    params[j][0]  = "STR_CD="  + arrStrCd[k];
                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                    
                    if( "01".equals(strOutPutFlag) || "02".equals(strOutPutFlag))
                        params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")"; 
                                       
                    j++;
                }
            }            
        }else{                          //2.단품 구분(비단품)       
            if("A".equals(strSlipFlag)){         //2-1.품목 매입 
            	if("%".equals(strOutPutFlag)){
            		if("1".equals(strBizType)){
						for(int rep = 0; rep < 3; rep++){
    	                    
    	                    if(rep == 0) {
    	                    	reportodi[j]  = "pord1201";
        	                    reportozr[j]  = "dps/pord1201";
        	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
        	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                                params[j][2]  = "TITLE=("+map.get("02")+")"; 
    	                    }
                            else if(rep == 1){
                            	reportodi[j]  = "pord1201";
        	                    reportozr[j]  = "dps/pord1201";
        	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
        	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                            	params[j][2]  = "TITLE=("+map.get("01")+")";
                            }
                            else if(rep == 2){
                            	reportodi[j]  = "pord1201_01";
        	                    reportozr[j]  = "dps/pord1201_01";
        	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
        	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                            	params[j][2]  = "TITLE=("+map.get("03")+")";
                            }
                                  
    	                    
    	                    j++;
    	                }
            		} else {
            			for(int rep = 0; rep < 2; rep++){
            				
		            		if(rep == 0){
		                    	reportodi[j]  = "pord1201";
			                    reportozr[j]  = "dps/pord1201";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
		                    	params[j][2]  = "TITLE=("+map.get("02")+")";	
		                    }
		                    else if(rep == 1){
		                    	reportodi[j]  = "pord1201_01";
			                    reportozr[j]  = "dps/pord1201_01";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
		                    	params[j][2]  = "TITLE=("+map.get("03")+")";
		                    
		                    }
		                    j++; 
		            	}
            		} 
            	}else{
            		
                    if( "01".equals(strOutPutFlag) || "02".equals(strOutPutFlag) || "03".equals(strOutPutFlag)) {
                        
                    	if("03".equals(strOutPutFlag)) {
                        	reportodi[j]  = "pord1201_01"; 
                            reportozr[j]  = "dps/pord1201_01";
                            params[j][0]  = "STR_CD="  + arrStrCd[k];                         
                            params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                            params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")";
                        } else {
                        	reportodi[j]  = "pord1201"; 
                            reportozr[j]  = "dps/pord1201";
                            params[j][0]  = "STR_CD="  + arrStrCd[k];                         
                            params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
                            params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")";        	
                        }
                        
                    }
					j++;
                }
            }else if("B".equals(strSlipFlag)){   //2-2.품목 반품
            	if("%".equals(strOutPutFlag)){
            		if("1".equals(strBizType)){
						for(int rep = 0; rep < 3; rep++){
    	                    
    	                    if(rep == 0) {
    	                    	reportodi[j]  = "pord1202";
        	                    reportozr[j]  = "dps/pord1202";
        	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
        	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
        	                    params[j][2]  = "TITLE=("+map.get("02")+")"; 
    	                    }
                            else if(rep == 1){
                            	reportodi[j]  = "pord1202";
        	                    reportozr[j]  = "dps/pord1202";
        	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
        	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
        	                	params[j][2]  = "TITLE=("+map.get("01")+")";
                            }
                            else if(rep == 2){
                            	reportodi[j]  = "pord1202_01";
        	                    reportozr[j]  = "dps/pord1202_01";
        	                    params[j][0]  = "STR_CD="  + arrStrCd[k];
        	                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
        	                	params[j][2]  = "TITLE=("+map.get("03")+")";
                            }
                            j++;
    	                }
            		} else {
            			for(int rep = 0; rep < 2; rep++){
		            		
            				if(rep == 0){
		                    	reportodi[j]  = "pord1202";
			                    reportozr[j]  = "dps/pord1202";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
		                    	params[j][2]  = "TITLE=("+map.get("02")+")";	
		                    }
		                    else if(rep == 1){
		                    	reportodi[j]  = "pord1202_01";
			                    reportozr[j]  = "dps/pord1202_01";
			                    params[j][0]  = "STR_CD="  + arrStrCd[k];
			                    params[j][1]  = "SLIP_NO=" + arrSlipNo[k]; 
		                    	params[j][2]  = "TITLE=("+map.get("03")+")";
		                    }
		                    j++; 
		            	}
            		}   
            	}else{
            		
            		if( "01".equals(strOutPutFlag) || "02".equals(strOutPutFlag) || "03".equals(strOutPutFlag)) {
                    	if("03".equals(strOutPutFlag)){
                    		reportodi[j]  = "pord1202_01";
                            reportozr[j]  = "dps/pord1202_01";
                            params[j][0]  = "STR_CD="  + arrStrCd[k];
                            params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
                            params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")";
                    	} else {
                    		reportodi[j]  = "pord1202";
                            reportozr[j]  = "dps/pord1202";    
                            params[j][0]  = "STR_CD="  + arrStrCd[k];
                            params[j][1]  = "SLIP_NO=" + arrSlipNo[k];
                            params[j][2]  = "TITLE=("+map.get(strOutPutFlag)+")";
                    	}
                    	
                    }
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
//var g_showFlag = false; // 자동팝업창의 닫힘의 유무를 위함(미리보기)
</script>

<%@ include file="/jsp/report.jsp"%>  
<%
//out.println("<script>window.close();</script>");
%>
