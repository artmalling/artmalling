/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.util.Util;
import common.vo.SessionInfo;

import dcom.socket.dClientDept;

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
 * <p>상품권 교환 반품</p>
 * 
 * @created  on 1.0, 2016.11.07
 * @created  by khj
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo719DAO extends AbstractDAO {

    /**
     * 상품권 교환 정보를  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public int realSave(ActionForm form, MultiInput mi[], HttpServletRequest request) throws Exception {
    	final String MSG_LEN 		= "0621";
        final int	 MSG_ARR_LEN 	= 60;
		int 	   ret   = 0;
        int rtnCode         = 0;
        int retint = 0;
		String 	   retstr   = "";
		MultiInput mi1   = mi[0];
		MultiInput mi2   = mi[1];
		MultiInput mi3   = mi[2];
		MultiInput mi4   = mi[3];
        dClientDept client   = null;
        String sendData  = "";
        Util       util  = new Util();
    	String[] rMsg = new String[MSG_ARR_LEN];
    	SqlWrapper sql   = null;
        Service    svc   = null;
        
        int result = 0;
		
        try {
        	
        	//client = new dClientDept();
        	
        	HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            String strUserId = sessionInfo.getUSER_ID();
            String strBrchId = sessionInfo.getBRCH_ID();

            sql  = new SqlWrapper();
            svc  = (Service)form.getService();
            connect("pot");
            
            mi2.next();
            
            int intConvPoint 	= Integer.parseInt(mi2.getString("CONV_POINT"));
            int intConvGiftAmt 	= Integer.parseInt(mi2.getString("CONV_GIFT_AMT"));

            mi2.setInt("CONV_POINT", intConvPoint);
            mi2.setInt("CONV_GIFT_AMT", intConvGiftAmt);
            
			//*********** 전문송신 모듈
			//***1. 전문생성   
			String[] arrData = new String[MSG_ARR_LEN];
          	
	        arrData[0]  = MSG_LEN;										//	MSG_LEN	     C	4
	        arrData[1]  = "DEPTRN0211";			                        //	MSG_TEXT	 C	10
	        arrData[3]  = "200030";										//	TRADE_GB_CD	 C	6
	        arrData[4]  = util.getDate();								//	SALE_DT	     C	8
	        arrData[5]  = util.getShortTimeString();					//	SALE_TM	     C	6
	        arrData[7]  = strUserId;                                    //	REG_ID	     C	10
	        arrData[8]  = "C";											//	IN_FLAG	     C	1
	        arrData[9]  = mi2.getString("CARD_NO");                  	//	CARD_NO	     C	20 util.decryptedStr(strCardNo)
	        arrData[10] = mi2.getString("PWD_NO");                      //	PASSWD	     C	4
	        arrData[11] = strBrchId;				                    //	BRCH_ID   	 C	10
	        arrData[12] = "40";                                         //  TYPE1_CD     C    2
	        arrData[14] = String.valueOf(intConvPoint);                 //  TYPE1_AMT    N    9
	        arrData[36] = "1";                                          //  TYPE_CNT     N    2
	        arrData[37] = String.valueOf(intConvPoint);                 //  TRADE_AMT    N   10
	        arrData[41] = "21";                                         //  ADD_USE_FLAG C    2
			
			//***2. 전문송신
			//송신후에 결과값 처리..
			//rMsg = client.sendData(arrData);
	        
	        result = this.sendData(arrData);
			//***2. 전문송신
			//System.out.println("전문송신결과응답코드:"+rMsg[42]);
			//***3. 전문송수신결과에 따른 저장여부 및 메세지.
	        
	        //rollback();
			if(result == 0){
				 rtnCode = this.saveData(form, mi, request);
				System.out.println("DMbo719DAO saveData : rtnCode = " + rtnCode);
			}else{

				rollback();
			    throw new Exception("|[USER]" +result + "상품권교환반품 : 포인트 적립에 실패하였습니다");	
			}
			

			if(rtnCode > 0){	
				System.out.println("proCall ----");
				retstr = this.proCall(form, mi, request);
			}else{
				rollback();
			    throw new Exception("|[USER]" +result + "상품권교환반품 : 상품권 등록에 실패하였습니다");	
			}
			
			//rollback();
 
			
			if(rtnCode > 0){	
				retint = GIFTDRAWL_save(form, mi, request, strUserId);
				//retstr = this.proCall(form, mi, request);
			}else{
				rollback();
			    throw new Exception("|[USER]" +result + "상품권교환반품 : 상품권 등록에 실패하였습니다");	
			}
			
			System.out.println("DMbo719DAO proCall : retstr = " + retstr);
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
        return ret;
	}
    
    
  
	public int GIFTDRAWL_save(ActionForm form, MultiInput  mi[], HttpServletRequest request, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String strSlipNo;
		

		MultiInput mi1   = mi[0];     //DS_I_MASTER - H_MASTER  
		
		int i =1;
		try {
			connect("pot");
			begin();
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
            String strUserId = sessionInfo.getUSER_ID();
            
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sql.put(svc.getQuery("SEL_DRAWL_SLIP_NO"));     // 회수 전표번호
			Map map = (Map) selectMap(sql);
			strSlipNo = map.get("DRAWL_SLIP_NO").toString();
		
			while(mi1.next()){
				sql.close();
				i = 1;
				
				sql.put(svc.getQuery("INS_GIFTDRAWL")); 
				sql.setString(i++, mi1.getString("PROC_DT"));        //1:반품일자
				sql.setString(i++, sessionInfo.getSTR_CD());         //2:점
				sql.setString(i++, strSlipNo);                       //3:전표번호
				sql.setString(i++, mi1.getString("PROC_DT"));        //4:전표번호 SEQ발번
				sql.setString(i++, sessionInfo.getSTR_CD());         //4:전표번호 SEQ발번
				sql.setString(i++, strSlipNo);                       //4:전표번호 SEQ발번
				
				sql.setString(i++, mi1.getString("GIFT_AMT_TYPE"));
				sql.setString(i++, mi1.getString("GIFT_TYPE_CD"));
				sql.setString(i++, mi1.getString("ISSUE_TYPE"));				
				
				sql.setString(i++, mi1.getString("GIFTCERT_AMT"));
				sql.setString(i++, mi1.getString("GIFTCARD_NO"));
				sql.setString(i++, mi1.getString("SALE_STR"));
				sql.setString(i++, mi1.getString("SALE_DT"));
				sql.setString(i++, strUserId);
				sql.setString(i++, strUserId);
				res = update(sql);
	
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				sql.close();
				i = 1;
				sql.put(svc.getQuery("UPD_GIFTMST")); 
				sql.setString(i++, sessionInfo.getSTR_CD());
				sql.setString(i++, mi1.getString("PROC_DT"));
				sql.setString(i++, userId);
				sql.setString(i++, userId);
				sql.setString(i++, mi1.getString("GIFTCARD_NO"));
				
				res = update(sql);
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
     * 상품권 교환 정보를  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public int save(ActionForm form, MultiInput mi[], HttpServletRequest request) throws Exception {
    	final String MSG_LEN 		= "0621";
        final int	 MSG_ARR_LEN 	= 60;
		int 	   ret   = 0;
		MultiInput mi1   = mi[0];
		MultiInput mi2   = mi[1];
        dClientDept client   = null;
        String sendData  = "";
        Util       util  = new Util();
    	String[] rMsg = new String[MSG_ARR_LEN];
    	SqlWrapper sql   = null;
        Service    svc   = null;
        
        int result = 0;
    	
        try {
        	
        	//client = new dClientDept();
        	
        	HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            String strUserId = sessionInfo.getUSER_ID();
            String strBrchId = sessionInfo.getBRCH_ID();

            sql  = new SqlWrapper();
            svc  = (Service)form.getService();
            connect("pot");
            
            mi2.next();
            
            int intConvPoint 	= Integer.parseInt(mi2.getString("CONV_POINT"));
            int intConvGiftAmt 	= Integer.parseInt(mi2.getString("CONV_GIFT_AMT"));

            mi2.setInt("CONV_POINT", intConvPoint);
            mi2.setInt("CONV_GIFT_AMT", intConvGiftAmt);
            
			//*********** 전문송신 모듈
			//***1. 전문생성   
			String[] arrData = new String[MSG_ARR_LEN];
          	
	        arrData[0]  = MSG_LEN;										//	MSG_LEN	     C	4
	        arrData[1]  = "DEPTRN0211";			                        //	MSG_TEXT	 C	10
	        arrData[3]  = "300050";										//	TRADE_GB_CD	 C	6   //포인트 사용취소
	        arrData[4]  = util.getDate();								//	SALE_DT	     C	8
	        arrData[5]  = util.getShortTimeString();					//	SALE_TM	     C	6
	        arrData[7]  = strUserId;                                    //	REG_ID	     C	10
	        arrData[8]  = "C";											//	IN_FLAG	     C	1
	        arrData[9]  = util.encryptedStr(mi2.getString("CARD_NO"));	//	CARD_NO	     C	20 util.decryptedStr(strCardNo)
	        arrData[10] = util.encryptedPasswd(mi2.getString("PWD_NO"));                      //	PASSWD	     C	4
	        arrData[11] = strBrchId;				                    //	BRCH_ID   	 C	10
	        arrData[12] = "40";                                         //  TYPE1_CD     C    2
	        arrData[14] = String.valueOf(intConvPoint);                 //  TYPE1_AMT    N    9
	        arrData[36] = "1";                                          //  TYPE_CNT     N    2
	        arrData[37] = String.valueOf(intConvPoint);                 //  TRADE_AMT    N   10
	        arrData[41] = "21";                                         //  ADD_USE_FLAG C    2
			
			//***2. 전문송신
			//송신후에 결과값 처리..
			//rMsg = client.sendData(arrData);
	        result = this.sendData(arrData);
			//***2. 전문송신
			//System.out.println("전문송신결과응답코드:"+rMsg[42]);
			//***3. 전문송수신결과에 따른 저장여부 및 메세지.
			if(result == 0){
				ret = this.saveData(form, mi, request);
			}else{
			    throw new Exception("|[USER]" +result + "상품권교환반품에 실패하였습니다");	
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			//end();
		}
		
        return ret;
	}
    
    /**
	 * 프로시져 호출
	 * @param form
	 * @param mi
	 * @return
	 */	
	public int sendData(String[] output) throws Exception{
		int ret  = 0;
		//int res  = 0;
		String res = "";
		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		
		int i = 0;
		try {
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			connect("pot");
			begin();
		
			//psql.put("DCS.PR_DMBO504", 63);    
			psql.put("DCS.PR_DMBO504_GIFT", 63);    
			
			psql.setString(++i, output[ 0]);                 //전문 총길이
			psql.setString(++i, output[ 1]);                 //전문 구분
			psql.setString(++i, ""); //POS정보
			psql.setString(++i, output[ 3]);                 //거래구분코드
			psql.setString(++i, output[ 4]);                 //영업일자
			psql.setString(++i, output[ 5]);                 //거래시간
			psql.setString(++i, "");     //영수증번호
			psql.setString(++i, output[ 7]);                 //담당자사번
			psql.setString(++i, output[ 8]);                 //카드/주민번호구분
			psql.setString(++i, output[ 9]);                 //카드번호/주민번호
			psql.setString(++i, output[10]);                 //비밀번호
			psql.setString(++i, output[11]);                 //가맹점ID
			psql.setString(++i, output[12]);                 //결제수단코드1
			psql.setString(++i, "");                       //결제수단1상세
			psql.setString(++i, output[14]);                 //결제수단금액1
			psql.setString(++i, "");                       //결제수단코드2
			psql.setString(++i, "");                       //결제수단2상세
			psql.setDouble(++i, 0);                  //결제수단금액2
			psql.setString(++i, "");                       //결제수단코드3
			psql.setString(++i, "");                       //결제수단3상세
			psql.setDouble(++i, 0);                  //결제수단금액3
			psql.setString(++i, "");                       //결제수단코드4
			psql.setString(++i, "");                       //결제수단4상세
			psql.setDouble(++i, 0);                  //결제수단금액4
			psql.setString(++i, "");                       //결제수단코드5
			psql.setString(++i, "");                       //결제수단5상세
			psql.setDouble(++i, 0);                  //결제수단금액5
			psql.setString(++i, "");                       //결제수단코드6
			psql.setString(++i, "");                       //결제수단6상세
			psql.setDouble(++i, 0);                  //결제수단금액6
			psql.setString(++i, "");                       //결제수단코드7
			psql.setString(++i, "");                       //결제수단7상세
			psql.setDouble(++i, 0);                  //결제수단금액7
			psql.setString(++i, "");                       //결제수단코드8
			psql.setString(++i, "");                       //결제수단8상세
			psql.setDouble(++i, 0);                  //결제수단금액8
			psql.setString(++i, output[36]);                 //결제수단건수
			psql.setString(++i, output[37]);                 //총거래금액
			psql.setDouble(++i, 0);                   //사용취소포인트
			psql.setString(++i, "");                  //원거래영수증번호
			psql.setString(++i, "");                  //원거래승인번호
			psql.setString(++i, output[41]);          //적립/사용구분
			//psql.setString(++i, "");                  //응답코드
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			//psql.setString(++i, "");                  //승인번호
			//psql.setString(++i, "");                  //성명
			//psql.setString(++i, "");                       //회원등급
			//psql.setString(++i, "");                 //시스템일자
			//psql.setString(++i, "");                   //시스템시간

			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			//psql.setDouble(++i, 0);                  //누적포인트
			//psql.setDouble(++i, 0);                  //가용포인트
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			
			//psql.setString(++i, output[50]);                 //금회포인트
			//psql.setDouble(++i, 0);                  //결제적립
			//psql.setString(++i, "");     //캠페인ID
			//psql.setDouble(++i, 0);                  //캠페인적립
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			
			
			psql.setString(++i, "");     //이벤트ID
			psql.setDouble(++i, 0);                  //이벤트적립
			
			//psql.setDouble(++i, 0);                  //기타적립
			//psql.setString(++i, ""); //영수증출력메시지1
			//psql.setString(++i, ""); //영수증출력메시지2
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			
			//psql.setString(++i, ""); //회원ID
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			//psql.setString(++i, "");           //공란
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			psql.registerOutParameter(62, DataTypes.INTEGER);//8
			psql.registerOutParameter(63, DataTypes.VARCHAR);//9
			
			System.out.println("psql----------1" + psql);
			
		    prs = updateProcedure(psql);	

			System.out.println("Return----------1");

			resp = prs.getInt(62);

			System.out.println("Return----------2 = " + resp);
			
			res = prs.getString(63);

			System.out.println("Return----------3 = " + res);
			
			//System.out.println(prs.getInt(62) + "Return");
			//System.out.println(prs.getString(63) + "MESSAGE");
			
			/*
	        if (resp != 0) {
	            throw new Exception("[USER]" +res);
	        }*/
				//ret += resp;


		} catch (Exception e) {

			System.out.println("rollbackrollbackrollbackrollback = ");
			rollback();
			throw e;
		} finally {
			//end();
		}
		return resp;
	}
    

    /**
     * 상품권 교환 정보를  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi 
     * @param strID
     * @return
     * @throws Exception
     */
    public String chkSave(ActionForm form, MultiInput mi[], HttpServletRequest request) throws Exception {
		
		MultiInput mi1   = mi[0];
		MultiInput mi2   = mi[1];  
    	SqlWrapper sql   = null;
        Service    svc   = null;
        String strUseYn  = "";
        
        try {
        	
        	HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
            sql  = new SqlWrapper();
            svc  = (Service)form.getService();
            connect("pot");
            /*
            mi2.next();
            
            int intQty5   = Integer.parseInt(mi2.getString("QTY_5"));
            int intQty10  = Integer.parseInt(mi2.getString("QTY_10"));
            int intQty50  = Integer.parseInt(mi2.getString("QTY_50"));
            int intQty100 = Integer.parseInt(mi2.getString("QTY_100"));
            
            int intConvPoint =  5000 * intQty5 + 10000 * intQty10 + 50000 * intQty50 + 100000 *  intQty100;
            */
            int intSumGift = 0;
            int intRow     = 0;
            while (mi1.next()) {
            	sql.close();
        	    sql.put(svc.getQuery("GET_GIFTCARD_SALECHECK"));    //상품권확인
            	sql.setString(1, sessionInfo.getSTR_CD());  
            	sql.setString(2, mi1.getString("GIFTCARD_NO"));  
            	
                Map map2 = selectMap(sql); 
                strUseYn = map2.get("USE_YN").toString();
                intRow++;
                
                if(strUseYn.equals("99")){
                	throw new Exception("[USER]"+ intRow +"행은 존재하지 않는 상품권번호입니다.");	
                }else  if(strUseYn.equals("10")){
                	throw new Exception("[USER]"+ intRow +"행은 판매불가 상품권입니다.");	
                }else  if(strUseYn.equals("20")){
                	throw new Exception("[USER]"+ intRow +"행은 사고 상품권입니다.");	
                }
                sql.close();
                
                sql  = new SqlWrapper();
            	sql.setString(1, mi1.getString("GIFTCARD_NO"));  
        	    sql.put(svc.getQuery("GET_GIFTCARD_PRC"));    //상품권확인
        	    
                Map map = selectMap(sql); 
                String strGiftCertAmt = map.get("GIFTCERT_AMT").toString();
                intSumGift += Integer.parseInt(strGiftCertAmt);
            }
            /*
            if( intConvPoint != intSumGift){
            	throw new Exception("[USER]"+"상품권 금액과 포인트 사용금액이 일치하지 않습니다.");	
            }
            */

            //mi2.setInt("CONV_POINT", intSumGift);

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return strUseYn;
	}
    
    /**
     * 상품권 교환 정보를  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public int saveData(ActionForm form, MultiInput mi[], HttpServletRequest request) throws Exception {
		int 	   ret   = 0;
        SqlWrapper sql   = null;
        Service    svc   = null;
		MultiInput mi2   = mi[1];      //DS_I_POINT 
		MultiInput mi3   = mi[2];      //DS_O_MASTER
        Util       util  = new Util();
        
        try {
        	System.out.println("11111111111111");
        	//if( getTrConnection() == null){
				connect("pot");
				begin();
				System.out.println("22222222222");
			//}

            svc  = (Service)form.getService();
            String strQuery = "";
            sql  = new SqlWrapper();
			int res = 0;
			int res1 = 0;
		    	
	    	HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");

            sql.put(svc.getQuery("GET_SQ_GIFTCD"));  //상품권SEQ
            Map map = selectMap(sql);
            mi2.setInt("SEQ_NO", Integer.parseInt(map.get("SQ_GIFTCD").toString()));

            sql.close();     
            sql  = new SqlWrapper();
			int i=1;
			sql.put(svc.getQuery("INS_GIFTCD"));
            sql.setString(i++, mi2.getString("CARD_NO"));
            sql.setString(i++, String.valueOf(Integer.parseInt(mi2.getString("SEQ_NO"))));
	    	sql.setString(i++, String.valueOf(Integer.parseInt(mi2.getString("CONV_POINT"))));
	    	sql.setString(i++, String.valueOf(Integer.parseInt(mi2.getString("CONV_GIFT_AMT"))));
	    	sql.setString(i++, sessionInfo.getBRCH_ID());
	    	sql.setString(i++, sessionInfo.getUSER_ID());
            sql.setString(i++, ("02"));

	    	res = update(sql);		
	    	System.out.println("SaveData" + res);
	    	if ( res != 1 ) {
	    		throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                        + "데이터 입력을 하지 못했습니다.");
	    	}
	    	
	    	 while (mi3.next()) {
            	sql.close();
            	i=1;
        	    sql.put(svc.getQuery("UPT_GIFTCD"));   
                sql.setString(i++, String.valueOf(Integer.parseInt(mi2.getString("SEQ_NO"))));
    	    	sql.setString(i++, String.valueOf(Integer.parseInt(mi3.getString("PROC_DT"))));
                sql.setString(i++, mi2.getString("CARD_NO"));
                sql.setString(i++, String.valueOf(Integer.parseInt(mi3.getString("SEQ_NO"))));

    	    	res1 = update(sql);		
    	    	System.out.println("SaveData_UPDATE" + res1);
    	    	if ( res1 != 1 ) {
    	    		throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                            + "데이터 입력을 하지 못했습니다.");
    	    	}
            }
	    	 
	    	ret += res1;
	    	
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			//if( getTrConnection() == null)
			//	end();
		}
		
        return ret;
	}	
    
    
    /**
     * <p>상품권 교환반품  - 회수처리 및 상품권상세 입력</p>
     * 
     */
    public String proCall(ActionForm form, MultiInput mi[], HttpServletRequest request) throws Exception {
        ProcedureWrapper psql = null;
        SqlWrapper sql        = null;
        Service svc           = null;
        Util util             = new Util();
        int ret = 0;
        int res = 0;
        String retMsg = "";
        
		MultiInput mi1       = mi[0];
		MultiInput mi2       = mi[1];
		//MultiInput mi3   	 = mi[2];
		MultiInput mi4   	 = mi[3];
		
        try {
     	
		    connect("pot");
		    begin();

            psql = new ProcedureWrapper();
            sql  = new SqlWrapper();
            svc = (Service) form.getService();
            
            ProcedureResultSet prs = null;
            
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
        	sql.put(svc.getQuery("GET_SALE_SLIP_NO"));  //전표번호생성
            Map map = selectMap(sql);
            
            mi2.next();          
            mi2.setString("SALE_SLIP_NO", map.get("SALE_SLIP_NO").toString());               
		   
            while (mi4.next()) {
                psql.close();
                sql.close();
                
                int i=1;
                int j=1;
                
                psql.put("MSS.PR_MGPOSTRCREATE_RETURN", 10); 
                psql.setString(i++, sessionInfo.getSTR_CD());         //1:점
                psql.setString(i++, mi4.getString("PROC_DT"));        //2:일자
                psql.setString(i++, util.jLpad(mi2.getString("SALE_SLIP_NO") ,  6));   //3:전표번호 ==> 시퀀스 오브젝트(MSS.SQ_MG_SALEMST)6자리 0으로
                psql.setString(i++, sessionInfo.getDEPT_CD());        //4:판매부서
                psql.setString(i++, "14");                            //5:판매구분01:카드포인트반품판매
                psql.setString(i++, mi4.getString("GIFTCARD_NO"));    //6:상품권번호
                psql.setString(i++, "1");                             //7:판매수량
                psql.setString(i++, sessionInfo.getUSER_ID());        //8:세션정보 사용자ID
                
                psql.registerOutParameter(i++, DataTypes.VARCHAR);    //9
                psql.registerOutParameter(i++, DataTypes.VARCHAR);    //10
                prs = updateProcedure(psql);
                
                retMsg = prs.getString(9);   
                
		        if(!retMsg.equals("0")){
		        	 throw new Exception("[USER]"+prs.getString(10));	
		        }

                /** 상품권 번호 상세 저장**/
    		    sql.put(svc.getQuery("INS_GIFTCD_DTL"));
    		    sql.setString(j++,  mi2.getString("CARD_NO"));
    		    sql.setString(j++,  mi2.getString("SEQ_NO"));
    		    sql.setString(j++,  mi4.getString("GIFTCARD_NO"));
    		    sql.setString(j++,  "Y");
    		     
    		    res = update(sql); 		    
		    }
            
//            while (mi3.next()) {
//            	sql.close();
//            	int j=1;
//    		    
//                /** 포인트 전환내역 저장**/
//    		    sql.put(svc.getQuery("INS_GIFTCD_CONV"));
//    		    sql.setString(j++,  mi2.getString("CARD_NO"));
//    		    sql.setString(j++,  mi2.getString("SEQ_NO"));
//    		    sql.setString(j++,  mi3.getString("CONV_POINT"));
//    		    sql.setString(j++,  mi3.getString("CONV_QTY"));
//    		    sql.setString(j++,  mi3.getString("CONV_GIFT_AMT"));
//    		    sql.setString(j++,  sessionInfo.getBRCH_ID());
//    		     
//    		    res = update(sql);             	
//            }
            ret = mi2.getRowNum();  
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
		    end();
        }
        return retMsg;
    }

    /**
     * <p>상품권 교환  마스터, 상품권 교환기준 마스터 조회</p>
     * 
     */
    public List[] searchMaster(ActionForm form) throws Exception {
    	List ret[] 		= null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery  = "";
        
        String strCardNo = String2.nvl(form.getParam("strCardNo"));
        
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
        
        try{       
	        connect("pot");
	       
			strQuery = svc.getQuery("SEL_RULE");
			sql.put(strQuery);
	        ret[0] = select2List(sql);
	        
			sql.close();
	        strQuery = svc.getQuery("SEL_MASTER"); 
	        sql.put(strQuery);
	        sql.setString(1, strCardNo);
			ret[1] = select2List(sql);        
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
    
    /**
     * <p>상품권 교환  금액 조회</p>
     * 
     */
	public List searchAmt(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strGiftCardNo   = String2.nvl(form.getParam("strGiftCardNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strGiftCardNo);

		strQuery = svc.getQuery("SEL_AMT") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}    
}
