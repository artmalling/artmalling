 
/****************************************************************************
 * ���� ��ɿ��� ����ϴ� ����� ���� �κ� 
 ****************************************************************************
 * @author  : �����
 * @date    : 2008.09.05
 * @version : 1.9
 * @history : 2009/02/24 - ���� ó���� ���� session��ü �߰�
 *            2009/03/02 - gforms���� form���� �Ķ���� ó���� ���� request��ü �߰�
 *            2009/03/04 - Session���� ����ȭ �ϱ� ���Ͽ� SyncLoad=true�� �߰�
 *                         date��ü �߰� �� getDate(format), getComplexDate(format, type, size) �޼ҵ� �߰�
 *            2009/03/06 - STYLE_GRID��� ó�� [gss���� ó��]
 *            2009/03/26 - OnDataError��ü ���� ���� [ ���� ref��ü �̸��� �߸� ������ ]
 *            2009/04/02 - getParameter�޼ҵ忡�� encodeURIComponentó�� ��� �߰�  �� �Ľ� ó���� ��ü �߰�
 *            2009/04/06 - getParameter�޼ҵ忡�� input type=checkbox�� ���� ó�� �����ϵ��� ����
 *            2009/04/07 - USE_ENCODING �� defaut�� UTF-8�� ���� [encodeURIComponent�� �����ڵ�� �Ķ���� ����]
 ****************************************************************************/


/**********************************************************************************************
 *  ���ο��� ����� ������Ʈ�� CLSID�� ������ �ݴϴ�. 
 **********************************************************************************************/
var DS_CLSID = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";	  // �����ͼ�
var TR_CLSID = "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5";	  // Ʈ������ 
var UNI_DS_CLSID = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";  // �����ڵ� �����ͼ�
var UNI_TR_CLSID = "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8";  // �����ڵ� Ʈ������

var COMBO_CLSID = "CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197";			// �ڵ� �޺�
var EMEDIT_CLSID = "CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F";		// ����ũ ������
var TEXTAREA_CLSID = "CLSID:2F5DF8D9-F63C-460E-B5CB-399E816B0274";		// �ؽ�Ʈ AREA
var RADIO_CLSID = "CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0";			// ���� ��ư

var UNI_COMBO_CLSID = "CLSID:BB4533A0-85E0-4657-9BF2-E8E7B100D47E";		// �����ڵ� �ڵ� �޺�
var UNI_EMEDIT_CLSID = "CLSID:D7779973-9954-464E-9708-DA774CA50E13";	// �����ڵ� ����ũ ������
var UNI_TEXTAREA_CLSID = "CLSID:1455BE02-C41B-4115-B21C-32380507DC8F";	// �����ڵ� �ؽ�Ʈ AREA
var UNI_RADIO_CLSID = "CLSID:F73C0958-D8FE-43A5-9BB0-0F651C5A2BCC";		// �����ڵ� ���� ��ư


/**********************************************************************************************
 * �α��� ���н� �̵��� �������� �����ϴ� �κ�
 **********************************************************************************************/
var LOGIN_PAGE = "/index.jsp";		

/**********************************************************************************************
 * ���� ����ÿ� ȭ�鿡 ����� �޽����� ���� �մϴ�. 
 **********************************************************************************************/
var SESSION_EXPIRE_MESSAGE = "������ ����Ǿ����ϴ�.\n�ٽ� �α��� ���ּ���!";

/**********************************************************************************************
 *  ������Ʈ ��带 �����մϴ�. 
 *  -  EUC-KR : �ѱ� ����, UTF-8 : �����ڵ� (�빮�ڷ� �����ؾ� �ϸ�, UTF-8�� ���ÿ���
 *      �� ������ UTF-8�� ������ �ּž� �մϴ�.
 **********************************************************************************************/
var MODE = "EUC-KR";

/**********************************************************************************************
 * getParameter�� encodeURIComponent����� ������� ���θ� ���� �մϴ�.
 * USE_ENCODING �Ӽ��� true�� ��쿡�� UTF-8�������� �Ķ���Ͱ� ������ �Ǹ�, beaver.xml�� character-encoding
 * ������ UTF-8�� ���־�� �մϴ�. [default]
 * <character-encoding value="UTF-8"/>
 * @date    : 2009.04.02
 **********************************************************************************************/
 var USE_ENCODING = true;
 
 
