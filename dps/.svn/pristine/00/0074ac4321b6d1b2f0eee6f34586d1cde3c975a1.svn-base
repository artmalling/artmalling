<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 조직코드> 점정보관리
 * 작 성 일 : 2010.02.07
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod0010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2010.02.07 (정진영) 신규작성
 ******************************************************************************/
--> 

<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var newMasterYn = false;
 var btnClickSave = false;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.07
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화    
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_STR_CD, "CODE^2", PK);           //점코드 (영문, 숫자)
    initEmEdit(EM_STR_NAME, "GEN^40", PK);         //점명
    initEmEdit(EM_SMEDI_ID, "CODE^20", PK);             //스마일EDI ID
    initEmEdit(EM_SMEDI_EMAIL, "GEN^40", PK);             //스마일EDI 이메일
    initEmEdit(EM_SMEDI_CHAR_ID, "CODE^10", PK);             //스마일EDI 담당자
    initEmEdit(EM_SMEDI_CHAR_NM, "GEN", READ);           //스마일EDI 담당자명
    initEmEdit(EM_COMP_NO, "000-00-00000", PK);          //사업자번호
    initEmEdit(EM_CORP_NO, "000000-0000000", PK);          //법인번호
    initEmEdit(EM_COMP_NAME, "GEN^40", PK);        //상호명
    initEmEdit(EM_REP_NAME, "GEN^20", PK);         //대표자명
    initEmEdit(EM_BIZ_STAT, "GEN^40", PK);         //업태
    initEmEdit(EM_BIZ_CAT, "GEN^40", PK);          //종목
    initEmEdit(EM_POST_NO, "POST", READ);         //우편번호
    initEmEdit(EM_ADDR, "GEN^80", READ);             //주소
    initEmEdit(EM_DTL_ADDR, "GEN^80", PK);         //상세주소
    initEmEdit(EM_REP_TEL1_NO, "CODE^4^0", PK);       //대표전화
    initEmEdit(EM_REP_TEL2_NO, "CODE^4^0", PK);       //대표전화
    initEmEdit(EM_REP_TEL3_NO, "CODE^4^0", PK);       //대표전화
    
    initEmEdit(EM_SMEDI_TEL1_NO, "CODE^4^0", PK);       //대표전화
    initEmEdit(EM_SMEDI_TEL2_NO, "CODE^4^0", PK);       //대표전화
    initEmEdit(EM_SMEDI_TEL3_NO, "CODE^4^0", PK);       //대표전화
    
    initEmEdit(EM_FAX1_NO, "CODE^4^0", NORMAL);             //FAX번호
    initEmEdit(EM_FAX2_NO, "CODE^4^0", NORMAL);             //FAX번호
    initEmEdit(EM_FAX3_NO, "CODE^4^0", NORMAL);             //FAX번호
    initEmEdit(EM_DISP_NO, "NUMBER^2^0", NORMAL);   //조회순서
    initEmEdit(EM_APP_S_DT, "YYYYMMDD", PK);    //적용시작일
    initEmEdit(EM_APP_E_DT, "YYYYMMDD", PK);    //적용종료일
    initEmEdit(EM_OPEN_TIME, "HHMI", PK);    //개점시간
    initEmEdit(EM_CLOSE_TIME, "HHMI", PK);    //폐점시간
    initEmEdit(EM_BAL_CHK_TIME, "HHMI", PK);    //시재점검가능시간
    //initEmEdit(EM_BSK_RFD_AMT, "NUMBER^5^0", PK);    //장바구니환불금액
    //initEmEdit(EM_BSK_RFD_CNT, "NUMBER^2^0", PK);    //장바구니환불가능횟수
    //initEmEdit(EM_CASH_RECP_PSBL_AMT, "NUMBER^9^0", NORMAL);    //현금영수증발행금액
    //initEmEdit(EM_PACKET_CRYPT_KEY, "GEN^16", NORMAL);        //패킷암호키

    // MARIO OUTLET START
    /*
    initEmEdit(EM_BUY_ACC_VEN_CD,     "CODE^10^#",     PK);          //매입거래선
    initEmEdit(EM_BUY_ACC_VEN_NAME,    "GEN",            NORMAL);      //매입거래선명
    initEmEdit(EM_SALE_ACC_VEN_CD,    "CODE^10^#",     PK);          //매출거래선
    initEmEdit(EM_SALE_ACC_VEN_NAME,    "GEN",           NORMAL);      //매출거래선명
    */
 	// MARIO OUTLET END
    
    //오브젝트 속성 재 정의    
    EM_STR_CD.Enable = false;   //수정불가
    EM_STR_CD.Alignment = 0;    //왼쪽정렬
    EM_COMP_NO.Alignment = 0;   //왼쪽정렬
    EM_CORP_NO.Alignment = 0;   //왼쪽정렬
    
    //0보다 큰값 입력(NUMBER)
    EM_DISP_NO.NumericRange = "0~+:0";
    //EM_BSK_RFD_AMT.NumericRange = "0~+:0"; 
    //EM_BSK_RFD_CNT.NumericRange = "0~+:0";
    //EM_CASH_RECP_PSBL_AMT.NumericRange = "0~+:0";
    
    //콤보 초기화
    initComboStyle(LC_O_FCL_FLAG,DS_O_FCL_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);      //시설구분(조회)
    initComboStyle(LC_O_BSTR_FLAG,DS_O_BSTR_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //지점구분(조회)
    initComboStyle(LC_O_STR_FLAG,DS_O_STR_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //점구분(조회)

    initComboStyle(LC_I_CORP_FLAG,DS_I_CORP_FLAG, "CODE^0^30,NAME^0^70", 1, PK);    //법인구분
    initComboStyle(LC_I_FCL_FLAG,DS_I_FCL_FLAG, "CODE^0^30,NAME^0^70", 1, READ);      //시설구분
    initComboStyle(LC_I_STR_FLAG,DS_I_STR_FLAG, "CODE^0^30,NAME^0^70", 1, READ);      //점구분
    initComboStyle(LC_I_AREA_FLAG,DS_I_AREA_FLAG, "CODE^0^30,NAME^0^70", 1, PK);    //지역구분
    initComboStyle(LC_I_MNG_FLAG,DS_I_MNG_FLAG, "CODE^0^30,NAME^0^70", 1, PK);      //운영구분
    initComboStyle(LC_I_BSTR_FLAG,DS_I_BSTR_FLAG, "CODE^0^30,NAME^0^70", 1, PK);    //지점구분
    initComboStyle(LC_I_USE_YN,DS_I_USE_YN, "CODE^0^30,NAME^0^70", 1, PK);          //사용여부
    //initComboStyle(LC_I_CASH_RECP_SELF_YN,DS_I_CASH_RECP_SELF_YN, "CODE^0^30,NAME^0^70", 1, PK);   //현금영수증자진발행여부
    //initComboStyle(LC_I_PACKET_CRYPT_YN,DS_I_PACKET_CRYPT_YN, "CODE^0^30,NAME^0^70", 1, PK);          //패킷암호화여부

    initComboStyle(LC_I_BUPLA,DS_I_BUPLA, "CODE^0^40,NAME^0^90", 1, PK);          //사업장코드
    initComboStyle(LC_I_GSBER,DS_I_GSBER, "CODE^0^40,NAME^0^90", 1, NORMAL);          //사업영역코드
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_FCL_FLAG", "D", "P034", "Y");
    getEtcCode("DS_O_BSTR_FLAG", "D", "P055", "Y");
    getEtcCode("DS_O_STR_FLAG", "D", "P045", "Y");
    
    getEtcCode("DS_I_CORP_FLAG", "D", "P022", "N");
    getEtcCode("DS_I_FCL_FLAG", "D", "P034", "N");
    getEtcCode("DS_I_STR_FLAG", "D", "P045", "N");
    getEtcCode("DS_I_AREA_FLAG", "D", "P054", "N");
    getEtcCode("DS_I_MNG_FLAG", "D", "P038", "N");
    getEtcCode("DS_I_BSTR_FLAG", "D", "P055", "N");
    getEtcCode("DS_I_USE_YN", "D", "D022", "N");
    //getEtcCode("DS_I_CASH_RECP_SELF_YN", "D", "D022", "N");
    //getEtcCode("DS_I_PACKET_CRYPT_YN", "D", "D022", "N");

    getEtcCode("DS_I_BUPLA", "D", "P099", "N");
    getEtcCode("DS_I_GSBER", "D", "P100", "N");
    insComboData( LC_I_GSBER, "", "",1);

    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_FCL_FLAG,"%");
    setComboData(LC_O_BSTR_FLAG,"%");
    setComboData(LC_O_STR_FLAG,"%");

    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod001","DS_IO_MASTER" );
    
    enableCnt();
    LC_O_FCL_FLAG.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                     + '<FC>id=STR_CD      name="점코드"     width=40   align=center</FC>'
                     + '<FC>id=STR_NAME    name="점명"       width=93   align=left</FC>'
                     + '<FC>id=FCL_FLAG    name="시설구분"   width=60   align=left EditStyle=Lookup   Data="DS_I_FCL_FLAG:CODE:NAME"</FC>'

                     + '<FC>id=BSTR_FLAG      name="지점구분 "     width=50   align=center  show="false"</FC>'
                     + '<FC>id=STR_FLAG      name="점구분"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=MNG_FLAG      name="운영구분 "     width=50   align=center  show="false"</FC>'
                     + '<FC>id=CORP_FLAG      name="법인구분"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=AREA_FLAG      name="지역구분"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=DISP_NO      name="조회순서"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=BUPLA      name="사업장"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=GSBER      name="사업영역"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=BUY_ACC_VEN_CD      name="구매처코드"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=SALE_ACC_VEN_CD      name="거래처코드"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=USE_YN      name="사용여부"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=APP_S_DT      name="적용시작일 "     width=50   align=center  show="false"</FC>'
                     + '<FC>id=APP_E_DT      name="적용종료일"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=SMEDI_CHAR_ID      name="스마일EDI 담당자"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=SMEDI_ID      name="스마일EDI ID"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=SMEDI_EMAIL      name="스마일EDI 이메일"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=COMP_NO      name="사업자번호"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=CORP_NO      name="법인번호"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=COMP_NAME      name="상호명 "     width=50   align=center  show="false"</FC>'
                     + '<FC>id=REP_NAME      name="대표자명"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=BIZ_STAT      name="업태"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=BIZ_CAT      name="종목 "     width=50   align=center  show="false"</FC>'
                     + '<FC>id=POST_NO      name="주소"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=ADDR      name="주소"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=DTL_ADDR      name="주소"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=REP_TEL1_NO      name="대표전화"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=REP_TEL2_NO      name="대표전화"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=REP_TEL3_NO      name="대표전화"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=SMEDI_TEL1_NO      name="담당전화-지역"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=SMEDI_TEL2_NO      name="담당전화-국"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=SMEDI_TEL3_NO      name="담당전화-번호"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=FAX1_NO      name="FAX번호"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=FAX2_NO      name="FAX번호"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=FAX3_NO      name="FAX번호"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=OPEN_TIME      name="개점시간"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=CLOSE_TIME      name="폐점시간"     width=50   align=center  show="false"</FC>'
                     + '<FC>id=BAL_CHK_TIME      name="시재점검 가능시간"     width=50   align=center  show="false"</FC>'
                     //+ '<FC>id=BSK_RFD_AMT      name="장바구니 환불금액"     width=50   align=center  show="false"</FC>'
                     //+ '<FC>id=BSK_RFD_CNT      name="장바구니환불가능횟수"     width=50   align=center  show="false"</FC>'
                     //+ '<FC>id=CASH_RECP_SELF_YN      name="현금영수증자진발행여부"     width=50   align=center  show="false"</FC>'
                     //+ '<FC>id=CASH_RECP_PSBL_AMT      name="현금영수증발행금액"     width=50   align=center  show="false"</FC>'
                     //+ '<FC>id=PACKET_CRYPT_YN      name="패킷암호화여부"     width=50   align=center  show="false"</FC>'
                     //+ '<FC>id=PACKET_CRYPT_KEY      name="패킷암호키"     width=50   align=center  show="false"</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.07
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if( DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
        	EM_STR_NAME.Focus();
            return false;
        }
    }
	
    newMasterYn = false;
    DS_IO_MASTER.ClearData();
     
    var strFclFlag   = LC_O_FCL_FLAG.BindColVal;
    var strBstrFlag = LC_O_BSTR_FLAG.BindColVal;
    var strStrFlag   = LC_O_STR_FLAG.BindColVal;

    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strFclFlag="+encodeURIComponent(strFclFlag)
                   + "&strBstrFlag="+encodeURIComponent(strBstrFlag)
                   + "&strStrFlag="+encodeURIComponent(strStrFlag);
    TR_MAIN.Action="/dps/pcod001.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);
    
}
/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.07
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 
    //기존의 신규로우 존재 시 데이타 클리어 
    if( newMasterYn ) {
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1 ){   
        	EM_STR_CD.Focus();
            return;
        }
        DS_IO_MASTER.DeleteRow(DS_IO_MASTER.CountRow);
    }

    //수정된 내용 존재시
    if( DS_IO_MASTER.IsUpdated){
    	//변경 된 상세 내역이 존재합니다.<br> 신규 작성  하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1050") != 1){            
            EM_STR_NAME.Focus();
            return ;
        }
        DS_IO_MASTER.UndoAll();
    }
        
    //행추가
    DS_IO_MASTER.Addrow();

    var row = DS_IO_MASTER.CountRow;
    //기초값 및 컴포넌트 상태 변경
    setObjTypeStyle( LC_I_FCL_FLAG, "COMBO", PK );
    setObjTypeStyle( LC_I_STR_FLAG, "COMBO", PK );
    DS_IO_MASTER.NameValue( row, "APP_S_DT") = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));
    DS_IO_MASTER.NameValue( row, "APP_E_DT") = "99991231" ;
    DS_IO_MASTER.NameValue( row, "USE_YN") = "Y" ;
   // DS_IO_MASTER.NameValue( row, "CASH_RECP_SELF_YN") = "Y" ;
    newMasterYn = true;
    
    EM_STR_CD.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.07
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.07
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if( DS_IO_MASTER.CountRow < 1){
        	LC_O_FCL_FLAG.Focus();
            return;
        }        	
        EM_STR_NAME.Focus();
        return;
    }
    // 필수 입력값 체크( gauce.js)
    if( !checkBindBlank( GD_MASTER, BO_HEADER, "DISP_NO,SMEDI_CHAR_ID,SMEDI_ID,SMEDI_EMAIL,SMEDI_TEL1_NO,SMEDI_TEL2_NO,SMEDI_TEL3_NO,GSBER,FAX1_NO,FAX2_NO,FAX3_NO"))
    	return;
    var row = DS_IO_MASTER.RowPosition;
    // 담당자 체크
    /*  마라오 수정(20120710)
    if( DS_IO_MASTER.NameValue( row, "SMEDI_CHAR_NM") == "" ){
        showMessage(EXCLAMATION, OK, "USER-1036", "담당자");
        EM_SMEDI_CHAR_ID.Focus();
        return ;
    }   
    */ 
    // MARIO OUTLET START
    // 매입처 체크
    /*
    if( EM_BUY_ACC_VEN_NAME.Text == "" ){
        showMessage(EXCLAMATION, OK, "USER-1036", "매입처");
        EM_BUY_ACC_VEN_CD.Focus();
        return ;
    }
    // 거래처 체크
    if( EM_SALE_ACC_VEN_NAME.Text == "" ){
        showMessage(EXCLAMATION, OK, "USER-1036", "거래처");
        EM_SALE_ACC_VEN_CD.Focus();
        return ;
    }
    */
 	// MARIO OUTLET END
 
    // 점코드 자리수 체크
    var strCd = DS_IO_MASTER.NameValue( row, "STR_CD");
    strCd = trim(strCd);
    if( strCd.length != 2 ){
        showMessage(EXCLAMATION, Ok,  "USER-1027", "점코드", 2);
        EM_STR_CD.Focus();
        return ;
    }
    // 점코드 중복체크
    var dupRow = checkDupKey(DS_IO_MASTER, "STR_CD");
    if (dupRow > 0) {
        showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);
        
        DS_IO_MASTER.NameValue( dupRow, "STR_CD")    = "";
        DS_IO_MASTER.RowPosition = dupRow;
        EM_STR_CD.Focus();
        return ;
    }

    var appSDt = DS_IO_MASTER.NameValue( row, "APP_S_DT");
    var appEDt = DS_IO_MASTER.NameValue( row, "APP_E_DT");
    
    if( !isBetweenFromTo(appSDt,appEDt)){
        showMessage(EXCLAMATION, Ok,  "USER-1015");
        EM_APP_E_DT.Focus();
        return ;    	
    }

    var openTime = DS_IO_MASTER.NameValue( row, "OPEN_TIME");
    var closeTime = DS_IO_MASTER.NameValue( row, "CLOSE_TIME");
    
    if( openTime > closeTime){
        showMessage(EXCLAMATION, Ok,  "USER-1009", "개점시간", "폐점시간");
        EM_CLOSE_TIME.Focus();
        return ;        
    }

    /*
    ㅇPOS와 자리수 동기화
   - 2010-04-22 오후 5:04:22
   - 점명 : 20Byte (DB변경 안함)
   - 대표자명 : 20Byte (DB변경 안함)
   - 주소 : 주소 + 상세주소 40Byte (DB변경 안함)
    */
    if( !checkInputByte( null, DS_IO_MASTER, row, 'STR_NAME', '점명',  "EM_STR_NAME", 20))
        return;
    if( !checkInputByte( null, DS_IO_MASTER, row, 'COMP_NAME', '상호명',  "EM_COMP_NAME"))
        return;
    if( !checkInputByte( null, DS_IO_MASTER, row, 'REP_NAME', '대표자명',  "EM_REP_NAME", 40))
        return;
    if( !checkInputByte( null, DS_IO_MASTER, row, 'BIZ_STAT', '업태',  "EM_BIZ_STAT"))
        return;
    if( !checkInputByte( null, DS_IO_MASTER, row, 'BIZ_CAT', '종목',  "EM_BIZ_CAT"))
        return;

    var addr = DS_IO_MASTER.NameValue(row,'ADDR') + DS_IO_MASTER.NameValue(row,'DTL_ADDR');
    var tmpRtn = checkByteLengthStr(addr,40,'N');
    if( tmpRtn!=null){
    	showMessage(EXCLAMATION, OK, "GAUCE-1000", "주소와 상세주소를 합쳐서 40Byte 이상 초과 입력할수 없습니다.");
    	EM_DTL_ADDR.Focus();
    	return;
    }
    /*
    if( !checkInputByte( null, DS_IO_MASTER, row, 'ADDR', '주소',  "EM_ADDR"))
        return;
    if( !checkInputByte( null, DS_IO_MASTER, row, 'DTL_ADDR', '상세주소',  "EM_DTL_ADDR"))
        return;
    */
    
    /* if( DS_IO_MASTER.NameValue(row,"PACKET_CRYPT_YN") == "Y"){
    	if(DS_IO_MASTER.NameValue(row,"PACKET_CRYPT_KEY") == ""){
            showMessage(EXCLAMATION, OK, "USER-1003", "패킷암호키");
            EM_PACKET_CRYPT_KEY.Focus();
            return;
    	}
        if( !checkInputByte( null, DS_IO_MASTER, row, 'PACKET_CRYPT_KEY', '패킷암호키',  "EM_PACKET_CRYPT_KEY"))
            return;
    } */
    
    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','01','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        EM_STR_NAME.Focus();
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        EM_STR_NAME.Focus();
        return;
    }
    btnClickSave = true;
    TR_MAIN.Action="/dps/pcod001.pc?goTo=save";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    btnClickSave = false;
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();
        var row = DS_IO_MASTER.NameValueRow("STR_CD",strCd);
        row = row<1?1:row;
        DS_IO_MASTER.RowPosition = row;
    }
    EM_STR_NAME.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.07
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.02.07
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 :2010.02.07
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/


