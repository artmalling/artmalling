package eord.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import ecom.util.Util;

public class EOrd101DAO extends AbstractDAO2{
	public StringBuffer getList(ActionForm form) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		StringBuffer sb = null;
		int i = 0;
		String query = "";
		
		try{
			
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			sb = new StringBuffer();

			String strcd = String2.nvl(form.getParam("strcd"));		//점코드
			String vencd = String2.nvl(form.getParam("vencd"));	    //협력사코드
			String pumbuncd = String2.nvl(form.getParam("pubumCd"));   //품번코드
			String slip_proc_falg = String2.nvl(form.getParam("slip_proc_falg"));	//전표상태
			String gjDate = String2.nvl(form.getParam("gjDate"));			//기준일
			String sDate = String2.nvl(form.getParam("sDate")).replaceAll("/", "");				//시작일
			String eDate = String2.nvl(form.getParam("eDate")).replaceAll("/", "");				//종료일
			String slip_falg = String2.nvl(form.getParam("slip_falg"));			//전표구분
			
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_LIST"));
			sql.setString(++i, slip_proc_falg);
			sql.setString(++i, pumbuncd);
			sql.setString(++i, vencd);
			sql.setString(++i, slip_falg);
			sql.setString(++i, strcd);
			
			if("0".equals(gjDate)){					// 발주일
				sql.put(svc.getQuery("SEL_ORD_DT"));
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);
			} else if("1".equals(gjDate)){			// 발주확정일
				sql.put(svc.getQuery("SEL_ORD_CONF"));    
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);	             
			} else if("2".equals(gjDate)){			// 납품예정일
				sql.put(svc.getQuery("SEL_DELI_DT"));
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);		
			} else if("3".equals(gjDate)){			// 검품확정일
				sql.put(svc.getQuery("SEL_CHK_DT"));
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
	
	public StringBuffer getMaster(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;		
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strcd = String2.nvl(form.getParam("strcd"));		//점코드
			String slip_no = String2.nvl(form.getParam("slip_no"));	//전표번호
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_MASTER"));
			sql.setString(++i, strcd);
			sql.setString(++i, slip_no);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
public StringBuffer getDetail(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;		
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strcd = String2.nvl(form.getParam("strcd"));		//점코드
			String slip_no = String2.nvl(form.getParam("slip_no"));	//전표번호
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DETAIL"));
			sql.setString(++i, strcd);
			sql.setString(++i, slip_no);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
}
	
public StringBuffer getpumbunGbBun(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;		
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strcd = String2.nvl(form.getParam("strcd"));		//점코드
			String ven_cd = String2.nvl(form.getParam("vencd"));	//협력사코드
			String pumbuncd = String2.nvl(form.getParam("pumbuncd"));	//품번코드
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PUMBUNGB"));
			sql.setString(++i, strcd);
			sql.setString(++i, pumbuncd);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
}

public StringBuffer getMarginFlag(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;		
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String strcd = String2.nvl(form.getParam("strcd"));		//점코드
		String pumbuncd = String2.nvl(form.getParam("pumbuncd"));	//협력사코드
		String marginAppdt = String2.nvl(form.getParam("marginAppdt")).trim().replaceAll("/", "");	//품번코드
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MARGIN_FLAG"));
		sql.setString(++i, strcd);
		sql.setString(++i, pumbuncd);
		sql.setString(++i, marginAppdt);
		
		sb = executeQueryByAjax(sql);
		
	}catch(Exception e){
		throw e;
	}
	return sb;
}

public StringBuffer getMarginRate(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;		
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String strcd = String2.nvl(form.getParam("strcd"));											//점코드
		String pumbuncd = String2.nvl(form.getParam("pumbuncd"));									//협력사코드
		String marginAppdt = String2.nvl(form.getParam("marginAppdt")).trim().replaceAll("/", "");	//마진적용일
		String marginGbn = String2.nvl(form.getParam("marginGbn"));									//행사구분
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MARGIN_RATE"));
		sql.setString(++i, strcd);
		sql.setString(++i, pumbuncd);
		sql.setString(++i, marginAppdt);
		sql.setString(++i, marginGbn);
		
		sb = executeQueryByAjax(sql);
		
		
		
	}catch(Exception e){
		throw e;
	}
	return sb;
}

public StringBuffer slip_flag(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;		
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String strcd = String2.nvl(form.getParam("strcd"));		//점코드
		String slip_no = String2.nvl(form.getParam("slip_no"));	//전표번호
		
		connect("pot");
		
		sql.put(svc.getQuery("MASTER_SLIP"));
		sql.setString(++i, strcd);
		sql.setString(++i, slip_no);
		
		sb = executeQueryByAjax(sql);
		
	}catch(Exception e){
		throw e;
	}
	return sb;
}

