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

import javax.servlet.http.HttpServletRequest;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>타임아웃관리  </p>
 * 
 * @created  on 1.0, 2010/07/05
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCodB01DAO extends AbstractDAO {

	/**
	 * 마스터 을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi, HttpServletRequest request) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
	    
	    
		String  strSrchGubun        = String2.nvl(form.getParam("strSrchGubun"));
		String  strEmPostNoI  	    = URLDecoder.decode(String2.nvl(form.getParam("strEmPostNoI")), "UTF-8");              
		String  strEmAddrOld        = URLDecoder.decode(String2.nvl(form.getParam("strEmAddrOld")), "UTF-8");//시/도
		String  strEmRoadNMNew      = URLDecoder.decode(String2.nvl(form.getParam("strEmRoadNMNew")), "UTF-8");//시/군/구
		String  strLcSigunguNew     = URLDecoder.decode(String2.nvl(form.getParam("strLcSigunguNew")), "UTF-8");//구분
		String  strLcSidoNew  	    = URLDecoder.decode(String2.nvl(form.getParam("strLcSidoNew")), "UTF-8");  
		

		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		if(strSrchGubun.equals("N")){//지역명검색
			
				strQuery = svc.getQuery("SEL_ZIPCODE") + "\n";
				sql.setString(i++, strEmPostNoI); 
				sql.setString(i++, strEmAddrOld); 
				sql.setString(i++, strEmAddrOld); 
				sql.setString(i++, strEmAddrOld); 
			
		}else{//도로명 검색
			
				strQuery = svc.getQuery("SEL_ZIPCODE2") + "\n";
				sql.setString(i++, strEmPostNoI); 
				sql.setString(i++, strEmRoadNMNew); 
				sql.setString(i++, strLcSidoNew); 
				sql.setString(i++, strLcSigunguNew); 
				
			
		}
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}

	/**
	 * 타임아웃
	 * 저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {
		
		String  strSrchGubun        = String2.nvl(form.getParam("strSrchGubun"));
		String strSeqNo   = "";		// 순번
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		int i=0;
		try {
			connect("pot");
			begin();
			String flag = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					 
					if(strSrchGubun.equals("N")){
						i = 0;
						sql.put(svc.getQuery("POST_SEQ"));
						
						Map mapSeqNo = (Map)selectMap(sql);
						strSeqNo= mapSeqNo.get("POST_SEQ").toString();
						
						mi.setString("POST_SEQ", strSeqNo);
						
						sql.close();
						
						sql.put(svc.getQuery("ZIPCODE_INSERT"));
						
						sql.setString(++i,  mi.getString("POST_SEQ"));										
						sql.setString(++i,  mi.getString("POST_NO"));
						sql.setString(++i,  mi.getString("SI_DO"));										
						sql.setString(++i,  mi.getString("SI_GUN_GU"));
						sql.setString(++i,  mi.getString("EUP_DONG"));										
						sql.setString(++i,  mi.getString("LI"));
						sql.setString(++i,  mi.getString("ISLAND"));										
						sql.setString(++i,  mi.getString("DESTINATION"));
						sql.setString(++i,  mi.getString("TYPE_NM"));										
						sql.setString(++i,  mi.getString("STR_ADDR1"));
						sql.setString(++i,  mi.getString("STR_ADDR2"));										
						sql.setString(++i,  mi.getString("END_ADDR1"));
						sql.setString(++i,  mi.getString("END_ADDR2"));										
						sql.setString(++i,  mi.getString("FULL_ADDR"));
						sql.setString(++i,  mi.getString("ADDR1"));										
						sql.setString(++i,  mi.getString("ADDR2"));
						
						
										
					}else{
						i=0;
						
						sql.put(svc.getQuery("POST_SEQ2"));
						
						Map mapSeqNo = (Map)selectMap(sql);
						strSeqNo= mapSeqNo.get("POST_SEQ").toString();
						mi.setString("POST_SEQ", strSeqNo);
						sql.close();
						
						sql.put(svc.getQuery("ZIPCODE_INSERT2"));
					
						sql.setString(++i,  mi.getString("POST_SEQ"));										
						sql.setString(++i,  mi.getString("POST_NO"));
						sql.setString(++i,  mi.getString("SI_DO"));										
						sql.setString(++i,  mi.getString("SI_GUN_GU"));
						sql.setString(++i,  mi.getString("EUP_DONG"));		
						sql.setString(++i,  mi.getString("ROAD_NM"));
						sql.setString(++i,  mi.getString("FULL_ADDR"));	
						sql.setString(++i,  mi.getString("ADDR1"));
						sql.setString(++i,  mi.getString("ADDR2"));
						
					}
					
				} else if(mi.IS_UPDATE()){// 수정 
					
					if(strSrchGubun.equals("N")){
						sql.put(svc.getQuery("ZIPCODE_UPDATE"));
						i = 0;
						
						sql.setString(++i,  mi.getString("SI_DO"));										
						sql.setString(++i,  mi.getString("SI_GUN_GU"));
						sql.setString(++i,  mi.getString("EUP_DONG"));										
						sql.setString(++i,  mi.getString("LI"));
						sql.setString(++i,  mi.getString("ISLAND"));										
						sql.setString(++i,  mi.getString("DESTINATION"));
						sql.setString(++i,  mi.getString("TYPE_NM"));										
						sql.setString(++i,  mi.getString("STR_ADDR1"));
						sql.setString(++i,  mi.getString("STR_ADDR2"));										
						sql.setString(++i,  mi.getString("END_ADDR1"));
						sql.setString(++i,  mi.getString("END_ADDR2"));										
						sql.setString(++i,  mi.getString("FULL_ADDR"));
						sql.setString(++i,  mi.getString("ADDR1"));										
						sql.setString(++i,  mi.getString("ADDR2"));
						
						sql.setString(++i,  mi.getString("POST_SEQ"));										
						sql.setString(++i,  mi.getString("POST_NO"));
						
					}else{
						
						sql.put(svc.getQuery("ZIPCODE_UPDATE2"));
						
						i = 0;
						sql.setString(++i,  mi.getString("SI_DO"));										
						sql.setString(++i,  mi.getString("SI_GUN_GU"));
						sql.setString(++i,  mi.getString("EUP_DONG"));		
						sql.setString(++i,  mi.getString("ROAD_NM"));
						sql.setString(++i,  mi.getString("FULL_ADDR"));	
						sql.setString(++i,  mi.getString("ADDR1"));
						sql.setString(++i,  mi.getString("ADDR2"));
						
						sql.setString(++i,  mi.getString("POST_SEQ"));										
						sql.setString(++i,  mi.getString("POST_NO"));
						
					}
				}else if (mi.IS_DELETE()) { // 삭제 
					
					if(strSrchGubun.equals("N")){
						i = 0;
						sql.put(svc.getQuery("ZIPCODE_DELETE"));
						
						sql.setString(++i,  mi.getString("POST_SEQ"));										
						sql.setString(++i,  mi.getString("POST_NO"));
						
					}else{
						i = 0;
						sql.put(svc.getQuery("ZIPCODE_DELETE2"));
						
						sql.setString(++i,  mi.getString("POST_SEQ"));										
						sql.setString(++i,  mi.getString("POST_NO"));
					}
				}
				
				res = update(sql);

				
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
