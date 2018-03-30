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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif309DAO extends AbstractDAO {
	/**
	 * 상품권 코드 정보 조회
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

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
 
		sql.setString(i++, strGiftCardNo); 
		
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
	public int save(ActionForm form, MultiInput mi, String userId) throws Exception {
	
		int ret = 0;
		int res = 0; 
		SqlWrapper sql = null;
		Service svc = null;
        List	list 	 = null;
        String strCardno = "";
        String strGiftTypeCd = "";
        String strIssueType = "";
        String strGiftAmtType = ""; 
					
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();	 
			
			
            String strStrCD  	= String2.nvl(form.getParam("strStrCD"));
			String strRegDt  	= String2.nvl(form.getParam("strRegDt")); 
			
			
			// 상품권 판매 TABLE 시퀀스 발번
			sql.put(svc.getQuery("SEL_GIFTDRAWL"));
            //화면(JSP)에서 입력된 (조회)파라미터(Paramater) ss
            list = select2List(sql);
            List ListDRAWL = (List) list.get(0);
               String strDRAWLSeq = ListDRAWL.get(0).toString(); 
               sql.close(); 

			while (mi.next()) {				
				int i=0;
				sql.close();	
				
				if (mi.IS_INSERT()) { 			// 저장  
					
					String strSeqNo = getSeqNo(form, strRegDt, strStrCD, strDRAWLSeq);
					int endno = strSeqNo.length();
					endno = endno - 1;
					strSeqNo = strSeqNo.substring(1, endno);
					
					strCardno 		= mi.getString("GIFTCARD_NO"); 
					strGiftTypeCd 	= mi.getString("GIFT_TYPE_CD"); 
					strIssueType 	= mi.getString("ISSUE_TYPE"); 
					strGiftAmtType 	= mi.getString("GIFT_AMT_TYPE");  
					
					//상품권 마스터에 회수내역 UPDATE
					saveGiftM(form, strStrCD, strRegDt, strCardno, userId);
					
					// 회수테이블에 INSERT
					sql.put(svc.getQuery("INS_GIFTDRAWL")); 
					sql.setString(++i, strRegDt);   
					sql.setString(++i, strStrCD);   
					sql.setString(++i, strDRAWLSeq);   
					sql.setString(++i, strSeqNo); 		
					sql.setString(++i, mi.getString("GIFT_TYPE_CD"));
					sql.setString(++i, mi.getString("ISSUE_TYPE"));
					sql.setString(++i, mi.getString("GIFT_AMT_TYPE"));
					sql.setString(++i, mi.getString("GIFTCERT_AMT")); 
					sql.setString(++i, mi.getString("GIFTCARD_NO"));
					sql.setString(++i, mi.getString("SALE_STR"));
					sql.setString(++i, mi.getString("SALE_DT"));
					sql.setString(++i, userId);
					sql.setString(++i, userId);	
					res = update(sql); 
					sql.close();  
					
					// 상품권 판매 TABLE 시퀀스 발번
					sql.put(svc.getQuery("SEL_GIFTREUSE"));
			        //화면(JSP)에서 입력된 (조회)파라미터(Paramater) ss
			        list = select2List(sql);
			        List rowList = (List) list.get(0);
			           String strSeq = rowList.get(0).toString(); 
			           sql.close(); 

			        //상품권 재사용 테이블 INSERT
					saveGiftReuse(form, strRegDt, strStrCD, strDRAWLSeq, strSeqNo, strSeq, strGiftTypeCd, strIssueType, strGiftAmtType, strCardno, userId);
				    //상품권 마스터에 재사용내역 UPDATAE
					saveGift(form, strCardno, userId);
				}  
				
				ret += res;	
			} 
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
	 * 회수순번
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
	* 상품권 마스터에 구분값 UPDATE
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int saveGift(ActionForm form, String strCardno, String userId) throws Exception {
	int ret = 0;
	int res = 0;
	SqlWrapper sql = null;
	Service svc = null;
	
	try {
		sql = new SqlWrapper();			
		svc = (Service) form.getService();		
			
		int i=0;
		sql.close();
						
		sql.put(svc.getQuery("UPD_GIFTMST"));
		sql.setString(++i, userId);
		sql.setString(++i, strCardno);
		res = update(sql);

		ret += res;	
	} catch (Exception e) {
		rollback();
		throw e;
	}		
	return ret;		
}
	
	/**
	* 상품권 재사용 관리 INSERT
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int saveGiftReuse(ActionForm form, String strRegDt, String strStrCD, String strDRAWLSeq, String  strSeqNo, String strSeq, String strGiftTypeCd, String strIssueType, String strGiftAmtType, String strCardno, String userId) throws Exception {
	int ret = 0;
	int res = 0;
	SqlWrapper sql = null;
	Service svc = null;
	
	try {
		sql = new SqlWrapper();			
		svc = (Service) form.getService();		
			
		int i=0;
		sql.close();

		sql.put(svc.getQuery("INS_GIFTREUSE"));
		sql.setString(++i, strRegDt);   
		sql.setString(++i, strStrCD);    
		sql.setString(++i, strRegDt);    
		sql.setString(++i, strDRAWLSeq); 
		sql.setString(++i, strSeqNo);   
		sql.setString(++i, strSeq); 		
		sql.setString(++i, strGiftTypeCd);
		sql.setString(++i, strIssueType);
		sql.setString(++i, strGiftAmtType);
		sql.setString(++i, strCardno);
		sql.setString(++i, userId);
		sql.setString(++i, userId);	
		res = update(sql); 

		sql.close();   
		
		ret += res;	
	} catch (Exception e) {
		rollback();
		throw e;
	}		
	return ret;		
}
	
	/**
	* 상품권 마스터에 구분값 UPDATE
	* 
	* @param form
	* @param mi
	* @param strID
	* @return
	* @throws Exception
	*/
	public int saveGiftM(ActionForm form, String strStrCD, String strRegDt, String strCardno, String userId) throws Exception {
	int ret = 0;
	int res = 0;
	SqlWrapper sql = null;
	Service svc = null;
	
	try {
		sql = new SqlWrapper();			
		svc = (Service) form.getService();		
			
		int i=0;
		sql.close(); 
		
		sql.put(svc.getQuery("UPD_GIFTMST_DRAWL"));
		sql.setString(++i, strStrCD);
		sql.setString(++i, strRegDt);
		sql.setString(++i, userId);
		sql.setString(++i, userId);
		sql.setString(++i, strCardno);
		res = update(sql);

		ret += res;	
	} catch (Exception e) {
		rollback();
		throw e;
	}		
	return ret;		
}

}