public StringBuffer detailDel(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int ret = 0;
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String del_status [] = String2.nvl(form.getParam("de_rowStatus")).split("/");										//상태
		String del_strcd [] = String2.nvl(form.getParam("de_strcd")).split("/");											//점코드
		String de_slip_no [] = String2.nvl(form.getParam("de_slip_no")).split("/");											//전표번호
		String de_ord_seqno [] = String2.nvl(form.getParam("de_ord_seqno")).split("/");									    //전표순서
		
		connect("pot");
		begin();
		
		for( int j = 0 ; j < del_strcd.length; j++  ){
			int i = 0 ;
			sql.put(svc.getQuery("DEL_DETAIL"));
			sql.setString(++i, del_strcd[j]);
			sql.setString(++i, de_slip_no[j]);
			sql.setString(++i, de_ord_seqno[j]);
			ret += executeUpdate(sql);
			sql.close();
		}
		
		if( ret > 0 ){				
			sb.append("<?xml version='1.0' encoding='utf-8'?>");
			sb.append("<t>");
			sb.append("<r id='1'>");
			sb.append("<c id='RET'>").append(ret);
			sb.append("</c>");
			sb.append("</r>");
			sb.append("</t>");
		}else {
			rollback();
			sb.append("<?xml version='1.0' encoding='utf-8'?>");
			sb.append("<t>");
			sb.append("<r id='1'>");
			sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
			sb.append("</c>");
			sb.append("</r>");
			sb.append("</t>");
		}
		
		
	}catch(Exception e){
		rollback();
		throw e;
	} finally {
		end();
	}
	return sb;
}  

public StringBuffer getSkuInfo(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;		
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String d_pumbuncd = String2.nvl(form.getParam("d_pumbuncd"));											//점코드
		String strPummokcd = String2.nvl(form.getParam("strPummokcd"));									//협력사코드
		
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_SKU_SALE_PRC")); 
		sql.setString(++i, d_pumbuncd);
		sql.setString(++i, strPummokcd);
		
		
		sb = executeQueryByAjax(sql);
		
	}catch(Exception e){
		throw e;
	}
	return sb;
}


public StringBuffer save(ActionForm form, String userid) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int ret 	= 0;
	int res 	= 0;
	int i   	= 0;
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String m_rowStatus = String2.nvl(form.getParam("m_rowStatus"));
		
		if( "3".equals(m_rowStatus) ){		//마스터 신규
			
			ret = masterInsert(form, userid);
		} else {							//마스터 저장
			
			res = masterModify(form, userid);
		}
		
		
		
		if( ret > 0 || res > 0 ){				
			sb.append("<?xml version='1.0' encoding='utf-8'?>");
			sb.append("<t>");
			sb.append("<r id='1'>");
			sb.append("<c id='RET'>").append((ret+res));
			sb.append("</c>");
			sb.append("</r>");
			sb.append("</t>");
		}else {
			rollback();
			sb.append("<?xml version='1.0' encoding='utf-8'?>");
			sb.append("<t>");
			sb.append("<r id='1'>");
			sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
			sb.append("</c>");
			sb.append("</r>");
			sb.append("</t>");
		}
		
		
		
	}catch(Exception e){
		rollback();
		throw e;
	} finally {
		end();
	}
	return sb;
} 

