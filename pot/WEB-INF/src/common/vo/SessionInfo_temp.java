/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package common.vo;

/**
 * 로그인 이후 세션에 담을 사용자 정보를 정의한 자바 빈 
 * @created  on 1.0, 12/12/10
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * @modified 
 * @modified 
 * @caused   사용자 정보를 세션에서 효율적으로 가지고 다니기 위해
 */

import java.util.ArrayList;

public class SessionInfo_temp implements java.io.Serializable {

	private static final long serialVersionUID = -9080634516562556660L;

	private String USER_ID = "";// 사번
	private String USER_NAME = "";// 사원명

	private String ORG_CD = "";// 조직코드
	private String ORG_FLAG = ""; // 조직구분 1:판매, 2:매입
	private String ORG_LEVEL = ""; // 조직레벨 -점:1, 부문:2, 팀:3, PC:4, 코너:5 >>
									// 등급(GRADE) A:, B:, C:, D:, E:, F:
	private String GROUP_CD = "";// 그룹코드
	private String STR_CD = "";// 점코드
	private String DEPT_CD = "";// 부분코드
	private String TEAM_CD = "";// 팀코드
	private String PC_CD = "";// PC코드
	private String CORNER_CD = "";// 코너코드

	private String SUB_SYS = "";// 시스템코드
	private String VIEW_LEVEL = "";// 뷰레벨: 관리자, 일반사용자 등, 초기화면사용
	private String MULTI_LOGIN = "";// 중복사용 허용

	private String HP1_NO = ""; // 핸드폰번호1
	private String HP2_NO = ""; // 핸드폰번호2
	private String HP3_NO = ""; // 핸드폰번호3
	private String PHONE1_NO = ""; // 전화번호1
	private String PHONE2_NO = ""; // 전화번호2
	private String PHONE3_NO = ""; // 전화번호3
	private String E_MAIL = ""; // 이메일
	private String PART_NM = ""; // 부서명

	private String PGM_ID = "";// Program ID
	private String L_CD = "";// 대분류 메뉴
	private String M_CD = "";// 소분류 메뉴

	private String BRCH_ID = "";// 포인트카드에서 사용하는 점코드
	// MARIO OUTLET 
	private String COM_CD = "2000";// 그룹사 코드. setting되는 부분이 없어 임의로 "2000"(센트럴) 입력. 
	//고도화 시 세션에 COM_CD를 세팅하는 부분이 필요함.

	// MARIO OUTLET 
	private String bu_Nm	= "";//부명
	private String team_Nm	= "";//팀명
	private String pc_Nm	= "";//PC명
	private String jknm		= "";//조직명
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

	public void setUsr_Id(String USER_ID) { // 인사회계
		this.setUSER_ID(USER_ID);
	}

	public String getUsr_Id() { // 인사회계
		return this.getUSER_ID();
	}

	public void setUsr_Cd(String USER_ID) { // 인사회계
		this.setUSER_ID(USER_ID);
	}

