/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.List;
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>점별행사단품관리</p>
 * 
 * @created  on 1.0, 2010/04/28
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod710DAO extends AbstractDAO {

	/**
	 * 행사를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchEvtmst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strEventCd    = String2.nvl(form.getParam("strEventCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_EVTMST") + "\n";	
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 점별행사단품을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String strID, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strEventCd     = String2.nvl(form.getParam("strEventCd"));
		String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));


		connect("pot");
		
		strQuery = svc.getQuery("SEL_STREVTSKU")+ "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		
		if(("").equals(strPumbunCd)){
			sql.setString(i++, "%");
		} else {
			sql.setString(i++, strPumbunCd);
		}
		
		sql.setString(i++, strID);
		sql.setString(i++, orgFlag);

		strQuery += svc.getQuery("SEL_STREVTSKU_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}	
 
	/**
	 * 점별행사단품, 점별단품가격마스터
	 * 저장, 수정, 삭제  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		int i;
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strEventCd    = String2.nvl(form.getParam("strEventCd"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strEventSDt   = String2.nvl(form.getParam("strEventSDt"));
		String strEventEDt   = String2.nvl(form.getParam("strEventEDt"));
		
		String eventSDt      = "";
		String pumbunCd     = "";
		try {
			connect("pot");
			begin();
			String flag;
			sql = new SqlWrapper();
			svc = (Service) form.getService();
 
			// 점별행사단품, 점별단품가격마스터 
			while (mi[1].next()) {
				sql.close();
				if ( mi[1].IS_UPDATE()) {	
					flag = "U";
					i = 1;
					sql.put(svc.getQuery("SEL_STRSKUPRCMST_DUP_CNT"));				
					sql.setString(i++, mi[1].getString("STR_CD"));
					sql.setString(i++, mi[1].getString("SKU_CD"));
					sql.setString(i++, mi[1].getString("APP_S_DT"));
					sql.setString(i++, mi[1].getString("APP_E_DT"));	
					map = selectMap( sql );		
					String regCnt = String2.nvl((String)map.get("CNT"));
					if( !regCnt.equals("1")) {
						throw new Exception("[USER]"+" [ "+ mi[1].getString("SKU_CD") + " ]의 중복되는 기간이 존재합니다.");
					}

					sql.close();
					i = 1;			
					sql.put(svc.getQuery("UPD_STRSKUPRCMST"));
                    sql.setString(i++, mi[1].getString("APP_E_DT"));

                    sql.setString(i++, strID);
					sql.setString(i++, mi[1].getString("STR_CD"));
                    sql.setString(i++, mi[1].getString("SKU_CD"));
                    sql.setString(i++, mi[1].getString("EVENT_CD"));
                    sql.setString(i++, mi[1].getString("APP_S_DT"));
                    // 점별행사단품 수정
    				res = update(sql);
    				
					sql.close();
					i = 1;			
					sql.put(svc.getQuery("UPD_STRSKUEVTPRC"));	
                    sql.setString(i++, mi[1].getString("APP_E_DT"));

                    sql.setString(i++, strID);
					sql.setString(i++, mi[1].getString("STR_CD"));
                    sql.setString(i++, mi[1].getString("SKU_CD"));
                    sql.setString(i++, mi[1].getString("EVENT_CD"));
                    sql.setString(i++, mi[1].getString("APP_S_DT"));
                    // 점별행사단품 수정
    				res = update(sql);				
    				
    				

				} else {
					continue;	
				}

				if (res != 1) {
					String msg = "데이터 입력을 하지 못했습니다.";
					if( flag.equals("D")){
						msg = "데이터 삭제을 하지 못했습니다.";
					}
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ msg );
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
