package eord.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class EOrd102DAO extends AbstractDAO2 {
	public StringBuffer getMaster(ActionForm form) throws Exception {
		
		List list = null;
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = "";
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));					//점코드
			String strVencd = String2.nvl(form.getParam("vencd"));				//협력사코드
			String strPumbun = String2.nvl(form.getParam("pumben"));			//품번코드
			String strSlip_flag = String2.nvl(form.getParam("slip_flag"));		//전표구분
			String strShGb = String2.nvl(form.getParam("strShGb"));				//조회구분
			String sDate = String2.nvl(form.getParam("sDate"));					//시작일
			String eDate = String2.nvl(form.getParam("eDate"));					//종료일
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_LIST"));
			sql.setString(++i, strcd);
			sql.setString(++i, strPumbun);
			sql.setString(++i, strVencd);
			sql.setString(++i, strSlip_flag);
			sql.setString(++i, strcd);
			
			if( "1".equals(strShGb) ){		//발주일자
				sql.put(svc.getQuery("SEL_ORD_DT"));
				sql.setString(++i, sDate); 
				sql.setString(++i, eDate);
			} else if( "2".equals(strShGb) ){	//납품예정일
				sql.put(svc.getQuery("SEL_DELI_DT")); 
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);
			}
			
			sql.put(svc.getQuery("SEL_ORDERBY"));
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	}
	
    public List getPrintMaster(ActionForm form) throws Exception {

        List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        String query = "";

        try{
            sql = new SqlWrapper();
            svc = (Service)form.getService();

            String strStrCd = String2.nvl(form.getParam("StrCd"));   // 점코드
            String strSlipNo = String2.nvl(form.getParam("SlipNo")); // 전표번호

            // 전표번호 배열
            String slipArray[] = strSlipNo.split("\\,");
            int slipLength = slipArray.length;

            connect("pot");

            query = svc.getQuery("SEL_SLP_MST") + "\n";
            sql.setString(++i, strStrCd);

            // 전표번호 쿼리
            query += "AND SLP.SLIP_NO IN (";
            for (int k = 0; k < slipLength; k++) {
                if (k > 0) {
                    query += ", ";
                }
                query += "?";;
                sql.setString(++i, slipArray[k]);
            }
            query += ")\n";

            query += svc.getQuery("SEL_SLP_MST_ORDER_BY");
            sql.put(query);

            list = executeQuery(sql);

        }catch(Exception e){
            throw e;
        }

        return list;
    }

    public List getPrintDetail(ActionForm form) throws Exception {

        List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        String query = "";

        try{
            sql = new SqlWrapper();
            svc = (Service)form.getService();

            String strStrCd = String2.nvl(form.getParam("StrCd"));   // 점코드
            String strSlipNo = String2.nvl(form.getParam("SlipNo")); // 전표번호

            // 전표번호 배열
            String slipArray[] = strSlipNo.split("\\,");
            int slipLength = slipArray.length;

            connect("pot");

            query = svc.getQuery("SEL_SLP_DTL") + "\n";
            sql.setString(++i, strStrCd);

            // 전표번호 쿼리
            query += "AND DTL.SLIP_NO IN (";
            for (int k = 0; k < slipLength; k++) {
                if (k > 0) {
                    query += ", ";
                }
                query += "?";;
                sql.setString(++i, slipArray[k]);
            }
            query += ")\n";

            query += svc.getQuery("SEL_SLP_DTL_ORDER_BY");
            sql.put(query);

            list = executeQuery(sql);

        }catch(Exception e){
            throw e;
        }

        return list;
    }

}
