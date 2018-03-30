 
/****************************************************************************
 * 공통 기능에서 사용하는 상수값 선언 부분 
 ****************************************************************************
 * @author  : 최재원
 * @date    : 2008.09.05
 * @version : 1.9
 * @history : 2009/02/24 - 세션 처리를 위한 session객체 추가
 *            2009/03/02 - gforms에서 form간의 파라미터 처리를 위한 request객체 추가
 *            2009/03/04 - Session에서 동기화 하기 위하여 SyncLoad=true로 추가
 *                         date객체 추가 및 getDate(format), getComplexDate(format, type, size) 메소드 추가
 *            2009/03/06 - STYLE_GRID기능 처거 [gss에서 처리]
 *            2009/03/26 - OnDataError객체 오류 수정 [ 내부 ref객체 이름이 잘못 지정됨 ]
 *            2009/04/02 - getParameter메소드에서 encodeURIComponent처리 기능 추가  및 파싱 처리할 객체 추가
 *            2009/04/06 - getParameter메소드에서 input type=checkbox에 대해 처리 가능하도록 수정
 *            2009/04/07 - USE_ENCODING 값 defaut로 UTF-8로 설정 [encodeURIComponent로 유니코드로 파라미터 전송]
 ****************************************************************************/


/**********************************************************************************************
 *  내부에서 사용할 컴포넌트의 CLSID를 정의해 줍니다. 
 **********************************************************************************************/
var DS_CLSID = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";	  // 데이터셋
var TR_CLSID = "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5";	  // 트랜젝션 
var UNI_DS_CLSID = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";  // 유니코드 데이터셋
var UNI_TR_CLSID = "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8";  // 유니코드 트랜젝션

var COMBO_CLSID = "CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197";			// 코드 콤보
var EMEDIT_CLSID = "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F";		// 마스크 에디터
var TEXTAREA_CLSID = "CLSID:2F5DF8D9-F63C-460E-B5CB-399E816B0274";		// 텍스트 AREA
var RADIO_CLSID = "CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0";			// 라디오 버튼

var UNI_COMBO_CLSID = "CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E";		// 유니코드 코드 콤보
var UNI_EMEDIT_CLSID = "CLSID:D7779973-9954-464E-9708-DA774CA50E13";	// 유니코드 마스크 에디터
var UNI_TEXTAREA_CLSID = "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F";	// 유니코드 텍스트 AREA
var UNI_RADIO_CLSID = "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC";		// 유니코드 라디오 버튼


/**********************************************************************************************
 * 로그인 실패시 이동할 페이지를 정의하는 부분
 **********************************************************************************************/
var LOGIN_PAGE = "/index.jsp";		

/**********************************************************************************************
 * 세션 만료시에 화면에 출력한 메시지를 정의 합니다. 
 **********************************************************************************************/
var SESSION_EXPIRE_MESSAGE = "세션이 만료되었습니다.\n다시 로그인 해주세요!";

/**********************************************************************************************
 *  컴포넌트 모드를 설정합니다. 
 *  -  EUC-KR : 한글 전용, UTF-8 : 유니코드 (대문자로 설정해야 하며, UTF-8로 사용시에는
 *      본 파일을 UTF-8로 저장해 주셔야 합니다.
 **********************************************************************************************/
var MODE = "EUC-KR";

/**********************************************************************************************
 * getParameter의 encodeURIComponent기능을 사용할지 여부를 정의 합니다.
 * USE_ENCODING 속성이 true인 경우에는 UTF-8형식으로 파라미터가 전송이 되며, beaver.xml의 character-encoding
 * 설정을 UTF-8로 해주어야 합니다. [default]
 * <character-encoding value="UTF-8"/>
 * @date    : 2009.04.02
 **********************************************************************************************/
 var USE_ENCODING = true;
 
 
/**********************************************************************************************
 * 2008/10/28 SelectProcess()기능 관련 추가 사항
 *---------------------------------------------------------------------------------------------
 * Context명이 Root(/)가 아닌 경우 SelectProcess에서 /common/retrieveDefault.bf 호출시 
 * 해당 Action을 찾지 못하는 문제가 발생하기 때문에 아래 CONTEXT_ROOT값이 해당 시스템에 맞게 
 * Context명을 넣어준다 
 *  ex) http://localhost:7001/eduma/index.jsp와 같은 형태에서 context명이 eduma인 경우
 *       CONTEXT_ROOT 값에 eduma라고 입력해 주면 됩니다.
 **********************************************************************************************/
var CONTEXT_ROOT = "";

