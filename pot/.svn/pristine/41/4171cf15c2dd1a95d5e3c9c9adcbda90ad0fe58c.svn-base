/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 즐겨찾기관리
 * </p>
 * 
 * @created on 1.0, 2010/06/09
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class TCom007DAO extends AbstractDAO {

	/**
	 * 즐겨찾기 추가
	 * 
	 * @param ActionForm
	 * @param MuliiInput
	 * @param HttpServletRequest
	 * @return void
	 * @throws Exception
	 */
	public void addFavorite(ActionForm form, String strUserId)
			throws Exception {
		Service svc    = null;
		SqlWrapper sql = null;
		String strPId  = null;
		int ret        = 0;
		Map map        = null;
		try {
			begin();
			connect("pot");
			svc      = (Service) form.getService();
			sql      = new SqlWrapper();
			strPId   = String2.trimToEmpty(form.getParam("programID"));
			//중복체크
			sql.put(svc.getQuery("SEL_FAVORITE"));		
			sql.setString(1, strPId);
			sql.setString(2, strUserId);
			
			map = this.selectMap(sql);
		       
			if (map.size() > 0){
				throw new Exception("[USER]" + "이미 등록 되었습니다");
			} 
			
			sql.close();
			
			//신규입력
			sql.put(svc.getQuery("INS_FAVORITE"));		
			sql.setString(1, strPId);
			sql.setString(2, strUserId);
			sql.setString(3, strUserId);
			
            ret = update(sql);
			
			if (ret !=1) {
				throw new Exception("[USER]" + "즐겨찾기 등록 실패");
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
	}
	
	/**
	 * 즐겨찾기 삭제
	 * 
	 * @param ActionForm
	 * @param MuliiInput
	 * @param HttpServletRequest
	 * @return void
	 * @throws Exception
	 */
	public void delFavorite(ActionForm form, String strUserId)
			throws Exception {
		Service svc    = null;
		SqlWrapper sql = null;
		String strPId  = null;
		int ret        = 0;
		try {
			begin();
			connect("pot");
			svc      = (Service) form.getService();
			sql      = new SqlWrapper();
			strPId   = String2.trimToEmpty(form.getParam("programID"));
			sql.put(svc.getQuery("DEL_FAVORITE"));		
			
			sql.setString(1, strPId);
			sql.setString(2, strUserId);
			
			ret = update(sql);
			
			if (ret !=1) {
				throw new Exception("[USER]" + "즐겨찾기 삭제 실패");
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
	}

}
