/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p> 청구대상 데이터 조회DAO </p>
 * 
 * @created on 1.0, 2010/05/31
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal922DAO extends AbstractDAO {
	/**
	 * <p>
	 * 청구대상 데이터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null; 
		//String query = "";
		String strQuery = "";

		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));    
		String strReqDt    = String2.nvl(form.getParam("strReqDt"));
		String strReqToDt  = String2.nvl(form.getParam("strReqToDt")); 
		String strBcompCd  = String2.nvl(form.getParam("strBcompCd"));   
		String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));  
		String strCardNo   = String2.nvl(form.getParam("strCardNo"));    
		String strApprNo   = String2.nvl(form.getParam("strApprNo"));  
		String strDivMonth   = String2.nvl(form.getParam("strDivMonth"));  

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery += svc.getQuery("SEL_MASTER") + "\n";

		//query = svc.getQuery("SEL_MASTER"); 
		sql.setString(i++, strStrCd   );
		sql.setString(i++, strReqDt   );
		sql.setString(i++, strReqToDt   );
		
		if(!strBcompCd.equals("%")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMPCD") + "\n";
			sql.setString(i++, strBcompCd);
		}
		if(!strJbrchId.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCHID") + "\n";
			sql.setString(i++, strJbrchId);
		}
		if(!strCardNo.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CARDNO") + "\n";
			sql.setString(i++, strCardNo);
		}
		if(!strApprNo.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_APPRNO") + "\n";
			sql.setString(i++, strApprNo);
		}
		if(!strDivMonth.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_DIVMONTH") + "\n";
			sql.setString(i++, strDivMonth);
		}	

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * <p>
	 * 청구대상 데이터 오류 COUNT
	 * </p>
	 * 
	 */
	public List searchCount(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		//String query = "";
		String strQuery = "";

		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));    
		String strReqDt    = String2.nvl(form.getParam("strReqDt")); 
		String strReqToDt  = String2.nvl(form.getParam("strReqToDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery += svc.getQuery("SEL_COUNT") + "\n";

		//query = svc.getQuery("SEL_MASTER"); 
		sql.setString(i++, strStrCd   );
		sql.setString(i++, strReqDt   );
		sql.setString(i++, strReqToDt   );

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 청구대상 데이터 등록/수정
	 * @param form
	 * @param mi1
	 * @param userId - 로그인한 사용자ID
	 * @return
	 * @throws Exception
	 */
	public int saveData(ActionForm form, MultiInput mi1, String userId)	throws Exception {

		int	i				= 0;
		int	res				= 0;
		int	ret				= 0;

		SqlWrapper	sql			= null;
		Service		svc			= null;

		try {

			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service)	form.getService();

			mi1.next();

			i =	1;
			
			sql.put(svc.getQuery("MERGE_MASTER"));;

			//merge
			sql.setString(i++, 	mi1.getString("REQ_DT"));		//청구일자 1
			sql.setString(i++, 	mi1.getString("FCL_FLAG"));		//시설구분 2
			sql.setInt(i++, 	mi1.getInt("SEQ_NO"));			//청구순번 3

			//update
			sql.setString(i++, 	mi1.getString("DEVICE_ID"));	//단말기구분
			sql.setString(i++, 	mi1.getString("WORK_FLAG"));	//작업구분
			sql.setString(i++, 	mi1.getString("CARD_NO"));		//카드번호
			sql.setString(i++, 	mi1.getString("EXP_DT"));		//유효기간(YYMM)
			sql.setInt(i++, 	mi1.getInt("DIV_MONTH"));		//할부
			sql.setInt(i++, 	mi1.getInt("APPR_AMT"));		//승인금액
			sql.setInt(i++, 	mi1.getInt("SVC_AMT"));			//봉사료
			sql.setString(i++,	mi1.getString("APPR_NO"));		//승인번호
			sql.setString(i++,	mi1.getString("APPR_DT"));		//승인일자
			sql.setString(i++,	mi1.getString("APPR_TIME"));	//승인시간
			sql.setString(i++,	mi1.getString("CAN_DT"));		//취소일자
			sql.setString(i++, 	mi1.getString("CAN_TIME"));		//취소시간
			sql.setString(i++, 	mi1.getString("CCOMP_CD"));		//발급사코드
			sql.setString(i++, 	mi1.getString("BCOMP_CD"));		//매입사코드
			sql.setString(i++, 	mi1.getString("JBRCH_ID"));		//가맹점번호
			sql.setString(i++, 	mi1.getString("POS_NO"));		//POS번호
			sql.setString(i++, 	mi1.getString("TRAN_NO"));		//거래번호
			sql.setString(i++, 	mi1.getString("PAY_TYPE"));		//결재구분
			
			sql.setString(i++, 	userId);		//수정자
			
			//insert
			sql.setString(i++, 	mi1.getString("REQ_DT"));		//매입요청일자
			sql.setString(i++,	mi1.getString("FCL_FLAG"));		//카드번호
			sql.setInt(i++, 	mi1.getInt("SEQ_NO"));			//카드번호
			sql.setString(i++, 	mi1.getString("REC_FLAG"));		//레코드구분    
			sql.setString(i++, 	mi1.getString("DEVICE_ID"));	//단말기구분    
			sql.setString(i++, 	mi1.getString("WORK_FLAG"));	//작업구분      
			sql.setString(i++, 	mi1.getString("COMP_NO"));		//사업자번호    
			sql.setString(i++, 	mi1.getString("CARD_NO"));		//카드번호      
			sql.setString(i++, 	mi1.getString("EXP_DT"));		//유효기간(YYMM)
			sql.setInt(i++, 	mi1.getInt("DIV_MONTH"));		//할부          
			sql.setInt(i++, 	mi1.getInt("APPR_AMT"));		//승인금액      
			sql.setInt(i++, 	mi1.getInt("SVC_AMT"));			//봉사료        
			sql.setString(i++, 	mi1.getString("APPR_NO"));		//승인번호      
			sql.setString(i++, 	mi1.getString("APPR_DT"));		//승인일자      
			sql.setString(i++, 	mi1.getString("APPR_TIME"));	//승인시간      
			sql.setString(i++, 	mi1.getString("CAN_DT"));		//취소일자      
			sql.setString(i++, 	mi1.getString("CAN_TIME"));		//취소시간      
			sql.setString(i++, 	mi1.getString("CCOMP_CD"));		//발급사코드    
			sql.setString(i++, 	mi1.getString("BCOMP_CD"));		//매입사코드    
			sql.setString(i++, 	mi1.getString("JBRCH_ID"));		//가맹점번호    
			sql.setString(i++, 	mi1.getString("STR_CD"));		//점코드        
			sql.setString(i++, 	mi1.getString("REQ_DT"));		//매출일자
			sql.setString(i++, 	"XXXX");		//POS번호
			sql.setString(i++, 	"XXXX");		//거래번호
			
			//POS_SEQ_NO
			sql.setString(i++, 	mi1.getString("STR_CD"));		//점코드
			sql.setString(i++, 	mi1.getString("REQ_DT"));		//매출일자(=청구일자와 동일)
			sql.setString(i++, 	"XXXX");		//POS번호
			sql.setString(i++, 	"XXXX");		//거래번호
			
			sql.setString(i++, 	mi1.getString("PAY_TYPE"));		//결재구분
			sql.setString(i++, 	userId);		//등록자
			sql.setString(i++, 	userId);		//수정자

			res = update(sql);
			
			if (res == 0) {
				throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
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
	 * 가맹점 번호를 조회한다.  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getJbrchID(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		//String query = "";
		String strQuery = "";

		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));    
		String strBCompCd  = String2.nvl(form.getParam("strBCompCd")); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery += svc.getQuery("SEL_JBRCH_ID") + "\n";

		//query = svc.getQuery("SEL_MASTER"); 
		sql.setString(i++, strStrCd   );
		sql.setString(i++, strBCompCd );

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 시설구분, 사업자 번호를 조회한다. 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getStrInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		//String query = "";
		String strQuery = "";

		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));    

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery += svc.getQuery("SEL_STR_INFO") + "\n";

		//query = svc.getQuery("SEL_MASTER"); 
		sql.setString(i++, strStrCd   );

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
}