/**********************************************************************************************
 * 공통 기능에서 사용하는 Function/Object 선언 부분 
 **********************************************************************************************
 * @author  : 최재원
 * @date    : 2008.09.05
 * @version : 1.0
 **********************************************************************************************/

/**
 * Context Root의 위치를 반환하는 메소드.
 **/
function getRoot() {
	return CONTEXT_ROOT;
}

/**
 * 화면의 특정 TAG안에 있는 INPUT, SELECT, 컴포넌트[EmEdit, LuxeCombo, Radio]의 
 * 내용을 파라미터로 반환하는 함수
 * - usage : getParameter("DIV, SPAN등의 TAG의 ID");
 * @author  : 최재원
 * @date    : 2008.09.05
 * @version : 1.0
 * @history : 2009.04.02 - encodeURIComponent 기능  및 TEXTAREA 추가
 **/
function getParameter(obj) {
	var LUXECOMBO = "";
	var TEXTAREA = "";
	var EMEDIT = "";
	var RADIO = "";
	
	if (MODE.toUpperCase() == "EUC-KR") {
		LUXECOMBO = COMBO_CLSID;
		TEXTAREA = EMEDIT_CLSID;
		EMEDIT = TEXTAREA_CLSID;
		RADIO = RADIO_CLSID;
	} else if (MODE.toUpperCase() == "UTF-8") {
		LUXECOMBO = UNI_COMBO_CLSID;
		TEXTAREA = UNI_EMEDIT_CLSID;
		EMEDIT = UNI_TEXTAREA_CLSID;
		RADIO = UNI_RADIO_CLSID;
	}
		
	var LIST = obj;
	var PARAM = "";
	for (i=0; i < LIST.all.length; i++) {
		var obj = LIST.all[i];
		switch(obj.tagName) {
			case "INPUT":
				if (obj.type == "button") {
					break;
				} else if (obj.type== "checkbox") {
					if (USE_ENCODING == true) {
						PARAM += "&" + obj.id + "=" + encodeURIComponent(obj.checked);
					}  else {
						PARAM += "&" + obj.id + "=" + obj.checked;
					}
					break;
				} else {
					if (USE_ENCODING == true) {
						PARAM += "&" + obj.id + "=" + encodeURIComponent(obj.value);
					}  else {
						PARAM += "&" + obj.id + "=" + obj.value;
					}
					break;
				}
				break;
			case "TEXTAREA":
			case "SELECT":
				if (USE_ENCODING == true) {
					PARAM += "&" + obj.id + "=" + encodeURIComponent(obj.value);
				}  else {
					PARAM += "&" + obj.id + "=" + obj.value;
				}
				
				break;
			case "OBJECT":
				var clsid = obj.classid.toUpperCase();
				if (clsid == LUXECOMBO) {		// 럭스 콤보 [BindColVal]
					if (USE_ENCODING == true) {
						PARAM += "&" + obj.id + "=" + encodeURIComponent(obj.BindColVal);
					}  else {
						PARAM += "&" + obj.id + "=" + obj.BindColVal;
					}
					
				} else if (clsid == EMEDIT) {	// EMEdit [Text]
					if (USE_ENCODING == true) {
						PARAM += "&" + obj.id + "=" + encodeURIComponent(obj.text);
					}  else {
						PARAM += "&" + obj.id + "=" + obj.text;
					}
				} else if (clsid == TEXTAREA) {	// TextArea [Text]
					if (USE_ENCODING == true) {
						PARAM += "&" + obj.id + "=" + encodeURIComponent(obj.text);
					}  else {
						PARAM += "&" + obj.id + "=" + obj.text;
					}
				} else if (clsid == RADIO) {	// Radio [CodeValue]
					if (USE_ENCODING == true) {
						PARAM += "&" + obj.id + "=" + encodeURIComponent(obj.CodeValue);
					}  else {
						PARAM += "&" + obj.id + "=" + obj.CodeValue;
					}
				}
				break;
		}
	}
	return PARAM;
}


/**
 * 간단한 데이터 조회를 위한 SelectProcess 객체
 *
 * @author  : 최재원
 * @date    : 2008.09.03
 * @version : 1.0
 **/
