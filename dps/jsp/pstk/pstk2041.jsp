<!-- 
/*******************************************************************************
 * 시스템명 : 실사재고등록 - 엑셀업로드 팝업
 * 작 성 일 : 2010-04-25
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk2041.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 엑셀업로드 팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
   <% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<title>실사재고등록 엑셀 업로드</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var returnParam    = dialogArguments[0];
var strStrCdA      = dialogArguments[1];    // 점
var strPumbunCdA   = dialogArguments[2];    // 브랜드
var strPrcAppDtA   = dialogArguments[3];    // 실사년월
var strSkuTypeA   = dialogArguments[4];     // 단품유형
var strStkDtA   = dialogArguments[5];       // 재고조사일 


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
/**
 * doInit()
 * 작 성 자 : 이재득
 * 작 성 일 : 2010-04-25
 * 개    요 : initialize
 * return값 : void
**/
function doInit() 
{     	
	
	// Output Data Set Header 초기화
	DS_O_RESULT.setDataHeader('<gauce:dataset name="H_SEL_EXCEL"/>');
	DS_O_SKU.setDataHeader('<gauce:dataset name="H_SEL_EXCEL"/>');
	
    //그리드 초기화
    gridCreate1();
  
    // EMedit 초기화
    initEmEdit(EM_FILS_LOC, "GEN^300^0", READ); //EXCEL경로
    
    getEtcCode("DS_I_COLOR_CD", "D", "P062", "N");        //칼라  
    getEtcCode("DS_I_SIZE_CD", "D", "P026", "N");         //사이즈
    getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");    //판매단위
    getEtcCode("DS_I_CMP_SPEC_UNIT", "D", "P013", "N");   //구성규격단위
} 

