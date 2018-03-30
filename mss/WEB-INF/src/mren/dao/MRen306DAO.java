/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.util.Util;
import common.vo.SessionInfo;

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
 * <p>주거세대전출정산</p>
 * 
 * @created  on 1.0, 2010.05.03
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen306DAO extends AbstractDAO {

	  /**
	    * <p>주거세대 전출정산</p>
	    */
	   @SuppressWarnings("rawtypes")
	   public List getMaster(ActionForm form) throws Exception {

		   List       list = null;
	       SqlWrapper  sql = null;
	       Service     svc = null;
	       
	       Util util = new Util();
	       try {
	           connect("pot");
	           svc  = (Service)form.getService();
	           sql  = new SqlWrapper();
	           int i = 0;
	           //parameters
	           String strFclCd		= String2.nvl(form.getParam("strFclCd"));	// [조회용]시설구분(점코드)
	           String strDong		= String2.nvl(form.getParam("strDong"));	// [조회용]동
	           String strHo			= String2.nvl(form.getParam("strHo"));		// [조회용]호
	           String strHname		= URLDecoder.decode(String2.nvl(form.getParam("strHname")), "UTF-8"); // [조회용]세대주명
	           String strSel		= String2.nvl(form.getParam("strSel"));		// [조회용]조회기간구분
	           String strStart		= String2.nvl(form.getParam("strStart"));	// [조회용]기간S
	           String strEnd		= String2.nvl(form.getParam("strEnd"));		// [조회용]기간E  
	           
	           sql.put(svc.getQuery("SEL_MASTER"));
	           sql.setString(++i, strFclCd);
	           sql.setString(++i, strDong);
	           sql.setString(++i, strHo);
	           sql.setString(++i, strHname);

	           // 1:전입일, 2:전출일
	           if (strSel.equals("1")) {
	        	   sql.put(svc.getQuery("SEL_IN_DT"));
	        	   sql.setString(++i, strStart);
	        	   sql.setString(++i, strEnd);
	           } else if (strSel.equals("2")) {
	        	   sql.put(svc.getQuery("SEL_OUT_DT"));
	        	   sql.setString(++i, strStart);
	        	   sql.setString(++i, strEnd);
	           } 
 
	           sql.put(svc.getQuery("SEL_ORDER_BY"));
	           list = select2List(sql);
	           //복호화
	           //list = util.decryptedStr(list,5);	// 전화번호1
	           //list = util.decryptedStr(list,6);	// 전화번호2
	           //list = util.decryptedStr(list,7);	// 전화번호3 
	       } catch (Exception e) {
	           throw e;
	       }
	       return list;
	   }
	   
	   /**
	    * <p>주거세대 전출정산-Detail</p>
	    */
	   @SuppressWarnings("rawtypes")
	   public List getDetail(ActionForm form) throws Exception {

		   List       list = null;
	       SqlWrapper  sql = null;
	       Service     svc = null;
	       
	       try {
	           connect("pot");
	           svc  = (Service)form.getService();
	           sql  = new SqlWrapper();
	           int i = 0;
	           //parameters
	           String strOutDt		= String2.nvl(form.getParam("strOutDt"));	// 전출일
	           String strCntrId		= String2.nvl(form.getParam("strCntrId"));	// 계약ID   
	           
	           sql.put(svc.getQuery("SEL_DETAIL"));
	           sql.setString(++i, strOutDt);
	           sql.setString(++i, strCntrId); 
 
	           list = select2List(sql); 
	       } catch (Exception e) {
	           throw e;
	       }
	       return list;
	   }
	    
	   
	   /**
		*  주거세대 전출정산
		* 
		* @param form
		* @param mi
		* @param strID
		* @return
		* @throws Exception
		*/
	   public int procCalculate(ActionForm form, MultiInput mi, String userId, HttpServletRequest request) throws Exception {
			
			int res = 0;
			SqlWrapper sql = null;
			Service svc = null;
	        ProcedureWrapper psql = null; 
	        ProcedureResultSet prs = null; 
	        
	        String strStrCd   	= String2.nvl(form.getParam("strStrCd"));
	        String strHholdId	= String2.nvl(form.getParam("strHholdId"));
	        String strILJA   	= String2.nvl(form.getParam("strILJA"));  
			
			try {
				connect("pot");
				begin();
				sql  = new   SqlWrapper();
	            psql = new ProcedureWrapper();
	            svc  = (Service)form.getService();
				int i=1;
				HttpSession session = request.getSession();
	            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
	            
	            while (mi.next()) {
	            	// 전출일 등록
	            	sql.close();
		            sql.put(svc.getQuery("UPD_MRCALMOVEOUT"));  
					sql.setString(i++, strILJA);
					sql.setString(i++, strHholdId); 
					res = update(sql);	
					if (res != 1) {
						throw new Exception("" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
	            }
				
	            // 전출정산 처리
				i=1;
				psql.put("MSS.PR_MRCALMOVEOUT", 5);
				psql.setString(i++, strStrCd);
				psql.setString(i++, strHholdId); 
				psql.setString(i++, sessionInfo.getUSER_ID());
				psql.registerOutParameter(i++, DataTypes.VARCHAR);
				psql.registerOutParameter(i++, DataTypes.VARCHAR);
				updateProcedure(psql);
 
			} catch (Exception e) { 
				rollback();
				throw e;
			} finally {
				end();
			}
			return res;		
		}
	    
	}
