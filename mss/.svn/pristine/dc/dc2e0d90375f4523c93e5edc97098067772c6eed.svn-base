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
 * <p>상품권 강제불출</p>
 * 
 * @created on 1.0, 2012.08.16
 * @created by 강진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MGif216DAO extends AbstractDAO {

	/**
	 * 반품상품권 내역조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftNoInfo(ActionForm form)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;

		try {
			//파라미터 값 가져오기
			String strStoreCd 	= String2.trimToEmpty(form.getParam("strStoreCd")); 	//점코드
			String strPoutDt  	= String2.trimToEmpty(form.getParam("strPoutDt")); 		//불출일자
			String strPoutType  = String2.trimToEmpty(form.getParam("strPoutType")); 	//불출유형
			String isAll      	= String2.trimToEmpty(form.getParam("isAll"));
			String strGiftSNo  	= String2.trimToEmpty(form.getParam("strGiftSNo"));  	//상품권시작번호
			String strGiftENo  	= String2.trimToEmpty(form.getParam("strGiftENo"));  	//상품권종료번호
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery("SEL_POUT_GIFT"));
			
			sql.setString(i++, strStoreCd);
			
			if("Y".equals(isAll)){
				sql.put(svc.getQuery("SEL_POUT_GIFT_WHERE_DATE"));
				sql.setString(i++, strPoutType);
				sql.setString(i++, strPoutDt);
			} else {
				sql.put(svc.getQuery("SEL_POUT_GIFT_WHERE_NO"));
				if(strGiftSNo.equals("")){
					sql.setString(i++, form.getParam("strGiftENo"));
					sql.setString(i++, form.getParam("strGiftENo"));
				}else{
					sql.setString(i++, form.getParam("strGiftSNo"));
					sql.setString(i++, form.getParam("strGiftENo"));
				}
			}
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 상품권 강제불출
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
			
			//파라미터 값 가져오기
			String strStoreCd 	= String2.trimToEmpty(form.getParam("strStoreCd")); 	//점코드
			String strPoutDt  	= String2.trimToEmpty(form.getParam("strPoutDt")); 		//불출일자
			String strPoutType  = String2.trimToEmpty(form.getParam("strPoutType")); 	//불출유형
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			//(불출)확정전표번호
			sql.put(svc.getQuery("SEL_SEQ_NO"));	
			Map mapSeqNo = selectMap(sql);
			String strSeqNo = mapSeqNo.get("SEQ").toString();
			sql.close();
			
			while(mi.next()){
				//상품권 재사용내역을 등록
				if((mi.IS_UPDATE() || mi.IS_INSERT())){
					i   = 0;
					res = 0;
					sql.put(svc.getQuery("INS_POUT"));
					
					sql.setString(++i, strPoutDt);
					sql.setString(++i, mi.getString("IN_STR"));
					sql.setString(++i, strSeqNo);
					sql.setString(++i, strPoutDt);
					sql.setString(++i, mi.getString("IN_STR"));
					sql.setString(++i, strSeqNo);
					sql.setString(++i, mi.getString("GIFT_TYPE_CD"));
					sql.setString(++i, mi.getString("GIFT_AMT_TYPE"));
					sql.setString(++i, mi.getString("CONF_QTY"));
					sql.setString(++i, mi.getString("CONF_AMT"));
					sql.setString(++i, mi.getString("GIFTCARD_NO")); //GIFT_S_NO
					sql.setString(++i, mi.getString("GIFTCARD_NO")); //GIFT_E_NO
					sql.setString(++i, strUserId);
					sql.setString(++i, strUserId);
					
					res = update(sql);
					ret += res;
					sql.close();
					
					if( res == 1) {
						//재사용 상품권정보 수정
						i   = 0;
						res = 0;
						sql.put(svc.getQuery("UPD_GIFTMST"));
						
						sql.setString(++i, strPoutDt);
						sql.setString(++i, strUserId);
						sql.setString(++i, strUserId);
						sql.setString(++i, mi.getString("GIFTCARD_NO"));
						
						res = update(sql);
						sql.close();
						if( res != 1) {
							throw new Exception("[USER]"+"강제불출 상품권정보 수정이 실패하였습니다.");
						}
					} else {
						throw new Exception("[USER]"+"상품권 강제불출 등록이 실패하였습니다.");
					}
					sql.close();
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
