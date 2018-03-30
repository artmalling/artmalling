<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 재고실사> 실사재고등록(단품)
 * 작 성 일 : 2010.04.04
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk220.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 실사재고를 관리한다.
 * 이    력 :
 *        2010.04.04 (이재득) 작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
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
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
var strSkuType = "0";
var strPummokCd ="";

var strStrCd       = "";
var strStkYm       = "";
var strPumbunCd    = "";
var strToday = '<%=Util.getToday("yyyyMMdd")%>'

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
var top = 175;		//해당화면의 동적그리드top위치
function doInit(){

	//Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_EXCEL.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_SKU.setDataHeader('<gauce:dataset name="H_SEL_EXCEL"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2();
    
    // EMedit에 초기화( gauce.js )
    initEmEdit(EM_O_STK_YM,       "THISMN",    PK);     //실사년월
    initEmEdit(EM_O_PUMBUN_CD,    "CODE^6^0",  PK);     //브랜드코드
    initEmEdit(EM_O_PUMBUN_NAME,  "GEN^40",    READ); //브랜드명
    initEmEdit(EM_O_ORG_NAME,     "GEN^40",    READ); //조직명
    initEmEdit(EM_O_COST_CAL_WAY, "GEN^20",    READ); //재고평가구분
    initEmEdit(EM_O_STK_DT,       "YYYYMMDD",  READ); //재고조사일
    initEmEdit(EM_O_STK_FLAG,     "GEN^10",    READ); //재고실사구분
    initEmEdit(EM_O_STATE,        "GEN^40",    READ); //상태
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점(조회)   
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_I_COST_CAL_WAY", "D", "P039", "N");    //재고평가구분
    getEtcCode("DS_I_COLOR_CD", "D", "P062", "N");        //칼라  
    getEtcCode("DS_I_SIZE_CD", "D", "P026", "N");         //사이즈
    getEtcCode("DS_I_SALE_UNIT_CD", "D", "P013", "N");    //판매단위
    getEtcCode("DS_I_CMP_SPEC_UNIT", "D", "P013", "N");   //구성규격단위

    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");    
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    EM_O_PUMBUN_CD.Focus();
    
    getPbnStk();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pstk220","DS_IO_MASTER" );
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"              width=30     align=center    edit=none  sumtext=""</FC>'    	             
    	             + '<FC>id=CHECK1          name="선택"            width=45    align=center EditStyle=CheckBox  HeadCheckShow="true"  sumtext="" edit={IF(CLOSE_DT="", "true", "false")} BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'                     
    	             + '<FC>id=SKU_CD          name="*단품코드"       width=120    align=center  sumtext=""  edit=none  BgColor={if(ERROR_CHECK = "","white","orange") } </FC>'
    	             + '<FC>id=MODEL_NO        name="*브랜드상품코드"   width=110    align=center edit=none BgColor={if(ERROR_CHECK = "","white","orange") }  </FC>'
                     + '<FC>id=SKU_NAME        name="단품명"          width=140    align=left  edit=none  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>' 
                     + '<FC>id=STR_CD          name="점코드"          width=50    align=center  show="false"</FC>'
                     + '<FC>id=STK_YM          name="조사년월"        width=80    align=center  show="false"</FC>'                                         
                     //+ '<FC>id=BUY_COST_PRC    name="원가"             width=80    align=right  edit=none sumtext=""</FC>'
                     + '<FC>id=BUY_COST_PRC    name="기준매입단가"             width=90    align=right  edit=none sumtext=""  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     // MARIO OUTLET
                     //+ '<FG>                   name="장부재고" '
                     //+ '<FC>id=STK_QTY         name="수량"             width=70    align=right  edit=none  sumtext=@sum BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     //+ '<FC>id=STK_AMT         name="금액"             width=90    align=right  edit=none  sumtext=@sum BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     //+ '</FG> '
                     // MARIO OUTLET
                     
                     + '<FG> name="실사재고" '
                     + '<FC>id=NORM_QTY        name="정상수량"         width=70    align=right sumtext=@sum  edit={IF(CLOSE_DT="", "true", "false")} edit=Numeric  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=NORM_AMT        name="정상금액"         width=110    align=right sumtext=@sum  edit=none      BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=INFRR_QTY       name="불량수량"         width=70    align=right sumtext=@sum  edit={IF(CLOSE_DT="", "true", "false")} edit=Numeric  BBgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=INFRR_AMT       name="불량금액"         width=110    align=right sumtext=@sum  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=SRVY_QTY        name="합계수량"         width=70    align=right sumtext=@sum  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=SRVY_AMT        name="합계금액"         width=110    align=right sumtext=@sum  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=SRVY_COST_AMT   name="재고실사원가금액"  width=60    align=right sumtext=@sum  edit=none  show="false"</FC>'
                     + '<FC>id=SRVY_SALE_AMT   name="재고실사매가금액"  width=60    align=right sumtext=@sum  edit=none   show="false"</FC>'
                     + '</FG> '
                     + '<FC>id=SEQ_NO          name="순번"            width=45    align=right  edit=none  show="false"</FC>'
                     + '<FC>id=STYLE_CD        name="STYLE코드"        width=90    align=center  edit=none show="false"</FC>'
                     + '<FC>id=STYLE_NAME      name="STYLE명"          width=110    align=left  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=COLOR_CD        name="칼라명"           width=80    align=left  edit=none  EditStyle=Lookup    Data="DS_I_COLOR_CD:CODE:NAME"  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=SIZE_CD         name="사이즈"           width=80    align=left  edit=none  EditStyle=Lookup    Data="DS_I_SIZE_CD:CODE:NAME"   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=PUMBUN_CD       name="브랜드"             width=60    align=center  edit=none  show="false" </FC>'
                     + '<FC>id=PUMMOK_CD       name="품목"             width=80    align=center  edit=none  show="false" </FC>'
                     //+ '<FC>id=INPUT_PLU_CD    name="소스마킹코드"     width=100    align=left  edit=none  show="false"  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     //+ '<FC>id=SALE_UNIT_CD    name="판매단위"         width=60    align=left  edit=none  show="false"  EditStyle=Lookup    Data="DS_I_SALE_UNIT_CD:CODE:NAME"   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     //+ '<FC>id=CMP_SPEC_UNIT   name="구성단위"         width=80    align=left  edit=none  show="false"  EditStyle=Lookup    Data="DS_I_CMP_SPEC_UNIT:CODE:NAME"  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     //+ '<FC>id=CLOSE_DT        name="마감일자"         width=100    align=left  edit=none  show="false"</FC>'
                     + '<FC>id=ERROR_CHECK     name="에러체크"         width=100    align=left  edit=none  show="false"</FC>';
                      
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    
    GD_MASTER.ViewSummary = "1";     
    GD_MASTER.ColumnProp("SKU_NAME", "sumtext")        = "합계";
}