/**
 * enableCnt()
 * 작 성 자 : FKL
 * 작 성 일 :2010.02.07
 * 개    요 : 입력항목의 사용여부지정
 * return값 : void
 */
function enableCnt( flag){
	
	enableControl(EM_STR_CD              , flag==null?false:flag); 
    enableControl(EM_STR_NAME            , flag==null?false:true); 
    enableControl(LC_I_FCL_FLAG          , flag==null?false:flag); 
    enableControl(LC_I_BSTR_FLAG         , flag==null?false:true); 
    enableControl(LC_I_STR_FLAG          , flag==null?false:flag); 
    enableControl(LC_I_MNG_FLAG          , flag==null?false:true); 
    enableControl(LC_I_CORP_FLAG         , flag==null?false:true); 
    enableControl(LC_I_AREA_FLAG         , flag==null?false:true); 
    enableControl(EM_DISP_NO             , flag==null?false:true); 
    enableControl(LC_I_USE_YN            , flag==null?false:true); 
    enableControl(EM_APP_S_DT            , flag==null?false:true); 
    enableControl(IMG_APP_S_DT           , flag==null?false:true); 
    enableControl(EM_APP_E_DT            , flag==null?false:true); 
    enableControl(IMG_APP_E_DT           , flag==null?false:true); 
    enableControl(EM_SMEDI_CHAR_ID       , flag==null?false:true); 
    enableControl(IMG_CHAR_ID            , flag==null?false:true); 
    enableControl(EM_SMEDI_ID            , flag==null?false:true); 
    enableControl(EM_SMEDI_EMAIL         , flag==null?false:true); 
    enableControl(EM_COMP_NO             , flag==null?false:true); 
    enableControl(EM_CORP_NO             , flag==null?false:true); 
    enableControl(EM_COMP_NAME           , flag==null?false:true); 
    enableControl(EM_REP_NAME            , flag==null?false:true); 
    enableControl(EM_BIZ_STAT            , flag==null?false:true); 
    enableControl(EM_BIZ_CAT             , flag==null?false:true); 
    enableControl(IMG_POST               , flag==null?false:true); 
    enableControl(EM_DTL_ADDR            , flag==null?false:true); 
    enableControl(EM_REP_TEL1_NO         , flag==null?false:true); 
    enableControl(EM_REP_TEL2_NO         , flag==null?false:true); 
    enableControl(EM_REP_TEL3_NO         , flag==null?false:true); 
    
    enableControl(EM_SMEDI_TEL1_NO         , flag==null?false:true); 
    enableControl(EM_SMEDI_TEL2_NO         , flag==null?false:true); 
    enableControl(EM_SMEDI_TEL3_NO         , flag==null?false:true); 
    
    
    enableControl(EM_FAX1_NO             , flag==null?false:true); 
    enableControl(EM_FAX2_NO             , flag==null?false:true); 
    enableControl(EM_FAX3_NO             , flag==null?false:true); 
    enableControl(EM_OPEN_TIME           , flag==null?false:true); 
    enableControl(EM_CLOSE_TIME          , flag==null?false:true); 
    enableControl(EM_BAL_CHK_TIME        , flag==null?false:true); 
    //enableControl(EM_BSK_RFD_AMT         , flag==null?false:true); 
    //enableControl(EM_BSK_RFD_CNT         , flag==null?false:true); 
    //enableControl(LC_I_CASH_RECP_SELF_YN , flag==null?false:true); 
    //enableControl(EM_CASH_RECP_PSBL_AMT  , flag==null?false:true); 
    //enableControl(LC_I_PACKET_CRYPT_YN   , flag==null?false:true); 
    //enableControl(EM_PACKET_CRYPT_KEY    , flag==null?false:true); 

    enableControl(LC_I_BUPLA             , flag==null?false:true); 
    enableControl(LC_I_GSBER             , flag==null?false:true); 
 	// MARIO OUTLET START
 	/*
    enableControl(EM_BUY_ACC_VEN_CD      , flag==null?false:true); 
    enableControl(IMG_BUY_ACC_VEN_CD     , flag==null?false:true); 
    enableControl(EM_SALE_ACC_VEN_CD     , flag==null?false:true); 
    enableControl(IMG_SALE_ACC_VEN_CD    , flag==null?false:true); 
    */
 	// MARIO OUTLET END
} 