function SelectProcess(obj) {
	var dataset = obj;
	this.dataid = getRoot() +  "/common/retrieveDefault.bf";
	this.param = "";
	this.modelset = null;
	this.model = null;
	this.execute = null;

	this.reset = function() {
		if (this.dataid == null && dataset.dataid == "") {
			alert("DataId가 입력되지 않았습니다.\nDataId를 입력후에 사용해 주세요.");
			return;
		} else if (this.dataid != null) {
			dataset.dataid = this.dataid;
		}
			
		if (this.modelset == null) {
			alert("Beaver ModelSet이 입력되지 않았습니다.\nBeaver ModelSet을 입력해주세요.");
			return;
		}

		if (this.execute == null) {
			alert("Execute가 입력되지 않았습니다.\nExecute를 입력해주세요.");
			return;
		}

		var id = "?MODEL_SET=" + this.modelset + "&EXECUTE=" + this.execute;

		dataset.dataid = this.dataid + id + this.param;
		
		dataset.reset();
	}
}


var DATASET_LIST = [];		// 데이터셋 리스트 보관용 [검증]
var IGNORE_DATASET_LIST = "MAKE_HEADER_GDS,SERVER_SESSION_DS,SERVER_DATE_DS";
/**
 * COMPONENT_INITIALIZE ::: 컴포넌트에 이벤트 할당 처리 [전처리]
 *
 * @author  : rogerrb
 * @date    : 2008.09.04
 * @version : 1.0
 **/
function COMPONENT_INITIALIZE() {

	if (document.readyState == "complete") {
		var objList = document.getElementsByTagName ("object");
		// 그리드 컴포넌트만 선행 처리
		for (i=0;i<objList.length ;i++)	{
			var obj = objList[i];
			if ( obj.classid.toUpperCase() == "CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B") {
				try {
					var GAUCE_DATASET = eval(obj.DataId);
					var dataErrorCheck = GAUCE_DATASET.dataErrorCheck;
					
					if (typeof(dataErrorCheck) == "undefined" || dataErrorCheck.toUpperCase() == "TRUE") {
						DATASET_LIST[obj.DataId] = obj.DataId;	// 중복 이벤트 적용 방지
						new DataSetOnDataError(GAUCE_DATASET, obj);
					} else if (dataErrorCheck.toUpperCase() == "FALSE") {
						// to do
					}

				} catch (exception) {
					// 디버그에 사용되는 그리드는 제외
					if (obj.id != "DATASET_GRID") {
						alert("그리드 [" + obj.id + "]에 연결된 데이터셋 [" + obj.dataid + "]를 찾을수 없습니다.\n" +
						      "소스를 확인해 주십시오.");
					}
					
				}
			}
		}

		for (i=0;i<objList.length ;i++)	{
			var obj = objList[i];
			// 데이터셋 컴포넌트
			if (obj.classid.toUpperCase() == "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" && IGNORE_DATASET_LIST.indexOf(obj.id) == -1) {	// 데이터셋 객체
				// syncload = true추가
				obj.syncload = true;
				
				if ( typeof(DATASET_LIST[obj.id]) == "undefined") {
					var dataErrorCheck = obj.dataErrorCheck;
					// 수정 해야됨 - 세션 및 날짜 데이터셋  
					if (typeof(dataErrorCheck) == "undefined" || dataErrorCheck.toUpperCase() == "TRUE") {
						new DataSetOnDataError(obj); // 이벤트 할당
					} else if (dataErrorCheck.toUpperCase() == "FALSE") {
						// to do
					}
				}
				new DataSetOnLoadError(obj); // 이벤트 할당
			// 트랜젝션 컴포넌트
			} else if (obj.classid.toUpperCase() == "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5") {
				new TrOnFail(obj);
			
			// 그리드 컴포넌트
			}
		}
	}
}


/**
 * 데이터셋 컴포넌트 에러처리[OnLoadError]
 * @author  : rogerrb
 * @date    : 2008.09.04
 * @version : 1.0
 **/
function DataSetOnLoadError(obj) {
	var GAUCE_DATASET = obj;

	this.onLoadError = function(row,colid) {
		var errorCode = GAUCE_DATASET.ErrorCode;
		var errorMsg = GAUCE_DATASET.errorMsg;
		
			if ( errorMsg.indexOf("SESSION_EXPIRED") != -1 ) {
				alert(SESSION_EXPIRE_MESSAGE);
				parent.location.href = LOGIN_PAGE;
			} else if (errorCode == "50015") {
				errorMsg = errorMsg.substring(errorMsg.indexOf("[INTERNAL-7500]")+16);
				alert(errorMsg);
			} else {
				alert("Error Code : " + errorCode + "\n" + "Error Message : " + errorMsg + "\n");
			}
	}

	GAUCE_DATASET.attachEvent("OnLoadError", this.onLoadError);
}

/**
 * 데이터셋 컴포넌트 에러처리[OnDataError]
 * @author  : rogerrb
 * @date    : 2008.09.04
 * @version : 1.0
 * @history : 2009.03.24 - 2개 이상의 데이터셋 있을 경우 이벤트 참조 오류 수정
 **/
