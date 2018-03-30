/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package common.edi.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;

import common.edi.transport.AbstractEDIService;
import common.edi.transport.EDIConstants;


/**
 * KSNET 매입요청 전문 송신
 * 
 * @created  on 1.0, 2010/05/18
 * @created  by 조형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 *
 */
public class Psal929EDI extends AbstractEDIService{	
	/**
	 * Constructor
	 */
	public Psal929EDI() throws Exception {
		try {
			this.setTranFormDoc("/psal929.edi.xml");
		} catch (Exception e) {
			System.out.println("전문포맷 로드중 실패하였습니다.:"+ "psal929.edi.xml");
			e.printStackTrace();
			throw e;
		}
	}
	
	
	/**
	 * 매입요청 송신 서비스
	 * 
	 * @param dColumns 상세내역 칼럼 목록
	 * @param dList 상세내역 데이터 목록
	 * @param hColumns 헤더 칼럼 목록
	 * @param hList 헤더 데이터 목록
	 * @return 송신 처리 결과 1: 성공
	 */
	public int FTService(String[] dColumns, List<List<String>> dList, Map<String,String> hmap) {
		int result 		= 0; 	//
		int totRecCnt 	= 0;	//
		
		if (dList.size() < 1) {
			// BusinessException
			return -1;
		}
		
		try {
			/* van 연결 */
			this.connection();
			
			/* 서비스 요청 */
			/* FT01 <-> FT12, error: FT09 */
			totRecCnt = dList.size() + 1;
			byte[] bfData 	= this.parseFt01Message(EDIConstants.TR_CD_T01, EDIConstants.Ft.TX_FILENAME_LENGTH);
			byte[] bfComm 	= this.getReqCommMsg(EDIConstants.TR_CD_T01, totRecCnt, EDIConstants.TX_COMM_LENGTH + bfData.length, EDIConstants.Ft.TX_DATA_LENGTH);
			this.sendMessage(this.getRequestMessage(bfComm, bfData));
			
			byte[] recvMsg 	= this.recvMessage();
			Map<String, String> comMsgMap = this.getRecvMsgMap(recvMsg, EDIConstants.TMPL_MSGE_COMM_NODE);

			/* FT01 <-> FT12, error: FT09 */
			String trcd = (String) comMsgMap.get(EDIConstants.Ft.TX_GUBUN_CD);
			String sendTermId = null;
			String recvTermId = null;
			int sendRecCnt = 0;
			int recvRecCnt = 0;
			System.out.println("trcd: [" + trcd + "]");
			int txCnt = (totRecCnt / EDIConstants.Ft.TX_MAX_RECD_CNT) + ((totRecCnt % EDIConstants.Ft.TX_MAX_RECD_CNT) > 0? 1:0);
			System.out.println("#### txCnt:[" + txCnt + "]");
			for (int i = 0; i < txCnt; i++) {
				/* 전문 유효성 검사 */
				trcd = (String) comMsgMap.get(EDIConstants.Ft.TX_GUBUN_CD);
				if (!this.isValidFTService(trcd, EDIConstants.TR_CD_T12, sendTermId, recvTermId, sendRecCnt, recvRecCnt)) {
					throw new Exception();
				}
				/* 데이타전송 */
				bfData 	= this.parseFt02Message(EDIConstants.TR_CD_T02, (i * EDIConstants.Ft.TX_MAX_RECD_CNT), i, dColumns, dList);
//				bfComm 	= this.getReqCommMsg(EDIConstants.TR_CD_T02, totRecCnt, EDIConstants.TX_COMM_LENGTH + bfData.length, EDIConstants.Ft.TX_DATA_LENGTH);
				bfComm 	= this.getReqCommMsg(EDIConstants.TR_CD_T02, i*6, EDIConstants.TX_COMM_LENGTH + bfData.length, EDIConstants.Ft.TX_DATA_LENGTH);
				this.sendMessage(this.getRequestMessage(bfComm, bfData));
				
				/* 데이타 전송 응당 수신 */
				recvMsg		= this.recvMessage();
				comMsgMap 	= this.getRecvMsgMap(recvMsg, EDIConstants.TMPL_MSGE_COMM_NODE);
				
				/* */
				System.out.println("#### iiiiiiiiiiiiii:[" + i + "]");
				if ((i+1) * EDIConstants.Ft.TX_MAX_RECD_CNT == dList.size()) {
					/* 데이타전송 */
					bfData 	= this.parseFt02Message(EDIConstants.TR_CD_T02, (i+1 * EDIConstants.Ft.TX_MAX_RECD_CNT), i, dColumns, dList);
//					bfComm 	= this.getReqCommMsg(EDIConstants.TR_CD_T02, totRecCnt, EDIConstants.TX_COMM_LENGTH + bfData.length, EDIConstants.Ft.TX_DATA_LENGTH);
					bfComm 	= this.getReqCommMsg(EDIConstants.TR_CD_T02, (i+1) *6, EDIConstants.TX_COMM_LENGTH + bfData.length, EDIConstants.Ft.TX_DATA_LENGTH);
					this.sendMessage(this.getRequestMessage(bfComm, bfData));
					
					/* 데이타 전송 응당 수신 */
					recvMsg		= this.recvMessage();
					comMsgMap 	= this.getRecvMsgMap(recvMsg, EDIConstants.TMPL_MSGE_COMM_NODE);
					
					break;
				}
			}

			/* FT03 <-> FT13, error: FT09 */
			/* 전문 유효성 검사 */
			if (!this.isValidFTService(trcd, EDIConstants.TR_CD_T12, sendTermId, recvTermId, sendRecCnt, recvRecCnt)) {
				throw new Exception();
			}
			bfComm 		= this.getReqCommMsg(EDIConstants.TR_CD_T03, totRecCnt, EDIConstants.TX_COMM_LENGTH, EDIConstants.Ft.TX_DATA_LENGTH);
			this.sendMessage(bfComm);
			/**/
			recvMsg		= this.recvMessage();
			comMsgMap 	= this.getRecvMsgMap(recvMsg, EDIConstants.TMPL_MSGE_COMM_NODE);
			trcd = (String) comMsgMap.get(EDIConstants.Ft.TX_GUBUN_CD);
			System.out.println("gubuncd: [" + trcd + "]");
			/* 전문 유효성 검사 */
			if (!this.isValidFTService(trcd, EDIConstants.TR_CD_T13, sendTermId, recvTermId, sendRecCnt, recvRecCnt)) {
				throw new Exception();
			}
			result = 1; // 전문전송작업 정상처리
			System.out.println("#### 전문전송 작업이 정상처리되었습니다.");
		} catch (Exception e) {
			System.out.println("Exception:" + e);
			try {
				/* 오류메세지(전문) 전송 */
//				this.sendMessage(this.parseFt09Message(EDIConstants.TR_CD_T09, "0009"));
				
				byte[] bfData 	= this.parseFt09Message(EDIConstants.TR_CD_T09, "0009");
				byte[] bfComm 	= this.getReqCommMsg(EDIConstants.TR_CD_T09, 0, EDIConstants.TX_COMM_LENGTH + bfData.length, EDIConstants.Ft.TX_DATA_LENGTH);
				this.sendMessage(this.getRequestMessage(bfComm, bfData));
				
			} catch (Exception ie) {
				System.out.println("Exception:" + e);
			}
			result = -1;
			e.printStackTrace();
		}

		return result;
	}

