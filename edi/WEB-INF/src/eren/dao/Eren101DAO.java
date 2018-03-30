package eren.dao;

import java.util.List;

import ecom.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


public class Eren101DAO extends AbstractDAO {
	
	// MASTER조회	
    public String getMaster(ActionForm form) throws Exception {
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		String rtJson = null;
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));
			String strVencd = String2.nvl(form.getParam("vencd"));
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_MASTER"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			list = select2List(sql);
			
			Util util = new Util();
			String	cols= "STR_CD,STR_NM,CAL_YM,CNTR_ID,CAL_TYPE,CNTR_S_DT,CNTR_E_DT,RENT_TYPE,RENT_FLAG,RENT_DEPOSIT";
            		cols += ",MM_RENTFEE,RENT_AMT,RENT_VAT_AMT,TAX_AMT,TAX_VAT_AMT,NTAX_AMT,BAL_AMT";
            		cols += ",ARREAR_AMT,MOD_AMT,MOD_REASON,REAL_CHAREG_AMT";
			rtJson = util.listToJsonOBJ(list, cols);
			System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}

	// DETAIL조회	
    public String getDetail(ActionForm form) throws Exception {
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		String rtJson = null;
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService(); 
			
			String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
			String strCalYm 	= String2.nvl(form.getParam("strCalYm"));
			String strCntrId 	= String2.nvl(form.getParam("strCntrId"));
			String strCalType 	= String2.nvl(form.getParam("strCalType"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DETAIL"));
			sql.setString(++i, strStrCd);
			sql.setString(++i, strCalYm);
			sql.setString(++i, strCntrId);
			sql.setString(++i, strCalType);
			list = select2List(sql);
			
			Util util = new Util(); 
			String	cols= "MNTN_ITEM_NM,USE_QTY,USE_AMT"; 
			rtJson = util.listToJsonOBJ(list, cols);
			System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
}
