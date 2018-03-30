/**
 * 시스템명 : 한국후지쯔 포인트카드 팝업 스크립트
 * 작 성 일 : 2010-03-08
 * 작 성 자 : 김재겸
 * 수 정 자 :
 * 파 일 명 : popup_ccs.js
 * 버    전 : 1.0
 * 인 코 딩 :
 * 개    요 : 문화센터 팝업 자바스크립트 표준 공통 함수
 */

/**
 * 목록을 반드시 작성하여 주시기 바랍니다.
 * 백화점     : CCom000 ~ CCom199
 * 경영지원   : CCom200 ~ CCom399
 * 포인트카드 : CCom400 ~ CCom599
 * 문화센터   : CCom600 ~ CCom799
 * 공통       : CCom900 ~ CCom999
 */

/**
공통함수 목록

☞-------------------FUNCTION ---------------------------------

☞-------------------POPOP  ---------------------------------
ccsLectureGroupPop()  : 강좌군선택 팝업
ccsCustomerPop()      : 회원검색 팝업
ccsInstructorPop()    : 강사검색 팝업
ccsLecturePop()       : 강좌검색 팝업
ccsOpenLecturePop()   : 개설강좌검색 팝업
ccsOpenLectureGridPop : 개설강좌검색 그리드 팝업
 
☞-------------------non-POPOP  ---------------------------------
getCultureCenter()          : 문화센터코드 가지고 오는 함수 - CCom600
ccsGetStandardCode()        : 기준코드 콤보 구하기
ccsGetStandardCodeData()    : 기준코드 상세 dataSet 구하기
ccsGetLectureCategory()     : 강좌분류 카테고리정보 콤보 구하기
ccsGetLectureGroup()        : 강좌분류 카테고리에 대한 강좌군 콤보 구하기
ccsGetLectureGroupData()    : 강좌분류 카테고리에 대한 강좌군 dataSet 구하기
ccsGetRefundStandardGroup() : 환불기준그룹 콤보 구하기
ccsGetEvaluationGroup()     : 평가분류그룹 콤보 구하기
ccsGetEvaluationItemData()  : 평가분류에 대한 평가항목 dataSet 구하기
ccsGetLectOpenTimes()       : 개설강좌 횟수 구하기
ccsGetLectOpenTermCnt()     : 개설강좌 기간,횟수 구하기
ccsGetInstPayHistory()      : 강사료지급조건이력 구하기
ccsGetInstOpenLecture()     : 강사의 개설강좌 콤보 구하기
ccsGetSmstScheduleData()    : 학기별일정 dataSet 구하기
ccsGetDpsPosTranData()      : 백화점포스TRAN dataSet 구하기
ccsGetCourseDiscount()      : 수강할인 콤보 구하기
ccsGetPosNoData()           : 문화센터 POS번호 dataSet 구하기
*/

//------------------------------------------------------------------------------
// FUNCTION
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// POPUP
//------------------------------------------------------------------------------

/**
 * ccsLectureGroupPop()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-03-28
 * 개    요 : 강좌군선택 팝업
 * 사용방법 : ccsLectureGroupPop(EM_CAT_CD, EM_CAT_NM, EM_LGRP_CD, EM_LGRP_NM, 1);
 *           ccsLectureGroupPop(LC_CAT_CD, '', EM_LGRP_CD, EM_LGRP_NM, 2);
 *           ccsLectureGroupPop('', '', EM_LGRP_CD, EM_LGRP_NM, 3);
 *            arguments[0] -> 팝업 그리드 더블클릭시 카테고리코드를  받아올 ID
 *            arguments[1] -> 팝업 그리드 더블클릭시 카테고리명을  받아올 ID
 *            arguments[2] -> 팝업 그리드 더블클릭시 강좌군코드를  받아올 ID
 *            arguments[3] -> 팝업 그리드 더블클릭시 강좌군명을  받아올 ID
 *            arguments[4] -> 1:emEdit + emEdit, 2:luxeCombo + emEdit, 3:null + emEdit
 * return값 : map
 *            CAT_CODE  --> 카테고리코드
 *            CAT_NAME  --> 카테고리명
 *            LGRP_CODE --> 강좌군코드
 *            LGRP_NAME --> 강좌군명
 */
