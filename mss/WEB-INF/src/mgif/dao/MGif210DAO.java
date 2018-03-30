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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
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

public class MGif210DAO extends AbstractDAO {

	/**
	 * 점내 불출신청 -MASTER
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
		 
		String strStr    = String2.nvl(form.getParam("strStr"));
		String strSrart  = String2.nvl(form.getParam("strSrart"));
		String strEnd    = String2.nvl(form.getParam("strEnd"));
		String strPout   = String2.nvl(form.getParam("strPout"));
		String strConf   = String2.nvl(form.getParam("strConf"));
		String strEvent  = String2.nvl(form.getParam("strEvent"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
 
		sql.setString(i++, strStr);
		sql.setString(i++, strSrart);
		sql.setString(i++, strEnd);
		sql.setString(i++, strPout);
		sql.setString(i++, strConf);
		
		strQuery = svc.getQuery("SEL_POUTREQ") + "\n";
		sql.put(strQuery);
		
		if(!strEvent.equals("")) {
			strQuery = svc.getQuery("SEL_EVENT") + "\n";
			sql.put(strQuery);
			sql.setString(i++, strEvent);
		}
		strQuery = svc.getQuery("SEL_ORDERBY") + "\n";
		sql.put(strQuery);
		ret = select2List(sql); 
		return ret;
		
	}
	
	/**
	 * 점내 불출신청 상세-DETAIL
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
		String strOrgCd     = String2.nvl(form.getParam("strOrgCd"));
		String strPoutReqDt = String2.nvl(form.getParam("strPoutReqDt"));
		String strPoutType  = String2.nvl(form.getParam("strPoutType"));
		String strPoutSlipNo  = String2.nvl(form.getParam("strPoutSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPoutSlipNo);
		sql.setString(i++, strPoutReqDt); 

		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 행사별 조직 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEvtOrg(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strEventCd  = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);

		strQuery = svc.getQuery("SEL_ORG_CD") + "\n";
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * <p>공통코드[금종&상품권종류]</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getEtcCodeSub(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper(); 
			
			String strEtcCode	= String2.nvl(form.getParam("strEtcCode"));	// 공통코드(코드)
		//	System.out.println(strEtcCode);
			if(strEtcCode.equals("1"))
			{
				sql.put(svc.getQuery("SEL_ETCCODE_SELECT"));
				list = select2List(sql);	
			}
			else
			{
				String strGiftType  = String2.nvl(form.getParam("strGiftType"));
			//	System.out.println(strEtcCode);
				sql.put(svc.getQuery("SEL_ETCCODE_SELECT2"));
				list = select2List(sql);
			}            
			
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
	
	/**
	 * DETAIL 상품금액 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftType(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		 
		String strGiftType     = String2.nvl(form.getParam("strGiftType")); 
		String strGiftAmt     = String2.nvl(form.getParam("strGiftAmt")); 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strGiftType);
		sql.setString(i++, strGiftAmt); 

		strQuery = svc.getQuery("SEL_GIFT_AMT") + "\n";
		
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
	public int save(ActionForm form, MultiInput[] mi, String userId) throws Exception {
	
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
			String strPoutSlipsg = null;
			String strPoutSlip = String2.nvl(form.getParam("strPoutSlip"));	 	
			
			String strPoutRsn 	= "";


			// 마스터내용 비고 수정
			while (mi[1].next()) {	
				if(mi[1].IS_UPDATE()){

					strPoutRsn 	= mi[1].getString("POUT_RSN");
					
					sql.put(svc.getQuery("UPD_POUTREQ_M"));
					sql.setString(1, mi[1].getString("POUT_RSN"));                       
					sql.setString(2, userId);   											
					sql.setString(3, mi[1].getString("STR_CD")); 				         
					sql.setString(4, mi[1].getString("POUT_REQ_DT"));                    
					sql.setString(5, mi[1].getString("POUT_REQ_SLIP_NO"));               
					res = update(sql);                                                   
					if (res == 0) {                                                      
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"                
								+ "데이터 입력을 하지 못했습니다.");                                  
					} 
					sql.close();
				}
			}
			
			if(strPoutSlip.equals("")){
				sql.put(svc.getQuery("SEL_POUTREQ_SEQ"));
	            //화면(JSP)에서 입력된 (조회)파라미터(Paramater) ss
	            list = select2List(sql);
	            List rowList = (List) list.get(0);
	               String strSeq = rowList.get(0).toString(); 
	               sql.close();
	               
	               strPoutSlipsg = strSeq; 
			} 
			else {
				strPoutSlipsg = strPoutSlip; 
			}
			
			// 상세내역 
			while (mi[0].next()) {				
				int i=0;
				sql.close();		
				
	        	String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
				String strOrgCd		= String2.nvl(form.getParam("strOrgCd"));
				String strPoutDt 	= String2.nvl(form.getParam("strPoutDt"));
				String strPoutType 	= String2.nvl(form.getParam("strPoutType"));
				String strEventCd 	= String2.nvl(form.getParam("strEventCd"));
				
				
				if (mi[0].IS_INSERT()) { 			// 저장		
					
	             	String strPoutSeqNo = getSeqNo(form, strStrCd, strPoutDt, strPoutSlipsg);
	 				int endno = strPoutSeqNo.length();
	 				endno = endno - 1;
	 				strPoutSeqNo = strPoutSeqNo.substring(1, endno);	
	 				
					sql.put(svc.getQuery("INS_POUTREQ")); 
					sql.setString(++i, strStrCd);   
					sql.setString(++i, strOrgCd);   
					sql.setString(++i, strPoutDt); 				
					sql.setString(++i, strPoutSlipsg);
					sql.setString(++i, strPoutSeqNo);
					sql.setString(++i, strPoutType);
					sql.setString(++i, strEventCd);
					sql.setString(++i, strPoutRsn); 
					sql.setString(++i, mi[0].getString("GIFT_TYPE_CD")); 
					sql.setString(++i, mi[0].getString("GIFT_AMT_TYPE"));
					sql.setString(++i, mi[0].getString("REQ_QTY")); 
					sql.setString(++i, mi[0].getString("REQ_AMT")); 
					sql.setString(++i, userId);
					sql.setString(++i, userId);	
					res = update(sql);

					sql.close();
			//		saveMst(form, strGiftSNo, strGiftENo, userId);
					
				}else if(mi[0].IS_DELETE()){ 		// 삭제
					
					sql.put(svc.getQuery("DEL_POUTREQ_SEQ")); 
					sql.setString(++i, strStrCd);	 
					sql.setString(++i, strPoutDt); 
					sql.setString(++i, strPoutSlipsg); 
					sql.setString(++i, mi[0].getString("POUT_REQ_SEQ_NO")); 

					res = update(sql);
					sql.close();
					
				//	delDtl(form, strGiftSNo, strGiftENo, userId);
				}
				else if(mi[0].IS_UPDATE()){
					
					if(mi[0].getString("POUT_REQ_SEQ_NO").equals("")) {
						
						String strPoutSeqNo = getSeqNo(form, strStrCd, strPoutDt, strPoutSlipsg);
		 				int endno = strPoutSeqNo.length();
		 				endno = endno - 1;
		 				strPoutSeqNo = strPoutSeqNo.substring(1, endno);	
		 				
		 				sql.put(svc.getQuery("UPD_POUTREQ")); 
						
						sql.setString(++i, strPoutRsn); 
						sql.setString(++i, mi[0].getString("REQ_QTY"));  
						sql.setString(++i, mi[0].getString("REQ_AMT")); 
						sql.setString(++i, userId);
	                    sql.setString(++i, strStrCd);    
						sql.setString(++i, strPoutDt); 				
						sql.setString(++i, strPoutSlipsg);
						sql.setString(++i, strPoutSeqNo); 
						res = update(sql);
						
						sql.close();
					}
					else {
						
						sql.put(svc.getQuery("UPD_POUTREQ")); 
						
						sql.setString(++i, strPoutRsn); 
						sql.setString(++i, mi[0].getString("REQ_QTY"));  
						sql.setString(++i, mi[0].getString("REQ_AMT")); 
						sql.setString(++i, userId);
	                    sql.setString(++i, strStrCd);    
						sql.setString(++i, strPoutDt); 				
						sql.setString(++i, strPoutSlipsg);
						sql.setString(++i, mi[0].getString("POUT_REQ_SEQ_NO")); 
						res = update(sql);
						
						sql.close();
					}      
	             	 
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
			
			String strStrCd  	= String2.nvl(form.getParam("strStrCd")); 
			String strPoutDt 	= String2.nvl(form.getParam("strPoutDt"));
			String strSlipno  	= String2.nvl(form.getParam("strSlipno")); 
			
			svc = (Service) form.getService();
			sql.close();
			sql.put(svc.getQuery("DEL_POUTREQ_SLIP")); 

			sql.setString(i++, strStrCd); 
			sql.setString(i++, strPoutDt);
			sql.setString(i++, strSlipno); 
			
			res = update(sql);		

			//delMst(form, mi, userId);
			
			ret += res;
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}

}
