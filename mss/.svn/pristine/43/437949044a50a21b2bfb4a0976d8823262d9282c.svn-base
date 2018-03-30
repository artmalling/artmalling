package mpro.dao;

import java.util.List;
import common.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


public class MPro201DAO extends AbstractDAO {
	
	public List getDetail(ActionForm form) throws Exception{
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
				
		String yearMon = String2.nvl(form.getParam("YearMon"));
		String strOrgCd = String2.nvl(form.getParam("strOrgCd"));
		System.out.println("strOrgCd :" + strOrgCd);
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		
		connect("pot");				
		
		sql.setString(1, yearMon);
		sql.setString(2, yearMon);
		sql.setString(3, strOrgCd);
		
		strQuery = svc.getQuery("SEL_PROMISS") + "\n";
		sql.put(strQuery);
		
		ret = select2List(sql);
		
		return ret;
	}
	
	public List getDetailPopup(ActionForm form) throws Exception{
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		Util util = new Util();
				
		String strOrgCd = String2.nvl(form.getParam("strOrgCd"));
		String selDate = String2.nvl(form.getParam("selDate"));
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");				
		
		sql.setString(1, strOrgCd);
		sql.setString(2, selDate);
		sql.setString(3, selDate);
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery);
		
		ret = select2List(sql);
		
/*      ret = util.decryptedStr(ret,10);        //휴대전화1
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
		ret = util.decryptedStr(ret,43);        //택배전화3   */
		
		return ret;
	}	

}
