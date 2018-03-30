package ecmn.dao;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import kr.fujitsu.ffw.control.cfg.svc.Service;

public class ECmn104DAO extends AbstractDAO2{
	/**
	 * <p>리스트 조회</p>
	 * 
	 */
	public StringBuffer getMaster(ActionForm form) throws Exception {
		 
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = "";
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String pumbencd = URLDecoder.decode(String2.nvl(form.getParam("pumben")), "UTF-8");
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			String title = URLDecoder.decode(String2.nvl(form.getParam("title")), "UTF-8");
			String readCnt = String2.nvl(form.getParam("read_cnt"));
			
			if( "".equals(readCnt)){
				readCnt = "100";
			}
			
			connect("pot");
			
			query = svc.getQuery("SEL_BOARD") + "\n";
			
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, pumbencd);
			sql.setString(++i, title);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, readCnt);
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, pumbencd);
			sql.setString(++i, title);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, readCnt);
			
			sql.put(query);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return sb;
	}
	/**
	 * <p>게시글 상세 조회</p>
	 * 
	 */
	public StringBuffer getDtBoard(ActionForm form) throws Exception {
		StringBuffer sb = null;
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String reg_seqNo = String2.nvl(form.getParam("reg_seqNo"));
			String regDt = String2.nvl(form.getParam("regDt"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DTBOARD"));
			sql.setString(++i, strcd);
			sql.setString(++i, reg_seqNo);
			sql.setString(++i, regDt);
			
			sb = executeQueryByAjax(sql);
			list = executeQuery(sql);
			
			if( list.size() > 0 ){
				dtBoardCnt(strcd, reg_seqNo, regDt, form);
			}
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	/**
	 * <p>답변글 상세조회</p>
	 * 
	 */
	public StringBuffer getDtReply(ActionForm form) throws Exception {
		StringBuffer sb = null;
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String reply_seqNo = String2.nvl(form.getParam("replyNo"));
			String reply_Dt = String2.nvl(form.getParam("reply_dt"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DTREPLY"));
			sql.setString(++i, strcd);
			sql.setString(++i, reply_seqNo);
			sql.setString(++i, reply_Dt);
			
			sb = this.executeQueryByAjax(sql);
			list = executeQuery(sql);
			
		    if( list.size() > 0 ){
		    	dtReplyCnt(strcd, reply_seqNo, reply_Dt, form);
		    }
		    
		}catch(Exception e){
			
			throw e;
		} 
		
		return sb;
	}
	
	/**
	 * <p>게시글 조회횟수 1 증가</p>
	 * 
	 */
	public void dtBoardCnt(String strcd, String seqno, String regDt, ActionForm form) throws Exception {
		SqlWrapper sql = null;
		Service svc = null;
		int res = 0;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			begin();
			
			sql.put(svc.getQuery("UPD_BOARD_CNT"));
			sql.setString(++i, strcd);
			sql.setString(++i, seqno);
			sql.setString(++i, regDt);
			
			res = executeUpdate(sql);
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
		
	}
	/**
	 * <p>댓글 조회횟수 1 증가</p>
	 * 
	 */
	public void dtReplyCnt(String strcd, String replyNo, String replyDt, ActionForm form) throws Exception {
		SqlWrapper sql = null;
		Service svc = null;
		int res = 0;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			begin();
			
			sql.put(svc.getQuery("UPD_REPLY_CNT"));
			sql.setString(++i, strcd);
			sql.setString(++i, replyNo);
			sql.setString(++i, replyDt);
			
			res = executeUpdate(sql);
			
		}catch(Exception e){
			rollback();
			throw e;
		} finally {
			end();
		}
	}
	/**
	 * <p>댓글 등록 팝업 게시글 상세보기</p>
	 * 
	 */
	public Map popReply(ActionForm form) throws Exception {
		Map returnMap = new HashMap();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String reqNo = String2.nvl(form.getParam("reqNo"));
			String regDt = String2.nvl(form.getParam("regDt"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DTBOARD"));
			sql.setString(++i, strcd);
			sql.setString(++i, reqNo);
			sql.setString(++i, regDt);
			
			returnMap = executeQueryByMap(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return returnMap;
	}
	
	/**
	 * <p>댓글 등록 팝업 댓글 등록자</p>
	 * 
	 */
	public List regnmList(ActionForm form, String vencd) throws Exception {
		Map returnMap = new HashMap();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		List returnList = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String reqNo = String2.nvl(form.getParam("reqNo"));
			String regDt = String2.nvl(form.getParam("regDt"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_REGNM"));
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, strcd);
			sql.setString(++i, reqNo);
			sql.setString(++i, regDt);
			
			returnList = executeQuery(sql);
		}catch(Exception e){
			throw e;
		}
		
		return returnList;
	}
	
	
	/**
	 * <p>댓글 등록</p>
	 * 
	 */
	public StringBuffer ins_reply(ActionForm form, String userid, String vencd) throws Exception {
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql =  null;
		Service svc = null;
		int i = 0;
		int ret = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));					//점코드
			String reqNo = String2.nvl(form.getParam("reqNo"));					//순번
			String regDt = String2.nvl(form.getParam("regDt"));					//접수일자
			String reply_title = URLDecoder.decode(String2.nvl(form.getParam("reply_title")), "UTF-8");		//댓글 제목
			String reply_content = URLDecoder.decode(String2.nvl(form.getParam("reply")), "UTF-8");			//댓글 내용
			String reply_regcd = String2.nvl(form.getParam("reply_regcd"));									//댓글 등록
			
			connect("pot");
			begin();
			
			sql.put(svc.getQuery("SEL_SEQNO"));		//댓글 시퀀스		
			Map mapReplySeqNo = executeQueryByMap(sql);
			String seqno = mapReplySeqNo.get("SEQNO").toString();
			sql.close();
			
			sql.put(svc.getQuery("INT_REPLE"));
			sql.setString(++i, seqno);
			sql.setString(++i, regDt);
			sql.setString(++i, reqNo);
			sql.setString(++i, reply_title);
			sql.setString(++i, reply_content);
			sql.setString(++i, reply_regcd);
			sql.setString(++i, userid);
			sql.setString(++i, userid);
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			
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
	 * <p>댓글 수정</p>
	 * 
	 */
	public StringBuffer updReply(ActionForm form, String userid) throws Exception {
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		int ret = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String replyNo = String2.nvl(form.getParam("replyNo"));
			String replyDt = String2.nvl(form.getParam("replyDt"));
			String reply_title = URLDecoder.decode(String2.nvl(form.getParam("reply_title")), "UTF-8");
			String reply_content = URLDecoder.decode(String2.nvl(form.getParam("reply_content")), "UTF-8");
			
			connect("pot");
			begin();
			
			sql.put(svc.getQuery("UPD_REPLY"));
			sql.setString(++i, reply_title);
			sql.setString(++i, reply_content);
			sql.setString(++i, userid);
			sql.setString(++i, strcd);
			sql.setString(++i, replyNo);
			sql.setString(++i, replyDt);
			
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
	 * <p>댓글 삭제</p>
	 * 
	 */
	public StringBuffer delReply(ActionForm form) throws Exception {
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		int ret = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strcd = String2.nvl(form.getParam("strcd"));
			String replyNo = String2.nvl(form.getParam("replyNo"));
			String replyDt = String2.nvl(form.getParam("replyDt"));
			
			connect("pot");
			begin();
			
			sql.put(svc.getQuery("DEL_REPLY"));
			
			sql.setString(++i, strcd);
			sql.setString(++i, replyNo);
			sql.setString(++i, replyDt);
			
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
	
}
