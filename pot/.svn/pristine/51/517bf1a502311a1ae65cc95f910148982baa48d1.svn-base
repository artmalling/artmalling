/**
 * 시스템명 : 한국후지쯔 인사회계 팝업 스크립트
 * 작 성 일 : 2010-01-20
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 : potup_ham.js
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

getPopup()								
getEmpCd()							:사원정보를 조회하는 팝업 
showModal()							:팝업창
getJojik()                          :조직정보 팝업

						

☞-------------------non-POPOP  ---------------------------------
<<<<<<< popup_ham.js

=======
>>>>>>> 1.7

*/
/**
  * getPopup()
  * 작 성 자  : JAE
  * 작 성 일  : 2007-12-14
  * 개    요  : 공통팝업 
  * parameters : 
  * return :   object
**/

 var ie7  = navigator.appVersion.indexOf("MSIE 7.0")>=0 ? true : false;
function getPopup( type, param, param2, param3, param4, param5, param6 ){

    var retObj = new Object(); 

    if( type == "ACCTCD" ){                 // 계정코드 팝업
        // fieldNm?? atcom05 ???????? ??????
        // fieldValue ?????????? ??????
        retObj = showModal("/ham/apop001.ap?goTo=list&fieldNm="+param+"&fieldValue="+param2, retObj,"900","510");
    }
    else if( type == "CUSTCD" ){            // 관리세목(거래처) 코드 팝업
        retObj = showModal("/ham/apop002.ap?goTo=list&acctUt="+param, retObj,"610","530");
    }
    else if( type == "ARAPNO" ){            // 채권/채무 팝업
        retObj = showModal("/ham/apop003.ap?goTo=list&AcctUt="+param+"&AcctCd="+param2+"&CustType="+param3+"&CustCd="+param4, retObj,"610","570");
    }
    else if( type == "BILLNO" ){            // 지급어음 팝업
        retObj = showModal("/ham/apop004.ap?goTo=list&BookGbn="+param+"&DRCR="+param2+"&AcctUt="+param3, retObj,"610","570");
    }
    else if( type == "ASSCTCD" ){           // 자산코드 팝업
        retObj = showModal("/ham/apop005.ap?goTo=list", retObj,"610","550");
    }    
    else if( type == "FINCD" ){             // 재무제표 계정 팝업
        retObj = showModal("/ham/apop006.ap?goTo=list", retObj,"610","550");
    }
    else if( type == "DEPOSITCD" ){         // 계좌번호 팝업
        retObj = showModal("/ham/apop007.ap?goTo=list&ETC1="+param2+"&ACCTCD="+param3, retObj,"610","525");
    }
    else if( type == "DIVISIONID" ){        // 회계관리ID 팝업
        retObj = showModal("/ham/apop008.ap?goTo=list", retObj,"510","505");
    }
    else if( type == "ASSETGBN" ){          // 자산구분 코드 소분류만 팝업 
        retObj = showModal("/ham/apop009.ap?goTo=list&gubun=0", retObj,"610","525");
    }
    else if( type == "ALLASSETGBN" ){ 
    	// 자산구분 코드 대, 중, 소팝업
        retObj = showModal("/ham/apop009.ap?goTo=list&gubun=1", retObj,"610","525");
    }
    else if( type == "MNGFIELDCD" ){        // 관리세목(거래선) 코드 팝업
        retObj = showModal("/ham/apop010.ap?goTo=list&mngfieldCd="+param, retObj,"610","525");
    }
    else if( type == "JOJIC" ){             // 조직 코드 검색 팝업(레벨:3)
        retObj = showModal("/ham/apop011.ap?goTo=list&jumcd="+param+"&jklevl="+param2+"&lcode="+param5+"&prgflag="+param4+"&gubun="+param6, retObj,"610","525");
    }
    else if( type == "MNGFIELD" ){          // 관리세목(거래선) 코드 팝업
        retObj = showModal("/ham/apop012.ap?goTo=list", retObj,"610","550");
    }
    else if( type == "MNGDETLCD" ){         // 관리세목 코드 팝업
        retObj = showModal("/ham/apop013.ap?goTo=list&mngfieldCd="+param, retObj,"610","550");
    }
    else if( type == "COMMON" ){            // 공통코드 팝업
        retObj = showModal("/ham/apop014.ap?goTo=list&COMM_PART="+param, retObj,"610","525");
    }
    else if( type == "DIVISIONCD" ){        // 공제코드 팝업
        retObj = showModal("/ham/apop015.ap?goTo=list&DIVISIONID="+param, retObj,"610","525");
    }
    else if( type == "EVDTYPE" ){           // 회계구분코드 팝업
        //retObj = showModal("/ham/apop016.ap?goTo=list", retObj,"610","525");
        retObj = showModal("/ham/apop016.ap?goTo=list", retObj,"610","525");
    }
    else if( type == "ASSETACCTCD" ){       // 자산계정코드 팝업
        retObj = showModal("/ham/apop017.ap?goTo=list", retObj,"610","525");
    }
    else if( type == "ASSETCD" ){           // 자산코드 팝업
        retObj = showModal("/ham/apop018.ap?goTo=list&acctut="+param, retObj,"610","525");
    }
    else if( type == "ARAPNO2" ){           // 채권/채무 팝업
        retObj = showModal("/ham/apop019.ap?goTo=list&AcctUt="+param, retObj,"900","550");
    }
    else if( type == "REPCUSTCD" ){          // 대표거래처 코드 팝업
        retObj = showModal("/ham/apop022.ap?goTo=list&flag="+param, retObj,"610","530");
    }
    else if( type == "RESLIPNO" ){           // 반복전표 팝업
        retObj = showModal("/ham/apop023.ap?goTo=list", retObj,"605","522");
    }
    else if( type == "CARDNO" ){            // 법인카드 팝업
        retObj = showModal("/ham/apop024.ap?goTo=list", retObj,"605","522");
    }
    else if( type == "FUNDCD" ){            // 자금코드 팝업
        retObj = showModal("/ham/apop025.ap?goTo=list", retObj,"510","522");
    }
    else if( type == "FUNDCD2" ){            // 자금코드 팝업
        retObj = showModal("/ham/apop026.ap?goTo=list&AcctCd="+param+"&Count="+param2, retObj,"510","522");
    }
    else if( type == "FUNDCD3" ){            // ???? ?? ?????
        retObj = showModal("/ham/apop028.ap?goTo=list", retObj,"510","522");
    }
    else if( type == "TSMILETAX" ){           // 세금계산서 팝업
        retObj = showModal("/ham/apop029.ap?goTo=list&Makedt="+param+"&CustCd="+param2, retObj,"810","570");
    }
    else if( type == "OUTASSETCD" ){          // 매각자산코드
    	retObj = showModal("/ham/apop030.ap?goTo=list&acctut="+param, retObj,"610","525");
    }
    else if( type == "USERID" ){              // 사용자 팝업
    	retObj = showModal("/ham/apop031.ap?goTo=list", retObj, "430", "510");
    }
    
    
    return retObj;
}

