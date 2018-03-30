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
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 월관리비등록
 * </p>
 * 
 * @created on 1.0, 2010.04.26
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MRen302DAO extends AbstractDAO {

	/**
	 * <p>
	 * 월관리비조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// 시설구분
			String strCalYM 	= String2.nvl(form.getParam("strCalYM"));	// 부과년월
			String strMntnitem 	= String2.nvl(form.getParam("strMntnitem"));// 관리비항목
			int i = 0;

			sql.put(svc.getQuery("SEL_MR_ITEMAMT"));
			sql.setString(++i, strMntnitem);
			sql.setString(++i, strStrCd);
			sql.setString(++i, strCalYM);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}


	/**
	 * <p>
	 * 월관리비 저장
	 * </p>
	 */
	public int save(ActionForm form, MultiInput mi, String userID)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String orgCdCnt = "";

		try {
			connect("pot");
			begin(); // DB트렌젝션 시작
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {
				sql.close();
				if (mi.IS_INSERT()) {
					int i = 0;
					sql.put(svc.getQuery("SEL_MR_ITEMAMT_COUNT"));							
					sql.setString(++i, mi.getString("CAL_YM"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
					
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();
					
					sql.put(svc.getQuery("INS_MR_ITEMAMT"));
					i = 0;
					
		            sql.setString(++i, mi.getString("CAL_YM"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
					sql.setInt(++i, mi.getInt("MNTN_AMT"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, userID);
					sql.setString(++i, userID);
				} else if(mi.IS_UPDATE()){
					sql.put(svc.getQuery("UPD_MR_ITEMAMT"));
					int i = 0;
					
					sql.setInt(++i, mi.getInt("MNTN_AMT"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, userID);
					sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("CAL_YM"));
				}
				res = update(sql);
				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
	 * <p>
	 * 월관리비 저장
	 * </p>
	 */
	public int delete(ActionForm form, MultiInput mi)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String orgCdCnt = "";
		
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				res = 0;
				sql.close();
				if ( mi.IS_DELETE()){
					int i = 0;	
					
					sql.put(svc.getQuery("DEL_MR_ITEMAMT"));
					sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("CAL_YM"));									
					
					res = update(sql);	
				} 

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
	
	/**
	 * <p>
	 * 관리비 항목코드 조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMntnitem(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		connect("pot");
		svc = (Service) form.getService();
		sql = new SqlWrapper();
		String strStrCd = String2.nvl(form.getParam("strStrCd")); // 시설구분
		String strAllGb = String2.nvl(form.getParam("strAllGb")); // 전체사용구분
		if (strAllGb.equals("Y")) { //전체포함
			sql.put(svc.getQuery("SEL_MR_MNTNITEM_ALL"));
		} else {
			sql.put(svc.getQuery("SEL_MR_MNTNITEM"));
		}
		sql.setString(1, strStrCd);
		list = select2List(sql);
		return list;
	}
	
	/**
	 * <p>
	 * 관리비 마감체크
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getCloseYN(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		connect("pot");
		svc = (Service) form.getService();
		sql = new SqlWrapper();
	    
		String strStrCd = String2.nvl(form.getParam("strStrCd")); 	// 시설구분
		String strCalYM = String2.nvl(form.getParam("strCalYM")); 	// 부과년월
		String strTemp = String2.nvl(form.getParam("strTemp"));		// 임시
		
		sql.put(svc.getQuery("SEL_CLOSE_YN"));
		sql.setString(1, strTemp);
		list = select2List(sql);
		return list;
	}
}