	/**
	 * <pre></pre>
	 * 
	 * @param gubunCd
	 * @param len
	 * @return
	 * @throws Exception
	 */
	private byte[] parseFt01Message(String gubunCd, int len) throws Exception {
		/* 데이터부분 메시지 변환 xml -> byte */
		String today =  new java.text.SimpleDateFormat("yyMMdd").format(new java.util.Date());
		StringBuffer bufXml = new StringBuffer();
		bufXml.append("<DATA>");
		bufXml.append(EDIConstants.Ft.TX_TERM_ID);
		bufXml.append(EDIConstants.Ft.TX_FILENAME_DELIM);
//		bufXml.append(EDIConstants.Ft.TX_DEFT_SEQ);
		bufXml.append("08");
		bufXml.append(EDIConstants.Ft.TX_FILENAME_DELIM);
		bufXml.append(today.substring(0, 4));	//
		bufXml.append(EDIConstants.Ft.TX_FILENAME_DELIM);
		bufXml.append(today.substring(0, 4));
		bufXml.append(EDIConstants.Ft.TX_FILENAME_DELIM);
		bufXml.append(today);
		bufXml.append("</DATA>\n");
		/**/
		System.out.println("#######################################################################");
		System.out.println("XML:[" + bufXml.toString() + "]");
		System.out.println("#######################################################################");

		return this.getRquestDataMessage(gubunCd, len, bufXml);
	}
	
