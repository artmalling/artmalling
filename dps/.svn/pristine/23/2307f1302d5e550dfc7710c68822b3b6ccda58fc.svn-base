/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>인정LOSS율등록관리</p>
 * 
 * @created  on 1.0, 2010/04/04
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk202DAO extends AbstractDAO {


	/**
	 * 인정LOSS율을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYyyy    = String2.nvl(form.getParam("strStkYyyy"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strPumbunName = URLDecoder.decode(String2.nvl(form.getParam("strPumbunName")), "UTF-8");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYyyy);
		//sql.setString(i++, userId);
		
		strQuery = svc.getQuery("SEL_STKLOSS") + "\n";
		
		if( !strPumbunCd.equals("") || !strPumbunName.equals("")){
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strPumbunName);
			strQuery += svc.getQuery("SEL_STKLOSS_LIKE_PUMBUN") + "\n";
		}	

		strQuery += svc.getQuery("SEL_STKLOSS_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 재고평가구분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCostCalWay(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_STRPBN_COST_CAL_WAY") + "\n";
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 중복데이타를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOverLap(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYyyy    = String2.nvl(form.getParam("strStkYyyy"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkYyyy);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_STKLOSS_INS_CNT") + "\n";
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 복사시 체크한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCopyCheck(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYyyy    = String2.nvl(form.getParam("strStkYyyy"));
		

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkYyyy);
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkYyyy);
		
		
		strQuery = svc.getQuery("SEL_STKLOSS_COPY_CHECK") + "\n";
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 인정LOSS율을  복사한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int copy(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i;
		SqlWrapper sql = null;
		Service svc    = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrCd        = String2.nvl(form.getParam("strStrCd"));
			String strStkYyyy      = String2.nvl(form.getParam("strStkYyyy"));
			
			sql.close();
			sql.put(svc.getQuery("INS_STKLOSS_COPY"));  

			i = 1; 
			sql.setString(i++, strStkYyyy);       	     // 평가년월 
			sql.setString(i++, strID); 
			sql.setString(i++, strID); 
			sql.setString(i++, strStrCd);   	 		 // 점코드 
			sql.setString(i++, strStkYyyy);       	     // 평가년월 

			res = update(sql);

			if (res  < 0) {
				throw new Exception("" + "데이터의 적합성 문제로 인하여"
						+ "데이터 복사를 하지 못했습니다.");
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
	 * 인정LOSS율을  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;	
		String orgCdCnt = "";
		String strQuery = "";
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrCd        = String2.nvl(form.getParam("strStrCd"));

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {
					i = 0;
					
					sql.put(svc.getQuery("SEL_STKLOSS_INS_CNT"));							
					sql.setString(++i, strStrCd);
					sql.setString(++i, mi.getString("STK_YYYY"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();

					i = 0;	
					
					sql.put(svc.getQuery("INS_STKLOSS"));
					
					sql.setString(++i, strStrCd);
					sql.setString(++i, mi.getString("STK_YYYY"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));					
					sql.setString(++i, mi.getString("APP_LOSS_RATE"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				} else if (mi.IS_UPDATE()) {
					i = 0;					
					
					sql.put(svc.getQuery("UPD_STKLOSS"));	
										
					sql.setString(++i, mi.getString("APP_LOSS_RATE"));
					sql.setString(++i, strID);
					sql.setString(++i, strStrCd);					
					sql.setString(++i, mi.getString("STK_YYYY"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
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
	 *  <p>
	 *  인정LOSS율을 삭제한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String strStrCd = String2.nvl(form.getParam("strStrCd"));
			while (mi.next()) {
				res = 0;
				sql.close();
				if ( mi.IS_DELETE()){
					i = 0;	
					
					sql.put(svc.getQuery("DEL_STKLOSS"));
					sql.setString(++i, strStrCd);
					sql.setString(++i, mi.getString("STK_YYYY"));	
					sql.setString(++i, mi.getString("PUMBUN_CD"));				
					
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
}
