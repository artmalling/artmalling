function setStrPbnNmWithoutPop( objCd, objNm, authGb, searchTp){
	
	
	
	/*
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
		//codeName = objNm.Text;   //명으로 조회는 없음 2011.04.12
	}
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_CD") = objCd.Text; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PUMBUN_NM") = codeName; 
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB") = authGb;
	DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/edi/ccom012.cc?goTo=searchOnWithoutPop";
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
	*/
	
	
	
}


/**
* openCal()
* 작 성 자 : FKL
* 작 성 일 : 2010. 01. 22
* 개    요 : 캘렌다 오픈
* 사용방법 : openCal(obj1, obj2, obj3)
*            obj1 -> 년도, 년도+월, 년도+월+일
*            obj2 -> 선택시 일자를 받을 EMEDIT ID
* return값 : 
*/

function openCal(obj1, obj2, obj3) {
  var obj = new Array();
  var rtn = "";
  
  if (arguments.length == 2 && obj1 != 'H' && obj1 != 'G' && obj1 != 'M' && obj1 != 'Y') {
    showMessage(STOPSIGN, OK, "SCRIPT-1002");
    return;
  } else if (arguments.length == 2 && (obj1 == 'H' || obj1 == 'G' || obj1 == 'M' || obj1 == 'Y')) {
    obj.push(obj1);
    obj.push(obj2);
  }

  if (arguments.length >= 3 && arguments[0].classid.toUpperCase() == CLSID_GRID) obj.push(eval(arguments[0].DataID).NameValue(obj2, obj3));

  if(obj1 == "Y"){
	  rtn = window.showModalDialog("/edi/html/common/calendarY.html",obj,"dialogWidth:218px;dialogHeight:130px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
  } else if(obj1 == "M"){
	  
	  rtn = window.showModalDialog("/edi/html/common/calendarM.html",obj,"dialogWidth:218px;dialogHeight:100px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
  }else{
	  if(arguments.length == 4){
		  if(arguments[3] == "Y")
			  rtn = window.showModalDialog("/edi/html/common/calendarY.html",obj,"dialogWidth:218px;dialogHeight:130px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
		  else if(arguments[3] == "M")
			  rtn = window.showModalDialog("/edi/html/common/calendarM.html",obj,"dialogWidth:218px;dialogHeight:100px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
		  else {
			  rtn = window.showModalDialog("/edi/html/common/calendar.html",obj,"dialogWidth:280px;dialogHeight:225px;scroll:no;resizable:yes;help:no;center:yes;status:no");
		  }
	  }else{
		  rtn = window.showModalDialog("/edi/html/common/calendar.html",obj,"dialogWidth:280px;dialogHeight:225px;scroll:no;resizable:yes;help:no;center:yes;status:no");
	  }
	  
//	  rtn = window.showModalDialog("/edi/html/common/calendar.html",obj,"dialogWidth:201px;dialogHeight:206px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
//	  rtn = window.showModalDialog("/edi/html/common/calendar.html",obj,"dialogWidth:280px;dialogHeight:225px;scroll:no;resizable:yes;help:no;center:yes;status:no");
//	  rtn = window.showModalDialog("/edi/html/common/calendar.html",obj,"dialogTop:3000px;dialogLeft:3000px;dialogWidth:200px;dialogHeight:206px;scroll:no;resizable:yes;help:no;status:no");
  }
  if (arguments.length >= 3 && arguments[0].classid.toUpperCase() == CLSID_GRID){  alert("mm"); eval(arguments[0].DataID).NameValue(obj2, obj3) = rtn; }
  
  if (obj1 == "Y"){
      obj2.Focus();
  } else if (obj1 == "G"){
	  if ( typeof(rtn) == "undefined") {
		  return;
	  } else {
		  obj2.value = rtn;
		  obj2.focus();
	  }
  } else if (obj1 == "H") {
      obj2.focus();
  } else if (obj1 == "M") {
	  if ( typeof(rtn) == "undefined") {
		  return;
	  } else {
		  obj2.value = rtn;
		  
	  }
	  obj2.focus();
  } 
  
  
}


/**
* getPostPop()
* 작 성 자 : FKL
* 작 성 일 : 2011. 06. 24
* 개    요 : 우편번호 팝업
* 사용방법 : getPostPop(objCd, objNm1,objNm2)
*            arguments[0] -> 팝업 그리드 더블클릭시 우편번호를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 주소1을 받아올 EMEDIT ID
*            arguments[2] -> 팝업 그리드 더블클릭시 주소2를 받아올 EMEDIT ID
* return값 : array
*/

function getPostPop(objPostNo,objAddr1,objAddr2)
{
	
	
    var rtnMap  = new Map();
    var arrArg  = new Array();

    arrArg.push(rtnMap);

    var returnVal = window.showModalDialog("/edi/ccom002.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		var map = arrArg[0];
		document.getElementById(objPostNo).value = convertZip(map.get("POST_NO"));
		document.getElementById(objAddr1).value = map.get("ADDR1");
		document.getElementById(objAddr2).value = map.get("ADDR2");
		document.getElementById(objAddr2).focus();	
 	}
    
}

/**
* getPostPop()
* 작 성 자 : FKL
* 작 성 일 : 2012. 06. 26
* 개    요 : 우편번호 팝업
* 사용방법 : getPostPop(objCd, objNm1,objNm2)
*            arguments[0] -> 팝업 그리드 더블클릭시 우편번호1를 받아올 EMEDIT ID
*            arguments[1] -> 팝업 그리드 더블클릭시 우편번호2를 받아올 EMEDIT ID
*            arguments[2] -> 팝업 그리드 더블클릭시 주소1을 받아올 EMEDIT ID
*            arguments[3] -> 팝업 그리드 더블클릭시 주소2를 받아올 EMEDIT ID
* return값 : array
*/

function getPostPop2(objPostNo1,objPostNo2,objAddr1,objAddr2)
{
	
	
    var rtnMap  = new Map();
    var arrArg  = new Array();
    var strVal = "";
    var strPost1 = "";
    var strPost2 = "";

    arrArg.push(rtnMap);

    var returnVal = window.showModalDialog("/edi/ccom002.cc?goTo=list",
                                           arrArg,
                                           "dialogWidth:540px;dialogHeight:450px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
  	if (returnVal){
		var map = arrArg[0];
		
		strVal = getRawZip(map.get("POST_NO"));
		
		if (strVal.length==6) {
			strPost1 = strVal.substring(0,3);
			strPost2 = strVal.substring(3,6);
		} else if(strVal.indexOf("-")>0) {
			var arrTmp = strVal.split("-");
			strPost1 = arrTmp[0];
			strPost2 = arrTmp[1];
		}
		
		document.getElementById(objPostNo1).value = strPost1;
		document.getElementById(objPostNo2).value = strPost2;
		document.getElementById(objAddr1).value = map.get("ADDR1");
		document.getElementById(objAddr2).value = map.get("ADDR2");
		document.getElementById(objAddr2).focus();	
 	}
    
}

/**
* setAddCondition()
* 작 성 자 : FKL
* 작 성 일 : 2011-01-22
* 개    요 : 공통 POP 쿼리 생성시 사용 
* 사용방법 : setAddCondition(argsLength, arguments)
*            arguments[0] -> 필수조건의 argument 갯수
*            arguments[1] -> 호출한 function 의 argument Object
*
* 실행  예) setAddCondition(5, arguments);
*
* return값 : void
*/
function setAddCondition() {
	var startPoint = arguments[0];
	var args 	   = arguments[1];
	var rvalue = '';
	
	if( args.length > startPoint ) {
		rvalue = args[startPoint];
		for( var i=startPoint+1; i<args.length; i++ ) {
			rvalue += "#G#";
			rvalue += args[i];
		}
	}
	return rvalue;
}

/**
* helpPop()
* 작 성 자 : HSEON
* 작 성 일 : 2011-06-21
* 개    요 : 도움말 팝업
* 사용방법 : helpPop(strPid:프로그램ID)
* 실행  예) helpPop("TCOM101");
* return값 : void
*/
function helpPop(strPid)
{
    var returnVal = window.showModalDialog("/edi/ccom003.cc?goTo=helpPop",
    										strPid,
                                           "dialogWidth:750px;dialogHeight:700px;scroll:no;" +
                                           "resizable:no;help:no;unadorned:yes;center:yes;status:no");
}
