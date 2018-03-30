<!-- 
/*******************************************************************************
 * 시스템명 : 실사재고등록 - 엑셀업로드 팝업
 * 작 성 일 : 2010-04-25
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk2201.jsp
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
<%String dir = BaseProperty.get("context.common.dir");
SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
String userid = sessionInfo.getUSER_ID();       //사용자아이디

%>
<html>
<head>
<title>영수증 출력</title>
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
var gstrBarcode      = dialogArguments[1];    // 점
var strPumbunCdA   = dialogArguments[2];    // 일자
var strPrcAppDtA   = dialogArguments[3];    // 포스
var strSkuTypeA   = dialogArguments[4];     // 거래번호
var strStkDtA   = dialogArguments[5];       // 재고조사일 
var strImgUrl	= "";
var strUserId	= "<%=userid%>";




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
	//DS_O_RESULT.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
	//DS_O_SKU.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
	
    //그리드 초기화
    //gridCreate1();
  
    // EMedit 초기화
    //initEmEdit(EM_FILS_LOC, "GEN^300^0", READ); //EXCEL경로
    
    //getEtcCode("DS_I_COLOR_CD", "D", "P062", "N");        //칼라  
    //getEtcCode("DS_I_SIZE_CD", "D", "P026", "N");         //사이즈
    //getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");    //판매단위
    //getEtcCode("DS_I_CMP_SPEC_UNIT", "D", "P013", "N");   //구성규격단위
    
    // 바코드 생성
    strImgUrl = genBarcode();
    
    // 영수능 내용 생성
    genContent();

} 

function gridCreate1(){
    var hdrProperies = '<FC>id=CHECK1          name="선택"             width=45    align=center EditStyle=CheckBox  HeadCheckShow="true" edit={IF(CLOSE_DT="", "true", "false")}</FC>'                     
    	 			+ '<FC>id=STR_CD          name="점코드"           width=50    align=center   BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none</FC>'	
    				+ '<FC>id=PUMBUN_CD       name="브랜드"             width=60    align=center  BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none  </FC>'
        			+ '<FC>id=PUMMOK_CD       name="품목"             width=80    align=center  BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none  </FC>' 
    				+ '<FC>id=MODEL_NO        name="*브랜드상품코드"   width=110    align=center  BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none</FC>'
   					+ '<FC>id=SKU_CD          name="*단품코드"         width=110    align=center  BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none</FC>'
                    + '<FC>id=SKU_NAME        name="단품명"           width=140    align=left  edit=none   BgColor={if(ERROR_CHECK = "T","white","orange") } </FC>' 
                    + '<FC>id=STK_YM          name="조사년월"         width=80    align=center   BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none</FC>'                                         
                     + '<FC>id=BUY_COST_PRC    name="단가"             width=60    align=right    BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none </FC>'
                     //+ '<FC>id=BUY_SALE_PRC    name="단가"             width=80    align=right    BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none  </FC>'
                     //+ '<FG>                   name="장부재고" '
                     //+ '<FC>id=STK_QTY         name="수량"             width=50    align=right    BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none</FC>'
                     //+ '<FC>id=STK_AMT         name="금액"             width=80    align=right    BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none</FC>'
                     //+ '</FG> '
                     + '<FG> name="실사재고" '
                     + '<FC>id=NORM_QTY        name="정상수량"         width=60    align=right    BgColor={if(ERROR_CHECK = "T","white","orange") }   edit=none  </FC>'
                     + '<FC>id=NORM_AMT        name="정상금액"         width=80    align=right    BgColor={if(ERROR_CHECK = "T","white","orange") }   edit=none   </FC>'
                     //+ '<FC>id=INFRR_QTY       name="불량수량"         width=60    align=right    BgColor={if(ERROR_CHECK = "T","white","orange") }   edit=none  </FC>'
                     //+ '<FC>id=INFRR_AMT       name="불량금액"         width=80    align=right    BgColor={if(ERROR_CHECK = "T","white","orange") }   edit=none   </FC>'
                     + '</FG> '
                     //+ '<FC>id=STYLE_CD        name="STYLE코드"        width=90    align=center  BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none </FC>'
                     //+ '<FC>id=STYLE_NAME      name="STYLE명"          width=100    align=left   BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none</FC>'
                     //+ '<FC>id=COLOR_CD        name="칼라명"           width=80    align=left    BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none  EditStyle=Lookup    Data="DS_I_COLOR_CD:CODE:NAME"</FC>'
                     //+ '<FC>id=SIZE_CD         name="사이즈"           width=80    align=left    BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none  EditStyle=Lookup    Data="DS_I_SIZE_CD:CODE:NAME"</FC>'
                     
                     //+ '<FC>id=INPUT_PLU_CD    name="소스마킹코드"     width=100    align=left    BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none  </FC>'
                     //+ '<FC>id=SALE_UNIT_CD    name="판매단위"         width=60    align=left     BgColor={if(ERROR_CHECK = T"","white","orange") }  edit=none    EditStyle=Lookup    Data="DS_I_SALE_UNIT_CD:CODE:NAME"</FC>'
                     //+ '<FC>id=CMP_SPEC_UNIT   name="구성단위"         width=80    align=left    BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none    EditStyle=Lookup    Data="DS_I_CMP_SPEC_UNIT:CODE:NAME"</FC>'
                     //+ '<FC>id=CLOSE_DT        name="마감일자"         width=100    align=left   BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none  show="false" </FC>'
                     + '<FC>id=ERROR_CHECK        name="에러체크"         width=100    align=left  BgColor={if(ERROR_CHECK = "T","white","orange") }  edit=none show="true"</FC>';                  
 
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
 	
 	var strStartRow = 2; //시작Row
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
    //DS_O_RESULT.DeleteRow(1);
 	// Excel에서 가져온 DATASET을 화면에 보여줄 DATASET에 복사한다.
 	var strData = DS_O_RESULT.ExportData(1,DS_O_RESULT.CountRow, true );
 	
 	if(strData == "") {
		 showMessage(INFORMATION, OK, "USER-1000", "업로드파일 양식에 오류가 있습니다.");
		return false;
	}
 
 	
 	// Excel에서 가져온 데이터의 정합성 체크를 한다.
 	errorChk(DS_O_RESULT);
 	
 	strData = DS_O_RESULT.ExportData(1,DS_O_RESULT.CountRow, true );
 	
 	DS_O_SKU.ImportData(strData);
 
 	// 중복체크 후 구별을 쉽게하기 위해 정렬한다.
 	//DS_O_SKU.SortExpr = "+" + "SKU_CD";
 	//DS_O_SKU.Sort();
 	
 }
 
 /**
  * errorChk(objIn, objOut)
  * 작 성 자     : 이재득
  * 작 성 일     : 2010-04-25
  * 개    요        : UPLOAD된 값 체크 
  * return값 : void
  */
 
 function errorChk(obj){ 
	 
     var errorCnt = 0;
     
     for(var i=0; i <= obj.CountRow; i++){
    	 
         j = i;
    	 obj.NameValue(i,"STK_YM") 		= strPrcAppDtA;
    	 obj.NameValue(i,"ERROR_CHECK") = "T";
         var strModelNo        = obj.NameValue(i,"MODEL_NO");
         var goTo       = "searchSkuCheck" ;    
         var action     = "O";    
         var parameters = "&strStrCd="           +encodeURIComponent(gstrBarcode)
                        + "&strPumbunCd="        +encodeURIComponent(strPumbunCdA)
       					+ "&strModelNo="         +encodeURIComponent(strModelNo)
                        + "&strStkDt="           +encodeURIComponent(strPrcAppDtA)
                        ;
               
         TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
         TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SKUCHECK=DS_IO_SKUCHECK)"; //조회는 O
         TR_MAIN.Post();
         i = j;              
               
         if (DS_IO_SKUCHECK.CountRow < 1) {
        	 obj.NameValue(i,"ERROR_CHECK")= "F";   
            errorCnt++;                   
         }
         else{
        	 obj.NameValue(i,"STR_CD") 		= DS_IO_SKUCHECK.NameValue(i,"STR_CD");
        	 obj.NameValue(i,"PUMBUN_CD") 	= DS_IO_SKUCHECK.NameValue(i,"PUMBUN_CD");
        	 obj.NameValue(i,"PUMMOK_CD") 	= DS_IO_SKUCHECK.NameValue(i,"PUMMOK_CD");
        	 obj.NameValue(i,"SKU_CD") 		= DS_IO_SKUCHECK.NameValue(i,"SKU_CD");
        	 obj.NameValue(i,"SKU_NAME") 	= DS_IO_SKUCHECK.NameValue(i,"SKU_NAME");

        	 if (obj.NameValue(i,"BUY_COST_PRC")==0)
        	 	obj.NameValue(i,"BUY_COST_PRC")= DS_IO_SKUCHECK.NameValue(i,"BUY_COST_PRC");
        	 
        	 if (obj.NameValue(i,"BUY_COST_PRC")==0) {
        		 obj.NameValue(i,"ERROR_CHECK")= "F";   
                errorCnt++;	 
        	 }
        	 
        	 obj.NameValue(i,"NORM_AMT") = obj.NameValue(i,"BUY_COST_PRC") * obj.NameValue(i,"NORM_QTY");
        	 obj.NameValue(i,"CHECK1") = obj.NameValue(i,"ERROR_CHECK");
       	 }
  		
         DS_IO_SKUCHECK.ClearData();
     }
     
}

 
 
 
function skuErrorChk_OLD(vRow){ 
	 
	var txtStrCd        = gstrBarcode;		//점
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
    
    TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
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
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strStrCd.length    != 2) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "점코드 자리수(2)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		} else {
			if (txtStrCd    != strStrCd) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "점코드가 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
				return false;
			}
		}        	
	}
      
	if (isNull(strPumbunCd)) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드에 오류가 있습니다."); 
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strPumbunCd.length != 6) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드 자리수(6)를 확인하십시요."); 
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		} else {
			if (strPumbunCd != txtPumbunCd) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드가 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
				return false;
			}
		}	
	}
		
	if (isNull(strSkuCd)) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "단품코드에 오류가 있습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strSkuCd.length    != 13) { 
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품코드 자리수(13)를 확인하십시요."); 
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
	}
	
	if (isNull(strStkYm)) { 
		showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사 년월에 오류가 있습니다."); 
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strStkYm.length    != 6) { 
			showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사년월 자리수(6)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		} else {
			if (strStkYm    != txtStkYm) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사 년월이 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
				return false;
			}
		}
	}
	
	if (isNull(strPummokCd)) { 
		showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드에 오류가 있습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strPummokCd.length != 8) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드 자리수(8)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		} else {
			if (strPummokCd != strChkPummokCd) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드가 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
				return false;
			}
		}
	}
		
	if(strNormQty < 0) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "정상수량은 0보다 작을수 없습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	}
	
	if(strInfrrQty < 0) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "불량수량은 0보다 작을수 없습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	}
	
	
	if (strSkuTypeA == "1" || strSkuTypeA == "3") {
		
		if(strChkBuyCostPrc != strBuyCostPrc) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 원가를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
		
		if(strChkBuySalePrc != strBuySalePrc) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 단가를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
		
		if(strBuySalePrc*strNormQty != strNormAmt) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 정상금액을 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
		
		if(strBuySalePrc*strInfrrQty != strInfrrAmt) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 불량금액을 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
	}
	
	DS_O_SKU.NameValue(vRow,"RATE") = DS_IO_SKUCHECK.NameValue(1,"RATE");
	DS_O_SKU.NameValue(vRow,"TAX_FLAG") = DS_IO_SKUCHECK.NameValue(1,"TAX_FLAG");
	
	return true;
	
}

