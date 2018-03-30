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
 * <p>경영실적2차배부처리</p>
 * 
 * @created on 1.0, 2011/06/17
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis068DAO extends AbstractDAO {

	/**
	 * 2차배부처리 대상조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizRslt(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStrCd   = null;
		String strRsltYm  = null;
		String strLstYm   = null;
		String strDivFlag = null;
		
		String strDeptCd = null;
		String strTeamCd = null;
		String strOrgFlag = null;

		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			strRsltYm  = String2.trimToEmpty(form.getParam("strRsltYm")); //경영실적년월
			strLstYm   = Util.addMonth(strRsltYm+"01", -1 , "yyyyMM");
			strDivFlag = String2.trimToEmpty(form.getParam("strDivFlag"));//배부구분
			
			strDeptCd   = String2.trimToEmpty(form.getParam("strDeptCd"));	//부문코드
			strTeamCd   = String2.trimToEmpty(form.getParam("strTeamCd"));	//팀코드
			strOrgFlag   = String2.trimToEmpty(form.getParam("strOrgFlag"));	//조직구분

			strLoc = "SEL_BIZ_RSLT_TOP";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strDivFlag);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strLstYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strRsltYm);
			
			sql.setString(i++, strOrgFlag);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			
			if("3".equals(strDivFlag)){
				sql.put(svc.getQuery("SEL_BIZ_RSLT_WHERE_PC"));
			} else {
				sql.put(svc.getQuery("SEL_BIZ_RSLT_WHERE_TEAM"));
			}
			
			sql.put(svc.getQuery("SEL_BIZ_RSLT_BOTTOM"));
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 2차 배부처리
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
					//2차 배부처리 내역 수정
					ret += updateBizRslt(svc, mi, strUserId);
					
					//배부기준에 의한 배부대상 데이터의 생성
					ret += mngBizRslt(svc, mi, strUserId);
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
	private int updateBizRslt(Service svc, MultiInput mi, String strUserId) throws Exception {
		int ret        = 0;
		int i          = 0;
		String strLoc  = "UPD_BIZ_RSLT";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, mi.getString("SD_DIV_CD"));
		sql.setString(++i, mi.getString("SD_DIV_BIZ_CD"));
		sql.setString(++i, mi.getString("RSLT_AMT"));
		sql.setString(++i, strUserId);
		sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
		sql.setString(++i, mi.getString("STR_CD"));
		sql.setString(++i, mi.getString("ORG_CD"));
		sql.setString(++i, mi.getString("BIZ_CD"));

		ret = this.update(sql);
		
		return ret;
	}
	
	/**
	 *  <p>2차 배부처리 내역 수정</p>
	 */
	private int mngBizRslt(Service svc, MultiInput mi, String strUserId) throws Exception {
		int ret        = 0;
		int i          = 0;
		double totAmt  = 0;
		double reAmt   = 0;
		double amt     = 0;
		List list      = null;
		Map map        = null;
		String strLoc  = "UST_BIZ_RSLT";
		SqlWrapper sql = new SqlWrapper();
		totAmt = mi.getDouble("RSLT_AMT");
		reAmt  = totAmt;
		//배부기준정보 가져오기
		sql.put(svc.getQuery("SEL_DIV_MST"));
		sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
		sql.setString(++i, mi.getString("STR_CD"));
		sql.setString(++i, mi.getString("SD_DIV_CD"));
		if("1".equals(mi.getString("DIV_FLAG"))){
			sql.setString(++i, "3");
		} else {
			//sql.put(svc.getQuery("SEL_DIV_MST_WHERE_CD"));
			sql.setString(++i, "4");
			//sql.setString(++i, mi.getString("ORG_CD").substring(2,4));
			//sql.setString(++i, mi.getString("ORG_CD").substring(4,6));
		}

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
			sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("SD_DIV_BIZ_CD"));
			sql.setString(++i, map.get("ORG_CD").toString());
			sql.setString(++i, map.get("ORG_FLAG").toString());
			sql.setString(++i, map.get("ORG_LEVEL").toString());
			sql.setDouble(++i, amt);
			sql.setString(++i, strUserId);
			
			ret += this.update(sql);
			sql.close();
			
			//배부이력저장
			i = 0;
			sql.put(svc.getQuery("INS_HISTORY"));
			
			sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
			sql.setString(++i, map.get("STR_CD").toString());
			sql.setString(++i, map.get("ORG_CD").toString());
			sql.setString(++i, mi.getString("SD_DIV_BIZ_CD"));
			sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
			sql.setString(++i, map.get("STR_CD").toString());
			sql.setString(++i, map.get("ORG_CD").toString());
			sql.setString(++i, mi.getString("SD_DIV_BIZ_CD"));			
			sql.setString(++i, mi.getString("SD_DIV_CD"));			
			sql.setInt(++i, Integer.parseInt(map.get("DIV_RATE").toString()));
			sql.setString(++i, map.get("ORG_LEVEL").toString());
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
