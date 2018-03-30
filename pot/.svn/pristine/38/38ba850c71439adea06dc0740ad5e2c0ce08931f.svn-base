 /****************************************************************************
 * 공통 기능에서 사용하는 상수값 선언 부분 
 ****************************************************************************
 * @author  : 박인복
 * @date    : 2011.05.26
 * @version : 1.8
 * @history : 2011/05/26 - 기본이 되는 쉬프트차트 공통함수 추가
 *            2011/05/30 - TitleText 함수 인자 추가(alignment, Bold)
 *                       - SetChartAxisStyle 함수 인자 추가(Visible)
 *                       - argments 초기값 추가
 *                       - ColorEachPoint 함수 추가
 *                       - SetAxisPosition 함수 추가
 *            2011/05/31 - 컬러 전역 변수 선언
 *                       - RemoveAllSeries 함수 추가
 *                       - MarkStyle 함수 추가
 *                       - PieSerise 함수 추가
 ****************************************************************************/
var SEREIS_COLOR_01 = "#2c88b5";
var SEREIS_COLOR_02 = "#7bac40";
var SEREIS_COLOR_03 = "#e17b28";
var SEREIS_COLOR_04 = "#e15c50";
var SEREIS_COLOR_05 = "#398ac2";
var SEREIS_COLOR_06 = "#80b94c";
var SEREIS_COLOR_07 = "#ef9936";
var SEREIS_COLOR_08 = "#f27960";
var SEREIS_COLOR_09 = "#5791cb";
var SEREIS_COLOR_10 = "#8bc367";
var SEREIS_COLOR_11 = "#f1b454";
var SEREIS_COLOR_12 = "#f49778";
var SEREIS_COLOR_13 = "#7099d3";
var SEREIS_COLOR_14 = "#95cc7e";
var SEREIS_COLOR_15 = "#f3ca6d";
var SEREIS_COLOR_16 = "#f6af8c";
var SEREIS_COLOR_17 = "#85a1da";
var SEREIS_COLOR_18 = "#9fd491";
var SEREIS_COLOR_19 = "#f3ca6d";
var SEREIS_COLOR_20 = "#f7c29d";
var SEREIS_COLOR_21 = "#0000ff";	//파랑
var SEREIS_COLOR_22 = "#ff0000";	//빨강
var SEREIS_COLOR_23 = "#21b0cf";	//연파랑
var SEREIS_COLOR_24 = "#4dd29b";	//연녹색
var SEREIS_COLOR_25 = "#ff8000";	//주황
var SEREIS_COLOR_26 = "#e688c7";	//연보라


function ChartDefaultStyle(obj){
	var _obj = document.getElementById(obj);

	//Panel 설정
	_obj.Panel.Gradient.Visible = "true";
	_obj.Panel.ForeColor = _obj.ToOLEColor("ced8e0");
	_obj.Panel.Gradient.StartColor =_obj.ToOLEColor("ffffff");
	_obj.Panel.Gradient.MidColor =_obj.ToOLEColor("f9f9f9");
	_obj.Panel.Gradient.EndColor =_obj.ToOLEColor("f2f2f2");

	//Aspect 설정
	_obj.Aspect.OrthoAngle = 30;
	_obj.Aspect.View3D = true;

	//Legend 설정
	_obj.Legend.LegendStyle = 1; // Series
	_obj.Legend.Color =_obj.ToOLEColor("eaf0f6");
	_obj.Legend.Font.Color =_obj.ToOLEColor("666666");
	_obj.Legend.Font.Name = "굴림";
	_obj.Legend.Transparent = true;
	
	//Left Walls 설정
	_obj.Walls.left.Gradient.Direction = 5; // FromTopLeft

	//Left Axis 설정
	_obj.Axis.left.AxisPen.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.left.Labels.Font.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.left.Labels.Font.Size = 11;
	_obj.Axis.left.Labels.OnAxis = "true";
	_obj.Axis.left.MinorGrid.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.left.MinorTicks.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.left.Ticks.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.left.TicksInner.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.left.Labels.Font.Name = "굴림";
	//_obj.Axis.left.GridPen.Visible ="false";
	
	//Bottom Axis 설정
	_obj.Axis.Bottom.AxisPen.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.Bottom.Labels.Font.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.Bottom.Labels.Font.Size = 11;
	_obj.Axis.Bottom.Labels.OnAxis = "true";
	_obj.Axis.Bottom.MinorGrid.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.Bottom.MinorTicks.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.Bottom.Ticks.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.Bottom.TicksInner.Color =_obj.ToOLEColor("6f5d41");
	_obj.Axis.Bottom.Labels.Font.Name = "굴림";
	_obj.Axis.Bottom.GridPen.Visible ="false";

}

/***************************************
 * 데이터 바인딩 함수 - 다중시리즈시 연속으로 추가
 *  var 변수명 = ChartAddSeries(차트ID, 시리즈타입, 범례이름, 데이터셋ID, X축컬럼, Y축 컬럼, label 컬럼, color 컬럼)
 *  Pie, Donut는 X축 값이 없다.
 ***************************************/
