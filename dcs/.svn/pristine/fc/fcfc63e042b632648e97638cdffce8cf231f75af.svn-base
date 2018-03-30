/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import common.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>영수증사후적립(일괄)</p>
 * 
 * @created  on 1.0, 2016.12.01
 * @created  by 윤지영
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 

public class DMbo642DAO extends AbstractDAO {
	
	/**
	* 영수증 사후 적립(일괄) 회원정보 조회
	* 
	* @param form
	* @return
	* @throws Exception
	*/
    public List searchCust(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Map        map  = null;
        Util       util = new Util();
        String 	   strQuery = "";

        //String BRCH_ID = String2.nvl(form.getParam("BRCH_ID"));
        String CUST_ID = String2.nvl(form.getParam("strCustId"));
        String SS_NO   = String2.nvl(form.getParam("strSsNo"));
        String CARD_NO = String2.nvl(form.getParam("strCardNo"));
        String strFlag = String2.nvl(form.getParam("strCompFlag"));        
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i=1;
    	strQuery = " SELECT DECODE(COUNT(CARD_NO), 0, '1', NVL(MAX(CUST_ID),'2')) AS CUST_ID FROM DCS.DM_CARD WHERE CARD_NO  = ? ";
    	sql.setString(i++, CARD_NO);
        sql.put(strQuery);
  
        map = selectMap(sql);
        sql.close();

        sql = new SqlWrapper();
        i=1;
        
        if(map.get("CUST_ID").equals("2")){
         	
			if("".equals(strFlag) || "%".equals(strFlag)) {
				strFlag = "P";
			}
			strQuery = svc.getQuery("SEL_CUSTINFO") + "\n"; 
			
			sql.setString(i++, CARD_NO);
	
			if (!String2.isEmpty(String2.trim((CARD_NO)))){
				strQuery += svc.getQuery("SEL_CUSTINFO_CARD_NO") + "\n";
				sql.setString(i++, CARD_NO);
			}
		
        }else{
        	
			if("".equals(strFlag) || "%".equals(strFlag)) {
				strFlag = "P";
			}
			strQuery = svc.getQuery("SEL_CUSTINFO_OLD") + "\n"; 
			if(strFlag.equals("C")){
				strQuery = svc.getQuery("SEL_CUSTINFO_COM") + "\n";
				strFlag = "P";
			}
			
			sql.setString(i++, strFlag);
	        //sql.setString(i++, BRCH_ID); //가맹점
			
			if (!String2.isEmpty(String2.trim((SS_NO)))){
				strQuery += svc.getQuery("SEL_CUSTINFO_SS_NO") + "\n";
				sql.setString(i++, SS_NO);
			}
			
			if (!String2.isEmpty(String2.trim((CUST_ID)))){
				strQuery += svc.getQuery("SEL_CUSTINFO_CUST_ID") + "\n";
				sql.setString(i++, CUST_ID);
			}		
	
			if (!String2.isEmpty(String2.trim((CARD_NO)))){
				strQuery += svc.getQuery("SEL_CUSTINFO_CARD_NO") + "\n";
				sql.setString(i++, CARD_NO);
			}			
			strQuery += svc.getQuery("SEL_CUSTINFO_ORDER");
			
			strQuery += "\n           AND A.SCED_REQ_DT IS NULL ";
        }	
		
        sql.put(strQuery);
        
        ret = select2List(sql);  

        return ret; 
    }
    
	/**
	 * 영수증 사후 적립(일괄) 영수증 마스터 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */   
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String     strQuery = "";   
        
