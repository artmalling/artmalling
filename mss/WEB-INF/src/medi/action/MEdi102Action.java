package medi.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import medi.dao.MEdi102DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.util.String2;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/18
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */


public class MEdi102Action extends DispatchAction {
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEdi102Action.class);

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
	 * <p>공지사항등록조회 </p>
	 * 
	 */	
	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi102DAO dao = null;
		
		String strGoTo = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			
			dao = new MEdi102DAO();
			
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
	 * <p>바이어코드 조회 </p>
	 * 
	 */	
	
	public ActionForward getBuyerCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MEdi102DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_BYBER");
			helper.setDataSetHeader(dSet, "H_BUYERCD");
			
			dao = new MEdi102DAO();
			
			list = dao.getBuyerCd(form);
			
			helper.setListToDataset(list, dSet);
			
		}catch(Exception e){
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally {
			helper.close(dSet);
		}
		
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>바이어코드 콤보 조회 </p>
	 * 
	 */	
	
	public ActionForward getComboBuyer(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi102DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_COMBOBUYER");
			helper.setDataSetHeader(dSet, "H_COMBOBUYER");
			
			dao = new MEdi102DAO();
			
			list = dao.getComboBuyer(form);
			
			helper.setListToDataset(list, dSet);
			
		}catch(Exception e){
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally {
			helper.close(dSet);
		}
		
		return mapping.findForward(strGoto);
	}
	
	
	
	/**
	 * <p>저장/수정</p>
	 * 
	 */	
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MEdi102DAO dao = null;
		int ret = 0;
		
		HttpSession session = request.getSession();
        String userId = "";
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try{
        	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
            
            helper = new GauceHelper2(request, response, form);
            
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            MultiInput mi = helper.getMutiInput(dSet);
            
            dao = new MEdi102DAO();
            
            if( "save".equals(String2.nvl(form.getParam("strFlg"))) ){
            	ret = dao.save(form, mi, userId);
            }else {
            	ret = dao.delete(form, mi);		//삭제
            }
            
        }catch(Exception e){
        	logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
        	 helper.close(dSet, "처리되었습니다");
        }
		
		return mapping.findForward(strGoTo);
	}
}