function gridCreate2(){
    var hdrProperies =                  
                       '<FC>id=CHECK1          name="선택"             width=35    align=center EditStyle=CheckBox  HeadCheckShow="true" edit={IF(CLOSE_DT="", "true", "false")}</FC>'                     
                     + '<FC>id=SKU_CD          name="*단품코드"         width=110  align=center  EditStyle=Popup</FC>'
                     + '<FC>id=SKU_NAME        name="단품명"           width=140   align=left  edit=none</FC>' 
                     + '<FC>id=STR_CD          name="점코드"           width=50    align=center</FC>'
                     + '<FC>id=STK_YM          name="조사년월"         width=80    align=center</FC>'                                         
                     + '<FC>id=BUY_COST_PRC    name="원가"             width=60    align=right  edit=none </FC>'
                     + '<FC>id=BUY_SALE_PRC    name="단가"             width=80    align=right  edit=none  </FC>'
                     // MARIO OUTLET
                     //+ '<FG>                   name="장부재고" '
                     //+ '<FC>id=STK_QTY         name="수량"             width=50    align=right  edit=none</FC>'
                     //+ '<FC>id=STK_AMT         name="금액"             width=80    align=right  edit=none</FC>'
                     //+ '</FG> '
                     // MARIO OUTLET
                     + '<FG> name="실사재고" '
                     + '<FC>id=NORM_QTY        name="정상수량"         width=60    align=right   Edit=Numeric  </FC>'
                     + '<FC>id=NORM_AMT        name="정상금액"         width=80    align=right   edit=none   </FC>'
                     + '<FC>id=INFRR_QTY       name="불량수량"         width=60    align=right   Edit=Numeric  </FC>'
                     + '<FC>id=INFRR_AMT       name="불량금액"         width=80    align=right   edit=none   </FC>'
                     + '<FC>id=SRVY_QTY        name="합계수량"         width=60    align=right   edit=none show="false" </FC>'
                     + '<FC>id=SRVY_AMT        name="합계금액"         width=80    align=right   edit=none show="false" </FC>'
                     + '<FC>id=SRVY_COST_AMT   name="재고실사원가금액"  width=60    align=right  edit=none  show="false" </FC>'
                     + '<FC>id=SRVY_SALE_AMT   name="재고실사매가금액"  width=60    align=right  edit=none  show="false" </FC>'
                     + '</FG> '
                     + '<FC>id=SEQ_NO          name="순번"            width=45     align=right  edit=none  show="false" </FC>'
                     + '<FC>id=STYLE_CD        name="STYLE코드"        width=90    align=center  edit=none </FC>'
                     + '<FC>id=STYLE_NAME      name="STYLE명"          width=100    align=left  edit=none</FC>'
                     + '<FC>id=COLOR_CD        name="칼라명"           width=80    align=left  edit=none  EditStyle=Lookup    Data="DS_I_COLOR_CD:CODE:NAME"</FC>'
                     + '<FC>id=SIZE_CD         name="사이즈"           width=80    align=left  edit=none  EditStyle=Lookup    Data="DS_I_SIZE_CD:CODE:NAME"</FC>'
                     + '<FC>id=PUMBUN_CD       name="브랜드"             width=60    align=center  edit=none  </FC>'
                     + '<FC>id=PUMMOK_CD       name="품목"             width=80    align=center  edit=none  </FC>'
                     + '<FC>id=INPUT_PLU_CD    name="소스마킹코드"     width=100    align=left  edit=none  </FC>'
                     + '<FC>id=SALE_UNIT_CD    name="판매단위"         width=60    align=left  edit=none    EditStyle=Lookup    Data="DS_I_SALE_UNIT_CD:CODE:NAME"</FC>'
                     + '<FC>id=CMP_SPEC_UNIT   name="구성단위"         width=80    align=left  edit=none    EditStyle=Lookup    Data="DS_I_CMP_SPEC_UNIT:CODE:NAME"</FC>'
                     + '<FC>id=CLOSE_DT        name="마감일자"         width=100    align=left  edit=none  show="false"</FC>'
                     + '<FC>id=ERROR_CHECK     name="에러체크"         width=100    align=left  edit=none show="false"</FC>';
                      
    initGridStyle(GD_EXCEL, "common", hdrProperies, true);
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
 * 작 성 일 : 2010.04.04
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {	
	 
	 //저장되지 않은 내용이 있을경우 경고
	 if (DS_IO_MASTER.IsUpdated ) {
	     ret = showMessage(QUESTION , YESNO, "USER-1059");
	     if (ret != "1") {
	         return false;
	     } 
	 } 
	 
	if( LC_O_STR_CD.BindColVal == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus();
        return false;
    }else if( EM_O_STK_YM.Text == "" ){
    	showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "실사년월");            
    	EM_O_STK_YM.Focus();
        return false;
    }else if( EM_O_PUMBUN_CD.Text == "" ){
    	showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "브랜드");            
    	EM_O_PUMBUN_CD.Focus();
        return false;
    }	
	
    DS_IO_MASTER.ClearData();
  
    //헤더체크초기화
    GD_MASTER.ColumnProp('CHECK1','HeadCheck') = false;  
    
    strStrCd      = LC_O_STR_CD.BindColVal;    
    strStkYm      = EM_O_STK_YM.Text;
    strPumbunCd   = EM_O_PUMBUN_CD.Text;
    strStkDt      = EM_O_STK_DT.Text;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strStkDt="+encodeURIComponent(strStkDt)
                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd)
                    +"&strSkuType="+encodeURIComponent(strSkuType);   
    
    TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);     
    
    if (DS_IO_MASTER.CountRow > 0){        
        getcolumnSetting(strSkuType);    	
    } 
    
    //실사종료일에 따라 그리드 Edit설정
    gridEditable(); 
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	//저장되지 않은 내용이 있을경우 경고
     if (DS_IO_MASTER.IsUpdated ) {
         ret = showMessage(QUESTION , YESNO, "USER-1059");
         if (ret != "1") {
             return;
         } 
     }
	DS_IO_MASTER.ClearData();
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {	
	 var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
     var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT");
     if(srvyEDt < strToDay && srvyEDt != "") {
         showMessage(INFORMATION , OK, "GAUCE-1000" , "실사재고기간에만 삭제 가능합니다.");
         return; 
     } 
	 
    var delRow = 0;
    var delNewRow = 0;
    var noNewData = 0;
    var newInsData = '';
    for( var i=1; i<=DS_IO_MASTER.CountRow; i++){
        if( DS_IO_MASTER.NameValue(i,"CHECK1")=='T'){         	
        	DS_IO_MASTER.RowMark(i) = 1;          
        	if(DS_IO_MASTER.RowStatus(i)!='1')
        		noNewData++;
        	
            delRow++;
        }else{
            if(DS_IO_MASTER.RowStatus(i)=='1')
            	newInsData += DS_IO_MASTER.ExportData(i,1,true);
        	DS_IO_MASTER.RowMark(i) = 0;
        }
    }
    if( delRow < 1){
    	DS_IO_MASTER.ClearAllMark();
        showMessage(INFORMATION, OK, "USER-1019");
        if(DS_IO_MASTER.CountRow < 1)
            EM_O_PUMBUN_CD.Focus();
        else
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"CHECK1");
        
        return;
    }
    
    //선택한 항목을 삭제하겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1023") != 1 ){
        GD_MASTER.Focus();
        return;
    }
    
    DS_IO_MASTER.DeleteMarked();
    
    if(noNewData <1 )
    	return;
    
    TR_MAIN.Action="/dps/pstk220.pt?goTo=delete";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    btn_Search();
    
    if( newInsData != '')
    	DS_IO_MASTER.ImportData(newInsData);

    GD_MASTER.ColumnProp('CHECK1','HeadCheck') = false;
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {	 
	 if (!getSkuCdCheck()){
		 return;
	 }
	 
     var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
     var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT");
     if(srvyEDt < strToDay && srvyEDt != "") {
    	 showMessage(INFORMATION , OK, "GAUCE-1000" , "실사재고기간에만 저장/수정이 가능합니다.");
         return; 
     }
	 
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION , OK, "USER-1028"); 
        return;
    }   
    
    if(DS_IO_MASTER.NameValue(1, "CLOSE_DT") != ""){
    	showMessage(EXCLAMATION , Ok,  "USER-1068", "확정/", "");
    	return;
    }
        
    if( LC_O_STR_CD.BindColVal == "%" || LC_O_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "점");            
        LC_O_STR_CD.Focus;
        return false;
    }
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "SKU_CD") == "" ){
        showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "단품코드");            
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SKU_CD");
        return false;
    }
    if( DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "SKU_NAME") == "" ){
        showMessage(EXCLAMATION , Ok,  "USER-1036", "단품코드");            
        setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SKU_CD");
        return false;
    }  
    
    if( getCloseCheck('DS_CLOSECHECK','',strToday,'PSTK','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        LC_O_STR_CD.Focus();
        return;
    }

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION , YESNO, "USER-1010") != 1 )
        return;

    var strStrCd = DS_O_PBNSTK.NameValue(1, "STR_CD");
    var strStkYm = DS_O_PBNSTK.NameValue(1, "STK_YM");
    var strPumbunCd = DS_O_PBNINF.NameValue(1, "PUMBUN_CD");   
    
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strStkYm="+encodeURIComponent(strStkYm)
                    +"&strPumbunCd="+encodeURIComponent(strPumbunCd);    
    
    TR_MAIN.Action="/dps/pstk220.pt?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        btn_Search();        
    }else{
    	setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"SKU_CD");
    }
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	if(DS_IO_EXCEL.CountRow <= 0){
	     showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	       return;
   }
	
	var strTitle = "실사재고현황(단품)";
	var parameters = "점 " ;
		
	/*    
	var strStrCd        = LC_STR_CD.Text;      //점
	var strPosFloor     = LC_POS_FLOOR.Text;   //포스층
	var strPosFlag      = LC_POS_FLAG.Text;    //포스구분
	var strPosNoS       = numFormat(EM_POSNO_S.text,4);           //포스시작번호
	var strPosNoE       = numFormat(EM_POSNO_E.text,4);           //포스종료번호
	var strSaleDtS      = EM_SALE_DT_S.text;         //시작일자
	var strSaleDtE      = EM_SALE_DT_E.text;         //종료일자
	var strDealNo       = EM_DEALNO.text;         //거래번호
	
	var strSkuCd			= EM_SKU_NAME.Text;
	var strPumbunCd			= EM_PUMBUN_NAME.Text;
	var strFromSaleAmt		= EM_SALE_AMT_S.Text;
	var strToSaleAmt		= EM_SALE_AMT_E.Text;
	var strFromSaleTime		= EM_SALE_TIME_S.Text;
	var strToSaleTime		= EM_SALE_TIME_E.Text;  
	var strSearchCnt		= DS_IO_EXCEL.CountRow;
	var strCreditCardNo		= EM_CREDIT_CARDNO.Text;  

	var parameters = "점 "             + strStrCd
	               + " ,   POS층 "     + strPosFloor
	               + " ,   POS구분 "   + strPosFlag
	               + " ,   매출기간 "  + strSaleDtS + " ~ " +  strSaleDtE
	               + " ,   매출시간 "  + strFromSaleTime + " ~ " +  strToSaleTime
	               + " ,   판매금액 "  + strFromSaleAmt + " ~ " +  strToSaleAmt
	               + " ,   브랜드명 "  + strPumbunCd
	               + " ,   단품명 "  + strSkuCd
	               + " ,   POS번호 "  + strPosNoS + " ~ " +  strPosNoE
	               + " ,   거래번호 "  + strDealNo
	               + " ,   카드번호 "  + strCreditCardNo;
	               + " ,   조회건수 "  + strSearchCnt;
	
	*/
	GD_EXCEL.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	openExcel2(GD_EXCEL, strTitle, parameters, true );
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.04.04
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * btn_Add1()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-02-10
  * 개    요 : 그리드 Row추가 
  * return값 : void
 */
 function btn_Add1(){   
	  
	if (!srvyDtValidation())
        return;
    
    if (!getCloseDt())
        return;
    
    if( EM_O_STK_YM.Text == "" ){
           showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "실사년월");            
           EM_O_STK_YM.Focus();
           return false;
    }
    if( EM_O_PUMBUN_CD.Text == "" ){
       showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "브랜드코드");            
       EM_O_PUMBUN_CD.Focus();
       return false;
   }else if( EM_O_PUMBUN_NAME.Text == "" ){
       showMessage(EXCLAMATION , Ok,  "USER-1036", "브랜드코드");            
       EM_O_PUMBUN_NAME.Focus();
       return false;
   }
   DS_IO_MASTER.Addrow();
   setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.CountRow,"SKU_CD");
   GD_MASTER.ColumnProp('CHECK1','HeadCheck') = false; 
 }

 /**
  * btn_Del1()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-02-10
  * 개    요 : 그리드 Row 삭제 
  * return값 : void
 */
 function btn_Del1(){
    var row = DS_IO_MASTER.RowPosition;
    if( DS_IO_MASTER.RowStatus(row) == "1")
        DS_IO_MASTER.DeleteRow(row);
    else
        showMessage(INFORMATION, OK, "USER-1052");
    
    GD_MASTER.Focus();
 }
 
 
