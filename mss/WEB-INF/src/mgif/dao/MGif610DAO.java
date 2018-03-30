/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>제휴쿠폰 정산관리</p>
 * 
 * @created on 1.0, 2011/04/28
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MGif610DAO extends AbstractDAO {

	/**
	 * 결제내역조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPayDtl(ActionForm form)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStoreCd = null;
		String strCalYM   = null;
		String strVenCd   = null;

		try {
			//파라미터 값 가져오기
			strStoreCd  = String2.trimToEmpty(form.getParam("strStoreCd")); //본사점구분코드
			strCalYM    = String2.trimToEmpty(form.getParam("strCalYM"));   //정산년월
			strVenCd    = String2.trimToEmpty(form.getParam("strVenCd"));   //제휴협력사코드

			strLoc = "SEL_PAY_DTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strCalYM);
			
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strCalYM);
			sql.setString(i++, strVenCd);

			sql.setString(i++, strStoreCd);
			sql.setString(i++, strVenCd);
			sql.setString(i++, strCalYM+"01");
			sql.setString(i++, strCalYM+"31");

			sql.setString(i++, strCalYM+"31");
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 정산내역조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCalDtl(ActionForm form)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStoreCd = null;
		String strCalYM   = null;
		String strVenCd   = null;

		try {
			//파라미터 값 가져오기
			strStoreCd  = String2.trimToEmpty(form.getParam("strStoreCd")); //본사점구분코드
			strCalYM    = String2.trimToEmpty(form.getParam("strCalYM"));   //정산년월
			strVenCd    = String2.trimToEmpty(form.getParam("strVenCd"));   //제휴협력사코드

			strLoc = "SEL_CAL_DTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strCalYM);
			sql.setString(i++, strStoreCd);
			
			if (!"".equals(strVenCd)){
				sql.put(svc.getQuery("SEL_CAL_DTL_WHERE_VEN_CD"));
				sql.setString(i++, strVenCd);
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 제휴쿠폰 정산처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret        = 0;
		int res        = 0;
		int i          = 0;
		Service svc    = null;
		SqlWrapper sql = null;
		try {
			begin();
			connect("pot");
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				i   = 0;
				res = 0;
				sql.put(svc.getQuery("UST_JOIN_CAL"));
				
				sql.setString(++i, mi.getString("CAL_YM"));
				sql.setString(++i, mi.getString("STR_CD"));                                                                
				sql.setString(++i, "1");                                    // -- 정산유형(1:제휴/2:가맹점/3:위탁판매)                    
				sql.setString(++i, mi.getString("VEN_CD"));                                       
				sql.setString(++i, "2");                                    // -- 지급수취구분(1:지급/2:수취)                               
				sql.setString(++i, mi.getString("PAY_TYPE"));                                                              
				sql.setInt(++i, mi.getInt("BOND_AMT"));
				sql.setInt(++i, mi.getInt("MONTH_PAY_AMT"));
				sql.setInt(++i, mi.getInt("REAL_PAY_AMT"));
				sql.setString(++i, mi.getString("FEE_RATE"));
				sql.setInt(++i, mi.getInt("FEE_SUP_AMT"));
				sql.setInt(++i, mi.getInt("FEE_VAT_AMT"));
				sql.setInt(++i, mi.getInt("FEE_TOT_AMT"));
				sql.setInt(++i, mi.getInt("CAL_AMT"));
				sql.setString(++i, mi.getString("TAX_SUP_DT"));
				sql.setInt(++i, mi.getInt("CONT_AMT"));
				sql.setString(++i, strUserId);
				
				//제휴쿠폰 정산처리
				res = update(sql);
				
				if( res != 1) {
					throw new Exception("[USER]"+"정산처리를 실패하였습니다.");
				}
				
				ret += res;
				sql.close();
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
