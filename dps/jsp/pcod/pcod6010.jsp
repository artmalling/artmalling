<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품가격> 단품가격예약등록
 * 작 성 일 : 2010.04.01
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : pcod6010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품의 판매가격을 변경 예약 한다.
 * 이    력 :
 *        2010.04.01 (이정식) 신규작성
 *        2010.06.15 (이정식) 거래형태 임대을A(3), 임대을B(5)에 관한처리(특정매입과 동일하게)
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir          = BaseProperty.get("context.common.dir");
    String strStartDate = Date2.addDay(+1);//내일날짜
    String strToday     = Date2.YYYYMMDD();//오늘날짜
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var lo_SkuType     = ""; //단품구분
var lo_BizType     = ""; //거래구분
var lo_StyleType   = ""; //스타일타입
var lo_LoadingFlag = 0;  //DS_MASTER 데이터가 로딩여부 체크
var lo_bfPumbunCd  = ""; //브랜드코드값
var lo_bfIncDate;        //적용시작일
var lo_bfStrCd     = ""; //
var lo_canPosChange = 1;
var lo_addrowFlag  = 0;
var onPopFlag = false;
var onPopFlag2 = false;
 /**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){

    // Input Data Set Header 초기화
    DS_SKU_COND.setDataHeader('<gauce:dataset name="H_SKU_COND"/>');
    DS_SKU_COND.Addrow();
    // Output Data Set Header 초기화
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화
    initEmEdit(EM_O_PUMBUN_CD, "CODE^6^0", PK);  //브랜드코드(조회)
    initEmEdit(EM_O_PUMBUN_NM, "GEN^40", READ);  //브랜드명(조회)
    initEmEdit(EM_O_SKU_CD, "CODE^13^0", NORMAL);  //단품코드(조회)
    initEmEdit(EM_O_SKU_NM, "GEN^40", NORMAL);  //단품명(조회)
    initEmEdit(EM_ADJ_S_DT_I, "YYYYMMDD", PK);  //적용시작일 
    initEmEdit(EM_INC_RATE, "NUMBER^3^0", NORMAL);//인하(인상)율
    initEmEdit(EM_O_STYLE_CD_A, "CODE^11", NORMAL);  //스타일코드(A)
    initEmEdit(EM_O_STYLE_NM_A, "GEN^40", NORMAL);  //스타일명(A)
    initEmEdit(EM_O_STYLE_CD_B, "CODE^54", NORMAL);  //스타일코드(B)
    initEmEdit(EM_O_STYLE_NM_B, "GEN^40", NORMAL);  //스타일명(B)
    initEmEdit(EM_O_VEN, "CODE^6^0", NORMAL);  //협력사(조회)
    initEmEdit(EM_O_VEN_NM, "GEN^40", READ);  //협력사(조회)
        
    initEmEdit(EM_O_MNG_CD1, "CODE^10", NORMAL);  //관리목목1코드
    initEmEdit(EM_O_MNG_NM1, "GEN^40", READ);     //관리항목1명
    initEmEdit(EM_O_MNG_CD2, "CODE^10",  NORMAL); //관리항목2코드
    initEmEdit(EM_O_MNG_NM2, "GEN^40", READ);     //관리항목2명 
    initEmEdit(EM_O_MNG_CD3, "CODE^10", NORMAL);  //관리항목3코드
    initEmEdit(EM_O_MNG_NM3, "GEN^40", READ);     //관리항목3명
    initEmEdit(EM_O_MNG_CD4, "CODE^10",  NORMAL); //관리항목4코드
    initEmEdit(EM_O_MNG_NM4, "GEN^40", READ);     //관리항목4명 
    initEmEdit(EM_O_MNG_CD5, "CODE^10", NORMAL);  //관리항목5코드
    initEmEdit(EM_O_MNG_NM5, "GEN^40", READ);     //관리항목5명
    
    EM_INC_RATE.NumericRange = "0~+:0";

    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, NORMAL);  //점(조회)
    initComboStyle(LC_O_PUMMOK_CD,DS_O_PUMMOK_CD, "CODE^0^30,NAME^0^100", 1, NORMAL);  //품목(조회)
    initComboStyle(LC_INC_FLAG,DS_O_INC_FLAG, "CODE^0^30,NAME^0^100", 1, NORMAL);         // 인상인하구분
    initComboStyle(LC_O_BRAND_CD_A,DS_O_BRAND_CD_A, "CODE^0^30,NAME^0^100", 1, NORMAL);  //브랜드(A)
    initComboStyle(LC_O_SUB_BRD_CD_A,DS_O_SUB_BRD_CD_A, "CODE^0^30,NAME^0^100", 1, NORMAL);  //서브브랜드(A)
    initComboStyle(LC_O_PLAN_YEAR,DS_O_PLAN_YEAR, "CODE^0^30,NAME^0^100", 1, NORMAL);  //기획년도(A)
    initComboStyle(LC_O_SEASON_CD,DS_O_SEASON_CD, "CODE^0^30,NAME^0^100", 1, NORMAL);  //시즌(A)
    initComboStyle(LC_O_ITEM_CD,DS_O_ITEM_CD, "CODE^0^30,NAME^0^100", 1, NORMAL);  //아이템(A)
    initComboStyle(LC_O_BRAND_CD_B,DS_O_BRAND_CD_B, "CODE^0^30,NAME^0^100", 1, NORMAL);  //브랜드(B)
    initComboStyle(LC_O_SUB_BRD_CD_B,DS_O_SUB_BRD_CD_B, "CODE^0^30,NAME^0^100", 1, NORMAL);  //서브브랜드(B)
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js ) 
    getEtcCode("DS_O_PLAN_YEAR", "D", "P012", "Y");       //기획년도  
    getEtcCode("DS_O_SEASON_CD", "D", "P035", "Y");       //시즌코드
    getEtcCode("DS_O_ITEM_CD", "D", "P036", "Y");         //아이템코드
    getEtcCode("DS_O_INC_FLAG", "D", "P226", "N");        //인상인하구분
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "Y");
    getStore("DS_I_STR_CD", "Y", "", "N");
    
    //로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_PUMMOK_CD.setDataHeader('CODE:STRING(8),NAME:STRING(40)');
    DS_O_BRAND_CD_A.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_SUB_BRD_CD_A.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_BRAND_CD_B.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_SUB_BRD_CD_B.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    
    // 기본값 입력( gauce.js )
    insComboData( LC_O_PUMMOK_CD, "%", "전체", 1 );
    insComboData( LC_INC_FLAG, "%", "전체", 1 );
    insComboData( LC_O_BRAND_CD_A, "%", "전체", 1 );
    insComboData( LC_O_SUB_BRD_CD_A, "%", "전체", 1 );
    insComboData( LC_O_BRAND_CD_B, "%", "전체", 1 );
    insComboData( LC_O_SUB_BRD_CD_B, "%", "전체", 1 );
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_O_STR_CD.Index < 0){
    	LC_O_STR_CD.Index= 0;
    }
    setComboData(LC_O_PUMMOK_CD,"%");
    setComboData(LC_INC_FLAG,"%");
    setComboData(LC_O_BRAND_CD_A,"%");
    setComboData(LC_O_BRAND_CD_B,"%");
    setComboData(LC_O_SUB_BRD_CD_A,"%");
    setComboData(LC_O_SUB_BRD_CD_B,"%");
    setComboData(LC_O_PLAN_YEAR,"%");
    setComboData(LC_O_SEASON_CD,"%");
    setComboData(LC_O_ITEM_CD,"%");
    LC_INC_FLAG.Index      = 0;
    
    //조회조건 Enable여부를 초기화한다.
    setEnableControl("", "");
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod601","DS_MASTER" );
    
    EM_ADJ_S_DT_I.Text = "<%=strStartDate%>";
    lo_bfIncDate = EM_ADJ_S_DT_I.Text;
    EM_O_PUMBUN_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        width=40  align=center name="NO"</FC>'
                     + '<FC>id=CHECK_FLAG      width=45  align=center name="선택" EditStyle=checkbox HeadCheck=false HeadCheckShow=true edit={IF(EDIT_FLAG="1","true","false")}</FC>'
                     + '<FC>id=STR_CD          width=80  align=left   name="*점"  EditStyle=Lookup   Data="DS_I_STR_CD:CODE:NAME" edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FG>name="*단품"' 
                     + '<FC>id=SKU_CD          width=130 align=center name="단품코드" edit=Numeric EditStyle=Popup edit={IF(SysStatus="I","true","false")}</FC>'
                     + '<FC>id=SKU_NAME        width=130 align=left   name="단품명"   edit=none</FC>'
                     + '<C>id=NORM_MG_RATE     width=70  align=right  name="마진율"   edit=none show=false</C>'
                     + '</FG>'
                     + '<C>id=STYLE_CD         width=90  align=center name="스타일" edit=none show=false</C>'
                     + '<C>id=COLOR_NM         width=90  align=left   name="칼라"   edit=none show=false</C>'
                     + '<C>id=SIZE_NM          width=90  align=left   name="사이즈" edit=none show=false</C>'
                     + '<G>name="변경전"'
                     + '<C>id=ORI_APP_S_DT     width=80  align=center name="적용시작일" edit=none Mask="XXXX/XX/XX"</C>'
                     + '<C>id=ORI_APP_E_DT     width=80  align=center name="적용종료일" edit=none Mask="XXXX/XX/XX"</C>'
                     + '<C>id=ORI_SAL_COST_PRC width=80  align=right  name="판매원가"   edit=none</C>'
                     + '<C>id=ORI_SALE_PRC     width=80  align=right  name="판매매가"   edit=none</C>'
                     + '<C>id=ORI_SALE_MG_RATE width=70  align=right  name="마진율"     edit=none</C>'
                     + '</G>'
                     + '<G>name="변경후"'
                     + '<C>id=NEW_APP_S_DT     width=80  align=center name="적용시작일" edit=none Mask="XXXX/XX/XX"</C>'
                     + '<C>id=NEW_APP_E_DT     width=80  align=center name="적용종료일" edit=none Mask="XXXX/XX/XX"</C>'
                     ////+ '<C>id=NEW_SAL_COST_PRC width=80  align=right  name="판매원가"   edit=Numeric edit={IF(EDIT_FLAG=0,"false",IF(BIZ_TYPE=2,"false","true"))} </C>'
                     ////+ '<C>id=NEW_SALE_PRC     width=80  align=right  name="판매매가"   edit=Numeric     edit={IF(EDIT_FLAG=0,"false",IF(BIZ_TYPE=1 AND SKU_TYPE=2,"false","true"))} </C>'
                     // 직매입이면서 FNB이면서 신선인 경우 (명동보리밥) 원가 입력 불가, 특정, 임대 원가 입력 불가
                     // 직매입이면서 FNB가 아니면서 신선인 경우 매가 입력 불가 --> 직매입 일반 신선 상품인 경우 매가 입력 불가
                     + '<C>id=NEW_SAL_COST_PRC width=80  align=right  name="판매원가"   edit=Numeric     edit={IF(EDIT_FLAG=0,"false",IF((BIZ_TYPE=1 AND PUMBUN_TYPE=4 AND SKU_TYPE=2) OR BIZ_TYPE=2 OR BIZ_TYPE=3 OR BIZ_TYPE=5,"false","true"))} </C>'
                     + '<C>id=NEW_SALE_PRC     width=80  align=right  name="판매매가"   edit=Numeric     edit={IF(EDIT_FLAG=0,"false",IF((BIZ_TYPE=1 AND PUMBUN_TYPE<>4) AND SKU_TYPE=2,"false","true"))} </C>'
                     + '<C>id=NEW_SALE_MG_RATE width=70  align=right  name="마진율"     edit=RealNumeric edit={IF(EDIT_FLAG=0,"false",IF(BIZ_TYPE=1 AND (SKU_TYPE=1 OR SKU_TYPE=3),"false","true"))} </C>'
                     + '</G>'
                     ;

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 searchMaster();
}


function searchMaster(){
	
	//Validation Check
	if( EM_O_PUMBUN_CD.Text == ""){
        //(브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_O_PUMBUN_NM.Text == ""){
        //존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }   
    
    if( EM_ADJ_S_DT_I.Text == ""){
        //(적용시작일)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
        EM_ADJ_S_DT_I.Focus();
        return;
    }
    
    if (!checkYYYYMMDD(EM_ADJ_S_DT_I.Text)){
    	//(적용시작일)은/는 유효하지 않는 날짜입니다.
        showMessage(EXCLAMATION, OK, "USER-1061", "적용시작일");                  
    	EM_ADJ_S_DT_I.Focus();
        return;
    }
    
    if (EM_ADJ_S_DT_I.Text <= "<%=strToday%>"){
        //(적용시작일)은/는 금일 이후로 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1030", "적용시작일 ");                  
        EM_ADJ_S_DT_I.Focus();
        return;
    }
    
    if (LC_INC_FLAG.BindColVal != "%"){
    	if(LC_INC_FLAG.BindColVal == "2" &&EM_INC_RATE.Text >= 100){
    		showMessage(EXCLAMATION, OK, "USER-1000", "인상인한구분이 인하일경우 인하율을 100%를 초과할수 없습니다.");                  
    		EM_INC_RATE.Focus();
            return;
    	}
    	
    	if(EM_INC_RATE.Text <= 0){
    		showMessage(EXCLAMATION, Ok, "USER-1008", "인하(인상)율","0");
            EM_INC_RATE.Focus();
            return;
        }
    }
    
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(EXCLAMATION, YESNO, "USER-1059") != 1 ){           
            GD_MASTER.Focus();
            return;
        }
    }
    
    //헤더체크초기화
    GD_MASTER.ColumnProp('CHECK_FLAG','HeadCheck') = false;
    
    lo_LoadingFlag = 0;
    
    DS_MASTER.ClearData();
    DS_SKU_COND.UserStatus(1) = '1';
    var goTo           = "searchMaster" ;    
    var action         = "O";
    TR_SEARCH.Action   = "/dps/pcod601.pc?goTo="+goTo+"&strSkuType="+lo_SkuType;  
    TR_SEARCH.KeyValue = "SERVLET(I:DS_SKU_COND=DS_SKU_COND,"+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SEARCH.Post();
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (DS_MASTER.NameValueRow("CHECK_FLAG","T") == 0 || !DS_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
    
    for( var i = 1 ; i <= DS_MASTER.CountRow; i++){
    	if(DS_MASTER.NameValue( i, "CHECK_FLAG") == "T" 
    	    && DS_MASTER.NameValue( i, "EDIT_FLAG") =="1" ){
    		
    		//판매매가
    		if(!(DS_MASTER.NameValue(i,"SKU_TYPE") == "2")){//신선 이외의 경우
    			if(DS_MASTER.NameValue( i, "NEW_SALE_PRC") <= 0 ){
    				showMessage(EXCLAMATION, OK, "USER-1008", "판매매가","신선 이외의 경우 0");     
                    setFocusGrid(GD_MASTER,DS_MASTER,i,"NEW_SALE_PRC");
                    return false;
    			}
    		}
    		
    		// MARIO OUTLET 2011-08-11 
            // getRoundDec() 원단위 절사함수
            if(Number(DS_MASTER.NameString( i, "NEW_SALE_PRC")) > 0) {
	            if((Number(DS_MASTER.NameString( i, "NEW_SALE_PRC"))%10) > 0) {
	            	showMessage(EXCLAMATION, Ok,  "USER-1000", "판매매가는 원단위로 입력 할 수 없습니다.");
	            	setFocusGrid(GD_MASTER,DS_MASTER,i,"NEW_SALE_PRC");
	            	return false;	
	            }
            }
    		
    		//마진율
    		if(!containsStrCharsOnlyValue(DS_MASTER.NameValue( i, "NEW_SALE_MG_RATE"), ".0123456789")){
                showMessage(EXCLAMATION, Ok,  "USER-1005", "마진율");            
                setFocusGrid(GD_MASTER,DS_MASTER,i,"NEW_SALE_MG_RATE");
                return false;
            }
    		
    		//최저마진율
    		if(!(DS_MASTER.NameValue(i,"BIZ_TYPE") == "1" 
    		    && DS_MASTER.NameValue(i,"SKU_TYPE") == "2")){//직매입 신선 이외의 경우
    			if(DS_MASTER.NameValue(i,"LOW_MG_RATE") != ''){//최저마진율값이 존재 할 경우
    		        if(DS_MASTER.NameValue(i,"NEW_SALE_MG_RATE") 
    		            < DS_MASTER.NameValue(i,"LOW_MG_RATE")){//마진율값은 최저마진율 값보다 작을수 없다.
    		        	showMessage(EXCLAMATION, OK, "USER-1020", "마진율","최저마진율  " + DS_MASTER.NameValue(i,"LOW_MG_RATE"));
    		        	setFocusGrid(GD_MASTER,DS_MASTER,i,"NEW_SALE_MG_RATE");
    	                return false;
    		        }
    		    }
    		}
    		
    		//변경시작일관련 날자체크
            if(DS_MASTER.NameValue(i,"NEW_APP_S_DT") <= DS_MASTER.NameValue(i,"ORI_APP_S_DT")){
            	showMessage(EXCLAMATION, OK, "USER-1008", "적용후 적용시작일","적용전 적용시작일");           
                setFocusGrid(GD_MASTER,DS_MASTER,i,"NEW_APP_S_DT");
                return false;
            }
    		
    		//원가, 매가, 마진율 변화체크
    		if((DS_MASTER.NameValue(i,"ORI_SAL_COST_PRC") == DS_MASTER.NameValue(i,"NEW_SAL_COST_PRC"))
    		  && (DS_MASTER.NameValue(i,"ORI_SALE_PRC") == DS_MASTER.NameValue(i,"NEW_SALE_PRC"))
    		    && (DS_MASTER.NameValue(i,"ORI_SALE_MG_RATE") == DS_MASTER.NameValue(i,"NEW_SALE_MG_RATE"))){
    			  showMessage(EXCLAMATION, OK, "USER-1000", "변경전과 변경후가 같습니다.");
    			  setFocusGrid(GD_MASTER,DS_MASTER,i,"NEW_SAL_COST_PRC");
                  return;    			
    		}
    		
    		//duplication 체크- 신규입력건의 정합성체크
    		if(DS_MASTER.SysStatus(i) == "1"){
    			for(var y = 1 ; y < i ; y++){
    				if(DS_MASTER.NameValue(i,"STR_CD") == DS_MASTER.NameValue(y,"STR_CD")){//동일한 점코드가 존재시
                        if(DS_MASTER.NameValue(i,"SKU_CD") == DS_MASTER.NameValue(y,"SKU_CD")){
                            showMessage(EXCLAMATION, OK, "GAUCE-1007", DS_MASTER.CountRow);
                            setFocusGrid(GD_MASTER,DS_MASTER,i,"SKU_CD");
                            return;
                        }
                    }
    			}
    		}
    	}   
    }

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        GD_MASTER.Focus();
        return;
    }

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        return;
    }
    
    var parameters = "&strPumbunCd="+encodeURIComponent(EM_O_PUMBUN_CD.Text);
   
    TR_SAVE.Action="/dps/pcod601.pc?goTo=save"+parameters;
    TR_SAVE.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_SAVE.Post();
    
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010.04.01
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 그리드 Row추가 
 * return값 : void
*/
function btn_Add1(){
	//Validation Check
    if( EM_O_PUMBUN_CD.Text == ""){
        //(브랜드)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }
    
    if( EM_O_PUMBUN_NM.Text == ""){
        //존재하지 않는 브랜드입니다.
        showMessage(EXCLAMATION, OK, "USER-1036", "브랜드");
        EM_O_PUMBUN_CD.Focus();
        return;
    }   
    
    if( EM_ADJ_S_DT_I.Text == ""){
        //(적용시작일)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1003", "적용시작일");
        EM_ADJ_S_DT_I.Focus();
        return;
    }
    
    if (!checkYYYYMMDD(EM_ADJ_S_DT_I.Text)){
        //(적용시작일)은/는 유효하지 않는 날짜입니다.
        showMessage(Information, OK, "USER-1061", "적용시작일");                  
        EM_ADJ_S_DT_I.Focus();
        return;
    }
    
    if (EM_ADJ_S_DT_I.Text <= "<%=strToday%>"){
        //(적용시작일)은/는 금일 이후로 입력해야 합니다.
        showMessage(Information, OK, "USER-1030", "적용시작일 ");                  
        EM_ADJ_S_DT_I.Focus();
        return;
    }
    
    DS_MASTER.Addrow();
    if(!lo_addrowFlag) setFocusGrid(GD_MASTER,DS_MASTER, DS_MASTER.RowPosition,"STR_CD");
    lo_addrowFlag = 0;
}

/**
 * btn_Del1()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 그리드 Row 삭제 
 * return값 : void
*/
function btn_Del1(){
    var row = DS_MASTER.RowPosition;
    if( DS_MASTER.RowStatus(row) == "1") DS_MASTER.DeleteRow(row);
    else showMessage(INFORMATION, OK, "USER-1052");
    
    GD_MASTER.Focus();
}

/**
 * setPumbunCdCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 브랜드POPUP/품목COMBO를 조회한다.
 * return값 : void
 */
function setPumbunCdCombo(evnflag){
	
    var codeObj     = EM_O_PUMBUN_CD;
    var nameObj     = EM_O_PUMBUN_NM;
    var pmkComboObj = LC_O_PUMMOK_CD;
    var strCd       = LC_O_STR_CD.BindColVal;
    
   	if(codeObj.Text == "" && evnflag != "POP" ){
    	lo_SkuType   = "";
        lo_StyleType = "";
        nameObj.Text = "";
        eval(pmkComboObj.ComboDataID).ClearData();
        insComboData( pmkComboObj, "%", "전체", 1 );
        setComboData( pmkComboObj,"%");
        DS_MASTER.ClearData();
        setEnableControl(lo_SkuType , lo_StyleType);
        clearStyleCnt();
        return;
    }
    
    var result = null;
    DS_SEARCH_NM.ClearData();
    if( evnflag == "POP" ){
    	result = strPbnPop2(codeObj,nameObj,'Y','', strCd,'','','','','Y','1');
    	codeObj.Focus();
    }else if( evnflag == "NAME" ){
        setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'', strCd,'','','','','Y','1');
    }

    if( result != null || DS_SEARCH_NM.CountRow > 0){
    	if( DS_MASTER.IsUpdated && lo_bfPumbunCd != codeObj.Text){
            // 변경된 상세내역이 존재합니다. 브랜드을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","브랜드") != 1 ){
                codeObj.Text = lo_bfPumbunCd;
                GD_MASTER.Focus();
                return;
            }
        }
    	
    	var pumbunCd = codeObj.Text;
    	if(lo_bfPumbunCd != pumbunCd) DS_MASTER.ClearData();
        getPbnPmkCode(pmkComboObj.ComboDataID, pumbunCd,"N");
        getStyleBrand("DS_O_BRAND_CD_A", pumbunCd, "Y");
        getStyleSubBrand("DS_O_SUB_BRD_CD_A", pumbunCd, "Y"); 
        getStyleBrand("DS_O_BRAND_CD_B", pumbunCd, "Y");
        getStyleSubBrand("DS_O_SUB_BRD_CD_B", pumbunCd, "Y");
        
        lo_SkuType   = result != null ? result.get('SKU_TYPE')  : DS_SEARCH_NM.NameValue(1,"SKU_TYPE");
        lo_StyleType = result != null ? result.get('STYLE_TYPE'): DS_SEARCH_NM.NameValue(1,"STYLE_TYPE");
        
        //단품구분에 따른 그리드 컬럼 조정
        GD_MASTER.ReDraw = "false";
        if(lo_SkuType == "3"){//조회 브랜드의 단품종류가 의류잡화단품이 아닐경우 스타일,컬러, 사이즈 숨김
        	GD_MASTER.ColumnProp("STYLE_CD", "show") = true;
            if(lo_StyleType == "1"){//조회 브랜드의 스타일종류가 의류단품이 아닐경우 스타일,컬러, 사이즈 숨김
                GD_MASTER.ColumnProp("COLOR_NM", "show") = true;
                GD_MASTER.ColumnProp("SIZE_NM",  "show") = true;
            }else{
                GD_MASTER.ColumnProp("COLOR_NM", "show") = false;
                GD_MASTER.ColumnProp("SIZE_NM",  "show") = false;
            }
        } else {
            GD_MASTER.ColumnProp("STYLE_CD", "show") = false;
            GD_MASTER.ColumnProp("COLOR_NM", "show") = false;
            GD_MASTER.ColumnProp("SIZE_NM",  "show") = false;
        }
        GD_MASTER.ReDraw = "true";

        //콤보에 '전체' 추가
        insComboData(pmkComboObj,"%","전체",1);        
        //콤보데이터 기본값 설정( gauce.js )
        setComboData(LC_O_BRAND_CD_A,"%");
        setComboData(LC_O_SUB_BRD_CD_A,"%");
        setComboData(LC_O_BRAND_CD_B,"%");
        setComboData(LC_O_SUB_BRD_CD_B,"%");
        setComboData(pmkComboObj,"%");
        lo_bfPumbunCd = pumbunCd;
        
        setEnableControl(lo_SkuType , lo_StyleType);
        return;
    }
    if(nameObj.Text == ""){
    	codeObj.Text = "";
    	lo_SkuType      = "";
        lo_StyleType    = "";
        eval(pmkComboObj.ComboDataID).ClearData();  
        insComboData( pmkComboObj, "%", "전체", 1 );
        setComboData( pmkComboObj,"%");
        DS_MASTER.ClearData();
        clearStyleCnt();
    }
    
}