function DataSetOnDataError(obj, grid) {
	var GAUCE_DATASET = obj;
	var GRID = grid;
	
	/**
	 * OnDataError공통 처리용 이벤트 Callback함수 [private]
	 * - 데이터셋에 대한 검증용
	 *
	 * @author  : 최재원
	 * @date    : 2008.09.04
	 * @version : 1.0
	 **/
	dataSetError = function(ds, row, colid) {
		if (ds.ErrorCode == "50018") {			// NOT NULL
			alert("데이터셋 [" + ds.id +"]의 [" + colid + "]컬럼은 필수 입력 입니다.\n" + 
				  "[" + row + "]번째 ROW의 [" + colid + "]컬럼에 값을 입력해 주십시오");
			ds.RowPosition = row;
		} else if (ds.ErrorCode == "50019") {	// KEY
			var MSG = ds.ErrorMsg;
			var DUPLICATE_ROW = MSG.substring(MSG.indexOf("DuplicateRow:")+13, MSG.indexOf(")"));
			alert("데이터셋 [" + ds.id +"]의 [" + row + "] 번째 ROW의 값이 " + 
				  "[" + DUPLICATE_ROW + "]번째 ROW의 값과 중복 입력되었습니다.\n" + 
				  "[" + row + "]번째 ROW에 값을 확인해 주십시오.");

			ds.RowPosition = row;
		} else {
			alert("Error Code : " + ds.ErrorCode + "\n" + "Error Message : " + ds.ErrorMsg + "\n");
		}
	}


	/**
	 * 데이터셋의 키 컬럼을 반환하는 내부 메소드
	 *
	 * @author  : 최재원
	 * @date    : 2008.09.05
	 * @version : 1.0
	 **/
	keycolumn = function(ds) {
		var columnCnt = ds.CountColumn;
		var headerInfo = "";
		var keycolumnList = new Array();

		for (i=1; i<=columnCnt; i++) {
			var columnName = ds.ColumnID(i);
			var colProp = ds.ColumnProp(i);
			if (colProp == 2){
				keycolumnList[keycolumnList.length] = columnName;
			}
		}
		return keycolumnList;
	}


	/**
	 * 데이터셋의 키 컬럼ID을 그리드에 컬럼명으로 반환하는 내부 메소드
	 *
	 * @author  : 최재원
	 * @date    : 2008.09.05
	 * @version : 1.0
	 **/
	gridColumnName = function(keyColumnList, grid) {
		var returnValue = "";
		for (i=0; i<keyColumnList.length ; i++) {

			var colName = grid.ColumnProp(keyColumnList[i], "name");	

			if (i == keyColumnList.length-1) {
				if (typeof(colName) == "undefined") {
					returnValue += keyColumnList[i];
				} else {
					returnValue += colName;
				}
			} else {
				if (typeof(colName) == "undefined") {
					returnValue += keyColumnList[i] + ",";
				} else {
					returnValue += colName + ", ";
				}
			}
			
		}

		return returnValue.substring(0, returnValue.length);
	}


	/**
	 * OnDataError공통 처리용 이벤트 Callback함수
	 *
	 * @author  : 최재원
	 * @date    : 2008.09.04
	 * @version : 1.0
	 **/
	onDataError = function(row,colid) {

		if (typeof(GRID) == "undefined") {			// 데이터셋을 통한 데이터에러 처리
			dataSetError(GAUCE_DATASET, row, colid);

		} else {									// 그리드를 통한 데이터 에러 처리
			var colName = GRID.ColumnProp(colid, "name");
		
			// 키 컬럼 LIST
			var keyColumnList = keycolumn(GAUCE_DATASET);

			// 그리드 컬럼
			var korColumnName = gridColumnName(keyColumnList, GRID);
			// 그리드에 컬럼이 존재하지 않는 경우 처리.
			if (typeof(colName) == "undefined" && GAUCE_DATASET.ErrorCode != "50019") {
				
				dataSetError(GAUCE_DATASET, row, colid);
			} else {
				if (GAUCE_DATASET.ErrorCode == "50018") {			// NOT NULL
					alert("[" + colName + "]은 필수 입력 입니다.\n" + 
						  "[" + row + "]번째 [" + colName + "]의 값을 입력해 주십시오.");
					GAUCE_DATASET.RowPosition = row;
					try {
						GRID.setColumn(colid);
					}catch (exception){}
					
				} else if (GAUCE_DATASET.ErrorCode == "50019") {	// KEY
					var MSG = GAUCE_DATASET.ErrorMsg;
					var DUPLICATE_ROW = MSG.substring(MSG.indexOf("DuplicateRow:")+13, MSG.indexOf(")"));
					alert("[" + korColumnName + "]의 값이 [" + DUPLICATE_ROW + "]번째와 중복 입력되었습니다.\n" +
						  "[" + korColumnName + "]은 중복 입력이 될 수 없습니다.\n" +
						  "[" + row + "]번째 데이터 값을 확인해주십시오.");

					GAUCE_DATASET.RowPosition = row;					
				} else {
					alert("Error Code : " + GAUCE_DATASET.ErrorCode + "\n" + "Error Message : " + GAUCE_DATASET.ErrorMsg + "\n");
				}
			}
		}
		
	}

	GAUCE_DATASET.attachEvent("OnDataError", onDataError);
}


