/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>POS 사은품 회수관리</p>
 * 
 * @created  on 1.0, 2011/03/14
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae405DAO extends AbstractDAO {
	/**
	 * POS 사은품 회수 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPosRecovery(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSdt")));
		sql.setString(i++, String2.nvl(form.getParam("strEdt")));
		sql.setString(i++, String2.nvl(form.getParam("strFlorCd")));
		sql.setString(i++, String2.nvl(form.getParam("strPosCd")));
		strQuery = svc.getQuery("SEL_POSRECOVERY") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 합산 영수증 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPsntRecp(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));
		sql.setString(i++, String2.nvl(form.getParam("strPrsntNo")));

		strQuery = svc.getQuery("SEL_PRSNTRECP") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 합산 영수증 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftList(ActionForm form) throws Exception {

		List ret = null;
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.close();
		sql.put(svc.getQuery("SEL_GIFT_LIST"));
		sql.setString(i++, String2.nvl(form.getParam("strSaleDt")));
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strPosNo")));
		sql.setString(i++, String2.nvl(form.getParam("strTranNo")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleDt")));
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strPosNo")));
		sql.setString(i++, String2.nvl(form.getParam("strTranNo")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleDt")));
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strPosNo")));
		sql.setString(i++, String2.nvl(form.getParam("strTranNo")));
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 사은품 지급 취소 내역을 등록 한다.
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
		String strPrsntNo = "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			mi[1].next();
			while(mi[0].next()){
				// POS 사은품 회수 내역 PROC_STATE UPDATE
				sql.close();
				i = 1;
				sql.put(svc.getQuery("UPD_POSRECOVERY"));
				sql.setString(i++, mi[0].getString("NDRAWL_RSN_CD")); // 미회수사유코드
				sql.setString(i++, mi[0].getString("NDRAWL_RSN")); // 미회수 사유
				sql.setString(i++, mi[0].getString("REMARK")); // 적요
				sql.setString(i++, userId); // 수정자
				sql.setString(i++, mi[0].getString("SALE_DT")); // 매출일자
				sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
				sql.setString(i++, mi[0].getString("POS_NO")); // 포스번호
				sql.setString(i++, mi[0].getString("TRAN_NO")); // 거래번호
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}
			
			// 사은품 지급 원전표 취소 UPDATE
			sql.close();
			i = 1;
			sql.put(svc.getQuery("UPD_EVTSKUPRSNT"));
			sql.setString(i++, userId); // 수정자
			sql.setString(i++, mi[0].getString("PRSNT_DT")); // 지급일
			sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
			sql.setString(i++, mi[0].getString("PRSNT_NO")); // 지급번호
			res = update(sql);
			if (res != 1) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			if(mi[0].getString("PROC_STAT").equals("0")){
				// 취소 사은품 지급 지급번호 발번
				sql.close();
				sql.put(svc.getQuery("SEL_PRSNT_NO"));
				Map map = (Map) selectMap(sql);
				strPrsntNo = map.get("PRSNT_NO").toString();
				if (strPrsntNo.equals("")) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				// 사은품 지급 취소 등록
				sql.close();
				i = 1;
				sql.put(svc.getQuery("INS_EVTSKUPRSNT"));
				sql.setString(i++, mi[0].getString("SALE_DT")); // 지급취소일
				sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
				sql.setString(i++, strPrsntNo); // 지급번호
				sql.setString(i++, mi[0].getString("DRAWLFLAG").equals("1")?"5":"6"); // 지급구분 1:정상, 2:예외, 4:지급취소, 5: 포스 정상취소, 6:포스미회수 지급 취소
				sql.setString(i++, mi[0].getString("PRSNT_DT") + mi[0].getString("STR_CD")
								 + mi[0].getString("PRSNT_NO")); // 원전표 번호
				sql.setString(i++, userId); // 수정자
				sql.setString(i++, userId); // 수정자
				sql.setString(i++, mi[0].getString("PRSNT_DT")); // 지급취소일
				sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
				sql.setString(i++, mi[0].getString("PRSNT_NO")); // 지급번호
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				i = 1;
				sql.close();
				// 사은품 지급 영수증 등록
				sql.put(svc.getQuery("INS_PRSNTRECP"));
				sql.setString(i++, mi[0].getString("SALE_DT")); // 지급취소일
				sql.setString(i++, strPrsntNo); // 지급번호
				sql.setString(i++, userId); // 수정자
				sql.setString(i++, userId); // 등록자
				sql.setString(i++, mi[0].getString("PRSNT_DT")); // 지급일
				sql.setString(i++, mi[0].getString("STR_CD")); // 점코드
				sql.setString(i++, mi[0].getString("PRSNT_NO")); // 지급번호
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
