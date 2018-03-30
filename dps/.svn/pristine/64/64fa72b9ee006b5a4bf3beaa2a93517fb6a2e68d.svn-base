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
 * <p>단품스캔코드관리</p>
 * 
 * @created  on 1.0, 2010.03.28
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod509DAO extends AbstractDAO {


	/**
	 * 단품스캔코드를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi , String userId , String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		String styleType = String2.nvl(form.getParam("styleType"));
		int i = 1;	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		mi.next();
		
		sql.setString(i++, userId);
		sql.setString(i++, orgFlag);
		strQuery = svc.getQuery("SEL_SKUMST") + "\n";
		
		if( !mi.getString("STR_CD").equals("%")){
			sql.setString(i++, mi.getString("STR_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_STR_CD") + "\n";
		}			
		if( !mi.getString("PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("PUMMOK_CD").equals("%")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMMOK_CD") + "\n";
		}
		if( !mi.getString("SKU_CD").equals("") || !mi.getString("SKU_NM").equals("")){
			sql.setString(i++, mi.getString("SKU_CD"));
			sql.setString(i++, mi.getString("SKU_NM"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_LIKE_SKU_CD") + "\n";
		}
		if( !mi.getString("BARCODE").equals("")){
			sql.setString(i++, mi.getString("BARCODE"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_BARCODE") + "\n";
		}
		
		if (!styleType.equals("")){
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_STYLE_TYPE") + "\n";
			
			if( !mi.getString("STYLE_CD_A").equals("") || !mi.getString("STYLE_NM_A").equals("")){
				sql.setString(i++, mi.getString("STYLE_CD_A"));
				sql.setString(i++, mi.getString("STYLE_NM_A"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_STYLE_CD") + "\n";
			}
			if( !mi.getString("STYLE_CD_B").equals("") || !mi.getString("STYLE_NM_B").equals("")){
				sql.setString(i++, mi.getString("STYLE_CD_B"));
				sql.setString(i++, mi.getString("STYLE_NM_B"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_STYLE_CD") + "\n";
			}
			if( !mi.getString("BRAND_CD_A").equals("%")){
				sql.setString(i++, mi.getString("BRAND_CD_A"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_BRAND_CD") + "\n";
			}
			if( !mi.getString("BRAND_CD_B").equals("%")){
				sql.setString(i++, mi.getString("BRAND_CD_B"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_BRAND_CD") + "\n";
			}
			if( !mi.getString("SUB_BRD_CD_A").equals("%")){
				sql.setString(i++, mi.getString("SUB_BRD_CD_A"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_SUB_BRD_CD") + "\n";
			}
			if( !mi.getString("SUB_BRD_CD_B").equals("%")){
				sql.setString(i++, mi.getString("SUB_BRD_CD_B"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_SUB_BRD_CD") + "\n";
			}
			if( !mi.getString("PLAN_YEAR").equals("%")){
				sql.setString(i++, mi.getString("PLAN_YEAR"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_PLAN_YEAR") + "\n";
			}		
			if( !mi.getString("SEASON_CD").equals("%")){
				sql.setString(i++, mi.getString("SEASON_CD"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_SEASON_CD") + "\n";
			}
			if( !mi.getString("ITEM_CD").equals("%")){
				sql.setString(i++, mi.getString("ITEM_CD"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_ITEM_CD") + "\n";
			}
			if( !mi.getString("MNG_CD1").equals("")){
				sql.setString(i++, mi.getString("MNG_CD1"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD1") + "\n";
			}
			if( !mi.getString("MNG_CD2").equals("")){
				sql.setString(i++, mi.getString("MNG_CD2"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD2") + "\n";
			}		
			if( !mi.getString("MNG_CD3").equals("")){
				sql.setString(i++, mi.getString("MNG_CD3"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD3") + "\n";
			}
			if( !mi.getString("MNG_CD4").equals("")){
				sql.setString(i++, mi.getString("MNG_CD4"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD4") + "\n";
			}
			if( !mi.getString("MNG_CD5").equals("")){
				sql.setString(i++, mi.getString("MNG_CD5"));
				strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD5") + "\n";
			}
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_STYLE_TYPE_END") + "\n";
		}
		
		
		
		strQuery += svc.getQuery("SEL_SKUMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 단품스캔코드를 저장  처리한다.
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
		String strCdCnt = "";
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				i = 0;
				
				sql.put(svc.getQuery("SEL_BARCDMST_INS_BAR_CNT"));							
				//sql.setString(++i, mi.getString("STR_CD"));				
				sql.setString(++i, mi.getString("BARCODE"));
				sql.setString(++i, mi.getString("SKU_CD"));
				Map map = selectMap( sql );							
				strCdCnt = String2.nvl((String)map.get("CNT"));
				if( !strCdCnt.equals("0")) {
					throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
				}
				sql.close();
				
                i = 0;
				
				sql.put(svc.getQuery("SEL_BARCDMST_INS_CNT"));						
				sql.setString(++i, mi.getString("BARCODE"));
				sql.setString(++i, mi.getString("STR_CD"));
				Map map1 = selectMap( sql );							
				strCdCnt = String2.nvl((String)map1.get("CNT"));
				if( !strCdCnt.equals("0")) {
					throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
				}
				sql.close();

				i = 0;
				sql.put(svc.getQuery("INS_BARCDMST"));
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("BARCODE"));
				sql.setString(++i, mi.getString("SKU_CD"));
				sql.setString(++i, strPumbunCd);
				sql.setString(++i, null);					
				sql.setString(++i, strID);					
				sql.setString(++i, strID);
					
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