/**
  * setPumbunCdCombo()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.03.18
  * 개    요 : 브랜드POPUP를 조회한다.
  * return값 : void
  */
 function setPumbunCdSkuType(evnflag){
     var codeObj = EM_O_PUMBUN_CD;
     var nameObj = EM_O_PUMBUN_NAME;
     
     if(DS_IO_MASTER.CountRow > 0){
         DS_IO_MASTER.ClearData();
     }
     
     if(codeObj.Text == "" && evnflag != "POP" ){
    	 EM_O_COST_CAL_WAY.Text = "";
    	 EM_O_ORG_NAME.Text = "";
    	 nameObj.Text = "";
    	 return;
     }         

     var result = null;

     if( evnflag == "POP" ){
         result = strPbnPop(codeObj,nameObj,'Y','','', '','','','','','1','','','','','');
          
     }else if( evnflag == "NAME" ){
         setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj , nameObj ,"Y",1 ,'','', '','','','','','1','','','','','');
         getPbnInf();
         strSkuType = DS_SEARCH_NM.NameValue(1, "SKU_TYPE");
         getcolumnSetting(strSkuType); 
         gridEditable();
     }

     if( result != null ){         
    	 getPbnInf();
    	 strSkuType = result.get("SKU_TYPE");  
    	 getcolumnSetting(strSkuType);
    	 gridEditable();
     }
      
     //EM_O_PUMBUN_CD.Focus();
 } 
 
 /**
  * srvyDtValidation()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-14
  * 개    요 : 실사년월기간내 등록가능 여부를체크한다.
  * return값 : void
 **/
 function srvyDtValidation(){
	  
	  getPbnStk();	  
	  var srvySDt  = DS_O_PBNSTK.NameValue(1, "SRVY_S_DT");
	  var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
	  var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT");
	  var stkDt    = EM_O_STK_DT.Text;
	  
	  // 당일이 실사입력기간 이내인 경우
	  if (srvySDt <= strToDay && srvyEDt >= strToDay){		
		  // 신선인 경우
		  if(strSkuType == "2"){
			  GD_MASTER.ColumnProp('NORM_AMT',  'edit')  = "true";
	          GD_MASTER.ColumnProp('INFRR_AMT', 'edit')  = "true";
	          GD_MASTER.ColumnProp('NORM_QTY',  'edit')  = "true";
	          GD_MASTER.ColumnProp('INFRR_QTY', 'edit')  = "true";
	      // 규격, 의류인 경우
		  }else{
			  GD_MASTER.ColumnProp('NORM_AMT',  'edit')  = "none";
              GD_MASTER.ColumnProp('INFRR_AMT', 'edit')  = "none";
              GD_MASTER.ColumnProp('NORM_QTY',  'edit')  = "true";
              GD_MASTER.ColumnProp('INFRR_QTY', 'edit')  = "true";
		  }
		  //GD_MASTER.ColumnProp('SKU_CD','edit')= "true";
		  return true;		  
	  }else{
		  showMessage(EXCLAMATION , Ok,  "USER-1093");
		  GD_MASTER.ColumnProp('SKU_CD',    'edit') = "none";
          GD_MASTER.ColumnProp('NORM_QTY',  'edit') = "none";
          GD_MASTER.ColumnProp('INFRR_QTY', 'edit') = "none";
          GD_MASTER.ColumnProp('NORM_AMT',  'edit') = "none";
          GD_MASTER.ColumnProp('INFRR_AMT', 'edit') = "none";
		  //DS_IO_MASTER.ClearData();
          return false;		
	  }  
  }
 
 /**
  * gridEditable()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-14
  * 개    요 : 실사종료일자에 따라 그리드 Edit 설정을 한다.
  * return값 : void
 **/
 function gridEditable(){	  
	  getPbnStk();
	 
	 var srvyEDt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
	 var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT");
	 
	 var strCloseDt = DS_O_PBNSTK.NameValue(1, "CLOSE_DT");
	 	 
	 var strCloseState = EM_O_STATE.Text;	 
	 	 
	 if(srvyEDt < strToDay || strCloseState == "마감" || strCloseDt != ""){
	     GD_MASTER.Editable = "false";       
	     GD_MASTER.ColumnProp('CHECK1','edit')= "false";
	     enableControl(Excel_Up_Load, false);
	 }else{
	     GD_MASTER.Editable = "true"; 
	     GD_MASTER.ColumnProp('CHECK1','edit')= "true";
	     enableControl(Excel_Up_Load, true);
	 }
  }
 
 /**
  * getPbnStk()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 브랜드에 따른 재고실사 조회
  * return값 : void
  */
 function getPbnStk() {
	  var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;           
      var strStkYm       = EM_O_STK_YM.Text;              
      
      var goTo       = "searchPbnStk" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strStkYm="+encodeURIComponent(strStkYm)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
      
      TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBNSTK=DS_O_PBNSTK)"; //조회는 O
      TR_MAIN.Post();     
      
      EM_O_STK_DT.Text = DS_O_PBNSTK.NameValue(1, "SRVY_DT");
      EM_O_STK_FLAG.Text = DS_O_PBNSTK.NameValue(1, "STK_FLAG_NAME"); 
      EM_O_STATE.Text = DS_O_PBNSTK.NameValue(1, "CLOSE_FLAG");
      
     //return DS_O_MARGIN.NameValue(1, "LOW_MG_RATE");
 }
 
 /**
  * getPbnInf()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 브랜드정보(조직/재고평가구분) 조회
  * return값 : void
  */
 function getPbnInf() {
      var strStrCd       = LC_O_STR_CD.BindColVal;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;       
      
      var goTo       = "searchPbnInf" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
      
      TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PBNINF=DS_O_PBNINF)"; //조회는 O
      TR_MAIN.Post();     
      
      if (DS_O_PBNINF.CountRow > 0) {
	      EM_O_ORG_NAME.Text = DS_O_PBNINF.NameValue(1, "ORG_NAME");
	      EM_O_COST_CAL_WAY.Text = DS_O_PBNINF.NameValue(1, "COST_CAL_NAME");
	      if (DS_O_PBNINF.NameValue(1, "BIZ_TYPE") != '1' && DS_O_PBNINF.NameValue(1, "BIZ_TYPE") != '2') {
			showMessage(EXCLAMATION, OK, "USER-2003"); 
	    	EM_O_PUMBUN_CD.Text = "";
	    	EM_O_PUMBUN_NM.Text = "";
			EM_O_PUMBUN_CD.Focus();
	      }
      } else {
          EM_O_ORG_NAME.Text     = "";
          EM_O_COST_CAL_WAY.Text = "";    
      }
      
     
 }
 
  function getskuPop(row, colid, flag){
	  var strStrCd = LC_O_STR_CD.BindColVal;
	  var strPumbunCd = EM_O_PUMBUN_CD.Text;	  
	  var strSkuCd = DS_IO_MASTER.NameValue(row, "SKU_CD");
	  
      var rtnList = strSkuMultiSelPop(strSkuCd, "", "Y"
                , '', strStrCd, strPumbunCd);	  
	 
    if(rtnList != null){
    	
        for(var i = 0; i < rtnList.length; i++){
            if(i == 0 )
               intRow = row;
            else
            	DS_IO_MASTER.InsertRow(row+i);            

            DS_IO_MASTER.NameValue(row+i, "SKU_CD")        = rtnList[i].SKU_CD;
            DS_IO_MASTER.NameValue(row+i, "SKU_NAME")      = rtnList[i].SKU_NAME;
            DS_IO_MASTER.NameValue(row+i, "SALE_UNIT_CD")  = rtnList[i].SALE_UNIT_CD;
            DS_IO_MASTER.NameValue(row+i, "CMP_SPEC_UNIT") = rtnList[i].CMP_SPEC_UNIT;
            DS_IO_MASTER.NameValue(row+i, "STYLE_CD")      = rtnList[i].STYLE_CD;
            DS_IO_MASTER.NameValue(row+i, "COLOR_CD")      = rtnList[i].COLOR_CD;
            DS_IO_MASTER.NameValue(row+i, "SIZE_CD")       = rtnList[i].SIZE_CD;
            DS_IO_MASTER.NameValue(row+i, "PUMMOK_CD")     = rtnList[i].PUMMOK_CD;
            var strSkuCd = DS_IO_MASTER.NameValue(row+i, "SKU_CD");
            
            getSkuCd(strSkuCd, row, i);
        }
        
        if(strSkuType == "3"){
        	GD_MASTER.redraw = false;
            DS_IO_MASTER.Sortexpr = "+STYLE_CD+COLOR_CD+SIZE_CD";
            DS_IO_MASTER.Sort();
            
            GD_MASTER.redraw = true;
            setFocusGrid(GD_MASTER,DS_IO_MASTER,1,"NORM_QTY");
        }else{
            setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"NORM_QTY");
        }
        
    }else 
    	setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"SKU_CD");
    
    
    //getSkuInfo();
}
 /**
  * getSkuCd()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 단품코드 조회
  * return값 : void
  */
 function getSkuCd(strSkuCd, row , i) {
      var strStrCd       = LC_O_STR_CD.BindColVal;              
      var strStkYm       = EM_O_STK_YM.Text; 
      var strStkDt       = EM_O_STK_DT.Text;      
      
      var goTo       = "searchSkuCd" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strStkYm="+encodeURIComponent(strStkYm)
                      +"&strStkDt="+encodeURIComponent(strStkDt)
                      +"&strSkuCd="+encodeURIComponent(strSkuCd);
      
      TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SKUCD=DS_IO_SKUCD)"; //조회는 O
      TR_MAIN.Post();
      if (DS_IO_SKUCD.CountRow > 0){
    	  DS_IO_MASTER.NameValue(row+i, "INPUT_PLU_CD") = DS_IO_SKUCD.NameValue(1, "INPUT_PLU_CD");
    	  DS_IO_MASTER.NameValue(row+i, "BUY_SALE_PRC") = DS_IO_SKUCD.NameValue(1, "BUY_SALE_PRC");
    	  DS_IO_MASTER.NameValue(row+i, "BUY_COST_PRC") = DS_IO_SKUCD.NameValue(1, "BUY_COST_PRC");
    	  DS_IO_MASTER.NameValue(row+i, "RATE")         = DS_IO_SKUCD.NameValue(1, "RATE");
    	  DS_IO_MASTER.NameValue(row+i, "TAX_FLAG")     = DS_IO_SKUCD.NameValue(1, "TAX_FLAG");
    	  DS_IO_MASTER.NameValue(row+i, "TAX_FLAG")     = DS_IO_SKUCD.NameValue(1, "MODEL_NO");
    	  // MARIO OUTLET
    	  //DS_IO_MASTER.NameValue(row+i, "STK_QTY") = DS_IO_SKUCD.NameValue(1, "STK_QTY");
    	  //DS_IO_MASTER.NameValue(row+i, "STK_AMT") = DS_IO_SKUCD.NameValue(1, "STK_AMT");
    	  // MARIO OUTLET
      }
 }
 
 /**
  * getSkuCdCheck()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 단품코드유효성 체크
  * return값 : void
  */
 function getSkuCdCheck() {
      //var strStrCd       = LC_O_STR_CD.BindColVal;              
      //var strStkYm       = EM_O_STK_YM.Text; 
      //var strStkDt       = EM_O_STK_DT.Text; 
     
	 for(var i=1; i <= DS_IO_MASTER.CountRow; i++){    
         var strStrCd = DS_IO_MASTER.NameValue(i, "STR_CD");
         var strSkuCd    = DS_IO_MASTER.NameValue(i, "SKU_CD");
         if (strStrCd == "")
             strStrCd       = LC_O_STR_CD.BindColVal;
         var strStkDt       = EM_O_STK_DT.Text; 
         
         var goTo       = "searchSkuCheck" ;    
         var action     = "O";    
         var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                        + "&strSkuCd="           +encodeURIComponent(strSkuCd)
                        + "&strStkDt="           +encodeURIComponent(strStkDt)
                        ;
         
         TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
         TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_SKUCHECK=DS_IO_SKUCHECK)"; //조회는 O
         TR_MAIN.Post();
         
         if (DS_IO_SKUCHECK.NameValue(1 , "CNT") == 0){
             showMessage(INFORMATION, OK, "USER-1036", "단품 코드");          
             return false;
         }
     }
     return true;
 }
 
 /**
  * getCloseDt()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 단품코드 조회
  * return값 : void
  */
 function getCloseDt() {
      var strStrCd       = LC_O_STR_CD.BindColVal;              
      var strStkYm       = EM_O_STK_YM.Text; 
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;     
      
      var goTo       = "searchCloseDt" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strStkYm="+encodeURIComponent(strStkYm)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
     
      TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CLOSE=DS_IO_CLOSE)"; //조회는 O
      TR_MAIN.Post();
      
      if (DS_IO_CLOSE.NameValue(1, "CNT") > 0 ){
          showMessage(EXCLAMATION , Ok,  "USER-1068", "확정/", ""); 
          //확정/마감 된 브랜드일 경우 그리드 에디트 사용불가
          GD_MASTER.Editable = "false";
          return false;
      }else{
    	//확정/마감 된 브랜드일 경우 그리드 에디트 사용가능
    	  GD_MASTER.Editable = "true";
    	  return true;
      } 
      return true ;
 }
 
 /**
  * getcolumnSetting()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개     요 : 단품구분에 따라 컬럼 셋팅
  * return값 : void
  */
 function getcolumnSetting(skuType) {	  
	  //DS_IO_MASTER.ClearData();
	  
	  //var srvy_Dt  = DS_O_PBNSTK.NameValue(1, "SRVY_E_DT");
	  //var close_Dt = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition , "CLOSE_DT");
	  
	  //var strCloseState = EM_O_STATE.Text;
	  
	  var strToDay = DS_O_PBNSTK.NameValue(1, "TODAY_DT");
	  
	  
	  // 규격상품인 경우
	  if (skuType == "1"){
		  GD_MASTER.ColumnProp('STYLE_NAME','show')    = "FALSE";
		  GD_MASTER.ColumnProp('COLOR_CD','show')      = "FALSE";
		  GD_MASTER.ColumnProp('SIZE_CD','show')       = "FALSE";
		  GD_MASTER.ColumnProp('INPUT_PLU_CD','show')  = "TRUE";
          GD_MASTER.ColumnProp('SALE_UNIT_CD','show')  = "TRUE";
          GD_MASTER.ColumnProp('CMP_SPEC_UNIT','show') = "TRUE";
          GD_MASTER.ColumnProp('SKU_CD','edit') = "none";

          GD_MASTER.ColumnProp('NORM_AMT','edit')      = "none";
          GD_MASTER.ColumnProp('INFRR_AMT','edit')     = "none";
          GD_MASTER.ColumnProp('NORM_QTY','edit')      = "TRUE";
          GD_MASTER.ColumnProp('INFRR_QTY','edit')     = "TRUE";          
          
      // 신선상품인 경우
	  }else if (skuType == "2"){
		  GD_MASTER.ColumnProp('STYLE_NAME','show')    = "FALSE";
          GD_MASTER.ColumnProp('COLOR_CD','show')      = "FALSE";
          GD_MASTER.ColumnProp('SIZE_CD','show')       = "FALSE";
          GD_MASTER.ColumnProp('INPUT_PLU_CD','show')  = "FALSE";
          GD_MASTER.ColumnProp('SALE_UNIT_CD','show')  = "TRUE";
          GD_MASTER.ColumnProp('CMP_SPEC_UNIT','show') = "FALSE";
         
          GD_MASTER.ColumnProp('NORM_QTY','edit')      = "TRUE";
          GD_MASTER.ColumnProp('INFRR_QTY','edit')     = "TRUE";
          GD_MASTER.ColumnProp('NORM_AMT','edit')      = "TRUE";
          GD_MASTER.ColumnProp('INFRR_AMT','edit')     = "TRUE";
      // 의류상품인 경우
	  }else if (skuType == "3"){ 
		  GD_MASTER.ColumnProp('STYLE_NAME','show')    = "TRUE";
          GD_MASTER.ColumnProp('COLOR_CD','show')      = "TRUE";
          GD_MASTER.ColumnProp('SIZE_CD','show')       = "TRUE";
          GD_MASTER.ColumnProp('INPUT_PLU_CD','show')  = "FALSE";
          GD_MASTER.ColumnProp('SALE_UNIT_CD','show')  = "FALSE";
          GD_MASTER.ColumnProp('CMP_SPEC_UNIT','show') = "FALSE";          
          
          GD_MASTER.ColumnProp('NORM_AMT','edit')      = "none";
          GD_MASTER.ColumnProp('INFRR_AMT','edit')     = "none";
          GD_MASTER.ColumnProp('NORM_QTY','edit')      = "TRUE";
          GD_MASTER.ColumnProp('INFRR_QTY','edit')     = "TRUE";
          
	  }	  
 }
 
 /**
  * getExcelUpLoadPop()
  * 작 성 자 : 김경은
  * 작 성 일 : 2010-02-23 
  * 개    요 : 의류단품 엑셀 업로드  팝업
  * 사용방법 : getExcelUpLoadPop()
  * return값 : array
  */
  function getExcelUpLoadPop(){
	  if( EM_O_PUMBUN_CD.Text == "" ){
	       showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "브랜드");            
	       EM_O_PUMBUN_CD.Focus();
	       return false;
	    }
	    
	    if (!srvyDtValidation())
	        return;
	    
	    if (!getCloseDt())
	        return;
      
      
      var rtnMap  = new Map();
      var arrArg  = new Array();
      
      arrArg.push(rtnMap);
      arrArg.push(LC_O_STR_CD.BindColVal);      // 점
      arrArg.push(EM_O_PUMBUN_CD.Text);      // 브랜드
      arrArg.push(EM_O_STK_YM.Text);     // 실사년월
      arrArg.push(strSkuType);     // 단품유형
      arrArg.push(EM_O_STK_DT.Text);     // 재고조사일
      
      
           
      DS_O_SKU.ClearData();
      //DS_IO_DETAIL.ClearData();
      
   // 필수 입력 내용 체크
      //if(checkValidation("Save")){
      var returnVal = window.showModalDialog("/dps/pstk220.pt?goTo=popUpList",
                                             arrArg,
                                             "dialogWidth:900px;dialogHeight:378px;scroll:no;" +
                                             "resizable:no;help:no;unadorned:yes;center:yes;status:no");          
      if(returnVal != ""){
          DS_O_SKU.ImportData(returnVal);
          
          
          for(var i = 1; i<= DS_O_SKU.CountRow; i++){
        	  
              if(DS_O_SKU.NameValue(i, "CHECK1") == "T"){
                  DS_IO_MASTER.AddRow();
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_CD")        = DS_O_SKU.NameValue(i, "SKU_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD")        = DS_O_SKU.NameValue(i, "STR_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SKU_NAME")        = DS_O_SKU.NameValue(i, "SKU_NAME");         // 단품코드
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STK_YM")        = DS_O_SKU.NameValue(i, "STK_YM");
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "MODEL_NO")        = DS_O_SKU.NameValue(i, "MODEL_NO");
                  
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NORM_QTY")      = DS_O_SKU.NameValue(i, "NORM_QTY"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "NORM_AMT")      = DS_O_SKU.NameValue(i, "NORM_AMT"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "INFRR_QTY")     = DS_O_SKU.NameValue(i, "INFRR_QTY"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "INFRR_AMT")     = DS_O_SKU.NameValue(i, "INFRR_AMT"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_QTY")      = DS_O_SKU.NameValue(i, "NORM_QTY")+DS_O_SKU.NameValue(i, "INFRR_QTY");
                  
                  
                  if (strSkuType == "1" || strSkuType == "3") {
                	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUY_COST_PRC")  = DS_O_SKU.NameValue(i, "BUY_COST_PRC"); 
                      //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUY_SALE_PRC")  = DS_O_SKU.NameValue(i, "BUY_SALE_PRC"); 
                      //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_AMT")		= DS_O_SKU.NameValue(i, "BUY_SALE_PRC")*(DS_O_SKU.NameValue(i, "NORM_QTY")+DS_O_SKU.NameValue(i, "INFRR_QTY"));
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_AMT")		= DS_O_SKU.NameValue(i, "BUY_COST_PRC")*(DS_O_SKU.NameValue(i, "NORM_QTY")+DS_O_SKU.NameValue(i, "INFRR_QTY"));
                      //DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_SALE_AMT") = DS_O_SKU.NameValue(i, "BUY_SALE_PRC")*(DS_O_SKU.NameValue(i, "NORM_QTY")+DS_O_SKU.NameValue(i, "INFRR_QTY"));
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_COST_AMT") = DS_O_SKU.NameValue(i, "BUY_COST_PRC")*(DS_O_SKU.NameValue(i, "NORM_QTY")+DS_O_SKU.NameValue(i, "INFRR_QTY"));
                     
                  } else if(strSkuType == "2") {
                	  
                	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_AMT")		= DS_O_SKU.NameValue(i, "NORM_AMT")+DS_O_SKU.NameValue(i, "INFRR_AMT");
                	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_SALE_AMT")		= DS_O_SKU.NameValue(i, "NORM_AMT")+DS_O_SKU.NameValue(i, "INFRR_AMT");
                	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_COST_AMT") = getCalcPord("COST_PRC", "", DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_AMT"), DS_O_SKU.NameValue(i, "RATE"), DS_O_SKU.NameValue(i, "TAX_FLAG"), "1");   // 원가금액  (반올림)
                	  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUY_COST_PRC")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_COST_AMT")/DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_QTY");
                      DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "BUY_SALE_PRC")  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_AMT")/DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SRVY_QTY"); 
                  }
				 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STYLE_CD")      = DS_O_SKU.NameValue(i, "STYLE_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STYLE_NAME")    = DS_O_SKU.NameValue(i, "STYLE_NAME"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "COLOR_CD")      = DS_O_SKU.NameValue(i, "COLOR_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SIZE_CD")       = DS_O_SKU.NameValue(i, "SIZE_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD")     = DS_O_SKU.NameValue(i, "PUMBUN_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMMOK_CD")     = DS_O_SKU.NameValue(i, "PUMMOK_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "INPUT_PLU_CD")  = DS_O_SKU.NameValue(i, "INPUT_PLU_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SALE_UNIT_CD")  = DS_O_SKU.NameValue(i, "SALE_UNIT_CD"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CMP_SPEC_UNIT") = DS_O_SKU.NameValue(i, "CMP_SPEC_UNIT"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "CLOSE_DT")      = DS_O_SKU.NameValue(i, "CLOSE_DT"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ERROR_CHECK")   = DS_O_SKU.NameValue(i, "ERROR_CHECK"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "RATE")          = DS_O_SKU.NameValue(i, "RATE"); 
                  DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TAX_FLAG")      = DS_O_SKU.NameValue(i, "TAX_FLAG"); 
                  
              }
          }
      }
  }

 /**
  * ExcelDownData()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010.04.25
  * 개     요 : 엑셀다운
  * return값 :
  */
  function ExcelDownData() {
	  if( EM_O_PUMBUN_CD.Text == "" ){
	       showMessage(EXCLAMATION , Ok,  "GAUCE-1005", "브랜드");            
	       EM_O_PUMBUN_CD.Focus();
	       return false;
	    }
	  
	  var strStrCd       = LC_O_STR_CD.BindColVal;
      var strStkDt       = EM_O_STK_DT.Text;
      var strPumbunCd    = EM_O_PUMBUN_CD.Text;
      
      //var strStkYm = EM_O_STK_YM.Text.substring(0, 4);
      var strStkYm = EM_O_STK_YM.Text;
      
      var goTo       = "searchMasterExcel" ;    
      var action     = "O";     
      var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                      +"&strStkYm="+encodeURIComponent(strStkYm)
                      +"&strStkDt="+encodeURIComponent(strStkDt)
                      +"&strPumbunCd="+encodeURIComponent(strPumbunCd);
      
      TR_MAIN.Action="/dps/pstk220.pt?goTo="+goTo+parameters;  
      TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_EXCEL=DS_IO_EXCEL)"; //조회는 O
      TR_MAIN.Post();
            
      //if(DS_IO_EXCEL.CountRow <= 0){
      //  showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
      //    return;
      //}
      
      var strTitle = "실사재고등록(단품)";

      var parameters = "";
      
      openExcel4(GD_EXCEL, strTitle, parameters, true );      
  }
 
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
<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
   style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
   <param name="Text" value='FileOpen'>
   <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER
	event=OnDataError(row,colid)>
