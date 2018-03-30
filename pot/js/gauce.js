/**
 * 시스템명 : 자바스크립트 공통함수
 * 작 성 일 : 2010-06-20
 * 작 성 자 : FKL
 * 수 정 자 :
 * 파 일 명 :
 * 버    전 : 1.0
 * 인 코 딩 : Unicode
 * 개    요 : 자바스크립트 공통함수
 * 이    력 :
 */ 

var CLSID_TRANSACTION = "CLSID:223216F6-B9FE-406D-9ED6-143FCE3A07B8";
var CLSID_DATASET     = "CLSID:AF989B7C-8AC3-40BC-B749-EB335BDFD190";


/**
* tabInit()
* 작 성 자 : 정지인
* 작 성 일 : 2010-02-10
* 개     요 : Tab 컨트럴 셋팅 
* 사용방법 : gridInit(oTab)
*          arguments[0] -> TAB 컨트럴 ID
*/
function tabInit(oTab){    
    oTab.BackColor = "#1d608a";
    oTab.DisableBackColor = "#eaeef4"; 
    oTab.TextColor        = "#ffffff";
    oTab.DisableTextColor = "#000000";
    //@sbcho 주석처리
    //oTab.DisplayTabBottomLine = "false";
}

/**
* Date : 2006.07.26
* TR post후 에러발생시 아래 함수를 호출 합니다.
* 
*/
function trFailed( errMsg ){
    if( errMsg != null){
        var msgIdx = errMsg.lastIndexOf("[USER]");
        if( msgIdx > 0 ){
            showMessage(EXCLAMATION, OK, "USER-1000", errMsg.substr(msgIdx+6) );
        }else{
            showMessage(STOPSIGN , OK, "SERVER-1001", errMsg);            
        }
    }    
}

/**
* Date : 2006.07.26
* 데이터셋 겟방식 전송후 에러발생시 아래 함수를 호출 합니다.
* 
*/
function dsFailed( dataset ){
	if (dataset.ErrorCode == 0 ) {
		showMessage(STOPSIGN, OK, "GAUCE-1010");
	} else {
		var msgIdx = dataset.ErrorMsg.lastIndexOf("[USER]");
		if( msgIdx > 0 ){
            showMessage(EXCLAMATION, OK, "USER-1000", dataset.ErrorMsg.substr(msgIdx+6) );
        }else{
            showMessage(STOPSIGN , OK, "SERVER-1001", dataset.ErrorMsg);            
        }
	}  
}

 /**
 * Date : 2006.07.26
 * TR post후 아래 함수를 호출 합니다.
 * strMode : R(RETRIEVE), C(INSERT), U(UPDATE), D(DELETE), B(BATCH)
 */
 function endTR(strMode, currentTR, outDataSet) {
     window.status = "";
 
     var intTotalCnt = outDataSet.CountRow;
     
     if (strMode == "R") {
         if (intTotalCnt == 0 && (currentTR.ErrorCode == 50000 || currentTR.ErrorCode == 0)){
            showMessage(Information, Ok, "GAUCE-1003");        
         }
         else {
            window.status = "▒▒▒▒▒ [" + intTotalCnt + "]건이 조회되었습니다. ▒▒▒▒▒";
         }
     }
     
     if ("RIB".indexOf(strMode) == -1 && (currentTR.ErrorCode == 0 || currentTR.ErrorCode == 50000)) {
        window.status = "";
        showMessage(Information, OK, "GAUCE-1002", currentTR);
        return 0;
     }  
     else {
        return -1;
     }
     
     return 0;
 }
 
 
 
  /**
 * Date : 2006.08.16
 * TR post후 아래 함수를 호출 합니다.
 * 메시지에 대한 제어가 필요한 경우
 * - 조회 건수가 없을때 인자로 들어오는 메시지 출력
 * - 조회 건수 있으면 메시지 띄우지 않음
 * strMode : R(RETRIEVE), C(INSERT), U(UPDATE), D(DELETE), B(BATCH)
 */
 function endTR2(strMode, currentTR, outDataSet, strMsg) {
     window.status = "";
 
     var intTotalCnt = outDataSet.CountRow;
     
     if (strMode == "R") {
         if (intTotalCnt == 0 && (currentTR.ErrorCode == 50000 || currentTR.ErrorCode == 0)){
            if (strMsg != "") {
                showMessage(Information, Ok, "USER-1000", strMsg);        
            }
         }
         else {
            window.status = "▒▒▒▒▒ [" + intTotalCnt + "]건이 조회되었습니다. ▒▒▒▒▒";
         }
     }
     
     if ("RIB".indexOf(strMode) == -1 && (currentTR.ErrorCode == 0 || currentTR.ErrorCode == 50000)) {
        window.status = "";
        showMessage(Information, OK, "GAUCE-1002", currentTR);
        return 0;
     }  
     else {
        return -1;
     }
     
     return 0;
 }
 
 
 /**
* 작 성 자 : FKL
* 작 성 일 : 2006-07-27
* 개    요 : TR 객체의 초기화 
* return값 : 
*/
function initTR(currentTR, srType) {
     currentTR.TimeOut = 600000;  //10분
     
     //SaveData 하위 속성은 Load 되는 Binary Data를 Local System에 저장 여부를 결정 한다     
     //currentTR.ExtProp("SaveData") = "T";  // TR 로그 남기기 - c:\temp 디렉토리에 생성됨
     
     //SendNullData = false일때는 DataSet에 변경된 Data가 없는 경우 TR에서 Post를 
     //호출하더라도 해당 Service를 Server로 요청하지 않는다.
     currentTR.SendNullData = false;
     
     //StatusResetType 정의
     //0 : Transaction 작업 후 DataSet의 Status만 Reset한다.
     //1 : Transaction 작업 후 DataSet을 Reset(Reload)한다.
     //2 : Transaction 작업 후 DataSet의 Status를 유지한다.     
     currentTR.StatusResetType = srType;    
 }


/**
* initMGridStyle(grName, styleName, strFormat )
* 작 성 자 : FKL
* 작 성 일 : 2010-04-04
* 개    요 : 가우스 MGrid object를 정해진 Style로 바꾸어준다. 
* 사용방법 : initMGridStyle(grName, styleName, strFormat);
*          arguments[0] -> GRID 이름 
*          arguments[1] -> 디자인형태
*          arguments[2] -> 포맷
* return값 : 
*/
function initMGridStyle(grName, styleName, strFormat){
    grName.LayoutInfo("BackgroundInfo", "borderstyle") = "none"; 
    grName.LayoutInfo("IndicatorInfo", "width") = 18;
    grName.SelectedColor  = "#FEFB8D";
    grName.SelectedColorRate = "30";
//    grName.BgColor="BLUE"
//    grName.FocusCurCol ="black"
//    grName.bgColor='red'
 
    grName.ColumnInfo = strFormat;


//  grName.HeadLineColor = "#e1e1e1";
//  grName.LineColor = "#e1e1e1";
//  grName.BorderStyle="0";
//  grName.SortView="Right";




}


