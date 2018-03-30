/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import com.gauce.GauceDataSet;
import common.util.EtZipcode;
import common.util.Util;
import common.vo.SessionInfo;
/**
 * <p>무기명회원 가입 신청서 등록</p>
 * 
 * @created  on 1.0, 2010/01/25
 * @created  by 김영진(FUJITSU KOREA LTD.)
 *  
 * @modified on 
 * @modified by  
 * @caused   by 
 */
public class DCtm102DAO extends AbstractDAO {

    /**
     * <p>회원정보 저장 - 프로시져 콜.</p>
     * 
     * @created  on 1.0, 2010/01/25
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
	public GauceDataSet saveData(ActionForm form, MultiInput mi,
			HttpServletRequest request, HttpServletResponse response, String strCardGrade, GauceDataSet dSet)
			throws Exception {

    	GauceDataSet ret = null;
        SqlWrapper  sql = null;
        ProcedureWrapper psql = null;
        Service     svc  = null;
        Util        util = new Util();

        System.out.println("chk====3 ");
        int res = 0;
        
        String aftData = "";
        String strChksave   = String2.nvl(form.getParam("strChksave"));
        String strUpdate   = String2.nvl(form.getParam("strUpdate"));
                
        try {
        	
        	connect("pot");        	
    	    begin();
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            psql = new ProcedureWrapper();

            int i=1;        
            ProcedureResultSet prs = null;
            
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
            String strUserId = sessionInfo.getUSER_ID();
            String strBrchId = sessionInfo.getBRCH_ID();     
            
            String  strCustId       = mi.getString("CUST_ID");                        //회원ID.   
            System.out.println("strCustId==== " + strCustId);
            
            String  strHholdId      = mi.getString("HHOLD_ID");                       //세대ID                  
            //String  strSsNo         = util.encryptedStr(mi.getString("SS_NO"));       //주민번호                
            String  strSsNo         = mi.getString("SS_NO");       //주민번호                   
            String  strCustNm       = mi.getString("CUST_NAME");                      //회원명 
            /*
            String  strSexCd        = "";
            //주민번호로 성별 체크 - 내국인일경우....
            if(mi.getString("SS_NO").length() == 6){
            }else if(mi.getString("SS_NO").substring(6, 7).equals("1") || mi.getString("SS_NO").substring(6, 7).equals("3")
             ||mi.getString("SS_NO").substring(6, 7).equals("5") || mi.getString("SS_NO").substring(6, 7).equals("7")){
            	strSexCd = "M";
            }else{
            	strSexCd = "F";
            }
            */
            String  strCardPwdNo    = mi.getString("CARD_PWD_NO");                      //카드비밀번호 //암호화 ###미처리 
            
            //if(!strCardPwdNo.equals("****") && !String2.nvl(strCardPwdNo).equals("")){  //'****'가 아닐경우 암호화처리 
            	//strCardPwdNo = strCardPwdNo;
            	//strCardPwdNo = util.encryptedPasswd(strCardPwdNo);
            //}

            String strHomeZipCd1    = mi.getString("HOME_ZIP_CD1");                   //우편번호1                  
            String strHomeZipCd2    = mi.getString("HOME_ZIP_CD2");                   //우편번호2                               
            String strHomeAddr1     = mi.getString("HOME_ADDR1");                     //집주소1                   
            String strHomeAddr2     = mi.getString("HOME_ADDR2");                     //집주소2   
            
            String strNoclsReqYN    = mi.getString("NOCLS_REQ_YN");                   //클랜징미적용요청여부             
            String strHomeClsYn     = mi.getString("HOME_CLS_YN");                    //자택주소클렌징여부                 
            String strHomePh1       = mi.getString("HOME_PH1");    //자택전화번호1 //암호화          
            String strHomePh2       = mi.getString("HOME_PH2");    //자택전화번호2 //암호화          
            String strHomePh3       = mi.getString("HOME_PH3");    //자택전화번호3 //암호화          
            String strMobilePh1     = mi.getString("MOBILE_PH1");  //휴대폰1 //암호화             
            String strMobilePh2     = mi.getString("MOBILE_PH2");  //휴대폰2 //암호화             
            String strMobilePh3     = mi.getString("MOBILE_PH3");  //휴대폰3 //암호화             
            String strEmail1        = mi.getString("EMAIL1");      //이메일1 //암호화             
            String strEmail2        = mi.getString("EMAIL2");      //이메일2 //암호화   
            
            /*
            String strHomePh1       = util.encryptedStr(mi.getString("HOME_PH1"));    //자택전화번호1 //암호화          
            String strHomePh2       = util.encryptedStr(mi.getString("HOME_PH2"));    //자택전화번호2 //암호화          
            String strHomePh3       = util.encryptedStr(mi.getString("HOME_PH3"));    //자택전화번호3 //암호화          
            String strMobilePh1     = util.encryptedStr(mi.getString("MOBILE_PH1"));  //휴대폰1 //암호화             
            String strMobilePh2     = util.encryptedStr(mi.getString("MOBILE_PH2"));  //휴대폰2 //암호화             
            String strMobilePh3     = util.encryptedStr(mi.getString("MOBILE_PH3"));  //휴대폰3 //암호화             
            String strEmail1        = util.encryptedStr(mi.getString("EMAIL1"));      //이메일1 //암호화             
            String strEmail2        = util.encryptedStr(mi.getString("EMAIL2"));      //이메일2 //암호화  
             */
            
            String strEmailYn       = mi.getString("EMAIL_YN");                       //이메일수신여부                
            String strEmailAgreeDt  = mi.getString("EMAIL_AGREE_DT");                 //이메일등록일자                
            String strWedYn         = mi.getString("WED_YN");                         //결혼여부                   
            String strWedDt         = mi.getString("WED_DT");                         //결혼기념일                  
            String strBirthDt       = mi.getString("BIRTH_DT");                       //본인생일                   
            String strLunarFlag     = mi.getString("LUNAR_FLAG");                     //본인생일양음력구분   
            String strSmsYn         = mi.getString("SMS_YN");                         //SMS수신여부                
            String strSmsAgreeDt    = mi.getString("SMS_AGREE_DT");                   //sms동의일자                
            String strPostRcvCd     = mi.getString("POST_RCV_CD");                    //우편물수신처코드                                  
            String strOffiNm        = mi.getString("OFFI_NM");                        //사무실명                   
            String strOffiPh1       = mi.getString("OFFI_PH1");                       //사무실전화번호1               
            String strOffiPh2       = mi.getString("OFFI_PH2");                       //사무실전화번호2               
            String strOffiPh3       = mi.getString("OFFI_PH3");                       //사무실전화번호3               
            String strOffiFax1      = mi.getString("OFFI_FAX1");                      //사무실팩스 1                
            String strOffiFax2      = mi.getString("OFFI_FAX2");                      //사무실팩스2                 
            String strOffiFax3      = mi.getString("OFFI_FAX3");                      //사무실팩스3                 
            String strOffiInterPh   = mi.getString("OFFI_INTER_PH");                  //직장전화내선번호                       
            String strOffiZipCd1    = mi.getString("OFFI_ZIP_CD1");                   //사무실우편번호1               
            String strOffiZipCd2    = mi.getString("OFFI_ZIP_CD2");                   //사무실우편번호2    
            String strOffiAddr1     = mi.getString("OFFI_ADDR1");                     //사무실주소1                 
            String strOffiAddr2     = mi.getString("OFFI_ADDR2");                     //사무실주소2                 
            String strOffiClsYn     = mi.getString("OFFI_CLS_YN");                    //사무실주소 클랜징여부            
            String strScompEmpYn    = mi.getString("SCOMP_EMP_YN");                   //계열사직원여부                             
            String strChildCnt      = mi.getString("CHILD_CNT");                      //자녀수                    
            String strWebUserId     = mi.getString("WEB_USER_ID");                    //WEB사용자ID                  
            String strWebPasswd     = mi.getString("WEB_PASSWD");                     //WEB패스워드_암호    
            String strNameConfYn    = mi.getString("NAME_CONF_YN");                   //실명인증여부                 
            String strIPin          = mi.getString("I_PIN");                          //아이핀가입                  
            String strScedReqDt     = mi.getString("SCED_REQ_DT");                    //탈퇴요청일                  
            String strScedTakeFlag  = mi.getString("SCED_TAKE_FLAG");                 //탈퇴접수형태구분               
            String strScedProcDt    = mi.getString("SCED_PROC_DT");                   //탈퇴처리일자                 
            String strAlienYn       = mi.getString("ALIEN_YN");                       //외국인여부                  
            String strCustStatFlag  = mi.getString("CUST_STAT_FLAG");                 //회원상태                            
            String strCardNo        = mi.getString("CARD_NO");     //P_CARD_NO
            String strCardType      = mi.getString("CARD_TYPE_CD");                   //카드타입 P_CARD_TYPE
             
            String strHOriAddr1     = mi.getString("HORI_ADDR1");                //고객입력 주소(주소정세솔루션 처리 전)
            String strHOriAddr2     = mi.getString("HORI_ADDR2");                //고객입력 주소(주소정세솔루션 처리 전)
            String strOOriAddr1     = mi.getString("OORI_ADDR1");                //고객입력 주소(주소정세솔루션 처리 전)
            String strOOriAddr2     = mi.getString("OORI_ADDR2");                //고객입력 주소(주소정세솔루션 처리 전)
            
            String strHouseType     = mi.getString("HOUSE_TYPE");                //주거형태 
            String strHouseFlag     = mi.getString("HOUSE_FLAG");                //주거구분
            String strHoldCarYN     = mi.getString("HOLD_CAR_YN");               //자동차보유 
            String strFavorDept1YN  = mi.getString("FAVOR_DEPT1_YN");            //선호부문1
            String strFavorDept2YN  = mi.getString("FAVOR_DEPT2_YN");            //선호부문2
            String strFavorDept3YN  = mi.getString("FAVOR_DEPT3_YN");            //선호부문3
            String strFavorDept4YN  = mi.getString("FAVOR_DEPT4_YN");            //선호부문4
            String strFavorDept5YN  = mi.getString("FAVOR_DEPT5_YN");            //선호부문5
            String strIncomeAmt     = mi.getString("INCOME_AMT");                //월 평균소득                         
            String strFamilyCnt     = mi.getString("FAMILY_CNT");                //가족수                            
            String strDeptName      = mi.getString("DEPT_NAME");                 //부서                             
            String strPosition      = mi.getString("POSITION");                  //직위                     
            String strPositionEtc   = mi.getString("POSITION_ETC");              //직위    - 기타                        
            String strAgentName     = mi.getString("AGENT_NAME");                //대리인성명                          
            String strAgentSsno     = mi.getString("AGENT_SSNO");                //대리인주민번호                        
            String strAgentRelation = mi.getString("AGENT_RELATION");            //관계                          
            String strAgentPh1      = mi.getString("AGENT_PH1");                 //대리인전화번호1                    
            String strAgentPh2      = mi.getString("AGENT_PH2");                 //대리인전화번호2                    
            String strAgentPh3      = mi.getString("AGENT_PH3");                 //대리인전화번호3                    
            String strLegalAgent    = mi.getString("LEGAL_AGENT");               //법정대리인   
            
