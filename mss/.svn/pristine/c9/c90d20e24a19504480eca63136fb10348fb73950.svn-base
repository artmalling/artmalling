package mpro.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

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

public class MPro207DAO extends AbstractDAO {

	/**
	 * <p>마스터 조회</p>
	 * 
	 */
	public List getMaster(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;        
        int i = 0;
        
        try {
        	System.out.println("dao strat");
        	connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            
            
            String strOrgCd		    = String2.nvl(form.getParam("strOrgCd"));	//점코드
            String em_sDate         = String2.nvl(form.getParam("em_sDate"));	//기간 시작일
            String em_eDate	        = String2.nvl(form.getParam("em_eDate"));	//기간 종료일
            String userid	        = String2.nvl(form.getParam("userid"));	//사용자
            
            sql.put(svc.getQuery("SEL_HAPPYCALL"));
            sql.setString(++i, em_sDate);   
            sql.setString(++i, em_eDate);
            sql.setString(++i, strOrgCd);
            sql.setString(++i, userid);

            list = select2List(sql); 

        } catch (Exception e) {
            throw e;
        }
        return list;
    }
}