var colName = GD_MASTER.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(STOPSIGN, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(STOPSIGN, OK, "GAUCE-1007", row);
} else {
    showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 적용기준일 -->
<script language=JavaScript for=EM_O_STK_YM event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;
    gridEditable();
</script>
<script language=JavaScript for=GD_MASTER
	event=CanColumnPosChange(row,colid)>
    var strStrCd = LC_O_STR_CD.BindColVal;
    var strPumbunCd = EM_O_PUMBUN_CD.Text;
   
    var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
    var newValue = DS_IO_MASTER.NameValue(row,colid);
    var changeFlag = (orgValue != newValue || DS_IO_MASTER.RowStatus(row) == 1) ;
    
    switch (colid) {
        case "SKU_CD" :               
            if( changeFlag ){
            	
                eval(this.DataID).NameValue(row,"SKU_NAME") = "";
                if(newValue == ''){
                    return ;
                }
                var popupData = setStrSkuNmWithoutToGridPop("DS_SEARCH_SKU",newValue,'','Y','1', '', strStrCd, strPumbunCd);
                if(popupData != null){
                    eval(this.DataID).NameValue(row,"SKU_CD") = popupData.get("SKU_CD");
                    eval(this.DataID).NameValue(row,"SKU_NAME") = popupData.get("SKU_NAME");
                    eval(this.DataID).NameValue(row,"SALE_UNIT_CD") = popupData.get("SALE_UNIT_CD");
                    eval(this.DataID).NameValue(row,"CMP_SPEC_UNIT") = popupData.get("CMP_SPEC_UNIT");
                    eval(this.DataID).NameValue(row,"STYLE_CD") = popupData.get("STYLE_CD");
                    eval(this.DataID).NameValue(row,"COLOR_CD") = popupData.get("COLOR_CD");
                    eval(this.DataID).NameValue(row,"SIZE_CD") = popupData.get("SIZE_CD");
                    eval(this.DataID).NameValue(row,"PUMMOK_CD") = popupData.get("PUMMOK_CD");                    
                    var strSkuCd = DS_IO_MASTER.NameValue(row, "SKU_CD");
                    
                    getSkuCd(strSkuCd, row, i);
                }else {
                	eval(this.DataID).NameValue(row,"SKU_CD") = "";
                    eval(this.DataID).NameValue(row,"SKU_NAME") = "";
                    eval(this.DataID).NameValue(row,"SALE_UNIT_CD") = "";
                    eval(this.DataID).NameValue(row,"CMP_SPEC_UNIT") = "";
                    eval(this.DataID).NameValue(row,"STYLE_CD") = "";
                    eval(this.DataID).NameValue(row,"COLOR_CD") = "";
                    eval(this.DataID).NameValue(row,"SIZE_CD") ="";
                    setTimeout('setFocusGrid(GD_MASTER,DS_IO_MASTER,'+row+',"SKU_CD");',50);
                }
        }
        break;        
    }   
    
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,oldData)>
    switch (colid) {
    case "NORM_QTY" :
        var buyCostPrc = DS_IO_MASTER.NameValue(row, "BUY_COST_PRC");
        var buySalePrc = DS_IO_MASTER.NameValue(row, "BUY_SALE_PRC");
        var normQty = DS_IO_MASTER.NameValue(row, "NORM_QTY");
        var infrrQty = DS_IO_MASTER.NameValue(row, "INFRR_QTY");

        
        if (normQty < 0){
            showMessage(EXCLAMATION , Ok,  "USER-1008", "정상수량", "0");
            DS_IO_MASTER.NameValue( row, "NORM_QTY")= "";
            setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"NORM_QTY");
            return;
        }
        if (normQty == 0) DS_IO_MASTER.NameValue( row, "NORM_AMT")= "";
        
        // 규격 or 의류 단품인 경우
        if (strSkuType == "1" || strSkuType == "3") {
            //DS_IO_MASTER.NameValue(row, "NORM_AMT") = buySalePrc*normQty;        
            DS_IO_MASTER.NameValue(row, "NORM_AMT") = buyCostPrc*normQty;
            DS_IO_MASTER.NameValue(row, "SRVY_QTY") = normQty+infrrQty; 
            var srvyQty = DS_IO_MASTER.NameValue(row, "SRVY_QTY");
            
            
            DS_IO_MASTER.NameValue(row, "SRVY_AMT")      = buyCostPrc*srvyQty;
            //DS_IO_MASTER.NameValue(row, "SRVY_AMT")      = buySalePrc*srvyQty;
            //DS_IO_MASTER.NameValue(row, "SRVY_SALE_AMT") = buySalePrc*srvyQty;
            DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT") = buyCostPrc*srvyQty;
            
        // 신선 단품인 경우 
        } else if (strSkuType == "2") {
        	// 합계수량 = 정상수량 + 불량수량
        	DS_IO_MASTER.NameValue(row, "SRVY_QTY") = normQty+infrrQty;  
        	var srvyQty = DS_IO_MASTER.NameValue(row, "SRVY_QTY");

        	// 합계금액 =  정상금액 + 불량금액
        	DS_IO_MASTER.NameValue(row, "SRVY_SALE_AMT") = DS_IO_MASTER.NameValue(row, "NORM_AMT") + DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        	DS_IO_MASTER.NameValue(row, "SRVY_AMT")      = DS_IO_MASTER.NameValue(row, "NORM_AMT") + DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        	
        	var rate     = DS_IO_MASTER.NameValue(row, "RATE");
        	var sale_amt = DS_IO_MASTER.NameValue(row, "SRVY_AMT");
        	var strTaxFlag = DS_IO_MASTER.NameValue(row, "TAX_FLAG");
        	
        	// 원가금액 계산
        	DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT") = getCalcPord("COST_PRC", "", sale_amt, rate, strTaxFlag, "1");   // 원가금액  (반올림)
        	var cost_amt = DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT");
        	
        	// 매가단가, 원가단가 계산
        	DS_IO_MASTER.NameValue(row, "BUY_SALE_PRC")  = sale_amt / srvyQty; 
        	DS_IO_MASTER.NameValue(row, "BUY_COST_PRC")  = cost_amt / srvyQty; 
        }
    break;

    case "INFRR_QTY" :
        var buyCostPrc = DS_IO_MASTER.NameValue(row, "BUY_COST_PRC");
        var buySalePrc = DS_IO_MASTER.NameValue(row, "BUY_SALE_PRC");
        var normQty = DS_IO_MASTER.NameValue(row, "NORM_QTY");
        var infrrQty = DS_IO_MASTER.NameValue(row, "INFRR_QTY");
        
        if (infrrQty < 0){
            showMessage(EXCLAMATION , Ok,  "USER-1008", "불량수량", "0");
            DS_IO_MASTER.NameValue( row, "INFRR_QTY")= "";
            setFocusGrid(GD_MASTER,DS_IO_MASTER,row,"INFRR_QTY");
            return;
        }
        if (infrrQty == 0) DS_IO_MASTER.NameValue( row, "INFRR_AMT")= "";
        
        // 규격 or 의류 단품인 경우
        if (strSkuType == "1" || strSkuType == "3") {
	        //DS_IO_MASTER.NameValue(row, "INFRR_AMT") = buySalePrc*infrrQty;
	        DS_IO_MASTER.NameValue(row, "INFRR_AMT") = buyCostPrc*infrrQty;
    	    DS_IO_MASTER.NameValue(row, "SRVY_QTY") = normQty+infrrQty; 
    	    var srvyQty = DS_IO_MASTER.NameValue(row, "SRVY_QTY");
    	    
            DS_IO_MASTER.NameValue(row, "SRVY_AMT")      = buyCostPrc*srvyQty;
            //DS_IO_MASTER.NameValue(row, "SRVY_AMT")      = buySalePrc*srvyQty;
            DS_IO_MASTER.NameValue(row, "SRVY_SALE_AMT") = buySalePrc*srvyQty;
            DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT") = buyCostPrc*srvyQty;  
            // 신선 단품인 경우 
        } else if (strSkuType == "2") {
        	// 합계수량 = 정상수량 + 불량수량
        	DS_IO_MASTER.NameValue(row, "SRVY_QTY") = normQty+infrrQty;
        	var srvyQty = DS_IO_MASTER.NameValue(row, "SRVY_QTY");

        	// 합계금액 =  정상금액 + 불량금액
        	DS_IO_MASTER.NameValue(row, "SRVY_SALE_AMT") = DS_IO_MASTER.NameValue(row, "NORM_AMT") + DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        	DS_IO_MASTER.NameValue(row, "SRVY_AMT")      = DS_IO_MASTER.NameValue(row, "NORM_AMT") + DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        	
        	var rate     = DS_IO_MASTER.NameValue(row, "RATE");
        	var sale_amt = DS_IO_MASTER.NameValue(row, "SRVY_AMT");
        	var strTaxFlag = DS_IO_MASTER.NameValue(row, "TAX_FLAG");

        	// 원가금액 계산
        	DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT") = getCalcPord("COST_PRC", "", sale_amt, rate, strTaxFlag, "1");   // 원가금액  (반올림)
        	var cost_amt = DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT");
        	
        	// 매가단가, 원가단가 계산
        	DS_IO_MASTER.NameValue(row, "BUY_SALE_PRC")  = sale_amt / srvyQty; 
        	DS_IO_MASTER.NameValue(row, "BUY_COST_PRC")  = cost_amt / srvyQty; 
        }
    break;

    case "NORM_AMT" :
    	var normAmt = DS_IO_MASTER.NameValue(row, "NORM_AMT");
    	var infrrAmt = DS_IO_MASTER.NameValue(row, "INFRR_AMT");
    	DS_IO_MASTER.NameValue(row, "SRVY_AMT") = normAmt+infrrAmt;
    	
    	if (strSkuType == "2") {
        	var srvyQty = DS_IO_MASTER.NameValue(row, "SRVY_QTY");

        	// 합계금액 =  정상금액 + 불량금액
        	DS_IO_MASTER.NameValue(row, "SRVY_SALE_AMT") = DS_IO_MASTER.NameValue(row, "NORM_AMT") + DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        	DS_IO_MASTER.NameValue(row, "SRVY_AMT")      = DS_IO_MASTER.NameValue(row, "NORM_AMT") + DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        	
        	var rate     = DS_IO_MASTER.NameValue(row, "RATE");
        	var sale_amt = DS_IO_MASTER.NameValue(row, "SRVY_AMT");
        	var strTaxFlag = DS_IO_MASTER.NameValue(row, "TAX_FLAG");
        	
        	// 원가금액 계산
        	DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT") = getCalcPord("COST_PRC", "", sale_amt, rate, strTaxFlag, "1");   // 원가금액  (반올림)
        	var cost_amt = DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT");
        	
        	// 매가단가, 원가단가 계산
        	DS_IO_MASTER.NameValue(row, "BUY_SALE_PRC")  = sale_amt / srvyQty; 
        	DS_IO_MASTER.NameValue(row, "BUY_COST_PRC")  = cost_amt / srvyQty; 
    	}
    	break;
    	
    case "INFRR_AMT" :
    	var normAmt = DS_IO_MASTER.NameValue(row, "NORM_AMT");
        var infrrAmt = DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        DS_IO_MASTER.NameValue(row, "SRVY_AMT") = normAmt+infrrAmt;
        
    	if (strSkuType == "2") {
        	var srvyQty = DS_IO_MASTER.NameValue(row, "SRVY_QTY");

        	// 합계금액 =  정상금액 + 불량금액
        	DS_IO_MASTER.NameValue(row, "SRVY_SALE_AMT") = DS_IO_MASTER.NameValue(row, "NORM_AMT") + DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        	DS_IO_MASTER.NameValue(row, "SRVY_AMT")      = DS_IO_MASTER.NameValue(row, "NORM_AMT") + DS_IO_MASTER.NameValue(row, "INFRR_AMT");
        	
        	var rate     = DS_IO_MASTER.NameValue(row, "RATE");
        	var sale_amt = DS_IO_MASTER.NameValue(row, "SRVY_AMT");
        	var strTaxFlag = DS_IO_MASTER.NameValue(row, "TAX_FLAG");
        	
        	// 원가금액 계산
        	DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT") = getCalcPord("COST_PRC", "", sale_amt, rate, strTaxFlag, "1");   // 원가금액  (반올림)
        	var cost_amt = DS_IO_MASTER.NameValue(row, "SRVY_COST_AMT");
        	
        	// 매가단가, 원가단가 계산
        	DS_IO_MASTER.NameValue(row, "BUY_SALE_PRC")  = sale_amt / srvyQty; 
        	DS_IO_MASTER.NameValue(row, "BUY_COST_PRC")  = cost_amt / srvyQty; 
    	}
        break;
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
var orgValue = DS_IO_MASTER.OrgNameValue(row,colid);
var newValue = DS_IO_MASTER.NameValue(row,colid);
var changeFlag = (orgValue != newValue || DS_IO_MASTER.RowStatus(row) == 1) ;
    switch (colid) {
        case "MODEL_NO" :
            getskuPop(row, colid, "POP");
        break;   
    }