/**
 * setInitCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-16
 * 개    요 : 공통코드 팝업 및 이름  조회
 * return값 : void
 */
function setInitCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){

    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }
    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : (svcFlg == 'I'?'SEL_COMM_CODE_ONLY':'SEL_COMM_CODE_USE_REFER_ONLY');
    var mngCd1   = svcFlg == 'S2'?EM_O_MNG_CD1.Text:'';
    mngCd1 = mngCd1 == ''? '**********' : mngCd1;
    
    if( evnflag == "POP" ){
        if( svcFlg =='S'|| svcFlg == 'I' )
            commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
        else
            commonPop(title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );
        
        codeObj.Focus();
        return;
    }

    nameObj.Text = "";

    if( svcFlg =='S'|| svcFlg == 'I' )
        setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId);
    else
        setNmWithoutPop('DS_SEARCH_NM',title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );
    
    
    if( DS_SEARCH_NM.CountRow == 1){
        codeObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_CD");
        nameObj.Text = DS_SEARCH_NM.NameValue(1,"CODE_NM");
        return;
    }
    if( svcFlg =='S'|| svcFlg == 'I' )
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId);
    else
        commonPop(title,comSqlId,codeObj ,nameObj,'D',comId, svcFlg == 'S2'?'':'Y', mngCd1 );

    codeObj.Focus();
}

