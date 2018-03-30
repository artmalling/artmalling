/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import com.gauce.GauceDataSet;
import common.util.Util;
import common.vo.SessionInfo;

/**
 * <p>포인트 강제적립/차감</p>
 * 
 * @created  on 1.0, 2010/01/25
 * @created  by 남형석
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo604DAO extends AbstractDAO {

	public List searchMaster(ActionForm form, GauceDataSet dSet) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strProrDt_f = String2.nvl(form.getParam("strProrDt_f"));
		String strProrDt_t = String2.nvl(form.getParam("strProrDt_t"));
		String strCustid   = String2.nvl(form.getParam("strCustid"));
		String strCardno   = String2.nvl(form.getParam("strCardno"));//
		String strSsno     = String2.nvl(form.getParam("strSsno"));//
		String strCompFlag   = String2.nvl(form.getParam("strCompFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strProrDt_f);
		sql.setString(i++, strProrDt_t);
		sql.setString(i++, strCompFlag);
		
		if (!String2.isEmpty(String2.trim((strSsno)))){
			strQuery += svc.getQuery("SEL_MASTER_SS_NO") + "\n";
			sql.setString(i++, strSsno);
		}
		
		if (!String2.isEmpty(String2.trim((strCustid)))){
			strQuery += svc.getQuery("SEL_MASTER_CUST_ID") + "\n";
			sql.setString(i++, strCustid);
		}		

		if (!String2.isEmpty(String2.trim((strCardno)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, strCardno);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_END") + "\n";
		
		
		
		strQuery += svc.getQuery("SEL_MASTER_UNION") + "\n";
		sql.setString(i++, strProrDt_f);
        sql.setString(i++, strProrDt_t);
        sql.setString(i++, strCompFlag);
		
		if (!String2.isEmpty(String2.trim((strSsno)))){
			strQuery += svc.getQuery("SEL_MASTER_SS_NO") + "\n";
			sql.setString(i++, strSsno);
		}
		
		if (!String2.isEmpty(String2.trim((strCustid)))){
			strQuery += svc.getQuery("SEL_MASTER_CUST_ID") + "\n";
			sql.setString(i++, strCustid);
		}		

		if (!String2.isEmpty(String2.trim((strCardno)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, strCardno);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_END") + "\n";
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		Util util = new Util();
		//util.decryptedStr(ret,dSet.indexOfColumn("CARD_NO")); 
		
		//System.out.println(ret.size());
		return ret;
	}

	/**
     * <p>당일 포인트 강제 적립/차감 정보를 조회한다</p>
     * 
     */        
    public List searchTodayList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
               
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
		String strCustid   = String2.nvl(form.getParam("strCustid"));
		String strCardno   = String2.nvl(form.getParam("strCardno"));
		String strSsno     = String2.nvl(form.getParam("strSsno"));

        
        strQuery = svc.getQuery("SEL_TODAY_LIST") + "\n";
        
        if (!String2.isEmpty(String2.trim((strSsno)))){
			strQuery += svc.getQuery("SEL_TODAY_LIST_SS_NO") + "\n";
			sql.setString(i++, strSsno);
		}
		
		if (!String2.isEmpty(String2.trim((strCustid)))){
			strQuery += svc.getQuery("SEL_TODAY_LIST_CUST_ID") + "\n";
			sql.setString(i++, strCustid);
		}		

		if (!String2.isEmpty(String2.trim((strCardno)))){
			strQuery += svc.getQuery("SEL_TODAY_LIST_CARD_NO") + "\n";
			sql.setString(i++, strCardno);
		}
		
		strQuery += svc.getQuery("SEL_TODAY_LIST_ORDER") + "\n";
        
        sql.put(strQuery); 
        ret = select2List(sql);
               
        return ret;
    }	

	/**
	 * <p>포인트 강제적립/차감 내역 저장</p>
	 * 
	 * @created  on 1.0, 2010/01/25
	 * @created  by 남형석
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public int saveData(ActionForm form, GauceDataSet dSet, HttpServletRequest request) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        String don_id  = null;
        Util util      = new Util();

        try {

			begin();
            connect("pot");
            svc  = (Service)form.getService();
            String strQuery = "";
           
            sql  = new SqlWrapper();
			String cardNo   = "";
			 
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            sql.close();
            
            String BRCH_ID   = dSet.getDataRow(0).getColumnValue(0).toString();
            String CARD_NO   = dSet.getDataRow(0).getColumnValue(1).toString();
            String PROC_FLAG = dSet.getDataRow(0).getColumnValue(2).toString();
            String POINT     = dSet.getDataRow(0).getColumnValue(3).toString();
            String REASON_CD = dSet.getDataRow(0).getColumnValue(4).toString();
            String REMARK    = dSet.getDataRow(0).getColumnValue(5).toString();
            String SS_NO     = dSet.getDataRow(0).getColumnValue(6).toString();
            String CUST_ID   = dSet.getDataRow(0).getColumnValue(6).toString();
             
            String query = "  SELECT UNIQUE A.CARD_NO \n"
                         + "    FROM DCS.DM_CARD A    \n"
                         + "       , DCS.DM_CUSTOMER B \n"
                         + "   WHERE A.CUST_ID  =  B.CUST_ID \n"
                         + "    AND A.CARD_NO    LIKE DCS.SC_Crypto_FUN('ENC', '"+ CARD_NO +"') || '%' \n"
                         + "    AND B.SS_NO      LIKE DCS.SC_Crypto_FUN('ENC', '"+ SS_NO +"') || '%' \n"
                         + "    AND A.CUST_ID    LIKE '"+ CUST_ID +"' || '%' \n";
            
            sql.put(query);
            Map map = selectMap(sql);            
            cardNo = (String)map.get("CARD_NO");   
            
            if ("".equals(cardNo)) 
            	throw new Exception("" +" 카드 번호가 정확하지 않습니다.! ");
            
            sql.close();
            int i=1;
            sql.put(svc.getQuery("saveData")); 
			sql.setString(i++, BRCH_ID);
			sql.setString(i++, CARD_NO);
			sql.setString(i++, PROC_FLAG);
			sql.setInt(i++, Integer.parseInt(POINT));
			sql.setString(i++, REASON_CD);
			sql.setString(i++, REMARK);
			sql.setString(i++, sessionInfo.getUSER_ID());
			
			sql.put(strQuery);
			
			res = update(sql);			
			
			if ( res != 1 ) {
				throw new Exception("" +
						"데이터의 정합성 문제로 인하여 " +
						"데이터 입력을 하지 못했습니다.");
			}
			
			ret += res;
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
        return ret;
	}	
	
}
