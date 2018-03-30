
/**********************************************************************************************
 *  컴포넌트 모드를 설정합니다. 
 *  -  EUC-KR : 한글 전용, UTF-8 : 유니코드 (대문자로 설정해야 하며, UTF-8로 사용시에는
 *      본 파일을 UTF-8로 저장해 주셔야 합니다.
 **********************************************************************************************/
var MODE = "EUC-KR";

var DS_CLSID = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";			// 데이터셋 [euc-kr]
var UNI_DS_CLSID = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";	// 유니코드 데이터셋 [utf-8]

var GRID_CLSID = "CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B";			// 그리드 [euc-kr]
var UNI_GRID_CLSID = "CLSID:71E7ACA0-EF63-4055-9894-229B056E9C31";	// 유니코드 그리드 [utf-8]

var CURRENT_DS_CLSID = "";
var CURRENT_GRID_CLSID = "";
if (MODE.toUpperCase() == "EUC-KR") {
		CURRENT_DS_CLSID = DS_CLSID;
		CURRENT_GRID_CLSID = GRID_CLSID;
} else {
		CURRENT_DS_CLSID = UNI_DS_CLSID;
		CURRENT_GRID_CLSID = UNI_GRID_CLSID;
}
var GAUCE_VIEW_OBJECT = "<style>" + 
                        ".fieldset { BORDER-LEFT-WIDTH: 10px;FONT-SIZE: 12px;font-family:'굴림', '굴림체', 'Arial', 'Verdana' color;" +
						"color: #434343;BORDER-right-WIDTH: 1px;BORDER-top-WIDTH: 1px;BORDER-bottom-WIDTH: 1px;border-color:#5D96C7;" +
						"margin-left:0;margin-right:5;margin-top:5;	margin-bottom:5;padding-right: 3;padding-left: 3;" +
						"padding-top: 3;padding-bottom: 5;}" + 
						".span {fontsize:13pt;color:black;font-family:돋움;font-weight:bold;position:relative;top:-3}" +
						".combo {fontsize:12pt;color:black;font-family:돋움;}" + 
						"</style>" +
                        "<span class='span'>DataSet</span>" +
                        "<select id=DATASET_COMBO class='combo'  style='width:100' onchange='GAUCE_VIEW_DATASET(this.value)'>" +
						"<option value=''>::: SELECT :::</option>" + 
						"</select>" +
						"<input type=button value='H' onclick='HEADER_FROM_DS()' style='width:20' title='선택한 데이터셋의 헤더를 반환합니다.'><input type=button value='F' onclick='GRID_COLUMN()' style='width:20' title='그리드의 포멧을 반환합니다.'>" + 
						"<span class='span'>&nbsp;&nbsp;Set Class</span>" +
						"<input type=text id=BEAVER_SET value='' style='width:200' >" +
						"<input type=button value='Header' style='width:55' onclick='MAKE_HEADER_RUN()' title='Beaver ModelSet을 가지고 헤더를 생성합니다.'>" +
						"<object classid=" + CURRENT_DS_CLSID  + " id=MAKE_HEADER_GDS>" +
						"	<param name=SyncLoad value=true> " + 
						"</object>" + 
						"<script for=MAKE_HEADER_GDS event='OnLoadCompleted()'>" +
						"	MAKE_HEADER(this); " + 
						"</script>" +
						"<script for=MAKE_HEADER_GDS event='OnLoadError()'>" +
						"	ERROR(this); " + 
						"</script>" +
						"<object id=DATASET_GRID classid=" + CURRENT_GRID_CLSID  + " height=250 width=98% style='visibility: hidden'>" + 
						"<param name='Editable' value='true'>" +
						"</object>" +
			            "<fieldset class='fieldset' style='width=98%'>" + 
						"<legend>[properties]</legend>" + 
						"<span id=GAUCE_PROPERTIES>&nbsp;</span>" + 
						"</fieldset>";


var TRIM_PATTERN = /(^\s*)|(\s*$)/g; // 내용의 값을 빈공백을 trim하기 위한것(앞/뒤)


/*************************************************************************
 *  String.trim()
 *  내용의 좌 우측 공백을 제거해 주는 메소드
 *************************************************************************
 * Author    : 최재원
 * Date       : 2004.04.12
 * History   : 최초 작성
 * Desc      : 내용의 좌 우측 공백을 제거해 주는 메소드
 * Param    : none
 * Return    : trim()된 문자열
 *************************************************************************/
String.prototype.trim = function() {
	return this.replace(TRIM_PATTERN, "");
}


function HEADER_FROM_DS() {
	if (DATASET_COMBO.value == "") {
		alert("데이터셋을 선택하신후에 사용하세요");
		return;
	} else if (eval(DATASET_COMBO.value).CountColumn == 0) {
		alert("데이터셋의 컬럼이 없습니다.");
		return;
	}
	MAKE_HEADER(eval(DATASET_COMBO.value));
}

