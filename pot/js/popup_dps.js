/**
 * 시스템명 : 한국후지쯔 공통 팝업 스크립트
 * 작 성 일 : 2010-01-20
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 : potup_dps.js
 * 버    전 : 1.0
 * 인 코 딩 : 
 * 개    요 : 백화점 영업관리 팝업 자바스크립트 표준 공통 함수 
 */


/** 목록을 반드시 작성하여 주시기 바랍니다.
 *  백화점     : CCom000 ~ CCom199
 *  경영지원   : CCom200 ~ CCom399
 *  포인트카드 : CCom400 ~ CCom599
 *  문화센터   : CCom600 ~ CCom799
 *  공통       : CCom900 ~ CCom999
 */

/**
공통함수 목록

☞-------------------FUNCTION ---------------------------------


☞-------------------POPOP  ---------------------------------
accVenPop()                           : 거래선 Popup
accVenToGridPop()                     : 거래선 Popup(그리드)
accVenMultiSelPop()                   : 거래선 Popup(멀티선택)
skuATypePop()                         : 단품코드(의류단품A) Popup
skuATypeToGridPop()                   : 단품코드(의류단품A) Popup(그리드)
skuATypeMultiSelPop()                 : 단품코드(의류단품A) Popup(멀티선택)
skuBTypePop()                         : 단품코드(의류단품B) Popup
skuBTypeToGridPop()                   : 단품코드(의류단품B) Popup(그리드)
skuBTypeMultiSelPop()                 : 단품코드(의류단품B) Popup(멀티선택)
strSkuPop()                           : 단품코드(점별) Popup
strSkuToGridPop()                     : 단품코드(점별) Popup(그리드)
strSkuMultiSelPop()                   : 단품코드(점별) Popup(멀티선택)
stylePop()                            : 스타일코드 Popup
styleToGridPop()                      : 스타일코드 Popup(그리드)
styleMultiSelPop()                    : 스타일코드 Popup(멀티선택)
buyerPop()                            : 바이어(SM) Popup
buyerEmpPop()                         : 바이어(SM)사번 Popup
buyerToGridPop()                      : 바이어(SM) Popup(그리드)
buyerMultiSelPop()                    : 바이어(SM) Popup(멀티선택)
orgPop()                              : 조직 Popup
orgToGridPop()                        : 조직 Popup(그리드)
orgMultiSelPop()                      : 조직 Popup(멀티선택)
orgCornerOutPop()                     : 조직 (코너제외) Popup
orgCornerOutToGridPop()               : 조직 (코너제외) Popup(그리드)
orgCornerOutMultiSelPop()             : 조직 (코너제외) Popup(멀티선택)
pummokPop()                           : 품목 Popup
pummokToGridPop()                     : 품목 Popup(그리드)
pummokMultiSelPop()                   : 품목 Popup(멀티선택)
pbnPmkPop()                           : 품번별 품목 Popup
pbnPmkToGridPop()                     : 품번별 품목 Popup(그리드)
pbnPmkMultiSelPop()                   : 품번별 품목 Popup(멀티선택)
repPumbunPop()                        : 대표 품번 Popup
repPumbunToGridPop()                  : 대표 품번 Popup(그리드)
repPumbunMultiSelPop()                : 대표 품번 Popup(멀티선택)
strPbnPop()                           : 점별 품번 Popup
strPbnToGridPop()                     : 점별 품번 Popup(그리드)
strPbnMultiSelPop()                   : 점별 품번 Popup(멀티선택)
eventPop()                            : 행사 Popup
eventToGridPop()                      : 행사 Popup(그리드)
eventMultiSelPop()                    : 행사 Popup(멀티선택)
eventThmePop()                        : 행사테마 Popup
eventThmeToGridPop()                  : 행사테마 Popup(그리드)
eventThmeMultiSelPop()                : 행사테마 Popup(멀티선택)
repVenPop()                           : 대표협력사 Popup
repVenToGridPop()                     : 대표협력사 Popup(그리드)
repVenMultiSelPop()                   : 대표협력사 Popup(멀티선택)
venPop()                              : 협력사 Popup
venToGridPop()                        : 협력사 Popup(그리드)
venMultiSelPop()                      : 협력사 Popup(멀티선택)
fnbShopPop()                          : F&B매장조회(대표매장) Popup
fnbShopToGridPop()                    : F&B매장조회(대표매장) Popup(그리드)
fnbShopMultiSelPop()                  : F&B매장조회(대표매장) Popup(멀티선택)
fnbCornerPop()                        : F&B코너 Popup
fnbCornerToGridPop()                  : F&B코너 Popup(그리드)
fnbCornerMultiSelPop()                : F&B코너 Popup(멀티선택)
posNoPop()                            : POS번호 Popup
posNoToGridPop()                      : POS번호 Popup(그리드)
posNoMultiSelPop()                    : POS번호 Popup(멀티선택)
posMsgPop()                           : POS 영수증 메세지 Popup
posMsgToGridPop()                     : POS 영수증 메세지 Popup(그리드)
posMsgMultiSelPop()                   : POS 영수증 메세지 Popup(멀티선택)
skuATypeMultiSelPordPop()		      : 단품코드(의류단품A) Popup(멀티선택)_발주매입
skuBTypeMultiSelPordPop()		      : 단품코드(의류단품B) Popup(멀티선택)_발주매입
getBrandPop()                         : 브랜드 popup

☞-------------------non-POPOP  ---------------------------------
accVenNmWithoutPop()                  : 거래선) 이름
accVenNmWithoutToGridPop()            : 거래선 이름(그리드)
skuATypeNmWithoutPop()                : 단품코드(의류단품A) 이름
skuATypeNmWithoutToGridPop()          : 단품코드(의류단품A) 이름(그리드)
skuBTypeNmWithoutPop()                : 단품코드(의류단품B) 이름
skuBTypeNmWithoutToGridPop()          : 단품코드(의류단품B) 이름(그리드)
strSkuNmWithoutPop()                  : 단품코드(점별) 이름
strSkuNmWithoutToGridPop()            : 단품코드(점별) 이름(그리드)
setStyleNmWithoutPop()                : 스타일이름 
setStyleNmWithoutToGridPop()          : 스타일이름 (그리드)
setBuyerNmWithoutPop()                : 바이어(SM)이름 
setBuyerNmWithoutToGridPop()          : 바이어(SM)이름 (그리드)
setOrgNmWithoutPop()                  : 조직 이름 
setOrgNmWithoutToGridPop()            : 조직 이름 (그리드)
setOrgCornerOutNmWithoutPop()         : 조직 (코너제외) 이름 
setOrgCornerOutNmWithoutToGridPop()   : 조직 (코너제외) 이름 (그리드)
setPummokNmWithoutPop()               : 품목 이름 
setPummokNmWithoutToGridPop()         : 품목 이름 (그리드)
setPbnPmkNmWithoutPop()               : 품번별 품목 이름 
setPbnPmkNmWithoutToGridPop()         : 품번별 품목 이름 (그리드)
setRepPumbunNmWithoutPop()            : 대표 품번 이름 
setRepPumbunNmWithoutToGridPop()      : 대표 품번 이름 (그리드)
setStrPbnNmWithoutPop()               : 점별 품번 이름 
setStrPbnNmWithoutToGridPop()         : 점별 품번 이름 (그리드)
setEventNmWithoutPop()                : 행사 이름 
setEventNmWithoutToGridPop()          : 행사 이름 (그리드)
setEventThmeNmWithoutPop()            : 행사테마 이름 
setEventThmeNmWithoutToGridPop()      : 행사테마 이름 (그리드)
setRepVenNmWithoutPop()               : 대표협력사 이름 
setRepVenNmWithoutToGridPop()         : 대표협력사 이름 (그리드)
setVenNmWithoutPop()                  : 협력사 이름 
setVenNmWithoutToGridPop()            : 협력사 이름 (그리드)
setFnbShopNmWithoutPop()              : F&B매장조회(대표매장) 이름
setFnbShopNmWithoutToGridPop()        : F&B매장조회(대표매장) 이름 (그리드)
setFnbCornerNmWithoutPop()            : F&B코너 이름  
setFnbCornerNmWithoutToGridPop()      : F&B코너 이름 (그리드)
setPosNoNmWithoutPop()                : POS번호 이름 
setPosNoNmWithoutToGridPop()          : POS번호 이름 (그리드)
setPosMsgNmWithoutPop()               : POS 영수증 메세지 이름 
setPosMsgNmWithoutToGridPop()         : POS 영수증 메세지 이름 (그리드)
skuATypeNmWithoutToGridPordPop()      : 단품코드(의류단품A) 이름(그리드)_발주매입
skuBTypeNmWithoutToGridPordPop()      : 단품코드(의류단품A) 이름(그리드)_발주매입
setStrBrdNmWithoutPop()               : 브랜드명

getStrVenCode()                       : 점별 협력사의 점코드를 가지고 오는 함수 - Ccom000
getStrPbnCode()                       : 점별 품번의 점코드를 가지고 오는 함수 - Ccom000
getMainBuyer()                        : 정 바이어를 가지고 오는 함수 - Ccom005
getVenInfo()                          : 협력사정보를 조회한다.      - Ccom016
getPumbunInfo()                       : 품번정보를 조회한다.        - Ccom012
getPmkLCode()                         : 품목의 대분류 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom000
getPmkSCode()                         : 품목의 소분류 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom000
getPmkDCode()                         : 품목의 세분류 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom000
getPmkMCode()                         : 품목의 중분류 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom000
getPbnPmkCode()                       : 품번별 품목 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom010
getStyleBrand()                       : 스타일 마스터의 품번별 브랜드 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom000
getStyleSubBrand()                    : 스타일 마스터의 품번별 서브브랜드 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom000
getEventPlaceCode()                   : 행사장 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom000
getFnBShopCornerCode()                : F&B매장중 코너매장 콤보 세팅을 위한 dataSet을 가져오는 함수  - Ccom000
*/

/** 
* accVenPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 거래선 Popup
* 사용방법 : accVenPop( objCd, objNm, buySaleFlag)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 매입매출구분
*            //--추가조건--
*            arguments[3] -> 사업자번호
*
* 실행  예) accVenPop( EM_ACC_VEN_CD, EM_ACC_VEN_NAME, '1');
*
* return값 : map
               ACC_VEN_CD  --> 거래선코드
               NAME1       --> 거래선명
               NAME2       --> 이름2
               SORTL       --> 검색어1/2
               STCD1       --> 세금번호1(주민등록번호)
               STCD2       --> 세금번호2(사업자번호)
               STCD3       --> 세금번호3(법인번호)
               J_1KFTIND   --> 산업유형(업태)
               J_1KFTBUS   --> 사업유형(종목)
               J_1KFREPRE  --> 담당자이름(대표자명)
               PSTLZ       --> 우편번호
               ORT01       --> 도시(주소-동,리까지)
               STRAS       --> 번지
               SPERR       --> 전기보류
               LOEVM       --> 삭제표시
               SPERR2      --> 전기보류2
               LOEVM2      --> 삭제표시2
               TELF1       --> 전화
               TELFX       --> 팩스
               BUY_SALE_FLAG --> 매입매출구분
*/
function accVenPop( objCd, objNm, buySaleFlag )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(buySaleFlag);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom001.cc?goTo=accVenPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("ACC_VEN_CD");
		objNm.Text = map.get("NAME1");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
  	
	return null;
}

/** 
* accVenToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 거래선 Popup(Grid)
* 사용방법 : accVenToGridPop( strCd, strNm, buySaleFlag)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 매입매출구분
*            //--추가조건--
*            arguments[3] -> 사업자번호
*
* 실행  예) accVenToGridPop( "CODE", "NAME", "1");
*
* return값 : map
               ACC_VEN_CD  --> 거래선코드
               NAME1       --> 거래선명
               NAME2       --> 이름2
               SORTL       --> 검색어1/2
               STCD1       --> 세금번호1(주민등록번호)
               STCD2       --> 세금번호2(사업자번호)
               STCD3       --> 세금번호3(법인번호)
               J_1KFTIND   --> 산업유형(업태)
               J_1KFTBUS   --> 사업유형(종목)
               J_1KFREPRE  --> 담당자이름(대표자명)
               PSTLZ       --> 우편번호
               ORT01       --> 도시(주소-동,리까지)
               STRAS       --> 번지
               SPERR       --> 전기보류
               LOEVM       --> 삭제표시
               SPERR2      --> 전기보류2
               LOEVM2      --> 삭제표시2
               TELF1       --> 전화
               TELFX       --> 팩스
               BUY_SALE_FLAG --> 매입매출구분
*/
function accVenToGridPop( strCd, strNm , buySaleFlag)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(buySaleFlag);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom001.cc?goTo=accVenPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
  	
	return null;
}

/** 
* accVenMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 거래선 Popup(멀티선택)
* 사용방법 : accVenMultiSelPop( strCd, strNm, buySaleFlag)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 매입매출구분
*            //--추가조건--
*            arguments[3] -> 사업자번호
*
* 실행  예) accVenMultiSelPop( EM_ACC_VEN_CD, EM_ACC_VEN_NAME, "1");
*
* return값 : List
*             map
               ACC_VEN_CD  --> 거래선코드
               NAME1       --> 거래선명
               NAME2       --> 이름2
               SORTL       --> 검색어1/2
               STCD1       --> 세금번호1(주민등록번호)
               STCD2       --> 세금번호2(사업자번호)
               STCD3       --> 세금번호3(법인번호)
               J_1KFTIND   --> 산업유형(업태)
               J_1KFTBUS   --> 사업유형(종목)
               J_1KFREPRE  --> 담당자이름(대표자명)
               PSTLZ       --> 우편번호
               ORT01       --> 도시(주소-동,리까지)
               STRAS       --> 번지
               SPERR       --> 전기보류
               LOEVM       --> 삭제표시
               SPERR2      --> 전기보류2
               LOEVM2      --> 삭제표시2
               TELF1       --> 전화
               TELFX       --> 팩스
               BUY_SALE_FLAG --> 매입매출구분
*/
function accVenMultiSelPop( strCd, strNm, buySaleFlag )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(buySaleFlag);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom001.cc?goTo=accVenPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	
	return null;
}


/**
* setAccVenNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  거래선 이름
* 사용방법 : setaccVenNmWithoutPop( strDataSet, strCd, strNm, buySaleFlag, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 매입매출구분
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사업자번호
*
* 실행  예) setaccVenNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME, "1" , 0);
*
* return값 : void
*/
function setAccVenNmWithoutPop( strDataSet, objCd, objNm, buySaleFlag, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	buySaleFlag = buySaleFlag==null?'1':buySaleFlag
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('ACC_VEN_CD:STRING(13),ACC_VEN_NAME:STRING(40),ACC_VEN_FLAG:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ACC_VEN_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ACC_VEN_NAME") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ACC_VEN_FLAG") = buySaleFlag;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom001.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
	if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "ACC_VEN_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "NAME1");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return accVenPop( objCd, objNm, buySaleFlag);
			else
				return accVenPop( objCd, objNm, buySaleFlag, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setAccVenNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  거래선 이름(그리드)
* 사용방법 : setAccVenNmWithoutToGridPop( strDataSet, strCd, strNm, buySaleFlag, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 매입매출구분
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사업자번호
*
* 실행  예) setAccVenNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" ,"1" , 0);
*
* return값 : 
*             map
               ACC_VEN_CD  --> 거래선코드
               NAME1       --> 거래선명
               NAME2       --> 이름2
               SORTL       --> 검색어1/2
               STCD1       --> 세금번호1(주민등록번호)
               STCD2       --> 세금번호2(사업자번호)
               STCD3       --> 세금번호3(법인번호)
               J_1KFTIND   --> 산업유형(업태)
               J_1KFTBUS   --> 사업유형(종목)
               J_1KFREPRE  --> 담당자이름(대표자명)
               PSTLZ       --> 우편번호
               ORT01       --> 도시(주소-동,리까지)
               STRAS       --> 번지
               SPERR       --> 전기보류
               LOEVM       --> 삭제표시
               SPERR2      --> 전기보류2
               LOEVM2      --> 삭제표시2
               TELF1       --> 전화
               TELFX       --> 팩스
               BUY_SALE_FLAG --> 매입매출구분
*/
function setAccVenNmWithoutToGridPop( strDataSet, strCd, strNm, buySaleFlag, searchTp){

	buySaleFlag = buySaleFlag==null?'1':buySaleFlag;
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('ACC_VEN_CD:STRING(13),ACC_VEN_NAME:STRING(40),ACC_VEN_FLAG:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ACC_VEN_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ACC_VEN_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ACC_VEN_FLAG") = buySaleFlag;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom001.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return accVenToGridPop( strCd, strNm, buySaleFlag );
			else
				return accVenToGridPop( strCd, strNm, buySaleFlag, addCondition );
		}else{
	   	    return null;
		}
	}
}




/** 
* skuATypePop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품A) Popup
* 사용방법 : skuATypePop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 스타일
*            arguments[7] -> 컬러
*            arguments[8] -> 사이즈
*            arguments[9] -> 품번유형
*            arguments[10] -> 거래형태
*            arguments[11] -> 사용여부
*            arguments[12] -> 매입일자
*            arguments[13] -> 협력사코드
*
* 실행  예) skuATypePop( EM_SKU_CD, EM_SKU_NM , 'N');
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               STYLE_CD       --> 스타일
               COLOR_CD       --> 컬러
               SIZE_CD        --> 사이즈
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function skuATypePop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom002.cc?goTo=skuATypePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("SKU_CD");
		objNm.Text = map.get("SKU_NAME");
		return map;
 	}
	
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
  	
	return null;
}

/** 
* skuATypeToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품A) Popup(Grid)
* 사용방법 : skuATypeToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 스타일
*            arguments[7] -> 컬러
*            arguments[8] -> 사이즈
*            arguments[9] -> 품번유형
*            arguments[10] -> 거래형태
*            arguments[11] -> 사용여부
*            arguments[12] -> 매입일자
*            arguments[13] -> 협력사코드
*
* 실행  예) skuATypeToGridPop( "CODE", "NAME" , 'N');
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               STYLE_CD       --> 스타일
               COLOR_CD       --> 컬러
               SIZE_CD        --> 사이즈
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function skuATypeToGridPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom002.cc?goTo=skuATypePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
  	
	return null;
}

/** 
* skuATypeMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품A) Popup(멀티선택)
* 사용방법 : skuATypeMultiSelPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 스타일
*            arguments[7] -> 컬러
*            arguments[8] -> 사이즈
*            arguments[9] -> 품번유형
*            arguments[10] -> 거래형태
*            arguments[11] -> 사용여부
*            arguments[12] -> 매입일자
*            arguments[13] -> 협력사코드
*
* 실행  예) skuATypeMultiSelPop( EM_SKU_CD, EM_SKU_NM , 'N');
*
* return값 : List
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               STYLE_CD       --> 스타일
               COLOR_CD       --> 컬러
               SIZE_CD        --> 사이즈
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function skuATypeMultiSelPop( strCd, strNm, authGb )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom002.cc?goTo=skuATypePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	
	return null;
}


/**
* setskuATypeNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  단품코드(의류단품A) 이름
* 사용방법 : setskuATypeNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 스타일
*            arguments[9] -> 컬러
*            arguments[10] -> 사이즈
*            arguments[11] -> 품번유형
*            arguments[12] -> 거래형태
*            arguments[13] -> 사용여부
*            arguments[14] -> 매입일자
*            arguments[15] -> 협력사코드
*
* 실행  예) setskuATypeNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setskuATypeNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom002.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
	if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "SKU_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "SKU_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return skuATypePop( objCd, objNm, authGb );
			else
				return skuATypePop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setskuATypeNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  단품코드(의류단품A) 이름(그리드)
* 사용방법 : setskuATypeNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 스타일
*            arguments[9] -> 컬러
*            arguments[10] -> 사이즈
*            arguments[11] -> 품번유형
*            arguments[12] -> 거래형태
*            arguments[13] -> 사용여부
*            arguments[14] -> 매입일자
*            arguments[15] -> 협력사코드
*
* 실행  예) setskuATypeNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : 
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               STYLE_CD       --> 스타일
               COLOR_CD       --> 컬러
               SIZE_CD        --> 사이즈
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function setskuATypeNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom002.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return skuATypeToGridPop( strCd, strNm, authGb );
			else
				return skuATypeToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}


/** 
* skuBTypePop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품B) Popup
* 사용방법 : skuBTypePop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 관리항목1
*            arguments[7] -> 관리항목2
*            arguments[8] -> 관리항목3
*            arguments[9] -> 관리항목4
*            arguments[10] -> 관리항목5
*            arguments[11] -> 품번유형
*            arguments[12] -> 거래형태
*            arguments[13] -> 사용여부
*            arguments[14] -> 매입일자
*            arguments[15] -> 협력사코드
*            arguments[16] -> 스타일코드
*            arguments[17] -> 칼라코드
*            arguments[18] -> 사이즈코드
*
* 실행  예) skuBTypePop( EM_SKU_CD, EM_SKU_NM , 'N');
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               MNG_CD1        --> 관리항목1
               MNG_CD2        --> 관리항목2
               MNG_CD3        --> 관리항목3
               MNG_CD4        --> 관리항목4
               MNG_CD5        --> 관리항목5
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
*/
function skuBTypePop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom003.cc?goTo=skuBTypePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("SKU_CD");
		objNm.Text = map.get("SKU_NAME");
		return map;
 	}
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
  	
	return null;
}