function ccsLectureGroupPop(catCd, catNm, lgrpCd, lgrpNm, type) {
    var rtnMap = new Map();
    var arrArg = new Array();
    var catCdValue = "";
    
    if (type == 1) {
        catCdValue = catCd.Text;
    } else if (type == 2) {
    	catCdValue = catCd.BindColVal;
    }
    rtnMap.put("cateCode", catCdValue);
    rtnMap.put("lgrpCode", lgrpCd.Text);
    arrArg.push(rtnMap);

    var returnVal = window.showModalDialog("/ccs/ccod901.cd?goTo=list",
                                           arrArg,
                                           "dialogWidth:500px;dialogHeight:405px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

    if (returnVal) {
        var map = arrArg[0];
        if (type == 1) {
        	catCd.Text = map.get("CAT_CD");
        	catNm.Text = map.get("CAT_NM");
        } else if (type == 2) {
        	catCd.BindColVal = map.get("CAT_CD");
        }
        lgrpCd.Text = map.get("LGRP_CD");
        lgrpNm.Text = map.get("LGRP_NM");
        return map;
    }
    
    return null;
}

/**
 * ccsCustomerPop()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010. 03. 28
 * 개    요 : 회원검색 팝업 (DS_O_POPUP 필수)
 * 사용방법 : ccsCustomerPop(searchText, searchCols, custNo, custNm, resNo)
 *            arguments[0] -> 검색 옵션 {CUST_NO:'111111111',RES_NO:'2222222222222',CUST_NM:'홍길동'}
 *            arguments[1] -> 팝업 그리드 더블클릭시 회원번호를 받아올 EMEDIT ID
 *            arguments[2] -> 팝업 그리드 더블클릭시 회원명를 받아올 EMEDIT ID
 *            arguments[3] -> 팝업 그리드 더블클릭시 회원명를 받아올 EMEDIT ID
 * return값 : array
 */
function ccsCustomerPop(searchOpt, isClosed) {

    var row = 0;
    var yn = isClosed||'N';
    var rtnMap  = new Map();
    var arrArg  = new Array();
    
    if (searchOpt && isClosed == 'Y' &&
        (searchOpt.CUST_NO || searchOpt.CUST_NM || searchOpt.RES_NO)
    ) {
        
        var goTo       = "searchMaster";
        var action     = "O"; // 조회
        var parameters = "&strCustNo="+(searchOpt.CUST_NO? searchOpt.CUST_NO:'')
                       + "&strCustNm="+encodeURI(encodeURIComponent(searchOpt.CUST_NM? searchOpt.CUST_NM:''))
                       + "&strResNo="+(searchOpt.RES_NO? searchOpt.RES_NO:'');
        
        TR_MAIN.Action = "/ccs/ccod905.cd?goTo="+goTo+parameters;
        TR_MAIN.KeyValue = "SERVLET("+action+":DS_O_POPUP=DS_O_POPUP)";
        TR_MAIN.Post();
        
        row = DS_O_POPUP.CountRow;
        
        if (row == 1) {            
            for (var i = 1; i <= DS_O_POPUP.CountColumn; i++) {
                rtnMap.put(DS_O_POPUP.ColumnID(i), DS_O_POPUP.NameValue(row, DS_O_POPUP.ColumnID(i)));
            }
            return rtnMap;
        }
    }
    if (row != 1) {

        arrArg.push(rtnMap);
    	arrArg.push(searchOpt == null? {}:searchOpt);
    	arrArg.push(isClosed||"N");
    
        var returnVal = window.showModalDialog("/ccs/ccod905.cd?goTo=list",
                                               arrArg,
                                               "dialogWidth:700px;dialogHeight:395px;scroll:no;" +
                                               "resizable:no;help:no;unadorned:yes;center:yes;status:no");
         
      	if (returnVal){
    		return arrArg[0];
     	}
      	else
      		return null;
    }
    
}

/**
 * ccsInstructorPop()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-01
 * 개    요 : 강사검색 팝업
 * 사용방법 : ccsInstructorPop("DS_O_RESULT", instMap, "F");
 *            arguments[0] -> 출력용 dataSet
 *            arguments[1] -> 오브젝트 map배열(필드명:오브젝트명)
 *            arguments[2] -> 유형 (F:포커스 잃을때, S:팝업클릭조회)
 * return값 : map
 *            INST_NO  --> 강사번호
 *            INST_NM  --> 강사명
 */
function ccsInstructorPop(strDataSet, objMap, type) {
    if (strDataSet == null || objMap == null || type == null) {
        return false;
    }
    
    var dataSet = eval(strDataSet);
    var keyArray = objMap.keys();
    var keyLength = keyArray.length;
    var objInstNo = eval(objMap.get("INST_NO"));
    var objInstNm = eval(objMap.get("INST_NM"));
    var strInstNo = objInstNo.Text;
        
    if (type == "F") {
    	// 강사번호 변경시 강사명 초기화
    	if (trim(strInstNo) == "") {
    		objInstNm.Text = "";
            return false;
        }
    	
        DS_I_CONDITION.setDataHeader('INST_NO:STRING(6)');
        DS_I_CONDITION.ClearData();
        DS_I_CONDITION.Addrow();
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "INST_NO") = strInstNo;

        TR_MAIN.Action   = "/ccs/ccod909.cd?goTo=getInstructor";
        TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
        TR_MAIN.Post();
    } else {
    	dataSet.ClearData();
    }

    // 검색결과 있을때
    if (dataSet.CountRow == 1) {
    	for (var i=0; i<keyArray.length; i++) {
		    // 변수정보
		    var key = keyArray[i];
		    var id = objMap.get(key);
        	var value = dataSet.NameValue(dataSet.RowPosition, key)
            
        	if (value != "") {
        		var component = id.split("_");
    	        // LuxCombo        		
    	        if (component[0] == "LC"){
    	    	    eval(id).BindColVal = value;
    	    	
                // EmEdit
                } else {
                    eval(id).Text = value;
                }
        	}
        }
    	
    	return "OK";

    // 검색결과 없을때 팝업
    } else {
        var rtnMap = new Map();
        var arrArg = new Array();

        rtnMap.put("instNo", strInstNo);
        arrArg.push(rtnMap);

        var returnVal = window.showModalDialog("/ccs/ccod909.cd?goTo=list",
                                               arrArg,
                                               "dialogWidth:300px;dialogHeight:452px;scroll:no;" +
                                               "resizable:no;help:no;unadorned:yes;center:yes;status:no");

        if (returnVal) {
            var map = arrArg[0];
            // 리턴값 주기
            for (var i=0; i<keyArray.length; i++) {
    		    // 변수정보
    		    var key = keyArray[i];
    		    var id = objMap.get(key);
            	var value = map.get(key);
                
            	if (value != "") {
            		var component = id.split("_");
        	        // LuxCombo        		
        	        if (component[0] == "LC"){
        	    	    eval(id).BindColVal = value;
        	    	
                    // EmEdit
                    } else {
                        eval(id).Text = value;
                    }
            	}
            }
            
            return "OK";
        }
        
        return null;
    }
}

/**
 * ccsLecturePop()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-01
 * 개    요 : 강좌검색 팝업
 * 사용방법 : ccsLecturePop("DS_O_RESULT", BO_HEADER, EM_LECT_CD, EM_LECT_NM, "F", "LECT_CD|LECT_NM");
 *            arguments[0] -> 출력용 dataSet
 *            arguments[1] -> 데이터 셋의 바인드 오브젝트
 *            arguments[2] -> 강좌코드 오브젝트 
 *                            강좌코드 확인 추가 : <input type="hidden" id="LECT_CD" name="LECT_CD" value="" />
 *                            신규작성시 초기화 : document.getElementById("LECT_CD").value = "";
 *                            조회 후 테이터셋 존재시 : document.getElementById("LECT_CD").value = EM_LECT_CD.Text;
 *            arguments[3] -> 강좌명 오브젝트
 *            arguments[4] -> 유형 (F:포커스 잃을때, S:팝업클릭조회)
 *            arguments[5] -> 필드정보 (LECT_CD|LECT_NM)
 * return값 : map
 */
