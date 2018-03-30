package medi.dao;

import java.net.URLDecoder;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/22
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MEdi105DAO extends AbstractDAO {
	
	 
	public List getMaster(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		String query = "";
		
		String strCd = String2.nvl(form.getParam("strCd"));
		String sDate = String2.nvl(form.getParam("sDate"));	
		String eDate = String2.nvl(form.getParam("eDate"));
		String strReadCnt = String2.nvl(form.getParam("strReadCnt"));	
		String strTitle = URLDecoder.decode(String2.nvl(form.getParam("strTitle")), "UTF-8"); 
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");
		
		sql.setString(++i, strTitle); 
		sql.setString(++i, strCd);
		sql.setString(++i, sDate);
		sql.setString(++i, eDate);
		
		if( strReadCnt != null && !"".equals(strReadCnt)  ){
			
			sql.setString(++i, strReadCnt);
		}
		
		query += svc.getQuery("SEL_QNA") + "\n";
		
		if( strReadCnt != null && !"".equals(strReadCnt)  ){
			query += svc.getQuery("SEL_ROWNUM") +"\n";
		}
		 
		sql.put(query);
		
		list = select2List(sql);
		
		return list;
	}
	
	public List getPopupDetail(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = "";
		
		String seq_no = String2.nvl(form.getParam("seq_no"));
		String reg_dt = String2.nvl(form.getParam("reg_dt"));
		String strcd = String2.nvl(form.getParam("strcd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.setString(++i, strcd);
		sql.setString(++i, seq_no);
		sql.setString(++i, reg_dt);
		
		query = svc.getQuery("SEL_POPQNA");
		
		sql.put(query);
		
		list = select2List(sql);
		
		return list;
	}
	
	public int save(ActionForm form, String userid, MultiInput mi) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		int res = 0;
		
		try{
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String seq_no = String2.nvl(form.getParam("seq_no"));
			String reg_dt = String2.nvl(form.getParam("reg_dt"));
			String contentReple = String2.nvl(form.getParam("contentReple")); 
			
			while( mi.next() ){
				
				if( mi.IS_UPDATE() ){
					sql.put(svc.getQuery("UPD_QNA"));
					 
					sql.setString(++i, mi.getString("ANS_CONTENT")); 
					sql.setString(++i, userid);
					sql.setString(++i, userid);
					sql.setString(++i, strcd);
					sql.setString(++i, seq_no);
					sql.setString(++i, reg_dt);
					
					res += update(sql);
				}
				sql.close();
			}
			
			
			
			
			if (res < 1) {
				throw new Exception("" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			
			
		}catch(Exception e){
			rollback();
            throw e;
		} finally {
			end();
		}
		
		return res;
	}
	
}