function ChartAddSeries(obj, seriesType, title, dataObj, xValue, yValue, label, color){
	//alert(obj+ " / " +  seriesType+ " / " +  title+ " / " +  dataObj+ " / " +  xValue+ " / " +  yValue+ " / " +  label+ " / " +  color);
	//시리즈 타입을 Number로 변환하는 함수
	var SERIES = new ShiftChartSeries();

	var _seriesType = SERIES.getChartSeries(seriesType);
	
	var _obj = document.getElementById(obj);

	var idx = _obj.AddSeries(_seriesType);
	_obj.Series(idx).DataID = dataObj;

	//SeriesType마다 X,Y축의 값이 달라지므로 분기처리해야한다.
	switch(Number(_seriesType)){
		case 2 :		//Area
		case 4 :		//Bar
		case 8 :		//Donut
		case 11 :		//FastLine
		case 19 :		//Line
		case 21 :		//Pie
		case 22 :		//Point
			if(xValue != "")	_obj.Series(idx).XValues.Column = xValue;
			if(yValue != "")	_obj.Series(idx).YValues.Column = yValue;
			if(label != "")		_obj.Series(idx).PointLabels.Column = label;
			if(color != "")		_obj.Series(idx).PointColors.Column = color;
			if(title != "")		_obj.Series(idx).Title = title;
			break;
			
		dafault :
			break;
	}
	//ColorEachPoint는 디폴트로 적용하지 않는다.
	_obj.Series(idx).ColorEachPoint = "false";
	
	/***************************************
	 * LineZeroTrunc 클리어
	 ***************************************/
	var idx2;
	this.SetSeriesDataXMLClear = function() {
		if(typeof(idx2) == 'undefined')
			return false;
		
		var strDataXML = '<Dataset><set null="True"/></Dataset>';
		
		_obj.SetSeriesDataXML(strDataXML, idx);
		_obj.SetSeriesDataXML(strDataXML, idx2);
		
		return true;
	}
	/***************************************
	 * Line Chart 값이 0일경우 연결선 끊기
	 ***************************************/	
	this.LineZeroTrunc = function() {
		
		_obj.Series(idx).DataID = "";
		//_obj.RemoveAllSeries();

		
		if(title != "")  _obj.Series(idx).Title = title;
		//Point 시리즈를 추가한다.
		idx2 = _obj.AddSeries(22);
		
		var _dataObj = document.getElementById(dataObj);
		var dsCnt = _dataObj.CountRow;
		var strDataXML = '<Dataset>';

		for(var i=1, j=0;i<=dsCnt;i++,j++){
			strDataXML += '<set ';
			if(xValue != "") 
				strDataXML += 'x="' + _dataObj.NameString(i,xValue) + '" ';
			else
				strDataXML += 'x="' + j + '" ';
			if(yValue != "")
				strDataXML += 'y="' + _dataObj.NameString(i,yValue) + '" ';
			if(label != "") 
				strDataXML += 'label="' + _dataObj.NameString(i,label) + '" ';
			if(color != "") 
				strDataXML += 'color="' + _dataObj.NameString(i,color) + '" ';
			if(yValue != ""){
				if(_dataObj.NameString(i,yValue) == 0)
					strDataXML += 'null="True"';
				else
					strDataXML += 'null="False"';
			}
			strDataXML += '/>';
		}
		strDataXML += '</Dataset>';
		
		_obj.SetSeriesDataXML(strDataXML, idx);
		_obj.SetSeriesDataXML(strDataXML, idx2);
		//운영에 맞게 스타일 지정이 필요함.
		_obj.Series(idx2).ColorEachPoint = "false";
		_obj.Series(idx2).asPoint.Pointer.Style = 1;
		_obj.Series(idx2).Color = _obj.ToOLEColor(SEREIS_COLOR_20);
		_obj.Series(idx2).ShowInLegend = "false";
		//alert(_obj.Series(idx).VerticalAxis);
		_obj.Series(idx2).VerticalAxis = _obj.Series(idx).VerticalAxis;				
	}	
	/***************************************
	 * Bar Chart 값이 0일경우 연결선 끊기
	 ***************************************/	
	this.BarZeroTrunc = function() {
		
		_obj.Series(idx).DataID = "";
	
		if(title != "")  _obj.Series(idx).Title = title;
		
		var _dataObj = document.getElementById(dataObj);
		var dsCnt = _dataObj.CountRow;
		var strDataXML = '<Dataset>';

		for(var i=1, j=0;i<=dsCnt;i++,j++){
			strDataXML += '<set ';
			if(xValue != "") 
				strDataXML += 'x="' + _dataObj.NameString(i,xValue) + '" ';
			else
				strDataXML += 'x="' + j + '" ';
			if(yValue != "")
				strDataXML += 'y="' + _dataObj.NameString(i,yValue) + '" ';
			if(label != "") 
				strDataXML += 'label="' + _dataObj.NameString(i,label) + '" ';
			if(color != "") 
				strDataXML += 'color="' + _dataObj.NameString(i,color) + '" ';
			if(yValue != ""){
				if(_dataObj.NameString(i,yValue) == 0)
					strDataXML += 'null="True"';
				else
					strDataXML += 'null="False"';
			}
			strDataXML += '/>';
		}
		strDataXML += '</Dataset>';
		
		_obj.SetSeriesDataXML(strDataXML, idx);	
	}
	
	/***************************************
	 * BarTrunc 클리어
	 ***************************************/
	this.SetSeriesDataXMLClearBar = function() {
		var strDataXML = '<Dataset><set null="True"/></Dataset>';
		_obj.SetSeriesDataXML(strDataXML, idx);
	}	
/***************************************
 * 데이터 컬럼 변경 함수
 *  변수명.XValue("X축 컬럼");
 *  변수명.YValue("Y축 컬럼");
 *  변수명.Label("라벨 컬럼");
 *  변수명.Color("컬러 컬럼");
 *  변수명.Title("타이틀 명");
 *  변수명.DataSet("데이터셋 ID");
 ***************************************/
	//XValue 설정
	this.XValue = function(xValue) {
		_obj.Series(idx).XValues.Column = xValue;
	}
	
	//YValue 설정
	this.YValue = function(yValue) {
		_obj.Series(idx).YValues.Column = yValue;
	}
	
	//Label 설정
	this.Label = function(label) {
		_obj.Series(idx).PointLabels.Column = label;
	}
	
	//Color 설정
	this.Color = function(color) {
		_obj.Series(idx).PointColors.Column = color;
	}
	
	//Title 설정
	this.Title = function(title) {
		_obj.Series(idx).Title = title;
	}
	
	//DataSet 설정
	this.DataSet = function(dataSetID) {
		_obj.Series(idx).DataID = dataSetID;
	}
/***************************************
 * 시리즈 컬러 컨트롤 함수
 *  변수명.BarColor(컬러);
 ***************************************/
	this.SeriesColor = function(Color) {
		_obj.Series(idx).Color = _obj.ToOLEColor(Color);
	}
	
/***************************************
 * 시리즈 컬러 컨트롤 함수
 *  변수명.ColorEachPoint(사용여부);
 ***************************************/
	this.ColorEachPoint = function(bColorEachPoint) {
		_obj.Series(idx).ColorEachPoint =bColorEachPoint; 
	}

/***************************************
 * 시리즈 에니메이션 설정 함수
 *  변수명.animation(에니메이션타입);
 *  에니메이션타입 : 0:None,1:Default,2:Fade,3:WipeRight,4:WipeLeft,5:WipeUp,6:WipeDown
 ***************************************/
	this.animationType = function(aniType) {
		_obj.Series(idx).AnimationType=aniType;
	}
	
/***************************************
 * 시리즈 변경 함수
 *  변수명.changeSeriseName(시리즈명);
 *  시리즈명 : AngularGauge,Area,Arrow,Bar,Bezier,Bubble,Candle,Donut,Error,ErrorBar,
 *             FastLine,Gantt,HighLow,Histogram,HorizArea,HorizBar,HorizeGauge,HorizLine,
 *             Line,Map,Pie,Point,Polar,Pyramid,Radar,Shape,Smith,Volume,VolumePipe,World
 ***************************************/
	this.changeSeriseName = function(seriesType){
		
		var _seriesType = SERIES.getChartSeries(seriesType);
		_obj.ChangeSeriesType(idx, _seriesType);
		
		_obj.Refresh();
	}
	
/***************************************
 * 시리즈 범례 설정 함수
 *  변수명.showInLegend(범례 표시여부);
 *  범례 표시여부 : true,false
 ***************************************/
	this.showInLegend = function(bShowInLegend) {
		_obj.Series(idx).ShowInLegend = bShowInLegend;
	}
	
/***************************************
 * Bar 시리즈 컨트롤 함수
 *  변수명.BarSerise(멀티바 스타일, 바 스타일, 바 넓이);
 *  멀티바 스타일 - 0 : 기본, 1 : Side, 2 : Stacked, 3 : Stacked100
 *  바 스타일 - 0:Rectangle, 1:Pyramid, 2:InvPyramid, 3:Cylinder, 4:Ellipse, 5:Arrow, 6:Cone, 7:InvCone, 8:InvArrow
 ***************************************/
	this.BarSerise = function(MultiBar,BarStyle,BarWidth, BarOffSet){
		_obj.Series(idx).asBar.MultiBar = MultiBar;
		_obj.Series(idx).asBar.BarStyle = BarStyle;
		_obj.Series(idx).asBar.BarWidth = BarWidth;
		_obj.Series(idx).asBar.OffsetPercent = typeof(BarOffSet) != 'undefined' ? BarOffSet : 0;
	}
	
/***************************************
 * Pie, Donut 시리즈 컨트롤 함수
 *  변수명.PieSerise(슬라이스 깊이, 폭 자동 조절 여부, X축 폭 넓이, Y축 폭 넓이, 회전 각도);
 *  폭 자동 조절 여부 - true, false
 *  폭 넓이를 조절하기 위해서는 bCircled(폭 자동 조절 여부)가 false 여야 동작한다.
 ***************************************/
	this.PieSerise = function(explodeBiggest, bCircled, xRadius, yRadius, rotationAngle){
		//Default 값 설정
		explodeBiggest = typeof(explodeBiggest) != 'undefined' ? explodeBiggest : 1;
		bCircled = typeof(bCircled) != 'undefined' ? bCircled : "true";
		xRadius = typeof(xRadius) != 'undefined' ? xRadius : 0;
		yRadius = typeof(yRadius) != 'undefined' ? yRadius : 0;
		rotationAngle = typeof(rotationAngle) != 'undefined' ? rotationAngle : 0;
		
		var _objPosition = "";
		if(_seriesType == 21)
			_objPosition = _obj.Series(idx).asPie;
		else if(_seriesType == 8)
			_objPosition = _obj.Series(idx).asDonut;
		
		_objPosition.ExplodeBiggest = explodeBiggest;
		_objPosition.Circled = bCircled;
		_objPosition.XRadius = xRadius;
		_objPosition.YRadius = yRadius;
		_objPosition.RotationAngle = rotationAngle;
	}

	/***************************************
	* Pie, Donut 시리즈 컨트롤 함수
	*  변수명.SetExplodedSliceAll(슬라이스 깊이);
	*  모든 객체에 ExplodedSlice를 설정한다.
	***************************************/
	this.SetExplodedSliceAll = function(value){
		//Default 값 설정
		var index = document.getElementById(dataObj).CountRow;
		var value = typeof(value) != 'undefined' ? value : 0;
		
		var _objPosition = "";
		if(_seriesType == 21)
			_objPosition = _obj.Series(idx).asPie;
		else if(_seriesType == 8)
			_objPosition = _obj.Series(idx).asDonut;
		
		for(var i=0;i<index;i++){
			_objPosition.ExplodedSlice.Value(i) = value;
		}
	}

	/***************************************
	* Pie, Donut 시리즈 컨트롤 함수
	*  변수명.SetExplodedSliceAll(로우 인덱스, 슬라이스 깊이);
	*  각 객체마다 ExplodedSlice를 설정한다.
	***************************************/
	this.SetExplodedSlice = function(index, value){
		//Default 값 설정
		var dsCnt = document.getElementById(dataObj).CountRow;
		index = typeof(index) != 'undefined' ? index-1 : dsCnt-1;
		value = typeof(value) != 'undefined' ? value : 0;
		if(index >= dsCnt && index < 0)
			return;
		var _objPosition = "";
		if(_seriesType == 21)
			_objPosition = _obj.Series(idx).asPie;
		else if(_seriesType == 8)
			_objPosition = _obj.Series(idx).asDonut;

		_objPosition.ExplodedSlice.Value(index) = value;
	}
	
/***************************************
 * Pie, Donut 시리즈 컨트롤 함수
 *  변수명.PiePercentDisply(%표시여부);
 *  %표시여부 - true, false
 *  폭 넓이를 조절하기 위해서는 bCircled(폭 자동 조절 여부)가 false 여야 동작한다.
 ***************************************/
	this.PiePercentDisply = function(percentFlag){
		if(percentFlag == "true"){
			_obj.Series(idx).ValueFormat = "###,##0.#%";		
		}
	}		
		

/***************************************
 * 시리즈 오른쪽 Y축의 데이터 지정 함수
 *  변수명.VerticalAxis(Axis명);
 *  Axis 명 - 0 : LeftAxis, 1 : RightAxis, 2 : BothVertAxis, 3 : CustomVertAxis
 ***************************************/
	this.VerticalAxis = function(verticalAxis){
		_obj.Series(idx).VerticalAxis = verticalAxis;
	}

/***************************************
 * 시리즈 마크 설정 함수
 *  변수명.MarkStyle(마크 표시 여부, 마크 배경 투명 여부, 가려진 마크 표시 여부, 마크 연결선 표시 여부, 마크 표시 위치);
 *  마크 표시 여부, 마크 배경 투명 여부, 가려진 마크 표시 여부, 마크 연결선 표시 여부 : true,false
 ***************************************/
	this.MarkStyle = function(bVisible, bTransparent, bClip, bArrowVisible, ArrowLength) {
		//Default 값 설정
		bVisible = typeof(bVisible) != 'undefined' ? bVisible : "true";
		bTransparent = typeof(bTransparent) != 'undefined' ? bTransparent : "false";
		bClip = typeof(bClip) != 'undefined' ? bClip : "false";
		bArrowVisible = typeof(bArrowVisible) != 'undefined' ? bArrowVisible : "true";
		ArrowLength = typeof(ArrowLength) != 'undefined' ? ArrowLength : 5;
		
		_obj.Series(idx).Marks.Visible = bVisible;
		_obj.Series(idx).Marks.Transparent = bTransparent;
		_obj.Series(idx).Marks.Clip = bClip;
		_obj.Series(idx).Marks.Arrow.Visible = bArrowVisible;
		_obj.Series(idx).Marks.ArrowLength = ArrowLength;
	}

	/***************************************
	 *  축 %설정
	 *  (0:left, 1:right, 2: Top, 3:bottom)
	 ***************************************/	
	//% 설정
	this.PerLabel = function(xValue) {             
		if(xValue == 0){ // Left
			_obj.Axis.left.Labels.ValueFormat = "###,##0%"		
		}else if(xValue == 1){ // Right
			_obj.Axis.right.Labels.ValueFormat = "###,##0%"		
		}else if(xValue == 2){ // Top
			_obj.Axis.top.Labels.ValueFormat = "###,##0%"		
		}else if(xValue == 3){ // Bottom
			_obj.Axis.bottom.Labels.ValueFormat = "###,##0%"		
		}
		
	}   	
}