/**
 * setAccVenCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-04-04
 * 개    요 : 거래선 팝업을 실행한다.
 * return값 : void
**/
function setAccVenCode(evnFlag, accFlag, codeObj, nameObj){
    
    if( evnFlag == 'POP'){
        accVenPop(codeObj,nameObj, accFlag);
        codeObj.Focus();
        return;
    }

    if( codeObj.Text ==""){
        nameObj.Text = "";    
        return;
    }
    
    setAccVenNmWithoutPop( "DS_O_RESULT",codeObj, nameObj, accFlag, 1);
}


-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnDataError(row,colid)>
var colName = GD_MASTER.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(EXCLAMATION, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(EXCLAMATION, OK, "GAUCE-1007", row);
} else {
    showMessage(EXCLAMATION, OK, "USER-1000", this.ErrorMsg);
}
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    enableCnt(this.RowStatus(row) == 1);
    var appSDt = this.NameValue(row,"APP_S_DT");
    if( this.RowStatus(row) != 1 && appSDt < getTodayFormat("YYYYMMDD") ){
        enableControl(EM_APP_S_DT            , false); 
        enableControl(IMG_APP_S_DT           , false); 
    }else{
        enableControl(EM_APP_S_DT            , true); 
        enableControl(IMG_APP_S_DT           , true); 
    }
