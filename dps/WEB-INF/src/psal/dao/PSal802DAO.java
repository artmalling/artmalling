/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.Arrays;
import java.util.HashMap;
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
 * <p>매출일마감관리</p>
 * 
 * @created  on 1.0, 2010/06/07
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

/*
 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
 */
public class PSal802DAO extends AbstractDAO {
	
	/**
	 * 매출 일마감조회 
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
		
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));     //점
		String strCloseDtS     = String2.nvl(form.getParam("strCloseDtS"));   //마감년월 시작
		String strAffairsFlag  = String2.nvl(form.getParam("strAffairsFlag"));   //업무구분
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_DCLOSE") + "\n";

		sql.setString(i++, strCloseDtS);
		sql.setString(i++, strCloseDtS);
		sql.setString(i++, strCloseDtS);
		sql.setString(i++, strStrCd);
		

		if (!"%".equals(strAffairsFlag)){
			strQuery += svc.getQuery("SEL_DCLOSE_AFFAIRS") + "\n";;
			sql.setString(i++, strAffairsFlag);
		}

		strQuery += svc.getQuery("SEL_DCLOSE_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }

	/**
	 * 매출일마감업무구분 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
    public List searchAffairs(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_AFFAIRS_FLAG") + "\n";
		

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }

    /**
     * 매출 일마감 처리
     * 
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
	public int close(ActionForm form, MultiInput mi, String strID)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		
		String closeYn;
		String closeFlag;
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if ( mi.IS_UPDATE()) {
					closeYn = mi.getString("CLOSE_YN");
					i = 0;
					// 마감처리시
					if(closeYn.equals("Y")){

						// 이전일 마감여부
						sql.close();
						i = 0;
						String tmp = "SELECT NVL((";
						tmp += svc.getQuery("SEL_DCLOSE_CLOSE_YN")+ " \n";
						tmp += svc.getQuery("SEL_DCLOSE_CLOSE_YN_WHERE_YM_ADD")+ "\n";
						tmp += "),'N') AS CLOSE_YN "+ "\n";
						tmp += "FROM DUAL ";
						
						sql.put(tmp);							
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_DT"));				
						sql.setInt(++i, -1);	
						
						map = selectMap( sql );							
						closeFlag = String2.nvl((String)map.get("CLOSE_YN"));
						if( !closeFlag.equals("Y")) {
							throw new Exception("[USER]"+"이전 일이 마감 되지 않았습니다.");
						}
												
						// 임시로 바로 업데이트
						sql.close();
						i = 0;
						sql.put(svc.getQuery("MERGE_DCLOSE"));
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));		
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_DT"));			
						sql.setString(++i, mi.getString("CLOSE_YN"));			
						sql.setString(++i, mi.getString("SAP_IF_YN"));		
						sql.setString(++i, strID);	

						res = update(sql);

						if (res != 1) {
							throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
					// 마감 해제 처리 시	
					} else {
						
						// 당월 매출 월마감 여부 확인
						sql.close();
						i = 0;
						String mCloseCheck = "SELECT NVL((";
						mCloseCheck += svc.getQuery("SEL_MCLOSE_CLOSE_YN")+ " \n";
						mCloseCheck += "),'N') AS CLOSE_YN ";
						mCloseCheck += "FROM DUAL ";
						
						sql.put(mCloseCheck);							
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));
						sql.setString(++i, "41");			
						sql.setString(++i, mi.getString("CLOSE_DT"));
						
						map = selectMap( sql );							
						closeFlag = String2.nvl((String)map.get("CLOSE_YN"));
						if( !closeFlag.equals("N")) {
							throw new Exception("[USER]"+"당월 월 매출이 마감 되어 있습니다.");
						}
						
						
						// 이후 일 마감여부
						sql.close();
						i = 0;
						String tmp = "SELECT NVL((";
						tmp += svc.getQuery("SEL_DCLOSE_CLOSE_YN")+ " \n";
						tmp += svc.getQuery("SEL_DCLOSE_CLOSE_YN_WHERE_YM_ADD")+ " \n";
						tmp += "),'N') AS CLOSE_YN ";
						tmp += "FROM DUAL ";
						
						sql.put(tmp);							
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_DT"));				
						sql.setInt(++i, 1);	
						
						map = selectMap( sql );							
						closeFlag = String2.nvl((String)map.get("CLOSE_YN"));
						if( !closeFlag.equals("N")) {
							throw new Exception("[USER]"+"이후 일이 마감 되어 있습니다.");
						}

						sql.close();
						i = 0;
						sql.put(svc.getQuery("MERGE_DCLOSE"));
						sql.setString(++i, mi.getString("STR_CD"));					
						sql.setString(++i, mi.getString("CLOSE_TASK_FLAG"));		
						sql.setString(++i, mi.getString("CLOSE_UNIT_FLAG"));			
						sql.setString(++i, mi.getString("CLOSE_DT"));			
						sql.setString(++i, mi.getString("CLOSE_YN"));			
						sql.setString(++i, mi.getString("SAP_IF_YN"));		
						sql.setString(++i, strID);	

						res = update(sql);

						if (res != 1) {
							throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
					}
					
				} else {
					continue;
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
