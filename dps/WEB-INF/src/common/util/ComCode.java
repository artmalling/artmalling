/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.util;

/**
 * 각 종 Code 정보
 * 
 * @created on 1.0, 2010/04/13
 * @created by FUJITSU KOREA LTD
 * @modified
 * @modified
 * @caused
 */
public class ComCode implements java.io.Serializable{
	/********************** TRAN 의 거래형태************************/
	public static final String	TR_NORMAL					   	= "0";//일반거래
	public static final String	TR_CREDIT					   	= "1";//외상거래
	public static final String	TR_PENDED						= "2";//미결거래
	public static final String	TR_MON							= "8";//입출금
	public static final String	TR_ETC							= "9";//기타
	
	/********************** TRAN 거래형태 코드 8(입출금)의 거래모드************************/
	public static final String	TR_MON_RESERVE						   	= "81";//준비금
	public static final String	TR_MON_MIDDLE						   	= "82";//중간입금
	public static final String	TR_MON_PDA								= "83";//PDA입금
	public static final String	TR_MON_COU_EX							= "84";//상품권환전
	public static final String	TR_MON_CLOSE							= "85";//마감입금
	

}