/**
 * 트랜젝션 컴포넌트 에러처리 [OnFail]
 * @author  : rogerrb
 * @date    : 2008.09.04
 * @version : 1.0
 **/
function TrOnFail(obj) {
	var TR = obj;

	this.onFail = function() {
		var errorCode = TR.ErrorCode;
		var errorMsg = TR.errorMsg;
		
			if ( errorMsg.indexOf("SESSION_EXPIRED") != -1 ) {
				alert(SESSION_EXPIRE_MESSAGE);

				// 로그인 페이지로 이동... [해당 시스템에 맞게 수정]
				parent.location.href = LOGIN_PAGE;
			} else if (errorCode == "50015") {
				errorMsg = errorMsg.substring(errorMsg.indexOf("[INTERNAL-7500]")+16);
				alert(errorMsg);
			} else {
				alert("Error Code : " + errorCode + "\n" + "Error Message : " + errorMsg + "\n");
			}
	}

	TR.attachEvent("OnFail", this.onFail);
}





  var request = null;

  /****************************************************************
   * Gforms에서 파라미터를 받아서 처리 하기 위한 사용자 정의 객체
   *
   * @date		: 2009/03/02
   * @author	: 최재원
   * @method  : getParameter("키값");
   ****************************************************************/
  function Request() {
  	var url = location.href;
	var param = new Object();
	if (url.indexOf("?") != -1) {
		var queryString =url.substring(url.indexOf("?")+1);
		var paramList = queryString.split("&");
		for (i=0; i<paramList.length; i++ )
		{
			var tmp = paramList[i];
			tmp = tmp.split("=");
			str = "param." + tmp[0] + "= '" + tmp[1] + "'";
			eval(str);
		}
	}
	
	/**
	 * request.getParameter("키값");
	 **/
	this.getParameter = function (str) {

		var result = eval("param." + str);
		if (typeof(result) == "undefined") {
			alert("입력한 파라미터 [" + str + "]가 존재 하지 않습니다.");
			return null;
		} else {
			return result;
		}
	}
  }


request = new Request();


// 세션을 가지고 있는 객체
var session = null;


/*****************************************************************************
 * 세션을 화면에서 사용하기 위한 사용자 정의 객체.
 *****************************************************************************
 * @date	2009/02/24
 * @method 	getAttribute("세션Key") - 세션의 지정된 이름으로 저장된 값을 반환
 * @method 	valid()	- 세션이 정상적인지를 체크한다.
 * @histody 2009/03/04 - SyncLoad관련 기능 추가
 *****************************************************************************/
function Session() {
	var SESSION_DS = null;
	if (document.all("SERVER_SESSION_DS") == null) {
		SESSION_DS = document.createElement("<OBJECT>");
		if (MODE.toUpperCase() == "EUC-KR") {
			SESSION_DS.classid = DS_CLSID;
		} else if (MODE.toUpperCase() == "UTF-8") {
			SESSION_DS.classid = UNI_DS_CLSID;
		}
		SESSION_DS.id = "SERVER_SESSION_DS";
		SESSION_DS.syncload = "true";
	}

	for (i = 0; i < document.all.length; i++) {
		if (document.all[i].tagName == "HEAD") {
			document.all[i].insertAdjacentElement("beforeEnd", SESSION_DS);
			break;
		}
	}

	SESSION_DS.dataid =  getRoot() + "/common/retrieveSession.bf";
	SESSION_DS.reset();

	// 세션에 저장된 값을 꺼내는 메소드
	this.getAttribute = function(key) {
		if (SESSION_DS.countRow == 0) {
			alert("세션값이 설정되어있지 않습니다.");
			return null;
		} else {
			if (SESSION_DS.ColumnIndex(key) == 0)  {
				alert("입력한 [" + key + "]에 해당하는 세션값이 존재하지 않습니다.");
				return null;
			}
			return SESSION_DS.NameValue(1, key);
		}
	}

	// 세션이 올바른지를 판단하는 메소드
	this.valid = function() {
		if (SESSION_DS.countRow == 0)	{
			alert(SESSION_EXPIRE_MESSAGE);
			location.href = LOGIN_PAGE;
		}
	}

}