/**********************************************************************************************
 * 2008/10/28 SelectProcess()��� ���� �߰� ����
 *---------------------------------------------------------------------------------------------
 * Context���� Root(/)�� �ƴ� ��� SelectProcess���� /common/retrieveDefault.bf ȣ��� 
 * �ش� Action�� ã�� ���ϴ� ������ �߻��ϱ� ������ �Ʒ� CONTEXT_ROOT���� �ش� �ý��ۿ� �°� 
 * Context���� �־��ش� 
 *  ex) http://localhost:7001/eduma/index.jsp�� ���� ���¿��� context���� eduma�� ���
 *       CONTEXT_ROOT ���� eduma��� �Է��� �ָ� �˴ϴ�.
 **********************************************************************************************/
var CONTEXT_ROOT = "";

/**********************************************************************************************
 * ���� ��ɿ��� ����ϴ� Function/Object ���� �κ� 
 **********************************************************************************************
 * @author  : �����
 * @date    : 2008.09.05
 * @version : 1.0
 **********************************************************************************************/

/**
 * Context Root�� ��ġ�� ��ȯ�ϴ� �޼ҵ�.
 **/
function getRoot() {
	return CONTEXT_ROOT;
}

/**
 * ȭ���� Ư�� TAG�ȿ� �ִ� INPUT, SELECT, ������Ʈ[EmEdit, LuxeCombo, Radio]�� 
 * ������ �Ķ���ͷ� ��ȯ�ϴ� �Լ�
 * - usage : getParameter("DIV, SPAN���� TAG�� ID");
 * @author  : �����
 * @date    : 2008.09.05
 * @version : 1.0
 * @history : 2009.04.02 - encodeURIComponent ���  �� TEXTAREA �߰�
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
				if (clsid == LUXECOMBO) {		// ���� �޺� [BindColVal]
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
 * ������ ������ ��ȸ�� ���� SelectProcess ��ü
 *
 * @author  : �����
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
			alert("DataId�� �Էµ��� �ʾҽ��ϴ�.\nDataId�� �Է��Ŀ� ����� �ּ���.");
			return;
		} else if (this.dataid != null) {
			dataset.dataid = this.dataid;
		}
			
		if (this.modelset == null) {
			alert("Beaver ModelSet�� �Էµ��� �ʾҽ��ϴ�.\nBeaver ModelSet�� �Է����ּ���.");
			return;
		}

		if (this.execute == null) {
			alert("Execute�� �Էµ��� �ʾҽ��ϴ�.\nExecute�� �Է����ּ���.");
			return;
		}

		var id = "?MODEL_SET=" + this.modelset + "&EXECUTE=" + this.execute;

		dataset.dataid = this.dataid + id + this.param;
		
		dataset.reset();
	}
}


var DATASET_LIST = [];		// �����ͼ� ����Ʈ ������ [����]
var IGNORE_DATASET_LIST = "MAKE_HEADER_GDS,SERVER_SESSION_DS,SERVER_DATE_DS";
/**
 * COMPONENT_INITIALIZE ::: ������Ʈ�� �̺�Ʈ �Ҵ� ó�� [��ó��]
 *
 * @author  : rogerrb
 * @date    : 2008.09.04
 * @version : 1.0
 **/
