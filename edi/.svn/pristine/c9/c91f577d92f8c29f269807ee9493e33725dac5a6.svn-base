package sample.ajax.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import sample.ajax.dao.SAM_010DAO;

public class SAM_010Action extends DispatchAction {
	static Logger logger = Logger.getLogger(SAM_010Action.class);
	
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
 
    	BaseProperty property = BaseProperty.getInstance();
    	
        List list = null;
        SAM_010DAO dao = null;

        
        
        try {
            dao = new SAM_010DAO();

            list = dao.getListData(form);
            

        } catch (Exception e) {
            e.printStackTrace();
        }
//        System.out.println("list.size() 이게 사이즈입니다.: "+ list.size());
        request.setAttribute("ret", list);
        return mapping.findForward("list");
    }
    
    public ActionForward detail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        SAM_010DAO dao = null;
        StringBuffer ret = null;
        
        System.out.println("title: " + form.getString(1, "title"));
              
        try {
            dao = new SAM_010DAO();
            ret = dao.getDetailData(form);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        ActionUtil.sendAjaxResponse(response, ret);
        return mapping.findForward("detail");
    }
}
