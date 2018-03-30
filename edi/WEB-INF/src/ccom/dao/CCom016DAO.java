package ccom.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm; 
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import kr.fujitsu.ffw.control.cfg.svc.Service;

/**
 * <p>공통으로 사용되는  DAO</p>
 * 
 * @created  on 1.0, 2011/02/17
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom016DAO extends AbstractDAO2 {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
	
	/*
	 *  협력사 코드 1건조회
	 */
	public StringBuffer getVenBlur(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			  
			String strStrCd 	= String2.nvl(form.getParam("strStrCd"));		// 점
			String strVenCd 	= String2.nvl(form.getParam("strVenCd"));		// 협력사 
			String strVenNm 	= String2.nvl(form.getParam("strVenNm"));		// 협력사 
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_VEN_SEL"));
			sql.setString(1, strStrCd);
			sql.setString(2, strVenCd); 
			sql.setString(3, strVenNm); 
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	/*
	 *  협력사코드 조회
	 */
	public StringBuffer getVenPop(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer(); 
			
			String strStrCd          = String2.nvl(form.getParam("strStrCd"));
			String strVenCd          = String2.nvl(form.getParam("strVenCd")); 
			String strVenNm 		 = String2.nvl(form.getParam("strVenNm"));		// 협력사 
			
			connect("pot"); 

			sql.put(svc.getQuery("SEL_VENCODE"));
			sql.setString(1, strStrCd);
			sql.setString(2, strVenCd); 
			sql.setString(3, strVenNm); 
			
			sb = executeQueryByAjax(sql);
			 
		}catch(Exception e){ 
			throw e;
		} 
		return sb;
	} 
 
}