function COMPONENT_INITIALIZE() {

	if (document.readyState == "complete") {
		var objList = document.getElementsByTagName ("object");
		// �׸��� ������Ʈ�� ���� ó��
		for (i=0;i<objList.length ;i++)	{
			var obj = objList[i];
			if ( obj.classid.toUpperCase() == "CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B") {
				try {
					var GAUCE_DATASET = eval(obj.DataId);
					var dataErrorCheck = GAUCE_DATASET.dataErrorCheck;
					
					if (typeof(dataErrorCheck) == "undefined" || dataErrorCheck.toUpperCase() == "TRUE") {
						DATASET_LIST[obj.DataId] = obj.DataId;	// �ߺ� �̺�Ʈ ���� ����
						new DataSetOnDataError(GAUCE_DATASET, obj);
					} else if (dataErrorCheck.toUpperCase() == "FALSE") {
						// to do
					}

				} catch (exception) {
					// ����׿� ���Ǵ� �׸���� ����
					if (obj.id != "DATASET_GRID") {
						alert("�׸��� [" + obj.id + "]�� ����� �����ͼ� [" + obj.dataid + "]�� ã���� �����ϴ�.\n" +
						      "�ҽ��� Ȯ���� �ֽʽÿ�.");
					}
					
				}
			}
		}

		for (i=0;i<objList.length ;i++)	{
			var obj = objList[i];
			// �����ͼ� ������Ʈ
			if (obj.classid.toUpperCase() == "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB" && IGNORE_DATASET_LIST.indexOf(obj.id) == -1) {	// �����ͼ� ��ü
				// syncload = true�߰�
				obj.syncload = true;
				
				if ( typeof(DATASET_LIST[obj.id]) == "undefined") {
					var dataErrorCheck = obj.dataErrorCheck;
					// ���� �ؾߵ� - ���� �� ��¥ �����ͼ�  
					if (typeof(dataErrorCheck) == "undefined" || dataErrorCheck.toUpperCase() == "TRUE") {
						new DataSetOnDataError(obj); // �̺�Ʈ �Ҵ�
					} else if (dataErrorCheck.toUpperCase() == "FALSE") {
						// to do
					}
				}
				new DataSetOnLoadError(obj); // �̺�Ʈ �Ҵ�
			// Ʈ������ ������Ʈ
			} else if (obj.classid.toUpperCase() == "CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5") {
				new TrOnFail(obj);
			
			// �׸��� ������Ʈ
			}
		}
	}
}


/**
 * �����ͼ� ������Ʈ ����ó��[OnLoadError]
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
 * �����ͼ� ������Ʈ ����ó��[OnDataError]
 * @author  : rogerrb
 * @date    : 2008.09.04
 * @version : 1.0
 * @history : 2009.03.24 - 2�� �̻��� �����ͼ� ���� ��� �̺�Ʈ ���� ���� ����
 **/