/***************************************
 * 에니메이션 적용 함수
 *  ShowAnimation(차트ID);
 ***************************************/
function ShowAnimation(obj) {
	var _obj = document.getElementById(obj);
	
	_obj.ShowAnimation();
}

/***************************************
 * TitleText 적용 함수
 *  TitleText(차트ID, 타이틀위치, 타이틀 명, 컬러, 폰트사이즈, 정렬방법, 굵기여부);
 *  타이틀 위치 - Header/SubHeader/Footer/SubFooter
 *  정렬방법 - 0:LeftJustify, 1:RightJustify, 2: Center
 *  굵기여부 - true, false
 ***************************************/
function TitleText(obj, position, text, color, size, alignment, vBold) {
	//Default 값 설정
	position = typeof(position) != 'undefined' ? position : "Left";
	text = typeof(text) != 'undefined' ? text : "";
	color = typeof(color) != 'undefined' ? color : "black";
	size = typeof(size) != 'undefined' ? size : 11;
	alignment = typeof(alignment) != 'undefined' ? alignment : 0;
	vBold = typeof(vBold) != 'undefined' ? vBold : "false";
	
	var _obj = document.getElementById(obj);
	
	var _objPosition = "";
	if(position == "Header") 
		_objPosition = _obj.Header
	else if(position == "SubHeader")
		_objPosition = _obj.SubHeader
	else if(position == "Footer")
		_objPosition = _obj.Footer
	else if(position == "SubFooter")
		_objPosition = _obj.SubFooter
	
	if(position == "") return;
	
	var tmp = text.split("\n");
	
	for(var i=0; i <= tmp.length ; i++)
		_objPosition.Text.Add(tmp[i]);
	
	_objPosition.Font.Color = _obj.ToOLEColor(color);
	_objPosition.Font.Size = size;
	_objPosition.Alignment = alignment;
	_objPosition.Font.Bold = vBold;
	_objPosition.Font.Name = "굴림";	
}

