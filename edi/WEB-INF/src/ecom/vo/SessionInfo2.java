/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package ecom.vo;

/**
 * 로그인 이후 세션에 담을 사용자 정보를 정의한 자바 빈 
 * @created  on 1.0, 11/03/16
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * @modified 
 * @modified 
 * @caused   EDI
 */

public class SessionInfo2 implements java.io.Serializable {

	/**
     * 
     */
	private static final long serialVersionUID = -9080634516562556660L;
	/**
     * 
     */
	private String USER_ID = "";// 사용자id
	private String USER_NAME = "";// 사원명
	private String SUB_MENU = "";// 서브메뉴
	private String STR_CD = "";//점코드
	private String STR_NM = "";//점코드명
    private String PWD_NO = "";//비밀번호
    private String PUMBUN_CD = "";//품번 코드
    private String PUMBUN_NAME = "";//품번명
    private String CHAR_BUYER_CD = "";//담당바비어
    private String VEN_CD = ""; 	//협력사 코드 
    private String VEN_NAME = "";	//협력사 명
    private String BIZ_TYPE = "";	//거래형태
    private String GB = "";  		//구분 1. 협력사  2. 품번
    
    /**
	 * 구분 
	 * 
	 * @param USER_ID
	 */
    
    public String getGB() {
		return GB;
	}

	public void setGB(String gB) {
		GB = gB;
	}
	/**
	 * 거래형태
	 * 
	 * @param USER_ID
	 */
	public String getBIZ_TYPE() {
		return BIZ_TYPE;
	}

	public void setBIZ_TYPE(String bIZ_TYPE) {
		BIZ_TYPE = bIZ_TYPE;
	}

	/**
	 * 점코드명
	 * 
	 * @param USER_ID
	 */
    public String getSTR_NM() {
		return STR_NM;
	}

	public void setSTR_NM(String sTR_NM) {
		STR_NM = sTR_NM;
	}

	//추가로 정의해서 쓰세요
    /**
	 * 협력사 코드
	 * 
	 * @param USER_ID
	 */
    public String getVEN_CD() {
		return VEN_CD;
	}
    
	public void setVEN_CD(String vEN_CD) {
		VEN_CD = vEN_CD;
	}

	/**
	 * 협력사 명
	 * 
	 * @param USER_ID
	 */
	public String getVEN_NAME() {
		return VEN_NAME;
	}

	public void setVEN_NAME(String vEN_NAME) {
		VEN_NAME = vEN_NAME;
	}
	
    /**
	 * 점코드
	 * 
	 * @param USER_ID
	 */
	public String getSTR_CD() {
		return STR_CD;
	}

	public void setSTR_CD(String sTR_CD) {
		STR_CD = sTR_CD;
	}
	
	/**
	 * 비밀번호
	 * 
	 * @param USER_ID
	 */
	public String getPWD_NO() {
		return PWD_NO;
	}

	public void setPWD_NO(String pWD_NO) {
		PWD_NO = pWD_NO;
	}
	/**
	 * 품번 코드
	 * 
	 * @param USER_ID
	 */
	public String getPUMBUN_CD() {
		return PUMBUN_CD;
	}

	public void setPUMBUN_CD(String pUMBUN_CD) {
		PUMBUN_CD = pUMBUN_CD;
	}
	
	/**
	 * 품번명
	 * 
	 * @param USER_ID
	 */
	public String getPUMBUN_NAME() {
		return PUMBUN_NAME;
	}

	public void setPUMBUN_NAME(String pUMBUN_NAME) {
		PUMBUN_NAME = pUMBUN_NAME;
	}

	/**
	 * 담당바이어
	 * 
	 * @param USER_ID
	 */
	public String getCHAR_BUYER_CD() {
		return CHAR_BUYER_CD;
	}

	public void setCHAR_BUYER_CD(String cHAR_BUYER_CD) {
		CHAR_BUYER_CD = cHAR_BUYER_CD;
	}

	/**
	 * 사번
	 * 
	 * @param USER_ID
	 */
	public void setUSER_ID(String USER_ID) {
		this.USER_ID = USER_ID;
	}

	public String getUSER_ID() {
		return this.USER_ID;
	}

	/**
	 * 사원명
	 * 
	 * @param USER_NAME
	 */
	public void setUSER_NAME(String USER_NAME) {
		this.USER_NAME = USER_NAME;
	}

	public String getUSER_NAME() {
		return this.USER_NAME;
	}



	/**
	 * 서브메뉴
	 * 
	 * @param SUB_MENU
	 */
	public void setSUB_MENU(String SUB_MENU) {
		this.SUB_MENU = SUB_MENU;
	}

	public String getSUB_MENU() {
		return this.SUB_MENU;
	}



}
