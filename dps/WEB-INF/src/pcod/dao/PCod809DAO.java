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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>CMS쿠폰관리</p>
 * 
 * @created  on 1.0, 2010/05/25
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod809DAO extends AbstractDAO {

	/**
	 * CMS쿠폰 마스터 을 조회한다.
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

	    
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strAppDtFrom = String2.nvl(form.getParam("strAppDtFrom"));
		String strAppDtTo = String2.nvl(form.getParam("strAppDtTo"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		String strVenName = URLDecoder.decode( String2.nvl(form.getParam("strVenName")), "UTF-8");
		String strSkuCd = String2.nvl(form.getParam("strSkuCd"));
		String strSkuName = URLDecoder.decode( String2.nvl(form.getParam("strSkuName")), "UTF-8");
		String strCpnCd = String2.nvl(form.getParam("strCpnCd"));
		

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_CMSCPNMST") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strAppDtFrom);
		sql.setString(i++, strAppDtTo);
		
		if( !strVenCd.equals("") 
				|| !strVenName.equals("")
				|| !strSkuCd.equals("")
				|| !strSkuName.equals("") 
				|| !strCpnCd.equals("") ){
			sql.setString(i++, strVenCd);
			sql.setString(i++, strVenName);
			sql.setString(i++, strSkuCd);
			sql.setString(i++, strSkuName);
			strQuery += svc.getQuery("SEL_CMSCPNMST_WHERE") + "\n";
		}
		
		if( !strCpnCd.equals("") ){
			sql.setString(i++, strCpnCd);
		    strQuery += svc.getQuery("SEL_CMSCPNMST_WHERE_CPN_CD") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_CMSCPNMST_ORDER") ;
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * CMS쿠폰 엑셀업로드 데이터를 검증한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchExcelData(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		String dualTable = " WITH UPLOAD_EXCEL_DATA AS ( ";		
		while (mi.next()) {
			if( i > 0)
				dualTable += "\n UNION ALL ";
			dualTable +=" \n ";
			dualTable +=" SELECT ";
			dualTable += " '"+strStrCd                                           + "'         AS STR_CD ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CPN_CD"))        + "'         AS CPN_CD ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CPN_NAME"))      + "'         AS CPN_NAME ";
			dualTable += ",LPAD('"+String2.trimToEmpty(mi.getString("SKU_CD"))   + "',13,'0') AS SKU_CD ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CPN_QTY"))       + "'         AS CPN_QTY ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("CPN_AMT"))       + "'         AS CPN_AMT ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("APP_S_DT"))      + "'         AS APP_S_DT ";
			dualTable += ",'"+String2.trimToEmpty(mi.getString("APP_E_DT"))      + "'         AS APP_E_DT ";
			dualTable += ",'"+((Util.isSkuCdCheckSum( String2.leftPad(String2.trimToEmpty(mi.getString("SKU_CD")), 13, '0'))) ? "Y":"N")+"' AS CHECK_SUM_YN ";
			dualTable +=" FROM DUAL ";
			i++;
		}
		dualTable += ") \n";
		
		strQuery = dualTable;
		strQuery += svc.getQuery("SEL_EXCEL_CMSCPNMST") ;
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	/**
	 * CMS쿠폰,
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
		
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {

					// 중복 코드인지 조회 
					sql.put(svc.getQuery("SEL_CMSCPNMST_CPN_CD_CNT"));							
					sql.setString(1,  mi.getString("STR_CD"));								
					sql.setString(2,  mi.getString("SKU_CD"));								
					sql.setString(3,  mi.getString("CPN_CD"));								
					sql.setString(4,  mi.getString("APP_S_DT"));								
					Map map = selectMap( sql );							
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"["+mi.getString("CPN_CD")+"] 중복 데이터가 존재합니다.");
					}
					// 단품코드 기간중복여부 체크
					sql.close();
					sql.put(svc.getQuery("SEL_CMSCPNMST_SKU_DUP_CNT"));							
					sql.setString(1,  mi.getString("STR_CD"));								
					sql.setString(2,  mi.getString("SKU_CD"));								
					sql.setString(3,  mi.getString("APP_S_DT"));							
					sql.setString(4,  mi.getString("APP_E_DT"));						
					map = selectMap( sql );							
					cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"["+mi.getString("SKU_CD")
								                     +","+mi.getString("APP_S_DT")
								                     +"~"+mi.getString("APP_E_DT")+"]<br>단품이 중복되는 기간이 존재합니다.");
					}
					
					sql.close();
					i = 0;				
					sql.put(svc.getQuery("INS_CMSCPNMST"));
					sql.setString( ++i, mi.getString("STR_CD"   ));
					sql.setString( ++i, mi.getString("CPN_CD"   ));
					sql.setString( ++i, mi.getString("CPN_NAME" ));
					sql.setString( ++i, mi.getString("SKU_CD"   ));
					sql.setString( ++i, mi.getString("CPN_QTY"  ));
					sql.setString( ++i, mi.getString("CPN_AMT"  ));
					sql.setString( ++i, mi.getString("APP_S_DT" ));
					sql.setString( ++i, mi.getString("APP_E_DT" ));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				} else if (mi.IS_UPDATE()){

					// 단품코드 기간중복여부 체크
					sql.close();
					sql.put(svc.getQuery("SEL_CMSCPNMST_SKU_DUP_CNT"));							
					sql.setString(1,  mi.getString("STR_CD"));								
					sql.setString(2,  mi.getString("SKU_CD"));								
					sql.setString(3,  mi.getString("APP_S_DT"));							
					sql.setString(4,  mi.getString("APP_E_DT"));						
					Map map = selectMap( sql );							
					String cnt = String2.nvl((String)map.get("CNT"));
					if( cnt.equals("2")) {
						throw new Exception("[USER]"+"["+mi.getString("SKU_CD")
								                     +","+mi.getString("APP_S_DT")
								                     +"~"+mi.getString("APP_E_DT")+"]<br>단품이 중복되는 기간이 존재합니다.");
					}
					sql.close();					
					i = 0;							
					sql.put(svc.getQuery("UPD_CMSCPNMST"));
					sql.setString( ++i, mi.getString("CPN_NAME"     ));
					sql.setString( ++i, mi.getString("CPN_QTY"      ));
					sql.setString( ++i, mi.getString("CPN_AMT"      ));
					sql.setString( ++i, mi.getString("APP_S_DT"     ));
					sql.setString( ++i, mi.getString("APP_E_DT"     ));
					sql.setString(++i, strID);
					sql.setString( ++i, mi.getString("STR_CD"       ));
					sql.setString( ++i, mi.getString("CPN_CD"       ));
					sql.setString( ++i, mi.getString("SKU_CD"       ));
					sql.setString( ++i, mi.getString("ORG_APP_S_DT" ));
					
				} else{
					continue;
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "처리 하지 못했습니다.");
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
	 * CMS쿠폰,
	 * 삭제  처리한다.
	 * 
	 * @param form
	 * @param mi
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

			while (mi.next()) {
				sql.close();				
				if (mi.IS_DELETE()){
					i = 0;							
					sql.put(svc.getQuery("DEL_CMSCPNMST"));
					sql.setString( ++i, mi.getString("STR_CD"       ));
					sql.setString( ++i, mi.getString("CPN_CD"       ));
					sql.setString( ++i, mi.getString("SKU_CD"       ));
					sql.setString( ++i, mi.getString("ORG_APP_S_DT" ));
				}else{
					continue;
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "처리 하지 못했습니다.");
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
