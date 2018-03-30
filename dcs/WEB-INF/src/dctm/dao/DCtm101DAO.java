/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import com.gauce.GauceDataSet;
import common.util.Util;
import common.vo.SessionInfo;

/**
 * <p>무기명카드발급등록</p>
 * 
 * @created  on 1.0, 2010/02/16
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCtm101DAO extends AbstractDAO {

	/**
	 * 무기명 카드 발급 등록 매수 조회.
	 *  
	 */  
	public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strFromDt = String2.nvl(form.getParam("strFromDt"));
		String strToDt = String2.nvl(form.getParam("strToDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		strQuery = svc.getQuery("SEL_DATA") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		
		return ret;
	}	

	/**
	 * 무기명 카드 발급 등록 매수 상세조회.
	 *  
	 */  
	public List searchDetail(ActionForm form, HttpServletRequest request) throws Exception {
		List ret = null;
		SqlWrapper sql = null; 
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strCardCreDt  = String2.nvl(form.getParam("strCardCreDt"));
		String strCardSeq    = String2.nvl(form.getParam("strCardSeq"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
 
		connect("pot");
 
		sql.setString(i++, strCardCreDt);  
		sql.setString(i++, strCardSeq);

		strQuery = svc.getQuery("SEL_PRE_CARD_NO") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		
		return ret;
	}	
	
	/**
	 * 무기명 카드 발급 등록 내역 조회.
	 *  
	 */
	public List searchMaster2(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		Util util = new Util();
		
		String strCardCreDt = String2.nvl(form.getParam("strCardCreDt"));
		String strCardSeq = String2.nvl(form.getParam("strCardSeq"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strCardCreDt);
		sql.setString(i++, strCardSeq);
		
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
        sql.put(strQuery);

		ret = select2List(sql);
		//ret = util.decryptedStr(ret,0);     //카드번호  복호화.
		return ret;
	}	
	
	/**
	 * 무기명 카드 발급 등록 매수 저장.
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int saveData(ActionForm form, GauceDataSet dSet, HttpServletRequest request) throws Exception {
		
		int 		ret = 0;
        SqlWrapper  sql = null;
        Service     svc = null;
        List getSeq = null;
        String strSeq = "";
        String strCard_no = "";
        String strSno = "";		//카드시작번호
        String strEno = "";		//카드종료번호
        Util util = new Util();
        try {

        	connect("pot");
    	    begin();
                    
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
			int res = 0;
			int i=1;
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");

            //SEQ  구하기
            sql.put(svc.getQuery("SEL_PRE_CARD_SEQ"));
            Map map = selectMap(sql);
            strSeq = (String)map.get("CSEQ");   
            sql.close();

            //DCS.DM_PRE_CARD_NO 입력.
            sql.put(svc.getQuery("INS_PRE_CARD_NO"));
            sql.setString(i++, dSet.getDataRow(0).getColumnValue(0).toString()); //P_CARD_CRE_DT
			sql.setString(i++, strSeq); //P_CARD_CRE_SEQ
			sql.setString(i++, dSet.getDataRow(0).getColumnValue(1).toString()); //P_CARD_GRADE
			sql.setInt(i++, Integer.parseInt(dSet.getDataRow(0).getColumnValue(2).toString())); //P_CARD_QTY
			sql.setString(i++, sessionInfo.getUSER_ID()); //P_USER_ID
			res = update(sql);
			
	        if ( res != 1 ) {
	        	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
	        
	        ret = 0;
			//입력후에 이상이 없으면.. 카드번호를 가져와서 암호화 한다.
	        for (int j = 0; j < Integer.parseInt(dSet.getDataRow(0).getColumnValue(2).toString()); j++) {
	        	sql.clearParameter();
				sql.close();

	            //카드번호  구하기
				sql.put(svc.getQuery("SEL_SQ_CARD"));
	            map.clear();
	            map = selectMap(sql);
	            
	            if(j==0){
	            	strSno = (String)map.get("CARD_NO");
	            }
	            if(j==Integer.parseInt(dSet.getDataRow(0).getColumnValue(2).toString())-1){
	            	strEno = (String)map.get("CARD_NO");
	            }
	            
	            strCard_no = (String)map.get("CARD_NO");
	            //strCard_no = strCard_no;
				sql.close();
				sql = new SqlWrapper();
	            //해당값을 저장하도록 한다.
	            //DCS.DM_PRE_CARD_NO 입력.
	            i=1;
				sql.put(svc.getQuery("INS_CARD"));
	            sql.setString(i++, strCard_no); //CARD_NO
				sql.setString(i++, dSet.getDataRow(0).getColumnValue(0).toString()); 	//P_CARD_CRE_SEQ
				sql.setString(i++, strSeq); 											//P_CARD_CRE_SEQ 
				sql.setString(i++, dSet.getDataRow(0).getColumnValue(1).toString());    //P_CARD_GRADE
				sql.setString(i++, sessionInfo.getUSER_ID()); //P_USER_ID
				sql.setString(i++, sessionInfo.getUSER_ID()); //P_USER_ID
				res = update(sql);
				ret++;
				
				if(j%1000 == 1000){
					end();
					connect("pot");
	        	    begin();
				}
			}
			
	        if ( res != 1 ) {
	        	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			sql.close();
			sql = new SqlWrapper();
            i=1;
            sql.setString(i++, strSno);
			sql.setString(i++, strEno); 	
			sql.setString(i++, dSet.getDataRow(0).getColumnValue(0).toString());  
			sql.setString(i++, strSeq); 	

			sql.put(svc.getQuery("UPD_PRE_CARD_NO"));
			res = update(sql);            	
			
			if ( res != 1 ) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
        return ret;
        
	}	

	
	public int delData(ActionForm form, GauceDataSet dSet, HttpServletRequest request) throws Exception {
		int ret = 0;
		int res = 0;
        SqlWrapper  sql = null;
        ProcedureWrapper psql = null;
        Service     svc = null;
        ProcedureResultSet prs = null;
        
        String strCardCreDt   	= String2.nvl(form.getParam("strCardCreDt"));
        String strCardSeq   	= String2.nvl(form.getParam("strCardSeq"));
        String strCardCnt  		=  String2.nvl(form.getParam("strCardCnt"));
        
        try {
        	connect("pot");
    	    begin();
            sql  = new   SqlWrapper();
            psql = new ProcedureWrapper();
			int i=1;
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
			psql.put("DCS.PR_DCTM101_DELETE", 6);
			
			psql.setString(i++, strCardCreDt);
			psql.setString(i++, strCardSeq);
			psql.setString(i++, strCardCnt);
			psql.setString(i++, sessionInfo.getUSER_ID());
			psql.registerOutParameter(i++, DataTypes.INTEGER);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
					
			prs = updateProcedure(psql);
			
			res = prs.getInt(5);
			
			return res;

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
	}		
	
}
