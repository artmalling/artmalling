/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.action;

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

import org.apache.log4j.Logger;

import pord.dao.POrd201DAO;
import pord.dao.POrd206DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p> 규격단품 매입발주 등록 </p>
 * 
 * @created  on 1.0, 2010/02/16
 * @created  by 신명섭
 *  
 * @modified on 
 * @modified by     
 * @caused   by 
 */

public class POrd206Action extends DispatchAction {
	/*              
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd206Action.class);

	/**            
	 * <p> 규격단품 매입발주 등록 화면 </p>                                          
	 * 
	 */                                                   
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try {

			GauceHelper2.initialize(form, request, response);
			HttpSession session     = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
            if (sessionInfo != null) {
                System.out.println("USER : " + sessionInfo.getUSER_ID());
            } 
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}  
		return mapping.findForward("list");
	}
	
	/**
	 * <p> 규격단품 매입발주 리스트 조회 </p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
	   	POrd206DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new POrd206DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_LIST");
			helper.setDataSetHeader(dSet, "H_LIST");
			list   = dao.getList(form, userId, org_flag); 
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
	 * <p> 규격단품 매입발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd206DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao     = new POrd206DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			
			list    = new  List[2];
			helper  = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet[0], "H_MASTER");
			dSet[1] = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet[1], "H_DETAIL");
			
			list    = dao.getDetail(form);        
			for(int i=0;i<list.length;i++){          
				helper.setListToDataset(list[i], dSet[i]);
			}
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> 규격단품 대출입발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail1(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd206DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd206DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = new GauceDataSet[3];
			             
			list = new  List[3];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_MASTER1");     
			helper.setDataSetHeader(dSet[0], "H_MASTER1");         
			dSet[1] = helper.getDataSet("DS_IO_DETAIL1");
			helper.setDataSetHeader(dSet[1], "H_DETAIL1");
			dSet[2] = helper.getDataSet("DS_IO_DETAIL2");
			helper.setDataSetHeader(dSet[2], "H_DETAIL1");
			               
			list = dao.getDetail1(form);                

			for(int i=0;i<list.length;i++){
				helper.setListToDataset(list[i], dSet[i]);
				System.out.println("list:::::"+list[i].size());
			}

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> 의류단품 점출입발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail3(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd206DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao     = new POrd206DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			
			list    = new  List[2];
			helper  = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_MASTER3");
			helper.setDataSetHeader(dSet[0], "H_MASTER3");
			dSet[1] = helper.getDataSet("DS_IO_DETAIL3");
			helper.setDataSetHeader(dSet[1], "H_DETAIL3");
			
			list    = dao.getDetail3(form);        
			for(int i=0;i<list.length;i++){          
				helper.setListToDataset(list[i], dSet[i]);
			}
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p> 매가인상하발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail4(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[]         = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd206DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao     = new POrd206DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			
			list    = new  List[2];
			helper  = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_MASTER4");
			helper.setDataSetHeader(dSet[0], "H_MASTER4");
			dSet[1] = helper.getDataSet("DS_IO_DETAIL4");
			helper.setDataSetHeader(dSet[1], "H_DETAIL4");
			
			list    = dao.getDetail4(form);        
			for(int i=0;i<list.length;i++){          
				helper.setListToDataset(list[i], dSet[i]);
			}
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
	 * 단품발주 SM 확정처리
	 * </p>
	 * 
	 * <p>
	 * 
	 * </p>
	 * 
	 */
	public ActionForward conf(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {


		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		 
		POrd206DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		// 임시
		String org_flag = null;  // 조직구분 (1:판매, 2:매입)

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();
			
			helper = new GauceHelper2(request, response, form);
			
			dao = new POrd206DAO();    
			// 등록및수정, 삭제 분기
			
			ret = dao.conf(form, userId, org_flag );
			
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(); 
		}
		return mapping.findForward("conf");
	}
	
	/**
	 * <p>승인,반려,취소시 현재전표상태값 체크</p>
	 * 
	 */
	public ActionForward chkStrProStat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		POrd201DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd201DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_CHK_STRPROCSTAT");
			helper.setDataSetHeader(dSet, "H_CHK_STRPROCSTAT");
			list = dao.chkStrProStat(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		} 
		return mapping.findForward(strGoTo);
	}
}