public int masterModify(ActionForm form, String userid) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;	
	int ret = 0;
	int res = 0;
	int mstCnt = 0;
	String strSlipNo  = "";		// 전표번호
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String sv_strcd 		= String2.nvl(form.getParam("sv_strcd"));
		String sv_slip_no 		= String2.nvl(form.getParam("sv_slip_no"));
		String sv_slip_flag 	= String2.nvl(form.getParam("sv_slip_flag"));
		String sv_sh_gbn 		= String2.nvl(form.getParam("sv_sh_gbn"));
		String sv_pb_cd 		= String2.nvl(form.getParam("sv_pb_cd"));
		String sv_baljujc 		= String2.nvl(form.getParam("sv_baljujc"));
		String sv_bjdate 		= String2.nvl(form.getParam("sv_bjdate")).trim().replaceAll("/", "");
		String sv_bjhjdate 		= String2.nvl(form.getParam("sv_bjhjdate"));
		String sv_hrs_cd 		= String2.nvl(form.getParam("sv_hrs_cd"));
		String gs_gbn 			= String2.nvl(form.getParam("gs_gbn"));
		String sv_npyjdate 		= String2.nvl(form.getParam("sv_npyjdate")).trim().replaceAll("/", "");
		String buyercd 			= String2.nvl(form.getParam("buyercd"));
		String majindate 		= String2.nvl(form.getParam("majindate")).trim().replaceAll("/", "");
		String sv_hs_gbn 		= String2.nvl(form.getParam("sv_hs_gbn"));
		String sv_hs_rate 		= String2.nvl(form.getParam("sv_hs_rate"));
		String sv_gpwjDate 		= String2.nvl(form.getParam("sv_gpwjDate"));
		String sv_spg 			= String2.nvl(form.getParam("sv_spg")).replaceAll(",","");
		String sv_wgg 			= String2.nvl(form.getParam("sv_wgg")).replaceAll(",","");
		String sv_mgg 			= String2.nvl(form.getParam("sv_mgg")).replaceAll(",","");
		String sv_etc 			= String2.nvl(form.getParam("sv_etc")).replaceAll(",","");
		String sv_gap_tot_amt 	= String2.nvl(form.getParam("sv_gap_tot_amt")).replaceAll(",", "");	//차익액합
		String sv_new_gap_rate 	= String2.nvl(form.getParam("sv_new_gap_rate"));					//차익율
		String sv_vat_tamt 		= String2.nvl(form.getParam("sv_vat_tamt"));						//부가세
		String sv_dtl_cnt 		= String2.nvl(form.getParam("sv_dtl_cnt"));							//명세건수
		String sv_biz_type 		= String2.nvl(form.getParam("sv_biz_type"));						//biz_type
		String norm_mg_rate 	= String2.nvl(form.getParam("norm_mg_rate"));						//마진율
		String d_ord_qty 	    = String2.nvl(form.getParam("by_d_sv_ord_qty"));				
		
		connect("pot");
		begin();
		 
		i = 1; 
			sql.put(svc.getQuery("UPD_MASTER"));		

			sql.setString(i++, sv_slip_flag);
			sql.setString(i++, sv_sh_gbn);
			sql.setString(i++, sv_pb_cd);
			sql.setString(i++, sv_bjdate);
			sql.setString(i++, sv_npyjdate);
			sql.setString(i++, majindate);
			sql.setString(i++, sv_hs_gbn);
			sql.setString(i++, sv_hs_rate);
			sql.setString(i++, sv_etc);
			sql.setString(i++, sv_spg);
			sql.setString(i++, sv_wgg);
			sql.setString(i++, sv_mgg);
			sql.setString(i++, sv_gap_tot_amt);			//mi1.getString("GAP_TOT_AMT") 수정 차익액합
			sql.setString(i++, sv_new_gap_rate);	    //mi1.getString("NEW_GAP_RATE") 수정  신차익율
			sql.setString(i++, sv_vat_tamt);	    	//mi1.getString("vat amt") 수정 부가세   
			sql.setString(i++,  sv_dtl_cnt);
			sql.setString(i++, userid);
			sql.setString(i++, sv_strcd);
			sql.setString(i++, sv_slip_no);
			 
			 ret = executeUpdate(sql);
			 
			sql.close();
		    i = 1;				
			sql.put(svc.getQuery("INS_MASTER_LOG"));
			
			sql.setString(i++, sv_strcd);  
			sql.setString(i++, sv_slip_no);;
			sql.setString(i++, sv_slip_flag);
			sql.setString(i++, "00");    
			sql.setString(i++, sv_strcd);  
			sql.setString(i++, sv_slip_no);
			sql.setString(i++, sv_slip_flag);
			sql.setString(i++, "00");
			mstCnt += executeUpdate(sql);	
			    
			    if( ret > 0 ){
	  
			    	String d_sv_strcd [] 			= form.getParam("d_sv_strcd").split("/");
			        String d_sv_rowStatus [] 		= form.getParam("d_sv_rowStatus").split("/");
			        String d_sv_slip_no [] 			= form.getParam("d_sv_slip_no").split("/");
			        String d_sv_ord_seqno [] 		= form.getParam("d_sv_ord_seqno").split("/");
			        String d_sv_no [] 				= form.getParam("d_sv_no").split("/");
			        String d_sv_pmksrt_cd [] 		= form.getParam("d_sv_pmksrt_cd").split("/");
			        String d_sv_pummok_cd [] 		= form.getParam("d_sv_pummok_cd").split("/");
			        String d_sv_ord_unit_cd [] 		= form.getParam("d_sv_ord_unit_cd").split("/");
			        String d_sv_ord_qty [] 			= form.getParam("d_sv_ord_qty").split("/");
			        String d_sv_mg_rate [] 			= form.getParam("d_sv_mg_rate").split("/");
			        String d_sv_new_cost_prc [] 	= form.getParam("d_sv_new_cost_prc").split("/");
			        String d_sv_new_cost_amt [] 	= form.getParam("d_sv_new_cost_amt").split("/");
			        String d_sv_new_sale_prc [] 	= form.getParam("d_sv_new_sale_prc").split("/");
			        String d_sv_new_sale_amt [] 	= form.getParam("d_sv_new_sale_amt").split("/");
			        String d_sv_tag_flag [] 		= form.getParam("d_sv_tag_flag").split("/");
			        String d_sv_tag_prt_own_flag [] = form.getParam("d_sv_tag_prt_own_flag").split("/");
			        String d_sv_new_gat_amt [] 		= form.getParam("d_sv_new_gat_amt").split("/");
			        String d_sv_vat_amt []			= form.getParam("d_sv_vat_amt").split("/");

					System.out.println("!234234234234234234234234234!$"+sv_slip_no);
			        res = DetailDelete(form, sv_strcd, sv_slip_no); 

				    if( d_sv_strcd.length > 0 ){
					    for(int j = 0; j < d_sv_strcd.length; j++){
					    	if(!d_sv_new_sale_amt[j].equals("0")) {
							 res += de_insert(form , userid, sv_slip_no, sv_strcd, d_sv_pmksrt_cd[j], d_sv_pummok_cd[j], d_sv_ord_unit_cd[j], d_sv_ord_qty[j], d_sv_mg_rate[j],  d_sv_new_cost_prc[j], 
									 d_sv_new_cost_amt[j], d_sv_new_sale_prc[j], d_sv_new_sale_amt[j],d_sv_tag_flag[j], sv_pb_cd, sv_hrs_cd, sv_slip_flag,d_sv_tag_prt_own_flag[j], d_sv_new_gat_amt[j], d_sv_vat_amt[j]);
					    	}
					    }
				    } 
				    UpdateMaster(form, sv_strcd, sv_slip_no);
				 }
 
			System.out.println("!123123!$"+ret);
	}catch(Exception e){
		rollback();
		System.out.println("~~~~~~~~~~~~~~~"+e);
		throw e;
	} finally {
		end();
	}
	 
	return ret;
}