/**
 * setEnableControl()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 단품구분에 따른 Enable여부를 변경한다.
 * return값 : void
 */
function setEnableControl(lo_SkuType , lo_StyleType){
	if (lo_SkuType = "3" && lo_StyleType == "1"){
        enableControl(LC_O_PLAN_YEAR, true);
        enableControl(LC_O_SEASON_CD, true);
        enableControl(LC_O_BRAND_CD_A, true);
        enableControl(LC_O_SUB_BRD_CD_A, true);
        enableControl(LC_O_BRAND_CD_B, false);
        enableControl(LC_O_SUB_BRD_CD_B, false);
        enableControl(LC_O_ITEM_CD, true);
        enableControl(EM_O_STYLE_CD_A, true);
        enableControl(EM_O_STYLE_NM_A, true);
        enableControl(EM_O_STYLE_CD_B, false);
        enableControl(EM_O_STYLE_NM_B, false);
        enableControl(EM_O_MNG_CD1, false);
        enableControl(EM_O_MNG_CD2, false);
        enableControl(EM_O_MNG_CD3, false);
        enableControl(EM_O_MNG_CD4, false);
        enableControl(EM_O_MNG_CD5, false);
        enableControl(IMG_MNG_CD1, false);
        enableControl(IMG_MNG_CD2, false);
        enableControl(IMG_MNG_CD3, false);
        enableControl(IMG_MNG_CD4, false);
        enableControl(IMG_MNG_CD5, false);
        enableControl(IMG_STYLE_CD_A, true);
        enableControl(IMG_STYLE_CD_B, false);
        EM_O_SKU_CD.Text = "";
        EM_O_SKU_NM.Text = ""; 
        EM_O_STYLE_CD_B.Text = "";
        EM_O_STYLE_NM_B.Text = "";
        EM_O_MNG_CD1.Text = "";
        EM_O_MNG_NM1.Text = "";
        EM_O_MNG_CD2.Text = "";
        EM_O_MNG_NM2.Text = "";
        EM_O_MNG_CD3.Text = "";
        EM_O_MNG_NM3.Text = "";
        EM_O_MNG_CD4.Text = "";
        EM_O_MNG_NM4.Text = "";
        EM_O_MNG_CD5.Text = "";
        EM_O_MNG_NM5.Text = "";
        
    }else if(lo_SkuType = "3" && lo_StyleType == "2"){
        enableControl(LC_O_PLAN_YEAR, false);
        enableControl(LC_O_SEASON_CD, false);
        enableControl(LC_O_BRAND_CD_A, false);
        enableControl(LC_O_SUB_BRD_CD_A, false);
        enableControl(LC_O_BRAND_CD_B, true);
        enableControl(LC_O_SUB_BRD_CD_B, true);
        enableControl(EM_O_STYLE_CD_A, false);
        enableControl(EM_O_STYLE_NM_A, false);
        enableControl(EM_O_STYLE_CD_B, true);
        enableControl(EM_O_STYLE_NM_B, true);
        enableControl(LC_O_ITEM_CD, false);
        enableControl(EM_O_MNG_CD1, true);
        enableControl(EM_O_MNG_CD2, true);
        enableControl(EM_O_MNG_CD3, true);
        enableControl(EM_O_MNG_CD4, true);
        enableControl(EM_O_MNG_CD5, true); 
        enableControl(IMG_MNG_CD1, true);
        enableControl(IMG_MNG_CD2, true);
        enableControl(IMG_MNG_CD3, true);
        enableControl(IMG_MNG_CD4, true);
        enableControl(IMG_MNG_CD5, true);
        enableControl(IMG_STYLE_CD_A, false);
        enableControl(IMG_STYLE_CD_B, true);
        setComboData(LC_O_PLAN_YEAR,"%");
        setComboData(LC_O_SEASON_CD,"%");
        setComboData(LC_O_ITEM_CD,"%");
        EM_O_SKU_CD.Text = "";
        EM_O_SKU_NM.Text = ""; 
        EM_O_STYLE_CD_A.Text = "";
        EM_O_STYLE_NM_A.Text = "";
    }else{
        enableControl(LC_O_BRAND_CD_A, false);
        enableControl(LC_O_SUB_BRD_CD_A, false);
        enableControl(LC_O_BRAND_CD_B, false);
        enableControl(LC_O_SUB_BRD_CD_B, false);
        enableControl(LC_O_PLAN_YEAR, false);
        enableControl(LC_O_SEASON_CD, false);
        enableControl(LC_O_ITEM_CD, false);
        enableControl(EM_O_STYLE_CD_A, false);
        enableControl(EM_O_STYLE_NM_A, false);
        enableControl(EM_O_MNG_CD1, false);
        enableControl(EM_O_MNG_CD2, false);
        enableControl(EM_O_MNG_CD3, false);
        enableControl(EM_O_MNG_CD4, false);
        enableControl(EM_O_MNG_CD5, false);
        enableControl(EM_O_STYLE_CD_B, false);
        enableControl(EM_O_STYLE_NM_B, false);
        enableControl(IMG_MNG_CD1, false);
        enableControl(IMG_MNG_CD2, false);
        enableControl(IMG_MNG_CD3, false);
        enableControl(IMG_MNG_CD4, false);
        enableControl(IMG_MNG_CD5, false);
        enableControl(IMG_STYLE_CD_A, false);
        enableControl(IMG_STYLE_CD_B, false);         
        setComboData(LC_O_PLAN_YEAR,"%");
        setComboData(LC_O_SEASON_CD,"%");
        setComboData(LC_O_ITEM_CD,"%");
        EM_O_SKU_CD.Text = "";
        EM_O_SKU_NM.Text = "";         
        EM_O_STYLE_CD_A.Text = "";
        EM_O_STYLE_NM_A.Text = "";
        EM_O_STYLE_CD_B.Text = "";
        EM_O_STYLE_NM_B.Text = "";
        EM_O_MNG_CD1.Text = "";
        EM_O_MNG_NM1.Text = "";
        EM_O_MNG_CD2.Text = "";
        EM_O_MNG_NM2.Text = "";
        EM_O_MNG_CD3.Text = "";
        EM_O_MNG_NM3.Text = "";
        EM_O_MNG_CD4.Text = "";
        EM_O_MNG_NM4.Text = "";
        EM_O_MNG_CD5.Text = "";
        EM_O_MNG_NM5.Text = "";
    }
}

