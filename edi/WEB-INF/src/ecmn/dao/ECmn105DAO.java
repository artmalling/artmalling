/*
 * Copyright (c) 2010 �븳援��썑吏�易�. All rights reserved.
 *
 * This software is the confidential and proprietary information of �븳援��썑吏�易�.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with �븳援��썑吏�易�
 */

package ecmn.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import ecom.util.Util;
/**
 * <p>�솕�썝�젙蹂댁“�쉶</p>
 * 
 * @created  on 1.0, 2011.09.29
 * @created  by 源��쑀�셿(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class ECmn105DAO extends AbstractDAO {

    /**
     * <p>留덉뒪�꽣 �궡�뿭�쓣 議고쉶�엺�떎.</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public String getMaster(ActionForm form) throws Exception {

        List list 		= null;
        SqlWrapper sql 	= null;
        Service svc 	= null;
        Util util 		= new Util();
        String rtJson 	= null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            String strCardNo		= String2.nvl(form.getParam("strCardNo"));	// 議고쉶 二쇰�쇰벑濡앸쾲�샇
            
            sql.put(svc.getQuery("SEL_CUST_INFO"));
            sql.setString(1, strCardNo);                          
            list = select2List(sql);  

            if (list.size() > 0 ) {
    			String cols= ""+
				"CUST_ID"; 
    			rtJson = util.listToJsonOBJ(list, cols);
            } else {
            	
            }
            System.out.println("################### rtJson : " + rtJson);
        } catch (Exception e) {
            throw e;
        }
        return rtJson;
    }
    
    public String getChkDup(ActionForm form) throws Exception {

        List list 		= null;
        SqlWrapper sql 	= null;
        Service svc 	= null;
        Util util 		= new Util();
        String rtJson 	= null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            String strHP1		= String2.nvl(form.getParam("strHP1"));	
            String strHP2		= String2.nvl(form.getParam("strHP2"));
            String strHP3		= String2.nvl(form.getParam("strHP3"));
            
            sql.put(svc.getQuery("SEL_DUP_CHK"));
            sql.setString(1, strHP1);
            sql.setString(2, strHP2);
            sql.setString(3, strHP3);
            
            list = select2List(sql);  

            if (list.size() > 0 ) {
    			String cols= ""+
				"CUST_NAME,ENTR_DT"; 
    			rtJson = util.listToJsonOBJ(list, cols);
            } else {
            	
            }
            System.out.println("################### rtJson : " + rtJson);
        } catch (Exception e) {
            throw e;
        }
        return rtJson;
    }
    
    public String getChkSced(ActionForm form) throws Exception {

        List list 		= null;
        SqlWrapper sql 	= null;
        Service svc 	= null;
        Util util 		= new Util();
        String rtJson 	= null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            String strHP1		= String2.nvl(form.getParam("strHP1"));	
            String strHP2		= String2.nvl(form.getParam("strHP2"));
            String strHP3		= String2.nvl(form.getParam("strHP3"));
            
            sql.put(svc.getQuery("SEL_SCED_CHK"));
            sql.setString(1, strHP1);
            sql.setString(2, strHP2);
            sql.setString(3, strHP3);
            
            list = select2List(sql);  

            if (list.size() > 0 ) {
    			String cols= ""+
				"CUST_NAME,ENTR_DT"; 
    			rtJson = util.listToJsonOBJ(list, cols);
            } else {
            	
            }
            System.out.println("################### rtJson : " + rtJson);
        } catch (Exception e) {
            throw e;
        }
        return rtJson;
    }
    
    public String sendSMS(ActionForm form) throws Exception {

        List list 		= null;
        SqlWrapper sql 	= null;
        Service svc 	= null;
        Util util 		= new Util();
        String rtJson 	= null;
        String strSmsCd = null;
        ProcedureWrapper psql = null;
        String ret2 = null;
        
        psql = new ProcedureWrapper();
		int i=1; 
		ProcedureResultSet prs = null;
        
        String strHP1		= String2.nvl(form.getParam("strHP1"));	
        String strHP2		= String2.nvl(form.getParam("strHP2"));
        String strHP3		= String2.nvl(form.getParam("strHP3"));
        String strUserId		= String2.nvl(form.getParam("strUserId"));
        String strSendGb		= String2.nvl(form.getParam("strSendGb"));

        
        String strHP  = strHP1 + strHP2 + strHP3 ;
        
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            
            
            sql.put(svc.getQuery("SEL_SMS_CD"));
       
            
            list = select2List(sql);  

            if (list.size() > 0 ) {
    			String cols= ""+
				"SMS_CD"; 
    			rtJson = util.listToJsonOBJ(list, cols);
            } else {
            	
            }
            System.out.println("################### rtJson : " + rtJson);
            
            strSmsCd = rtJson.toString();
            
            strSmsCd = strSmsCd.substring(12, 18);
            
            System.out.println(strSmsCd);
 			
            begin();
            
            if (strSendGb.equals("SMS_ARTBAT"))		// 배치용 서비스 구분자 
            	psql.put("DPS.PR_MEMBSMS_NEW", 5);
            else
            	psql.put("DPS.PR_MEMBSMS", 5);		// 일반 발솔 서비스
            
			psql.setString(i++,  strHP   );
			psql.setString(i++,  strSmsCd     );
			psql.setString(i++,  strUserId     );
	        psql.registerOutParameter(i++, DataTypes.INTEGER);
	        psql.registerOutParameter(i++, DataTypes.VARCHAR);
	        
	        prs = updateProcedure(psql);
	        
	        ret2 = prs.getString(5);
	        
	        System.out.println("################### return : " + ret2);
 			
	        commit();

        } catch (Exception e) {
            rollback();
            throw e;
        }
    	 finally {
    		 end();
    	 }
        return rtJson;
    }
    
    
    
    
    
    
    
    
    /**
     * <p>�쉶�썝�젙蹂대�� �엫�떆���옣�븳�떎.</p>
     * 
     */
    public String saveSSNO(ActionForm form, String userId) throws Exception {
    	
    	int ret 		= 0;
    	SqlWrapper sql 	= null;
    	Service svc 	= null;
    	Util util 		= new Util();
    	String rtString 	= null;
    	ProcedureWrapper psql = null;
    	
    	try {
    		
    		connect("pot");
    		begin();

    		
            int i=1;        
            ProcedureResultSet prs = null;
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		psql = new ProcedureWrapper();
    		
    		
    	
    		   String strCardNo    =     String2.nvl(form.getParam("strCardNo"));
			   String strCardPw    =     String2.nvl(form.getParam("strCardPw"));
			   String strCustNm    =     String2.nvl(form.getParam("strCustNm"));
			   String strBrchCd    =     String2.nvl(form.getParam("strBrchCd"));
			   String strBirthDt   =     String2.nvl(form.getParam("strBirthDt")).replaceAll("/", "");
			   String strHP1       =     String2.nvl(form.getParam("strHP1"));
			   String strHP2       =     String2.nvl(form.getParam("strHP2"));
			   String strHP3       =     String2.nvl(form.getParam("strHP3"));
			   String strPostNo    =     String2.nvl(form.getParam("strPostNo"));
			   
			   String strHaddr1    =     String2.nvl(form.getParam("strHaddr1"));
			   String strHaddr2    =     String2.nvl(form.getParam("strHaddr2"));
			   String strHaddrO    =     String2.nvl(form.getParam("strHaddrO"));
			   String strAllowDt1  =     String2.nvl(form.getParam("strAllowDt1")).replaceAll("/", "");
			   String strAllowDt2  =     String2.nvl(form.getParam("strAllowDt2")).replaceAll("/", "");
			   String strAllowDt3  =     String2.nvl(form.getParam("strAllowDt3")).replaceAll("/", "");
			   String strAllowDt4  =     String2.nvl(form.getParam("strAllowDt4")).replaceAll("/", "");
			   
			   String strBirthGb   =     String2.nvl(form.getParam("strBirthGb"));
			   String strSex       =     String2.nvl(form.getParam("strSex"));
			   String strSmsYn     =     String2.nvl(form.getParam("strSmsYn"));
			   String strPostHo    =     String2.nvl(form.getParam("strPostHo"));
			   String strDi        =     String2.nvl(form.getParam("strDi"));
			   String strAllow1    =     String2.nvl(form.getParam("strAllow1"));
			   String strAllow2    =     String2.nvl(form.getParam("strAllow2"));
			   String strAllow3    =     String2.nvl(form.getParam("strAllow3"));
			   String strAllow4    =     String2.nvl(form.getParam("strAllow4"));
			   
			   String strEntrDt    =     String2.nvl(form.getParam("strEntrDt")).replaceAll("/", "");
			   String strStrCd    =     String2.nvl(form.getParam("strStrCd"));
			   
			   
			   String strSsNo	   =     strBirthDt.substring(2,8);
    		
			   psql.put("DCS.PR_PCUST_INSERT_BACKUP", 170);
			   
			   psql.registerOutParameter(i++, DataTypes.VARCHAR);
               psql.registerOutParameter(i++, DataTypes.VARCHAR);
               psql.setString(i++,  strSsNo                );    //주민번호
               psql.setString(i++,  strCustNm              );    //회원명
               psql.setString(i++,  strCardPw           );    //카드비밀번호 //암호화 ###미처리
               psql.setString(i++,  strPostNo          );    //우편번호1
               psql.setString(i++,  strPostNo          );    //우편번호2
               psql.setString(i++,  strHaddrO           );    //집주소1    -- 고객입력 주소(주소정제솔루션 처리 후)
               psql.setString(i++,  null           );    //집주소2    -- 고객입력 주소(주소정제솔루션 처리 후)
               psql.setString(i++,  "Y"          );    //클랜징미적용요청여부
               
               psql.setString(i++,  "N"           );    //클렌징 여부
               psql.setString(i++,  null             );    //자택전화번호1 //암호화
               psql.setString(i++,  null             );    //자택전화번호2 //암호화 
               psql.setString(i++,  null             );    //자택전화번호3 //암호화 
               psql.setString(i++,  strHP1           );    //휴대폰1 //암호화 
               psql.setString(i++,  strHP2           );    //휴대폰2 //암호화 
               psql.setString(i++,  strHP3           );    //휴대폰3 //암호화 
               psql.setString(i++,  null              );    //이메일1 //암호화 
               psql.setString(i++,  null              );    //이메일2 //암호화 
               psql.setString(i++,  "N"             );    //이메일수신여부     ---------20
               
               psql.setString(i++,  strEntrDt        );    //이메일등록일자
               psql.setString(i++,  null               );    //결혼여부
               psql.setString(i++,  null               );    //결혼기념일
               psql.setString(i++,  strBirthDt             );    //본인생일
               psql.setString(i++,  strBirthGb           );    //본인생일양음력
               psql.setString(i++,  strSmsYn               );    //SMS수신여부
               psql.setString(i++,  strEntrDt          );    //sms동의일자
               psql.setString(i++,  strPostHo           );    //우편물수신처코드
               psql.setString(i++,  null              );    //사무실명
               psql.setString(i++,  null             );    //사무실전화번호1   ---------30
               
               psql.setString(i++,  null             );    //사무실전화번호2
               psql.setString(i++,  null             );    //사무실전화번호3
               psql.setString(i++,  null            );    //사무실팩스 1
               psql.setString(i++,  null            );    //사무실팩스2 
               psql.setString(i++,  null            );    //사무실팩스3
               psql.setString(i++,  null         );    //직장전화내선번호
               psql.setString(i++,  null          );    //사무실우편번호1
               psql.setString(i++,  null          );    //사무실우편번호2
               psql.setString(i++,  null           );    //사무실주소1   -- 고객입력 주소(주소정제솔루션 처리 후)
               psql.setString(i++,  null           );    //사무실주소2   -- 고객입력 주소(주소정제솔루션 처리 후)
               
               psql.setString(i++,  null           );    //사무실주소 클랜징여부
               psql.setString(i++,  null          );    //계열사직원여부
               psql.setString(i++,  null            );    //자녀수
               psql.setString(i++,  null           );    //wedid
               psql.setString(i++,  null           );    //wedpass
               psql.setString(i++,  "N"          );    //실명인증여부
               psql.setString(i++,  null                );    //아이핀가입
               psql.setString(i++,  null           );    //탈퇴요청일
               psql.setString(i++,  null        );    //탈퇴접수형태구분
               psql.setString(i++,  null          );    //탈퇴처리일자       ---------50
               
               psql.setString(i++,  null             );    //외국인여부
               psql.setString(i++,  "0"        );    //회원상태
               psql.setString(i++,  userId               );    //등록자아이디
               psql.setString(i++,  strBrchCd              );    //가맹점아이디
               psql.setString(i++,  "12"            );    //카드타입 P_CARD_TYPE
               psql.setString(i++,  strHaddr1           );    //P_HORI_ADDR1   고객입력 주소(주소정세솔루션 처리 전)
               psql.setString(i++,  strHaddr2           );    //P_HORI_ADDR2   고객입력 주소(주소정세솔루션 처리 전)
               psql.setString(i++,  strHaddrO           );    //P_OORI_ADDR1   고객입력 주소(주소정세솔루션 처리 전)
               psql.setString(i++,  null           );    //P_OORI_ADDR2   고객입력 주소(주소정세솔루션 처리 전)
               psql.setString(i++,  "4"         );    //주거형태          ---------60      
               
               psql.setString(i++,  "9"         );    //주거구분
               psql.setString(i++,  null         );    //자동차보유                              
               psql.setString(i++,  "N"      );    //선호부문1                              
               psql.setString(i++,  "N"      );    //선호부문2                              
               psql.setString(i++,  "N"      );    //선호부문3                              
               psql.setString(i++,  "N"      );    //선호부문4   
               psql.setString(i++,  "N"      );    //선호부문5   
               psql.setString(i++,  "0"         );    //월 평균소득                             
               psql.setString(i++,  "0"         );    //가족수                                
               psql.setString(i++,  null          );    //부서          ---------70        
               
               psql.setString(i++,  null          );    //직위               
               psql.setString(i++,  null       );    //직위-기타       
               psql.setString(i++,  null         );    //대리인성명                              
               psql.setString(i++,  null         );    //대리인주민번호                            
               psql.setString(i++,  null     );    //관계                                 
               psql.setString(i++,  null          );    //대리인전화번호1                           
               psql.setString(i++,  null          );    //대리인전화번호2                           
               psql.setString(i++,  null          );    //대리인전화번호3                           
               psql.setString(i++,  null        );    //법정대리인
               psql.setString(i++,  strAllow1       );    //정보제공 동의여부             ---------80                  
               
               psql.setString(i++,  strAllowDt1       );    //정보제공 동의일자                          
               psql.setString(i++,  strCustNm     );    //정보제공 동의성명    
               psql.setString(i++,  strAllow2       );    //개인정보 제3자 제공 동의여부                            
               psql.setString(i++,  strAllowDt2       );    //개인정보 제3자 제공 동의일자                   
               psql.setString(i++,  strCustNm     );    //개인정보 제3자 제공 동의자     
               psql.setString(i++,  strAllow3       );    //정보제공 동의여부                               
               psql.setString(i++,  strAllowDt3       );    //정보제공 동의일자                          
               psql.setString(i++,  strCustNm     );    //정보제공 동의성명    
               psql.setString(i++,  strAllow4       );    //개인정보 제3자 제공 동의여부                            
               psql.setString(i++,  strAllowDt4       );    //개인정보 제3자 제공 동의일자  ---90                  
               
               psql.setString(i++,  strCustNm     );    //개인정보 제3자 제공 동의자                 
               psql.setString(i++,  strEntrDt            );    //가입일자                               
               psql.setString(i++,  "9"           );    //신분증확인                              
               psql.setString(i++,  null          );    //발행기관                               
               psql.setString(i++,  null           );    //발행일자   
               psql.setString(i++,  null                 );    //UNDER_14_YN             
               psql.setString(i++,  null                 );    //PARENT_WEB_ID      
               psql.setString(i++,  null                 );    //PARENT_APPR_DATE   
               psql.setString(i++,  null                 );    //ON_CARD_YN         
               psql.setString(i++,  null                 );    //MOBILE_CARD_YN       --100
               
               psql.setString(i++,  null                 );    //ON_TERMS1_YN    
               psql.setString(i++,  null                 );    //ON_TERMS1_DATE  
               psql.setString(i++,  null                 );    //ON_TERMS2_YN    
               psql.setString(i++,  null                 );    //ON_TERMS2_DATE  
               psql.setString(i++,  null                 );    //ON_TERMS3_YN    
               psql.setString(i++,  null                 );    //ON_TERMS3_DATE       
               psql.setString(i++,  null                 );    //ON_TERMS4_YN    
               psql.setString(i++,  null                 );    //ON_TERMS4_DATE  
               psql.setString(i++,  null                 );    //ON_TERMS5_YN    
               psql.setString(i++,  null                 );    //ON_TERMS5_DATE        ---110      
               
               psql.setString(i++,  strPostNo        );    //HNEW_ZIP_CD1   -- 자택 새주소     
               psql.setString(i++,  strPostNo        );    //HNEW_ZIP_CD2                 
               psql.setString(i++,  strHaddr1         );    //HNEW_ADDR1                   
               psql.setString(i++,  strHaddr2         );    //HNEW_ADDR2                   
               psql.setString(i++,  "Y"         );    //HOME_NEW_YN                  
               psql.setString(i++,  strPostNo        );    //ONEW_ZIP_CD1   -- 직장 새주소     
               psql.setString(i++,  strPostNo        );    //ONEW_ZIP_CD2                 
               psql.setString(i++,  strHaddr1         );    //ONEW_ADDR1                   
               psql.setString(i++,  strHaddr2         );    //ONEW_ADDR2                     
               psql.setString(i++,  null         );    //OFFI_NEW_YN   -- 120
               
               psql.setString(i++,  null         );    //HORI_NEW_YN  
               psql.setString(i++,  strPostHo        );    //HORI_ZIP_CD1      -- 고객입력 우편번호                                  
               psql.setString(i++,  null        );    //HORI_ZIP_CD2                      
               psql.setString(i++,  null         );    //OORI_NEW_YN                       
               psql.setString(i++,  null        );    //OORI_ZIP_CD1                      
               psql.setString(i++,  null        );    //OORI_ZIP_CD2       
               psql.setString(i++,  null          );    //HOME_SIDO         -- 주소 세부항목      
               psql.setString(i++,  null         );    //HOME_SIGUN                        
               psql.setString(i++,  null            );    //HOME_GU                           
               psql.setString(i++,  null         );    //HOME_YDONG       ---130                 
               
               psql.setString(i++,  null        );    //HOME_DONGRI                       
               psql.setString(i++,  null     );    //HOME_BUNJI_FLAG                   
               psql.setString(i++,  null         );    //HOME_BUNJI                        
               psql.setString(i++,  null     );    //HOME_GAJI_BUNJI                   
               psql.setString(i++,  null     );    //HOME_BUILD_NAME                   
               psql.setString(i++,  null     );    //HOME_BUILD_DONG                   
               psql.setString(i++,  null       );    //HOME_BUILD_HO                     
               psql.setString(i++,  null         );    //HOME_FLOOR                        
               psql.setString(i++,  null        );    //HOME_MAIL_YN                      
               psql.setString(i++,  null          );    //OFFI_SIDO         -- 주소 세부항목    140   
               
               psql.setString(i++,  null         );    //OFFI_SIGUN                        
               psql.setString(i++,  null            );    //OFFI_GU                           
               psql.setString(i++,  null         );    //OFFI_YDONG                        
               psql.setString(i++,  null        );    //OFFI_DONGRI                       
               psql.setString(i++,  null     );    //OFFI_BUNJI_FLAG                   
               psql.setString(i++,  null         );    //OFFI_BUNJI                            
               psql.setString(i++,  null     );    //OFFI_GAJI_BUNJI                   
               psql.setString(i++,  null     );    //OFFI_BUILD_NAME                   
               psql.setString(i++,  null     );    //OFFI_BUILD_DONG                   
               psql.setString(i++,  null       );    //OFFI_BUILD_HO       --150              
               
               psql.setString(i++,  null         );    //OFFI_FLOOR                        
               psql.setString(i++,  null        );    //OFFI_MAIL_YN   
               psql.setString(i++,  strSex             );    //SEX_CD
		       psql.setString(i++, strCardNo);     //P_CARD_NO
		       psql.setString(i++, "U");           //기명:I 무기명:U 구분값     
		       psql.setString(i++,  "100"             ); 
		       psql.setString(i++,  "00"             );             
		       psql.setString(i++,  userId           );    //ENTR_PBN                        
		       psql.setString(i++,  "21"         );    //CUST_GRADE      
		       psql.setString(i++,  "10"          );    //CUST_TYPE      --160 
		       
		       psql.setString(i++,  "1"          );    //ISSUE_CNT           
		       psql.setString(i++,  "N"			  );    //TM여부
		       psql.setString(i++,  "01"		  );    //통신사
		       psql.setString(i++,  strDi				  );    //DI
		       psql.setString(i++,  null				  );    //CI       
		       psql.setString(i++,  null			  );    //가입채널
		       psql.setString(i++,  strStrCd			  );    //가입점
		       psql.setString(i++,  null				  );    //적요
		       psql.registerOutParameter(i++, DataTypes.INTEGER);
		       psql.registerOutParameter(i++, DataTypes.VARCHAR);        // ---------170
               
		       
		       System.out.println("START");
	            System.out.println("psql" + psql);
	            
	            prs = updateProcedure(psql);
	            
	            String prsRet = prs.getString(169);  // 성공/실패 구분
	            String prsRet2 = prs.getString(170); // 메세지 
	            
	            System.out.println("prsRet" + prsRet); 
	            
	            if ( !prsRet.equals("0")) {
	            	rtString = "[{'CD':'F','MSG':'"+prsRet2+"'}]";
	            	rollback();
	            }
	            else {
	            	
	            	String strCustId  = prs.getString(1);
		            String strHholdId = prs.getString(2);
		            System.out.println("strCustId: " + strCustId + "/ strHholdId: " + strHholdId);
		            System.out.println("################### rtJson : " + rtString);
		            String Msg = strCustNm + " 고객님의 등록이 완료되었습니다. <br> *회원번호 : " + strCustId;
		            rtString = "[{'CD':'T','MSG':'"+Msg+"'}]";
		            commit();
	            }
	            
		}catch(Exception e){
			System.out.println("######################## DAO e : " + e);
			rollback();
			throw e;
			
		} finally {
			end();
		}
    	return rtString;
    }
}