public int UpdateMaster(ActionForm form, String sv_strcd, String sv_slip_no) throws Exception {
	SqlWrapper sql = null;
	Service svc = null;
	int res = 0; 
	
	try{   
		sql = new SqlWrapper();
		svc = (Service) form.getService();
 
		sql.close();
		//System.out.println("아아아아아아아아아아아");
		sql.put(svc.getQuery("UPD_MASTER_LAST"));		

		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ : "+sv_strcd);
		sql.setString(1, sv_strcd);
		//System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! : "+sv_slip_no);
		sql.setString(2, sv_slip_no); 
		res = executeUpdate(sql);
		sql.close();
	}
	catch(Exception e){ 
		System.out.println("Error : " + e);
		throw e;
	}
	return res;
}

public int DetailDelete(ActionForm form, String strcd, String slipNo ) throws Exception {
	
	
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;	
	int ret = 0;
	String ord_seqNo = "";
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
 
		sql.close();
		sql.put(svc.getQuery("DEL_DETAIL_ALL")); 
		
		sql.setString(1, strcd);
		sql.setString(2, slipNo);
		ret = executeUpdate(sql);
		sql.close();
		 
	}catch(Exception e){ 
		throw e; 
	}
	return ret;
}

/**
 * <p> 전표번호 조회</p>
 * 
 */
public String slipno(ActionForm form) throws Exception{
	String returnJson = null;
	List list = null;
	SqlWrapper sql = null; 
	Service svc = null;
	int i = 0;
	Util util = new Util();
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		String sv_strcd 		= String2.nvl(form.getParam("sv_strcd")); 
		String sv_bjdate 		= String2.nvl(form.getParam("sv_bjdate")).trim().replaceAll("/", ""); 
		String sv_slip_flag     = String2.nvl(form.getParam("sv_slip_flag")); 
		connect("pot");
		
		// 전표번호를 생성한다.(시퀀스사용)
		sql.put(svc.getQuery("SEL_SLIP_NO"));	
		sql.setString(1, sv_strcd);
		sql.setString(2, sv_bjdate);
		sql.setString(3, sv_slip_flag);
		  
		list = executeQueryByList(sql);
		
		String cols = "SLIP_NO";
 
		returnJson = util.listToJsonOBJ(list, cols);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+returnJson);
		
	}catch(Exception e){
		throw e;
	}
	
	return returnJson;
} 

