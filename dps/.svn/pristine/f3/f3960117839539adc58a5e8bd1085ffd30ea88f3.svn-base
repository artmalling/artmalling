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

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/23
 * @created  by 박종은(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod211DAO extends AbstractDAO {

	/**
	 * 브랜드정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		// 20120507 * DHL 주석처리 -->
		//String strBrandGb   = String2.nvl(form.getParam("strBrandGb"));
		// 20120507 * DHL 주석처리 <--
		
		String strBrandCd 	= String2.nvl(form.getParam("strBrandCd"));
		String strBrandNm 	= String2.nvl(form.getParam("strBrandNm")); 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_BRAND_MST"));

		sql.setString(i++, strBrandCd);
		sql.setString(i++, strBrandNm);
		
		/*
		// 20120507 * DHL 주석처리 
		if("01".equals(strBrandGb)){				   //  01 :TOTAL
			sql.put(svc.getQuery("SEL_BR_01"));
		}else if("02".equals(strBrandGb)){		       // 02 :식품
			sql.put(svc.getQuery("SEL_BR_02"));
		}else if("03".equals(strBrandGb)){		       // 03 :패션잡화
			sql.put(svc.getQuery("SEL_BR_03"));
		}else if("04".equals(strBrandGb)){		       // 04 :여성
			sql.put(svc.getQuery("SEL_BR_04"));
		}else if("05".equals(strBrandGb)){		       // 05 :남성
			sql.put(svc.getQuery("SEL_BR_05"));
		}else if("06".equals(strBrandGb)){		       // 06 :아동
			sql.put(svc.getQuery("SEL_BR_06"));
		}else if("07".equals(strBrandGb)){		       // 07 :가정문화
			sql.put(svc.getQuery("SEL_BR_07"));
		}else if("08".equals(strBrandGb)){		       // 08 :예비1
			sql.put(svc.getQuery("SEL_BR_08"));
		}else if("09".equals(strBrandGb)){		       // 09 :예비2
			sql.put(svc.getQuery("SEL_BR_09"));
		}else if("10".equals(strBrandGb)){		       // 10 :예비3
			sql.put(svc.getQuery("SEL_BR_10"));
		}
		*/

		ret = select2List(sql);
		
		return ret;
	}


	/**
	 * 브랜드을  저장, 수정  처리한다.
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
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {

					i = 0;
					
					sql.put(svc.getQuery("INS_BRDMST"));
					
					sql.setString(++i, mi.getString("BRAND_NM"));	
					
					/*
					// 20120507 * DHL 주석처리 -->
					sql.setString(++i, mi.getString("BRAND_FLAG01"));
					sql.setString(++i, mi.getString("BRAND_FLAG02"));
					sql.setString(++i, mi.getString("BRAND_FLAG03"));
					sql.setString(++i, mi.getString("BRAND_FLAG04"));
					sql.setString(++i, mi.getString("BRAND_FLAG05"));
					sql.setString(++i, mi.getString("BRAND_FLAG06"));
					sql.setString(++i, mi.getString("BRAND_FLAG07"));
					sql.setString(++i, mi.getString("BRAND_FLAG08"));
					sql.setString(++i, mi.getString("BRAND_FLAG09"));
					sql.setString(++i, mi.getString("BRAND_FLAG10"));
					// 20120507 * DHL 주석처리 <--
					*/
					
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				} else if (mi.IS_UPDATE()) {
					
					i = 0;
					
					sql.put(svc.getQuery("UPD_BRDMST"));

					sql.setString(++i, mi.getString("BRAND_NM"));	
					
					/*
					// 20120507 * DHL 주석처리 -->
					sql.setString(++i, mi.getString("BRAND_FLAG01"));
					sql.setString(++i, mi.getString("BRAND_FLAG02"));
					sql.setString(++i, mi.getString("BRAND_FLAG03"));
					sql.setString(++i, mi.getString("BRAND_FLAG04"));
					sql.setString(++i, mi.getString("BRAND_FLAG05"));
					sql.setString(++i, mi.getString("BRAND_FLAG06"));
					sql.setString(++i, mi.getString("BRAND_FLAG07"));
					sql.setString(++i, mi.getString("BRAND_FLAG08"));
					sql.setString(++i, mi.getString("BRAND_FLAG09"));
					sql.setString(++i, mi.getString("BRAND_FLAG10"));
					// 20120507 * DHL 주석처리 <--
					*/
					
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("BRAND_CD"));
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]"+"[USER]" + "데이터의 적합성 문제로 인하여"
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
	 * 브랜드정보    삭제  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int del(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		Util util 		= new Util();
		SqlWrapper sql 	= null;
		Service svc 	= null;
        int i = 1;
        String strCdCnt = "";

		String strBrandCd     = String2.nvl(form.getParam("strBrandCd"));
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			/* 브랜드코드 기사용여부 */
			sql.close();
			sql.put(svc.getQuery("SEL_BRDCD_CNT"));
			sql.setString(1, strBrandCd);
		    Map map = selectMap( sql );
			strCdCnt = String2.nvl((String)map.get("CNT"));
			System.out.println(strCdCnt);
			if( !strCdCnt.equals("0")) {
				throw new Exception("[USER]"+"이미 사용된 브랜드코드 입니다.");
			}
			
			sql.close();
			sql.put(svc.getQuery("DEL_BRDMST"));
		    sql.setString(1, strBrandCd);
			res = update(sql);
			ret += res;
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}	
}
