/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import common.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.CaseInsensitiveHashMap;
import kr.fujitsu.ffw.util.String2;
import kr.fujitsu.ffw.base.BaseProperty;

/**
 * <p>
 * 공통 코드 입력/수정/삭제/조회한다
 * </p>
 * 
 * @created on 1.0, 2010.01.05
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class TCom101DAO extends AbstractDAO {

	/**
	 * 공통코드 마스터 부분을 조회한다.
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
		String strTmpCd = URLDecoder.decode(String2.nvl(form.getParam("strTmpCd")), "UTF-8");
		
		String strSysCd = String2.nvl(form.getParam("strSysCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strTmpCd);
		sql.setString(i++, strTmpCd);
		sql.setString(i++, strSysCd);

		strQuery = svc.getQuery("SEL_MASTER") + "\n"; //

		sql.put(strQuery);

		ret = select2List(sql);

		return ret; 
	}

	/**
	 * 공통코드 디테일 부분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strCommPart = String2.nvl(form.getParam("strCommPart"));
		String strSysCd = String2.nvl(form.getParam("strSysCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strCommPart);
		sql.setString(i++, strSysCd);

		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);


		ret = select2List(sql);
 
		return ret;
	}


	/**
	 * 공통코드 저장, 수정, 삭제 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		int mstCnt 	= 0;	
		
		String errMsg 	= null;
		int 	ret 	= 0;
		int 	ret1 	= 0;
		int 	ret2 	= 0;	

		int i;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String delCnt = "0";
			while (mi[0].next()) { 

				sql.close();		
				if (mi[0].IS_INSERT()) {  
					i = 0;						
					sql.put(svc.getQuery("SEL_MASTER_CNT"));		
	
					sql.setString(++i, mi[0].getString("SYS_PART")); 
					sql.setString(++i, mi[0].getString("COMM_CODE")); 
					
					Map map = selectMap( sql );	
					
					String cnt = String2.nvl((String)map.get("CNT"));
	
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중복 데이터 입니다.");
					}
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("INS_MASTER"));
					
					sql.setString(++i, mi[0].getString("SYS_PART")); 
					sql.setString(++i, mi[0].getString("COMM_CODE")); 
					sql.setString(++i, mi[0].getString("COMM_NAME1")); 
					sql.setString(++i, strID);
					sql.setString(++i, strID); 
				} 
	
				else if (mi[0].IS_UPDATE()) {
					i = 0;
					sql.put(svc.getQuery("UPT_MASTER"));
					
					sql.setString(++i, mi[0].getString("COMM_NAME1")); 
					sql.setString(++i, strID); 
					sql.setString(++i, mi[0].getString("COMM_CODE")); 
					sql.setString(++i, mi[0].getString("SYS_PART"));  
				} 
				 
				else if (mi[0].IS_DELETE()) 
				{	// 공통코드 DTL 사용여부 전부 = N  
					i = 0;						
					sql.put(svc.getQuery("SEL_DETAIL_CNT"));		

					sql.setString(++i, mi[0].getString("COMM_CODE")); 
					sql.setString(++i, mi[0].getString("SYS_PART")); 
					
					Map map = selectMap(sql );	 
					delCnt = String2.nvl((String)map.get("CNT"));  

					if( delCnt.equals("0")) break; 
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("DEL_MASTER"));

					sql.setString(++i, strID);
					sql.setString(++i, mi[0].getString("COMM_CODE")); 
					sql.setString(++i, mi[0].getString("SYS_PART"));
				}

				if (mi[0].IS_DELETE() && ("0").equals(delCnt) ) res = 1;
				else
				res = update(sql);  
				
				if (res < 1) 
				{
					if (mi[0].IS_DELETE()) 	errMsg = "삭제" ;   
					else					errMsg = "입력" ; 
					
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 " + errMsg + "하지 못했습니다.");
				}
				ret1 += res;
			}
			
			while (mi[1].next()) 
			{
				sql.close();
				if (mi[1].IS_INSERT()) 
				{   
					i = 0;
					sql.put(svc.getQuery("INS_DETAIL"));
					
					sql.setString(++i, mi[1].getString("SYS_PART"));
					sql.setString(++i, mi[1].getString("COMM_PART"));
					sql.setString(++i, mi[1].getString("COMM_CODE")); 
					sql.setString(++i, mi[1].getString("COMM_NAME1"));
					sql.setString(++i, mi[1].getString("COMM_NAME2"));

					if ("F".equals(mi[1].getString("USE_YN"))) {
						sql.setString(++i, "N");
					} else {
						sql.setString(++i, "Y");
					}
					sql.setString(++i, mi[1].getString("REFER_CODE"));
					sql.setString(++i, mi[1].getString("REFER_VALUE"));
					sql.setString(++i, mi[1].getString("INQR_ORDER"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
					// MARIO OUTLET ADD
					sql.setString(++i, mi[1].getString("RESERVED1"));
					sql.setString(++i, mi[1].getString("RESERVED2"));
					sql.setString(++i, mi[1].getString("RESERVED3"));
					sql.setString(++i, mi[1].getString("RESERVED4"));
					sql.setString(++i, mi[1].getString("RESERVED5")); 
					// MARIO OUTLET ADD
					
				} else if (mi[1].IS_UPDATE()) {
					i = 0;
					sql.put(svc.getQuery("UPT_DETAIL"));

					sql.setString(++i, mi[1].getString("COMM_NAME1"));
					sql.setString(++i, mi[1].getString("COMM_NAME2"));
					if ("F".equals(mi[1].getString("USE_YN"))) {
						sql.setString(++i, "N");
					} else {
						sql.setString(++i, "Y");
					}

					sql.setString(++i, mi[1].getString("REFER_CODE"));
					sql.setString(++i, mi[1].getString("REFER_VALUE"));
					sql.setString(++i, mi[1].getString("INQR_ORDER"));
					sql.setString(++i, strID);
					// MARIO OUTLET ADD
					sql.setString(++i, mi[1].getString("RESERVED1"));
					sql.setString(++i, mi[1].getString("RESERVED2"));
					sql.setString(++i, mi[1].getString("RESERVED3"));
					sql.setString(++i, mi[1].getString("RESERVED4"));
					sql.setString(++i, mi[1].getString("RESERVED5"));
					// MARIO OUTLET ADD
					
					sql.setString(++i, mi[1].getString("COMM_PART"));
					sql.setString(++i, mi[1].getString("COMM_CODE"));
					sql.setString(++i, mi[1].getString("SYS_PART"));
				} else {
					i = 0;
					sql.put(svc.getQuery("DEL_DETAIL2"));

					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("COMM_PART"));
					sql.setString(++i, mi[1].getString("COMM_CODE"));
					sql.setString(++i, mi[1].getString("SYS_PART"));
				}
				
				res = update(sql); 

				if (res != 1) 
				{
					if (mi[1].IS_DELETE()) 	errMsg = "삭제" ;   
					else					errMsg = "입력" ; 
					
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 " + errMsg + "하지 못했습니다.");
				}
				ret2 += res; 
			}
			
			// MST / DTL   변경 시  MST 건수 리턴 
			// MST 없이 DTL 변경 시 DTL 건수 리턴
			if ( mi[0].getRowNum() > 0 ) ret = mi[0].getRowNum() ;
			else 						 ret = mi[1].getRowNum() ;

		} catch (Exception e) { 
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	 
}