public int masterInsert(ActionForm form, String userid) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;	
	int ret = 0;
	int mstCnt = 0;
	String strSlipNo  = "";		// 전표번호
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String sv_strcd 		= String2.nvl(form.getParam("sv_strcd"));
		String sv_slip_no 		= String2.nvl(form.getParam("sv_slip_no")); 
		String sv_slip_flag 	= String2.nvl(form.getParam("sv_slip_flag"));
		String sv_sh_gbn		= String2.nvl(form.getParam("sv_sh_gbn"));
		String sv_pb_cd 		= String2.nvl(form.getParam("sv_pb_cd"));
		String sv_baljujc 		= String2.nvl(form.getParam("sv_baljujc"));
		String sv_bjdate 		= String2.nvl(form.getParam("sv_bjdate")).trim().replaceAll("/", "");
		String sv_bjhjdate 		= String2.nvl(form.getParam("sv_bjhjdate"));
		String sv_hrs_cd 		= String2.nvl(form.getParam("sv_hrs_cd"));
		String gs_gbn 			= String2.nvl(form.getParam("gs_gbn"));
		String sv_npyjdate 		= String2.nvl(form.getParam("sv_npyjdate")).trim().replaceAll("/", "");
		String buyercd 			= String2.nvl(form.getParam("buyercd"));
		String majindate 		= String2.nvl(form.getParam("majindate")).trim().replaceAll("/", "");
		String sv_hs_gbn 		= String2.nvl(form.getParam("sv_hs_gbn"));
		String sv_hs_rate 		= String2.nvl(form.getParam("sv_hs_rate"));
		String sv_gpwjDate		= String2.nvl(form.getParam("sv_gpwjDate"));
		String sv_spg 			= String2.nvl(form.getParam("sv_spg")).replaceAll(",","");
		String sv_wgg 			= String2.nvl(form.getParam("sv_wgg")).replaceAll(",","");
		String sv_mgg 			= String2.nvl(form.getParam("sv_mgg")).replaceAll(",","");
		String sv_etc 			= String2.nvl(form.getParam("sv_etc")).replaceAll(",","");
		String sv_gap_tot_amt 	= String2.nvl(form.getParam("sv_gap_tot_amt")).replaceAll(",", "");	//차익액합
		String sv_new_gap_rate 	= String2.nvl(form.getParam("sv_new_gap_rate"));					//차익율
		String sv_vat_tamt 		= String2.nvl(form.getParam("sv_vat_tamt"));						//부가세
		String sv_dtl_cnt 		= String2.nvl(form.getParam("sv_dtl_cnt"));							//명세건수
		String sv_biz_type 		= String2.nvl(form.getParam("sv_biz_type"));						//biz_type
		String norm_mg_rate 	= String2.nvl(form.getParam("norm_mg_rate"));						//마진율
		String d_ord_qty 	= String2.nvl(form.getParam("by_d_sv_ord_qty"));						  
		
		connect("pot");
		begin(); 
		
	/*	// 전표번호를 생성한다.(시퀀스사용)
		sql.put(svc.getQuery("SEL_SLIP_NO"));	
		sql.setString(1, sv_strcd);
		sql.setString(2, sv_bjdate);
		
		Map mapSlipNo = (Map)executeQueryByMap(sql);
		strSlipNo = mapSlipNo.get("SLIP_NO").toString();*/
		 
		sql.close();
		
		String strDetailCount	= String2.nvl(form.getParam("sv_dtl_cnt"));
		
		
		
		i = 1; 
		// 3. 마스터테이블에 저장
		
			sql.put(svc.getQuery("INS_MASTER"));
			
			 sql.setString(i++, sv_slip_no); 
			 sql.setString(i++, sv_strcd);  
			 sql.setString(i++, sv_pb_cd); 
			 sql.setString(i++, sv_hrs_cd);   
			 sql.setString(i++, sv_slip_flag);
			 sql.setString(i++, "1");  							/* 발주주체구분 : (0: 백화점발주, 1: EDI발주, 2: PDA발주, 3: 사은품발주, 4: EDI대행업체발주) */ 
			 sql.setString(i++, "0");    						/* 발주구분           : 0(일반) */  
			 sql.setString(i++, "0"); 							/* 자동전표구분 : 0(일반전표) */   
			 sql.setString(i++, "0"); 							/* 사전사후구분 : 0(사전전표) */ 
			 sql.setString(i++, sv_bjdate);						/* 발주일 */    
			 sql.setString(i++, sv_npyjdate);					/* 납품예정일 */
			 sql.setString(i++, majindate);						/* 마진적용일 */
			 sql.setString(i++, sv_hs_gbn);						/* 행사구분 */
			 sql.setString(i++, sv_hs_rate);					/* 행사율 */
			 sql.setString(i++, "        ");					/* SM확정일자 */
			 sql.setString(i++, "");							/* SM ID */  
			 sql.setString(i++, "");							/* 바이어ID */
			 sql.setString(i++, "        ");					/* 바이어확정일자(발주확정일자) */ 
			 sql.setString(i++, buyercd);          
			 sql.setString(i++, "00");   
			 sql.setString(i++, sv_dtl_cnt);     
			 sql.setString(i++, sv_spg);						//mi1.getString("ORD_TOT_QTY") 수량계 
			 sql.setString(i++, sv_wgg); 						//mi1.getString("NEW_COST_TAMT") 원가계
			 sql.setString(i++, sv_mgg);  						//mi1.getString("NEW_SALE_TAMT")  매가계 
			 sql.setString(i++, sv_gap_tot_amt); 				//GAP_TOT_AMT  신차익액
			 sql.setString(i++, sv_new_gap_rate);  				//NEW_GAP_RATE 신차익율
			 sql.setString(i++, sv_vat_tamt);  					//VAT_TAMT 부가세
			 sql.setString(i++, sv_etc);        
			 sql.setString(i++, sv_biz_type);      
			 sql.setString(i++, gs_gbn);     
			 sql.setString(i++, "N");   
			 sql.setString(i++, userid); 
			 sql.setString(i++, userid);
			 sql.setString(i++, userid);  
			 
			 ret = executeUpdate(sql);
			 sql.close();
			
			i = 1; 
			sql.put(svc.getQuery("INS_MASTER_LOG"));
			sql.setString(i++, sv_strcd);  
			sql.setString(i++, sv_slip_no);
			sql.setString(i++, sv_slip_flag);
			sql.setString(i++, "00");    
			sql.setString(i++, sv_strcd);  
			sql.setString(i++, sv_slip_no);
			sql.setString(i++, sv_slip_flag);
			sql.setString(i++, "00");
			
			mstCnt = executeUpdate(sql);
			sql.close();
			
			if( ret > 0 ){	
				String d_sv_strcd [] = form.getParam("d_sv_strcd").split("/");
				
				if( d_sv_strcd.length > 0 ){
					 String d_sv_rowStatus [] 			= form.getParam("d_sv_rowStatus").split("/");
				     String d_sv_slip_no []	 			= form.getParam("d_sv_slip_no").split("/");
				     String d_sv_ord_seqno [] 			= form.getParam("d_sv_ord_seqno").split("/");
				     String d_sv_no [] 					= form.getParam("d_sv_no").split("/");
				     String d_sv_pmksrt_cd [] 			= form.getParam("d_sv_pmksrt_cd").split("/");
				     String d_sv_pummok_cd [] 			= form.getParam("d_sv_pummok_cd").split("/");
				     String d_sv_ord_unit_cd [] 		= form.getParam("d_sv_ord_unit_cd").split("/");
				     String d_sv_ord_qty [] 			= form.getParam("d_sv_ord_qty").split("/");
				     String d_sv_mg_rate [] 			= form.getParam("d_sv_mg_rate").split("/");
				     String d_sv_new_cost_prc [] 		= form.getParam("d_sv_new_cost_prc").split("/");
				     String d_sv_new_cost_amt [] 		= form.getParam("d_sv_new_cost_amt").split("/");
				     String d_sv_new_sale_prc [] 		= form.getParam("d_sv_new_sale_prc").split("/");
				     String d_sv_new_sale_amt [] 		= form.getParam("d_sv_new_sale_amt").split("/");
				     String d_sv_tag_flag [] 			= form.getParam("d_sv_tag_flag").split("/");
				     String d_sv_tag_prt_own_flag []	= form.getParam("d_sv_tag_prt_own_flag").split("/");
				     String d_sv_new_gat_amt [] 		=  form.getParam("d_sv_new_gat_amt").split("/");
				     String d_sv_vat_amt [] 			=  form.getParam("d_sv_vat_amt").split("/");
				     
				     // System.out.println("####################### d_sv_vat_amt : " +form.getParam("d_sv_vat_amt"));
				     // System.out.println("####################### d_sv_vat_amt : " +form.getParam("d_sv_vat_amt"));
				     
				     for(int j = 0; j < d_sv_strcd.length; j++){
				    	 if(!d_sv_rowStatus[j].equals("3")  ){		//디테일 신규
				    		 System.out.println(j +" 번째  신규 저장  rowStatus : " + d_sv_rowStatus[j]); 
						    	if(!d_sv_new_sale_amt[j].equals("0")) {
								 ret += de_insert(form , userid, sv_slip_no, sv_strcd, d_sv_pmksrt_cd[j], d_sv_pummok_cd[j], d_sv_ord_unit_cd[j], d_sv_ord_qty[j], d_sv_mg_rate[j],  d_sv_new_cost_prc[j], 
										 d_sv_new_cost_amt[j], d_sv_new_sale_prc[j], d_sv_new_sale_amt[j],d_sv_tag_flag[j], sv_pb_cd, sv_hrs_cd, sv_slip_flag,d_sv_tag_prt_own_flag[j], d_sv_new_gat_amt[j], d_sv_vat_amt[j]);
						    	}
				    		 }

				     }
				    
				     // 신규/수정 저장시 Detail 저장 후 Detail 데이터로 MASTER UPDATE
				     UpdateMaster(form, sv_strcd, sv_slip_no); 
				}
				
			}
		  
	}catch(Exception e){
		rollback();
		throw e;
	} finally {
		end();
	}
	return ret;
}
                                                                               
