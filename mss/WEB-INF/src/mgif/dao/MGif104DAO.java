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
/**
 * <p>가맹점 마스터 관리</p>
 * 
 * @created  on 1.0, 2011/04/04
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif104DAO extends AbstractDAO {
	/**
	 * 협력사 목록 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getStrMst(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_STRMST") + "\n";
		sql.setString(i++, form.getParam("strStrCd"));
		//sql.setString(i++, form.getParam("strBuySaleFlag"));
		sql.setString(i++, form.getParam("strVenCd"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 협력사 목록 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getStrInfo(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_STR_INFO") + "\n";
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strVenCd"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 수수료 정보
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getVenFeeMst(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_VENFEEINFO") + "\n";
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strVenCd"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	/**
	 * 가맹점 마스터 정보를 저장&수정
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String userId)
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
			while(mi[0].next()){
				sql.close();
				// 제휴사 마스터  정보 저장 & 수정
				sql.put(svc.getQuery("UST_STRVENMST"));
				sql.setString(i++, mi[0].getString("STR_CD"));				 	// 적용일자
				sql.setString(i++, mi[0].getString("VEN_CD"));				 	// 협력사 코드
				sql.setString(i++, mi[0].getString("GIFT_VEN_FLAG").equals("9")?"":mi[0].getString("GIFT_VEN_FLAG")); // 상품권 협렵사 구분
				sql.setString(i++, userId); 								// 등록자
				res = update(sql);
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}
			
			// 수수료정보 저장 & 수정
			while(mi[1].next()){
				sql.close();
				i = 1;
				if(mi[1].IS_INSERT() || mi[1].IS_UPDATE()){
					sql.put(svc.getQuery("UST_VENFEEMST"));
					sql.setString(i++, mi[1].getString("APP_DT"));				// 적용일자
					sql.setString(i++, mi[1].getString("STR_CD"));				// 점코드
					sql.setString(i++, mi[1].getString("VEN_CD")); 				// 협력사 코드
					sql.setString(i++, mi[1].getString("END_DT")); 				// 종료일
					sql.setString(i++, mi[1].getString("BRCH_REC_FEE_RATE")); 	// 가맹점 수취수수료율
					sql.setString(i++, userId); 								// 등록자
					res = update(sql);
					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}else if(mi[1].IS_DELETE()){
					sql.put(svc.getQuery("DEL_VENFEEMST"));
					sql.setString(i++, mi[1].getString("APP_DT"));				// 적용일자
					sql.setString(i++, mi[1].getString("STR_CD"));				// 점코드
					sql.setString(i++, mi[1].getString("VEN_CD")); 				// 협력사 코드
					res = update(sql);
					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
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
	/**
	 * 수수료 정보를 저장한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveVenFeeMst(ActionForm form, MultiInput mi, String userId)
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
			sql.close();
			
			
			while(mi.next()){
				if(mi.IS_UPDATE()){
					i = 1;
					sql.close();
					// 이전 등록 내용이 있는경우 이전 적용일에 대한 종료일자 업데이트 
					sql.put(svc.getQuery("UPD_VENFEEMST"));
					sql.setString(i++, mi.getString("END_DT"));				 	// 종료일자
					sql.setString(i++, userId); 								// 수정자
					sql.setString(i++, mi.getString("APP_DT"));				 	// 적용일자
					sql.setString(i++, mi.getString("STR_CD"));				 	// 점코드
					sql.setString(i++, mi.getString("VEN_CD")); 				// 협력사 코드
					res = update(sql);
					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
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