/** 
* skuBTypeToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품B) Popup(Grid)
* 사용방법 : skuBTypeToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 관리항목1
*            arguments[7] -> 관리항목2
*            arguments[8] -> 관리항목3
*            arguments[9] -> 관리항목4
*            arguments[10] -> 관리항목5
*            arguments[11] -> 품번유형
*            arguments[12] -> 거래형태
*            arguments[13] -> 사용여부
*            arguments[14] -> 매입일자
*            arguments[15] -> 협력사코드
*            arguments[16] -> 스타일코드
*            arguments[17] -> 칼라코드
*            arguments[18] -> 사이즈코드
*
* 실행  예) skuBTypeToGridPop( "CODE", "NAME" , 'N');
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               MNG_CD1        --> 관리항목1
               MNG_CD2        --> 관리항목2
               MNG_CD3        --> 관리항목3
               MNG_CD4        --> 관리항목4
               MNG_CD5        --> 관리항목5
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
*/
function skuBTypeToGridPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom003.cc?goTo=skuBTypePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
  	
	return null;
}

/** 
* skuBTypeMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품B) Popup(멀티선택)
* 사용방법 : skuBTypeMultiSelPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 관리항목1
*            arguments[7] -> 관리항목2
*            arguments[8] -> 관리항목3
*            arguments[9] -> 관리항목4
*            arguments[10] -> 관리항목5
*            arguments[11] -> 품번유형
*            arguments[12] -> 거래형태
*            arguments[13] -> 사용여부
*            arguments[14] -> 매입일자
*            arguments[15] -> 협력사코드
*            arguments[16] -> 스타일코드
*            arguments[17] -> 칼라코드
*            arguments[18] -> 사이즈코드
*
* 실행  예) skuBTypeMultiSelPop( EM_SKU_CD, EM_SKU_NM , 'N');
*
* return값 : List
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               MNG_CD1        --> 관리항목1
               MNG_CD2        --> 관리항목2
               MNG_CD3        --> 관리항목3
               MNG_CD4        --> 관리항목4
               MNG_CD5        --> 관리항목5
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
*/
function skuBTypeMultiSelPop( strCd, strNm, authGb )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom003.cc?goTo=skuBTypePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	
	return null;
}


/**
* setSkuBTypeNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  단품코드(의류단품B) 이름
* 사용방법 : setSkuBTypeNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 관리항목1
*            arguments[9] -> 관리항목2
*            arguments[10] -> 관리항목3
*            arguments[11] -> 관리항목4
*            arguments[12] -> 관리항목5
*            arguments[13] -> 품번유형
*            arguments[14] -> 거래형태
*            arguments[15] -> 사용여부
*            arguments[16] -> 매입일자
*            arguments[17] -> 협력사코드
*            arguments[18] -> 스타일코드
*            arguments[19] -> 칼라코드
*            arguments[20] -> 사이즈코드
*
* 실행  예) setSkuBTypeNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setSkuBTypeNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom003.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "SKU_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "SKU_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return skuATypePop( objCd, objNm, authGb );
			else
				return skuATypePop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setSkuBTypeNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  단품코드(의류단품B) 이름(그리드)
* 사용방법 : setSkuBTypeNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 관리항목1
*            arguments[9] -> 관리항목2
*            arguments[10] -> 관리항목3
*            arguments[11] -> 관리항목4
*            arguments[12] -> 관리항목5
*            arguments[13] -> 품번유형
*            arguments[14] -> 거래형태
*            arguments[15] -> 사용여부
*            arguments[16] -> 매입일자
*            arguments[17] -> 협력사코드
*            arguments[18] -> 스타일코드
*            arguments[19] -> 칼라코드
*            arguments[20] -> 사이즈코드
*
* 실행  예) setSkuBTypeNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : 
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               MNG_CD1        --> 관리항목1
               MNG_CD2        --> 관리항목2
               MNG_CD3        --> 관리항목3
               MNG_CD4        --> 관리항목4
               MNG_CD5        --> 관리항목5
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
*/
function setSkuBTypeNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom003.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return skuBTypeToGridPop( strCd, strNm, authGb );
			else
				return skuBTypeToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* strSkuPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(점별) Popup
* 사용방법 : strSkuPop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 품번유형
*            arguments[7] -> 거래형태
*            arguments[8] -> 사용여부
*            arguments[9] -> 매입일자
*            arguments[10] -> 단품종류
*            arguments[11] -> 협력사코드
*            arguments[12] -> 스타일코드
*            arguments[13] -> 칼라코드
*            arguments[14] -> 사이즈코드
*            arguments[15] -> 소스마킹코드테이블 포함여부
*            arguments[16] -> 단품협력사코드
*
* 실행  예) strSkuPop( EM_SKU_CD, EM_SKU_NM , 'N');
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               GIFT_AMT_TYPE  --> 상품권금종
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
               SKU_TYPE       --> 단품종류
*/
function strSkuPop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom004.cc?goTo=strSkuPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("SKU_CD");
		objNm.Text = map.get("SKU_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
  	
	return null;
}

/** 
* strSkuToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(점별) Popup(Grid)
* 사용방법 : strSkuToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 품번유형
*            arguments[7] -> 거래형태
*            arguments[8] -> 사용여부
*            arguments[9] -> 매입일자
*            arguments[10] -> 단품종류
*            arguments[11] -> 협력사코드
*            arguments[12] -> 스타일코드
*            arguments[13] -> 칼라코드
*            arguments[14] -> 사이즈코드
*            arguments[15] -> 소스마킹코드테이블 포함여부
*            arguments[16] -> 단품협력사코드
*
* 실행  예) strSkuToGridPop( "CODE", "NAME" , 'N');
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               GIFT_AMT_TYPE  --> 상품권금종
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
               SKU_TYPE       --> 단품종류
*/
function strSkuToGridPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);
	
    var returnVal = window.showModalDialog("/pot/ccom004.cc?goTo=strSkuPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
  	
	return null;
}

/** 
* strSkuMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(점별) Popup(멀티선택)
* 사용방법 : strSkuMultiSelPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 품번유형
*            arguments[7] -> 거래형태
*            arguments[8] -> 사용여부
*            arguments[9] -> 매입일자
*            arguments[10] -> 단품종류
*            arguments[11] -> 협력사코드
*            arguments[12] -> 스타일코드
*            arguments[13] -> 칼라코드
*            arguments[14] -> 사이즈코드
*            arguments[15] -> 소스마킹코드테이블 포함여부
*            arguments[16] -> 단품협력사코드
*
* 실행  예) strSkuMultiSelPop( "CODE", "NAME" , 'N');
*
* return값 : list
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               GIFT_AMT_TYPE  --> 상품권금종
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
               SKU_TYPE       --> 단품종류
*/
function strSkuMultiSelPop( strCd, strNm, authGb )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom004.cc?goTo=strSkuPop",
                                           arrArg,
                                           "dialogWidth:400px;dialogHeight:445px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	
	return null;
}


/**
* setStrSkuNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  단품코드(점별) 이름
* 사용방법 : setStrSkuNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 거래형태
*            arguments[10]-> 사용여부
*            arguments[11] -> 매입일자
*            arguments[12] -> 단품종류
*            arguments[13] -> 협력사코드
*            arguments[14] -> 스타일코드
*            arguments[15] -> 칼라코드
*            arguments[16] -> 사이즈코드
*            arguments[17] -> 소스마킹코드테이블 포함여부
*            arguments[18] -> 단품협력사코드
*
* 실행  예) setStrSkuNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setStrSkuNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	var strHeader = 'SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200),VEN_NAME:STRING(100),PUMBUN_NAME:STRING(100)';

	DS_I_CONDITION.setDataHeader(strHeader);
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_NAME") = ""; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_NAME") = ""; 

    TR_MAIN.Action="/pot/ccom004.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "SKU_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "SKU_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return strSkuPop( objCd, objNm, authGb );
			else
				return strSkuPop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}


/**
* setStrSkuNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  단품코드(점별) 이름(그리드)
* 사용방법 : setStrSkuNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 거래형태
*            arguments[10]-> 사용여부
*            arguments[11] -> 매입일자
*            arguments[12] -> 단품종류
*            arguments[13] -> 협력사코드
*            arguments[14] -> 스타일코드
*            arguments[15] -> 칼라코드
*            arguments[16] -> 사이즈코드
*            arguments[17] -> 소스마킹코드테이블 포함여부
*            arguments[18] -> 단품협력사코드
*
* 실행  예) setStrSkuNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               GIFT_AMT_TYPE  --> 상품권금종
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
               SKU_TYPE       --> 단품종류
*/
function setStrSkuNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	var strHeader = 'SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200),VEN_NAME:STRING(100),PUMBUN_NAME:STRING(100)';

	DS_I_CONDITION.setDataHeader(strHeader);
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_NAME") = ""; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_NAME") = ""; 

    TR_MAIN.Action="/pot/ccom004.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return strSkuToGridPop( strCd, strNm, authGb );
			else
				return strSkuToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}
/** 
* buyerPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 바이어(SM)코드 Popup
* 사용방법 : buyerPop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 조직구분
*            arguments[5] -> 조직코드
*            arguments[6] -> 정부구분
*            arguments[7] -> 사용여부
*            arguments[8] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) buyerPop( EM_BUYER_CD, EM_BUYER_NM , 'N');
*
* return값 : map
              BUYER_CD    --> 바이어코드
              BUYER_NAME  --> 바이어명
              MAIN_FLAG   --> 정부구분
*/
function buyerPop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom005.cc?goTo=buyerPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("BUYER_CD");
		objNm.Text = map.get("BUYER_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
  	
  	
	return null;
}
/** 
* buyerPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 바이어(SM)코드 Popup
* 사용방법 : buyerPop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 조직구분
*            arguments[5] -> 조직코드
*            arguments[6] -> 정부구분
*            arguments[7] -> 사용여부
*            arguments[8] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) buyerPop( EM_BUYER_CD, EM_BUYER_NM , 'N');
*
* return값 : map
              BUYER_CD    --> 바이어코드
              BUYER_NAME  --> 바이어명
              MAIN_FLAG   --> 정부구분
*/
function buyerEmpPop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom031.cc?goTo=buyerEmpPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		//objCd.Text = map.get("BUYER_CD");
		//objNm.Text = map.get("BUYER_NAME");
		objCd.Text = map.get("EMP_NO");
		objNm.Text = map.get("EMP_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
  	
  	
	return null;
}

/** 
* buyerToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 바이어(SM)코드 Popup(Grid)
* 사용방법 : buyerToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 조직구분
*            arguments[5] -> 조직코드
*            arguments[6] -> 정부구분
*            arguments[7] -> 사용여부
*            arguments[8] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) buyerToGridPop( "CODE", "NAME" , 'N');
*
* return값 : map
              BUYER_CD    --> 바이어코드
              BUYER_NAME  --> 바이어명
              MAIN_FLAG   --> 정부구분
*/
function buyerToGridPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom005.cc?goTo=buyerPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
  	
	return null;
}

/** 
* buyerMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 바이어(SM)코드 Popup(멀티선택)
* 사용방법 : buyerMultiSelPop( strCd, strNm, authGb)
*            arguments[0] -> 코드
*            arguments[1] -> 명
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 조직구분
*            arguments[5] -> 조직코드
*            arguments[6] -> 정부구분
*            arguments[7] -> 사용여부
*            arguments[8] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) buyerMultiSelPop( "CODE", "NAME" , 'N');
*
* return값 : List 
*             map
               BUYER_CD    --> 바이어코드
               BUYER_NAME  --> 바이어명
               MAIN_FLAG   --> 정부구분
*/
function buyerMultiSelPop( strCd, strNm, authGb )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom005.cc?goTo=buyerPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	
	return null;
}


/**
* setBuyerNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 바이어(SM)코드 이름
* 사용방법 : setBuyerNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 조직구분
*            arguments[7] -> 조직코드
*            arguments[8] -> 정부구분
*            arguments[9] -> 사용여부
*            arguments[10] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) setBuyerNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setBuyerNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('BUYER_CD:STRING(6),BUYER_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_NAME") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom005.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "BUYER_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "BUYER_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return buyerPop( objCd, objNm, authGb );
			else
				return buyerPop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setBuyerEmpNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 바이어(SM)사원코드 이름
* 사용방법 : setBuyerEmpNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 조직구분
*            arguments[7] -> 조직코드
*            arguments[8] -> 정부구분
*            arguments[9] -> 사용여부
*            arguments[10] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) setBuyerEmpNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setBuyerEmpNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('BUYER_CD:STRING(6),BUYER_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_NAME") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom031.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		//objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "BUYER_CD");
		//objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "BUYER_NAME");
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "EMP_NO");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "EMP_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return buyerEmpPop( objCd, objNm, authGb );
			else
				return buyerEmpPop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setBuyerNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 바이어(SM)코드 Popup(그리드)
* 사용방법 : setBuyerNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 조직구분
*            arguments[7] -> 조직코드
*            arguments[8] -> 정부구분
*            arguments[9] -> 사용여부
*            arguments[10] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) setBuyerNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : 
*             map
               BUYER_CD    --> 바이어코드
               BUYER_NAME  --> 바이어명
               MAIN_FLAG   --> 정부구분
*/
function setBuyerNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('BUYER_CD:STRING(6),BUYER_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom005.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return buyerToGridPop( strCd, strNm, authGb );
			else
				return buyerToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}

/**
* setBuyerEmpNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 바이어(SM)코드 Popup(그리드)
* 사용방법 : setBuyerEmpNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 조직구분
*            arguments[7] -> 조직코드
*            arguments[8] -> 정부구분
*            arguments[9] -> 사용여부
*            arguments[10] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) setBuyerNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : 
*             map
               BUYER_CD    --> 바이어코드
               BUYER_NAME  --> 바이어명
               MAIN_FLAG   --> 정부구분
*/
function setBuyerEmpNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('BUYER_CD:STRING(6),BUYER_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom031.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return buyerToGridPop( strCd, strNm, authGb );
			else
				return buyerToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* stylePop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 스타일코드 Popup
* 사용방법 : stylePop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 품번코드
*            arguments[5] -> 사용여부
*            arguments[6] -> 스타일구분
*
* 실행  예) stylePop( EM_STYLE_CD, EM_STYLE_NM , 'N');
*
* return값 : map                   
              STYLE_CD    --> 스타일코드
              STYLE_NAME  --> 스타일명
              PUMBUN_CD   --> 품번코드
              PUMMOK_CD   --> 품목코드
*/
function stylePop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom006.cc?goTo=stylePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("STYLE_CD");
		objNm.Text = map.get("STYLE_NAME");
		return map;
 	}
	
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* styleToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 스타일코드 Popup(Grid)
* 사용방법 : styleToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 품번코드
*            arguments[5] -> 사용여부
*            arguments[6] -> 스타일구분
*
* 실행  예) styleToGridPop( "CODE", "NAME" , 'N');
*
* return값 : map                   
              STYLE_CD    --> 스타일코드
              STYLE_NAME  --> 스타일명
              PUMBUN_CD   --> 품번코드
              PUMMOK_CD   --> 품목코드
*/
function styleToGridPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom006.cc?goTo=stylePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* styleMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 스타일코드 Popup(멀티선택)
* 사용방법 : stylePop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 품번코드
*            arguments[5] -> 사용여부
*            arguments[6] -> 스타일구분
*
* 실행  예) styleMultiSelPop( "CODE", "NAME" , 'N');
*
* return값 : List
*             map                   
               STYLE_CD    --> 스타일코드
               STYLE_NAME  --> 스타일명
               PUMBUN_CD   --> 품번코드
               PUMMOK_CD   --> 품목코드
*/
function styleMultiSelPop( strCd, strNm, authGb )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom006.cc?goTo=stylePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
  		return arrArg[0];
 	}
	return null;
}

/**
* setStyleNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 스타일이름
* 사용방법 : setStyleNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 품번코드
*            arguments[7] -> 사용여부
*            arguments[8] -> 스타일구분
*
* 실행  예) setStyleNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setStyleNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('STYLE_CD:STRING(54),STYLE_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STYLE_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STYLE_NAME") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom006.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "STYLE_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "STYLE_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return stylePop( objCd, objNm, authGb );
			else
				return stylePop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setStyleNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 스타일이름(그리드)
* 사용방법 : setStyleNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 품번코드
*            arguments[7] -> 사용여부
*            arguments[8] -> 스타일구분
*
* 실행  예) setStyleNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : 
*             map                   
               STYLE_CD    --> 스타일코드
               STYLE_NAME  --> 스타일명
               PUMBUN_CD   --> 품번코드
               PUMMOK_CD   --> 품목코드
*/
function setStyleNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('STYLE_CD:STRING(54),STYLE_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STYLE_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STYLE_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom006.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return styleToGridPop( strCd, strNm, authGb );
			else
				return styleToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}
/** 
* orgPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-15
* 개    요 : 조직 Popup
* 사용방법 : orgPop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한 체크 여부
*            //--추가조건--
*            arguments[3] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[7] -> 사용여부
*            arguments[8] -> 점코드 
*            arguments[9] -> 코스트센터 코드 (조직레벨 PC(4)이상 입력시)
*            arguments[10] -> 1: 조회조건 disable
*
* 실행  예) orgPop( EM_ORG_CD, EM_ORG_NM, 'Y');
*
* return값 : map
*              STR_CD      --> 점코드
               DEPT_CD     --> 부문코드
               TEAM_CD     --> 팀코드
               PC_CD       --> PC코드
               CORNER_CD   --> 코너코드
               ORG_CD      --> 조직코드
               ORG_NAME    --> 조직명
               KOSTL_CD    --> 코스트센터 코드 (코너 레벨일경우 PC의 코스트센터 코드)
*/
function orgPop( objCd, objNm, authGb)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom007.cc?goTo=orgPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("ORG_CD");
		objNm.Text = map.get("ORG_NAME");
		return map;
 	}
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* orgToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-15
* 개    요 : 조직 Popup(Grid)
* 사용방법 : orgToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한 체크 여부
*            //--추가조건--
*            arguments[3] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[7] -> 사용여부
*            arguments[8] -> 점코드 
*            arguments[9] -> 코스트센터 코드 (조직레벨 PC(4)이상 입력시)
*
* 실행  예) orgToGridPop( "CODE", "NAME", 'Y');
*
* return값 : map
*              STR_CD      --> 점코드
               DEPT_CD     --> 부문코드
               TEAM_CD     --> 팀코드
               PC_CD       --> PC코드
               CORNER_CD   --> 코너코드
               ORG_CD      --> 조직코드
               ORG_NAME    --> 조직명
               KOSTL_CD    --> 코스트센터 코드 (코너 레벨일경우 PC의 코스트센터 코드)
