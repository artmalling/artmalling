/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>점, 부분, 팀, PC 콤보 조회</p>
 * 
 * @created  on 1.0, 2010/02/15	
 * @created  by 김성미(FUJITSU KOREA LTD.) 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom916DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
	// ToDo:: 세션 정보 체크  => 매입/ 매장조직 
    /**
     * 점코드 조회
     *
     * @param  : 
     * @return : 
     */
    public List getBeforeYearDay(ActionForm form) throws Exception {
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strdate 		= String2.nvl(form.getParam("strdate"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	    sql.put(svc.getQuery("SEL_BEFORE_DAY"));
	    sql.setString(i++, strdate);
		ret = select2List(sql);
		
		return ret;
	}
}
