/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMultipart;

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
 * <p>발행의뢰(인쇄업체)</p>
 * 
 * @created  on 1.0, 2011/04/13
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif112DAO extends AbstractDAO {

	 /**
	 * 발행의뢰 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getReqMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));	//점코드
		String strYmdFrom = String2.nvl(form.getParam("strYmdFrom"));   //일자 from
		String strYmdTo = String2.nvl(form.getParam("strYmdTo"));		//일자to
		String strCodeFlag = String2.nvl(form.getParam("strCodeFlag"));		//코드생성구분
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MG_GIFTISSUEREQ_MST") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYmdFrom);
		sql.setString(i++, strYmdTo);
		sql.setString(i++, strCodeFlag);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 발행의뢰 디테일 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getReqDtl(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strReqDt = String2.nvl(form.getParam("strReqDt"));	//발행신청일자
		String strStrCd = String2.nvl(form.getParam("strStrCd"));   //점코드
		String strReqSlipNo = String2.nvl(form.getParam("strReqSlipNo"));		//발행순번
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MG_GIFTISSUEREQ_DTL") + "\n";
		
		sql.setString(i++, strReqDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strReqSlipNo);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 미생성 발행신청 내역 삭제
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delIssueReq(ActionForm form, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			i=1;
			sql.close();
			sql.put(svc.getQuery("DEL_DETAIL"));
			sql.setString(i++, form.getParam("strReqDt"));					// 신청일자
			sql.setString(i++, form.getParam("strStrCd"));					// 신청점
			sql.setString(i++, form.getParam("strReqSlipNo"));				// 신청번호
			res = update(sql);
			if (res == 0) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 * 발행의뢰 저장
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		ProcedureWrapper psql = null;
		Service svc = null;
		ProcedureResultSet prs = null;
		try {
			connect("pot");
			begin();
			psql = new ProcedureWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				psql.put("MSS.PR_MGGIFTREQ", 8);  
	            psql.setString(1, mi.getString("STAT_FLAG"));       //상태구분(01:신청, 02:발행의뢰 , 03:입고, 09: 취소)
	            if(mi.IS_DELETE()){
	            	psql.setString(2, "T");    	//삭제 구분 여부
	            }else{
		            psql.setString(2, "F");    	//삭제 구분 여부
	            }
	            psql.setString(3, mi.getString("REQ_DT")); 			//신청일자
	            psql.setString(4, mi.getString("STR_CD"));       	//신청점 
	            psql.setString(5, mi.getString("REQ_SLIP_NO"));     //신청번호
	            psql.setString(6, mi.getString("REQ_SEQ_NO"));      //신청순번
	            psql.setString(7, userId);     						//등록자

	            psql.registerOutParameter(8, DataTypes.VARCHAR);	//8 ERROR_CODE
	            prs = updateProcedure(psql);

	            if (!prs.getString(8).equals("0")) {
	            	 throw new Exception("[USER]" + "발행의뢰 등록중 오류가 발생했습니다.");
	            }
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 * 발행의뢰 (인쇄업체) 내용 엑셀 저장
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "null", "unchecked" })
	public List getExcel(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		mi.next();
		strQuery =  " SELECT A.GIFT_AMT_TYPE" + "\n";
		strQuery += "      , B.GIFT_AMT_NAME" + "\n";
		strQuery += "      , A.GIFTCARD_NO" + "\n";
		strQuery += "      , A.GIFTCERT_AMT" + "\n";
		strQuery += "   FROM MSS.MG_GIFTREQ A" + "\n";
		strQuery += "      , MSS.MG_GIFTAMTMST B" + "\n";
		strQuery += "  WHERE A.GIFT_TYPE_CD = B.GIFT_TYPE_CD" + "\n";
		strQuery += "    AND A.ISSUE_TYPE = B.ISSUE_TYPE" + "\n";
		strQuery += "    AND A.GIFT_AMT_TYPE = B.GIFT_AMT_TYPE" + "\n";
		strQuery += "    AND REQ_STR = '" + mi.getString("STR_CD") + "' \n";
		strQuery += "    AND REQ_DT = '" + mi.getString("REQ_DT") + "' \n";
		strQuery += "    AND REQ_SLIP_NO = '" + mi.getString("REQ_SLIP_NO") + "' \n";
		strQuery += "ORDER BY A.GIFT_AMT_TYPE, A.GIFTCARD_NO ";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	public static String jLpad(String var, int len){
	    if (null == var) var = "";
	    int aaa = len - var.length();
	    if(aaa >= 0) {
	        for(int c=0; c < aaa; c++){
	            var = "0"+var;
	        }
	    }else{
	        var = var.substring(0, len);
	    }
	    return var;
	}
}