	public String getUsr_Cd() { // 인사회계
		return this.getUSER_ID();
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

	public void setUsr_Nm(String USER_NAME) { // 인사회계
		this.setUSER_NAME(USER_NAME);
	}

	public String getUsr_Nm() { // 인사회계
		return this.getUSER_NAME();
	}

	/**
	 * 그룹코드
	 * 
	 * @param GROUP_CD
	 */
	public void setGROUP_CD(String GROUP_CD) {
		this.GROUP_CD = GROUP_CD;
	}

	public String getGROUP_CD() {
		return this.GROUP_CD;
	}

	public void setGroup_Cd(String GROUP_CD) { // 인사회계
		this.setGROUP_CD(GROUP_CD);
	}

	public String getGroup_Cd() { // 인사회계
		return this.getGROUP_CD();
	}

	/**
	 * 점코드
	 * 
	 * @param STR_CD
	 */
	public void setSTR_CD(String STR_CD) {
		this.STR_CD = STR_CD;
	}

	public String getSTR_CD() {
		return this.STR_CD;
	}

	public void setStr_Cd(String STR_CD) { // 인사회계
		this.setSTR_CD(STR_CD);
	}

	public String getStr_Cd() { // 인사회계
		return this.getSTR_CD();
	}

	/**
	 * 조직구분
	 * 
	 * @param ORG_FLAG
	 */
	public void setORG_FLAG(String ORG_FLAG) {
		this.ORG_FLAG = ORG_FLAG;
	}

	public String getORG_FLAG() {
		return this.ORG_FLAG;
	}

	/**
	 * 부문
	 * 
	 * @param DEPT_CD
	 */
	public void setDEPT_CD(String DEPT_CD) {
		this.DEPT_CD = DEPT_CD;
	}

	public String getDEPT_CD() {
		return this.DEPT_CD;
	}

	public void setBu(String DEPT_CD) { // 인사회계
		this.setDEPT_CD(DEPT_CD);
	}

	public String getBu() { // 인사회계
		return this.getDEPT_CD();
	}

	/**
	 * 팀
	 * 
	 * @param TEAM_CD
	 */
	public void setTEAM_CD(String TEAM_CD) {
		this.TEAM_CD = TEAM_CD;
	}

	public String getTEAM_CD() {
		return this.TEAM_CD;
	}

	public void setTeam(String TEAM_CD) { // 인사회계
		this.setTEAM_CD(TEAM_CD);
	}

	public String getTeam() { // 인사회계
		return this.getTEAM_CD();
	}

	/**
	 * PC
	 * 
	 * @param PC_CD
	 */
	public void setPC_CD(String PC_CD) {
		this.PC_CD = PC_CD;
	}

	public String getPC_CD() {
		return this.PC_CD;
	}

	public void setPc(String PC_CD) { // 인사회계
		this.setPC_CD(PC_CD);
	}

	public String getPc() { // 인사회계
		return this.getPC_CD();
	}

	/**
	 * 조직코드
	 * 
	 * @param ORG_CD
	 */
	public void setORG_CD(String ORG_CD) {
		this.ORG_CD = ORG_CD;
	}

	public String getORG_CD() {
		return this.ORG_CD;
	}

	public void setJkcd(String ORG_CD) { // 인사회계
		this.setORG_CD(ORG_CD);
	}

	public String getJkcd() { // 인사회계
		return this.getORG_CD();
	}

	/**
	 * 조직구분
	 * 
	 * @param ORG_LEVEL
	 */
	public void setORG_LEVEL(String ORG_LEVEL) {
		this.ORG_LEVEL = ORG_LEVEL;
	}

	public String getORG_LEVEL() {
		return this.ORG_LEVEL;
	}

	public void setGrade(String ORG_LEVEL) { // 인사회계
		this.setORG_LEVEL(ORG_LEVEL);
	}

	public String getGrade() { // 인사회계
		return this.getORG_LEVEL();
	}

	/**
	 * 코너CD
	 * 
	 * @param CORNER_CD
	 */
	public void setCORNER_CD(String CORNER_CD) {
		this.CORNER_CD = CORNER_CD;
	}

	public String getCORNER_CD() {
		return this.CORNER_CD;
	}
	
	/**
	 * 뷰레벨
	 * 
	 * @param VIEW_LEVEL
	 */
	public void setVIEW_LEVEL(String VIEW_LEVEL) {
		this.VIEW_LEVEL = VIEW_LEVEL;
	}

	public String getVIEW_LEVEL() {
		return this.VIEW_LEVEL;
	}

	/**
	 * 중복사용허용
	 * 
	 * @param MULTI_LOGIN
	 */
	public void setMULTI_LOGIN(String MULTI_LOGIN) {
		this.MULTI_LOGIN = MULTI_LOGIN;
	}

	public String getMULTI_LOGIN() {
		return this.MULTI_LOGIN;
	}	
	
	/**
	 * 서브시스템
	 * 
	 * @param SUB_SYS
	 */
	public void setSUB_SYS(String SUB_SYS) {
		this.SUB_SYS = SUB_SYS;
	}

	public String getSUB_SYS() {
		return this.SUB_SYS;
	}

	public void setSub_System(String SUB_SYS) { // 인사회계
		this.setSUB_SYS(SUB_SYS);
	}

	public String getSub_System() { // 인사회계
		return this.getSUB_SYS();
	}

	/**
	 * 현재 실행한 프로그램 ID
	 * 
	 * @param PGM_ID
	 */
	public void setPGM_ID(String PGM_ID) {
		this.PGM_ID = PGM_ID;
	}

	public String getPGM_ID() {
		return this.PGM_ID;
	}

	public void setPid(String PGM_ID) { // 인사회계
		this.setPGM_ID(PGM_ID);
	}

	public String getPid() { // 인사회계
		return this.getPGM_ID();
	}

	/**
	 * 현재 실행한 프로그램의 대분류 메뉴코드
	 * 
	 * @param L_CD
	 */
	public void setL_CD(String L_CD) {
		this.L_CD = L_CD;
	}

	public String getL_CD() {
		return this.L_CD;
	}

	public void setLcode(String L_CD) { // 인사회계
		this.setL_CD(L_CD);
	}

	public String getLcode() { // 인사회계
		return this.getL_CD();
	}

	/**
	 * 현재 실행한 프로그램의 중분류 메뉴코드
	 * 
	 * @param M_CD
	 */
	public void setM_CD(String M_CD) {
		this.M_CD = M_CD;
	}

	public String getM_CD() {
		return this.M_CD;
	}

	public void setMcode(String M_CD) { // 인사회계
		this.setM_CD(M_CD);
	}

	public String getMcode() { // 인사회계
		return this.getM_CD();
	}

	/**
	 * 포인트카드가 사용하는 점코드
	 * 
	 * @param BRCH_ID
	 */
	public void setBRCH_ID(String BRCH_ID) {
		this.BRCH_ID = BRCH_ID;
	}

	public String getBRCH_ID() {
		return this.BRCH_ID;
	}

	/**
	 * 회사코드 인사회계
	 * 
	 * @param com_cd
	 */

	public void setCOM_CD(String COM_CD) {
		this.COM_CD = COM_CD;
	}

	public void setCom_Cd(String com_cd) {
		this.setCOM_CD(com_cd);
	}

	public String getCOM_CD() {
		return this.COM_CD;
	}

	public String getCom_Cd() {
		return this.getCOM_CD();
	}
	
	/**
	 * 
	 * @param HP1_NO
	 */
	public void setHP1_NO(String HP1_NO) {
		this.HP1_NO = HP1_NO;
	}

	public String getHP1_NO() {
		return this.HP1_NO;
	}
	/**
	 * 
	 * @param HP2_NO
	 */
	public void setHP2_NO(String HP2_NO) {
		this.HP2_NO = HP2_NO;
	}

	public String getHP2_NO() {
		return this.HP2_NO;
	}
	/**
	 * 
	 * @param HP3_NO
	 */
	public void setHP3_NO(String HP3_NO) {
		this.HP3_NO = HP3_NO;
	}

	public String getHP3_NO() {
		return this.HP3_NO;
	}
	/**
	 * 
	 * @param PHONE1_NO
	 */
	public void setPHONE1_NO(String PHONE1_NO) {
		this.PHONE1_NO = PHONE1_NO;
	}

	public String getPHONE1_NO() {
		return this.PHONE1_NO;
	}
	/**
	 * 
	 * @param PHONE2_NO
	 */
	public void setPHONE2_NO(String PHONE2_NO) {
		this.PHONE2_NO = PHONE2_NO;
	}

	public String getPHONE2_NO() {
		return this.PHONE2_NO;
	}
	/**
	 * 
	 * @param PHONE3_NO
	 */
	public void setPHONE3_NO(String PHONE3_NO) {
		this.PHONE3_NO = PHONE3_NO;
	}

	public String getPHONE3_NO() {
		return this.PHONE3_NO;
	}
	/**
	 * 
	 * @param E_MAIL
	 */
	public void setE_MAIL(String E_MAIL) {
		this.E_MAIL = E_MAIL;
	}

	public String getE_MAIL() {
		return this.E_MAIL;
	}
	/**
	 * 
	 * @param PART_NM
	 */
	public void setPART_NM(String PART_NM) {
		this.PART_NM = PART_NM;
	}

	public String getPART_NM() {
		return this.PART_NM;
	}

}
