/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;
import java.util.Map;

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

public class MCae603DAO extends AbstractDAO {
	/**
	 * 협력사별 정산확정 MASTER 조회
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
		 
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strSdt		= String2.nvl(form.getParam("strSdt"));   
		String strEdt		= String2.nvl(form.getParam("strEdt"));
		String strEventCd	= String2.nvl(form.getParam("strEventCd"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strSdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEventCd);
		sql.put(strQuery);

		ret = select2List(sql);
 
		return ret;
	} 
	
	/**
	 * 협력사별 정산확정 카드별 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCardDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strEventCd	= String2.nvl(form.getParam("strEventCd"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		
		strQuery = svc.getQuery("SEL_CARD_DETAIL") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		sql.put(strQuery);

		ret = select2List(sql);
 
		return ret;
	} 
	
	/**
	 * 협력사별 정산확정 물품 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMulDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strEventCd	= String2.nvl(form.getParam("strEventCd"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");  
		
		strQuery = svc.getQuery("SEL_MUL_DETAIL") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		sql.put(strQuery);

		ret = select2List(sql);
 
		return ret;
	} 
	
	/**
	 * 협력사별 정산 확정 한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		ProcedureWrapper psql = null;
		ProcedureResultSet prs = null;
		Service svc = null;
		String strCnt = "";
		String strGiftAmtType = "";
		try { 
			connect("pot");
			begin();
			sql = new SqlWrapper();
			psql = new ProcedureWrapper();
			svc = (Service) form.getService();
			
			//카드 확정
			while(mi[0].next()){
				sql.close();
				i = 1;
				
			    if(mi[0].IS_UPDATE()){
					sql.put(svc.getQuery("UPD_MC_EVTSKUCAL"));
					sql.setString(i++, userId); 					
					sql.setString(i++, mi[0].getString("STR_CD"));				 
					sql.setString(i++, mi[0].getString("EVENT_CD")); 						
					sql.setString(i++, mi[0].getString("VEN_CD"));				 	
					res = update(sql);
				}
				
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				ret += res;
				
			}
			// 물품 확정
			while (mi[1].next()) {
				sql.close();
				i = 1;
				
			    if(mi[1].IS_UPDATE()){
					// 사은품 지급 등록
			    	sql.put(svc.getQuery("UPD_MC_EVTSKUCAL"));
					sql.setString(i++, userId); 					
					sql.setString(i++, mi[1].getString("STR_CD"));				 
					sql.setString(i++, mi[1].getString("EVENT_CD")); 						
					sql.setString(i++, mi[1].getString("VEN_CD"));				 	
					res = update(sql);
				}
				
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
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

}