</script>
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
    if( this.IsUpdated && !btnClickSave){

        if(this.RowStatus(row) == '1' && newMasterYn){
        	//변경 된 상세 내역이 존재합니다.<br> 이동  하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1049") != 1){
            	EM_STR_NAME.Focus();
                return false;
            }
        	//등록된 내용 삭제
            this.DeleteRow(row);
            setObjTypeStyle( LC_I_FCL_FLAG, "COMBO", READ );
            setObjTypeStyle( LC_I_STR_FLAG, "COMBO", READ );
            newMasterYn = false;
        }else{
        	//변경 된 상세 내역이 존재합니다.<br> 이동  하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1049") != 1){
                EM_STR_NAME.Focus();
                return false;
            }

        	//변경된 데이터 원상복귀
            var ColCnt = this.CountColumn;
            for( var i=1; i<=ColCnt;i++){
            	if(this.RWStatus(row,i) != 0)
                    this.NameValue( row, this.ColumnID(i)) = this.OrgNameValue(row,this.ColumnID(i));
            }
        }
    }
    
    return true;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>

<!-- 담당자 한건 조회 -->
<script language=JavaScript for=EM_SMEDI_CHAR_ID event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
    	return;
    	
	if(this.text==''){
		EM_SMEDI_CHAR_NM.Text = "";
		return;
	}	
	setUserNmWithoutPop('DS_O_RESULT', '담당자', 'SEL_USR_MST', this , EM_SMEDI_CHAR_NM,1);
