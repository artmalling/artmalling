/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import com.gauce.GauceDataSet;
import common.util.Util;
/**
 * <p>영수증 사후 적립:고객미등록</p>
 * 
 * @created  on 1.0, 2010.03.23
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo622DAO extends AbstractDAO {
    public List searchCust(ActionForm form, GauceDataSet dSet) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Map        map  = null;
        Util       util = new Util();
        String strQuery = "";

        String BRCH_ID = String2.nvl(form.getParam("BRCH_ID"));
        String CUST_ID = String2.nvl(form.getParam("CUST_ID"));
        String SS_NO   = String2.nvl(form.getParam("SS_NO"));
        String CARD_NO = String2.nvl(form.getParam("CARD_NO"));
        String strFlag = String2.nvl(form.getParam("COMP_PERS_FLAG"));        
        
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


     /* ret = util.decryptedStr(ret,dSet.indexOfColumn("HOME_PH1"));    //집전화1
        ret = util.decryptedStr(ret,dSet.indexOfColumn("HOME_PH2"));    //집전화2
        ret = util.decryptedStr(ret,dSet.indexOfColumn("HOME_PH3"));    //집전화3
        ret = util.decryptedStr(ret,dSet.indexOfColumn("MOBILE_PH1"));  //휴대전화1
        ret = util.decryptedStr(ret,dSet.indexOfColumn("MOBILE_PH2"));  //휴대전화2
        ret = util.decryptedStr(ret,dSet.indexOfColumn("MOBILE_PH3"));  //휴대전화3
        ret = util.decryptedStr(ret,dSet.indexOfColumn("SS_NO"));       //주민번호
        ret = util.decryptedStr(ret,dSet.indexOfColumn("EMAIL1"));      //EMAIL1
        ret = util.decryptedStr(ret,dSet.indexOfColumn("EMAIL2"));      //EMAIL2
        ret = util.decryptedStr(ret,dSet.indexOfColumn("CARD_NO"));     //CARD_NO */

        return ret; 
    }
    
    public List searchMaster(ActionForm form, String RECP_NO, String BRCH_ID) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
//        String BRCH_ID = String2.nvl(form.getParam("BRCH_ID"));
//        String RECP_NO = String2.nvl(form.getParam("RECP_NO"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, RECP_NO); 
        sql.setString(i++, RECP_NO);
        sql.setString(i++, RECP_NO); 
        sql.setString(i++, RECP_NO);
        sql.setString(i++, BRCH_ID);

        strQuery = svc.getQuery("SEL_MASTER"); 
        sql.put(strQuery);
        ret = select2List(sql);  
        
        return ret; 
    }
    
    public List searchDetail(ActionForm form, String RECP_NO) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = ""; 
        //String RECP_NO = String2.nvl(form.getParam("RECP_NO"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        //원거래 영수증 번호[19]=점[2]+일자[8]+POS번호[4]+거래번호[5]  
        String RECP_NO_O = RECP_NO.substring(11, 13) + RECP_NO.substring(0, 8) + RECP_NO.substring(13, 17) + RECP_NO.substring(17,22); 
        
        int i = 1;
        //영수증번호[24]
        sql.setString(i++, RECP_NO); 
        sql.setString(i++, RECP_NO);
        sql.setString(i++, RECP_NO); 
        sql.setString(i++, RECP_NO);
        //원거래 영수증번호 [19]
        sql.setString(i++, RECP_NO_O); 
        sql.setString(i++, RECP_NO_O);