            String strOffTerms1Yn   = mi.getString("OFF_TERMS1_YN");             //정보제공 동의일자 동의여부                     
            String strOffTerms1Dt   = mi.getString("OFF_TERMS1_DT");             //정보제공 동의일자                  
            String strOffTerms1Name = mi.getString("OFF_TERMS1_NAME");           //정보제공 동의성명 
            String strOffTerms2Yn   = mi.getString("OFF_TERMS2_YN");             //개인정보 제3자 제공 동의여부        
            String strOffTerms2Dt   = mi.getString("OFF_TERMS2_DT");             //개인정보 제3자 제공 동의일자              
            String strOffTerms2Name = mi.getString("OFF_TERMS2_NAME");           //개인정보 제3자 제공 동의자 
            String strOffTerms3Yn   = mi.getString("OFF_TERMS3_YN");             //정보제공 동의일자 동의여부                     
            String strOffTerms3Dt   = mi.getString("OFF_TERMS3_DT");             //정보제공 동의일자                  
            String strOffTerms3Name = mi.getString("OFF_TERMS3_NAME");           //정보제공 동의성명 
            String strOffTerms4Yn   = mi.getString("OFF_TERMS4_YN");             //개인정보 제3자 제공 동의여부        
            String strOffTerms4Dt   = mi.getString("OFF_TERMS4_DT");             //개인정보 제3자 제공 동의일자              
            String strOffTerms4Name = mi.getString("OFF_TERMS4_NAME");           //개인정보 제3자 제공 동의자 
            
            String strEntrDt        = mi.getString("ENTR_DT");                   //가입일자                       
            String strIdCheck       = mi.getString("ID_CHECK");                  //신분증확인                      
            String strIssueOrg      = mi.getString("ISSUE_ORG");                 //발행기관                       
            String strIssueDt       = mi.getString("ISSUE_DT");                  //발행일자             

    		String strHoriZipCd1    = mi.getString("HORI_ZIP_CD1");              //고객입력 우편번호  1
    		String strHoriZipCd2    = mi.getString("HORI_ZIP_CD2");              //고객입력 우편번호 2
            String strHnewZipCd1    = mi.getString("HNEW_ZIP_CD1");              //정제 후 우편번호1
            String strHnewZipCd2    = mi.getString("HNEW_ZIP_CD2");              //정제 후 우편번호2	
            String strHnewAddr1     = mi.getString("HNEW_ADDR1");                //정제 후 새주소1	
            String strHnewAddr2     = mi.getString("HNEW_ADDR2");                //정제 후 새주소2	
            
            
            System.out.println("strHnewAddr2  ========   " + strHnewAddr2);
            
            String strHomeNewYn     = mi.getString("HOME_NEW_YN");               //새주소, 구주소 구분
            String strHomeSido      = mi.getString("HOME_SIDO");                 //시도	     
            String strHomeSiGun     = mi.getString("HOME_SIGUN"); 	             //시군	     
            String strHomeGu        = mi.getString("HOME_GU");                   //구	     
            String strHomeYdong     = mi.getString("HOME_YDONG");                //읍면	     
            String strHomeDongri    = mi.getString("HOME_DONGRI");               //동리	     
            String strHomeBunjiFlag = mi.getString("HOME_BUNJI_FLAG");           //번지 구분	 
            String strHomeBunji     = mi.getString("HOME_BUNJI");                //번지	     
            String strHomeGajiBunji = mi.getString("HOME_GAJI_BUNJI");           //가지번지	 
            String strHomeBuildName = mi.getString("HOME_BUILD_NAME");           //건물명	     
            String strHomeBuildDong = mi.getString("HOME_BUILD_DONG");           //건물 동	 
            String strHomeBuildHo   = mi.getString("HOME_BUILD_HO");             //건물 호	 
            String strHomeFloor     = mi.getString("HOME_FLOOR");                //건물 층	 
            String strHomeMailYn    = mi.getString("HOME_MAIL_YN");              //우편물발송가능여부
            
        	String strOoriZipCd1    = mi.getString("OORI_ZIP_CD1");              //고객입력 우편번호  1
    		String strOoriZipCd2    = mi.getString("OORI_ZIP_CD2");              //고객입력 우편번호 2
            String strOnewZipCd1    = mi.getString("ONEW_ZIP_CD1");              //정제 후 우편번호1
            String strOnewZipCd2    = mi.getString("ONEW_ZIP_CD2");              //정제 후 우편번호2	
            String strOnewAddr1     = mi.getString("ONEW_ADDR1");                //정제 후 새주소1	

            System.out.println("strOnewAddr1  ========   " + strOnewAddr1);
            System.out.println("strEtc  ========   " + mi.getString("ETC_MEMO"));
            
            
            String strOnewAddr2     = mi.getString("ONEW_ADDR2");                //정제 후 새주소2	
            String strOffiNewYn     = mi.getString("OFFI_NEW_YN");               //새주소, 구주소 구분
            String strOffiSido      = mi.getString("OFFI_SIDO");                 //시도	     
            String strOffiSiGun     = mi.getString("OFFI_SIGUN"); 	             //시군	     
            String strOffiGu        = mi.getString("OFFI_GU");                   //구	     
            String strOffiYdong     = mi.getString("OFFI_YDONG");                //읍면	     
            String strOffiDongri    = mi.getString("OFFI_DONGRI");               //동리	     
            String strOffiBunjiFlag = mi.getString("OFFI_BUNJI_FLAG");           //번지 구분	 
            String strOffiBunji     = mi.getString("OFFI_BUNJI");                //번지	     
            String strOffiGajiBunji = mi.getString("OFFI_GAJI_BUNJI");           //가지번지	 
            String strOffiBuildName = mi.getString("OFFI_BUILD_NAME");           //건물명	     
            String strOffiBuildDong = mi.getString("OFFI_BUILD_DONG");           //건물 동	 
            String strOffiBuildHo   = mi.getString("OFFI_BUILD_HO");             //건물 호	 
            String strOffiFloor     = mi.getString("OFFI_FLOOR");                //건물 층	 
            String strOffiMailYn    = mi.getString("OFFI_MAIL_YN");              //우편물발송가능여부
            String strHoriNewYn     = mi.getString("HORI_NEW_YN");  
            String strOoriNewYn     = mi.getString("OORI_NEW_YN");
            String strPoCardPrefix  = mi.getString("POCARD_PREFIX");
            String strCcompCd       = mi.getString("CCOMP_CD");
            String strEntrPbn       = mi.getString("ENTR_PBN");					 //가입권유브랜드
            String strCustGrade     = mi.getString("CUST_GRADE");				 //회원등급
            String strCustType      = mi.getString("CUST_TYPE");				 //회원유형
            String strSexCd			= mi.getString("SEX_CD");				 	 //성별구분
            String strIssueCnt      = mi.getString("ISSUE_CNT");				 //카드발급횟수
            String strTMYN			= mi.getString("TM_YN");					 //TM여부
            String strMobileComp	= mi.getString("MOBILE_COMP");				 //통신사
            String strDI			= mi.getString("DI");						 //DI
            String strCI			= mi.getString("CI");						 //CI
            String strEntrCh	    = mi.getString("ENTR_CH");						 //가입채널
            String strSTR_CD	    = mi.getString("STR_CD");						 //가입점
            String strEtc	    	= mi.getString("ETC_MEMO");					//적요 추가 16.12.19

            System.out.println("strPoCardPrefix"+strPoCardPrefix);
            System.out.println("strCardNo"+strCardNo);
            System.out.println("strChksave"+strChksave);
            
            if(strChksave.equals("U")){
                psql.put("DCS.PR_PCUST_UPDATE", 171);
            }else{
                psql.put("DCS.PR_PCUST_INSERT_BACKUP", 170);
            }
            