</script>

<!-- 이메일 정합성 체크 -->
<script language=JavaScript for=EM_SMEDI_EMAIL event=onKillFocus()>
    if(this.text=='')
        return;
    
    if(!isValidStrEmail(this.text)){
    	showMessage(EXCLAMATION, OK, "USER-1004", "이메일");
        this.text = "";
        setTimeout(this.id+".Focus();",50);
        return;
    } 
</script>

<!--매입거래선 입력시  -->
<script language=JavaScript for=EM_BUY_ACC_VEN_CD event=onKillFocus()>

//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setAccVenCode('NAME','1',EM_BUY_ACC_VEN_CD,EM_BUY_ACC_VEN_NAME);
</script>
<!--매출거래선 입력시  -->
<script language=JavaScript for=EM_SALE_ACC_VEN_CD event=onKillFocus()>

//변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    setAccVenCode('NAME','2',EM_SALE_ACC_VEN_CD,EM_SALE_ACC_VEN_NAME);
</script>
<!-- 적용시작일 -->
<script language=JavaScript for=EM_APP_S_DT event=onKillFocus()>
    if(!checkDateTypeYMD(this,getRawData(addDate('D',1,getTodayFormat('YYYYMMDD'))),"DS_IO_MASTER","APP_S_DT"))
    	return;
    var rowStatus = DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition);
    if(getTodayFormat("YYYYMMDD") > this.text){
        showMessage(EXCLAMATION, OK, "USER-1030", "적용시작일");
        this.text = rowStatus=='1'?getRawData(addDate('D',1,getTodayFormat('YYYYMMDD'))):DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,'APP_S_DT');
        setTimeout(this.id+".Focus();",50);
        return;    	
    }
</script>
<!-- 적용종료일 -->
<script language=JavaScript for=EM_APP_E_DT event=onKillFocus()>
    if(!checkDateTypeYMD(this,getRawData(addDate('D',1,getTodayFormat('YYYYMMDD'))),"DS_IO_MASTER","APP_E_DT"))
        return;

    var rowStatus = DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition);
    if(getTodayFormat("YYYYMMDD") > this.text){
        showMessage(EXCLAMATION, OK, "USER-1030", "적용종료일");
        this.text = rowStatus=='1'?'99991231':DS_IO_MASTER.OrgNameValue(DS_IO_MASTER.RowPosition,'APP_E_DT');;
        setTimeout(this.id+".Focus();",50);
        return;     
    }
</script>
<!-- 사업자번호 -->
<script language=JavaScript for=EM_COMP_NO event=onKillFocus()>
    if(this.text=='')
        return;
    
    if((this.Text).replace(' ','').length != 10){
        showMessage(EXCLAMATION, OK, "USER-1004", "사업자번호");
        this.text = "";
        setTimeout(this.id+".Focus();",50);
        return;
    }
     
</script>
<!-- 법인번호 -->
<script language=JavaScript for=EM_CORP_NO event=onKillFocus()>
    if(this.text=='')
        return;
    
    if((this.Text).replace(' ','').length != 13){
        showMessage(EXCLAMATION, OK, "USER-1004", "법인번호");
        this.text = "";
        setTimeout(this.id+".Focus();",50);
        return;
    }
     
</script>

<!-- 개점시간 -->
<script language=JavaScript for=EM_OPEN_TIME event=onKillFocus()>
    if(this.text=='')
        return;
    
    if((this.Text).replace(' ','').length != 4){
        showMessage(EXCLAMATION, OK, "USER-1004", "개점시간");
        this.text = "";
        setTimeout(this.id+".Focus();",50);
        return;
    }
     
