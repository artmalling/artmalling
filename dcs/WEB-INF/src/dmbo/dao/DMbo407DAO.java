/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>기간별가입회원List조회</p>
 * 
 * @created  on 1.0, 2010/03/21
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by  
 * @caused   by 
 */

public class DMbo407DAO extends AbstractDAO {

	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		Util util       = new Util();
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          
		
		String strStrCd   	= String2.nvl(form.getParam("strStrCd"));
		String strFromDt  	= String2.nvl(form.getParam("strFromDt"));
		String strToDt  	= String2.nvl(form.getParam("strToDt"));
		String strGbFlag  	= String2.nvl(form.getParam("strGbFlag"));
		//String strCustId	  = String2.nvl(form.getParam("strCustId"));
		//String strEntrGb1	  = String2.nvl(form.getParam("strEntrGb1"));
		//String strEntrGb2	  = String2.nvl(form.getParam("strEntrGb2"));
		String strBfGubun  	= String2.nvl(form.getParam("strBfGubun"));
		String strEntrGubun	= String2.nvl(form.getParam("strEntrGubun"));
		String strChkNoBf  	= String2.nvl(form.getParam("strChkNoBf"));
		String strOrder  	= String2.nvl(form.getParam("strOrder"));

		
	
		sql = new SqlWrapper();     
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER")); 
		
		sql.setString(i++, strFromDt);			//가입일자 From
		sql.setString(i++, strToDt);			//가입일자 To
		sql.setString(i++, strStrCd);			//점코드
		sql.setString(i++, strFromDt);			//가입일자 From
		sql.setString(i++, strToDt);			//가입일자 To
		sql.setString(i++, strFromDt);			//가입일자 From
		sql.setString(i++, strToDt);			//가입일자 To
		sql.setString(i++, strGbFlag);
		sql.setString(i++, strBfGubun);			//혜택 구분 ( 적립, 할인)
		
		if (strEntrGubun.equals("0"))
			sql.put(svc.getQuery("SEL_MASTER_ENTR_GBN1")); // 고객센터
		else if (strEntrGubun.equals("1"))
			sql.put(svc.getQuery("SEL_MASTER_ENTR_GBN2")); // 매장(브랜드) 가입
		else if (strEntrGubun.equals("2"))
			sql.put(svc.getQuery("SEL_MASTER_ENTR_GBN3")); // 모바일 가입
	
		
		if (strChkNoBf.equals("1")) 
			sql.put(svc.getQuery("SEL_MASTER_NO_BENEFIT")); // 혜택 미적용 조회 제외.
		
		if (strOrder.equals("0")) 
			sql.put(svc.getQuery("SEL_MASTER_ORDER1")); // 정렬 (가입일 기준)
		else 
			sql.put(svc.getQuery("SEL_MASTER_ORDER2")); // 정렬 (포인트 내림차순 기준)
		
		ret = select2List(sql);
		
		//ret = util.decryptedStr(ret,13);     //이동전화1복호화.
		//ret = util.decryptedStr(ret,14);     //이동전화2 복호화.
		//ret = util.decryptedStr(ret,15);     //이동전화3 복호화.
		/*ret = util.decryptedStr(ret,16);     //이동전화1복호화.
		ret = util.decryptedStr(ret,17);     //이동전화2 복호화.
		ret = util.decryptedStr(ret,18);     //이동전화3 복호화.
		ret = util.decryptedStr(ret,19);     //이메일1   복호화
		ret = util.decryptedStr(ret,20);     //이메일2    복호화.*/
		return ret;
	}
}

