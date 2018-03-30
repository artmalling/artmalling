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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>판매반품등록</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif303DAO extends AbstractDAO {
	
	private List list;


	/**
	 * Master 조회
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
		
		String strPosSale    = String2.nvl(form.getParam("strPosSale"));
		String strSaleSlip  = String2.nvl(form.getParam("strSaleSlip")); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
 
		//sql.setString(i++, strPosSale);
		//sql.setString(i++, strSaleSlip); 
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		
		if(!strPosSale.equals("")) {
			strQuery += svc.getQuery("SEL_M_POSSALE") + "\n";
			sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
			sql.setString(i++, strPosSale);
			sql.setString(i++, strPosSale);
			sql.setString(i++, strPosSale);
		}
		
		if(!strSaleSlip.equals("")) {
			strQuery += svc.getQuery("SEL_M_SALESLIP") + "\n";
			sql.setString(i++, strSaleSlip);
			sql.setString(i++, strSaleSlip);
			sql.setString(i++, strSaleSlip); 
		}
		strQuery += svc.getQuery("SEL_ORDERBY") + "\n";
		sql.put(strQuery);
		ret = select2List(sql); 
		return ret;
		
	}
	
	/**
	 * POS 영수증번호, 원거래 상품권 매출번호로 상품권 매출번호 & 매출일자 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSaleSlip(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1; 
		
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strPosSale    = String2.nvl(form.getParam("strPosSale"));
		String strSaleSlip  = String2.nvl(form.getParam("strSaleSlip")); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
 
		//sql.setString(i++, strPosSale);
		//sql.setString(i++, strSaleSlip); 
		
		strQuery = svc.getQuery("SEL_SALEMST") + "\n";
		sql.put(strQuery);
		
		if(!strPosSale.equals("")) {
			strQuery = svc.getQuery("SEL_POSSALE") + "\n";
			sql.put(strQuery);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPosSale);
			sql.setString(i++, strPosSale);
			sql.setString(i++, strPosSale);
		}
		
		if(!strSaleSlip.equals("")) {
			strQuery = svc.getQuery("SEL_SALESLIP") + "\n";
			sql.put(strQuery);
			sql.setString(i++, strSaleSlip);
			sql.setString(i++, strSaleSlip);
			sql.setString(i++, strSaleSlip); 
		}
	//	strQuery = svc.getQuery("SEL_ORDERBY") + "\n";
	//	sql.put(strQuery);
		ret = select2List(sql); 
		return ret;
		
	}
	
	/**
	 * 상품권 번호로 반품영수증 조회 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftCardNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;  
		
		String strGiftCardNo    = String2.nvl(form.getParam("strGiftCardNo"));
		String strSlipNo 	 	= String2.nvl(form.getParam("strSlipNo")); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
 
		sql.setString(i++, strGiftCardNo);
		sql.setString(i++, strSlipNo); 
		sql.setString(i++, strSlipNo); 
		sql.setString(i++, strSlipNo); 
		
		strQuery = svc.getQuery("SEL_SELECT") + "\n";
		sql.put(strQuery);
 
		ret = select2List(sql); 
		return ret;
		
	}
	
	/**
	* 상품권 반품
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public String save(ActionForm form, MultiInput mi, String userId, String orgFlag) throws Exception {
	
		String ret = "";
		String strMessage = "";
		SqlWrapper sql = null;
		Service svc = null;
		String strSlipNo = "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();	 
			/*
			 * 판매반품전표 저장
			 * 1. 원거래 매출 마스터에 취소구분자 UPDATE
			 * 2. 신규 판매전표 생성
			 *   2-1.  신규 판매 전표 생성
			 *   2-2.  신규 판매 상품권 마스터 수정
			 * 3.  원거래 판매전표중 신규생성되지 않은 RFD_GB 구분자 9로 설정 
			 */
			
			// 1. 원거래 매출 마스터에 취소구분자 UPDATE
			updCancel(form, userId);
			
			System.out.print("strCnt ====== "+ Integer.parseInt(form.getParam("strCnt")));
			
			// 2. 신규 판매전표 생성
			if(Integer.parseInt(form.getParam("strCnt")) > 0){
				strSlipNo = saveSale(form, mi, userId, orgFlag);
				sql.close();
    			sql.put(svc.getQuery("SEL_SLIP_NO"));
    			sql.setString(1, String2.nvl(form.getParam("strSaleDt")));
    			sql.setString(2, String2.nvl(form.getParam("strStrCd")));
    			sql.setString(3, strSlipNo);
                list = select2List(sql);
                if(list.size() == 0){
                	throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
    						+ "데이터 입력을 하지 못했습니다.");
                }
                List rowList2 = (List) list.get(0);
                String strNewSlipNo = rowList2.get(0).toString(); 
				strMessage += " 신규전표 : " + strNewSlipNo;	
			}
			
			// 3.  원거래 판매전표중 신규생성되지 않은 RFD_GB 구분자 9로 설정 
			updRFDGB(form, strSlipNo, userId);
			
			ret +=  strMessage;	
		} catch (Exception e) {
			System.out.println("log : " + e);
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;		
	}
	
	/**
	* 상품권 판매 취소 구분 UPDATE
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int updCancel(ActionForm form, String userId) throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			sql = new SqlWrapper();			
			svc = (Service) form.getService();		
				
			sql.close();
			sql.put(svc.getQuery("UPD_SALEMST")); 
			sql.setString(1, userId); 
			sql.setString(2, String2.nvl(form.getParam("strWonStrCd")));
			sql.setString(3, String2.nvl(form.getParam("strWonSaleDt")));
			sql.setString(4, String2.nvl(form.getParam("strWonSlipCd")));
			res = update(sql);

			if(res != 1){
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
		} catch (Exception e) {
			rollback();
			throw e;
		}		
		return res;		
	}
	
	/**
	* 상품권 판매 상세 내역에 RFD_GB 구분자 수정
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int updRFDGB(ActionForm form, String strSlipNo, String userId) throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			sql = new SqlWrapper();			
			svc = (Service) form.getService();		
				
			sql.close();
			if(Integer.parseInt(form.getParam("strCnt")) > 0){ // 판매전표가 생성된경우 반품된 상품권만 수정
				sql.put(svc.getQuery("UPD_SALEDTL")); 
				sql.setString(1, userId); 
				sql.setString(2, String2.nvl(form.getParam("strWonStrCd")));
				sql.setString(3, String2.nvl(form.getParam("strWonSaleDt")));
				sql.setString(4, String2.nvl(form.getParam("strWonSlipCd")));
				sql.setString(5, String2.nvl(form.getParam("strStrCd")));
				sql.setString(6, String2.nvl(form.getParam("strSaleDt")));
				sql.setString(7, strSlipNo);
				res = update(sql);
			}else{ // 재판매내역이 없는경우 모두 수정
				sql.put(svc.getQuery("UPD_SALEDTL_ALL")); 
				sql.setString(1, userId); 
				sql.setString(2, String2.nvl(form.getParam("strWonStrCd")));
				sql.setString(3, String2.nvl(form.getParam("strWonSaleDt")));
				sql.setString(4, String2.nvl(form.getParam("strWonSlipCd")));
				res = update(sql);
			}
			if(res == 0){
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
		} catch (Exception e) {
			rollback();
			throw e;
		}		
		return res;		
	}
	
	/**
	* 상품권 매출 MASTER
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public String saveSale(ActionForm form, MultiInput mi, String userId, String orgFlag) throws Exception {
	int ret = 0;
	int res = 0;
	SqlWrapper sql = null;
	Service svc = null;
	List list= null;
	List listD= null;
	int i = 0;
	String strSlipNo = "";
	try {
		sql = new SqlWrapper();			
		svc = (Service) form.getService();		
		
			// 상품권 판매 TABLE 시퀀스 발번
			sql.put(svc.getQuery("SEL_SALEMST_SLIPNO"));
	        list = select2List(sql);
	        List rowList = (List) list.get(0);
	        strSlipNo = rowList.get(0).toString(); 
	        sql.close();
	        
			// 마스터 등록 			
			sql.put(svc.getQuery("INS_SALEMSTS"));
			sql.setString(++i, form.getParam("strStrCd"));
			sql.setString(++i, form.getParam("strSaleDt")); 
			sql.setString(++i, strSlipNo);
			sql.setString(++i, orgFlag);
			sql.setString(++i, form.getParam("strStrCd"));
			sql.setString(++i, form.getParam("strSaleDt"));
			sql.setString(++i, strSlipNo); 
			sql.setString(++i, userId); 
			sql.setString(++i, userId); 
			res = update(sql);
			
			if(res == 0){
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}

	   sql.close();
           
		// 상세 내역 등록
		while(mi.next()){
			i=0;
			sql.close();
			if(mi.getString("SALE_GBN").equals("F") && !strSlipNo.equals("")){ 
				// 판매전표 DETAIL 생성
				sql.put(svc.getQuery("INS_SALEDTLS")); 
				sql.setString(++i, form.getParam("strSaleDt"));   
				sql.setString(++i, form.getParam("strStrCd"));   
				sql.setString(++i, strSlipNo);        				
				sql.setString(++i, form.getParam("strSaleDt")); 		
				sql.setString(++i, form.getParam("strStrCd")); 		
				sql.setString(++i, strSlipNo); 
				sql.setString(++i, mi.getString("GIFT_TYPE_CD"));
				sql.setString(++i, mi.getString("ISSUE_TYPE"));
				sql.setString(++i, mi.getString("GIFT_AMT_TYPE"));
				sql.setString(++i, mi.getString("SALE_QTY"));
				sql.setString(++i, mi.getString("SALE_AMT"));
				sql.setString(++i, mi.getString("GIFTCARD_NO"));
				sql.setString(++i, userId);
				sql.setString(++i, userId);	
				
				res = update(sql); 
				
				if(res == 0){
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				i = 0;
				sql.close();
				sql.put(svc.getQuery("UPD_SALE_AMT")); 
				sql.setString(++i, form.getParam("strStrCd"));   
				sql.setString(++i, form.getParam("strSaleDt"));   
				sql.setString(++i, strSlipNo);        				
				sql.setString(++i, form.getParam("strStrCd"));   
				sql.setString(++i, form.getParam("strSaleDt"));   
				sql.setString(++i, strSlipNo);   
				res = update(sql); 
				
				if(res == 0){
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				// 상품권 마스터에 판매내역 업데이트 
				saveGiftM(form, orgFlag, mi.getString("SALE_AMT"), mi.getString("GIFTCARD_NO"), userId);
			}
			
			res += res;
		}
		ret += res;	
		

		if(ret == 0){
			throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
					+ "데이터 입력을 하지 못했습니다.");
		}
	} catch (Exception e) {
		rollback();
		throw e;
	}		
	return strSlipNo;		
}
	 
	
	/**
	* 상품권마스터 회수 UPDATE
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int saveGiftM(ActionForm form, String strOrgFlag, String strAmt, String strCard, String userId) throws Exception {
	int ret = 0;
	int res = 0;
	SqlWrapper sql = null;
	Service svc = null;
	
	try {
		sql = new SqlWrapper();			
		svc = (Service) form.getService();		
			
		int i=0;
		sql.close();
		sql.put(svc.getQuery("UPD_GIFTMST_SALE"));
		sql.setString(++i, form.getParam("strStrCd"));
		sql.setString(++i, form.getParam("strSaleDt")); 
		sql.setString(++i, strOrgFlag);
		sql.setString(++i, userId);
		sql.setString(++i, strAmt);
		sql.setString(++i, userId);
		sql.setString(++i, strCard);
		res = update(sql);
		
		if(res == 0){
			throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
					+ "데이터 입력을 하지 못했습니다.");
		}
		ret += res;	
	} catch (Exception e) {
		rollback();
		throw e;
	}		
	return ret;		
	}
	
 
	
	
	
	
	
	

}
