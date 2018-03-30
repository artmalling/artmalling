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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif611DAO extends AbstractDAO {
	/**
	 * 제휴상품권(쿠폰)조회 -MASTER
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		 
		String strStrCd    	= String2.nvl(form.getParam("strStrCd"));
		String strSCalYm    	= String2.nvl(form.getParam("strSCalYm"));
		String strVenCd   	= String2.nvl(form.getParam("strVenCd")); 
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
 
		sql.setString(i++, strSCalYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strVenCd); 
		
		strQuery = svc.getQuery("SEL_JOINCAL") + "\n";
		sql.put(strQuery);
	 
		ret = select2List(sql); 
		return ret;
		
	}
	
	/**
	 * 제휴상품권(쿠폰)조회 -DETAIL
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		 
		connect("pot"); 
		String strStrCd    	= String2.nvl(form.getParam("strStrCd"));
		String strSCalYm    	= String2.nvl(form.getParam("strSCalYm"));
		String strVenCd    	= String2.nvl(form.getParam("strVenCd")); 
		String strPayRecFlag    	= String2.nvl(form.getParam("strPayRecFlag")); 
		String strCalFlag    	= String2.nvl(form.getParam("strCalFlag")); 
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		sql.setString(i++, strSCalYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPayRecFlag);
		sql.setString(i++, strCalFlag);
		
		strQuery = svc.getQuery("SEL_JOINPAY") + "\n";
		sql.put(strQuery);
	 
		ret = select2List(sql); 
		return ret;
		
	}
	

	/**
	* 저장/수정
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int save(ActionForm form, MultiInput mi, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
        List	list 	 = null;  
        
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();	
			
			while (mi.next()) {				
				int i=0;
				sql.close();		  
				if (mi.IS_INSERT()) { 			// 저장		
					sql.put(svc.getQuery("INS_JOINPAY")); 
					sql.setString(++i, mi.getString("CAL_YM"));     
					sql.setString(++i, mi.getString("PAY_DT"));   				
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("CAL_TYPE")); 
					sql.setString(++i, mi.getString("VEN_CD")); 	 
					sql.setString(++i, mi.getString("PAYREC_FLAG")); 
					sql.setString(++i, mi.getString("CAL_FLAG")); 
					sql.setString(++i, mi.getString("CAL_YM"));     
					sql.setString(++i, mi.getString("PAY_DT"));   				
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("CAL_TYPE")); 
					sql.setString(++i, mi.getString("VEN_CD")); 	 
					sql.setString(++i, mi.getString("PAYREC_FLAG")); 
					sql.setString(++i, mi.getString("CAL_FLAG")); 
					sql.setString(++i, mi.getString("PAY_AMT"));     
					sql.setString(++i, mi.getString("FEE_PAY_AMT"));   				
					sql.setString(++i, userId);
					sql.setString(++i, userId);	
					res = update(sql);
				}else if(mi.IS_UPDATE()){
					sql.put(svc.getQuery("UPD_JOINPAY")); 
					sql.setString(++i, mi.getString("PAY_AMT"));  
					sql.setString(++i, mi.getString("FEE_PAY_AMT")); 
					sql.setString(++i, userId); 
					sql.setString(++i, mi.getString("CAL_YM"));     
					sql.setString(++i, mi.getString("PAY_DT"));   				
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("CAL_TYPE")); 
					sql.setString(++i, mi.getString("VEN_CD")); 	 
					sql.setString(++i, mi.getString("PAYREC_FLAG")); 
					sql.setString(++i, mi.getString("CAL_FLAG")); 
					sql.setString(++i, mi.getString("SEQ_NO")); 
					res = update(sql);
				}
				
				if(res != 1){
					throw new Exception("[USER]"+"입금등록 처리를 실패했습니다.");
				}
				
				i = 0;
				sql.close();	
				sql.put(svc.getQuery("UPD_JOINCAL")); 
				sql.setString(++i, form.getParam("strPayAmt"));  
				sql.setString(++i, form.getParam("strFeeAmt")); 
				sql.setString(++i, form.getParam("strPayAmt"));  
				sql.setString(++i, form.getParam("strFeeAmt")); 
				sql.setString(++i, userId); 
				sql.setString(++i, mi.getString("CAL_YM"));     
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("CAL_TYPE")); 
				sql.setString(++i, mi.getString("VEN_CD")); 	 
				sql.setString(++i, mi.getString("PAYREC_FLAG")); 
				sql.setString(++i, mi.getString("CAL_FLAG")); 
				res = update(sql);
				
				if(res != 1){
					throw new Exception("[USER]"+"입금등록 처리를 실패했습니다.");
				}
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
	 * 입금순번
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */	
	public String getSeqNo(ActionForm form, String strStrCd, String strPayDt) 
		throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;
		String strSeqNo = "";
		
		connect("pot");
		sql = new SqlWrapper();
		svc = (Service) form.getService();	
		
		sql.put(svc.getQuery("SEL_SEQNO"));
		sql.setString(++i, strStrCd);
		sql.setString(++i, strPayDt);  
		
	    list = select2List(sql);
	    List rlist = (List) list.get(0);
	    strSeqNo = list.get(0).toString();

		sql.close();		
		return strSeqNo;		
	} 
}
