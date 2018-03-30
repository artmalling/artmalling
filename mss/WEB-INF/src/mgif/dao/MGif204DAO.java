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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
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

public class MGif204DAO extends AbstractDAO {
	/**
	 * 출고내역 조회
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
		
		String strOutStr = String2.nvl(form.getParam("strOutStr"));
		String strReqStr = String2.nvl(form.getParam("strReqStr"));
		String strOutDtS = String2.nvl(form.getParam("strOutDtS"));
		String strOutDtE = String2.nvl(form.getParam("strOutDtE"));
		String strInConf = String2.nvl(form.getParam("strInConf"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strOutStr);
		sql.setString(i++, strReqStr);
		sql.setString(i++, strOutDtS);
		sql.setString(i++, strOutDtE);
		sql.setString(i++, strInConf);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 출고세부내역 조회
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
		
		String strOutDt   = String2.nvl(form.getParam("strOutDt"));
		String strOutStr  = String2.nvl(form.getParam("strOutStr"));
		String strOutSlip = String2.nvl(form.getParam("strOutSlip"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strOutDt);
		sql.setString(i++, strOutStr);
		sql.setString(i++, strOutSlip);

		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}

	/**
	*  출고내역 삭제
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int delete(ActionForm form, MultiInput mi, MultiInput md, String userId) throws Exception {
		
		int ret = 0;
		int res = 0;
		int i = 0;
		int j = 0; 
		int k = 0;
		SqlWrapper sql = null;
		Service svc = null;

		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
        String strOutStr	= String2.nvl(form.getParam("strOutStr"));		// 출고점
        String strOutDt		= String2.nvl(form.getParam("strOutDt"));		// 출고일자
        
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (md.next()) {
				res = 0;
				sql.close();
				k=0;
				sql.put(svc.getQuery("UPD_GIFTMST")); 				
				sql.setString(++k, userId);	
				sql.setString(++k, md.getString("GIFT_S_NO"));
				sql.setString(++k, md.getString("GIFT_E_NO"));	 
				sql.setString(++k, strOutStr);
				sql.setString(++k, strOutDt);
				
				res += update(sql);
				
				sql.close();

				if (res < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 처리 하지 못했습니다.");
				}				
				ret += res;
			}
			
			while (mi.next()) {
				res = 0;
				sql.close();
				
				if (mi.IS_UPDATE()){
					i = 0;		
					sql.put(svc.getQuery("DEL_OUTREQCONF"));
					sql.setString(++i, mi.getString("OUT_DT"));
					sql.setString(++i, mi.getString("OUT_STR"));
					sql.setString(++i, mi.getString("OUT_SLIP_NO"));	
					res = update(sql);	
					sql.close();					
					j = 0;							
					sql.put(svc.getQuery("UPD_OUTREQ"));					
					sql.setString(++j, userId);	
					sql.setString(++j, mi.getString("REQ_DT"));
					sql.setString(++j, mi.getString("REQ_STR"));	
					sql.setString(++j, mi.getString("REQ_SLIP_NO"));		
				} 
				res += update(sql);

				if (res < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 처리 하지 못했습니다.");
				}				
				ret += res;
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	 
}
