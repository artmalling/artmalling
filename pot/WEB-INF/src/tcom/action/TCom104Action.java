/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import tcom.dao.TCom104DAO;
import tcom.dao.TCom201DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>시스템메뉴-권한관리</p>
 * 
 * @created  on 1.0, 2010/02/12
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom104Action  extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom104Action.class);

	/**
	 * <p>권한 관리 페이지를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		return mapping.findForward(strGoTo);
	}


	/**
	 * <p>그룹을 보여준다.</p>
	 * 
	 */
	public ActionForward selPgroup(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom104DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			String strDS = String2.nvl(form.getParam("strDS"));	//사용DS 
			
			helper = new GauceHelper2(request, response, form);  
			dSet = helper.getDataSet(strDS);
			helper.setDataSetHeader(dSet, "H_SEL_PGROUP");
			
			dao = new TCom104DAO();
			list = dao.getPgroup(form);  
			helper.setListToDataset(list, dSet); 

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>프로그램을 트리로 표현한다.</p>
	 * 
	 */
	public ActionForward treeview(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		TCom104DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			String strDS = String2.nvl(form.getParam("strDS"));	//사용DS 

			helper = new GauceHelper2(request, response, form);  
			dSet = helper.getDataSet(strDS);
			helper.setDataSetHeader(dSet, "H_TREE_MAIN");
			
			dao = new TCom104DAO();
			list = dao.getTreeList(form);

			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
 
	/**
	 * <p>사용자조회 </p>
	 * Tab1,3
	 */
	public ActionForward selUsrmstCond(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom104DAO dao 		= null;
 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			String strGbn = form.getParam("strGbn"); // 분기할곳
			helper = new GauceHelper2(request, response, form);  

			// System.out.println( "--------------------------strGbn      ===> " + strGbn     );
			if ("U".equals(strGbn))
			{
				// TAB1
				dSet = helper.getDataSet("DS_O_USRMST"); 
				helper.setDataSetHeader(dSet, "H_USRMST");
			}
			else
			{
				// TAB3
				dSet = helper.getDataSet("DS_O_USRMST_J"); 
				helper.setDataSetHeader(dSet, "H_USRMST_J");
			} 
			String subSys = null; 
 
			dao = new TCom104DAO();
			list = dao.getUsrmstCond(form);  
			helper.setListToDataset(list, dSet);   
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>프로그램 권한 리스트를 리턴한다.</p>
	 *  Tab1,2
	 */
	public ActionForward selUsrpgm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom104DAO dao 		= null; 

		String strGoTo 	= form.getParam("goTo"); // 분기할곳
		String strDS 	= String2.nvl(form.getParam("strDS"));	// 데이터셋
		try { 

			helper = new GauceHelper2(request, response, form);  
			dSet = helper.getDataSet(strDS); 
			helper.setDataSetHeader(dSet, "H_USRPGM");
  
			dao = new TCom104DAO();
			list = dao.getUsrpgm(form);
			 
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}	
	
	/**
	 * <p>프로그램더하기 버튼 시 사용(해당 프로그램 리턴)</p>
	 *  Tab1,2
	 */
	public ActionForward selPgmmst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom104DAO dao 		= null;  

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			helper = new GauceHelper2(request, response, form);  
			dSet = helper.getDataSet("DS_O_PGMMST"); 
			helper.setDataSetHeader(dSet, "H_SEL_PGMMST"); 
			
			dao = new TCom104DAO();
			list = dao.getPgmmst(form);

			helper.setListToDataset(list, dSet); 

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> 프로그램 권한정보 변경사항을 저장한다.</p>
	 * Tab1
	 */
	public ActionForward updatePrAuth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		TCom104DAO dao 		= null;
		MultiInput mi 		= null;
		int ret 			= 0;

		HttpSession session = request.getSession();
		String strGoTo 		= form.getParam("goTo"); 				// 분기할곳
		String strDS 		= String2.nvl(form.getParam("strDS"));	// 데이터셋
		
		String userId = null;
		try {

			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet   = new GauceDataSet();
			dSet   = helper.getDataSet(strDS);
			mi = helper.getMutiInput(dSet);

			dao = new TCom104DAO();
			ret = dao.updatePrAuth(form, mi, userId); 

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet , ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo); 
	}

	/**
	 * <p> 사용자 권한복사팝업을 load한다.</p>
	 * Tab1. 권한복사 팝업
	 */
	public ActionForward copyAuthorPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> </p>
	 * Tab1. 권한복사 팝업 : 권한복사
	 */
	public ActionForward saveCopyAuth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
 
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		
		TCom104DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession(); 
		String userId  = null;  
		List list 	   = null;


		String strGoTo = form.getParam("goTo"); // 분기할곳 

		try { 
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_IO_MAIN");
			helper.setDataSetHeader(dSet, "H_COPY_MAIN");  

			MultiInput mi = helper.getMutiInput(dSet); 
			
			dao = new TCom104DAO(); 
			ret = dao.saveCopyAuth(form, mi, userId);  
 
			 
		} catch (Exception e) {
		   logger.error("", e); 
		   helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet,"처리되었습니다.");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>그룹별 사용자 조직정보 팝업을 보여준다.</p>
	 *  Tab2. 그룹그리드 더블클릭 화면팝업
	 */
	public ActionForward usrJojikPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		return mapping.findForward(strGoTo);
	}


	/**
	 * <p>룹별 사용자 조직정보 팝업을 보여준다 : 그룹별 사용자 조직정보 팝업에서 보여줄 조직정보 리스트를 리턴한다.</p>
	 * Tab2. 그룹리스트
	 */
	public ActionForward selUsrmst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom104DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳 
		try {
 
			helper = new GauceHelper2(request, response, form);  
			dSet = helper.getDataSet("DS_O_USRMST_POP"); 
			helper.setDataSetHeader(dSet, "H_USRMST"); 

			dao = new TCom104DAO();
			list = dao.getUsrmst(form);

			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>사용자별 프로그램 조직권한 정보를 리턴한다.</p>
	 * Tab3. 조직권한
	 */
	public ActionForward selJjauth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom104DAO dao 		= null;  

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			helper = new GauceHelper2(request, response, form);  
			dSet   = helper.getDataSet("DS_IO_JJAUTH"); 
			helper.setDataSetHeader(dSet, "H_JJAUTH");

			dao = new TCom104DAO();
			list = dao.selectJjauthList(form);

			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			e.printStackTrace();
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	} 
	
	/**
	 * <p> 사용자별 조직권한 팝업을 보여준다.</p>
	 * Tab3. 조직권한
	 */
	public ActionForward jojikAuthPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String strGoTo = form.getParam("goTo"); // 분기할곳S
		try {
			GauceHelper2.initialize(form, request, response);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		} 
		return mapping.findForward(strGoTo);
	}
	/**
	 * <p>
	 * 점 정보조회 
	 * Tab3. 조직권한
	 * 
	 */
	public ActionForward selectStrCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom104DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom104DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_STR_CD");
			helper.setDataSetHeader(dSet, "H_STR_CD");
			
			list = dao.selectStrCd(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 부문정보조회 
	 * Tab3. 조직권한
	 * 
	 */
	public ActionForward selectDeptCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom104DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom104DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_DEPT_CD");
			helper.setDataSetHeader(dSet, "H_DEPT_CD");
			
			list = dao.selectDeptCd(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo); 
	}
	/**
	 * <p>
	 * 팀정보조회 
	 * Tab3. 조직권한
	 * 
	 */
	public ActionForward selectTeamCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom104DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom104DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_TEAM_CD");
			helper.setDataSetHeader(dSet, "H_TEAM_CD");
			
			list = dao.selectTeamCd(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo); 
	}
	/**
	 * <p>
	 * PC정보조회 
	 * Tab3. 조직권한
	 * 
	 */
	public ActionForward selectPcCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom104DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom104DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_PC_CD");
			helper.setDataSetHeader(dSet, "H_PC_CD");
			
			list = dao.selectPcCd(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo); 
	}
	
	/**
	 * <p>
	 * PC정보조회 
	 * Tab3. 조직권한
	 * 
	 */
	public ActionForward selectPumbunCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List 			list 	= null;
		GauceHelper2 	helper 	= null;
		GauceDataSet 	dSet 	= null;
		TCom104DAO 		dao 	= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom104DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_PUMBUN_CD");
			helper.setDataSetHeader(dSet, "H_PUMBUN_CD");
			
			list = dao.selectPumbunCd(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo); 
	}
	

	/**
	 * <p>사용자별 조직 권한정보 변경사항을 저장한다.</p>
	 * Tab3. 조직권한
	 */
	public ActionForward updateJjauth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List 			list 	= null;
		GauceHelper2 	helper 	= null;
		GauceDataSet 	dSet 	= null;
		TCom104DAO 		dao 	= null;
		MultiInput 		mi 		= null; 
		int 			ret 	= 0;

		HttpSession session = request.getSession();
		String strGoTo 		= form.getParam("goTo"); 				// 분기할곳 
		
		String userId = null;
		try {

			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			dSet   = new GauceDataSet();
			dSet   = helper.getDataSet("DS_IO_JJAUTH");
			mi 	   = helper.getMutiInput(dSet); 
			
			dao = new TCom104DAO();
			ret = dao.setJjauth(form, mi, userId); 

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally { 
			helper.close(dSet,ret + "건 처리되었습니다");
		}

		return mapping.findForward(strGoTo);
	}

}
