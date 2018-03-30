package esal.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Esal107DAO extends AbstractDAO2 {
	public StringBuffer getMaster(ActionForm form ) throws Exception {
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			sb = new StringBuffer();   
		     
			String strCd    = String2.nvl(form.getParam("strCd"));			//점코드
			String venCd    = String2.nvl(form.getParam("venCd"));			//협력사코드
			String pumbunCd = String2.nvl(form.getParam("pumbunCd"));		//품번코드
			String pummokCd = String2.nvl(form.getParam("pummokCd"));		//품목코드
			String sDate    = String2.nvl(form.getParam("sDate"));			//일자
			String stkYm    = String2.nvl(form.getParam("stkYm"));			//년도
			String stkSDt   = String2.nvl(form.getParam("stkSDt"));			//시작일
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_MASTER"));
			sql.setString(++i, strCd);
			sql.setString(++i, stkYm);
			sql.setString(++i, venCd);
			sql.setString(++i, strCd);
			sql.setString(++i, stkSDt);
			sql.setString(++i, sDate);
			sql.setString(++i, venCd);
			
			if(!pumbunCd.equals("")){
				sql.put(svc.getQuery("SEL_MASTER_WHERE_PUMBUN_CD"));
				sql.setString(++i, pumbunCd);
			}
			if(!pummokCd.equals("")){
				sql.put(svc.getQuery("SEL_MASTER_WHERE_PUMMOK_CD"));
				sql.setString(++i, pummokCd);
			}
			//if(!strSkuCd.equals("")){
			//	strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_CD") + "\n";
			//	sql.setString(i++, strSkuCd);
			//}		
			
			sql.put(svc.getQuery("SEL_MASTER_GROUP"));
			sql.put(svc.getQuery("SEL_MASTER_ORDER"));
			
			sb= executeQueryByAjax(sql);
			System.out.println("!!!!!::"+sb.toString());
			
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	}
	
	public List getExcel(ActionForm form ) throws Exception {
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		List list = null;
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
		     
			String strCd    = String2.nvl(form.getParam("strCd"));			//점코드
			String venCd    = String2.nvl(form.getParam("venCd"));			//협력사코드
			String pumbunCd = String2.nvl(form.getParam("pumbunCd"));		//품번코드
			String pummokCd = String2.nvl(form.getParam("pummokCd"));		//품목코드
			String sDate    = String2.nvl(form.getParam("sDate"));			//일자
			String stkYm    = String2.nvl(form.getParam("stkYm"));			//년도
			String stkSDt   = String2.nvl(form.getParam("stkSDt"));			//시작일
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_MASTER"));
			sql.setString(++i, strCd);
			sql.setString(++i, stkYm);
			sql.setString(++i, venCd);
			sql.setString(++i, strCd);
			sql.setString(++i, stkSDt);
			sql.setString(++i, sDate);
			sql.setString(++i, venCd);
			
			if(!pumbunCd.equals("")){
				sql.put(svc.getQuery("SEL_MASTER_WHERE_PUMBUN_CD"));
				sql.setString(++i, pumbunCd);
			}
			if(!pummokCd.equals("")){
				sql.put(svc.getQuery("SEL_MASTER_WHERE_PUMMOK_CD"));
				sql.setString(++i, pummokCd);
			}
			
			sql.put(svc.getQuery("SEL_MASTER_GROUP"));
			sql.put(svc.getQuery("SEL_MASTER_ORDER"));
			
			list = executeQueryByList(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return list;
	}
}