function skuErrorChk(vRow){ 
	 
	var txtStrCd        = gstrBarcode;		//점
    var txtPumbunCd     = strPumbunCdA;	//브랜드
    var txtStkYm        = strPrcAppDtA;	//실사년월
    var txtStkDt        = strStkDtA;		//재고조사일
     
	var strStrCd        = DS_O_SKU.NameValue(vRow,"STR_CD");  
    var strPumbunCd     = DS_O_SKU.NameValue(vRow,"PUMBUN_CD");         //조직코드
    var strSkuCd        = DS_O_SKU.NameValue(vRow,"SKU_CD");
    var strStkYm        = DS_O_SKU.NameValue(vRow,"STK_YM");
    var strPummokCd     = DS_O_SKU.NameValue(vRow,"PUMMOK_CD"); 
    var strBuyCostPrc   = DS_O_SKU.NameValue(vRow,"BUY_COST_PRC"); 
    //var strBuySalePrc   = DS_O_SKU.NameValue(vRow,"BUY_SALE_PRC"); 
    var strNormQty   	= DS_O_SKU.NameValue(vRow,"NORM_QTY"); 
    var strNormAmt   	= DS_O_SKU.NameValue(vRow,"NORM_AMT"); 
    //var strInfrrQty   	= DS_O_SKU.NameValue(vRow,"INFRR_QTY"); 
    //var strInfrrAmt   	= DS_O_SKU.NameValue(vRow,"INFRR_AMT"); 
    /*
    DS_IO_SKUCHECK.ClearData();
    
    var goTo       = "searchSkuCheck" ;    
    var action     = "O";    
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSkuCd="           +encodeURIComponent(strSkuCd)
                   + "&strStkDt="           +encodeURIComponent(txtStkDt)
                   ;
    
    TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SKUCHECK=DS_IO_SKUCHECK)"; //조회는 O
    TR_MAIN.Post();
    
    var strChkStrCd = DS_IO_SKUCHECK.NameValue(1,"STR_CD");
    var strChkSkuCd = DS_IO_SKUCHECK.NameValue(1,"SKU_CD");
    var strChkSkuType = DS_IO_SKUCHECK.NameValue(1,"SKU_TYPE");
    var strChkPumbunCd = DS_IO_SKUCHECK.NameValue(1,"PUMBUN_CD");
    var strChkPummokCd = DS_IO_SKUCHECK.NameValue(1,"PUMMOK_CD");
    var strChkBuyCostPrc = DS_IO_SKUCHECK.NameValue(1,"BUY_COST_PRC");
    var strChkBuySalePrc = DS_IO_SKUCHECK.NameValue(1,"BUY_SALE_PRC");
    */
    
	if (isNull(strStrCd)) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "점코드에 오류가 있습니다."); 
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strStrCd.length    != 2) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "점코드 자리수(2)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		} else {
			if (txtStrCd    != strStrCd) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "점코드가 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
				return false;
			}
		}        	
	}
      
	if (isNull(strPumbunCd)) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드에 오류가 있습니다."); 
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strPumbunCd.length != 6) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드 자리수(6)를 확인하십시요."); 
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		} else {
			if (strPumbunCd != txtPumbunCd) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "브랜드코드가 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
				return false;
			}
		}	
	}
		
	if (isNull(strSkuCd)) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "단품코드에 오류가 있습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strSkuCd.length    != 13) { 
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품코드 자리수(13)를 확인하십시요."); 
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
	}
	
	if (isNull(strStkYm)) { 
		showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사 년월에 오류가 있습니다."); 
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strStkYm.length    != 6) { 
			showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사년월 자리수(6)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		} else {
			if (strStkYm    != txtStkYm) { 
				showMessage(INFORMATION, OK, "GAUCE-1000", "재고조사 년월이 상이합니다."); 
				DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
				return false;
			}
		}
	}
	
	if (isNull(strPummokCd)) { 
		showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드에 오류가 있습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	} else {
		if (strPummokCd.length != 8) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드 자리수(8)를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		} else {
			if (strPummokCd != strPummokCd) { 
				//showMessage(INFORMATION, OK, "GAUCE-1000", "품목코드가 상이합니다."); 
				//DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
				//return false;
			}
		}
	}
		
	if(strNormQty < 0) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "정상수량은 0보다 작을수 없습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	}
	/*
	if(strInfrrQty < 0) {
		showMessage(INFORMATION, OK, "GAUCE-1000", "불량수량은 0보다 작을수 없습니다.");
		DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
		return false;
	}
	*/
	
	
	if (strSkuTypeA == "1" || strSkuTypeA == "3") {
		/*	
		if(strChkBuyCostPrc != strBuyCostPrc) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 원가를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
		*/
		/*
		if(strChkBuySalePrc != strBuySalePrc) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 단가를 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
		*/
		
		if(strBuyCostPrc*strNormQty != strNormAmt) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 정상금액을 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
		/*
		if(strBuySalePrc*strInfrrQty != strInfrrAmt) {
			showMessage(INFORMATION, OK, "GAUCE-1000", "단품의 불량금액을 확인하십시요.");
			DS_O_SKU.NameValue(vRow,"ERROR_CHECK")= "F";
			return false;
		}
		*/
	}
	
	//DS_O_SKU.NameValue(vRow,"RATE") = DS_IO_SKUCHECK.NameValue(1,"RATE");
	//DS_O_SKU.NameValue(vRow,"TAX_FLAG") = DS_IO_SKUCHECK.NameValue(1,"TAX_FLAG");
	
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
 		if(DS_O_SKU.NameValue(i, "ERROR_CHECK") == "F"){
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
         	if(strerrorCheck != "T"){
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
 
 /**
  * genBarcode_pc()  ※ pc개발용
  * 작 성 자     : jyk
  * 작 성 일     : 2017-08-31
  * 개    요        : 바코드이미지를 생성한다.
  * return값 : void
  */ 
 function genBarcode_pc() {
	 
	 var goTo       	= "genBarcode";						// Action 명 
	 var strBarcode 	= gstrBarcode;						// 바코드 번호
	 var strDir			="C:/Dev/workspace/hyungji/pot/";	// 이미지 생성경로
	 var strBcdWidth	="0";								// 바코드 폭(이미지 너비가 아닌 바코드 한 줄의 너비)
	 var strBcdhHeight	="50";								// 바코드 높이
	
	 // 바코드 생성 메소드 호출
	 document.frmGenBarcode.action = "/dps/psal426.ps?";
	 document.frmGenBarcode.goTo.value = goTo;
	 document.frmGenBarcode.strBarcode.value = strBarcode;
	 document.frmGenBarcode.strDir.value = strDir;
	 document.frmGenBarcode.strBcdWidth.value = strBcdWidth;
	 document.frmGenBarcode.strBcdhHeight.value = strBcdhHeight;
	 
	 document.frmGenBarcode.submit();
	 
	 return strDir+"imgs/fkl.png";
 }
 
 
 /**
  * genBarcode()
  * 작 성 자     : jyk
  * 작 성 일     : 2017-08-31
  * 개    요        : 바코드이미지를 생성한다.
  * return값 : String
  */ 
 function genBarcode() {
	 var goTo       	= "genBarcode";						// Action 명 
	 var strBarcode 	= gstrBarcode;						// 바코드 번호
	 var strDir			="/was/apps/pot";	// 이미지 생성경로
	 var strBcdWidth	="0";								// 바코드 폭(이미지 너비가 아닌 바코드 한 줄의 너비)
	 var strBcdhHeight	="50";								// 바코드 높이
	
	 // 바코드 생성 메소드 호출
	 document.frmGenBarcode.action = "/dps/psal436.ps?";
	 document.frmGenBarcode.goTo.value = goTo;
	 document.frmGenBarcode.strBarcode.value = strBarcode;
	 document.frmGenBarcode.strDir.value = strDir;
	 document.frmGenBarcode.strBcdWidth.value = strBcdWidth;
	 document.frmGenBarcode.strBcdhHeight.value = strBcdhHeight;
	 
	 document.frmGenBarcode.submit();
	 //alert("/<%=dir%>/imgs/"+strUserId+".png");
	 return "/<%=dir%>/imgs/"+strUserId+".png";
 }
 
 /**
  * genContent()
  * 작 성 자     : jyk
  * 작 성 일     : 2017-08-31
  * 개    요        : 영수증 내용을 생성하여 출력.
  * return값 : void
  */ 
 function genContent() {
	  DS_O_MASTER.ClearData();
	  document.getElementById("receipt_content").innerHTML = "";
	 var strStrCd 	=  gstrBarcode.substr(11,2);
	 var strSaleDt	=  gstrBarcode.substr(0,8);
	 var strPosNo 	=  gstrBarcode.substr(13,4);
	 var strTranNo 	=  gstrBarcode.substr(17,5);
	 var strContent = "";
	 
	 var goTo       = "genContent" ;    
	 var action     = "O";     
	 var parameters = "&strStrCd="          +encodeURIComponent(strStrCd)
	                   + "&strPosNo="          +encodeURIComponent(strPosNo)
	                   + "&strTranNo="         +encodeURIComponent(strTranNo)
	                   + "&strSaleDt="         +encodeURIComponent(strSaleDt);
	    
	    TR_MAIN.Action="/dps/psal426.ps?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
	    TR_MAIN.Post();
	 
	 if (DS_O_MASTER.CountRow == 0 ) {
		 strContent = '영수증 정보가 없습니다.';
		 alert(strContent);
		 self.close();
	 }
	 else {
		 
		 strContent = strContent + "<table><tr><td>";
		 /* 영수증 이미지 */
		 strContent = strContent + "<img width=300 height=221 src=/<%=dir%>/imgs/dps/recp.png><br><br>";
		 /* 영수증 내용 작성 */		 
		 for ( var i=1; i <= DS_O_MASTER.CountRow; i ++) {
			 strContent = strContent + DS_O_MASTER.NameValue(i, "RECP_CONTENT") + "<br>";
		 }
		 /* 바코드 이미지*/
		 strContent = strContent + "<img src='"+strImgUrl+"'>";
		 strContent = strContent + "<br><center><b>"+gstrBarcode+"</b></center>";
		 strContent = strContent + "</td></tr></table>";
	 }
	 
	 
	 //alert(strImgUrl);
	 
	 
	 document.getElementById("receipt_content").innerHTML = strContent;

 }
 
 
 function print(printArea)
 {
 		win = window.open(); 
 		self.focus(); 
 		win.document.open();
 		
 		/*
 			1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
 			2. window.open() 을 사용하여 새 팝업창을 띄운다.
 			3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
 			4. <body> 안에 매개변수로 받은 printArea를 추가한다.
 			5. window.print() 로 인쇄
 			6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
 		*/
 		win.document.write('<html><head><title></title><style>');
 		win.document.write('body, td {font-falmily: Verdana; font-size: 10pt;}');
 		win.document.write('</style></haed><body>');
 		win.document.write(printArea);
  		win.document.write('</body></html>');
 		win.document.close();
 		win.print();
 		win.close();
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

<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
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
<!-- 바코드 생성 호출용 폼 -->
<form name="frmGenBarcode" target="frmHidden">
	<input type="hidden" name="goTo">
	<input type="hidden" name="strBarcode">
	<input type="hidden" name="strDir">
	<input type="hidden" name="strBcdWidth">
	<input type="hidden" name="strBcdhHeight">
</form>
<!-- 바코드 생성 호출용  -->
<iframe  name="frmHidden"  style="display:none;"></iframe>
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
              <SPAN id="title1" class="PL03">영수증내역(미리보기) </SPAN>
            </td>
            <td align="right"><img id="IMG_ADD_ROW"  src="/<%=dir%>/imgs/btn/del.gif" onclick="javascript:btn_DeleteRow();" hspace="2"  align="absmiddle" style="display:none"/><img id="IMG_DEL_ROW"
                    style="vertical-align: middle;"
                    src="/<%=dir%>/imgs/btn/print.gif" onclick="javascript:print(document.getElementById('receipt_content').innerHTML);"  align="absmiddle"/>
                </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="PT03 Pb03">
         
        </td>
      </tr>
      <tr>
      <td class="dot">
      </td>
      </tr>
      
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">      
        <tr>
        <td width="100%" height="730">
        <div id="receipt_content">
			<!-- 영수증 내용자리 -->
		</div>
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
