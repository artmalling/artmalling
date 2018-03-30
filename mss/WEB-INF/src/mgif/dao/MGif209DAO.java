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

public class MGif209DAO extends AbstractDAO {

	/**
	 * 사고/해지 등록 조회
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
		
		String strStr = String2.nvl(form.getParam("strStr"));
		String strSrart = String2.nvl(form.getParam("strSrart"));
		String strEnd = String2.nvl(form.getParam("strEnd")); 
		String strChk = String2.nvl(form.getParam("strChk"));  

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
 
		sql.setString(i++, strStr);
		sql.setString(i++, strSrart);
		sql.setString(i++, strEnd);   
		
		strQuery = svc.getQuery("SEL_GIFTACDT") + "\n";
		sql.put(strQuery);
		
		if(strChk.equals("2")) {
			strQuery = svc.getQuery("SEL_CHECK") + "\n";
			sql.put(strQuery);
			sql.setString(i++, strChk);
		}
		strQuery = svc.getQuery("SEL_ORDERBY") + "\n";
		sql.put(strQuery);
		
		ret = select2List(sql); 
		return ret;
		
	}
	
	/**
	 * <p>공통코드[계산방식]</p>
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
	 * 상품권번호에 대한 상품권종류&금종&상품권금액  조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSpno(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		 
		String strSpno = String2.nvl(form.getParam("strSpno"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
  
		sql.setString(i++, strSpno);
		
		strQuery = svc.getQuery("SEL_SPNO") + "\n";
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
     * <p>사고/해지 저장</p>
     */
    public int save(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc = null;
        List	list 	 = null;
        
        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();

            while (mi.next()) {
                sql.close();
                
                
                if (mi.IS_INSERT()) {
                	

               	 	sql.put(svc.getQuery("SEL_GIFTACDT_SEQ"));
                    //화면(JSP)에서 입력된 (조회)파라미터(Paramater) ss
                    list = select2List(sql);
                    List rowList = (List) list.get(0);
                       String strSeq = rowList.get(0).toString();
                       System.out.println(strSeq);
                       sql.close();
                	
                	sql.put(svc.getQuery("INS_ACDT"));                	
                	int i = 0;
                	if(mi.getString("ACDT_PROC_FLAG").equals("1")){  
                		System.out.println(mi);
                		sql.setString(++i, mi.getString("ACDT_DT"));
                        sql.setString(++i, mi.getString("ACDT_STR")); 
                        sql.setString(++i, strSeq); 
                        sql.setString(++i, mi.getString("GIFTCARD_NO")); 
                        sql.setString(++i, mi.getString("GIFT_TYPE_CD")); 
                        sql.setString(++i, mi.getString("ISSUE_TYPE")); 
                        sql.setString(++i, mi.getString("GIFT_AMT_TYPE")); 
                        sql.setString(++i, mi.getString("ACDT_PROC_FLAG")); 
                        sql.setString(++i, mi.getString("ACDT_RSN_CD")); 
                        sql.setString(++i, mi.getString("ACDT_REASON")); 
                        sql.setString(++i, "");
                        sql.setString(++i, "");
                        sql.setString(++i, "");
                        sql.setString(++i, "");
                        sql.setString(++i, "");
                        //session의 사용자 ID
                        sql.setString(++i, userID);
                        sql.setString(++i, userID);  
                        res = update(sql);
                        sql.close();
                	}
                	else if (mi.getString("ACDT_PROC_FLAG").equals("2")){ 
                		sql.setString(++i, mi.getString("ACDT_DT"));
                        sql.setString(++i, mi.getString("ACDT_STR"));
                        sql.setString(++i, strSeq);
                        sql.setString(++i, mi.getString("GIFTCARD_NO"));
                        sql.setString(++i, mi.getString("GIFT_TYPE_CD"));
                        sql.setString(++i, mi.getString("ISSUE_TYPE"));
                        sql.setString(++i, mi.getString("GIFT_AMT_TYPE"));
                        sql.setString(++i, mi.getString("ACDT_PROC_FLAG"));
                        sql.setString(++i, mi.getString("ACDT_RSN_CD"));
                        sql.setString(++i, mi.getString("ACDT_REASON"));
                        sql.setString(++i, mi.getString("CAN_DT"));
                        sql.setString(++i, mi.getString("CAN_STR"));
                        sql.setString(++i, mi.getString("CAN_REG_ID"));
                        sql.setString(++i, mi.getString("CAN_RSN_CD"));
                        sql.setString(++i, mi.getString("CAN_REASON")); 
                        //session의 사용자 ID
                        sql.setString(++i, userID);  
                        sql.setString(++i, userID); 
                        res= update(sql);
                        sql.close();
                	}else {
                		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                				+ "데이터 입력을 하지 못했습니다.");
                	}
                    
                    sql.put(svc.getQuery("UPD_GIFTMST_I"));
 
                	if(mi.getString("ACDT_PROC_FLAG").equals("1"))
                	{ 
	                	//사고만 등록시
	            		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
	                	sql.setString     (1, mi.getString("ACDT_DT"));  
	                	sql.setString(2, mi.getString("ACDT_STR"));   
	                	sql.setString(3, strSeq);   
	                	sql.setString(4, "Y");  
	                	sql.setString(5, mi.getString("GIFTCARD_NO"));  
	                	update(sql); 
                	}
                	else if (mi.getString("ACDT_PROC_FLAG").equals("2"))
                	{
                		//사고&해지 동시등록
                		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                		sql.setString(1, mi.getString("ACDT_DT"));  
	                	sql.setString(2, mi.getString("ACDT_STR"));  
	                	sql.setString(3, strSeq);  
	                	sql.setString(4, "N");  
	                	sql.setString(5, mi.getString("GIFTCARD_NO")); 
	                	update(sql); 
                	}else {
                		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                				+ "데이터 입력을 하지 못했습니다.");
                	}
                	
                } else if (mi.IS_UPDATE()) {
                	sql.put(svc.getQuery("UPD_ACDT"));
                	int i = 0;
                	
                    sql.setString(++i, mi.getString("ACDT_PROC_FLAG"));
                    sql.setString(++i, mi.getString("ACDT_RSN_CD"));
                    sql.setString(++i, mi.getString("ACDT_REASON"));
                    sql.setString(++i, mi.getString("CAN_DT"));
                    sql.setString(++i, mi.getString("CAN_STR"));
                    sql.setString(++i, mi.getString("CAN_REG_ID"));
                    sql.setString(++i, mi.getString("CAN_RSN_CD"));
                    sql.setString(++i, mi.getString("CAN_REASON")); 
                    //session의 사용자 ID
                    sql.setString(++i, userID);   
                    sql.setString(++i, mi.getString("ACDT_DT"));
                    sql.setString(++i, mi.getString("ACDT_STR"));
                    sql.setString(++i, mi.getString("ACDT_SEQ_NO"));
                    res = update(sql);
                    sql.close();
                    
                  //해지update
                	sql.put(svc.getQuery("UPD_GIFTMST_U"));
            		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                	if(mi.getString("ACDT_PROC_FLAG").equals("1"))
                	{ 
	                	//사고만 등록시
	            		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                		sql.setString(1, "Y");    
                    	sql.setString(2, mi.getString("GIFTCARD_NO")); 
                    	sql.setString(3, mi.getString("ACDT_DT"));  
                    	sql.setString(4, mi.getString("ACDT_STR"));  
                    	sql.setString(5, mi.getString("ACDT_SEQ_NO"));
                    	update(sql); 
                	}
                	else if (mi.getString("ACDT_PROC_FLAG").equals("2"))
                	{
                		//사고&해지 동시등록
                		//화면(JSP)에서 입력된 (조회)파라미터(Paramater)
                		sql.setString(1, "N");    
                    	sql.setString(2, mi.getString("GIFTCARD_NO")); 
                    	sql.setString(3, mi.getString("ACDT_DT"));  
                    	sql.setString(4, mi.getString("ACDT_STR"));  
                    	sql.setString(5, mi.getString("ACDT_SEQ_NO"));
                    	update(sql); 
                	}else {
                		throw new Exception("" + "데이터의 적합성 문제로 인하여"
                				+ "데이터 입력을 하지 못했습니다.");
                	}
                	
                } else {
                	/* 저장된 내역은 삭제 할 수 없음
                	sql.put(svc.getQuery("DEL_MR_MNTNITEM"));
                	int i = 0;
                    sql.setString(++i, mi.getString("STR_CD"));
                    sql.setString(++i, mi.getString("MNTN_ITEM_CD"));
                    res = update(sql);
                    */
                }
                
                if (res != 1) {
                	throw new Exception("" + "데이터의 적합성 문제로 인하여"
                			+ "데이터 입력을 하지 못했습니다.");
                }

                ret += res;
            }
        } catch (Exception e) {
        	System.out.println(">>>>>>>>>>>>>>>>>>>> : " + e);
            rollback();
            throw e;
        } finally {
            end();
        }
        return ret;
    }

}
