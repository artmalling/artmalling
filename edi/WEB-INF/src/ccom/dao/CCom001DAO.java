package ccom.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class CCom001DAO extends AbstractDAO2{
	
	public StringBuffer getPumbunCombo(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strcd    = String2.nvl(form.getParam("strcd"));
			String vencd    = String2.nvl(form.getParam("vencd"));
			String gb       = String2.nvl(form.getParam("gb"));
			String skuFlag  = String2.nvl(form.getParam("skuFlag"));
			String pumbunCd = String2.nvl(form.getParam("pumbunCd"));
			
			connect("pot");
			 
			sql.put(svc.getQuery("SEL_PUMBUNCOMBO"));
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			
			if(!"".equals(skuFlag)){ 	    // skuFlag : (1:단품, 2:비단품)   
				sql.setString(++i, skuFlag);
				sql.put(svc.getQuery("SEL_SKUFLAG_WHERE"));  
				if("1".equals(skuFlag)){
					sql.put(svc.getQuery("SEL_PUMBUNTYPE_WHERE1")); 
				}else{
					sql.put(svc.getQuery("SEL_PUMBUNTYPE_WHERE2"));
				}
			}
			
			if(!"".equals(pumbunCd)){	  // 품번
				sql.setString(++i, pumbunCd);
				sql.put(svc.getQuery("SEL_PUMBUNCD_WHERE"));
			}
			
			
			sql.put(svc.getQuery("SEL_PUMBUNCOMBO_ORDER"));		
			
			
			sb = executeQueryByAjax(sql);
			
			/*query = svc.getQuery("SEL_PUMBUNCOMBO") + "\n";
			
			if( "2".equals(gb) ){
				query += svc.getQuery("SEL_PUMBUN");
			}
			
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			
			if( "2".equals(gb) ){
				sql.setString(++i, pumbuncd);
			}*/
			sql.put(query);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
public StringBuffer getPumbunSTK(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strcd    = String2.nvl(form.getParam("strcd"));
			String vencd    = String2.nvl(form.getParam("vencd"));
			String gb       = String2.nvl(form.getParam("gb"));
			String skuFlag  = String2.nvl(form.getParam("skuFlag"));
			String skuType  = String2.nvl(form.getParam("skuType"));
			
			connect("pot");
			 
			sql.put(svc.getQuery("SEL_PUMBUNCOMBO"));
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			
			if(!"".equals(skuFlag)){ 	    // skuFlag : (1:단품, 2:비단품)   
				sql.setString(++i, skuFlag);
				sql.put(svc.getQuery("SEL_SKU_FLAG"));  
			}
			
			if(!"".equals(skuType)){ 	    // skuFlag : (1:규격, 2:신선, 3:의류)   
				sql.setString(++i, skuFlag);
				sql.put(svc.getQuery("SEL_SKU_TYPE"));  
			}
			
			sql.put(svc.getQuery("SEL_PUMBUNCOMBO_ORDER"));		
			
			sql.put(query);
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	public StringBuffer getEtcCode(ActionForm form) throws Exception {
			
			StringBuffer sb = null;
			SqlWrapper sql = null;
			Service svc = null;
			String query = "";
			int i = 0;
			
			try{
				sql = new SqlWrapper();
				svc = (Service) form.getService();
				
				sb = new StringBuffer();
				
				String syspat = String2.nvl(form.getParam("syspat"));
				String compart = String2.nvl(form.getParam("compart"));
				
				
				connect("pot");
				
				sql.put(svc.getQuery("SEL_ETCCODE"));
				sql.setString(++i, syspat);
				sql.setString(++i, compart);
				
				sb = executeQueryByAjax(sql);
				
			}catch(Exception e){
				throw e;
			}
			
			return sb;
		}
		
		
	public StringBuffer getTodayDB(ActionForm form) throws Exception {
			
			StringBuffer sb = null;
			SqlWrapper sql = null;
			Service svc = null;
			String query = "";
			int i = 0;
			
			try{
				sql = new SqlWrapper();
				svc = (Service) form.getService();
				
				sb = new StringBuffer();
				
				connect("pot");
				
				sql.put(svc.getQuery("SEL_TODAYDB"));
				
				sb = executeQueryByAjax(sql);
				
			}catch(Exception e){
				throw e;
			}
			
			return sb;
	}
	
	public StringBuffer getTodayTimeDB(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_TODAYTimeDB"));
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	
	
	public StringBuffer getPummokBlur(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));
			String strPummokCd = String2.nvl(form.getParam("strPummokCd"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_SKU_SALE_PRC"));
			sql.setString(1, strPumbuncd);
			sql.setString(2, strPummokCd);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	public StringBuffer getPmkSrtBlur(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));
			String strPmkSrtcd = String2.nvl(form.getParam("strPmkSrtCd"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PMKSRT_SALE_PRC"));
			sql.setString(1, strPumbuncd);
			
			if( !"".equals(strPmkSrtcd) ){
				sql.put(svc.getQuery("SEL_PBNPMKSRT_WHERE_PMKSRT_CD"));
				sql.setString(2, strPmkSrtcd);
			}
			sql.put(svc.getQuery("SEL_PBNPMKSRT_ORDER"));
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}

	public StringBuffer getCloseCheck(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strStrCd          = String2.nvl(form.getParam("strcd"));
			String strCloseDt        = String2.nvl(form.getParam("closeDt"));
			String strCloseTaskFlag  = String2.nvl(form.getParam("strCloseTaskFlag"));
			String strCloseUnitFlag  = String2.nvl(form.getParam("strCloseUnitFlag"));
			String strCloseAcntFlag  = String2.nvl(form.getParam("strCloseAcntFlag"));
			String strCloseFlag      = String2.nvl(form.getParam("strCloseFlag"));		
			
			
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_CLOSECHECK"));
			
			sql.setString(++i, strStrCd);		
			sql.setString(++i, strCloseDt);
			sql.setString(++i, strCloseTaskFlag);
			sql.setString(++i, strCloseUnitFlag);
			sql.setString(++i, strCloseAcntFlag);
			sql.setString(++i, strCloseFlag);	
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	
	public StringBuffer getPummok(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strPummokcd          = String2.nvl(form.getParam("strPummokcd"));
			String strPumbunCd       = String2.nvl(form.getParam("pumbunCd"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PBNPMK"));
			sql.setString(++i,strPumbunCd);
			
			if( !"".equals(strPummokcd) ){
				sql.put(svc.getQuery("SEL_PBNPMK_WHERE_PUMMOK_CD"));
				sql.setString(++i, strPummokcd);
			}
			
			sql.put(svc.getQuery("SEL_PBNPMK_ORDER"));		
			
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	public StringBuffer getPmkSrt(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strPumbunCd       = String2.nvl(form.getParam("pumbunCd"));
			String strPmkSrtcd       = String2.nvl(form.getParam("strPmkSrtcd"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PBNPMKSRT"));
			sql.setString(++i,strPumbunCd);
			
			if( !"".equals(strPmkSrtcd) ){
				sql.put(svc.getQuery("SEL_PBNPMKSRT_WHERE_PUMMOK_CD"));
				sql.setString(++i, strPmkSrtcd);
			}
			
			sql.put(svc.getQuery("SEL_PBNPMKSRT_ORDER"));		
			
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}	
	
	
	public StringBuffer getBizType(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			String strStrcd          = String2.nvl(form.getParam("strcd"));			//점코드
			String strVencd          = String2.nvl(form.getParam("vencd"));			//협력사코드
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_BIZTYPE"));
			sql.setString(++i,strStrcd);
			sql.setString(++i,strVencd);		
			
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	public StringBuffer getStrCd(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			sb = new StringBuffer();
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_STR_CD"));
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}

	/**
	 * <p> 협력사 반올림 구분  </p>
	 * 
	 */
	public StringBuffer getVenRoundFlag(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;		
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strCd = String2.nvl(form.getParam("strCd"));									//점코드
			String venCd = String2.nvl(form.getParam("venCd"));									//협력사코드
			
			connect("pot");
			sql.put(svc.getQuery("SEL_ROUNDFLAG"));
			sql.setString(++i, strCd);
			sql.setString(++i, venCd);
			
			sb = executeQueryByAjax(sql);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}

	/**
	* 전표상태를 조회한다.  
	*
	* @param  : 
	* @return :
	*/
	public StringBuffer getSlipProcStat(ActionForm form) throws Exception {
		StringBuffer sb = null;
	     SqlWrapper sql = null;
	     Service svc = null;      
	     String strQuery = "";
		 int i =1;
		 try {
		   connect("pot");
		   
		   svc = (Service) form.getService();
		   sql = new SqlWrapper();        
		   sb  = new StringBuffer();
		   
		   String strStrCd         = String2.nvl(form.getParam("strCd"));
		   String strSlipNo        = String2.nvl(form.getParam("slip_no")).replaceAll("-", "");
					
		   sql.setString(i++, strStrCd);		
		   sql.setString(i++, strSlipNo);
		   
		   strQuery = svc.getQuery("SEL_SLIP_PROC_STAT");
		   
		   sql.put(strQuery);		
	    
		   sb = executeQueryByAjax(sql);
	
	     } catch (Exception e) {
	       throw e;
	     }
	     return sb;
	}
}