/***************************************
 *  TitleTextFix 적용 함수
 *  TitleText(차트ID, 타이틀위치, 타이틀 명);
 *  타이틀 위치 - Header/SubHeader/Footer/SubFooter
 *  정렬방법 - 0:LeftJustify, 1:RightJustify, 2: Center
 *  굵기여부 - true, false
 ***************************************/
function TitleTextFix(obj, position, titeleText) {
	//Default 값 설정
	position =typeof(position) != 'undefined' ? position : "Left";
	text = titeleText;
	color = "#666666";
	size = 12;
	alignment = 2;
	vBold = "true";
	
	var _obj = document.getElementById(obj);
	
	var _objPosition = "";
	if(position == "Header") 
		_objPosition = _obj.Header
	else if(position == "SubHeader")
		_objPosition = _obj.SubHeader
	else if(position == "Footer")
		_objPosition = _obj.Footer
	else if(position == "SubFooter")
		_objPosition = _obj.SubFooter
	
	if(position == "") return;
	
	var tmp = text.split("\n");
	
	for(var i=0; i <= tmp.length ; i++)
		_objPosition.Text.Add(tmp[i]);
	
	_objPosition.Font.Color = _obj.ToOLEColor(color);
	_objPosition.Font.Size = 12;
	_objPosition.Alignment = alignment;
	_objPosition.Font.Bold = vBold;
	_objPosition.Font.Name = "굴림";	
}