*/
function orgToGridPop( strCd, strNm, authGb)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom007.cc?goTo=orgPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* orgMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-15
* 개    요 : 조직 Popup(멀티 선택)
* 사용방법 : orgMultiSelPop( strCd, strCdNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한 체크 여부
*            //--추가조건--
*            arguments[3] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[7] -> 사용여부
*            arguments[8] -> 점코드 
*            arguments[9] -> 코스트센터 코드 (조직레벨 PC(4)이상 입력시)
*
* 실행  예) orgMultiSelPop( "CODE", "NAME" , 'N');
*
* return값 :  List
*             map
*              STR_CD      --> 점코드
               DEPT_CD     --> 부문코드
               TEAM_CD     --> 팀코드
               PC_CD       --> PC코드
               CORNER_CD   --> 코너코드
               ORG_CD      --> 조직코드
               ORG_NAME    --> 조직명
               KOSTL_CD    --> 코스트센터 코드 (코너 레벨일경우 PC의 코스트센터 코드)
*/
function orgMultiSelPop( strCd, strNm, authGb)
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom007.cc?goTo=orgPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setOrgNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 조직 Popup(이름)
* 사용방법 : setOrgNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[9] -> 사용여부
*            arguments[10] -> 점코드 
*            arguments[11] -> 코스트센터 코드 (조직레벨 PC(4)이상 입력시)
*
* 실행  예) setOrgNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setOrgNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('ORG_CD:STRING(10),ORG_NM:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_NM") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom007.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "ORG_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "ORG_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return orgPop( objCd, objNm, authGb );
			else
				return orgPop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setOrgNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 조직 Popup(그리드) 
* 사용방법 : setOrgNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[9] -> 사용여부
*            arguments[10] -> 점코드 
*            arguments[11] -> 코스트센터 코드 (조직레벨 PC(4)이상 입력시)
*
* 실행  예) setOrgNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : 
*             map
*              STR_CD      --> 점코드
               DEPT_CD     --> 부문코드
               TEAM_CD     --> 팀코드
               PC_CD       --> PC코드
               CORNER_CD   --> 코너코드
               ORG_CD      --> 조직코드
               ORG_NAME    --> 조직명
               KOSTL_CD    --> 코스트센터 코드 (코너 레벨일경우 PC의 코스트센터 코드)
*/
function setOrgNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader('ORG_CD:STRING(10),ORG_NM:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_NM") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom007.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return orgToGridPop( strCd, strNm, authGb );
			else
				return orgToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}
/** 
* orgCornerOutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-15
* 개    요 : 조직 (코너제외) Popup
* 사용방법 : orgCornerOutPop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한 체크 여부
*            //--추가조건--
*            arguments[3] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[7] -> 사용여부
*            arguments[8] -> 점코드 
*
* 실행  예) orgCornerOutPop( EM_ORG_CD, EM_ORG_NM, 'Y');
*
* return값 : map
*              STR_CD      --> 점코드
               DEPT_CD     --> 부문코드
               TEAM_CD     --> 팀코드
               PC_CD       --> PC코드
               ORG_CD      --> 조직코드
               ORG_NAME    --> 조직명
*/
function orgCornerOutPop( objCd, objNm, authGb)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom008.cc?goTo=orgCornerOutPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("ORG_CD");
		objNm.Text = map.get("ORG_NAME");
		return map;
 	}
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
  	

	return null;
}

/** 
* orgCornerOutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-15
* 개    요 : 조직 (코너제외) Popup(Grid)
* 사용방법 : orgCornerOutToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한 체크 여부
*            //--추가조건--
*            arguments[3] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[7] -> 사용여부
*            arguments[8] -> 점코드 
*
* 실행  예) orgCornerOutToGridPop( "CODE", "NAME", 'Y');
*
* return값 : map
*              STR_CD      --> 점코드
               DEPT_CD     --> 부문코드
               TEAM_CD     --> 팀코드
               PC_CD       --> PC코드
               ORG_CD      --> 조직코드
               ORG_NAME    --> 조직명
*/
function orgCornerOutToGridPop( strCd, strNm, authGb)
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom008.cc?goTo=orgCornerOutPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* orgCornerOutMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-15
* 개    요 : 조직 (코너제외) Popup(멀티선택)
* 사용방법 : orgCornerOutMultiSelPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한 체크 여부
*            //--추가조건--
*            arguments[3] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[7] -> 사용여부
*            arguments[8] -> 점코드 
*
* 실행  예) orgCornerOutMultiSelPop( "CODE", "NAME" , 'N');
*
* return값 :   List
*              map
*              STR_CD      --> 점코드
               DEPT_CD     --> 부문코드
               TEAM_CD     --> 팀코드
               PC_CD       --> PC코드
               ORG_CD      --> 조직코드
               ORG_NAME    --> 조직명
*/
function orgCornerOutMultiSelPop( strCd, strNm, authGb)
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom008.cc?goTo=orgCornerOutPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
		
 	}
	return null;
}

/**
* setOrgCornerOutNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 조직 (코너제외) Popup(이름)
* 사용방법 : setOrgCornerOutNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[3] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[7] -> 사용여부
*            arguments[8] -> 점코드 
*
* 실행  예) setOrgCornerOutNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setOrgCornerOutNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('ORG_CD:STRING(10),ORG_NM:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_NM") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom008.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "ORG_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "ORG_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return orgCornerOutPop( objCd, objNm, authGb );
			else
				return orgCornerOutPop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setOrgCornerOutNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 조직 (코너제외) Popup(그리드)
* 사용방법 : setOrgCornerOutNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[3] -> (권한 체크 'Y' 경우] 사원번호 
*            arguments[4] -> 상위조직코드 
*            arguments[5] -> 조직구분
*            arguments[6] -> 조직레벨 
*            arguments[7] -> 사용여부
*            arguments[8] -> 점코드 
*
* 실행  예) setOrgCornerOutNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME", 'N', 0);
*
* return값 : 
*              map
*              STR_CD      --> 점코드
               DEPT_CD     --> 부문코드
               TEAM_CD     --> 팀코드
               PC_CD       --> PC코드
               ORG_CD      --> 조직코드
               ORG_NAME    --> 조직명
*/
function setOrgCornerOutNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('ORG_CD:STRING(10),ORG_NM:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_NM") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom008.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return orgCornerOutToGridPop( strCd, strNm, authGb );
			else
				return orgCornerOutToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}
/** 
* pummokPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품목 Popup
* 사용방법 : pummokPop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 신선식품여부
*            arguments[3] -> 품목레벨
*            arguments[4] -> 상위품목코드
*            arguments[5] -> 사용여부 
*
* 실행  예) pummokPop( EM_PUMMOK_CD, EM_PUMMOK_NM );
*
* return값 : map                    
               PUMMOK_CD     --> 품목코드
               PUMMOK_NAME   --> 품목명
               RECP_NAME     --> 영수증명
               PUMMOK_LEVEL  --> 품목레벨
               L_CD          --> 대
               M_CD          --> 중
               S_CD          --> 소
               D_CD          --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
*/
function pummokPop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom009.cc?goTo=pummokPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("PUMMOK_CD");
		objNm.Text = map.get("PUMMOK_NAME");
		return map;
 	}
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* pummokToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품목 Popup(Grid)
* 사용방법 : pummokToGridPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 신선식품여부
*            arguments[3] -> 품목레벨
*            arguments[4] -> 상위품목코드
*            arguments[5] -> 사용여부 
*
* 실행  예) pummokToGridPop( "CODE", "NAME" );
*
* return값 : map                    
               PUMMOK_CD     --> 품목코드
               PUMMOK_NAME   --> 품목명
               RECP_NAME     --> 영수증명
               PUMMOK_LEVEL  --> 품목레벨
               L_CD          --> 대
               M_CD          --> 중
               S_CD          --> 소
               D_CD          --> 세
               UNIT_CD       --> 단위코드
               TAG_FLAG      --> 택구분
               PUMMOK_SRT_CD --> 품목단축코드
*/
function pummokToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom009.cc?goTo=pummokPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* pummokMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품목 Popup(멀티선택)
* 사용방법 : pummokMultiSelPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 신선식품여부
*            arguments[3] -> 품목레벨
*            arguments[4] -> 상위품목코드
*            arguments[5] -> 사용여부 
*
* 실행  예) pummokMultiSelPop( "CODE", "NAME" );
*
* return값 : List 
*              map                   
               PUMMOK_CD     --> 품목코드
               PUMMOK_NAME   --> 품목명
               RECP_NAME     --> 영수증명
               PUMMOK_LEVEL  --> 품목레벨
               L_CD          --> 대
               M_CD          --> 중
               S_CD          --> 소
               D_CD          --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               PUMMOK_SRT_CD --> 품목단축코드
*/
function pummokMultiSelPop( strCd, strNm)
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom009.cc?goTo=pummokPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setPummokNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품목 Popup(이름)
* 사용방법 : setPummokNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명*            
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 신선식품여부
*            arguments[5] -> 품목레벨
*            arguments[6] -> 상위품목코드
*            arguments[7] -> 사용여부 
*
* 실행  예) setPummokNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setPummokNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('PUMMOK_CD:STRING(8),PUMMOK_NM:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_NM") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom009.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMMOK_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMMOK_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return pummokPop( objCd, objNm);
			else
				return pummokPop( objCd, objNm, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}
/**
* setPummokNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품목 Popup(멀티선택)
* 사용방법 : setPummokNmWithoutToGridPop( strDataSet, strCd, strNm,  searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명*            
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 신선식품여부
*            arguments[5] -> 품목레벨
*            arguments[6] -> 상위품목코드
*            arguments[7] -> 사용여부 
*
* 실행  예) setPummokNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME", 'N', 0);
*
* return값 : 
*              map                   
               PUMMOK_CD     --> 품목코드
               PUMMOK_NAME   --> 품목명
               RECP_NAME     --> 영수증명
               PUMMOK_LEVEL  --> 품목레벨
               L_CD          --> 대
               M_CD          --> 중
               S_CD          --> 소
               D_CD          --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               PUMMOK_SRT_CD --> 품목단축코드
*/
function setPummokNmWithoutToGridPop( strDataSet, strCd, strNm,  searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('PUMMOK_CD:STRING(8),PUMMOK_NM:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_NM") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom009.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return pummokToGridPop( strCd, strNm);
			else
				return pummokToGridPop( strCd, strNm, addCondition );
		}else{
			return null;
		}
	}
}
/** 
* pbnPmkPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품번별 품목 Popup
* 사용방법 : pbnPmkPop( objCd, objNm, pumbunCd)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 품번코드
*            //--추가조건--
*            arguments[3] -> 신선식품여부
*            arguments[4] -> 사용여부
*            arguments[5] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) pbnPmkPop( EM_PUMMOK_CD, EM_PUMMOK_NM, '000000' );
*
* return값 : map                         
               PUMMOK_CD         --> 품목코드
               PUMMOK_NAME       --> 품목명
               RECP_NAME         --> 영수증명
               PUMMOK_LEVEL      --> 품목레벨
               L_CD              --> 대
               M_CD              --> 중
               S_CD              --> 소
               D_CD              --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               TAG_PRT_OWN_FLAG  --> 택발행주체
*/
function pbnPmkPop( objCd, objNm, pumbunCd )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(pumbunCd);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom010.cc?goTo=pbnPmkPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("PUMMOK_CD");
		objNm.Text = map.get("PUMMOK_NAME");
		return map;
 	}
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* pbnPmkSrtPop()
* 작 성 자 : DHL
* 작 성 일 : 2012-05-15
* 개    요 : 품번별 품목 단축코드 Popup
* 사용방법 : pbnPmkSrtPop( objCd, objNm, pumbunCd)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 품번코드
*            //--추가조건--
*            arguments[3] -> 신선식품여부
*            arguments[4] -> 사용여부
*            arguments[5] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) pbnPmkSrtPop( EM_PUMMOK_SRT_CD, EM_PUMMOK_NM, '000000' );
*
* return값 : map                         
               PUMMOK_SRT_CD         --> 품목코드
               PUMMOK_CD         --> 품목코드
               PUMMOK_NAME       --> 품목명
               RECP_NAME         --> 영수증명
               PUMMOK_LEVEL      --> 품목레벨
               L_CD              --> 대
               M_CD              --> 중
               S_CD              --> 소
               D_CD              --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               TAG_PRT_OWN_FLAG  --> 택발행주체
*/
function pbnPmkSrtPop( objCd, objNm, pumbunCd )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(pumbunCd);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom222.cc?goTo=pbnPmkSrtPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("PUMMOK_SRT_CD");
		objNm.Text = map.get("PUMMOK_NAME");
		return map;
 	}
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* pbnPmkToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품번별 품목 Popup(Grid)
* 사용방법 : pbnPmkToGridPop( strCd, strNm, pumbunCd)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 품번코드
*            //--추가조건--
*            arguments[3] -> 신선식품여부
*            arguments[4] -> 사용여부
*            arguments[5] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) pbnPmkToGridPop( "CODE", "NAME", '000000' );
*
* return값 : map                         
               PUMMOK_CD         --> 품목코드
               PUMMOK_NAME       --> 품목명
               RECP_NAME         --> 영수증명
               PUMMOK_LEVEL      --> 품목레벨
               L_CD              --> 대
               M_CD              --> 중
               S_CD              --> 소
               D_CD              --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               TAG_PRT_OWN_FLAG  --> 택발행주체
*/
function pbnPmkToGridPop( strCd, strNm, pumbunCd )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd.Text);
	arrArg.push(strNm.Text);
	arrArg.push(pumbunCd);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom010.cc?goTo=pbnPmkPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}


/** 
* pbnPmkSrtToGridPop()
* 작 성 자 : DHL
* 작 성 일 : 2012-05-15
* 개    요 : 품번별 품목 단축코드 Popup(Grid)
* 사용방법 : pbnPmkSrtToGridPop( strCd, strNm, pumbunCd)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 품번코드
*            //--추가조건--
*            arguments[3] -> 신선식품여부
*            arguments[4] -> 사용여부
*            arguments[5] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) pbnPmkSrtToGridPop( "CODE", "NAME", '000000' );
*
* return값 : map                         
               PUMMOK_SRT_CD     --> 단축코드
               PUMMOK_CD         --> 품목코드
               PUMMOK_NAME       --> 품목명
               RECP_NAME         --> 영수증명
               PUMMOK_LEVEL      --> 품목레벨
               L_CD              --> 대
               M_CD              --> 중
               S_CD              --> 소
               D_CD              --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               TAG_PRT_OWN_FLAG  --> 택발행주체
*/
function pbnPmkSrtToGridPop( strCd, strNm, pumbunCd )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd.Text);
	arrArg.push(strNm.Text);
	arrArg.push(pumbunCd);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom222.cc?goTo=pbnPmkSrtPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* pbnPmkMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품번별 품목 Popup(멀티선택)
* 사용방법 : pummokMultiSelPop( strCd, strCdNm, pumbunCd)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 품번코드
*            //--추가조건--
*            arguments[3] -> 신선식품여부
*            arguments[4] -> 사용여부
*            arguments[5] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) pbnPmkMultiSelPop( "CODE", "NAME" , '000000' );
*
* return값 : List 
*              map                        
               PUMMOK_CD         --> 품목코드
               PUMMOK_NAME       --> 품목명
               RECP_NAME         --> 영수증명
               PUMMOK_LEVEL      --> 품목레벨
               L_CD              --> 대
               M_CD              --> 중
               S_CD              --> 소
               D_CD              --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               TAG_PRT_OWN_FLAG  --> 택발행주체
*/
function pbnPmkMultiSelPop( strCd, strNm, strpumbunCd )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(strpumbunCd);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom010.cc?goTo=pbnPmkPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}