session = new Session();





// 날짜 정보를 가지고 있는 객체
var date = null;


/*****************************************************************************
 * 서버 시간을 화면에서 사용하기 위한 사용자 정의 객체.
 *****************************************************************************
 * @date	2009/03/04
 * @method 	getDate("세션Key") - 현재 서버날짜를 지정된 포맷으로 반환하는 메소드
 * @method 	getComplexDate(format, type, size)	
 *          - 서버의 날짜를 현재 기준으로 년, 월, 일을 지정하여 이전, 이후 날짜를 반환하는 메소드
 * @histody 2009/03/04 - 신규작성
 *****************************************************************************/
function ServerDate() {
	var SERVER_DATE_DS = null;
	var CURRENT_DATE_PARAM = "";	// 현재 날짜에서 사용한 파라미터 저장
	var CURRENT_DATE = "";			// 현재 날짜
	var COMPLEX_DATE_PARAM = "";	// 복합적인 날짜 계산에서 사용한 파라미터 저장
	var COMPLEX_DATE = "";			// 복합적인 날짜 
	if (document.all("SERVER_DATE_DS") == null) {
		SERVER_DATE_DS = document.createElement("<OBJECT>");
		if (MODE == "EUC-KR") {
			SERVER_DATE_DS.classid = DS_CLSID;
		} else if (MODE == "UTF-8") {
			SERVER_DATE_DS.classid = UNI_DS_CLSID;
		}
		SERVER_DATE_DS.id = "SERVER_DATE_DS";
		SERVER_DATE_DS.syncload = "true";
	}

	for (i = 0; i < document.all.length; i++) {
		if (document.all[i].tagName == "HEAD") {
			document.all[i].insertAdjacentElement("beforeEnd", SERVER_DATE_DS);
			break;
		}
	}

	/**
	 * 서버의 날짜를 반환해오는 메소드
	 * @param format 날짜 포멧을 지정 ex) yyyyMMdd hh:mm:ss
	 **/
	this.getDate = function(format) {
		if (typeof(format) == "undefined" || format == "") format = "yyyyMMdd";
		SERVER_DATE_DS.dataid = getRoot() + "/common/getDate.bf?FORMAT=" + format;
		if (SERVER_DATE_DS.dataid == CURRENT_DATE_PARAM) {
			return CURRENT_DATE;
		} else {
			CURRENT_DATE_PARAM = SERVER_DATE_DS.dataid;
			SERVER_DATE_DS.reset();
			CURRENT_DATE = SERVER_DATE_DS.NameValue(1, "DATE");
			return CURRENT_DATE;
			
		}
	}
	
	/**
     * 오늘 날짜를 기준으로 타입[(연('Y'), 월('M'), 일('D'), 주('W'))]에 따라 증감을 하여 지정한 포멧에 맞게 반환하는 메소드
     * 
     * @param format	날짜 포멧  ex) yyyy-MM-dd HH:mm:ss
     * @param type		연(Year) 'Y', 월(Month) 'M', 일(Day) 'D', 주(Week) 'W'
     * @param size		정수형 증감값
	 **/
	this.getComplexDate = function(format, type, size) {
		if (typeof(format) == "undefined" || format == "") format = "yyyyMMdd";
		
		if (typeof(type) == "undefined" || type == "") type = "D";
		
		if (typeof(size) == "undefined" || size == "") size = "0";
		
		SERVER_DATE_DS.dataid = getRoot() + "/common/getComplexDate.bf?FORMAT=" + format + "&TYPE=" + type + "&SIZE=" + size;
		if (SERVER_DATE_DS.dataid == COMPLEX_DATE_PARAM) {
			return COMPLEX_DATE;
		} else {
			COMPLEX_DATE_PARAM = SERVER_DATE_DS.dataid;
			SERVER_DATE_DS.reset();
			COMPLEX_DATE = SERVER_DATE_DS.NameValue(1, "DATE");
			return COMPLEX_DATE;
			
		}
	}
	
}

date = new ServerDate();


