package medi.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import medi.dao.MEdi101DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;




/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/16
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */


public class MEdi101Action extends DispatchAction {
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEdi101Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
			//System.out.println(session.getAttribute("sessionInfo").getClass().getCanonicalName());
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
	 * <p> 협력사 EDI 비밀번호 관리 </p>
	 *  조회
	 */
	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MEdi101DAO dao = null;
		
		String strGoTo = form.getParam("goTo");
		
		try{
			dao = new MEdi101DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			
			list = dao.getMaster(form);
			
			helper.setListToDataset(list, dSet);
			
		}catch(Exception e){
			logger.error("", e);		
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally{
			helper.close(dSet);
		}
		
		
		return mapping.findForward(strGoTo);
	}
	/**
	 * <p> 협력사 EDI 비밀번호 관리 </p>
	 *  저장
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		String userid = "";
		int ret = 0;
		
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		
		String strGoTo = form.getParam("goTo");
		
		try{
			userid = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			
			MultiInput mi = helper.getMultiInput(dSet);
			MEdi101DAO dao = new MEdi101DAO();
			
			ret = dao.save(form, mi, userid);
			
		}catch(Exception e){
			e.printStackTrace();
			logger.info("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally{
			helper.close(dSet, ret + "건 처리 되었습니다.");	
		}
		
		
		return mapping.findForward(strGoTo);
	}
	
	
}
