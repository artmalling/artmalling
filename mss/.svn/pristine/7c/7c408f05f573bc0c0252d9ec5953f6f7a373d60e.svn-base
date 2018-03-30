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
 * <p>가맹점 정산</p>
 * 
 * @created on 1.0, 2011/04/21
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MGif607DAO extends AbstractDAO {

	/**
	 * 회수내역조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchColDtl(ActionForm form)
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
			strVenCd    = String2.trimToEmpty(form.getParam("strVenCd"));   //가맹점코드

			strLoc = "SEL_COL_DTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strCalYM);
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strVenCd);
			sql.setString(i++, strCalYM+"01");
			sql.setString(i++, strCalYM+"31");
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strVenCd);
			sql.setString(i++, strCalYM+"01");
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
			strVenCd    = String2.trimToEmpty(form.getParam("strVenCd"));   //가맹점코드

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
			
			sql.put(svc.getQuery("SEL_CAL_DTL_ORDER"));
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 정산상세내역조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCalDtl2(ActionForm form)
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
			strVenCd    = String2.trimToEmpty(form.getParam("strVenCd"));   //가맹점코드

			strLoc = "SEL_CALDTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strCalYM);
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strCalYM);
			sql.setString(i++, strVenCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	
	/**
	 * 회수내역 정산처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput[] mi, String strUserId)
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
			while(mi[0].next()){                                                                  
				i   = 0;                                                                       
				res = 0;                                                                       
				sql.put(svc.getQuery("UST_JOIN_CAL"));                                                        
				sql.setString(++i, mi[0].getString("CAL_YM"));                                                             
				sql.setString(++i, mi[0].getString("DRAWL_STR"));                                                          
				sql.setString(++i, mi[0].getString("VEN_CD"));                                                             
				sql.setInt(++i, mi[0].getInt("OUT_PAY_AMT1"));                                                               
				sql.setInt(++i, mi[0].getInt("OUT_PAY_AMT2"));                                                               
				sql.setInt(++i, mi[0].getInt("TOT_OUT_PAY_AMT"));  
				sql.setString(++i, mi[0].getString("BRCH_REC_FEE_RATE"));      
				sql.setInt(++i, mi[0].getInt("FEE_SUP_AMT"));                                                                
				sql.setInt(++i, mi[0].getInt("FEE_VAT_AMT"));                                                       
				sql.setInt(++i, mi[0].getInt("FEE_TOT_AMT"));    
				sql.setInt(++i, mi[0].getInt("CAL_AMT"));   
				sql.setString(++i, strUserId);                                                                       
				//회수내역 정산처리                                                                                          
				res = update(sql);                                                                                   
				if( res != 1) {
					throw new Exception("[USER]"+"정산처리를 실패하였습니다.");
				}
				ret += res;
				sql.close();
				
				// 가맹점 정산 상세 내역 삭제 
				i   = 0;                                                                       
				res = 0;                                                                       
				sql.put(svc.getQuery("DEL_CALDTL"));                                                        
				sql.setString(++i, mi[0].getString("CAL_YM"));                                                             
				sql.setString(++i, mi[0].getString("DRAWL_STR"));                                                          
				sql.setString(++i, mi[0].getString("VEN_CD"));                                                             
				//회수내역 정산처리                                                                                          
				res = update(sql);                                                                                   
				/*if( res != 1) {
					throw new Exception("[USER]"+"정산처리를 실패하였습니다.");
				}*/
				sql.close();
			}
			
			// 가맹점 정산 상세 내역 저장
			while(mi[1].next()){                                                                  
				i   = 0;                                                                       
				res = 0;                                                                       
				sql.put(svc.getQuery("INS_CALDTL"));                                                        
				sql.setString(++i, mi[1].getString("CAL_YM"));                                                             
				sql.setString(++i, mi[1].getString("STR_CD"));                                                          
				sql.setString(++i, mi[1].getString("VEN_CD"));      
				sql.setString(++i, mi[1].getString("CAL_YM"));                                                             
				sql.setString(++i, mi[1].getString("STR_CD"));                                                          
				sql.setString(++i, mi[1].getString("VEN_CD"));
				sql.setInt(++i, mi[1].getInt("ALLI_CD"));                                                               
				sql.setInt(++i, mi[1].getInt("BOND_AMT2"));                                                               
				sql.setString(++i, strUserId);
				sql.setString(++i, strUserId);        
				//회수내역 정산처리                                                                                          
				res = update(sql);                                                                                   
				if( res != 1) {
					throw new Exception("[USER]"+"정산처리를 실패하였습니다.");
				}
				//ret += res;
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