public int de_modify(ActionForm form, String userid, String strSlipNo, String strcd, String slip_no, String ord_seqno, String pmksrtcd, String pummokcd, String ord_unit_cd, String ord_qty, String mg_rate, String new_cost_prc,
		String new_cost_amt, String new_sale_prc, String new_sale_amt, String sv_tag_flag, String pumbuncd, String vencd, String slip_flag, String tag_prt_own_flag, String new_gap_amt) throws Exception {
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;	
	int ret = 0;
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
	    
	    
	    connect("pot");
		begin();

		i = 1; 
		sql.put(svc.getQuery("UPD_DETAIL")); 
		sql.setString(i++, pmksrtcd);
		sql.setString(i++, pummokcd);
		sql.setString(i++, ord_unit_cd.replaceAll(",", "")); 
		sql.setString(i++, mg_rate.replaceAll("%", ""));		//마진율
		sql.setString(i++, ord_qty.replaceAll(",", ""));
		sql.setString(i++, new_cost_prc.replaceAll(",", ""));
		sql.setString(i++, new_cost_amt.replaceAll(",", ""));
		sql.setString(i++, new_sale_prc.replaceAll(",", ""));
		sql.setString(i++, new_sale_amt.replaceAll(",", ""));
		sql.setString(i++, "0");					//mi2.getString("NEW_GAP_AMT") 신차익액
		sql.setString(i++, mg_rate.replaceAll("%", ""));      //신차익율
		sql.setString(i++, pumbuncd);
		sql.setString(i++, vencd);
		sql.setString(i++, slip_flag);
		sql.setString(i++, sv_tag_flag);
		sql.setString(i++, tag_prt_own_flag);  			//택발행주체		수정할것		
		sql.setString(i++, userid);							//수정자						
		sql.setString(i++, strcd);
		sql.setString(i++, slip_no);		
		sql.setString(i++, ord_seqno);
		
		ret = executeUpdate(sql);

	}catch(Exception e){
		rollback();
		throw e;
	} finally {
		end();
	}
	
	return ret;
	
	
}