/**
 * getSkuPop()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 :  단품GridPopup
 * return값 : void
 */
function getSkuPop(row, colid , popFlag){   
   var strSkuCd  = DS_MASTER.NameValue(DS_MASTER.RowPosition,"SKU_CD"); //단품코드   
   var strSkuNm  = ""; //단품코드  
   var strStrCd  = DS_MASTER.NameValue(DS_MASTER.RowPosition,"STR_CD"); //점코드
   
   var rtnMap = null;
   if(strSkuCd != "" && popFlag != "1"){
       rtnMap = setStrSkuNmWithoutToGridPop("DS_O_RESULT", strSkuCd, strSkuNm , 'Y' , '1','',strStrCd,EM_O_PUMBUN_CD.Text,'','','Y','',lo_SkuType,'','','','');
       if(rtnMap != null){            
           DS_MASTER.NameValue(row, "SKU_CD")         = rtnMap.get("SKU_CD");
           DS_MASTER.NameValue(row, "SKU_NAME")       = rtnMap.get("SKU_NAME");
       }else{
    	   if(DS_MASTER.NameValue(row, "SKU_NAME") == "") DS_MASTER.NameValue(row, "SKU_CD")="";
       }        
   }else{
       if (popFlag =="1"){
           rtnMap = strSkuToGridPop(strSkuCd , strSkuNm,'Y','',strStrCd,EM_O_PUMBUN_CD.Text,'','','Y','',lo_SkuType,'','','','');
           if(rtnMap != null){         
               DS_MASTER.NameValue(row, "SKU_CD")         = rtnMap.get("SKU_CD");
               DS_MASTER.NameValue(row, "SKU_NAME")       = rtnMap.get("SKU_NAME");
               onPopFlag2 = true;
               getSingeSkuInfo(row,colid);
           }else{
        	   if(DS_MASTER.NameValue(row, "SKU_NAME") == "") DS_MASTER.NameValue(row, "SKU_CD")="";
           }
       }       
   }
}

