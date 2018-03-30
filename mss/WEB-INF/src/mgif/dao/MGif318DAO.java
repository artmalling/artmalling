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

public class MGif318DAO extends AbstractDAO { 

	 /**
	 * 점내 불출 리스트 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPoutrReqMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));				//점코드
		String strReqYmdFrom = String2.nvl(form.getParam("strReqYmdFrom"));   	//입고일자 from
		String strReqYmdTo = String2.nvl(form.getParam("strReqYmdTo"));			//입고일자to
		String strPoutFlag = String2.nvl(form.getParam("strPoutFlag"));			//불출구분
		String strPoutType = String2.nvl(form.getParam("strPoutType"));			//불출유형 
		String strVenCd = String2.nvl(form.getParam("strVenCd"));			//행사코드
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_POUTRREQ_MASTER") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strReqYmdFrom);
		sql.setString(i++, strReqYmdTo);
		sql.setString(i++, strPoutFlag);
		sql.setString(i++, strPoutType); 
		sql.setString(i++, strVenCd);
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 점내 불출 내역 디테일 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPoutrReqDtl(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		//String strConfDt = String2.nvl(form.getParam("strConfDt"));   //신청일자
		//String strConfSlipNo = String2.nvl(form.getParam("strConfSlipNo"));	//순번
//		String strConfFromDt = String2.nvl(form.getParam("strConfFromDt"));   //입고일자
//		String strConfToDt = String2.nvl(form.getParam("strConfToDt"));   //입고일자
		String strConfDt = String2.nvl(form.getParam("strConfDt"));   		//확정일자
		String strPoutFlag = String2.nvl(form.getParam("strPoutFlag"));		//불출구분
		String strPoutType = String2.nvl(form.getParam("strPoutType"));		//불출유형 
//		String strVenCd = String2.nvl(form.getParam("strVenCd"));			//행사코드
		String strConfSlipNo = String2.nvl(form.getParam("strConfSlipNo"));	//확정전표번호 
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_POUTRREQ_DETAIL") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strConfDt);
//		sql.setString(i++, strConfFromDt);
//		sql.setString(i++, strConfToDt);
		sql.setString(i++, strPoutFlag);
		sql.setString(i++, strPoutType); 
//		sql.setString(i++, strVenCd);
		sql.setString(i++, strConfSlipNo);
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
}
