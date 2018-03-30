package ecmn.dao;

import java.net.URLDecoder;
import java.util.List;
import javax.servlet.http.HttpSession;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class ECmn101DAO extends AbstractDAO2{
	public StringBuffer getMaster(ActionForm form)throws Exception {
		
		List list = null;
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = "";
		
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
		
			String strcd = String2.nvl(form.getParam("strcd"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String pumben = String2.nvl(form.getParam("pumben"));
			String title = URLDecoder.decode(String2.nvl(form.getParam("title")), "UTF-8");
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			String read_cnt = String2.nvl(form.getParam("read_cnt"));
			
			connect("pot");
			
			query = svc.getQuery("SEL_NOTICE") + "\n";
			if( !"".equals(read_cnt) ){
				query += svc.getQuery("SEL_ROWNUM") + "\n";
			}
			

			sql.setString(++i, strcd);
			sql.setString(++i, title);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, pumben);
			sql.setString(++i, title);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			
			
			if( !"".equals(read_cnt) ){
				sql.setString(++i, read_cnt);
			}
			
			sql.put(query);
			sb = this.executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
	
public StringBuffer getMasterMain(ActionForm form)throws Exception {
		
		List list = null;
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = "";
		
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
		
			String strcd = String2.nvl(form.getParam("strcd"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String pumben = String2.nvl(form.getParam("pumben"));
			String title = URLDecoder.decode(String2.nvl(form.getParam("title")), "UTF-8");
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			String read_cnt = String2.nvl(form.getParam("read_cnt"));
			
			connect("pot");
			
			query = svc.getQuery("SEL_NOTICE_MAIN") + "\n";
			if( !"".equals(read_cnt) ){
				query += svc.getQuery("SEL_ROWNUM") + "\n";
			}
			
			sql.setString(++i, strcd);
			sql.setString(++i, title); 
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, pumben);
			sql.setString(++i, title); 
			
			
			if( !"".equals(read_cnt) ){
				sql.setString(++i, read_cnt);
			}
			
			sql.put(query);
			sb = this.executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
	public StringBuffer getDetail(ActionForm form)throws Exception{
		
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		List list = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String seqNo = String2.nvl(form.getParam("seqNo"));
			String reg_dt = String2.nvl(form.getParam("reg_dt"));
			
			if( strcd.length() == 1 ){
				strcd = "0" + strcd;
			}
			
			connect("pot"); 
			
			sql.put(svc.getQuery("SEL_DETAIL"));
			sql.setString(++i, strcd);
			sql.setString(++i, seqNo);
			sql.setString(++i, reg_dt);
			
			sb = executeQueryByAjax(sql);
			list = executeQuery(sql);
			
			sql.close();
			if( list.size() > 0 ){
				updateReadCnt(strcd, seqNo, reg_dt, form);
			}
						
		}catch(Exception e){
			 throw e;
		}
		
		return sb;
	}
	
	public void updateReadCnt(String strcd, String seqno, String reg_dt, ActionForm form)throws Exception {
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		int ret = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			connect("pot");
			begin();
			
			sql.close();
			sql.put(svc.getQuery("INT_CNT"));
			sql.setString(++i, strcd);
			sql.setString(++i, seqno);
			sql.setString(++i, reg_dt);
			
			ret = executeUpdate(sql);
			
		}catch(Exception e){
			e.printStackTrace();
			
		} finally {
			end();
		}
	}
}