/** 
* pbnPmkMultiSelLevelPop()
* 작 성 자 : FKSS DHL
* 작 성 일 : 2012-05-09
* 개    요 : 품번별 품목 단축코드 Popup(멀티선택)
* 사용방법 : pummokMultiSelLevelPop( strCd, strCdNm, pumbunCd)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 품번코드
*            //--추가조건--
*            arguments[3] -> 신선식품여부
*            arguments[4] -> 사용여부
*            arguments[5] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) pbnPmkMultiSelLevelPop( "CODE", "NAME" , '000000' );
*
* return값 : List 
*              map                        
               PUMMOK_SRT_CD     --> 단축코드
               PUMMOK_CD         --> 품목코드
               PUMMOK_NAME       --> 품목명
               RECP_NAME         --> 영수증명
               PUMMOK_LEVEL      --> 품목레벨
               L_CD              --> 대
               M_CD              --> 중
               S_CD              --> 소
               D_CD              --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               TAG_PRT_OWN_FLAG  --> 택발행주체
*/
function pbnPmkMultiSelLevelPop( strCd, strNm, strpumbunCd )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(strpumbunCd);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom222.cc?goTo=pbnPmkSrtPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setPbnPmkNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품번별 품목 Popup(이름)
* 사용방법 : setPbnPmkNmWithoutPop( strDataSet, objCd, objNm, objCd1, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 품번코드
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 신선식품여부 
*            arguments[6] -> 사용여부
*            arguments[7] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) setPbnPmkNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , EM_CODE, 0);
*
* return값 : void
*/
function setPbnPmkNmWithoutPop( strDataSet, objCd, objNm, pumbunCd, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('PUMBUN_CD:STRING(6),PUMMOK_CD:STRING(8),PUMMOK_NM:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = pumbunCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_CD") = objCd.Text;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_NM") = codeName;    
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom010.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMMOK_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMMOK_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return pbnPmkPop( objCd, objNm, pumbunCd);
			else
				return pbnPmkPop( objCd, objNm, pumbunCd, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}


/**
* setPbnPmkSrtNmWithoutPop()
* 작 성 자 : DHL
* 작 성 일 : 2012-05-15
* 개    요 : 품번별 품목 Popup(이름)
* 사용방법 : setPbnPmkSrtNmWithoutPop( strDataSet, objCd, objNm, objCd1, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 품번코드
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 신선식품여부 
*            arguments[6] -> 사용여부
*            arguments[7] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) setPbnPmkSrtNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , EM_CODE, 0);
*
* return값 : void
*/
function setPbnPmkSrtNmWithoutPop( strDataSet, objCd, objNm, pumbunCd, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('PUMBUN_CD:STRING(6),PUMMOK_SRT_CD:STRING(4),PUMMOK_NM:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = pumbunCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_SRT_CD") = objCd.Text;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_NM") = codeName;    
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom222.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMMOK_SRT_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMMOK_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return pbnPmkSrtPop( objCd, objNm, pumbunCd);
			else
				return pbnPmkSrtPop( objCd, objNm, pumbunCd, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}
/**
* setPbnPmkNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품번별 품목 Popup(그리드)
* 사용방법 : setPbnPmkNmWithoutToGridPop( strDataSet, strCd, strNm, objCd1, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 품번코드
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 신선식품여부 
*            arguments[6] -> 사용여부
*            arguments[7] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) setPbnPmkNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , EM_CODE, 0);
*
* return값 : 
*              map                        
               PUMMOK_CD         --> 품목코드
               PUMMOK_NAME       --> 품목명
               RECP_NAME         --> 영수증명
               PUMMOK_LEVEL      --> 품목레벨
               L_CD              --> 대
               M_CD              --> 중
               S_CD              --> 소
               D_CD              --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               TAG_PRT_OWN_FLAG  --> 택발행주체
*/
function setPbnPmkNmWithoutToGridPop( strDataSet, strCd, strNm, pumbunCd, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('PUMBUN_CD:STRING(6),PUMMOK_CD:STRING(8),PUMMOK_NM:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = pumbunCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_CD") = strCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_NM") = strNm;    
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom010.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return pbnPmkToGridPop( strCd, strNm, pumbunCd);
			else
				return pbnPmkToGridPop( strCd, strNm, pumbunCd, addCondition );
		}else{
	   	    return null;
		}
	}
}

/**
* setPbnPmkSrtNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 품번별 단축코드 Popup(그리드)
* 사용방법 : setPbnPmkSrtNmWithoutToGridPop( strDataSet, strCd, strNm, objCd1, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 품번코드
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 신선식품여부 
*            arguments[6] -> 사용여부
*            arguments[7] -> 품번수정여부 <2010.03.26 : 요청>
*
* 실행  예) setPbnPmkSrtNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , EM_CODE, 0);
*
* return값 : 
*              map                        
               PUMMOK_SRT_CD     --> 단축코드
               PUMMOK_NAME       --> 품목명
               RECP_NAME         --> 영수증명
               PUMMOK_LEVEL      --> 품목레벨
               L_CD              --> 대
               M_CD              --> 중
               S_CD              --> 소
               D_CD              --> 세
               UNIT_CD           --> 단위코드
               TAG_FLAG          --> 택구분
               TAG_PRT_OWN_FLAG  --> 택발행주체
*/
function setPbnPmkSrtNmWithoutToGridPop( strDataSet, strCd, strNm, pumbunCd, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('PUMBUN_CD:STRING(6),PUMMOK_SRT_CD:STRING(4),PUMMOK_NM:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = pumbunCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_SRT_CD") = strCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMMOK_NM") = strNm;    
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom222.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return pbnPmkSrtToGridPop( strCd, strNm, pumbunCd);
			else
				return pbnPmkSrtToGridPop( strCd, strNm, pumbunCd, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* repPumbunPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표 품번 Popup
* 사용방법 : repPumbunPop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 조직코드
*            arguments[6] -> 협력사코드
*            arguments[7] -> 바이어코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 사용여부
*            arguments[10] -> 거래형태
*            arguments[11] -> 판매분매입구분
*
* 실행  예) repPumbunPop( EM_PUMBUN_CD, EM_PUMBUN_NM, 'N' );
*
* return값 : map                   
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               RECP_NAME      --> 영수증명
               SKU_FLAG       --> 단품구분
               REP_PUMBUN_CD  --> 대표품번코드
*/
function repPumbunPop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom011.cc?goTo=repPumbunPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("PUMBUN_CD");
		objNm.Text = map.get("PUMBUN_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* repPumbunToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표 품번 Popup(Grid)
* 사용방법 : repPumbunToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 조직코드
*            arguments[6] -> 협력사코드
*            arguments[7] -> 바이어코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 사용여부
*            arguments[10] -> 거래형태
*            arguments[11] -> 판매분매입구분
*
* 실행  예) repPumbunToGridPop( "CODE", "NAME", 'N' );
*
* return값 : map                   
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               RECP_NAME      --> 영수증명
               SKU_FLAG       --> 단품구분
               REP_PUMBUN_CD  --> 대표품번코드
*/
function repPumbunToGridPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom011.cc?goTo=repPumbunPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}
/** 
* repPumbunMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표 품번 Popup(멀티선택)
* 사용방법 : repPumbunMultiSelPop( strCd, strCdNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 조직코드
*            arguments[6] -> 협력사코드
*            arguments[7] -> 바이어코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 사용여부
*            arguments[10] -> 거래형태
*            arguments[11] -> 판매분매입구분
*
* 실행  예) repPumbunMultiSelPop( "CODE", "NAME" , 'N' );
*
* return값 : List
*              Map                   
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               RECP_NAME      --> 영수증명
               SKU_FLAG       --> 단품구분
               REP_PUMBUN_CD  --> 대표품번코드
*/
function repPumbunMultiSelPop( strCd, strNm, authGb )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom011.cc?goTo=repPumbunPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setRepPumbunNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표 품번 Popup(이름)
* 사용방법 : setRepPumbunNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 조직코드
*            arguments[8] -> 협력사코드
*            arguments[9] -> 바이어코드
*            arguments[10] -> 품번유형
*            arguments[11] -> 사용여부
*            arguments[12] -> 거래형태
*            arguments[13] -> 판매분매입구분
*
* 실행  예) setRepPumbunNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , EM_CODE, 0);
*
* return값 : void
*/
function setRepPumbunNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('PUMBUN_CD:STRING(6),PUMBUN_NM:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_NM") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom011.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMBUN_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMBUN_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return repPumbunPop( objCd, objNm, authGb);
			else
				return repPumbunPop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setRepPumbunNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표 품번 Popup(그리드)
* 사용방법 : setRepPumbunNmWithoutToGridPop( strDataSet,  strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 조직코드
*            arguments[8] -> 협력사코드
*            arguments[9] -> 바이어코드
*            arguments[10] -> 품번유형
*            arguments[11] -> 사용여부
*            arguments[12] -> 거래형태
*            arguments[13] -> 판매분매입구분
*
* 실행  예) setRepPumbunNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , EM_CODE, 0);
*
* return값 : map                   
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               RECP_NAME      --> 영수증명
               SKU_FLAG       --> 단품구분
               REP_PUMBUN_CD  --> 대표품번코드
*/
function setRepPumbunNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('PUMBUN_CD:STRING(6),PUMBUN_NM:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_NM") = strNm; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom011.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return repPumbunToGridPop( strCd, strNm, authGb);
			else
				return repPumbunToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}
/** 
* strPbnPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 점별 품번 Popup
* 사용방법 : strPbnPop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 조직코드
*            arguments[6] -> 협력사코드
*            arguments[7] -> 바이어코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 사용여부
*            arguments[10] -> 단품구분
*            arguments[11] -> 단품종류
*            arguments[12] -> 통합발주여부
*            arguments[13] -> 거래형태
*            arguments[14] -> 판매분매입구분
*            arguments[15] -> 의류단품코드구분
*            arguments[16] -> 층코드
*
* 실행  예) strPbnPop(EM_PUMBUN_CD, EM_PUMBUN__NM, 'N' );
*
* return값 : map                           
               PUMBUN_CD        --> 품번코드
               PUMBUN_NAME      --> 품번명
               RECP_NAME        --> 영수증명
               SKU_FLAG         --> 단품구분
               REP_PUMBUN_CD    --> 대표품번코드
               SKU_TYPE         --> 단품종류
               BIZ_TYPE         --> 거래형태
               TAX_FLAG         --> 과세구분
               CHAR_BUYER_CD    --> 바이어코드
               CHAR_BUYER_NAME  --> 바이어명
               CHAR_SM_CD       --> SM코드
               CHAR_SM_NAME     --> SM명
               VEN_CD           --> 협력사코드
               VEN_NAME         --> 협력
               STYLE_TYPE       --> 의류단품코드구분
               BUYER_EMP_NAME   --> 바이어사원명
               BUY_ORG_CD       --> 매입조직  
			   SALE_ORG_CD      --> 판매조직   
			   PUMBUN_TYPE      --> 품번유형 
*/
function strPbnPop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom012.cc?goTo=strPbnPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("PUMBUN_CD");
		objNm.Text = map.get("PUMBUN_NAME");
		return map;
 	}
	
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* strPbnPop2()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 점별 품번 Popup
* 사용방법 : strPbnPop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 조직코드
*            arguments[6] -> 협력사코드
*            arguments[7] -> 바이어코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 사용여부
*            arguments[10] -> 단품구분
*            arguments[11] -> 단품종류
*            arguments[12] -> 통합발주여부
*            arguments[13] -> 거래형태
*            arguments[14] -> 판매분매입구분
*            arguments[15] -> 의류단품코드구분
*            arguments[16] -> 층코드
*
* 실행  예) strPbnPop(EM_PUMBUN_CD, EM_PUMBUN__NM, 'N' );
*
* return값 : map                           
               PUMBUN_CD        --> 품번코드
               PUMBUN_NAME      --> 품번명
               RECP_NAME        --> 영수증명
               SKU_FLAG         --> 단품구분
               REP_PUMBUN_CD    --> 대표품번코드
               SKU_TYPE         --> 단품종류
               BIZ_TYPE         --> 거래형태
               TAX_FLAG         --> 과세구분
               CHAR_BUYER_CD    --> 바이어코드
               CHAR_BUYER_NAME  --> 바이어명
               CHAR_SM_CD       --> SM코드
               CHAR_SM_NAME     --> SM명
               VEN_CD           --> 협력사코드
               VEN_NAME         --> 협력
               STYLE_TYPE       --> 의류단품코드구분
               BUYER_EMP_NAME   --> 바이어사원명
               BUY_ORG_CD       --> 매입조직  
			   SALE_ORG_CD      --> 판매조직   
			   PUMBUN_TYPE      --> 품번유형 
*/
function strPbnPop2( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom012.cc?goTo=strPbnPop2",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("PUMBUN_CD");
		objNm.Text = map.get("PUMBUN_NAME");
		return map;
 	}
	
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
	return null;
}


/** 
* strPbnToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 점별 품번 Popup(Grid)
* 사용방법 : strPbnToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 조직코드
*            arguments[6] -> 협력사코드
*            arguments[7] -> 바이어코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 사용여부
*            arguments[10] -> 단품구분
*            arguments[11] -> 단품종류
*            arguments[12] -> 통합발주여부
*            arguments[13] -> 거래형태
*            arguments[14] -> 판매분매입구분
*            arguments[15] -> 의류단품코드구분
*            arguments[16] -> 층코드
*
* 실행  예) strPbnToGridPop( "CODE", "NAME", 'N' );
*
* return값 : map                           
               PUMBUN_CD        --> 품번코드
               PUMBUN_NAME      --> 품번명
               RECP_NAME        --> 영수증명
               SKU_FLAG         --> 단품구분
               REP_PUMBUN_CD    --> 대표품번코드
               SKU_TYPE         --> 단품종류
               BIZ_TYPE         --> 거래형태
               TAX_FLAG         --> 과세구분
               CHAR_BUYER_CD    --> 바이어코드
               CHAR_BUYER_NAME  --> 바이어명
               CHAR_SM_CD       --> SM코드
               CHAR_SM_NAME     --> SM명
               VEN_CD           --> 협력사코드
               VEN_NAME         --> 협력사명
               STYLE_TYPE       --> 의류단품코드구분
               BUYER_EMP_NAME   --> 바이어사원명
*/
function strPbnToGridPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom012.cc?goTo=strPbnPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* strPbnMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 점별 품번 Popup(멀티선택)
* 사용방법 : strPbnMultiSelPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 조직코드
*            arguments[6] -> 협력사코드
*            arguments[7] -> 바이어코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 사용여부
*            arguments[10] -> 단품구분
*            arguments[11] -> 단품종류
*            arguments[12] -> 통합발주여부
*            arguments[13] -> 거래형태
*            arguments[14] -> 판매분매입구분
*            arguments[15] -> 의류단품코드구분
*            arguments[16] -> 층코드
*
* 실행  예) strPbnMultiSelPop( "CODE", "NAME" , 'N' );
*
* return값 : List  
*              map                         
               PUMBUN_CD        --> 품번코드
               PUMBUN_NAME      --> 품번명
               RECP_NAME        --> 영수증명
               SKU_FLAG         --> 단품구분
               REP_PUMBUN_CD    --> 대표품번코드
               SKU_TYPE         --> 단품종류
               BIZ_TYPE         --> 거래형태
               TAX_FLAG         --> 과세구분
               CHAR_BUYER_CD    --> 바이어코드
               CHAR_BUYER_NAME  --> 바이어명
               CHAR_SM_CD       --> SM코드
               CHAR_SM_NAME     --> SM명
               VEN_CD           --> 협력사코드
               VEN_NAME         --> 협력사명
               STYLE_TYPE       --> 의류단품코드구분
               BUYER_EMP_NAME   --> 바이어사원명
*/
function strPbnMultiSelPop( strCd, strNm, authGb )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom012.cc?goTo=strPbnPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setStrPbnNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 점별 품번 Popup(이름)
* 사용방법 : setStrPbnNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 조직코드
*            arguments[8] -> 협력사코드
*            arguments[9] -> 바이어코드
*            arguments[10] -> 품번유형
*            arguments[11] -> 사용여부
*            arguments[12] -> 단품구분
*            arguments[13] -> 단품종류
*            arguments[14] -> 통합발주여부
*            arguments[15] -> 거래형태
*            arguments[16] -> 판매분매입구분
*            arguments[17] -> 의류단품코드구분
*            arguments[18] -> 층코드
*
* 실행  예) setStrPbnNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , "N", 0);
*
* return값 : void
*/
function setStrPbnNmWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('PUMBUN_CD:STRING(6),PUMBUN_NM:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_NM") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom012.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMBUN_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "PUMBUN_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return strPbnPop( objCd, objNm, authGb);
			else
				return strPbnPop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setStrPbnNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 점별 품번 Popup(그리드)
* 사용방법 : setStrPbnNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 조직코드
*            arguments[8] -> 협력사코드
*            arguments[9] -> 바이어코드
*            arguments[10] -> 품번유형
*            arguments[11] -> 사용여부
*            arguments[12] -> 단품구분
*            arguments[13] -> 단품종류
*            arguments[14] -> 통합발주여부
*            arguments[15] -> 거래형태
*            arguments[16] -> 판매분매입구분
*            arguments[17] -> 의류단품코드구분
*            arguments[18] -> 층코드
*
* 실행  예) setStrPbnNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , "N", 0);
*
* return값 : map                         
               PUMBUN_CD        --> 품번코드
               PUMBUN_NAME      --> 품번명
               RECP_NAME        --> 영수증명
               SKU_FLAG         --> 단품구분
               REP_PUMBUN_CD    --> 대표품번코드
               SKU_TYPE         --> 단품종류
               BIZ_TYPE         --> 거래형태
               TAX_FLAG         --> 과세구분
               CHAR_BUYER_CD    --> 바이어코드
               CHAR_BUYER_NAME  --> 바이어명
               CHAR_SM_CD       --> SM코드
               CHAR_SM_NAME     --> SM명
               VEN_CD           --> 협력사코드
               VEN_NAME         --> 협력사명
               STYLE_TYPE       --> 의류단품코드구분
               BUYER_EMP_NAME   --> 바이어사원명
*/
function setStrPbnNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('PUMBUN_CD:STRING(6),PUMBUN_NM:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_NM") = strNm; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom012.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return strPbnToGridPop( strCd, strNm, authGb);
			else
				return strPbnToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}
/** 
* eventPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사 Popup
* 사용방법 : eventPop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 행사테마코드
*            arguments[4] -> 행사종류
*            arguments[5] -> 행사유형
*            arguments[6] -> 행사시작일
*            arguments[7] -> 행사종료일
*            arguments[8] -> 행사테마명
*            arguments[9] -> 적용기준일
*            arguments[10]-> 정상제외여부
*
* 실행  예) eventPop( EM_EVENT_CD, EM_EVENT_NM );
*
* return값 : map          
               EVENT_CD         --> 행사코드
               EVENT_NAME       --> 행사명
               EVENT_THME_CD    --> 행사테마코드
               EVENT_THME_NAME  --> 행사테마명
               EVENT_PLU_FLAG   --> 행사유형
*/
function eventPop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom013.cc?goTo=eventPop",
                                           arrArg,
                                           "dialogWidth:420px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("EVENT_CD");
		objNm.Text = map.get("EVENT_NAME");
		return map;
 	}
	
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
	return null;
}
/** 
* eventToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사 Popup(Grid)
* 사용방법 : eventToGridPop( strCd, strMn)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 행사테마코드
*            arguments[4] -> 행사종류
*            arguments[5] -> 행사유형
*            arguments[6] -> 행사시작일
*            arguments[7] -> 행사종료일
*            arguments[8] -> 행사테마명
*            arguments[9] -> 적용기준일
*            arguments[10]-> 정상제외여부
*
* 실행  예) eventToGridPop( "CODE", "NAME" );
*
* return값 : map          
               EVENT_CD         --> 행사코드
               EVENT_NAME       --> 행사명
               EVENT_THME_CD    --> 행사테마코드
               EVENT_THME_NAME  --> 행사테마명
               EVENT_PLU_FLAG   --> 행사유형
*/
function eventToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom013.cc?goTo=eventPop",
                                           arrArg,
                                           "dialogWidth:420px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}
/** 
* eventMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사 Popup(멀티선택)
* 사용방법 : eventMultiSelPop( strCd, strNm )
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 행사테마코드
*            arguments[4] -> 행사종류
*            arguments[5] -> 행사유형
*            arguments[6] -> 행사시작일
*            arguments[7] -> 행사종료일
*            arguments[8] -> 행사테마명
*            arguments[9] -> 적용기준일
*            arguments[10]-> 정상제외여부
*
* 실행  예) eventMultiSelPop( "CODE", "NAME" );
*
* return값 :  List
*              map          
               EVENT_CD         --> 행사코드
               EVENT_NAME       --> 행사명
               EVENT_THME_CD    --> 행사테마코드
               EVENT_THME_NAME  --> 행사테마명
               EVENT_PLU_FLAG   --> 행사유형
*/
function eventMultiSelPop( strCd, strNm )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom013.cc?goTo=eventPop",
                                           arrArg,
                                           "dialogWidth:420px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setEventNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사 Popup(이름)
* 사용방법 : setEventNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 행사테마코드
*            arguments[6] -> 행사종류
*            arguments[7] -> 행사유형
*            arguments[8] -> 행사시작일
*            arguments[9] -> 행사종료일
*            arguments[10] -> 행사테마명
*            arguments[11] -> 적용기준일
*            arguments[12] -> 정상제외여부
*
* 실행  예) setEventNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setEventNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('EVENT_CD:STRING(11),EVENT_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_NAME") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom013.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "EVENT_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "EVENT_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return eventPop( objCd, objNm);
			else
				return eventPop( objCd, objNm, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setEventNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사 Popup(그리드)
* 사용방법 : setEventNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 행사테마코드
*            arguments[6] -> 행사종류
*            arguments[7] -> 행사유형
*            arguments[8] -> 행사시작일
*            arguments[9] -> 행사종료일
*            arguments[10] -> 행사테마명
*            arguments[11] -> 적용기준일
*            arguments[12] -> 정상제외여부
*
* 실행  예) setEventNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 0);
*
* return값 : void
*/
function setEventNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('EVENT_CD:STRING(11),EVENT_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_NAME") = strNm; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom013.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return eventToGridPop( strCd, strNm);
			else
				return eventToGridPop( strCd, strNm, addCondition );
		}else{
	   	    return null;
		}
	}
}
/** 
* eventThmePop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사테마 Popup
* 사용방법 : eventThmePop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 사용여부
*            arguments[3] -> 테마레벨
*
* 실행  예) eventThmePop( EM_EVENT_THME_CD, EM_EVENT_THME_NM );
*
* return값 : map
*              EVENT_THME_CD    --> 행사테마코드
               EVENT_THME_NAME  --> 행사테마명
               EVENT_L_CD       --> 대분류
               EVENT_M_CD       --> 중분류
               EVENT_S_CD       --> 소분류
*/
function eventThmePop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom014.cc?goTo=eventThmePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("EVENT_THME_CD");
		objNm.Text = map.get("EVENT_THME_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* eventThmeToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사테마 Popup(Grid)
* 사용방법 : eventThmeToGridPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 사용여부
*            arguments[3] -> 테마레벨
*
* 실행  예) eventThmeToGridPop( "CODE", "NAME" );
*
* return값 : map
*              EVENT_THME_CD    --> 행사테마코드
               EVENT_THME_NAME  --> 행사테마명
               EVENT_L_CD       --> 대분류
               EVENT_M_CD       --> 중분류
               EVENT_S_CD       --> 소분류
*/
function eventThmeToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);
	
    var returnVal = window.showModalDialog("/pot/ccom014.cc?goTo=eventThmePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* eventThmeMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사테마 Popup(멀티선택)
* 사용방법 : eventThmeMultiSelPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 사용여부
*            arguments[3] -> 테마레벨
*
* 실행  예) eventThmeMultiSelPop( "CODE", "NAME" );
*
* return값 : List
*              map
*              EVENT_THME_CD    --> 행사테마코드
               EVENT_THME_NAME  --> 행사테마명
               EVENT_L_CD       --> 대분류
               EVENT_M_CD       --> 중분류
               EVENT_S_CD       --> 소분류
