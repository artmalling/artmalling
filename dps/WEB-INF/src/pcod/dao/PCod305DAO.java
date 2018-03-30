/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>협력사관리</p>
 * 
 * @created  on 1.0, 2010/02/11
 * @created  by 박종은(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod305DAO extends AbstractDAO {


	/**
	 * 마진 마스터을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strVenCd 		= String2.nvl(form.getParam("strVenCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strMgFlag 		= String2.nvl(form.getParam("strMgFlag"));
		String strRepVenCd 		= String2.nvl(form.getParam("strRepVenCd"));
		String strRepPumbunCd 	= String2.nvl(form.getParam("strRepPumbunCd"));
		String strVenName 		= URLDecoder.decode(String2.nvl(form.getParam("strVenName")), "UTF-8");
		String strPumbunName    = URLDecoder.decode(String2.nvl(form.getParam("strPumbunName")), "UTF-8");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMgFlag);
		sql.setString(i++, strRepVenCd);
		sql.setString(i++, strRepPumbunCd);
		sql.setString(i++, strPumbunName);
		sql.setString(i++, strVenName);

		strQuery = svc.getQuery("SEL_MARGINMST");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 정상마진정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret 	= null;
		Util util 	= new Util();
	
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;

		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));
		String strEventFlag = String2.nvl(form.getParam("strEventFlag"));
		String strMgFlag 	= String2.nvl(form.getParam("strMgFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strEventFlag);
		sql.setString(i++, strMgFlag);

		strQuery = svc.getQuery("SEL_NORMAL_MARGIN");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}

	/**
	 * 행사마진정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail2(ActionForm form) throws Exception {

		List ret 		= null;
		Util util 		= new Util();
	
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;

		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));
		String strEventFlag = String2.nvl(form.getParam("strEventFlag"));
		String strMgFlag 	= String2.nvl(form.getParam("strMgFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strEventFlag);
		sql.setString(i++, strMgFlag);
		
		strQuery = svc.getQuery("SEL_EVENT_MARGIN");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}

	/**
	 * 점별품번 최저마진율 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMargin(ActionForm form) throws Exception {

		List ret 	= null;
		Util util 	= new Util();
	
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;

		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);

		strQuery = svc.getQuery("SEL_LOW_MARGIN");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}

	/**
	 * 점별품번 행사구분의 중복 체크 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDBMargin(ActionForm form) throws Exception {

		List ret 	= null;
		Util util 	= new Util();
	
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;

		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));
		String strEventFlag 	= String2.nvl(form.getParam("strEventFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strEventFlag);

		strQuery = svc.getQuery("SEL_CHK_MARGIN");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 마진구분 정보를 조회 한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMgInfo(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strMgFlag = String2.nvl(form.getParam("strMgFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strMgFlag);

		strQuery = svc.getQuery("SEL_MG_INFO");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}
	
	public List searchPumbunCheck(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strPumbunCd);

		strQuery = svc.getQuery("SEL_PUMBUN_CHECK");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 마진마스터   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		Util util 		= new Util();
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String updAppSDt = "";

		
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd"));
		String strEventFlag = String2.nvl(form.getParam("strEventFlag"));
		String strMgFlag 	= String2.nvl(form.getParam("strMgFlag"));
		String strBigo 	    = URLDecoder.decode(String2.nvl(form.getParam("strBigo")), "UTF-8");  
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[0].IS_INSERT()) {
					sql.put(svc.getQuery("SEL_MARGINMST_APPSDATE"));
					
					sql.setString(1, strStrCd);	
					sql.setString(2, strPumbunCd);
					sql.setString(3, strEventFlag);					
					sql.setString(4, strMgFlag);
					sql.setString(5, mi[0].getString("APP_S_DT"));	

					Map map = selectMap( sql );
					updAppSDt = String2.nvl((String)map.get("APP_S_DT"));
					
					if( !updAppSDt.equals("")) {
						sql.close();
						sql.put(svc.getQuery("UPD_MARGINMST_APPEDATE"));
						
						sql.setString(1, mi[0].getString("APP_S_DT"));	
						sql.setString(2, strID);			
						sql.setString(3, strStrCd);					
						sql.setString(4, strPumbunCd);					
						sql.setString(5, strEventFlag);					
						sql.setString(6, strMgFlag);					
						sql.setString(7, updAppSDt);
						sql.setString(8, mi[0].getString("APP_S_DT"));	
						res = update(sql);
						
					}

					
					sql.close();
					sql.put(svc.getQuery("INS_MARGINMST"));
							
					sql.setString(1, strStrCd);
					sql.setString(2, strPumbunCd);					
					sql.setString(3, strEventFlag);
					sql.setString(4, mi[0].getString("EVENT_RATE"));		
					sql.setString(5, mi[0].getString("APP_S_DT"));		
					sql.setString(6, mi[0].getString("APP_E_DT"));		
					sql.setString(7, mi[0].getString("NORMAL_MG_RATE"));		
					sql.setString(8, strMgFlag);
					sql.setString(9, strID);
					sql.setString(10, strID);
					sql.setString(11, strBigo);
					
					res = update(sql);
					ret += res;

				} else if (mi[0].IS_UPDATE()) {
					
					/*
					sql.close();
                    sql.put(svc.getQuery("SEL_UPD_MARGINMST_APPSDATE"));
					
					sql.setString(1, strStrCd);	
					sql.setString(2, strPumbunCd);
					sql.setString(3, strEventFlag);					
					sql.setString(4, strMgFlag);
					sql.setString(5, mi[0].getString("APP_S_DT"));	

					Map map = selectMap( sql );
					updAppSDt = String2.nvl((String)map.get("APP_S_DT"));
					
					if( !updAppSDt.equals("")) {
						sql.close();
						sql.put(svc.getQuery("UPD_MARGINMST_APPEDATE"));
						
						sql.setString(1, mi[0].getString("APP_S_DT"));	
						sql.setString(2, strID);			
						sql.setString(3, strStrCd);					
						sql.setString(4, strPumbunCd);					
						sql.setString(5, strEventFlag);					
						sql.setString(6, strMgFlag);					
						sql.setString(7, updAppSDt);
						res = update(sql);
						
					}
					
					sql.close();
					sql.put(svc.getQuery("UPD_MARGINMST"));
					int m=1;
					sql.setString(m++, mi[0].getString("NORMAL_MG_RATE"));
					sql.setString(m++, mi[0].getString("APP_S_DT"));	
					sql.setString(m++, mi[0].getString("APP_E_DT"));	
					sql.setString(m++, strID);					
					sql.setString(m++, strStrCd);					
					sql.setString(m++, strPumbunCd);					
					sql.setString(m++, strEventFlag);					
					sql.setString(m++, strMgFlag);					
					//sql.setString(m++, mi[0].getString("APP_E_DT"));
					
					res = update(sql);
					ret += res;
					*/
										
					sql.close();
					sql.put(svc.getQuery("UPD_MARGINMST_NEW"));
					int m=1;
					sql.setString(m++, mi[0].getString("NORMAL_MG_RATE"));
					sql.setString(m++, mi[0].getString("APP_S_DT"));	
					sql.setString(m++, mi[0].getString("APP_E_DT"));	
					sql.setString(m++, strID);				
					sql.setString(m++, mi[0].getString("ORG_STR_CD"));
					sql.setString(m++, mi[0].getString("ORG_PUMBUN_CD"));
					sql.setString(m++, mi[0].getString("ORG_PUMMOK_CD"));
					sql.setString(m++, mi[0].getString("ORG_EVENT_FLAG"));
					sql.setString(m++, mi[0].getString("ORG_EVENT_RATE"));
					sql.setString(m++, mi[0].getString("ORG_EVENT_CD"));
					sql.setString(m++, mi[0].getString("ORG_APP_S_DT"));
					
					res = update(sql);
					ret += res;
										
				}

				if (res == 0) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
			}

			sql.close();
			sql.put(svc.getQuery("UPD_MARGINMST_BIGO"));
			
			sql.setString(1, strBigo);	
			sql.setString(2, strID);			
			sql.setString(3, strStrCd);					
			sql.setString(4, strPumbunCd);					
			sql.setString(5, strEventFlag);					
			sql.setString(6, strMgFlag);	
			res = update(sql);
			ret += 1;
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
}
