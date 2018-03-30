package medi.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/16
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */


public class MEdi101DAO extends AbstractDAO {

	/**
	 * <p> 협력사 EDI 비밀번호 관리 </p>
	 *  db 연결 조회
	 */
	
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;
		
		String strcd = String2.nvl(form.getParam("strcd"));
		String strGubun = String2.nvl(form.getParam("strGubun"));
		String gubunCode = String2.nvl(form.getParam("gubunCode"));
		
		if( gubunCode.equals(null) || gubunCode.equals("") ){
			gubunCode = "%";
		}
		
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		connect("pot");
		
		sql.setString(++i, gubunCode);	//사용자
		sql.setString(++i, strGubun);	//조회구분
		sql.setString(++i, strcd);		
		
		strQuery = svc.getQuery("SEL_VEN") + "\n";
				
		sql.put(strQuery);
		
		ret = select2List(sql);
		System.out.println("ret size :"+ ret.size());
		
		return ret;
	}
	/**
	 * <p> 협력사 EDI 비밀번호 관리 </p>
	 *  조회
	 */
	public int save(ActionForm form, MultiInput mi,String userid)throws Exception{
		
		SqlWrapper sql = null;
		Service svc = null;
		int ret = 0;
		Util        util = new Util();
		
		try{
			
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String remark = URLDecoder.decode(String2.nvl(form.getParam("Remark")), "UTF-8");
			
			while( mi.next() ){
				
				if( mi.IS_UPDATE() ){
										
					sql.put(svc.getQuery("UPT_EDIUSER"));
					
					sql.setString(1, mi.getString("PWD_NO").toString());					
					sql.setString(2, userid);
					sql.setString(3, String2.nvl(form.getParam("strCd")));
					sql.setString(4, String2.nvl(form.getParam("strUserId")));
					sql.setString(5, mi.getString("GB"));
					
					ret += update(sql);					
					sql.close();
					
					sql.put(svc.getQuery("SEL_HIT_SEQ"));
					Map mapSeqno = (Map)selectMap(sql);
					String seq = mapSeqno.get("SEQ").toString();
					mi.setString("SEQ", seq);
					sql.close();
					
					sql.put(svc.getQuery("INT_HIT"));
					
					sql.setString(1, mi.getString("STR_CD"));
					sql.setString(2, mi.getString("USER_ID"));
					sql.setString(3, mi.getString("GB"));
					sql.setString(4, mi.getString("SEQ"));
					sql.setString(5, mi.getString("NOTICE_FLAG"));
					sql.setString(6, userid);
					sql.setString(7, userid);
					sql.setString(8, remark);
					
					update(sql);
					sql.close();
					
					/*
			        ProcedureWrapper psql = null; 
			        ProcedureResultSet prs = null; 
	                psql = new ProcedureWrapper();
					psql.put("MSS.PR_MPSMSCREATE", 6);
					
					// SMS발송처리
					if (mi.getString("NOTICE_FLAG").equals("01")) { // 01:SMS,02:유선통보,03:기타방식
						String sendMessage = "협력사EDI 비밀번호가  " + mi.getString("PWD_NO") + " 로 변경되었습니다. -" + mi.getString("STRNM")+"-";
						psql.setString(1, sendMessage);
						psql.setString(2, mi.getString("HPONE")); 
						psql.setString(3, mi.getString("HPONE")); 
						psql.setString(4, ""); //실시간 전종
						psql.registerOutParameter(5, DataTypes.VARCHAR);
						psql.registerOutParameter(6, DataTypes.VARCHAR);
						prs = updateProcedure(psql);
						
						String rtCd = prs.getString(5);
						String rtMsg = prs.getString(6);
						
						//SMS시스템에 정상등록이 아닐경우 ERR메시지 처리
						if (!rtCd.equals("0")) {
							throw new Exception("[USER]" + rtMsg );
						}
					}*/
					
				}
				
				if (ret < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
			}
			
		}catch(Exception e){
			rollback();
			throw e;
		}finally{
			end();
		}
			
		return ret;
	}
	
}