*/
function eventThmeMultiSelPop( strCd, strNm )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom014.cc?goTo=eventThmePop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}
/**
* setEventThmeNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사테마 Popup(이름)
* 사용방법 : setEventThmeNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 사용여부
*            arguments[5] -> 테마레벨
*
* 실행  예) setEventThmeNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setEventThmeNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('EVENT_THME_CD:STRING(4),EVENT_THME_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_THME_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_THME_NAME") = codeName; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom014.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "EVENT_THME_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "EVENT_THME_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return eventThmePop( objCd, objNm);
			else
				return eventThmePop( objCd, objNm, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setEventThmeNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 행사테마 ToGridPopup(그리드)
* 사용방법 : setEventThmeNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 사용여부
*            arguments[5] -> 테마레벨
*
* 실행  예) setEventThmeNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 0);
*
* return값 : map
*              EVENT_THME_CD    --> 행사테마코드
               EVENT_THME_NAME  --> 행사테마명
               EVENT_L_CD       --> 대분류
               EVENT_M_CD       --> 중분류
               EVENT_S_CD       --> 소분류
*/
function setEventThmeNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('EVENT_THME_CD:STRING(4),EVENT_THME_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_THME_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "EVENT_THME_NAME") = strNm; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom014.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return eventThmeToGridPop( strCd, strNm);
			else
				return eventThmeToGridPop( strCd, strNm, addCondition );
		}else{
	   	    return null;
		}
	}
}
/** 
* repVenPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표협력사 Popup
* 사용방법 : repVenPop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 사용여부
*            arguments[4] -> 품번유형
*            arguments[5] -> 거래형태
*            arguments[6] -> 매출처/매입처구분
*            arguments[7] -> 거래구분
*
* 실행  예) repVenPop( EM_EVENT_THME_CD, EM_EVENT_THME_NM  );
*
* return값 :   
*              map            
               VEN_CD          --> 협력사코드
               VEN_NAME        --> 협력사명
               VEN_SHORT_NAME  --> 협력사약명
               COMP_NO         --> 사업자번호
               REP_VEN_CD      --> 대표협력사코드
*/
function repVenPop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );
	
	arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);


    var returnVal = window.showModalDialog("/pot/ccom015.cc?goTo=repVenPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("VEN_CD");
		objNm.Text = map.get("VEN_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
  	

	return null;
}

/** 
* repVenPop_pcod101()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표협력사 Popup
* 사용방법 : repVenPop( objCd, objNm, objValue1, ..., objValue15)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[3] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[4] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[5] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[6] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[7] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[8] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[9] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[10] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[11] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[12] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[13] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[14] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[15] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*
* 실행  예) repVenPop( EM_EVENT_THME_CD, EM_EVENT_THME_NM  );
*
* return값 :   
*              map            
               VEN_CD          --> 협력사코드
               VEN_NAME        --> 협력사명
               VEN_SHORT_NAME  --> 협력사약명
               COMP_NO         --> 사업자번호
               REP_VEN_CD      --> 대표협력사코드
               CORP_NO         --> 법인번호
			   COMP_NAME	   --> 상호명
			   BIZ_STAT        --> 대표자명
			   BIZ_CAT         --> 업태
			   REP_NAME        --> 종목
			   POST_NO         --> 우편번호
			   ADDR            --> 주소1
			   DTL_ADDR        --> 주소2
			   PHONE1_NO       --> 전화번호1
			   PHONE2_NO       --> 전화번호2
			   PHONE3_NO       --> 전화번호3
			   FAX1_NO         --> FAX번호1
			   FAX2_NO         --> FAX번호2
			   FAX3_NO         --> FAX번호3
               
*/
function repVenPop_pcod101( objCd, objNm
		               , objValue1
		               , objValue2
		               , objValue3
		               , objValue4
		               , objValue5
		               , objValue6
		               , objValue7
		               , objValue8
		               , objValue9
		               , objValue10
		               , objValue11
		               , objValue12
		               , objValue13
		               , objValue14
		               , objValue15 )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 17, arguments );
	
	arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);


    var returnVal = window.showModalDialog("/pot/ccom015.cc?goTo=repVenPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("VEN_CD");
		objNm.Text = map.get("VEN_NAME");
		objValue1.Text = map.get("COMP_NO");
		objValue2.Text = map.get("CORP_NO");
		objValue3.Text = map.get("COMP_NAME");
		objValue4.Text = map.get("REP_NAME");
		objValue5.Text = map.get("BIZ_STAT");
		objValue6.Text = map.get("BIZ_CAT");
		objValue7.Text = map.get("POST_NO");
		objValue8.Text = map.get("ADDR");
		objValue9.Text = map.get("DTL_ADDR");
		objValue10.Text = map.get("PHONE1_NO");
		objValue11.Text = map.get("PHONE2_NO");
		objValue12.Text = map.get("PHONE3_NO");
		objValue13.Text = map.get("FAX1_NO");
		objValue14.Text = map.get("FAX2_NO");
		objValue15.Text = map.get("FAX3_NO");
		
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  		objValue1.Text = "";
		objValue2.Text = "";
		objValue3.Text = "";
		objValue4.Text = "";
		objValue5.Text = "";
		objValue6.Text = "";
		objValue7.Text = "";
		objValue8.Text = "";
		objValue9.Text = "";
		objValue10.Text = "";
		objValue11.Text = "";
		objValue12.Text = "";
		objValue13.Text = "";
		objValue14.Text = "";
		objValue15.Text = "";
  	}
  	

	return null;
}

/**
* setRepVenNmWithoutPop_pcod101()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표협력사 Popup(이름)
* 사용방법 : setRepVenNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*           
*
* 실행  예) setRepVenNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setRepVenNmWithoutPop_pcod101( strDataSet, objCd, objNm
									        , objValue1
									        , objValue2
									        , objValue3
									        , objValue4
									        , objValue5
									        , objValue6
									        , objValue7
									        , objValue8
									        , objValue9
									        , objValue10
									        , objValue11
									        , objValue12
									        , objValue13
									        , objValue14
									        , objValue15, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 19, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('VEN_CD:STRING(6),VEN_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_NAME") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom015.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "VEN_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "VEN_NAME");
		objValue1.Text = dataSetId.NameValue(dataSetId.RowPosition, "COMP_NO");
		objValue2.Text = dataSetId.NameValue(dataSetId.RowPosition, "CORP_NO");
		objValue3.Text = dataSetId.NameValue(dataSetId.RowPosition, "COMP_NAME");
		objValue4.Text = dataSetId.NameValue(dataSetId.RowPosition, "REP_NAME");
		objValue5.Text = dataSetId.NameValue(dataSetId.RowPosition, "BIZ_STAT");
		objValue6.Text = dataSetId.NameValue(dataSetId.RowPosition, "BIZ_CAT");
		objValue7.Text = dataSetId.NameValue(dataSetId.RowPosition, "POST_NO");
		objValue8.Text = dataSetId.NameValue(dataSetId.RowPosition, "ADDR");
		objValue9.Text = dataSetId.NameValue(dataSetId.RowPosition, "DTL_ADDR");
		objValue10.Text = dataSetId.NameValue(dataSetId.RowPosition, "PHONE1_NO");
		objValue11.Text = dataSetId.NameValue(dataSetId.RowPosition, "PHONE2_NO");
		objValue12.Text = dataSetId.NameValue(dataSetId.RowPosition, "PHONE3_NO");
		objValue13.Text = dataSetId.NameValue(dataSetId.RowPosition, "FAX1_NO");
		objValue14.Text = dataSetId.NameValue(dataSetId.RowPosition, "FAX2_NO");
		objValue15.Text = dataSetId.NameValue(dataSetId.RowPosition, "FAX3_NO");
		
	}else{
		objNm.Text 		=	"";
		objValue1.Text 	=	"";  
		objValue2.Text 	=	"";  
		objValue3.Text 	=	"";  
		objValue4.Text 	=	"";  
		objValue5.Text 	=	"";  
		objValue6.Text 	=	"";  
		objValue7.Text 	=	"";  
		objValue8.Text 	=	"";  
		objValue9.Text 	=	"";  
		objValue10.Text =	""; 
		objValue11.Text =	""; 
		objValue12.Text =	""; 
		objValue13.Text =	""; 
		objValue14.Text =	""; 
		objValue15.Text =	"";
		if(searchTp == "1"){
			if(addCondition == "")
				return repVenPop_pcod101( objCd, objNm
						   , objValue1
			               , objValue2
			               , objValue3
			               , objValue4
			               , objValue5
			               , objValue6
			               , objValue7
			               , objValue8
			               , objValue9
			               , objValue10
			               , objValue11
			               , objValue12
			               , objValue13
			               , objValue14
			               , objValue15);
			else
				return repVenPop_pcod101( objCd, objNm
						   , objValue1
			               , objValue2
			               , objValue3
			               , objValue4
			               , objValue5
			               , objValue6
			               , objValue7
			               , objValue8
			               , objValue9
			               , objValue10
			               , objValue11
			               , objValue12
			               , objValue13
			               , objValue14
			               , objValue15, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.Text 		=	"";
			objValue1.Text 	=	"";  
			objValue2.Text 	=	"";  
			objValue3.Text 	=	"";  
			objValue4.Text 	=	"";  
			objValue5.Text 	=	"";  
			objValue6.Text 	=	"";  
			objValue7.Text 	=	"";  
			objValue8.Text 	=	"";  
			objValue9.Text 	=	"";  
			objValue10.Text =	""; 
			objValue11.Text =	""; 
			objValue12.Text =	""; 
			objValue13.Text =	""; 
			objValue14.Text =	""; 
			objValue15.Text =	"";
		}
	}
}

/** 
* repVenToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표협력사 Popup(Grid)
* 사용방법 : repVenToGridPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 사용여부
*            arguments[4] -> 품번유형
*            arguments[5] -> 거래형태
*            arguments[6] -> e매출처/매입처구분
*            arguments[7] -> 거래구분
*
* 실행  예) repVenToGridPop( "CODE", "NAME"  );
*
* return값 :   
*              map            
               VEN_CD          --> 협력사코드
               VEN_NAME        --> 협력사명
               VEN_SHORT_NAME  --> 협력사약명
               COMP_NO         --> 사업자번호
               REP_VEN_CD      --> 대표협력사코드
*/
function repVenToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );
	
	arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);
	
    var returnVal = window.showModalDialog("/pot/ccom015.cc?goTo=repVenPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* repVenMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표협력사 Popup(멀티선택)
* 사용방법 : repVenMultiSelPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 사용여부
*            arguments[4] -> 품번유형
*            arguments[5] -> 거래형태
*            arguments[6] -> e매출처/매입처구분
*            arguments[7] -> 거래구분
*
* 실행  예) repVenMultiSelPop( "CODE", "NAME"  );
*
* return값 : List  
*              map            
               VEN_CD          --> 협력사코드
               VEN_NAME        --> 협력사명
               VEN_SHORT_NAME  --> 협력사약명
               COMP_NO         --> 사업자번호
               REP_VEN_CD      --> 대표협력사코드
*/
function repVenMultiSelPop( strCd, strNm )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom015.cc?goTo=repVenPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setRepVenNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표협력사 Popup(이름)
* 사용방법 : setRepVenNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 사용여부
*            arguments[6] -> 품번유형
*            arguments[7] -> 거래형태
*            arguments[8] -> 매출처/매입처구분
*            arguments[9] -> 거래구분
*
* 실행  예) setRepVenNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setRepVenNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('VEN_CD:STRING(6),VEN_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_NAME") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom015.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "VEN_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "VEN_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return repVenPop( objCd, objNm);
			else
				return repVenPop( objCd, objNm, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setRepVenNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 대표협력사 Pop(그리드)
* 사용방법 : setRepVenNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 사용여부
*            arguments[6] -> 품번유형
*            arguments[7] -> 거래형태
*            arguments[8] -> 매출처/매입처구분
*            arguments[9] -> 거래구분
*
* 실행  예) setRepVenNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 0);
*
* return값 : map            
               VEN_CD          --> 협력사코드
               VEN_NAME        --> 협력사명
               VEN_SHORT_NAME  --> 협력사약명
               COMP_NO         --> 사업자번호
               REP_VEN_CD      --> 대표협력사코드
*/
function setRepVenNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('VEN_CD:STRING(6),VEN_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_NAME") = strNm; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom015.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return repVenToGridPop( strCd, strNm);
			else
				return repVenToGridPop( strCd, strNm, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* venPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 협력사 Popup
* 사용방법 : venPop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 사용여부
*            arguments[4] -> 품번유형
*            arguments[5] -> 거래형태
*            arguments[6] -> 매출처/매입처구분
*            arguments[7] -> 거래구분
*            arguments[8] -> 임대관리전용협력사호출("T")
*
* 실행  예) venPop( EM_VEN_CD, EM_VEN_NM );
*
* return값 : map                           
               VEN_CD         --> 협력사코드
               VEN_NAME       --> 협력사명
               VEN_SHORT_NAME --> 협력사약명
               COMP_NO        --> 사업자번호
               REP_VEN_CD     --> 대표협력사코드
               STR_CD         --> 점코드
               PAY_CYC        --> 지불주기
               PAY_WAY        --> 지불방법
               RUND_FLAG      --> 반올림구분
               PAY_HOLI_FLAG  --> 지불시기구분
*/
function venPop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);
	
    var returnVal = window.showModalDialog("/pot/ccom016.cc?goTo=venPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");     

	
	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("VEN_CD");
		objNm.Text = map.get("VEN_NAME");
		return map;
 	}
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* venToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 협력사 Popup(Grid)
* 사용방법 : venToGridPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 사용여부
*            arguments[4] -> 품번유형
*            arguments[5] -> 거래형태
*            arguments[6] -> 매출처/매입처구분
*            arguments[7] -> 거래구분
*            arguments[8] -> 임대관리전용협력사호출("T")
*
* 실행  예) venToGridPop( "CODE", "NAME" );
*
* return값 : map                           
               VEN_CD         --> 협력사코드
               VEN_NAME       --> 협력사명
               VEN_SHORT_NAME --> 협력사약명
               COMP_NO        --> 사업자번호
               REP_VEN_CD     --> 대표협력사코드
               STR_CD         --> 점코드
               PAY_CYC        --> 지불주기
               PAY_WAY        --> 지불방법
               RUND_FLAG      --> 반올림구분
               PAY_HOLI_FLAG  --> 지불시기구분
*/
function venToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom016.cc?goTo=venPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* venMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 협력사 Popup(멀티선택)
* 사용방법 : venMultiSelPop( strCd, strCdNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 사용여부
*            arguments[4] -> 품번유형
*            arguments[5] -> 거래형태
*            arguments[6] -> 매출처/매입처구분
*            arguments[7] -> 거래구분
*            arguments[8] -> 임대관리전용협력사호출("T")
*
* 실행  예) venMultiSelPop( "CODE", "NAME"  );
*
* return값 : List 
*              map                          
               VEN_CD         --> 협력사코드
               VEN_NAME       --> 협력사명
               VEN_SHORT_NAME --> 협력사약명
               COMP_NO        --> 사업자번호
               REP_VEN_CD     --> 대표협력사코드
               STR_CD         --> 점코드
               PAY_CYC        --> 지불주기
               PAY_WAY        --> 지불방법
               RUND_FLAG      --> 반올림구분
               PAY_HOLI_FLAG  --> 지불시기구분
*/
function venMultiSelPop( strCd, strNm )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom016.cc?goTo=venPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setVenNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 협력사 Popup(이름)
* 사용방법 : setVenNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 사용여부
*            arguments[6] -> 품번유형
*            arguments[7] -> 거래형태
*            arguments[8] -> 매출처/매입처구분
*            arguments[9] -> 거래구분
*            arguments[10] -> 임대관리전용협력사호출("T")
*
* 실행  예) setVenNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setVenNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('VEN_CD:STRING(6),VEN_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();	
	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_NAME") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom016.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "VEN_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "VEN_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return venPop( objCd, objNm);
			else
				return venPop( objCd, objNm, addCondition );
		}
	}
}

/**
* setVenNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 협력사 Popup(그리드)
* 사용방법 : setVenNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 사용여부
*            arguments[6] -> 품번유형
*            arguments[7] -> 거래형태
*            arguments[8] -> 매출처/매입처구분
*            arguments[9] -> 거래구분
*
* 실행  예) setVenNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME", 0);
*
* return값 : map                          
               VEN_CD         --> 협력사코드
               VEN_NAME       --> 협력사명
               VEN_SHORT_NAME --> 협력사약명
               COMP_NO        --> 사업자번호
               REP_VEN_CD     --> 대표협력사코드
               STR_CD         --> 점코드
               PAY_CYC        --> 지불주기
               PAY_WAY        --> 지불방법
               RUND_FLAG      --> 반올림구분
               PAY_HOLI_FLAG  --> 지불시기구분
*/
function setVenNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('VEN_CD:STRING(6),VEN_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_NAME") = strNm; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom016.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return venToGridPop( strCd, strNm);
			else
				return venToGridPop( strCd, strNm, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* fnbShopPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B매장조회 Popup
* 사용방법 : fnbShopPop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 협력사코드
*            arguments[4] -> 사용여부
*            arguments[5] -> 대표매장여부
*            arguments[6] -> F&B매장구분
*
* 실행  예) fnbShopPop( EM_FNB_SHOP_CD, EM_FNB_SHOP_NM );
*
* return값 : map           
               FNB_SHOP_CD   --> 매장코드
               FNB_SHOP_NAME --> 매장명
               VEN_CD        --> 협력사코드
*/
function fnbShopPop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom017.cc?goTo=fnbShopPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	 
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("FNB_SHOP_CD");
		objNm.Text = map.get("FNB_SHOP_NAME");
		return map;
 	}
  	
  	if( objNm.Text == "" ){
  		objCd.Text = "";
  	}
  	

	return null;
}

/** 
* fnbShopToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B매장조회 Popup(Grid)
* 사용방법 : fnbShopToGridPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 협력사코드
*            arguments[4] -> 사용여부
*            arguments[5] -> 대표매장여부
*            arguments[6] -> F&B매장구분
*
* 실행  예) fnbShopToGridPop( "CODE", "NAME" );
*
* return값 : map           
               FNB_SHOP_CD   --> 매장코드
               FNB_SHOP_NAME --> 매장명
               VEN_CD        --> 협력사코드
*/
function fnbShopToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom017.cc?goTo=fnbShopPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* fnbShopMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B매장조회 Popup(멀티선택)
* 사용방법 : fnbShopMultiSelPop( strCd, strCdNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 협력사코드
*            arguments[4] -> 사용여부
*            arguments[5] -> 대표매장여부
*            arguments[6] -> F&B매장구분
*
* 실행  예) fnbShopMultiSelPop( "CODE", "NAME"  );
*
* return값 :  List
*              map           
               FNB_SHOP_CD   --> 매장코드
               FNB_SHOP_NAME --> 매장명
               VEN_CD        --> 협력사코드
*/
function fnbShopMultiSelPop( strCd, strCdNm )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strCdNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom017.cc?goTo=fnbShopPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setFnbShopNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B매장조회 Popup(멀티선택)
* 사용방법 : setFnbShopNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 협력사코드
*            arguments[6] -> 사용여부
*            arguments[7] -> 대표매장여부
*            arguments[8] -> F&B매장구분
*
* 실행  예) setFnbShopNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setFnbShopNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('FNB_SHOP_CD:STRING(4),FNB_SHOP_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "FNB_SHOP_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "FNB_SHOP_NAME") = codeName; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom017.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "FNB_SHOP_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "FNB_SHOP_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return fnbShopPop( objCd, objNm);
			else
				return fnbShopPop( objCd, objNm, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setFnbShopNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B매장조회 Popup(그리드)
* 사용방법 : setFnbShopNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 협력사코드
*            arguments[6] -> 사용여부
*            arguments[7] -> 대표매장여부
*            arguments[8] -> F&B매장구분
*
* 실행  예) setFnbShopNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 0);
*
* return값 : map           
               FNB_SHOP_CD   --> 매장코드
               FNB_SHOP_NAME --> 매장명
               VEN_CD        --> 협력사코드
