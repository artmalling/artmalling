/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.util.List;
import common.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif208DAO extends AbstractDAO {
	/**
	 * 반품 전표별 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strHStrCd   = String2.nvl(form.getParam("strHStrCd"));
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strRfdDtS   = String2.nvl(form.getParam("strRfdDtS"));
		String strRfdDtE   = String2.nvl(form.getParam("strRfdDtE"));
		String strStrConf  = String2.nvl(form.getParam("strStrConf"));
		String strHstrConf = String2.nvl(form.getParam("strHstrConf"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strHStrCd);
		sql.setString(i++, strRfdDtS);
		sql.setString(i++, strRfdDtE);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStrConf);
		sql.setString(i++, strHstrConf);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 반품 전표별 상세내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strRfdDt     = String2.nvl(form.getParam("strRfdDt"));
		String strRfdSlipNo = String2.nvl(form.getParam("strRfdSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strRfdDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strRfdSlipNo);

		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
		
	/**
     * 반품확정
     * @param  form
     * @param   
     * @return 
     */
    public int conf(ActionForm form, MultiInput mi, String userId) throws Exception {
    	
    	int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strRfdDt     = String2.nvl(form.getParam("strRfdDt"));
			String strStrCd     = String2.nvl(form.getParam("strStrCd"));
			String strRfdSlipNo = String2.nvl(form.getParam("strRfdSlipNo"));
			String strRfdDt_E 	= String2.nvl(form.getParam("strRfdDt_E"));
	
			int i = 1;
			sql.close();
			sql.put(svc.getQuery("COMF_REFUND")); 
			sql.setString(i++, strRfdDt_E);
			sql.setString(i++, userId);
			sql.setString(i++, strRfdDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strRfdSlipNo);			
			res = update(sql);
			
			confMst(form, mi, strRfdDt_E, userId);			
			
			ret += res;
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}	
		
    /**
	* 본사반품확정시 상품권마스터 상태반영
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int confMst(ActionForm form, MultiInput mi, String strRfdDt_E, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot"); 
			sql = new SqlWrapper();
			svc = (Service) form.getService();		
			
			while (mi.next()) {		
				int i=0;
			    sql.close();
			
			    sql.put(svc.getQuery("COMF_MSTSTAT"));  
				sql.setString(++i, strRfdDt_E);
				sql.setString(++i, userId);
				sql.setString(++i, mi.getString("GIFT_S_NO"));
			    sql.setString(++i, mi.getString("GIFT_E_NO"));				
			    res = update(sql);
 
			}
			ret += res;	
		} catch (Exception e) {
			rollback();
			throw e;
		} 
		return ret;		
	}	
}
	
	
