package ecmn.dao;

import java.util.List;
import java.util.Map;

import ecom.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class ECmn103DAO extends AbstractDAO2 {
	
	/**
	 * <p>법률자문 마스터 조회</p>
	 * 
	 */
	public String getMaster(ActionForm form ) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		String returnJson = null;
		List list = null;
		int i = 0;
		String query = "";
		String cols = null;
		Util util = new Util();
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strCd = String2.nvl(form.getParam("strcd"));					//점코드
			String venCd = String2.nvl(form.getParam("vencd"));					//협력사코드
			String Pumbuncd = String2.nvl(form.getParam("pumbencd"));			//품번코드
			String sDate = String2.nvl(form.getParam("sDate"));					//시작일
			String eDate = String2.nvl(form.getParam("eDate"));					//종료일
			String title = String2.nvl(form.getParam("title"));					//제목
			String readCnt = String2.nvl(form.getParam("readCnt"));				//조회건수
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_MASTER"));
			
			if( !"".equals(readCnt) ){
				sql.put(svc.getQuery("SEL_ROWNUM"));
			}
			
			sql.setString(++i, strCd); 
			sql.setString(++i, venCd);
			sql.setString(++i, Pumbuncd);
			sql.setString(++i, title);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
		
			if( !"".equals(readCnt) ){
				sql.setString(++i, readCnt);
			}
		
			list = executeQueryByList(sql);
		
			cols = "STR_CD,STR_NM,PUMBUNCD,PUMBUN_NM,VEN_CD,SEQ_NO,REG_DT,TITLE,BUYER_CD,BUYERNAME,TIME";
			
			returnJson = util.listToJsonOBJ(list, cols);
			
		}catch(Exception e){
			throw e;
		}
		
		return returnJson;
	}
	
	/**
	 * <p>법률자문 등록</p>
	 * 
	 */
	public StringBuffer insert(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int ret = 0;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String userid = String2.nvl(form.getParam("userid"));
			String title = String2.nvl(form.getParam("title"));
			String content = String2.nvl(form.getParam("content"));
			String pumbuncd = String2.nvl(form.getParam("pumbuncd"));
			
			connect("pot");
			begin();
			
			sql.put(svc.getQuery("INS_ET_LAWQNA"));
			sql.setString(++i, strcd);
			sql.setString(++i, title);
			sql.setString(++i, content);
			sql.setString(++i, vencd);
			sql.setString(++i, pumbuncd);
			sql.setString(++i, userid);
			sql.setString(++i, userid);
			
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
	
	/**
	 * <p>법률 자문 상세 조회  </p>
	 * 
	 */
	
	public StringBuffer getDetail(ActionForm form) throws Exception {
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();			
			
			connect("pot");
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String regDt = String2.nvl(form.getParam("regDt"));
			String seqno = String2.nvl(form.getParam("seqno"));
			
			if( strcd.length() == 1  ){
				strcd = "0" + strcd;
			}
			
			sql.put(svc.getQuery("SEL_DETAIL"));
			
			sql.setString(++i, strcd);
			sql.setString(++i, seqno);
			sql.setString(++i, regDt);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	/**
	 * <p>법률자문  수정 </p>
	 * 
	 */
	public StringBuffer save(ActionForm form) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		StringBuffer sb = null;
		int i = 0;
		int ret = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String strReg_dt = String2.nvl(form.getParam("regDt"));
			String strSeqno = String2.nvl(form.getParam("seq_no"));
			String strTitle = String2.nvl(form.getParam("title"));
			String StrContent = String2.nvl(form.getParam("content"));
			String StrUserid = String2.nvl(form.getParam("userid"));
			
			connect("pot");
			begin();
			
			sql.put(svc.getQuery("UPD_LAWQNA"));
			
			sql.setString(++i, strTitle);
			sql.setString(++i, StrContent);
			sql.setString(++i, StrUserid);
			sql.setString(++i, strcd);
			sql.setString(++i, strSeqno);
			sql.setString(++i, strReg_dt);
			
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
		}finally {
			end();
		}
		return sb;
	}
	
	/**
	 * <p>팝업 리스트 삭제 </p>
	 * 
	 */
	public StringBuffer delete(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int ret = 0;
		int i = 0;
		
		try{
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String strRegdt = String2.nvl(form.getParam("regDt"));
			String strSeqno = String2.nvl(form.getParam("seq_no"));
			
			connect("pot");
			begin();
			
			sql.put(svc.getQuery("DEL_LAWQNA"));
			sql.setString(++i,strcd);
			sql.setString(++i,strSeqno);
			sql.setString(++i,strRegdt);
			
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
		}finally {
			end();
		}
		
		return sb;
	}
	
	
	
}
