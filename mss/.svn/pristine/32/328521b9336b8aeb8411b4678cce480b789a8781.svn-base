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

public class MGif623DAO extends AbstractDAO {
	
	/**
	 * 상품권종류 콤보
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftTypeCd(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_COMBO") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	 /**
	 * 자사상품권 POS회수 집계 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftPosSum(ActionForm form) throws Exception {

		System.out.println(" strSlipNo ---3333 ");
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		System.out.println(" strSlipNo ---4444 ");
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strCalYmdFrom = String2.nvl(form.getParam("strCalYmdFrom"));   //정산년월 FROM
		String strCalYmdTo = String2.nvl(form.getParam("strCalYmdTo"));	//정산년월to

		System.out.println(" strSlipNo ---5555 ");
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		System.out.println(" strSlipNo ---6666 ");
		connect("pot");
		strQuery = svc.getQuery("SEL_MG_POSDRAWL_MST") + "\n";

		System.out.println(" strSlipNo ---7777 ");
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCalYmdFrom);
		sql.setString(i++, strCalYmdTo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	
	 /**
	 * 자사상품권마스터존재 POS회수 집계 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strCalYmdFrom = String2.nvl(form.getParam("strCalYmdFrom"));   //정산년월 FROM
		String strCalYmdTo = String2.nvl(form.getParam("strCalYmdTo"));	//정산년월to
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MG_POSDRAWL_DTL") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCalYmdFrom);
		sql.setString(i++, strCalYmdTo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}


	 /**
	 * 자사상품권마스터 미존재 POS회수 집계 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftMstNot(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strCalYmdFrom = String2.nvl(form.getParam("strCalYmdFrom"));   //정산년월 FROM
		String strCalYmdTo = String2.nvl(form.getParam("strCalYmdTo"));	//정산년월to
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MG_POSDRAWL_DTL_NOT") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCalYmdFrom);
		sql.setString(i++, strCalYmdTo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
}