/**
 * clearStyleCnt()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 의류잡화단품 정보를 초기화 한다.
 * return값 : void
**/
function clearStyleCnt(){
    DS_O_BRAND_CD_A.ClearData();
    DS_O_SUB_BRD_CD_A.ClearData();
    DS_O_BRAND_CD_B.ClearData();
    DS_O_SUB_BRD_CD_B.ClearData();
    // 기본값 입력( gauce.js )
    insComboData( LC_O_BRAND_CD_A, "%", "전체", 1 );
    insComboData( LC_O_SUB_BRD_CD_A, "%", "전체", 1 );
    insComboData( LC_O_BRAND_CD_B, "%", "전체", 1 );
    insComboData( LC_O_SUB_BRD_CD_B, "%", "전체", 1 );
    setComboData( LC_O_BRAND_CD_A,"%");
    setComboData( LC_O_SUB_BRD_CD_A,"%");
    setComboData( LC_O_BRAND_CD_B,"%");
    setComboData( LC_O_SUB_BRD_CD_B,"%");    
}

/**
 * setAdjDate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 적용시잘일 변경
 * return값 : void
**/
function setAdjDate(){
	openCal('G',EM_ADJ_S_DT_I);
	
	if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 적용일자을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","적용일자") != 1 ){
        	EM_ADJ_S_DT_I.Text = lo_bfIncDate;
            GD_MASTER.Focus();
            return;
        }
    }
    lo_bfIncDate = EM_ADJ_S_DT_I.Text;
    DS_MASTER.ClearData();
}

