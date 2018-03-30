/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

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
 * <p>주거세대월관리비정산</p>
 * 
 * @created  on 1.0, 2010.06.07
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen604DAO extends AbstractDAO {

	  /**
	    * <p>주거세대 월관리비정산</p>
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
	           String strStrCd		= String2.nvl(form.getParam("strStrCd"));	// [조회용]시설구분(점코드)
	           String strDong		= String2.nvl(form.getParam("strDong"));	// [조회용]동
	           String strHo			= String2.nvl(form.getParam("strHo"));		// [조회용]호
	           String strCalYM		= String2.nvl(form.getParam("strCalYM"));	// [조회용]부과년월
	           
	           sql.put(svc.getQuery("SEL_MASTER"));
	           sql.setString(++i, strHo);
	           sql.setString(++i, strDong);
	           sql.setString(++i, strCalYM);
	           sql.setString(++i, strStrCd);
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
	    * <p>주거세대 월관리비정산-Detail</p>
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
	           String strCalYM		= String2.nvl(form.getParam("strCalYM"));	// 전출일
	           String strCntrId		= String2.nvl(form.getParam("strCntrId"));	// 계약ID   
	           
	           sql.put(svc.getQuery("SEL_DETAIL"));
	           sql.setString(++i, strCalYM);
	           sql.setString(++i, strCntrId); 
 
	           list = select2List(sql); 
	       } catch (Exception e) {
	           throw e;
	       }
	       return list;
	   }
	    
	   
	   /**
		*  주거세대 월관리비정산
		* 
		* @param form
		* @param mi
		* @param strID
		* @return
		* @throws Exception
		*/
	   public List procCalculate(ActionForm form, MultiInput mi, String userId, HttpServletRequest request) throws Exception {
	        ProcedureWrapper psql = null; 
	        ProcedureResultSet prs = null; 
	        List list 				= null;
	        String strStrCd	= String2.nvl(form.getParam("strStrCd"));
	        String strCalYM	= String2.nvl(form.getParam("strCalYM"));
			
			try {
				connect("pot");
				begin();
	            psql = new ProcedureWrapper();
				int i=1;
				HttpSession session = request.getSession();
	            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
				
	            // 월관리비정산 처리
				i=1;
				psql.put("MSS.PR_MRCALMNTN_HOUSE", 5);
				psql.setString(i++, strStrCd);
				psql.setString(i++, strCalYM); 
				psql.setString(i++, sessionInfo.getUSER_ID());
				psql.registerOutParameter(i++, DataTypes.VARCHAR);
				psql.registerOutParameter(i++, DataTypes.VARCHAR);
				prs = updateProcedure(psql);
				
				//재조회
				list = getMaster(form);
 
			} catch (Exception e) { 
				rollback();
				throw e;
			} finally {
				end();
			}
			return list;		
		}
	    
	}
