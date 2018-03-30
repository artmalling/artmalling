/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package common.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.dao.CCom914DAO;

/**
 * <p>공지사항팝업</p>
 * 
 * @created  on 1.0, 2010/06/21
 * @created  by HSEON(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom914Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom914Action.class);

    /**
     * <p>
     * 공지사항팝업
     * </p>
     */
    public ActionForward noticeMainPop(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
		GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
    }  

	/**
	 * <p>
	 * Popup.js 에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchNoticeMainPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list 				= null;
		GauceHelper2 helper 	= null;
		GauceDataSet dSet[] 	= null;
		CCom914DAO dao 			= null; 
 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			
			dao = new CCom914DAO();
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[2];  

			// 부문정보조회
			dSet[0]= helper.getDataSet("DS_O_DEPT_CD");
			helper.setDataSetHeader(dSet[0],"H_NOTICE_DEPT");
			
			list = dao.selectNoticeDept(form);
			helper.setListToDataset(list, dSet[0]); 
			
			dSet[1]= helper.getDataSet("DS_O_NOTICE");
			helper.setDataSetHeader(dSet[1], "H_NOTICE");
			
			//데이터 조회
			list = dao.selectNotice(form);
			helper.setListToDataset(list, dSet[1]);
			
			//건수가 있으면 TC_NOTI_USER_ID 에 사용자 정보 등록
			if(list.size() > 0) {
				
				list = dao.searchNoticeUserCnt(form);
				
				List tempStr = (List) list.get(0);
				
				int i = Integer.parseInt(tempStr.get(0).toString());
				
				//미리 조회한 사용자 정보가 없을경우
				if(i == 0) {
					//공지별 조회한 사용자 정보 셋팅
					dao.insertNoticeUserID(form);
				}
			}

		} catch (Exception e) { 
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	} 
}