*/
function setFnbShopNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('FNB_SHOP_CD:STRING(4),FNB_SHOP_NAME:STRING(40),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "FNB_SHOP_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "FNB_SHOP_NAME") = strNm; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom017.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return fnbShopToGridPop( strCd, strNm);
			else
				return fnbShopToGridPop( strCd, strNm, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* fnbCornerPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B코너 Popup
* 사용방법 : fnbCornerPop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 매장코드
*            arguments[4] -> 사용여부
*            arguments[5] -> F&B매장구분
*
* 실행  예) fnbCornerPop( EM_MENU_FLAG_CD, EM_MENU_FLAG_NM );
*
* return값 : map         
               MENU_FLAG_CD   --> 코너코드
               MENU_FLAG_NAME --> 코너명
*/
function fnbCornerPop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom018.cc?goTo=fnbCornerPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("MENU_FLAG_CD");
		objNm.Text = map.get("MENU_FLAG_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
	return null;
}

/** 
* fnbCornerToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B코너 Popup(Grid)
* 사용방법 : fnbCornerToGridPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 매장코드
*            arguments[4] -> 사용여부
*            arguments[5] -> F&B매장구분
*
* 실행  예) fnbCornerToGridPop( "CODE", "NAME" );
*
* return값 : map         
               MENU_FLAG_CD   --> 코너코드
               MENU_FLAG_NAME --> 코너명
*/
function fnbCornerToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom018.cc?goTo=fnbCornerPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* fnbCornerMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B코너 Popup(멀티선택)
* 사용방법 : fnbCornerMultiSelPop( strCd, strCdNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            //--추가조건--
*            arguments[2] -> 점코드
*            arguments[3] -> 매장코드
*            arguments[4] -> 사용여부
*            arguments[5] -> F&B매장구분
*
* 실행  예) fnbCornerMultiSelPop( "CODE", "NAME"  );
*
* return값 : List  
*              map       
               MENU_FLAG_CD   --> 코너코드
               MENU_FLAG_NAME --> 코너명
*/
function fnbCornerMultiSelPop( strCd, strCdNm )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strCdNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom018.cc?goTo=fnbCornerPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setFnbCornerNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B코너 Popup(이름)
* 사용방법 : setFnbCornerNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 매장코드
*            arguments[6] -> 사용여부
*            arguments[7] -> F&B매장구분
*
* 실행  예) setFnbCornerNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setFnbCornerNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('MENU_FLAG_CD:STRING(2),MENU_FLAG_NAME:STRING(20),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MENU_FLAG_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MENU_FLAG_NAME") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom018.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "MENU_FLAG_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "MENU_FLAG_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return fnbCornerPop( objCd, objNm);
			else
				return fnbCornerPop( objCd, objNm, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setFnbCornerNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : F&B코너 Popup(이름)
* 사용방법 : setFnbCornerNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[4] -> 점코드
*            arguments[5] -> 매장코드
*            arguments[6] -> 사용여부
*            arguments[7] -> F&B매장구분
*
* 실행  예) setFnbCornerNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 0);
*
* return값 :  map         
               MENU_FLAG_CD   --> 코너코드
               MENU_FLAG_NAME --> 코너명
*/
function setFnbCornerNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('MENU_FLAG_CD:STRING(2),MENU_FLAG_NAME:STRING(20),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MENU_FLAG_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MENU_FLAG_NAME") = strNm; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom018.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return fnbCornerToGridPop( strCd, strNm);
			else
				return fnbCornerToGridPop( strCd, strNm, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* posNoPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : POS번호 Popup
* 사용방법 : posNoPop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 점코드
*            //--추가조건--
*            arguments[3] -> 층
*            arguments[4] -> POS구분
*            arguments[5] -> 사용여부
*
* 실행  예) posNoPop( EM_POS_NO, EM_POS_NM );
*
* return값 : map                     
               POS_NO   --> POS번호
               POS_NAME --> POS명
*/
function posNoPop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom019.cc?goTo=posNoPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("POS_NO");
		objNm.Text = map.get("POS_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  		objNm.Text = "";
  	}
  	
	return null;
}

/** 
* posNoToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : POS번호 Popup(Grid)
* 사용방법 : posNoToGridPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 점코드
*            //--추가조건--
*            arguments[3] -> 층
*            arguments[4] -> POS구분
*            arguments[5] -> 사용여부
*
* 실행  예) posNoToGridPop( "CODE", "NAME" );
*
* return값 : map                     
               POS_NO   --> POS번호
               POS_NAME --> POS명
*/
function posNoToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom019.cc?goTo=posNoPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* posNoMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : POS번호 Popup(멀티선택)
* 사용방법 : posNoMultiSelPop( strCd, strCdNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 Text
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 Text
*            arguments[2] -> 점코드
*            //--추가조건--
*            arguments[3] -> 층
*            arguments[4] -> POS구분
*            arguments[5] -> 사용여부
*
* 실행  예) posNoMultiSelPop( "CODE", "NAME"  );
*
* return값 : list 
*              map       
               POS_NO   --> POS번호
               POS_NAME --> POS명
*/
function posNoMultiSelPop( strCd, strNm )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom019.cc?goTo=posNoPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setPosNoNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : POS번호 Popup(이름)
* 사용방법 : setPosNoNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            arguments[4] -> 점코드
*            //--추가조건--
*            arguments[5] -> 층
*            arguments[6] -> POS구분
*            arguments[7] -> 사용여부
*
* 실행  예) setPosNoNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setPosNoNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('POS_NO:STRING(4),POS_NAME:STRING(20),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "POS_NO") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "POS_NAME") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom019.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "POS_NO");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "POS_NAME");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return posNoPop( objCd, objNm);
			else
				return posNoPop( objCd, objNm, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setPosNoNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : POS번호 Popup(이름)
* 사용방법 : setPosNoNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            arguments[4] -> 점코드
*            //--추가조건--
*            arguments[5] -> 층
*            arguments[6] -> POS구분
*            arguments[7] -> 사용여부
*
* 실행  예) setPosNoNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 0);
*
* return값 :  map                     
               POS_NO   --> POS번호
               POS_NAME --> POS명
*/
function setPosNoNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('POS_NO:STRING(4),POS_NAME:STRING(20),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "POS_NO") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "POS_NAME") = strNm; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom019.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return posNoToGridPop( strCd, strNm);
			else
				return posNoToGridPop( strCd, strNm, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* posMsgPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-17
* 개    요 : POS 영수증 메세지 Popup
* 사용방법 : posMsgPop( objCd, objNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 점코드
*            //--추가조건--
*            arguments[3] -> 메세지구분
*            arguments[4] -> 사용여부

*
* 실행  예) posMsgPop( EM_MSG_ID, EM_MSG_EXPL );
*
* return값 : map
*              MSG_FLAG  --> 메세지구분
*              MSG_ID    --> 메시지ID
*              MSG_EXPL  --> 메시지명
*/
function posMsgPop( objCd, objNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom020.cc?goTo=posMsgPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("MSG_ID");
		objNm.Text = map.get("MSG_EXPL");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  		objNm.Text = "";
  	}
	return null;
}

/** 
* posMsgToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-17
* 개    요 : POS 영수증 메세지 Popup(Grid)
* 사용방법 : posMsgToGridPop( strCd, strNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 점코드
*            //--추가조건--
*            arguments[3] -> 메세지구분
*            arguments[4] -> 사용여부

*
* 실행  예) posMsgToGridPop( "CODE", "NAME" );
*
* return값 : map
*              MSG_FLAG  --> 메세지구분
*              MSG_ID    --> 메시지ID
*              MSG_EXPL  --> 메시지명
*/
function posMsgToGridPop( strCd, strNm )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom020.cc?goTo=posMsgPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
	return null;
}

/** 
* posMsgMultiSelPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-17
* 개    요 : POS 영수증 메세지 Popup(멀티선택)
* 사용방법 : posMsgMultiSelPop( strCd, strCdNm)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 Text
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 Text
*            arguments[2] -> 점코드
*            //--추가조건--
*            arguments[3] -> 메세지구분
*            arguments[4] -> 사용여부

*
* 실행  예) posMsgMultiSelPop( "CODE", "NAME"  );
*
* return값 : List
*              map
*              MSG_FLAG  --> 메세지구분
*              MSG_ID    --> 메시지ID
*              MSG_EXPL  --> 메시지명
*/
function posMsgMultiSelPop( strCd, strCdNm )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 2, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strCdNm);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom020.cc?goTo=posMsgPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}

/**
* setPosMsgNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : POS 영수증 메세지 Popup(멀티선택)
* 사용방법 : setPosMsgNmWithoutPop( strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            arguments[4] -> 점코드
*            //--추가조건--
*            arguments[5] -> 메세지구분
*            arguments[6] -> 사용여부
*
* 실행  예) setPosMsgNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setPosMsgNmWithoutPop( strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('MSG_ID:STRING(4),MSG_EXPL:STRING(40), ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MSG_ID") = objCd.Text;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MSG_EXPL") = codeName;	    
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom020.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "MSG_ID");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "MSG_EXPL");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return posMsgPop( objCd, objNm);
			else
				return posMsgPop( objCd, objNm, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* setPosMsgNmWithoutToGridPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : POS 영수증 메세지 Popup(그리드)
* 사용방법 : setPosMsgNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            arguments[4] -> 점코드
*            //--추가조건--
*            arguments[5] -> 메세지구분
*            arguments[6] -> 사용여부
*
* 실행  예) setPosMsgNmWithoutToGridPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setPosMsgNmWithoutToGridPop( strDataSet, strCd, strNm, searchTp){
	
	var addCondition = setAddCondition( 4, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('MSG_ID:STRING(4),MSG_EXPL:STRING(40), ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MSG_ID") = strCd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MSG_EXPL") = strNm;	    
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom020.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return posMsgToGridPop( strCd, strNm);
			else
				return posMsgToGridPop( strCd, strNm, addCondition );
		}else{
	   	    return null;
		}
	}
}

/**
* getStrVenCode( strDataSet, venCd, authGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 점별 협력사에서 점 코드 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getStrVenCode( strDataSet, "venCd" , "N" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 협력사코드
*            arguments[2] -> 권한여부
*            arguments[3] -> 사원번호
* return값 : void
*/
function getStrVenCode(strDataSet, venCd, authGb) {

	var addCondition = setAddCondition( 3, arguments );
    DS_I_COMMON.setDataHeader('VEN_CD:STRING(6),AUTH_GB:STRING(1), ADD_CONDITION:STRING(200)');
    
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "VEN_CD")          = venCd;
	DS_I_COMMON.NameValue(1, "AUTH_GB")         = authGb ;
	DS_I_COMMON.NameValue(1, "ADD_CONDITION")   = addCondition ;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getStrVenCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
}
/**
* getStrPbnCode( strDataSet, venCd, authGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 점별 품번에서 점 코드 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getStrPbnCode( strDataSet, "pumbunCd" , "N" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 품번코드
*            arguments[2] -> 권한여부
*            arguments[3] -> 사원번호
* return값 : void
*/
function getStrPbnCode(strDataSet, pumbunCd, authGb) {

	var addCondition = setAddCondition( 3, arguments );
    DS_I_COMMON.setDataHeader('PUMBUN_CD:STRING(6),AUTH_GB:STRING(1), ADD_CONDITION:STRING(200)');
    
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "PUMBUN_CD")       = pumbunCd;
	DS_I_COMMON.NameValue(1, "AUTH_GB")         = authGb ;
	DS_I_COMMON.NameValue(1, "ADD_CONDITION")   = addCondition ;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getStrPbnCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
}
/**
 * getMainBuyer()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-03
 * 개    요 : 정 바이어를 조회한다.
 * return값 : void
**/ 
function getMainBuyer( strDataSet, strOrgCd, orgFlag){

	var goTo       = "searchMainBuyer" ;    
	var parameters = "&strOrgCd="+strOrgCd
	               +  "&orgFlag="+orgFlag;
	TR_MAIN.Action="/pot/ccom005.cc?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT="+strDataSet+")"; //조회는 O
	TR_MAIN.Post();
}


/**
 * getVenInfo()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-03
 * 개    요 : 협력사정보를 조회한다.
 * return값 : void
 *  ----- colId ------ --------- name --------- 
 *  VEN_CD              협력사코드            
 *  VEN_NAME            협력사명              
 *  VEN_SHORT_NAME      협력사약명            
 *  BUY_SALE_FLAG       매입매출구분          
 *  BIZ_TYPE            거래형태              
 *  BIZ_FLAG            거래구분              
 *  REP_VEN_CD          대표협력사코드        
 *  BUY_ACC_VEN_CD      매입거래선코드        
 *  SALE_ACC_VEN_CD     매출거래선코드        
 *  COMP_FLAG           사업자구분            
 *  ETAX_ISSUE_FLAG     전자세금계산서발행구분
 *  RVS_ISSUE_FLAG      역발행구분            
 *  OCOMP_TAX_ID        타사전자세금계산서ID  
 *  EDI_YN              EDI사용여부           
 *  COMP_NO             사업자번호            
 *  CORP_NO             법인번호              
 *  COMP_NAME           상호명                
 *  BIZ_STAT            업태                  
 *  BIZ_CAT             종목                  
 *  REP_NAME            대표자명              
 *  POST_NO             우편번호              
 *  POST_SEQ            우편순번              
 *  ADDR                주소                  
 *  DTL_ADDR            상세주소              
 *  PHONE1_NO           전화번호(지역)        
 *  PHONE2_NO           전화번호(국)          
 *  PHONE3_NO           전화번호(번호)        
 *  FAX1_NO             FAX번호(지역)         
 *  FAX2_NO             FAX번호(국)           
 *  FAX3_NO             FAX번호(번호)         
 *  BIZ_S_DT            거래시작일            
 *  BIZ_E_DT            거래종료일            
**/ 
function getVenInfo( strDataSet, strVenCd){

	var goTo       = "searchVenInfo" ;    
	var parameters = "&strVenCd="+strVenCd;
	TR_MAIN.Action="/pot/ccom016.cc?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT="+strDataSet+")"; //조회는 O
	TR_MAIN.Post();
}

/**
 * getPumbunInfo()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-14
 * 개    요 : 품번정보를 조회한다.
 * return값 : void
 *  ----- colId ------ --- name --- 
 *  PUMBUN_CD            품번코드
 *  PUMBUN_NAME          품번명
 *  RECP_NAME            영수증명
 *  VEN_CD               협력사코드
 *  VEN_NAME             협력사명
 *  BIZ_TYPE             거래형태
 *  BIZ_FLAG             거래구분
 *  REP_PUMBUN_CD        대표품번코드
 *  REP_PUMBUN_NAME      대표품번명
 *  TAX_FLAG             과세구분
 *  PUMBUN_FLAG          품번구분
 *  PUMBUN_TYPE          품번유형
 *  SKU_FLAG             단품구분
 *  SKU_TYPE             단품종류
 *  STYLE_TYPE           의류단품코드구분
 *  ITG_ORD_FLAG         통합발주여부
 *  BRAND_CD             브랜드코드
 *  APP_S_DT             적용시작일
 *  APP_E_DT             적용종료일
 *  USE_YN               사용여부
 *  BRAND_CD             브랜드코드
 *  BRAND_NM             브랜드명
**/ 
function getPumbunInfo( strDataSet, strPumbunCd){

	var goTo       = "searchPumbunInfo" ;    
	var parameters = "&strPumbunCd="+strPumbunCd;
	TR_MAIN.Action="/pot/ccom012.cc?goTo="+goTo+parameters;  
	TR_MAIN.KeyValue="SERVLET(O:DS_O_RESULT="+strDataSet+")"; //조회는 O
	TR_MAIN.Post();
}