// 헤더 생성
function MAKE_HEADER_RUN() {
	var setName = BEAVER_SET.value;

	if (setName.trim() == "") {
		alert("Beaver에서 작성한 Set Class를 Full Package명으로 입력해 주세요.");
		return;
	}
	alert("[" + setName.trim() + "]을 가지고 헤더를 생성합니다.");
	MAKE_HEADER_GDS.dataId = "/common/headerMaker.bf?MODEL_SET=" + setName.trim();
	MAKE_HEADER_GDS.reset();

}

function GRID_COLUMN() {
	alert(DATASET_GRID.format);
}

/**
 * 현재 데이터셋의 헤더를 반환하는 함수
 *
 * @author  : 최재원
 * @date    : 2008.09.05
 * @version : 1.0
 **/ 
function MAKE_HEADER(ds) {
	var columnCnt = ds.CountColumn;
	var headerInfo = "";
	for (i=1; i<=columnCnt; i++) {
		var columnName = ds.ColumnID(i);
		var columnType = ds.ColumnType(i);
		switch(columnType) {
			case 1:	
				columnType = "STRING";
				break;
			case 2:
				columnType = "INTEGER";
				break;
			case 3:
				columnType = "DECIMAL";
				break;
			case 4:
				columnType = "DATE";
				break;
			case 5:
				columnType = "URL";
				break;
		}
		var columnSize = ds.ColumnSize(i);

		var decSize = ds.ColumnDec(i);

		var colProp = ds.ColumnProp(i);

		switch(colProp) {
			case 0:
				colProp = "";
				break;
			case 1:
				colProp = "";
				break;
			case 2:
				colProp = "KEYVALUETYPE";
				break;
			case 3:
				colProp = "";
				break;
			case 4:
				colProp = "NOTNULL";
				break;
			case 5:
				colProp = "";
				break;
		}
		var result = columnName + ":" + columnType + "(" +  columnSize;
		if (decSize != 0) {
			result += "." + decSize + ")";
		} else {
		    result += ")";
		}
		
		if (colProp != "") {
			result += ":" + colProp;
		}

		headerInfo += result + ",";
	}
	alert(headerInfo.substring(0,headerInfo.length-1));
}

// 오류 표시
function ERROR(ds) {
	var errorMsg = ds.errorMsg;
	errorMsg = errorMsg.substring(errorMsg.indexOf("[INTERNAL-7500]")+16);
	alert(errorMsg + "\n정확한 BeaverSet Class를 입력해 주십시오.");
}

function GAUCE_GRID_ONCLICK(row, colid) {
	var ds = eval(DATASET_GRID.dataid);
	var idx = ds.columnIndex(colid);
	var columnType = ds.ColumnType(idx);

	switch(columnType) {
		case 1:	
			columnType = "String";
			break;
		case 2:
			columnType = "Integer";
			break;
		case 3:
			columnType = "Decimal";
			break;
		case 4:
			columnType = "Date";
			break;
		case 5:
			columnType = "URL";
			break;
	}
	var columnSize = ds.ColumnSize(idx);

	var decSize = ds.ColumnDec(idx);

	var colProp = ds.ColumnProp(idx);
	switch(colProp) {
		case 0:
			colProp = "Normal";
			break;
		case 1:
			colProp = "Constant";
			break;
		case 2:
			colProp = "Key";
			break;
		case 3:
			colProp = "Sequence";
			break;
		case 4:
			colProp = "NotNull";
			break;
		case 5:
			colProp = "Reference";
			break;
	}
	
	var result = "컬럼ID: " +colid + ", 컬럼Type: " + columnType + ", 컬럼Size:" +  columnSize + ", 소숫점: " + decSize + ", 컬럼속성: " + colProp;
	GAUCE_PROPERTIES.innerHTML = result;
}
function GAUCE_VIEW_DATASET(param) {
	GAUCE_PROPERTIES.innerHTML = "&nbsp;";
	if (param == "") {
		DATASET_GRID.format = "";
		DATASET_GRID.dataid = "";
		DATASET_GRID.style.visibility = 'hidden';
		return;
	}

	DATASET_GRID.style.visibility = 'visible';
	var ds = eval(param);
	var cnt = ds.CountColumn;
	var format = "";
	for(i=1; i<=cnt; i++) {
		format += "<C> id='" + ds.ColumnID(i) + "' name='" +  ds.ColumnID(i) + "' width=80  align=left</C>";
	}
	DATASET_GRID.ColSizing = true;
	DATASET_GRID.dataid = ds.id;
	DATASET_GRID.ColSelect = true;
	DATASET_GRID.format = format;
}

function GAUCE_UPDATE_DATASET() {
	var objList = document.getElementsByTagName ("object");
	for (i=0;i<objList.length ;i++)	{
		var obj = objList[i];
		if ( obj.classid.toUpperCase() == CURRENT_DS_CLSID && obj.id != "MAKE_HEADER_GDS") {

			DATASET_COMBO.add( new Option(obj.id,obj.id) );
		}
	}
}

