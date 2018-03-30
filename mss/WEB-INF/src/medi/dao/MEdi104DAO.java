package medi.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/25
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MEdi104DAO extends AbstractDAO  {
	/*
	 * 바이어코드 조회
	 */
	public List getBuyerCd(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		String query = "";
		
		String userid = String2.nvl(form.getParam("userid"));			//사원번호
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");
		
		sql.setString(++i, userid);
		
		query = svc.getQuery("SEL_BUYERCD");
		
		
		sql.put(query);
		
		list = select2List(sql);
		
		return list;
	}
	
	/*
	 * 바이어코드 콤보 조회
	 */
	public List comboBuber(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		String query = "";
		
		String userid = String2.nvl(form.getParam("userid"));			//사원번호
		String org_flag = String2.nvl(form.getParam("org_flag"));			//사원번호
		String strcd = String2.nvl(form.getParam("strcd"));			//사원번호
		
		
		
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");
		
		
		sql.setString(++i, userid);
		sql.setString(++i, org_flag);
		sql.setString(++i, userid);
		sql.setString(++i, strcd);
		
		query = svc.getQuery("SEL_COMBOBUYER");
		
		
		sql.put(query);
		
		list = select2List(sql);
		
		//System.out.println("list size4 : " + list.size());
		return list;
	}
	
	
	/*
	 * 브랜드코드, 브랜드명 조회
	 */
	public List getPumben(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		String query = "";
		
		String Buyercd = String2.nvl(form.getParam("Buyercd"));			//사원번호
		String strcd = String2.nvl(form.getParam("strcd"));			   //점코드
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");
		
		sql.setString(++i, Buyercd);
		sql.setString(++i, strcd);
		
		query = svc.getQuery("SEL_PUMBENNAME");
		
		
		sql.put(query);
		
		list = select2List(sql);
		
		return list;
	}
	
	/*
	 * 게시판 브랜드 권한
	 * 	 
	 * */
	
	public List getboardauth(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		String query = "";
		
		String regDt = String2.nvl(form.getParam("regDt"));			//일자
		String Seqno = String2.nvl(form.getParam("Seqno"));			//순번
		String buyercd = String2.nvl(form.getParam("buyercd"));			//순번
		String strcd = String2.nvl(form.getParam("strcd"));			//순번
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");
		
		sql.setString(++i, strcd);
		sql.setString(++i, Seqno);
		sql.setString(++i, regDt);
		sql.setString(++i, buyercd);
		
		query = svc.getQuery("SEL_AUTH");
		
		sql.put(query);
		
		list = select2List(sql);
		//System.out.println("list sizse : " + list.size());
		return list;
	}
	
	/*
	 * 게시판 조회
	 * 	 
	 * */
	public List getMaster(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i =0;
		String query = "";
		
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		String strCd = String2.nvl(form.getParam("strCd"));			//점
		String sDate = String2.nvl(form.getParam("sDate"));			//시작기간일
		String eDate = String2.nvl(form.getParam("eDate"));			//종료기간일
		String readCnt = String2.nvl(form.getParam("readCnt"));			//조회건수
		String strTitle = URLDecoder.decode(String2.nvl(form.getParam("strTitle")), "UTF-8");			//제목
		String buyer = String2.nvl(form.getParam("buyer"));			//바이어코드
		String userid = String2.nvl(form.getParam("userid"));			//사용자 사번
		
		connect("pot");
		
		
		sql.setString(++i, strCd);
		sql.setString(++i, sDate);
		sql.setString(++i, eDate);
		sql.setString(++i, strTitle);
		sql.setString(++i, readCnt);
		sql.setString(++i, strCd);
		sql.setString(++i, sDate);
		sql.setString(++i, eDate);
		sql.setString(++i, strTitle);
		sql.setString(++i, readCnt);
		sql.setString(++i, userid);
		
		query = svc.getQuery("SEL_MASTER");
		
		sql.put(query);
		
		list = select2List(sql);
		
		
		return list;
	}
	
	
/*
 * 답변글  수정, 등록
 * 	 
 * */

public int saveReply(ActionForm form, MultiInput mi, String userid) throws Exception {
	
	SqlWrapper sql = null;
	Service svc = null;
	int ret = 0;
	int i = 0;
	
	try{
		connect("pot");
		begin();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		String regDt 		= String2.nvl(form.getParam("regdt"));  	//등록일자
		String replySeqno   = String2.nvl(form.getParam("seqNo"));		//순번
		String buyercd      = String2.nvl(form.getParam("buyercd"));	//바이어코드
		
		while( mi.next() ){
			
			if( mi.IS_INSERT() ){				//답변 신규
				
				sql.put(svc.getQuery("SEL_SEQNO"));				
				Map mapReplySeqNo = (Map)selectMap(sql);
				String seqno = mapReplySeqNo.get("SEQNO").toString();
				mi.setString("Reple_SEQNO",seqno.toString());
				sql.close();
				
				sql.put(svc.getQuery("INT_REPLE"));
				sql.setString(++i, mi.getString("Reple_SEQNO"));
				sql.setString(++i, regDt);
				sql.setString(++i, replySeqno);
				sql.setString(++i, mi.getString("TITLE01"));
				sql.setString(++i, mi.getString("CONTNES"));
				sql.setString(++i, buyercd);
				sql.setString(++i, userid);
				sql.setString(++i, userid);
				sql.setString(++i, mi.getString("STR_CD"));
				
				ret += update(sql);
				sql.close();
				
			}else if( mi.IS_UPDATE() ){			//답변 수정
				
				sql.put(svc.getQuery("UPD_REPLY"));
				sql.setString(++i, mi.getString("TITLE01"));
				sql.setString(++i, mi.getString("CONTNES"));
				sql.setString(++i, userid);
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("REPL_DT"));
				sql.setString(++i, mi.getString("REPL_SEQ_NO"));
				
				ret += update(sql);
				sql.close();
			}
			
			if (ret < 1) {
				throw new Exception("" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
		}
		
	}catch(Exception e){
		rollback();
		throw e;
	} finally{
		end();
	}
	
	
	return ret;
}


/*
 * 게시판  수정, 등록
 * 	 
 * */

public int saveVBoard(ActionForm form, MultiInput mi, MultiInput mi2, String userid) throws Exception {
	
	SqlWrapper sql = null;
	Service svc = null;
	Map mapSlipNo = null;
	String seqno = "";
	int ret = 0;
	int i = 0;
	
	try{
		connect("pot");
		begin();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		String strcd 		= String2.nvl(form.getParam("strcd"));  	//점
		String regdt   		= String2.nvl(form.getParam("regdt"));		//등록 일자
		String regSeqno     = String2.nvl(form.getParam("regSeqno"));	//시퀀스
		String buyercd     = String2.nvl(form.getParam("buyercd"));		//바이어코드
		
		while( mi.next() ){
			
			if( mi.IS_INSERT() ){				//게시판 신규 등록
				
				sql.put(svc.getQuery("SEL_AUTH_SEQ_NO"));        
				mapSlipNo = (Map)selectMap(sql);
				seqno = mapSlipNo.get("SEQ_NO").toString();		
				sql.close();
				
				sql.put(svc.getQuery("INT_BOARD"));
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, seqno);
				sql.setString(++i, mi.getString("TITLE01"));
				sql.setString(++i, mi.getString("CONTNES"));
				sql.setString(++i, buyercd);
				sql.setString(++i, mi.getString("AUTH_FLAG"));
				sql.setString(++i, userid);
				sql.setString(++i, userid);
				
				ret += update(sql);
				sql.close();
				
			}else if( mi.IS_UPDATE() ){			//게시판  수정
				
				sql.put(svc.getQuery("UPD_BOARD"));
				sql.setString(++i, mi.getString("TITLE01"));
				sql.setString(++i, mi.getString("CONTNES"));
				sql.setString(++i, mi.getString("AUTH_FLAG"));
				sql.setString(++i, userid);
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("REG_DT"));
				sql.setString(++i, mi.getString("REG_SEQ_NO"));
				
				ret += update(sql);
				sql.close();
			}
			
		}
		
		while( mi2.next() ){
			
			i = 0;
			sql.close();
			if( "T".equals(mi2.getString("PUMBUN_YN").toString()) ){		//업데이트
				 
				 String auth_regdt = String2.nvl(form.getParam("auth_regdt"));
		         String auth_seq = String2.nvl(form.getParam("auth_seqno"));
		         String auth_buyercd = String2.nvl(form.getParam("auth_buyercd"));
		         String auth_strcd = String2.nvl(form.getParam("auth_strcd"));
		         
		         sql.close();
		         
		        if( !"".equals(auth_seq) ){		//수정일때
		        	
			        sql.put(svc.getQuery("INT_AUTHUP"));
			        sql.setString(++i, auth_strcd);
			        sql.setString(++i, auth_regdt);
			        sql.setString(++i, auth_seq);
			        sql.setString(++i, mi2.getString("PUMBUN_CD"));
			        
			        ret += update(sql);
			        sql.close();
		        }else {				//신규일때		
		        	
			        sql.put(svc.getQuery("INT_AUTH"));
			        sql.setString(++i, auth_strcd);
			        sql.setString(++i, seqno);
			        sql.setString(++i, mi2.getString("PUMBUN_CD"));
			        
			        ret += update(sql);
			        sql.close();
		        }
				 
			}else {														//삭제
				
				sql.close();
				
				sql.put(svc.getQuery("DET_AUTH")); //삭제
				sql.setString(1, mi2.getString("REG_DT"));			
				sql.setString(2, mi2.getString("REG_SEQ_NO"));
				sql.setString(3, mi2.getString("PUMBUN_CD"));
				sql.setString(4, mi2.getString("STR_CD"));
				
				ret += update(sql);	
				
			}
		}
		
		if (ret < 1) {
			throw new Exception("" + "데이터의 적합성 문제로 인하여"
					+ "데이터 입력을 하지 못했습니다.");
		}
		
	}catch(Exception e){
		rollback();
		throw e;
	} finally{
		end();
	}
	return ret;
}


