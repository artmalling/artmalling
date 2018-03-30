/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
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

public class MCae408DAO extends AbstractDAO {
	
	/**
	 * 행사 마스터 정보 조회
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSdt = String2.nvl(form.getParam("strSdt"));
		String strEdt = String2.nvl(form.getParam("strEdt"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEventCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 행사 디테일 정보 조회
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
		 
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strInfrrDt 	= String2.nvl(form.getParam("strInfrrDt"));
		String strSlipNo	= String2.nvl(form.getParam("strSlipNo")); 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strInfrrDt);
		sql.setString(i++, strSlipNo); 
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
     * <p>사은행사유형 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getEventType(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        ProcedureWrapper proc = new ProcedureWrapper();
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));	// 행사코드

            sql.put(svc.getQuery("SEL_EVENT"));
            sql.setString(++i, strEventCd);                  
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>사은행사 마감체크</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getEventMagam(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        ProcedureWrapper proc = new ProcedureWrapper();
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));	// 행사코드

            sql.put(svc.getQuery("SEL_MAGAM"));
            sql.setString(++i, strEventCd);                  
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>사은품코드,명 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getSkuCd(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        ProcedureWrapper proc = new ProcedureWrapper();
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0; 
            
            String strStrCd			= String2.nvl(form.getParam("strStrCd"));	    // 점
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));	// 행사코드    
            
            sql.put(svc.getQuery("SEL_SKU_CD"));
            sql.setString(++i, strStrCd);     
            sql.setString(++i, strEventCd);                  
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>사은품코드,명 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getSkuAmt(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        ProcedureWrapper proc = new ProcedureWrapper();
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0; 
            
            String strStrCd			= String2.nvl(form.getParam("strStrCd"));	    // 점
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));	// 행사코드    
            String strSkuCD			= String2.nvl(form.getParam("strSkuCD"));	// 사은품코드    
            
            sql.put(svc.getQuery("SEL_SKU_GB"));
            sql.setString(++i, strStrCd);     
            sql.setString(++i, strEventCd);     
            sql.setString(++i, strSkuCD);                
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    

	
	public List chkGiftCardNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_CHECK_GIFTCARD_NO") + "\n";
		
		sql.put(strQuery);
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));	//상품권번호
		sql.setString(++i, strGiftCardNo); 
		ret = select2List(sql);
		return ret;
	}
	
    /**
	* 기타지급관리 저장/수정
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int save(ActionForm form, MultiInput miD, MultiInput mi, String userId) throws Exception {
	
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
        List	list 	 = null;
        
		String strQuery = "";
		int GIFTCARD_CNT = 0;
		
		int gift_cnt = 0;

		String strGIFTCERT_AMT = "";
		String strGIFTCARDNO = "";

		List retno = null;
		List retnoArr = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();	
			String strSilpNosg = null;
			String strSlipNo = String2.nvl(form.getParam("strSlipNo"));	 
			
			if(strSlipNo.equals("")){
				sql.put(svc.getQuery("SEL_EVTSKUINGRR_SEQ"));
	            //화면(JSP)에서 입력된 (조회)파라미터(Paramater) ss
	            list = select2List(sql);
	            List rowList = (List) list.get(0);
	               String strSeq = rowList.get(0).toString(); 
	               sql.close();
	               
	               strSilpNosg = strSeq; 
			} 
			else {
				strSilpNosg = strSlipNo; 
			}
			
			String strStrCd  = String2.nvl(form.getParam("strStrCd"));
			String strEventCd  = String2.nvl(form.getParam("strEventCd"));
			String strInfrrDt = String2.nvl(form.getParam("strInfrrDt")); 
			String strRemark = String2.nvl(form.getParam("strRemark"));
			
			while (miD.next()) {

				gift_cnt = 0;			
				int i=0;

				GIFTCARD_CNT = Integer.parseInt(miD.getString("GIFTCARD_CNT"));
	            System.out.println("GIFTCARD_CNT----------" + GIFTCARD_CNT); 
				
				sql.close();				 
				if (miD.IS_INSERT()) { 			// 저장  
					sql.put(svc.getQuery("INS_EVTSKUINFRR"));
					sql.setString(++i, strInfrrDt);   
					sql.setString(++i, strStrCd);   
					sql.setString(++i, strSilpNosg); 				
					sql.setString(++i, strInfrrDt); 				
					sql.setString(++i, strStrCd); 				
					sql.setString(++i, strSilpNosg);
					sql.setString(++i, strEventCd);
					sql.setString(++i, miD.getString("SKU_CD"));
					sql.setString(++i, miD.getString("BUY_COST_PRC"));
					sql.setString(++i, miD.getString("INFRR_QTY"));  
					sql.setString(++i, strRemark);  
					sql.setString(++i, userId);
					sql.setString(++i, userId);	
					res = update(sql);
					
					System.out.println("SKU_GB----------" + miD.getString("SKU_GB")); 
					
					//사은품종류가 상품권이면
					if (miD.getString("SKU_GB").equals("2")) {
						
						for(int a = 0; a < GIFTCARD_CNT; a++) {		

							retno = null;
							retnoArr = null;
							i = 1;
							sql.close();
							//-- 상품권의 가격정보 가져오기

							strGIFTCARDNO = miD.getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt);
							System.out.println("strGIFTCARDNO----------" + strGIFTCARDNO);
							
							strQuery = svc.getQuery("SEL_GIFTCERT_AMT") + "\n";
							sql.put(strQuery);                                     //상품권금액조회     
							sql.setString(i++, strGIFTCARDNO);
							
							retno = select2List(sql);
							
							retnoArr  = (List)retno.get(0);
							System.out.println("retArr_a----------" + retnoArr); 
							
							strGIFTCERT_AMT = retnoArr.get(0).toString();						
							System.out.println("strGIFTCERT_AMT----------" + strGIFTCERT_AMT); 
							
							i = 1;
							sql.close();
							// 상품권 지급 내역 등록
							sql.put(svc.getQuery("INS_EVTETCSKUGIFTPRSNT"));
							sql.setString(i++, String2.nvl(form.getParam("strInfrrDt")));	    // 지급일
							sql.setString(i++, strStrCd);				                        // 점코드
							sql.setString(i++, strSilpNosg);									// 지급번호
							
							// SEQ_NO INSERT시 MAX값 저장
							sql.setString(i++, String2.nvl(form.getParam("strInfrrDt")));    	// 지급일
							sql.setString(i++, strStrCd);				                        // 점코드
							sql.setString(i++, strSilpNosg);									// 지급번호
							
							//sql.setString(i++, miD.getString("GIFTCARD_NO"));		    	// 상품권번호
							sql.setString(i++, miD.getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));	// 상품권번호
													
							sql.setString(i++, strEventCd);				                    // 행사코드
							sql.setString(i++, miD.getString("SKU_CD"));					// 단품코드
							sql.setString(i++, userId);										// 등록자
							sql.setString(i++, userId);										// 수정자
							//sql.setString(i++, miD.getString("GIFTCERT_AMT"));			// 상품권금액
							sql.setString(i++, strGIFTCERT_AMT);			                // 상품권금액
								
							res = update(sql);						
				
							if (res != 1) {
								throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
										+ "데이터 입력을 하지 못했습니다.");
							}
							
							i=1;
							sql.close();
							sql.put(svc.getQuery("UPD_GIFTMST"));
							sql.setString(i++, strStrCd);				                       	// 판매점
							sql.setString(i++, String2.nvl(form.getParam("strInfrrDt")));		// 판매일
							sql.setString(i++, userId); 								    	// 판매자
							//sql.setString(i++, miD.getString("GIFTCERT_AMT"));				// 금액
							sql.setString(i++, strGIFTCERT_AMT);		                 		// 금액
							sql.setString(i++, userId); 									    // 수정자
							sql.setString(i++, miD.getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));   // 상품권번호
							res = update(sql);

							gift_cnt = gift_cnt + 12;
							
				            System.out.println("res---------- " + res); 
							if (res == 0) {
								throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
										+ "데이터 입력을 하지 못했습니다.");
							}
						}	
											
					}
					
					
				}else if(miD.IS_DELETE()){ 		// 삭제
					sql.put(svc.getQuery("DEL_EVTSKUINFRR_SEQ")); 
					sql.setString(++i, strStrCd);    
					sql.setString(++i, strInfrrDt); 				
					sql.setString(++i, strSilpNosg); 
					sql.setString(++i, miD.getString("SEQ_NO"));
					res = update(sql);  
				}
				else if(miD.IS_UPDATE()){ 
					if(miD.getString("SEQ_NO").equals("")) {
						
						String strEtcSeqNo = getSeqNo(form, strInfrrDt, strStrCd, strSilpNosg);
		 				int endno = strEtcSeqNo.length();
		 				endno = endno - 1;
		 				strEtcSeqNo = strEtcSeqNo.substring(1, endno);	
						
		 				sql.put(svc.getQuery("UPD_EVTSKUINFRR_D")); 

						sql.setString(++i, miD.getString("INFRR_QTY"));  
						sql.setString(++i, strRemark); 
						sql.setString(++i, userId);
	                    sql.setString(++i, strStrCd);    
						sql.setString(++i, strInfrrDt); 				
						sql.setString(++i, strSilpNosg);
						sql.setString(++i, strEtcSeqNo); 
						res = update(sql);
						
						sql.close();
					}
					else {
						sql.put(svc.getQuery("UPD_EVTSKUINFRR_D")); 
						
						sql.setString(++i, miD.getString("INFRR_QTY"));  
						sql.setString(++i, strRemark); 
						sql.setString(++i, userId);
	                    sql.setString(++i, strStrCd);    
						sql.setString(++i, strInfrrDt); 				
						sql.setString(++i, strSilpNosg);
						sql.setString(++i, miD.getString("SEQ_NO"));  
						res = update(sql);
						
						sql.close();
					}      
	             	 
				}
				
				ret += res;	
			}  
			while (mi.next()) {			
				if(mi.IS_UPDATE()){ 
					sql.put(svc.getQuery("UPD_EVTSKUINFRR")); 
	 
					sql.setString(1, strRemark); 
					sql.setString(2, userId);
	                sql.setString(3, strStrCd);    
					sql.setString(4, strInfrrDt); 				
					sql.setString(5, strSilpNosg);   
					res = update(sql);
					
					sql.close();
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
	 * 반품순번
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */	
	public String getSeqNo(ActionForm form, String strInfrrDt, String strStrCd, String strSilpNosg) 
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
		sql.setString(++i, strInfrrDt);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSilpNosg);
		
	    list = select2List(sql);
	    List rlist = (List) list.get(0);
	    strSeqNo = list.get(0).toString();

		sql.close();		
		return strSeqNo;		
	}
}
