package sample.jstl.action;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;
import kr.fujitsu.ffw.util.multipart.Multipart;

import org.apache.log4j.Logger;

import sample.jstl.dao.BoardDAO;

public class BoardAction extends DispatchAction {
    Logger logger = Logger.getLogger("sample.action.BoardAction");
    
    public ActionForward ajaxtest(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        return mapping.findForward("ajaxtest");
    }   
    
    public ActionForward xmldetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        BoardDAO dao = null;

        try {
            dao = new BoardDAO();
            StringBuffer sb = dao.selectDetail(form);
            logger.info("XML:\n" + sb.toString());
            ActionUtil.sendAjaxResponse(response, sb.toString());
            
            
        } catch (Exception e) {
            logger.error("detail", e);
        }

        return mapping.findForward("xmldetail");
    }
    
    public ActionForward xmllist(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        BoardDAO dao = null;
        logger.info("++++++ xmllist로 넘어오고 있음당....");
        try {
            dao = new BoardDAO();
            ActionUtil.sendAjaxResponse(response, dao.selectXML(form).toString());
        } catch (Exception e) {
            logger.error("xmllist", e);
        }

        return mapping.findForward("xmllist");
    }

    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        BoardDAO dao = null;
        
        try {
            dao = new BoardDAO();
            list = dao.selectKebBoard(form);            
            logger.info("selectKebBoard=====>조회 건수: " + list.size());
            System.out.println("selectKebBoard=====>조회 건수: " + list.size());
            
        } catch (Exception e) {
            logger.error("list", e);
        }
        request.setAttribute("list", list);

        return mapping.findForward("list");
    }

    public ActionForward view(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        return mapping.findForward("view");
    }

    public ActionForward detail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Map map = null;
        BoardDAO dao = null;

        try {
            dao = new BoardDAO();
            map = dao.selectOneRow(form);

        } catch (Exception e) {
            logger.error("detail", e);
        }
        request.setAttribute("map", map);

        return mapping.findForward("detail");
    }

    public ActionForward insert(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        BoardDAO dao = null;
        String uploadDir = "";
        String contents = null;
        String title = null;
        String writer = null;

        try {
            dao = new BoardDAO();
            uploadDir = "D:/java/upload";
            Multipart mi = new Multipart(request, uploadDir);
            Enumeration en = mi.getFileNames();
            
            String upname = null;
            String svname = null;

            contents = String2.nvl(mi.getParameter("contents"));
            title = String2.nvl(mi.getParameter("title"));
            writer = String2.nvl(mi.getParameter("writer"));

            while (en.hasMoreElements()) {
            	try {
	                upname = null;
	                upname = (String) en.nextElement();
	                svname = mi.getFilesystemName(upname);
	                logger.info("▷▶▷▶▷▶ 업로드한 파일명" + svname);
	                logger.info("▷▶▷▶▷▶ 사이즈: " + mi.getFile(upname).length());
            	} catch (Exception e) {
            		// 파일이 첨부되지않았을 경우...
            	}
            }

            dao.insertKebBoard(form, writer, contents, title);

        } catch (Exception e) {
            logger.error("insert", e);
        }
        return mapping.findForward("insert", "&test=test");
    }

    public ActionForward redirect(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        return mapping.findForward("redirect");
    }
    
    public ActionForward test(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        BoardDAO dao = null;

        try {
            dao = new BoardDAO();
            dao.test(form);

        } catch (Exception e) {
        	e.printStackTrace();
//            logger.error("detail", e);
        }

        return mapping.findForward("test");
    }
 
    
}
