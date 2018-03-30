/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.util.EtZipcode;
import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>회원정보 이행작업</p>
 * 
 * @created  on 1.0, 2010/05/25
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCtm191DAO extends AbstractDAO {

    /**
     * <p>회원정보 이행작업</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null; 
        Service svc     = null;
        
        String strSeqNoS = String2.nvl(form.getParam("strSeqNoS"));
        String strSeqNoE = String2.nvl(form.getParam("strSeqNoE"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.put(svc.getQuery("SEL_MASTER"));
        sql.setString( 1,   strSeqNoS  );
        sql.setString( 2,   strSeqNoE  );
        ret = select2List(sql);
        return ret; 
    }     
       
    /** 
     * <p>회원정보 이행작업</p>
     *  
     */
    public List searchDetail(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null; 
        Service svc     = null;

        String strSeqNoS = String2.nvl(form.getParam("strSeqNoS"));
        String strSeqNoE = String2.nvl(form.getParam("strSeqNoE"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
          
        sql.put(svc.getQuery("SEL_DETAIL")); 
        sql.setString( 1,   strSeqNoS  );
        sql.setString( 2,   strSeqNoE  );
        ret = select2List(sql);
        return ret;
    }
    
    /**
     * <p>회원정보 저장</p>
     * 
     */
    public int save(ActionForm form, MultiInput mi, String userId) throws Exception {
    	SqlWrapper sql = null;
        Service    svc = null;
        Util util = new Util();
        int ret = 0;
        int ret2 = 0;
        int res = 0;
        int i   = 0;
        
        try {
        	
            connect("pot");
            begin();
            
            sql  = new SqlWrapper();
            svc = (Service) form.getService(); 
            
            while (mi.next()) {

                String strCard    = "";
                String strCustId  = "";
                String strHhold   = "";
                
                if(mi.getString("TEMP_FLAG").equals("0")){
                    //카드번호  구하기     
                    String strQuery = " SELECT DCS.F_GET_SQ_CARD('1') CARD_NO FROM DUAL ";
                    sql.put(strQuery);
                    
                    Map map1 = selectMap(sql);            
                    strCard = (String)map1.get("CARD_NO");
                    sql.close();
                    
                    //CUST ID  구하기     
                    String strQuery2 = " SELECT DCS.F_GET_SQ_CUST CUST_ID FROM DUAL ";
                    sql.put(strQuery2);
                    
                    Map map2  = selectMap(sql);            
                    strCustId = (String)map2.get("CUST_ID");
                    sql.close();
                    
                    //HHOLD ID  구하기     
                    String strQuery3 = " SELECT DCS.F_GET_SQ_HHOLD HHOLD_ID FROM DUAL ";
                    sql.put(strQuery3);
                    
                    Map map3  = selectMap(sql);            
                    strHhold = (String)map3.get("HHOLD_ID");
                    sql.close();
                }
                
               System.out.println("HOME_ADDR1===========>"+ mi.getString("HOME_ADDR1"));;    //집주소1                   
               System.out.println("HOME_ADDR2===========>"+ mi.getString("HOME_ADDR2"));;    //집주소2   
                
                //주소정제
                addrCls( form,  mi );
                
                //전화번호분리
                toKenPhoneNumber( form, mi );

                i=1;
                sql.put(svc.getQuery("INS_TEMP")); 
                sql.setString( i++,   mi.getString("MEMBERID")      );
                sql.setString( i++,   mi.getString("MEMBERNAME")    );
                sql.setString( i++,   mi.getString("PASSWORD")      );
                sql.setString( i++,   mi.getString("SS_NO")         );
                sql.setString( i++,   mi.getString("EMAIL1")        );
                sql.setString( i++,   mi.getString("EMAIL2")        );
                sql.setString( i++,   mi.getString("BIRTH_DT")      );
                sql.setString( i++,   mi.getString("LUNAR_FLAG")    );
                sql.setString( i++,   mi.getString("HOME_ZIP_CD")   );
                sql.setString( i++,   mi.getString("HOME_ADDR1")    );
                sql.setString( i++,   mi.getString("HOME_ADDR2")    );
                sql.setString( i++,   mi.getString("REG_DATE")      );
                sql.setString( i++,   mi.getString("EMAIL_YN")      );
                sql.setString( i++,   mi.getString("HOME_PH")       );
                sql.setString( i++,   mi.getString("MOBILE_PH")     );
                sql.setString( i++,   mi.getString("HOME_ZIP_SEQ")  );
                sql.setString( i++,   mi.getString("USE_YN")        );
                sql.setString( i++,   mi.getString("MOD_DATE")      );
                sql.setString( i++,   mi.getString("CUST_FLAG")     );
                sql.setString( i++,   mi.getString("CUST_POINT")    );
                sql.setString( i++,   mi.getString("SCOMP_EMP_YN")  );
                sql.setString( i++,   mi.getString("EMP_ID")        );
                sql.setString( i++,   mi.getString("DEPT_CD")       );
                sql.setString( i++,   mi.getString("PROM_FLAG")     );
                sql.setString( i++,   mi.getString("CFM_REQNUM")    );
                sql.setString( i++,   mi.getString("CFM_IPIN")      );
                sql.setString( i++,   mi.getString("CFM_DCHECK")    );
                sql.setString( i++,   mi.getString("PROM_USER_ID")  );
                sql.setString( i++,   mi.getString("PROM_CD")       );
                sql.setString( i++,   mi.getString("CARD_ISSUE_YN") );
                sql.setString( i++,   mi.getString("SS_NO")      	);
                sql.setString( i++,   mi.getString("EMAIL1")      	);
                sql.setString( i++,   mi.getString("EMAIL2")	    );
                sql.setString( i++,   mi.getString("HOME_PH1_EN")  	);
                sql.setString( i++,   mi.getString("HOME_PH2_EN")  	);
                sql.setString( i++,   mi.getString("HOME_PH3_EN")  	);
                sql.setString( i++,   mi.getString("MOBILE_PH1_EN")	);
                sql.setString( i++,   mi.getString("MOBILE_PH2_EN")	);
                sql.setString( i++,   mi.getString("MOBILE_PH3_EN")	);
                sql.setString( i++,   mi.getString("PASSWORD")		);
                sql.setString( i++,   mi.getString("HCLS_ZIP_CD1")  ); 
                sql.setString( i++,   mi.getString("HCLS_ZIP_CD2")  );
                sql.setString( i++,   mi.getString("HCLS_ADDR1")    );
                sql.setString( i++,   mi.getString("HCLS_ADDR2")    );
                sql.setString( i++,   mi.getString("HOME_CLS_YN")   ); 
                sql.setString( i++,   mi.getString("HNEW_ZIP_CD1")  );
                sql.setString( i++,   mi.getString("HNEW_ZIP_CD2")  );
                sql.setString( i++,   mi.getString("HNEW_ADDR1")    );
                sql.setString( i++,   mi.getString("HNEW_ADDR2")    );
                sql.setString( i++,   mi.getString("HOME_NEW_YN")   );
                sql.setString( i++,   strCard                       );
                sql.setString( i++,   strCard                       );
                sql.setString( i++,   strCustId                     );
                sql.setString( i++,   mi.getString("SIDO")          );
                sql.setString( i++,   mi.getString("SIGUN")         );
                sql.setString( i++,   mi.getString("GU")            );
                sql.setString( i++,   mi.getString("YDONG")         );
                sql.setString( i++,   mi.getString("DONGRI")        );
                sql.setString( i++,   mi.getString("BUNJI_FLAG")    ); 
                sql.setString( i++,   mi.getString("BUNJI")         );
                sql.setString( i++,   mi.getString("GAJI_BUNJI")    );
                sql.setString( i++,   mi.getString("BUILD_NAME")    );
                sql.setString( i++,   mi.getString("BUILD_DONG"));
                sql.setString( i++,   mi.getString("BUILD_HO")      );
                sql.setString( i++,   mi.getString("FLOOR")         );
                sql.setString( i++,   mi.getString("MAIL_SEND_YN")  );
                sql.setString( i++,   strHhold                      );
                sql.setString( i++,   mi.getString("SEQ_NO")        );
                sql.setString( i++,   mi.getString("TEMP_FLAG"));

                res = update(sql); 
                sql.close();    
                if (res  < 0) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                            + "데이터 입력을 하지 못했습니다.");
                }else{
                	
                	sql.put(svc.getQuery("UPD_PROC_YN")); 
                	sql.setString(1,   mi.getString("SEQ_NO")  ); 
                    ret2 = update(sql);
                    sql.close();    
                        
                    if (ret2 != 1) {
                    	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
    							+ "데이터 입력을 하지 못했습니다.");
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
    
    public int totCnt(ActionForm form, MultiInput mi, String userId, int cnt,
            HttpServletRequest request, HttpServletResponse response) throws Exception{
    	
        List ret        = null; 
        SqlWrapper sql  = null; 
        Service svc     = null;
        int res         = 0;
        
        String strSeqNoS = String2.nvl(form.getParam("strSeqNoS"));
        String strSeqNoE = String2.nvl(form.getParam("strSeqNoE"));
        
        int intSeqNoS = Integer.parseInt(strSeqNoS);
        int intSeqNoE = Integer.parseInt(strSeqNoE);
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        String totCnt = "0"; 
        //총 COUNT 구하기
        String strQuery = " SELECT COUNT(*) TOT_CNT FROM DCS.DM_HPAGE_USER_TEMP2 WHERE PROC_YN IS NULL ";
        sql.put(strQuery);
        
        Map map1 = selectMap(sql);            
        totCnt = (String)map1.get("TOT_CNT");
        sql.close();
        System.out.println("totCnt====================>"+totCnt);
        System.out.println("totCnt====================>"+Integer.parseInt(totCnt)/100);
        
        for (int i=0 ; i< Integer.parseInt(totCnt)/100 + 1; i++){
        	
            intSeqNoS = intSeqNoS + 100;
            intSeqNoE = intSeqNoE + 100;
            
            sql.put(svc.getQuery("SEL_MASTER"));
            sql.setInt( 1,   intSeqNoS );
            sql.setInt( 2,   intSeqNoE );
            ret = select2List(sql);
            sql.close();
            
          // res = save( form, ret, userId);
            end();
            cnt += res; 
        }
        System.out.println("cnt====================>"+cnt);
        return cnt;
    }
    
    
    /**
     * <p>전화번호 분리작업</p>
     * 
     * @created  on 1.0, 2010/05/25
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    public void toKenPhoneNumber(ActionForm form, MultiInput mi) throws Exception {

        String strHomePh   = mi.getString("HOME_PH");  
        String[] strPh = null;

        int i = 0;
        if(!String2.nvl(strHomePh.replaceAll("-", "")).equals("") && String2.nvl(strHomePh.replaceAll("-", "")).length() > 7){
        	StringTokenizer st = new StringTokenizer(strHomePh,"-");
        	strPh = new String[st.countTokens()];
            strPh[0] = "";
            strPh[1] = "";
            strPh[2] = "";
            while(st.hasMoreTokens()){
            	strPh[i] = st.nextToken();
                i++;
            }
            
        	mi.set("HOME_PH1_EN",     strPh[0]);   
        	mi.set("HOME_PH2_EN",     strPh[1]);   
        	mi.set("HOME_PH3_EN",     strPh[2]);   
        }else{
        	mi.set("HOME_PH1_EN",     "");   
        	mi.set("HOME_PH2_EN",     "");   
        	mi.set("HOME_PH3_EN",     "");   
        }

        String strMobilePh = mi.getString("MOBILE_PH"); 
        String[] strMph = null;
     
        int j = 0;
        if(!String2.nvl(strMobilePh.replaceAll("-", "")).equals("") && String2.nvl(strMobilePh.replaceAll("-", "")).length() > 7){
            StringTokenizer st2 = new StringTokenizer(strMobilePh,"-");
            strMph = new String[st2.countTokens()];
            strMph[0]= "";
            strMph[1]= ""; 
            strMph[2]= "";
            while(st2.hasMoreTokens()){
            	strMph[j] = st2.nextToken();
                j++; 
            }

        	mi.set("MOBILE_PH1_EN",   strMph[0]);    
        	mi.set("MOBILE_PH2_EN",   strMph[1]);   
        	mi.set("MOBILE_PH3_EN",   strMph[2]);   
        }else{

        	mi.set("MOBILE_PH1_EN",   "");    
        	mi.set("MOBILE_PH2_EN",   "");   
        	mi.set("MOBILE_PH3_EN",   "");   
        }
   } 
    
    /**
     * <p>주소정제</p>
     * 
     * @created  on 1.0, 2010/05/25
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    public void addrCls(ActionForm form, MultiInput mi) throws Exception {
        EtZipcode zip = new EtZipcode();
        String returnSuccYn = "N";

        String strHomeAddr1   = mi.getString("HOME_ADDR1");    //집주소1                   
        String strHomeAddr2   = mi.getString("HOME_ADDR2");    //집주소2  

		//주소정제 솔루션
        if(!String2.nvl(strHomeAddr1).equals("") && !String2.nvl(strHomeAddr2).equals("")){
        	System.out.println("strHomeAddr1=============>"+strHomeAddr1);
        	System.out.println("strHomeAddr2=============>"+strHomeAddr2);
		    returnSuccYn = zip.putAddress(strHomeAddr1,strHomeAddr2);
        	System.out.println("returnSuccYn=============>"+returnSuccYn);
        }else{
        	returnSuccYn = "99";
        	mi.set("HCLS_ZIP_CD1",   "");            
        	mi.set("HCLS_ZIP_CD2",   "");            
        	mi.set("HCLS_ADDR1",     "");            
        	mi.set("HCLS_ADDR2",     "");            
        	                                                          
    	    mi.set("HNEW_ZIP_CD1",   "");                     
    	    mi.set("HNEW_ZIP_CD2",   "");                       
    	    mi.set("HNEW_ADDR1",     "");                
    	    mi.set("HNEW_ADDR2",     "");      
    	    mi.set("HOME_CLS_YN",    "N");                                    
   	        mi.set("HOME_NEW_YN",    "N"); 
		    mi.set("SIDO",           "");        
		    mi.set("SIGUN",          "");        
		    mi.set("GU",             "");     
		    mi.set("YDONG",          "");     
		    mi.set("DONGRI",         "");     
		    mi.set("BUNJI_FLAG",     "");      
		    mi.set("BUNJI",          "");     
		    mi.set("GAJI_BUNJI",     "");     
		    mi.set("BUILD_NAME",     "");          
		    mi.set("BUILD_DONG",     "");     
		    mi.set("BUILD_HO",       "");       
		    mi.set("FLOOR",          "");    
		    mi.set("MAIL_SEND_YN",   "");     
        }

        if(returnSuccYn.equals("Y")){
            //주소 정제 솔루션 처리 후고객 입력 주소 저장
        	mi.set("HCLS_ZIP_CD1",   zip.getRevise_Zipcode1());   /*	정제 후 우편번호1	- 구주소   */       
        	mi.set("HCLS_ZIP_CD2",   zip.getRevise_Zipcode2());   /*	정제 후 우편번호2       	*/  
        	mi.set("HCLS_ADDR1",     zip.getRevise_Addr1());      /*	정제 후 구주소1	        */       
        	mi.set("HCLS_ADDR2",     zip.getRevise_Addr2());      /*	정제 후 구주소2	        */  

    	    mi.set("HNEW_ZIP_CD1",   zip.getRevise_Zipcode1());  /*	정제 후 우편번호1 - 신주소    */                        
    	    mi.set("HNEW_ZIP_CD2",   zip.getRevise_Zipcode2());  /*	정제 후 우편번호2	         */                        
    	    mi.set("HNEW_ADDR1",     zip.getRevise_StAddr1());   /*	정제 후 새주소1	         */                   
    	    mi.set("HNEW_ADDR2",     zip.getRevise_StAddr2());   /*	정제 후 새주소2	         */                     
    	    mi.set("HOME_CLS_YN",    zip.getCln_Yn());           /*	주소클린징여부	         */                         
    	                                
    	    mi.set("HOME_NEW_YN",    zip.getAddr_Gbn());         /*	새주소, 구주소 구분zip.getAddr_Gbn()	*/

		    mi.set("SIDO",           zip.getWide_Nm());          /*	시도	                */    
		    mi.set("SIGUN",          zip.getCity_Nm());          /*	시군	                */    
		    mi.set("GU",             zip.getSection_Nm());       /*	구	                */    
		    mi.set("YDONG",          zip.getVillage_Nm());       /*	읍면	                */    
		    mi.set("DONGRI",         zip.getAddress_Nm());       /*	동리	                */      
		    mi.set("BUNJI_FLAG",     zip.getBunji_Gbn());        /*	번지 구분	            */  
		    mi.set("BUNJI",          zip.getHead_Bunji());       /*	번지	                */      
		    mi.set("GAJI_BUNJI",     zip.getGaji_Bunji());       /*	가지번지	            */  
		    mi.set("BUILD_NAME",     zip.getBuild_Nm());         /*	건물명	            */     
		    mi.set("BUILD_DONG",     zip.getBuild_Dong());       /*	건물 동	            */  
            byte[] b = zip.getBuild_Ho().getBytes(); 
            if(b.length > 10){
            	mi.set("BUILD_HO",   zip.getBuild_Ho().substring(0,10));  /*	건물 호	            */   
            }else{
                mi.set("BUILD_HO",   zip.getBuild_Ho());                  /*	건물 호	            */  
            	 
            }
		    
		  
		    mi.set("FLOOR",          zip.getBuild_Floor());      /*	건물 층	            */  
		    mi.set("MAIL_SEND_YN",   zip.getDeliv_Yn());         /*	우편물발송가능여부	*/     

        }else if(returnSuccYn.equals("N")){
System.out.println("여기????????????????????");
            //솔루션 접속 불 시	                                                          
    	    mi.set("HNEW_ZIP_CD1",    mi.getString("HOME_ZIP_CD1"));                     
    	    mi.set("HNEW_ZIP_CD2",    mi.getString("HOME_ZIP_CD2"));                       
    	    mi.set("HNEW_ADDR1",     strHomeAddr1);               
    	    mi.set("HNEW_ADDR2",     strHomeAddr2);      
    	    mi.set("HOME_CLS_YN",    "N");                                    
   	        mi.set("HOME_NEW_YN",    "N");       

		    mi.set("SIDO",           "");        
		    mi.set("SIGUN",          "");        
		    mi.set("GU",             "");     
		    mi.set("YDONG",          "");     
		    mi.set("DONGRI",         "");      
		    mi.set("BUNJI_FLAG",     "");       
		    mi.set("BUNJI",          "");     
		    mi.set("GAJI_BUNJI",     "");     
		    mi.set("BUILD_NAME",     "");         
		    mi.set("BUILD_DONG",     "");      
		    mi.set("BUILD_HO",       "");       
		    mi.set("FLOOR",          "");    
		    mi.set("MAIL_SEND_YN",   "");          
       }
   } 
    
}
