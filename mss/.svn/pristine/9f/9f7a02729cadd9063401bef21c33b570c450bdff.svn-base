package mpro.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mpro.dao.MPro207DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;


/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/14
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MPro207Action extends DispatchAction {
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MPro207Action.class);

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
	 * <p>master 조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MPro207DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try{
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			
			dao = new MPro207DAO();
			list = dao.getMaster(form);
			
			helper.setListToDataset(list, dSet);
			
		}catch(Exception e){
			logger.error("" + e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally {
			helper.close(dSet);
		}
		
		return mapping.findForward(strGoTo);
	}
	
	
}