function gridCreate1(){
    var hdrProperies = '<FC>id=CHECK1          name="선택"             width=45    align=center EditStyle=CheckBox  HeadCheckShow="true" edit={IF(CLOSE_DT="", "true", "false")}</FC>'                     
                     + '<FC>id=SKU_CD          name="*단품코드"         width=110    align=center  BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none</FC>'
                     + '<FC>id=SKU_NAME        name="단품명"           width=140    align=left  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") } </FC>' 
                     + '<FC>id=STR_CD          name="점코드"           width=50    align=center   BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none</FC>'
                     + '<FC>id=STK_YM          name="조사년월"         width=80    align=center   BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none</FC>'                                         
                     + '<FC>id=BUY_COST_PRC    name="원가"             width=60    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none </FC>'
                     + '<FC>id=BUY_SALE_PRC    name="단가"             width=80    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none  </FC>'
                     //+ '<FG>                   name="장부재고" '
                     //+ '<FC>id=STK_QTY         name="수량"             width=50    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none</FC>'
                     //+ '<FC>id=STK_AMT         name="금액"             width=80    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none</FC>'
                     //+ '</FG> '
                     + '<FG> name="실사재고" '
                     + '<FC>id=NORM_QTY        name="정상수량"         width=60    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }   edit=none  </FC>'
                     + '<FC>id=NORM_AMT        name="정상금액"         width=80    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }   edit=none   </FC>'
                     + '<FC>id=INFRR_QTY       name="불량수량"         width=60    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }   edit=none  </FC>'
                     + '<FC>id=INFRR_AMT       name="불량금액"         width=80    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }   edit=none   </FC>'
                     + '<FC>id=SRVY_QTY        name="합계수량"         width=60    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }   edit=none show="false" </FC>'
                     + '<FC>id=SRVY_QTY_AMT    name="합계금액"         width=80    align=right    BgColor={if(ERROR_CHECK = "","white","orange") }   edit=none show="false" </FC>'
                     + '<FC>id=SRVY_COST_AMT   name="재고실사원가금액"  width=60    align=right   BgColor={if(ERROR_CHECK = "","white","orange") }    edit=none  show="false" </FC>'
                     + '<FC>id=SRVY_SALE_AMT   name="재고실사매가금액"  width=60    align=right   BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none   show="false" </FC>'
                     + '</FG> '
                     + '<FC>id=SEQ_NO          name="순번"            width=45     align=right   BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none  show="false" </FC>'
                     + '<FC>id=STYLE_CD        name="STYLE코드"        width=90    align=center  BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none </FC>'
                     + '<FC>id=STYLE_NAME      name="STYLE명"          width=100    align=left   BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none</FC>'
                     + '<FC>id=COLOR_CD        name="칼라명"           width=80    align=left    BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none  EditStyle=Lookup    Data="DS_I_COLOR_CD:CODE:NAME"</FC>'
                     + '<FC>id=SIZE_CD         name="사이즈"           width=80    align=left    BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none  EditStyle=Lookup    Data="DS_I_SIZE_CD:CODE:NAME"</FC>'
                     + '<FC>id=PUMBUN_CD       name="브랜드"             width=60    align=center  BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none  </FC>'
                     + '<FC>id=PUMMOK_CD       name="품목"             width=80    align=center  BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none  </FC>'
                     + '<FC>id=INPUT_PLU_CD    name="소스마킹코드"     width=100    align=left    BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none  </FC>'
                     + '<FC>id=SALE_UNIT_CD    name="판매단위"         width=60    align=left     BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none    EditStyle=Lookup    Data="DS_I_SALE_UNIT_CD:CODE:NAME"</FC>'
                     + '<FC>id=CMP_SPEC_UNIT   name="구성단위"         width=80    align=left    BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none    EditStyle=Lookup    Data="DS_I_CMP_SPEC_UNIT:CODE:NAME"</FC>'
                     + '<FC>id=CLOSE_DT        name="마감일자"         width=100    align=left   BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none  show="false" </FC>'
                     + '<FC>id=ERROR_CHECK        name="에러체크"         width=100    align=left  BgColor={if(ERROR_CHECK = "","white","orange") }  edit=none show="false"</FC>';                  
 
    initGridStyle(GD_EXCEL_DATA, "common", hdrProperies, true);
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
 * 작 성 자 : 이재득
 * 작 성 일 : 2010-04-25
 * 개    요  : 
 * return값 : void
**/
function btn_Search() 
{ 
      
      
}       
/*************************************************************************
 * 3. 함수
*************************************************************************/

 /**
  * btn_Close()
  * 작 성 자 : 
  * 작 성 일 :
  * 개    요 : Close
  * return값 : void
 **/  
 function btn_Close()
 {
 
 }
 
 /**
  * btn_Conf()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개    요 : 확인버튼  처리
  * return값 : void
 **/  
 function btn_Conf()
 {
 
 }    
 
     
 /**
  * loadExcelData()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-25
  * 개    요 : Excel파일 DateSet에 저장
  * return값 :
  */
 function loadExcelData() {
 
 	INF_EXCELUPLOAD.Open();
 	
 	//loadExcelData 옵션처리
 	var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
 	if (strExcelFileName == "''")
 	    return;
 	
 	EM_FILS_LOC.text  = strExcelFileName;  //경로명 표기
 	
 	var strStartRow = 7; //시작Row
    var strEndRow = 0; //끝Row
    var strReadType = 0; //읽기모드
    var strBlankCount = 0; //공백row개수
    var strLFTOCR = 0; //줄바꿈처리 
    var strFireEvent = 1; //이벤트발생
    var strSheetIndex = 1; //Sheet Index 추가
    var strtrEtc = "1";//엑셀 컬럼에 1000단위 구분기호(,)가 있을 경우, 구분기호를 무시하고 데이터를 가져온다. (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,72    UMX: 2,0,1,72 이상버전 사용가능)
    var strtrcol = 0;//Excel 파일에서 읽어 들일 시작 Col 위치 (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,80    UMX: 2,0,1,80 이상버전 사용가능)

    var strOption = strExcelFileName
    + "," + strStartRow + "," + strEndRow + "," + strReadType 
    + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
    + "," + strSheetIndex + "," + strtrEtc+ "," + strtrcol;
 	
 	DS_O_RESULT.ClearData();
 	DS_O_SKU.ClearData();
 	// Excel파일 DateSet에 저장               
    DS_O_RESULT.Do("Excel.Application", strOption);
 	
    DS_O_RESULT.DeleteRow(1);
 	// Excel에서 가져온 DATASET을 화면에 보여줄 DATASET에 복사한다.
 	var strData = DS_O_RESULT.ExportData(1,DS_O_RESULT.CountRow, true );
 	
 	if(strData == "") {
		 showMessage(INFORMATION, OK, "USER-1000", "업로드파일 양식에 오류가 있습니다.");
		return false;
	}
 	DS_O_SKU.ImportData(strData);
 
 	// 중복체크 후 구별을 쉽게하기 위해 정렬한다.
 	//DS_O_SKU.SortExpr = "+" + "SKU_CD";
 	//DS_O_SKU.Sort();
 
 	// Excel에서 가져온 데이터의 정합성 체크를 한다.
 	errorChk();
 }
 
 /**
  * errorChk()
  * 작 성 자     : 이재득
  * 작 성 일     : 2010-04-25
  * 개    요        : UPLOAD된 값 체크 
  * return값 : void
  */
 
 function errorChk(){ 
	 
     //var errorCnt = 0;
     
     for(i=0; i <= DS_O_SKU.CountRow; i++){
    	 
         j = i;
         var txtStrCd        = strStrCdA;		//점
         var txtPumbunCd     = strPumbunCdA;	//브랜드
         var txtStkYm        = strPrcAppDtA;	//실사년월
         var txtStkDt        = strStkDtA;		//재고조사일
         
           
         var strStrCd        = DS_O_SKU.NameValue(i,"STR_CD");  
           
         var strPumbunCd     = DS_O_SKU.NameValue(i,"PUMBUN_CD");         //조직코드
         var strSkuCd        = DS_O_SKU.NameValue(i,"SKU_CD");
         var strStkYm        = DS_O_SKU.NameValue(i,"STK_YM");
         var strPummokCd     = DS_O_SKU.NameValue(i,"PUMMOK_CD");           
           
           
           
         if(strStrCd.length == 2 && strPumbunCd.length == 6 && strSkuCd.length == 13 && strStkYm.length == 6 && strPummokCd.length ==8
                   && !isNull(strStrCd)    && !isNull(strPumbunCd) && !isNull(strSkuCd) && !isNull(strStkYm) && !isNull(strPummokCd)    
                   && txtStrCd == strStrCd && strPumbunCd == txtPumbunCd && strStkYm == txtStkYm){
               
               var goTo       = "searchSkuCheck" ;    
               var action     = "O";    
               var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                              + "&strSkuCd="           +encodeURIComponent(strSkuCd)
                              + "&strStkDt="           +encodeURIComponent(txtStkDt)
                              ;
               
               TR_MAIN.Action="/dps/pstk204.pt?goTo="+goTo+parameters;  
               TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SKUCHECK=DS_IO_SKUCHECK)"; //조회는 O
               TR_MAIN.Post();
               i = j;              
               
               if (DS_IO_SKUCHECK.CountRow < 1) {
                   DS_O_SKU.NameValue(i,"ERROR_CHECK")= "T";   
                   errorCnt = 1;                   
               } 
               
               
               DS_IO_SKUCHECK.ClearData();
         } else {
               DS_O_SKU.NameValue(i,"ERROR_CHECK")= "T";
               errorCnt = 1;               
         }          
     }
}

 
 
 
function skuErrorChk(vRow){ 
	 
	var txtStrCd        = strStrCdA;		//점
    var txtPumbunCd     = strPumbunCdA;	//브랜드
    var txtStkYm        = strPrcAppDtA;	//실사년월
    var txtStkDt        = strStkDtA;		//재고조사일
     
	var strStrCd        = DS_O_SKU.NameValue(vRow,"STR_CD");  
    var strPumbunCd     = DS_O_SKU.NameValue(vRow,"PUMBUN_CD");         //조직코드
    var strSkuCd        = DS_O_SKU.NameValue(vRow,"SKU_CD");
    var strStkYm        = DS_O_SKU.NameValue(vRow,"STK_YM");
    var strPummokCd     = DS_O_SKU.NameValue(vRow,"PUMMOK_CD"); 
    var strBuyCostPrc   = DS_O_SKU.NameValue(vRow,"BUY_COST_PRC"); 
    var strBuySalePrc   = DS_O_SKU.NameValue(vRow,"BUY_SALE_PRC"); 
    var strNormQty   	= DS_O_SKU.NameValue(vRow,"NORM_QTY"); 
    var strNormAmt   	= DS_O_SKU.NameValue(vRow,"NORM_AMT"); 
    var strInfrrQty   	= DS_O_SKU.NameValue(vRow,"INFRR_QTY"); 
    var strInfrrAmt   	= DS_O_SKU.NameValue(vRow,"INFRR_AMT"); 
    
    DS_IO_SKUCHECK.ClearData();
    
    var goTo       = "searchSkuCheck" ;    
    var action     = "O";    
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSkuCd="           +encodeURIComponent(strSkuCd)
                   + "&strStkDt="           +encodeURIComponent(txtStkDt)
                   ;
    
    TR_MAIN.Action="/dps/pstk204.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SKUCHECK=DS_IO_SKUCHECK)"; //조회는 O
    TR_MAIN.Post();
    
    var strChkStrCd = DS_IO_SKUCHECK.NameValue(1,"STR_CD");
    var strChkSkuCd = DS_IO_SKUCHECK.NameValue(1,"SKU_CD");
    var strChkSkuType = DS_IO_SKUCHECK.NameValue(1,"SKU_TYPE");
    var strChkPumbunCd = DS_IO_SKUCHECK.NameValue(1,"PUMBUN_CD");
    var strChkPummokCd = DS_IO_SKUCHECK.NameValue(1,"PUMMOK_CD");
    var strChkBuyCostPrc = DS_IO_SKUCHECK.NameValue(1,"BUY_COST_PRC");
    var strChkBuySalePrc = DS_IO_SKUCHECK.NameValue(1,"BUY_SALE_PRC");
    
    
	if (isNull(strStrCd)) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "점코드에 오류가 있습니다."); 
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
		return false;
	} else {
		if (strStrCd.length    != 2) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "점코드 자리수(2)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		} else {
			if (txtStrCd    != strStrCd) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "점코드가 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
				return false;
			}
		}        	
	}
      
	if (isNull(strPumbunCd)) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드에 오류가 있습니다."); 
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
		return false;
	} else {
		if (strPumbunCd.length != 6) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드 자리수(6)를 확인하십시요."); 
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		} else {
			if (strPumbunCd != txtPumbunCd) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드가 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
				return false;
			}
		}	
	}
		
	if (isNull(strSkuCd)) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "단품코드에 오류가 있습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
		return false;
	} else {
		if (strSkuCd.length    != 13) { 
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품코드 자리수(13)를 확인하십시요."); 
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		}
	}
	
	if (isNull(strStkYm)) { 
		showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사 년월에 오류가 있습니다."); 
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
		return false;
	} else {
		if (strStkYm.length    != 6) { 
			showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사년월 자리수(6)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		} else {
			if (strStkYm    != txtStkYm) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사 년월이 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
				return false;
			}
		}
	}
	
	if (isNull(strPummokCd)) { 
		showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드에 오류가 있습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
		return false;
	} else {
		if (strPummokCd.length != 8) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드 자리수(8)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		} else {
			if (strPummokCd != strChkPummokCd) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드가 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
				return false;
			}
		}
	}
		
	if(strNormQty < 0) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "정상수량은 0보다 작을수 없습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
		return false;
	}
	
	if(strInfrrQty < 0) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "불량수량은 0보다 작을수 없습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
		return false;
	}
	
	
	if (strSkuTypeA == "1" || strSkuTypeA == "3") {
		
		if(strChkBuyCostPrc != strBuyCostPrc) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 원가를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		}
		
		if(strChkBuySalePrc != strBuySalePrc) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 단가를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		}
		
		if(strBuySalePrc*strNormQty != strNormAmt) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 정상금액을 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		}
		
		if(strBuySalePrc*strInfrrQty != strInfrrAmt) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 불량금액을 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "T";
			return false;
		}
	}
	
	DS_O_SKU.NameValue(vRow,"RATE") = DS_IO_SKUCHECK.NameValue(1,"RATE");
	DS_O_SKU.NameValue(vRow,"TAX_FLAG") = DS_IO_SKUCHECK.NameValue(1,"TAX_FLAG");
	
	return true;
	
}
 
 /**
  * btn_DeleteRow()
  * 작 성 자     : 이재득
  * 작 성 일     : 2010-04-25
  * 개    요        : 선택된 단품을 삭제한다.
  * return값 : void
  */
 function btn_DeleteRow(){
 	var intRowCount =  DS_O_SKU.CountRow;
 	for(var i=intRowCount; i >= 1; i--){
 		if(DS_O_SKU.NameValue(i, "CHECK1") == 'T'){
 			DS_O_SKU.DeleteRow(i);
 		}
 	}
 	//그리드 CHEKCBOX헤더 체크해제
     GD_EXCEL_DATA.ColumnProp('CHECK1','HeadCheck')= "false"; 	
 }
 
 /**
  * btn_Apply()
  * 작 성 자     : 이재득
  * 작 성 일     : 2010-04-25
  * 개    요        : 선택된 단품을 적용한다.
  * return값 : void
  */
 function btn_Apply(){
     var selCount = 0;
     for(var i = 1; i <= DS_O_SKU.CountRow; i++){
         var strSel        = DS_O_SKU.NameValue(i, "CHECK1");
         var strerrorCheck = DS_O_SKU.NameValue(i, "ERROR_CHECK");
         if(strSel == "T"){
         	if(strerrorCheck != ""){
 	            showMessage(INFORMATION, OK, "GAUCE-1000", "선택된 단품에 오류가 있습니다.");
 	            DS_O_SKU.RowPosition = i;
 	            return;
         	}
         	selCount++;
         }
     }
     
     if(selCount <= 0){
     	showMessage(INFORMATION, OK, "GAUCE-1000", "선택된 단품내역이 없습니다.");
     	return;
     }
     	
 	window.returnValue = DS_O_SKU.ExportData(1,DS_O_SKU.CountRow, true );
     //그리드 CHEKCBOX헤더 체크해제
     GD_EXCEL_DATA.ColumnProp('CHECK1','HeadCheck')= "false";
     window.close();
 }
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_SKU event=OnColumnChanged(row,colid)>
	
	if(colid == "CHECK1") {
		if(DS_O_SKU.NameValue(row,colid) == "T"){
			if(!skuErrorChk(row)) {
				DS_O_SKU.NameValue(row,colid) = "F";
			}
		}
	}
		
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GD_EXCEL_DATA event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_O_SKU.CountRow; i++){
        	DS_O_SKU.NameValue(i, "CHECK1") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_O_SKU.CountRow; i++){
        	DS_O_SKU.NameValue(i, "CHECK1") = 'F';
        }
    }
