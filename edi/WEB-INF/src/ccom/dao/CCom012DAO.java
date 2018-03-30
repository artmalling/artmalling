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

public class CCom012DAO extends AbstractDAO2 {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
	
	/*
	 *  품목코드 1건조회
	 */
	public StringBuffer getPumbunBlur(ActionForm form) throws Exception {
		
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
			String strPumbunCd 	= String2.nvl(form.getParam("strPumbunCd")); 	// 품번코드
			String strPumbunNm 	= String2.nvl(form.getParam("strPumbunNm")); 	// 품번명
			String skuFlag 		= String2.nvl(form.getParam("strGb")); 			// 구분
			 
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PUMBUN_SEL"));
			sql.setString(++i, strStrCd);
			sql.setString(++i, strVenCd);
			sql.setString(++i, strPumbunCd);
			sql.setString(++i, strPumbunNm);
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + skuFlag);
			
			if(!"".equals(skuFlag)){ 	    // skuFlag : (1:단품, 2:비단품)   
				sql.setString(++i, skuFlag);
				sql.put(svc.getQuery("SEL_SKUFLAG_WHERE"));  
				if("1".equals(skuFlag)){
					sql.put(svc.getQuery("SEL_PUMBUNTYPE_WHERE1")); 
				}else{
					sql.put(svc.getQuery("SEL_PUMBUNTYPE_WHERE2"));
				}
			}
			 
			sql.put(svc.getQuery("SEL_PUMBUNCOMBO_ORDER"));		 
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	/*
	 *  품목코드 조회
	 */
	public StringBuffer getPubunPop(ActionForm form) throws Exception {
		
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
			String strPumbunCd       = String2.nvl(form.getParam("strPumbunCd"));
			String strPumbunNm 		 = String2.nvl(form.getParam("strPumbunNm")); 	// 품번코드 	// 품번명
			String skuFlag 			 = String2.nvl(form.getParam("strGb")); 		
			System.out.println(">>>>>>>>>>>>>>>>>>>>> skuFlag : " + skuFlag);
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PBCODE"));
			sql.setString(++i,strStrCd);
			sql.setString(++i,strVenCd); 
			
			if( !"".equals(strPumbunCd) || !"".equals(strPumbunNm) ){
				sql.put(svc.getQuery("SEL_WHERE_PBCODE"));
				sql.setString(++i, strPumbunCd);
				sql.setString(++i, strPumbunNm); 
			} 
			
			if(!"".equals(skuFlag)){ 	    // skuFlag : (1:단품, 2:비단품)   
				sql.setString(++i, skuFlag);
				sql.put(svc.getQuery("SEL_SKUFLAG_WHERE"));  
				if("1".equals(skuFlag)){
					sql.put(svc.getQuery("SEL_PUMBUNTYPE_WHERE1")); 
				}else{
					sql.put(svc.getQuery("SEL_PUMBUNTYPE_WHERE2"));
				}
			}
			sql.put(svc.getQuery("SEL_PUMBUNCOMBO_ORDER"));		 
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+e);
			throw e;
		} 
		return sb;
	} 
 
}
