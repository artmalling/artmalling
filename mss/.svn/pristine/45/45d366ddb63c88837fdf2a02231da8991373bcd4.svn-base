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
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>자사상품권 정산</p>
 * 
 * @created  on 1.0, 2011/05/26
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif619DAO extends AbstractDAO {
	/**
	 * 회수 마스터 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getTotal(ActionForm form) throws Exception {

		List ret[] = new List[2];
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSdt = String2.nvl(form.getParam("strYM"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_TOTAL") + "\n";
		sql.put(strQuery);
		sql.setString(1, strStrCd);
		sql.setString(2, strStrCd);
		sql.setString(3, strStrCd);
		sql.setString(4, strSdt);
		ret[0] = select2List(sql);
		
		sql.close();
		strQuery = svc.getQuery("SEL_SUB_TOTAL") + "\n";
		sql.put(strQuery);
		sql.setString(1, strStrCd);
		sql.setString(2, strStrCd);
		sql.setString(3, strStrCd);
		sql.setString(4, strSdt);
		ret[1] = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 자사 상품권 회수 상세내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail(ActionForm form) throws Exception {

		List ret[] = new List[4];
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSdt = String2.nvl(form.getParam("strYM"));
		String strSaleStrCd = String2.nvl(form.getParam("strSaleStrCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleStrCd);
		sql.setString(i++, strSdt);
		sql.setString(i++, strStrCd);
		ret[0] = select2List(sql);
		
		sql.close();
		i = 1;
		strQuery = svc.getQuery("SEL_GIFTCAL") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strSdt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleStrCd);
		ret[1] = select2List(sql);
		
		sql.close();
		i = 1;
		strQuery = svc.getQuery("SEL_SAVEDATA_MST") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleStrCd);
		sql.setString(i++, strSdt);
		ret[2] = select2List(sql);
		
		sql.close();
		i = 1;
		strQuery = svc.getQuery("SEL_SAVEDATA_DTL") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleStrCd);
		sql.setString(i++, strSdt);
		ret[3] = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 자사상품권 자료 생성
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			if(form.getParam("desSign").equals("D")){
				// 이전 정산 내용 삭제
				i = 1;
				sql.close();
				sql.put(svc.getQuery("DEL_GIFTCAL_MST"));
				sql.setString(i++, form.getParam("strYM"));
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, form.getParam("strSaleStrCd"));
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				i = 1;
				sql.close();
				sql.put(svc.getQuery("DEL_GIFTCAL_DTL"));
				sql.setString(i++, form.getParam("strYM"));
				sql.setString(i++, form.getParam("strStrCd"));
				sql.setString(i++, form.getParam("strSaleStrCd"));
				res = update(sql);
				if (res == 0) {                                                             
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"                       
							+ "데이터 입력을 하지 못했습니다.");                                         
				} 
			}
			
			// 정산 master 등록 
			while (mi[0].next()) {
				i = 1;
				sql.close();    
				sql.put(svc.getQuery("INS_GIFTCAL_MST"));                         
				sql.setString(i++, mi[0].getString("CAL_YM"));                       
				sql.setString(i++, mi[0].getString("STR_CD"));                       
				sql.setString(i++, mi[0].getString("SALE_STR"));                     
				sql.setString(i++, mi[0].getString("DT"));                           
				sql.setString(i++, mi[0].getString("CAL_QTY"));                   
				sql.setString(i++, mi[0].getString("CAL_AMT"));                   
				sql.setString(i++, userId);
				sql.setString(i++, userId);
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}
			
			// 정산 detail 등록 
			while (mi[1].next()) {
				i = 1;
				sql.close();                                                      
				sql.put(svc.getQuery("INS_GIFTCAL_DTL"));                         
				sql.setString(i++, mi[1].getString("CAL_YM"));                                       
				sql.setString(i++, mi[1].getString("STR_CD"));                                       
				sql.setString(i++, mi[1].getString("SALE_STR"));                                     
				sql.setString(i++, mi[1].getString("DT"));      
				sql.setString(i++, mi[1].getString("CAL_YM"));     
				sql.setString(i++, mi[1].getString("STR_CD"));                
				sql.setString(i++, mi[1].getString("SALE_STR"));  
				sql.setString(i++, mi[1].getString("DT"));  
				sql.setString(i++, mi[1].getString("ISSUE_TYPE"));     
				sql.setString(i++, mi[1].getString("GIFT_AMT_TYPE"));    
				sql.setString(i++, mi[1].getString("GIFT_TYPE_CD"));    
				sql.setString(i++, mi[1].getString("GIFTCARD_NO")); 
				sql.setString(i++, mi[1].getString("CAL_AMT"));  
				sql.setString(i++, mi[1].getString("CAL_QTY"));                                
				sql.setString(i++, userId);                                                 
				sql.setString(i++, userId);                                                 
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
	
	/**
	 * 자사상품권 자료 확정
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int confirm(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				i = 1;
				sql.close();
				sql.put(svc.getQuery("UPD_GIFTCAL"));
				sql.setString(i++, userId);
				sql.setString(i++, mi.getString("CAL_YM"));
				sql.setString(i++, mi.getString("ISSUE_TYPE"));
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, mi.getString("SALE_STR"));
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
