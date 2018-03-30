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
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>행사 Best/Worst Matrix</p>
 * 
 * @created on 1.0, 2011/06/28
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis082DAO extends AbstractDAO {

	/**
	 * 점별 행사테마별 정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchThem(ActionForm form, String strUserId) throws Exception {

		List ret             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		String strLoc        = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleDt     = null;
		
		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			if("%".equals(strStrCd)){
				strStrCd = "";
			}
			strSaleDt  = String2.trimToEmpty(form.getParam("strSaleDt")); //일자

			strLoc = "SEL_THEM";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			
			connect("pot");
			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
	
	/**
	 * 점별 행사테마별 정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchEvent(ActionForm form, String strUserId) throws Exception {

		List ret             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		String strLoc        = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleDt     = null;
		String strThemCd     = null;
		
		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			strSaleDt  = String2.trimToEmpty(form.getParam("strSaleDt")); //일자
			strThemCd  = String2.trimToEmpty(form.getParam("strThemCd")); //테마코드

			strLoc = "SEL_EVENT";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strThemCd);
			
			connect("pot");
			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}

	/**
	 * 행사매출 달성/신장 현황
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchChartInfo(ActionForm form, String strUserId) throws Exception {

		List list            = null;
		Map  map             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		String strLoc        = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleDt     = null;
		String strStartDt    = null;
		String strSaleMon    = null;
		String strLstDt      = null;
		String strLstStartDt = null;
		String strRtn        = "";
		
		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			if("%".equals(strStrCd)){
				strStrCd = "";
			}
			strSaleDt  = String2.trimToEmpty(form.getParam("strSaleDt")); //일자

			strLoc = "SEL_THEM";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			
			connect("pot");
			list = select(sql);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}	
	
	/**
	 * 엑셀 정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getExcelData(ActionForm form, String strUserId) throws Exception {

		List ret             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		String strLoc        = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleDt     = null;
		
		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			if("%".equals(strStrCd)){
				strStrCd = "";
			}
			strSaleDt  = String2.trimToEmpty(form.getParam("strSaleDt")); //일자

			strLoc = "SEL_EXCEL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, "");
			
			connect("pot");
			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
}