//수정 정지인
/**
* initGridStyle(grName, styleName, strFormat, editableFlag )
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : 가우스 Grid object를 정해진 Style로 바꾸어준다. Style과 관련된 내용은 표준화 문서를 참고한다.
* 사용방법 : initGridStyle(GD_MMENU, "common", hdrProperies,true );
*          arguments[0] -> GRID 이름 
*          arguments[1] -> 디자인형태
*          arguments[2] -> 포맷
*          arguments[3] -> 그리드 에디터 여부
* return값 : 
*/
function initGridStyle(grName, styleName, strFormat, editableFlag){

  var titleHeight;
  var bgColor;
  var fontSize;
  var fontFamily;

  var EnterkeyOnPopup;
  var UsingOneClick;
  var headerBorder;
  var borderStyle;
  var dragDropEnable;
  var columnSizing;
  var columnSelect;
  var columnEditable;
  var allShowEdit;
  var AddSelectRows;
  var sumColor;
  var sumBgColor;
  var subColor;
  var subBgColor;
  var subPressBgColor;

  var color;
  var headAlign;
  var headColor;
  var headBgColor;
  var lineColor;
  var headLineColor;
  var indicatorBkColor;
  var indicatorColBkColor;

  // Format Parameter의 <C> 컬럼 Tag 속성
  var CColor;
  var CBgColor;
  var CHeadColor;
  var CHeadBgColor;

  // Format Parameter의 <FC> 컬럼 Tag 속성
  var FCColor;
  var FCBgColor;
  var FCHeadColor;
  var FCHeadBgColor;

  // Format Parameter의 <G> 컬럼 Tag 속성
  var GHeadColor;
  var GHeadBgColor;

  // Format Parameter의 <FG> 컬럼 Tag 속성
  var FGHeadColor;
  var FGHeadBgColor;

  //  Format Parameter의 <X> 컬럼 Tag 속성
  var XHeadColor;
  var XHeadBgColor;


  //  Format Parameter의 <FX> 컬럼 Tag 속성
  var FXHeadColor;
  var FXHeadBgColor;

  var parameterNames  = ["indWidth", "rowHeight", "titleHeight"];
  var parameterValues = [18, 20, 25];
  var parameterTypes  = ["number", "number", "number"];



//  if (grParameters != null){
//    parseGridParameter(grParameters, parameterNames, parameterValues, parameterTypes);
//  }

  var indWidth    = parameterValues[0];
  var rowHeight   = parameterValues[1];
  var titleHeight = parameterValues[2];

  if (editableFlag != null){
    columnSelect        = editableFlag;
    columnEditable      = editableFlag;
  } else {
    columnSelect        = false;
    columnEditable      = false;
  }

  switch(THEME){
    case SPRING :
      break;
    case SUMMER :
      break;
    case FALL   :
      break;
    case WINTER :
      titleHeight         = titleHeight;
      fontSize            = "14px";
      fontfamily          = "돋움, dotum";
      EnterkeyOnPopup     = true;
      UsingOneClick       = true;
      headerBorder        = 4;
      borderStyle         = 0;
      dragDropEnable      = true;
      columnSizing        = true;
      allShowEdit         = true;
      AddSelectRows       = true;
      indicatorBkColor    = "#eaeef4";
      indicatorColBkColor = "#FFFFFF";
      lineColor           = "#dddddd";
      headLineColor       = "#dddddd";
      sumColor            = "#000000";
      sumBgColor          = "#b9d9ea";
      subColor            = "#093a64"; 
      subBgColor          = "#FFFFFF";
      subpressBgColor     = "#FFFFFF";
      CHeadColor          = "#383838";
      CHeadBgColor        = "#eaeef4";
      FCHeadColor         = "#383838";
      FCHeadBgColor       = "#eaeef4";
      GHeadColor          = "#383838";
      GHeadBgColor        = "#eaeef4";
      FGHeadColor         = "#383838";
      FGHeadBgColor       = "#eaeef4";
      XHeadColor          = "#383838";
      XHeadBgColor        = "#eaeef4";

      switch(styleName.toUpperCase()){
          case "COMMON" :
            //eval(grName.DataID).ViewDeletedRow  = false;
            grName.MultiRowSelect = false;
            CColor              = "#555555";
            FCColor             = "#555555";
               CBgColor            = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF')}";
            FCBgColor           = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF')}";
               break;
          case "MULTISELECT" :
            CColor              = "#555555";
            FCColor             = "#555555";
            //eval(grName.DataID).ViewDeletedRow  = true;
            grName.MultiRowSelect = true;
            CBgColor            = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF')}";
            FCBgColor           = "{decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF')}";
            break;
          case "LIST2F" :
            CColor              = "{if(currow = 1 or currow = 2, '#000000', '#555555')}";
            FCColor             = "{if(currow = 1 or currow = 2, '#000000', '#555555')}";
            //eval(grName.DataID).ViewDeletedRow  = true;
            grName.MultiRowSelect = false;
            CBgColor            = "{if(currow = 1 or currow = 2, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            FCBgColor           = "{if(currow = 1 or currow = 2, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            break;
          case "LIST2L" :
            CColor              = "{if(rowcount - currow = 0 or rowcount - currow = 1, '#000000', '#555555')}";
            FCColor             = "{if(rowcount - currow = 0 or rowcount - currow = 1, '#000000', '#555555')}";
            //eval(grName.DataID).ViewDeletedRow  = true;
            grName.MultiRowSelect = false;
            CBgColor            = "{if(rowcount - currow = 0 or rowcount - currow = 1, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            FCBgColor           = "{if(rowcount - currow = 0 or rowcount - currow = 1, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            break;
          case "LIST3F" :
            CColor              = "{if(currow = 1 or currow = 2 or currow = 3, '#000000', '#555555')}";
            FCColor             = "{if(currow = 1 or currow = 2 or currow = 3, '#000000', '#555555')}";
            //eval(grName.DataID).ViewDeletedRow  = true;
            grName.MultiRowSelect = false;
            CBgColor            = "{if(currow = 1 or currow = 2 or currow = 3, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            FCBgColor           = "{if(currow = 1 or currow = 2 or currow = 3, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            break;
          case "LIST3L" :
            CColor              = "{if(rowcount - currow = 0 or rowcount - currow = 1 or rowcount - currow = 2, '#000000', '#555555')}";
            FCColor             = "{if(rowcount - currow = 0 or rowcount - currow = 1 or rowcount - currow = 2, '#000000', '#555555')}";
            //eval(grName.DataID).ViewDeletedRow  = true;
            grName.MultiRowSelect = false;
            CBgColor            = "{if(rowcount - currow = 0 or rowcount - currow = 1 or rowcount - currow = 2, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            FCBgColor           = "{if(rowcount - currow = 0 or rowcount - currow = 1 or rowcount - currow = 2, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            break;
          case "LIST4F" :
            CColor              = "{if(currow = 1 or currow = 2 or currow = 3 or currow = 4, '#000000', '#555555')}";
            FCColor             = "{if(currow = 1 or currow = 2 or currow = 3 or currow = 4, '#000000', '#555555')}";
            //eval(grName.DataID).ViewDeletedRow  = true;
            grName.MultiRowSelect = false;
            CBgColor            = "{if(currow = 1 or currow = 2 or currow = 3 or currow = 4, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            FCBgColor           = "{if(currow = 1 or currow = 2 or currow = 3 or currow = 4, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            break;
          case "LIST4L" :
            CColor              = "{if(rowcount - currow = 0 or rowcount - currow = 1 or rowcount - currow = 2 or rowcount - currow = 3, '#000000', '#555555')}";
            FCColor             = "{if(rowcount - currow = 0 or rowcount - currow = 1 or rowcount - currow = 2 or rowcount - currow = 3, '#000000', '#555555')}";
            //eval(grName.DataID).ViewDeletedRow  = true;
            grName.MultiRowSelect = false;
            CBgColor            = "{if(rowcount - currow = 0 or rowcount - currow = 1 or rowcount - currow = 2 or rowcount - currow = 3, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            FCBgColor           = "{if(rowcount - currow = 0 or rowcount - currow = 1 or rowcount - currow = 2 or rowcount - currow = 3, '#D0D7D9', decode(currow-tointeger(currow/2)*2,0,'#FFFFFF',1,'#FFFFFF'))}";
            break;
          default :
              break;
        }
        break;
    default :
        break;
  }

    // Grid 속성 설정 시작

/*  grName.UrlImages  = "<I>Type='PopupBotton', Url='search_s', Fit='Original', Flat='True'</I>" +
    "<I>Type='PopupCalendar', Url='/pot/imgs/icon/ico_calender.gif', Fit='Original', Flat='True'</I>" +
    "<I>Type='DisableIndicator', Url='/pot/imgs/icon/icon_blue.gif' Fit='Original'</I>" +
    "<I>Type='FocusIndicator', Url='/pot/imgs/icon/icon_red.gif' Fit='Original'</I>" +
    "<I>Type='NonFocusIndicator', Url='/pot/imgs/icons/icon_gray.gif' Fit='Original'</I>";
*/

// 2006/06/26 수정 : 안형철
//  eval(grName.DataID).Do('SyncDataEvent', false); //SyncData 호출시 CanRowPosChanged Event 발생 방지

  grName.TargetEnterKey       = "1";
  grName.TranslateKeyDown     = "1"; // tabKey 설정
  grName.AddSelectRows        = AddSelectRows
  grName.RejectEnterkeyOnPopupStyle = EnterkeyOnPopup;
  grName.AllShowEdit          = allShowEdit;
  grName.UsingOneClick        = UsingOneClick;
  grName.ColSelect            = columnSelect;
  grName.ColSizing            = columnSizing;
  grName.Editable             = columnEditable;
  grName.HeadBorder           = headerBorder;
  grName.BorderStyle          = borderStyle;
  //@sbcho 주석처리
  //grName.DragDropEnable       = dragDropEnable;
  grName.RowHeight            = rowHeight;
  grName.TitleHeight          = titleHeight;
  grName.IndWidth             = indWidth;
  grName.style.fontSize       = fontSize;
  grName.style.fontFamily     = fontFamily;
  grName.lineColor            = lineColor;
  grName.IndicatorBkColor     = indicatorBkColor;
  grName.IndicatorColBkColor  = indicatorColBkColor;
  grName.SelectionColor       = "<SC>Type=FocusCurCol,  BgColor=#FEFB8D, TextColor=#000000</SC>" +
    "<SC>Type=FocusCurRow,  BgColor=#FEFB8D, TextColor=#000000</SC>" +
    "<SC>Type=FocusSelRow,  BgColor=#FEFB8D, TextColor=#555555</SC>" +
    "<SC>Type=FocusEditCol  BgColor=#A5BA8B, TextColor=#000000</SC>" +
    "<SC>Type=FocusEditRow, BgColor=#FEFB8D</SC>" +
    "<SC>Type=CurCol,       BgColor=#FEFB8D</SC>" +
    "<SC>Type=CurRow,       BgColor=#FEFB8D</SC>" +
    "<SC>Type=SelRow,       BgColor=#FEFB8D</SC>" +
    "<SC>Type=EditCol,      BgColor=#FEFB8D</SC>" +
    "<SC>Type=EditRow,      BgColor=#FEFB8D</SC>" ;
//20100103 정지인

  grName.HeadLineColor = "#e1e1e1";
  grName.LineColor = "#e1e1e1";
  grName.BorderStyle="0";
  grName.SortView="Right";

  
  grName.Format = strFormat;
  
  // Grid 속성 설정 종료
  var tagRE           = /<(fc|c|g|fg|x|fx)>/i;
  var colAttRE        = /([\w_]+)\s*=\s*['"]?([^<'"\s,]+)/i;

  var curGlbFormat    = grName.Format;
  var newGlbFormat    = "";
  var tagMatch;
  var tagName;
  var colAttData;
  var colAttMatch;
  var colAttName;
  var colAttValue;
  var insertStr;

  while((tagMatch = curGlbFormat.match(tagRE)) != null){
    var style      = "";
    var isSuppress = false;
    colAttData = curGlbFormat.substring(tagMatch.lastIndex, curGlbFormat.indexOf("<", tagMatch.lastIndex));
    while((colAttMatch = colAttData.match(colAttRE)) != null){
      colAttName  = colAttMatch[1].toUpperCase();
      colAttValue = colAttMatch[2].toUpperCase();
      switch(colAttName){
        case "STYLE" :
          if (colAttValue == "REQUIRED"){
            style = "REQUIRED";
          } else if (colAttValue == "TITLE"){
            style = "TITLE";
          }
          break;
        case  "SUPPRESS" :
          isSuppress = true;
          break;
        default :
          break;
      }
      colAttData = colAttData.substr(colAttMatch.lastIndex);
    }
    insertStr = "";
    tagName = tagMatch[1].trim().toUpperCase();
    switch(tagName){
      case "C" :
        headAlign = "Center";
        headColor = CHeadColor;
        headBgColor = CHeadBgColor;
        if (isSuppress){
          if (style == "TITLE") {
            insertStr = insertStr + " BgColor=" + CHeadBgColor;
          } else {
            insertStr = insertStr + " BgColor=" + subpressBgColor;
          }
        } else {
          if (style == "TITLE") {
            insertStr = insertStr + " BgColor=" + CHeadBgColor;
          } else {
            insertStr = insertStr + " BgColor=" + CBgColor;
          }
        }

        insertStr = insertStr + " Color=" + CColor + " SumColor=" + sumColor + " SumBgColor=" + sumBgColor + " SubColor=" + subColor + " SubBgColor=" + subBgColor;
        break;
      case "FC" :
        headAlign = "Center";
        headColor = FCHeadColor;
        headBgColor = FCHeadBgColor;
        if (isSuppress){
          if (style == "TITLE") {
            insertStr = insertStr + " BgColor=" + CHeadBgColor;
          } else {
            insertStr = insertStr + " BgColor=" + subpressBgColor;
          }
        } else {
          if (style == "TITLE") {
            insertStr = insertStr + " BgColor=" + CHeadBgColor;
          } else {
            insertStr = insertStr + " BgColor=" + FCBgColor;
          }
        }
        insertStr = insertStr + " Color=" + FCColor + " SumColor=" + sumColor + " SumBgColor=" + sumBgColor + " SubColor=" + subColor + " SubBgColor=" + subBgColor;
        break;
      case "F" :
        headAlign = "Center";
        headColor = GHeadColor;
        headBgColor = GHeadBgColor;
        break;
      case "G" :
        headAlign = "Center";
        headColor = GHeadColor;
        headBgColor = GHeadBgColor;
        break;
      case "FG" :
        headAlign = "Center";
        headColor = FGHeadColor;
        headBgColor = FGHeadBgColor;
        break;
      case "X" :
        headAlign = "Center";
        headColor = XHeadColor;
        headBgColor = XHeadBgColor;
        break;
      case "FX" :
        headAlign = "Center";
        headColor = FXHeadColor;
        headBgColor = FXHeadBgColor;
        break;
      default :
          break;
    }

    //사용자가 지정한 컬럼 속성에 따른 처리
    colAttData = curGlbFormat.substring(tagMatch.lastIndex, curGlbFormat.indexOf("<", tagMatch.lastIndex));
    if (style == "REQUIRED") headColor = "#1467E4";
    insertStr = insertStr  + " LineColor=" + lineColor + " HeadColor=" + headColor + " HeadBgColor=" + headBgColor + " HeadAlign=" + headAlign + " " ;
    newGlbFormat = newGlbFormat + curGlbFormat.substring(0, tagMatch.lastIndex) + insertStr;
    curGlbFormat = curGlbFormat.substr(tagMatch.lastIndex);

  }
  newGlbFormat = newGlbFormat + curGlbFormat;
  grName.Format = newGlbFormat;
}

/**
* parseGridParameter
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : grParameters    --> "indWidth=20, rowHeight=20, titleHeight=20"
*/
function parseGridParameter(grParameters, parameterNames, parameterValues, parameterTypes){

  if (grParameters == null) return;
  var featureArray = grParameters.split(",");
  var featurePair;
  for (var i=0, n=featureArray.length;i<n;i++){
    featurePair = featureArray[i].split("=");
    for (var j=0, m=parameterNames.length;j<m; j++){
      if (featurePair[0] == parameterNames[j]){
        switch(parameterTypes[j]){
          case "string" :
            parameterValues[j] = featurePair[1];
            break;
          case "number" :
            parameterValues[j] = Number(featurePair[1]);
            break;
          case "boolean" :
            parameterValues[j] = (featurePair[1].toUpperCase() == "YES" || featurePair[1].toUpperCase() == "TRUE" || featurePair[1] == "1") ? true : false;
            break;
          default :
            break;
        }
      }
    }
  }
}



/**
* checkDupKey
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : dataSet, Keys("||" delimiter)로 중복체크를 하여
*            중복된 값이 존재 할 경우 해당 row를 아니면 0을 return한다.
* 사 용 법 : if (checkDupKey(ds_master, "col#1||col#2||col#3")) alert("중복된 데이터가 존재합니다.");
*/

function checkDupKey (gauceDataSet, strKeys) {
  var strKey = strKeys.split("||");
  var intChk;
  for (var i=1, n=gauceDataSet.CountRow; i<n; i++) {
    for (var j=i+1, m=gauceDataSet.CountRow; j<=m; j++) {
      intChk = 0;
      for (var k = 0, o=strKey.length; k<o; k++) {
        if(gauceDataSet.RowLevel(i) == 0){
          if ((gauceDataSet.NameValue(i, strKey[k]) == gauceDataSet.NameValue(j, strKey[k])) &&
              (gauceDataSet.NameValue(i, strKey[k]) != "" )) {
            intChk++;
          }
        }
      }
      if (intChk == strKey.length) return (j);
    }
  }
  return 0;
}

/**
* checkDupKey2
* 작 성 자 : FKL
* 작 성 일 : 2010-02-03
* 개    요 : dataSet, Keys("||" delimiter)로 중복체크를 하여
*            중복된 값이 존재 할 경우 해당 row를 아니면 0을 return한다.
* 사 용 법 : if (checkDupKey(ds_master, "col#1||col#2||col#3")) alert("중복된 데이터가 존재합니다.");
*/

function checkDupKey2 (gauceDataSet, strKeys) {
  var strKey = strKeys.split("||");
  var intChk;
  for (var i=1, n=gauceDataSet.CountRow; i<n; i++) {
    for (var j=i+1, m=gauceDataSet.CountRow; j<=m; j++) {
      intChk = 0;
      for (var k = 0, o=strKey.length; k<o; k++) {
        if(gauceDataSet.RowLevel(i) == 0){
           if(strKey[k].indexOf('^')<1){
              if ((gauceDataSet.NameValue(i, strKey[k]) == gauceDataSet.NameValue(j, strKey[k])) &&
                  (gauceDataSet.NameValue(i, strKey[k]) != "" )) {
                intChk++;
              }
           }else{
              var subStrKey = strKey[k].split("^^");
              var cond1 = eval("'"+gauceDataSet.NameValue(i, subStrKey[0])+"' "+subStrKey[1]+" "+subStrKey[2]);
              var cond2 = eval("'"+gauceDataSet.NameValue(j, subStrKey[0])+"' "+subStrKey[1]+" "+subStrKey[2]);
              var iValue = (gauceDataSet.NameValue(i, subStrKey[0])=='') ? 0: gauceDataSet.NameValue(i, subStrKey[0]);
              var jValue = (gauceDataSet.NameValue(j, subStrKey[0])=='') ? 0: gauceDataSet.NameValue(j, subStrKey[0]);
              if((iValue == jValue) && cond1 && cond2) {
                intChk++;
              }
           }
        }
      }
      if (intChk == strKey.length) return (j);
    }
  }
  return 0;
}

/**
* getGridColumnIDs
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : GridObject, show(true/false) 형식으로 Column의 ID를 반환한다.
* 사 용 법 : var strArray =  getGridColumnIDs(gr_master, true);
*/
function getGridColumnIDs(objGrid, blnExcludeHidden) {
  var regExp = new RegExp("(id=[\'\"]?)([a-zA-Z0-9_]+)([\'\"]?)", "gi");
  var gridFormat = objGrid.format;
  var result = new Array();

  while (regExp.exec(gridFormat) != null) {
    if (!blnExcludeHidden || objGrid.columnProp(RegExp.$2, "show") == "TRUE") {
      result.push(RegExp.$2);
    }
  }
  return result;
}

/**
* enableColumnHidden
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : Grid Object Name으로 컬럼의 Header를 숨김/전체보이기 기능을 생성하는 DHTML 함수
* 사 용 법 : enableColumnHidden(gridName);
* 주의사항 : 반드시 </head> Tag위에 위치 할 것
*/
function enableColumnHidden(strGridName){
  var strTemp = '<script language="javascript"  for='+strGridName+' event=OnCommand(code,text)>' +
    'switch(code){' +
    'case 1:' +
    'colid = '+strGridName+'.GetColumn();' +
    strGridName+'.ColumnProp(colid, "Show") = false;' +
    'break;' +
    'case 2:' +
    'var gridColumnId = getGridColumnIDs('+strGridName+', false);' +
    'for(var i=0, n=gridColumnId.length;i<n;i++){ ' +
    strGridName+'.ColumnProp(gridColumnId[i], "Show") = true;' +
    '}' +
    'break;' +
    'default:' +
    'break;' +
    '}' +
    '</script>' +
    '<script language="javascript"  for='+strGridName+' event=OnRButtonDown(Row,Colid,xpos,ypos)>' +
    'if(Row == 0 && Colid != "__INDICATOR__" ){' +
    strGridName+'.SetColumn(Colid);' +
    'var columnName = '+strGridName+'.ColumnProp(Colid, "Name");' +
    strGridName+'.MenuData= "[" + columnName + "] 컬럼 숨기기^1^1^1,전체 컬럼 보이기^1^2^1"; ' +
    strGridName+'.TrackPopupMenu(xpos, ypos);' +
    '}' +
    '</script>';
    document.writeln(strTemp);
}

/**
 * parseGauceHeader
 * 작 성 자 : FKL
 * 작 성 일 : 2006-06-20
 * 개    요 : strHeader(컬럼의 항목간의 구분자 ~t, 컬럼별 구분자 ~r 로 구성된 문자열을
 *            setDataHeader()에 적용 할 수 있는 형태로 자동 변환
 * 사 용 법 : ds_master.setDataHeader(parseGauceHeader('<%=request.getAttribe("QUERY_NAME")%>"));
 */
function parseGauceHeader(strHeader){
  if (strHeader == "null" || strHeader == "" || strHeader == null || strHeader == undefined) return "";
  var strRow;
  var strReturn = "";
  strRow = strHeader.split("~r");

  for(var i=0, n=strRow.length;i<n;i++){
    var strColumn = strRow[i].split("~t");
    strReturn = strReturn + strColumn[0];
    switch(strColumn[1]){
      case "TB_STRING"  :
        strReturn = strReturn + ":STRING(" + strColumn[2] + ")";
        break;
      case "TB_DECIMAL" :
        strReturn = strReturn + ":DECIMAL(" + strColumn[2] + "." + nullToZero(strColumn[3]) + ")";
        break;
      case "TB_INT" :
        strReturn = strReturn + ":INTEGER("  + strColumn[2] + ")";
        break;
      case "TB_URL" :
        strReturn = strReturn + ":URL(" + strColumn[2] + ")";
        break;
      default :
        break;
    }
    switch(strColumn[4]){
      case "TB_KEY" :
        strReturn = strReturn + ":KEYVALUETYPE";
        break;
      case "TB_NOTNULL" :
        strReturn = strReturn + ":NOTNULL";
        break;
      case "TB_NORMAL" :
        break;
      default :
        break;
    }

    if(i != n -1){
      strReturn = strReturn + ",";
    }
  }
  return strReturn;
}

/**
 * markingRequiredColumn(gridObject)
 * 작 성 자 : FKL
 * 작 성 일 : 2006-06-20
 * 개    요 : XML에 기술한 가우스 컬럼에서 TB_KEY, TB_NOTNULL일 경우 자동으로 GRID의 HeadColor를 Highlight 시킴
 * 사 용 법 : markingRequiredColumn(GR_XXXXXX);
 */
function markingRequiredColumn(grid){
  var dataset = eval(grid.DataID);
  for (var i=1, n=dataset.CountColumn;i<=n;i++) {
    switch(dataset.ColumnProp(i)){
      case 0 :    // Normal Column
        break;
      case 1 :    // Constant Column
        break;
      case 2 :    // Key Column
        var columnId = dataset.ColumnID(i);
        if (grid.ColumnProp(columnId, 'HeadColor') != undefined){
          if (grid.ColumnProp(columnId, 'HeadColor') != 14968596) { // '#1467E4'의 10진수 값
            grid.ColumnProp(columnId,'HeadColor') = 14968596;
          }
        }
        break;
      case 3 :    // Sequence Column
          break;
      case 4 :    // Not Null Column
        var columnId = dataset.ColumnID(i);
        if (grid.ColumnProp(columnId, 'HeadColor') != undefined){
          if (grid.ColumnProp(columnId, 'HeadColor') != 14968596) { // '#1467E4'의 10진수 값
            grid.ColumnProp(columnId,'HeadColor') = 14968596;
          }
        }
        break;
      case 5 :    // Reference Column
        break;
      default :
        break;
    }
  }
}

/**
* initComboStyle
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : LuxeCombo의 Style 및 기본적 PARAMETER SETTING
* 사 용 법 : initComboStyle(LC_DEAL_GUBN_S, ds_deal_gubn, "ETC_CODE^0^20,ETC_NAME^0^100", 1, PK/READ/NORMAL);
*          initComboStyle(LuxeCombo ID, Dataset Name, ExprForamt, SearchColumn Index, PK)
*/
function initComboStyle(objCombo, strDataSet, strExprFormat, intSearchColumn,  strType, strDsBindFlag){
  objCombo.ComboDataID      = strDataSet.id;
  objCombo.ListExprFormat   = strExprFormat;
  objCombo.FontSize         = "10";
  objCombo.FontName         = "돋움";
  objCombo.ListCount        = 10;
  objCombo.SearchColumn     = strExprFormat.split(",")[intSearchColumn].split("^")[0];
  objCombo.BindColumn       = strExprFormat.split(",")[0].split("^")[0];
  
  // 콤보 리스트의 선 표시여부 설정
  objCombo.HasListGridHorizLine = false;
  objCombo.HasListGridVertLine  = false;
  //--
  objCombo.InheritColor      = true;
  if (strDsBindFlag != true){
    objCombo.SyncComboData    = false;
  }
  objCombo.WantSelChgEvent  = true;
  switch(THEME){
    case SPRING :
      break;
    case SUMMER :
      break;
    case FALL   :
      break;
    case WINTER :
      setObjTypeStyle( objCombo, "COMBO", strType );
      break;
    default :
      break;
  }
}

/**
* initComboStyleSearch
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : LuxeCombo의 Style 및 기본적 PARAMETER SETTING
* 사 용 법 : initComboStyleSearch(LC_DEAL_GUBN_S, ds_deal_gubn, "ETC_CODE^0^20,ETC_NAME^0^100", 1, PK/READ/NORMAL);
*          initComboStyleSearch(LuxeCombo ID, Dataset Name, ExprForamt, SearchColumn Index, PK)
*/
function initComboStyleSearch(objCombo, strDataSet, strExprFormat, intSearchColumn,  strType, strDsBindFlag){
  objCombo.ComboDataID      = strDataSet.id;
  var intFormatSubstring = strExprFormat.indexOf(",");
  var strFormatSubstring = strExprFormat.substring(intFormatSubstring+1);
  objCombo.ListExprFormat   = strFormatSubstring;
  objCombo.FontSize         = "10.5";
  objCombo.FontName         = "돋움";
  objCombo.ListCount        = 10;
  objCombo.SearchColumn     = strExprFormat.split(",")[intSearchColumn].split("^")[0];
  objCombo.BindColumn       = strExprFormat.split(",")[0].split("^")[0];
  // 콤보 리스트의 선 표시여부 설정
  objCombo.HasListGridHorizLine = false;
  objCombo.HasListGridVertLine  = false;
  //--
  objCombo.InheritColor      = true;
  if (strDsBindFlag != true){
    objCombo.SyncComboData    = false;
  }
  objCombo.WantSelChgEvent  = true;
  switch(THEME){
    case SPRING :
      break;
    case SUMMER :
      break;
    case FALL   :
      break;
    case WINTER :
      setObjTypeStyle( objCombo, "COMBO_SEARCH", strType );
      break;
    default :
      break;
  }
}

/**
*initEmEdit(EmeEdit objEdit, String strFormat, editStyle)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : eme edit의 스타일을 적용한다.
* 인 자 값 : edit-eme eidt오브젝트, parameters-속성파라미터, String editStyle-편집속성(PK/READ/NORMAL)
* 사용방법 : initEmEdit(edit, "YYYYMMDD", PK/READ/NORMAL);
             initEmEdit(edit, "YYYYMM", PK/READ/NORMAL);
             initEmEdit(edit, "NUMBER^10^2", PK/READ/NORMAL); --> 10,2의 소수점 체크
             initEmEdit(edit, "NUMBER2^10^2", PK/READ/NORMAL); --> NUMBER 에 컴마를 뺐음
             initEmEdit(edit, "POST", PK/READ/NORMAL);
             initEmEdit(edit, "GEN", PK/READ/NORMAL);
             initEmEdit(edit, "GEN^5", PK/READ/NORMAL); --> ^를 사용하여 최대자리수 설정[디폴트 50자리]
             initEmEdit(edit, "##-#####-#####", PK/READ/NORMAL);
             initEmEdit(edit, "CODE^5^9", PK/READ/NORMAL);  --> 코드성 데이터의 입력 형식 지정( CODE^자리수^형식(EM_EDIT 의 Format String 참조)
* return값 : void
**/
function initEmEdit(objEdit, strFormat,  blnEditStyle){
  var arrFormat            = new Array();
  objEdit.ClipMode         = "true";
  objEdit.MoveCaret        = "true";
  objEdit.PromptChar       = " ";
  objEdit.SelectAllOnClick = "true";
  objEdit.InheritColor     = "true";
  objEdit.Border           = "false";
  objEdit.VAlign           = 1;
  

  objEdit.FontSize         = "16";
  objEdit.FontName         = "돋움";
  
  arrFormat = strFormat.toUpperCase().split("^");
  
  // 오늘 일자 셋팅 
  var now = new Date();
  var mon = now.getMonth()+1;
  if(mon < 10)mon = "0" + mon;
  var day = now.getDate();
  if(day < 10)day = "0" + day;
  
  switch(arrFormat[0]){
    case 'HHMI' :
        objEdit.Numeric   = "false";
        objEdit.Alignment = 1;
        objEdit.Format = "HH:NN";
        break;
    case 'HHMISS' :
        objEdit.Numeric   = "false";
        objEdit.Alignment = 1;
        objEdit.Format = "HH:NN:SS";
        break;
    case 'YYYYMMDD' :
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM/DD";
      break;
    case 'YYYYMM' :
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM";
      break;
    case 'NUMBER' :
        objEdit.Alignment       = 2;
        objEdit.Numeric         = "true";
        objEdit.MaxLength       = parseInt(arrFormat[1]);
        objEdit.MaxDecimalPlace = parseInt(arrFormat[2]);
        objEdit.IsComma         = "true";
        break;
    case 'NUMBER2' :
        objEdit.Numeric         = "true";
        objEdit.MaxLength       = parseInt(arrFormat[1]);
        objEdit.MaxDecimalPlace = parseInt(arrFormat[2]);
        objEdit.IsComma         = "false";
        break;
    case 'NUMBER3' :
        var tmpFormat = "";
        for (i=0; i<parseInt(arrFormat[1]); i++) {
            tmpFormat += "0";
        }
        objEdit.PromptChar = "";
        objEdit.Format = tmpFormat;
        objEdit.MaxLength= parseInt(arrFormat[1]);
        break;
    case 'POST' :
        objEdit.Alignment = 1;
        objEdit.Format = "###-###";
        break;
    case 'GEN' :
        objEdit.Alignment    = 0;
        objEdit.GeneralEdit  = "true";
        if(arrFormat.length > 1){
            objEdit.MaxLength       = parseInt(arrFormat[1]);          
        }else{
            objEdit.MaxLength    = 50;
        }
        break;
    case 'CODE' :
        objEdit.Numeric   = "false";
        objEdit.GeneralEdit  = "false";
        objEdit.Alignment = 0;
        var formatChar = "#";
        var length = 4;        
        if( arrFormat.length > 2 ){
            formatChar = arrFormat[2];
            length = parseInt(arrFormat[1]);
        } else if( arrFormat.length > 1){
            length = parseInt(arrFormat[1]);
        }
        var format = formatChar;
        for( var i = 1; i < length; i++){
            format += formatChar;
        }
        objEdit.Format = format;
        break;
    case 'TODAY' :
        var varToday = now.getYear().toString()+ mon + day;
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM/DD";
        objEdit.Text = varToday;
        break;
    case 'THISMON' :
        var varToday = now.getYear().toString()+ mon;
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM/DD";
        objEdit.Text = varToday;
        break;
    case 'THISYEAR' :
        var varToday = now.getYear().toString();
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM/DD";
        objEdit.Text = varToday;
        break;
    case 'THISMN' :
        var varToday = now.getYear().toString()+ mon;
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM";
        objEdit.Text = varToday;
        break;
    case 'THISYR' :
        var varToday = now.getYear().toString();
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY";
        objEdit.Text = varToday;
        break;
    case 'SYYYYMMDD' :
        var varToday = now.getYear().toString()+ mon + "01";
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM/DD";
        objEdit.Text = varToday;
        break;
    case 'EYYYYMMDD' :
        var lastDate =new Date(now.getYear().toString(),mon, 0);
        var varToday = now.getYear().toString()+ mon + lastDate.getDate();
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM/DD";
        objEdit.Text = varToday;
        break;
    case 'SYYYYMM' :
        var varToday = now.getYear().toString() + "01";
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM";
        objEdit.Text = varToday;
        break;
    case 'EYYYYMM' :
        var varToday = now.getYear().toString() + "12";
        objEdit.Alignment = 1;
        objEdit.Format = "YYYY/MM";
        objEdit.Text = varToday;
        break;
    default :
        objEdit.Alignment    = 0;
        objEdit.GeneralEdit  = false;
        objEdit.Format = arrFormat[0]
        break;
  }

  switch(THEME){
        case SPRING :
      break;
    case SUMMER :
      break;
    case FALL   :
      break;
    case WINTER :
      setObjTypeStyle( objEdit, "EMEDIT", blnEditStyle );
      break;
    default :
        break;
    }
}

/**
* setObjTypeStyle()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 : EMEdit, COMBO의 PK,READ,NORMAL 상태를 변경 시키다.
* 사용법: setObjTypeStyle( obj, objType, strType )
*        obj      --> (EmEdit 또는 Combo) 오브젝트
*        objType  --> 오브젝트 타입( COMBO, COMBO_SEARCH, EMEDIT )
*        strType  --> 상태타입( PK , READ , NORMAL)
*        
*        ex) setObjTypeStyle( EM_I_AREA_SIZE, "EMEDIT", NORMAL ); 
* return값 : void
*/
function setObjTypeStyle( obj, objType, strType ){
    switch(objType.toUpperCase()){
        case "COMBO" :
            obj.DisableBackColor      = "#e7e7e7";
            switch(strType){
              case PK   :
                obj.className             = "combo_pk";
                obj.Enable                = true;
                obj.DefaultString         = "";
                break;
              case READ :
                obj.Enable                = false;
                obj.className             = "combo_read";
                obj.DefaultString         = "";
                break;
              case NORMAL :
                obj.className             = "combo";
                obj.Enable                = true;
                obj.DefaultString         = "";
              default :
                break;
            }
            break;
        case "COMBO_SEARCH" :
            obj.DisableBackColor      = "#e7e7e7";
            switch(strType){
              case PK   :

                obj.style.border          = "none";
                obj.className             = "combo_pk";
                obj.Enable                = true;
                obj.DefaultString         = "==선택하세요==";
                  break;
              case READ :
                obj.Enable                = false;
                obj.className             = "combo_read";
                obj.DefaultString         = "";
                       break;
              case NORMAL :
                obj.className             = "combo";
                obj.Enable                = true;
                obj.DefaultString         = "==선택하세요==";
              
              default :
                break;
            }
            break;
        case "EMEDIT" :
            obj.DisabledBackColor     = "#e7e7e7";
            obj.ReadOnlyBackColor     = "#f2f5f8"; 
            obj.ReadOnlyForeColor     = "#555555";
            switch(strType){
                case PK   :
                    obj.Enable                = true;
                    obj.className             = "input_pk"
                    break;
                case READ :
                    obj.Enable                = false;
                    obj.className             = "input_read";
                    break;
                case NORMAL :
                    obj.Enable                = true;
                    obj.className             = "input";
                default :
                    break;
            }
            break;
        case "TEXTAREA" :
            obj.DisabledBackColor      = "#e7e7e7";
            switch(strType){
                case PK   :
                    obj.Enable                = true;
                    obj.className             = "textarea_pk"
                    break;
                case READ :
                    obj.Enable                = false;
                    obj.className             = "textarea_read";
                    break;
                case NORMAL :
                    obj.Enable                = true;
                    obj.className             = "textarea";
                default :
                    break;
            }
            break;
    }
}
/**
* openExcel(objGrid, strTitle, blnSupp)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : Excel Export 공통
* 인 자 값 : objGrid  : Grid Object
             strTitle : 파일명 또는 제목
* return값 : Void
*/

function openExcel(objGrid, strTitle, blnSupp){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    if (dataset.CountRow == 0){
    showMessage(Information, Ok, "SCRIPT-1014");
    return false;
    }
    obj.push(objGrid);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));

    if (blnSupp == false) {
      obj.push(false);
    } else {
      obj.push(true);
  }
    var h = windowsXPSP2 == true ? "230" : "195";
    return window.showModalDialog("/pot/jsp/excel.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* openExcel2(objGrid, strTitle, strCond, blnSupp)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : Excel Export 공통
* 인 자 값 : objGrid  : Grid Object
             strTitle : 파일명 또는 제목
             strCond  : 조회조건
             bInSupp  :
* return값 : Void
*/

function openExcel2(objGrid, strTitle, strCond, blnSupp, onlyTxt){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    if (dataset.CountRow == 0){
        showMessage(Information, Ok, "SCRIPT-1014");
        return false;
    }
    obj.push(objGrid);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));
    obj.push(strCond.replace(/[\/:*?"<>|]/gi,""));
    if (blnSupp == false) {
        obj.push(false);
    } else {
        obj.push(true);
    }
    obj.push(onlyTxt);
    var h = windowsXPSP2 == true ? "230" : "195";
    return window.showModalDialog("/pot/jsp/excel.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}


/**
* openExcel3()
* 작 성 자 : KHY
* 작 성 일 : 2007-11-09
* 개    요  : 그리드가 Master, Detail 두개일 때 사용함
* 사용방법 : gfbuyExcel(objGrid1, objGrid2, strTitle, strCond, strMasterInfo)
*            arguments[0] -> MASTER 그리드 ID
*            arguments[1] -> DETAIL 그리드 ID
*            arguments[2] -> 제목 
*            arguments[3] -> 조회 필수 조건 (줄내림하고 싶을때는 ^ 사용)
*            arguments[4] -> 마스터 정보     (줄내림하고 싶을때는 ^ 사용)
*
*         ex) gfbuyExcel(GD_MASTER, GD_DETAIL, "샘플 타이틀", "브랜드 #헤르본#^색상 #레드#", "스타일 #가가가가#");

* return값 : void
*/
function openExcel3(objGrid1, objGrid2, strTitle, strCond, strMasterInfo){
    if( strMasterInfo == undefined ) strMasterInfo = '';
    
    var obj = new Array();
    var dataset1 = eval(objGrid1.DataID);
    var dataset2 = eval(objGrid2.DataID);
    if ( dataset1.CountRow == 0 && dataset2.CountRow == 0 ){
        showMessage(Information, Ok, "SCRIPT-1014");
        return false;
    }
    obj.push(objGrid1);
    obj.push(objGrid2);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));
    obj.push(strCond.replace(/[\/:*?"<>|]/gi,""));
    obj.push(strMasterInfo.replace(/[\/:*?"<>|]/gi,""));

    var h = windowsXPSP2 == true ? "265" : "265";
    return window.showModalDialog("/pot/jsp/gfbuy/excel.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* openExcel4(objGrid, strTitle, strCond, blnSupp)
* 작 성 자 : FKL
* 작 성 일 : 2010-06-01
* 개    요 : Excel Export 공통(조회된 데이타가 없어도 엑셀 다운로드 가능)
* 인 자 값 : objGrid  : Grid Object
             strTitle : 파일명 또는 제목
             strCond  : 조회조건
             bInSupp  :
* return값 : Void
*/

function openExcel4(objGrid, strTitle, strCond, blnSupp){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    
    obj.push(objGrid);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));
    obj.push(strCond.replace(/[\/:*?"<>|]/gi,""));
    if (blnSupp == false) {
        obj.push(false);
    } else {
        obj.push(true);
    }
    var h = windowsXPSP2 == true ? "230" : "195";
    return window.showModalDialog("/pot/jsp/excel.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* openExcel5(objGrid, strTitle, strCond,  blnSupp, onlyTxt, strPid)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : Excel Export 공통
* 인 자 값 : objGrid  : Grid Object
             strTitle : 파일명 또는 제목
             strCond  : 조회조건
             bInSupp  :
             onlyTxt  :
             strPid   : 프로그램ID (pid 추가)
* return값 : Void
*/

function openExcel5(objGrid, strTitle, strCond,  blnSupp, onlyTxt, strPid){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    if (dataset.CountRow == 0){
        showMessage(Information, Ok, "SCRIPT-1014");
        return false;
    }
    obj.push(objGrid);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));
    obj.push(strCond.replace(/[\/:*?"<>|]/gi,""));
    if (blnSupp == false) {
        obj.push(false);
    } else {
        obj.push(true);
    }
    obj.push(onlyTxt);
    obj.push(strPid);
    var h = windowsXPSP2 == true ? "230" : "195";
    return window.showModalDialog("/pot/jsp/excel.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* openExcelM(objGrid, strTitle, strCond, blnSupp)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : Excel Export 공통
* 인 자 값 : objGrid  : Grid Object
             strTitle : 파일명 또는 제목
             strCond  : 조회조건
             bInSupp  :
* return값 : Void
*/

function openExcelM(objGrid, strTitle, strCond, blnSupp){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    if (dataset.CountRow == 0){
        showMessage(Information, Ok, "SCRIPT-1014");
        return false;
    }
    obj.push(objGrid);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));
    obj.push(strCond.replace(/[\/:*?"<>|]/gi,""));
    if (blnSupp == false) {
        obj.push(false);
    } else {
        obj.push(true);
    }
    var h = windowsXPSP2 == true ? "230" : "195";
    return window.showModalDialog("/pot/jsp/excelM.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* openExcelM(objGrid, strTitle, strCond, blnSupp)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : Excel Export 공통
* 인 자 값 : objGrid  : Grid Object
             strTitle : 파일명 또는 제목
             strCond  : 조회조건
             bInSupp  :
* return값 : Void
*/

function openExcelM2(objGrid, strTitle, strCond, blnSupp, strPid){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    if (dataset.CountRow == 0){
        showMessage(Information, Ok, "SCRIPT-1014");
        return false;
    }
    obj.push(objGrid);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));
    obj.push(strCond.replace(/[\/:*?"<>|]/gi,""));
    if (blnSupp == false) {
        obj.push(false);
    } else {
        obj.push(true);
    }
    obj.push(strPid);
    var h = windowsXPSP2 == true ? "230" : "195";
    return window.showModalDialog("/pot/jsp/excelM.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* openExcel2(objGrid, strTitle, strCond, blnSupp)
* 작 성 자 : FKL
* 작 성 일 : 2010-05-12
* 개    요 : Excel Export 공통(Show가 false인 Column을 출력)
* 인 자 값 : objGrid  : Grid Object
             strTitle : 파일명 또는 제목
             strCond  : 조회조건
             bInSupp  :
* return값 : Void
*/

function openExcelS(objGrid, strTitle, strCond, blnSupp){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    if (dataset.CountRow == 0){
        showMessage(Information, Ok, "SCRIPT-1014");
        return false;
    }
    obj.push(objGrid);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));
    obj.push(strCond.replace(/[\/:*?"<>|]/gi,""));
    if (blnSupp == false) {
        obj.push(false);
    } else {
        obj.push(true);
    }
    var h = windowsXPSP2 == true ? "230" : "195";
    return window.showModalDialog("/pot/jsp/excelS.jsp", obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* openPrint(String)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : Excel Export 공통
* 인 자 값 : objGrid  : Grid Object
             strTitle : 파일명 또는 제목
* return값 : Void
*/
function openPrint(objGrid, strTitle, blnSupp){
    var obj = new Array();
    var dataset = eval(objGrid.DataID);
    if (dataset.CountRow == 0){
    showMessage(Information, Ok, "SCRIPT-1014");
    return false;
    }
    obj.push(objGrid);
    obj.push(strTitle.replace(/[\/:*?"<>|]/gi,""));

    if (blnSupp == false) {
      obj.push(false);
    } else {
      obj.push(true);
  }

    var h = windowsXPSP2 == true ? "175" : "155";
    return window.showModalDialog("/html/excel.html",obj,"dialogWidth:430px;dialogHeight:" + h + "px;scroll:no;resizable:no;help:no;unadorned:yes;center:yes;status:no");
}

/**
* getComboData(objCombo, strColumnID)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : 콤보의 데이터값을 갖어온다.(현재 Position)
* 사용방법 : getComboData(LC_STORE_CODE, “STORE_CODE”);
*            arguments[0] -> LuxeCombo Object;
*            arguments[1] -> LuxeCombo에 연동한 DataSet의 ColumnID ( XML에 지정한 Gauce Column ID와 동일)
* return값 : String
*/
function getComboData(objCombo, strColumnID){
  var combo      = eval(objCombo);
  return combo.ValueOfIndex(strColumnID, combo.Index) ;
}

/**
* setComboData( ComboObject, String)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : 콤보에 원하는 strValue에 해당하는 값으로 표시한다.
* 사용방법 : setComboData(LC_STORE_CODE, “07”);
*            arguments[0] -> LuxeCombo Object;
*            arguments[1] -> 셋팅을 원하는 value
* 주의사항   ListExprFormat에 셋팅되어 있는 첫번째 컬럼을 기준을 셋팅한다.
* return값 : void
*/
function setComboData(objCombo, strValue){
  var combo        = eval(objCombo);
  combo.BindColVal = strValue;
}

/**
* getComboDataId(ComboObject, String Columid, String value, String TargetColumnId)
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : strColumnId의 값이 strValue인 TargetColumnId의 값을 갖어온다.
* 사용방법 : getComboData(LC_STORE_CODE, “STORE_CODE”, “07”, “STORE_NAME”);
*            arguments[0] -> LuxeCombo Object;
*            arguments[1] -> value의 조회 조건이 되는 ColumnId
*            arguments[2] -> ColumnId에서 찾고자 하는 value
*            arguments[3] -> 갖고 오기를 원하는 ColumnId
* return값 : String
*/
function getComboDataId(objCombo, strColumnId, strValue, strTargetColumnId){
  var combo        = eval(objCombo);
  return combo.ValueByColumn(strColumnId, strValue, strTargetColumnId)
}


/**
* undo()
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : 그리드에서 Undo 기능 함수
* 사용범위 : 공통에서 사용
* return값 : String
*/
function undo(){
  if (FOCUSEDGRID != '' && FOCUSEDGRID != null){
    var gridObject = FOCUSEDGRID;
    var dataSetObject = eval(gridObject.DataID);
    dataSetObject.UndoMarked();
    gridObject.Focus();
  }
}

/**
* deleteAllRow()
* 작 성 자 : FKL
* 작 성 일 : 2006-06-20
* 개    요 : 선택된 전체 Row에 대해서 삭제 처리한다.
* 인 자 값 : GaudataSetObject : Gauce DataSet Object
* 사용범위 : 개발자 사용 가능
* return값 : String
*/
function deleteAllRow(dataSetObject){
  for(var i=1, n=dataSetObject.CountRow;i<=n;i++){
    if( dataSetObject.RowMark(i) == 1){
      dataSetObject.DeleteRow(i);
    }
  }
}

/**
 * deActivate()
 * 작 성 자 : FKL
 * 작 성 일 : 2006-06-20
 * 개    요 : 마지막 포커스를 갖고 있던 GridObject 명칭 지정
 * return값 : Void
 */
function deActivate(){
  if(event.srcElement.tagName.toUpperCase() == "OBJECT"){
    if(event.srcElement.classid.toUpperCase() == CLSID_GRID){
      FOCUSEDGRID = event.srcElement;
    }
  }
}

/**
 * document.ondeactivate event Handler passing
 * 작 성 자 : FKL
 * 작 성 일 : 2006-06-20
 * 개    요 : document.ondeactivate event에 deActivate을 Attach함.
 * return값 : Void
 */
document.attachEvent('ondeactivate', deActivate);

/**
 * hasFocusObject()
 * 작 성 자 : FKL
 * 작 성 일 : 2006-06-20
 * 개    요 : Document에서 Focus를 갖고있는 GRID OBJECT 탐색
 * return값 : Void
 */
function hasFocusObject(){
  var obj = document.body.all;
  for(var i=0, n=obj.length;i<n;i++) {
    var strTagName = obj.item(i).tagName.toUpperCase();
    if (strTagName == "OBJECT") {
      if (obj.item(i).classid.toUpperCase() == CLSID_GRID){
        if(obj.item(i).FocusState){
          LASTFOCUSEDOBJ = obj.item(i);
          return true;
        }
      }
    }
  }
  return false;
}

/**
 * setPorcCount()
 * 작 성 자 : FKL
 * 작 성 일 : 2006-06-20
 * 개    요 : tr결과에 대한 return value count세팅
 * return값 : Void
 */
function setPorcCount(jobGubun, RowCount){
	var strMsg = ""; 

	switch(jobGubun.toUpperCase()){
    case  "SELECT"  :
        if (typeof(arguments[1]) == "object" ) {
            var DsID = arguments[1].DataId;
            var DsCnt = eval(DsID).CountRow;
            strMsg = "▒▒▒▒▒ [" + DsCnt + "]건이 조회되었습니다. ▒▒▒▒▒";
            arguments[1].Focus();
        } else {
        	strMsg = "▒▒▒▒▒ [" + RowCount + "]건이 조회되었습니다. ▒▒▒▒▒";
        }
        
        break;           
    case  "CLEAR" :
    	strMsg = "";
        break;    
    default :
        break;
    }

	try{
		window.external.GetFrame(window).Provider('../').OuterWindow.showStatusBar(strMsg);
	} catch(e){		
	}
	
	
    return;
}


/**
* setFocusGrid()
* 작 성 자 : ckj
* 작 성 일 : 2006-08-24
* 개    요 :  GRID의 원하는 컬럼에 포커스 주기.
* 사용방법 : setFocusGrid(gridObjId, dataSetId, row, colId)
*            arguments[0] -> 이벤트 대상인  GRID의 아이디 
*            arguments[1] -> GRID와 바인드 되어 있는 데이타셋의 아이디 
*            arguments[2] -> 포커스 될 컬럼의  row 포지션 
*            arguments[3] -> 포커스 될 컬럼의 아이디  
* return값 : str
*/
function setFocusGrid(gridObjId, dataSetId,row,colId) {
    dataSetId.RowPosition = row;
    gridObjId.SetColumn(colId);
    gridObjId.Focus();
}



/**
* isDataSetModified(dataSetId)
* 작 성 자 : ckj
* 작 성 일 : 2006-08-25
* 개    요 : DataSet 변경 여부 체크하기 ( 예)GRID변경내용여부 확인시 사용 )
* 사용방법 : isDataSetModified(dataSetId)
*            arguments[0] -> 확인하고자 하는 DataSet의 아이디
* return값 : boolean
*/
function isDataSetModified( dataSetId ) {    //기존에 이 function 쓰고 있는 코드 모두 가우스의 IsUpdated 프로퍼티로 바꾸시길...
    return dataSetId.IsUpdated;
}

///////공통 : 조직정보 불러오기 /////////////////////////////////////////////////////
/**
*  아래와  같이 DataSet을 정의하 고 사용하세요 ~~
*
*    <comment id="_NSID_"><object id="DS_I_CONDITION"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
*
*/

var jojikDataHeader = 'AUTH_GB:STRING(1),BONSA_GB:STRING(1),ALL_GB:STRING(1),STR_CD:STRING(4),DEPT:STRING(2),TEAM:STRING(2),PC:STRING(2),ORG_FLAG:STRING(1),MNG_ORG_YN:STRING(1),ADD_CONDITION:STRING(200)';

/**
* getStore(strDataSet, authGb, bonsaGb, allstrGb, allGb)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : 점 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getStore("DS_O_STORE", "Y", "Y", "Y", "Y");
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 권한에 따라 보여질지 여부 ( Y/N )
*            arguments[2] -> 본사점 표시 유무  0:본사점, 1:매장 '':본사 + 매장
*            arguments[3] -> '전체'를 보일건지 여부 ( Y/N )
*            ---------------------------------------------------------------------
*            arguments[4] -> 매장, 매입조직 구분 없이 조회 여부
* return값 : void
*/
function getStore(strDataSet, authGb, bonsaGb, allGb) {

    var addCondition = setAddCondition( 4, arguments );
    
    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BONSA_GB") = bonsaGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB") = allGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getStore";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_STORE="+strDataSet+")";
    TR_MAIN.Post();
}
/**
* getStore2(strDataSet, authGb, bonsaGb, allstrGb, allGb, strOrgFlag)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : 점 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getStore("DS_O_STORE", "Y", "Y", "Y", "Y");
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 권한에 따라 보여질지 여부 ( Y/N )
*            arguments[2] -> 본사점 표시 유무  0:본사점, 1:매장 '':본사 + 매장
*            arguments[3] -> '전체'를 보일건지 여부 ( Y/N )
*            ---------------------------------------------------------------------
*            arguments[4] -> 매장, 매입조직 구분 없이 조회 여부/
*            arguments[5] -> 화면에서 선택한 조직구분(필수)/
* return값 : void
*/
function getStore2(strDataSet, authGb, bonsaGb, allGb, strOrgFlag) {

    var addCondition = setAddCondition( 4, arguments );
    
    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BONSA_GB") = bonsaGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB") = allGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getStore2&strOrgFlag="+strOrgFlag;
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_STORE="+strDataSet+")";
    TR_MAIN.Post();
}
/**
* getDept(strDataSet, strStrCd, allGb
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : 부문 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getDept(strDataSet, "01", "Y")
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점 코드
*            arguments[2] -> '전체'를 보일건지 여부 ( Y/N )
*            arguments[3] -> 조직구분
*            --------------------- 미필수
*            arguments[4] -> 관리조직 여부 
* return값 : void
*/
function getDept(strDataSet, authGb, strStrCd, allGb, strMngOrgYn) {
    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")  = strStrCd;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB")  = allGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;
    if(arguments.length > 5)
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = arguments[5];
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getDept";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_DEPT="+strDataSet+")";
    TR_MAIN.Post();
}
/**
* getDept2(strDataSet, strStrCd, allGb
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : 부문 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getDept(strDataSet, "01", "Y")
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점 코드
*            arguments[2] -> '전체'를 보일건지 여부 ( Y/N )
*            arguments[3] -> 조직구분
*            --------------------- 미필수
*            arguments[4] -> 관리조직 여부 
*            arguments[5] -> 화면에서 선택한 조직구분(필수)/
* return값 : void
*/
function getDept2(strDataSet, authGb, strStrCd, allGb, strMngOrgYn, strOrgFlag) {
    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")  = strStrCd;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB")  = allGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;    
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = strOrgFlag   //arguments[5];
   
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getDept2&strOrgFlag="+strOrgFlag;
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_DEPT="+strDataSet+")";
    TR_MAIN.Post();
}

/**
* getTeam(strDataSet, strStrCd, strDept, allGb)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : Team 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getTeam(strStrCd, strJojikGb, strBu, "N", strDataSet);
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점 
*            arguments[2] -> 부문
*            arguments[3] -> '전체'를 보일건지 여부 ( Y/N )
*            arguments[4] -> 조직구분
*            --------------------- 미필수
*            arguments[5] -> 관리조직 여부 
* return값 : void
*/
function getTeam(strDataSet, authGb,strStrCd, strDept, allGb, strMngOrgYn)  {    

    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")  = strStrCd;        //점코드
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "DEPT")      = strDept;        //부서 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB")  = allGb;        //Y/N
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;
    if(arguments.length > 6)
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = arguments[6];
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getTeam";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_TEAM="+strDataSet+")";
    TR_MAIN.Post();
}
/**
* getTeam(strDataSet, strStrCd, strDept, allGb)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : Team 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getTeam(strStrCd, strJojikGb, strBu, "N", strDataSet);
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점 
*            arguments[2] -> 부문
*            arguments[3] -> '전체'를 보일건지 여부 ( Y/N )
*            arguments[4] -> 조직구분
*            --------------------- 미필수
*            arguments[5] -> 관리조직 여부 
*            arguments[6] -> 화면에서 선택한 조직구분(필수)/
* return값 : void
*/
function getTeam2(strDataSet, authGb, strStrCd, strDept, allGb, strMngOrgYn, strOrgFlag)  {    

    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")  = strStrCd;        //점코드
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "DEPT")      = strDept;        //부서 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB")  = allGb;        //Y/N
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;
    
        
    
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = strOrgFlag//arguments[6];
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getTeam2&strOrgFlag="+strOrgFlag;
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_TEAM="+strDataSet+")";
    TR_MAIN.Post();
}


/**
* getPc(strDataSet, strStrCd, strDept, strTeam, allGb)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : pc콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getPc(strStrCd, strJojikGb, strBu, strGwa, "N", strDataSet);
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점 
*            arguments[2] -> 부문
*            arguments[3] -> 층(팀) 
*            arguments[4] -> 권한에 따라 보여질지 여부 ( Y/N )
*            arguments[5] -> 조직구분
*            --------------------- 미필수
*            arguments[6] -> 관리조직 여부 
* return값 : void
*/
function getPc(strDataSet, authGb,strStrCd, strDept, strTeam, allGb, strMngOrgYn)  {

    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD" )    = strStrCd; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "DEPT" )      = strDept; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TEAM" )      = strTeam;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB" )    = allGb;
    
    
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = arguments[7];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getPc";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_PC="+strDataSet+")";
    TR_MAIN.Post();
}
/**
* getPc(strDataSet, strStrCd, strDept, strTeam, allGb)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : pc콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getPc(strStrCd, strJojikGb, strBu, strGwa, "N", strDataSet);
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점 
*            arguments[2] -> 부문
*            arguments[3] -> 층(팀) 
*            arguments[4] -> 권한에 따라 보여질지 여부 ( Y/N )
*            arguments[5] -> 조직구분
*            --------------------- 미필수
*            arguments[6] -> 관리조직 여부 
* return값 : void
*/
function getPc2(strDataSet, authGb, strStrCd, strDept, strTeam, allGb, strMngOrgYn, strOrgFlag)  {

    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")  = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD" )    = strStrCd; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "DEPT" )      = strDept; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TEAM" )      = strTeam;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB" )    = allGb;
    
    if(arguments.length > 7)
        DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ORG_FLAG")  = strOrgFlag//arguments[7];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "MNG_ORG_YN")  = strMngOrgYn;
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getPc2&strOrgFlag="+strOrgFlag;
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_PC="+strDataSet+")";
    TR_MAIN.Post();
}


/**
* getPumbun(strDataSet, authGb, strStrCd, strJojikGb, strBu, strGwa, strKey)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2006-08-14
* 개    요 : 점 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getStore(strDataSet, "Y", "0001", "0", "88", "01", "A" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 권한에 따라 보여질지 여부 ( Y/N )
*            arguments[2] -> 점
*            arguments[3] -> 조직구분
*            arguments[4] -> 부
*            arguments[5] -> 과(팀/층)
*            arguments[6] -> 계(PC)
* return값 : void
*/
function getPumbun(strDataSet, authGb, strStrCd, strJojikGb, strBu, strGwa, strKye) {
    
    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTH_GB")   = authGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")    = strStrCd;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "JOJIK_GB")  = strJojikGb;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BU")        = strBu;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "GWA")       = strGwa;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "KYE")       = strKye;
    
    TR_MAIN.Action    = "/pot/tcom999.tc?goTo=getPumbun";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_PUMBUN="+strDataSet+")";
    TR_MAIN.Post();
}

/**
* getCorner(strDataSet, strStrCd, strDept, strTeam, strPc, allGb)
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2010-02-15
* 개    요 : 코너 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getCorner("DS_O_CORNER", "01", "01", "01", "01" ,"Y");
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점 
*            arguments[2] -> 부문
*            arguments[3] -> 층(팀) 
*            arguments[4] -> PC
*            arguments[5] -> 전체 표시여부 Y/N
* return값 : void
*/
function getCorner(strDataSet, strStrCd, strDept, strTeam, strPc, allGb)  {
    DS_I_CONDITION.setDataHeader( jojikDataHeader );
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD" )    = strStrCd; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "DEPT" )      = strDept; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TEAM" )      = strTeam;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "PC" )        = strPc;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALL_GB" )    = allGb;
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getCorner";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_CORNER="+strDataSet+")";
    TR_MAIN.Post();
}

/**
* isAuthOK_PLU_PUMBUN(strDataSet, strStrCd, strCode)
* 작 성 자 : 이종철(공통)
* 작 성 일 : 2006-08-17
* 개    요 : 품번 또는 PLU코드를 입력받아 권한에 적합한지를 판단
* 사용방법 : isAuthOK_PLU_PUMBUN(strDataSet, "Y", "0001", "0", "88", "01", "A" )
*            arguments[0] -> 저장할 DataSet의 ID
*            arguments[1] -> 점
*            arguments[2] -> 품번코드 또는 plu 코드
* return값 : void
*/
function isAuthOK_PLU_PUMBUN(strDataSet, strStrCd, strCode) {
    
    DS_I_CONDITION.setDataHeader('STR_CD:STRING(4),CODE:STRING(13)');
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")    = strStrCd;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "CODE")      = strCode;
    
    TR_MAIN.Action    = "/pot/tcom999.tc?goTo=isAuthOK_PLU_PUMBUN";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_ISAUTH="+strDataSet+")";
    TR_MAIN.Post();
}


/**
* chkBetweenDate(strDate, endDate)
* 작 성 자  : 후지쯔(공통)
* 작 성 일  : 2006-08-10
* 개    요   : 시작종료일을 기준으로 조회 기간을 체크 리턴한다.(DS_O_CHKDATE - 데이타셋 필수 선언)
* 입력파라미터 : 시작일, 종료일
* 사용방법 : 
* return값 : void
*/

function chkBetweenDate(strDate, endDate){
    //기준 기간 조회
    getEtcCode("DS_O_CHKDATE", "D", "PS04", "N");
    if (strDate != "" && endDate != "") {
        if(strDate.length == 6 ){
            strDate = strDate + '01';
        }
        if(endDate.length == 6) { 
           
           if (endDate.substr(4,2))
            var lastDD = new Date(endDate.substr(0,4)*1, endDate.substr(4,2)*1, 0 );
            endDate = endDate + lastDD.getDate();
        }
        
        var chai = daysBetween(strDate, endDate) + 1;
        
        if (chai > DS_O_CHKDATE.NameValue(1,"NAME")){
            showMessage(STOPSIGN, OK, "USER-1000",   "조회기간은 최대 ["+DS_O_CHKDATE.NameValue(1,"NAME")+"]일을 넘길수 없습니다.");
            return false;
        } else {
            return true;
        }
    }
    return false;
}

/**
* chkBetweenDate(strDate, endDate)
* 작 성 자  : 후지쯔(공통)
* 작 성 일  : 2006-08-10
* 개    요   : 시작종료일을 기준으로 조회 기간을 체크 리턴한다.(DS_O_CHKDATE - 데이타셋 필수 선언)
* 입력파라미터 : 시작일, 종료일
* 사용방법 : 
* return값 : void
*/

function chkBetweenDate2(strDate, endDate){
    //기준 기간 조회
    getEtcCode("DS_O_CHKDATE", "D", "GS01", "N");
    if (strDate != "" && endDate != "") {
        if(strDate.length == 6 ){
            strDate = strDate + '01';
        }
        if(endDate.length == 6) { 
           
           if (endDate.substr(4,2))
            var lastDD = new Date(endDate.substr(0,4)*1, endDate.substr(4,2)*1, 0 );
            endDate = endDate + lastDD.getDate();
        }
        
        var chai = daysBetween(strDate, endDate) + 1;
        
        if (chai > DS_O_CHKDATE.NameValue(1,"NAME")){
            showMessage(STOPSIGN, OK, "USER-1000",   "조회기간은 최대 ["+DS_O_CHKDATE.NameValue(1,"NAME")+"]일을 넘길수 없습니다.");
            return false;
        } else {
            return true;
        }
    }
    return false;
}

/**
* getCorp(strDataSet)
* 작 성 자 : 
* 작 성 일 : 2010-01-13
* 개    요 : 법인 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getCorp(strDataSet)
*            arguments[0] -> 저장할 DataSet의 ID
* return값 : void
*/
function getCorp(strDataSet) {
    TR_MAIN.Action    = "/pot/tcom999.tc?goTo=getCorp";
    TR_MAIN.KeyValue= "SERVLET(O:DS_O_CORP="+strDataSet+")";
    TR_MAIN.Post();
}

/**
  * sortColId()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-01-27
  * 개    요 : 데이터 셋의 컬럼ID로 데이터를 정렬한다.
  * 사용방법 : sortColId( grid, row, colId, turnYn, sign)
  *          grid -> 정렬할 그리드 Object
  *          row -> 선택된 로우Index
  *          colId -> 정렬할 컬럼 ID
  *          checkDataSet -> 변경여부를 체크할 데이터 셋
  *          turnYn -> 재 클릭 식 반전 여부
  *          sign -> 반전 안될시 소트순서(+ 오름 - 내림) 반전 시 첫 정렬 순서
  * return값 : void
*/
var clickSORT = false;

function sortColId( dataSet, row, colId, checkDataSet, turnYn, sign) {
    //로우가 헤더일 경우만 정렬 실행
    if( row < 1 && dataSet.RowLevel(row) == 0 ){
        if( checkDataSet != null ){
            var dataList = checkDataSet.split(",");
            for(var i=0; i<dataList.length; i++){                
                if( eval(dataList[i]).IsUpdated){
                    showMessage(INFORMATION, OK, "USER-1000","변경된 상세내역이 존재하여 정렬 할 수 없습니다.");
                    return;
                }
            }
        }        
    	clickSORT = true;
        turnYn = (turnYn==null||turnYn=="undefined")?"Y":turnYn;
        sign = (sign==null||sign=="undefined")?"+":sign;
        
        var sortExpr = dataSet.Sortexpr;
        
        var bfSign = sortExpr.substring(1)==colId?sortExpr.substring(0,1):(sign=="+"?"-":"+");
        
        if( turnYn == "Y") {
            if(bfSign == "+")
                sign = "-";
            else
                sign = "+";
        }
        
        dataSet.Sortexpr = sign+colId;
        dataSet.Sort();
        
        clickSORT = false;
    }
}


/**
  * checkBindBlank() 
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-01-31
  * 개    요 : 데이터 셋의 빈값을 체크하여 해당 컬럼과 매칭되는 컴포넌트에 포커스를 이동한다.
  * 사용방법 : checkBindBlank( grid, binder, noCheckItem)
  *          grid -> 체크할 그리드 오브젝트
  *          binder -> 데이터 셋의 바인드 오브젝트
  *          noCheckItem -> 빈값 체크하지 않을 컬럼 ID List( ','로 구분)
  *          
  * * 체크할 컬럼을 모두 등록한다.
  * * 
  * return값 : true ->빈값이 없음, false -> 빈값이 존재함
*/
function checkBindBlank( grid, binder, noCheckItem)
{
    var noCheckList = noCheckItem==null?"":noCheckItem.split(",");
    //데이터셋을 얻어온다.
    var dataSet = eval(grid.DataID);
    //바인드 정보를 가져온다.
    var bindInfo = binder.BindInfo;
    //컬럼과 컴포넌트 매칭 정보를 맵으로 구성
    var tmpMap = new Map();
    while (bindInfo.indexOf("col=") != -1) {        
        bindInfo = bindInfo.substring(  bindInfo.indexOf("col=")+4);        
        var tmpKey = bindInfo.substring(0,bindInfo.indexOf(" "));               
        bindInfo = bindInfo.substring( bindInfo.indexOf("ctrl=")+5);        
        var tmpValue = bindInfo.substring(0, bindInfo.indexOf(" "));        
        tmpMap.put(tmpKey,tmpValue);
    }    
    
    //변경된 로우에 대하여 빈값여부를 체크한다. 
    for(var i=1; i <= dataSet.CountRow; i++ ) {
        var rowStatus = dataSet.RowStatus(i);
        
        if( dataSet.RowStatus(i) == 0 
                || dataSet.RowStatus(i) == 2
                || dataSet.RowStatus(i) == 4) 
            continue;
        
        for( var j = 0 ; j < grid.CountColumn ; j++){
            var colId = grid.GetColumnID(j);
            var noCheck = false;
            for( k = 0 ; k < noCheckList.length; k++) {
                if( noCheckList[k] == colId ){
                    noCheck = true;
                    break;
                }
            }
            if( !noCheck && tmpMap.get(colId) != null){
                if (dataSet.NameString(i,colId)=="" ) {
                    // ()은/는 반드시 입력해야 합니다.
                    showMessage(EXCLAMATION, OK, "USER-1003",grid.GetHdrDispName(-3, colId));
                    dataSet.RowPosition = i;
                    eval(tmpMap.get(colId)).Focus();
                    return false;
                }
            }
        }
            
    }    
    return true;
}


/**
 * checkDSBlank()
 * 작 성 자 : 김성미
 * 작 성 일 : 2010-02-07
 * 개    요 : 데이터셋의 빈값을 체크하여 해당 그리드로 포커스 이동
 * 사용방법 : checkDSBlank( grid, checkItem)
 *          grid -> 체크할 그리드 오브젝트
 *          checkItem -> 빈값 체크하지 할 컬럼 Index List( ','로 구분)
 *          (그리드 헤더에 정의되어 있는 컬럼 순번을 입력한다.- 0 부터 시작)
 * * 체크할 컬럼을 모두 등록한다.
 * * 
 * return값 : true ->빈값이 없음, false -> 빈값이 존재함
*/
function checkDSBlank(grid, checkItem)
{
    //  체크할 컬럼 
    var checkItemList = checkItem==null?"":checkItem.split(",");
    //데이터셋을 얻어온다.
    var dataSet = eval(grid.DataID);
    
    //변경된 로우에 대하여 빈값여부를 체크한다. 
    for(var i=1; i <= dataSet.CountRow; i++ ) {
    if( dataSet.RowStatus(i) == 0 
            || dataSet.RowStatus(i) == 2
            || dataSet.RowStatus(i) == 4) 
        continue;
    
    for( var j = 0 ; j < grid.CountColumn ; j++){
           for(var k=0; k<checkItemList.length; k++){
            var colId = grid.GetColumnID(checkItemList[k]);
           if(dataSet.NameValue(i,colId) == ""){
               // ()은/는 반드시 입력해야 합니다.
               showMessage(Information, OK, "USER-1003",grid.GetHdrDispName(-3, colId));
               dataSet.RowPosition = i;
               grid.SetColumn(colId); //name 컬럼 
               grid.Focus(); //그리드에 포커스 
               return false;
           }
        }
         }    
    }    
    return true;
}

/**
* insComboFirstNullId()
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-09
* 개    요 :  콤보 오브젝트의 첫번째 위치에 "" 아이디로 데이터를 추가한다.
*          (DataSet의 컬럼에  CODE와 NAME 가 존재해야 한다.)
* 사용법: insComboFirstNullId( objCombo, nullName)
*        objCombo --> 콩보오브젝트
*        nullName --> Null Id 의 이름
* return값 : void
*/
function insComboFirstNullId( objCombo, nullName){
    insComboData( objCombo, "", nullName,1);
}
/**
 * insComboData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-09
 * 개    요 :  콤보 오브젝트의  데이터를 추가한다.
 *          (DataSet의 컬럼에  CODE와 NAME 가 존재해야 한다.)
 * 사용법: insComboFirstNullId( objCombo, code, name, row)
 *        objCombo --> 콩보오브젝트
 *        code     --> CODE 
 *        name     --> NAME
 *        row      --> 들어갈 위치 (생략시 맨 마지막에 입력)
 * return값 : void
 */
function insComboData( objCombo, code, name, row ){
    var COMBO_DATA_SET = eval(objCombo.ComboDataID);
    if( row == null ){
        COMBO_DATA_SET.AddRow();
        row = COMBO_DATA_SET.CountRow;
    } else{
        COMBO_DATA_SET.InsertRow(row);
    }
   COMBO_DATA_SET.NameValue(row, "CODE") = code;
   COMBO_DATA_SET.NameValue(row, "NAME") = name;
}

    
/**
*initTxtAreaEdit(EmeEdit objEdit, String strFormat, editStyle)
* 작 성 자 : FKL
* 작 성 일 : 2010-02-10
* 개    요 : TEXT AREA의 스타일을 적용한다.
* 인 자 값 : objTextArea TEXTAREA오브젝트, String editStyle-편집속성(PK/READ/NORMAL)
* 사용방법 : initTxtAreaEdit(TXT_DETAIL, NORMAL)
* return값 : void
**/
function initTxtAreaEdit(objTextArea, blnEditStyle){
  objTextArea.Border           = "false";   
  objTextArea.WantReturn       = "true";  
  
  switch(THEME){
        case SPRING :
      break;
    case SUMMER :
      break;
    case FALL   :
      break;
    case WINTER :
      setObjTypeStyle( objTextArea, "TEXTAREA", blnEditStyle );
      break;
    default :
        break;
    }
}

/**
*initImgDataSet(ImgDataSet imgDataSet)
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-23
* 개    요 : 이미지 데이터 셋에 이미지를 불러온다.
* 인 자 값 : imgDataSet IMGDATASET오브젝트
* 사용방법 : initImgDataSet(IDS_IMAGE)
* return값 : void
**/
function initImgDataSet( imgDataSet ) {

    imgDataSet.DataId = "/pot/jsp/imageLoad.jsp";
    imgDataSet.Reset();  
}

/**
*initImgDataSetG(ImgDataSet imgDataSet)
* 작 성 자 : 조혜선
* 작 성 일 : 2011-08-30
* 개    요 : 이미지 데이터 셋에 이미지를 불러온다.
* 인 자 값 : imgDataSet IMGDATASET오브젝트
* 사용방법 : initImgDataSetG(IDS_IMAGE)
* return값 : void
**/
function initImgDataSetG( imgDataSet ) {

    imgDataSet.DataId = "/pot/jsp/imageLoadG.jsp";
    imgDataSet.Reset();  
}

/**
 * textAreaMaxlength()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010.02.23
 * 개    요 : TEXTAREA의 일정Byte 이상의 입력을 제한
 *           objName(TEXTAREA, 제한할 Byte)
 *           textAreaMaxlength(TA_TEMP, 200);
 * return값 : 키 이벤트 제한 
 * 
 */
function textAreaMaxlength(objName, len) {
    var tmp = objName.Text;
    var tmpLen = 0
    for (k = 0; k < tmp.length; k++) {
        var onechar = tmp.charAt(k);
        if (escape(onechar).length > 4) {
            tmpLen += 2;
        } else {
            tmpLen++;
        }
    }

    e = window.event;
    if (tmpLen > (len-1) ) { 
         strBoolean = false;
    } else {
        strBoolean = true;
    }
    e.returnValue = strBoolean;
    return strBoolean;
}


/**
*initTab( String TabDivID)
* 작 성 자 : 정진영
* 작 성 일 : 2010-02-23
* 개    요 : 탭을 구성한다.
* 인 자 값 : tabDivId 탭 DIV의 ID
* return값 : void
**/
function initTab( TabDivID ){
    
    var TabDIV = document.getElementById(TabDivID);
    
    //탭 DIV의 스타일 적용 
    TabDIV.style.position='relative';
    TabDIV.style.left='0';
    TabDIV.style.top='0';
    
    //Item 타이틀 목록 
    var MenuOBJ = TabDIV.getElementsByTagName('menu');
    var menuLen = MenuOBJ.length;
    var divList = new Array();

    //총 탭 메뉴수
    TabDIV.countItem = menuLen;
    TabDIV.onresize = function(){ TabItemDraw( this.id );};

    TabDIV.TitleAlign = TabDIV.TitleAlign == undefined ? 'left' : TabDIV.TitleAlign;
    TabDIV.TitleGap = TabDIV.TitleGap == undefined ? 2 : TabDIV.TitleGap;
    //현재 선택된 위치
    TabDIV.SelectIdx = TabDIV.SelectIdx == undefined ? 1 : TabDIV.SelectIdx;
    // 메뉴표시여부
    TabDIV.MenuDisplay = TabDIV.MenuDisplay == undefined ? 'true' : TabDIV.MenuDisplay;
    // 메뉴 높이 (24 고정 : 메뉴를 표시하지 않을 때 는 0)
    var menuHeight = TabDIV.MenuDisplay == 'true'? 23 : 0 ;
    //메뉴 DIV 생성
    var MenuDIV = document.createElement("div");
    //메뉴 DIV 속성및 스타일 적용    
    MenuDIV.id = TabDivID+"_MENU";
    MenuDIV.style.width = "100%";
    MenuDIV.style.height = menuHeight;
    MenuDIV.className = "stab";
    
    //제목을 위한 SPAN 생성 및 스타일 적용
    for(var i = 0 ; i < menuLen ; i++){        
    
        MenuOBJ[i].Enable  = MenuOBJ[i].Enable == undefined ? 'true'   : MenuOBJ[i].Enable ;
        MenuOBJ[i].Display = MenuOBJ[i].Display == undefined ? 'true'  : MenuOBJ[i].Display;
        //왼쪽
        var span = document.createElement("span");
        span.id = "SP_L_"+TabDivID+MenuOBJ[i].DivId;
        span.style.height = menuHeight;
        MenuDIV.appendChild(span);
        //중앙
        span = document.createElement("span");
        span.innerText = menuHeight==0? '' : MenuOBJ[i].TitleName;
        span.id = "SP_C_"+TabDivID+MenuOBJ[i].DivId;
        span.style.height = menuHeight;
        span.Index = i+1;
        span.DivId = MenuOBJ[i].DivId;
        span.TabId = TabDivID;
        span.ClickFunc = MenuOBJ[i].ClickFunc;
        span.ClickBfFunc = MenuOBJ[i].ClickBfFunc;
        span.onclick = function(){
                                    if( !(eval((getMenuObject(this.TabId,this.Index).Enable).toLowerCase())))
                                        return;

                                    if( this.Index == getTabItemSelect(this.TabId))
                                        return;
                                    
                                    if( this.ClickBfFunc ){
                                        if( eval( this.ClickBfFunc+'("'+this.TabId+'",'+this.Index+')') == false){
                                            return;
                                        }
                                    }
                                    document.getElementById(this.TabId).SelectIdx = this.Index;
                                    TabItemDraw( this.TabId );
                                    if( this.ClickFunc ){
                                        eval( this.ClickFunc+'("'+this.TabId+'",'+this.Index+')');
                                    }
                                 };
        MenuDIV.appendChild(span);
        //오른쪽
        span = document.createElement("span");
        span.id = "SP_R_"+TabDivID+MenuOBJ[i].DivId;
        span.style.height = menuHeight;
        MenuDIV.appendChild(span);
        divList[i] = MenuOBJ[i].DivId;
    }
    

    TabDIV.appendChild(MenuDIV);

    for(var i = 0 ; i < menuLen ; i++){
        if(document.getElementById(divList[i])){
            document.getElementById(divList[i]).style.position = 'absolute';
            document.getElementById(divList[i]).style.left = '0';
            document.getElementById(divList[i]).style.top = menuHeight;
            document.getElementById(divList[i]).style.width = '100%';
            document.getElementById(divList[i]).style.height= (TabDIV.height-menuHeight);
            document.getElementById(divList[i]).style.overflowY='auto'; 
            document.getElementById(divList[i]).style.display='none'; 
            TabDIV.appendChild(document.getElementById(divList[i]));
        }
    }

    TabItemDraw( TabDivID );
}

/**
* getMenuObject(String TabDivId, int Idx)
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 메뉴 속성 정보를 가지고 있는 오브젝트를 조회한다.
* 인 자 값 : TabDivId 탭 DIV의 ID , Idx 조회할 위치
**/
function getMenuObject( TabDivId, Idx){

    var TabDIV = document.getElementById(TabDivId);
    var MenuOBJ = TabDIV.getElementsByTagName('menu');
    if(Idx > MenuOBJ.length){
        alert("Overflow index Error");
        return;
    }

    return MenuOBJ[Idx-1];
}
/**
* TabItemDraw( String TabID)
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 탭을 화면에 표시한다.
* 인 자 값 : tabId 탭 DIV의 ID
**/
function TabItemDraw( TabID ){
    
    var TabDIV = document.getElementById(TabID);
    
    //Item 타이틀 목록 
    var MenuOBJ = TabDIV.getElementsByTagName('menu');
    var MenuLen = MenuOBJ.length;
    //아이템의 가로길이 지정을 위한 처리.
    var clientWidth = TabDIV.clientWidth;
    //현재 선택된 메뉴
    var SelectIndex = TabDIV.SelectIdx;
    //제목 속성
    var TitleWidth = Number(TabDIV.TitleWidth);
    var TitleAlign = TabDIV.TitleAlign;
    var TitleGap = Number(TabDIV.TitleGap);
    var menuHeight = TabDIV.MenuDisplay == 'true'? 23 : 0 ;
    //제목을 위한 SPAN 생성 및 스타일 적용
    for(var i = 0 ; i < MenuLen ; i++){
        var ItemId = MenuOBJ[i].DivId;
        var Enable = MenuOBJ[i].Enable;
        var Display = MenuOBJ[i].Display;
        var TitleName = menuHeight==0?'':MenuOBJ[i].TitleName;
        //왼쪽
        var TitleSpanLeft = document.getElementById( "SP_L_" + TabID + ItemId);
        //중앙
        var TitleSpanCenter = document.getElementById( "SP_C_" + TabID + ItemId);
        //오른쪽
        var TitleSpanRight = document.getElementById( "SP_R_" + TabID + ItemId);

        //타이틀 입력
        TitleSpanCenter.innerText = TitleName;
        if(eval(Display.toLowerCase())==false){
            TitleSpanLeft.style.display = "none";
            TitleSpanCenter.style.display = "none";
            TitleSpanRight.style.display = "none";
            document.getElementById(ItemId).style.display = "none";
            continue;
        }
        
        TitleSpanLeft.style.display = "";
        TitleSpanCenter.style.display = "";
        TitleSpanRight.style.display = "";

        var className = TitleAlign.toLowerCase();
        //타이틀 길이 조정
        if(TitleWidth != undefined){
        	TitleSpanLeft.style.width = 7;
            TitleSpanCenter.style.width = TitleWidth-14;
            TitleSpanRight.style.width = 7 + Number(TitleGap);
        }

        if(eval(Enable.toLowerCase())){
            className += " hand";
        }
        document.getElementById(ItemId).style.width = clientWidth;
        //선택된 메뉴
        if( i == (Number(SelectIndex)-1)){
            className += " stab_on_";
            document.getElementById(ItemId).style.display = "";
        }else{
            className += " stab_off_";  
            document.getElementById(ItemId).style.display = "none"; 
        }        
        TitleSpanLeft.className = className+"l";
        TitleSpanCenter.className = className+"c";
        TitleSpanRight.className = className+"r";
    }
}
/**
* setTabItemEnable( String TabDivID, int Index, boolean enable)
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 텝아이템의 사용여부를 설정한다.
* 인 자 값 : tabId 탭 DIV의 ID, Index 변경할 위치, enable 사용여부
**/
function setTabItemEnable( TabDivID, Index, enable){
    getMenuObject(TabDivID, Index).Enable = String(enable);
    TabItemDraw( TabDivID );
}

/**
* setTabItemDisplay( String TabDivID, int Index, boolean display)
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 텝아이템의 표시여부를 설정한다.
* 인 자 값 : tabId 탭 DIV의 ID, Index 변경할 위치, display 표시여부
**/
function setTabItemDisplay( TabDivID, Index, display){
    getMenuObject(TabDivID, Index).Display = String(display);
    TabItemDraw( TabDivID );
}
/**
* setTabItemIndex( String TabDivID, int Index)
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 텝아이템의 선택을 설정한다.
* 인 자 값 : tabId 탭 DIV의 ID, Index 변경할 위치
**/
function setTabItemIndex( TabDivID, Index){
    var TabDIV = document.getElementById(TabDivID);
    TabDIV.SelectIdx = Index;
    TabItemDraw( TabDivID );
}

/**
* setTabItemTitle( String TabDivID, int Index, String TitleName)
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 텝아이템의 메뉴명을 설정한다.
* 인 자 값 : tabId 탭 DIV의 ID, Index 변경할 위치, TitleName 타이틀명
**/
function setTabItemTitle( TabDivID, Index, TitleName){
    getMenuObject(TabDivID, Index).TitleName = String(TitleName);
    TabItemDraw( TabDivID );
}

/**
* getTabItemEnable( String TabDivID, int Index)
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 텝아이템의 사용여부를 조회한다.
* 인 자 값 : tabId 탭 DIV의 ID, index 조회할 위치
**/
function getTabItemEnable( TabDivID, Index){
    return getMenuObject(TabDivID, Index).Enable;
}

/**
* getTabItemDisplay( String TabDivID, int Index )
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 텝아이템의 표시여부를 조회한다.
* 인 자 값 : tabId 탭 DIV의 ID, index 조회할 위치
**/
function getTabItemDisplay( TabDivID, Index){
    return getMenuObject(TabDivID, Index).Display;
}
/**
* getTabItemSelect( String TabDivID)
* 작 성 자 : 정진영
* 작 성 일 : 2010-03-17
* 개    요 : 텝아이템의 선택를 조회한다.
* 인 자 값 : tabId 탭 DIV의 ID
* 사용방법 : setTabItemSelect( tabId )
**/
function getTabItemSelect( TabDivID){
    var TabDIV = document.getElementById(TabDivID);
    return TabDIV.SelectIdx;
}

/**
 * sel_DeleteRow(dataSet, chk)
* 작 성 자 : 김경은
* 작 성 일 : 2010-03-07
* 개    요 : 체크된 row 삭제
* 인 자 값 : DATASET, 체크박스컬럼명
* 사용방법 : sel_DeleteRow( dataSet, "SEL" )
* return값 : void
**/
function sel_DeleteRow(dataSet, chk){
    var intRowCount =  dataSet.CountRow;
    for(var i=intRowCount; i >= 1; i--){
        if(dataSet.NameValue(i, chk) == 'T'){
            dataSet.DeleteRow(i);
        }
    }
}

/**
 * checkInputByte()
 * 작 성 자 : 정진영
 * 작 성 일 :2010-03-21
 * 개    요 : 입력 길이 체크 처리
 * 사용방법 : checkInputByte( GRID_OBJ, DATASET_OBJ, rowIndex, ColId, ColName, Gauce Component, checkSize)
 *            
 * return값 : boolean
 */
function checkInputByte( gridObj, dataObj, row, colid, colName, component, checkSize){
   var colSize = dataObj.ColumnSize(dataObj.ColumnIndex(colid));
   var colVal = dataObj.NameValue(row,colid);
   checkSize = checkSize==null?colSize:checkSize;
   var result = checkByteLengthStr(colVal,checkSize,"N");
   if( result){
       colMsg = "";
       if(colName != null)
           colMsg =  colName+ " 은/는 ";
       
       showMessage(EXCLAMATION, OK, "GAUCE-1000", colMsg + checkSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
       
    dataObj.NameValue(row,colid) = result;
       
    if( component != null)
        eval(component).Focus();
    else
         setFocusGrid( gridObj, dataObj, row, colid);
       
    return false;
}
   return true;
}

/**
 * getRowStatus()
 * 작 성 자 : 정진영
 * 작 성 일 :2010-03-24
 * 개    요 : 로우의 상태값을 조회한다. (로우 및 입력시 현재 선택된 로우 상태값) 
 * 사용방법 : getRowStatus( DATASET_OBJ , row)
 *            
 * return값 : boolean
 */
function getRowStatus( DataSET , row){
    row = row == null?DataSET.RowPosition:row;    
    return DataSET.RowStatus(row);
}

/**
 * getColOldValue()
 * 작 성 자 : 정진영
 * 작 성 일 :2010-03-24
 * 개    요 : 컬럼의 초기 조회값을 조회한다. (로우 및 입력시 현재 선택된 로우 상태값) 
 * 사용방법 : getColOldValue( DATASET_OBJ , colId, row)
 *            
 * return값 : oldValue
 */
function getColOldValue( DataSET, colId, row){
    row = row == null?DataSET.RowPosition:row;
    //신규 추가된 로우는 빈값
    if( getRowStatus(DataSET,row) == '1')
        return '';
    
    return DataSET.OrgNameValue(row,colId);    
}

/**
 * checkDateFormat(obj, setDate, message)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-24
 * 개    요 : (컴퍼넌트)날짜 입력했을때 형식에 맞지 않으면 메시지 보여주고 setDate로 날짜 셋팅
 * 사용방법 :  checkDateFormat(EM_S_S_OFFER_DT, strToday, "조회시작일");
 *            
 * return값 :
 */
function checkDateFormat(obj, setDate, message){
    if(isYYYYMMDD(obj.Text) == ""){
        showMessage(StopSign, OK, "USER-1007", message);
        obj.Text = setDate;
        obj.Focus();         
    }
}    

/**
 * checkDateTypeYMD()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-24
 * 개    요 : 입력값이 Date 형인지 조회한다.
 * 사용방법 : checkDateTypeYMD( component )
 *           component    ==> 값을 체크할 컴포넌트 오브젝트     
 *      컴포넌트가 EMEDIT 일경우
 *          추가 옵션
 *          arguments[1]  ==> 초기값 ( 기본값 : 오늘)
 *          arguments[2]  ==> 데이터셋 오브젝트 ID (초기 조회값을 가져오기 위한)
 *          arguments[3]  ==> 컬럼ID (초기 조회값을 가져오기 위한)
 *          arguments[4]  ==> row 위치값 (기본값 : 선택된 로우)
 *      컴포넌트가 GRID 일 경우
 *          arguments[1]  ==> 컬럼 ID
 *          arguments[2]  ==> 초기값 ( 기본값 : 오늘)
 *            
 * return값 : boolean
 */
function checkDateTypeYMD( component ){
    //입력된 컴포넌트에 따라 처리 인자값 처리 변경
    var classId = component.classid.toUpperCase();
    switch(classId){
        //EMEDIT 에서 호출시
        case CLSID_EMEDIT :
            var vlaue = component.Text;
            value = vlaue.replace(' ','');
            // 빈값일경우
            if( value == '')
                return false;
            
            if( value.length == 8 ) {
                if (!checkYYYYMMDD(vlaue)){
                    showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+value+"' 는 유효하지 않는 날짜형식입니다.");
                    if( arguments.length < 2){
                        component.Text = getTodayFormat("YYYYMMDD");
                    } else {
                        component.Text = arguments[1];
                    }                    
                    setTimeout( component.id+".Focus();",50);
                    return false;
                }
                return true;
            }

            showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+value+"' 는 유효하지 않는 날짜형식입니다.");
            //디폴드 값을 입력하지 않으면 오늘로 세팅
            if( arguments.length < 2){
                component.Text = getTodayFormat("YYYYMMDD");
                setTimeout( component.id+".Focus();",50);
                return false;
            }
            setTimeout( component.id+".Focus();",50);
            var defaultValue = arguments[1];
            component.Text = defaultValue;
            //데이터 셋과 컬럼 명이 입력 될경우 이전 값을 체크하여 초기 조회 값을 입력함(로우는 선택)
            if( arguments.length > 3){
                var row = null;
                if( arguments.length > 4)
                    row = arguments[4];
                
                var oldValue = getColOldValue(eval(arguments[2]),arguments[3],row);
                
                if( oldValue==null)
                    return false;
                    
                if( oldValue.length == 8){
                    component.Text = oldValue;
                }
            }
            return false;
        //그리드에서 호출시
        case CLSID_GRID :
            if( arguments.length < 2){
                return false;
            }
            var dataSet = eval(component.DataID);
            //로우는 현재 선택된 로우
            var row = dataSet.RowPosition;
            var vlaue = dataSet.NameValue( row, arguments[1]);
            if( vlaue==null)
                return false;
            value = vlaue.replace(' ','');
            // 빈값일경우
            if( value == '')
                return false;
            
            //날자 형식으면 true (common.js)
            if( checkYYYYMMDD(vlaue))
                return true;
            showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+vlaue+"'는 유효하지 않는 날짜형식입니다.");
            // 초기 값이 존재하지 않으면 신규입력
            var oldValue = getColOldValue(dataSet,arguments[1],row);
            if( oldValue.length != 8){
                //신규입력일 경우 디폴트 값 또는 오늘
                oldValue = arguments.length < 3?getTodayFormat("YYYYMMDD"):arguments[2];
            }
            setTimeout( "setFocusGrid("+component.id+","+component.DataID+","+row+",'"+arguments[1]+"');",50);

            dataSet.NameValue( row, arguments[1]) = oldValue;
            return false;
    }
}

/**
 * checkDateTypeYM()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-24
 * 개    요 : 입력값이 Date 형인지 조회한다.(년월)
 * 사용방법 : checkDateTypeYM( component )
 *           component    ==> 값을 체크할 컴포넌트 오브젝트     
 *      컴포넌트가 EMEDIT 일경우
 *          추가 옵션
 *          arguments[1]  ==> 초기값 ( 기본값 : 오늘)
 *          arguments[2]  ==> 데이터셋 오브젝트 ID (초기 조회값을 가져오기 위한)
 *          arguments[3]  ==> 컬럼ID (초기 조회값을 가져오기 위한)
 *          arguments[4]  ==> row 위치값 (기본값 : 선택된 로우)
 *      컴포넌트가 GRID 일 경우
 *          arguments[1]  ==> 컬럼 ID
 *          arguments[2]  ==> 초기값 ( 기본값 : 오늘)
 *            
 * return값 : boolean
 */
function checkDateTypeYM( component ){
    //입력된 컴포넌트에 따라 처리 인자값 처리 변경
    var classId = component.classid.toUpperCase();
    switch(classId){
        //EMEDIT 에서 호출시
        case CLSID_EMEDIT :
            var vlaue = component.Text;
            value = vlaue.replace(/^\s*|\s*$/g, "");
            // 빈값일경우
            if( value == '')
                return false;
            
            if( value.length == 6 ) {
                if (!checkYYYYMM(value)){
                    showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+value+"' 는 유효하지 않는 날짜형식입니다.");
                    if( arguments.length < 2){
                        component.Text = getTodayFormat("YYYYMM");
                    } else {
                        component.Text = arguments[1];
                    }                    
                    setTimeout( component.id+".Focus();",50);
                    return false;
                }
                return true;
            }

            showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+value+"' 는 유효하지 않는 날짜형식입니다.");
            //디폴드 값을 입력하지 않으면 오늘로 세팅
            if( arguments.length < 2){
                component.Text = getTodayFormat("YYYYMM");
                setTimeout( component.id+".Focus();",50);
                return false;
            }
            setTimeout( component.id+".Focus();",50);
            var defaultValue = arguments[1];
            component.Text = defaultValue;
            //데이터 셋과 컬럼 명이 입력 될경우 이전 값을 체크하여 초기 조회 값을 입력함(로우는 선택)
            if( arguments.length > 3){
                var row = null;
                if( arguments.length > 4)
                    row = arguments[4];
                
                var oldValue = getColOldValue(eval(arguments[2]),arguments[3],row);
                
                if( oldValue==null)
                    return false;
                    
                if( oldValue.length == 6){
                    component.Text = oldValue;
                }
            }
            return false;
        //그리드에서 호출시
        case CLSID_GRID :
            if( arguments.length < 2){
                return false;
            }
            var dataSet = eval(component.DataID);
            //로우는 현재 선택된 로우
            var row = dataSet.RowPosition;
            var vlaue = dataSet.NameValue( row, arguments[1]);
            if( vlaue==null)
                return false;
            value = vlaue.replace(' ','');
            // 빈값일경우
            if( value == '')
                return false;
            
            //날자 형식으면 true (common.js)
            if( checkYYYYMM(vlaue))
                return true;
            showMessage(INFORMATION, OK, "USER-1000", "입력하신 '"+vlaue+"'는 유효하지 않는 날짜형식입니다.");
            // 초기 값이 존재하지 않으면 신규입력
            var oldValue = getColOldValue(dataSet,arguments[1],row);
            if( oldValue.length != 6){
                //신규입력일 경우 디폴트 값 또는 오늘
                oldValue = arguments.length < 3?getTodayFormat("YYYYMM"):arguments[2];
            }
            setTimeout( "setFocusGrid("+component.id+","+component.DataID+","+row+",'"+arguments[1]+"');",50);

            dataSet.NameValue( row, arguments[1]) = oldValue;
            return false;
    }
}

/**
 * getMaxData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-26
 * 개    요 :  Max 값을 조회한다.
 * return값 : String
 */
function getMaxData( DataSet, column, excludeInsYn, keyCol, keyData, fromRow, toRow ){
    // 데이터 셋의 데이터가 존재하지 않으면 return
    if(DataSet.CountRow < 1)
        return '';
    var hasKey = false;       // key 여부 ( 키가 존재하면 해당키에 Max 값을 조회)
    var keyList;              // Key 컬럼 리스트
    var keyValList;           // Key 값 리스트 ( Key 컬럼 리스트와 같아야 함)
    var keyLen;               // Key 개수
    
    fromRow = fromRow== null? 1:fromRow;            // 시작할 로우 ( 기본값 : 1)
    toRow   = toRow== null? DataSet.CountRow:toRow; // 종료할 로우 ( 기본값 : CountRow)
    // From 로우가 TO 로우보다 클 경우 에러.
    if( fromRow > toRow){
        alert("[Error] A FromRow greater than ToRow!!");
        return '';
    }
    
    // key 가 존재시 key를 리스트 화 
    if( keyCol != null){
        keyList = keyCol.split("||");       // key 컬럼 리스트 ( 구분자  '||')
        
        // key 컬럼이 존재하는데 key 데이타 가 없으면 에러.
        if( keyData == null){
            alert("[Error] Don't have KeyData!!");
            return '';
        }
        keyValList = keyData.split("||");  // key 데이타 리스트 ( 구분자  '||')
        
        // key 컬럼과 key 데이타의 수가 틀리면 에러.
        if( keyList.length != keyValList.length){
            alert("[Error] keyList and keyValList Difference!!");
            return '';
        }
        hasKey = true;
        keyLen = keyList.length;
    }    
    // 신규 로우 제외 여부. ( 기본값 true )
    excludeInsYn = excludeInsYn == null? true:excludeInsYn;    
    var maxData = '';                   // 리턴할 Max 데이타
    
    // 전체 데이터 셋을 체크하면 Max 값을 조회
    for( var i=fromRow ; i <= toRow; i++){
        // 신규로우 제외 여부가  true 이고 데이터가 신규 일경우 제외 처리
        if( excludeInsYn && DataSet.SysStatus(i) == '1')
            continue;
        
        // 키가 존재할 경우 해당 키가 아니면 제외 
        if( hasKey){
            var isKeyVal = true;   // 조회하는 로우가 KEY와 같은지 여부
            // Key 와 같은 로우인지 체크
            for( var j=0; j<keyLen; j++){
                if(DataSet.NameValue(i,keyList[j]) != keyValList[j]){
                    isKeyVal = false;
                    break;
                }
            }
            // key 와 같은 로우가아니면 제외 
            if(!isKeyVal)
                continue;
        }
        var value = DataSet.NameValue(i,column);  // 현재 값
        // Max 값 체크
        if( value > maxData)
            maxData = value;
    }
    
    return maxData;
    
}

/**
 * getNameValueRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-26
 * 개    요 :  해당 데이터의 로우를 조회한다.
 * return값 : Int
 */
function getNameValueRow( DataSet, Cols, Values){
    // 데이터 셋의 데이터가 존재하지 않으면 return
    if(DataSet.CountRow < 1)
        return 0;

    var keyList;              // Key 컬럼 리스트
    var keyValList;           // Key 값 리스트 ( Key 컬럼 리스트와 같아야 함)
    var keyLen;               // Key 개수
    
    keyList = Cols.split("||");       // key 컬럼 리스트 ( 구분자  '||')
    
    // key 컬럼이 존재하는데 key 데이타 가 없으면 에러.
    if( Values == null){
        alert("[Error] Don't have KeyData!!");
        return 0;
    }
    keyValList = Values.split("||");  // key 데이타 리스트 ( 구분자  '||')
    
    // key 컬럼과 key 데이타의 수가 틀리면 에러.
    if( keyList.length != keyValList.length){
        alert("[Error] keyList and keyValList Difference!!");
        return 0;
    }
    keyLen = keyList.length;

    // 전체 데이터 셋을 체크하면 Row 조회
    for( var i=1 ; i <= DataSet.CountRow; i++){
        var isKeyVal = true;   // 조회하는 로우가 KEY와 같은지 여부
        // Key 와 같은 로우인지 체크
        for( var j=0; j<keyLen; j++){
            if(DataSet.NameValue(i,keyList[j]) != keyValList[j]){
                isKeyVal = false;
                break;
            }
        }
        if(!isKeyVal)
            continue;
        return i;
    }
    
    return 0;
}

/**
 * getNameValueCount()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-26
 * 개    요 :  해당 데이터의 총 수를 조회한다.
 * return값 : Int
 */
function getNameValueCount( DataSet, Cols, Values, excludeInsYn, excludeDelYn){
    // 데이터 셋의 데이터가 존재하지 않으면 return
    if(DataSet.CountRow < 1)
        return 0;

    var keyList;              // Key 컬럼 리스트
    var keyValList;           // Key 값 리스트 ( Key 컬럼 리스트와 같아야 함)
    var keyLen;               // Key 개수    
    var rowCnt = 0;           // 로우수
    excludeInsYn = excludeInsYn==null? false:excludeInsYn; // 신규입력 로우 제외 여부 (기본: 아니요)
    excludeDelYn = excludeDelYn==null? true:excludeDelYn; // 신규입력 로우 제외 여부 (기본: 예)
    
    keyList = Cols.split("||");       // key 컬럼 리스트 ( 구분자  '||')
    
    // key 컬럼이 존재하는데 key 데이타 가 없으면 에러.
    if( Values == null){
        alert("[Error] Don't have KeyData!!");
        return 0;
    }
    keyValList = Values.split("||");  // key 데이타 리스트 ( 구분자  '||')
    
    // key 컬럼과 key 데이타의 수가 틀리면 에러.
    if( keyList.length != keyValList.length){
        alert("[Error] keyList and keyValList Difference!!");
        return 0;
    }
    keyLen = keyList.length;
    
    // 전체 데이터 셋을 체크하면 Row 조회
    for( var i=1 ; i <= DataSet.CountRow; i++){
        var isKeyVal = true;   // 조회하는 로우가 KEY와 같은지 여부
        
        if(excludeInsYn)
            if(DataSet.RowStatus(i)==1)
                continue;
        if(excludeDelYn)
            if(DataSet.RowStatus(i)==2)
                continue;
        // Key 와 같은 로우인지 체크
        for( var j=0; j<keyLen; j++){
            if(DataSet.NameValue(i,keyList[j]) != keyValList[j]){
                isKeyVal = false;
                break;
            }
        }
        if(!isKeyVal)
            continue;
        rowCnt++;
    }
    
    return rowCnt;
}

/**
 * getFliterNameValueCount()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-03-26
 * 개    요 :  해당 데이터의 필터된총 수를 조회한다.
 * return값 : Int
 */
function getFliterNameValueCount(DataSet, Cols, Values){
    
    var nFilteredRowCount = DataSet.CountFiltered;
    // 필터 데이터가 존재하지 않으면 return
    if(nFilteredRowCount < 1)
        return 0;

    var keyList;              // Key 컬럼 리스트
    var keyValList;           // Key 값 리스트 ( Key 컬럼 리스트와 같아야 함)
    var keyLen;               // Key 개수    
    var rowCnt = 0;           // 로우수
    
    keyList = Cols.split("||");       // key 컬럼 리스트 ( 구분자  '||')
    
    // key 컬럼이 존재하는데 key 데이타 가 없으면 에러.
    if( Values == null){
        alert("[Error] Don't have KeyData!!");
        return 0;
    }
    keyValList = Values.split("||");  // key 데이타 리스트 ( 구분자  '||')
    
    // key 컬럼과 key 데이타의 수가 틀리면 에러.
    if( keyList.length != keyValList.length){
        alert("[Error] keyList and keyValList Difference!!");
        return 0;
    }
    keyLen = keyList.length;
    
    // 전체 데이터 셋을 체크하면 Row 조회
    for( var i=0 ; i<nFilteredRowCount; i++){
        var isKeyVal = true;   // 조회하는 로우가 KEY와 같은지 여부
        // Key 와 같은 로우인지 체크
        for( var j=0; j<keyLen; j++){
            var keyIdx = DataSet.ColumnIndex(keyList[j])
            for(var k=0; k<=DataSet.CountColumn; k++){
                if(keyIdx-1 != k)
                    continue;
                var value = DataSet.ExtProp("FilteredColumnString", i +","+ k);
                if( keyValList[j] != value){
                    isKeyVal = false;
                    break;
                }
            }
            if(!isKeyVal)
                break;
        }
        if(!isKeyVal)
            continue;        
        rowCnt++;
    }    
    return rowCnt;
}
/**
* getEventCode(sysPart, strCd, pumbunCd, prcAppDt, allGb)
* 작 성 자 : 김경은
* 작 성 일 : 2010-04-09
* 개    요 : 행사 코드  콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getEventCode("DS_O_OLD_EVENT_CD", strCd, pumbunCd, prcAppDt)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/

function getEventCode(strDataSet, strCd, pumbunCd, prcAppDt, allGb) {

    DS_I_COMMON.setDataHeader('STR_CD:STRING(2),PUMBUN_CD:STRING(6),PRC_APP_DT:STRING(8),ALL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "STR_CD")      = strCd;
    DS_I_COMMON.NameValue(1, "PUMBUN_CD")   = pumbunCd;
    DS_I_COMMON.NameValue(1, "PRC_APP_DT")  = prcAppDt ;
    DS_I_COMMON.NameValue(1, "ALL_GB")      = allGb ;
    
    
    TR_MAIN.Action    = "/pot/ccom000.cc?goTo=getEventCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    //if (allGb == "Y") {
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
    //}
}

/**
* getFlc()
* 작 성 자 : 김유완
* 작 성 일 : 2010-03-30
* 개    요 : 시설구분
* 사용방법 : getFlc( strDataSet, strStaGbn, strHusFlag, strAuthGbn ,strAllGbn )
*            arguments[0] -> 데이터셋
*            arguments[1] -> 시설구분데이터 위치 구분(C:공통점마스터, M:임대관리마스터) 
                           - 시설구분별관리기준(외에 특별한 경우를 제외하곤 "M", 임대관리마스터에 등록된 정보만 조회)
                           - "C"경우는 공통기준정보의 점마스터에서 조회
*            arguments[2] -> 주거/비주거구분(1:비주거, 2:주거[아파트], 3:주거[CES])
*            arguments[3] -> 권한구분(Y/N)
*            arguments[4] -> 전체구분(Y/N)
*            //--추가조건--
*            arguments[5] -> STR_FLAG(0:본사, 1:점포)
*            arguments[6] -> CES포함/미포함(N:미포함, Y또는빈값:포함)
*            arguments[n] -> 추가
*
* 실행  예) getFlc("DS_LC_FCL_FLAG", "M", "1", "Y", "N");  
*
* return값 : 코드/명
*/
function getFlc( strDataSet, strStaGbn, strHusFlag, strAuthGbn ,strAllGbn, strCesYn ){
    
    var addCondition = setAddCondition( 5, arguments );
    
    DS_I_CONDITION.setDataHeader  ('STAGBN:STRING(1),HUSFLAG:STRING(1),AUTHGBN:STRING(1),ALLGBN:STRING(1),ADD_CONDITION:STRING(200)');
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STAGBN")    = strStaGbn; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "HUSFLAG") = strHusFlag; 
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "AUTHGBN") = strAuthGbn;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALLGBN")    = strAllGbn;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ADD_CONDITION") = addCondition;

    TR_MAIN.Action="/pot/ccom901.cc?goTo=getFlc";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
}

/**
* getBcompCode(sysPart, strCd, pumbunCd, prcAppDt, allGb)
* 작 성 자 : 장형욱
* 작 성 일 : 2010-05-23
* 개    요 : 매입사코드  콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getEventCode("DS_O_BCOMP", strCd, pumbunCd, prcAppDt)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/
function getBcompCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {  
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    TR_MAIN.Action  = "/pot/ccom901.cc?goTo=getBcompCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
}    

/**
* getCcompCode(sysPart, strCd, pumbunCd, prcAppDt, allGb)
* 작 성 자 : DHL
* 작 성 일 : 2012-06-01
* 개    요 : 발급사코드  콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getEventCode("DS_O_CCOMP", strCd, pumbunCd, prcAppDt)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/
function getCcompCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {  
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    TR_MAIN.Action  = "/pot/ccom901.cc?goTo=getCcompCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
}    

/**
* getDcardCode(sysPart, strCd, pumbunCd, prcAppDt, allGb)
* 작 성 자 : 장형욱
* 작 성 일 : 2010-05-23
* 개    요 : 매입사코드  콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getEventCode("DS_O_BCOMP", strCd, pumbunCd, prcAppDt)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/
function getDcardCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {  
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    TR_MAIN.Action  = "/pot/ccom901.cc?goTo=getDcardCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
}    

/**
* getVcardCode(sysPart, strCd, pumbunCd, prcAppDt, allGb)
* 작 성 자 : 장형욱
* 작 성 일 : 2010-05-23
* 개    요 : 밴사카드  콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getEventCode("DS_O_BCOMP", strCd, pumbunCd, prcAppDt)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/
function getVcardCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {  
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    TR_MAIN.Action  = "/pot/ccom901.cc?goTo=getVcardCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
}   

/**
* getChrgCode(sysPart, strCd, pumbunCd, prcAppDt, allGb)
* 작 성 자 : 장형욱
* 작 성 일 : 2010-05-26
* 개    요 : 매입사코드  콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getEventCode("DS_O_BCOMP", strCd, pumbunCd, prcAppDt)
*            arguments[0] -> sys_part
*            arguments[1] -> 코드구분 comm_part
*            arguments[2] -> 저장할 DataSet의 ID
* return값 : void
*/
function getChrgCode(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) {  
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1)');
    
    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    
    TR_MAIN.Action  = "/pot/ccom901.cc?goTo=getChrgCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
}    


/**
 * rollBackRowData()
 * 작 성 자 : 김유완
 * 작 성 일 : 2010.04.19
 * 개    요 : 이전데이터값 복원
 * 사용방법 :  rollBackRowData(DS_IO_MASTER, DS_IO_MASTER.RowPosition, "1,2,3");  //1,2,3컬럼만
              rollBackRowData(DS_IO_MASTER, DS_IO_MASTER.RowPosition);           //행전체
 * return값 : 입력행 데이터 값 복원
 */         
function rollBackRowData(objDsName, row, colnum) {
    if (arguments[2] == null || arguments[2] == undefined) {
        for(var i=1; i<=objDsName.CountColumn; i++){
            objDsName.NameValue(row, objDsName.ColumnID(i)) = objDsName.OrgNameValue(row, objDsName.ColumnID(i));
        }
    } else {
        var arrColnum = colnum.split(",");
        for(var i=0; i<=arrColnum.length; i++){
            objDsName.NameValue(row, objDsName.ColumnID(arrColnum[i])) = objDsName.OrgNameValue(row, objDsName.ColumnID(arrColnum[i]));
        }
    }
}



/**
 * getBrchUserAuth()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.04.25
 * 개    요 : 가맹점 코드를 이용하여 가맹점 권한을 체크한다.
 * 사용방법 :  getBrchUserAuth(세션 가맹점 코드)
 * return값 : A(모든 가맹점 권한 있음), B 해당가맹점만 권한있음.
 */  
function getBrchUserAuth(BRCH_ID) {

    var dsName = "DS_TEMPORARY";
    var trName = "TR_TEMPORARY";
    
    var ds;
    var tr;
    
    if (null == document.getElementById(dsName)) {
        ds = document.createElement("OBJECT");
        ds.classid = CLSID_DATASET; 
        ds.id = dsName;
        document.body.insertAdjacentElement("afterBegin", ds) ;
    } else {
        ds = document.getElementById(dsName);
    }

    if (null == document.getElementById(trName)) {
        tr = document.createElement("OBJECT");
        tr.classid = CLSID_TRANSACTION; 
        tr.id = trName;
        document.body.insertAdjacentElement("afterBegin", tr) ;
    } else {
        tr = document.getElementById(trName);
    }

    var parameters  = "&dsName="  + encodeURIComponent(dsName) ;
        parameters += "&sqlId=GET_USER_AUTH";
        parameters += "&BRCH_ID=" + encodeURIComponent(BRCH_ID) ;
        
    tr.Action   = "/dcs/dcom100.cc?goTo=getCommonResult" + parameters;
    tr.KeyName  = "Toinb_dataid4";
    tr.KeyValue = "SERVLET(O:" + ds.id + "=" + ds.id + ")";
    tr.Post();

    return (null == ds.NameValue(1, "USER_AUTH") || "" == ds.NameValue(1, "USER_AUTH")) ? "B" : ds.NameValue(1, "USER_AUTH");
}

/**
 * getCommonSearch()
 * 작 성 자 : jinjung.kim
 * 작 성 일 : 2010.04.25
 * 개    요 : sqlId를 이용하여 조회함.
 * 사용방법 :  getCommonSearch(sqlId, params)
 * return값 : DataSet
 */  
function getCommonSearch(sqlId, params) {
    
    var dsName = "DS_COMM_TEMP";
    var trName = "TR_COMM_TEMP";
    
    var ds;
    var tr;
    
    if (null == document.getElementById(dsName)) {
        ds = document.createElement("OBJECT");
        ds.classid = CLSID_DATASET; 
        ds.id = dsName;
        document.body.insertAdjacentElement("afterBegin", ds) ;
    } else {
        ds = document.getElementById(dsName);
    }

    if (null == document.getElementById(trName)) {
        tr = document.createElement("OBJECT");
        tr.classid = CLSID_TRANSACTION; 
        tr.id = trName;
        document.body.insertAdjacentElement("afterBegin", tr) ;
    } else {
        tr = document.getElementById(trName);
    }

    var parameters  = "&dsName="  + encodeURIComponent(dsName) ;
        parameters += "&sqlId=" + encodeURIComponent(sqlId);
        parameters += params;
        
    tr.Action   = "/dcs/dcom100.cc?goTo=getCommonResult" + parameters;
    tr.KeyName  = "Toinb_dataid4";
    tr.KeyValue = "SERVLET(O:" + ds.id + "=" + ds.id + ")";
    tr.Post();

    return ds;
}

/** 
 * getBizCdCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010-05-03
 * 개    요 : 경영실적항목코드 분류콤보
 * 사용방법 : getBizCdCombo(DataSetID)
 *            arguments[0] -> DataSetID
 *            arguments[1] -> 분류레벨 "1" DEFAULT 대분류 "2" 중분류 "3" 소분류 
 *            arguments[2] -> "Y" 전체 표시 "N" DEFAULT  
 *            arguments[3] -> 대분류코드 - 중분류와 소분류 데이터 검색시 사용
 *            arguments[4] -> 중분류코드 - 소분류 데이터 검색시 사용
 *
 * 실행  예) getBizCdCombo(DS_BIZL_CD, "1", "Y") - 대분류 데이터 검색
 *           getBizCdCombo(DS_BIZL_CD, "2", "Y", strBizLCd) - 중분류 데이터 검색
 * return값 :
*/
function getBizCdCombo(){
	var dsSet     = arguments[0]; //데이터 셋
	var strLvl    = "";
	var strViewYn = "";
	var strBizLCd = "";
	var strBizMCd = "";
	
	strLvl    = arguments[1] == undefined ? "1" : arguments[1];
	strViewYn = arguments[2] == undefined ? "N" : arguments[2];
	strBizLCd = arguments[3] == undefined ? ""  : arguments[3];
	strBizMCd = arguments[4] == undefined ? ""  : arguments[4];
	
    var parameters = "&strLvl="    + strLvl 
                   + "&strViewYn=" + strViewYn 
                   + "&strBizLCd=" + strBizLCd
                   + "&strBizMCd=" + strBizMCd 
                   ;
    
    dsSet.ClearData();          
    dsSet.DataID   = "/pot/ccom221.cc?goTo=getBizCdCombo"+parameters;
    dsSet.SyncLoad = "true";
    dsSet.Reset();
}

/** 
 * getDivCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-03
 * 개    요 : 배부기준코드 콤보
 * 사용방법 : getDivCombo(DataSetID)
 *            arguments[0] -> DataSetID
 *            arguments[1] -> 년월
 *            arguments[2] -> seq
 *            arguments[3] -> 실적계획구분
 *            arguments[4] -> "Y" 전체 표시 "N" DEFAULT
 *            arguments[5] -> strCd 점코드
 *            arguments[6] -> orglvl 조직레벨
 *
 * 실행  예) getDivCombo(DS_DIV_CD, "201101", "1", "1", "Y", "01", "1")
 * return값 :
*/
function getDivCombo(){
	var dsSet     = arguments[0]; //데이터 셋
	var strDate   = "";
	var strSeq    = "";
	var strFlag   = "";
	var strViewYn = "";
	
	strDate   = arguments[1] == undefined ? ""  : arguments[1];
	strSeq    = arguments[2] == undefined ? ""  : arguments[2];
	strFlag   = arguments[3] == undefined ? ""  : arguments[3];
	strViewYn = arguments[4] == undefined ? "N" : arguments[4];
	strStrCd  = arguments[5] == undefined ? ""  : arguments[5];
	strOrgLvl = arguments[6] == undefined ? ""  : arguments[6];
	
    var parameters = "&strDate="   + strDate 
                   + "&strSeq="    + strSeq 
                   + "&strFlag="   + strFlag 
                   + "&strViewYn=" + strViewYn 
                   + "&strStrCd="  + strStrCd
                   + "&strOrgLvl=" + strOrgLvl
                   ;
    
    dsSet.ClearData();          
    dsSet.DataID   = "/pot/ccom221.cc?goTo=getDivCombo"+parameters;
    dsSet.SyncLoad = "true";
    dsSet.Reset();
}

/** 
 * getDivMst()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-03
 * 개    요 : 배부기준코드 콤보
 * 사용방법 : getDivCombo(DataSetID)
 *            arguments[0] -> DataSetID
 *            arguments[1] -> "Y" 전체 표시 "N" DEFAULT  
 *
 * 실행  예) getDivMst(DS_DIV_CD, "Y")
 * return값 :
*/
function getDivMst(){
	var dsSet     = arguments[0]; //데이터 셋
	var strViewYn = "";
	strViewYn = arguments[1] == undefined ? "N" : arguments[1];
    var parameters = "&strViewYn=" + strViewYn;
    
    dsSet.ClearData();          
    dsSet.DataID   = "/pot/ccom221.cc?goTo=getDivMst"+parameters;
    dsSet.SyncLoad = "true";
    dsSet.Reset();
}


/**
* getBlock(strDataSet, strCd)
* 작 성 자 : 안형철
* 작 성 일 : 2011-07-29
* 개    요 : 블럭정보 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getBlock("DS_O_COMMON", strCd)
*            arguments[0] -> 점코드
* return값 : void
*/
function getBlock(strDataSet, strCd) {  
 
    DS_I_CONDITION.setDataHeader( 'STR_CD:STRING(2)' );
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")  = strCd;
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getBlock";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_BLOCK="+strDataSet+")";
    TR_MAIN.Post();

}


/**
* getGate(strDataSet, strCd, strBlockCd)
* 작 성 자 : 안형철
* 작 성 일 : 2011-08-09
* 개    요 : 출입구정보 콤보 세팅을 위한 dataSet을 가져오는 함수 
* 사용방법 : getGate("DS_O_COMMON", strCd, strBlockCd)
*            arguments[0] -> 점코드
*            arguments[1] -> 블럭코드
* return값 : void
*/
function getGate(strDataSet, strCd, strBlockCd) {  
 
    DS_I_CONDITION.setDataHeader( 'STR_CD:STRING(2),BLOCK_CD:STRING(20)' );
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STR_CD")  = strCd;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "BLOCK_CD")  = strBlockCd;
    
    TR_MAIN.Action    = "/pot/ccom901.cc?goTo=getGate";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_GATE="+strDataSet+")";
    TR_MAIN.Post();

}


/**
* set2DoList()
* 작 성 자 : 후지쯔(공통)
* 작 성 일 : 2011-02-15
* 개    요 : TO DO LIST에 데이터 적재 함수 
* 사용방법 : 
*            (DS_I_CONDITION DATASET 필요함)
*            arguments[0] -> 작업대상자(받는사람)
*            arguments[1] -> 작업요청자
*            arguments[2] -> 작업명칭
*            arguments[3] -> 작업URL
*            arguments[4] -> 작업처리기한(TYPE : YYYYMMDD / YYYYMMDDHH24 / YYYYMMDDHH24MI / YYYYMMDDHH24MISS )
*            ------------------------------------------------------------------------------------------
*            arguments[5] -> 작업일시
*            arguments[6] -> 작업시퀀스
*            arguments[7] -> 작업완료구분
*            
* 1) TODOLIST 생성
*      arguments[0]~[4] 필수 입력
*      set2DoList("209902007", "209902008", "공통코드 데이터 입력", "/pot/tcom101.tc?goTo=list", "201107291430");
* 2) TODOLIST 완료 / 취소
*      arguments[0],[5]~[7] 필수 입력
*      set2DoList("209902007", "", "", "", "", "20110729151958","2","Y");
* return값 : void
*/
function set2DoList() {
	
	// 작업처리기한
	var strLimitDate = arguments[4]== undefined ? "" : arguments[4];
	if 		(strLimitDate.length == 8)  strLimitDate = strLimitDate + "235959";
	else if (strLimitDate.length == 10) strLimitDate = strLimitDate + "5959";
	else if (strLimitDate.length == 12) strLimitDate = strLimitDate + "59";
	
	var setHeader = "TDL_USER_ID:STRING(10),RQS_USER_ID:STRING(10),TDL_NAME:STRING(100),TDL_URL:STRING(100),TDL_LIMIT_DATE:STRING(14),TDL_DATE:STRING(14),TDL_SEQ:STRING(3),TDL_FLAG:STRING(1)"
    DS_I_CONDITION.setDataHeader(setHeader);
    
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();

    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TDL_USER_ID")  	= arguments[0]== undefined ? "" : arguments[0];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "RQS_USER_ID") 	= arguments[1]== undefined ? "" : arguments[1];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TDL_NAME") 		= arguments[2]== undefined ? "" : arguments[2];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TDL_URL") 		= arguments[3]== undefined ? "" : arguments[3];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TDL_LIMIT_DATE") 	= strLimitDate;
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TDL_DATE") 		= arguments[5]== undefined ? "" : arguments[5];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TDL_SEQ") 		= arguments[6]== undefined ? "" : arguments[6];
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "TDL_FLAG") 		= arguments[7]== undefined ? "N": arguments[7]; 

    TR_MAIN.Action    = "/pot/ccom911.cc?goTo=enroll2DoList";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_CONDITION=DS_I_CONDITION)";
    TR_MAIN.Post(); 
}



/**
* getBeforeYearDay(strdate)
* 작 성 자 : 김광래
* 작 성 일 : 2016-01-02
* 개    요 : 전년도 동일 요일 일자 가져오기 
* 사용방법 : getBlock("DS_O_COMMON", strCd)
*            arguments[0] -> 해당일자
* return값 : void
*/
function getBeforeYearDay(strdate) {  
 
	var strdate     = strdate; //해당일자 파라미터  
	var goTo       = "getBeforeYearDay" ;    
	var parameters =  "&strdate="		+encodeURIComponent(strdate)     
	
	TR_MAIN.Action  = "/pot/ccom916.cc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET(O:DS_I_CONDITION=DS_I_CONDITION)"; //조회는 O
    TR_MAIN.Post();
    
    var rt_date = DS_I_CONDITION.NameValue(1, "BF_DAY");
    
    return rt_date;
}


/**
* getVen()
* 작 성 자 : 윤지영
* 작 성 일 : 2017-01-06
* 개    요 : 시설구분
* 사용방법 : getVen( strDataSet, strStaGbn, strHusFlag, strAuthGbn ,strAllGbn )
*            arguments[0] -> 데이터셋
*            arguments[1] -> STR_FLAG(01:아트몰링)
*            arguments[2] -> 전체구분(Y/N) 
*            //--추가조건--  
*            arguments[n] -> 추가
*
* 실행  예) getVen("DS_LC_FCL_FLAG", "01", "Y");  
*
* return값 : 코드/명
*/
function getVen( strDataSet, strStaGbn, strAllGbn){ 
    
    DS_I_CONDITION.setDataHeader  ('STAGBN:STRING(2),ALLGBN:STRING(1)');
    DS_I_CONDITION.ClearData();
    DS_I_CONDITION.Addrow();
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "STAGBN")    = strStaGbn;  
    DS_I_CONDITION.NameValue(DS_I_CONDITION.RowPosition, "ALLGBN")    = strAllGbn; 

    TR_MAIN.Action="/pot/ccom901.cc?goTo=getVen";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_CONDITION=DS_I_CONDITION,O:DS_O_RESULT="+strDataSet+")";
    TR_MAIN.Post(); 
}