function ccsLecturePop(strDataSet, binder, objCode, objName, type, fieldInfo) {
    var dataSet = eval(strDataSet);
    var bindInfo = binder.BindInfo; // 바인드 정보
    var lectCd = objCode.Text;
    var fieldArray = fieldInfo.split("|");
    
    // 컬럼과 컴포넌트 매칭 정보를 맵으로 구성
    var tmpMap = new Map();
    while (bindInfo.indexOf("col=") != -1) {
    	// 키
        bindInfo = bindInfo.substring(bindInfo.indexOf("col=")+4);        
        var tmpKey = bindInfo.substring(0,bindInfo.indexOf(" "));
        // 아이디
        bindInfo = bindInfo.substring(bindInfo.indexOf("ctrl=")+5);
        var tmpValue = bindInfo.substring(0, bindInfo.indexOf(" "));
        // 속성
        bindInfo = bindInfo.substring(bindInfo.indexOf("param=")+6);
        var tmpValue2 = bindInfo.substring(0, bindInfo.indexOf("</c>"));
        // 배열로 담기
        var valueArray = new Array(tmpValue, tmpValue2);
        tmpMap.put(tmpKey, valueArray);
    }
    
    if (type == "F") {
    	// 강좌코드 변경시 강좌명 초기화
    	if (trim(objCode.Text) == "") {
        	objName.Text = "";
            return false;
        }
    	
        DS_I_CONDITION.setDataHeader('LECT_CD:STRING(7)');
        DS_I_CONDITION.ClearData();
        DS_I_CONDITION.Addrow();
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "LECT_CD") = lectCd;

        TR_MAIN.Action   = "/ccs/ccod902.cd?goTo=getLecture";
        TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
        TR_MAIN.Post();
    } else {
    	dataSet.ClearData();
    }
    
    // 검색결과 있을때
    if (dataSet.CountRow == 1) {
        objName.Text = dataSet.NameValue(dataSet.RowPosition, "LECT_NM");
        
        for (var i=0; i<fieldArray.length; i++) {
        	var key = fieldArray[i];
        	var value = dataSet.NameValue(dataSet.RowPosition, key)
        	value = value.toString();
            value = value.replace(/\'/gi, "\\'");

    	    eval(tmpMap.get(key)[0]+"."+tmpMap.get(key)[1]+" = '"+value+"'");
    	    // 강좌코드 확인
    	    if (key == "LECT_CD"){
    	    	document.getElementById(key).value = value;
            // 재료비/교재비 결제포함여부        	    
            } else if (key == "MAT_ADD_YN" || key == "TCH_ADD_YN"){
                if (value == "Y") {                    	
                    document.getElementById(key).checked = true;
                    document.getElementById(key+"_TEXT").innerHTML = "결제포함";
                } else {
                    document.getElementById(key).checked = false;
                    document.getElementById(key+"_TEXT").innerHTML = "결제미포함";
                }
            }
        }
        
    // 검색결과 없을때 팝업
    } else {
        var rtnMap = new Map();
        var arrArg = new Array();

        rtnMap.put("lectCd", lectCd);
        arrArg.push(rtnMap);

        var returnVal = window.showModalDialog("/ccs/ccod902.cd?goTo=list",
                                               arrArg,
                                               "dialogWidth:500px;dialogHeight:450px;scroll:no;" +
                                               "resizable:no;help:no;unadorned:yes;center:yes;status:no");

        if (returnVal) {
            var map = arrArg[0];
            // 리턴값 주기
            for (var i=0; i<fieldArray.length; i++) {
            	var key = fieldArray[i];
            	var value = map.get(key);
                value = value.toString();
            	value = value.replace(/\'/gi, "\\'");
            	
        	    eval(tmpMap.get(key)[0]+"."+tmpMap.get(key)[1]+" = '"+value+"'");
        	    // 강좌코드 확인
        	    if (key == "LECT_CD"){
        	    	document.getElementById(key).value = value;
                // 재료비/교재비 결제포함여부        	    
                } else if (key == "MAT_ADD_YN" || key == "TCH_ADD_YN"){
                    if (value == "Y") {                    	
                        document.getElementById(key).checked = true;
                        document.getElementById(key+"_TEXT").innerHTML = "결제포함";
                    } else {
                        document.getElementById(key).checked = false;
                        document.getElementById(key+"_TEXT").innerHTML = "결제미포함";
                    }
                }
            }
        }
    }
}

/**
 * ccsOpenLecturePop()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-20
 * 개    요 : 개설강좌검색 팝업
 * 사용방법 : ccsOpenLecturePop("DS_O_RESULT", map, "F");
 *            arguments[0] -> 출력용 dataSet
 *            arguments[1] -> 오브젝트 map배열(필드명:오브젝트명)
 *            arguments[2] -> 유형 (F:포커스 잃을때, S:팝업클릭조회)
 *            
 *           var lectMap = new Map();
 *           testMap.put("CNTR_CD", "LC_CNTR_CD");
 *           testMap.put("YEAR_CD", "EM_YEAR_CD");
 *           testMap.put("SMST_CD", "LC_SMST_CD");
 *           testMap.put("CAT_CD", "LC_S_CAT_CD");
 *           testMap.put("LGRP_CD", "LC_S_LGRP_CD");
 *           testMap.put("LECT_CD", "EM_LECT_CD");
 *           testMap.put("LECT_NM", "EM_LECT_NM");
 *           
 * return값 : map
 */
function ccsOpenLecturePop(strDataSet, objMap, type) {
    if (strDataSet == null || objMap == null || type == null) {
        return false;
    }

    var dataSet = eval(strDataSet);
    var objLectCd = eval(objMap.get("LECT_CD"));
    var objLectNm = eval(objMap.get("LECT_NM"));
    var strCntrCd = "";
    var strYearCd = "";
    var strSmstCd = "";
    var strCatCd = "";
    var strLgrpCd = "";
    var strLectCd = "";
    var strLectNm = "";
    var keyArray = objMap.keys();
    var keyLength = keyArray.length;
    
    if (objLectCd == null || keyLength < 1) {
        return false;
    }
    
    // 오브젝트 정보
    if (objMap.get("CNTR_CD")) {
        strCntrCd = eval(objMap.get("CNTR_CD")).BindColVal;
    }
    if (objMap.get("YEAR_CD")) {
        strYearCd = eval(objMap.get("YEAR_CD")).Text;
    }
    if (objMap.get("SMST_CD")) {
        strSmstCd = eval(objMap.get("SMST_CD")).BindColVal;
    }
    if (objMap.get("CAT_CD") && objLectCd.Text.length != 7) {
        strCatCd = eval(objMap.get("CAT_CD")).BindColVal;
    }
    if (objMap.get("LGRP_CD") && objLectCd.Text.length != 7) {
        strLgrpCd = eval(objMap.get("LGRP_CD")).BindColVal;
    }
    strLectCd = objLectCd.Text;
    strLectNm = objLectNm.Text;

    if (type == "F") {
    	// 강좌코드 변경시 강좌명 초기화
    	if (trim(strLectCd) == "") {
    		objLectNm.Text = "";
            return false;
        }

        DS_I_CONDITION.setDataHeader('YEAR_CD:STRING(4),SMST_CD:STRING(1),CNTR_CD:STRING(3),CAT_CD:STRING(3),LGRP_CD:STRING(3),LECT_NM:STRING(100),LECT_CD:STRING(7)');
        DS_I_CONDITION.ClearData();
        DS_I_CONDITION.Addrow();
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "YEAR_CD") = strYearCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SMST_CD") = strSmstCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CNTR_CD") = strCntrCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CAT_CD") = strCatCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "LGRP_CD") = strLgrpCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "LECT_NM") = strLectNm;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "LECT_CD") = strLectCd;

        TR_MAIN.Action   = "/ccs/ccod910.cd?goTo=getOpenLecture";
        TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
        TR_MAIN.Post();
    } else {
    	dataSet.ClearData();
    }
    
    // 검색결과 있을때
    if (dataSet.CountRow == 1) {
        for (var i=0; i<keyArray.length; i++) {
		    // 변수정보
		    var key = keyArray[i];
		    var id = objMap.get(key);
        	var value = dataSet.NameValue(dataSet.RowPosition, key)
            
        	// if (value != "") {
        		var component = id.split("_");
    	        // LuxCombo        		
    	        if (component[0] == "LC"){
    	    	    eval(id).BindColVal = value;
    	    	
                // EmEdit
                } else {
                    eval(id).Text = value;
                }
        	// }
        }
        
        return "OK";
        
    // 검색결과 없을때 팝업
    } else {
        var rtnMap = new Map();
        var arrArg = new Array();

        rtnMap.put("CNTR_CD", strCntrCd);
        rtnMap.put("YEAR_CD", strYearCd);
        rtnMap.put("SMST_CD", strSmstCd);
        rtnMap.put("CAT_CD", strCatCd);
        rtnMap.put("LGRP_CD", strLgrpCd);
        rtnMap.put("LECT_CD", strLectCd);
        arrArg.push(rtnMap);

        var returnVal = window.showModalDialog("/ccs/ccod910.cd?goTo=list",
                                               arrArg,
                                               "dialogWidth:800px;dialogHeight:465px;scroll:no;" +
                                               "resizable:no;help:no;unadorned:yes;center:yes;status:no");

        if (returnVal) {
            var map = arrArg[0];
            // 리턴값 주기
            for (var i=0; i<keyArray.length; i++) {
    		    // 변수정보
    		    var key = keyArray[i];
    		    var id = objMap.get(key);
            	var value = map.get(key);
                
            	// if (value != "") {
            		var component = id.split("_");
        	        // LuxCombo        		
        	        if (component[0] == "LC"){
        	    	    eval(id).BindColVal = value;
        	    	
                    // EmEdit
                    } else {
                        eval(id).Text = value;
                    }
            	// }
            }
            
            return "OK";
        }
    }
}