/**
* getPmkLCode( strDataSet, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 대분류 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getPmkLCode( strDataSet, "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 전체여부
* return값 : void
*/
function getPmkLCode(strDataSet, allGb) {

    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getPmkLCode";
    TR_MAIN.KeyValue= "SERVLET(O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);
    
   	if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getPmkMCode( strDataSet, strLCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 중분류 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getPmkMCode( strDataSet, "L_CD" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 대분류코드
*            arguments[2] -> 전체여부
* return값 : void
*/
function getPmkMCode(strDataSet, strLCd, allGb) {

    DS_I_COMMON.setDataHeader('L_CD:STRING(2)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "L_CD")          = strLCd;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getPmkMCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);
   	if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getPmkSCode( strDataSet, strLCd, strMCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 소분류 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getPmkSCode( strDataSet, "L_CD"  , "M_CD" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 대분류코드
*            arguments[2] -> 중분류코드
*            arguments[3] -> 전체여부
* return값 : void
*/
function getPmkSCode(strDataSet, strLCd, strMCd, allGb) {

    DS_I_COMMON.setDataHeader('L_CD:STRING(2),M_CD:STRING(2)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "L_CD")          = strLCd;
	DS_I_COMMON.NameValue(1, "M_CD")          = strMCd;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getPmkSCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);   
   	if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}
/**
* getPmkDCode( strDataSet,  strLCd, strMCd, strSCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 세분류 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getPmkDCode( strDataSet, "L_CD" , "M_CD" , "S_CD" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 대분류코드
*            arguments[2] -> 중분류코드
*            arguments[2] -> 소분류코드
*            arguments[3] -> 전체여부
* return값 : void
*/
function getPmkDCode(strDataSet, strLCd, strMCd, strSCd, allGb) {

    DS_I_COMMON.setDataHeader('L_CD:STRING(2),M_CD:STRING(2),S_CD:STRING(2)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "L_CD")          = strLCd;
	DS_I_COMMON.NameValue(1, "M_CD")          = strMCd;
	DS_I_COMMON.NameValue(1, "S_CD")          = strSCd;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getPmkDCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);   
    if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getEvtThmeLCode( strDataSet, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 대분류 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getEvtThmeLCode( strDataSet, "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 전체여부
* return값 : void
*/
function getEvtThmeLCode(strDataSet, allGb) {

    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getEvtThmeLCode";
    TR_MAIN.KeyValue= "SERVLET(O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);
    
   	if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getEvtThmeMCode( strDataSet, strLCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 중분류 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getEvtThmeMCode( strDataSet, "L_CD" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 대분류코드
*            arguments[2] -> 전체여부
* return값 : void
*/
function getEvtThmeMCode(strDataSet, strLCd, allGb) {

    DS_I_COMMON.setDataHeader('L_CD:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "L_CD")          = strLCd;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getEvtThmeMCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);
   	if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getEvtThmeSCode( strDataSet, strLCd, strMCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 소분류 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getEvtThmeSCode( strDataSet, "L_CD"  , "M_CD" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 대분류코드
*            arguments[2] -> 중분류코드
*            arguments[3] -> 전체여부
* return값 : void
*/
function getEvtThmeSCode(strDataSet, strLCd, strMCd, allGb) {

    DS_I_COMMON.setDataHeader('L_CD:STRING(1),M_CD:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "L_CD")          = strLCd;
	DS_I_COMMON.NameValue(1, "M_CD")          = strMCd;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getEvtThmeSCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);   
   	if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}
/**
* getPbnPmkCode( strDataSet, strPumbunCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 세분류 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getPbnPmkCode( strDataSet, "strPumbunCd" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 품번코드
*            arguments[2] -> 전체여부
* return값 : void
*/
function getPbnPmkCode(strDataSet, strPumbunCd, allGb, useYn) {

    DS_I_COMMON.setDataHeader('PUMBUN_CD:STRING(6),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "PUMBUN_CD")       = strPumbunCd;
	DS_I_COMMON.NameValue(1, "USE_YN")          = useYn;
    TR_MAIN.Action	= "/pot/ccom010.cc?goTo=searchCombo";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COND=DS_I_COMMON,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);    
    if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getPbnPmkCode( strDataSet, strPumbunCd, allGb )
* 작 성 자 : DHL
* 작 성 일 : 2010-12-30
* 개    요 : 품목의 세분류 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getPbnPmkCode( strDataSet, "strPumbunCd" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 품번코드
*            arguments[2] -> 전체여부
* return값 : void
*/
function getPbnPmkSrtCode(strDataSet, strPumbunCd, allGb, useYn) {

    DS_I_COMMON.setDataHeader('PUMBUN_CD:STRING(6),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "PUMBUN_CD")       = strPumbunCd;
	DS_I_COMMON.NameValue(1, "USE_YN")          = useYn;
    TR_MAIN.Action	= "/pot/ccom222.cc?goTo=searchCombo";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COND=DS_I_COMMON,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);    
    if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getStyleBrand( strDataSet, strPumbunCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 스타일 마스터의 품번별 브랜드 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getStyleBrand( strDataSet, "strPumbunCd" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 품번코드
*            arguments[2] -> 전체여부
* return값 : void
*/
function getStyleBrand(strDataSet, strPumbunCd, allGb) {

    DS_I_COMMON.setDataHeader('PUMBUN_CD:STRING(6)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "PUMBUN_CD")          = strPumbunCd;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getStyleBrand";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);    
    if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}
/**
* getStyleSubBrand( strDataSet, strPumbunCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 스타일 마스터의 품번별 서브브랜드 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getStyleSubBrand( strDataSet, "strPumbunCd" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 품번코드
*            arguments[2] -> 전체여부
* return값 : void
*/
function getStyleSubBrand(strDataSet, strPumbunCd, allGb) {

    DS_I_COMMON.setDataHeader('PUMBUN_CD:STRING(6)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "PUMBUN_CD")          = strPumbunCd;
	
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getStyleSubBrand";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);    
    if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getEventPlaceCode( strDataSet, strPumbunCd, allGb )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : 행사장 콤보 세팅을 위한 dataSet을 가져오는 함수  
* 사용방법 : getEventPlaceCode( strDataSet, "strStrCd" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점코드
*            arguments[2] -> 전체여부
*            arguments[3] -> 사용여부
* return값 : void
*/
function getEventPlaceCode(strDataSet, strStrCd, allGb, strUseYn) {

    DS_I_COMMON.setDataHeader('STR_CD:STRING(2),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "STR_CD")          = strStrCd;
	DS_I_COMMON.NameValue(1, "USE_YN")          = strUseYn;
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getEventPlaceCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);    
    if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/**
* getFnBShopCornerCode( strDataSet, strCd, allGb, strUseYn )
* 작 성 자 : FKL
* 작 성 일 : 2010-12-30
* 개    요 : F&B매장중 코너매장 콤보 세팅을 위한 dataSet을 가져오는 함수
* 사용방법 : getEventPlaceCode( strDataSet, "strStrCd" , "Y" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점코드
*            arguments[2] -> 전체여부
*            arguments[3] -> 사용여부
* return값 : void
*/
function getFnBShopCornerCode(strDataSet, strStrCd, allGb, strUseYn) {

    DS_I_COMMON.setDataHeader('STR_CD:STRING(2),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "STR_CD")          = strStrCd;
	DS_I_COMMON.NameValue(1, "USE_YN")          = strUseYn;
    TR_MAIN.Action	= "/pot/ccom000.cc?goTo=getFnBShopCornerCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    var dataSet = eval(strDataSet);    
    if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/** 
* skuATypeMultiSelPordPop()
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-21
* 개    요 : 단품코드(의류단품A) Popup(멀티선택)
* 사용방법 : skuATypeMultiSelPordPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 스타일
*            arguments[7] -> 컬러
*            arguments[8] -> 사이즈
*            arguments[9] -> 품번유형
*            arguments[10] -> 거래형태
*            arguments[11] -> 사용여부
*            arguments[12] -> 매입일자
*            arguments[13] -> 협력사코드
*
* 실행  예) skuATypeMultiSelPordPop( EM_SKU_CD, EM_SKU_NM , 'N');
*
* return값 : List
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               STYLE_CD       --> 스타일
               COLOR_CD       --> 컬러
               SIZE_CD        --> 사이즈
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function skuATypeMultiSelPordPop( strCd, strNm, authGb ){
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom021.cc?goTo=skuATypePop",
                                           arrArg,
                                           "dialogWidth:658px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	
	return null;
}


/** 
* skuBTypeMultiSelPordPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품B) Popup(멀티선택)
* 사용방법 : skuBTypeMultiSelPordPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 관리항목1
*            arguments[7] -> 관리항목2
*            arguments[8] -> 관리항목3
*            arguments[9] -> 관리항목4
*            arguments[10] -> 관리항목5
*            arguments[11] -> 품번유형
*            arguments[12] -> 거래형태
*            arguments[13] -> 사용여부
*            arguments[14] -> 매입일자
*            arguments[15] -> 협력사코드
*
* 실행  예) skuBTypeMultiSelPordPop( EM_SKU_CD, EM_SKU_NM , 'N');
*
* return값 : List
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               MNG_CD1        --> 관리항목1
               MNG_CD2        --> 관리항목2
               MNG_CD3        --> 관리항목3
               MNG_CD4        --> 관리항목4
               MNG_CD5        --> 관리항목5
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function skuBTypeMultiSelPordPop( strCd, strNm, authGb ){
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom022.cc?goTo=skuBTypePop",
                                           arrArg,
                                           "dialogWidth:658px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	
	return null;
}


/**
* setskuATypeNmWithoutToGridPordPop()
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-23
* 개    요 :  단품코드(의류단품A) 이름(그리드)_발주매입
* 사용방법 : setskuATypeNmWithoutToGridPordPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 스타일
*            arguments[9] -> 컬러
*            arguments[10] -> 사이즈
*            arguments[11] -> 품번유형
*            arguments[12] -> 거래형태
*            arguments[13] -> 사용여부
*            arguments[14] -> 매입일자
*            arguments[15] -> 협력사코드
*
* 실행  예) setskuATypeNmWithoutToGridPordPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : 
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               STYLE_CD       --> 스타일
               COLOR_CD       --> 컬러
               SIZE_CD        --> 사이즈
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function setSkuATypeNmWithoutToGridPordPop( strDataSet, strCd, strNm, authGb, searchTp){
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
	
    TR_MAIN.Action="/pot/ccom021.cc?goTo=searchOnWithoutPop&searchTp="+searchTp;
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return skuATypeMultiSelPordPop( strCd, strNm, authGb );
			else
				return skuATypeMultiSelPordPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}

/**
* setSkuBTypeNmWithoutToGridPordPop()
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-23
* 개    요 :  단품코드(의류단품B) 이름(그리드)_발주매입
* 사용방법 : setSkuBTypeNmWithoutToGridPordPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 관리항목1
*            arguments[9] -> 관리항목2
*            arguments[10] -> 관리항목3
*            arguments[11] -> 관리항목4
*            arguments[12] -> 관리항목5
*            arguments[13] -> 품번유형
*            arguments[14] -> 거래형태
*            arguments[15] -> 사용여부
*            arguments[16] -> 매입일자
*            arguments[17] -> 협력사코드
*
* 실행  예) setSkuBTypeNmWithoutToGridPordPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : 
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               MNG_CD1        --> 관리항목1
               MNG_CD2        --> 관리항목2
               MNG_CD3        --> 관리항목3
               MNG_CD4        --> 관리항목4
               MNG_CD5        --> 관리항목5
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function setSkuBTypeNmWithoutToGridPordPop( strDataSet, strCd, strNm, authGb, searchTp){

	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom022.cc?goTo=searchOnWithoutPop&searchTp="+searchTp;
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return skuBTypeToGridPop( strCd, strNm, authGb );
			else
				return skuBTypeToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}

/**
* setStrSkuNmWithoutToGridPordPop()
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-24
* 개    요 :  단품코드(점별) 이름(그리드)
* 사용방법 : setStrSkuNmWithoutToGridPordPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 거래형태
*            arguments[10]-> 사용여부
*            arguments[11] -> 매입일자
*            arguments[12] -> 단품종류
*            arguments[13] -> 협력사코드
*
* 실행  예) setStrSkuNmWithoutToGridPordPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               GIFT_AMT_TYPE  --> 상품권금종
*/
function setStrSkuNmWithoutToGridPordPop( strDataSet, strCd, strNm, authGb, searchTp){
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);
	var strHeader = 'SKU_CD:STRING(13),SKU_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200),VEN_NAME:STRING(100),PUMBUN_NAME:STRING(100)';
	
	DS_I_CONDITION.setDataHeader(strHeader);
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = strNm;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "VEN_NAME") = ""; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_NAME") = ""; 

    TR_MAIN.Action="/pot/ccom004.cc?goTo=searchOnWithoutPordPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return strSkuToGridPop( strCd, strNm, authGb );
			else
				return strSkuToGridPop( strCd, strNm, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}

/** 
* skuATypeToGridPordPop()
* 작 성 자 : 김경은
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품A) Popup(Grid)
* 사용방법 : skuATypeToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 스타일
*            arguments[7] -> 컬러
*            arguments[8] -> 사이즈
*            arguments[9] -> 품번유형
*            arguments[10] -> 거래형태
*            arguments[11] -> 사용여부
*            arguments[12] -> 매입일자
*            arguments[13] -> 협력사코드
*
* 실행  예) skuATypeToGridPop( "CODE", "NAME" , 'N');
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               STYLE_CD       --> 스타일
               COLOR_CD       --> 컬러
               SIZE_CD        --> 사이즈
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
*/
function skuATypeToGridPordPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom024.cc?goTo=skuATypePop",
                                           arrArg,
                                           "dialogWidth:658px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
  	
	return null;
}

/** 
* skuBTypeToGridProdPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(의류단품B) Popup(Grid)
* 사용방법 : skuBTypeToGridPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 관리항목1
*            arguments[7] -> 관리항목2
*            arguments[8] -> 관리항목3
*            arguments[9] -> 관리항목4
*            arguments[10] -> 관리항목5
*            arguments[11] -> 품번유형
*            arguments[12] -> 거래형태
*            arguments[13] -> 사용여부
*            arguments[14] -> 매입일자
*            arguments[15] -> 협력사코드
*            arguments[16] -> 스타일코드
*            arguments[17] -> 칼라코드
*            arguments[18] -> 사이즈코드
*
* 실행  예) skuBTypeToGridProdPop( "CODE", "NAME" , 'N');
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               MNG_CD1        --> 관리항목1
               MNG_CD2        --> 관리항목2
               MNG_CD3        --> 관리항목3
               MNG_CD4        --> 관리항목4
               MNG_CD5        --> 관리항목5
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
*/
function skuBTypeToGridPordPop( strCd, strNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom025.cc?goTo=skuBTypePop",
                                           arrArg,
                                           "dialogWidth:658px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		var map = arrArg[0];
		return map;
 	}
  	
	return null;
}
/** 
* offerSheetPop()
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-24
* 개    요 : 
* 사용방법 : offerSheetPop( strCd )
*            arguments[0] -> 조직코드
*
* 실행  예) offerSheetPop( strCd);
*
* return값 :  List
*               json
*                  STR_CD              ==> 점코드              , OFFER_YM            ==> OFFER 년월         , OFFER_SEQ_NO        ==> OFFER 순번          , OFFER_DT            ==> OFFER일자            
*                  OFFER_SHEET_NO      ==> OFFER SHEET NO      , PUMBUN_CD           ==> 품번코드           , VEN_CD              ==> 협력사코드          , BUYER_CD            ==> 바이어코드           
*                  PRC_COND            ==> 가격조건            , SHIPPMENT_CD        ==> 운송방법           , CURRENCY_CD         ==> 화폐단위            , OFFER_TOT_QTY       ==> OFFER총수량          
*                  OFFER_TOT_AMT       ==> OFFER총금액         , PAYMENT_COND        ==> 결제조건           , PAYMENT_DTL_COND    ==> 결제조건세부사항    , SHIP_PORT           ==> 선적항               
*                  ARRI_PORT           ==> 도착항              , LC_DATE             ==> L/C일자            , LC_NO               ==> L/C NO              , LC_EFFECTIVE_DT     ==> L/C유효일            
*                  LC_OPEN_BANK        ==> L/C개설은행         , VENDOR_INFO         ==> VENDOR INFO        , IMPORT_COUNTRY      ==> 수입국가            , ATTN                ==> ATTN                 
*                  MESSRS              ==> MESSRS              , VALIDITY            ==> VALIDITY           , SHIPPMENT           ==> SHIPPMENT           , PACKING             ==> PACKING              
*                  INSURANCE           ==> INSURANCE           , PRICE               ==> PRICE              , ORGIN               ==> ORGIN               , INSPECTION          ==> INSPECTION           
*                  DELIVERY            ==> DELIVERY            , BL_NO               ==> B/L NO             , BL_DT               ==> B/L일자             , PAYMENT             ==> Payment              
*                  COMMODITY           ==> COMMODITY           , PACKING_CHARGE      ==> PACKING CHARGE     , NCV                 ==> N.C.V.              , SHIPPER             ==> SHIPPER              
*                  EXC_APP_DT          ==> 환율적용일          , EXC_RATE            ==> 환율               , CLOSE_FLAG          ==> 마감구분            , CLOSE_DT            ==> 마감일자             
*                  EXPNC_CLOSE_FLAG    ==> 제경비마감구분      , COST_CLOSE_FLAG     ==> 원가확정여부       , OFFER_DTL_SEQ_NO    ==> OFFER상세번호       , SKU_CD              ==> 단품코드             
*                  STYLE_CD            ==> 스타일              , COLOR_CD            ==> 칼라코드           , SIZE_CD             ==> 사이즈코드          , OFFER_QTY           ==> OFFER수량            
*                  OFFER_UNIT_AMT      ==> OFFER단가           , OFFER_AMT           ==> OFFER금액          , ORDER_YM            ==> ORDER 년월          , ORDER_SEQ_NO        ==> ORDER 순번           
*                  ORDER_SHEET_NO      ==> ORDER SHEET NO  
*                 
*/
function offerSheetPop( strCd)
{
    var rtnList  = new Array();
    var arrArg  = new Array();

    arrArg.push(rtnList);
	arrArg.push(strCd);

    var returnVal = window.showModalDialog("/pot/ccom023.cc?goTo=offerSheetPop",
                                           arrArg,
                                           "dialogWidth:545px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		return arrArg[0];
 	}
	return null;
}



/** 
* buyerPop()
* 작 성 자 : 김경은
* 작 성 일 : 2010-05-17
* 개    요 : 바이어(SM)코드 Popup 
* 사용방법 : buyerCharNamePop( objCd, objNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 조직구분
*            arguments[5] -> 조직코드
*            arguments[6] -> 정부구분
*            arguments[7] -> 사용여부
*            arguments[8] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) buyerCharNamePop( EM_BUYER_CD, EM_BUYER_NM , 'N');
*
* return값 : map
              BUYER_CD    --> 바이어코드
              BUYER_NAME  --> 바이어명
              MAIN_FLAG   --> 정부구분
*/
function buyerCharNamePop( objCd, objNm, authGb )
{
    var rtnMap  = new Map();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 3, arguments );

    arrArg.push(rtnMap);
	arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	arrArg.push(authGb);
	arrArg.push("S");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom026.cc?goTo=buyerPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:395px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

	
  	if (returnVal){
		var map = arrArg[0];
		objCd.Text = map.get("BUYER_CD");
		objNm.Text = map.get("BUYER_CHAR_NAME");
		return map;
 	}
  	if( objNm.Text == ""  ){
  		objCd.Text = "";
  	}
  	
  	
	return null;
}

/**
* setBuyerCharNameWithoutPop()
* 작 성 자 : 김경은
* 작 성 일 : 2010-05-17
* 개    요 : 바이어(SM)코드 이름
* 사용방법 : setBuyerCharNameWithoutPop( strDataSet, objCd, objNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 조직구분
*            arguments[7] -> 조직코드
*            arguments[8] -> 정부구분
*            arguments[9] -> 사용여부
*            arguments[10] -> 바이어구분(BUYER_FLAG)
*
* 실행  예) setBuyerCharNameWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 'N', 0);
*
* return값 : void
*/
function setBuyerCharNameWithoutPop( strDataSet, objCd, objNm, authGb, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}
	
	var addCondition = setAddCondition( 5, arguments );
	var dataSetId = eval(strDataSet);

	DS_I_CONDITION.setDataHeader  ('BUYER_CD:STRING(6),BUYER_NAME:STRING(40),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BUYER_NAME") = codeName;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

	TR_MAIN.Action="/pot/ccom026.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "BUYER_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "BUYER_CHAR_NAME");
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			if(addCondition == "")
				return buyerCharNamePop( objCd, objNm, authGb );
			else
				return buyerCharNamePop( objCd, objNm, authGb, addCondition );
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
 * getCcompPop()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-25
 * 개    요 : 카드발급사 찾기 팝업
 * 사용방법 : getCcompPop(objCd, objNm)
 *            arguments[0] -> 팝업 그리드 더블클릭시 기부등록코드를 받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 기부등록명을 받아올 EMEDIT ID
 * return값 : array
 */
function getCcompPop(objCd, objNm) {
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
    arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom027.cc?goTo=ccompPop",
                                           arrArg,
                                           "dialogWidth:404px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
        var map = arrArg[0];
        objCd.Text = map.get("CODE");
        objNm.Text = map.get("NAME");
    } else {
        if(objNm.Text == "") {
            objCd.Text = "";
            objNm.Text = "";     
            objCd.focus();
        }
    }  
}

/**
 * getCcompPop()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-05-25
 * 개    요 : 카드발급사 찾기 팝업
 * 사용방법 : getCcompPop(objCd, objNm)
 *            arguments[0] -> 팝업 그리드 더블클릭시 기부등록코드를 받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 기부등록명을 받아올 EMEDIT ID
 * return값 : array
 */
function getCcompPop2(objCd, objNm, objNo) {
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
    arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom030.cc?goTo=ccompPop",
                                           arrArg,
                                           "dialogWidth:404px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
        var map = arrArg[0];
        objCd.Text = map.get("CODE");
        objNm.Text = map.get("NAME");
        objNo.Text = map.get("BIN_NO");
    } else {
        if(objNm.Text == "") {
            objCd.Text = "";
            objNm.Text = "";
            objNo.Text = "";
            objCd.focus();
        }
    }  
} 

/**
 * getVrtnPop()
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-06-01
 * 개    요 : VAN사 반송코드 찾기 팝업
 * 사용방법 : getVrtnPop(objCd, objNm)
 *            arguments[0] -> 팝업 그리드 더블클릭시 기부등록코드를 받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 기부등록명을 받아올 EMEDIT ID
 * return값 : array
 */
function getVrtnPop(objCd, objNm) {
    var rtnMap  = new Map();
    var arrArg  = new Array();
 
    arrArg.push(rtnMap);
    arrArg.push(objCd.Text);

    var returnVal = window.showModalDialog("/pot/ccom028.cc?goTo=vrtnPop",
                                           arrArg,
                                           "dialogWidth:404px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    if (returnVal){
        var map = arrArg[0];
        objCd.Text = map.get("CODE");
        objNm.Text = map.get("NAME");
    } else {
        if(objNm.Text == "") {
            objCd.Text = "";
            objNm.Text = "";     
            objCd.focus();
        }
    }  
}  

/**
 * getBrandPop()
 * 작 성 자 : FKSS
 * 작 성 일 : 2010-07-13
 * 개    요 : 브랜드 조회 팝업
 * 사용방법 : getVrtnPop(objCd, objNm)
 *            arguments[0] -> 팝업 그리드 더블클릭시 브랜드코드를 받아올 EMEDIT ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 브랜드명을 받아올 EMEDIT ID
 * return값 : array
 */
function getBrandPop(objCd, objNm) {
    var rtnMap  = new Map();
    var arrArg  = new Array();
 
    arrArg.push(rtnMap);
    arrArg.push(objCd.Text);
	if( !objNm.Enable || objNm.ReadOnly ){
		arrArg.push('');
	}else{
		arrArg.push(objNm.Text);
	}
	
	
	var returnVal = window.showModalDialog("/pot/ccom000.cc?goTo=brandPop",
                                           arrArg,
                                           "dialogWidth:404px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
    if (returnVal){
        var map = arrArg[0];
        objCd.Text = map.get("BRAND_CD");
        objNm.Text = map.get("BRAND_NM");
        
        
    } else {
        if(objNm.Text == "") {
            objCd.Text = "";
            objNm.Text = "";     
            objCd.focus();
        }
    }  
}  

/**
* setStrBrdNmWithoutPop()
* 작 성 자 : FKL
* 작 성 일 : 2010-07-13
* 개    요 : 브랜드명 조회
* 사용방법 : setStrBrdNmWithoutPop(strDataSet, objCd, objNm, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*
* 실행  예) setStrBrdNmWithoutPop("DS_O_RESULT", EM_CODE, EM_NAME , 0);
*
* return값 : void
*/
function setStrBrdNmWithoutPop(strDataSet, objCd, objNm, searchTp){
	if(trim(objCd.Text) == "" && trim(objNm.Text) == ""){
		return;
	}

	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('BRAND_CD:STRING(5),BRAND_NM:STRING(40)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	var codeName = '';	
	if( objNm.Enable && !objNm.ReadOnly ){		
		//codeName = objNm.Text;   //명으로 조회는 없음 2010.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BRAND_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BRAND_NM") = codeName; 

	TR_MAIN.Action="/pot/ccom000.cc?goTo=searchOnBrandWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
    
    if (dataSetId.countRow == 1) {
		objCd.text = dataSetId.NameValue(dataSetId.RowPosition, "BRAND_CD");
		objNm.text = dataSetId.NameValue(dataSetId.RowPosition, "BRAND_NM");		
	}else{
  		objNm.Text = "";
		if(searchTp == "1"){
			return getBrandPop( objCd, objNm);
		}else{
			if(trim(objCd.Text) != "" )
				objNm.text = "";
		}
	}
}

/**
* getBrchCode(strDataSet, bcompCd, authGb)
* 작 성 자 : FKL
* 작 성 일 : 2010-07-25
* 개    요 : 매입사별 가맹점번호 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getBrchCode( strDataSet, "bcompCd" , "N" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 매입사코드
*            arguments[2] -> 전체사용여부
* return값 : void
*/
function getJbrchCode(strDataSet, bcompCd, allGb) {

	var addCondition = setAddCondition( 3, arguments );
    DS_I_COMMON.setDataHeader('BCOMP_CD:STRING(2)');
    
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(1, "BCOMP_CD")          = bcompCd;
	
    TR_MAIN.Action	= "/pot/ccom029.cc?goTo=getBrchCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    var dataSet = eval(strDataSet);   
   	if(allGb == "Y"){
        dataSet.InsertRow(1);
        dataSet.NameValue(1, "CODE") = "%";
        dataSet.NameValue(1, "NAME") = "전체";
    }
}

/** 
* strSkuMultiSelPop_Pcod()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 : 단품코드(점별) Popup(멀티선택)
* 사용방법 : strSkuMultiSelPop( strCd, strNm, authGb)
*            arguments[0] -> 팝업 그리드 더블클릭시 코드를  받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 명을  받아올 EMEDIT ID
*            arguments[2] -> 권한여부
*            //--추가조건--
*            arguments[3] -> 사원번호
*            arguments[4] -> 점코드
*            arguments[5] -> 품번코드
*            arguments[6] -> 품번유형
*            arguments[7] -> 거래형태
*            arguments[8] -> 사용여부
*            arguments[9] -> 매입일자
*            arguments[10] -> 단품종류
*            arguments[11] -> 협력사코드
*            arguments[12] -> 스타일코드
*            arguments[13] -> 칼라코드
*            arguments[14] -> 사이즈코드
*            arguments[15] -> 소스마킹코드테이블 포함여부
*            arguments[16] -> 단품협력사코드
*
* 실행  예) strSkuMultiSelPop( "CODE", "NAME" , 'N');
*
* return값 : list
*             map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               GIFT_AMT_TYPE  --> 상품권금종
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
               SKU_TYPE       --> 단품종류
*/
function strSkuMultiSelPop_Pcod( strCd, strNm, strLcd, strMcd, strScd, authGb )
{
    var rtnList  = new Array();
    var arrArg  = new Array();
	var addCondition = setAddCondition( 6, arguments );

    arrArg.push(rtnList);
	arrArg.push(strCd);
	arrArg.push(strNm);
	arrArg.push(strLcd);
	arrArg.push(strMcd);
	arrArg.push(strScd);
	arrArg.push(authGb);
	arrArg.push("M");
	arrArg.push(addCondition);

    var returnVal = window.showModalDialog("/pot/ccom915.cc?goTo=strSkuPop",
                                           arrArg,
                                           "dialogWidth:358px;dialogHeight:420px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	
	return null;
}

/**
* setStrSkuNmWithoutToGridPop_Pcod()
* 작 성 자 : FKL
* 작 성 일 : 2010-02-16
* 개    요 :  단품코드(점별) 이름(그리드)
* 사용방법 : setStrSkuNmWithoutToGridPop( strDataSet, strCd, strNm, authGb, searchTp)
*            arguments[0] -> 데이터셋
*            arguments[1] -> 코드
*            arguments[2] -> 명
*            arguments[3] -> 권한여부
*            arguments[4] -> 검색할 타입 (코드가 존재하지 않을경우 - 1:팝업을 띄운다, 0:무시)
*            //--추가조건--
*            arguments[5] -> 사원번호
*            arguments[6] -> 점코드
*            arguments[7] -> 품번코드
*            arguments[8] -> 품번유형
*            arguments[9] -> 거래형태
*            arguments[10]-> 사용여부
*            arguments[11] -> 매입일자
*            arguments[12] -> 단품종류
*            arguments[13] -> 협력사코드
*            arguments[14] -> 스타일코드
*            arguments[15] -> 칼라코드
*            arguments[16] -> 사이즈코드
*            arguments[17] -> 소스마킹코드테이블 포함여부
*            arguments[18] -> 단품협력사코드
*
* 실행  예) setStrSkuNmWithoutToGridPop("DS_O_RESULT", "CODE", "NAME" , 'N', 0);
*
* return값 : map
               SKU_CD         --> 단품코드
               SKU_NAME       --> 단품명
               RECP_NAME      --> 영수증명
               PUMBUN_CD      --> 품번코드
               PUMBUN_NAME    --> 품번명
               PUMMOK_CD      --> 품목코드
               SALE_UNIT_CD   --> 판매단위
               CMP_SPEC_CD    --> 구성규격
               CMP_SPEC_UNIT  --> 구성규격단위
               GIFT_AMT_TYPE  --> 상품권금종
               STYLE_CD       --> 스타일코드
               COLOR_CD       --> 칼라코드
               SIZE_CD        --> 사이즈코드
               SKU_TYPE       --> 단품종류
*/
function setStrSkuNmWithoutToGridPop_Pcod( strDataSet, strCd, strNm, strLcd, strMcd, strScd, authGb, searchTp){
										
	var addCondition = setAddCondition( 8, arguments );
	var dataSetId = eval(strDataSet);
	
	DS_I_CONDITION.setDataHeader  ('SKU_CD:STRING(13),SKU_NAME:STRING(40),L_CD:STRING(2),M_CD:STRING(2),S_CD:STRING(2),AUTH_GB:STRING(1),ADD_CONDITION:STRING(200)');
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();

	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_CD") = strCd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SKU_NAME") = strNm;
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "L_CD") = strLcd; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "M_CD") = strMcd;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "S_CD") = strScd;
	
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom915.cc?goTo=searchOnWithoutPop";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post();  

	if (dataSetId.countRow == 1) {
    	var rtnMap  = new Map();
   	    for(var i=1;i<=dataSetId.CountColumn;i++)
        {
   		 rtnMap.put(dataSetId.ColumnID(i), dataSetId.NameValue(1, dataSetId.ColumnID(i)));
        }
   	    return rtnMap;
	}else{
		if(searchTp == "1"){
			if(addCondition == "")
				return strSkuMultiSelPop_Pcod( strCd, strNm, strLcd, strMcd, strScd, authGb );
			else
				return strSkuMultiSelPop_Pcod( strCd, strNm, strLcd, strMcd, strScd, authGb, addCondition );
		}else{
	   	    return null;
		}
	}
}

/**
* gfnCallByPopUpPosNo(strDataSet, OBJPARAMS)
* 작 성 자 : 박래형
* 작 성 일 : 2016-10-25
* 개    요 : 매입사별 가맹점번호 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : gfnCallByPopUpPosNo(strDataSet, OBJPARAMS)
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> OBJPARAMS{} -> PID           : 화면 ID
*                                           SQL_GB        : SQL 구분
*                                           MULTI         : 멀티구분(M, S)
*                                           EVTFLAG       : 이벤트구분(EVT, POP)
*                                           PARAMS.STR_CD : PARAMS(SQL에 쓰일 변수값들)
*                                           PARAMS.POS_NO : PARAMS(SQL에 쓰일 변수값들)
* return값 : arrList
*/
function gfnCallByPopUpPosNo(strDataSet, OBJPARAMS){
 
	// 리턴 할 arrList
	var arrList = new Array();
	var rtnList = new Array();
	
	// 리턴받을 데이터셋 초기화
	var objDataSet = eval(strDataSet);
	var strDataHd  = "";
	objDataSet.ClearData();
	
	// 조회조건으로 쓰일 데이터셋 초기화 및 세팅
	strDataHd  = "STR_CD:STRING(2),POS_NO:STRING(40),PID:STRING(7),SQL_GB:STRING(100)";
	DS_I_CONDITION.setDataHeader(strDataHd);
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	
	var nRow = DS_I_CONDITION.RowPosition;
	DS_I_CONDITION.NameValue(nRow, "PID")    = OBJPARAMS.PID    != "undefined" ? OBJPARAMS.PID    : "";
	DS_I_CONDITION.NameValue(nRow, "SQL_GB") = OBJPARAMS.SQL_GB != "undefined" ? OBJPARAMS.SQL_GB : "";
	DS_I_CONDITION.NameValue(nRow, "STR_CD") = OBJPARAMS.PARAMS.STR_CD != "undefined" ? OBJPARAMS.PARAMS.STR_CD : "";
	DS_I_CONDITION.NameValue(nRow, "POS_NO") = OBJPARAMS.PARAMS.POS_NO != "undefined" ? OBJPARAMS.PARAMS.POS_NO : "";

	// 단건 체크 후 리턴 시작
	if(OBJPARAMS.EVTFLAG == "EVT"){
		var strGoTo      = "searchPosNo";
	    TR_MAIN.Action   = "/pot/ccom999.cc?goTo=" + strGoTo;
	    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
	    TR_MAIN.Post();
	    
	    // 단건일 경우 Map에 데이터 세팅
	    if(objDataSet.CountRow == 1){
	        var nRow = 1;
	        var nCnt = 0;
	        for (nRow=1; nRow<=objDataSet.CountRow; nRow++) {
	        	arrList = new Array();
	        	arrList["STR_CD"]    = objDataSet.NameValue(nRow, "STR_CD");
	        	arrList["POS_NO"]    = objDataSet.NameValue(nRow, "POS_NO");
	        	arrList["SHOP_NAME"] = objDataSet.NameValue(nRow, "SHOP_NAME");
	        	arrList["POS_NAME"]  = objDataSet.NameValue(nRow, "POS_NAME");
	        	arrList["POS_FLAG"]  = objDataSet.NameValue(nRow, "POS_FLAG");
	        	arrList["FLOR_CD"]   = objDataSet.NameValue(nRow, "FLOR_CD");
	        	arrList["HALL_CD"]   = objDataSet.NameValue(nRow, "HALL_CD");
	        	rtnList[nCnt++] = arrList;
	        }
	    	return rtnList;
	    }
	}
	// 단건 체크 후 리턴 종료

	// POPUP 호출 시작
    arrList.push(OBJPARAMS.PID);		// 호출한 프로그램 ID
    arrList.push(OBJPARAMS.SQL_GB);		// SQL_GB
    arrList.push(OBJPARAMS.MULTI);		// 멀티구분(M, S)
    arrList.push(OBJPARAMS.PARAMS);		// SQL에 사용될 변수

	var strGoTo = "popUpPosNo";
	var strOpt  = "dialogWidth:480px; dialogHeight:500px; scroll:no; resizable:no; help:no; unadorned:yes; center:yes;status:no";
	rtnList     = window.showModalDialog( "/pot/ccom999.cc?goTo=" + strGoTo
    		                            , arrList
                                        , strOpt
                                        );

    if(rtnList == undefined || rtnList.length <= 0) rtnList = new Array();	// 선택된 데이터 없으면 리스트 초기화로 리턴
	// POPUP 호출 종료
	
	return rtnList;
}

/**
* gfnCallByPopUpPumbunCd(strDataSet, OBJPARAMS)
* 작 성 자 : 박래형
* 작 성 일 : 2016-11-02
* 개    요 : 점별 품번 가져오는 함수 
* 사용방법 : gfnCallByPopUpPumbunCd(strDataSet, OBJPARAMS)
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> OBJPARAMS{} -> PID           : 화면 ID
*                                           SQL_GB        : SQL 구분
*                                           MULTI         : 멀티구분(M, S)
*                                           EVTFLAG       : 이벤트구분(EVT, POP)
*                                           PARAMS.STR_CD : PARAMS(SQL에 쓰일 변수값들)
*                                           PARAMS.POS_NO : PARAMS(SQL에 쓰일 변수값들)
* return값 : arrList
*/
function gfnCallByPopUpPumbunCd(strDataSet, OBJPARAMS){
 
	// 리턴 할 arrList
	var arrList = new Array();
	var rtnList = new Array();
	
	// 리턴받을 데이터셋 초기화
	var objDataSet = eval(strDataSet);
	var strDataHd  = "";
	objDataSet.ClearData();
	
	// 조회조건으로 쓰일 데이터셋 초기화 및 세팅
	strDataHd  = "STR_CD:STRING(2),PUMBUN_CD:STRING(40),PUMBUN_NAME:STRING(100),PID:STRING(7),SQL_GB:STRING(100)";
	strDataHd += ",PUMBUN_TYPE:STRING(1),SKU_FLAG:STRING(1),BIZE_TYPE:STRING(100),SKU_TYPE:STRING(1)";
	DS_I_CONDITION.setDataHeader(strDataHd);
	DS_I_CONDITION.ClearData();
	DS_I_CONDITION.Addrow();
	
	var nRow = DS_I_CONDITION.RowPosition;
	DS_I_CONDITION.NameValue(nRow, "PID")         = OBJPARAMS.PID    != "undefined" ? OBJPARAMS.PID    : "";
	DS_I_CONDITION.NameValue(nRow, "SQL_GB")      = OBJPARAMS.SQL_GB != "undefined" ? OBJPARAMS.SQL_GB : "";
	DS_I_CONDITION.NameValue(nRow, "STR_CD")      = OBJPARAMS.PARAMS.STR_CD    != "undefined" ? OBJPARAMS.PARAMS.STR_CD    : "";
	DS_I_CONDITION.NameValue(nRow, "PUMBUN_CD")   = OBJPARAMS.PARAMS.PUMBUN_CD != "undefined" ? OBJPARAMS.PARAMS.PUMBUN_CD : "";
	DS_I_CONDITION.NameValue(nRow, "PUMBUN_NAME") = "";
	DS_I_CONDITION.NameValue(nRow, "PUMBUN_TYPE") = OBJPARAMS.PARAMS.PUMBUN_TYPE != "undefined" ? OBJPARAMS.PARAMS.PUMBUN_TYPE : "";
	DS_I_CONDITION.NameValue(nRow, "SKU_FLAG")    = OBJPARAMS.PARAMS.SKU_FLAG    != "undefined" ? OBJPARAMS.PARAMS.SKU_FLAG    : "";
	DS_I_CONDITION.NameValue(nRow, "BIZE_TYPE")   = OBJPARAMS.PARAMS.BIZE_TYPE   != "undefined" ? OBJPARAMS.PARAMS.BIZE_TYPE   : "";
	DS_I_CONDITION.NameValue(nRow, "SKU_TYPE")    = OBJPARAMS.PARAMS.SKU_TYPE    != "undefined" ? OBJPARAMS.PARAMS.SKU_TYPE    : "";

	// 단건 체크 후 리턴 시작
	if(OBJPARAMS.EVTFLAG == "EVT"){
		var strGoTo      = "searchPumbunCd";
	    TR_MAIN.Action   = "/pot/ccom999.cc?goTo=" + strGoTo;
	    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COND=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
	    TR_MAIN.Post();
	    
	    // 단건일 경우 Map에 데이터 세팅
	    if(objDataSet.CountRow == 1){
	        var nRow = 1;
	        var nCnt = 0;
	        for (nRow=1; nRow<=objDataSet.CountRow; nRow++) {
	        	arrList = new Array();
	        	arrList["STR_CD"]          = objDataSet.NameValue(nRow, "STR_CD");
	        	arrList["PUMBUN_CD"]       = objDataSet.NameValue(nRow, "PUMBUN_CD");
	        	arrList["PUMBUN_NAME"]     = objDataSet.NameValue(nRow, "PUMBUN_NAME");
	        	arrList["RECP_NAME"]       = objDataSet.NameValue(nRow, "RECP_NAME");
	        	arrList["SKU_FLAG"]        = objDataSet.NameValue(nRow, "SKU_FLAG");
	        	arrList["REP_PUMBUN_CD"]   = objDataSet.NameValue(nRow, "REP_PUMBUN_CD");
	        	arrList["SKU_TYPE"]        = objDataSet.NameValue(nRow, "SKU_TYPE");
	        	arrList["BIZ_TYPE"]        = objDataSet.NameValue(nRow, "BIZ_TYPE");
	        	arrList["TAX_FLAG"]        = objDataSet.NameValue(nRow, "TAX_FLAG");
	        	arrList["CHAR_BUYER_CD"]   = objDataSet.NameValue(nRow, "CHAR_BUYER_CD");
	        	arrList["CHAR_BUYER_NAME"] = objDataSet.NameValue(nRow, "CHAR_BUYER_NAME");
	        	arrList["CHAR_SM_CD"]      = objDataSet.NameValue(nRow, "CHAR_SM_CD");
	        	arrList["CHAR_SM_NAME"]    = objDataSet.NameValue(nRow, "CHAR_SM_NAME");
	        	arrList["VEN_CD"]          = objDataSet.NameValue(nRow, "VEN_CD");
	        	arrList["VEN_NAME"]        = objDataSet.NameValue(nRow, "VEN_NAME");
	        	arrList["STYLE_TYPE"]      = objDataSet.NameValue(nRow, "STYLE_TYPE");
	        	arrList["BUYER_EMP_NAME"]  = objDataSet.NameValue(nRow, "BUYER_EMP_NAME");
	        	arrList["BUY_ORG_CD"]      = objDataSet.NameValue(nRow, "BUY_ORG_CD");
	        	arrList["SALE_ORG_CD"]     = objDataSet.NameValue(nRow, "SALE_ORG_CD");
	        	arrList["BRAND_CD"]        = objDataSet.NameValue(nRow, "BRAND_CD");
	        	arrList["BRAND_NM"]        = objDataSet.NameValue(nRow, "BRAND_NM");
	        	arrList["PUMBUN_TYPE"]     = objDataSet.NameValue(nRow, "PUMBUN_TYPE");
	        	rtnList[nCnt++] = arrList;
	        }
	    	return rtnList;
	    }
	}
	// 단건 체크 후 리턴 종료

	// POPUP 호출 시작
    arrList.push(OBJPARAMS.PID);		// 호출한 프로그램 ID
    arrList.push(OBJPARAMS.SQL_GB);		// SQL_GB
    arrList.push(OBJPARAMS.MULTI);		// 멀티구분(M, S)
    arrList.push(OBJPARAMS.PARAMS);		// SQL에 사용될 변수

	var strGoTo = "popUpPumbunCd";
	var strOpt  = "dialogWidth:480px; dialogHeight:500px; scroll:no; resizable:no; help:no; unadorned:yes; center:yes;status:no";
	rtnList     = window.showModalDialog( "/pot/ccom999.cc?goTo=" + strGoTo
    		                            , arrList
                                        , strOpt
                                        );

    if(rtnList == undefined || rtnList.length <= 0) rtnList = new Array();	// 선택된 데이터 없으면 리스트 초기화로 리턴
	// POPUP 호출 종료
	
	return rtnList;
}
