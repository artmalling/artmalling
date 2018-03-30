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
 * <p>반품 상품권 재사용 등록</p>
 * 
 * @created on 1.0, 2011/04/28
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MGif306DAO extends AbstractDAO {

	/**
	 * 반품상품권 내역조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchRtnCou(ActionForm form)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStoreCd = null;
		String strStartDt = null;
		String strEndDt   = null;
		String strRtnType = null;
		String isAll      = null;
		String strGiftNo  = null;
		String strResueDt  = null;

		try {
			//파라미터 값 가져오기
			strStoreCd = String2.trimToEmpty(form.getParam("strStoreCd")); //회수점코드
			strStartDt = String2.trimToEmpty(form.getParam("strStartDt")); //반품회수기간 시작일 
			strEndDt   = String2.trimToEmpty(form.getParam("strEndDt"));   //반품회수기간 종료일
			strRtnType = String2.trimToEmpty(form.getParam("strRtnType")); //반품회수유형
			isAll      = String2.trimToEmpty(form.getParam("isAll"));
			strGiftNo  = String2.trimToEmpty(form.getParam("strGiftNo"));  //상품권번호
			strResueDt = String2.trimToEmpty(form.getParam("strResueDt"));  //재사용등록일자
			strLoc = "SEL_RTN_COU";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStoreCd);
			
			if("Y".equals(isAll)){
				sql.put(svc.getQuery("SEL_RTN_COU_WHERE_DATE"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);
				if (!"%".equals(strRtnType)){
					sql.put(svc.getQuery("SEL_RTN_COU_WHERE_FLAG"));
					sql.setString(i++, strRtnType);
				}
			} else {
				sql.put(svc.getQuery("SEL_RTN_COU_WHERE_NO"));
				sql.setString(i++, strGiftNo);
			}
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 반품 상품권 재사용 등록
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
		//파라미터 변수선언
		String strDate = null;
		try {
			begin();
			connect("pot");
			
			//파라미터 값 가져오기
			strDate = String2.trimToEmpty(form.getParam("strReUseDt")); //재사용등록일자
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				//상품권 재사용내역을 등록
				if((mi.IS_UPDATE() || mi.IS_INSERT()) && mi.getString("CHECK_FLAG").equals("T")){
				i   = 0;
				res = 0;
				sql.put(svc.getQuery("INS_REUSE_COU"));
				
				sql.setString(++i, strDate);
				sql.setString(++i, mi.getString("DRAWL_STR"));
				sql.setString(++i, mi.getString("DRAWL_DT"));
				sql.setString(++i, mi.getString("GIFT_TYPE_CD"));
				sql.setString(++i, mi.getString("ISSUE_TYPE"));
				sql.setString(++i, mi.getString("GIFT_AMT_TYPE"));
				sql.setString(++i, mi.getString("GIFTCARD_NO"));
				sql.setString(++i, mi.getString("DRAWL_FLAG"));
				sql.setString(++i, strUserId);
				sql.setString(++i, strUserId);
				
				res = update(sql);
				
				if( res != 1) {
					throw new Exception("[USER]"+"상품권 재사용내역 등록을 실패하였습니다.");
				}
				sql.close();
				
				//재사용 상품권정보 수정
				i   = 0;
				res = 0;
				sql.put(svc.getQuery("UPD_REUSE_COU"));
				
				sql.setString(++i, strUserId);
				sql.setString(++i, mi.getString("GIFTCARD_NO"));
				sql.setString(++i, strDate);
				
				res = update(sql);
				
				if( res != 1) {
					throw new Exception("[USER]"+"재사용 상품권정보 수정을 실패하였습니다.");
				}
				
				ret += res;
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