/**
 * ccsOpenLectureGridPop()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-24
 * 개    요 : 개설강좌검색 그리드 팝업
 * 사용방법 : ccsOpenLectureGridPop(GD_MASTER, "DS_O_RESULT", searchMap, "LECT_CD|LECT_NM|CAT_CD", "F", "1");
 *            arguments[0] -> 그리드
 *            arguments[1] -> 출력용 dataSet
 *            arguments[2] -> 검색할필드정보 Map배열
 *            arguments[3] -> 리턴받을 필드정보(강좌코드 필수)
 *            arguments[4] -> 유형 (F:포커스 잃을때, S:팝업클릭조회)
 *            arguments[5] -> 비활성화설정 (1:년도, 학기, 센터 비활성화)
 *
 * return값 : map
 */
function ccsOpenLectureGridPop(grid, strDataSet, searchMap, fieldInfo, type, enableCheck) {
    if (strDataSet == null || searchMap == null ||
        fieldInfo == null || fieldInfo == "" || type == null) {
        return false;
    }

    // 변수정보
    var dsMaster = eval(grid.DataID);
    var row = dsMaster.RowPosition;
    var dataSet = eval(strDataSet);
    var searchKeyArray = searchMap.keys();
    var searchKeyLength = searchKeyArray.length;
    var fieldArray = fieldInfo.split("|");
    var fieldLength = fieldArray.length;
    var i;
    var strYearCd = "";
    var strSmstCd = "";
    var strCntrCd = "";
    var strLectCd = "";
    var strCatCd = "";
    var strLgrpCd = "";

    if (fieldLength < 1) {
        return false;
    }

    // 변수 정보
    if (searchMap.get("YEAR_CD")) {
        strYearCd = searchMap.get("YEAR_CD");
    }
    if (searchMap.get("SMST_CD")) {
        strSmstCd = searchMap.get("SMST_CD");
    }
    if (searchMap.get("CNTR_CD")) {
        strCntrCd = searchMap.get("CNTR_CD");
    }
    if (searchMap.get("LECT_CD")) {
        strLectCd = searchMap.get("LECT_CD");
    }
    if (searchMap.get("CAT_CD")) {
        strCatCd = searchMap.get("CAT_CD");
    }
    if (searchMap.get("LGRP_CD")) {
        strLgrpCd = searchMap.get("LGRP_CD");
    }

    if (type == "F") {
        // 강좌코드 없을때 초기화
        if (trim(strLectCd) == "" || trim(strLectCd).length != 7) {
            for (i=0; i<fieldLength; i++) {
                dsMaster.NameValue(row, fieldArray[i]) = "";
            }
            return false;
        }

        DS_I_CONDITION.setDataHeader('YEAR_CD:STRING(4),SMST_CD:STRING(1),CNTR_CD:STRING(3),CAT_CD:STRING(3),LGRP_CD:STRING(3),LECT_CD:STRING(7),LECT_NM:STRING(100)');
        DS_I_CONDITION.ClearData();
        DS_I_CONDITION.Addrow();
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "YEAR_CD") = strYearCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "SMST_CD") = strSmstCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CNTR_CD") = strCntrCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CAT_CD")  = strCatCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "LGRP_CD") = strLgrpCd;
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "LECT_CD") = strLectCd;        
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "LECT_NM") = "";

        TR_MAIN.Action   = "/ccs/ccod910.cd?goTo=getOpenLecture";
        TR_MAIN.KeyValue = "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
        TR_MAIN.Post();
    } else {
        dataSet.ClearData();
    }

    // 검색결과 있을때
    if (dataSet.CountRow == 1) {
        for (var i=0; i<fieldArray.length; i++) {
            // 변수정보
            var key = fieldArray[i];
            var value = dataSet.NameValue(dataSet.RowPosition, key)

            dsMaster.NameValue(row, key) = value;
        }

    // 검색결과 없을때 팝업
    } else {
        var rtnMap = new Map();
        var arrArg = new Array();

        rtnMap.put("YEAR_CD", strYearCd);
        rtnMap.put("SMST_CD", strSmstCd);
        rtnMap.put("CNTR_CD", strCntrCd);
        rtnMap.put("LECT_CD", strLectCd);
        rtnMap.put("CAT_CD", strCatCd);
        rtnMap.put("LGRP_CD", strLgrpCd);
        rtnMap.put("ENABLE_CHECK", enableCheck);
        arrArg.push(rtnMap);

        var returnVal = window.showModalDialog("/ccs/ccod910.cd?goTo=list",
                                               arrArg,
                                               "dialogWidth:800px;dialogHeight:465px;scroll:no;" +
                                               "resizable:no;help:no;unadorned:yes;center:yes;status:no");

        if (returnVal) {
            var map = arrArg[0];
            // 리턴값 주기
            for (var i=0; i<fieldArray.length; i++) {
                // 변수정보
                var key = fieldArray[i];
                var value = map.get(key);

                dsMaster.NameValue(row, key) = value;
            }
        }
    }
}

//------------------------------------------------------------------------------
// non-POPOP
//------------------------------------------------------------------------------

/**
 * getCultureCenter()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-03-17
 * 개    요 : 문화센터 콤보 세팅을 위한 dataSet을 가져오는 함수 
 * 사용방법 : getCultureCenter(dataSet, "Y", "N", "Y", "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 권한에 따라 보여질지 여부 (Y/N)
 *            arguments[2] -> 콤보에 '전점' 표시 할지 여부 (Y/N)
 *            arguments[3] -> '전체'를 보일건지 여부 (Y/N)
 *            arguments[4] -> 사용여부검색 (Y:사용함검색, N:전체검색)
 * return값 : void
 */