	/**
	 * <pre></pre>
	 * 
	 * @param gubunCd
	 * @param recCnt
	 * @param txDataCnt
	 * @param columns
	 * @param list
	 * @return
	 * @throws Exception
	 */
	private byte[] parseFt02Message(String gubunCd, int recCnt, int txDataCnt, String[] columns, List<List<String>> list) throws Exception {
		List<String> dataList = null;
		int currentRow 	= 0;
		int startRow 	= recCnt;//(recCnt * 2);
		int endRow 		= (startRow + EDIConstants.Ft.TX_MAX_RECD_CNT) > list.size() 
							? list.size() : (recCnt+EDIConstants.Ft.TX_MAX_RECD_CNT);
		System.out.println("#######################################################################");
		System.out.println("#### totRecCnt:		[" + recCnt + "]");
		System.out.println("#### txDataCnt:     [" + txDataCnt + "]");
//		System.out.println("#### length:   		[" + txLen + "]");
		System.out.println("#### startRow: 		[" + startRow + "]");
		System.out.println("#### endRow:   		[" + endRow + "]");
		System.out.println("#######################################################################");	
		/**/
		
		StringBuffer sbufXml 	= null;
		String data 			= null;
		
		int trRecCnt = endRow - startRow;	// 전송 레코드 카운트
		int dataBuffSize = EDIConstants.Ft.TX_DATA_LENGTH * (trRecCnt < EDIConstants.Ft.TX_MAX_RECD_CNT? trRecCnt + 1: trRecCnt);
		byte[] dataBuff 		= new byte[dataBuffSize];
		for (int i=startRow; i<endRow; i++) {
			System.out.println("#### current row:   [" + i + "]");
			dataList = (List<String>) list.get(i);
			
			if (columns.length != dataList.size()) {
				throw new Exception("Invalid columns!");
			}
			
			sbufXml = new StringBuffer();
			for (int ii = 0; ii < columns.length; ii++) {
				data = (String) dataList.get(ii);
				sbufXml.append("<").append(columns[ii]).append(">");
				sbufXml.append(data);
				sbufXml.append("</").append(columns[ii]).append(">\n");
			}
			
			/* 데이터부분 메시지 변환 xml -> byte */
			byte[] bufTmp =  this.getRquestDataMessage(gubunCd, EDIConstants.Ft.TX_DATA_LENGTH, sbufXml);				
			System.arraycopy(bufTmp, 0, dataBuff, (currentRow * EDIConstants.Ft.TX_DATA_LENGTH) , bufTmp.length);
			currentRow++;
		}
		
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>> trRecCnt:"+ trRecCnt);
		if (trRecCnt < EDIConstants.Ft.TX_MAX_RECD_CNT) {
			/* 데이터부분 메시지 변환 xml -> byte */
			byte[] bufTmp =  this.getRquestTotRecMsg(gubunCd, list.size() + 1);	
			System.arraycopy(bufTmp, 0, dataBuff, (currentRow * EDIConstants.Ft.TX_DATA_LENGTH) , bufTmp.length);
		}
		
		return dataBuff;
	}
	
	
	/**
	 * <pre>오류메세지 </pre>
	 * 
	 * @param gubunCd
	 * @param errCode
	 * @return
	 * @throws Exception
	 */
	private byte[] parseFt09Message(String gubunCd, String errCode) throws Exception {
		StringBuffer sbufXml = new StringBuffer();
		sbufXml.append("<ERROR_CD>").append(errCode).append("</ERROR_CD>\n");
		
		return this.getRquestDataMessage(gubunCd, EDIConstants.Ft.TX_ERROR_LENGTH, sbufXml);
	}
	
	
	/**
	 * <pre>
	 * 구분코드에 해당하는 전문포맷에 맞춰  데이터부를 byte로 변환후 리턴한다.
	 * </pre>
	 * 
	 * @param gubunCd 구분코드
	 * @param dataLen 레코드 버퍼 사이즈
	 * @param sbuf 데이터 xml
	 * @return 요청 메세지 byte
	 * @throws Exception
	 */
	public byte[] getRquestDataMessage(String gubunCd, int buffSize, StringBuffer sbuf) throws Exception {
		/* 데이타부 */
		StringBuffer bufXml = new StringBuffer();
		bufXml.append("<?xml version='1.0' encoding='euc-kr'?>\n");
		bufXml.append("<REQ_XML>\n");
		bufXml.append(sbuf);
		bufXml.append("</REQ_XML>\n");
		/**/
		System.out.println("#######################################################################");
		System.out.println("DATA_XML:[" + bufXml.toString() + "]");
		System.out.println("#######################################################################");
		
		Document dRequest = DocumentHelper.parseText(bufXml.toString());
		byte[] buff = new byte[buffSize];
		System.out.println("#### EDIMessageHandler.getRquestMessage: ");
		
		return this.getRquestMessage(dRequest, buff, this.getMessageNod(gubunCd));		
	}
	