public int de_insert(ActionForm form, String userid, String sv_slip_no, String strcd, String pmksrtcd, String pummokcd, String ord_unit_cd, String ord_qty, String mg_rate, String new_cost_prc,
		String new_cost_amt, String new_sale_prc, String new_sale_amt, String tag_flag, String pumbuncd, String vencd, String slip_flag, String tag_prt_own_flag, String new_gap_amt, String vat_amt) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;	
	int ret = 0;
	String strSlip = "";
	String ord_seqNo = "";
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();

		sql.close();
								
		// 1. 전표상세번호 생성
		sql.put(svc.getQuery("SEL_ORD_SEQ_NO"));
		sql.setString(1, strcd);								//점코드 못받아온다
		sql.setString(2, sv_slip_no);
		Map mapSeqNo = (Map)executeQueryByMap(sql);
		ord_seqNo = mapSeqNo.get("ORD_SEQ_NO").toString();
		sql.close();
		
		i = 1; 
		sql.put(svc.getQuery("INS_DETAIL"));
		
		sql.setString(i++, strcd);							//점코드 못받아온다
		sql.setString(i++, sv_slip_no);						
		sql.setString(i++, ord_seqNo);
		sql.setString(i++, pmksrtcd);
		sql.setString(i++, pummokcd);	  
		sql.setString(i++, "        ");                    /* 단품코드 */   											
		sql.setString(i++, ord_unit_cd.replaceAll(",", ""));
		sql.setString(i++, mg_rate);
		sql.setString(i++, ord_qty.replaceAll(",", ""));	
		sql.setString(i++, mg_rate);							//신차익율은 마진율과 같게
		sql.setString(i++, new_gap_amt);									//mi2.getString("NEW_GAP_AMT") 신차이액
		sql.setString(i++, new_cost_prc.replaceAll(",", ""));
		sql.setString(i++, new_cost_amt.replaceAll(",", ""));
		sql.setString(i++, new_sale_prc.replaceAll(",", ""));
		sql.setString(i++, new_sale_amt.replaceAll(",", ""));
		sql.setString(i++, vat_amt);  		                    		/* 부가세  */
		sql.setString(i++, pumbuncd);							//품번코드		
		sql.setString(i++, vencd);								//협력사코드
		sql.setString(i++, slip_flag);							
		sql.setString(i++, tag_flag);							//택 구분
		sql.setString(i++, tag_prt_own_flag);					//택 발행 주체 수정할것
		sql.setString(i++, userid);
		sql.setString(i++, userid); 	
		
		ret = executeUpdate(sql);
		

		System.out.println("!^!^!^!^!^!^!^!^"+sv_slip_no);
	//	strSlip = int(strSlipNo);
	}catch(Exception e){ 
		throw e; 
	}
	
	return ret;
}


