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

public class MGif501DAO extends AbstractDAO {

	 /**
	 * 상품권 폐기 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftDuseMst(ActionForm form,String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strDrawlDtFrom = String2.nvl(form.getParam("strDrawlDtFrom"));   //회수일자 from
		String strDrawlDtTo = String2.nvl(form.getParam("strDrawlDtTo"));	//회수일자to
		String strGiftTypeCd = String2.nvl(form.getParam("strGiftTypeCd"));	//상품권 종류
		String strGiftAmtCd = String2.nvl(form.getParam("strGiftAmtCd"));	//금종
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTDUSE_MST") + "\n";
		
		sql.setString(i++, userId);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDrawlDtFrom);
		sql.setString(i++, strDrawlDtTo);
		sql.setString(i++, strGiftTypeCd);
		sql.setString(i++, strGiftAmtCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 상품권 폐기 마스터 상품권 코드로 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftDuseGiftNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strGiftCardSNo = String2.nvl(form.getParam("strGiftCardSNo"));   //상품권 코드 시작
		String strGiftCardENo = String2.nvl(form.getParam("strGiftCardENo"));   //상품권 코드 종료
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFTDUSE_GIFTCARDNO") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strGiftCardSNo);
		sql.setString(i++, strGiftCardENo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권 폐기등록
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		int ret = 0;
		int res1 = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			String strDuseDt = String2.nvl(form.getParam("strDuseDt"));	//폐기일자
			String strRemark = String2.nvl(form.getParam("strRemark"));	//비고 
			
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {
				sql.close();
				i = 1;
				
				if (mi.getString("CHECK1").equals("T")) { 			// 저장		
					
					sql.put(svc.getQuery("INS_GIFTDUSE"));
					
					sql.setString(i++, strDuseDt);
					sql.setString(i++, mi.getString("DRAWL_STR"));
					sql.setString(i++, strDuseDt);
					sql.setString(i++, mi.getString("DRAWL_STR"));
					sql.setString(i++, mi.getString("QTY"));
					sql.setString(i++, mi.getString("GIFTCARD_NO"));
					sql.setString(i++, mi.getString("GIFT_TYPE_CD"));
					sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));
					sql.setString(i++, strRemark);
					sql.setString(i++, userId);
					sql.setString(i++, userId);
					
					res = update(sql);
				
					if (res != 1) {
						throw new Exception("" + "상품권 폐기 등록시 에러");
					} 
					ret += res;
					
					// 상품코드 마스터 수정 
					sql.close();
					sql.put(svc.getQuery("UPD_GIFTMST"));
					i = 1;
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("GIFTCARD_NO"));
					res1 = update(sql);
	
					if (res1 != 1) {
						throw new Exception("" + "상품코드 마스터 UPDATE시 에러 ");
					} 
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
	
}
