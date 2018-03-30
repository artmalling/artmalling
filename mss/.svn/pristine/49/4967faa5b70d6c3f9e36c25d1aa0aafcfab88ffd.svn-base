<!-- 
/*******************************************************************************
 * 시스템명 : 임대관리 > 기준정보관리> 열요금표관리
 * 작 성 일 : 2010.04.01
 * 작 성 자 : 신익수
 * 수 정 자 : 
 * 파 일 명 : mren1100.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 온수,증기,냉기 요금표를 관리 합니다.
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />

<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

var strToday = getTodayFormat("yyyymmdd");

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_MASTER1.setDataHeader('<gauce:dataset name="H_MASTER1"/>');
    DS_IO_MASTER2.setDataHeader('<gauce:dataset name="H_MASTER2"/>');
    DS_IO_MASTER3.setDataHeader('<gauce:dataset name="H_MASTER3"/>');
    DS_IO_MASTER4.setDataHeader('<gauce:dataset name="H_MASTER4"/>');
    registerUsingDataset('<%=((SessionInfo) session.getAttribute("sessionInfo")).getPGM_ID()%>'.toLowerCase(), "DS_IO_MASTER,DS_IO_MASTER1,DS_IO_MASTER2,DS_IO_MASTER3,DS_IO_MASTER4");
    
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate(); 
    
    //공통코드 가져오기
    getEtcCode("DS_IO_MONTH", "D", "M100", "N");      //월
    getEtcCode("DS_IO_OVERTIME", "D", "M084", "N");   //부하시간대구분
    getEtcCode("DS_IO_TIME","D","M059","N");    //시간 
    
    //초기 onload 하자 마자 조회 한다.
    btn_Search();
}

function gridCreate(){
    //온수-주택용WWTR_KIND_CD
	var hdrProperies =   '<FC>id=WWTR_KIND_CD        name="용도구분" SHOW=FALSE </FC>' 
		                + '<FC>id=BAS_PRC           name="*기본요금;(계약면적㎡당)"  width=80   align=right </FC>'
						+ '<FC>id=UNIT_PRC        name="*사용요금;(Mcal)"       width=80    align=right </FC>'  
						+ '<G>name = "계절별 차등요금제 사용요금(Mcal)" '
						+ '<FC>id=UNIT_PRC_01   name="*1월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_02   name="*2월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_03   name="*3월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_04   name="*4월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_05   name="*5월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_06   name="*6월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_07   name="*7월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_08   name="*8월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_09   name="*9월"  width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_10   name="*10월" width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_11   name="*11월" width=80    align=right </FC>'
						+ '<FC>id=UNIT_PRC_12   name="*12월" width=80    align=right </FC>'   
						+ '</G>'
				    ;

    initGridStyle(GD_MASTER, "common", hdrProperies, true);  
    
    //온수-기타
    var hdrProperies1 = ' <FC>id=WWTR_KIND_CD        name="용도구분" width=70 EDIT=NONE show=false</FC>'
    	                + '<FC>id=WWTR_KIND_NM        name="용도구분" width=70 EDIT=NONE</FC>'
    	                + '<FC>id=BAS_PRC              name="*기본요금;(계약용량;Mcal/h당)"  width=80    align=right </FC>'
					    + '<FC>id=UNIT_PRC          name="*사용요금;(Mcal)"  width=80    align=right </FC>'
					    + '<X>name="시간대별 차등요금제 사용요금(Mcal)" '
					            + '<G>name="적용기간" '
					                + '<C>id=APP_S_MM          name="*시작월"  width=70    align=center EditStyle=Lookup  Data="DS_IO_MONTH:CODE:NAME" </C>'
					                + '<C>id=APP_E_MM          name="*종료월"  width=70    align=center EditStyle=Lookup  Data="DS_IO_MONTH:CODE:NAME" </C>'
					            + '</G>'
					            + '<G>name="수요관리시간대" '
					                + '<C>id=DEM_S_HH          name="*시작시간"  width=70    align=center EditStyle=Lookup  Data="DS_IO_TIME:CODE:NAME"</C>'
					                + '<C>id=DEM_E_HH          name="*종료시간"  width=70    align=center EditStyle=Lookup  Data="DS_IO_TIME:CODE:NAME" </C>'
					                + '<C>id=DEM_UNIT_PRC      name="*단가"  width=80    align=right </C>'
					          + '</G>'
					        + '<C>id=DEM_ETC_UNIT_PRC  name="*수요관리;시간대 이;외단가"  width=80    align=right </C>'
					    + '</X> '
			        ;

    initGridStyle(GD_MASTER1, "common", hdrProperies1, true);  
    
    //증기
    var hdrProperies2 = ' <FC>id=STM_KIND_CD        name="용도구분" SHOW=FALSE </FC>' 
    	               + '<FC>id=BAS_PRC     name="*기본요금;(계약용량Mcal당)"  width=90   align=right</FC>'
        	           + '<FC>id=UNIT_PRC    name="*사용요금;(Macal)"       width=80 align=right   </FC>'
			        ;

    initGridStyle(GD_MASTER2, "common", hdrProperies2, true);  
    GD_MASTER2.TitleHeight = 76;
    
    //냉수-기본요금
    var hdrProperies3 = ' <FC>id=CWTR_KIND_CD   name="용도구분"  SHOW=FALSE</FC>'
                        + '<FC>id=SEQ   name="순번"  SHOW=FALSE</FC>' 
                        + '<G>name="열교환기용량(Mcal/h당)" '
                        + '<C>id=USE_S_QTY   name="*시작구간"  width=80    align=right </C>'
					    + '<C>id=USE_E_QTY   name="*종료구간"  width=80    align=right </C>'
					    + '</G> '
					    + '<FC>id=BAS_PRC   name="*기본요금"  width=80    align=right </FC>'
			        ;

    initGridStyle(GD_MASTER3, "common", hdrProperies3, true);  
    
    //냉수-사용요금
    var hdrProperies4 = ' <FC>id=CWTR_KIND_CD   name="용도구분"  SHOW=FALSE </FC>'
    	                + '<FC>id=TIME_ZONE_OLD   name="부하시간대구분기존값" show=false  </FC>'
    	                + '<FC>id=TIME_ZONE   name="*부하시간대구분"  width=120    align=left edit={IF(TIME_ZONE_OLD=C,"true","false")}   EditStyle=Lookup  Data="DS_IO_OVERTIME:CODE:NAME"</FC>'
    	                + '<G>name="적용기간" '
					    + '<FC>id=APP_S_MM    name="*시작월"  width=80    align=center EditStyle=Lookup  Data="DS_IO_MONTH:CODE:NAME"  </FC>'
					    + '<FC>id=APP_E_MM    name="*종료월"  width=80    align=center EditStyle=Lookup  Data="DS_IO_MONTH:CODE:NAME"  </FC>'
					    + '</G>'
					    + '<G>name="적용기간" '
					    + '<FC>id=APP_S_HH    name="*시작시간"  width=80    align=center EditStyle=Lookup  Data="DS_IO_TIME:CODE:NAME"</FC>'
					    + '<FC>id=APP_E_HH    name="*종료시간"  width=80    align=center EditStyle=Lookup  Data="DS_IO_TIME:CODE:NAME"</FC>'
					    + '</G>'
					    + '<FC>id=UNIT_PRC    name="*단가"  width=80    align=right </FC>'

			        ;

    initGridStyle(GD_MASTER4, "common", hdrProperies4, true);  
}

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/

/**
 * btn_Search()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    //온수-주택용 조회
    getWarmWtrprch();
    
    //온수-기타 조회
    getWarmWtrprcb();
    
    //증기 조회
    getSteamPrc();
    
    //냉수 -기본요금 조회
    getColdWtrBa();
    
    //냉수-사용요금 조회
    getcoldWtr();

}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated && !DS_IO_MASTER1.IsUpdated && !DS_IO_MASTER2.IsUpdated && !DS_IO_MASTER3.IsUpdated && !DS_IO_MASTER4.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(StopSign, OK, "USER-1028");
       return;
    }
    
	if (DS_IO_MASTER3.CountRow == 0) {
		showMessage(StopSign, OK, "USER-1000","냉수-기본요금은 한건 이상 입력 해야 합니다.");
	    return;
	}
	
	if (DS_IO_MASTER4.CountRow == 0) {
        showMessage(StopSign, OK, "USER-1000","냉수-사용요금은 한건 이상 입력 해야 합니다.");
        return;
    }
	 
	//ccheck 
    if(!checkValidation("Save")) {
    	return;
    }
	
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1010") != 1 )
        return;
    
    var goTo       = "save" ;  
 
    TR_MAIN.Action="/mss/mren110.mr?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_MASTER1=DS_IO_MASTER1,I:DS_IO_MASTER2=DS_IO_MASTER2,I:DS_IO_MASTER3=DS_IO_MASTER3,I:DS_IO_MASTER4=DS_IO_MASTER4)"; //조회는 O
    TR_MAIN.Post();
    btn_Search();   
    
    
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
  /**
  * getWarmWtrprch()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  온수-주택용 조회
  * return값 : void
  */
 function getWarmWtrprch(){
	//데이타셋 초기화
	DS_IO_MASTER.ClearData();
	
	var goTo       = "getWarmWtrprch" ;    
    var action     = "O";     
    
    TR_MAIN.Action="/mss/mren110.mr?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    //setPorcCount("SELECT", GD_MASTER);
    
    if (DS_IO_MASTER.CountRow == 0) {
    	DS_IO_MASTER.Addrow();
    }
 }

   /**
  * getWarmWtrprcb()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  온수-기타 조회
  * return값 : void
  */
 function getWarmWtrprcb(){
	//데이타셋 초기화
	DS_IO_MASTER1.ClearData();
	
	var goTo       = "getWarmWtrprcb" ;    
    var action     = "O";     
    
    TR_MAIN.Action="/mss/mren110.mr?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER1=DS_IO_MASTER1)"; //조회는 O
    TR_MAIN.Post();
    
    if (DS_IO_MASTER1.CountRow == 0) {
        DS_IO_MASTER1.Addrow();
    }
 }
 
 /**
  * getSteamPrc()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  증기 조회
  * return값 : void
  */
 function getSteamPrc(){
	//데이타셋 초기화
	DS_IO_MASTER2.ClearData(); 
	
	var goTo       = "getSteamPrc" ;    
    var action     = "O";     
    
    TR_MAIN.Action="/mss/mren110.mr?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER2=DS_IO_MASTER2)"; //조회는 O
    TR_MAIN.Post();
    
    if (DS_IO_MASTER2.CountRow == 0) {
    	DS_IO_MASTER2.Addrow();
    }
 }
 
 /**
  * getColdWtrBa()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  냉수 -기본요금 조회
  * return값 : void
  */
 function getColdWtrBa(){
	//데이타셋 초기화
	DS_IO_MASTER3.ClearData(); 
	
	var goTo       = "getColdWtrBa" ;    
    var action     = "O";     
    
    TR_MAIN.Action="/mss/mren110.mr?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER3=DS_IO_MASTER3)"; //조회는 O
    TR_MAIN.Post();
    
 }
 
 /**
  * getcoldWtr()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  냉수-사용요금 조회
  * return값 : void
  */
 function getcoldWtr(){
	//데이타셋 초기화
	DS_IO_MASTER4.ClearData(); 
	
	var goTo       = "getcoldWtr" ;    
    var action     = "O";     
    
    TR_MAIN.Action="/mss/mren110.mr?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER4=DS_IO_MASTER4)"; //조회는 O
    TR_MAIN.Post();
    
 }
 
 /**
  * coldWtrBaAddRow()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  냉수-기본요금 행추가 
  * return값 : void
  */
 function coldWtrBaAddRow() {
	 //if(checkValidation1()) {
		 DS_IO_MASTER3.AddRow();
		 GD_MASTER3.SetColumn("USE_S_QTY");
		 
		 DS_IO_MASTER3.NameValue(DS_IO_MASTER3.RowPosition, "USE_S_QTY") = setDefaultValue(DS_IO_MASTER3, "USE_E_QTY");
	 //}
 }

 /**
  * coldWtrAddRow()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  냉수-사용요금 행추가 
  * return값 : void
  */
 function coldWtrAddRow() {
	
	if (DS_IO_MASTER4.CountRow == 3) {
	   showMessage(INFORMATION, OK, "USER-1000", "냉수-사용요금을 더이상 추가 할수 없습니다.");
       return false;
	} else {
		//if(checkValidation2()) {
		    DS_IO_MASTER4.AddRow();
		    GD_MASTER4.SetColumn("TIME_ZONE");
		//}
	}
 }
 
 
 /**
  * coldWtrBaDelRow()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  냉수-기본요금 행삭제
  * return값 : void
  */
  function coldWtrBaDelRow() {
	  if (DS_IO_MASTER3.CountRow > 0) {
		  if (DS_IO_MASTER3.CountRow == 1) {
			  showMessage(INFORMATION, OK, "USER-1000", "냉수-기본요금을 더이상 삭제 할수 없습니다.");
			  return false;
		  } else {
			  DS_IO_MASTER3.DeleteRow(DS_IO_MASTER3.Rowposition);  
		  }
	  }
  }
  
 /**
  * coldWtrDelRow()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-04-04
  * 개    요 :  냉수-사용요금 행삭제
  * return값 : void
  */
  function coldWtrDelRow() {
	  if (DS_IO_MASTER4.CountRow > 0) {
          if (DS_IO_MASTER4.CountRow == 1) {
              showMessage(INFORMATION, OK, "USER-1000", "냉수-사용요금을 더이상 삭제 할수 없습니다.");
              return false;
          } else {
        	  DS_IO_MASTER4.DeleteRow(DS_IO_MASTER4.Rowposition);  
          }
      }
  }
 
  /**
   * checkValidation1()
   * 작 성 자     : 신익수
   * 작 성 일     : 2010-04-04
   * 개    요        : 냉수-기본요금 행추가시 체크 
   * Gubun : Save, Delete
   * return값 : void
   */
  function checkValidation1(){
	//냉수-기본 요금 추가시 
      var intRowCount3   = DS_IO_MASTER3.CountRow;
      
      if(intRowCount3 > 0){
          for(var i=1; i <= intRowCount3; i++){
            var strUseSqty  = DS_IO_MASTER3.NameValue(i, "USE_S_QTY");
            var strUseEqty  = DS_IO_MASTER3.NameValue(i, "USE_E_QTY");
            var strBasQty  = DS_IO_MASTER3.NameValue(i, "BAS_PRC");
            
            if(strUseSqty == 0){
                showMessage(INFORMATION, OK, "USER-1003", "열교환기 용량(Mcal/h당) 시작구간");
                GD_MASTER3.SetColumn("USE_S_QTY");  
                DS_IO_MASTER3.RowPosition = i;  
                return false;
            }
            
            if(strUseEqty == 0){
                showMessage(INFORMATION, OK, "USER-1003", "열교환기 용량(Mcal/h당) 종료구간");
                GD_MASTER3.SetColumn("USE_E_QTY");  
                DS_IO_MASTER3.RowPosition = i;  
                return false;
            }
            
            if(strBasQty == 0){
                showMessage(INFORMATION, OK, "USER-1003", "기본요금");
                GD_MASTER3.SetColumn("BAS_PRC");  
                DS_IO_MASTER3.RowPosition = i;  
                return false;
            }
            
            //구간값 
            for (var k=i+1; k<=DS_IO_MASTER3.CountRow; k++) {
                var iUseS = DS_IO_MASTER3.NameValue(i, "USE_S_QTY");
                var iUseE = DS_IO_MASTER3.NameValue(i, "USE_E_QTY");
                var kUseS = DS_IO_MASTER3.NameValue(k, "USE_S_QTY");
                var kUseE = DS_IO_MASTER3.NameValue(k, "USE_E_QTY");
                if ( // 사용량구간(From)
                     (eval(iUseS) >= eval(kUseS) && eval(iUseS) <= eval(kUseE)) ||
                     (eval(iUseE) >= eval(kUseS) && eval(iUseE) <= eval(kUseE)) 
                    ||
                    // 사용량구간(To)
                     (eval(kUseS) >= eval(iUseS) && eval(kUseS) <= eval(iUseE)) ||
                     (eval(kUseE) >= eval(iUseS) && eval(kUseE) <= eval(iUseE)))  
                {
                       DS_IO_MASTER3.RowPosition = k;
                       showMessage(INFORMATION, OK, "USER-1000", "["+i+"]번째 행의 시작구간 이  ["+k+"]번째 행의 종료구간 과 중복 됩니다.");
                       return false;
                }
        
            }
         }
      }
      return true; 
  }
  
  /**
   * checkValidation2()
   * 작 성 자     : 신익수
   * 작 성 일     : 2010-04-04
   * 개    요        : 냉수-사용요금 행추가시 체크 
   * Gubun : Save, Delete
   * return값 : void
   */
  function checkValidation2(){
	//냉수-사용요금 체크 
      var intRowCount4 = DS_IO_MASTER4.CountRow;
      
      if(intRowCount4 > 0){
          for(var i=1; i <= intRowCount4; i++){
          
            var strTimeZone = DS_IO_MASTER4.NameValue(i, "TIME_ZONE");
            var strAppSmm  = DS_IO_MASTER4.NameValue(i, "APP_S_MM");
            var strAppEmm  = DS_IO_MASTER4.NameValue(i, "APP_E_MM");
            var strAppShh  = DS_IO_MASTER4.NameValue(i, "APP_S_HH");
            var strAppEhh  = DS_IO_MASTER4.NameValue(i, "APP_E_HH");
            var strUnitPrc  = DS_IO_MASTER4.NameValue(i, "UNIT_PRC");
             
            if(strTimeZone.length <= 0){
                showMessage(INFORMATION, OK, "USER-1003", "[냉수-사용요금] 부하시간대구분");
                GD_MASTER4.SetColumn("TIME_ZONE"); 
                DS_IO_MASTER4.RowPosition = i;  
                return false;
            }
            
            if(strAppSmm.length <= 0){ 
                showMessage(INFORMATION, OK, "USER-1003", "[냉수-사용요금] 적용기간 시작월");
                GD_MASTER4.SetColumn("APP_S_MM");  
                DS_IO_MASTER4.RowPosition = i;  
                return false;
            }
            
            if(strAppEmm.length <= 0){
                showMessage(INFORMATION, OK, "USER-1003", "[냉수-사용요금] 적용기간 종료월");
                GD_MASTER4.SetColumn("APP_E_MM");  
                DS_IO_MASTER4.RowPosition = i;  
                return false;
            }
            
            if(strAppShh.length <= 0){
                showMessage(INFORMATION, OK, "USER-1003", "[냉수-사용요금] 부하시간 시작시간");
                GD_MASTER4.SetColumn("APP_S_HH");  
                DS_IO_MASTER4.RowPosition = i;  
                return false;
            }
            
            if(strAppEhh.length <= 0){
                showMessage(INFORMATION, OK, "USER-1003", "[냉수-사용요금] 부하시간 종료시간");
                GD_MASTER4.SetColumn("APP_E_HH");  
                DS_IO_MASTER4.RowPosition = i;  
                return false;
            }
            
            if( strUnitPrc == 0){
                showMessage(INFORMATION, OK, "USER-1003", "[냉수-사용요금] 단가");
                GD_MASTER4.SetColumn("UNIT_PRC");  
                DS_IO_MASTER4.RowPosition = i;  
                return false;
            }
            
            // 중복체크
            var dupRow = checkDupKey(DS_IO_MASTER4, "TIME_ZONE");
            if (dupRow > 0) {
                showMessage(StopSign, Ok,  "USER-1044", "[냉수-사용요금] " + dupRow);
                
                DS_IO_MASTER.RowPosition = dupRow;
                GD_MASTER4.SetColumn("TIME_ZONE");
                GD_MASTER4.Focus(); 

                return false;
            }
            
            if (strAppSmm > strAppEmm) {
                showMessage(INFORMATION, OK, "USER-1000", "[냉수-사용요금] 시작월은 종료월보다 클수 없습니다.");
                GD_MASTER4.SetColumn("APP_S_MM");  
                DS_IO_MASTER4.RowPosition = i;  
                return false;
            }
            
            if (strAppShh > strAppEhh) {
                showMessage(INFORMATION, OK, "USER-1000", "[냉수-사용요금] 시작시간은 종료시간보다 클수 없습니다.");
                GD_MASTER4.SetColumn("APP_S_HH");  
                DS_IO_MASTER4.RowPosition = i;  
                return false;
            }
         }
      }
      return true; 
  }
 
  /**
   * checkValidation(Gubun)
   * 작 성 자     : 신익수
   * 작 성 일     : 2010-04-04
   * 개    요        : 조회조건 값 체크 
   * Gubun : Save, Delete
   * return값 : void
   */
  function checkValidation(Gubun) {
       
       switch (Gubun) {
       
       case "Save":
           //온수-주택용
           var intRowCount   = DS_IO_MASTER.CountRow;
           
           if(intRowCount > 0){
               for(var i=1; i <= intRowCount; i++){
	           	 var strBasPrc     = DS_IO_MASTER.NameValue(i,"BAS_PRC");
		         var strUnitPrc    = DS_IO_MASTER.NameValue(i,"UNIT_PRC");  
	           	 var strUnitPrc01  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_01");
	           	 var strUnitPrc02  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_02");
	           	 var strUnitPrc03  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_03");
	           	 var strUnitPrc04  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_04");
	           	 var strUnitPrc05  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_05");
	           	 var strUnitPrc06  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_06");
	           	 var strUnitPrc07  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_07");
	           	 var strUnitPrc08  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_08");
	           	 var strUnitPrc09  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_09");
	           	 var strUnitPrc10  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_10");
	           	 var strUnitPrc11  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_11");
	           	 var strUnitPrc12  = DS_IO_MASTER.NameValue(i,"UNIT_PRC_12"); 
	           	   
	           	 if(strBasPrc == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 기본요금(계약면적㎡당)");
                    GD_MASTER.SetColumn("BAS_PRC");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 사용요금(Mcal)");
                    GD_MASTER.SetColumn("UNIT_PRC");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc01 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 1월");
                    GD_MASTER.SetColumn("UNIT_PRC_01");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc02 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 2월");
                    GD_MASTER.SetColumn("UNIT_PRC_02");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc03 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 3월");
                    GD_MASTER.SetColumn("UNIT_PRC_03");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc04 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 4월");
                    GD_MASTER.SetColumn("UNIT_PRC_04");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc05 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 5월");
                    GD_MASTER.SetColumn("UNIT_PRC_05");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc06 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 6월");
                    GD_MASTER.SetColumn("UNIT_PRC_06");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc07 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 7월");
                    GD_MASTER.SetColumn("UNIT_PRC_07");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc08 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 8월");
                    GD_MASTER.SetColumn("UNIT_PRC_08");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc09 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 9월");
                    GD_MASTER.SetColumn("UNIT_PRC_09");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc10 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 10월");
                    GD_MASTER.SetColumn("UNIT_PRC_10");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc11 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 11월");
                    GD_MASTER.SetColumn("UNIT_PRC_11");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
	           	 if(strUnitPrc12 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-주택용] 12월");
                    GD_MASTER.SetColumn("UNIT_PRC_12");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                 }
                 
              } 
           }
           
           //온수-기타
            var intRowCount1   = DS_IO_MASTER1.CountRow;
           
           if(intRowCount1 > 0){
               for(var i=1; i <= intRowCount1; i++){
                 var strBasPrc1     = DS_IO_MASTER1.NameValue(i,"BAS_PRC");
                 var strUnitPrc1    = DS_IO_MASTER1.NameValue(i,"UNIT_PRC");  
                 var strAppSmm1    = DS_IO_MASTER1.NameValue(i,"APP_S_MM");  
                 var strAppEmm1    = DS_IO_MASTER1.NameValue(i,"APP_E_MM");  
                 var strDemShh1    = DS_IO_MASTER1.NameValue(i,"DEM_S_HH");  
                 var strDemEhh1    = DS_IO_MASTER1.NameValue(i,"DEM_E_HH");  
                 var strDemUnitPrc    = DS_IO_MASTER1.NameValue(i,"DEM_UNIT_PRC");  
                 var strDemEtcUnitPrc    = DS_IO_MASTER1.NameValue(i,"DEM_ETC_UNIT_PRC");  

                 if(strBasPrc1 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[온수-기타] 기본요금(계약용량Mcal/h당)");
                    GD_MASTER1.SetColumn("BAS_PRC");  
                    DS_IO_MASTER1.RowPosition = i;  
                    return false;
                 }
                 if(strUnitPrc1 == 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[온수-기타] 사용요금(Mcal)");
                     GD_MASTER1.SetColumn("UNIT_PRC");  
                     DS_IO_MASTER1.RowPosition = i;  
                     return false;
                 }
                 
                 if(strAppSmm1.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[온수-기타] 적용기간 시작월");
                     GD_MASTER1.SetColumn("APP_S_MM");  
                     DS_IO_MASTER1.RowPosition = i;  
                     return false;
                 }
                 if(strAppEmm1.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[온수-기타] 적용기간 종료월");
                     GD_MASTER1.SetColumn("APP_E_MM");  
                     DS_IO_MASTER1.RowPosition = i;  
                     return false;
                 }
                 if(strDemShh1.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[온수-기타] 수요관리시간대 시작시간");
                     GD_MASTER1.SetColumn("DEM_S_HH");  
                     DS_IO_MASTER1.RowPosition = i;  
                     return false;
                 }
                 if(strDemEhh1.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[온수-기타] 수요관리시간대 종료시간");
                     GD_MASTER1.SetColumn("DEM_E_HH");  
                     DS_IO_MASTER1.RowPosition = i;  
                     return false;
                 }
                 if(strDemUnitPrc == 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[온수-기타] 수요관리시간대 단가");
                     GD_MASTER1.SetColumn("DEM_UNIT_PRC");  
                     DS_IO_MASTER1.RowPosition = i;  
                     return false;
                 }
                 if(strDemEtcUnitPrc == 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[온수-기타] 수요관리시간대 이외 단가");
                     GD_MASTER1.SetColumn("DEM_ETC_UNIT_PRC");  
                     DS_IO_MASTER1.RowPosition = i;  
                     return false;
                 }
                 
                 if (strDemShh1 > strDemEhh1) {
                     showMessage(INFORMATION, OK, "USER-1000", "[온수-기타] 시작시간은 종료시간보다 클수 없습니다.");
                     GD_MASTER1.SetColumn("DEM_S_HH");  
                     DS_IO_MASTER1.RowPosition = i;  
                     return false;
                 }
              } 
               
           }
           
           //증기 체크 
           var intRowCount2   = DS_IO_MASTER2.CountRow;
           
           if(intRowCount2 > 0){
               for(var i=1; i <= intRowCount2; i++){
                 var strBasPrc2     = DS_IO_MASTER2.NameValue(i,"BAS_PRC");
                 var strUnitPrc2    = DS_IO_MASTER2.NameValue(i,"UNIT_PRC");   

                 if(strBasPrc2 == 0){
                    showMessage(INFORMATION, OK, "USER-1003", "[증기] 기본요금(계약용량Mcal당)");
                    GD_MASTER2.SetColumn("BAS_PRC");  
                    DS_IO_MASTER2.RowPosition = i;  
                    return false;
                 }
                 if(strUnitPrc2 == 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[증기] 사용요금(Mcal)");
                     GD_MASTER2.SetColumn("UNIT_PRC");  
                     DS_IO_MASTER2.RowPosition = i;  
                     return false;
                 }
              } 
           }
           
    	   //냉수-기본 요금 추가시 
           var intRowCount3   = DS_IO_MASTER3.CountRow;
           
           if(intRowCount3 > 0){
               for(var i=1; i <= intRowCount3; i++){
                 var strUseSqty  = DS_IO_MASTER3.NameValue(i, "USE_S_QTY");
                 var strUseEqty  = DS_IO_MASTER3.NameValue(i, "USE_E_QTY");
                 var strBasQty  = DS_IO_MASTER3.NameValue(i, "BAS_PRC");
                 
                 if(strUseSqty == 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[냉수-기본 요금 ] 열교환기 용량(Mcal/h당) 시작구간");
                     GD_MASTER3.SetColumn("USE_S_QTY");  
                     DS_IO_MASTER3.RowPosition = i;  
                     return false;
                 }
                 
                 if(strUseEqty == 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[냉수-기본 요금 ] 열교환기 용량(Mcal/h당) 종료구간");
                     GD_MASTER3.SetColumn("USE_E_QTY");  
                     DS_IO_MASTER3.RowPosition = i;  
                     return false;
                 }
                 
                 if(strBasQty == 0){
                     showMessage(INFORMATION, OK, "USER-1003", "[냉수-기본 요금 ] 기본요금");
                     GD_MASTER3.SetColumn("BAS_PRC");  
                     DS_IO_MASTER3.RowPosition = i;  
                     return false;
                 }
                 
                 //구간값 
                 for (var k=i+1; k<=DS_IO_MASTER3.CountRow; k++) {
                     var iUseS = DS_IO_MASTER3.NameValue(i, "USE_S_QTY");
                     var iUseE = DS_IO_MASTER3.NameValue(i, "USE_E_QTY");
                     var kUseS = DS_IO_MASTER3.NameValue(k, "USE_S_QTY");
                     var kUseE = DS_IO_MASTER3.NameValue(k, "USE_E_QTY");
                     if ( // 사용량구간(From)
                          (eval(iUseS) >= eval(kUseS) && eval(iUseS) <= eval(kUseE)) ||
                          (eval(iUseE) >= eval(kUseS) && eval(iUseE) <= eval(kUseE)) 
                         ||
                         // 사용량구간(To)
                          (eval(kUseS) >= eval(iUseS) && eval(kUseS) <= eval(iUseE)) ||
                          (eval(kUseE) >= eval(iUseS) && eval(kUseE) <= eval(iUseE)))  
                     {
                            DS_IO_MASTER3.RowPosition = k;
                            showMessage(INFORMATION, OK, "USER-1000", "[냉수-기본 요금 ] / ["+i+"]번째 행의 시작구간 이  ["+k+"]번째 행의 종료구간 과 중복 됩니다.");
                            return false;
                     }
             
                 }
              } 
           }
           
           //냉수-사용요금 체크 
           var intRowCount4 = DS_IO_MASTER4.CountRow;
           
           if(intRowCount4 > 0){
               for(var i=1; i <= intRowCount4; i++){
               
                 var strTimeZone = DS_IO_MASTER4.NameValue(i, "TIME_ZONE");
            	 var strAppSmm  = DS_IO_MASTER4.NameValue(i, "APP_S_MM");
                 var strAppEmm  = DS_IO_MASTER4.NameValue(i, "APP_E_MM");
                 var strAppShh  = DS_IO_MASTER4.NameValue(i, "APP_S_HH");
                 var strAppEhh  = DS_IO_MASTER4.NameValue(i, "APP_E_HH");
                 var strUnitPrc  = DS_IO_MASTER4.NameValue(i, "UNIT_PRC");
                  
                 if(strTimeZone.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "부하시간대구분");
                     GD_MASTER4.SetColumn("TIME_ZONE"); 
                     DS_IO_MASTER4.RowPosition = i;  
                     return false;
                 }
                 
                 if(strAppSmm.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "적용기간 시작월");
                     GD_MASTER4.SetColumn("APP_S_MM");  
                     DS_IO_MASTER4.RowPosition = i;  
                     return false;
                 }
                 
                 if(strAppEmm.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "적용기간 종료월");
                     GD_MASTER4.SetColumn("APP_E_MM");  
                     DS_IO_MASTER4.RowPosition = i;  
                     return false;
                 }
                 
                 if(strAppShh.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "부하시간 시작시간");
                     GD_MASTER4.SetColumn("APP_S_HH");  
                     DS_IO_MASTER4.RowPosition = i;  
                     return false;
                 }
                 
                 if(strAppEhh.length <= 0){
                     showMessage(INFORMATION, OK, "USER-1003", "부하시간 종료시간");
                     GD_MASTER4.SetColumn("APP_E_HH");  
                     DS_IO_MASTER4.RowPosition = i;  
                     return false;
                 }
                 
                 if( strUnitPrc == 0){
                     showMessage(INFORMATION, OK, "USER-1003", "단가");
                     GD_MASTER4.SetColumn("UNIT_PRC");  
                     DS_IO_MASTER4.RowPosition = i;  
                     return false;
                 }
                 
                 // 중복체크
                 var dupRow = checkDupKey(DS_IO_MASTER4, "TIME_ZONE");
                 if (dupRow > 0) {
                     showMessage(StopSign, Ok,  "USER-1044", dupRow);
                     
                     DS_IO_MASTER.RowPosition = dupRow;
                     GD_MASTER4.SetColumn("TIME_ZONE");
                     GD_MASTER4.Focus(); 

                     return false;
                 }
                 
                 /* [2010.06.28] 다음날, 다음월 등록가능 Ex) 09월~(다음해)03월
                 if (strAppSmm > strAppEmm) {
                	 showMessage(INFORMATION, OK, "USER-1000", "시작월은 종료월보다 클수 없습니다.");
                     GD_MASTER4.SetColumn("APP_S_MM");  
                     DS_IO_MASTER4.RowPosition = i;  
                     return false;
                 }
                 
                 if (strAppShh > strAppEhh) {
                     showMessage(INFORMATION, OK, "USER-1000", "시작시간은 종료시간보다 클수 없습니다.");
                     GD_MASTER4.SetColumn("APP_S_HH");  
                     DS_IO_MASTER4.RowPosition = i;  
                     return false;
                 }
                 */
              }
           } 
        
           return true; 
       
       }     
  }
 
