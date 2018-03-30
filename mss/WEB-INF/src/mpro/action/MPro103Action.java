package mpro.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import mpro.dao.MPro103DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

public class MPro103Action extends DispatchAction {
	
	private Logger logger = Logger.getLogger(MPro103Action.class);

	/**
	 * <p>약속변경이력조회</p>
	 *  메뉴 화면
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
	 * <p>약속변경이력조회</p>
	 *  메뉴 화면
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MPro103DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try{
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			
			dSet = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			
			dao = new MPro103DAO();
			list = dao.getMaster(form);
			helper.setListToDataset(list, dSet);
			
		}catch(Exception e){
			logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
		}finally {
            helper.close(dSet);
        }
		
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MPro103DAO dao = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			
			dao = new MPro103DAO();
			list = dao.getDetail(form);
			helper.setListToDataset(list, dSet);
			
		}catch(Exception e){
			logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
		}finally {
            helper.close(dSet);
        }
		
		
		return mapping.findForward(strGoTo);
	}
	
	
}
