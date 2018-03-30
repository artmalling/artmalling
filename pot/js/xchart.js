/*

XChart를 초기화(XChart에 대한 프로퍼티 설정을 한다.)

변수
 oXChart : 초기화 하고자하는 XChart

*/
function cfInitXChart(oXChart) {

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = false;
	oXChart.Aspect.Chart3DPercent = 30;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;
	
	//마우스 드래드에 의한 Zoom 사용 여부
	oXChart.Zoom.Enable = false;
	
	// 0:스크롤 불가, 1:수평 스크롤 허용, 2:수직 스크롤 허용, 3:수평/수직 스크롤 모두 허용
	oXChart.Scroll.Enable = 2;
	// 스크롤에 사용되는 마우스 버튼 지정(1:왼쪽 버튼, 2:오른쪽 버튼, 4:가운데 버튼)
	oXChart.Scroll.MouseButton = 1;

	//Xchart의 타이틀에 관련된 속성을 설정한다
	//주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#f1f1f1, #ffffff");
	oXChart.Panel.BorderStyle = 0;
	
	//top right선을 안보임
    oXChart.Frame.Visible = false;
    
	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("RED");
//	oXChart.Axis.Left.Inverted = true;
	oXChart.Axis.Bottom.Increment = 5;

	//Legend의 속성을 설정한다
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 0;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	//var Toolsidx = oXChart.Tools.Add(8);
	//oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 1;	//0:MouseOver, 1:MouseClick
	//oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 2;
	//oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;
}

function cfAddGanttSeriesOne(oXChart, nDataSet, vType, vTitle, vColor, cLabel, cYvalue, sDtCol, eDtCol, nTaskCol, minDate, maxDate) {
	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	if ((vTitle == null)||(vTitle == "undefined")) return;

	//Series Type = 8일 경우, Gantt Chart
	if(vType != 8) {
		alert("Gantt Chart가 아닙니다.");
	} else {

		var idx = oXChart.AddSeries(vType);

		oXChart.Legend.Visible = false;

		//==================================================
		// 단순히 데이터를 읽어서 표현하는 방식
		//==================================================
		oXChart.Series(idx).DataID = nDataSet.id;
		oXChart.Series(idx).Title = vTitle;		//범례에 표현되는 문자열
		oXChart.Axis.Left.Labels.Visible = false;
		oXChart.Series(idx).LabelColumn = cLabel;
		oXChart.Series(idx).StartDateColumn = sDtCol;
		oXChart.Series(idx).EndDateColumn = eDtCol;
		oXChart.Series(idx).NextTaskColumn = nTaskCol;
		oXChart.Series(idx).ColorColumn = vColor;
		oXChart.Series(idx).asGantt.Pointer.VerticalSize = 10;		//포인터(막대)의 높이 지정
		//oXChart.Series(idx).asGantt.Pointer.Pen.Visible = false;

		//Left축을 기준으로 상하 여백을 위해 시작, 끝의 값을 임의 지정
	    oXChart.Axis.Left.Automatic=true;
		oXChart.Page.MaxPointsPerPage = 12;
		
		if (nDataSet.CountRow <= 12) {
		    oXChart.Axis.Left.Automatic=false;
		    //Bottom축에 시작(1일), 끝(31일)의 값을 임의 지정
    		//oXChart.Axis.Bottom.Automatic=false;
			//Left축 초기화
			oXChart.Axis.Left.Minimum = 0;
			oXChart.Axis.Left.Maximum = 0;
		
			//Left축 셋팅
			oXChart.Axis.Left.Maximum = eval(parseFloat(nDataSet.Max(nDataSet.ColumnIndex(nTaskCol),0,0))+0.5);
			oXChart.Axis.Left.Minimum = eval(parseFloat(nDataSet.Min(nDataSet.ColumnIndex(nTaskCol),0,0))-0.5);
        } else {
			oXChart.Axis.Bottom.AutomaticMaximum=false;
			oXChart.Axis.Bottom.AutomaticMinimum=false;
	    }
		
		var sy  = parseInt(eval(nDataSet.nameValue(1,minDate).substring(0,4)));
		var sm  = parseInt(eval(nDataSet.nameValue(1,minDate).substring(4,6)));
		    sm  = sm - 1;
		var sd  = parseInt(eval(nDataSet.nameValue(1,minDate).substring(6,8)));

		var ey  = parseInt(eval(nDataSet.nameValue(1,maxDate).substring(0,4)));
		var em  = parseInt(eval(nDataSet.nameValue(1,maxDate).substring(4,6)));
		    em  = em - 1;
		var ed  = parseInt(eval(nDataSet.nameValue(1,maxDate).substring(6,8)));
        
        //Bottom축 초기화
		oXChart.Axis.Bottom.Minimum = 0;
		oXChart.Axis.Bottom.Maximum = 0;
		
		//Bottom축 셋팅
		oXChart.Axis.Bottom.Maximum = new Date(ey,em,ed).getVarDate();		// 조회종료일(데이트 형식상 -1개월 해줘야함)
		oXChart.Axis.Bottom.Minimum = new Date(sy,sm,sd).getVarDate();		// 조회시작일(데이트 형식상 -1개월 해줘야함)
		
//		oXChart.Axis.Bottom.Minimum = new Date(parseInt(eval(sy)),parseInt(eval(sm)),parseInt(eval(sd))).getVarDate();		// 2006-07-01
		oXChart.Axis.Bottom.Increment=oXChart.GetDateTimeStep(17);    		// 17:삼일간격으로 표현(XChart-Method-GetDateTimeStep 참조)
		oXChart.Axis.Bottom.Labels.DateTimeFormat="dd";
		oXChart.Axis.Bottom.MinorTickCount = 2;

		//==================================================
		// Gantt의 각 막대를 별도로 지정하여 표현하는 방식
		//==================================================
//		for(var i=1; i<=nDataSet.countrow; i++) {
//			var sr = oXChart.Series(idx).asGantt;
//
//			var sy  = nDataSet.nameValue(i,sDtCol).substring(0,4);
//			var sm = nDataSet.nameValue(i,sDtCol).substring(4,6);
//			sm = parseInt(sm) - 1;	//Date객체 생성자에 Month는 0~11(1월~12월)사이의 값 인식함.
//			var sd  = nDataSet.nameValue(i,sDtCol).substring(6,8);
//
//			var ey  = nDataSet.nameValue(i,eDtCol).substring(0,4);
//			var em = nDataSet.nameValue(i,eDtCol).substring(4,6);
//			em = parseInt(em) - 1;	//Date객체 생성자에 Month는 0~11(1월~12월)사이의 값 인식함.
//			var ed  = nDataSet.nameValue(i,eDtCol).substring(6,8);
//
//			var start = new Date(sy,sm,sd);
//			var end  = new Date(ey,em,ed);
//
//			sr.AddGanttColor(start.getVarDate(), end.getVarDate(), nDataSet.nameValue(i,nTaskCol), nDataSet.nameValue(i,cLabel), oXChart.ToOLEColor(nDataSet.nameValue(i,vColor)));
//			sr.Pointer.VerticalSize = 10;
//		}

		// 시리즈 Mark관련 속성
		oXChart.Series(idx).Marks.Visible = true;
		oXChart.Series(idx).Marks.Frame.Visible = false;
//		oXChart.Series(idx).Marks.ShadowSize = 0;
		oXChart.Series(idx).Marks.Transparent = true;
		oXChart.Series(idx).Marks.Font.Color = oXChart.ToOLEColor("#3A3A3A");

//		var idx = oXChart.AddSeries(2);

		oXChart.reset();
	}
}