//        sql.setString(i++, RECP_NO_O); 
//        sql.setString(i++, RECP_NO_O);
//        sql.setString(i++, RECP_NO_O);

        strQuery = svc.getQuery("SEL_DETAIL"); 
        sql.put(strQuery);   
        ret = select2List(sql);  
        
        return ret; 
    }
    
    /**
	 * 프로시져 호출
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
			psql.setString(++i, output[ 8]);     //카드/주민번호구분			
			psql.setString(++i, output[ 9]);     //카드번호/주민번호		
			psql.setString(++i, "");         //비밀번호
			psql.setString(++i, output[11]);     //가맹점ID

			psql.setString(++i, output[12]);     //결제수단코드1
			psql.setString(++i, "");           //결제수단1상세
			psql.setDouble(++i, Integer.parseInt(output[14]));     //결제수단금액1

			psql.setString(++i, output[15]);     //결제수단코드2
			psql.setString(++i, "");           //결제수단2상세
			psql.setDouble(++i, Integer.parseInt(output[17]));     //결제수단금액2

			psql.setString(++i, output[18]);     //결제수단코드3
			psql.setString(++i, "");           //결제수단3상세
			psql.setDouble(++i, Integer.parseInt(output[20]));     //결제수단금액3

			psql.setString(++i, output[21]);     //결제수단코드4
			psql.setString(++i, "");           //결제수단4상세
			psql.setDouble(++i, Integer.parseInt(output[23]));     //결제수단금액4

			psql.setString(++i, output[24]);     //결제수단코드5
			psql.setString(++i, "");           //결제수단5상세
			psql.setDouble(++i, Integer.parseInt(output[26]));     //결제수단금액5

			psql.setString(++i, output[27]);     //결제수단코드6
			psql.setString(++i, "");           //결제수단6상세
			psql.setDouble(++i, Integer.parseInt(output[29]));     //결제수단금액6

			psql.setString(++i, output[30]);     //결제수단코드7
			psql.setString(++i, "");           //결제수단7상세
			psql.setDouble(++i, Integer.parseInt(output[32]));     //결제수단금액7

			psql.setString(++i, output[33]);     //결제수단코드8
			psql.setString(++i, "");           //결제수단8상세
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
			
		    psql.registerOutParameter(62, DataTypes.INTEGER);//8
		    psql.registerOutParameter(63, DataTypes.VARCHAR);//9
		    
		    prs = updateProcedure(psql);
		    
		    System.out.println(prs);
			resp = prs.getInt(62);
			res = prs.getString(63);
			
			System.out.println(resp);
						
	        if (resp != 0) {
	            throw new Exception("[USER]" +res);
	        }
				//ret += resp;


		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}
    
    /**
     * 
     * @param form
     * @param output
     * @return
     * @throws Exception
     */
    public int saveData(ActionForm form, String[] output) throws Exception {
    	int 		result = 0;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util = new Util();
        String strCd 	= output[ 6].substring( 0, 2);
        String sailDt	= output[ 6].substring( 2,10);
        String posNo 	= output[ 6].substring(10,14);
        String tranNo 	= output[ 6].substring(14,19);
        try {
            connect("pot");
            begin();
            
            svc  = (Service) form.getService();
            String query = "";
			
			/* 영수증사후적립 저장 */
			sql = new SqlWrapper();
			query = svc.getQuery("NEXT_POINT_SEQ"); // + "\n";
            String REG_ID      = form.getParam("USER_ID");            
            int in = 1;            
            sql.setString(in++, output[ 4]);	//SALE_DT     
            sql.setString(in++, strCd); 		//STR_CD      
            sql.setString(in++, posNo); 		//POS_NO      
            sql.setString(in++, tranNo); 		//TRAN_NO     
            sql.setString(in++, output[ 9].trim()); //CARD_NO     
            sql.setString(in++, output[11]); //BRCH_ID     
            sql.setString(in++, output[ 6]); //RECP_NO     
            sql.setString(in++, output[37]); //RECP_AMT    
            sql.setString(in++, output[49]); //ADD_POINT   
            sql.setString(in++, output[50]); //BASE_APOINT 
            sql.setString(in++, output[52]); //CAM_APOINT  
            sql.setString(in++, output[51]); //CAM_ID      
            sql.setString(in++, output[54]); //EVENT_APOINT
            sql.setString(in++, output[53]); //EVENT_CD    
            sql.setString(in++, output[55]); //ETC_APOINT  
            sql.setString(in++, "A"); 		//PROC_FLAG   
            //sql.setString(in++, output[46]); //SEND_DATE   
            sql.setString(in++, REG_ID); 	//REG_ID      
            
            query = svc.getQuery("INS_RECP") + "\n";
            sql.put(query);
            result = update(sql);   
            System.out.println("result:["+ result +"]");
            
            /* point 저장 */
            if (result > 0) {
            	sql = new SqlWrapper();
				query = svc.getQuery("NEXT_POINT_SEQ"); // + "\n";
				in = 1;
				sql.setString(in++, strCd);
				sql.setString(in++, sailDt);
				sql.setString(in++, posNo);
				sql.setString(in++, tranNo);
				sql.put(query);
				Map<String,String>resultMap = this.selectMap(sql);
				String seqNo = (String) resultMap.get("SEQ_NO");
				seqNo = seqNo == null || seqNo.length() <1 ? "1": seqNo;
				
				System.out.println(seqNo);
				
            	sql = new SqlWrapper();
				query = svc.getQuery("INS_POINT"); // + "\n";
				in = 1;
				sql.setString(in++, "0"+output[ 6].substring(0,1)); 	//STR_CD      
				sql.setString(in++, output[ 6].substring(11,16)); 	//TRAN_NO     
				sql.setString(in++, output[ 4]); 					//SALE_DT     
				sql.setString(in++, output[ 6].substring(7,11)); 	//POS_NO  
				System.out.println("0"+output[ 6].substring(0,1) + "STR_CD");
				System.out.println(output[ 4] + "SALE_DT");
				System.out.println(output[ 6].substring(7,11) + "POS_NO");
				System.out.println(output[ 6].substring(11,16) + "TRAN_NO");
				sql.setString(in++, String.valueOf(Integer.parseInt(seqNo) + 1)); 	 //SEQ_NO      
				sql.setString(in++, "D"); 		 //POINT_TYPE  
				sql.setString(in++, output[12]); //PAY_TYPE_01
				sql.setString(in++, output[13]); //PAY_DTL_01 
				sql.setString(in++, output[14]); //TRG_AMT_01 
				sql.setString(in++, output[15]); //PAY_TYPE_02
				sql.setString(in++, output[16]); //PAY_DTL_02 
				sql.setString(in++, output[17]); //TRG_AMT_02 
				sql.setString(in++, output[18]); //PAY_TYPE_03
				sql.setString(in++, output[19]); //PAY_DTL_03 
				sql.setString(in++, output[20]); //TRG_AMT_03 
				sql.setString(in++, output[21]); //PAY_TYPE_04
				sql.setString(in++, output[22]); //PAY_DTL_04 
				sql.setString(in++, output[23]); //TRG_AMT_04 
				sql.setString(in++, output[24]); //PAY_TYPE_05
				sql.setString(in++, output[25]); //PAY_DTL_05 
				sql.setString(in++, output[26]); //TRG_AMT_05 
				sql.setString(in++, output[27]); //PAY_TYPE_06
				sql.setString(in++, output[28]); //PAY_DTL_06 
				sql.setString(in++, output[29]); //TRG_AMT_06 
				sql.setString(in++, output[30]); //PAY_TYPE_07
				sql.setString(in++, output[31]); //PAY_DTL_07 
				sql.setString(in++, output[32]); //TRG_AMT_07 
				sql.setString(in++, output[33]); //PAY_TYPE_08
				sql.setString(in++, output[34]); //PAY_DTL_08 
				sql.setString(in++, output[35]); //TRG_AMT_08 
				sql.setString(in++, output[36]); //PAY_CNT    
				sql.setString(in++, output[37]); //PAY_TOT_AMT
				sql.setString(in++, ""); 		 //ORG_TRAN_NO 
				sql.setString(in++, ""); 		 //ORG_APPR_NO 
				sql.setString(in++, ""); 		 //IN_TYPE     
				sql.setString(in++, output[ 9]); //MBSH_NO     --
				sql.setString(in++, output[41]); //EXE_TYPE    	
				sql.setString(in++, output[43]); //APPR_NO     
				sql.setString(in++, output[42]); //RSLT_CD     
				sql.setString(in++, output[56]); //RSLT_MSG    
				sql.setString(in++, output[44]); //CUST_NM     
				sql.setString(in++, output[45]); //CUST_GRADE  
				sql.setString(in++, output[48]); //ACML_POINT  
				sql.setString(in++, output[49]); //OCC_POINT   
				sql.setString(in++, output[50]); //BASE_APOINT 
				sql.setString(in++, output[52]); //CAM_APOINT  
				sql.setString(in++, output[54]); //EVENT_APOINT
				sql.setString(in++, output[55]); //ETC_APOINT  
				sql.setString(in++, output[56]); //MSG_01      
				sql.setString(in++, output[57]); //MSG_02     
				
				sql.put(query);
	            result = update(sql);   
            }
            
            /* 정상처리 commit: 실패: rollback */
            if (result > 0) {
            	end();
            }
            else {
                result = -1;
                rollback();
            }
        } catch (SQLException sqle) {
            rollback();
            throw sqle;
        } catch (Exception e) {
            rollback();
            throw e;
        }
        
        return result;
    }    
    
    /**
     * 
     * @param form
     * @return
     */
    public int searchTrpointCount(ActionForm form, String recpNo) {
    	int count = 0;
    	Service     svc = null;
    	try {
    		String strCd 	= recpNo.substring( 0, 2);
            String sailDt	= recpNo.substring( 2,10);
            String posNo 	= recpNo.substring(10,14);
            String tranNo 	= recpNo.substring(14,19);
            
	        connect("pot");
	        
	        svc  = (Service) form.getService();
	        String query = "";
	        SqlWrapper sql  = new SqlWrapper();
	        query = svc.getQuery("SEL_RECP_CNT"); // + "\n";
	        
			int in = 1;
			sql.setString(in++, strCd);
			sql.setString(in++, sailDt);
			sql.setString(in++, posNo);
			sql.setString(in++, tranNo);
			sql.setString(in++, strCd);
			sql.setString(in++, sailDt);
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
     * 
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
    
    
    /**
	 * 프로시져 호출
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

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}
    

}