/*
 * 권한 삭제
 * 	 
 * */

public int setBoardAuthDelete(ActionForm form, MultiInput mi, String userid) throws Exception {		//권한 삭제
	SqlWrapper sql = null;
	Service svc = null;
	int ret = 0;
	int i = 0;
	
	try{
		connect("pot");
		begin();
		
		sql = new SqlWrapper();
        svc = (Service) form.getService();
        
		sql.close();
		
		sql.put(svc.getQuery("DET_AUTH")); //삭제
		sql.setString(1, mi.getString("REG_DT"));			
		sql.setString(2, mi.getString("REG_SEQ_NO"));
		sql.setString(3, mi.getString("PUMBUN_CD"));
		sql.setString(4, mi.getString("STR_CD"));
					
		ret += update(sql);	        
        
        
	}catch(Exception e){
		rollback();
        throw e;
	}
	return ret;
}

/*
 * 권한 부여
 * 	 
 * */

public int setBoardAuth(ActionForm form, MultiInput mi, String userid) throws Exception {		//권한 부여
	SqlWrapper sql = null;
	Service svc = null;
	int ret = 0;
	int i = 0;
	
	try{
		connect("pot");
		begin();
		
		sql = new SqlWrapper();
        svc = (Service) form.getService();        
        
        String auth_regdt = String2.nvl(form.getParam("auth_regdt"));
        String auth_seq = String2.nvl(form.getParam("auth_seqno"));
        String auth_buyercd = String2.nvl(form.getParam("auth_buyercd"));
        String auth_strcd = String2.nvl(form.getParam("auth_strcd"));
        
        sql.put(svc.getQuery("SEL_AUTH_SEQ_NO"));        
		Map mapSlipNo = (Map)selectMap(sql);
		String seqno = mapSlipNo.get("SEQ_NO").toString();		
		sql.close();
		
        if( !"".equals(auth_seq) ){		//수정일때
        
	        sql.put(svc.getQuery("INT_AUTHUP"));
	        sql.setString(++i, auth_strcd);
	        sql.setString(++i, auth_regdt);
	        sql.setString(++i, auth_seq);
	        sql.setString(++i, mi.getString("PUMBUN_CD"));
	        
	        ret += update(sql);
	        sql.close();
        }else {				//신규일때		
        
	        sql.put(svc.getQuery("INT_AUTH"));
	        sql.setString(++i, auth_strcd);
	        sql.setString(++i, seqno);
	        sql.setString(++i, mi.getString("PUMBUN_CD"));
	        
	        ret += update(sql);
	        sql.close();
        }
        
        if (ret < 1) {
			throw new Exception("" + "데이터의 적합성 문제로 인하여"
					+ "데이터 입력을 하지 못했습니다.");
		}
        
	}catch(Exception e){
		rollback();
        throw e;
	}
	return ret;
}

}
