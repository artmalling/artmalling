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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>간접비 자동배부 기준</p>
 * 
 * @created  on 1.0, 2010.05.03
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen111DAO extends AbstractDAO {
	
	/**
    * <p>월간접비 자동배부기준 마스터 조회</p>
    */
   public List getAutoMst(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strAutoItemCd = String2.nvl(form.getParam("strAutoItemCd"));	//배부기준항목
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_MR_DIVMST") + "\n";
		sql.setString(i++, strAutoItemCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
		
   }
   
   /**
    * <p>월간접비 자동배부기준 DETAIL 조회</p>
    */
   public List getAutoDtl(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strAutoItemCd = String2.nvl(form.getParam("strAutoItemCd"));	//배부기준항목
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_MR_FCLDIVMST") + "\n";
		sql.setString(i++, strAutoItemCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
		
   }
   
   /**
    * <p>월간접비 자동배부 점 조회</p>
    */
   public List getAutoStrCd(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strAutoItemCd = String2.nvl(form.getParam("strAutoItemCd"));	//배부기준항목
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_AUTO_STR_CD") + "\n";
		sql.setString(i++, strAutoItemCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
		
   }
   
   /**
    * <p>자동배부항목 등록된 점별 관리비 항목 조회</p>
    */
   public List getAutoItemCd(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strCd = String2.nvl(form.getParam("strCd"));	//점코드
		String strAutoItemCd = String2.nvl(form.getParam("strAutoItemCd"));	//배부기준항목
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_AUTO_ITEM_CD") + "\n";
		sql.setString(i++, strCd);
		sql.setString(i++, strAutoItemCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
		
   }
   
   /**
	 * 열요금표 관리 등록/수정/삭제
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi0,MultiInput mi1, String userId)
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
					
					sql.put(svc.getQuery("INS_MR_DIVMST"));

					sql.setString(i++, mi0.getString("DIV_ITEM_CD"));
					sql.setString(i++, mi0.getString("DIV_RATE"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
				} else if (mi0.IS_UPDATE()) {
					
					sql.put(svc.getQuery("UPD_MR_DIVMST"));

					sql.setString(i++, mi0.getString("DIV_RATE"));
					sql.setString(i++, userId);
					sql.setString(i++, mi0.getString("DIV_ITEM_CD"));					
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
				} 
				ret += res;
			}
			
			/**
			 * 시설별 배부 항목 등록/삭제
			 */
			while (mi1.next()) {
				i = 1;
				sql.close();
				//  시설별 배부 항목 등록
				if (mi1.IS_INSERT()) {
					
					sql.put(svc.getQuery("INS_MR_FCLDIVMST"));
					
					sql.setString(i++, mi1.getString("DIV_ITEM_CD"));
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("DIV_RATE"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
				} else if (mi1.IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_MR_FCLDIVMST"));
					
					sql.setString(i++, mi1.getString("DIV_RATE"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("DIV_ITEM_CD"));
					sql.setString(i++, mi1.getString("STR_CD"));
					
				} else if(mi1.IS_DELETE()){
					sql.put(svc.getQuery("DEL_MR_FCLDIVMST"));
					
					sql.setString(i++, mi1.getString("DIV_ITEM_CD"));
					sql.setString(i++, mi1.getString("STR_CD"));
				} 
				
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
	 * 배부 항모 삭제 
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
			
			sql.put(svc.getQuery("DEL_MR_FCLDIVMST_ALL"));
			sql.setString(i++, form.getParam("strAutoItemCd"));				// 배부항목
			res = update(sql);
			/*if (res == 0) {
				throw new Exception("[USER]"+"시설별 배부 기준 삭제시 오류가 발생 했습니다.");
			}*/
			
			//배부 기준 삭제 
			i=1;
			sql.close();
			sql.put(svc.getQuery("DEL_MR_DIVMST"));
			sql.setString(i++, form.getParam("strAutoItemCd"));				// 배부항목
			
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
}
