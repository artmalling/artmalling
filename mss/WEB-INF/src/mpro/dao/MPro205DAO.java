package mpro.dao;

import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/10
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MPro205DAO  extends AbstractDAO {
	
	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
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
            
            sql.put(svc.getQuery("SEL_HAPPYCALL"));
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
	
	/**
	 * <p>해피콜미이행조회 상세 팝업</p>
	 * 
	 */
	public List getDetailPopup(ActionForm form) throws Exception{
			
			List ret = null;
			SqlWrapper sql = null;
			Service svc = null;
			String strQuery = "";
			int i = 1;
			Util util = new Util();
			
			String strCd = String2.nvl(form.getParam("strCd"));
			String takeDt = String2.nvl(form.getParam("takeDt"));
			String userid = String2.nvl(form.getParam("userid"));
			
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			connect("pot");				
			
			sql.setString(1, strCd);
			sql.setString(2, takeDt);
			sql.setString(3, userid);
			
			strQuery = svc.getQuery("SEL_HAPPYCALLPOPUP") + "\n";
			sql.put(strQuery);
			
			ret = select2List(sql);
			
		/*  ret = util.decryptedStr(ret,10);        //휴대전화1
			ret = util.decryptedStr(ret,11);        //휴대전화2
			ret = util.decryptedStr(ret,12);        //휴대전화3
			ret = util.decryptedStr(ret,13);        //전화1
			ret = util.decryptedStr(ret,14);        //전화2
			ret = util.decryptedStr(ret,15);        //전화3
			ret = util.decryptedStr(ret,38);        //택배휴대전화1
			ret = util.decryptedStr(ret,39);        //택배휴대전화2
			ret = util.decryptedStr(ret,40);        //택배휴대전화3
			ret = util.decryptedStr(ret,41);        //택배전화1
			ret = util.decryptedStr(ret,42);        //택배전화2
			ret = util.decryptedStr(ret,43);        //택배전화3  */
			
			return ret;
	}
	
}
