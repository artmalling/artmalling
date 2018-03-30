package medi.action;

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
import medi.dao.MEdi104DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

public class MEdi104Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEdi104Action.class);

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
	 * <p>바이어코드 조회 </p>
	 * 
	 */	
	
	public ActionForward getBuyerCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_BUYER");
			helper.setDataSetHeader(dSet, "H_BUYER");
			
			dao = new MEdi104DAO();
			
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
	
	public ActionForward comboBuber(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_COMBOBUYER");
			helper.setDataSetHeader(dSet, "H_COMBOBUYER");
			
			dao = new MEdi104DAO();
			
			list = dao.comboBuber(form);
			
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
	 * <p>브랜드명 조회 </p>
	 * 
	 */	
	
	public ActionForward getPumben(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_PUMBENNM");
			
			dao = new MEdi104DAO();
			
			list = dao.getPumben(form);
			
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
	 * <p>게시판 브랜드 권한 </p>
	 * 
	 */	
	
	public ActionForward getboardauth(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_PUMBENNM");
			
			dao = new MEdi104DAO();
			
			list = dao.getboardauth(form);
			
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
	 * <p>게시판 조회 </p>
	 * 
	 */	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi104DAO dao = null;
		
		String strGoto = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			
			dao = new MEdi104DAO();
			
			list = dao.getMaster(form);
			
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
	 * <p>게시판 답변글 수정, 등록 </p>
	 * 
	 */	
	public ActionForward saveReply(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
				
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi104DAO dao = null;
		int ret = 0;
		String userid = "";
		
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

		String strGoto = form.getParam("goTo");
		
		try{
						

			userid = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			MultiInput mi = helper.getMultiInput(dSet);
					
			dao = new MEdi104DAO();
						
			ret = dao.saveReply(form, mi, userid);
			
		}catch(Exception e){
			logger.error("MEdi104Action saveReply() error :"+e.toString());
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally{
			helper.close(dSet, ret + "건 처리 되었습니다.");
		}
		
		return mapping.findForward(strGoto);
	}
	/**
	 * <p>게시판  수정, 등록 </p>
	 * 
	 */		
	public ActionForward saveVBoard(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{		
				
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;		
		MEdi104DAO dao = null;
		MultiInput mi1 = null;
		MultiInput mi2 = null;
		int ret = 0;
		String userid = "";
		
		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

		String strGoto = form.getParam("goTo");
		
		try{
						

			userid = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet[0], "H_MASTER");
			dSet[1] = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet[1], "H_PUMBENNM");
			
			mi1 = helper.getMultiInput(dSet[0]);
			mi2 = helper.getMultiInput(dSet[1]);
			
			dao = new MEdi104DAO();
			ret = dao.saveVBoard(form, mi1, mi2, userid);
			
			if( ret > 1 ){
				ret = 1;
			}
			
						
		}catch(Exception e){
			logger.error("MEdi104Action saveVBoard() error :"+e.toString());
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally{
			helper.close(dSet, ret + "건 처리 되었습니다.");
		}
		
		return mapping.findForward(strGoto);
	}
	
}