/***************************************
 * TitleTextClear 함수
 *  TitleTextClear(차트ID, 타이틀위치);
 *  타이틀 위치 - Header/SubHeader/Footer/SubFooter
 ***************************************/
function TitleTextClear(obj, position) {
	//Default 값 설정
	position = typeof(position) != 'undefined' ? position : "Left";
	
	var _obj = document.getElementById(obj);
	
	var _objPosition = "";
	if(position == "Header") 
		_objPosition = _obj.Header
	else if(position == "SubHeader")
		_objPosition = _obj.SubHeader
	else if(position == "Footer")
		_objPosition = _obj.Footer
	else if(position == "SubFooter")
		_objPosition = _obj.SubFooter
	
	if(position == "") return;
	
	_objPosition.Text.Clear();
}

/***************************************
 * 축 이름 설정 함수
 *  AxisName(차트ID, 축 위치, 기울기, 텍스트, 컬러, 폰트사이즈);
  * 축 위치 - Left/Right/Top/Bottom
 ***************************************/
function AxisName(obj, position, angle, text, color, size) {
	//Default 값 설정
	position = typeof(position) != 'undefined' ? position : "Left";
	angle = typeof(angle) != 'undefined' ? angle : 0;
	text = typeof(text) != 'undefined' ? text : "";
	color = typeof(color) != 'undefined' ? color : "black";
	size = typeof(size) != 'undefined' ? size : 12;
	
	var _obj = document.getElementById(obj);
	
	var _objPosition = "";
	if(position == "Left") 
		_objPosition = _obj.AxisName.Left;
	else if(position == "Right")
		_objPosition = _obj.AxisName.Right;
	else if(position == "Top")
		_objPosition = _obj.AxisName.Top;
	else if(position == "Bottom")
		_objPosition = _obj.AxisName.Bottom;
	
	if(position == "") return;

	_objPosition.Title.Caption = text;
	_objPosition.Title.Angle = angle;
	if(color != "")		_objPosition.Title.Font.Color = _obj.ToOLEColor(color);
	if(size != "")		_objPosition.Title.Font.Size = size;
	
}