	/**
	 * <pre>
	 * 구분코드에 해당하는 전문포맷에 맞춰  데이터부를 byte로 변환후 리턴한다.
	 * </pre>
	 * 
	 * @param gubunCd 구분코드
	 * @param totRecCnt 레코드 사이즈
	 * @return 요청 메세지 byte
	 * @throws Exception
	 */
	public byte[] getRquestTotRecMsg(String gubunCd, int totRecCnt) throws Exception {
		/* 데이타부 */
		StringBuffer bufXml = new StringBuffer();
		bufXml.append("<?xml version='1.0' encoding='euc-kr'?>\n");
		bufXml.append("<REQ_XML>\n");
		bufXml.append("<REC_FLAG>").append("T").append("</REC_FLAG>\n");
		bufXml.append("<TOT_REC_CNT>").append(totRecCnt).append("</TOT_REC_CNT>\n");
		bufXml.append("<FILLER>").append("").append("</FILLER>\n");
		bufXml.append("</REQ_XML>\n");
		/**/
		System.out.println("#######################################################################");
		System.out.println("DATA_XML:[" + bufXml.toString() + "]");
		System.out.println("#######################################################################");
		
		Document dRequest = DocumentHelper.parseText(bufXml.toString());
		byte[] buff = new byte[200];
		System.out.println("#### EDIMessageHandler.getRquestMessage: ");
		
		return this.getRquestMessage(dRequest, buff, this.getMessageNod(gubunCd) +"t");		
	}


	
	/**
	 * 테스트
	 * 
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String args[]) throws IOException {
		try {
			Psal929EDI edi = new Psal929EDI();
			edi.sendTest();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void sendTestdata() {
		
	}
	
	public void sendTest() {
		String dColumns[] = { 
				 "REC_FLAG"
				,"DEVICE_ID"
				,"WORK_FLAG"
				,"COMP_NO"
				,"CARD_NO"
				,"EXP_DT"
				,"DIV_MONTH"
				,"APPR_AMT"
				,"SVC_AMT"
				,"APPR_NO"
				,"APPR_DT"
				,"APPR_TIME"
				,"CAN_DT"
				,"CAN_TIME"
				,"CCOMP_CD"
				,"BCOMP_CD"
				,"JBRCH_ID"
				,"DOLLAR_FLAG"
				,"FILLER"
		};
		
		String hColumns[] = { 
				  "CHRG_DT"      
				, "CHRG_SEQ"     
				, "REC_FLAG"     
				, "REC_CNT"      
				, "SUM_AMT"      
				, "FILLER"       
				, "EDI_SEND_DATE"
				, "REG_DATE"     
				, "REG_ID"    
		};
		
		try {
//			Psal929EDI esvc = new Psal929EDI();
			List<List<String>> hList = new ArrayList<List<String>>();
			List<List<String>> dList = new ArrayList<List<String>>();
			
			List<String> dataList = new ArrayList<String>();
			dataList.add("D");
			dataList.add("1111");
			dataList.add("11");
			dataList.add("02");
			dataList.add("1111222233334444");
			dataList.add("1230");
			dataList.add("0");
			dataList.add("50000");
			dataList.add("0");
			dataList.add("9900001");
			dataList.add("20100530");
			dataList.add("1222");
			dataList.add("");
			dataList.add("");
			dataList.add("02");
			dataList.add("02");
			dataList.add("01000001");
			dataList.add("");
			dataList.add("");
			dList.add(dataList);
			dList.add(dataList);
			dList.add(dataList);
			dList.add(dataList);
			dList.add(dataList);
			dList.add(dataList);
			
			FTService(dColumns, dList, null);
		}
		catch(Exception e) {
			
		}
	}
}
