package mpro.dao;

import java.net.URLDecoder;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;
/**
 * <p>약속변경이력조회</p>
 * 
 * @created  on 1.0, 2011/03/08
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class MPro103DAO extends AbstractDAO{
	
	public List getMaster(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		connect("pot");
        svc  = (Service)form.getService();
        sql  = new SqlWrapper();
        int i = 0;
        
        String strCd = String2.nvl(form.getParam("strCd"));
        String strSchFlag = String2.nvl(form.getParam("strSchFlag"));
        String sDate = String2.nvl(form.getParam("sDate"));
        String eDate = String2.nvl(form.getParam("eDate"));
        String cust = URLDecoder.decode(String2.nvl(form.getParam("cust")), "UTF-8");
        String bumbun = String2.nvl(form.getParam("bumben"));
        String promType = String2.nvl(form.getParam("promType"));
        
        if( "01".equals(strSchFlag) ){
        
        	sql.put(svc.getQuery("SEL_TAKE_DT"));
        }else if( "02".equals(strSchFlag) ){
        	sql.put(svc.getQuery("SEL_IN_DELI_DT"));
        }else {
        	sql.put(svc.getQuery("SEL_FRST_PROM_DT"));
        }
        
        sql.setString(++i, promType);
        sql.setString(++i, cust);
        sql.setString(++i, bumbun);
        sql.setString(++i, strCd);
        sql.setString(++i, sDate);
        sql.setString(++i, eDate);
        
        list = select2List(sql); 
        
        return list;
    }
	
public List getDetail(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		connect("pot");
        svc  = (Service)form.getService();
        sql  = new SqlWrapper();
        int i = 0;
        
        String strCd = String2.nvl(form.getParam("strCd"));
        String takeDt = String2.nvl(form.getParam("takeDt"));
        String takeSeq = String2.nvl(form.getParam("takeSeq"));
        
        sql.put(svc.getQuery("SEL_PROMISEHIT"));
        
        sql.setString(++i, takeSeq);
        sql.setString(++i, strCd);
        sql.setString(++i, takeDt);
        
        list = select2List(sql);
        
        return list;
    }

}