public StringBuffer delete(ActionForm form) throws Exception{
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;	
	int ret = 0;
	String ord_seqNo = "";
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
	    String strcd = String2.nvl(form.getParam("strcd"));
	    String slip_no = String2.nvl(form.getParam("slip_no"));
	    
	    
	    
	    connect("pot");
		begin();
		
		sql.close();
		sql.put(svc.getQuery("DEL_DETAIL_ALL")); 
		
		sql.setString(1, strcd);
		sql.setString(2, slip_no);
		ret = executeUpdate(sql);
		
		sql.close();
		sql.put(svc.getQuery("DEL_DETAIL_LOG")); 
		
		sql.setString(1, strcd);
		sql.setString(2, slip_no);
		ret = executeUpdate(sql);
		
		sql.close();
		sql.put(svc.getQuery("DEL_MASTER")); 
		
		sql.setString(1, strcd);
		sql.setString(2, slip_no);
		ret = executeUpdate(sql);
		
		if( ret > 0 ){				
			sb.append("<?xml version='1.0' encoding='utf-8'?>");
			sb.append("<t>");
			sb.append("<r id='1'>");
			sb.append("<c id='RET'>").append(ret);
			sb.append("</c>");
			sb.append("</r>");
			sb.append("</t>");
		}else {
			rollback();
			sb.append("<?xml version='1.0' encoding='utf-8'?>");
			sb.append("<t>");
			sb.append("<r id='1'>");
			sb.append("<c id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.");
			sb.append("</c>");
			sb.append("</r>");
			sb.append("</t>");
		}
		
	}catch(Exception e){
		rollback();
		throw e;
	} finally {
		end();
	}
	
	return sb;
}


public StringBuffer getVenRoundFlag(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;		
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		sb = new StringBuffer();
		
		String strStrCd = String2.nvl(form.getParam("strcd"));											//점코드
		String strToday = String2.nvl(form.getParam("strToday"));									//협력사코드
		String ven_cd = String2.nvl(form.getParam("ven_cd"));									//협력사코드
		
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_ROUNDFLAG"));
		sql.setString(++i, strStrCd);
		sql.setString(++i, ven_cd);
		
		
		sb = executeQueryByAjax(sql);
		
		
	}catch(Exception e){
		throw e;
	}
	return sb;
}
  
public String chkSlipProdStat(ActionForm form) throws Exception{
	String returnJson = null;
	List list = null;
	SqlWrapper sql = null; 
	Service svc = null;
	int i = 0;
	Util util = new Util();
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		String strcd = String2.nvl(form.getParam("strcd"));		//점코드
		String strSlip_no = String2.nvl(form.getParam("strSlip_no"));	//전표번호
		  
		connect("pot");
		
		// 전표번호를 생성한다.(시퀀스사용)
		sql.put(svc.getQuery("CHK_SLIP_PROC_STAT"));	
		sql.setString(1, strcd);
		sql.setString(2, strSlip_no);
		  
		list = executeQueryByList(sql);
		
		String cols = "SLIP_PROC_STAT";
 
		returnJson = util.listToJsonOBJ(list, cols);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+returnJson);
		
	}catch(Exception e){
		throw e;
	}
	
	return returnJson;
} 


	
}
