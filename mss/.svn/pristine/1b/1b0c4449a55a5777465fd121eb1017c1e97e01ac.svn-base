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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>월간접관리비 배부 </p>
 * 
 * @created  on 1.0, 2010.05.03
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen307DAO extends AbstractDAO {
	
	/**
    * <p>월간접비 관리비 마스터 조회</p>
    */
   public List getMntnItemMst(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strCalYm = String2.nvl(form.getParam("strCalYm"));	//월
		String strItemCd = String2.nvl(form.getParam("strItemCd"));	//배부기준항목
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_MR_DIVAMT") + "\n";
		sql.setString(i++, strCalYm);
		sql.setString(i++, strItemCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
		
   }
   
   /**
    * <p>월간접비 관리비 배부기준 DETAIL 조회</p>
    */
   public List getMntnItemDtl(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strCalYm = String2.nvl(form.getParam("strCalYm"));	//월
		String strItemCd = String2.nvl(form.getParam("strItemCd"));	//배부기준항목
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_MR_FCLDIVAMT") + "\n";
		sql.setString(i++, strCalYm);
		sql.setString(i++, strItemCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
		
   }
   
   /**
	 * 월간접비 관리비 배부기준 등록/수정/삭제
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi0, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			/**
			 * 배부항목 마스터 등록 
			 */
			while (mi0.next()) {
				i = 1;
				sql.close();
				
				//배부항목 마스터 등록
				if (mi0.IS_INSERT()) { 
					sql.close();
					
					sql.put(svc.getQuery("INS_MR_DIVAMT"));
					
					sql.setString(i++, mi0.getString("CAL_YM"));
					sql.setString(i++, mi0.getString("DIV_ITEM_CD"));
					sql.setString(i++, mi0.getString("MNTN_AMT"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
				//배부금액 수정	
				} else if (mi0.IS_UPDATE()) {
					sql.close();
					
					sql.put(svc.getQuery("UPD_MR_DIVAMT"));
					
					sql.setString(i++, mi0.getString("MNTN_AMT"));
					sql.setString(i++, userId);
					sql.setString(i++, mi0.getString("CAL_YM"));
					sql.setString(i++, mi0.getString("DIV_ITEM_CD"));
				}
				//금액 수정
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
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
	
	/**
	 * 배부 항목 삭제 
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form) throws Exception {
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			//시설별 배부기준 먼저 삭제
			i=1;
			sql.close();
			
			sql.put(svc.getQuery("DEL_MR_FCLDIVAMT_ALL"));
			sql.setString(i++, form.getParam("strCalYm"));				// 배부항목
			sql.setString(i++, form.getParam("strItemCd"));				// 배부항목
			res = update(sql);
			/*if (res == 0) {
				throw new Exception("[USER]"+"시설별 배부 기준 삭제시 오류가 발생 했습니다.");
			}*/
			
			//배부 기준 삭제 
			i=1;
			sql.close();
			sql.put(svc.getQuery("DEL_MR_DIVAMT"));
			sql.setString(i++, form.getParam("strCalYm"));				// 배부항목
			sql.setString(i++, form.getParam("strItemCd"));				// 배부항목
			
			res = update(sql);
			/*if (res == 0) {
				throw new Exception("[USER]"+"배부 기준 삭제시 오류가 발생 했습니다.");
			}
			*/
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
	
	/**
	 * 관리비 배부
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String getDivAmt(ActionForm form,String userId) throws Exception {
		String ret = "";
		ProcedureWrapper psql = null;
		int i = 1;
		connect("pot");
		psql = new ProcedureWrapper();
		ProcedureResultSet prs = null;

		psql.close();
		psql.put("MSS.PR_MSMNTNAUTODIV", 5);
		
		psql.setString(1, form.getParam("strCalYm"));
		psql.setString(2, form.getParam("strItemCd"));
		psql.setString(3, userId);
		psql.registerOutParameter(4, DataTypes.VARCHAR); // return value(에러
		psql.registerOutParameter(5, DataTypes.VARCHAR);

		prs = selectProcedure(psql);
		ret = prs.getString(5);
		return ret;
	}
}