/**
 * getSingeSkuInfo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2010.04.01
 * 개    요 : 단일 가격정보 가져오기
 * return값 : void
**/
function getSingeSkuInfo(row,colid){
	//단품 정보 셋팅여부 체크
    if(DS_MASTER.NameValue(row, "SKU_CD") != ""){
        var rtnMap = setStrSkuNmWithoutToGridPop( "DS_O_SKU_CD", DS_MASTER.NameValue(row, "SKU_CD"), '', 'Y' , '0',''
                ,DS_MASTER.NameValue(row, "STR_CD"),EM_O_PUMBUN_CD.Text,'','','','',lo_SkuType,'','','','');

        if (rtnMap != null){
            DS_MASTER.NameValue(row, "SKU_NAME") = rtnMap.get("SKU_NAME");
        }
    }        
    if(DS_MASTER.NameValue(row, "SKU_NAME") == ""){
        showMessage(INFORMATION, OK, "USER-1069" , "단품코드");
        lo_canPosChange = 1;
        return true;
    }

    if(DS_MASTER.NameValue(row, "TEMP") == DS_MASTER.NameValue(row, "SKU_CD")) return true;
    //점코드와 단품정보를 이용하여 단건의 점별단품가격정보 가져오기
    DS_O_SKU_PRC_INFO.SyncLoad = true;
    
    var goTo       = "searchSkuPrcInfo";
    var action     = "O";
    var parameters = "&strStoreCd="  + DS_MASTER.NameValue(row, "STR_CD") //점코드
                   + "&strSkuCd="    + DS_MASTER.NameValue(row, "SKU_CD") //단품코드
                   + "&strPumbunCd=" + EM_O_PUMBUN_CD.Text                //브랜드코드
                   + "&strStartDt="  + EM_ADJ_S_DT_I.Text                 //적용시작일
                   + "&strIncFlag="  + LC_INC_FLAG.BindColVal             //인상인하구분
                   + "&strIncRate="  + EM_INC_RATE.Text                   //인상인하율
                   + "&strSkuType="  +lo_SkuType                          //단품구분
                   ;
    DS_O_SKU_PRC_INFO.DataID = "/dps/pcod601.pc?goTo="+goTo+parameters;
    DS_O_SKU_PRC_INFO.Reset();
    if ( DS_O_SKU_PRC_INFO.CountRow == 1 ) {
        onPopFlag2= false;
        lo_LoadingFlag = 0;
        for(var i = 1 ; i <= DS_O_SKU_PRC_INFO.CountColumn; i++)
            DS_MASTER.NameValue(row, DS_MASTER.ColumnID(i)) = DS_O_SKU_PRC_INFO.NameValue(1, DS_O_SKU_PRC_INFO.ColumnID(i));
        DS_MASTER.NameValue(row, "TEMP") = DS_MASTER.NameValue(row, "SKU_CD");
        lo_LoadingFlag = 1;
        return true;
    } else {
        lo_LoadingFlag = 0;
        for(var i = 1 ; i <= DS_O_SKU_PRC_INFO.CountColumn; i++)
            if(i != 3) DS_MASTER.NameValue(row, DS_MASTER.ColumnID(i)) = "";
        DS_MASTER.NameValue(row, "TEMP") = DS_MASTER.NameValue(row, "SKU_CD");
        lo_LoadingFlag = 1;
        return false;
    }
}

/**
 * setVenCode()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 협력사 팝업을 실행한다.
 * return값 : void
**/
function setVenCode(evnFlag, codeObj, nameObj){

    if( evnFlag == 'POP'){
        venPop(codeObj,nameObj);
        codeObj.Focus();
        return;
    }

    if( codeObj.Text =="" ){
        nameObj.Text = "";
        return;
    }
    
    setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 1);
    
}

/**
 * fn_mgRate()
 * 작 성 자 : 김장훈
 * 작 성 일 : 2011-03-10
 * 개    요    :  MARIO OUTLET 에만 적용
 * return값 : void
 */

function fn_mgRate(vRow){
	
	// (2)특정인경우에만 해당  
	if(DS_MASTER.NameValue(vRow, "BIZ_TYPE") == "2") {
		if(DS_MASTER.NameValue(vRow, "CHECK_FLAG") == "T") {
			DS_MASTER.NameValue(vRow, "NEW_SALE_MG_RATE") =  DS_MASTER.NameValue(vRow, "NORM_MG_RATE");	
		}
	}
	
}

-->
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
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_SEARCH event=onSuccess>
    lo_LoadingFlag = 1;
    
    for(i=0;i<TR_SEARCH.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SEARCH.SrvErrMsg('UserMsg',i));
    }
    
    //조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
</script>

<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_SAVE.SrvErrMsg('UserMsg',i));
    }
    
//     btn_search();
    searchMaster();
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_SEARCH event=onFail>
    trFailed(TR_SEARCH.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_MASTER  event=OnDataError(row,colid)>
    var colName = GD_MASTER.GetHdrDispName(-3, colid);
    if( this.ErrorCode == "50018" ) {
    	lo_addrowFlag = 1;
    	setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        showMessage(EXCLAMATION, OK, "GAUCE-1005", colName);
    } else if ( this.ErrorCode == "50019") {
    	setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        showMessage(EXCLAMATION, OK, "GAUCE-1007", row);
    } else {
        showMessage(STOPSIGN, OK, "USER-1000", this.ErrorMsg);
    }
</script>
<script language=JavaScript for=DS_O_SKU_PRC_INFO  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_MASTER event=onColumnChanged(row,colid)>
    if(!lo_LoadingFlag) return;
    
    var tempVal;
    var bizType    = DS_MASTER.NameValue(row,"BIZ_TYPE");
    var skuType    = DS_MASTER.NameValue(row,"SKU_TYPE");
    var taxFlag    = DS_MASTER.NameValue(row,"TAX_FLAG");
    var roundFlag  = DS_MASTER.NameValue(row,"ROUND_FLAG");
    var costPrc    = Number(DS_MASTER.NameString(row,"NEW_SAL_COST_PRC"));
    var salePrc    = Number(DS_MASTER.NameString(row,"NEW_SALE_PRC"));
    var mgRate     = Number(DS_MASTER.NameString(row,"NEW_SALE_MG_RATE"));
    var pumbunType = DS_MASTER.NameValue(row,"PUMBUN_TYPE");
    
    if(colid == "NEW_SAL_COST_PRC" || colid == "NEW_SALE_MG_RATE" || colid == "NEW_SALE_PRC"){
        if( bizType == "1"){//거래형태가 직매입일경우
            if( skuType == "2"){ //단품종류가 신선일 경우
            	
            	// MARIO OUTLET 신선 FNB 단품인 경우 추가
            	if (pumbunType == "4") {
            		DS_MASTER.NameValue(row, "NEW_SAL_COST_PRC") = getSalCostPrc(salePrc, mgRate, roundFlag, taxFlag);
            	} else {
                	DS_MASTER.NameValue(row, "NEW_SALE_PRC") = getSalePrc(costPrc, mgRate, roundFlag, taxFlag);
            	}
            } else { //단품종류가 규격/의류일 경우
          	    DS_MASTER.NameValue(row, "NEW_SALE_MG_RATE") = getSaleMgRate(costPrc, salePrc, roundFlag, taxFlag);
            }
        } else {//거래형태가 특정일경우
   		    DS_MASTER.NameValue(row, "NEW_SAL_COST_PRC") = getSalCostPrc(salePrc, mgRate, roundFlag, taxFlag);
        }
        DS_MASTER.NameValue(row, "CHECK_FLAG") = "T";
    }
    
    if(colid == "STR_CD") {
    	DS_MASTER.NameValue(row, DS_MASTER.ColumnID(2)) = "0";
    	DS_MASTER.NameValue(row, DS_MASTER.ColumnID(1)) = "F";
    	for(var i = 4 ; i <= DS_MASTER.CountColumn; i++)
            DS_MASTER.NameValue(row, DS_MASTER.ColumnID(i)) = "";
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 인상인하구분 콤보 변경시 -->
<script language=JavaScript for=LC_INC_FLAG event=OnSelChange()>
    if(LC_INC_FLAG.BindColVal == "%"){//전체일경우
    	EM_INC_RATE.Text = "";
    	enableControl(EM_INC_RATE, false);//인하(인상)율 비활성화
    	EM_INC_RATE.className = "input_read";
    	TD_INC_RATE.className = "";
    }else{
    	enableControl(EM_INC_RATE, true);//인하(인상)율 활성화
    	EM_INC_RATE.Focus();
    	EM_INC_RATE.className = "input_pk";
    	TD_INC_RATE.className = "point";
    }
</script>

<script language=JavaScript for=EM_O_VEN event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setVenCode('NAME',EM_O_VEN,EM_O_VEN_NM);
</script>
<!-- 단품코드 변경시 -->
<script language=JavaScript for=EM_O_SKU_CD event=OnKillFocus()>    

    //변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    if(this.text==''){
    	EM_O_SKU_NM.Text = "";
        return;
    }
    setStrSkuNmWithoutPop( "DS_O_SKU_CD", this, EM_O_SKU_NM , 'Y' , '0','',LC_O_STR_CD.BindColVal,EM_O_PUMBUN_CD.Text,'','','','',lo_SkuType,'','','','');
</script>

<!-- 브랜드(조회) -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;

    setPumbunCdCombo("NAME");
</script>

<!-- 적용시작일 변경시 -->
<script language=JavaScript for=EM_ADJ_S_DT_I event=OnKillFocus()>    

    //변경된 내역이 없으면 무시
    if( !this.Modified)
        return;
    
    if( DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 적용일자을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","적용일자") != 1 ){
            this.Text = lo_bfIncDate;
            GD_MASTER.Focus();
            return;
        }
    }
    lo_bfIncDate = this.Text;
    DS_MASTER.ClearData();
