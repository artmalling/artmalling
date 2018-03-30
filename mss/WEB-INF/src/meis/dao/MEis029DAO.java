/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package meis.dao;

import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>경영계획1차배부처리</p>
 * 
 * @created on 1.0, 2011/05/31
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis029DAO extends AbstractDAO {

	/**
	 * 1차배부처리 대상조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizPlan(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strStrCd  = null;
		String strPlanYm = null;
		String strLstYm  = null;

		try {
			//파라미터 값 가져오기
			strStrCd  = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			strPlanYm = String2.trimToEmpty(form.getParam("strPlanYm")); //경영계획년월
			strLstYm  = Util.addMonth(strPlanYm+"01", -1 , "yyyyMM");
			
			strLoc = "SEL_BIZ_PLAN";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strPlanYm.substring(0, 4));
			sql.setString(i++, strStrCd);
			sql.setString(i++, strLstYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanYm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 1차 배부처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 0;
		Service svc    = null;
		SqlWrapper sql = null;
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			while(mi.next()){
				if("T".equals(mi.getString("CHECK_FLAG"))){
					//1차 배부처리 내역 수정
					ret += updateBizPlan(svc, mi, strUserId);
					
					//배부기준에 의한 배부대상 데이터의 생성
					ret += mngBizPlan(svc, mi, strUserId);			
				}
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
	 *  <p>배부기준에 의한 배부대상 데이터의 생성</p>
	 */
	private int updateBizPlan(Service svc, MultiInput mi, String strUserId) throws Exception {
		int ret        = 0;
		int i          = 0;
		String strLoc  = "UPD_BIZ_PLAN";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, mi.getString("PR_DIV_CD"));
		sql.setString(++i, mi.getString("PR_DIV_BIZ_CD"));
		sql.setDouble(++i, mi.getDouble("PLAN_AMT"));
		sql.setString(++i, strUserId);
		sql.setString(++i, mi.getString("BIZ_PLAN_YM"));
		sql.setString(++i, mi.getString("STR_CD"));
		sql.setString(++i, mi.getString("ORG_CD"));
		sql.setString(++i, mi.getString("BIZ_CD"));

		ret = this.update(sql);
		
		return ret;
	}
	
	/**
	 *  <p>1차 배부처리 내역 수정</p>
	 */
	private int mngBizPlan(Service svc, MultiInput mi, String strUserId) throws Exception {
		int ret        = 0;
		int i          = 0;
		double totAmt  = 0;
		double reAmt   = 0;
		double amt     = 0;
		List list      = null;
		Map map        = null;
		String strLoc  = "UST_BIZ_PLAN";
		SqlWrapper sql = new SqlWrapper();
		
		totAmt = mi.getDouble("PLAN_AMT");
		reAmt  = totAmt;
		//배부기준정보 가져오기
		sql.put(svc.getQuery("SEL_DIV_MST"));
		sql.setString(++i, mi.getString("BIZ_PLAN_YM"));
		sql.setString(++i, mi.getString("PR_DIV_CD"));

		list = this.select(sql);
		sql.close();
		if(list.size() == 0) throw new Exception("[USER]"+"배부할 하위 조직이 없습니다.");
		for(int y = 0 ; y < list.size() ; y++){
			map = (Map) list.get(y);
			if(y != list.size()-1){
				amt = Math.round(Integer.parseInt(map.get("DIV_RATE").toString()) * totAmt / 100);
				reAmt = reAmt - amt;
			} else {
				amt = reAmt;
			}
			
			i = 0;
			sql.put(svc.getQuery(strLoc));
			sql.setString(++i, mi.getString("BIZ_PLAN_YM"));
			sql.setString(++i, mi.getString("BIZ_PLAN_YM").substring(0, 4));
			sql.setString(++i, map.get("STR_CD").toString());
			sql.setString(++i, mi.getString("PR_DIV_BIZ_CD"));
			sql.setDouble(++i, amt);
			sql.setString(++i, strUserId);
			
			ret += this.update(sql);
			sql.close();
			
			//배부이력저장
			i = 0;
			sql.put(svc.getQuery("INS_HISTORY"));
			sql.setString(++i, mi.getString("BIZ_PLAN_YM"));
			sql.setString(++i, map.get("STR_CD").toString());
			sql.setString(++i, mi.getString("PR_DIV_BIZ_CD"));
			sql.setString(++i, mi.getString("BIZ_PLAN_YM"));
			sql.setString(++i, map.get("STR_CD").toString());
			sql.setString(++i, mi.getString("PR_DIV_BIZ_CD"));
			sql.setString(++i, mi.getString("PR_DIV_CD"));
			sql.setInt(++i, Integer.parseInt(map.get("DIV_RATE").toString()));
			sql.setDouble(++i, amt);			
			sql.setString(++i, mi.getString("STR_CD")); 
			sql.setString(++i, mi.getString("ORG_CD"));
			sql.setString(++i, mi.getString("BIZ_CD"));
			sql.setString(++i, strUserId);
			sql.setString(++i, strUserId);
			
			ret += this.update(sql);
			sql.close();
		}
		return ret;
	}
}