var IE5=(document.getElementById && document.all)? true: false;
var W3C=(document.getElementById)? true: false;
var currIDb=null, currIDs=null, xoff=0, yoff=0; zctr=0; totz=0;

function trackmouse(evt){
		if((currIDb!=null) && (currIDs!=null)){
				var x=(IE5)? event.clientX+document.body.scrollLeft : evt.pageX;
				var y=(IE5)? event.clientY+document.body.scrollTop : evt.pageY;
						currIDb.style.left=x+xoff+'px';
						currIDs.style.left=x+xoff+10+'px';
						currIDb.style.top=y+yoff+'px';
						currIDs.style.top=y+yoff+10+'px';
				return false;
		}
}

function stopdrag(){
		currIDb=null;
		currIDs=null;
		NS6bugfix();
}

function grab_id(evt){
		xoff=parseInt(this.IDb.style.left)-((IE5)? event.clientX+document.body.scrollLeft : evt.pageX);
		yoff=parseInt(this.IDb.style.top)-((IE5)? event.clientY+document.body.scrollTop : evt.pageY);
		currIDb=this.IDb;
		currIDs=this.IDs;
}

function NS6bugfix(){
		if(!IE5){
				self.resizeBy(0,1);
				self.resizeBy(0,-1);
		}
}

function incrzindex(){
		zctr=zctr+2;
		this.subb.style.zIndex=zctr;
		this.subs.style.zIndex=zctr-1;
}

function createPopup(id, title, width, height, x , y , isdraggable, boxcolor, barcolor, shadowcolor, text, textcolor, textptsize, textfamily ) {
	if(W3C){
		zctr+=2;
		totz=zctr;
		var txt='';
		txt+='<div id="'+id+'_s" style="position:absolute; left:'+(x+7)+'px; top:'+(y+7)+'px; width:'+width+'px; height:'+height+'px; background-color:'+shadowcolor+'; filter:alpha(opacity=30); visibility:visible"> </div>';
		txt+='<div id="'+id+'_b" style="border:outset '+barcolor+' 2px; position:absolute; left:'+x+'px; top:'+y+'px; width:'+width+'px; overflow:hidden; height:'+height+'px; background-color:'+boxcolor+'; visibility:visible">';
		txt+='<div style="width:'+width+'px; height:16px; background-color:'+barcolor+'; padding:0px; border:1px"><table cellpadding="0" cellspacing="0" border="0" width="'+(IE5? width-4 : width)+'"><tr><td width="'+(width-20)+'"><div id="'+id+'_h" style="width:'+(width-20)+'px; height:14px; font: bold 12px Tahoma; cursor:move; color:'+textcolor+'"> '+title+'</div></td><td align="right"><a onmousedown="document.getElementById(\''+id+'_s\').style.display=\'none\'; document.getElementById(\''+id+'_b\').style.display=\'none\';return false"><span style="color:white;cursor:hand">▣</span></a></td></tr></table></div>';
		txt+='<div id="'+id+'_ov" width:'+width+'px; style="margin:5px; color:'+textcolor+'; font:'+textptsize+'pt '+textfamily+';">'+text+'</div></div>';
		document.write(txt);
		DATASET_GRID.style.visibility = 'hidden';
		GAUCE_UPDATE_DATASET();
		DATASET_GRID.attachEvent("OnColumnPosChanged", GAUCE_GRID_ONCLICK);
		DATASET_GRID.attachEvent("OnClick", GAUCE_GRID_ONCLICK);
		this.IDh=document.getElementById(id+'_h');
		this.IDh.IDb=document.getElementById(id+'_b');
		this.IDh.IDs=document.getElementById(id+'_s');
		this.IDh.IDb.subs=this.IDh.IDs;
		this.IDh.IDb.subb=this.IDh.IDb;
		this.IDh.IDb.IDov=document.getElementById(id+'_ov');
		if(IE5){
			this.IDh.IDb.IDov.style.width=width-6;
			this.IDh.IDb.IDov.style.height=height-22;
			this.IDh.IDb.IDov.style.scrollbarBaseColor=boxcolor;
			this.IDh.IDb.IDov.style.overflow="auto";
		}
		else{
			this.IDh.IDs.style.MozOpacity=.5;
		}
		this.IDh.IDb.onmousedown=incrzindex;
		if(isdraggable){
			this.IDh.onmousedown=grab_id;
			this.IDh.onmouseup=stopdrag;
		}
	}
}

if(W3C)document.onmousemove=trackmouse;
if(!IE5 && W3C)window.onload=NS6bugfix;        

createPopup( 'GAUCE_DEBUG', 'GAUCE DEBUG TOOLS Ver 1.0 - ' + MODE ,  536, 342, 1, 1, true, '#c0c0c0' , '#555555' , '#c0c0c0' ,  GAUCE_VIEW_OBJECT , '#f3f3f3' , 10 , 'Arial'); 