function getCultureCenter(dataSet, authYn, allCenterYn, allYn, useYn) {
	DS_I_COMMON.setDataHeader('AUTH_YN:STRING(1),ALL_CENTER_YN:STRING(1),ALL_YN:STRING(1),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "AUTH_YN") = authYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "ALL_CENTER_YN") = allCenterYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "ALL_YN") = allYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "USE_YN") = useYn;

    TR_MAIN.Action	 = "/pot/ccom600.cc?goTo=getCultureCenter";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();	
}

/**
 * ccsGetStandardCode()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-03-23
 * 개    요 : 기준코드 콤보 세팅을 위한 dataSet을 가져오는 함수 
 * 사용방법 : ccsGetStandardCode(dataSet, grpCD, "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 그룹코드
 *            arguments[2] -> '전체'를 보일건지 여부 (Y/N)
 *            arguments[3] -> 사용여부검색 (Y:사용함검색, N:전체검색)
 * return값 : void
 */
function ccsGetStandardCode(dataSet, grpCD, allYn, useYn) {
	DS_I_COMMON.setDataHeader('GRP_CD:STRING(3),ALL_YN:STRING(1),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "GRP_CD") = grpCD;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "ALL_YN") = allYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "USE_YN") = useYn;

    TR_MAIN.Action	 = "/ccs/ccod005.cd?goTo=getStandardCode";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetStandardCodeData()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-13
 * 개    요 : 기준코드상세 dataSet을 가져오는 함수 
 * 사용방법 : ccsGetStandardCodeData(dataSet, grpCd, "N");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 그룹코드
 *            arguments[2] -> 사용여부검색 (Y:사용함검색, N:전체검색)
 * return값 : void
 */
function ccsGetStandardCodeData(dataSet, grpCd, useYn) {
	DS_I_COMMON.setDataHeader('GRP_CD:STRING(3),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "GRP_CD") = grpCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "USE_YN") = useYn;
	
    TR_MAIN.Action	 = "/ccs/ccod005.cd?goTo=getStandardCodeData";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetLectureCategory()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-03-28
 * 개    요 : 강좌분류 카테고리정보 콤보 세팅을 위한 dataSet을 가져오는 함수 
 * 사용방법 : ccsGetLectureCategory(dataSet, "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> '전체'를 보일건지 여부 (Y/N)
 *            arguments[2] -> 사용여부검색 (Y:사용함검색, N:전체검색)
 * return값 : void
 */
function ccsGetLectureCategory(dataSet, allYn, useYn) {
	DS_I_COMMON.setDataHeader('ALL_YN:STRING(1),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "ALL_YN") = allYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "USE_YN") = useYn;

    TR_MAIN.Action	 = "/ccs/ccod901.cd?goTo=getLectureCategory";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetLectureGroup()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010-04-04
 * 개    요 : 강좌카테고리에 대한 강좌군 정보정보 콤보 세팅을 위한 dataSet을 가져오는 함수 
 * 사용방법 : ccsGetLectureGroup(dataSet, "Y", "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 선택되어진 카테고리 값
 *            arguments[2] -> '전체'를 보일건지 여부 (Y/N)
 *            arguments[3] -> 사용여부검색 (Y:사용함검색, N:전체검색)
 * return값 : void
 */
function ccsGetLectureGroup(dataSet, val, allYn, useYn) {
	DS_I_COMMON.setDataHeader('ALL_YN:STRING(1),USE_YN:STRING(1),CAT_CD:STRING(3)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "CAT_CD") = val;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "ALL_YN") = allYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "USE_YN") = useYn;

    TR_MAIN.Action	 = "/ccs/ccod901.cd?goTo=getLectureGroup";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetLectureGroupData()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-18
 * 개    요 : 강좌분류 카테고리에 대한 강좌군 dataSet을 가져오는 함수
 * 사용방법 : ccsGetLectureGroupData(dataSet, catCd, lgrpCd);
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 카테고리코드
 *            arguments[2] -> 강좌군코드
 * return값 : void
 */
function ccsGetLectureGroupData(dataSet, catCd, lgrpCd) {
	DS_I_COMMON.setDataHeader('CAT_CD:STRING(3),LGRP_CD:STRING(3)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "CAT_CD") = catCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "LGRP_CD") = lgrpCd;
	
    TR_MAIN.Action	 = "/ccs/ccod901.cd?goTo=getLectureGroupData";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetRefundStandardGroup()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-03-29
 * 개    요 : 환불기준 그룹정보 콤보 세팅을 위한 dataSet을 가져오는 함수 
 * 사용방법 : ccsGetRefundStandardGroup(dataSet, "Y", "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> '전체'를 보일건지 여부 (Y/N)
 *            arguments[2] -> 사용여부검색 (Y:사용함검색, N:전체검색)
 * return값 : void
 */
function ccsGetRefundStandardGroup(dataSet, allYn, useYn) {
	DS_I_COMMON.setDataHeader('ALL_YN:STRING(1),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "ALL_YN") = allYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "USE_YN") = useYn;

    TR_MAIN.Action	 = "/ccs/ccod004.cd?goTo=getRefundStandardGroup";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetOpendLecture()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010-04-05
 * 개    요 : 개설강좌 팝업 
 * 사용방법 : ccsGetOpendLecture({CUST_NO:"111111111",CNTR_CD:"101",YEAR_CD:"2010",SMST_CD:"1"});
 *            arguments[0] -> 기본 검색 세팅 옵션
 * return값 : void
 */
function ccsGetOpendLecture(searchOpt) {
	var rtnMap  = new Map();
	var arrArg  = new Array();
	
	arrArg.push(rtnMap);
	arrArg.push(searchOpt||{});
	
	var returnVal = window.showModalDialog("/ccs/ccod906.cd?goTo=list",
	                                       arrArg,
	                                       "dialogWidth:975px;dialogHeight:395px;scroll:no;" +
	                                       "resizable:no;help:no;unadorned:yes;center:yes;status:no");
	 
	if (returnVal){
	    return arrArg[0];
	}
	else 
		return null;
}
/**
 * ccsGetCustFml()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010-03-29
 * 개    요 : 가족관계 가져오기 
 * 사용방법 : ccsGetCustFml(dataSet, "111111111");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 회원번호
 * return값 : void
 */
function ccsGetCustFml(dataSet, custNo) {
	DS_I_COMMON.setDataHeader('CUST_NO:STRING(9)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "CUST_NO") = custNo;

    TR_MAIN.Action	 = "/ccs/ccod906.cd?goTo=searchFamily";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsCustomerFamilyPop()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010. 04. 05
 * 개    요 : 회원가족검색 팝업
 * 사용방법 : ccsCustomerFamilyPop(custNo)
 *            arguments[0] -> 검색 회원번호 
 * return값 : array
 */
function ccsCustomerFamilyPop(custNo) {

    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
	arrArg.push(custNo);

    var returnVal = window.showModalDialog("/ccs/ccod907.cd?goTo=list",
                                           arrArg,
                                           "dialogWidth:300px;dialogHeight:300px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
     
  	if (returnVal){
		return arrArg[0];
 	}
  	else
  		return null;
}

/**
 * getDbDate();
 * 작 성 자 : 조성대
 * 작 성 일 : 2010. 04. 07
 * 개    요 : 현재 DB시간 얻음 yyyymmddhh24miss 형태임
 * 사용방법 : getDbDate()
 *          DS_O_DATE 필수 
 * return값 : string
 */
function getDbDate() {
    TR_MAIN.Action	 = "/ccs/ccod906.cd?goTo=getDate";
    TR_MAIN.KeyValue = "SERVLET(O:DS_O_DATE=DS_O_DATE)";
    TR_MAIN.Post();	
    
    return DS_O_DATE.NameValue(DS_O_DATE.RowPosition, "NOW_DATE");
}

/**
 * ccsCustomerSgupPop()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010. 04. 08
 * 개    요 : 회원수강내역선택 팝업
 * 사용방법 : ccsCustomerFamilyPop(custNo)
 *            arguments[0] -> 검색 회원번호 
 * return값 : array
 */
function ccsCustomerSgupPop(searchOpt, isClosed) {
	var row = 0;
    var yn = isClosed||'N';
    var rtnMap  = new Map();
    var arrArg  = new Array();
    
    if (searchOpt && isClosed == 'Y' &&
        (searchOpt.SGUP_NO || searchOpt.CUST_NO || searchOpt.CUST_NM || searchOpt.RES_NO)
    ) {
        
        DS_I_POPUP.setDataHeader('SGUP_NO:STRING(10),CNTR_CD:STRING(3),YEAR_CD:STRING(4),SMST_CD:STRING(1),CUST_NO:STRING(9),CUST_NM:STRING(30),RES_NO:STRING(13)');
        DS_I_POPUP.ClearData();
        DS_I_POPUP.Addrow();
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "SGUP_NO") = searchOpt.SGUP_NO? searchOpt.SGUP_NO:'';
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "CNTR_CD") = searchOpt.CNTR_CD? searchOpt.CNTR_CD:'';
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "YEAR_CD") = searchOpt.YEAR_CD? searchOpt.YEAR_CD:'';
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "SMST_CD") = searchOpt.SMST_CD? searchOpt.SMST_CD:'';
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "CUST_NO") = searchOpt.CUST_NO? searchOpt.CUST_NO:'';
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "CUST_NM") = searchOpt.CUST_NM? searchOpt.CUST_NM:'';
        DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "RES_NO")  = searchOpt.RES_NO? searchOpt.RES_NO:'';
        TR_MAIN.Action     = "/ccs/ccod908.cd?goTo=searchMaster";
        TR_MAIN.KeyValue = "SERVLET(I:DS_I_POPUP=DS_I_POPUP,O:DS_O_POPUP=DS_O_POPUP)";
        TR_MAIN.Post(); 
        
        row = DS_O_POPUP.CountRow;
        
        if (row == 1) {            
            for (var i = 1; i <= DS_O_POPUP.CountColumn; i++) {
                rtnMap.put(DS_O_POPUP.ColumnID(i), DS_O_POPUP.NameValue(row, DS_O_POPUP.ColumnID(i)));
            }
            return rtnMap;
        }
    }
    if (row != 1) {
	
    	arrArg.push(rtnMap);
    	arrArg.push(searchOpt||{});
    	arrArg.push(isClosed||'N');
    	
    	var returnVal = window.showModalDialog("/ccs/ccod908.cd?goTo=list",
    	                                       arrArg,
    	                                       "dialogWidth:990px;dialogHeight:395px;scroll:no;" +
    	                                       "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    	 
    	if (returnVal)
    	    return arrArg[0];
    	else 
    		return null;
    }
}

/**
 * ccsGetEvaluationGroup()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-25
 * 개    요 : 평가분류 그룹정보 콤보 세팅을 위한 dataSet을 가져오는 함수 
 * 사용방법 : ccsGetEvaluationGroup(dataSet, "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> '전체'를 보일건지 여부 (Y/N)
 *            arguments[2] -> 구분코드 (강사/강좌)
 *            arguments[3] -> 사용여부검색 (Y:사용함검색, N:전체검색)
 * return값 : void
 */
function ccsGetEvaluationGroup(dataSet, allYn, gubunCd, useYn) {
	DS_I_COMMON.setDataHeader('ALL_YN:STRING(1),GUBUN_CD:STRING(2),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "ALL_YN") = allYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "GUBUN_CD") = gubunCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "USE_YN") = useYn;

    TR_MAIN.Action	 = "/ccs/ccod003.cd?goTo=getEvaluationGroup";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetEvaluationItemData()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-04-25
 * 개    요 : 평가분류에 대한 평가항목 dataSet을 가져오는 함수
 * 사용방법 : ccsGetEvaluationItemData(dataSet, evlGrp, "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 평가분류코드
 *            arguments[2] -> 사용여부검색 (Y:사용함검색, N:전체검색)
 * return값 : void
 */
function ccsGetEvaluationItemData(dataSet, evlGrp, useYn) {
	DS_I_COMMON.setDataHeader('EVL_GRP:STRING(3),USE_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "EVL_GRP") = evlGrp;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "USE_YN") = useYn;
	
    TR_MAIN.Action	 = "/ccs/ccod003.cd?goTo=getEvaluationItemData";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetLectOpenTimes()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-05-03
 * 개    요 : 개설강좌 횟수 구하는 함수
 * 사용방법 : ccsGetLectOpenTimes(dataSet, '101', '20100301', '20100327', '1', '2', '3');
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 센터코드
 *            arguments[2] -> 시작일
 *            arguments[3] -> 종료일
 *            arguments[4] -> 요일1
 *            arguments[5] -> 요일2
 *            arguments[6] -> 요일3
 * return값 : void
 */
function ccsGetLectOpenTimes(dataSet, cntrCd, startDate, endDate, dayCd1, dayCd2, dayCd3) {
	DS_I_COMMON.setDataHeader('CNTR_CD:STRING(3),START_DATE:STRING(8),END_DATE:STRING(8),DAY_CD1:STRING(1),DAY_CD2:STRING(1),DAY_CD3:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "CNTR_CD") = cntrCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "START_DATE") = startDate;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "END_DATE") = endDate;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "DAY_CD1") = dayCd1;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "DAY_CD2") = dayCd2;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "DAY_CD3") = dayCd3;

    TR_MAIN.Action	 = "/ccs/cinl000.cl?goTo=lectOpenTimes";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
    
    var result = 0;
    var DATA_SET = eval(dataSet);
    if (DATA_SET.CountRow == 1) {
	    result = DATA_SET.NameValue(1, "RESULT");
    }
    
    return result;
}

/**
 * ccsGetLectOpenTermCnt()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-05-03
 * 개    요 : 개설강좌 기간,횟수 구하는 함수
 * 사용방법 : ccsGetLectOpenTermCnt(dataSet, '101', '2010', '1', '1', '2', '3', '20100301', '5');
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 센터코드
 *            arguments[2] -> 년도
 *            arguments[3] -> 학기
 *            arguments[4] -> 요일1
 *            arguments[5] -> 요일2
 *            arguments[6] -> 요일3
 *            arguments[7] -> 시작일
 *            arguments[8] -> 강좌횟수
 * return값 : void
 */
function ccsGetLectOpenTermCnt(dataSet, cntrCd, yearCd, smstCd, dayCd1, dayCd2, dayCd3, startDate, lectCnt) {
	DS_I_COMMON.setDataHeader('CNTR_CD:STRING(3),YEAR_CD:STRING(4),SMST_CD:STRING(1),DAY_CD1:STRING(1),DAY_CD2:STRING(1),DAY_CD3:STRING(1),START_DATE:STRING(8),LECT_CNT:STRING(5)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "CNTR_CD") = cntrCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "YEAR_CD") = yearCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "SMST_CD") = smstCd;	
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "DAY_CD1") = dayCd1;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "DAY_CD2") = dayCd2;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "DAY_CD3") = dayCd3;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "START_DATE") = startDate;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "LECT_CNT") = lectCnt;
	
    TR_MAIN.Action	 = "/ccs/cinl000.cl?goTo=lectOpenTermCnt";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
    
    var resultMap = new Map();
    var DATA_SET = eval(dataSet);
    if (DATA_SET.CountRow == 1) {
    	// 배열로 담기    	
    	resultMap.put("START_DATE", DATA_SET.NameValue(1, "START_DATE"));
    	resultMap.put("END_DATE", DATA_SET.NameValue(1, "END_DATE"));
    	resultMap.put("LECT_CNT", DATA_SET.NameValue(1, "LECT_CNT"));
    }
    
    return resultMap;
}

/**
 * ccsGetPostPop()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010-05-03
 * 개    요 : 주소검색창 팝업
 * 사용방법 : ccsGetPostPop(우편번호, 주소1, 주소2);
 *            arguments[0] -> 우편번호 컬럼
 *            arguments[1] -> 주소1 컬럼
 *            arguments[2] -> 주소2컬럼
 * return값 : void
 */
function ccsGetPostPop(objCd1, objCd2, objNm1, objNm2, objGb) {
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);
    arrArg.push(objCd1.Text+objCd2.Text);
    
    var returnVal = window.showModalDialog("/pot/ccom430.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
    
    if (returnVal){
        var map = arrArg[0];
        objCd1.Text = map.get("POST_NO1");
        objCd2.Text = map.get("POST_NO2");
        objNm1.Text = map.get("ADDR1");
        objNm2.Text = map.get("ADDR2");
        objGb.Text = map.get("GUBUN");
        setTimeout(objNm2.focus, 200);        
    }
}

// sleep 기능 (주의 : 과도하게 사용하면 안됨 --)
function sleep(numberMillis) {
    var now = new Date();
    var exitTime = now.getTime() + numberMillis;


    while (true) {
         now = new Date();
         if (now.getTime() > exitTime)
             return;
    }
}

/**
 * ccsGetInstPayHistory()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-05-04
 * 개    요 : 강사료지급조건이력 구하기
 * 사용방법 : ccsGetInstPayHistory(dataSet, '110011');
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 강사번호
 * return값 : void
 */
function ccsGetInstPayHistory(dataSet, strInstNo) {
	DS_I_COMMON.setDataHeader('INST_NO:STRING(6)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "INST_NO") = strInstNo;
	
    TR_MAIN.Action	 = "/ccs/cinl003.cl?goTo=getInstPayHistory";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
    
    var resultMap = new Map();
    var DATA_SET = eval(dataSet);
    if (DATA_SET.CountRow == 1) {
    	// 배열로 담기    	
    	resultMap.put("PAY_MTH", DATA_SET.NameValue(1, "PAY_MTH"));
    	resultMap.put("PAY_VAL", DATA_SET.NameValue(1, "PAY_VAL"));
    	resultMap.put("PAY_BANK", DATA_SET.NameValue(1, "PAY_BANK"));
    	resultMap.put("PAY_ACCT", DATA_SET.NameValue(1, "PAY_ACCT"));
    	resultMap.put("PAY_TP", DATA_SET.NameValue(1, "PAY_TP"));
    }
    
    return resultMap;
}


/**
* ccsPrPop()
* 작 성 자 : 조성대
* 작 성 일 : 2010. 05. 04
* 개    요 : 홍보물선택 팝업
* 사용방법 : ccsPrPop(searchOpt, isClosed)
*            arguments[0] -> 검색 옵션 {CUST_NO:'111111111',RES_NO:'2222222222222',CUST_NM:'홍길동'}
*            arguments[1] -> 한건일 경우 자동 닫을지 말지 여부

* return값 : array
*/
function ccsPrPop(searchOpt, isClosed) {

   var row = 0;
   var yn = isClosed||'N';
   var rtnMap  = new Map();
   var arrArg  = new Array();
   
   if (searchOpt && isClosed == 'Y' &&
       (searchOpt.PR_NO)
   ) {       
       var goTo       = "searchMaster";
       var action     = "O"; // 조회
       var parameters = "&strPrNo="+searchOpt.PR_NO;
       
       TR_MAIN.Action = "/ccs/ccod903.cd?goTo="+goTo+parameters;
       TR_MAIN.KeyValue = "SERVLET("+action+":DS_O_POPUP=DS_O_POPUP)";
       TR_MAIN.Post();
       
       row = DS_O_POPUP.CountRow;
       
       if (row == 1) {            
           for (var i = 1; i <= DS_O_POPUP.CountColumn; i++) {
               rtnMap.put(DS_O_POPUP.ColumnID(i), DS_O_POPUP.NameValue(row, DS_O_POPUP.ColumnID(i)));
           }
           return rtnMap;
       }
   }
   if (row != 1) {

       arrArg.push(rtnMap);
       arrArg.push(searchOpt == null? {}:searchOpt);
       arrArg.push(isClosed||"N");
   
       var returnVal = window.showModalDialog("/ccs/ccod903.cd?goTo=list",
                                              arrArg,
                                              "dialogWidth:600px;dialogHeight:395px;scroll:no;" +
                                              "resizable:no;help:no;unadorned:yes;center:yes;status:no");
        
       if (returnVal){
           return arrArg[0];
       }
       else
           return null;
   }
   
}

/**
 * ccsGetInstOpenLecture()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-05-09
 * 개    요 : 강사의 개설강좌정보 콤보 세팅을 위한 dataSet을 가져오는 함수 
 * 사용방법 : ccsGetInstLecture(dataSet, "110001", "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 강사번호
 *            arguments[2] -> 개설여부검색 (Y:개설검색, N:전체검색)
 *            arguments[3] -> 센터코드
 *            arguments[4] -> 시작학기
 *            arguments[5] -> 종료학기
 * return값 : void
 */
function ccsGetInstOpenLecture(dataSet, instNo, openYn, cntrCd, strYearSmst, endYearSmst) {
	DS_I_COMMON.setDataHeader('INST_NO:STRING(6),OPEN_YN:STRING(1),CNTR_CD:STRING(3),STR_YEAR_SMST:STRING(5),END_YEAR_SMST:STRING(5)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "INST_NO") = instNo;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "OPEN_YN") = openYn;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "CNTR_CD") = cntrCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "STR_YEAR_SMST") = strYearSmst;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "END_YEAR_SMST") = endYearSmst;

    TR_MAIN.Action	 = "/ccs/ccod910.cd?goTo=getInstOpenLecture";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsMemberShipPop()
 * 작 성 자 : 조성대
 * 작 성 일 : 2010-03-28
 * 개    요 : 멤버쉽확인
 * 사용방법 : ccsMemberShipPop(EM_RES_NO);
 *            arguments[0] -> 주민번호
 * return값 : map
 */
function ccsMemberShipPop(resObj) {
    var rtnMap = new Map();
    var arrArg = new Array();
    arrArg.push(rtnMap);
    arrArg.push(resObj? resObj.Text:'');

    var returnVal = window.showModalDialog("/ccs/ccod904.cd?goTo=list",
                                           arrArg,
                                           "dialogWidth:500px;dialogHeight:132px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");

    if (returnVal) {        
        var map = arrArg[0];
        return map;
    }
    else    
        return null;
}

/**
 * ccsGetSmstScheduleData()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-06-09
 * 개    요 : 학기별일정 dataSet을 가져오는 함수
 * 사용방법 : ccsGetSmstScheduleData(dataSet, yearCd, smstCd, cntrCd);
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 년도
 *            arguments[2] -> 학기
 *            arguments[3] -> 센터
 * return값 : void
 */
function ccsGetSmstScheduleData(dataSet, yearCd, smstCd, cntrCd) {
	DS_I_COMMON.setDataHeader('YEAR_CD:STRING(4),SMST_CD:STRING(1),CNTR_CD:STRING(3)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "YEAR_CD") = yearCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "SMST_CD") = smstCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "CNTR_CD") = cntrCd;
	
    TR_MAIN.Action	 = "/ccs/ccod201.cd?goTo=getSmstScheduleData";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetDpsPosTranData()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-06-21
 * 개    요 : 영업정보 POS TRAN 정보 구하는 함수
 * 사용방법 : ccsGetDpsPosTranData(dataSet, '01', '20100621', '1234', '12345');
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 점코드
 *            arguments[2] -> 매출일자
 *            arguments[3] -> 포스번호
 *            arguments[4] -> 거래번호
 * return값 : void
 */
function ccsGetDpsPosTranData(dataSet, strCd, saleDt, posNo, tranNo) {
	DS_I_COMMON.setDataHeader('STR_CD:STRING(3),SALE_DT:STRING(8),POS_NO:STRING(4),TRAN_NO:STRING(5)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "STR_CD") = strCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "SALE_DT") = saleDt;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "POS_NO") = posNo;	
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "TRAN_NO") = tranNo;
	
	// 데이터셋 초기화
	var DATA_SET = eval(dataSet);
	DATA_SET.ClearData();
	
    TR_MAIN.Action	 = "/ccs/cmnr000.cm?goTo=dpsPosTranData";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
    
    var resultMap = new Map();
    if (DATA_SET.CountRow == 1) {
    	// 배열로 담기
    	resultMap.put("CARD_NO", DATA_SET.NameValue(1, "CARD_NO"));
    	resultMap.put("CARD_AMT", DATA_SET.NameValue(1, "CARD_AMT"));
    	resultMap.put("CASH_AMT", DATA_SET.NameValue(1, "CASH_AMT"));
    	resultMap.put("GIFT_AMT", DATA_SET.NameValue(1, "GIFT_AMT"));
    	resultMap.put("POINT_CARD", DATA_SET.NameValue(1, "POINT_CARD"));
    	resultMap.put("POINT_AMT", DATA_SET.NameValue(1, "POINT_AMT"));
    	resultMap.put("ORG_SALE_DT", DATA_SET.NameValue(1, "ORG_SALE_DT"));
    	resultMap.put("ORG_POS_NO", DATA_SET.NameValue(1, "ORG_POS_NO"));
    	resultMap.put("ORG_TRAN_NO", DATA_SET.NameValue(1, "ORG_TRAN_NO"));    	
    	resultMap.put("TRAN_FLAG", DATA_SET.NameValue(1, "TRAN_FLAG"));
    	resultMap.put("ORG_TRAN_CNT", DATA_SET.NameValue(1, "ORG_TRAN_CNT"));

    } else {
    	return false;
    }
    
    return resultMap;
}

/**
 * ccsGetCourseDiscount()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2010-03-23
 * 개    요 : 수강할인 콤보 세팅을 위한 dataSet을 가져오는 함수 
 * 사용방법 : ccsGetCourseDiscount(dataSet, "Y");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> '전체'를 보일건지 여부 (Y/N)
 * return값 : void
 */
function ccsGetCourseDiscount(dataSet, allYn) {
	DS_I_COMMON.setDataHeader('ALL_YN:STRING(1)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "ALL_YN") = allYn;

    TR_MAIN.Action	 = "/ccs/ccod007.cd?goTo=getCourseDiscount";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
}

/**
 * ccsGetPosNoData()
 * 작 성 자 : 김재겸
 * 작 성 일 : 2011-08-16
 * 개    요 : 문화센터 POS번호 dataSet 구하기
 * 사용방법 : ccsGetPosNoData(dataSet, "1201");
 *            arguments[0] -> 저장할 DataSet의 ID
 *            arguments[1] -> 점코드
 *            arguments[2] -> POS번호
 * return값 : void
 */
function ccsGetPosNoData(dataSet, strCd, posNo) {
	DS_I_COMMON.setDataHeader('STR_CD:STRING(2),POS_NO:STRING(4)');
	DS_I_COMMON.ClearData();
	DS_I_COMMON.Addrow();
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "STR_CD") = strCd;
	DS_I_COMMON.NameValue(DS_I_COMMON.RowPosition, "POS_NO") = posNo;

    // 데이터셋 초기화
	var DATA_SET = eval(dataSet);
	DATA_SET.ClearData();
	
    TR_MAIN.Action	 = "/ccs/cmnr000.cm?goTo=posNoData";
    TR_MAIN.KeyValue = "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+dataSet+")";
    TR_MAIN.Post();
	
	var posCnt = 0;
    if (DATA_SET.CountRow == 1) {
        posCnt = DATA_SET.NameValue(1, "POS_CNT")
    }
    
    return posCnt;
}
