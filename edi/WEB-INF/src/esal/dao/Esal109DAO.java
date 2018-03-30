package esal.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Esal109DAO extends AbstractDAO2{
	
	public StringBuffer getMaster(ActionForm form) throws Exception{
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new  StringBuffer();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));				//점코드
			String strVencd = String2.nvl(form.getParam("vencd"));				//협력사코드
			String strPumbuncd = String2.nvl(form.getParam("pumbumCd"));		//품번코드
			String sDate = String2.nvl(form.getParam("sDate"));					//시작일
			String eDate = String2.nvl(form.getParam("eDate"));					//종료일
			String sDate2 = String2.nvl(form.getParam("sDate2"));				//시작일
			String eDate2 = String2.nvl(form.getParam("eDate2"));				//종료일
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DAYMGPBN"));
			
			//행사 매출
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			//정상 매출
			sql.setString(++i, eDate);
			sql.setString(++i, sDate);
			
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			//정상 대비
			sql.setString(++i, eDate2);
			sql.setString(++i, sDate2);
			
			sql.setString(++i, sDate2);
			sql.setString(++i, eDate2);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			//정상 매출
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);		
			
			// 행사 매출
			sql.setString(++i, eDate);
			sql.setString(++i, sDate);
			
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			// 행사 대비
			sql.setString(++i, eDate2);
			sql.setString(++i, sDate2);
			
			sql.setString(++i, sDate2);
			sql.setString(++i, eDate2);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			// 브랜드계 매출
			sql.setString(++i, eDate);
			sql.setString(++i, sDate);
			
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);			
			
			// 브랜드계 대비
			sql.setString(++i, eDate2);
			sql.setString(++i, sDate2);
			
			sql.setString(++i, sDate2);
			sql.setString(++i, eDate2);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			sb = executeQueryByAjax(sql);
			
			System.out.println(sb);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}

	public StringBuffer getMaster2(ActionForm form) throws Exception{
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new  StringBuffer();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));				//점코드
			String strVencd = String2.nvl(form.getParam("vencd"));				//협력사코드
			String strPumbuncd = String2.nvl(form.getParam("pumbumCd"));		//품번코드
			String sDate = String2.nvl(form.getParam("sDate"));					//시작일
			String eDate = String2.nvl(form.getParam("eDate"));					//종료일
			String sDate2 = String2.nvl(form.getParam("sDate2"));				//시작일
			String eDate2 = String2.nvl(form.getParam("eDate2"));				//종료일
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DAYMGPBN2"));
			
			sql.setString(++i, eDate);
			sql.setString(++i, sDate);
			
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			sql.setString(++i, eDate2);
			sql.setString(++i, sDate2);
			
			sql.setString(++i, sDate2);
			sql.setString(++i, eDate2);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			sb = executeQueryByAjax(sql);
			
			System.out.println(sb);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
	public StringBuffer getDateChange(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;		
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strStrCd = String2.nvl(form.getParam("strcd"));		
			String strSdate = String2.nvl(form.getParam("strSdate"));	

			connect("pot"); 
			
			sql.put(svc.getQuery("SEL_CMPR_DT"));
			
			sql.setString(++i, strSdate);
			sql.setString(++i, strStrCd);
			sql.setString(++i, strSdate);
			
			sb = executeQueryByAjax(sql);
			System.out.println(sb);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
	public StringBuffer getDateChange2(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;		
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strStrCd = String2.nvl(form.getParam("strcd"));		
			String strEdate = String2.nvl(form.getParam("strEdate"));		

			connect("pot"); 
			
			sql.put(svc.getQuery("SEL_CMPR_DT2"));
			
			sql.setString(++i, strEdate);
			sql.setString(++i, strStrCd);
			sql.setString(++i, strEdate);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
}
