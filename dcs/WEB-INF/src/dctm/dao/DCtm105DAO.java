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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gauce.GauceDataSet;

import common.util.EtZipcode;
import common.util.Util;
import common.vo.SessionInfo;

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
 * <p>법인회원가입신청서등록 </p>
 * @created  on 1.0, 2010/2/25
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm105DAO extends AbstractDAO {

    /**
     * <p>법인회원정보 저장 - 프로시져 .</p>
     * 
     * @created  on 1.0, 2010/01/25
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */

	public String saveData(ActionForm form, GauceDataSet dSet, HttpServletRequest request, HttpServletResponse response,  MultiInput mi) throws Exception {
        String ret      = "";
        SqlWrapper sql  = null;
        ProcedureWrapper psql = null;
        Service svc     = null;
        Util util       = new Util();
        String aftData  = "";   
        
        String toDate     = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
        String strChksave = String2.nvl(form.getParam("strChksave"));
        String strUpdate  = String2.nvl(form.getParam("strUpdate"));
        
        try {
        	connect("pot");
    	    begin();
            svc  = (Service)form.getService();
            psql = new ProcedureWrapper();
            int res = 0;
            int i=1;          
            String strQuery = "";

            ProcedureResultSet prs = null;
            
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");        

            String strUserId = sessionInfo.getUSER_ID();    
            String strBrchId = sessionInfo.getBRCH_ID();  
            
            if(strChksave.equals("U")){
              psql.put("DCS.PR_CCUST_UPDATE", 60);
            }else{
              psql.put("DCS.PR_CCUST_INSERT", 59);     
            }

            String strCustId       = mi.getString("CUST_ID");
            String strHholdId      = mi.getString("HHOLD_ID");                      //세대ID             
            String strSsNo         = mi.getString("SS_NO");      //사업자번호.
            String strCustNm       = mi.getString("CUST_NAME");                     //사업자명
            String strCardPwdNo    = mi.getString("CARD_PWD_NO");                   //카드비밀번호 //암호화 ###미처리 
            if(!strCardPwdNo.equals("****") && !String2.nvl(strCardPwdNo).equals("")){  //'****'가 아닐경우 암호화처리 
            	//strCardPwdNo = strCardPwdNo;
            }
            String strRepName      = mi.getString("REP_NAME");                      //대표자명
            String strHomePh1      = mi.getString("HOME_PH1");   //대표번호1 //암호화
            String strHomePh2      = mi.getString("HOME_PH2");   //대표번호2 //암호화 
            String strHomePh3      = mi.getString("HOME_PH3");   //대표번호3 //암호화 
            String strHomeZipCd1   = mi.getString("HOME_ZIP_CD1");                  //우편번호1
            String strHomeZipCd2   = mi.getString("HOME_ZIP_CD2");                  //우편번호2
            String strHomeAddr1    = mi.getString("HOME_ADDR1");                    //집주소1
            String strHomeAddr2    = mi.getString("HOME_ADDR2");                    //집주소2
            String strHomeClsYn    = mi.getString("HOME_CLS_YN");                   //클린징여부 
            String strEmail1       = mi.getString("EMAIL1");     //이메일1 //암호화 
            String strEmail2       = mi.getString("EMAIL2");     //이메일2 //암호화 
            String strEmailYn      = mi.getString("EMAIL_YN");                      //이메일수신여부            
            String strEmailAgreeDt = mi.getString("EMAIL_AGREE_DT");                //이메일동의일자
            String strSmsYn        = mi.getString("SMS_YN");                        //SMS수신여부
            String strSmsAgreeDt   = mi.getString("SMS_AGREE_DT");                  //sms동의일자
            String strPostRcvCd    = mi.getString("POST_RCV_CD");                   //우편물수신처코드
            String strOffiNm       = mi.getString("OFFI_NM");                       //사무실명
            String strOffiPh1      = mi.getString("OFFI_PH1");                      //사무실전화번호1
            String strOffiPh2      = mi.getString("OFFI_PH2");                      //사무실전화번호2
            String strOffiPh3      = mi.getString("OFFI_PH3");                      //사무실전화번호3            
            String strOffiInterPh  = mi.getString("OFFI_INTER_PH");                 //OFFI_INTER_PH
            String strOffiFax1     = mi.getString("OFFI_FAX1");                     //사무실팩스 1
            String strOffiFax2     = mi.getString("OFFI_FAX2");                     //사무실팩스2 
            String strOffiFax3     = mi.getString("OFFI_FAX3");                     //사무실팩스3            
            String strCardCnt      = mi.getString("CARD_COUNT");  
            
            String strHoriZipCd1    = mi.getString("HORI_ZIP_CD1");                 //고객입력 우편번호  1  
            String strHoriZipCd2    = mi.getString("HORI_ZIP_CD2");                 //고객입력 우편번호 2   
            String strHOriAddr1     = mi.getString("HORI_ADDR1");                   //고객입력 주소(주소정세솔루션 처리 전) 
            String strHOriAddr2     = mi.getString("HORI_ADDR2");                   //고객입력 주소(주소정세솔루션 처리 전) 
            String strHoriNewYn     = mi.getString("HORI_NEW_YN");                                                                           
            String strHnewZipCd1    = mi.getString("HNEW_ZIP_CD1");                 //정제 후 우편번호1    
            String strHnewZipCd2    = mi.getString("HNEW_ZIP_CD2");                 //정제 후 우편번호2	 
            String strHnewAddr1     = mi.getString("HNEW_ADDR1");                   //정제 후 새주소1	 
            String strHnewAddr2     = mi.getString("HNEW_ADDR2");                   //정제 후 새주소2	 
            String strHomeNewYn     = mi.getString("HOME_NEW_YN");                  //새주소, 구주소 구분    
            String strHomeSido      = mi.getString("HOME_SIDO");                    //시도	         
            String strHomeSiGun     = mi.getString("HOME_SIGUN"); 	                //시군	         
            String strHomeGu        = mi.getString("HOME_GU");                      //구	         
            String strHomeYdong     = mi.getString("HOME_YDONG");                   //읍면	         
            String strHomeDongri    = mi.getString("HOME_DONGRI");                  //동리	         
            String strHomeBunjiFlag = mi.getString("HOME_BUNJI_FLAG");              //번지 구분	     
            String strHomeBunji     = mi.getString("HOME_BUNJI");                   //번지	         
            String strHomeGajiBunji = mi.getString("HOME_GAJI_BUNJI");              //가지번지	         
            String strHomeBuildName = mi.getString("HOME_BUILD_NAME");              //건물명	         
            String strHomeBuildDong = mi.getString("HOME_BUILD_DONG");              //건물 동	         
            String strHomeBuildHo   = mi.getString("HOME_BUILD_HO");                //건물 호	         
            String strHomeFloor     = mi.getString("HOME_FLOOR");                   //건물 층	         
            String strHomeMailYn    = mi.getString("HOME_MAIL_YN");                 //우편물발송가능여부     
        	String strCustGrade     = mi.getString("CUST_GRADE");                   //회원등급 기본 - "21";
        	String strVipFlag       = mi.getString("VIP_FLAG");                     //VIP 등록구분
        	String strCompPersFlag  = "C";                                          //법인 - C , 단체 - G
        	System.out.println(111);
        	String strPoCardPrefix  = mi.getString("POCARD_PREFIX");                //패밀리카드구분
        	System.out.println(strPoCardPrefix+"strPoCardPrefix");
        	if(mi.getString("SS_NO").substring(0,1).equals("B")){
        		strCompPersFlag = "G";
        	}
        	
            if(strChksave.equals("U")){
            	psql.setString(i++, strCustId      );               //회원ID.
            	psql.setString(i++, strHholdId     );               //세대ID    
            }else{
            	psql.registerOutParameter(i++, DataTypes.VARCHAR);  // 회원ID. 
            	psql.registerOutParameter(i++, DataTypes.VARCHAR);  // 세대ID. 
            }
                    
            psql.setString(i++, strCompPersFlag  );     //사업자번호.
            psql.setString(i++, strSsNo          );     //사업자번호.
            psql.setString(i++, strCustNm        );     //사업자명
            psql.setString(i++, strCardPwdNo     );     //카드비밀번호 //암호화 ###
            psql.setString(i++, strRepName       );     //대표자명
            psql.setString(i++, strHomePh1       );     //대표번호1 //암호화
            psql.setString(i++, strHomePh2       );     //대표번호2 //암호화 
            psql.setString(i++, strHomePh3       );     //대표번호3 //암호화 
            psql.setString(i++, strHomeZipCd1    );     //우편번호1
            psql.setString(i++, strHomeZipCd2    );     //우편번호2
            psql.setString(i++, strHomeAddr1     );     //집주소1
            psql.setString(i++, strHomeAddr2     );     //집주소2
            psql.setString(i++, strHomeClsYn     );
            psql.setString(i++, strEmail1        );     //이메일1 //암호화 
            psql.setString(i++, strEmail2        );     //이메일2 //암호화 
            psql.setString(i++, strEmailYn       );     //이메일수신여부            
            psql.setString(i++, strEmailAgreeDt  );     //이메일동의일자
            psql.setString(i++, strSmsYn         );     //SMS수신여부
            psql.setString(i++, strSmsAgreeDt    );     //sms동의일자
            psql.setString(i++, strPostRcvCd     );     //우편물수신처코드
            psql.setString(i++, strOffiNm        );     //사무실명 
            psql.setString(i++, strOffiPh1       );     //사무실전화번호1
            psql.setString(i++, strOffiPh2       );     //사무실전화번호2
            psql.setString(i++, strOffiPh3       );     //사무실전화번호3            
            psql.setString(i++, strOffiInterPh   );     //OFFI_INTER_PH
            psql.setString(i++, strOffiFax1      );     //사무실팩스 1
            psql.setString(i++, strOffiFax2      );     //사무실팩스2 
            psql.setString(i++, strOffiFax3      );     //사무실팩스3    
                                                 
            psql.setString(i++, strUserId        );     //등록자아이디
            psql.setString(i++, strBrchId        );     //가맹점아이디
            psql.setString(i++, "11");                  //카드타입 P_CARD_TYPE

            psql.setString(i++, strHoriNewYn     );     //신/구 주소구분
            psql.setString(i++, strHoriZipCd1    );    
            psql.setString(i++, strHoriZipCd2    );   
            psql.setString(i++, strHOriAddr1     );    //고객입력 주소(주소정세솔루션 처리 전) 
            psql.setString(i++, strHOriAddr2     );    //고객입력 주소(주소정세솔루션 처리 전)
            psql.setString(i++, strHnewZipCd1    );    //새주소
            psql.setString(i++, strHnewZipCd2    );     
            psql.setString(i++, strHnewAddr1     );    
            psql.setString(i++, strHnewAddr2     );   
            psql.setString(i++, strHomeNewYn     );  
            psql.setString(i++, strHomeSido      );    //HOME_SIDO         -- 주소 세부항목      
            psql.setString(i++, strHomeSiGun     );    //HOME_SIGUN                        
            psql.setString(i++, strHomeGu        );    //HOME_GU                           
            psql.setString(i++, strHomeYdong     );    //HOME_YDONG                        
            psql.setString(i++, strHomeDongri    );    //HOME_DONGRI                       
            psql.setString(i++, strHomeBunjiFlag );    //HOME_BUNJI_FLAG                   
            psql.setString(i++, strHomeBunji     );    //HOME_BUNJI                        
            psql.setString(i++, strHomeGajiBunji );    //HOME_GAJI_BUNJI                   
            psql.setString(i++, strHomeBuildName );    //HOME_BUILD_NAME                   
            psql.setString(i++, strHomeBuildDong );    //HOME_BUILD_DONG                   
            psql.setString(i++, strHomeBuildHo   );    //HOME_BUILD_HO                     
            psql.setString(i++, strHomeFloor     );    //HOME_FLOOR                        
            psql.setString(i++, strHomeMailYn    );    //HOME_MAIL_YN                   
            System.out.println(111);
            psql.setString(i++, strCardCnt       );    //카드발급수량
            
            if(strChksave.equals("U")&& strUpdate.equals("N")){                    
                psql.setString(i++, "Y");              // P_CARD_ISSUE_YN 카드발급 여부 : 등록화면에서는 'Y', 조회/수정화면에서는 'N'   ※ 등록기능에 추가된 항목
            }else if(strChksave.equals("U")){
            	psql.setString(i++, "N");  
            }
            System.out.println(2222);
            psql.registerOutParameter(i++, DataTypes.INTEGER);
            psql.registerOutParameter(i++, DataTypes.VARCHAR);
            
            prs = updateProcedure(psql);
            
            String prsRet = prs.getString(58); 
            if(strChksave.equals("U")){
            	prsRet = prs.getString(59);
            }else{
                dSet.getDataRow(0).setString(0,  prs.getString(1));
                dSet.getDataRow(0).setString(1,  prs.getString(2));
            } 
            strCustId  = dSet.getDataRow(0).getColumnValue(0).toString();
            strHholdId = dSet.getDataRow(0).getColumnValue(1).toString();
            if ( !prsRet.equals("0")) {
            	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
            }else{  
            
                //회원등급 저장
                this.cardSave (form, dSet, request, response, mi, strCustGrade, strVipFlag, strPoCardPrefix);
            
                aftData = "CUST_ID=["        + strCustId       + "],"     //회원ID.                                                                                                                               
                        + "HHOLD_ID=["       + strHholdId      + "],"     //세대ID     
                        + "COMP_PERS_FLAG=[" + strCompPersFlag + "],"     //개인/법인/단체 구분         
                        + "SS_NO=["          + strSsNo         + "],"     //사업자번호.                                        
                        + "CUST_NAME=["      + strCustNm       + "],"     //사업자명                            
                        + "CARD_PWD_NO=["    + strCardPwdNo    + "],"     //카드비밀번호 //암호화 ###                
                        + "REP_NAME=["       + strRepName      + "],"     //대표자명                            
                        + "HOME_PH1=["       + strHomePh1      + "],"     //대표번호1 //암호화                     
                        + "HOME_PH2=["       + strHomePh2      + "],"     //대표번호2 //암호화                     
                        + "HOME_PH3=["       + strHomePh3      + "],"     //대표번호3 //암호화                     
                        + "HOME_ZIP_CD1=["   + strHomeZipCd1   + "],"     //우편번호1                           
                        + "HOME_ZIP_CD2=["   + strHomeZipCd2   + "],"     //우편번호2                                                 
                        + "HOME_ADDR1=["     + strHomeAddr1    + "],"     //집주소1                            
                        + "HOME_ADDR2=["     + strHomeAddr2    + "],"     //집주소2                            
                        + "HOME_CLS_YN=["    + strHomeClsYn    + "],"                                       
                        + "EMAIL1=["         + strEmail1       + "],"     //이메일1 //암호화                      
                        + "EMAIL2=["         + strEmail2       + "],"     //이메일2 //암호화                      
                        + "EMAIL_YN=["       + strEmailYn      + "],"     //이메일수신여부                         
                        + "EMAIL_AGREE_DT=[" + strEmailAgreeDt + "],"     //이메일동의일자                         
                        + "SMS_YN=["         + strSmsYn        + "],"     //SMS수신여부                         
                        + "SMS_AGREE_DT=["   + strSmsAgreeDt   + "],"     //sms동의일자                         
                        + "POST_RCV_CD=["    + strPostRcvCd    + "],"     //우편물수신처코드                                    
                        + "OFFI_NM=["        + strOffiNm       + "],"     //사무실명                            
                        + "OFFI_PH1=["       + strOffiPh1      + "],"     //사무실전화번호1                        
                        + "OFFI_PH2=["       + strOffiPh2      + "],"     //사무실전화번호2                        
    		            + "OFFI_PH3=["       + strOffiPh3      + "],"     //사무실전화번호3                
                        + "OFFI_INTER_PH=["  + strOffiInterPh  + "],"     //OFFI_INTER_PH                   
                        + "OFFI_FAX1A=["     + strOffiFax1     + "],"     //사무실팩스 1                         
                        + "OFFI_FAX2=["      + strOffiFax2     + "],"     //사무실팩스2                          
                        + "OFFI_FAX3=["      + strOffiFax3     + "],"     //사무실팩스3   
                        + "CARD_COUNT=["     + strCardCnt      + "],"     
                        + "HNEW_ZIP_CD1=["   + strHnewZipCd1   + "],"                                           
                        + "HNEW_ZIP_CD2=["   + strHnewZipCd2   + "],"                                 
                        + "HNEW_ADDR1=["     + strHnewAddr1    + "],"                                      
                        + "HNEW_ADDR2=["     + strHnewAddr2    + "],"                                 
                        + "HOME_NEW_YN=["    + strHomeNewYn    + "],"                                       
                        + "HORI_NEW_YN=["    + strHoriNewYn    + "],"                                 
                        + "HORI_ZIP_CD1=["   + strHoriZipCd1   + "],"                                        
                        + "HORI_ZIP_CD2=["   + strHoriZipCd2   + "],"                                   
                        + "HOME_SIDO=["      + strHomeSido     + "],"                 
                        + "HOME_SIGUN=["     + strHomeSiGun    + "],"  
                        + "HOME_GU=["        + strHomeGu       + "],"     
                        + "HOME_YDONG=["     + strHomeYdong    + "],"              
                        + "HOME_DONGRI=["    + strHomeDongri   + "],"             
                        + "HOME_BUNJI_FLAG=["+ strHomeBunjiFlag+ "],"                                     
                        + "HOME_BUNJI=["     + strHomeBunji    + "],"                        
                        + "HOME_GAJI_BUNJI=["+ strHomeGajiBunji+ "],"    
                        + "HOME_BUILD_NAME=["+ strHomeBuildName+ "],"                                     
                        + "HOME_BUILD_DONG=["+ strHomeBuildDong+ "],"                                      
                        + "HOME_BUILD_HO=["  + strHomeBuildHo  + "],"                                        
                        + "HOME_FOOR=["      + strHomeFloor    + "],"                                        
                        + "HOME_MAIL_YN=["   + strHomeMailYn   + "],"
                        + "CUST_GRADE=["     + strCustGrade    + "],"   
                        + "VIP_FLAG=["       + strVipFlag      + "]";   
                                                                                                       
                //저장시 로그 쌓기.
                String logGubun = "I"; //S:조회 //I:입력
                String log1 = "DM_CUSTOMER";                                  // P_TABLE_ID 테이블명.
                String log2 = "DCTM105";                                      // P_PGM_ID 프로그램 ID
                String log3 = "CUST_ID=["+strCustId+"]";                      // P_PK_VAL 키값
                String log4 = aftData;                                        // 입력시에는 P_AFT_DATA 데이터, 조회시에는 쿼리.
                String log5 = sessionInfo.getUSER_ID();                       // 등록자 ID
                this.logSave(logGubun, log1, log2, log3, log4, log5);
            }
            ret = strCustId;
            return ret;
                    
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }        
    }        
    
    /**
	 * <p>카드 저장(발급갯수만큼)</p>
	 * 
	 * @created  on 1.0, 2010/03/28
	 * @created  by 김영진
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	public int cardSave(ActionForm form, GauceDataSet dSet,
			HttpServletRequest request, HttpServletResponse response, MultiInput mi, String strCustGrade, String strVipFlag, String strPoCardPrefix)
			throws Exception {

        int ret        = 0;
        int res        = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        Map map        = null;   
        Util util      = new Util();
        
        try {
        	
        	if( getTrConnection() == null){
                connect("pot");
        	    begin();
        	}
        	
            String strChksave = String2.nvl(form.getParam("strChksave"));
            
            int i=1;  
            String strCard_no = "";
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");        
            
            String strUserId = sessionInfo.getUSER_ID();
            String strBrchId = sessionInfo.getBRCH_ID();
            
            String strCardCnt = mi.getString("CARD_COUNT"); 
            String strCustId  = dSet.getDataRow(0).getColumnValue(0).toString();

            
            sql.put(svc.getQuery("SEL_CUST_GRADE"));
            sql.setString(i++, strBrchId);      //가맹점ID
            sql.setString(i++, strCustId);      //회원ID
            map = selectMap(sql);            
            String strSelGrade = (String)map.get("CUST_GRADE"); 
            sql.clearParameter();
            sql.close();

            i=1;
            if(!strSelGrade.equals("N")){ 
                //if(Integer.parseInt(strSelGrade) < Integer.parseInt(strCustGrade)){}
                sql.put(svc.getQuery("UPD_CUST_GRADE")); 
                sql.setString(i++, strCustGrade);   //회원등급
                sql.setString(i++, strBrchId);      //가맹점ID
                sql.setString(i++, strCustId);      //회원ID	
                ret = update(sql);
            
                if (ret != 1) { 
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
    						+ "데이터 입력을 하지 못했습니다.");
                }
            }else{
            	sql.put(svc.getQuery("INS_CUST_GRADE")); 
                sql.setString(i++, strBrchId);      //가맹점ID
                sql.setString(i++, strCustId);      //회원ID
                sql.setString(i++, strCustGrade);   //회원등급
                sql.setString(i++, strUserId);      //로그인ID
                ret = update(sql);
            
                if (ret != 1) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
                }
            }
            
            if(String2.nvl(strCardCnt).equals("0")){
        	    sql.close(); 
                i = 1;
                sql.put(svc.getQuery("SEL_VIP_REASON"));               
                sql.setString(i++, strCustId);      //회원ID          
                Map map1 = selectMap(sql);                          
                String strSelVip = (String)map1.get("VIP_YN"); 
                sql.close();                                       
                
                if(!String2.nvl(strVipFlag).equals("")){
                    if(!strSelVip.equals("N")){ 
                        i = 1;
                        sql.put(svc.getQuery("UPD_VIP_REASON")); 
                        sql.setString(i++, strVipFlag);     //VIP등록구분
                        sql.setString(i++, "Y");            //사용여부
                        sql.setString(i++, strUserId);      //로그인ID
                        sql.setString(i++, strCustId);      //회원ID
                        ret = update(sql);
                        
                        if (ret != 1) {
                        	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
			            			+ "데이터 입력을 하지 못했습니다.");
                        }
                    }else{
                        i = 1;
                        sql.put(svc.getQuery("INS_VIP_REASON")); 
                        sql.setString(i++, strCustId);      //회원ID
                        sql.setString(i++, strVipFlag);     //VIP등록구분
                        sql.setString(i++, strUserId);      //로그인ID
                        sql.setString(i++, strUserId);      //로그인ID
                        ret = update(sql);
                        
                        if (ret != 1) {
                        	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
			            			+ "데이터 입력을 하지 못했습니다.");
                        }
                    }
                }else{
                	if(!strSelVip.equals("N")){ 
                	    i = 1;
                        sql.put(svc.getQuery("UPD_VIP_REASON")); 
                        sql.setString(i++, strVipFlag);     //VIP등록구분
                        sql.setString(i++, "N");            //사용여부
                        sql.setString(i++, strUserId);      //로그인ID
                        sql.setString(i++, strCustId);      //회원ID
                        ret = update(sql);
                        
                        if (ret != 1) {
                        	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
		                			+ "데이터 입력을 하지 못했습니다.");
                        }
                	}
                }
            }
            sql.close();
            ret = 0;
            String strCardPwdNo = mi.getString("CARD_PWD_NO");
            if(!strCardPwdNo.equals("****") && !String2.nvl(strCardPwdNo).equals("")){  //'****'가 아닐경우 암호화처리 
            	//strCardPwdNo = strCardPwdNo;
            }else{
            	//카드비밀번호구하기
	            sql.put(svc.getQuery("SEL_CARD_PWD_NO"));
	            sql.setString(1, strCustId); 
	            map = selectMap(sql);
	            sql.close();
	            
	            strCardPwdNo = (String)map.get("PWD_NO");
            }
            
            sql.close();
            sql.put(svc.getQuery("UPD_CARD_PWD_NO"));
            sql.setString(1, strCardPwdNo);
            sql.setString(2, strCustId);
            res = update(sql);	
            sql.close();
            
			//입력후에 이상이 없으면.. 카드번호를 가져와서 암호화 한다.
	        for (int j = 0; j < Integer.parseInt(strCardCnt); j++) {
	            sql = new SqlWrapper();  
	            //카드번호  구하기
	            sql.put(svc.getQuery("SEL_CARD_NO"));
	            map = selectMap(sql); 
	            sql.clearParameter();
	            sql.close();
	            
	            strCard_no = (String)map.get("CARD_NO");

	            //해당값을 저장하도록 한다.
	            //DCS.DM_PRE_CARD_NO 입력.	
	            i=1;
	            sql = new SqlWrapper();
	            String strRepCardYn = "N";//대표카드 여부
	            if(!strChksave.equals("U") && j == 0){
	            	strRepCardYn = "Y";
			    }
	            sql.setString(i++, strCard_no);   //CARD_NO
				sql.setString(i++, strCustId); 
				sql.setString(i++, strCardPwdNo); 
				sql.setString(i++, strRepCardYn); //대표카드 여부
				sql.setString(i++, sessionInfo.getBRCH_ID()); 
				sql.setString(i++, strCustGrade);
				sql.setString(i++, strPoCardPrefix);
				sql.setString(i++, sessionInfo.getUSER_ID()); 
				sql.setString(i++, sessionInfo.getUSER_ID()); 
				
				sql.put(svc.getQuery("INC_CARD"));
				res = update(sql);			
				ret += res;
	            sql.clearParameter();
	            sql.close();	 
			}
	        if (ret != Integer.parseInt(strCardCnt)) { 
	        	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
            }
	        
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
        	if( getTrConnection() == null )
				end();
        }
        return ret;
    }

    /**
     * <p>주민번호로 회원정보를 조회한다.</p>
     * 
     * @created  on 1.0, 2010/02/14
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    
    public List showCustInfo(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List ret = null;
        SqlWrapper sql = null;
        Service svc = null;
        Util util = new Util();
        String strQuery = ""; 
        int i = 1;  
        
        HttpSession session     = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        String strBrchId = sessionInfo.getBRCH_ID();
        
        String strSsno   = String2.nvl(form.getParam("strSsno"));
        String strCardNo = String2.nvl(form.getParam("strCardNo"));
        String strCustId = String2.nvl(form.getParam("strCustId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        sql.setString(i++, strBrchId);
        sql.setString(i++, strCardNo);
        sql.setString(i++, strSsno);
        sql.setString(i++, strCustId); 
        sql.setString(i++, strCardNo);
        sql.setString(i++, strSsno);
        sql.setString(i++, strCustId); 
        sql.setString(i++, strCardNo);
        sql.setString(i++, strSsno);
        sql.setString(i++, strCustId); 
        
        strQuery = svc.getQuery("SEL_CUST") + "\n"; 
        sql.put(strQuery);
        
        ret = select2List(sql);
     /* ret = util.decryptedStr(ret,2);     //주민등록번호 복호화.
        ret = util.decryptedStr(ret,6);     
        ret = util.decryptedStr(ret,7);
        ret = util.decryptedStr(ret,8);        
        ret = util.decryptedStr(ret,13);
        ret = util.decryptedStr(ret,14);
        ret = util.decryptedStr(ret,15);*/
        
        //조회끝난후 로그 쌓기.
        if(ret.size() > 0){
            String logGubun = "S";                                        // S:조회 //I:입력
            String log1 = "DM_CUSTOMER";                                  // P_TABLE_ID 테이블명.
            String log2 = "DCTM105";                                      // P_PGM_ID 프로그램 ID
            String log3 = "CARD_NO=["+ util.encryptedStr(strCardNo) + "]"
                        + "SS_NO=["  + util.encryptedStr(strSsno)   + "]";// P_PK_VAL 키값
            String log4 = strQuery;                                       // 입력시에는 P_AFT_DATA 데이터, 조회시에는 쿼리.
            String log5 = sessionInfo.getUSER_ID();                       // 등록자 ID
            this.logSave(logGubun, log1, log2, log3, log4, log5); 	
        }
        
        return ret;
    }        

    /**
     * <p>법인회원의 카드리스트를  조회 한다.</p>
     * 
     */ 
	public List searchCardList(ActionForm form) throws Exception {
		List ret = null;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strCustid = String2.nvl(form.getParam("strCustid"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot"); 

		sql.setString(i++, strCustid);

		strQuery = svc.getQuery("SEL_CARD") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);
	//  ret = util.decryptedStr(ret,0);     //카드번호 복호화.

		return ret;
	}	    

	/**
     * <p>법인회원의 카드리스트를  조회 한다. - 발급용</p>
     * 
     */ 
	public List cardPrintList(ActionForm form) throws Exception {
		List ret = null;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strCustid    = String2.nvl(form.getParam("strCustid"));
		String intCardCount = String2.nvl(form.getParam("intCardCount"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot"); 

		sql.setString(i++, strCustid);
		sql.setString(i++, intCardCount);
		
		strQuery = svc.getQuery("SEL_CARD_RRINT") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);
	//	ret = util.decryptedStr(ret,0);     //카드번호 복호화.

		return ret;
	}	    

    /**
     * <p>가사업자번호 생성.</p>
     * 
     */ 
	public String insSSno(ActionForm form) throws Exception {
		
		String ret = "";
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot"); 

		sql.put("SELECT DCS.F_GET_SQ_BIZ SS_NO FROM DUAL");

        Map map = selectMap(sql);            
        ret = (String)map.get("SS_NO");   

        return ret;
	}	 
	
	
	/**
     * <p>주소정제</p>
     * 
     * @created  on 1.0, 2010/05/12
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    public void addrCls(ActionForm form, MultiInput mi, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String returnSuccYn = "";
        EtZipcode zip = new EtZipcode();
        
        while (mi.next()) {
            String strHomeAddr1     = mi.getString("HOME_ADDR1");  //집주소1                   
            String strHomeAddr2     = mi.getString("HOME_ADDR2");  //집주소2    
            
            //주소 정제 솔루션 처리 전 고객 입력 주소 저장
		    mi.set("HORI_ZIP_CD1", mi.getString("HOME_ZIP_CD1"));  /*	고객입력 우편번호  1	*/     
		    mi.set("HORI_ZIP_CD2", mi.getString("HOME_ZIP_CD2"));  /*	고객입력 우편번호  2	*/     
		    mi.set("HORI_ADDR1",   strHomeAddr1);                  /*	고객입력 주소1(주소정세솔루션 처리 전)	*/  
		    mi.set("HORI_ADDR2",   strHomeAddr2);                  /*	고객입력 주소2(주소정세솔루션 처리 전)	*/    
		    mi.set("HORI_NEW_YN",  mi.getString("HOME_NEW_YN"));   /*	새주소, 구주소 구분	*/     

		    //주소정제 솔루션
			//returnSuccYn = zip.putAddress(strHomeAddr1,strHomeAddr2);
			
			if(returnSuccYn.equals("Y")){
				
				//주소 정제 솔루션 처리 후고객 입력 주소 저장
          		mi.set("HOME_ZIP_CD1",   zip.getRevise_Zipcode1());   /*	정제 후 우편번호1	- 구주소   */       
          		mi.set("HOME_ZIP_CD2",   zip.getRevise_Zipcode2());   /*	정제 후 우편번호2       	*/  
          		mi.set("HOME_ADDR1",     zip.getRevise_Addr1());      /*	정제 후 구주소1	        */       
          		mi.set("HOME_ADDR2",     zip.getRevise_Addr2());      /*	정제 후 구주소2	        */  

			    mi.set("HNEW_ZIP_CD1",    zip.getRevise_Zipcode1());  /*	정제 후 우편번호1	- 신주소   */                        
			    mi.set("HNEW_ZIP_CD2",    zip.getRevise_Zipcode2());  /*	정제 후 우편번호2	        */                                                              
			    mi.set("HNEW_ADDR1",      zip.getRevise_StAddr1());   /*	정제 후 새주소1	        */                                                       
			    mi.set("HNEW_ADDR2",      zip.getRevise_StAddr2());   /*	정제 후 새주소2	        */                                                         
			    mi.set("HOME_CLS_YN",     zip.getCln_Yn());           /*	주소클린징여부	        */                                                                
			                                
			    mi.set("HOME_NEW_YN",     mi.getString("HOME_NEW_YN"));  /*	새주소, 구주소 구분	zip.getAddr_Gbn()*/  
			    
			    mi.set("HOME_SIDO",       zip.getWide_Nm());          /*	시도	                */    
			    mi.set("HOME_SIGUN",      zip.getCity_Nm());          /*	시군	                */    
			    mi.set("HOME_GU",         zip.getSection_Nm());       /*	구	                */    
			    mi.set("HOME_YDONG",      zip.getVillage_Nm());       /*	읍면	                */    
			    mi.set("HOME_DONGRI",     zip.getAddress_Nm());       /*	동리	                */      
			    mi.set("HOME_BUNJI_FLAG", zip.getBunji_Gbn());        /*	번지 구분	            */  
			    mi.set("HOME_BUNJI",      zip.getHead_Bunji());       /*	번지	                */      
			    mi.set("HOME_GAJI_BUNJI", zip.getGaji_Bunji());       /*	가지번지	            */  
			    mi.set("HOME_BUILD_NAME", zip.getBuild_Nm());         /*	건물명	            */                  
			    mi.set("HOME_BUILD_DONG", zip.getBuild_Dong());       /*	건물 동	            */  
			    mi.set("HOME_BUILD_HO",   zip.getBuild_Ho());         /*	건물 호	            */  
			    mi.set("HOME_FLOOR",      zip.getBuild_Floor());      /*	건물 층	            */  
			    mi.set("HOME_MAIL_YN",    zip.getDeliv_Yn());         /*	우편물발송가능여부	*/             
			    
	        }else{
	        	
	            //솔루션 접속 불 시
	        	mi.set("HNEW_ZIP_CD1",    mi.getString("HOME_ZIP_CD1"));                     
	     	    mi.set("HNEW_ZIP_CD2",    mi.getString("HOME_ZIP_CD2"));                       
	     	    mi.set("HNEW_ADDR1",      strHomeAddr1);               
	     	    mi.set("HNEW_ADDR2",      strHomeAddr2);      
	     	    mi.set("HOME_CLS_YN",     "N");              
	     	                                
	     	    mi.set("HOME_NEW_YN",     mi.getString("HOME_NEW_YN"));       
	     	    
	     	    mi.set("HOME_SIDO",       "");        
	     	    mi.set("HOME_SIGUN",      "");        
	     	    mi.set("HOME_GU",         "");     
	     	    mi.set("HOME_YDONG",      "");     
	     	    mi.set("HOME_DONGRI",     "");     
	     	    mi.set("HOME_BUNJI_FLAG", "");      
	     	    mi.set("HOME_BUNJI",      "");     
	     	    mi.set("HOME_GAJI_BUNJI", "");     
	     	    mi.set("HOME_BUILD_NAME", "");         
	     	    mi.set("HOME_BUILD_DONG", "");     
	     	    mi.set("HOME_BUILD_HO",   "");       
	     	    mi.set("HOME_FLOOR",      "");    
	     	    mi.set("HOME_MAIL_YN",    "");             
	        }     
			
	     }
    }   
    
    /**
	 * <p>로그 쌓이기</p>
	 * 
	 * @created  on 1.0, 2010/01/25
	 * @created  by 남형석
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public ProcedureResultSet logSave (String logGubun, String para1,String para2,String para3,String para4,String para5) throws Exception {
		
		int 		ret = 0;
        SqlWrapper  sql = null;
        ProcedureWrapper psql = null;
        Service     svc = null;
        ProcedureResultSet proset = null; 

        try {
        	if( getTrConnection() == null){
                connect("pot");
        	    begin();
        	}
            sql  = new   SqlWrapper();
            psql = new ProcedureWrapper();
			int i=1;
			if(logGubun.equals("S")){
			    psql.put("DCS.PR_TBL_SHIST_INSERT", 7);
			}else{
				psql.put("DCS.PR_TBL_UHIST_INSERT", 7);
			}
			
			psql.setString(i++, para1);
			psql.setString(i++, para2);
			psql.setString(i++, para3);
			psql.setString(i++, para4);
			psql.setString(i++, para5);
			
			psql.registerOutParameter(i++, DataTypes.INTEGER);//
			psql.registerOutParameter(i++, DataTypes.VARCHAR);//
			proset = updateProcedure(psql);
			return proset;
			
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null || logGubun.equals("S"))
				end();
		}
	}
}