            if(strChksave.equals("I")){
                psql.registerOutParameter(i++, DataTypes.VARCHAR);
                psql.registerOutParameter(i++, DataTypes.VARCHAR);

                //psql.setString(i++,  strCustId          );    //회원ID.
                //psql.setString(i++,  strHholdId         );    //세대ID   
                
            } else {
                psql.setString(i++,  strCustId          );    //회원ID.
                psql.setString(i++,  strHholdId         );    //세대ID    
            }
            psql.setString(i++,  strSsNo                );    //주민번호
            psql.setString(i++,  strCustNm              );    //회원명
            psql.setString(i++,  strCardPwdNo           );    //카드비밀번호 //암호화 ###미처리
            psql.setString(i++,  strHomeZipCd1          );    //우편번호1
            psql.setString(i++,  strHomeZipCd2          );    //우편번호2
            psql.setString(i++,  strHomeAddr1           );    //집주소1    -- 고객입력 주소(주소정제솔루션 처리 후)
            psql.setString(i++,  strHomeAddr2           );    //집주소2    -- 고객입력 주소(주소정제솔루션 처리 후)
            psql.setString(i++,  strNoclsReqYN          );    //클랜징미적용요청여부
            psql.setString(i++,  strHomeClsYn           );    //클렌징 여부
            psql.setString(i++,  strHomePh1             );    //자택전화번호1 //암호화
            psql.setString(i++,  strHomePh2             );    //자택전화번호2 //암호화 
            psql.setString(i++,  strHomePh3             );    //자택전화번호3 //암호화 
            psql.setString(i++,  strMobilePh1           );    //휴대폰1 //암호화 
            psql.setString(i++,  strMobilePh2           );    //휴대폰2 //암호화 
            psql.setString(i++,  strMobilePh3           );    //휴대폰3 //암호화 
            psql.setString(i++,  strEmail1              );    //이메일1 //암호화 
            psql.setString(i++,  strEmail2              );    //이메일2 //암호화 
            psql.setString(i++,  strEmailYn             );    //이메일수신여부     ---------20
            psql.setString(i++,  strEmailAgreeDt        );    //이메일등록일자
            psql.setString(i++,  strWedYn               );    //결혼여부
            psql.setString(i++,  strWedDt               );    //결혼기념일
            psql.setString(i++,  strBirthDt             );    //본인생일
            psql.setString(i++,  strLunarFlag           );    //본인생일양음력
            psql.setString(i++,  strSmsYn               );    //SMS수신여부
            psql.setString(i++,  strSmsAgreeDt          );    //sms동의일자
            psql.setString(i++,  strPostRcvCd           );    //우편물수신처코드
            psql.setString(i++,  strOffiNm              );    //사무실명
            psql.setString(i++,  strOffiPh1             );    //사무실전화번호1   ---------30
            psql.setString(i++,  strOffiPh2             );    //사무실전화번호2
            psql.setString(i++,  strOffiPh3             );    //사무실전화번호3
            psql.setString(i++,  strOffiFax1            );    //사무실팩스 1
            psql.setString(i++,  strOffiFax2            );    //사무실팩스2 
            psql.setString(i++,  strOffiFax3            );    //사무실팩스3
            psql.setString(i++,  strOffiInterPh         );    //직장전화내선번호
            psql.setString(i++,  strOffiZipCd1          );    //사무실우편번호1
            psql.setString(i++,  strOffiZipCd2          );    //사무실우편번호2
            psql.setString(i++,  strOffiAddr1           );    //사무실주소1   -- 고객입력 주소(주소정제솔루션 처리 후)
            psql.setString(i++,  strOffiAddr2           );    //사무실주소2   -- 고객입력 주소(주소정제솔루션 처리 후)
            psql.setString(i++,  strOffiClsYn           );    //사무실주소 클랜징여부
            psql.setString(i++,  strScompEmpYn          );    //계열사직원여부
            psql.setString(i++,  strChildCnt            );    //자녀수
            psql.setString(i++,  strWebUserId           );    //wedid
            psql.setString(i++,  strWebPasswd           );    //wedpass
            psql.setString(i++,  strNameConfYn          );    //실명인증여부
            psql.setString(i++,  strIPin                );    //아이핀가입
            psql.setString(i++,  strScedReqDt           );    //탈퇴요청일
            psql.setString(i++,  strScedTakeFlag        );    //탈퇴접수형태구분
            psql.setString(i++,  strScedProcDt          );    //탈퇴처리일자       ---------50
            psql.setString(i++,  strAlienYn             );    //외국인여부
            psql.setString(i++,  strCustStatFlag        );    //회원상태
            psql.setString(i++,  strUserId              );    //등록자아이디
            psql.setString(i++,  strBrchId              );    //가맹점아이디
            psql.setString(i++,  strCardType            );    //카드타입 P_CARD_TYPE
            psql.setString(i++,  strHOriAddr1           );    //P_HORI_ADDR1   고객입력 주소(주소정세솔루션 처리 전)
            psql.setString(i++,  strHOriAddr2           );    //P_HORI_ADDR2   고객입력 주소(주소정세솔루션 처리 전)
            psql.setString(i++,  strOOriAddr1           );    //P_OORI_ADDR1   고객입력 주소(주소정세솔루션 처리 전)
            psql.setString(i++,  strOOriAddr2           );    //P_OORI_ADDR2   고객입력 주소(주소정세솔루션 처리 전)
            psql.setString(i++,  strHouseType         );    //주거형태          ---------60      
            psql.setString(i++,  strHouseFlag         );    //주거구분
            psql.setString(i++,  strHoldCarYN         );    //자동차보유                              
            psql.setString(i++,  strFavorDept1YN      );    //선호부문1                              
            psql.setString(i++,  strFavorDept2YN      );    //선호부문2                              
            psql.setString(i++,  strFavorDept3YN      );    //선호부문3                              
            psql.setString(i++,  strFavorDept4YN      );    //선호부문4   
            psql.setString(i++,  strFavorDept5YN      );    //선호부문5   
            psql.setString(i++,  strIncomeAmt         );    //월 평균소득                             
            psql.setString(i++,  strFamilyCnt         );    //가족수                                
            psql.setString(i++,  strDeptName          );    //부서          ---------70        
            psql.setString(i++,  strPosition          );    //직위               
            psql.setString(i++,  strPositionEtc       );    //직위-기타       
            psql.setString(i++,  strAgentName         );    //대리인성명                              
            psql.setString(i++,  strAgentSsno         );    //대리인주민번호                            
            psql.setString(i++,  strAgentRelation     );    //관계                                 
            psql.setString(i++,  strAgentPh1          );    //대리인전화번호1                           
            psql.setString(i++,  strAgentPh2          );    //대리인전화번호2                           
            psql.setString(i++,  strAgentPh3          );    //대리인전화번호3                           
            psql.setString(i++,  strLegalAgent        );    //법정대리인
            psql.setString(i++,  strOffTerms1Yn       );    //정보제공 동의여부             ---------80                  
            psql.setString(i++,  strOffTerms1Dt       );    //정보제공 동의일자                          
            psql.setString(i++,  strOffTerms1Name     );    //정보제공 동의성명    
            psql.setString(i++,  strOffTerms2Yn       );    //개인정보 제3자 제공 동의여부                            
            psql.setString(i++,  strOffTerms2Dt       );    //개인정보 제3자 제공 동의일자                   
            psql.setString(i++,  strOffTerms2Name     );    //개인정보 제3자 제공 동의자     
            psql.setString(i++,  strOffTerms3Yn       );    //정보제공 동의여부             ---------80                  
            psql.setString(i++,  strOffTerms3Dt       );    //정보제공 동의일자                          
            psql.setString(i++,  strOffTerms3Name     );    //정보제공 동의성명    
            psql.setString(i++,  strOffTerms4Yn       );    //개인정보 제3자 제공 동의여부                            
            psql.setString(i++,  strOffTerms4Dt       );    //개인정보 제3자 제공 동의일자                   
            psql.setString(i++,  strOffTerms4Name     );    //개인정보 제3자 제공 동의자                 
            psql.setString(i++,  strEntrDt            );    //가입일자                               
            psql.setString(i++,  strIdCheck           );    //신분증확인                              
            psql.setString(i++,  strIssueOrg          );    //발행기관                               
            psql.setString(i++,  strIssueDt           );    //발행일자   
            psql.setString(i++,  null                 );    //UNDER_14_YN             ---------90
            psql.setString(i++,  null                 );    //PARENT_WEB_ID      
            psql.setString(i++,  null                 );    //PARENT_APPR_DATE   
            psql.setString(i++,  null                 );    //ON_CARD_YN         
            psql.setString(i++,  null                 );    //MOBILE_CARD_YN     
            psql.setString(i++,  null                 );    //ON_TERMS1_YN    
            psql.setString(i++,  null                 );    //ON_TERMS1_DATE  
            psql.setString(i++,  null                 );    //ON_TERMS2_YN    
            psql.setString(i++,  null                 );    //ON_TERMS2_DATE  
            psql.setString(i++,  null                 );    //ON_TERMS3_YN    
            psql.setString(i++,  null                 );    //ON_TERMS3_DATE       ---------100
            psql.setString(i++,  null                 );    //ON_TERMS4_YN    
            psql.setString(i++,  null                 );    //ON_TERMS4_DATE  
            psql.setString(i++,  null                 );    //ON_TERMS5_YN    
            psql.setString(i++,  null                 );    //ON_TERMS5_DATE              
            psql.setString(i++,  strHnewZipCd1        );    //HNEW_ZIP_CD1   -- 자택 새주소     
            psql.setString(i++,  strHnewZipCd2        );    //HNEW_ZIP_CD2                 
            psql.setString(i++,  strHnewAddr1         );    //HNEW_ADDR1                   
            psql.setString(i++,  strHnewAddr2         );    //HNEW_ADDR2                   
            psql.setString(i++,  strHomeNewYn         );    //HOME_NEW_YN                  
            psql.setString(i++,  strOnewZipCd1        );    //ONEW_ZIP_CD1   -- 직장 새주소     
            psql.setString(i++,  strOnewZipCd2        );    //ONEW_ZIP_CD2                 
            psql.setString(i++,  strOnewAddr1         );    //ONEW_ADDR1                   
            psql.setString(i++,  strOnewAddr2         );    //ONEW_ADDR2                   
            psql.setString(i++,  strOffiNewYn         );    //OFFI_NEW_YN   
            psql.setString(i++,  strHoriNewYn         );    //HORI_NEW_YN  
            psql.setString(i++,  strHoriZipCd1        );    //HORI_ZIP_CD1      -- 고객입력 우편번호                                  
            psql.setString(i++,  strHoriZipCd2        );    //HORI_ZIP_CD2                      
            psql.setString(i++,  strOoriNewYn         );    //OORI_NEW_YN                       
            psql.setString(i++,  strOoriZipCd1        );    //OORI_ZIP_CD1                      
            psql.setString(i++,  strOoriZipCd2        );    //OORI_ZIP_CD2       ---------120
            psql.setString(i++,  strHomeSido          );    //HOME_SIDO         -- 주소 세부항목      
            psql.setString(i++,  strHomeSiGun         );    //HOME_SIGUN                        
            psql.setString(i++,  strHomeGu            );    //HOME_GU                           
            psql.setString(i++,  strHomeYdong         );    //HOME_YDONG                        
            psql.setString(i++,  strHomeDongri        );    //HOME_DONGRI                       
            psql.setString(i++,  strHomeBunjiFlag     );    //HOME_BUNJI_FLAG                   
            psql.setString(i++,  strHomeBunji         );    //HOME_BUNJI                        
            psql.setString(i++,  strHomeGajiBunji     );    //HOME_GAJI_BUNJI                   
            psql.setString(i++,  strHomeBuildName     );    //HOME_BUILD_NAME                   
            psql.setString(i++,  strHomeBuildDong     );    //HOME_BUILD_DONG                   
            psql.setString(i++,  strHomeBuildHo       );    //HOME_BUILD_HO                     
            psql.setString(i++,  strHomeFloor         );    //HOME_FLOOR                        
            psql.setString(i++,  strHomeMailYn        );    //HOME_MAIL_YN                      
            psql.setString(i++,  strOffiSido          );    //OFFI_SIDO         -- 주소 세부항목      
            psql.setString(i++,  strOffiSiGun         );    //OFFI_SIGUN                        
            psql.setString(i++,  strOffiGu            );    //OFFI_GU                           
            psql.setString(i++,  strOffiYdong         );    //OFFI_YDONG                        
            psql.setString(i++,  strOffiDongri        );    //OFFI_DONGRI                       
            psql.setString(i++,  strOffiBunjiFlag     );    //OFFI_BUNJI_FLAG                   
            psql.setString(i++,  strOffiBunji         );    //OFFI_BUNJI                          ---------140   
            psql.setString(i++,  strOffiGajiBunji     );    //OFFI_GAJI_BUNJI                   
            psql.setString(i++,  strOffiBuildName     );    //OFFI_BUILD_NAME                   
            psql.setString(i++,  strOffiBuildDong     );    //OFFI_BUILD_DONG                   
            psql.setString(i++,  strOffiBuildHo       );    //OFFI_BUILD_HO                     
            psql.setString(i++,  strOffiFloor         );    //OFFI_FLOOR                        
            psql.setString(i++,  strOffiMailYn        );    //OFFI_MAIL_YN   
            psql.setString(i++,  strSexCd             );    //SEX_CD         
            
