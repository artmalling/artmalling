/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>협력사 사원관리  </p>
 * 
 * @created  on 1.0, 2012/07/10
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCodC01DAO extends AbstractDAO {

	/**
	 * 마스터 테이블을 조회한다.
	 * @param form
	 * @param mi
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi, HttpServletRequest request, String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String  strStrCd		= String2.nvl(form.getParam("strStrCd"));		//점코드
		String  strVenCd		= String2.nvl(form.getParam("strVenCd"));		//협력사 코드
		String  strPumBun		= String2.nvl(form.getParam("strPumBun"));		//브랜드 코드
		String  strKorNm		= URLDecoder.decode(String2.nvl(form.getParam("strKorNm")), "UTF-8");	//성명
		String  strWorkType		= String2.nvl(form.getParam("strWorkType"));	//퇴사구분값
		String  strGJDate		= String2.nvl(form.getParam("strGJDate"));		//기준일
		String  strSStartDt		= String2.nvl(form.getParam("strSStartDt"));	//조회기간 시작
		String  strSEndDt		= String2.nvl(form.getParam("strSEndDt"));		//조회기간 종료
		String  strEdu   		= String2.nvl(form.getParam("strEdu"));		    //cs교육
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		try{
			strQuery = svc.getQuery("SEL_MASTER") + "\n";
			
			sql.setString(i++, userId);
			
			//점코드
			if(!strStrCd.equals("")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_STR_CD") + "\n";
				sql.setString(i++, strStrCd);
			}
			
			//협력사 코드
			if(!strVenCd.equals("")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_VEC_CD") + "\n";
				sql.setString(i++, strVenCd);
			}
			
			//브랜드 코드
			if(!strPumBun.equals("")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_PUMBUN_CD") + "\n";
				sql.setString(i++, strPumBun); 
			}
			
			//성명
			if(!strKorNm.equals("")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_KOR_NM") + "\n";
				sql.setString(i++, strKorNm);
			}
			
			//CS 교육조건
			if(strEdu.equals("00")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_EDU1") + "\n";
				sql.setString(i++, "T");	//확인필요
			}
			if(strEdu.equals("01")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_EDU2") + "\n";
				sql.setString(i++, "T");	//확인필요
			}
			if(strEdu.equals("02")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_EDU3") + "\n";
				sql.setString(i++, "T");	//확인필요
			}
			if(strEdu.equals("03")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_EDU4") + "\n";
				sql.setString(i++, "T");	//확인필요
			}
			
			
			//퇴사구분값
			if(!strWorkType.equals("")) {
				
				strQuery += svc.getQuery("SEL_MASTER_W_WORK_TYPE") + "\n";
				sql.setString(i++, strWorkType);
			}
			
			
			//기준일에 따라 날자 변경
			
			String queryName = "";
			if(!strGJDate.equals("")) {
				switch (Integer.parseInt(strGJDate)) {
					case 01 :	//입점일
						queryName = "INSERT_DT";
						
						strQuery += svc.getQuery("SEL_MASTER_W_" + queryName) + "\n";
						sql.setString(i++, strSStartDt);
						sql.setString(i++, strSEndDt);
						break;
					case 02 :	//퇴점일
						queryName = "OUTSTR_DT";
						
						strQuery += svc.getQuery("SEL_MASTER_W_" + queryName) + "\n";
						sql.setString(i++, strSStartDt);
						sql.setString(i++, strSEndDt);
						break;
					case 03 :	//등록일
						queryName = "REG_DATE";
						
						strQuery += svc.getQuery("SEL_MASTER_W_" + queryName) + "\n";
						sql.setString(i++, strSStartDt);
						sql.setString(i++, strSEndDt);
						break;
					case 04 :	//생년월일
						queryName = "BIRTH_DT";
						
						strQuery += svc.getQuery("SEL_MASTER_W_" + queryName) + "\n";
						sql.setString(i++, strSStartDt);
						sql.setString(i++, strSEndDt);
						break;
					default :
						
						strQuery += svc.getQuery("SEL_MASTER_W_" + queryName) + "\n";
						sql.setString(i++, strSStartDt);
						sql.setString(i++, strSEndDt);
					
				}
			}
				
			sql.put(strQuery);
			
			ret = select2List(sql);
			
			Util util = new Util();
			
			
			//암호화 된 데이터 해제
			/*ret = util.decryptedStr(ret,1);		//암호화 해제(RESI_NO, 주민번호)
			ret = util.decryptedStr(ret,18);	//암호화 해제(HOME_PH1, 전화번호1)
			ret = util.decryptedStr(ret,19);	//암호화 해제(HOME_PH2, 전화번호2)
			ret = util.decryptedStr(ret,20);	//암호화 해제(HOME_PH3, 전화번호3)
			ret = util.decryptedStr(ret,21);	//암호화 해제(MOBILE_PH1, 핸드폰번호1)
			ret = util.decryptedStr(ret,22);	//암호화 해제(MOBILE_PH2, 핸드폰번호2)
			ret = util.decryptedStr(ret,23);	//암호화 해제(MOBILE_PH3, 핸드폰번호3)
			ret = util.decryptedStr(ret,28);	//암호화 해제(EMAIL1, 이메일1)
			ret = util.decryptedStr(ret,29);	//암호화 해제(EMAIL2, 이메일2)
			
			ret = util.decryptedStr(ret,38);	//암호화 해제(RESI_NO, 주민번호)
			ret = util.decryptedStr(ret,53);	//암호화 해제(HOME_PH1, 전화번호1)
			ret = util.decryptedStr(ret,54);	//암호화 해제(HOME_PH2, 전화번호2)
			ret = util.decryptedStr(ret,55);	//암호화 해제(HOME_PH3, 전화번호3)
			ret = util.decryptedStr(ret,56);	//암호화 해제(MOBILE_PH1, 핸드폰번호1)
			ret = util.decryptedStr(ret,57);	//암호화 해제(MOBILE_PH2, 핸드폰번호2)
			ret = util.decryptedStr(ret,58);	//암호화 해제(MOBILE_PH3, 핸드폰번호3)
			ret = util.decryptedStr(ret,59);	//암호화 해제(EMAIL1, 이메일1)
			ret = util.decryptedStr(ret,60);	//암호화 해제(EMAIL2, 이메일2) */
		}catch(Exception e){
			e.printStackTrace();
		}

		return ret;
	}
	
	public List searchdetail(ActionForm form, MultiInput mi, HttpServletRequest request) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String  venemp_id		= String2.nvl(form.getParam("venemp_id"));		
		String  flag			= String2.nvl(form.getParam("flag"));		

		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		try{
			strQuery = svc.getQuery("SEL_DETAIL") + "\n";
				
			sql.setString(i++, venemp_id);
			sql.setString(i++, flag);
				
			sql.put(strQuery);
			
			ret = select2List(sql);
			
			
		}catch(Exception e){
			e.printStackTrace();
		}

		return ret;
	}
	
	
	public int save(ActionForm form, MultiInput mi1,String userId, String org_flag)
	throws Exception {
		int ret 	= 0;
		int res 	= 0;
		int i   	= 1; 
		String strQuery = "";
		
		SqlWrapper sql = null;
		Service svc = null;
		Util util = new Util();
		
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			
			while (mi1.next()) {
				sql.close();
				if (mi1.IS_INSERT()) { // 저장
					
					//String zipCodeFull =mi1.getString("HOME_ZIP_CD");//우편번호 1,2로 나누기
					//String zipCode1=zipCodeFull.substring(0,3);
					//String zipCode2=zipCodeFull.substring(3);
					//String orZipCode1="";
					//String orZipCode2="";
					
					sql.put(svc.getQuery("INS_MASTER"));
					String JuminNo = mi1.getString("RESI_NO");
				    String JuminShake = JuminNo;
									    
				    
					//sql.setString(i++, util.encryptedStr(mi1.getString("RESI_NO")));     
					sql.setString(i++, JuminShake);
					sql.setString(i++, mi1.getString("KOR_NM"));     
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
					sql.setString(i++, mi1.getString("VEN_CD"));       
					sql.setString(i++, mi1.getString("JOB_CD"));     
					sql.setString(i++, mi1.getString("BIRTH_DT"));     
					sql.setString(i++, mi1.getString("BIRTH_LUNAR_FLAG"));    
					sql.setString(i++, mi1.getString("SEX_CD"));    
					sql.setString(i++, mi1.getString("INSTR_DT"));    
					sql.setString(i++, mi1.getString("HOME_NEW_YN")); //자택 새 주소 YN
					sql.setString(i++, mi1.getString("HOME_ZIP_CD"));
					sql.setString(i++, mi1.getString("HOME_ZIP_CD"));
					sql.setString(i++, mi1.getString("HOME_ADDR1"));
					sql.setString(i++, mi1.getString("HOME_ADDR2"));
					sql.setString(i++, mi1.getString("HOME_ZIP_CD"));
					sql.setString(i++, mi1.getString("HOME_ZIP_CD"));
					sql.setString(i++, mi1.getString("HOME_ADDR1"));
					sql.setString(i++, mi1.getString("HOME_ADDR2"));
					
					String homePh1=mi1.getString("HOME_PH1");//자택번호 암호화
					String strHomePh1=homePh1;//자택번호 암호화
					String homePh2=mi1.getString("HOME_PH2");//자택번호 암호화
					String strHomePh2=homePh2;//자택번호 암호화
					String homePh3=mi1.getString("HOME_PH3");//자택번호 암호화
					String strHomePh3=homePh3;//자택번호 암호화
					
					sql.setString(i++, strHomePh1);
					sql.setString(i++, strHomePh2);
					sql.setString(i++, strHomePh3);
					
					
					String strMobilePh1="";
					String strMobilePh2="";
					String strMobilePh3="";
					if(mi1.getString("MOBILE_PH1").equals("")){
					}else{
						String MobilePh1=mi1.getString("MOBILE_PH1");//핸드폰번호 암호화
						strMobilePh1=MobilePh1;//
						String Mobile2=mi1.getString("MOBILE_PH2");//핸드폰번호 암호화
						strMobilePh2=Mobile2;//
						String Mobile3=mi1.getString("MOBILE_PH3");//핸드폰번호 암호화
						strMobilePh3=Mobile3;//
						
					}
					sql.setString(i++, strMobilePh1);
					sql.setString(i++, strMobilePh2);
					sql.setString(i++, strMobilePh3);
					
					sql.setString(i++, mi1.getString("ORGN_NEW_YN"));//본적 새 주소 YN

					sql.setString(i++, mi1.getString("ORGN_ZIP_CD"));
					sql.setString(i++, mi1.getString("ORGN_ZIP_CD"));
					sql.setString(i++, mi1.getString("ORGN_ADDR1"));
					sql.setString(i++, mi1.getString("ORGN_ADDR2"));
					sql.setString(i++, mi1.getString("ORGN_ZIP_CD"));
					sql.setString(i++, mi1.getString("ORGN_ZIP_CD"));
					sql.setString(i++, mi1.getString("ORGN_ADDR1"));
					sql.setString(i++, mi1.getString("ORGN_ADDR2"));
					
					sql.setString(i++, mi1.getString("DOMAIN_FLAG"));
					String Email=mi1.getString("EMAIL1");
					String strEmail1=Email;//email암호화
					
					sql.setString(i++, strEmail1);
					if(mi1.getString("EMAIL2").equals("")){
						sql.setString(i++, mi1.getString("EMAIL2"));
					}else{
						String Email2=mi1.getString("EMAIL2");
						String strEmail2=Email2;//email2암호화
						sql.setString(i++, strEmail2);
					}
					sql.setString(i++, mi1.getString("OUTSTR_DT"));
					sql.setString(i++, mi1.getString("TEMP_PASS_NO"));
					sql.setString(i++, mi1.getString("TEMP_PASS_ISSUE_DT"));
					sql.setString(i++, mi1.getString("TEMP_PASS_RET_DT"));
					sql.setString(i++, mi1.getString("EMP_ID_ISSUE_DT"));
					sql.setString(i++, mi1.getString("MEMO"));
					sql.setString(i++, mi1.getString("WED_YN"));
					sql.setString(i++, userId);  
					sql.setString(i++, userId);       
					sql.setString(i++, mi1.getString("WORK_COMP4"));
					sql.setString(i++, mi1.getString("WORK_BRD4"));
					sql.setString(i++, mi1.getString("WORK_JOB4"));
					sql.setString(i++, mi1.getString("WORK_LOCATION4"));
						
					
				}else if(mi1.IS_UPDATE()){// 수정 
					i = 1;
					// 1. 마스터테이블에 수정
					
					sql.put(svc.getQuery("UPD_MASTER")); 
					//String zipCodeFull =mi1.getString("HOME_ZIP_CD");//우편번호 1,2로 나누기
					
					//String zipCode1=zipCodeFull.substring(0,3);
					
					//String zipCode2=zipCodeFull.substring(3);
					
					//String orZipCode1="";
					//String orZipCode2="";
					
					
					sql.setString(i++, mi1.getString("KOR_NM"));
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("VEN_CD"));
					sql.setString(i++, mi1.getString("JOB_CD"));
					sql.setString(i++, mi1.getString("BIRTH_DT"));
					sql.setString(i++, mi1.getString("BIRTH_LUNAR_FLAG"));
					sql.setString(i++, mi1.getString("SEX_CD"));
					sql.setString(i++, mi1.getString("INSTR_DT"));
					sql.setString(i++, mi1.getString("HOME_NEW_YN"));
					
					sql.setString(i++, mi1.getString("HOME_ZIP_CD"));
					sql.setString(i++, mi1.getString("HOME_ZIP_CD"));
					sql.setString(i++, mi1.getString("HOME_ADDR1"));
					sql.setString(i++, mi1.getString("HOME_ADDR2"));
					sql.setString(i++, mi1.getString("HOME_ZIP_CD"));
					sql.setString(i++, mi1.getString("HOME_ZIP_CD"));
					sql.setString(i++, mi1.getString("HOME_ADDR1"));
					sql.setString(i++, mi1.getString("HOME_ADDR2"));
					
					String homePh1=mi1.getString("HOME_PH1");//자택번호 암호화
					String strHomePh1=homePh1;//자택번호 암호화
					String homePh2=mi1.getString("HOME_PH2");//자택번호 암호화
					String strHomePh2=homePh2;//자택번호 암호화
					String homePh3=mi1.getString("HOME_PH3");//자택번호 암호화
					String strHomePh3=homePh3;//자택번호 암호화
					
					sql.setString(i++, strHomePh1);
					sql.setString(i++, strHomePh2);
					sql.setString(i++, strHomePh3);
					
					String strMobilePh1="";
					String strMobilePh2="";
					String strMobilePh3="";
					if(mi1.getString("MOBILE_PH1").equals("")){
					}else{
						String MobilePh1=mi1.getString("MOBILE_PH1");//핸드폰번호 암호화
						strMobilePh1=MobilePh1;//
						String Mobile2=mi1.getString("MOBILE_PH2");//핸드폰번호 암호화
						strMobilePh2=Mobile2;//
						String Mobile3=mi1.getString("MOBILE_PH3");//핸드폰번호 암호화
						strMobilePh3=Mobile3;//
						
					}
					sql.setString(i++, strMobilePh1);
					sql.setString(i++, strMobilePh2);
					sql.setString(i++, strMobilePh3);
					
					sql.setString(i++, mi1.getString("ORGN_NEW_YN"));
					
					
					sql.setString(i++, mi1.getString("ORGN_ZIP_CD"));
					sql.setString(i++, mi1.getString("ORGN_ZIP_CD"));
					sql.setString(i++, mi1.getString("ORGN_ADDR1"));
					sql.setString(i++, mi1.getString("ORGN_ADDR2"));
					sql.setString(i++, mi1.getString("ORGN_ZIP_CD"));
					sql.setString(i++, mi1.getString("ORGN_ZIP_CD"));
					sql.setString(i++, mi1.getString("ORGN_ADDR1"));
					sql.setString(i++, mi1.getString("ORGN_ADDR2"));
					
					
					sql.setString(i++, mi1.getString("DOMAIN_FLAG"));
					String Email=mi1.getString("EMAIL1");
					String strEmail1=Email;//email암호화
					
					sql.setString(i++, strEmail1);
					if(mi1.getString("EMAIL2").equals("")){
						sql.setString(i++, mi1.getString("EMAIL2"));
					}else{
						if(mi1.getString("DOMAIN_FLAG").equals("99")){
							String Email2=mi1.getString("EMAIL2");
							String strEmail2=Email2;//email2암호화
							sql.setString(i++, strEmail2);
							
						}else{
							sql.setString(i++, "");
						}
					}
					sql.setString(i++, mi1.getString("OUTSTR_DT"));
					sql.setString(i++, mi1.getString("TEMP_PASS_NO"));
					sql.setString(i++, mi1.getString("TEMP_PASS_ISSUE_DT"));
					sql.setString(i++, mi1.getString("TEMP_PASS_RET_DT"));
					sql.setString(i++, mi1.getString("EMP_ID_ISSUE_DT"));
					sql.setString(i++, mi1.getString("MEMO"));
					sql.setString(i++, mi1.getString("WED_YN"));
					sql.setString(i++, mi1.getString("WORK_TYPE")); 						
					sql.setString(i++, mi1.getString("TEMP_ENT_SUP_YN"));				
					sql.setString(i++, mi1.getString("TEMP_ENT_SUP_S_DT"));				
					sql.setString(i++, mi1.getString("TEMP_ENT_SUP_E_DT"));				
					sql.setString(i++, mi1.getString("BRD_FIX_AR_YN"));					
					sql.setString(i++, mi1.getString("BRD_FIX_AR_S_DT"));				
					sql.setString(i++, mi1.getString("BRD_FIX_AR_E_DT"));				
					sql.setString(i++, mi1.getString("LONG_ENT_SUP_YN"));				
					sql.setString(i++, mi1.getString("LONG_ENT_SUP_S_DT"));				
					sql.setString(i++, mi1.getString("LONG_ENT_SUP_E_DT"));				
					sql.setString(i++, mi1.getString("LONG_WORK_YN"));			 
					sql.setString(i++, mi1.getString("LONG_WORK_S_DT"));			
					sql.setString(i++, mi1.getString("LONG_WORK_E_DT"));			
					sql.setString(i++, mi1.getString("HI_SCHL_GRDU_YM"));			
					sql.setString(i++, mi1.getString("HI_SCHL_NM"));					
					sql.setString(i++, mi1.getString("HI_SCHL_LOCATION"));		  
					sql.setString(i++, mi1.getString("HI_SCHL_GRUD_FLAG"));			
					sql.setString(i++, mi1.getString("UNIVST_GRDU_YM"));			
					sql.setString(i++, mi1.getString("UNIVST_NM"));						
					sql.setString(i++, mi1.getString("UNIVST_LOCATION"));			
					sql.setString(i++, mi1.getString("UNIVST_GRDU_FLAG"));		  
					sql.setString(i++, mi1.getString("GRDU_SCHL_GRDU_YM"));			
					sql.setString(i++, mi1.getString("GRDU_SCHL_NM"));				
					sql.setString(i++, mi1.getString("GRDU_SCHL_LOCATION"));	  
					sql.setString(i++, mi1.getString("GRDU_SCHL_GRDU_FLAG"));  
					sql.setString(i++, mi1.getString("WORK_S_DT1"));					
					sql.setString(i++, mi1.getString("WORK_E_DT1"));					
					sql.setString(i++, mi1.getString("WORK_COMP1"));					
					sql.setString(i++, mi1.getString("WORK_BRD1"));						
					sql.setString(i++, mi1.getString("WORK_JOB1"));						
					sql.setString(i++, mi1.getString("WORK_LOCATION1"));			
					sql.setString(i++, mi1.getString("WORK_S_DT2"));					
					sql.setString(i++, mi1.getString("WORK_E_DT2"));					
					sql.setString(i++, mi1.getString("WORK_COMP2"));					
					sql.setString(i++, mi1.getString("WORK_BRD2"));						
					sql.setString(i++, mi1.getString("WORK_JOB2"));						
					sql.setString(i++, mi1.getString("WORK_LOCATION2"));			
					sql.setString(i++, mi1.getString("WORK_S_DT3"));					
					sql.setString(i++, mi1.getString("WORK_E_DT3"));					
					sql.setString(i++, mi1.getString("WORK_COMP3"));					
					sql.setString(i++, mi1.getString("WORK_BRD3"));						
					sql.setString(i++, mi1.getString("WORK_JOB3"));						
					sql.setString(i++, mi1.getString("WORK_LOCATION3"));			
					sql.setString(i++, mi1.getString("WORK_S_DT4"));					
					sql.setString(i++, mi1.getString("WORK_E_DT4"));					
					sql.setString(i++, mi1.getString("WORK_COMP4"));					
					sql.setString(i++, mi1.getString("WORK_BRD4"));						
					sql.setString(i++, mi1.getString("WORK_JOB4"));						
					sql.setString(i++, mi1.getString("WORK_LOCATION4"));					
					sql.setString(i++, userId);
					String JuminNo = mi1.getString("RESI_NO");
				    String JuminShake = JuminNo;
					sql.setString(i++, JuminShake);
					
					sql.setString(i++, mi1.getString("VENEMP_ID"));
										
		
				}else if (mi1.IS_DELETE()) { // 삭제 
					i = 1;  
					// 1. 마스터테이블에 저장
					
					sql.put(svc.getQuery("DEL_MASTER")); 
					//sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("VENEMP_ID"));
					//String JuminNo = mi1.getString("RESI_NO");
					
				    //String JuminShake = util.encryptedStr(JuminNo);
					
					//sql.setString(i++, JuminShake);
				}
				res = update(sql);
		
				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				} 
				
				ret += res;
			}
		} catch (Exception e) { 
			e.printStackTrace();
		} finally { 
			end();
		}
		return ret;
	}
	
	public int savedetail(ActionForm form, MultiInput mi1,String userId, String org_flag)
			throws Exception {
				int ret 	= 0;
				int res 	= 0;
				int i   	= 1; 
				String strQuery = "";
				
				SqlWrapper sql = null;
				Service svc = null;
				Util util = new Util();
				
				
				try {
					connect("pot");
					begin();
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					// 마스터
					
					while (mi1.next()) {
						sql.close();
						if (mi1.IS_INSERT()) { // 저장
														
							sql.put(svc.getQuery("INS_DETAIL"));
								
							sql.setString(i++, mi1.getString("VENEMP_ID"));
							sql.setString(i++, mi1.getString("VENEMP_ID"));
							sql.setString(i++, "5");
							sql.setString(i++, mi1.getString("VENEMP_ID"));
							sql.setString(i++, "5");
							sql.setString(i++, mi1.getString("DTL_CONTENTS"));
							sql.setString(i++, userId);  
							sql.setString(i++, userId);       
								
								
							
						}else if(mi1.IS_UPDATE()){// 수정 
							i = 1;
							// 1. 마스터테이블에 수정
							
							sql.put(svc.getQuery("UPD_DETAIL")); 
								
							sql.setString(i++, mi1.getString("DTL_CONTENTS"));					
							sql.setString(i++, userId);
							sql.setString(i++, mi1.getString("VENEMP_ID"));
							sql.setString(i++, "5");
							sql.setString(i++, mi1.getString("DTL_SEQ_NO"));
																			
				
						}else if (mi1.IS_DELETE()) { // 삭제 
							i = 1;  
							// 1. 마스터테이블에 저장
							
							sql.put(svc.getQuery("DEL_DETAIL")); 
							
							sql.setString(i++, userId);
							sql.setString(i++, mi1.getString("VENEMP_ID"));
							sql.setString(i++, "5");
							sql.setString(i++, mi1.getString("DTL_SEQ_NO"));
							
						}
						res = update(sql);
				
						if (res <= 0) {
							throw new Exception("" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						} 
						
						ret += res;
					}
				} catch (Exception e) { 
					e.printStackTrace();
				} finally { 
					end();
				}
				return ret;
			}
	
	public int delete(ActionForm form, MultiInput mi1,String userId, String org_flag)
	throws Exception {
		int ret 	= 0;
		int res 	= 0;
		int i   	= 1; 
		String strQuery = "";
		
		SqlWrapper sql = null;
		Service svc = null;
		Util util = new Util();
		
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				//sql.close();
				if (mi1.IS_DELETE()) { // 삭제 
					i = 1;  
					// 1. 마스터테이블에 저장
					
					sql.put(svc.getQuery("DEL_MASTER"));
					
					sql.setString(i++, mi1.getString("VENEMP_ID"));
					//sql.setString(i++, util.encryptedStr(mi1.getString("RESI_NO")));
				}
				res = update(sql);
		
				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				} 
				
				ret += res;
			}
		} catch (Exception e) { 
			e.printStackTrace();
		} finally { 
			end();
		}
		return ret;
	}
	
}
