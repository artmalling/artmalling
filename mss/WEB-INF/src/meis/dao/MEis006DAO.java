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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>경영실적 배부기준항목 관리</p>
 * 
 * @created on 1.0, 2011/08/08
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis006DAO extends AbstractDAO {

	/**
	 * 배부기준항목 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List search(ActionForm form) throws Exception {

		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strDivCd = null;
		String strDivNm = null;

		try {
			//파라미터 값 가져오기
			strDivCd = String2.trimToEmpty(form.getParam("strDivCd")); 
			strDivNm = String2.trimToEmpty(form.getParam("strDivNm"));

			strLoc = "SEL_DIV";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			if (!"".equals(strDivCd)){
				sql.put(svc.getQuery("SEL_DIV_WHERE_CD"));
				sql.setString(i++, strDivCd);
			}
			
			if (!"".equals(strDivNm)){
				sql.put(svc.getQuery("SEL_DIV_WHERE_NM"));
				sql.setString(i++, strDivNm);
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
	
	/**
	 * 배부기준항목 등록/수정
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret         = 0;
		int i           = 1;
		Service svc     = null;
		SqlWrapper sql  = null;
		String strUseYn = null;
		Map map         = null;
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			while(mi.next()){
				i = 1;
				if("T".equals(mi.getString("USE_YN"))) strUseYn = "Y";
				else strUseYn = "N";
				
				if(mi.IS_INSERT()){
					sql.put(svc.getQuery("INS_DIV")); 
					sql.setString(i++, mi.getString("DIV_CD_NM"));
					sql.setString(i++, mi.getString("SORT_NO"));
					sql.setString(i++, strUseYn);
					sql.setString(i++, strUserId);
					sql.setString(i++, strUserId);
				} else if(mi.IS_UPDATE()){
					sql.put(svc.getQuery("UPD_DIV")); 
					sql.setString(i++, mi.getString("DIV_CD_NM"));
					sql.setString(i++, mi.getString("SORT_NO"));
					sql.setString(i++, strUseYn);
					sql.setString(i++, strUserId);
					sql.setString(i++, mi.getString("DIV_CD"));
				} else{
					//배부기준마스터에 사용여부 체크
					sql.put(svc.getQuery("SEL_DIV_CD")); 
					sql.setString(1, mi.getString("DIV_CD"));
					map = this.selectMap(sql);
					sql.close();
					if(map.size() > 0)
						throw new Exception("[USER]"+"배부기준에서 사용되기 때문에 삭제할수 없습니다.");					
					
					sql.put(svc.getQuery("DEL_DIV")); 
					sql.setString(i++, mi.getString("DIV_CD"));
				}
				ret += this.update(sql);
				sql.close();
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
