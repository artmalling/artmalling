package mpro.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Mpro204DAO extends AbstractDAO{
	
	public List getMaster(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;        
        int i = 0;
        
        try {
            
        	connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            

            String strCd		    = String2.nvl(form.getParam("strCd"));	//점코드
            String em_sDate         = String2.nvl(form.getParam("em_sDate"));	//기간 시작일
            String em_eDate	        = String2.nvl(form.getParam("em_eDate"));	//기간 종료일
            String userid	        = String2.nvl(form.getParam("userid"));	//기간 종료일
            
            sql.put(svc.getQuery("SEL_ORGANIZATIN_PROMISS"));
            sql.setString(++i, strCd);   
            sql.setString(++i, em_sDate);
            sql.setString(++i, em_eDate);
            sql.setString(++i, userid);
            sql.setString(++i, strCd);   
            sql.setString(++i, em_sDate);
            sql.setString(++i, em_eDate);
            sql.setString(++i, userid);
            
            list = select2List(sql); 
           

        } catch (Exception e) {
            throw e;
        }
        return list;
    }
	
	
}
