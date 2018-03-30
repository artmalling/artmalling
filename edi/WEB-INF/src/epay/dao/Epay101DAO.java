package epay.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Epay101DAO extends AbstractDAO2{
	public StringBuffer getMaster(ActionForm form) throws Exception {
		StringBuffer sb = null;
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try{
			sb = new StringBuffer();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));   			//점코드
			String strVencd = String2.nvl(form.getParam("vencd"));				//협력사코드
			String strBizType = String2.nvl(form.getParam("bizType"));			//거래형태 
			String sDate = String2.nvl(form.getParam("sDate"));					//시작월
			String eDate = String2.nvl(form.getParam("eDate"));					//종료월
			String strPayCyc = String2.nvl(form.getParam("strPayCyc"));			//지불주기
			String strPayCnt = String2.nvl(form.getParam("strPayCnt"));			//지불조회
			
			connect("pot");
			
			
			if( "0".equals(strBizType) || "1".equals(strBizType) ||  "4".equals(strBizType) || "5".equals(strBizType) ){			//거래형태 1,4,5 (직매입)
		        sql.put(svc.getQuery("SEL_BILL1"));
			} else if( "2".equals(strBizType) ){					//특정매입(2)
				sql.put(svc.getQuery("SEL_BILL2"));
				
				sql.setString(++i, strStrcd);
				sql.setString(++i, strVencd);
				sql.setString(++i, strBizType);
				sql.setString(++i, strPayCyc);
				sql.setString(++i, strPayCnt);
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);
				
			} else if( "3".equals(strBizType) ){					//임대을(3)
				sql.put(svc.getQuery("SEL_BILL3"));
				
				sql.setString(++i, strStrcd);
				sql.setString(++i, strVencd);
				sql.setString(++i, strBizType);
				sql.setString(++i, strPayCyc);
				sql.setString(++i, strPayCnt);
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);
			}
			
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strBizType);
			sql.setString(++i, strPayCyc);
			sql.setString(++i, strPayCnt);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	public List getdetail1(ActionForm form) throws Exception { 
		List list = null;
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));
			String strVencd = String2.nvl(form.getParam("strVencd"));
			String strPayYm = String2.nvl(form.getParam("strPayYm"));
			String strPayCyc = String2.nvl(form.getParam("strPayCyc"));
			String strPayCnt = String2.nvl(form.getParam("strPayCnt"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PREDEFDED1"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strPayYm);
			sql.setString(++i, strPayCyc);
			sql.setString(++i, strPayCnt);
			sql.setString(++i, strVencd);
			
			list = executeQuery(sql);
			
			
		}catch(Exception e){
			throw e;
		}
		
		return list;
	}
	
	public List getdetail2(ActionForm form) throws Exception { 
		List list = null;
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));
			String strVencd = String2.nvl(form.getParam("strVencd"));
			String strPayYm = String2.nvl(form.getParam("strPayYm"));
			String strPayCyc = String2.nvl(form.getParam("strPayCyc"));
			String strPayCnt = String2.nvl(form.getParam("strPayCnt"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PREDEFDED2"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strPayYm);
			sql.setString(++i, strPayCyc);
			sql.setString(++i, strPayCnt);
			sql.setString(++i, strVencd);
			
			list = executeQuery(sql);
			
			
		}catch(Exception e){
			throw e;
		}
		
		return list;
	}
	
	public List getdetail3(ActionForm form) throws Exception { 
		List list = null;
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));
			String strVencd = String2.nvl(form.getParam("strVencd"));
			String strPayYm = String2.nvl(form.getParam("strPayYm"));
			String strPayCyc = String2.nvl(form.getParam("strPayCyc"));
			String strPayCnt = String2.nvl(form.getParam("strPayCnt"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PREDEFDED3"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strPayYm);
			sql.setString(++i, strPayCyc);
			sql.setString(++i, strPayCnt);
			sql.setString(++i, strVencd);
			
			list = executeQuery(sql);
			
			
		}catch(Exception e){
			throw e;
		}
		
		return list;
	}
	
	
}
