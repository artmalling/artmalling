/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package common.edi.transport;

/**
 * EDI 상수클래스
 * 
 * @created  on 1.0, 2010/05/18
 * @created  by 조형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 *
 */
public class EDIConstants {
	/* 전문 송수신 구분코드 */
//	public static final String TR_CD_T01 = "FT01";
//	public static final String TR_CD_T02 = "FT02";
//	public static final String TR_CD_T03 = "FT03";
//	public static final String TR_CD_T09 = "FT09";
//	public static final String TR_CD_T12 = "FT12";
//	public static final String TR_CD_T13 = "FT13";
//	public static final String TR_CD_R01 = "FR01";
//	public static final String TR_CD_R02 = "FR02";
//	public static final String TR_CD_R03 = "FR03";
//	public static final String TR_CD_R09 = "FR09";
//	public static final String TR_CD_R12 = "FR12";
//	public static final String TR_CD_R13 = "FR13";
	
	public static final String TR_CD_T01 = "HT01";
	public static final String TR_CD_T02 = "HT02";
	public static final String TR_CD_T03 = "HT03";
	public static final String TR_CD_T09 = "HT09";
	public static final String TR_CD_T12 = "HT12";
	public static final String TR_CD_T13 = "HT13";
	public static final String TR_CD_R01 = "HR01";
	public static final String TR_CD_R02 = "HR02";
	public static final String TR_CD_R03 = "HR03";
	public static final String TR_CD_R09 = "HR09";
	public static final String TR_CD_R12 = "HR12";
	public static final String TR_CD_R13 = "HR13";
	
	/* 오류코드 */
	public static final String TR_TERMID_ERR			= "0001";	/* 가맹점 번호 오류 */        
	public static final String TR_DATA_DIFF_ERR			= "0002";	/* 송수신 레코드 틀림 */      
	public static final String TR_TOTAL_REC_DIFF_ERR	= "0003";	/* Total 레코드 틀림 */       
	public static final String TR_NOT_FOUND_FILE_ERR	= "0004";	/* 찾는 파일 없음 */          
	public static final String TR_DUP_ERR				= "0005";	/* 중복 */            
	public static final String TR_PROTOCOL_ERR			= "0006";	/* 전문형식 오류 */           
	public static final String TR_KSNET_ETC_ERR			= "0007";   /* KSNET 기타 오류 */
	public static final String TR_ETC_ERR				= "0009";   /* 기타 오류 */
	/* 전문포맷 노드 */
	public static final String TMPL_BASE_NODE 			= "/definitions/conversation-template";
	public static final String TMPL_MSGE_NODE 			= "message-template";
	public static final String TMPL_MSGE_COMM_NODE 		= "/head";
	public static final String TMPL_MSGE_TYPE_BASIC 	= "basic";
	/* 전문포맷 데이터 노드 */
	public static final String TMPL_DATA_TOTL_NODE  	= "t";
	public static final String TMPL_DATA_DETL_NODE  	= "d";
	public static final String TMPL_DATA_RETN_NODE  	= "r";
	/* 전문길이 */
	public static final int TX_HEAD_LENGTH 		= 4;		//전문 길이 4BYTE
	public static final int TX_COMM_LENGTH 		= 28;		//전문 공통부분 길이
	
	/* 송신 - 매입요청 */
	public static class Ft {
		/**/
		public static final String TX_TERM_ID 		= "TESTMER003";	// 테스트기관코드
		public static final String TX_DEFT_SEQ 		= "01";
		
		/**/
		public static final int TX_MAX_RECD_CNT 	= 6;		//레코드 최대 갯수 //실제:6
		public static final int TX_HEAD_LENGTH 		= 4;		//전송길이 4byte
		public static final int TX_COMM_LENGTH 		= 28;		//전문 공통부분 길이
		public static final int TX_DATA_LENGTH 		= 200;		//전문 데이터부분 길이
		public static final int TX_ERROR_LENGTH 	= 4;		//전문 데이터부분 길이
		public static final int TX_FILENAME_LENGTH 	= 30;		//전송길이 4byte
		public static final String TX_FILENAME_DELIM 	= "-";	//파일명 구분자
		/**/
		public static final String TX_GUBUN_CD 	= "GUBUN_CD";
	}
	
	/* 수신 - 입금/반송/결과, 카드승인 */
	public static class Fr {
		/**/
		public static final String TX_TERM_ID 		= "DPT1234567";	// 임시
		public static final String TX_DEFT_SEQ 		= "01";
		
		/**/
		public static final int TX_MAX_RECD_CNT 	= 6;		//레코드 최대 갯수
		public static final int TX_HEAD_LENGTH 		= 4;		//전송길이 4byte
		public static final int TX_COMM_LENGTH 		= 28;		//전문 공통부분 길이
		public static final int TX_DATA_LENGTH 		= 150;		//전문 데이터부분 길이
		public static final int TX_ERROR_LENGTH 	= 4;		//전문 데이터부분 길이
		public static final int TX_FILENAME_LENGTH 	= 30;		//전송길이 4byte
		public static final String TX_FILENAME_DELIM 	= "-";		//전송길이 4byte
		/**/
		public static final String TX_GUBUN_CD 	= "GUBUN_CD";
	}
}
