package tcom.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;

/**
 * 메인화면의 시간을 실시간으로 갱신하기 위한 DAO
 * (현재 접속자수도 가지고 옴)
 * @created  on 1.0, 2008/12/20
 * @created  by FUJITSU KOREA LTD
 * 
 * @modified on 2010/05/14
 * @modified by 정지인(FKL)
 * @caused   by 
 */


public class TCom002DAO extends AbstractDAO {

    public StringBuffer getDateTime(ActionForm form) throws Exception {
        StringBuffer   sb = null;
        SqlWrapper    sql = null;
        Service       svc = null;
        
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();           
            
            sql.put(svc.getQuery("SEL_TIME")); 
           
            sb = selectAjax(sql);
        } catch (Exception e) {
            throw e;    
        }
        
        return sb;
    }
	
}