</script>

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=OnKillFocus()>   
    if(!this.Modified)
        return;    
    setPumbunCdSkuType("NAME");
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++)         
            DS_IO_MASTER.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++) DS_IO_MASTER.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PBNSTK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PBNINF" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SKUCD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_SKU" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_SKUCHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CLOSE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_EXCEL" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COST_CAL_WAY" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SIZE_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SALE_UNIT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CMP_SPEC_UNIT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_SKU" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CLOSECHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
}
</script>


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th class="point" width="80">점</th>
            <td width="165">
                 <comment id="_NSID_">
                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td>
            <th class="point" width="80">실사년월</th>
            <td width="105">
                <comment id="_NSID_">
                      <object id=EM_O_STK_YM classid=<%=Util.CLSID_EMEDIT%>  width=78 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03" onclick="javascript:openCal('M',EM_O_STK_YM)" align="absmiddle" /></td>
            </td>
            <th class="point" width="80">브랜드</th>
            <td>
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=60 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript: setPumbunCdSkuType('POP')" align="absmiddle" />
                <comment id="_NSID_">
                      <object id=EM_O_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=145 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>                
            </td>
          </tr>
          <tr>
            <th width="80">조직명</th>
            <td colspan="3">
                <comment id="_NSID_">
                      <object id=EM_O_ORG_NAME classid=<%=Util.CLSID_EMEDIT%>  width=365 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">재고평가구분</th>
            <td colspan="3">
                <comment id="_NSID_">
                      <object id=EM_O_COST_CAL_WAY classid=<%=Util.CLSID_EMEDIT%>  width=230 tabindex=1>
                      </object>
                </comment><script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
      <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
        <tr>
          <th width="84">재고조사일</th>
          <td width="164">
              <comment id="_NSID_">
                    <object id=EM_O_STK_DT classid=<%=Util.CLSID_EMEDIT%>  width=164 tabindex=1>
                    </object>
              </comment><script> _ws_(_NSID_);</script>
          </td>
          <th width="80">재고실사구분</th>
          <td width="104">
              <comment id="_NSID_">
                    <object id=EM_O_STK_FLAG classid=<%=Util.CLSID_EMEDIT%>  width=97 tabindex=1>
                    </object>
              </comment><script> _ws_(_NSID_);</script>
          </td>
          <th width="80">상태</th>
          <td>
              <comment id="_NSID_">
                    <object id=EM_O_STATE classid=<%=Util.CLSID_EMEDIT%>  width=230 tabindex=1>
                    </object>
              </comment><script> _ws_(_NSID_);</script>
          </td>
        </tr>
      </table></td>
    </tr>
  <tr>
      <td class="dot"></td>
  </tr>
  <tr>    
        
    <td class="right PB05">
        <table width="160" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <th><img src="/<%=dir%>/imgs/btn/add_row.gif" 
                  onclick="javascript:btn_Add1();" hspace="2" /></th> 
              <th><img src="/<%=dir%>/imgs/btn/del_row.gif" 
                  onclick="javascript:btn_Del1();" /></th>
              <th><img src="/<%=dir%>/imgs/btn/excel_s.gif" id="Excel_Up_Load"
                  onclick="getExcelUpLoadPop();" align="absmiddle" /></th>
              <th>
               <a href="/dps/samplefiles/SKU_STK_UPLOAD(Sample).xls" align="absmiddle" id=A_EXCEL_DOWN>
              <img src="/<%=dir%>/imgs/btn/excel_down.gif" id="Excel_Down_Load"
                   align="absmiddle" />
              </a>
              </th>
            </tr>
        </table>
    </td>
  </tr>  
	<tr>
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=421 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>				
			</tr>
			<tr>
			<td><comment id="_NSID_"><object id=GD_EXCEL
                    width="0" height=0 classid=<%=Util.CLSID_GRID%>>
                    <param name="DataID" value="DS_IO_EXCEL">
                </object></comment><script>_ws_(_NSID_);</script></td>
            </tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