/***********************************************************************************************
 * 가우스를 사용시 프로그래스(조회중, 처리중)을 표시해주는 오브젝트
 * @author : 최재원
 * @history : 2007/12/28 - 유니코드 추가 및 이벤트 할당/제거를 ref멤버 변수로 처리
 *            2008/01/21 - LogicalTR과 통합
 ***********************************************************************************************
 * usage : var rs = new Progress();	// 객체 생성.
 *             
 *         rs.submit(데이터셋오브젝트, x좌표, y좌표);			// 데이터셋을 통한 조회시
 *  
 *         rs.submit(트랜젝션오브젝트, x좌표, y좌표);			// 트랜젝션 처리시
 *  
 *         rs.submit(트랜젝션오브젝트, "R", x좌표, y좌표);	    // 트랜젝션 컴포넌트로 조회시
 *
 ***********************************************************************************************/
function Progress() {

	var GLB_SUBMIT_STATUS = false;	// reset/post 중복방지.
	var GLO_OBJECT = document.all;
	var GLO_INTERVAL = "";
	var GLO_TEMP_OBJECT = "";

	var CALL_BACK_FUNCTION = null;	//CALL BACK함수

	var ds_html = "<body leftmargin=0 topmargin=0><center><table cellpadding=0 cellspacing=0><tr><td>" +
			      "<img src='./image/ing01.gif'></td></tr></table></center></body>";

	var tr_html = "<body leftmargin=0 topmargin=0><center><table cellpadding=0 cellspacing=0><tr><td>" +
				  "<img src='./image/ing02.gif'></td></tr></table></center></body>";

	this.setCallBackFunction = function(param) {
		CALL_BACK_FUNCTION = param;
	}

	//	정상적으로 실행된 경우 메시지 출력 및 프로그래스 제거.
	this.close = function() {

		GLB_SUBMIT_STATUS = false;
		try {
			GLO_OBJECT.oProgressBar.outerHTML = "";
		} catch(exception) {}

		for (i=0; i<GLO_OBJECT.length; i++) {
			try {
				if (GLO_OBJECT[i].type.toUpperCase() == "BUTTON") {
					GLO_OBJECT[i].disabled = false;
				}

			} catch (exception) {}
		}
		
		/** 정상적으로 실행된 경우에 서버에서 메시지를 전송한 경우 해당 메시지를 출력해 준다. **/
		if (GLO_TEMP_OBJECT.ErrorMsg.trim() != "") {
			alert(GLO_TEMP_OBJECT.ErrorMsg);
		}

		// 이벤트를 제거하여 준다.
		if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			 GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				GLO_TEMP_OBJECT.detachEvent ('OnLoadCompleted', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnLoadError', EVENT_VIEW_ERROR);


		} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			        GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션.
				GLO_TEMP_OBJECT.detachEvent ('OnSuccess', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnFail', EVENT_VIEW_ERROR);
		}

		try {
			eval(CALL_BACK_FUNCTION + "()");
		} catch (exception) {}

	}

	/**  에러가 발생한 경우 에러를 표시 및 프로그래스바를 제거  **/
	this.viewError = function() {
		GLB_SUBMIT_STATUS = false;
		GLO_OBJECT.oProgressBar.outerHTML = "";

		for (i=0; i<GLO_OBJECT.length; i++) {
			try {
				if (GLO_OBJECT[i].type.toUpperCase() == "BUTTON") {
					GLO_OBJECT[i].disabled = false;
				}

			} catch (exception) {}
		}
		
		/*************************************************************************
		 * 프로젝트별로 커스터 마이징이 필요한 부분
		 *************************************************************************
		 * 서비스 실행시 오류가 발생한 경우 해당 오류를 출력해 준다. 
		 * 이부분에서 서비스에서 넘어온 Exception타입에 따라 Biz, SysException등에
		 * 따라 팝업창, alert유형등으로 처리해 주면 된다. 
		 *************************************************************************/
		alert(GLO_TEMP_OBJECT.ErrorMsg);

		// 이벤트를 제거하여 준다.
		if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			 GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				GLO_TEMP_OBJECT.detachEvent ('OnLoadCompleted', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnLoadError', EVENT_VIEW_ERROR);

		} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			        GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션.
				GLO_TEMP_OBJECT.detachEvent ('OnSuccess', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnFail', EVENT_VIEW_ERROR);
		}

	}

	// 실제 reset/post수행
	this.submit = function() {

		/** 중복 처리를 막기 위해 처리한 부분 **/
		if (GLB_SUBMIT_STATUS == true)	{
			alert("처리중입니다.\n잠시만 기다려 주십시오.");
			return;
		}
		GLB_SUBMIT_STATUS = true;
		if (arguments.length == 1)	{
			try {
				GLO_TEMP_OBJECT = arguments[0];
			} catch (exception) {
				try {
					GLO_OBJECT.oProgressBar.style.top = arguments[0];
				} catch (exception) {}
			}
			this.create(GLO_TEMP_OBJECT);
		} else if (arguments.length == 2) {
			try {
				GLO_TEMP_OBJECT = arguments[0];
			} catch (exception) {
				try {
					GLO_OBJECT.oProgressBar.style.top = arguments[0];
				} catch (exception) {}
			}
			this.create(GLO_TEMP_OBJECT, arguments[1]);
		} else if (arguments.length == 3) {
			try {
				GLO_TEMP_OBJECT = arguments[0];
			} catch (exception) {
				try {
					GLO_OBJECT.oProgressBar.style.top = arguments[0];
				} catch (exception) {}
			}
			this.create(GLO_TEMP_OBJECT, arguments[1], arguments[2]);

		} else if (arguments.length == 4) {
			try {
				GLO_TEMP_OBJECT = arguments[0];
			} catch (exception) {
				try {
					GLO_OBJECT.oProgressBar.style.top = arguments[0];
				} catch (exception) {}
			}
			this.create(GLO_TEMP_OBJECT, arguments[1], arguments[2], arguments[3]);
		}

			if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
					GLO_TEMP_OBJECT.attachEvent ('OnLoadCompleted', EVENT_CLOSE);
					GLO_TEMP_OBJECT.attachEvent ('OnLoadError', EVENT_VIEW_ERROR);
			} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션 오브젝트.
					GLO_TEMP_OBJECT.attachEvent ('OnSuccess', EVENT_CLOSE);
					GLO_TEMP_OBJECT.attachEvent ('OnFail', EVENT_VIEW_ERROR);
			} else {
				alert("가우스 데이터셋/트랜젝션 컴포넌트가 아닙니다.\n데이터셋/");
			}

		try	{
			GLO_OBJECT.oProgressBar.style.visibility="visible";
		} catch (exception) {}
		GLO_INTERVAL = window.setInterval(this.progress,300);
	}

	this.create = function() {
		var progress = '<iframe  id=oProgressBar style="position:absolute;visibility:hidden;width:255;height:65;" marginwidth="0" marginheight="0" scrolling="no" frameborder=0></iframe>';
		var doc = null;
		for (var i = 0; i < document.all.length; i++) {
			if (document.all[i].tagName.toUpperCase() == "BODY") {
				document.all[i].insertAdjacentHTML("beforeEnd", progress);
				doc = oProgressBar.document;
				break;
			}
		}
		if (doc == null) {
			alert("HTML Document에 body테그가 없습니다.");
			return;
		}

		doc.open("text/html");

		try	{
			if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				doc.write(ds_html);
			} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션 오브젝트.

				if(arguments[1] == "R") {
					doc.write(ds_html);
				} else {
					doc.write(tr_html);
				}

			}
		} catch (exception) {
				doc.write(tr_html);
		}
		doc.close();

		/** 파라미터에 따라 처리 하는 부분 **/
		try	{
			GLO_OBJECT.oProgressBar.style.zIndex = 0;
			if (arguments.length==3) {
				GLO_OBJECT.oProgressBar.style.left = arguments[1];
				GLO_OBJECT.oProgressBar.style.top = arguments[2];
			} else if (arguments.length == 4) {
				GLO_OBJECT.oProgressBar.style.left = arguments[2];
				GLO_OBJECT.oProgressBar.style.top = arguments[3];
			} else {
				GLO_OBJECT.oProgressBar.style.left = 360;
				GLO_OBJECT.oProgressBar.style.top = 210;
			}	

		} catch (exception)	{	
			alert("처리중입니다.\n잠시만 기다려 주십시오.");
			return;
		}
	}

	this.progress = function() {

		for (i=0; i<GLO_OBJECT.length; i++) {
			try {
				if (GLO_OBJECT[i].type.toUpperCase() == "BUTTON") {
					GLO_OBJECT[i].disabled = true;
				}
			} catch (exception) {}
		}

		window.clearInterval(GLO_INTERVAL);

		try	{
			if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// 데이터셋.
				GLO_TEMP_OBJECT.reset();
			} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // 트랜젝션 오브젝트.
				GLO_TEMP_OBJECT.post();
			}
		} catch (exception) {
			document.form1.submit();
		}
	}
	
	/** 이벤트 ref변수 **/
	var EVENT_VIEW_ERROR = this.viewError;
	var EVENT_CLOSE = this.close;
}


document.onreadystatechange = COMPONENT_INITIALIZE;