function DataSetOnDataError(obj, grid) {
	var GAUCE_DATASET = obj;
	var GRID = grid;
	
	/**
	 * OnDataError���� ó���� �̺�Ʈ Callback�Լ� [private]
	 * - �����ͼ¿� ���� ������
	 *
	 * @author  : �����
	 * @date    : 2008.09.04
	 * @version : 1.0
	 **/
	dataSetError = function(ds, row, colid) {
		if (ds.ErrorCode == "50018") {			// NOT NULL
			alert("�����ͼ� [" + ds.id +"]�� [" + colid + "]�÷��� �ʼ� �Է� �Դϴ�.\n" + 
				  "[" + row + "]��° ROW�� [" + colid + "]�÷��� ���� �Է��� �ֽʽÿ�");
			ds.RowPosition = row;
		} else if (ds.ErrorCode == "50019") {	// KEY
			var MSG = ds.ErrorMsg;
			var DUPLICATE_ROW = MSG.substring(MSG.indexOf("DuplicateRow:")+13, MSG.indexOf(")"));
			alert("�����ͼ� [" + ds.id +"]�� [" + row + "] ��° ROW�� ���� " + 
				  "[" + DUPLICATE_ROW + "]��° ROW�� ���� �ߺ� �ԷµǾ����ϴ�.\n" + 
				  "[" + row + "]��° ROW�� ���� Ȯ���� �ֽʽÿ�.");

			ds.RowPosition = row;
		} else {
			alert("Error Code : " + ds.ErrorCode + "\n" + "Error Message : " + ds.ErrorMsg + "\n");
		}
	}


	/**
	 * �����ͼ��� Ű �÷��� ��ȯ�ϴ� ���� �޼ҵ�
	 *
	 * @author  : �����
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
	 * �����ͼ��� Ű �÷�ID�� �׸��忡 �÷������� ��ȯ�ϴ� ���� �޼ҵ�
	 *
	 * @author  : �����
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
	 * OnDataError���� ó���� �̺�Ʈ Callback�Լ�
	 *
	 * @author  : �����
	 * @date    : 2008.09.04
	 * @version : 1.0
	 **/
	onDataError = function(row,colid) {

		if (typeof(GRID) == "undefined") {			// �����ͼ��� ���� �����Ϳ��� ó��
			dataSetError(GAUCE_DATASET, row, colid);

		} else {									// �׸��带 ���� ������ ���� ó��
			var colName = GRID.ColumnProp(colid, "name");
		
			// Ű �÷� LIST
			var keyColumnList = keycolumn(GAUCE_DATASET);

			// �׸��� �÷�
			var korColumnName = gridColumnName(keyColumnList, GRID);
			// �׸��忡 �÷��� �������� �ʴ� ��� ó��.
			if (typeof(colName) == "undefined" && GAUCE_DATASET.ErrorCode != "50019") {
				
				dataSetError(GAUCE_DATASET, row, colid);
			} else {
				if (GAUCE_DATASET.ErrorCode == "50018") {			// NOT NULL
					alert("[" + colName + "]�� �ʼ� �Է� �Դϴ�.\n" + 
						  "[" + row + "]��° [" + colName + "]�� ���� �Է��� �ֽʽÿ�.");
					GAUCE_DATASET.RowPosition = row;
					try {
						GRID.setColumn(colid);
					}catch (exception){}
					
				} else if (GAUCE_DATASET.ErrorCode == "50019") {	// KEY
					var MSG = GAUCE_DATASET.ErrorMsg;
					var DUPLICATE_ROW = MSG.substring(MSG.indexOf("DuplicateRow:")+13, MSG.indexOf(")"));
					alert("[" + korColumnName + "]�� ���� [" + DUPLICATE_ROW + "]��°�� �ߺ� �ԷµǾ����ϴ�.\n" +
						  "[" + korColumnName + "]�� �ߺ� �Է��� �� �� �����ϴ�.\n" +
						  "[" + row + "]��° ������ ���� Ȯ�����ֽʽÿ�.");

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
 * Ʈ������ ������Ʈ ����ó�� [OnFail]
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

				// �α��� �������� �̵�... [�ش� �ý��ۿ� �°� ����]
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
   * Gforms���� �Ķ���͸� �޾Ƽ� ó�� �ϱ� ���� ����� ���� ��ü
   *
   * @date		: 2009/03/02
   * @author	: �����
   * @method  : getParameter("Ű��");
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
	 * request.getParameter("Ű��");
	 **/
	this.getParameter = function (str) {

		var result = eval("param." + str);
		if (typeof(result) == "undefined") {
			alert("�Է��� �Ķ���� [" + str + "]�� ���� ���� �ʽ��ϴ�.");
			return null;
		} else {
			return result;
		}
	}
  }


request = new Request();


// ������ ������ �ִ� ��ü
var session = null;


/*****************************************************************************
 * ������ ȭ�鿡�� ����ϱ� ���� ����� ���� ��ü.
 *****************************************************************************
 * @date	2009/02/24
 * @method 	getAttribute("����Key") - ������ ������ �̸����� ����� ���� ��ȯ
 * @method 	valid()	- ������ ������������ üũ�Ѵ�.
 * @histody 2009/03/04 - SyncLoad���� ��� �߰�
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

	// ���ǿ� ����� ���� ������ �޼ҵ�
	this.getAttribute = function(key) {
		if (SESSION_DS.countRow == 0) {
			alert("���ǰ��� �����Ǿ����� �ʽ��ϴ�.");
			return null;
		} else {
			if (SESSION_DS.ColumnIndex(key) == 0)  {
				alert("�Է��� [" + key + "]�� �ش��ϴ� ���ǰ��� �������� �ʽ��ϴ�.");
				return null;
			}
			return SESSION_DS.NameValue(1, key);
		}
	}

	// ������ �ùٸ����� �Ǵ��ϴ� �޼ҵ�
	this.valid = function() {
		if (SESSION_DS.countRow == 0)	{
			alert(SESSION_EXPIRE_MESSAGE);
			location.href = LOGIN_PAGE;
		}
	}

}

session = new Session();





// ��¥ ������ ������ �ִ� ��ü
var date = null;


/*****************************************************************************
 * ���� �ð��� ȭ�鿡�� ����ϱ� ���� ����� ���� ��ü.
 *****************************************************************************
 * @date	2009/03/04
 * @method 	getDate("����Key") - ���� ������¥�� ������ �������� ��ȯ�ϴ� �޼ҵ�
 * @method 	getComplexDate(format, type, size)	
 *          - ������ ��¥�� ���� �������� ��, ��, ���� �����Ͽ� ����, ���� ��¥�� ��ȯ�ϴ� �޼ҵ�
 * @histody 2009/03/04 - �ű��ۼ�
 *****************************************************************************/
function ServerDate() {
	var SERVER_DATE_DS = null;
	var CURRENT_DATE_PARAM = "";	// ���� ��¥���� ����� �Ķ���� ����
	var CURRENT_DATE = "";			// ���� ��¥
	var COMPLEX_DATE_PARAM = "";	// �������� ��¥ ��꿡�� ����� �Ķ���� ����
	var COMPLEX_DATE = "";			// �������� ��¥ 
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
	 * ������ ��¥�� ��ȯ�ؿ��� �޼ҵ�
	 * @param format ��¥ ������ ���� ex) yyyyMMdd hh:mm:ss
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
     * ���� ��¥�� �������� Ÿ��[(��('Y'), ��('M'), ��('D'), ��('W'))]�� ���� ������ �Ͽ� ������ ���信 �°� ��ȯ�ϴ� �޼ҵ�
     * 
     * @param format	��¥ ����  ex) yyyy-MM-dd HH:mm:ss
     * @param type		��(Year) 'Y', ��(Month) 'M', ��(Day) 'D', ��(Week) 'W'
     * @param size		������ ������
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
 * ���콺�� ���� ���α׷���(��ȸ��, ó����)�� ǥ�����ִ� ������Ʈ
 * @author : �����
 * @history : 2007/12/28 - �����ڵ� �߰� �� �̺�Ʈ �Ҵ�/���Ÿ� ref��� ������ ó��
 *            2008/01/21 - LogicalTR�� ����
 ***********************************************************************************************
 * usage : var rs = new Progress();	// ��ü ����.
 *             
 *         rs.submit(�����ͼ¿�����Ʈ, x��ǥ, y��ǥ);			// �����ͼ��� ���� ��ȸ��
 *  
 *         rs.submit(Ʈ�����ǿ�����Ʈ, x��ǥ, y��ǥ);			// Ʈ������ ó����
 *  
 *         rs.submit(Ʈ�����ǿ�����Ʈ, "R", x��ǥ, y��ǥ);	    // Ʈ������ ������Ʈ�� ��ȸ��
 *
 ***********************************************************************************************/
function Progress() {

	var GLB_SUBMIT_STATUS = false;	// reset/post �ߺ�����.
	var GLO_OBJECT = document.all;
	var GLO_INTERVAL = "";
	var GLO_TEMP_OBJECT = "";

	var CALL_BACK_FUNCTION = null;	//CALL BACK�Լ�

	var ds_html = "<body leftmargin=0 topmargin=0><center><table cellpadding=0 cellspacing=0><tr><td>" +
			      "<img src='./image/ing01.gif'></td></tr></table></center></body>";

	var tr_html = "<body leftmargin=0 topmargin=0><center><table cellpadding=0 cellspacing=0><tr><td>" +
				  "<img src='./image/ing02.gif'></td></tr></table></center></body>";

	this.setCallBackFunction = function(param) {
		CALL_BACK_FUNCTION = param;
	}

	//	���������� ����� ��� �޽��� ��� �� ���α׷��� ����.
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
		
		/** ���������� ����� ��쿡 �������� �޽����� ������ ��� �ش� �޽����� ����� �ش�. **/
		if (GLO_TEMP_OBJECT.ErrorMsg.trim() != "") {
			alert(GLO_TEMP_OBJECT.ErrorMsg);
		}

		// �̺�Ʈ�� �����Ͽ� �ش�.
		if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			 GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// �����ͼ�.
				GLO_TEMP_OBJECT.detachEvent ('OnLoadCompleted', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnLoadError', EVENT_VIEW_ERROR);


		} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			        GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // Ʈ������.
				GLO_TEMP_OBJECT.detachEvent ('OnSuccess', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnFail', EVENT_VIEW_ERROR);
		}

		try {
			eval(CALL_BACK_FUNCTION + "()");
		} catch (exception) {}

	}

	/**  ������ �߻��� ��� ������ ǥ�� �� ���α׷����ٸ� ����  **/
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
		 * ������Ʈ���� Ŀ���� ����¡�� �ʿ��� �κ�
		 *************************************************************************
		 * ���� ����� ������ �߻��� ��� �ش� ������ ����� �ش�. 
		 * �̺κп��� ���񽺿��� �Ѿ�� ExceptionŸ�Կ� ���� Biz, SysException�
		 * ���� �˾�â, alert���������� ó���� �ָ� �ȴ�. 
		 *************************************************************************/
		alert(GLO_TEMP_OBJECT.ErrorMsg);

		// �̺�Ʈ�� �����Ͽ� �ش�.
		if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			 GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// �����ͼ�.
				GLO_TEMP_OBJECT.detachEvent ('OnLoadCompleted', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnLoadError', EVENT_VIEW_ERROR);

		} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			        GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // Ʈ������.
				GLO_TEMP_OBJECT.detachEvent ('OnSuccess', EVENT_CLOSE);
				GLO_TEMP_OBJECT.detachEvent ('OnFail', EVENT_VIEW_ERROR);
		}

	}

	// ���� reset/post����
	this.submit = function() {

		/** �ߺ� ó���� ���� ���� ó���� �κ� **/
		if (GLB_SUBMIT_STATUS == true)	{
			alert("ó�����Դϴ�.\n��ø� ��ٷ� �ֽʽÿ�.");
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
			     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// �����ͼ�.
					GLO_TEMP_OBJECT.attachEvent ('OnLoadCompleted', EVENT_CLOSE);
					GLO_TEMP_OBJECT.attachEvent ('OnLoadError', EVENT_VIEW_ERROR);
			} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // Ʈ������ ������Ʈ.
					GLO_TEMP_OBJECT.attachEvent ('OnSuccess', EVENT_CLOSE);
					GLO_TEMP_OBJECT.attachEvent ('OnFail', EVENT_VIEW_ERROR);
			} else {
				alert("���콺 �����ͼ�/Ʈ������ ������Ʈ�� �ƴմϴ�.\n�����ͼ�/");
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
			alert("HTML Document�� body�ױװ� �����ϴ�.");
			return;
		}

		doc.open("text/html");

		try	{
			if ( GLO_TEMP_OBJECT.classid.toUpperCase() == DS_CLSID || 
			     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// �����ͼ�.
				doc.write(ds_html);
			} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // Ʈ������ ������Ʈ.

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

		/** �Ķ���Ϳ� ���� ó�� �ϴ� �κ� **/
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
			alert("ó�����Դϴ�.\n��ø� ��ٷ� �ֽʽÿ�.");
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
			     GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_DS_CLSID ) {	// �����ͼ�.
				GLO_TEMP_OBJECT.reset();
			} else if ( GLO_TEMP_OBJECT.classid.toUpperCase() == TR_CLSID ||
			            GLO_TEMP_OBJECT.classid.toUpperCase() == UNI_TR_CLSID ) { // Ʈ������ ������Ʈ.
				GLO_TEMP_OBJECT.post();
			}
		} catch (exception) {
			document.form1.submit();
		}
	}
	
	/** �̺�Ʈ ref���� **/
	var EVENT_VIEW_ERROR = this.viewError;
	var EVENT_CLOSE = this.close;
}


document.onreadystatechange = COMPONENT_INITIALIZE;

