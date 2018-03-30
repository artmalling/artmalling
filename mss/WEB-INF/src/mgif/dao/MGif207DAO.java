/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.sql.Types;
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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif207DAO extends AbstractDAO {
	/**
	 * 반품 전표별 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strRfdDtS   = String2.nvl(form.getParam("strRfdDtS"));
		String strRfdDtE   = String2.nvl(form.getParam("strRfdDtE"));
		String strStrConf  = String2.nvl(form.getParam("strStrConf"));
		String strHstrConf = String2.nvl(form.getParam("strHstrConf"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strRfdDtS);
		sql.setString(i++, strRfdDtE);
		sql.setString(i++, strStrConf);
		sql.setString(i++, strHstrConf);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 상품권번호별 금종 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftAmttype(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strGiftno     = String2.nvl(form.getParam("strGiftno"));   
		String strRfdDt   = String2.nvl(form.getParam("strRfdDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strGiftno);   
		sql.setString(i++, strRfdDt);   
		strQuery = svc.getQuery("SEL_AMT_TYPE") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 상품권번호 중복 체크
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strCardNo     = String2.nvl(form.getParam("strCardNo")); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strCardNo); 

		strQuery = svc.getQuery("SEL_GIFT_NO") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	 
	
	/**
	 * 반품 전표별 상세내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strRfdDt     = String2.nvl(form.getParam("strRfdDt"));
		String strRfdSlipNo = String2.nvl(form.getParam("strRfdSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strRfdDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strRfdSlipNo);

		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}

	/**
	* 반품등록전표 저장/수정
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int save(ActionForm form, MultiInput mi, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
        List	list 	 = null;
					
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();	
			String strSilpNosg = null;
			String strSilpNo = String2.nvl(form.getParam("strSilpNo"));	 
			
			if(strSilpNo.equals("")){
				sql.put(svc.getQuery("SEL_REFUND_SEQ"));
	            //화면(JSP)에서 입력된 (조회)파라미터(Paramater) ss
	            list = select2List(sql);
	            List rowList = (List) list.get(0);
	               String strSeq = rowList.get(0).toString(); 
	               sql.close();
	               
	               strSilpNosg = strSeq; 
			} 
			else {
				strSilpNosg = strSilpNo; 
			}
			
			
			while (mi.next()) {				
				int i=0;
				sql.close();						
				
				String strStrCd  = String2.nvl(form.getParam("strStrCd"));
				String strRfdDt  = String2.nvl(form.getParam("strRfdDt"));
				String strHstrCd = String2.nvl(form.getParam("strHstrCd"));
				//String strSilpNo = String2.nvl(form.getParam("strSilpNo"));	
				String strGiftSNo = mi.getString("GIFT_S_NO");
				String strGiftENo = mi.getString("GIFT_E_NO");
				
				if (mi.IS_INSERT()) { 			// 저장
					String strSeqNo = getSeqNo(form, strRfdDt, strStrCd, strSilpNosg);
					int endno = strSeqNo.length();
					endno = endno - 1;
					strSeqNo = strSeqNo.substring(1, endno);	
					 
					sql.put(svc.getQuery("INS_REFUND"));
					sql.setString(++i, strRfdDt);   
					sql.setString(++i, strStrCd);   
					sql.setString(++i, strSilpNosg); 				
					sql.setString(++i, strSeqNo);
					sql.setString(++i, strHstrCd);
					sql.setString(++i, mi.getString("GIFT_TYPE_CD"));
					sql.setString(++i, mi.getString("GIFT_AMT_TYPE"));
					sql.setString(++i, mi.getString("ISSUE_TYPE"));
					sql.setString(++i, mi.getString("GIFT_S_NO"));
					sql.setString(++i, mi.getString("GIFT_E_NO"));
					sql.setString(++i, mi.getString("RFD_QTY"));
					sql.setString(++i, userId);
					sql.setString(++i, userId);	
					res = update(sql);
					
					saveMst(form, strGiftSNo, strGiftENo, strRfdDt, strStrCd, userId);
					
				}else if(mi.IS_DELETE()){ 		// 삭제
					sql.put(svc.getQuery("DEL_REFUNDDETAIL")); 
					sql.setString(++i, strRfdDt);	
					sql.setString(++i, strStrCd);
					sql.setString(++i, strSilpNo);
					sql.setString(++i, mi.getString("RFD_SEQ_NO"));
					res = update(sql); 
					
					delDtl(form, strGiftSNo, strGiftENo, strStrCd, userId);
				}
				//res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				ret += res;	
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
	 * 반품순번
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */	
	public String getSeqNo(ActionForm form, String rfddt, String strcd, String silpno) 
		throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;
		String strSeqNo = "";
		
		connect("pot");
		sql = new SqlWrapper();
		svc = (Service) form.getService();	
		
		sql.put(svc.getQuery("SEL_SEQNO"));
		sql.setString(++i, rfddt);
		sql.setString(++i, strcd);
		sql.setString(++i, silpno);
		
	    list = select2List(sql);
	    List rlist = (List) list.get(0);
	    strSeqNo = list.get(0).toString();

		sql.close();		
		return strSeqNo;		
	}
		
	/**
	* 반품전표 생성시 상품권마스터 상태반영
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int saveMst(ActionForm form, String giftSno, String giftEno, String strRfdDt, String strInStr, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			sql = new SqlWrapper();			
			svc = (Service) form.getService();		
				
			int i=0;
			sql.close();
							
			sql.put(svc.getQuery("INS_MSTSTAT"));
			sql.setString(++i, userId);						
			sql.setString(++i, giftSno);
			sql.setString(++i, giftEno);
			sql.setString(++i, strRfdDt);
			sql.setString(++i, strInStr);
			res = update(sql);

			ret += res;	
		} catch (Exception e) {
			rollback();
			throw e;
		}		
		return ret;		
	}
		
	/**
	* 반품전표 삭제시 상품권마스터 상태반영(디테일용)
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int delDtl(ActionForm form, String giftSno, String giftEno, String strInStr, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot"); 
			sql = new SqlWrapper();			
			svc = (Service) form.getService();		
			
			int i=0;
			sql.close();		
			
			sql.put(svc.getQuery("DEL_MSTSTAT"));
			sql.setString(++i, userId);						
			sql.setString(++i, giftSno);
			sql.setString(++i, giftEno);
			sql.setString(++i, strInStr);
			res = update(sql);
			ret += res;	
		} catch (Exception e) {
			rollback();
			throw e;
		}  	
		return ret;		
	}
		
	/**
	*  반품 전표별 삭제
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int delete(ActionForm form, MultiInput mi, String userId) throws Exception {
		
		int ret = 0;
		int res = 0;
		int i = 1;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			
			String strRfdDt     = String2.nvl(form.getParam("strRfdDt"));
			String strStrCd     = String2.nvl(form.getParam("strStrCd"));
			String strRfdSlipNo = String2.nvl(form.getParam("strRfdSlipNo"));
			String strGiftSNo   = String2.nvl(form.getParam("strGiftSNo"));
			String strGiftENo   = String2.nvl(form.getParam("strGiftENo"));
			
			svc = (Service) form.getService();
			sql.close();
			sql.put(svc.getQuery("DEL_REFUND")); 

			sql.setString(i++, strStrCd);
			sql.setString(i++, strRfdDt);
			sql.setString(i++, strRfdSlipNo);
			res = update(sql);		

			delMst(form, mi, strStrCd, userId);
			
			ret += res;
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	* 반품전표 삭제시 상품권마스터 상태반영
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int delMst(ActionForm form, MultiInput mi, String strInStr, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();			
			svc = (Service) form.getService();		
			
			while (mi.next()) {		
				int i=0;
				sql.close();		
				
				sql.put(svc.getQuery("DEL_MSTSTAT"));
				sql.setString(++i, userId);						
				sql.setString(++i, mi.getString("GIFT_S_NO"));
				sql.setString(++i, mi.getString("GIFT_E_NO"));
				sql.setString(++i, strInStr);
				res = update(sql);
		
			}
			ret += res;	
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}		
		return ret;		
	}
	
	/**
     * 반품확정
     * @param  form
     * @param   
     * @return 
     */
    public int conf(ActionForm form, MultiInput mi, String userId) throws Exception {
    	
    	int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strRfdDt     = String2.nvl(form.getParam("strRfdDt"));
			String strStrCd     = String2.nvl(form.getParam("strStrCd"));
			String strRfdSlipNo = String2.nvl(form.getParam("strRfdSlipNo"));
						
			int i = 1;
			sql.close();
			sql.put(svc.getQuery("COMF_REFUND")); 
			sql.setString(i++, userId);
			sql.setString(i++, strRfdDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strRfdSlipNo);			
			res = update(sql);
			
			confMst(form, mi, strRfdDt, strStrCd, userId);			
			
			ret += res;
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}	
		
    /**
	* 반품확정시 상품권마스터 상태반영
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int confMst(ActionForm form, MultiInput mi, String strRfdDt, String strInStr, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot"); 
			sql = new SqlWrapper();
			svc = (Service) form.getService();		
			
			while (mi.next()) {		
				int i=0;
				sql.close();
				
				sql.put(svc.getQuery("COMF_MSTSTAT")); 				
				sql.setString(++i, strRfdDt);				
				sql.setString(++i, userId);
				sql.setString(++i, mi.getString("GIFT_S_NO"));
				sql.setString(++i, mi.getString("GIFT_E_NO"));		
				sql.setString(++i, strInStr);	
				res = update(sql);
			}
			ret += res;	
		} catch (Exception e) {
			rollback();
			throw e;
		}  
		return ret;		
	}
	
    /**
	 * 상품권상태정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftStat(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strGiftSNo = String2.nvl(form.getParam("strGiftSNo"));
		String strGiftENo = String2.nvl(form.getParam("strGiftENo"));
		String strRfdDt   = String2.nvl(form.getParam("strRfdDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strGiftSNo);
		sql.setString(i++, strGiftENo);
		sql.setString(i++, strRfdDt);
		strQuery = svc.getQuery("SEL_GIFTSTAT") + "\n";		

		sql.put(strQuery);		
		ret = select2List(sql);
		
		return ret;
	}	
	
	 /**
	 * 유효상품권정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftCnt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strGiftSNo = String2.nvl(form.getParam("strGiftSNo"));
		String strGiftENo = String2.nvl(form.getParam("strGiftENo"));
		String strRfdDt   = String2.nvl(form.getParam("strRfdDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strGiftSNo);
		sql.setString(i++, strGiftENo);
		sql.setString(i++, strRfdDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strGiftSNo);
		sql.setString(i++, strGiftENo);
		sql.setString(i++, strRfdDt);
		strQuery = svc.getQuery("SEL_GIFTCARD_CNT") + "\n";		

		sql.put(strQuery);		
		ret = select2List(sql);
		
		return ret;
	}	
	
}
