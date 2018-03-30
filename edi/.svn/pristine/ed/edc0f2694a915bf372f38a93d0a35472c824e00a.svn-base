package esal.dao;


import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import ecom.util.Util;


public class Esal110DAO extends AbstractDAO{
	
	/**
	 * 브랜드별 단골고객 리스트 조회
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String getList(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Util      util = new Util();
		List list = null;
		String rtJson = null;
		String strQuery = "";
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  
			String strcd 		= String2.nvl(form.getParam("strcd"));		//점코드
			String strVencd 	= String2.nvl(form.getParam("vencd"));		//협력사코드
			String strPumbuncd 	= String2.nvl(form.getParam("pubumCd"));	//품번코드
			String strCustName 	= URLDecoder.decode(String2.nvl(form.getParam("custName")), "UTF-8");	//고객명
			String strCardNo 	= util.encryptedStr(String2.nvl(form.getParam("cardNo")));		//카드번호
			String strSDate 	= String2.nvl(form.getParam("sDate"));		//등록시작일
			String strEDate 	= String2.nvl(form.getParam("eDate"));		//등록종료일

			connect("pot");
			
			strQuery = svc.getQuery("SEL_LIST") +"\n";
			
			sql.setString(++i, strcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			//System.out.println("strCustName : " + strCustName);
			//System.out.println("strCardNo : " + strCardNo);
			//System.out.println("strSDate : " + strSDate);
			//System.out.println("strEDate : " + strEDate);
			
			if(!strCustName.equals("")) {
				strQuery += svc.getQuery("SEL_LIST_CUST_NAME") +"\n";
				sql.setString(++i, strCustName + "%");
			}
			
			if(!strCardNo.equals("")) {
				strQuery += svc.getQuery("SEL_LIST_CARD_NO") +"\n";
				sql.setString(++i, util.encryptedStr(strCardNo));
			}
			
			if(!strSDate.equals("") && !strEDate.equals("")) {
				strQuery += svc.getQuery("SEL_LIST_REG_DATE") +"\n";
				sql.setString(++i, strSDate);
				sql.setString(++i, strEDate);
			}
			
		
			sql.put(strQuery);
			
			
			list = select2List(sql);
			
			list = util.decryptedStr(list,3);	//암호화 해제(CARD_NO)
			list = util.decryptedStr(list,4);	//암호화 해제(MOBILE_PH1)
			list = util.decryptedStr(list,5);	//암호화 해제(MOBILE_PH2)
			list = util.decryptedStr(list,6);	//암호화 해제(MOBILE_PH3)
			
			String	cols= "REGUCUST_ID,CUST_NAME,BIRTH_DT,CARD_NO,MOBILE_PH1,MOBILE_PH2,MOBILE_PH3,REG_DATE,SEQ_NO";
			rtJson = util.listToJsonOBJ(list, cols);
			
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
	
	/**
	 * 단골고객 상세 조회
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String getDetailList(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Util      util = new Util();
		List list = null;
		String rtJson = null;
		String strQuery = "";
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  
			String strcd 			= String2.nvl(form.getParam("strcd"));		//점코드
			String strVencd 		= String2.nvl(form.getParam("vencd"));		//협력사코드
			//String strPumbuncd 		= String2.nvl(form.getParam("pubumCd"));	//품번코드
			String strReguCustId 	= String2.nvl(form.getParam("reguCustId"));	//단골고객번호
			String strSeqNo 		= String2.nvl(form.getParam("seqNo"));		//순번

			connect("pot");
			
			sql.put(svc.getQuery("SEL_DETAILLIST"));
			
			sql.setString(++i, strcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strSeqNo);
			sql.setString(++i, strReguCustId);
			
			list = select2List(sql);
			
			list = util.decryptedStr(list,4);	//암호화 해제(CARD_NO)
			list = util.decryptedStr(list,16);	//암호화 해제(HOME_PH1)
			list = util.decryptedStr(list,17);	//암호화 해제(HOME_PH2)
			list = util.decryptedStr(list,18);	//암호화 해제(HOME_PH3)
			list = util.decryptedStr(list,19);	//암호화 해제(MOBILE_PH1)
			list = util.decryptedStr(list,20);	//암호화 해제(MOBILE_PH2)
			list = util.decryptedStr(list,21);	//암호화 해제(MOBILE_PH3)
			list = util.decryptedStr(list,48);	//암호화 해제(EMAIL1)
			list = util.decryptedStr(list,49);	//암호화 해제(EMAIL2)
			
			//System.out.println("list : " + list);
			
			String cols = "STR_CD,VEN_CD,PUMBUN_CD,CUST_ID,CARD_NO,CUST_NAME,SEX_CD,BIRTH_DT,BIRTH_LUNAR_FLAG,WED_DT,WED_LUNAR_FLAG,HOME_NEW_YN,HOME_ZIP_CD1"
			            + ",HOME_ZIP_CD2,HOME_ADDR1,HOME_ADDR2,HOME_PH1,HOME_PH2,HOME_PH3,MOBILE_PH1,MOBILE_PH2,MOBILE_PH3,OFFI_NEW_YN,OFFI_ZIP_CD1,OFFI_ZIP_CD2"
			            + ",OFFI_ADDR1,OFFI_ADDR2,OFFI_PH1,OFFI_PH2,OFFI_PH3,OFFI_INTER_PH,OFFI_FAX1,OFFI_FAX2,OFFI_FAX3,HOBBY,SALE_AMT,RELIGION,REG_DATE,ETC"
			            + ",FAMILY1,FAMILY1_NM,FAMILY2,FAMILY2_NM,FAMILY3,FAMILY3_NM,FAMILY4,FAMILY4_NM,ETC2,EMAIL1,EMAIL2,DOMAIN_FLAG,REGUCUST_ID,SEQ_NO,GRADE_FLAG,SMS_FLAG,EMAIL_FLAG,WED_FLAG,TEXT_SALEAMT";
			
			rtJson = util.listToJsonOBJ(list, cols);
			
		}catch(Exception e){
			throw e;
		}
			
		return rtJson;
	}
	
	
	/**
	 * 중복체크
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String chkcardno(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Util      util = new Util();
		List list = null;
		String rtJson = null;
		String strQuery = "";
		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
				
			System.out.println("33333333333333333333333333333333333");
			System.out.println("33333333333333333333333333333333333");
			System.out.println(form.getParam("IN_PUMBUN_CD"));
			System.out.println(form.getParam("IN_CARD_NO"));
			System.out.println(util.encryptedStr(form.getParam("IN_CARD_NO")));
			System.out.println("33333333333333333333333333333333333");
			System.out.println("33333333333333333333333333333333333");
			
			String IN_PUMBUN_CD 	= form.getParam("IN_PUMBUN_CD");		            //품번코드
			String IN_CARD_NO 	= util.encryptedStr(form.getParam("IN_CARD_NO"));		//카드번호

			connect("pot");			
			
			
			strQuery = svc.getQuery("CHK_CARDNO") +"\n";
			sql.setString(++i, IN_CARD_NO);
			sql.setString(++i, IN_PUMBUN_CD);

			sql.put(strQuery);
			
			
			list = select2List(sql);
			
			
			String aa = list.get(0).toString();
			
			if(aa.equals("[0]")){
				rtJson = "Y";
			}else{
				rtJson = "N";
			}
			
//			String	cols= "REGUCUST_ID,CUST_NAME,BIRTH_DT,CARD_NO,MOBILE_PH1,MOBILE_PH2,MOBILE_PH3,REG_DATE,SEQ_NO";
//			rtJson = util.listToJsonOBJ(list, cols);
			
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
	
	/**
	 * 단골 고객 정보 등록
	 * @param form
	 * @param reguCustId - 단골 고객 번호
	 * @return
	 * @throws Exception
	 */
	public int insReguCustMst(ActionForm form, String reguCustId) throws Exception { 
		int 			i 		= 0;
		int 			ret 	= 0;
		SqlWrapper 		sql 	= null;
		Service 		svc 	= null;
		Util			util 	= new Util();

		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  
			String IN_BIRTH_DT			= String2.nvl(form.getParam("IN_BIRTH_DT"));
			String IN_BIRTH_LUNAR_FLAG	= String2.nvl(form.getParam("IN_BIRTH_LUNAR_FLAG"));
			String IN_CARD_NO			= util.encryptedStr(String2.nvl(form.getParam("IN_CARD_NO")));	//암호화(카드번호)
			String IN_CUST_ID			= String2.nvl(form.getParam("IN_CUST_ID"));
			String IN_CUST_NAME			= URLDecoder.decode(String2.nvl(form.getParam("IN_CUST_NAME")), "UTF-8");
			String IN_DOMAIN_FLAG		= String2.nvl(form.getParam("IN_DOMAIN_FLAG"));
			String IN_EMAIL1			= util.encryptedStr(String2.nvl(form.getParam("IN_EMAIL1")));	//암호화(이메일1)
			String IN_EMAIL2			= util.encryptedStr(String2.nvl(form.getParam("IN_EMAIL2")));	//암호화(이메일2)
			String IN_ETC				= URLDecoder.decode(String2.nvl(form.getParam("IN_ETC")), "UTF-8");
			String IN_ETC2				= URLDecoder.decode(String2.nvl(form.getParam("IN_ETC2")), "UTF-8");
			String IN_FAMILY1			= URLDecoder.decode(String2.nvl(form.getParam("IN_FAMILY1")), "UTF-8");
			String IN_FAMILY1_NM		= URLDecoder.decode(String2.nvl(form.getParam("IN_FAMILY1_NM")), "UTF-8");
			String IN_FAMILY2			= URLDecoder.decode(String2.nvl(form.getParam("IN_FAMILY2")), "UTF-8");
			String IN_FAMILY2_NM		= URLDecoder.decode(String2.nvl(form.getParam("IN_FAMILY2_NM")), "UTF-8");
			String IN_FAMILY3			= URLDecoder.decode(String2.nvl(form.getParam("IN_FAMILY3")), "UTF-8");
			String IN_FAMILY3_NM		= URLDecoder.decode(String2.nvl(form.getParam("IN_FAMILY3_NM")), "UTF-8");
			String IN_FAMILY4			= URLDecoder.decode(String2.nvl(form.getParam("IN_FAMILY4")), "UTF-8");
			String IN_FAMILY4_NM		= URLDecoder.decode(String2.nvl(form.getParam("IN_FAMILY4_NM")), "UTF-8");
			String IN_HOBBY				= URLDecoder.decode(String2.nvl(form.getParam("IN_HOBBY")), "UTF-8");
			String IN_HOME_ADDR1		= URLDecoder.decode(String2.nvl(form.getParam("IN_HOME_ADDR1")), "UTF-8");
			String IN_HOME_ADDR2		= URLDecoder.decode(String2.nvl(form.getParam("IN_HOME_ADDR2")), "UTF-8");
			//String IN_HOME_NEW_YN		= String2.nvl(form.getParam("IN_HOME_NEW_YN"));
			String IN_HOME_PH1			= util.encryptedStr(String2.nvl(form.getParam("IN_HOME_PH1")));	//암호화(집전화번호1)
			String IN_HOME_PH2			= util.encryptedStr(String2.nvl(form.getParam("IN_HOME_PH2")));	//암호화(집전화번호2)
			String IN_HOME_PH3			= util.encryptedStr(String2.nvl(form.getParam("IN_HOME_PH3")));	//암호화(집전화번호3)
			String IN_HOME_ZIP_CD1		= String2.nvl(form.getParam("IN_HOME_ZIP_CD1"));
			String IN_HOME_ZIP_CD2		= String2.nvl(form.getParam("IN_HOME_ZIP_CD2"));
			String IN_MOBILE_PH1		= util.encryptedStr(String2.nvl(form.getParam("IN_MOBILE_PH1")));	//암호화(휴대폰번호1)
			String IN_MOBILE_PH2		= util.encryptedStr(String2.nvl(form.getParam("IN_MOBILE_PH2")));	//암호화(휴대폰번호2)
			String IN_MOBILE_PH3		= util.encryptedStr(String2.nvl(form.getParam("IN_MOBILE_PH3")));	//암호화(휴대폰번호3)
			//String IN_MOD_DATE		= String2.nvl(form.getParam("IN_MOD_DATE"));
			String IN_MOD_ID			= String2.nvl(form.getParam("userid"));
			String IN_OFFI_ADDR1		= URLDecoder.decode(String2.nvl(form.getParam("IN_OFFI_ADDR1")), "UTF-8");
			String IN_OFFI_ADDR2		= URLDecoder.decode(String2.nvl(form.getParam("IN_OFFI_ADDR2")), "UTF-8");
			String IN_OFFI_FAX1			= String2.nvl(form.getParam("IN_OFFI_FAX1"));
			String IN_OFFI_FAX2			= String2.nvl(form.getParam("IN_OFFI_FAX2"));
			String IN_OFFI_FAX3			= String2.nvl(form.getParam("IN_OFFI_FAX3"));
			//String IN_OFFI_INTER_PH		= String2.nvl(form.getParam("IN_OFFI_INTER_PH"));
			//String IN_OFFI_NEW_YN	= String2.nvl(form.getParam("IN_OFFI_NEW_YN"));
			String IN_OFFI_PH1			= String2.nvl(form.getParam("IN_OFFI_PH1"));
			String IN_OFFI_PH2			= String2.nvl(form.getParam("IN_OFFI_PH2"));
			String IN_OFFI_PH3			= String2.nvl(form.getParam("IN_OFFI_PH3"));
			String IN_OFFI_ZIP_CD1		= String2.nvl(form.getParam("IN_OFFI_ZIP_CD1"));
			String IN_OFFI_ZIP_CD2		= String2.nvl(form.getParam("IN_OFFI_ZIP_CD2"));
			String IN_REGUCUST_ID		= reguCustId;
			//String IN_REG_DATE		= String2.nvl(form.getParam("IN_REG_DATE"));
			String IN_REG_ID			= String2.nvl(form.getParam("userid"));
			String IN_RELIGION			= URLDecoder.decode(String2.nvl(form.getParam("IN_RELIGION")), "UTF-8");
			String IN_SEX_CD			= String2.nvl(form.getParam("IN_SEX_CD"));
			String IN_WED_DT			= String2.nvl(form.getParam("IN_WED_DT"));
			String IN_GRADE_FLAG		= String2.nvl(form.getParam("IN_GRADE_FLAG"));
			String IN_SMS_FLAG			= String2.nvl(form.getParam("IN_SMS_FLAG"));
			String IN_EMAIL_FLAG		= String2.nvl(form.getParam("IN_EMAIL_FLAG"));
			String IN_WED_FLAG			= String2.nvl(form.getParam("IN_WED_FLAG"));
			String IN_WED_LUNAR_FLAG	= String2.nvl(form.getParam("IN_WED_LUNAR_FLAG"));
			String TEXT_SALEAMT	        = String2.nvl(form.getParam("TEXT_SALEAMT"));
			
			
			connect("pot");
			begin();
			
			sql.put(svc.getQuery("INS_REGUCUSTMST"));
			
			//merge
			sql.setString(++i, IN_REGUCUST_ID);
			
			//update
			sql.setString(++i, IN_BIRTH_DT);
			sql.setString(++i, IN_BIRTH_LUNAR_FLAG);
			sql.setString(++i, IN_CARD_NO);
			sql.setString(++i, IN_CUST_ID);
			sql.setString(++i, IN_CUST_NAME);
			sql.setString(++i, IN_DOMAIN_FLAG);
			sql.setString(++i, IN_EMAIL1);
			sql.setString(++i, IN_EMAIL2);
			sql.setString(++i, IN_ETC);
			sql.setString(++i, IN_ETC2);
			sql.setString(++i, IN_FAMILY1);
			sql.setString(++i, IN_FAMILY1_NM);
			sql.setString(++i, IN_FAMILY2);
			sql.setString(++i, IN_FAMILY2_NM);
			sql.setString(++i, IN_FAMILY3);
			sql.setString(++i, IN_FAMILY3_NM);
			sql.setString(++i, IN_FAMILY4);
			sql.setString(++i, IN_FAMILY4_NM);
			sql.setString(++i, IN_HOBBY);
			sql.setString(++i, IN_HOME_ADDR1);
			sql.setString(++i, IN_HOME_ADDR2);
			sql.setString(++i, IN_HOME_PH1);
			sql.setString(++i, IN_HOME_PH2);
			sql.setString(++i, IN_HOME_PH3);
			sql.setString(++i, IN_HOME_ZIP_CD1);
			sql.setString(++i, IN_HOME_ZIP_CD2);
			sql.setString(++i, IN_MOBILE_PH1);
			sql.setString(++i, IN_MOBILE_PH2);
			sql.setString(++i, IN_MOBILE_PH3);
			sql.setString(++i, IN_MOD_ID);
			sql.setString(++i, IN_OFFI_ADDR1);
			sql.setString(++i, IN_OFFI_ADDR2);
			sql.setString(++i, IN_OFFI_FAX1);
			sql.setString(++i, IN_OFFI_FAX2);
			sql.setString(++i, IN_OFFI_FAX3);
			sql.setString(++i, IN_OFFI_PH1);
			sql.setString(++i, IN_OFFI_PH2);
			sql.setString(++i, IN_OFFI_PH3);
			sql.setString(++i, IN_OFFI_ZIP_CD1);
			sql.setString(++i, IN_OFFI_ZIP_CD2);
			sql.setString(++i, IN_RELIGION);
			sql.setString(++i, IN_SEX_CD);
			sql.setString(++i, IN_WED_DT);
			sql.setString(++i, IN_GRADE_FLAG);
			sql.setString(++i, IN_SMS_FLAG);
			sql.setString(++i, IN_EMAIL_FLAG);
			sql.setString(++i, IN_WED_FLAG);
			sql.setString(++i, IN_WED_LUNAR_FLAG);
			sql.setString(++i, TEXT_SALEAMT);
			
			//insert
			sql.setString(++i, IN_BIRTH_DT);
			sql.setString(++i, IN_BIRTH_LUNAR_FLAG);
			sql.setString(++i, IN_CARD_NO);
			sql.setString(++i, IN_CUST_ID);
			sql.setString(++i, IN_CUST_NAME);
			sql.setString(++i, IN_DOMAIN_FLAG);
			sql.setString(++i, IN_EMAIL1);
			sql.setString(++i, IN_EMAIL2);
			sql.setString(++i, IN_ETC);
			sql.setString(++i, IN_ETC2);
			sql.setString(++i, IN_FAMILY1);
			sql.setString(++i, IN_FAMILY1_NM);
			sql.setString(++i, IN_FAMILY2);
			sql.setString(++i, IN_FAMILY2_NM);
			sql.setString(++i, IN_FAMILY3);
			sql.setString(++i, IN_FAMILY3_NM);
			sql.setString(++i, IN_FAMILY4);
			sql.setString(++i, IN_FAMILY4_NM);
			sql.setString(++i, IN_HOBBY);
			sql.setString(++i, IN_HOME_ADDR1);
			sql.setString(++i, IN_HOME_ADDR2);
			sql.setString(++i, IN_HOME_PH1);
			sql.setString(++i, IN_HOME_PH2);
			sql.setString(++i, IN_HOME_PH3);
			sql.setString(++i, IN_HOME_ZIP_CD1);
			sql.setString(++i, IN_HOME_ZIP_CD2);
			sql.setString(++i, IN_MOBILE_PH1);
			sql.setString(++i, IN_MOBILE_PH2);
			sql.setString(++i, IN_MOBILE_PH3);
			sql.setString(++i, IN_MOD_ID);
			sql.setString(++i, IN_OFFI_ADDR1);
			sql.setString(++i, IN_OFFI_ADDR2);
			sql.setString(++i, IN_OFFI_FAX1);
			sql.setString(++i, IN_OFFI_FAX2);
			sql.setString(++i, IN_OFFI_FAX3);
			sql.setString(++i, IN_OFFI_PH1);
			sql.setString(++i, IN_OFFI_PH2);
			sql.setString(++i, IN_OFFI_PH3);
			sql.setString(++i, IN_OFFI_ZIP_CD1);
			sql.setString(++i, IN_OFFI_ZIP_CD2);
			sql.setString(++i, IN_REGUCUST_ID);
			sql.setString(++i, IN_REG_ID);
			sql.setString(++i, IN_RELIGION);
			sql.setString(++i, IN_SEX_CD);
			sql.setString(++i, IN_WED_DT);
			sql.setString(++i, IN_GRADE_FLAG);
			sql.setString(++i, IN_SMS_FLAG);
			sql.setString(++i, IN_EMAIL_FLAG);
			sql.setString(++i, IN_WED_FLAG);
			sql.setString(++i, IN_WED_LUNAR_FLAG);
			sql.setString(++i,(TEXT_SALEAMT));
			
			ret = update(sql);
			
			if(ret < 1) {	//등록 오류
				rollback();
			}
			
		} catch(Exception e){
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
	
	/**
	 * 단골 고객 번호 조회
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getReguCustId(ActionForm form) throws Exception { 

		List 			list 	= null;
		SqlWrapper 		sql 	= null;
		Service 		svc 	= null;

		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  
			connect("pot");
			
			sql.put(svc.getQuery("SEL_SQ_REGUCUST_ID"));
			
			list = select2List(sql);
			
		} catch(Exception e){
			throw e;
		} finally {}
		
		return list;
	}
	
	/**
	 * 브랜드별 단골고객 등록
	 * @param form
	 * @param reguCustId - 단골 고객 번호
	 * @return
	 * @throws Exception
	 */
	public int insReguCustDtl(ActionForm form, String reguCustId) throws Exception { 
		int 			i 		= 0;
		int 			ret 	= 0;
		SqlWrapper 		sql 	= null;
		Service 		svc 	= null;
		Util			util 	= new Util();

		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  
			
			String strUserId	 	= String2.nvl(form.getParam("userid"));				//등록자ID
			String strStrCd			= String2.nvl(form.getParam("strcd"));				//점코드
			String strVenCd			= String2.nvl(form.getParam("vencd"));				//협력사 코드
			String IN_PUMBUN_CD 	= String2.nvl(form.getParam("IN_PUMBUN_CD"));		//품번코드
			String IN_SEQ_NO	 	= String2.nvl(form.getParam("IN_SEQ_NO"));			//순번

			connect("pot");
			begin();
			
			sql.put(svc.getQuery("INS_REGUCUSTDTL"));
			
			//merge
			sql.setString(++i, strStrCd);		//STR_CD
			sql.setString(++i, strVenCd);		//VEN_CD
			sql.setString(++i, IN_SEQ_NO);		//SEQ_NO
			sql.setString(++i, reguCustId);		//REGUCUST_ID
			
			//update
			sql.setString(++i, IN_PUMBUN_CD);	//PUMBUN_CD
			sql.setString(++i, strUserId);		//MOD_ID
			
			//insert
			sql.setString(++i, strUserId);		//MOD_ID
			sql.setString(++i, IN_PUMBUN_CD);	//PUMBUN_CD
			sql.setString(++i, reguCustId);		//REGUCUST_ID
			sql.setString(++i, strUserId);		//REG_ID
			sql.setString(++i, strStrCd);		//STR_CD
			sql.setString(++i, strVenCd);		//VEN_CD
			
			//insert - select seq_no
			sql.setString(++i, strStrCd);		//STR_CD
			sql.setString(++i, strVenCd);		//VEN_CD
			sql.setString(++i, reguCustId);		//REGUCUST_ID
			
			ret = update(sql);
			
			if(ret < 1) {	//등록 오류
				rollback();
			}
			
		} catch(Exception e){
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
	
	/**
	 * 브랜드별 단골고객 삭제
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int delReguCustDtl(ActionForm form) throws Exception { 
		int 			i 		= 0;
		int 			ret 	= 0;
		SqlWrapper 		sql 	= null;
		Service 		svc 	= null;

		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  
			String strStrCd			= String2.nvl(form.getParam("strcd"));				//점코드
			String strVenCd			= String2.nvl(form.getParam("vencd"));				//협력사 코드
			String strSeqNo		 	= String2.nvl(form.getParam("seqNo"));				//순번
			String strReguCustId 	= String2.nvl(form.getParam("reguCustId"));			//단골고객등록번호

			connect("pot");
			begin();
			
			sql.put(svc.getQuery("DEL_PC_REGUCUSTDTL"));
			
			//delete
			sql.setString(++i, strStrCd);		//STR_CD
			sql.setString(++i, strVenCd);		//VEN_CD
			sql.setString(++i, strSeqNo);		//SEQ_NO
			sql.setString(++i, strReguCustId);	//REGUCUST_ID
			
			ret = update(sql);
			
			if(ret < 1) {	//등록 오류
				rollback();
			}
			
		} catch(Exception e){
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
	
	/**
	 * 단골고객 상세 조회
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String getReguListPop(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Util      util = new Util();
		List list = null;
		String rtJson = null;
		String strQuery = "";
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  
			String strCardNo 		= String2.nvl(form.getParam("cardNo").replaceAll("-", ""));			//카드번호(필수, 암호화)
			String strCustName 		= URLDecoder.decode(String2.nvl(form.getParam("custName")));		//고객명
			String strBirthDate 	= String2.nvl(form.getParam("birthDate"));		//생년월일
			String strEmSDate 		= String2.nvl(form.getParam("em_S_Date"));		//가입일 기간 시작
			String strEmEDate 		= String2.nvl(form.getParam("em_E_Date"));		//가입일 기간 종료
			String strMobilePh1 	= String2.nvl(form.getParam("mobilePh1"));		//핸드폰번호1
			String strMobilePh2 	= String2.nvl(form.getParam("mobilePh2"));		//핸드폰번호2
			String strMobilePh3 	= String2.nvl(form.getParam("mobilePh3"));		//핸드폰번호3
			String mode		 		= String2.nvl(form.getParam("mode"));		//C-SEL_DM_CUSTOMER, N-SEL_PC_REGULIST
			String xmlName = "";

			if(mode.equals("C")) {
				xmlName = "SEL_DM_CUSTOMER";
			} else {
				xmlName = "SEL_PC_REGULIST";
			}
			
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  

			connect("pot");
			
			strQuery = svc.getQuery(xmlName + "_START") +"\n";
			
			if(!strCardNo.equals("")) {
				strQuery += svc.getQuery(xmlName + "_CARD_NO") +"\n";
				sql.setString(++i, util.encryptedStr(strCardNo));
			}
			
			if(!strCustName.equals("")) {
				strQuery += svc.getQuery(xmlName + "_CUST_NAME") +"\n";
				sql.setString(++i, strCustName);
			}
			
			if(!strBirthDate.equals("")) {
				strQuery += svc.getQuery(xmlName + "_BIRTH_DT") +"\n";
				sql.setString(++i, strBirthDate);
			}
			
			if(!strMobilePh1.equals("") && !strMobilePh2.equals("") && !strMobilePh3.equals("")) {
				strQuery += svc.getQuery(xmlName + "_MOBILE_PH") +"\n";
				sql.setString(++i, util.encryptedStr(strMobilePh1));
				sql.setString(++i, util.encryptedStr(strMobilePh2));
				sql.setString(++i, util.encryptedStr(strMobilePh3));
			}
			
			if(!strEmSDate.equals("") && !strEmEDate.equals("")) {
				strQuery += svc.getQuery(xmlName + "_ENTR_DT") +"\n";
				sql.setString(++i, strEmSDate);
				sql.setString(++i, strEmEDate);
			}
			
			strQuery += svc.getQuery(xmlName + "_END") +"\n";
			
			//System.out.println("strQuery : " + strQuery);
			
			sql.put(strQuery);
			
			list = select2List(sql);
			
			list = util.decryptedStr(list,0);	//암호화 해제(CARD_NO)
			list = util.decryptedStr(list,4);	//암호화 해제(MOBILE_PH1)
			list = util.decryptedStr(list,5);	//암호화 해제(MOBILE_PH2)
			list = util.decryptedStr(list,6);	//암호화 해제(MOBILE_PH3)
			
			String	cols= "CARD_NO,CUST_ID,CUST_NAME,BIRTH_DT,MOBILE_PH1,MOBILE_PH2,MOBILE_PH3,REGUCUST_ID";
			rtJson = util.listToJsonOBJ(list, cols);
			
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
	
	/**
	 * 고객/단골고객 조회(화면 셋팅용)
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String getReguList(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Util      util = new Util();
		List list = null;
		String rtJson = null;
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service)form.getService();
  
			String strSearchID 		= String2.nvl(form.getParam("searchID"));		//카드번호(필수, 암호화)
			String mode		 		= String2.nvl(form.getParam("mode"));			//C-SEL_PC_REGUCUSTMST_C, N-SEL_PC_REGUCUSTMST_N

			sql = new SqlWrapper();
			svc = (Service)form.getService();

			connect("pot");
			
			sql.put(svc.getQuery("SEL_PC_REGUCUSTMST_" + mode));
			
			System.out.println("strSearchID : " + strSearchID);
			System.out.println("mode : " + mode);
			
			sql.setString(++i, strSearchID);
			
			list = select2List(sql);
			
			list = util.decryptedStr(list,1);	//암호화 해제(CARD_NO)
			list = util.decryptedStr(list,18);	//암호화 해제(HOME_PH1)
			list = util.decryptedStr(list,19);	//암호화 해제(HOME_PH2)
			list = util.decryptedStr(list,20);	//암호화 해제(HOME_PH3)
			list = util.decryptedStr(list,21);	//암호화 해제(MOBILE_PH1)
			list = util.decryptedStr(list,22);	//암호화 해제(MOBILE_PH2)
			list = util.decryptedStr(list,23);	//암호화 해제(MOBILE_PH3)
			list = util.decryptedStr(list,40);	//암호화 해제(EMAIL1)
			list = util.decryptedStr(list,41);	//암호화 해제(EMAIL2)
			
			String cols= "REGUCUST_ID,CARD_NO,CUST_ID,CUST_NAME,SEX_CD,BIRTH_DT,BIRTH_LUNAR_FLAG,WED_DT,WED_LUNAR_FLAG,HOME_NEW_YN,HOME_ZIP_CD1"
						+ ",HOME_ZIP_CD2,HOME_ADDR1,HOME_ADDR2,HNEW_ZIP_CD1,HNEW_ZIP_CD2,HNEW_ADDR1,HNEW_ADDR2,HOME_PH1,HOME_PH2,HOME_PH3"
						+ ",MOBILE_PH1,MOBILE_PH2,MOBILE_PH3,OFFI_ZIP_CD1,OFFI_ZIP_CD2,OFFI_ADDR1,OFFI_ADDR2,OFFI_NEW_YN,ONEW_ZIP_CD1,ONEW_ZIP_CD2"
						+ ",ONEW_ADDR1,ONEW_ADDR2,OFFI_PH1,OFFI_PH2,OFFI_PH3,OFFI_FAX1,OFFI_FAX2,OFFI_FAX3,OFFI_INTER_PH,EMAIL1,EMAIL2"
						+ ",HOBBY,RELIGION,ETC,FAMILY1,FAMILY1_NM,FAMILY2,FAMILY2_NM,FAMILY3,FAMILY3_NM,FAMILY4,FAMILY4_NM,TEXT_SALEAMT";
			
			rtJson = util.listToJsonOBJ(list, cols);
			
		} catch(Exception e){
			throw e;
		} finally {
			end();
		}
		
		return rtJson;
	}
}