/**
* getEmpCd()
* 작 성 자  : FKL
* 작 성 일  : 2007-12-13
* 개    요   : 사원정보를 조회하는 팝업 
* 사용방법 : getEmpCd(gb,code)
* 재직구분(gb) :  null - 전체, 0 - 정상, 1 - 수습, 2 - 파견, 3 - 휴직, 4 - 퇴사
* code :  사원코드/명
*/
function getEmpCd() {
	var length = arguments.length;
	var gb = length>0 ? arguments[0]:"";
	var code = length>1 ? arguments[1]:"";
	
	var returnVal  = new Array();
  	var url        = "/ham/ccom990.cc?goTo=empCd&pGb="+gb+"&pCd="+code;
    returnVal      = showModal(url,"popup",430,487);
    
    return returnVal;
} 

function showModal(sUrl, sParam, sWidth, sHeight) {
    if(ie7 == true) {
    	//sWidth = sWidth-"15";  
        sHeight = sHeight-"30";  
    }
    var returnVal = new Array();
    var winleft=(screen.width)?(screen.width-sWidth)/2:100;
    var wintop=(screen.height)?(screen.height-sHeight)/2:100;

    returnVal = window.showModalDialog(sUrl, sParam,
            "dialogWidth:" + sWidth + "px; dialogHeight:" + sHeight + "px; resizable:no; help:no; status:no; scroll:no; edge:sunken;");

    return returnVal;
}

/**
* getJojik()
* 작 성 자  : FKL
* 작 성 일  : 2007-12-20
* 개    요   : 조직정보를 조회하는 팝업 
* 사용방법 : getJojik()
* ham/js/gauce.js에서 복사
*/
function getJojik() {
    var returnVal  = new Array();
  	var url        = "/ham/ccom990.cc?goTo=jojik";    	
    returnVal      = showModal(url,"popup",350,482);
    
    return returnVal;
} 

/**
* getPostNo()
* 작 성 자  : FKL
* 작 성 일  : 2007-12-28
* 개    요   : 우편번호를 조회하는 팝업 
* 사용방법 : getPostNo()
* ham/js/gauce.js에서 복사
*/
function getPostNo() {
    var returnVal  = new Array();
  	var url        = "/ham/ccom990.cc?goTo=postNo";    	
    returnVal      = showModal(url,"popup",430,487);
    
    return returnVal;
}