/***************************************
 * 축의 Start, End Position 설정 함수
 *  SetAxisPosition(차트ID, 축 위치, 시작 값, 마지막 값);
 *  축 위치 - Left/Right/Top/Bottom
 ***************************************/
function SetAxisPosition(obj, position, start, end) {
	//Default 값 설정
	position = typeof(position) != 'undefined' ? position : "Left";
	start = typeof(start) != 'undefined' ? start : 0;
	end = typeof(end) != 'undefined' ? end : 100;
	
	var _obj = document.getElementById(obj);
	
	var _objPosition = "";
	if(position == "Left") 
		_objPosition = _obj.Axis.Left;
	else if(position == "Right")
		_objPosition = _obj.Axis.Right;
	else if(position == "Top")
		_objPosition = _obj.Axis.Top;
	else if(position == "Bottom")
		_objPosition = _obj.Axis.Bottom;
	
	if(position == "") return;

	_objPosition.StartPosition = start;
	_objPosition.EndPosition = end;
}

/***************************************
 * AxesVisible(차트ID, 위치, 보이기/숨기기) 보이기/숨기기
 * val : 차트ID
 * wallsVisible  : 0(Back), 1(Bottom), 2(Left), 3(Right)
 * bVisible  : true, false
 ***************************************/
function AxesVisible(val, posVisible, bVisible){
	var _obj = document.getElementById(val);

	if(posVisible == 0){
		_obj.Axis.Left.Visible = bVisible;
	}
		
	if(posVisible == 1){
		_obj.Axis.Right.Visible = bVisible;
	}

	if(posVisible == 2){
		_obj.Axis.Top.Visible = bVisible;
	}
		
	if(posVisible == 3){
		_obj.Axis.Bottom.Visible = bVisible;
	}

	if(posVisible == 4){
		_obj.Axis.Depth.Visible = bVisible;
	}
	
}

/***************************************
 * Walls(차트ID, 위치, 보이기/숨기기) 보이기/숨기기
 * val : 차트ID
 * wallsVisible  : 0(Back), 1(Bottom), 2(Left), 3(Right)
 * bVisible  : true, false
 ***************************************/
function WallsVisible(val, posVisible,  bVisible) {
	var _obj = document.getElementById(val);
		
	if(posVisible == 0){
		_obj.Walls.Back.Visible = bVisible;
	}
		
	if(posVisible == 1){
		_obj.Walls.Bottom.Visible = bVisible;
	}

	if(posVisible == 2){
		_obj.Walls.Left.Visible = bVisible;
	}
		
	if(posVisible == 3){
		_obj.Walls.Right.Visible = bVisible;
	}
}

/***************************************
 * MinDisStAxis 최소간격 정의
 * MinDisStAxis(차트ID, 축위치, 간격비율)
 * 축위치 : 0(Left), 1(Right), 2(Top), 3(Bottom), 4(Depth)
 ***************************************/
function MinDisStAxis(objChart, disRate, posAxis) {
	var _obj = document.getElementById(objChart);
	
	if(posAxis == 0){
		_obj.Axis.left.Labels.Separation = disRate;	
	}
	
	if(posAxis == 1){
		_obj.Axis.right.Labels.Separation = disRate;		
	}

	if(posAxis == 2){
		_obj.Axis.top.Labels.Separation = disRate;			
	}

	if(posAxis == 3){
		_obj.Axis.bottom.Labels.Separation = disRate;				
	}

	if(posAxis == 4){
		_obj.Axis.Depth.Labels.Separation = disRate;					
	}				
}	

/***************************************
 * Paner 그라데이션 컬러 컨트롤 함수
 *  ShowAnimation(obj);
 ***************************************/
function PanerGradientColor(obj,StartColor,MidColor,EndColor) {
	//Default 값 설정
	StartColor = typeof(StartColor) != 'undefined' ? StartColor : "ECF2F0";
	MidColor = typeof(MidColor) != 'undefined' ? MidColor : "F7F9F8";
	EndColor = typeof(EndColor) != 'undefined' ? EndColor : "F1F5F3";
	
	var _obj = document.getElementById(obj);
	
	_obj.Panel.Gradient.Visible = true;
	_obj.Panel.Gradient.StartColor = _obj.ToOLEColor(StartColor);
	_obj.Panel.Gradient.MidColor = _obj.ToOLEColor(MidColor);
	_obj.Panel.Gradient.EndColor = _obj.ToOLEColor(EndColor);
}

/***************************************
 * 차트 리셋 함수
 *  ChartReset(차트ID);
 ***************************************/
function ChartReset(obj){
	var _obj = document.getElementById(obj);
	_obj.reset();
}

/***************************************
 * 차트 리플래쉬 함수
 *  ChartRefresh(차트ID);
 ***************************************/
function ChartRefresh(obj){
	var _obj = document.getElementById(obj);
	_obj.Refresh();
}

/***************************************
 * 차트 클리어  함수
 *  ClearChart(차트ID);
 ***************************************/
function ClearChart(obj){
	var _obj = document.getElementById(obj);
	_obj.clearChart();
}

/***************************************
 * 차트 전체 시리즈 클리어  함수
 *  RemoveAllSeries(차트ID);
 ***************************************/
