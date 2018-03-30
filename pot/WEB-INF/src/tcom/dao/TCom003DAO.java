/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 좌측 프레임 구성
 * </p>
 * 
 * @created on 1.0, 2010/12/14
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class TCom003DAO extends AbstractDAO {

	/**
	 * <p>
	 * 트리뷰를 위한 List를 리턴한다.
	 * </p>
	 * 
	 */
	public List getTreeList(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		List result = null;
		SqlWrapper sql = null;
		Service svc = null;
        String strPName = null;
		try {
			strPName = String2.trimToEmpty(form.getParam("strPName"));
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			mi.next();

			/*
			 * sql.put(svc.getQuery("SEL_PGM_CNT")); sql.setString(1, userId);
			 * sql.setString(2, userId);
			 * 
			 * //Map myMap = this.selectMap(sql);
			 * 
			 * //sql.clearParameter(); sql.close(); sql = new SqlWrapper();
			 */

			// int cnt = new Integer(myMap.get("CNT").toString()).intValue();

			if (!userId.equals("super")) {
				// 메뉴 권한이 셋팅 되지 않은 USER는 메뉴가 하나도 안보이도록 조치 */
				// 개인별/그룹별 메뉴 권한이 Setting 되어 있는 경우
				// if (cnt > 0) {
				sql.put(svc.getQuery("SEL_TREE_VIEW_PARTIAL"));
				// }
				// 권한이 셋팅 되어 있지않은 경우
				// else {
				// sql.put(svc.getQuery("SEL_TREE_VIEW_ALL"));
				// }

				sql.setString(1, mi.getString("SUB_SYSTEM"));
				sql.setString(2, userId);
				sql.setString(3, userId);
				if(!"".equals(strPName)){
					sql.put(svc.getQuery("SEL_TREE_VIEW_PARTIAL_WHERE"));
					sql.setString(4, strPName);
				}
				
				sql.put(svc.getQuery("SEL_TREE_VIEW_PARTIAL_ORDER_BY"));
			} else { // 개발시에만 사용
				sql.put(svc.getQuery("SEL_TREE_VIEW_PARTIAL_SUPER"));
				sql.setString(1, mi.getString("SUB_SYSTEM"));
				sql.setString(2, userId);

			}

			result = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return result;
	}
	
	/**
	 * <p>
	 * 즐겨찾기 목록을 리턴한다.
	 * </p>
	 * 
	 */
	public List getFavorite(ActionForm form, String userId)
			throws Exception {

		List result = null;
		SqlWrapper sql = null;
		Service svc = null;

		try {

			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("SEL_FAVORITE"));
			sql.setString(1, userId);

			result = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return result;
	}

}