        try {
        	
	        int i = 1; 
	        
			String strRecpNo   = String2.nvl(form.getParam("strRecpNo"));
			String strBrchId   = String2.nvl(form.getParam("strBrchId")); 
			
	        sql = new SqlWrapper();
	        svc = (Service) form.getService(); 
	 
	        connect("pot");
	        
			if (! isTrHeader_Chk(svc, strRecpNo)) {  
                throw new Exception("[USER]"+ "반품 된 영수증입니다.영수증번호를 확인해주세요.");
                
			}  
			
			if (! is_ChkRecpAdd_Chk(svc, strRecpNo)) {  
				throw new Exception("[USER]"+ "이미 사후적립 처리  된 영수증입니다.영수증번호를  확인해주세요." );
			} 
	        
			strQuery = svc.getQuery("SEL_MASTER"); 
	        
	        sql.setString(i++, strRecpNo); 
	        sql.setString(i++, strRecpNo);
	        sql.setString(i++, strRecpNo); 
	        sql.setString(i++, strRecpNo);
	        sql.setString(i++, strBrchId);
	        
	        sql.put(strQuery);
	        ret = select2List(sql);  
        
	    } catch (Exception e) {
	        throw e;
	    }
        return ret; 
    }
    
	/**
	 * 영수증 사후 적립(일괄) 영수증 디테일 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
    public List searchDetail(ActionForm form, String recpNo, String brchId) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
        try {        
        //String RECP_NO = String2.nvl(form.getParam("RECP_NO"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        strQuery = svc.getQuery("SEL_DETAIL"); 
        sql.setString(i++, recpNo); //영수증번호 
        sql.setString(i++, recpNo);
        sql.setString(i++, recpNo); 
        sql.setString(i++, recpNo);
        sql.setString(i++, brchId); //가맹점번호 
        
        sql.put(strQuery);
        ret = select2List(sql); 
        
	    } catch (Exception e) {
	        throw e;
	    }
        return ret; 
    }
    
	/**
	 * 영수증 사후 적립(일괄) 영수증 거래내역 결제수단별 디테일 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
    public List searchDetail_H(ActionForm form, String recpNo) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
        try { 
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        
        //원거래 영수증 번호[19]=점[2]+일자[8]+POS번호[4]+거래번호[5]  
        String recpNo_o = recpNo.substring(11, 13) + recpNo.substring(0, 8) + recpNo.substring(13, 17) + recpNo.substring(17,22); 

        strQuery = svc.getQuery("SEL_DETAIL_H");  
        //영수증번호[24]
        sql.setString(i++, recpNo);  
        sql.setString(i++, recpNo);
        sql.setString(i++, recpNo); 
        sql.setString(i++, recpNo);
        //원거래 영수증번호 [19]
        sql.setString(i++, recpNo_o); 
        sql.setString(i++, recpNo_o);
//        sql.setString(i++, recpNo_o); 
//        sql.setString(i++, recpNo_o);
//        sql.setString(i++, recpNo_o);
        
        sql.put(strQuery);
        ret = select2List(sql); 
        
	    } catch (Exception e) {
	        throw e;
	    }
        return ret; 
    } 
	/**
	 * 영수증 반품여부 체크
	 * @param Service
	 * @param ActionForm
	 * @return List
	 * @throws Exception
	 */
	private boolean isTrHeader_Chk(Service svc, String strRecpNo) throws Exception {
		SqlWrapper sql = null;
		boolean ret = false;
		 
		sql = new SqlWrapper(); 
		sql.put(svc.getQuery("SEL_TRHEADER_CHK"));
		int i = 0;
	    sql.setString(++i, strRecpNo); //영수증번호 
	    sql.setString(++i, strRecpNo);  
	    sql.setString(++i, strRecpNo);  
	    sql.setString(++i, strRecpNo);  

		Map map = selectMap(sql); 
		  
		if (map.get("CNT").equals("0") || map.get("CNT").equals(0)) {
			ret = true;
		} 
		
		return ret;
	}	
	
	/**
	 * 영수증 사후적립 체크
	 * @param Service
	 * @param ActionForm
	 * @return List
	 * @throws Exception
	 */
	private boolean is_ChkRecpAdd_Chk(Service svc, String strRecpNo) throws Exception {
		SqlWrapper sql = null;
		boolean ret = false;

		sql = new SqlWrapper();
		sql.put(svc.getQuery("SEL_RECP_ADD_CHK"));
		int i = 0;
	    sql.setString(++i, strRecpNo); //영수증번호 
	    sql.setString(++i, strRecpNo);  
	    sql.setString(++i, strRecpNo);  
	    sql.setString(++i, strRecpNo);  

		Map map = selectMap(sql);

		if (map.get("CNT").equals("0") || map.get("CNT").equals(0)) {
			ret = true;
		}
		return ret;
	}	
	
	/**
	 * 영수증 사후 적립
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput [] mi, String userId) throws Exception { 
		
		int ret 	= 0;
		int res 	= 0;
		int i   	= 0; 
    	final String MSG_LEN 		= "0621";
        final int	 MSG_ARR_LEN 	= 60;
        final int 	 REPLAY_CD_POS 	= 42;
        List   result_H  = null;
        List   result_D  = null;
        
		SqlWrapper sql = null;
		Service svc = null; 
		
        Util util = new Util(); 
		int result1 = 0;
		int result2 = 0;
        String rtnCode = "";
        String rtnMsg  = "";
         
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar cal = Calendar.getInstance();
        String time = sdf.format(cal.getTime()); 
		String USER_ID = userId;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();  
			
			// 고객정보
			while (mi[0].next()) { 
				 
				sql.close(); 		 
				
				while (mi[1].next()) {  
					
					i = 1;     
		            String STR_CD  = mi[1].getString("STR_CD"); //점코드
		            String SALE_DT = mi[1].getString("SALE_DT");//매출일자
		            String POS_NO  = mi[1].getString("POS_NO"); //POS번호
		            String TRAN_NO = mi[1].getString("TRAN_NO");//거래번호
		            
		            //화면 입력 영수증번호 [24]=> 매출일자(8)+"000"+점코드(2)+POS번호(4)+거래번호(5)+매출구분(1)+"0"
		            String RECP_NO = SALE_DT+"000"+STR_CD+POS_NO+TRAN_NO+"00";
		            
		            //영수증번호 [16]=> 시설구분(1)+매출일자(6)+POS번호(4)+거래번호(5)
		            String RECP_NO_FULL = "1" + mi[1].getString("SALE_DT").substring(2,8) + mi[1].getString("POS_NO") + mi[1].getString("TRAN_NO");
		             
		            // 1. 포인트 적립 체크 
		            if (searchTrpointCount(form, STR_CD, SALE_DT, POS_NO, TRAN_NO) < 1) { 
		            	
		            	// 2. 영수증 거래내역 상세 조회
		            	result_H = searchDetail_H(form , RECP_NO); 
		            	
			            long POINT       	= 0 ;
			            long PAY_AMT_SUM 	= 0;
			            String[] TYPE_CD 	= new String[30];
			            long[] TYPE_AMT 	= new long[30];
			            int TYPE_CNT 		= 0;   
			             
			            if(result_H.size() > 0 ) {
				            for (int j = 0 ; j < result_H.size(); j++) { 
				                
				                if ("PAY_AMT_SUM".equals((String)((List) result_H.get(j)).get(1))) { 			 //COL_ID
				                    PAY_AMT_SUM  = (Integer.parseInt((String) ((List) result_H.get(j)).get(4))); //COL_VAL//거래금액 합계 
				                }
				                
				                if ("PAY_AMT".equals((String)((List) result_H.get(j)).get(1))) { 				//COL_ID
				                    if ((Integer.parseInt((String) ((List) result_H.get(j)).get(5))) > 0) { 	//COL_VAL2
				                        TYPE_CD[TYPE_CNT] = (String)((List) result_H.get(j)).get(6); 			//COL_VAL3 
				                        TYPE_AMT[TYPE_CNT] = (Integer.parseInt((String) ((List) result_H.get(j)).get(5))); //COL_VAL2
				                        TYPE_CNT++;
				                    }
				                }
				            } 
				            
				            for (int k = 0 ; k < TYPE_CD.length; k++) {
				                if (null == TYPE_CD[k]) {
				                    TYPE_CD[k] = "";
				                }
				            }   
				            
			            } else { 
			                throw new Exception("[USER]" + "영수증 거래내역 조회 시 ERROR가 발생하였습니다. " 
			                		+ "다시 확인하시기 바랍니다. ");
			            }
			              
			            // 3. 영수증 포인트 적립 전문 
			            String[] arrData   = new String[MSG_ARR_LEN];
			            String[] outputArr = new String[MSG_ARR_LEN];
			            
			            arrData[ 0] = MSG_LEN;                       // MSG_LEN         N    4
			            arrData[ 1] = "DEPTRN0212";                  // MSG_TEXT        C   10
			            arrData[ 3] = "200020";                      // TRADE_GB_CD     C    6
			            arrData[ 4] = mi[1].getString("SALE_DT");    // SALE_DT         C    8
			            arrData[ 5] = time.substring(8,14);          // SALE_TM         C    6
			            arrData[ 6] = RECP_NO_FULL;                  // RECP_NO         C   20
			            arrData[ 7] = USER_ID;                       // REG_ID          C   10
			            arrData[ 8] = "C";                           // IN_FLAG         C    1
			            arrData[ 9] = mi[0].getString("CARD_NO");    // CARD_NO         C   64
			            arrData[11] = mi[1].getString("BRCH_ID");    // BRCH_ID         C   10
			            arrData[44] = mi[0].getString("CUST_NAME");  // CUST_NM         C   40
			            arrData[12] = TYPE_CD[0];                    // TYPE1_CD        C    2
			            arrData[14] = String.valueOf(TYPE_AMT[0]);   // TYPE1_AMT       N    9            
			            arrData[15] = TYPE_CD[1];                    // TYPE2_CD        C    2
			            arrData[17] = String.valueOf(TYPE_AMT[1]);   // TYPE2_AMT       N    9            
			            arrData[18] = TYPE_CD[2];                    // TYPE3_CD        C    2
			            arrData[20] = String.valueOf(TYPE_AMT[2]);   // TYPE3_AMT       N    9            
			            arrData[21] = TYPE_CD[3];                    // TYPE4_CD        C    2
			            arrData[23] = String.valueOf(TYPE_AMT[3]);   // TYPE4_AMT       N    9            
			            arrData[24] = TYPE_CD[4];                    // TYPE5_CD        C    2
			            arrData[26] = String.valueOf(TYPE_AMT[4]);   // TYPE5_AMT       N    9            
			            arrData[27] = TYPE_CD[5];                    // TYPE6_CD        C    2
			            arrData[29] = String.valueOf(TYPE_AMT[5]);   // TYPE6_AMT       N    9            
			            arrData[30] = TYPE_CD[6];                    // TYPE7_CD        C    2
			            arrData[32] = String.valueOf(TYPE_AMT[6]);   // TYPE7_AMT       N    9            
			            arrData[33] = TYPE_CD[7];                    // TYPE8_CD        C    2
			            arrData[35] = String.valueOf(TYPE_AMT[7]);   // TYPE8_AMT       N    9            
			            arrData[36] = String.valueOf(TYPE_CNT);      // TYPE_CNT        N    2            
			            arrData[37] = String.valueOf(PAY_AMT_SUM);   // TRADE_AMT       N   10
			            arrData[41] = "13";                          // ADD_USE_FLAG    C    2 12 : 포스사후적립 -> 13 : 인포사후적립
			            arrData[50] = String.valueOf(POINT);         // ADD_POINT       N    9 49--> 50으로 변경 201111 FKSS
			            
			            result1 = sendData(form, arrData); 
			            
			            // 4. 품목별 고객매출 정보 처리 
			            if(result1 == 0){
			            	
				            String[] arrData1   = new String[10]; 
				            
				            //영수증 상세 조회
				            result_D = searchDetail(form , RECP_NO, mi[1].getString("BRCH_ID"));  
				            
				            if(result_D.size() > 0 ) {
					            for (int j = 0 ; j < result_D.size(); j++) {  
					                arrData1[ 0]  = STR_CD;									  // 점코드
						            arrData1[ 1]  = SALE_DT;								  // 매출일자
						            arrData1[ 2]  = mi[0].getString("CUST_ID");				  // 고객번호 
						            arrData1[ 3]  = (String)((List) result_D.get(j)).get(12); // 품번코드   
						            arrData1[ 4]  = (String)((List) result_D.get(j)).get(11); // 순매출금액 
						            arrData1[ 5]  = "0";									  // 반품금액 
						            arrData1[ 6]  = (String)((List) result_D.get(j)).get(13); // 총매출액  
						            arrData1[ 7]  = (String)((List) result_D.get(j)).get(14); // 매출액 
						            
						            result2 = sendPumbunCust(form, arrData1);
						              
						            if(result2 == 0){ 
						            } else {
						            	rtnMsg = "고객 매출집계 처리 중 영수증 사후적립에 실패하였습니다.<br>";  
										throw new Exception("[USER]"+ rtnMsg);
						            } 						            
					            }
				            } else {
				            	rtnMsg = "영수증 상세내역 조회 중 영수증 사후적립에 실패하였습니다.<br>";  
				                throw new Exception("[USER]"+ rtnMsg);
				            }
			            } else {
			            	rtnMsg = "포인트 적립/사용 승인  처리 중 영수증 사후적립에 실패하였습니다.<br>";  
			                throw new Exception("[USER]"+ rtnMsg);
			            }
		            } else {  
		            	rtnMsg = "이미 승인처리되었습니다.<br>"; 
		            	throw new Exception("[USER]"+ rtnMsg);
		            } 
		            
					ret += res; 
				}    
			}
		} catch (Exception e) { 
			rollback(); 
			throw e;
		} finally {
			end();
		}
		return ret;
	} 
	
    /**
	 * 포인트 적립/사용 승인 프로시져 호출
	 * @param form
	 * @param mi
	 * @return
	 */	
	public int sendData( ActionForm form, String[] output) throws Exception{
		int ret  = 0;
		//int res  = 0;
		String res = "";
		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		SqlWrapper sql = null;
		Service svc = null;
		String orgCdCnt = "";
		int i = 0;
		try {
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();				

			psql.put("DCS.PR_DMBO504", 63);    
			
			psql.setString(++i, output[ 0]);     //전문 총길이			
			psql.setString(++i, output[ 1]);     //전문 구분			
			psql.setString(++i, ""); //POS정보			
			psql.setString(++i, "200020");       //거래구분코드
			psql.setString(++i, output[ 4]);     //영업일자
			psql.setString(++i, output[ 5]);     //거래시간
			psql.setString(++i, output[ 6]);     //영수증번호
			psql.setString(++i, output[ 7]);     //담당자사번
			psql.setString(++i, output[ 8]);     //카드/주민번호구분["C"]
			psql.setString(++i, output[ 9]);     //[카드번호]/주민번호		
			psql.setString(++i, "");             //비밀번호
			psql.setString(++i, output[11]);     //가맹점ID

			psql.setString(++i, output[12]);     //결제수단코드1
			psql.setString(++i, "");             //결제수단1상세
			psql.setDouble(++i, Integer.parseInt(output[14]));     //결제수단금액1

			psql.setString(++i, output[15]);     //결제수단코드2
			psql.setString(++i, "");           //결제수단2상세
			psql.setDouble(++i, Integer.parseInt(output[17]));     //결제수단금액2

			psql.setString(++i, output[18]);     //결제수단코드3
			psql.setString(++i, "");           //결제수단3상세
			psql.setDouble(++i, Integer.parseInt(output[20]));     //결제수단금액3

			psql.setString(++i, output[21]);     //결제수단코드4
			psql.setString(++i, "");             //결제수단4상세
			psql.setDouble(++i, Integer.parseInt(output[23]));     //결제수단금액4

			psql.setString(++i, output[24]);   //결제수단코드5
			psql.setString(++i, "");           //결제수단5상세
			psql.setDouble(++i, Integer.parseInt(output[26]));     //결제수단금액5

			psql.setString(++i, output[27]);    //결제수단코드6
			psql.setString(++i, "");            //결제수단6상세
			psql.setDouble(++i, Integer.parseInt(output[29]));     //결제수단금액6

			psql.setString(++i, output[30]);     //결제수단코드7
			psql.setString(++i, "");             //결제수단7상세
			psql.setDouble(++i, Integer.parseInt(output[32]));     //결제수단금액7

			psql.setString(++i, output[33]);     //결제수단코드8
			psql.setString(++i, "");             //결제수단8상세
			psql.setDouble(++i, Integer.parseInt(output[35]));     //결제수단금액8
			
			psql.setString(++i, output[36]);        //결제수단건수
			psql.setString(++i, output[37]);        //총거래금액
			psql.setDouble(++i, 0);                 //사용취소포인트
			psql.setString(++i, "");                //원거래영수증번호
			psql.setString(++i, "");                //원거래승인번호
			psql.setString(++i, output[41]);		//적립/사용구분
			
//			psql.setString(++i, "");                //응답코드			
//			psql.setString(++i, "");                //승인번호
//			psql.setString(++i, ""); 				//성명
//			psql.setString(++i, "");                //회원등급
//			psql.setString(++i, "");                //시스템일자
//			psql.setString(++i, "");                //시스템시간
			
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
//			psql.setDouble(++i, 0);                 //누적포인트
//			psql.setDouble(++i, 0);                 //가용포인트
			
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			
			//psql.setString(++i, output[50]);		//금회포인트
//			psql.setString(++i, "");                //금회포인트
//			psql.setDouble(++i, 0);                 //결제적립
//			psql.setString(++i, "");                //캠페인ID
//			psql.setDouble(++i, 0);                 //캠페인적립
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			
			
			psql.setString(++i, "");                //이벤트ID
			psql.setDouble(++i, 0);                 //이벤트적립
//			psql.setDouble(++i, 0);                 //기타적립
//			psql.setString(++i, ""); 				//영수증출력메시지1
//			psql.setString(++i, ""); 				//영수증출력메시지2
			
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
//			psql.setString(++i, ""); 				//회원ID
//			psql.setString(++i, "");           		//공란

			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
		    psql.registerOutParameter(62, DataTypes.INTEGER);//8 return   
		    psql.registerOutParameter(63, DataTypes.VARCHAR);//9 return value(에러 메세지)
		    
		    prs = updateProcedure(psql);
		    
			resp = prs.getInt(62);
			res = prs.getString(63);
			
			System.out.println("DCS.PR_DMBO504 프로시저 에러 내역:" + res);
			  
	        if( resp != 0 ) { 
	        	throw new Exception("[USER]"+ res);
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}    
     
    /**
	 * 포인트 적립 체크
	 * @param form
	 * @param mi
	 * @return
	 */	  
    public int searchTrpointCount(ActionForm form, String strCd,  String saleDt,  String posNo,  String tranNo ) {
    	int count = 0;
    	Service     svc = null;
    	try {   
	        connect("pot");
	        
	        svc  = (Service) form.getService();
	        String query = "";
	        SqlWrapper sql  = new SqlWrapper();
	        query = svc.getQuery("SEL_RECP_CNT"); // + "\n";
	        
			int in = 1;
			sql.setString(in++, strCd);
			sql.setString(in++, saleDt);
			sql.setString(in++, posNo);
			sql.setString(in++, tranNo);
			sql.setString(in++, strCd);
			sql.setString(in++, saleDt);
			sql.setString(in++, posNo);
			sql.setString(in++, tranNo);
			sql.put(query);
			
			Map<String,String> resultMap = this.selectMap(sql);
			count = Integer.parseInt((String) resultMap.get("REC_CNT")); 
            
    	}
    	catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return count;
    } 
     
    /**
	 * 고객 매출집계 프로시져 호출
	 * @param form
	 * @param mi
	 * @return
	 */	
	public int sendPumbunCust( ActionForm form, String[] output) throws Exception{
		int ret  = 0;
		String res = "";
		int resp = 0;					//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		try {
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();				

			psql.put("DPS.PR_PSPUMBUNCUST", 10);    
			
			psql.setString(++i, output[ 0]);     //점코드
			psql.setString(++i, output[ 1]);     //매출일자
			psql.setString(++i, output[ 2]);     //고객번호
			psql.setString(++i, output[ 3]);     //품번코드
			psql.setString(++i, output[ 4]);     //순매출금액
			psql.setString(++i, output[ 5]);     //반품금액
			psql.setString(++i, output[ 6]);     //총매출액
			psql.setString(++i, output[ 7]);     //매출액		
		    psql.registerOutParameter(++i, DataTypes.INTEGER);//8
		    psql.registerOutParameter(++i, DataTypes.VARCHAR);//9
		    
		    prs = updateProcedure(psql);
		    
			resp = prs.getInt(9);
			res = prs.getString(10);
			
			System.out.println("DCS.PR_PSPUMBUNCUST 프로시저 에러 내역:" + res);
			   
	        if( resp != 0 ) { 
	        	throw new Exception("[USER]"+ res);
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}
    
	 /**
     * Pop-Up  조회 --> 사용안함
     * @param form
     * @return
     */
    public String searchRecpNoStrCd(ActionForm form, String brchId) {
    	Service     svc = null;
    	String recpNoStrCd = null;
    	try {            
	        connect("pot");
	        
	        svc  = (Service) form.getService();
	        String query = "";
	        SqlWrapper sql  = new SqlWrapper();
	        query = svc.getQuery("SEL_STR_CD"); // + "\n";
	        
			int in = 1;
			sql.setString(in++, brchId);
			sql.put(query);
			Map<String,String> resultMap = this.selectMap(sql);
			recpNoStrCd = (String) resultMap.get("STR_CD");			
    	}
    	catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    	return recpNoStrCd;
    }
}