function RemoveAllSeries(obj){
	var _obj = document.getElementById(obj);
	_obj.RemoveAllSeries();
}

/***************************************
 * Axis 설정 함수
 *  SetChartAxisStyle(차트ID, 축 위치, 최소값, 최대값, 증가값, 축선 표현 여부, 축 표현 여부, 축 데이터 자동 표현 여부);
 * 축 위치 - Left/Right/Top/Bottom/Depth
 * 축선 표현 여부 - true, false
 * 축 표현 여부 - true, false
 * 축 데이터 자동 표현 여부 - true, false
 ***************************************/
function SetChartAxisStyle(obj, position, Minimum, Maximum, Increment, bGridPen, bVisible, bAutomatic){
	//Default 값 설정
	position = typeof(position) != 'undefined' ? position : "Left";
	Minimum = typeof(Minimum) != 'undefined' ? Minimum : 0;
	Maximum = typeof(Maximum) != 'undefined' ? Maximum : 100;
	Increment = typeof(Increment) != 'undefined' ? Increment : 0;
	bGridPen = typeof(bGridPen) != 'undefined' ? bGridPen : "true";
	bVisible = typeof(bVisible) != 'undefined' ? bVisible : "true";
	bAutomatic = typeof(bAutomatic) != 'undefined' ? bAutomatic : "false";
	
	
	var _obj = document.getElementById(obj);
	
	var _objPosition = "";
	if(position == "Left") 
		_objPosition = _obj.Axis.Left;
	else if(position == "Right")
		_objPosition = _obj.Axis.Right;
	else if(position == "Top")
		_objPosition = _obj.Axis.Top;
	else if(position == "Bottom")
		_objPosition = _obj.Axis.Bottom;
	else if(position == "Depth")
		_objPosition = _obj.Axis.Depth;
	
	if(position == "") return;
	
	_objPosition.Visible = bVisible;
	_objPosition.Automatic = bAutomatic;
	if(Minimum != "")	_objPosition.Minimum = Minimum;
	if(Maximum != "")	_objPosition.Maximum = Maximum;
	if(Increment != "")	_objPosition.Increment = Increment;
	
	_objPosition.GridPen.visible = bGridPen;
}

/***************************************
 * Legend 스타일 설정 함수
 *  SetLegendStyle(차트ID, 범례스타일, 투명유무, 범례 텍스트 스타일, 범례위치);
 *  범례스타일 - 0:Auto, 1:Series, 2:Values, 3:LastValues
 *  투명유무 - true/false
 *  범례 텍스트 스타일 - 0:Plain, 1:LeftValue, 2:RightValue, 3:LeftPercent, 4:RightPercent, 5:XValue
 *  위치 - 0:left, 1:right, 2:top, 3:bottom
 ***************************************/
function SetLegendStyle(obj, legendStyle, bTransparent, legendTextStyle, legendAlign){
	//Default 값 설정
	legendStyle = typeof(legendStyle) != 'undefined' ? legendStyle : 0;
	bTransparent = typeof(bTransparent) != 'undefined' ? bTransparent : "true";
	legendTextStyle = typeof(legendTextStyle) != 'undefined' ? legendTextStyle : 1;
	legendAlign = typeof(legendAlign) != 'undefined' ? legendAlign : 1;
	var _obj = document.getElementById(obj);

	_obj.Legend.LegendStyle = legendStyle;
	_obj.Legend.Transparent = bTransparent;
	_obj.Legend.TextStyle = legendTextStyle;
	_obj.Legend.Alignment = legendAlign;
}

/***************************************
 * Aspect 스타일 설정 함수
 *  SetAspectStyle(차트ID, 3D 유무);
 ***************************************/
function SetAspectStyle(obj, bView3D){
	//Default 값 설정
	bView3D = typeof(bView3D) != 'undefined' ? bView3D : "true";
	
	var _obj = document.getElementById(obj);
	
	_obj.Aspect.View3D = bView3D;
}

/***************************************
 * 각 시리즈 별 Array 저장
 *  - 넘어온 TYPE을 SeriesType으로 변환 시켜준다.
 ***************************************/
function ShiftChartSeries() {
    CHART_SERIES = [
    			 "AngularGauge^1"
				,"Area^2"
				,"Arrow^3"
				,"Bar^4"
				,"Bezier^5"
				,"Bubble^6"
				,"Candle^7"
				,"Donut^8"
				,"Error^9"
				,"ErrorBar^10"
				,"FastLine^11"
				,"Gantt^12"
				,"HighLow^13"
				,"Histogram^14"
				,"HorizArea^15"
				,"HorizBar^16"
				,"HorizeGauge^17"
				,"HorizLine^18"
				,"Line^19"
				,"Map^20"
				,"Pie^21"
				,"Point^22"
				,"Polar^23"
				,"Pyramid^24"
				,"Radar^25"
				,"Shape^26"
				,"Smith^27"
				,"Volume^28"
				,"VolumePipe^29"
				,"World^30"
				];
    var CHART_STYLE = [];
    for (var i=0; i<CHART_SERIES.length;i++)   {
        var map = CHART_SERIES[i].split("^");
        CHART_STYLE[map[0].toLowerCase()] = map[1];
    }

    this.getChartSeries = function(param) {
        var rtn = CHART_STYLE[param.toLowerCase()];
        if (typeof(rtn) == "undefined") {
            alert("입력하신 차트명 [" + param + "]은 사용하실수 없습니다.");
            return;
        } else {
            return rtn;
        }
    }
}