</script>
<!-- 폐점시간 -->
<script language=JavaScript for=EM_CLOSE_TIME event=onKillFocus()>
    if(this.text=='')
        return;
    
    if((this.Text).replace(' ','').length != 4){
        showMessage(EXCLAMATION, OK, "USER-1004", "폐점시간");
        this.text = "";
        setTimeout(this.id+".Focus();",50);
        return;
    }
     
</script>
<!-- 시재점검가능시간 -->
<script language=JavaScript for=EM_BAL_CHK_TIME event=onKillFocus()>
    if(this.text=='')
        return;
    
    if((this.Text).replace(' ','').length != 4){
        showMessage(EXCLAMATION, OK, "USER-1004", "시재점검가능시간");
        this.text = "";
        setTimeout(this.id+".Focus();",50);
        return;
    }
</script>

<!-- 장바구니 환불금액 -->
<script language=JavaScript for=EM_BSK_RFD_AMT event=onKillFocus()>
    /* if(this.text==''){
        this.text = "0";
    } */
</script>
<!-- 장바구니환불가능횟수 -->
<script language=JavaScript for=EM_BSK_RFD_CNT event=onKillFocus()>
    /* if(this.text==''){
        this.text = "0";
    } */
</script>
<!-- 현금영수증발행금액 -->
<script language=JavaScript for=EM_CASH_RECP_PSBL_AMT event=onKillFocus()>
/*     if(this.text==''){
        this.text = "0";
    } */
</script>
<!-- 조회순서 -->
<script language=JavaScript for=EM_DISP_NO event=onKillFocus()>
    if(this.text==''){
        this.text = "0";
    }
</script>
<!-- 패킷암호화여부 -->
<script language=JavaScript for=LC_I_PACKET_CRYPT_YN event=OnSelChange()>
   /* if(this.BindColVal == "Y"){
	   TD_PACKET_CRYPT_KEY.className = "point";
	   setObjTypeStyle( EM_PACKET_CRYPT_KEY, "EMEDIT", PK );
   }else{
       TD_PACKET_CRYPT_KEY.className = "";
       setObjTypeStyle( EM_PACKET_CRYPT_KEY, "EMEDIT", NORMAL );	   
   } */
</script>