</script>

<!-- 스타일코드A 변경시 -->
<script language=JavaScript for=EM_O_STYLE_CD_A event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if(this.text==''){
    	EM_O_STYLE_NM_A.Text = "";
        return;
    }
    setStyleNmWithoutPop( "DS_O_STYLE_CD_A", this, EM_O_STYLE_NM_A ,'Y' , '0' ,'',EM_O_PUMBUN_CD.Text,'');
</script>

<!-- 스타일코드B 변경시 -->
<script language=JavaScript for=EM_O_STYLE_CD_B event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if(this.text==''){
    	EM_O_STYLE_NM_B.Text = "";
        return;
    }
    setStyleNmWithoutPop( "DS_O_STYLE_CD_B", this, EM_O_STYLE_NM_B ,'Y' , '0' ,'',EM_O_PUMBUN_CD.Text,'');
</script>

<script language=JavaScript for=EM_O_MNG_CD1 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    if(this.Text == ""){
    	EM_O_MNG_NM1.Text = "";
        return;
    }
    
    setInitCommonPop('관리항목1','P005','NAME',EM_O_MNG_CD1,EM_O_MNG_NM1,'S');
</script>
<script language=JavaScript for=EM_O_MNG_CD2 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    if(this.Text == ""){
    	EM_O_MNG_NM2.Text = "";
        return;
    }
    
    setInitCommonPop('관리항목2','P006','NAME',EM_O_MNG_CD2,EM_O_MNG_NM2,'S2');
</script>
<script language=JavaScript for=EM_O_MNG_CD3 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    if(this.Text == ""){
        EM_O_MNG_NM3.Text = "";
        return;
    }
    
    setInitCommonPop('관리항목3','P007','NAME',EM_O_MNG_CD3,EM_O_MNG_NM3,'S2');
</script>
<script language=JavaScript for=EM_O_MNG_CD4 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    if(this.Text == ""){
        EM_O_MNG_NM4.Text = "";
        return;
    }
   
    setInitCommonPop('관리항목4','P008','NAME',EM_O_MNG_CD4,EM_O_MNG_NM4,'S2');
</script>
<script language=JavaScript for=EM_O_MNG_CD5 event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    if(this.Text == ""){
        EM_O_MNG_NM5.Text = "";
        return;
    }
    
    setInitCommonPop('관리항목5','P009','NAME',EM_O_MNG_CD5,EM_O_MNG_NM5,'S2');
</script>

<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    var strCd = DS_MASTER.NameValue(row, "STR_CD");
    if (strCd != ""){
    	if (colid == "SKU_CD" && strCd != ""){
        	onPopFlag = true;
            getSkuPop(row , colid , '1');
            onPopFlag = false;
        }
    } else {
    	setFocusGrid(GD_MASTER,DS_MASTER, row ,"STR_CD");
    	showMessage(EXCLAMATION, OK, "USER-1003" , "점");
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnColumnPosChanged(row,colid)>
    if(colid != "SKU_CD" && lo_canPosChange){
    	if(DS_MASTER.NameValue(row, "STR_CD") == "") setFocusGrid(GD_MASTER,DS_MASTER, row ,"STR_CD");
    	else {
    		setFocusGrid(GD_MASTER,DS_MASTER, row ,"SKU_CD");
    	}
    }
    lo_canPosChange = 0;
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,oldData)>
	if(row < 1)
	    return;
	if( onPopFlag)
	    return;
	if( oldData == DS_MASTER.NameValue(row,colid) && !onPopFlag2)
        return;
    if(colid=="SKU_CD"){
    	//점코드 셋팅여부체크
        if(DS_MASTER.NameValue(row, "STR_CD") == ""){
        	lo_canPosChange = 1;
        	showMessage(EXCLAMATION, OK, "USER-1003" , "점");
            return true;
        }
    	
        getSkuPop(row , colid , '0');
        
    	return getSingeSkuInfo(row,colid);
    }
    return true;
</script>

<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
    
    
    if( row < 1) return;
    
    
    //if( colid == "CHECK_FLAG"){
    //  	 fn_mgRate(row);
    //}
    
    
</script>