/**
 * setDefaultValue()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.13
 * 개    요 : 기본값
 * return값 : maxToVal
 */
function setDefaultValue(objDSName, strColid) {
	var maxToVal = 0;
	for (i = 1; i <= objDSName.CountRow; i++) {
		if (i != objDSName.RowPosition) {
			var tmpMaxToVal = eval(objDSName.NameValue(i, strColid));
			if (tmpMaxToVal > maxToVal) {
				maxToVal = eval(tmpMaxToVal);
			}
		}
	}
	if (eval(maxToVal) > 0) {
		maxToVal = eval(maxToVal + 1);
	} else {
		maxToVal = 0;
	}
	return maxToVal;
}

//-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=DS_IO_MONTH event=OnFilter(row)>
// [조회용]임대형태
if (DS_IO_MONTH.NameValue(row,"CODE") == "00" ) { //없음제외
    return false;
} else { 
    return true;
}
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER1"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER2"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER3"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER4"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MONTH"          classid=<%=Util.CLSID_DATASET%>><param name=UseFilter   value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_OVERTIME"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_TIME"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
 
<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

   <!--  그리드의 구분dot & 여백  -->
    <tr height=5><td></td></tr>
    <tr><td class="dot"></td></tr>
  <tr>
	<td class="sub_title PB03"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>온수-주택용</td>
  </tr>

  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_">
          <OBJECT id=GD_MASTER width=100% height=100 classid=<%=Util.CLSID_GRID%>>
               <param name="DataID" value="DS_IO_MASTER">
             </OBJECT>
           </comment>
           <script>_ws_(_NSID_);</script>
      </td>  
       </tr>
      </table> 
    </td>
    </tr>
    <!--  그리드의 구분dot & 여백  -->
	<tr height=5><td></td></tr>
	<tr><td class="dot"></td></tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
      <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="620" class="sub_title PB03"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>온수-기타</td>
            <td class="PL05 sub_title PB03"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>증기</td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                <tr>
                  <td width="100%">
                  <comment id="_NSID_">
                      <object id="GD_MASTER1" width="100%" height="140" classid="<%=Util.CLSID_GRID%>">
                        <param name="DataID" value="DS_IO_MASTER1" />
                      </object>
                    </comment>
                    <script>_ws_(_NSID_);</script></td>
                </tr>
              </table>
              </td>
            <td class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                <tr>
                  <td width="100%" >
                  <comment id="_NSID_">
                      <object id="GD_MASTER2" width="100%" height="140" classid="<%=Util.CLSID_GRID%>">
                        <param name="DataID" value="DS_IO_MASTER2" />
                      </object>
                    </comment>
                    <script>_ws_(_NSID_);</script></td>
                </tr>
              </table>
            </td>
          </tr>
        </table></td>
    </tr>
    <!--  그리드의 구분dot & 여백  -->
    <tr height=5><td></td></tr>
    <tr><td class="dot"></td></tr>
    <!--  그리드의 구분dot & 여백  -->
    <tr>
      <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100" class="sub_title PB03"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>냉수-기본요금</td>
            <td width="165" align="right">
                <img id="IMG_ADD_ROW"
	            style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/add_row.gif"
	            width="52" height="18" onclick="coldWtrBaAddRow();" hspace="2" /><img
	            id="IMG_DEL_ROW" style="vertical-align: middle;"
	            src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
	            onclick="coldWtrBaDelRow();" />
            </td>
            <td class="PL05 sub_title PB03" colspan="2"><img src="/<%=dir%>/imgs/comm/ring_blue.gif" width="11" height="12" align="absmiddle" class="PR03"/>냉수-사용요금</td>
            <!-- 
            <td align="right">
                <img id="IMG_ADD_ROW"
	            style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/add_row.gif"
	            width="52" height="18" onclick="coldWtrAddRow();" hspace="2" /><img
	            id="IMG_DEL_ROW" style="vertical-align: middle;"
	            src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
	            onclick="coldWtrDelRow();" />
            </td>
             -->
          </tr>
          <tr >
          <td height="5"></td>
          </tr>
          <tr>
            <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                <tr>
                  <td width="100%">
                  <comment id="_NSID_">
                      <object id="GD_MASTER3" width="100%" height="202" classid="<%=Util.CLSID_GRID%>">
                        <param name="DataID" value="DS_IO_MASTER3" />
                      </object>
                    </comment>
                    <script>_ws_(_NSID_);</script></td>
                </tr>
              </table>
              </td>
            <td colspan="2" class="PL05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
                <tr>
                  <td width="100%" >
                  <comment id="_NSID_">
                      <object id="GD_MASTER4" width="100%" height="202" classid="<%=Util.CLSID_GRID%>">
                        <param name="DataID" value="DS_IO_MASTER4" />
                      </object>
                    </comment>
                    <script>_ws_(_NSID_);</script></td>
                </tr>
              </table>
            </td>
          </tr>
        </table></td>
    </tr>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

