/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.HashMap;
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
 * <p>단품엑셀업로드</p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod505DAO extends AbstractDAO {

	/**
	 * 규격단품 데이터를 검증한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkSkuExcelData(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		String dualTable = " WITH UPLOAD_EXCEL_DATA AS ( \n";		
		while (mi.next()) {
			if( i > 0)
				dualTable += "\n UNION ALL ";
			dualTable +=" SELECT ";
			dualTable += " '"+String2.trimToEmpty(mi.getString("SKU_NAME"))                           + "' AS SKU_NAME ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("RECP_NAME"))                          + "' AS RECP_NAME ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("PUMMOK_CD")),0)       + "' AS PUMMOK_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("PUMMOK_CD"))                          + "' AS PUMMOK_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")),1)    + "' AS INPUT_PLU_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("INPUT_PLU_CD"))                       + "' AS INPUT_PLU_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MODEL_CD")),2)        + "' AS MODEL_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("MODEL_CD"))                           + "' AS MODEL_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SALE_UNIT_CD")),3)    + "' AS SALE_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SALE_UNIT_CD"))                       + "' AS SALE_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_CD")),4)     + "' AS BAS_SPEC_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_CD"))                        + "' AS BAS_SPEC_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD")),5)+ "' AS BAS_SPEC_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD"))                   + "' AS BAS_SPEC_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_CD")),6)     + "' AS CMP_SPEC_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_CD"))                        + "' AS CMP_SPEC_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD")),7)+ "' AS CMP_SPEC_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD"))                   + "' AS CMP_SPEC_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD")),8)  + "' AS ORIGIN_AREA_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD"))                     + "' AS ORIGIN_AREA_CD ";
			if(!String2.trimToEmpty(mi.getString("INPUT_PLU_CD")).equals("")){
				String tmpSkuCd = String2.leftPad(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")), 13, '0');
				dualTable += ",'"+tmpSkuCd                     + "' AS SKU_CD ";
				dualTable += ",'"+Util.getSkuCdCheckSum(tmpSkuCd.substring(0,12))+"' AS CHECK_SUM ";
			}else{
				dualTable += ",'' AS SKU_CD ";
				dualTable += ",'' AS CHECK_SUM ";
			}
			dualTable +=" FROM DUAL ";
			i++;
		}
		dualTable += ") ";
		
		i = 0;
		sql.put(dualTable);
		sql.put(svc.getQuery("SEL_STN_SKU"));
		sql.put(svc.getQuery("SEL_STN_SKU_ORDER"));
		sql.setString(++i, strPumbunCd);
		ret = select2List(sql);
		return ret;
	}

	/**
	 * 신선단품 데이터를 검증한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkFreshExcelData(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		
		String dualTable = " WITH UPLOAD_EXCEL_DATA AS ( \n";			
		while (mi.next()) {
			if( i > 0)
				dualTable += "\n UNION ALL ";
			dualTable +=" SELECT ";
			dualTable += " '"+String2.trimToEmpty(mi.getString("SKU_NAME"))                           + "' AS SKU_NAME ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("RECP_NAME"))                          + "' AS RECP_NAME ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("PUMMOK_CD")),0)       + "' AS PUMMOK_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("PUMMOK_CD"))                          + "' AS PUMMOK_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SALE_UNIT_CD")),3)    + "' AS SALE_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SALE_UNIT_CD"))                       + "' AS SALE_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_CD")),4)     + "' AS BAS_SPEC_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_CD"))                        + "' AS BAS_SPEC_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD")),5)+ "' AS BAS_SPEC_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD"))                   + "' AS BAS_SPEC_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_CD")),6)     + "' AS CMP_SPEC_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_CD"))                        + "' AS CMP_SPEC_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD")),7)+ "' AS CMP_SPEC_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD"))                   + "' AS CMP_SPEC_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD")),8)  + "' AS ORIGIN_AREA_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD"))                     + "' AS ORIGIN_AREA_CD ";
			dualTable +=" FROM DUAL ";
			i++;
		}
		dualTable += ") ";
		
		i = 0;
		sql.put(dualTable);
		sql.put(svc.getQuery("SEL_FRESH"));
		sql.put(svc.getQuery("SEL_FRESH_ORDER"));
		sql.setString(++i, strPumbunCd);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 의류단품(A) 데이터를 검증한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkAStyleExcelData(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		
		String dualTable = " WITH UPLOAD_EXCEL_DATA AS ( \n";			
		while (mi.next()) {
			if( i > 0)
				dualTable += "\n UNION ALL ";
			dualTable +=" SELECT ";
			dualTable += " '"+String2.trimToEmpty(mi.getString("STYLE_NAME"))                         + "' AS STYLE_NAME ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("RECP_NAME"))                          + "' AS RECP_NAME ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("STYLE_CD")),9)        + "' AS STYLE_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("STYLE_CD"))                           + "' AS STYLE_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("COLOR_CD")),10)       + "' AS COLOR_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("COLOR_CD"))                           + "' AS COLOR_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SIZE_CD")),11)        + "' AS SIZE_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SIZE_CD"))                            + "' AS SIZE_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SIZE_TYPE_CD")),12)   + "' AS SIZE_TYPE_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SIZE_TYPE_CD"))                       + "' AS SIZE_TYPE_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SEX_CD")),13)         + "' AS SEX_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SEX_CD"))                             + "' AS SEX_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("PUMMOK_CD")),0)       + "' AS PUMMOK_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("PUMMOK_CD"))                          + "' AS PUMMOK_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")),1)    + "' AS INPUT_PLU_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("INPUT_PLU_CD"))                       + "' AS INPUT_PLU_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("VEN_STYLE_CD")),14)   + "' AS VEN_STYLE_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("VEN_STYLE_CD"))                       + "' AS VEN_STYLE_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SALE_UNIT_CD")),3)    + "' AS SALE_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SALE_UNIT_CD"))                       + "' AS SALE_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_CD")),4)     + "' AS BAS_SPEC_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_CD"))                        + "' AS BAS_SPEC_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD")),5)+ "' AS BAS_SPEC_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD"))                   + "' AS BAS_SPEC_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_CD")),6)     + "' AS CMP_SPEC_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_CD"))                        + "' AS CMP_SPEC_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD")),7)+ "' AS CMP_SPEC_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD"))                   + "' AS CMP_SPEC_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD")),8)  + "' AS ORIGIN_AREA_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD"))                     + "' AS ORIGIN_AREA_CD ";
			
			if(!String2.trimToEmpty(mi.getString("INPUT_PLU_CD")).equals("")){
				String tmpSkuCd = String2.leftPad(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")), 13, '0');
				dualTable += ",'"+tmpSkuCd                     + "' AS SKU_CD ";
				dualTable += ",'"+Util.getSkuCdCheckSum(tmpSkuCd.substring(0,12))+"' AS CHECK_SUM ";
			}else{
				dualTable += ",'' AS SKU_CD ";
				dualTable += ",'' AS CHECK_SUM ";
			}
			
			if(String2.trimToEmpty(mi.getString("STYLE_CD")).length() == 14){
				dualTable += ",'Y' AS STYLE_CD_CHK ";
				String styleCd = String2.trimToEmpty(mi.getString("STYLE_CD"));
				dualTable += ",'"+styleCd.substring(0,5)       + "' AS BRAND_CD ";
				dualTable += ",'"+styleCd.substring(5,7)       + "' AS SUB_BRD_CD ";
				dualTable += ",'"+styleCd.substring(7,8)       + "' AS PLAN_YEAR_CD ";
				dualTable += ",'"+styleCd.substring(8,9)       + "' AS SEASON_CD ";
				dualTable += ",'"+styleCd.substring(9,11)       + "' AS ITEM_CD ";
				dualTable += ",'"+styleCd.substring(11)         + "' AS SEQ_NO ";
			}else{
				dualTable += ",'N' AS STYLE_CD_CHK ";
				dualTable += ",''  AS BRAND_CD ";
				dualTable += ",''  AS SUB_BRD_CD ";
				dualTable += ",''  AS PLAN_YEAR_CD ";
				dualTable += ",''  AS SEASON_CD ";
				dualTable += ",''  AS ITEM_CD ";
				dualTable += ",''  AS SEQ_NO ";
				
			}
			dualTable +=" FROM DUAL ";
			i++;
		}
		dualTable += ") ";
		
		i = 0;
		sql.put(dualTable);
		sql.put(svc.getQuery("SEL_ASTYLE"));
		sql.put(svc.getQuery("SEL_ASTYLE_ORDER"));
		sql.setString(++i, strPumbunCd);
		sql.setString(++i, strPumbunCd);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 의류단품(B) 데이터를 검증한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkBStyleExcelData(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		
		String dualTable = " WITH UPLOAD_EXCEL_DATA AS ( \n";			
		while (mi.next()) {
			if( i > 0)
				dualTable += "\n UNION ALL ";
			
			dualTable +=" SELECT ";			
			dualTable += " '"+String2.trimToEmpty(mi.getString("STYLE_NAME"))                         + "' AS STYLE_NAME ";			
			dualTable += ",'"+String2.trimToEmpty(mi.getString("RECP_NAME"))                          + "' AS RECP_NAME ";	
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BRAND_CD")),15)       + "' AS BRAND_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BRAND_CD"))                           + "' AS BRAND_CD ";		
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SUB_BRD_CD")),16)     + "' AS SUB_BRD_CD_LEN ";	
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SUB_BRD_CD"))                         + "' AS SUB_BRD_CD ";	
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD1")),17)        + "' AS MNG_CD1_LEN ";			
			dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD1"))                            + "' AS MNG_CD1 ";	
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD2")),18)        + "' AS MNG_CD2_LEN ";		
			dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD2"))                            + "' AS MNG_CD2 ";	
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD3")),19)        + "' AS MNG_CD3_LEN ";		
			dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD3"))                            + "' AS MNG_CD3 ";	
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD4")),20)        + "' AS MNG_CD4_LEN ";		
			dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD4"))                            + "' AS MNG_CD4 ";	
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD5")),21)        + "' AS MNG_CD5_LEN ";		
			dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD5"))                            + "' AS MNG_CD5 ";		
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SEX_CD")),13)         + "' AS SEX_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SEX_CD"))                             + "' AS SEX_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("PUMMOK_CD")),0)       + "' AS PUMMOK_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("PUMMOK_CD"))                          + "' AS PUMMOK_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")),1)    + "' AS INPUT_PLU_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("INPUT_PLU_CD"))                       + "' AS INPUT_PLU_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("VEN_STYLE_CD")),14)   + "' AS VEN_STYLE_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("VEN_STYLE_CD"))                       + "' AS VEN_STYLE_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SALE_UNIT_CD")),3)    + "' AS SALE_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("SALE_UNIT_CD"))                       + "' AS SALE_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_CD")),4)     + "' AS BAS_SPEC_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_CD"))                        + "' AS BAS_SPEC_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD")),5)+ "' AS BAS_SPEC_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD"))                   + "' AS BAS_SPEC_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_CD")),6)     + "' AS CMP_SPEC_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_CD"))                        + "' AS CMP_SPEC_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD")),7)+ "' AS CMP_SPEC_UNIT_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD"))                   + "' AS CMP_SPEC_UNIT_CD ";
			dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD")),8)  + "' AS ORIGIN_AREA_CD_LEN ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD"))                     + "' AS ORIGIN_AREA_CD ";				
			if(!String2.trimToEmpty(mi.getString("INPUT_PLU_CD")).equals("")){				
				String tmpSkuCd = String2.leftPad(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")), 13, '0');				
				dualTable += ",'"+tmpSkuCd                     + "' AS SKU_CD ";				
				dualTable += ",'"+Util.getSkuCdCheckSum(tmpSkuCd.substring(0,12))+"' AS CHECK_SUM ";				
			}else{				
				dualTable += ",'' AS SKU_CD ";				
				dualTable += ",'' AS CHECK_SUM ";				
			}			
			String styleCd = "";			
			styleCd += String2.trimToEmpty(mi.getString("BRAND_CD"));			
			styleCd += String2.trimToEmpty(mi.getString("SUB_BRD_CD"));			
			styleCd += String2.trimToEmpty(mi.getString("MNG_CD1"));			
			styleCd += String2.trimToEmpty(mi.getString("MNG_CD2"));			
			styleCd += String2.trimToEmpty(mi.getString("MNG_CD3"));			
			styleCd += String2.trimToEmpty(mi.getString("MNG_CD4"));			
			styleCd += String2.trimToEmpty(mi.getString("MNG_CD5"));			
		
			dualTable += ",'"+styleCd+"'  AS STYLE_CD ";			
			dualTable +=" FROM DUAL ";
			i++;
		}
		dualTable += ") ";
		
		i = 0;
		sql.put(dualTable);
		sql.put(svc.getQuery("SEL_BSTYLE"));
		sql.put(svc.getQuery("SEL_BSTYLE_ORDER"));
		sql.setString(++i, strPumbunCd);
		sql.setString(++i, strPumbunCd);

		ret = select2List(sql);
		return ret;
	}
	/**
	 *  <p>
	 *  규격단품마스터정보를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveStnSkumst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			connect("pot");
			begin();
			String newSkuCd = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));	
			String strPumbunType = String2.nvl(form.getParam("strPumbunType"));	
			String strSkuType = String2.nvl(form.getParam("strSkuType"));	
			String strStyleType = String2.nvl(form.getParam("strStyleType"));					
			String dualTable = "";		
			Map rtnMap = null;
			i = 0;
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {
					sql = new SqlWrapper();
					dualTable = " WITH UPLOAD_EXCEL_DATA AS ( \n";		
					dualTable += " SELECT ";
					dualTable += " '"+String2.trimToEmpty(mi.getString("SKU_NAME"))                           + "' AS SKU_NAME              \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("RECP_NAME"))                          + "' AS RECP_NAME             \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("PUMMOK_CD")),0)       + "' AS PUMMOK_CD_LEN         \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("PUMMOK_CD"))                          + "' AS PUMMOK_CD             \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")),1)    + "' AS INPUT_PLU_CD_LEN      \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("INPUT_PLU_CD"))                       + "' AS INPUT_PLU_CD          \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MODEL_CD")),2)        + "' AS MODEL_CD_LEN          \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("MODEL_CD"))                           + "' AS MODEL_CD              \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SALE_UNIT_CD")),3)    + "' AS SALE_UNIT_CD_LEN      \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SALE_UNIT_CD"))                       + "' AS SALE_UNIT_CD          \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_CD")),4)     + "' AS BAS_SPEC_CD_LEN       \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_CD"))                        + "' AS BAS_SPEC_CD           \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD")),5)+ "' AS BAS_SPEC_UNIT_CD_LEN  \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD"))                   + "' AS BAS_SPEC_UNIT_CD      \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_CD")),6)     + "' AS CMP_SPEC_CD_LEN       \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_CD"))                        + "' AS CMP_SPEC_CD           \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD")),7)+ "' AS CMP_SPEC_UNIT_CD_LEN  \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD"))                   + "' AS CMP_SPEC_UNIT_CD      \n";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD")),8)  + "' AS ORIGIN_AREA_CD_LEN    \n";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD"))                     + "' AS ORIGIN_AREA_CD        \n";
					dualTable += ",'"+mi.getString("SKU_CD")                                                  + "' AS SKU_CD                \n";
					dualTable += ",'"+mi.getString("CHECK_SUM")                                               + "' AS CHECK_SUM             \n";
					dualTable +=" FROM DUAL ";
					dualTable += ")";					
					i = 0;
					sql.put(dualTable);
					sql.put(svc.getQuery("SEL_STN_SKU"));
					sql.setString(++i, strPumbunCd);
					rtnMap = selectMap(sql);
					
					sql.close();
					String errCd = String2.nvl((String)rtnMap.get("ERROR_CD"));
					if(!errCd.equals("")){
						throw new Exception("[USER]"+"오류가 존재합니다. ["+errCd+"]");				
					}
					
					newSkuCd = mi.getString("SKU_CD");
					
					if( !mi.getString("INPUT_PLU_CD").equals("") && newSkuCd.equals("")){
						newSkuCd = String2.leftPad(mi.getString("INPUT_PLU_CD"), 13,'0');
						if(!Util.isSkuCdCheckSum(newSkuCd)){
							throw new Exception("[USER]"+"사용할수 없는 소스마킹코드입니다.");							
						}
					}
					
					//단품코드 자동발번
					if( newSkuCd.equals("")){
						sql.put(svc.getQuery("SEL_SKUMST_STN_NEW_CD"));
						Map map = selectMap( sql );
						newSkuCd = String2.nvl((String)map.get("NEW_SKU_CD"));
						if( newSkuCd.equals("")) {
							throw new Exception("[USER]"+"단품코드를 생성 할 수 없습니다.");
						}
						String checkSum = Util.getSkuCdCheckSum(newSkuCd);
						newSkuCd = newSkuCd + checkSum;
						sql.close();
					//단품코드 중복체크
					}else{
						i = 0;
						sql.put(svc.getQuery("SEL_SKUMST_SKU_CD_CNT"));							
						sql.setString(++i, newSkuCd);
						Map map = selectMap( sql );							
						String skuCdCnt = String2.nvl((String)map.get("CNT"));
						if( !skuCdCnt.equals("0")) {
							throw new Exception("[USER]"+"중복되는 단품코드 입니다.");
						}
						sql.close();
					}
					i = 0;
					
					sql.put(svc.getQuery("INS_SKUMST"));
					sql.setString(++i, newSkuCd);
					sql.setString(++i, mi.getString("SKU_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, strPumbunType );
					sql.setString(++i, strPumbunCd );
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, strSkuType );    // 단품종류
					sql.setString(++i, strStyleType );  // 의류단품구분
					sql.setString(++i, (mi.getString("INPUT_PLU_CD").equals("")?"1":"2")); // PLU 구분
					sql.setString(++i, mi.getString("INPUT_PLU_CD"));
					sql.setString(++i, mi.getString("MODEL_CD"));
					sql.setString(++i, mi.getString("SALE_UNIT_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_UNIT_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_UNIT_CD"));
					sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
					sql.setString(++i, "");      // 메이커
					sql.setString(++i, "N");     // SET_YN
					sql.setString(++i, "0");     // GIFT_FLAG
					sql.setString(++i, "");      // GIFT_TYPE_CD
					sql.setString(++i, "");      // GIFT_AMT_TYPE
					sql.setString(++i, "");      // STYLE_CD
					sql.setString(++i, "");      // COLOR_CD
					sql.setString(++i, "");      // SIZE_CD
					sql.setString(++i, "");      // BOTTLE_CD
					sql.setString(++i, "");      // REMARK
					sql.setString(++i, "Y");     // 사용여부
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				}else{
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				//History
				sql.close();
				Map keys = new HashMap();
				keys.put("SKU_CD", newSkuCd);
				update(Util.getHistorySQL("PC_SKUMST", "PC_SKUHIST", "DPS", keys, "SKU_CD", strID));

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
	 *  신선단품마스터정보를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveFreshSkumst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			connect("pot");
			begin();
			String newSkuCd = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));	
			String strPumbunType = String2.nvl(form.getParam("strPumbunType"));	
			String strSkuType = String2.nvl(form.getParam("strSkuType"));	
			String strStyleType = String2.nvl(form.getParam("strStyleType"));					
			String dualTable = "";		
			Map rtnMap = null;
			i = 0;
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {
					sql = new SqlWrapper();
					dualTable =  " WITH UPLOAD_EXCEL_DATA AS ( \n";		
					dualTable += " SELECT ";
					dualTable += " '"+String2.trimToEmpty(mi.getString("SKU_NAME"))                           + "' AS SKU_NAME ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("RECP_NAME"))                          + "' AS RECP_NAME ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("PUMMOK_CD")),0)       + "' AS PUMMOK_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("PUMMOK_CD"))                          + "' AS PUMMOK_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SALE_UNIT_CD")),3)    + "' AS SALE_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SALE_UNIT_CD"))                       + "' AS SALE_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_CD")),4)     + "' AS BAS_SPEC_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_CD"))                        + "' AS BAS_SPEC_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD")),5)+ "' AS BAS_SPEC_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD"))                   + "' AS BAS_SPEC_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_CD")),6)     + "' AS CMP_SPEC_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_CD"))                        + "' AS CMP_SPEC_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD")),7)+ "' AS CMP_SPEC_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD"))                   + "' AS CMP_SPEC_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD")),8)  + "' AS ORIGIN_AREA_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD"))                     + "' AS ORIGIN_AREA_CD ";
					dualTable +=" FROM DUAL ";
					dualTable += ") ";
					
					i = 0;
					sql.put(dualTable);
					sql.put(svc.getQuery("SEL_FRESH"));
					sql.setString(++i, strPumbunCd);

					rtnMap = selectMap(sql);
					
					sql.close();
					String errCd = String2.nvl((String)rtnMap.get("ERROR_CD"));
					if(!errCd.equals("")){
						throw new Exception("[USER]"+"오류가 존재합니다. ["+errCd+"]");				
					}
					//단품코드 자동발번
					sql.put(svc.getQuery("SEL_SKUMST_FRESH_NEW_CD"));
					Map map = selectMap( sql );
					newSkuCd = String2.nvl((String)map.get("NEW_SKU_CD"));
					if( newSkuCd.equals("")) {
						throw new Exception("[USER]"+"단품코드를 생성 할 수 없습니다.");
					}
					String checkSum = Util.getSkuCdCheckSum(newSkuCd);
					newSkuCd = newSkuCd + checkSum;
					sql.close();					
					
					i = 0;
					
					sql.put(svc.getQuery("INS_SKUMST"));
					sql.setString(++i, newSkuCd);
					sql.setString(++i, mi.getString("SKU_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, strPumbunType );
					sql.setString(++i, strPumbunCd );
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, strSkuType );    // 단품종류
					sql.setString(++i, strStyleType );  // 의류단품구분
					sql.setString(++i, "3");            // PLU 구분
					sql.setString(++i, "");             // INPUT_PLU_CD
					sql.setString(++i, "");             // MODEL_CD
					sql.setString(++i, mi.getString("SALE_UNIT_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_UNIT_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_UNIT_CD"));
					sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
					sql.setString(++i, "");      // 메이커
					sql.setString(++i, "N");     // SET_YN
					sql.setString(++i, "0");     // GIFT_FLAG
					sql.setString(++i, "");      // GIFT_TYPE_CD
					sql.setString(++i, "");      // GIFT_AMT_TYPE
					sql.setString(++i, "");      // STYLE_CD
					sql.setString(++i, "");      // COLOR_CD
					sql.setString(++i, "");      // SIZE_CD
					sql.setString(++i, "");      // BOTTLE_CD
					sql.setString(++i, "");      // REMARK
					sql.setString(++i, "Y");     // 사용여부
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				}else{
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				//History
				sql.close();
				Map keys = new HashMap();
				keys.put("SKU_CD", newSkuCd);
				update(Util.getHistorySQL("PC_SKUMST", "PC_SKUHIST", "DPS", keys, "SKU_CD", strID));

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
	 *  의류단품(A) 스타일마스터, 의류단품(A)마스터
	 *  정보를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveAStylemst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			connect("pot");
			begin();
			String newSkuCd = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));	
			String strPumbunType = String2.nvl(form.getParam("strPumbunType"));	
			String strSkuType = String2.nvl(form.getParam("strSkuType"));	
			String strStyleType = String2.nvl(form.getParam("strStyleType"));					
			String dualTable = "";	
			Map rtnMap = null;
			String insStyleCdList = "";
			i = 0;
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {
					sql = new SqlWrapper();
					dualTable =  " WITH UPLOAD_EXCEL_DATA AS ( \n";		
					dualTable +=" SELECT ";
					dualTable += " '"+String2.trimToEmpty(mi.getString("STYLE_NAME"))                         + "' AS STYLE_NAME ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("RECP_NAME"))                          + "' AS RECP_NAME ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("STYLE_CD")),9)        + "' AS STYLE_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("STYLE_CD"))                           + "' AS STYLE_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("COLOR_CD")),10)       + "' AS COLOR_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("COLOR_CD"))                           + "' AS COLOR_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SIZE_CD")),11)        + "' AS SIZE_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SIZE_CD"))                            + "' AS SIZE_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SIZE_TYPE_CD")),12)   + "' AS SIZE_TYPE_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SIZE_TYPE_CD"))                       + "' AS SIZE_TYPE_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SEX_CD")),13)         + "' AS SEX_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SEX_CD"))                             + "' AS SEX_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("PUMMOK_CD")),0)       + "' AS PUMMOK_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("PUMMOK_CD"))                          + "' AS PUMMOK_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")),1)    + "' AS INPUT_PLU_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("INPUT_PLU_CD"))                       + "' AS INPUT_PLU_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("VEN_STYLE_CD")),14)   + "' AS VEN_STYLE_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("VEN_STYLE_CD"))                       + "' AS VEN_STYLE_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SALE_UNIT_CD")),3)    + "' AS SALE_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SALE_UNIT_CD"))                       + "' AS SALE_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_CD")),4)     + "' AS BAS_SPEC_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_CD"))                        + "' AS BAS_SPEC_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD")),5)+ "' AS BAS_SPEC_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD"))                   + "' AS BAS_SPEC_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_CD")),6)     + "' AS CMP_SPEC_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_CD"))                        + "' AS CMP_SPEC_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD")),7)+ "' AS CMP_SPEC_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD"))                   + "' AS CMP_SPEC_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD")),8)  + "' AS ORIGIN_AREA_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD"))                     + "' AS ORIGIN_AREA_CD ";
					dualTable += ",'"+mi.getString("SKU_CD")                                                  + "' AS SKU_CD ";
					dualTable += ",'"+mi.getString("CHECK_SUM")                                               + "' AS CHECK_SUM ";					
					dualTable += ",'"+mi.getString("BRAND_CD")                                                + "' AS BRAND_CD ";
					dualTable += ",'"+mi.getString("SUB_BRD_CD")                                              + "' AS SUB_BRD_CD ";
					dualTable += ",'"+mi.getString("PLAN_YEAR_CD")                                            + "' AS PLAN_YEAR_CD ";
					dualTable += ",'"+mi.getString("SEASON_CD")                                               + "' AS SEASON_CD ";
					dualTable += ",'"+mi.getString("ITEM_CD")                                                 + "' AS ITEM_CD ";
					dualTable += ",'"+mi.getString("SEQ_NO")                                                  + "' AS SEQ_NO ";
					if(mi.getString("STYLE_CD").length() == 11){
						dualTable += ",'Y' AS STYLE_CD_CHK ";
					}else{
						dualTable += ",'N' AS STYLE_CD_CHK ";
						
					}
					dualTable +=" FROM DUAL ";
					dualTable += ") ";
					
					i = 0;
					sql.put(dualTable);
					sql.put(svc.getQuery("SEL_ASTYLE"));
					sql.setString(++i, strPumbunCd);
					sql.setString(++i, strPumbunCd);

					rtnMap = selectMap(sql);					
					sql.close();
					
					boolean insStyle = true;
					
					if( insStyleCdList.indexOf("|"+mi.getString("STYLE_CD")+"|") > -1 ){
						insStyle = false;
					}
					String errCd = String2.nvl((String)rtnMap.get("ERROR_CD"));
					
					// 에러가 있지만 스타일 코드를 추가 하지 않을 경우 [022:중복된스타일코드]에러는 무시한다.
					if(!errCd.equals("")){
						if( insStyle || !errCd.equals("022"))
						    throw new Exception("[USER]"+"오류가 존재합니다. ["+errCd+"]");				
					}
					// 스타일 타일 코드를 추가
					if(insStyle){
						i = 0;						
						sql.put(svc.getQuery("INS_STYLEMST"));
						sql.setString(++i, strPumbunCd);
						sql.setString(++i, mi.getString("STYLE_CD"));
						sql.setString(++i, mi.getString("STYLE_NAME"));
						sql.setString(++i, mi.getString("RECP_NAME"));
						sql.setString(++i, mi.getString("PUMMOK_CD"));
						sql.setString(++i, mi.getString("BRAND_CD"));
						sql.setString(++i, mi.getString("SUB_BRD_CD"));
						sql.setString(++i, mi.getString("PLAN_YEAR_CD"));
						sql.setString(++i, mi.getString("SEASON_CD"));
						sql.setString(++i, mi.getString("ITEM_CD"));
						sql.setString(++i, mi.getString("SEQ_NO"));
						sql.setString(++i, "" );     // MNG_CD1
						sql.setString(++i, "" );     // MNG_CD2
						sql.setString(++i, "" );     // MNG_CD3
						sql.setString(++i, "" );     // MNG_CD4
						sql.setString(++i, "" );     // MNG_CD5
						sql.setString(++i, mi.getString("SIZE_TYPE_CD"));
						sql.setString(++i, "" );     // MAKER_CD
						sql.setString(++i, mi.getString("SEX_CD"));
						sql.setString(++i, "" );     // CURRENCY_CD
						sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
						sql.setString(++i, mi.getString("VEN_STYLE_CD"));
						sql.setString(++i, strStyleType );  // 의류단품구분
						sql.setString(++i, mi.getString("SALE_UNIT_CD"));
						sql.setString(++i, mi.getString("BAS_SPEC_CD"));
						sql.setString(++i, mi.getString("BAS_SPEC_UNIT_CD"));
						sql.setString(++i, mi.getString("CMP_SPEC_CD"));
						sql.setString(++i, mi.getString("CMP_SPEC_UNIT_CD"));
						sql.setString(++i, "");      // REMARK
						sql.setString(++i, "Y");     // 사용여부
						sql.setString(++i, strID);
						sql.setString(++i, strID);
						// 스타일 신규추가
						update(sql);
						sql.close();
						
						//History
						Map keys = new HashMap();
						keys.put("PUMBUN_CD", strPumbunCd);
						keys.put("STYLE_CD", mi.getString("STYLE_CD"));
						update(Util.getHistorySQL("PC_STYLEMST", "PC_STYLEHIST", "DPS", keys, "PUMBUN_CD,STYLE_CD", strID));
						sql.close();
						// 저장한 스타일 코드 리스트 
						insStyleCdList += "|"+mi.getString("STYLE_CD")+"|";
					}
					
					newSkuCd = mi.getString("SKU_CD");
					
					if( !mi.getString("INPUT_PLU_CD").equals("") && newSkuCd.equals("")){
						newSkuCd = String2.leftPad(mi.getString("INPUT_PLU_CD"), 13,'0');
						if(!Util.isSkuCdCheckSum(newSkuCd)){
							throw new Exception("[USER]"+"사용할수 없는 소스마킹코드입니다.");							
						}
					}
					//단품코드 자동발번
					if( newSkuCd.equals("")){
						sql.put(svc.getQuery("SEL_SKUMST_STYLE_NEW_CD"));
						Map map = selectMap( sql );
						newSkuCd = String2.nvl((String)map.get("NEW_SKU_CD"));
						if( newSkuCd.equals("")) {
							throw new Exception("[USER]"+"단품코드를 생성 할 수 없습니다.");
						}
						String checkSum = Util.getSkuCdCheckSum(newSkuCd);
						newSkuCd = newSkuCd + checkSum;
						sql.close();
					//단품코드 중복체크
					}else{
						i = 0;
						sql.put(svc.getQuery("SEL_SKUMST_SKU_CD_CNT"));							
						sql.setString(++i, newSkuCd);
						Map map = selectMap( sql );							
						String skuCdCnt = String2.nvl((String)map.get("CNT"));
						if( !skuCdCnt.equals("0")) {
							throw new Exception("[USER]"+"중복되는 단품코드 입니다.");
						}
						sql.close();
					}				
					
					i = 0;
					sql.put(svc.getQuery("INS_SKUMST"));
					sql.setString(++i, newSkuCd);
					sql.setString(++i, mi.getString("SKU_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, strPumbunType );
					sql.setString(++i, strPumbunCd );
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, strSkuType );    // 단품종류
					sql.setString(++i, strStyleType );  // 의류단품구분
					sql.setString(++i, (mi.getString("INPUT_PLU_CD").equals("")?"1":"2"));            // PLU 구분
					sql.setString(++i, mi.getString("INPUT_PLU_CD"));             // INPUT_PLU_CD
					sql.setString(++i, mi.getString("VEN_STYLE_CD"));             // MODEL_CD
					sql.setString(++i, mi.getString("SALE_UNIT_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_UNIT_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_UNIT_CD"));
					sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
					sql.setString(++i, "");      // 메이커
					sql.setString(++i, "N");     // SET_YN
					sql.setString(++i, "0");     // GIFT_FLAG
					sql.setString(++i, "");      // GIFT_TYPE_CD
					sql.setString(++i, "");      // GIFT_AMT_TYPE
					sql.setString(++i, mi.getString("STYLE_CD"));      // STYLE_CD
					sql.setString(++i, mi.getString("COLOR_CD"));      // COLOR_CD
					sql.setString(++i, mi.getString("SIZE_CD"));      // SIZE_CD
					sql.setString(++i, "");      // BOTTLE_CD
					sql.setString(++i, "");      // REMARK
					sql.setString(++i, "Y");     // 사용여부
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				}else{
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				//History
				sql.close();
				Map keys = new HashMap();
				keys.put("SKU_CD", newSkuCd);
				update(Util.getHistorySQL("PC_SKUMST", "PC_SKUHIST", "DPS", keys, "SKU_CD", strID));

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
	 *  의류단품(B) 스타일마스터, 의류단품(B)마스터
	 *  정보를 저장한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveBStylemst(ActionForm form, MultiInput mi, String strID) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			connect("pot");
			begin();
			String newSkuCd = "";
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));	
			String strPumbunType = String2.nvl(form.getParam("strPumbunType"));	
			String strSkuType = String2.nvl(form.getParam("strSkuType"));	
			String strStyleType = String2.nvl(form.getParam("strStyleType"));					
			String dualTable = "";	
			Map rtnMap = null;
			String insStyleCdList = "";
			i = 0;
			while (mi.next()) {
				sql.close();
				if ( mi.IS_INSERT()) {
					sql = new SqlWrapper();
					dualTable =  " WITH UPLOAD_EXCEL_DATA AS ( \n";	
					dualTable +=" SELECT ";
					dualTable += " '"+String2.trimToEmpty(mi.getString("STYLE_NAME"))                         + "' AS STYLE_NAME ";			
					dualTable += ",'"+String2.trimToEmpty(mi.getString("RECP_NAME"))                          + "' AS RECP_NAME ";	
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BRAND_CD")),15)       + "' AS BRAND_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BRAND_CD"))                           + "' AS BRAND_CD ";		
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SUB_BRD_CD")),16)     + "' AS SUB_BRD_CD_LEN ";	
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SUB_BRD_CD"))                         + "' AS SUB_BRD_CD ";	
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD1")),17)        + "' AS MNG_CD1_LEN ";			
					dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD1"))                            + "' AS MNG_CD1 ";	
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD2")),18)        + "' AS MNG_CD2_LEN ";		
					dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD2"))                            + "' AS MNG_CD2 ";	
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD3")),19)        + "' AS MNG_CD3_LEN ";		
					dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD3"))                            + "' AS MNG_CD3 ";	
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD4")),20)        + "' AS MNG_CD4_LEN ";		
					dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD4"))                            + "' AS MNG_CD4 ";	
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("MNG_CD5")),21)        + "' AS MNG_CD5_LEN ";		
					dualTable += ",'"+String2.trimToEmpty(mi.getString("MNG_CD5"))                            + "' AS MNG_CD5 ";		
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SEX_CD")),13)         + "' AS SEX_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SEX_CD"))                             + "' AS SEX_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("PUMMOK_CD")),0)       + "' AS PUMMOK_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("PUMMOK_CD"))                          + "' AS PUMMOK_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("INPUT_PLU_CD")),1)    + "' AS INPUT_PLU_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("INPUT_PLU_CD"))                       + "' AS INPUT_PLU_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("VEN_STYLE_CD")),14)   + "' AS VEN_STYLE_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("VEN_STYLE_CD"))                       + "' AS VEN_STYLE_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("SALE_UNIT_CD")),3)    + "' AS SALE_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("SALE_UNIT_CD"))                       + "' AS SALE_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_CD")),4)     + "' AS BAS_SPEC_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_CD"))                        + "' AS BAS_SPEC_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD")),5)+ "' AS BAS_SPEC_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("BAS_SPEC_UNIT_CD"))                   + "' AS BAS_SPEC_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_CD")),6)     + "' AS CMP_SPEC_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_CD"))                        + "' AS CMP_SPEC_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD")),7)+ "' AS CMP_SPEC_UNIT_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("CMP_SPEC_UNIT_CD"))                   + "' AS CMP_SPEC_UNIT_CD ";
					dualTable += ",'"+checkCodeLength(String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD")),8)  + "' AS ORIGIN_AREA_CD_LEN ";
					dualTable += ",'"+String2.trimToEmpty(mi.getString("ORIGIN_AREA_CD"))                     + "' AS ORIGIN_AREA_CD ";	
					dualTable += ",'"+mi.getString("SKU_CD")                                                  + "' AS SKU_CD ";
					dualTable += ",'"+mi.getString("CHECK_SUM")                                               + "' AS CHECK_SUM ";		
					dualTable += ",'"+mi.getString("STYLE_CD")                                                + "' AS STYLE_CD ";		
					dualTable +=" FROM DUAL ";
					dualTable += ") ";
					
					i = 0;
					sql.put(dualTable);
					sql.put(svc.getQuery("SEL_BSTYLE"));
					sql.setString(++i, strPumbunCd);
					sql.setString(++i, strPumbunCd);

					rtnMap = selectMap(sql);					
					sql.close();
					
					boolean insStyle = true;
					
					if( insStyleCdList.indexOf("|"+mi.getString("STYLE_CD")+"|") > -1 ){
						insStyle = false;
					}
					String errCd = String2.nvl((String)rtnMap.get("ERROR_CD"));
					
					// 에러가 있지만 스타일 코드를 추가 하지 않을 경우 [022:중복된스타일코드]에러는 무시한다.
					if(!errCd.equals("")){
						if( insStyle || !errCd.equals("022"))
						    throw new Exception("[USER]"+"오류가 존재합니다. ["+errCd+"]");				
					}
					// 스타일 타일 코드를 추가
					if(insStyle){
						i = 0;						
						sql.put(svc.getQuery("INS_STYLEMST"));
						sql.setString(++i, strPumbunCd);
						sql.setString(++i, mi.getString("STYLE_CD"));
						sql.setString(++i, mi.getString("STYLE_NAME"));
						sql.setString(++i, mi.getString("RECP_NAME"));
						sql.setString(++i, mi.getString("PUMMOK_CD"));
						sql.setString(++i, mi.getString("BRAND_CD"));
						sql.setString(++i, mi.getString("SUB_BRD_CD"));
						sql.setString(++i, "");      // PLAN_YEAR_CD
						sql.setString(++i, "");      // SEASON_CD
						sql.setString(++i, "");      // ITEM_CD
						sql.setString(++i, "");      // SEQ_NO
						sql.setString(++i, mi.getString("MNG_CD1") );     // MNG_CD1
						sql.setString(++i, mi.getString("MNG_CD2") );     // MNG_CD2
						sql.setString(++i, mi.getString("MNG_CD3") );     // MNG_CD3
						sql.setString(++i, mi.getString("MNG_CD4") );     // MNG_CD4
						sql.setString(++i, mi.getString("MNG_CD5") );     // MNG_CD5
						sql.setString(++i, "");                            //SIZE_TYPE_CD
						sql.setString(++i, "" );     // MAKER_CD
						sql.setString(++i, mi.getString("SEX_CD"));
						sql.setString(++i, "" );     // CURRENCY_CD
						sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
						sql.setString(++i, mi.getString("VEN_STYLE_CD"));
						sql.setString(++i, strStyleType );  // 의류단품구분
						sql.setString(++i, mi.getString("SALE_UNIT_CD"));
						sql.setString(++i, mi.getString("BAS_SPEC_CD"));
						sql.setString(++i, mi.getString("BAS_SPEC_UNIT_CD"));
						sql.setString(++i, mi.getString("CMP_SPEC_CD"));
						sql.setString(++i, mi.getString("CMP_SPEC_UNIT_CD"));
						sql.setString(++i, "");      // REMARK
						sql.setString(++i, "Y");     // 사용여부
						sql.setString(++i, strID);
						sql.setString(++i, strID);
						// 스타일 신규추가
						update(sql);
						sql.close();
						
						//History
						Map keys = new HashMap();
						keys.put("PUMBUN_CD", strPumbunCd);
						keys.put("STYLE_CD", mi.getString("STYLE_CD"));
						update(Util.getHistorySQL("PC_STYLEMST", "PC_STYLEHIST", "DPS", keys, "PUMBUN_CD,STYLE_CD", strID));
						sql.close();
						// 저장한 스타일 코드 리스트 
						insStyleCdList += "|"+mi.getString("STYLE_CD")+"|";
					}
					
					newSkuCd = mi.getString("SKU_CD");
					
					if( !mi.getString("INPUT_PLU_CD").equals("") && newSkuCd.equals("")){
						newSkuCd = String2.leftPad(mi.getString("INPUT_PLU_CD"), 13,'0');
						if(!Util.isSkuCdCheckSum(newSkuCd)){
							throw new Exception("[USER]"+"사용할수 없는 소스마킹코드입니다.");							
						}
					}
					//단품코드 자동발번
					if( newSkuCd.equals("")){
						sql.put(svc.getQuery("SEL_SKUMST_STYLE_NEW_CD"));
						Map map = selectMap( sql );
						newSkuCd = String2.nvl((String)map.get("NEW_SKU_CD"));
						if( newSkuCd.equals("")) {
							throw new Exception("[USER]"+"단품코드를 생성 할 수 없습니다.");
						}
						String checkSum = Util.getSkuCdCheckSum(newSkuCd);
						newSkuCd = newSkuCd + checkSum;
						sql.close();
					//단품코드 중복체크
					}else{
						i = 0;
						sql.put(svc.getQuery("SEL_SKUMST_SKU_CD_CNT"));							
						sql.setString(++i, newSkuCd);
						Map map = selectMap( sql );							
						String skuCdCnt = String2.nvl((String)map.get("CNT"));
						if( !skuCdCnt.equals("0")) {
							throw new Exception("[USER]"+"중복되는 단품코드 입니다.");
						}
						sql.close();
					}				
					
					i = 0;
					
					sql.put(svc.getQuery("INS_SKUMST"));
					sql.setString(++i, newSkuCd);
					sql.setString(++i, mi.getString("STYLE_NAME"));
					sql.setString(++i, mi.getString("RECP_NAME"));
					sql.setString(++i, strPumbunType );
					sql.setString(++i, strPumbunCd );
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					sql.setString(++i, strSkuType );    // 단품종류
					sql.setString(++i, strStyleType );  // 의류단품구분
					sql.setString(++i, (mi.getString("INPUT_PLU_CD").equals("")?"1":"2"));            // PLU 구분
					sql.setString(++i, mi.getString("INPUT_PLU_CD"));             // INPUT_PLU_CD
					sql.setString(++i, mi.getString("VEN_STYLE_CD"));             // MODEL_CD
					sql.setString(++i, mi.getString("SALE_UNIT_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_CD"));
					sql.setString(++i, mi.getString("CMP_SPEC_UNIT_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_CD"));
					sql.setString(++i, mi.getString("BAS_SPEC_UNIT_CD"));
					sql.setString(++i, mi.getString("ORIGIN_AREA_CD"));
					sql.setString(++i, "");      // 메이커
					sql.setString(++i, "N");     // SET_YN
					sql.setString(++i, "0");     // GIFT_FLAG
					sql.setString(++i, "");      // GIFT_TYPE_CD
					sql.setString(++i, "");      // GIFT_AMT_TYPE
					sql.setString(++i, mi.getString("STYLE_CD"));      // STYLE_CD
					sql.setString(++i, "");      // COLOR_CD
					sql.setString(++i, "");      // SIZE_CD
					sql.setString(++i, "");      // BOTTLE_CD
					sql.setString(++i, "");      // REMARK
					sql.setString(++i, "Y");     // 사용여부
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				}else{
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				//History
				sql.close();
				Map keys = new HashMap();
				keys.put("SKU_CD", newSkuCd);
				update(Util.getHistorySQL("PC_SKUMST", "PC_SKUHIST", "DPS", keys, "SKU_CD", strID));

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
	 * 입력된 코드의 자리수를 체크한다. 
	 * 
	 * @param codeStr
	 * @param codeFlag
	 * @return
	 */
	private String checkCodeLength( String codeStr, int codeFlag ){
		String rtnErrCOde = "";
		String[] tmp = null;
		switch(codeFlag){
			case 0:  // PUMMOK_CD 
				if(codeStr.length() > 8){rtnErrCOde = "100";}
				break;
			case 1:  // INPUT_PLU_CD 
				if(codeStr.length() > 13){rtnErrCOde = "101";}
				break;
			case 2:  // MODEL_CD 
				if(codeStr.length() > 24)
				{
					rtnErrCOde = "102";
				}else if(codeStr.length() == 0)
				{
					rtnErrCOde = "202";
				}
				break;
			case 3:  // SALE_UNIT_CD 
				if(codeStr.length() > 3){rtnErrCOde = "103";}
				break;
			case 4:  // BAS_SPEC_CD
				tmp = codeStr.split("\\.");
				if(tmp.length == 0)
					break;
				if(tmp.length > 2 ){rtnErrCOde = "052";	}
				if( tmp.length == 1){if(tmp[0].length() > 6){rtnErrCOde = "104";}
				}else{
					if(tmp[0].length() > 6 || tmp[1].length() > 2 ){rtnErrCOde = "104";}					
				}
				break;
			case 5:  // BAS_SPEC_UNIT_CD 
				if(codeStr.length() > 3){rtnErrCOde = "105";}
				break;
			case 6:  // CMP_SPEC_CD 
				tmp = codeStr.split("\\.");
				if(tmp.length == 0)
					break;
				if(tmp.length > 2 ){rtnErrCOde = "053";}
				if( tmp.length == 1){
					if(tmp[0].length() > 6){rtnErrCOde = "106";}
				}else{
					if(tmp[0].length() > 6 || tmp[1].length() > 2 ){rtnErrCOde = "106";}					
				}
				break;
			case 7:  // CMP_SPEC_UNIT_CD 
				if(codeStr.length() > 3){rtnErrCOde = "107";}
				break;
			case 8:  // ORIGIN_AREA_CD 
				if(codeStr.length() > 3){rtnErrCOde = "108";}
				break;
			case 9:  // STYLE_CD (A) 
				if(codeStr.length() > 14){rtnErrCOde = "109";}
				break;
			case 10:  // COLOR_CD 
				if(codeStr.length() > 3){rtnErrCOde = "110";}
				break;
			case 11:  // SIZE_CD 
				if(codeStr.length() > 3){rtnErrCOde = "111";}
				break;
			case 12:  // SIZE_TYPE_CD 
				if(codeStr.length() > 1){rtnErrCOde = "112";}
				break;
			case 13:  // SEX_CD 
				if(codeStr.length() > 1){rtnErrCOde = "113";}
				break;
			case 14:  // VEN_STYLE_CD 
				if(codeStr.length() > 24){rtnErrCOde = "114";}
				break;
			case 15:  // BRAND_CD 
				if(codeStr.length() > 5){rtnErrCOde = "115";}
				break;
			case 16:  // SUB_BRD_CD 
				if(codeStr.length() > 2){rtnErrCOde = "116";}
				break;
			case 17:  // MNG_CD1 
				if(codeStr.length() > 10){rtnErrCOde = "117";}
				break;
			case 18:  // MNG_CD2 
				if(codeStr.length() > 10){rtnErrCOde = "118";}
				break;
			case 19:  // MNG_CD3 
				if(codeStr.length() > 10){rtnErrCOde = "119";}
				break;
			case 20:  // MNG_CD4 
				if(codeStr.length() > 10){rtnErrCOde = "120";}
				break;
			case 21:  // MNG_CD5 
				if(codeStr.length() > 10){rtnErrCOde = "121";}
				break;
		}
		
		return rtnErrCOde;
	}
}
