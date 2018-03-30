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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import com.gauce.GauceDataSet;
import common.util.Util;
/**
 * <p>영수증사후적립(회원등록이전)</p>
 * 
 * @created  on 1.0, 2010.08.25
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo621DAO extends AbstractDAO {
    
    public List searchMaster(ActionForm form, String strCd, String saleDt, String posNo, String tranNo, String brchId) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, strCd); 
        sql.setString(i++, saleDt);
        sql.setString(i++, posNo); 
        sql.setString(i++, tranNo);
        sql.setString(i++, brchId);

        strQuery = svc.getQuery("SEL_MASTER"); 
        sql.put(strQuery);
        ret = select2List(sql);  
        
        return ret; 
    }
    
    public List searchDetail(ActionForm form, String strCd, String saleDt, String posNo, String tranNo) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
        
        //String RECP_NO = String2.nvl(form.getParam("RECP_NO"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, strCd); 
        sql.setString(i++, saleDt);
        sql.setString(i++, posNo); 
        sql.setString(i++, tranNo);

        strQuery = svc.getQuery("SEL_DETAIL"); 
        sql.put(strQuery);   
        ret = select2List(sql);  
        
        return ret; 
    }
    
    
    /**
     * 
     * @param form
     * @param output
     * @return
     * @throws Exception
     */
    public int saveData(ActionForm form, String[] output, String strCd) throws Exception {
    	int 		result = 0;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util = new Util();
        
     // 영수증번호 포맷 변경 (2011.08.17)
        String recpNo 	= output[6];
        String sailDt	= "20"+ recpNo.substring( 1, 7);   
        String posNo 	= recpNo.substring( 7,11);
        String tranNo 	= recpNo.substring(11,16);        
        
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
            sql.setString(in++, sailDt);		//SALE_DT     
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
				sql.setString(in++, strCd); 	//STR_CD      
				sql.setString(in++, tranNo); 	//TRAN_NO     
				sql.setString(in++, sailDt); 					//SALE_DT     
				sql.setString(in++, posNo); 	//POS_NO      
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
    public int searchTrpointCount(ActionForm form, String strCd, String sailDt, String posNo, String tranNo) {
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

}