</script>




<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*    3. Excelupload
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_"><object id=DS_I_COND classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SIZE_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SALE_UNIT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CMP_SPEC_UNIT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_RESULT     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_SKU        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_INFO"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SKUCHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <object id="TR_MAIN"        classid="<%=Util.CLSID_TRANSACTION%>">
      <param name="KeyName"   value="Toinb_dataid4">
    </object>
</comment>
<script> _ws_(_NSID_);</script>

<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body  onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <SPAN id="title1" class="PL03">단품 엑셀 업로드 </SPAN>
            </td>
            <td align="right"><img id="IMG_ADD_ROW"  src="/<%=dir%>/imgs/btn/del.gif" onclick="javascript:btn_DeleteRow();" hspace="2"  align="absmiddle"/><img id="IMG_DEL_ROW"
                    style="vertical-align: middle;"
                    src="/<%=dir%>/imgs/btn/apply.gif" onclick="javascript:btn_Apply();"  align="absmiddle"/>
                </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="PT03 Pb03">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
               <td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
				    <tr>
				       <th>파일선택</th>
				        <td width="650"><comment id="_NSID_"><object
		                    id=EM_FILS_LOC style="vertical-align: middle;"
		                    classid=<%=Util.CLSID_EMEDIT%> width="585"></object></comment><script>_ws_(_NSID_);</script><img
		                    id="IMG_FILE_SEARCH" style="vertical-align: middle;"
		                    src="/<%=dir%>/imgs/btn/file_search.gif" width="62" height="18"
		                    onclick="loadExcelData();" />
		                </td>				          
				     </tr>
				   </table>
				</td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
      <td class="dot">
      </td>
      </tr>
      
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">      
        <tr>
        <td>
            <!-- 마스터 -->
            <comment id="_NSID_"><OBJECT id=GD_EXCEL_DATA height="275px" width="100%" classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_SKU">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>
            </tr>  
        </table></td>
      </tr>
    </table></td>
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>