<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){        // 전체체크
        for(var i=1; i<=DS_MASTER.CountRow; i++) 
        {
        	//변경전 적용 시작일이 크지 않은 경우만 수정 가능
        	if(DS_MASTER.NameString(i, "EDIT_FLAG") == "1") { 
        		DS_MASTER.NameString(i, colid) = 'T';
        		//fn_mgRate(i);
        	}
        }
    }else{                    // 전체체크해제
        for (var i=1; i<=DS_MASTER.CountRow; i++) DS_MASTER.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
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
<comment id="_NSID_"><object id="DS_O_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PUMMOK_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_BRAND_CD_A"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SUB_BRD_CD_A"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PLAN_YEAR"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SEASON_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ITEM_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_BRAND_CD_B"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SUB_BRD_CD_B"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD1"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD2"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD3"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD4"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_CD5"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STYLE_CD_A"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STYLE_CD_B"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_INC_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_SKU_PRC_INFO" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COLOR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SIZE_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SKU_COND" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<!-- 조회용  -->
<object id="TR_SEARCH" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
<!-- 저장용  -->
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80">점</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=55 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:setPumbunCdCombo('POP')"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=79  align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
            </td>
            <th width="80">품목</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_PUMMOK_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>단품코드</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_O_SKU_CD classid=<%=Util.CLSID_EMEDIT%> width=145 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:strSkuPop(EM_O_SKU_CD,EM_O_SKU_NM,'Y','',LC_O_STR_CD.BindColVal,EM_O_PUMBUN_CD.Text,'','','','',lo_SkuType,'','','',''); EM_O_SKU_CD.Focus();"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_SKU_NM classid=<%=Util.CLSID_EMEDIT%> width=257 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
            </td>
            <th>협력사</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_O_VEN classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"> </object>
              </comment> <script> _ws_(_NSID_);</script><img
              src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" onclick="javascript:setVenCode('POP',EM_O_VEN,EM_O_VEN_NM)" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=85 tabindex=1 align="absmiddle"> </object>
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
    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60">브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_BRAND_CD_A classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">서브브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_SUB_BRD_CD_A classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">기획년도</th>
            <td >
              <comment id="_NSID_">
                <object id=LC_O_PLAN_YEAR classid=<%= Util.CLSID_LUXECOMBO %> width=165  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>시즌</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_SEASON_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165  align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>아이템</th>
            <td>
              <comment id="_NSID_">
                <object id=LC_O_ITEM_CD classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>스타일</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_O_STYLE_CD_A classid=<%=Util.CLSID_EMEDIT%> width=90 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_STYLE_CD_A" class="PR03" onclick="javascript:stylePop(EM_O_STYLE_CD_A,EM_O_STYLE_NM_A,'Y','',EM_O_PUMBUN_CD.Text,'',''); EM_O_STYLE_CD_A.Focus();"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_STYLE_NM_A classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="60">브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_BRAND_CD_B classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="60">서브브랜드</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=LC_O_SUB_BRD_CD_B classid=<%= Util.CLSID_LUXECOMBO %> width=165 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width=60>관리항목1</th>
            <td >
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD1 classid=<%= Util.CLSID_EMEDIT %> width=90 tabindex=1 align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD1" class="PR03" onclick="javascript:setInitCommonPop('관리항목1','P005','POP',EM_O_MNG_CD1,EM_O_MNG_NM1,'S');EM_O_MNG_CD1.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM1 classid=<%= Util.CLSID_EMEDIT %> width=100  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>관리항목2</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD2 classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1 align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD2" class="PR03" onclick="javascript:setInitCommonPop('관리항목2','P006','POP',EM_O_MNG_CD2,EM_O_MNG_NM2,'S2');EM_O_MNG_CD2.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM2 classid=<%= Util.CLSID_EMEDIT %> width=80  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>관리항목3</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD3 classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1 align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD3" class="PR03" onclick="javascript:setInitCommonPop('관리항목3','P007','POP',EM_O_MNG_CD3,EM_O_MNG_NM3,'S2');EM_O_MNG_CD3.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM3 classid=<%= Util.CLSID_EMEDIT %> width=80  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>관리항목4</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD4 classid=<%= Util.CLSID_EMEDIT %> width=90 tabindex=1 align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD4" class="PR03" onclick="javascript:setInitCommonPop('관리항목4','P008','POP',EM_O_MNG_CD4,EM_O_MNG_NM4,'S2');EM_O_MNG_CD4.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM4 classid=<%= Util.CLSID_EMEDIT %> width=100  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>관리항목5</th>
            <td>
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_CD5 classid=<%= Util.CLSID_EMEDIT %> width=55 tabindex=1 align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script> 
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_MNG_CD5" class="PR03" onclick="javascript:setInitCommonPop('관리항목5','P009','POP',EM_O_MNG_CD5,EM_O_MNG_NM5,'S2');EM_O_MNG_CD5.Focus();" align="absmiddle" /> 
              <comment id="_NSID_"> 
                <object id=EM_O_MNG_NM5 classid=<%= Util.CLSID_EMEDIT %> width=80  align="absmiddle"> 
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th>스타일</th>
            <td colspan="3">
              <comment id="_NSID_">
                <object id=EM_O_STYLE_CD_B classid=<%=Util.CLSID_EMEDIT%> width=160 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id="IMG_STYLE_CD_B" class="PR03" onclick="javascript:stylePop(EM_O_STYLE_CD_B,EM_O_STYLE_NM_B,'Y','',EM_O_PUMBUN_CD.Text,'','');EM_O_STYLE_CD_B.Focus();"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_O_STYLE_NM_B classid=<%=Util.CLSID_EMEDIT%> width=277 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
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
    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th class="point" width="80">적용시작일</th>
            <td width="165">
              <comment id="_NSID_">
                <object id=EM_ADJ_S_DT_I classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1 onblur="checkDateTypeYMD(this, '<%=strStartDate%>');" align="absmiddle">
                </object>
              </comment> <script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                class="PR03" onclick="javascript: setAdjDate();" />
            </td>
            <th width="80">인하인상구분</th>
            <td width="165">
              <comment id="_NSID_"> 
                <object id=LC_INC_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=165 tabindex=1 align="absmiddle">
                </object> 
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th id="TD_INC_RATE" width="80">인하(인상)율</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_INC_RATE classid=<%=Util.CLSID_EMEDIT%> width=165 tabindex=1 align="absmiddle">
                </object>
              </comment>
              <script> _ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="right PT05" valign="bottom">
      <img src="/<%=dir%>/imgs/btn/add_row.gif" onclick="javascript:btn_Add1();" hspace="2"/><img src="/<%=dir%>/imgs/btn/del_row.gif" onclick="javascript:btn_Del1();""/>
    </td>
  </tr>
  <tr valign="top">
    <td class="PT05"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_MASTER width="100%" height=260 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_COND classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_SKU_COND>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='            
            <c>col=STR_CD        ctrl=LC_O_STR_CD        param=BindColVal </c>
            <c>col=PUMBUN_CD     ctrl=EM_O_PUMBUN_CD     param=Text </c>                         
            <c>col=PUMMOK_CD     ctrl=LC_O_PUMMOK_CD     param=BindColVal </c>   
            <c>col=VEN_CD        ctrl=EM_O_VEN           param=Text </c>               
            <c>col=STYLE_CD_A    ctrl=EM_O_STYLE_CD_A    param=Text </c>            
            <c>col=STYLE_NM_A    ctrl=EM_O_STYLE_NM_A    param=Text </c>
            <c>col=STYLE_CD_B    ctrl=EM_O_STYLE_CD_B    param=Text </c>            
            <c>col=STYLE_NM_B    ctrl=EM_O_STYLE_NM_B    param=Text </c>
            <c>col=SKU_CD        ctrl=EM_O_SKU_CD        param=Text </c>
            <c>col=SKU_NM        ctrl=EM_O_SKU_NM        param=Text </c>  
            <c>col=BRAND_CD_A    ctrl=LC_O_BRAND_CD_A    param=BindColVal </c>
            <c>col=BRAND_CD_B    ctrl=LC_O_BRAND_CD_B    param=BindColVal </c>
            <c>col=SUB_BRD_CD_A  ctrl=LC_O_SUB_BRD_CD_A  param=BindColVal </c>            
            <c>col=SUB_BRD_CD_B  ctrl=LC_O_SUB_BRD_CD_B  param=BindColVal </c>
            <c>col=PLAN_YEAR     ctrl=LC_O_PLAN_YEAR     param=BindColVal </c>            
            <c>col=SEASON_CD     ctrl=LC_O_SEASON_CD     param=BindColVal </c>                         
            <c>col=ITEM_CD       ctrl=LC_O_ITEM_CD       param=BindColVal </c>
            <c>col=MNG_CD1       ctrl=EM_O_MNG_CD1       param=Text </c>                       
            <c>col=MNG_CD2       ctrl=EM_O_MNG_CD2       param=Text </c>  
            <c>col=MNG_CD3       ctrl=EM_O_MNG_CD3       param=Text </c>
            <c>col=MNG_CD4       ctrl=EM_O_MNG_CD4       param=Text </c>  
            <c>col=MNG_CD5       ctrl=EM_O_MNG_CD5       param=Text </c>
            <c>col=ADJ_DATE      ctrl=EM_ADJ_S_DT_I      param=Text </c>
            <c>col=INC_FLAG      ctrl=LC_INC_FLAG        param=BindColVal </c>
            <c>col=INC_RATE      ctrl=EM_INC_RATE        param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