/***************************************
 * SetDataSetColor 시리즈별 컬러셋팅(DataSet ID, 컬럼명)
 ***************************************/
function SetDataSetColor(objDataSet, colNm){
	for(var i=1; i<=objDataSet.CountRow; i++){
		if(parseInt(i)<10){
			objDataSet.NameString(i, colNm) = eval("SEREIS_COLOR_0" + i);
		}else{
			objDataSet.NameString(i, colNm) = eval("SEREIS_COLOR_" + i);
		}
	}
	
	objDataSet.ResetStatus();
}	

/***************************************************************************************************
 * 	차트 Y축 MIN/MAX 값 설정
 *  setChartYValueMinMax(dataSetID, Y축 컬럼값[배열값], Chart ID);
 ***************************************************************************************************/
function setChartYValueMinMax(dataSetID, YValueCol, chartId){
	var objDataSet = document.getElementById(dataSetID);
	var objChart = document.getElementById(chartId);   
	
	// 최대값을 기준으로 Left 최소,최대값을 표현해 달라는 요청으로 스크립트로 작성
	//데이터셋ID.Max(컬럼지정,시작로우,마지막로우)

	var lMaxValue = 0;
 
    if(YValueCol.length == 1){
		lMaxValue= objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0);
	}else if(YValueCol.length == 2){
		lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
		                   ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
		                    );
	}else if(YValueCol.length == 3){
	   lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
										 ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[2]),0,0)
                                          );
    }else if(YValueCol.length == 4){
	   lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
										 ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[2]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[3]),0,0)
                                          );
    }else if(YValueCol.length == 5){
	   lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
										 ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[2]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[3]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[4]),0,0)
                                          );
    }else if(YValueCol.length == 6){
	   lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
										 ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[2]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[3]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[4]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[5]),0,0)                                         
                                          );
    }else if(YValueCol.length == 7){
	   lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
										 ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[2]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[3]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[4]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[5]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[6]),0,0)                                                                                  
                                          );
    }else if(YValueCol.length == 8){
	   lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
										 ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[2]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[3]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[4]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[5]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[6]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[7]),0,0)                                         
                                          );
    }else if(YValueCol.length == 9){
	   lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
										 ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[2]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[3]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[4]),0,0)
										 ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[5]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[6]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[7]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[8]),0,0)                                         
                                          );
    }else if(YValueCol.length == 10){
	   lMaxValue= Math.max(objDataSet.Max(objDataSet.ColumnIndex(YValueCol[0]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[1]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[2]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[3]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[4]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[5]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[6]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[7]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[8]),0,0)
                                         ,objDataSet.Max(objDataSet.ColumnIndex(YValueCol[9]),0,0)                                         
                                          );
    }
    
	//절대값으로 변환하여 MAX값 처리
	var maxLen = "";
	var max = Math.abs(lMaxValue);
    
	// 단위 계산을 위한 길이 추출 
	maxLen = new String(max).length; // max값의 길이 
	// max 값의 10%를 증가 처리 
	max = max + max*0.1;              
      
	// 1000이하의 값에 대하여는 예외 처리 
	if(maxLen < 4){
		maxLen = 1;
	}else{
      // max값 천단위 0처리를 위한 0패딩 호출 
       maxLen = createNum(maxLen -2); 
	}

	// max값 천단위 0끝처리 후 Y축 max에 대입 
	max = Math.floor(max/maxLen)*maxLen; // ex)100으로 나누어서 소숫점을 제거하고 100을 곱하여 원자릿수로 복구 
     
	SetChartAxisStyle(chartId, "Left", 0,  max, 0, "false", "true");
     
    // 증감치는 max 의 20%씩 
	objChart.Axis.Left.Increment = Math.floor(max*0.2);
    
}

/***************************************************************************************************
 * 	Length 길이만큼 0값 채우기
 *  createNum(길이);
 ***************************************************************************************************/
function createNum(sizeN){
	var incNum = "1";
	for ( i =1 ; i <= sizeN; i++){
		incNum = incNum +"0";
	}
	
	return new Number(incNum);
}

/***************************************
 * findMinMax Row값 찾기
 * findMinMax(DataSetID, colNm, maxMinTp);
 * colNm - MAX/MIN값 DataSet 칼럼ID
 * maxMinTp - MAX:최대값, MIN:최소값
 ***************************************/
function findMinMax(dataSetID, colNm, maxMinTp){
	var rowVal = new Array();
	var objDataSet = document.getElementById(dataSetID);
	var dataVal = 0;
	var j = 0;
	
	if(maxMinTp == "MAX"){
		dataVal = objDataSet.NameMax(colNm, 0, 0);
	}

	if(maxMinTp == "MIN"){
		dataVal = objDataSet.NameMin(colNm, 0, 0);	
	}
	
	for(var i=1; i<=objDataSet.CountRow; i++){
		if(dataVal == objDataSet.NameValue(i, colNm)){
			rowVal[j] = i;
			j++;
		}
	}	
	
	return rowVal;
}