<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_O_FCL_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_STR_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_BSTR_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CORP_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_FCL_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STR_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_AREA_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_MNG_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_USE_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PACKET_CRYPT_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_CLOSECHECK classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_BSTR_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CASH_RECP_SELF_YN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BUPLA" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_GSBER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- =============== Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" >시설구분</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_O_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=150
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">지점구분</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_O_BSTR_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=150
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">점구분</th>
						<td><comment id="_NSID_"> <object id=LC_O_STR_FLAG
							classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr >
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr >
				<td width="260" valign="top">
				<table border="0" width=100% cellspacing="0" cellpadding="0" class="BD4A">
					<tr>
						<td><comment id="_NSID_"><object id=GD_MASTER
							width=100% height=506 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</object></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10 PT05" valign="top">
				<div id=DIV_STR_INFO style="overflow:auto;width:100%;height:506px;" >				
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="sub_title PB03 "><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
							align="absmiddle" /> 시스템정보</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="58" class="point">점코드</th>
								<td width="95"><comment id="_NSID_"> <object
									id=EM_STR_CD classid=<%=Util.CLSID_EMEDIT%> width=95
									tabindex=1 align="absmiddle" onfocus="document.all.DIV_STR_INFO.scrollTop=0">
									</object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th width="58" class="point">점명</th>
								<td colspan="3"><comment id="_NSID_"> <object
									id=EM_STR_NAME classid=<%=Util.CLSID_EMEDIT%> width=265 onfocus="document.all.DIV_STR_INFO.scrollTop=0"
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
                            </tr>
                            <tr>
								<th width="58" class="point">시설구분</th>
								<td width="95"><comment id="_NSID_"> <object
									id=LC_I_FCL_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="58" class="point">지점구분</th>
								<td width="95" ><comment id="_NSID_"> <object
									id=LC_I_BSTR_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th width="58" class="point">점구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_STR_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
                            </tr>
                            <tr>
								<th class="point">운영구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_MNG_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th class="point">법인구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_CORP_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th class="point">지역구분</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_AREA_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=95
									tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
                            </tr>
                            <tr>
								<th>조회순서</th>
								<td><comment id="_NSID_"> <object id=EM_DISP_NO
									classid=<%=Util.CLSID_EMEDIT%> width=95 tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                                <th class="point">사업장</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_I_BUPLA classid=<%=Util.CLSID_LUXECOMBO%> width=95
                                    tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th>사업영역</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_I_GSBER classid=<%=Util.CLSID_LUXECOMBO%> width=95
                                    tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                                </td>
                            </tr>
                            <!--  // MARIO OUTLET START -->
                            <!-- 
                            <tr>
                                <th class="point">구매처코드</th>
                                <td><comment id="_NSID_"> <object id=EM_BUY_ACC_VEN_CD
                                    classid=<%=Util.CLSID_EMEDIT%> width=73 tabindex=1
                                    align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
                                    src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_BUY_ACC_VEN_CD
                                    onclick="javascript:setAccVenCode('POP','1',EM_BUY_ACC_VEN_CD,EM_BUY_ACC_VEN_NAME);" align="absmiddle" />
                                    <comment id="_NSID_"><object id=EM_BUY_ACC_VEN_NAME
                                    classid=<%=Util.CLSID_EMEDIT%> width=73 tabindex=1 style="display:'none';"
                                    align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                                <th class="point">거래처코드</th>
                                <td colspan="3"><comment id="_NSID_"><object id=EM_SALE_ACC_VEN_CD
                                    classid=<%=Util.CLSID_EMEDIT%> width=73 tabindex=1
                                    align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
                                    src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_SALE_ACC_VEN_CD
                                    onclick="javascript:setAccVenCode('POP','2',EM_SALE_ACC_VEN_CD,EM_SALE_ACC_VEN_NAME);" align="absmiddle" />
                                    <comment id="_NSID_"><object id=EM_SALE_ACC_VEN_NAME
                                    classid=<%=Util.CLSID_EMEDIT%> width=73 tabindex=1 style="display:'none';"
                                    align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
                            </tr>
                             -->
                            <!-- // MARIO OUTLET END -->
                            <tr>
								<th class="point">사용여부</th>
								<td><comment id="_NSID_"> <object id=LC_I_USE_YN
									classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th class="point">적용시작일</th>
								<td><comment id="_NSID_"> <object id=EM_APP_S_DT
									classid=<%=Util.CLSID_EMEDIT%> width=73 tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" id=IMG_APP_S_DT
									onclick="javascript: if(EM_APP_S_DT.Enable) openCal('G',EM_APP_S_DT);" /></td>
								<th class="point">적용종료일</th>
								<td><comment id="_NSID_"> <object id=EM_APP_E_DT
									classid=<%=Util.CLSID_EMEDIT%> width=73 tabindex=1
									align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
									src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" id=IMG_APP_E_DT
									onclick="javascript:openCal('G',EM_APP_E_DT)" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="sub_title PB03 PT10" style="display: none"><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
							align="absmiddle" /> 스마일EDI</td>
					</tr>
					<tr >
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" style="display: none">
							<tr valign="top">
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="s_table">
									<tr>
										<th width="58" class="point">담당자</th>
										<td width="230"><comment id="_NSID_"> <object
											id=EM_SMEDI_CHAR_ID classid=<%=Util.CLSID_EMEDIT%> width=78
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_CHAR_ID
											onclick="javascript:commonPop('사원', 'SEL_USR_MST_TEST', EM_SMEDI_CHAR_ID, EM_SMEDI_CHAR_NM);EM_SMEDI_CHAR_ID.Focus();"
											align="absmiddle" /> <comment id="_NSID_"> <object
											id=EM_SMEDI_CHAR_NM classid=<%=Util.CLSID_EMEDIT%> width=121
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>

										</td>
										<th width="58" class="point">ID</th>
										<td><comment id="_NSID_"> <object
											id=EM_SMEDI_ID classid=<%=Util.CLSID_EMEDIT%> width=143
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">이메일</th>
										<td><comment id="_NSID_"> <object
											id=EM_SMEDI_EMAIL classid=<%=Util.CLSID_EMEDIT%> width=225
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th class="point">담당전화</th>
										<td width=185><comment id="_NSID_"> <object
											id=EM_SMEDI_TEL1_NO classid=<%=Util.CLSID_EMEDIT%> width=45
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										&nbsp;-&nbsp; <comment id="_NSID_"> <object id=EM_SMEDI_TEL2_NO
											classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										&nbsp;-&nbsp; <comment id="_NSID_"> <object id=EM_SMEDI_TEL3_NO
											classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="sub_title PB03 PT10" ><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
							align="absmiddle" /> 사업자정보</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="s_table">
									<tr>
										<th width="58" class="point">사업자번호</th>
										<td width=185 ><comment id="_NSID_"> <object
											id=EM_COMP_NO classid=<%=Util.CLSID_EMEDIT%> width=185
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th width="58" class="point">법인번호</th>
										<td><comment id="_NSID_"> <object
											id=EM_CORP_NO classid=<%=Util.CLSID_EMEDIT%> width=185
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">상호명</th>
										<td><comment id="_NSID_"> <object
											id=EM_COMP_NAME classid=<%=Util.CLSID_EMEDIT%> width=185
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th class="point">대표자명</th>
										<td><comment id="_NSID_"> <object
											id=EM_REP_NAME classid=<%=Util.CLSID_EMEDIT%> width=185
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point">업태</th>
										<td><comment id="_NSID_"> <object
											id=EM_BIZ_STAT classid=<%=Util.CLSID_EMEDIT%> width=185
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th class="point">종목</th>
										<td><comment id="_NSID_"><object id=EM_BIZ_CAT
											classid=<%=Util.CLSID_EMEDIT%> width=185 tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th class="point" rowspan="2">주소</th>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_POST_NO classid=<%=Util.CLSID_EMEDIT%> width=58
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script><img
											src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_POST
											onclick="javascript:getPostPop(EM_POST_NO, EM_ADDR, EM_DTL_ADDR);EM_DTL_ADDR.Focus();"
											align="absmiddle" /> <comment id="_NSID_"> <object
											id=EM_ADDR classid=<%=Util.CLSID_EMEDIT%> width=367
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<td colspan="3"><comment id="_NSID_"> <object
											id=EM_DTL_ADDR classid=<%=Util.CLSID_EMEDIT%> width=450
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
									<tr>
										<th width="58" class="point">대표전화</th>
										<td width=185><comment id="_NSID_"> <object
											id=EM_REP_TEL1_NO classid=<%=Util.CLSID_EMEDIT%> width=45
											tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										&nbsp;-&nbsp; <comment id="_NSID_"> <object id=EM_REP_TEL2_NO
											classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										&nbsp;-&nbsp; <comment id="_NSID_"> <object id=EM_REP_TEL3_NO
											classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
										<th width="58" >FAX번호</th>
										<td><comment id="_NSID_"> <object id=EM_FAX1_NO
											classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										&nbsp;-&nbsp; <comment id="_NSID_"> <object id=EM_FAX2_NO
											classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										&nbsp;-&nbsp; <comment id="_NSID_"> <object id=EM_FAX3_NO
											classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
											align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="sub_title PB03 PT10" ><img
							src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
							align="absmiddle" /> POS 기준정보</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="64" class="point">개점시간</th>
								<td width="80"><comment id="_NSID_"> <object
									id=EM_OPEN_TIME classid=<%=Util.CLSID_EMEDIT%> width=80
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th width="64" class="point">폐점시간</th>
								<td width="80"><comment id="_NSID_"> <object
									id=EM_CLOSE_TIME classid=<%=Util.CLSID_EMEDIT%> width=80
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th width="105" class="point">시재점검 가능시간</th>
								<td ><comment id="_NSID_"> <object
									id=EM_BAL_CHK_TIME classid=<%=Util.CLSID_EMEDIT%> width=80
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<%-- <tr>
					    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0"
                            class="s_table" style="border-top:0px solid #b4d0e1;">
							<tr>
								<th width="150" class="point" style="border-top:0px solid #b4d0e1;">장바구니 환불금액</th>
								<td width="115" style="border-top:0px solid #b4d0e1;"><comment id="_NSID_"> <object
									id=EM_BSK_RFD_AMT classid=<%=Util.CLSID_EMEDIT%> width=115
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
								<th width="152" class="point" style="border-top:0px solid #b4d0e1;">장바구니환불가능횟수</th>
								<td style="border-top:0px solid #b4d0e1;"><comment id="_NSID_"> <object
									id=EM_BSK_RFD_CNT classid=<%=Util.CLSID_EMEDIT%> width=115
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
								<th class="point">현금영수증자진발행여부</th>
								<td><comment id="_NSID_"> <object
									id=LC_I_CASH_RECP_SELF_YN classid=<%=Util.CLSID_LUXECOMBO%> onfocus="document.all.DIV_STR_INFO.scrollTop=DIV_STR_INFO.clientWidth"
									width=115 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
								</td>
								<th >현금영수증발행금액</th>
								<td><comment id="_NSID_"> <object
									id=EM_CASH_RECP_PSBL_AMT classid=<%=Util.CLSID_EMEDIT%> onfocus="document.all.DIV_STR_INFO.scrollTop=DIV_STR_INFO.clientWidth"
									width=88 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
									&nbsp;이상
								</td>
							</tr>
                            <tr>
                                <th class="point">패킷암호화여부</th>
                                <td><comment id="_NSID_"> <object
                                    id=LC_I_PACKET_CRYPT_YN classid=<%=Util.CLSID_LUXECOMBO%> onfocus="document.all.DIV_STR_INFO.scrollTop=DIV_STR_INFO.clientWidth"
                                    width=115 tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                                </td>
                                <th id=TD_PACKET_CRYPT_KEY >패킷암호키</th>
                                <td><comment id="_NSID_"> <object
                                    id=EM_PACKET_CRYPT_KEY classid=<%=Util.CLSID_EMEDIT%> onfocus="document.all.DIV_STR_INFO.scrollTop=DIV_STR_INFO.clientWidth"
                                    width=115 tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                                </td>
                            </tr> --%>
						</table>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_HEADER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=STR_CD              ctrl=EM_STR_CD               param=Text   Enable=Enable </c>
            <c>col=STR_NAME            ctrl=EM_STR_NAME             param=Text</c>
            <c>col=FCL_FLAG            ctrl=LC_I_FCL_FLAG           param=BindColVal </c>
            <c>col=BSTR_FLAG           ctrl=LC_I_BSTR_FLAG          param=BindColVal</c>
            <c>col=STR_FLAG            ctrl=LC_I_STR_FLAG           param=BindColVal </c>
            <c>col=MNG_FLAG            ctrl=LC_I_MNG_FLAG           param=BindColVal</c>
            <c>col=CORP_FLAG           ctrl=LC_I_CORP_FLAG          param=BindColVal</c>
            <c>col=AREA_FLAG           ctrl=LC_I_AREA_FLAG          param=BindColVal</c>
            <c>col=DISP_NO             ctrl=EM_DISP_NO              param=Text</c>
            <c>col=BUPLA               ctrl=LC_I_BUPLA              param=BindColVal</c>
            <c>col=GSBER               ctrl=LC_I_GSBER              param=BindColVal</c>
            <c>col=USE_YN              ctrl=LC_I_USE_YN             param=BindColVal</c>
            <c>col=APP_S_DT            ctrl=EM_APP_S_DT             param=Text</c>
            <c>col=APP_E_DT            ctrl=EM_APP_E_DT             param=Text</c>
            <c>col=SMEDI_CHAR_ID       ctrl=EM_SMEDI_CHAR_ID        param=Text</c>
            <c>col=SMEDI_CHAR_NM       ctrl=EM_SMEDI_CHAR_NM        param=Text</c>
            <c>col=SMEDI_ID            ctrl=EM_SMEDI_ID             param=Text</c>
            <c>col=SMEDI_EMAIL         ctrl=EM_SMEDI_EMAIL          param=Text</c>
            <c>col=COMP_NO             ctrl=EM_COMP_NO              param=Text</c>
            <c>col=CORP_NO             ctrl=EM_CORP_NO              param=Text</c>
            <c>col=COMP_NAME           ctrl=EM_COMP_NAME            param=Text</c>
            <c>col=REP_NAME            ctrl=EM_REP_NAME             param=Text</c>
            <c>col=BIZ_STAT            ctrl=EM_BIZ_STAT             param=Text</c>
            <c>col=BIZ_CAT             ctrl=EM_BIZ_CAT              param=Text</c>
            <c>col=POST_NO             ctrl=EM_POST_NO              param=Text</c>
            <c>col=ADDR                ctrl=EM_ADDR                 param=Text</c>
            <c>col=DTL_ADDR            ctrl=EM_DTL_ADDR             param=Text</c>
            <c>col=REP_TEL1_NO         ctrl=EM_REP_TEL1_NO          param=Text</c>
            <c>col=REP_TEL2_NO         ctrl=EM_REP_TEL2_NO          param=Text</c>
            <c>col=REP_TEL3_NO         ctrl=EM_REP_TEL3_NO          param=Text</c>
            <c>col=FAX1_NO             ctrl=EM_FAX1_NO              param=Text</c>
            <c>col=FAX2_NO             ctrl=EM_FAX2_NO              param=Text</c>
            <c>col=FAX3_NO             ctrl=EM_FAX3_NO              param=Text</c>
            <c>col=OPEN_TIME           ctrl=EM_OPEN_TIME            param=Text</c>
            <c>col=CLOSE_TIME          ctrl=EM_CLOSE_TIME           param=Text</c>
            <c>col=BAL_CHK_TIME        ctrl=EM_BAL_CHK_TIME         param=Text</c>
        	
        	<c>col=SMEDI_TEL1_NO         ctrl=EM_SMEDI_TEL1_NO          param=Text</c>
            <c>col=SMEDI_TEL2_NO         ctrl=EM_SMEDI_TEL2_NO          param=Text</c>
            <c>col=SMEDI_TEL3_NO         ctrl=EM_SMEDI_TEL3_NO          param=Text</c>
        '>
        
            <!-- MARIO OUTLET START -->
            <!-- 
            <c>col=BUY_ACC_VEN_CD      ctrl=EM_BUY_ACC_VEN_CD       param=Text</c>
            <c>col=SALE_ACC_VEN_CD     ctrl=EM_SALE_ACC_VEN_CD      param=Text</c>
             -->
            <!-- MARIO OUTLET END -->
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