            //if(strChksave.equals("U")){
            //    psql.setString(i++, "Y");       // P_CARD_ISSUE_YN 카드발급 여부 : 등록화면에서는 'Y', 조회/수정화면에서는 'N'   ※ 등록기능에 추가된 항목            
            //}

            System.out.println("strChksave" + strChksave);
            System.out.println("strUpdate" + strUpdate);
            
            if(strChksave.equals("U") && strUpdate.equals("N")){                      
                psql.setString(i++, "Y");                          //P_CARD_ISSUE_YN 카드발급 여부 : 등록화면에서는 'Y', 조회/수정화면에서는 'N'   ※ 등록기능에 추가된 항목
            }else if(strChksave.equals("U")){
            	psql.setString(i++, "N");  
            }
            
            psql.setString(i++, strCardNo);     //P_CARD_NO
            psql.setString(i++, "U");           //기명:I 무기명:U 구분값     ---------150
            
            psql.setString(i++,  strPoCardPrefix             ); 
            psql.setString(i++,  strCcompCd             );             
            psql.setString(i++,  strEntrPbn           );    //ENTR_PBN                        
            psql.setString(i++,  strCustGrade         );    //CUST_GRADE   
            psql.setString(i++,  strCustType          );    //CUST_TYPE
            psql.setString(i++,  strIssueCnt          );    //ISSUE_CNT           
            psql.setString(i++,  strTMYN			  );    //TM여부
            psql.setString(i++,  strMobileComp		  );    //통신사
            psql.setString(i++,  strDI				  );    //DI
            psql.setString(i++,  strCI				  );    //CI        ---------160
            psql.setString(i++,  strEntrCh			  );    //가입채널
            psql.setString(i++,  strSTR_CD			  );    //가입점
            psql.setString(i++,  strEtc				  );    //적요
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);
            psql.registerOutParameter(i++, DataTypes.VARCHAR);        // ---------163
                        

            System.out.println("START");
            System.out.println("psql" + psql);
            
            prs = updateProcedure(psql);
            
            String prsRet = prs.getString(169);
            
            System.out.println("prsRet" + prsRet);
            
            if(strChksave.equals("U")){
            	mi.set("CARD_NO", strCardNo);
            	prsRet = prs.getString(170);
            }else{
                dSet.getDataRow(0).setString(0,  prs.getString(1));
                dSet.getDataRow(0).setString(1,  prs.getString(2));
                mi.set("CARD_NO", strCardNo);
                

                strCustId  = prs.getString(1);
                strHholdId = prs.getString(2);

                System.out.println("strCustId===== "+strCustId);
                System.out.println("strHholdId===== "+strHholdId);
                
                //strCustId  = dSet.getDataRow(0).getColumnValue(0).toString();
                //strHholdId = dSet.getDataRow(0).getColumnValue(1).toString();
            } 
            
            System.out.println("END");
            
            //res += prs.getInt(162);   

            System.out.println("prsRet===== "+prsRet);
            
            if ( !prsRet.equals("0")) {
            	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.1");
            }else{  

                System.out.println("1212121212121212===== ");
            	//회원등급 저장
            	//this.custGradeSave (form,  strUserId, strBrchId,  strCustId, strCustGrade);
            	
            	//회원유형 저장
            	//this.custTypeSave (form,  strUserId, strBrchId,  strCustId, strCustType);

            	//회원 가입 전 카드 사용 포인트 조회 및 ADD
            	this.addCdPoint(form,  strUserId, strCustId, strCardNo);
            	
                aftData = "CUST_ID=["        + strCustId       + "],"    //회원ID.                                                                                                                               
                        + "HHOLD_ID=["       + strHholdId      + "],"    //세대ID                                                                                                                                
                        + "SS_NO=["          + strSsNo         + "],"    //주민번호                                              
                        + "CUST_NAME=["      + strCustNm       + "],"    //회원명                                 
                        + "CARD_PWD_NO=["    + strCardPwdNo    + "],"    //카드비밀번호 //암호화 ###미처리                 
                        + "HOME_ZIP_CD1=["   + strHomeZipCd1   + "],"    //우편번호1                               
                        + "HOME_ZIP_CD2=["   + strHomeZipCd2   + "],"    //우편번호2                                                         
                        + "HOME_ADDR1=["     + strHomeAddr1    + "],"    //집주소1                                
                        + "HOME_ADDR2=["     + strHomeAddr2    + "],"    //집주소2                                
                        + "NOCLS_REQ_YN=["   + strNoclsReqYN   + "],"    //클랜징미적용요청여부                          
                        + "HOME_CLS_YN=["    + strHomeClsYn    + "],"    //자택주소클렌징여부                           
                        + "HOME_PH1=["       + strHomePh1      + "],"    //자택전화번호1 //암호화                       
                        + "HOME_PH2=["       + strHomePh2      + "],"    //자택전화번호2 //암호화                       
                        + "HOME_PH3=["       + strHomePh3      + "],"    //자택전화번호3 //암호화                       
                        + "MOBILE_PH1=["     + strMobilePh1    + "],"    //휴대폰1 //암호화                          
                        + "MOBILE_PH2=["     + strMobilePh2    + "],"    //휴대폰2 //암호화                          
                        + "MOBILE_PH3=["     + strMobilePh3    + "],"    //휴대폰3 //암호화                          
                        + "EMAIL1=["         + strEmail1       + "],"    //이메일1 //암호화                          
                        + "EMAIL2=["         + strEmail2       + "],"    //이메일2 //암호화                          
                        + "EMAIL_YN=["       + strEmailYn      + "],"    //이메일수신여부                             
                        + "EMAIL_AGREE_DT=[" + strEmailAgreeDt + "],"    //이메일등록일자                             
                        + "WED_YN=["         + strWedYn        + "],"    //결혼여부                                
                        + "WED_DT=["         + strWedDt        + "],"    //결혼기념일                               
                        + "BIRTH_DT=["       + strBirthDt      + "],"    //본인생일                                
                        + "LUNAR_FLAG=["     + strLunarFlag    + "],"    //본인생일양음력구분                                                              
                        + "SMS_YN=["         + strSmsYn        + "],"    //SMS수신여부                             
                        + "SMS_AGREE_DT=["   + strSmsAgreeDt   + "],"    //sms동의일자   
                        + "POST_RCV_CD=["    + strPostRcvCd    + "],"    //우편물수신처코드                                                                       
                        + "OFFI_NM=["        + strOffiNm       + "],"    //사무실명                                
                        + "OFFI_PH1=["       + strOffiPh1      + "],"    //사무실전화번호1                            
                        + "OFFI_PH2=["       + strOffiPh2      + "],"    //사무실전화번호2                            
                        + "OFFI_PH3=["       + strOffiPh3      + "],"    //사무실전화번호3                            
                        + "OFFI_FAX1=["      + strOffiFax1     + "],"    //사무실팩스 1                             
                        + "OFFI_FAX2=["      + strOffiFax2     + "],"    //사무실팩스2                              
                        + "OFFI_FAX3=["      + strOffiFax3     + "],"    //사무실팩스3                              
                        + "OFFI_INTER_PH=["  + strOffiInterPh  + "],"    //직장전화내선번호                            
                        + "OFFI_ZIP_CD1=["   + strOffiZipCd1   + "],"    //사무실우편번호1                            
                        + "OFFI_ZIP_CD2=["   + strOffiZipCd2   + "],"    //사무실우편번호2                                                     
                        + "OFFI_ADDR1=["     + strOffiAddr1    + "],"    //사무실주소1                              
                        + "OFFI_ADDR2=["     + strOffiAddr2    + "],"    //사무실주소2                              
                        + "OFFI_CLS_YN=["    + strOffiClsYn    + "],"    //사무실주소 클랜징여부                         
    		            + "SCOMP_EMP_YN=["   + strScompEmpYn   + "],"    //계열사직원여부                                                   
                       //+ "CHILD_CNT=["      + strChildCnt     + "],"    //자녀수                                 
                        + "WEB_USER_ID=["    + strWebUserId    + "],"    //WEB사용자ID                            
                        + "WEB_PASSWD=["     + strWebPasswd    + "],"    //WEB패스워드_암호                          
                        + "NAME_CONF_YN=["   + strNameConfYn   + "],"    //실명인증여부                              
                        + "I_PIN=["          + strIPin         + "],"    //아이핀가입                               
                        + "SCED_REQ_DT=["    + strScedReqDt    + "],"    //탈퇴요청일                               
                        + "SCED_TAKE_FLAG=[" + strScedTakeFlag + "],"    //탈퇴접수형태구분                            
                        + "SCED_PROC_DT=["   + strScedProcDt   + "],"    //탈퇴처리일자                              
                        + "ALIEN_YN=["       + strAlienYn      + "],"    //외국인여부     
                        + "CUST_STAT_FLAG=[" + strCustStatFlag + "],"    //회원상태                                                
                        + "HOUSE_TYPE=["     + strHouseType    + "],"    //주거형태          
                        + "HOUSE_FLAG=["     + strHouseFlag    + "],"    //주거구분                                                         
                        + "FAVOR_DEPT1_YN=[" + strFavorDept1YN + "],"    //선호부문1                                       
                        + "FAVOR_DEPT2_YN=[" + strFavorDept2YN + "],"    //선호부문2                                       
                        + "FAVOR_DEPT3_YN=[" + strFavorDept3YN + "],"    //선호부문3                                       
                        + "FAVOR_DEPT4_YN=[" + strFavorDept4YN + "],"    //선호부문4      
                        + "FAVOR_DEPT5_YN=[" + strFavorDept5YN + "],"    //선호부문5   
                       //+ "INCOME_AMT=["     + strIncomeAmt    + "],"    //월 평균소득                  
                       //+ "FAMILY_CNT=["     + strFamilyCnt    + "],"    //가족수                                         
                        + "DEPT_NAME=["      + strDeptName     + "],"    //부서                                          
                        + "POSITION=["       + strPosition     + "],"    //직위                   
                        + "POSITION_ETC=["   + strPositionEtc  + "],"    //직위-기타               
                        + "AGENT_NAME=["     + strAgentName    + "],"    //대리인성명                                       
                        + "AGENT_SSNO=["     + strAgentSsno    + "],"    //대리인주민번호                                     
                        + "AGENT_RELATION=[" + strAgentRelation+ "],"    //관계                                          
                        + "AGENT_PH1=["      + strAgentPh1     + "],"    //대리인전화번호1                                    
                        + "AGENT_PH2=["      + strAgentPh2     + "],"    //대리인전화번호2                                    
                        + "AGENT_PH3=["      + strAgentPh3     + "],"    //대리인전화번호3                                    
                        + "LEGAL_AGENT=["    + strLegalAgent   + "],"    //법정대리인                 
                        + "OFF_TERMS1_YN=["  + strOffTerms1Yn  + "],"    //정보제공 동의여부                 
                        + "OFF_TERMS1_DT=["  + strOffTerms1Dt  + "],"    //정보제공 동의일자                                   
                        + "OFF_TERMS1_NAME=["+ strOffTerms1Name+ "],"    //정보제공 동의성명        
                        + "OFF_TERMS2_YN=["  + strOffTerms2Yn  + "],"    //개인정보 제3자 제공 동의여부                 
                        + "OFF_TERMS2_DT=["  + strOffTerms2Dt  + "],"    //개인정보 제3자 제공 동의일자                            
                        + "OFF_TERMS2_NAME=["+ strOffTerms2Name+ "],"    //개인정보 제3자 제공 동의자                                         
                        + "OFF_TERMS3_YN=["  + strOffTerms3Yn  + "],"    //정보제공 동의여부                 
                        + "OFF_TERMS3_DT=["  + strOffTerms3Dt  + "],"    //정보제공 동의일자                                   
                        + "OFF_TERMS3_NAME=["+ strOffTerms3Name+ "],"    //정보제공 동의성명        
                        + "OFF_TERMS4_YN=["  + strOffTerms4Yn  + "],"    //개인정보 제3자 제공 동의여부                 
                        + "OFF_TERMS4_DT=["  + strOffTerms4Dt  + "],"    //개인정보 제3자 제공 동의일자                            
                        + "OFF_TERMS4_NAME=["+ strOffTerms4Name+ "],"    //개인정보 제3자 제공 동의자   
                        
                        + "ENTR_DT=["        + strEntrDt       + "],"    //가입일자                                        
                        + "ID_CHECK=["       + strIdCheck      + "],"    //신분증확인                                       
                        + "ISSUE_ORG=["      + strIssueOrg     + "],"    //발행기관                                        
                        + "ISSUE_DT=["       + strIssueDt      + "],"    //발행일자                                                       
                        + "HNEW_ZIP_CD1=["   + strHnewZipCd1   + "],"                                           
                        + "HNEW_ZIP_CD2=["   + strHnewZipCd2   + "],"                                 
                        + "HNEW_ADDR1=["     + strHnewAddr1    + "],"                                      
                        + "HNEW_ADDR2=["     + strHnewAddr2    + "],"                                 
                        + "HOME_NEW_YN=["    + strHomeNewYn    + "],"           
                        + "ONEW_ZIPCD1=["    + strOnewZipCd1   + "],"                               
                        + "ONEW_ZIPCD2=["    + strOnewZipCd2   + "],"                                
                        + "ONEW_ADDR1=["     + strOnewAddr1    + "],"                                        
                        + "ONEW_ADDR2=["     + strOnewAddr2    + "],"                          
                        + "OFFI_NEW_YN=["    + strOffiNewYn    + "],"                               
                        + "HORI_NEW_YN=["    + strHoriNewYn    + "],"                                 
                        + "HORI_ZIP_CD1=["   + strHoriZipCd1   + "],"                                        
                        + "HORI_ZIP_CD2=["   + strHoriZipCd2   + "],"                                 
                        + "HOME_BUNJI=["     + strOffiNewYn    + "],"                                   
                        + "OORI_ZIP_CD1=["   + strOoriZipCd1   + "],"               
                        + "OORI_ZIP_CD2=["   + strOoriZipCd2   + "],"     
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
                        + "OFFI_SI_DO=["     + strOffiSido     + "],"                                             
                        + "OFFI_SI_GUN=["    + strOffiSiGun    + "],"                                 
                        + "OFFI_GU=["        + strOffiGu       + "],"                                   
                        + "OFFI_YDONG=["     + strOffiYdong    + "],"                          
                        + "OFFI_DONGRI=["    + strOffiDongri   + "],"                    
                        + "OFFI_BUNJI_FLAG=["+ strOffiBunjiFlag+ "],"                                           
                        + "OFFI_BUNJI=["     + strOffiBunji    + "],"                                 
                        + "OFFI_GAJI_BUNJI=["+ strOffiGajiBunji+ "],"                                   
                        + "OFFI_BUILD_NAME=["+ strOffiBuildName+ "],"                                  
                        + "OFFI_BUILD_DONG=["+ strOffiBuildDong+ "],"   
                        + "OFFI_BUILD_HO=["  + strOffiBuildHo  + "],"                      
                        + "OFFI_FLOOR=["     + strOffiFloor    + "],"                       
                        + "OFFI_MAIL_YN=["   + strOffiMailYn   + "],"
                        + "TM_YN=["			 + strTMYN		   + "],"    //TM여부
                        + "MOBILE_COMP=["	 + strMobileComp   + "],"    //통신사
                        + "DI=["   			 + strDI   		   + "],"
                        + "CI=["   			 + strCI   		   + "],"
                		+ "ENTR_CH=["   	 + strEntrCh	   + "],"
                        + "STR_CD=["     	 + strSTR_CD	   + "],"
                		+ "ETC_MEMO=["     	 + strEtc	   	   + "]";	//적요
                		 
                
                //저장시 로그 쌓기.
                String logGubun = "I"; //S:조회 //I:입력
                String log1 = "DM_CUSTOMER";                                  // P_TABLE_ID 테이블명.
                String log2 = "DCTM102";                                      // P_PGM_ID 프로그램 ID
                String log3 = "CUST_ID=["+strCustId+"]";                      // P_PK_VAL 키값
                String log4 = aftData;                                        // 입력시에는 P_AFT_DATA 데이터, 조회시에는 쿼리.
                String log5 = sessionInfo.getUSER_ID();                       // 등록자 ID
                this.logSave(logGubun, log1, log2, log3, log4, log5);
            }

        } catch (Exception e) {
        	
            rollback();
            throw e;
        } finally {
            end();
        }      
        return dSet;  
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
    public List searchCustinfo(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List ret = null;
        SqlWrapper sql = null;
        Service svc = null;
        Util util = new Util();
        String strQuery = "";
        int i = 1;  
        
        HttpSession session     = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        String strSsno   = String2.nvl(form.getParam("strSsno"));
        String strCardNo = String2.nvl(form.getParam("strCardNo"));
        String strBrchId = sessionInfo.getBRCH_ID();
        String strMobilePh1 = String2.nvl(form.getParam("strMobilePh1"));
        String strMobilePh2 = String2.nvl(form.getParam("strMobilePh2"));
        String strMobilePh3 = String2.nvl(form.getParam("strMobilePh3"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        try {
            connect("pot");
        	begin();

        	sql.setString(i++, strBrchId);
        	sql.setString(i++, strBrchId);
            sql.setString(i++, strSsno);
            sql.setString(i++, strSsno);
            sql.setString(i++, strSsno);
            sql.setString(i++, strSsno);
            sql.setString(i++, strMobilePh1);
            sql.setString(i++, strMobilePh2);
            sql.setString(i++, strMobilePh3);     
            sql.setString(i++, strSsno);
            sql.setString(i++, strMobilePh1);
            sql.setString(i++, strMobilePh2);
            sql.setString(i++, strMobilePh3);  
            /*
            sql.setString(i++, util.encryptedStr(strSsno));
            sql.setString(i++, util.encryptedStr(strSsno));
            sql.setString(i++, util.encryptedStr(strSsno));
            sql.setString(i++, util.encryptedStr(strSsno));
            sql.setString(i++, util.encryptedStr(strMobilePh1));
            sql.setString(i++, util.encryptedStr(strMobilePh2));
            sql.setString(i++, util.encryptedStr(strMobilePh3));     
            sql.setString(i++, util.encryptedStr(strSsno));
            sql.setString(i++, util.encryptedStr(strMobilePh1));
            sql.setString(i++, util.encryptedStr(strMobilePh2));
            sql.setString(i++, util.encryptedStr(strMobilePh3)); 
*/         
            strQuery = svc.getQuery("SEL_CUST") + "\n";
            
            sql.put(strQuery);
            
            ret = select2List(sql);
                       
/*
            ret = util.decryptedStr(ret,3);     //주민등록번호 복호화. 
            ret = util.decryptedStr(ret,12);      
            ret = util.decryptedStr(ret,13);
            ret = util.decryptedStr(ret,14);
            ret = util.decryptedStr(ret,15); 
            ret = util.decryptedStr(ret,16);
            ret = util.decryptedStr(ret,17);
            ret = util.decryptedStr(ret,18);    //EMAIL1
            ret = util.decryptedStr(ret,19);    //EMAIL2
            ret = util.decryptedStr(ret,20);    //EMAIL3
            */
            
            //조회끝난후 로그 쌓기.
            if(ret.size() > 0){
                String logGubun = "S";                                        // S:조회 //I:입력
                String log1 = "DM_CUSTOMER";                                  // P_TABLE_ID 테이블명.
                String log2 = "DCTM102";                                      // P_PGM_ID 프로그램 ID
                //String log3 = "CARD_NO=["+ util.encryptedStr(strCardNo) + "]"
                //            + "SS_NO=["  + util.encryptedStr(strSsno)   + "]";// P_PK_VAL 키값
                

                String log3 = "CARD_NO=["+ strCardNo + "]"
                            + "SS_NO=["  + strSsno   + "]";// P_PK_VAL 키값
                
                String log4 = strQuery.replaceAll(" ", "");                   // 입력시에는 P_AFT_DATA 데이터, 조회시에는 쿼리.
                String log5 = sessionInfo.getUSER_ID();                       // 등록자 ID
                this.logSave(logGubun, log1, log2, log3, log4, log5); 	
            }
            return ret;
        
	    } catch (Exception e) {
	    	rollback();
	    	throw e;
	    } finally {
	        end();
	    }
    }    
    
    /**
	 * <p>무기명카드 발급 - 회원가입 전 카드 사용 조회 및 포인트ADD</p>
	 * 
	 * @created  on 1.0, 2010/03/29
	 * @created  by 김영진
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	public int addCdPoint(ActionForm form, String strUserId, String strCustId, String strCardNo)
			throws Exception {

        int ret = 0;
        Util util = new Util();
        SqlWrapper sql = null;
        Service svc    = null;
        
        try {
        	
        	if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
            sql = new SqlWrapper();
            svc = (Service) form.getService();
             
            int i=1;
            sql.put(svc.getQuery("SEL_CD_POINT"));
            sql.setString(i++, strCardNo);      //카드번호 - 암호화
            Map map = selectMap(sql);            
            String strAddPoint = map.get("ADD_POINT").toString();

            if(!strAddPoint.equals("0")){ 
                i=1;
                sql.close();
            	sql.put(svc.getQuery("UPD_CUST_TPOINT")); 
                sql.setString(i++, strAddPoint);    //사용포인트
                sql.setString(i++, strUserId);      //로그인자
                sql.setString(i++, strCustId);      //회원ID	
                ret = update(sql);
                if (ret != 1) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.2");
                }else{
                	sql.close();
                	i=1;
                	sql.put(svc.getQuery("UPD_CD_POINT")); 
                	sql.setString(i++, strCardNo);      //카드번호 - 암호화
                	ret = update(sql);
                	
                    if (ret != 1) {
                    	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
    							+ "데이터 입력을 하지 못했습니다.3");
                    }
                } 
            }
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
        	if( getTrConnection() == null)
				end();
        }
        return ret;
    }
	
    /**
     * <p>카드번호 존재CHK</p>
     * 
     * @created  on 1.0, 2010/02/14
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    public String chkCardNo(ActionForm form, MultiInput mi, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String ret = null;
        Map map    = null;
        SqlWrapper sql = null;
        Service svc = null;
        Util util = new Util();
        int i = 1;  

        while (mi.next()) { 
            String strCardNo = mi.getString("CARD_NO");    //P_CARD_NO

            //String strCardNo = util.encryptedStr(mi.getString("CARD_NO"));    //P_CARD_NO
            
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            connect("pot");
            sql.put(svc.getQuery("SEL_CARD_NO"));
            sql.setString(i++, strCardNo);
            map = selectMap(sql);
            String chkYN = map.get("CHK_YN").toString();
            String strCardGrade = map.get("CARD_GRADE").toString();
            String strCardNoYN  = map.get("CARD_NO_YN").toString();
            
            
            if(strCardNoYN.equals("N") && String2.nvl(strCardGrade).equals("")){
            	throw new Exception("[USER]"+"존재하지 않는 카드 번호입니다.");
            }else if( chkYN.equals("Y")) {
		    	throw new Exception("[USER]"+"이미 존재하는 카드 번호입니다.");
            }else{
            	ret = strCardGrade;
            }
            
        }
        return ret;
    }   
    
    /**
     * <p>주소정제</p>
     * 
     * @created  on 1.0, 2010/05/11
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    public void addrCls(ActionForm form, MultiInput mi, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String returnSuccYn = "N";
        EtZipcode zip = new EtZipcode();

        String strNoclsReqYN  = mi.getString("NOCLS_REQ_YN");  //주소클렌징여부(Y: 정제 , N: 안함) 
        
        String strHomeAddr1   = mi.getString("HOME_ADDR1");    //집주소1     
        String strHomeAddr2   = mi.getString("HOME_ADDR2");    //집주소2  
        
        System.out.println("HOME_ADDR1==== " + strHomeAddr1);
        System.out.println("HOME_ADDR2==== " + strHomeAddr2);        

        String strHnewAddr1   = mi.getString("HNEW_ADDR1");    //새 집주소1  
        String strHnewAddr2   = mi.getString("HNEW_ADDR2");    //새 집주소2  
        
        System.out.println("HNEW_ADDR1==== " + strHnewAddr1);
        System.out.println("HNEW_ADDR2==== " + strHnewAddr2);  

        //주소 정제 솔루션 처리 전 고객 입력 주소 저장
	    mi.set("HORI_ZIP_CD1", mi.getString("HOME_ZIP_CD1"));  /*	고객입력 우편번호  1	*/     
	    mi.set("HORI_ZIP_CD2", mi.getString("HOME_ZIP_CD2"));  /*	고객입력 우편번호  2	*/     
	    mi.set("HORI_ADDR1",   strHomeAddr1);                  /*	고객입력 주소1(주소정세솔루션 처리 전)	*/  
	    mi.set("HORI_ADDR2",   strHomeAddr2);                  /*	고객입력 주소2(주소정세솔루션 처리 전)	*/    
	    mi.set("HORI_NEW_YN",  mi.getString("HOME_NEW_YN"));   /*	새주소, 구주소 구분	*/     

        System.out.println("새주소, 구주소 구분==== " + mi.getString("HOME_NEW_YN"));  

        System.out.println("strNoclsReqYN(Y: 정제 , N: 안함)==== " + strNoclsReqYN);
        
	    if(strNoclsReqYN.equals("Y")){
	    	// 형지 아트몰링 주석처리 주소정제솔루션 사용안함
	    	//주소정제 솔루션
			//returnSuccYn = zip.putAddress(strHomeAddr1,strHomeAddr2);
	    }
        

        System.out.println("returnSuccYn==== " + returnSuccYn);
        
        if(returnSuccYn.equals("Y")){     //--- 위에서 N 으로 내려옴..   돌지를 않겠네

            System.out.println("chk====11111 ");
		    
        	//주소 정제 솔루션 처리 후고객 입력 주소 저장
      		mi.set("HOME_ZIP_CD1",   zip.getRevise_Zipcode1());   /*	정제 후 우편번호1	- 구주소   */       
      		mi.set("HOME_ZIP_CD2",   zip.getRevise_Zipcode2());   /*	정제 후 우편번호2       	*/  
      		mi.set("HOME_ADDR1",     zip.getRevise_Addr1());      /*	정제 후 구주소1	        */       
      		mi.set("HOME_ADDR2",     zip.getRevise_Addr2());      /*	정제 후 구주소2	        */  

		    mi.set("HNEW_ZIP_CD1",    zip.getRevise_Zipcode1());  /*	정제 후 우편번호1 - 신주소    */                        
		    mi.set("HNEW_ZIP_CD2",    zip.getRevise_Zipcode2());  /*	정제 후 우편번호2	         */                        
		    mi.set("HNEW_ADDR1",      zip.getRevise_StAddr1());   /*	정제 후 새주소1	         */                   
		    mi.set("HNEW_ADDR2",      zip.getRevise_StAddr2());   /*	정제 후 새주소2	         */                     
		    mi.set("HOME_CLS_YN",     zip.getCln_Yn());           /*	주소클린징여부	         */                                
		                                
		    mi.set("HOME_NEW_YN",     mi.getString("HOME_NEW_YN")); /*	새주소, 구주소 구분zip.getAddr_Gbn()	*/  
		    
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

            System.out.println("chk====2222 ");
        	//솔루션 접속 불 시
		    mi.set("HNEW_ZIP_CD1",    mi.getString("HOME_ZIP_CD1"));                     
		    mi.set("HNEW_ZIP_CD2",    mi.getString("HOME_ZIP_CD2"));                       
		    mi.set("HNEW_ADDR1",      strHnewAddr1);               	   // 새주소
		    mi.set("HNEW_ADDR2",      strHnewAddr2);                   // 새주소
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
        
        returnSuccYn = "N";

        System.out.println("chk====33333 ");
        String strOffiAddr1     = mi.getString("OFFI_ADDR1");  //사무실주소1                 
        String strOffiAddr2     = mi.getString("OFFI_ADDR2");  //사무실주소2    
        
        //주소 정제 솔루션 처리 전 고객 입력 주소 저장
	    mi.set("OORI_ZIP_CD1", mi.getString("OFFI_ZIP_CD1"));  /*	고객입력 우편번호  1	*/     
	    mi.set("OORI_ZIP_CD2", mi.getString("OFFI_ZIP_CD2"));  /*	고객입력 우편번호  2	*/     
	    mi.set("OORI_ADDR1",   strOffiAddr1);                  /*	고객입력 주소1(주소정세솔루션 처리 전)	*/  
	    mi.set("OORI_ADDR2",   strOffiAddr2);                  /*	고객입력 주소2(주소정세솔루션 처리 전)	*/    
	    mi.set("OORI_NEW_YN",  mi.getString("OFFI_NEW_YN"));   /*	새주소, 구주소 구분	*/     
	  
	    //주소정제 솔루션
	    if(!strOffiAddr1.equals("") && !strOffiAddr2.equals("")){
		    //returnSuccYn = zip.putAddress(strOffiAddr1,strOffiAddr2);
	    }
        if(returnSuccYn.equals("Y")){

            System.out.println("chk====44444 ");
        	//주소 정제 솔루션 처리 후 고객 입력 주소 저장
		    mi.set("OFFI_ZIP_CD1",    zip.getRevise_Zipcode1());  /*	정제 후 우편번호1 - 구주소	*/     
		    mi.set("OFFI_ZIP_CD2",    zip.getRevise_Zipcode2());  /*	정제 후 우편번호2 	        */     
		    mi.set("OFFI_ADDR1",      zip.getRevise_Addr1());     /*	정제 후  구주소1      */  
		    mi.set("OFFI_ADDR2",      zip.getRevise_Addr2());     /*	정제 후  구 주소2      */  
		    
	        mi.set("ONEW_ZIP_CD1",    zip.getRevise_Zipcode1());  /*	정제 후 우편번호1	    */                        
	        mi.set("ONEW_ZIP_CD2",    zip.getRevise_Zipcode2());  /*	정제 후 우편번호2	    */                        
	        mi.set("ONEW_ADDR1",      zip.getRevise_StAddr1());   /*	정제 후 새주소1	    */                   
	        mi.set("ONEW_ADDR2",      zip.getRevise_StAddr2());   /*	정제 후 새주소2	    */                     
	        mi.set("OFFI_CLS_YN",     zip.getCln_Yn());           /*	주소클린징여부	    */                         
	                                    
	        mi.set("OFFI_NEW_YN",     mi.getString("OFFI_NEW_YN")); /*	새주소, 구주소 구분zip.getAddr_Gbn()	*/  
	        
	        mi.set("OFFI_SIDO",       zip.getWide_Nm());          /*	시도	                */    
	        mi.set("OFFI_SIGUN",      zip.getCity_Nm());          /*	시군	                */    
	        mi.set("OFFI_GU",         zip.getSection_Nm());       /*	구	                */    
	        mi.set("OFFI_YDONG",      zip.getVillage_Nm());       /*	읍면	                */    
	        mi.set("OFFI_DONGRI",     zip.getAddress_Nm());       /*	동리	                */      
	        mi.set("OFFI_BUNJI_FLAG", zip.getBunji_Gbn());        /*	번지 구분	            */  
	        mi.set("OFFI_BUNJI",      zip.getHead_Bunji());       /*	번지	                */      
	        mi.set("OFFI_GAJI_BUNJI", zip.getGaji_Bunji());       /*	가지번지	            */  
	        mi.set("OFFI_BUILD_NAME", zip.getBuild_Nm());         /*	건물명	            */                  
	        mi.set("OFFI_BUILD_DONG", zip.getBuild_Dong());       /*	건물 동	            */  
	        mi.set("OFFI_BUILD_HO",   zip.getBuild_Ho());         /*	건물 호	            */  
	        mi.set("OFFI_FLOOR",      zip.getBuild_Floor());      /*	건물 층	            */  
	        mi.set("OFFI_MAIL_YN",    zip.getDeliv_Yn());         /*	우편물발송가능여부	*/   
	    
	    }else{

            System.out.println("chk====55555 ");
	    	//솔루션 접속 불 시
	    	mi.set("ONEW_ZIP_CD1",    mi.getString("OFFI_ZIP_CD1"));            
			mi.set("ONEW_ZIP_CD2",    mi.getString("OFFI_ZIP_CD2"));            
			mi.set("ONEW_ADDR1",      strHnewAddr1);        
			mi.set("ONEW_ADDR2",      strHnewAddr2);          
			mi.set("OFFI_CLS_YN",     "N");                  
			                            
			mi.set("OFFI_NEW_YN",     mi.getString("OFFI_NEW_YN"));        
			
			mi.set("OFFI_SIDO",        "");       
			mi.set("OFFI_SIGUN",       "");       
			mi.set("OFFI_GU",          "");       
			mi.set("OFFI_YDONG",       "");       
			mi.set("OFFI_DONGRI",      "");       
			mi.set("OFFI_BUNJI_FLAG",  "");       
			mi.set("OFFI_BUNJI",       "");       
			mi.set("OFFI_GAJI_BUNJI",  "");       
			mi.set("OFFI_BUILD_NAME",  "");            
			mi.set("OFFI_BUILD_DONG",  "");       
			mi.set("OFFI_BUILD_HO",    "");       
			mi.set("OFFI_FLOOR",       "");       
			mi.set("OFFI_MAIL_YN",     "");       
	    }

        System.out.println("chk====66666 ");
    }   
    
    
    /**
	 * <p>회원등급 저장</p>
	 * 
	 * @created  on 1.0, 2010/03/25
	 * @created  by 김영진
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
/*	public int custGradeSave(ActionForm form, String strUserId,
			String strBrchId, String strCustId, String strCustGrade)
			throws Exception {

        int ret = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        
        try {
        	
        	if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
            sql = new SqlWrapper();
            svc = (Service) form.getService();
             
            int i=1;          
            sql.put(svc.getQuery("SEL_CUST_GRADE"));
            sql.setString(i++, strBrchId);      //가맹점ID
            sql.setString(i++, strCustId);      //회원ID
            Map map = selectMap(sql);            
            String strSelGrade = (String)map.get("CUST_GRADE");            
            
            sql.close();
            i=1;
            if(!strSelGrade.equals("N")){ 
                //if(Integer.parseInt(strSelGrade) < Integer.parseInt(strCardGrade)){}
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
            
            if (ret != 1) { 
            	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
            }            
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
			if( getTrConnection() == null)
				end();
        }
        return ret;
    }*/
	
    /**
	 * <p>회원유형 저장</p>
	 * 
	 * @created  on 1.0, 2012/05/08
	 * @created  by 강진
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
/*	public int custTypeSave(ActionForm form, String strUserId,
			String strBrchId, String strCustId, String strCustType)
			throws Exception {

        int ret = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        
        try {
        	
        	if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
            sql = new SqlWrapper();
            svc = (Service) form.getService();
             
            int i=1;          
            sql.put(svc.getQuery("SEL_CUST_TYPE"));
            sql.setString(i++, strBrchId);      //가맹점ID
            sql.setString(i++, strCustId);      //회원ID
            Map map = selectMap(sql);
            sql.close();
            
            String strSelType = (String)map.get("CUST_TYPE");
            String appDt = "";
            if(!strSelType.equals("N")) {
            	appDt = strSelType.substring(0, 8);
            	strSelType = strSelType.substring(8, 10);
            }
            String toDay   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

            i=1;
            //날짜가 같고 유형이 다르면 update
            if(appDt.equals(toDay) && !strSelType.equals(strCustType)){
            	sql.put(svc.getQuery("UPD_CUST_TYPE")); 
            	sql.setString(i++, strCustType);    //회원유형
            	sql.setString(i++, strBrchId);      //가맹점ID
                sql.setString(i++, strCustId);      //회원ID	
                ret = update(sql);          	
            }
            //날짜가 다르고 유형이 다르면 insert
            else if(!appDt.equals(toDay) && !strSelType.equals(strCustType)){
            	sql.put(svc.getQuery("INS_CUST_TYPE")); 
                sql.setString(i++, strBrchId);      //가맹점ID
                sql.setString(i++, strCustId);      //회원ID
                sql.setString(i++, strCustType);    //회원유형
                sql.setString(i++, strUserId);      //로그인ID
                ret = update(sql);          	
            }else{
            	ret = 1;
            }
            
            if (ret != 1) { 
            	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
            }            
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
			if( getTrConnection() == null)
				end();
        }
        return ret;
    }*/	
	
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
		
		psql.registerOutParameter(i++, DataTypes.INTEGER);
		psql.registerOutParameter(i++, DataTypes.VARCHAR);
		proset = updateProcedure(psql);
		return proset;
	}
	
    /**
     * <p>가외국인번호 생성.</p>
     * 
     */ 
	public String getSSno(ActionForm form) throws Exception {
		
		String ret = "";
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		
		String strBirthDt	= String2.nvl(form.getParam("strBirthDt"));
		String strSex		= String2.nvl(form.getParam("strSex"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot"); 

		sql.put("SELECT DCS.F_GET_SQ_ALIEN('"+strBirthDt+"','"+strSex+"') SS_NO FROM DUAL");

        Map map = selectMap(sql);            
        ret = (String)map.get("SS_NO");   

        return ret;
	}	

    /**
     * <p>실명확인로그</p>
     * 
     */
	/*
	public String insRealName(ActionForm form, HttpServletRequest request) throws Exception {
		
        int ret = 0;
        SqlWrapper sql = null;
        Service svc    = null;

		try{
			connect("pot"); 
			begin();

            sql = new SqlWrapper();
            svc = (Service) form.getService();
             
            int i=1;  
            
			HttpSession session     = request.getSession();
	        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
			String strSsno		= String2.nvl(form.getParam("strSsno"));
			String strCustName	= URLDecoder.decode(String2.trimToEmpty(form.getParam("strCustName")), "UTF-8");
			String strCustId	= String2.nvl(form.getParam("strCustId"));
			String strRtnCode	= String2.nvl(form.getParam("strRtnCode"));
			String strConfYn	= String2.nvl(form.getParam("strConfYn"));
			String strReqId		= sessionInfo.getUSER_ID();			
			
        	sql.put(svc.getQuery("INS_REAL_NAME")); 
            sql.setString(i++, strSsno);
            sql.setString(i++, strCustName);
            sql.setString(i++, strCustId);
            sql.setString(i++, strRtnCode);
            sql.setString(i++, strConfYn);
            sql.setString(i++, strReqId);
            ret = update(sql);
	        
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }     
        return ret + "";
	}	
	*/
	/**
	 * <p> SMS발송 로그등록 </p>
	 * 
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public String insRealMobile(ActionForm form, HttpServletRequest request) throws Exception {
		
        int ret = 0;
        SqlWrapper sql = null;
        SqlWrapper sql_1 = null;
        Service svc    = null;

		try{
			connect("pot"); 
			begin();

            sql = new SqlWrapper();
            sql_1 = new SqlWrapper();
            svc = (Service) form.getService();
             
            int i=1;  
            
			HttpSession session     = request.getSession();
	        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
	        String strSendSite	= String2.nvl(form.getParam("strSendSite"));
	        String strSendType	= String2.nvl(form.getParam("strSendType"));
	        String strCustName	= URLDecoder.decode(String2.trimToEmpty(form.getParam("strCustName")), "UTF-8");
	        String strCustId	= String2.nvl(form.getParam("strCustId"));
	        String strCellPhoneService	= String2.nvl(form.getParam("strCellPhoneService"));
			String strMobilePh1	= String2.nvl(form.getParam("strMobilePh1"));
			String strMobilePh2	= String2.nvl(form.getParam("strMobilePh2"));
			String strMobilePh3	= String2.nvl(form.getParam("strMobilePh3"));
			String strHP		= String2.nvl(form.getParam("strHP"));
			String strSMSMsg	= URLDecoder.decode(String2.trimToEmpty(form.getParam("strSMSMsg")), "UTF-8");
			String strReqId		= sessionInfo.getUSER_ID();
			
            
            sql.put(svc.getQuery("INS_REAL_MOBILE")); 
            sql.setString(i++, strSendSite);
            sql.setString(i++, strSendType);
            sql.setString(i++, strCustName);
            sql.setString(i++, strCustId);
            sql.setString(i++, strCellPhoneService);
            sql.setString(i++, strMobilePh1);
            sql.setString(i++, strMobilePh2);
            sql.setString(i++, strMobilePh3);
            sql.setString(i++, strSMSMsg);
            sql.setString(i++, strReqId);
            ret = update(sql);
            
            
            i=1;
                    
            sql_1.put(svc.getQuery("INS_SOM_MOBILE")); 
            sql_1.setString(i++, strHP);
            sql_1.setString(i++, strSMSMsg);
            ret = update(sql_1);
            
	        
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }     
        return ret + "";
	}	
	
	public List getcardno(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List ret = null;
        SqlWrapper sql = null;
        Service svc = null;
        Util util = new Util();
        String strQuery = "";
        int i = 1;  
        
        HttpSession session     = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
             
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        try {
            connect("pot");
        	begin();

      
            strQuery += "SELECT DPS.PR_SKUCD_KYS(COMM_NAME1+1) AS CARD_NO" + "\n";
            strQuery += "FROM COM.TC_COMMCODE" + "\n";
            strQuery += "WHERE SYS_PART = 'D'" + "\n";
            strQuery += "AND COMM_PART = 'D135'" + "\n";
            strQuery += "AND COMM_CODE = '1'" + "\n";
            strQuery += "AND USE_YN = 'Y'" + "\n";
            
            
            sql.put(strQuery);
            
            ret = select2List(sql);

            
            return ret;
        
	    } catch (Exception e) {
	    	rollback();
	    	throw e;
	    } finally {
	        end();
	    }
    }   
	/**
	 *
	 * 작성일 : 2015.04.23
	 * 작성자 : jwjeon
	 * 내   용 : url 데이터 전송
	 * @throws UnsupportedEncodingException 
	 * @throws UnknownHostException 
	 * 
	 */
	public boolean sendSMS (Map<String, String> param, String hostname, String path, String encodingType) throws UnsupportedEncodingException, UnknownHostException, IOException {
		
		boolean isOK = false;
		BufferedWriter wr = null;
		Socket socket =  null;
		
		/*try {
			
			String data = URLEncoder.encode("enc_type", encodingType) + "=" + URLEncoder.encode(param.get("enc_type"), encodingType);
	        data += "&" + URLEncoder.encode("mail_code", encodingType) + "=" + URLEncoder.encode(param.get("mail_code"), encodingType);
	        data += "&" + URLEncoder.encode("user_id", encodingType) + "=" + URLEncoder.encode(param.get("user_id"), encodingType);
	        data += "&" + URLEncoder.encode("auth_key", encodingType) + "=" + URLEncoder.encode(param.get("auth_key"), encodingType);
	        data += "&" + URLEncoder.encode("mem_id", encodingType) + "=" + URLEncoder.encode(param.get("mem_id"), encodingType);
	        data += "&" + URLEncoder.encode("mem_name", encodingType) + "=" + URLEncoder.encode(param.get("mem_name"), encodingType);
	        data += "&" + URLEncoder.encode("mem_phone", encodingType) + "=" + URLEncoder.encode(param.get("mem_phone"), encodingType);
	        data += "&" + URLEncoder.encode("M1", encodingType) + "=" + URLEncoder.encode(param.get("M1"), encodingType);
	        data += "&" + URLEncoder.encode("M2", encodingType) + "=" + URLEncoder.encode(param.get("M2"), encodingType);
	        data += "&" + URLEncoder.encode("M3", encodingType) + "=" + URLEncoder.encode(param.get("M3"), encodingType);
	        
	        // Create a socket to the host
//	        String hostname = "postman.co.kr";
	        int port = 80;
	        InetAddress addr = InetAddress.getByName(hostname);
	        socket = new Socket(addr, port);

	        // Send header
//	        String path = "/open/auto_message_sender.jsp";
	        wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), encodingType));
	        wr.write("POST "+path+" HTTP/1.0\r\n");
	        wr.write("Content-Length: "+data.length()+"\r\n");
	        wr.write("Content-Type: application/x-www-form-urlencoded\r\n");
	        wr.write("\r\n");

	        // Send data
	        //wr.write(data);   //기존 업체 변경으로 인해 문자 발송 중지 20160218_강연식
	        wr.flush();
	        
	        isOK = true;
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (wr != null)
				wr.close();
			if (socket != null)
				socket.close();
		}*/
		
		return isOK;
	}


	
/*	
	public String insRealName(ActionForm form, HttpServletRequest request) throws Exception {
		
		String ret = "";
		ProcedureWrapper psql = null;
		Util util = new Util();

		try{
			connect("pot"); 
			begin();
			psql = new ProcedureWrapper();
			int i=1; 
			ProcedureResultSet prs = null;
			
			HttpSession session     = request.getSession();
	        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
			String strSsno		= String2.nvl(form.getParam("strSsno"));
			String strCustName	= URLDecoder.decode(String2.trimToEmpty(form.getParam("strCustName")), "UTF-8");
			String strCustId	= String2.nvl(form.getParam("strCustId"));
			String strRtnCode	= String2.nvl(form.getParam("strRtnCode"));
			String strConfYn	= String2.nvl(form.getParam("strConfYn"));
			String strReqId		= sessionInfo.getUSER_ID();			
			
			psql.put("DCS.PR_REAL_NAME_INSERT", 8);
			
			psqutil.encryptedStr(strSsno)       );
			psql.setString(i++,  strCustName   );
			psql.setString(i++,  strCustId     );
			psql.setString(i++,  strRtnCode    );
			psql.setString(i++,  strConfYn     );
			psql.setString(i++,  strReqId      );
	
	        psql.registerOutParameter(i++, DataTypes.INTEGER);
	        psql.registerOutParameter(i++, DataTypes.VARCHAR);
	        
	        prs = updateProcedure(psql);
	        
	        ret = prs.getString(7);
	        
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }     
        return ret;
	}
	
	
*/
	
	/**
     * <p>핸드폰번호 존재CHK</p>
     * 
     * @created  on 1.0, 2010/02/14
     * @created  by 김영진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
	 public List chkDupHp(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	        List ret = null;
	        SqlWrapper sql = null;
	        Service svc = null;
	        Util util = new Util();
	        String strQuery = "";
	        int i = 1;  
	        
	        HttpSession session     = request.getSession();
	        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
	        
	        String strHp1 = String2.nvl(form.getParam("strHp1"));
	        String strHp2 = String2.nvl(form.getParam("strHp2"));
	        String strHp3 = String2.nvl(form.getParam("strHp3"));
	        
	        sql = new SqlWrapper();
	        svc = (Service) form.getService();

	        try {
	            connect("pot");
	        	//begin();
 
	            strQuery = svc.getQuery("SEL_DUP_CHK") + "\n";
	            sql.put(strQuery);
	            sql.setString(i++,  strHp1      );
	            sql.setString(i++,  strHp2      );
	            sql.setString(i++,  strHp3      );
	            
	            ret = select2List(sql);
	                       
	
	            return ret;
	        
		    } catch (Exception e) {
		    	throw e;
		    } finally {
		        //end();
		    }
	    }
	 
	 	/**
	     * <p>탈퇴 내역 CHK</p>
	     * 
	     * @created  on 1.0, 2010/02/14
	     * @created  by 김영진
	     * 
	     * @modified on 
	     * @modified by 
	     * @caused   by 
	     */
		 public List chkScedCust(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		        List ret = null;
		        SqlWrapper sql = null;
		        Service svc = null;
		        Util util = new Util();
		        String strQuery = "";
		        int i = 1;  
		        
		        HttpSession session     = request.getSession();
		        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
		        
		        String strHp1 = String2.nvl(form.getParam("strHp1"));
		        String strHp2 = String2.nvl(form.getParam("strHp2"));
		        String strHp3 = String2.nvl(form.getParam("strHp3"));
		        
		        sql = new SqlWrapper();
		        svc = (Service) form.getService();

		        try {
		            connect("pot");
		        	//begin();
	 
		            strQuery = svc.getQuery("SEL_SCED_CHK") + "\n";
		            sql.put(strQuery);
		            sql.setString(i++,  strHp1      );
		            sql.setString(i++,  strHp2      );
		            sql.setString(i++,  strHp3      );
		            
		            ret = select2List(sql);
		                       
		
		            return ret;
		        
			    } catch (Exception e) {
			    	throw e;
			    } finally {
			        //end();
			    }
		    }
	 
		

	 public List insRealName(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	 		

	 	

	 		 List ret = null;
		     SqlWrapper sql = null;
		     Service svc = null;
		     String strQuery = "";
		     String strSmsCd = "";
		     String ret2 = "";

			 ProcedureWrapper psql = null;
			 
			 HttpSession session     = request.getSession();
		     SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
	 		
 			String strHp1 = String2.nvl(form.getParam("strHp1"));
	        String strHp2 = String2.nvl(form.getParam("strHp2"));
	        String strHp3 = String2.nvl(form.getParam("strHp3"));
	        String strUserId		= sessionInfo.getUSER_ID();	
	        String strSendGb		= String2.nvl(form.getParam("strSendGb"));
	        
	        String strHP  = strHp1 + strHp2 + strHp3 ;
	 		
	        psql = new ProcedureWrapper();
			int i=1; 
			ProcedureResultSet prs = null;
			
	        
	        
	        sql = new SqlWrapper();
	        svc = (Service) form.getService();
	 		try{
	 			connect("pot"); 
	 			
	 			strQuery = svc.getQuery("SEL_SMS_CD") + "\n";
	            sql.put(strQuery);
	            //sql.setString(i++,  strHp1      );

	            
	            ret = select2List(sql);
	 			
	            

	            strSmsCd = ret.toString();
	            
	            //strSmsCd.replaceAll("[", "");
	            //strSmsCd.replaceAll("]", "");
	            
	 			System.out.println(strSmsCd);
	 			
	 			strQuery = "";
	 			
	 			begin();
	 			
	 			/*
	 			strQuery = svc.getQuery("INS_SMS_SMST") + "\n";
	 			sql2.put(strQuery);
	 			sql2.setString(i++,  strHP      );
	 			sql2.setString(i++,  strHP      );
	 			sql2.setString(i++,  strSmsCd      );
	 			
	 			
	 			select2List(sql2);

	 			i = 1;
	 			
	 			
	 			strQuery = "";
	 			
	 			strQuery = svc.getQuery("INS_SMS_EMTRAN") + "\n";
	 			sql2.put(strQuery);
	 			sql2.setString(i++,  strHP      );
	 			sql2.setString(i++,  strHP      );
	 			sql2.setString(i++,  strSmsCd      );
	 	        
	 			select2List(sql2);
	 			
	 			
	 			*/
	 			if (strSendGb.equals("SMS_ARTBAT"))		//배치용 발송 서비스 
	 				psql.put("DPS.PR_MEMBSMS_NEW", 5);
	 			else
	 				psql.put("DPS.PR_MEMBSMS", 5);		// 일반발송용
	 			
				psql.setString(i++,  strHP   );
				psql.setString(i++,  strSmsCd     );
				psql.setString(i++,  strUserId     );
		        psql.registerOutParameter(i++, DataTypes.INTEGER);
		        psql.registerOutParameter(i++, DataTypes.VARCHAR);
		        
		        prs = updateProcedure(psql);
		        
		        ret2 = prs.getString(5);
	 			
		        commit();
		        
	         } catch (Exception e) {
	             rollback();
	             throw e;
	         } finally {
	             end();
	         }     
	         return ret;
	 	}
	 	
	 	

}

