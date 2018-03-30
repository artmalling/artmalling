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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>행사테마코드관리</p>
 * 
 * @created  on 1.0, 2010/02/08
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod701DAO extends AbstractDAO {

	/**
	 * 행사테마 마스터 트리을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTreeMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strLCd = String2.nvl(form.getParam("strLCd"));
		String strMCd = String2.nvl(form.getParam("strMCd"));
		String strSCd = String2.nvl(form.getParam("strSCd"));
		String strUseYn = String2.nvl(form.getParam("strUseYn"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot"); 
		
		strQuery = svc.getQuery("WITH_TMP_PC_EVTTHMEMST") + "\n";
		
		strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST") + "\n";
		
		strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_UP_S") + "\n";		
		
		if( !strLCd.equals("%") ){
			sql.setString(i++, strLCd);
			strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_WHERE_L_CD") + "\n";
		}
		
		if( !strMCd.equals("%") ){
			sql.setString(i++, strMCd);
			strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_WHERE_M_CD") + "\n";
		}
		
		if( !strSCd.equals("%") ){
			sql.setString(i++, strSCd);
			strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_WHERE_S_CD") + "\n";
		}
		
		if( !strUseYn.equals("%") ){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_WHERE_USE_YN") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_UP_E") + "\n";

		/* 하위항목 제외 2010.05.30
		strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_DOWN_S") + "\n";		
		
		if( !strLCd.equals("%") ){
			sql.setString(i++, strLCd);
			strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_WHERE_L_CD") + "\n";
		}
		
		if( !strMCd.equals("%") ){
			sql.setString(i++, strMCd);
			strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_WHERE_M_CD") + "\n";
		}
		
		if( !strSCd.equals("%") ){
			sql.setString(i++, strSCd);
			strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_WHERE_S_CD") + "\n";
		}
		
		if( !strUseYn.equals("%") ){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_WHERE_USE_YN") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_DOWN_E") + "\n";

		*/
		strQuery += svc.getQuery("SEL_TREE_EVTTHMEMST_ORDER") + "\n";
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 행사테마 마스터,
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

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		String newEvtThmeCd = "";
		
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					newEvtThmeCd = mi.getString("EVENT_L_CD");
					newEvtThmeCd += mi.getString("EVENT_M_CD").equals("")?"0":mi.getString("EVENT_M_CD");
					newEvtThmeCd += mi.getString("EVENT_S_CD").equals("")?"00":mi.getString("EVENT_S_CD");
					
					sql.put(svc.getQuery("SEL_EVTTHMEMST_EVENT_THME_CD_CNT"));							
					sql.setString(1, newEvtThmeCd);								
					map = selectMap( sql );							
					String evtThmeCdCnt = String2.nvl((String)map.get("CNT"));
					if( !evtThmeCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복되는 분류코드 입니다.");
					}
					sql.close();
					if( !mi.getString("EVENT_THME_LEVEL").equals("1") && mi.getString("USE_YN").equals("Y")){
						String lvl = mi.getString("EVENT_THME_LEVEL");
						sql.put(svc.getQuery("SEL_EVTTHMEMST_USE_YN_CNT"));
						sql.setString(1, lvl.equals("2")?(newEvtThmeCd.substring(0, 1)+"000"):(newEvtThmeCd.substring(0, 2)+"00"));												
						sql.setString(2, "N");												
						sql.setString(3, newEvtThmeCd);								
						map = selectMap( sql );							
						String useCnt = String2.nvl((String)map.get("CNT"));
						if( !useCnt.equals("0")) {
							throw new Exception("[USER]"+"상위분류가 사용불가 입니다.");
						}
						sql.close();
					}
					
					i = 0;							
					sql.put(svc.getQuery("INS_EVTTHMEMST"));
					sql.setString(++i, newEvtThmeCd);
					sql.setString(++i, mi.getString("EVENT_THME_NAME"));
					sql.setString(++i, mi.getString("EVENT_THME_LEVEL"));
					sql.setString(++i, mi.getString("EVENT_L_CD"));
					sql.setString(++i, mi.getString("EVENT_M_CD").equals("")?"0":mi.getString("EVENT_M_CD"));
					sql.setString(++i, mi.getString("EVENT_S_CD").equals("")?"00":mi.getString("EVENT_S_CD"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				} else if (mi.IS_UPDATE()){

					if( !mi.getString("EVENT_THME_LEVEL").equals("1") && mi.getString("USE_YN").equals("Y")){
						String lvl = mi.getString("EVENT_THME_LEVEL");
						sql.put(svc.getQuery("SEL_EVTTHMEMST_USE_YN_CNT"));
						sql.setString(1, lvl.equals("2")?(mi.getString("EVENT_THME_CD").substring(0, 1)+"000"):(mi.getString("EVENT_THME_CD").substring(0, 2)+"00"));												
						sql.setString(2, "N");												
						sql.setString(3, mi.getString("EVENT_THME_CD"));								
						map = selectMap( sql );							
						String useCnt = String2.nvl((String)map.get("CNT"));
						if( !useCnt.equals("0")) {
							throw new Exception("[USER]"+"상위분류가 사용불가 입니다.");
						}
						sql.close();
					}

					if( !mi.getString("EVENT_THME_LEVEL").equals("3") && mi.getString("USE_YN").equals("N")){
						String lvl = mi.getString("EVENT_THME_LEVEL");
						sql.put(svc.getQuery("SEL_EVTTHMEMST_USE_YN_CNT"));
						sql.setString(1, lvl.equals("1")?mi.getString("EVENT_THME_CD").substring(0, 1):mi.getString("EVENT_THME_CD").substring(0, 2));												
						sql.setString(2, "Y");												
						sql.setString(3, mi.getString("EVENT_THME_CD"));								
						map = selectMap( sql );							
						String useCnt = String2.nvl((String)map.get("CNT"));
						if( !useCnt.equals("0")) {
							throw new Exception("[USER]"+"하위분류 중 사용 중인 항목이 존재합니다.");
						}
						sql.close();
					}
					i = 0;							
					sql.put(svc.getQuery("UPD_EVTTHMEMST"));
					sql.setString(++i, mi.getString("EVENT_THME_NAME"));
					sql.setString(++i, mi.getString("USE_YN"));
					sql.setString(++i, mi.getString("REMARK"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("EVENT_THME_CD"));
				} else {
						
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
