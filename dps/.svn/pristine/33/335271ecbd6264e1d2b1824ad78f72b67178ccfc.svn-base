<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 상품코드> 단품엑셀업로드
 * 작 성 일 : 2010.03.29
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod5050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품정보를 엑셀 업로드 한다
 * 이    력 :
 *        2010.03.29 (정진영) 신규작성
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
<title>단품 엑셀 업로드</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
 // 엑셀데이터 검증시 나온 에러코드에 대한 대응 메시지 정의
 var errorMsgData = "001:미등록품목 입니다."                 + ",002:미등록판매단위 입니다."                        + ",003:미등록기본규격단위 입니다."
                 + ",004:미등록구성규격단위 입니다."        + ",005:미등록원산지 입니다."                          + ",006:미등록칼라 입니다."
                 + ",007:미등록사이즈 입니다."              + ",008:미등록사이즈타입 입니다."                      + ",009:미등록성별 입니다."
                 + ",010:미등록브랜드 입니다."              + ",011:미등록서브브랜드 입니다."                      + ",012:미등록기획년도 입니다."
                 + ",013:미등록시즌 입니다."                + ",014:미등록아이템 입니다."                          + ",015:미등록관리항목1 입니다."
                 + ",016:미등록관리항목2 입니다."           + ",017:미등록관리항목3 입니다."                       + ",018:미등록관리항목4 입니다."
                 + ",019:미등록관리항목5 입니다."           + ",020:사용 할 수 없는소스마킹코드 입니다."              + ",021:이미등록된소스마킹코드 입니다."
                 + ",022:이미등록된스타일 입니다."          + ",023:동일한 스타일 내 다른 상세정보가 존재 합니다."     + ",024:단품명이 입력되지 않았습니다."
                 + ",025:영수증명이 입력되지 않았습니다."    + ",026:품목이 입력되지 않았습니다."                   + ",027:판매단위가 입력되지 않았습니다."
                 + ",028:단품명이 40Byte가 초과되었습니다."  + ",029:영수증명이 20Byte가 초과되었습니다."           + ",030:스타일명이 40Byte가 초과되었습니다."
                 + ",031:원산지가 입력되지 않았습니다."      + ",032:스타일명이 입력되지 않았습니다."               + ",033:스타일코드가 입력되지 않았습니다."
                 + ",034:칼라가 입력되지 않았습니다."        + ",035:사이즈가 입력되지 않았습니다."                 + ",036:사이즈타입이 입력되지 않았습니다."
                 + ",037:성별이 입력되지 않았습니다."        + ",038:브랜드가 입력되지 않았습니다."                 + ",039:서브브랜드가 입력되지 않았습니다."
                 + ",040:기획년도가 입력되지 않았습니다."    + ",041:시즌이 입력되지 않았습니다."                   + ",042:아이템이 입력되지 않았습니다."
                 + ",043:시즌이 입력되지 않았습니다."        + ",044:아이템이 입력되지 않았습니다."                 + ",045:중복데이터가 존재합니다."
                 + ",046:사용 할 수 없는 스타일코드 입니다."   + ",047:관리항목이 입력되지 않았습니다."               + ",048:관리항목2가 입력되지 않았습니다."
                 + ",049:관리항목3이 입력되지 않았습니다."   + ",050:관리항목4가 입력되지 않았습니다."              + ",051:관리항목5가 입력되지 않았습니다."               
                 + ",052:기본규격은 999.99 타입으로 입력 하여야 합니다."                 
                 + ",053:구성규격은 999999.99 타입으로 입력 하여야 합니다."          
                 + ",054:중복되는 소스마킹코드 입니다."                                 
                 + ",100:품목코드의 자리수가 맞지않습니다."
                 + ",101:소스마킹코드는 최대 13자리입니다."
//                  + ",102:모델코드는 최대 24자리입니다."
                 + ",102:브랜드상품코드는 최대 24자리입니다."
                 + ",103:판매단위코드의 자리수가 맞지않습니다."
                 + ",104:기본규격의 자리수가 맞지않습니다."
                 + ",105:기본규격단위코드의 자리수가 맞지않습니다."
                 + ",106:구성규격의 자리수가 맞지않습니다."
                 + ",107:구성규격단위코드의 자리수가 맞지않습니다."
                 + ",108:원산지코드의 자리수가 맞지않습니다."
                 + ",109:스타일코드의 자리수가 맞지않습니다."
                 + ",110:컬러코드의 자리수가 맞지않습니다."
                 + ",111:사이즈코드의 자리수가 맞지않습니다."
                 + ",112:사이즈타입코드의 자리수가 맞지않습니다."
                 + ",113:성별코드의 자리수가 맞지않습니다."
                 + ",114:협력사스타일코드는 최대 24자리 입니다."
                 + ",115:브랜드코드의 자리수가 맞지않습니다."
                 + ",116:서브브랜드코드의 자리수가 맞지않습니다."
                 + ",117:관리항목1코드는 최대 10자리 입니다."
                 + ",118:관리항목2코드는 최대 10자리 입니다."
                 + ",119:관리항목3코드는 최대 10자리 입니다."
                 + ",120:관리항목4코드는 최대 10자리 입니다."
                 + ",121:관리항목5코드는 최대 10자리 입니다."
                 + ",201:브랜드상품코드가 이미존재합니다"
                 + ",202:브랜드상품코드가 입력되지 않았습니다."
                 ;
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    // Output Data Set Header 초기화
    DS_SKU.setDataHeader('<gauce:dataset name="H_SKU"/>');
    DS_FRESH.setDataHeader('<gauce:dataset name="H_FRESH"/>');
    DS_ASTYLE.setDataHeader('<gauce:dataset name="H_ASTYLE"/>');
    DS_BSTYLE.setDataHeader('<gauce:dataset name="H_BSTYLE"/>');

    //탭초기화
    initTab('TAB_MAIN');
    
    //그리드 초기화
    gridCreate1(); //규격단품
    gridCreate2(); //신선단품
    gridCreate3(); //의류잡화단품(A=Type)
    gridCreate4(); //의류잡화단품(B-Type)

    // EMedit에 초기화
    initEmEdit(EM_PUMBUN_CD, "CODE^6^0", PK);  //브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME, "GEN^40", READ);  //브랜드(조회)
    initEmEdit(EM_FILS_LOC, "GEN^500", READ); //EXCEL경로

    //조회후 결과표시 초기화
    setPorcCount("CLEAR");
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod505","DS_SKU,DS_FRESH,DS_ASTYLE,DS_BSTYLE" );

    
    setTimeout("EM_PUMBUN_CD.Focus();",50);
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            width=30  align=center edit="none" name="NO" </FC>'
                     + '<FC>id=SEL                 width=50  align=center             name="삭제" EditStyle=CheckBox Pointer=Hand HeadCheckShow=true </FC>'
                     + '<FC>id=ERROR_YN            width=50  align=center edit="none" name="오류;여부" value={IF(ERROR_CD="","N","Y")} </FC>'
                     + '<FC>id=SKU_NAME            width=90  align=left   edit="none" name="*단품명" </FC>'
                     + '<FC>id=RECP_NAME           width=90  align=left   edit="none" name="*영수증명" </FC>'
                     + '<FG>name="*품목"'
                     + '<FC>id=PUMMOK_CD           width=65  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=PUMMOK_NAME         width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=INPUT_PLU_CD        width=100 align=left   edit="none" name="소스마킹;코드" </FC>'
//                      + '<FC>id=MODEL_CD            width=160 align=left   edit="none" name="모델코드" </FC>'
                     + '<FC>id=MODEL_CD            width=130 align=left   edit="none" name="*브랜드상품코드" </FC>'
                     + '<FG>name="*판매단위"'
                     + '<FC>id=SALE_UNIT_CD        width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SALE_UNIT_NAME      width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=BAS_SPEC_CD         width=60  align=right  edit="none" name="기본규격" </FC>'
                     + '<FG>name="기본규격단위"'
                     + '<FC>id=BAS_SPEC_UNIT_CD    width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=BAS_SPEC_UNIT_NAME  width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=CMP_SPEC_CD         width=60  align=right  edit="none" name="구성규격" </FC>'
                     + '<FG>name="구성규격단위"'
                     + '<FC>id=CMP_SPEC_UNIT_CD    width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=CMP_SPEC_UNIT_NAME  width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="원산지"'
                     + '<FC>id=ORIGIN_AREA_CD      width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=ORIGIN_AREA_NAME    width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=ERROR_CD            width=300 align=left   edit="none" name="오류내용" EditStyle="Combo" Data="'+errorMsgData+'" </FC>';
                     
    initGridStyle(GD_SKU, "common", hdrProperies, true);
}
function gridCreate2(){
    var hdrProperies = '<FC>id={currow}            width=30 align=center  edit="none" name="NO" </FC>'
                     + '<FC>id=SEL                 width=50 align=center              name="삭제" EditStyle=CheckBox Pointer=Hand HeadCheckShow=true</FC>'
                     + '<FC>id=ERROR_YN            width=50  align=center edit="none" name="오류;여부" value={IF(ERROR_CD="","N","Y")} </FC>'
                     + '<FC>id=SKU_NAME            width=90  align=left   edit="none" name="*단품명" </FC>'
                     + '<FC>id=RECP_NAME           width=90  align=left   edit="none" name="*영수증명" </FC>'
                     + '<FG>name="*품목"'
                     + '<FC>id=PUMMOK_CD           width=65  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=PUMMOK_NAME         width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*판매단위"'
                     + '<FC>id=SALE_UNIT_CD        width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SALE_UNIT_NAME      width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=BAS_SPEC_CD         width=60  align=right  edit="none" name="기본규격" </FC>'
                     + '<FG>name="기본규격단위"'
                     + '<FC>id=BAS_SPEC_UNIT_CD    width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=BAS_SPEC_UNIT_NAME  width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=CMP_SPEC_CD         width=60  align=right  edit="none" name="구성규격" </FC>'
                     + '<FG>name="구성규격단위"'
                     + '<FC>id=CMP_SPEC_UNIT_CD    width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=CMP_SPEC_UNIT_NAME  width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*원산지"'
                     + '<FC>id=ORIGIN_AREA_CD      width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=ORIGIN_AREA_NAME    width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=ERROR_CD            width=300 align=left   edit="none" name="오류내용" EditStyle="Combo" Data="'+errorMsgData+'" </FC>';
                     
    initGridStyle(GD_FRESH, "common", hdrProperies, true);
}
function gridCreate3(){
    var hdrProperies = '<FC>id={currow}            width=30  align=center edit="none" name="NO" edit="none" </FC>'
                     + '<FC>id=SEL                 width=50  align=center             name="삭제" EditStyle=CheckBox Pointer=Hand HeadCheckShow=true</FC>'
                     + '<FC>id=ERROR_YN            width=50  align=center edit="none" name="오류;여부" value={IF(ERROR_CD="","N","Y")} </FC>'
                     + '<FC>id=STYLE_NAME          width=90  align=left   edit="none" name="*스타일명" </FC>'
                     + '<FC>id=RECP_NAME           width=90  align=left   edit="none" name="*영수증명" </FC>'
                     + '<FC>id=STYLE_CD            width=90  align=center edit="none" name="*스타일코드" </FC>'
                     + '<FG>name="*칼라"'
                     + '<FC>id=COLOR_CD            width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=COLOR_NAME          width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*사이즈"'
                     + '<FC>id=SIZE_CD             width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SIZE_NAME           width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*사이즈타입"'
                     + '<FC>id=SIZE_TYPE_CD        width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SIZE_TYPE_NAME      width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*성별"'
                     + '<FC>id=SEX_CD              width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SEX_NAME            width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*품목"'
                     + '<FC>id=PUMMOK_CD           width=65  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=PUMMOK_NAME         width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=INPUT_PLU_CD        width=100 align=left   edit="none" name="소스마킹;코드" </FC>'
                     + '<FC>id=VEN_STYLE_CD        width=160 align=left   edit="none" name="업체스타일" </FC>'
                     + '<FG>name="*판매단위"'
                     + '<FC>id=SALE_UNIT_CD        width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SALE_UNIT_NAME      width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=BAS_SPEC_CD         width=60  align=right  edit="none" name="기본규격" </FC>'
                     + '<FG>name="기본규격단위"'
                     + '<FC>id=BAS_SPEC_UNIT_CD    width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=BAS_SPEC_UNIT_NAME  width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=CMP_SPEC_CD         width=60  align=right  edit="none" name="구성규격" </FC>'
                     + '<FG>name="구성규격단위"'
                     + '<FC>id=CMP_SPEC_UNIT_CD    width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=CMP_SPEC_UNIT_NAME  width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="원산지"'
                     + '<FC>id=ORIGIN_AREA_CD      width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=ORIGIN_AREA_NAME    width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=ERROR_CD            width=300 align=left   edit="none" name="오류내용" EditStyle="Combo" Data="'+errorMsgData+'" </FC>';
                     
    initGridStyle(GD_ASTYLE, "common", hdrProperies, true);
}
function gridCreate4(){
    var hdrProperies = '<FC>id={currow}            width=30 align=center  edit="none" name="NO" edit="none" </FC>'
                     + '<FC>id=SEL                 width=50 align=center              name="삭제" EditStyle=CheckBox Pointer=Hand HeadCheckShow=true</FC>'
                     + '<FC>id=ERROR_YN            width=50  align=center edit="none" name="오류;여부" value={IF(ERROR_CD="","N","Y")} </FC>'
                     + '<FC>id=STYLE_NAME          width=90  align=left   edit="none" name="*스타일명" </FC>'
                     + '<FC>id=RECP_NAME           width=90  align=left   edit="none" name="*영수증명" </FC>'
                     + '<FG>name="*브랜드"'
                     + '<FC>id=BRAND_CD            width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=BRAND_NAME          width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*서브브랜드"'
                     + '<FC>id=SUB_BRD_CD          width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SUB_SRD_NAME        width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*관리항목1"'
                     + '<FC>id=MNG_CD1             width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=MNG_NAME1           width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*관리항목2"'
                     + '<FC>id=MNG_CD2             width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=MNG_NAME2           width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*관리항목3"'
                     + '<FC>id=MNG_CD3             width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=MNG_NAME3           width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*관리항목4"'
                     + '<FC>id=MNG_CD4             width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=MNG_NAME4           width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*관리항목5"'
                     + '<FC>id=MNG_CD5             width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=MNG_NAME5           width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*성별"'
                     + '<FC>id=SEX_CD              width=60  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SEX_NAME            width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="*품목"'
                     + '<FC>id=PUMMOK_CD           width=65  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=PUMMOK_NAME         width=80  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=INPUT_PLU_CD        width=100 align=left   edit="none" name="소스마킹;코드" </FC>'
                     + '<FC>id=VEN_STYLE_CD        width=160 align=left   edit="none" name="업체스타일" </FC>'
                     + '<FG>name="*판매단위"'
                     + '<FC>id=SALE_UNIT_CD        width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=SALE_UNIT_NAME      width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=BAS_SPEC_CD         width=60  align=right  edit="none" name="기본규격" </FC>'
                     + '<FG>name="기본규격단위"'
                     + '<FC>id=BAS_SPEC_UNIT_CD    width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=BAS_SPEC_UNIT_NAME  width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=CMP_SPEC_CD         width=60  align=right  edit="none" name="구성규격" </FC>'
                     + '<FG>name="구성규격단위"'
                     + '<FC>id=CMP_SPEC_UNIT_CD    width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=CMP_SPEC_UNIT_NAME  width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FG>name="원산지"'
                     + '<FC>id=ORIGIN_AREA_CD      width=50  align=center edit="none" name="코드" </FC>'
                     + '<FC>id=ORIGIN_AREA_NAME    width=70  align=left   edit="none" name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=ERROR_CD            width=300 align=left   edit="none" name="오류내용" EditStyle="Combo" Data="'+errorMsgData+'" </FC>';
                     
    initGridStyle(GD_BSTYLE, "common", hdrProperies, true);
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
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2010-03-29
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
    var dataSetId = "";
    var grid;
    var strCheckType = "";
    DS_EXECL_LOAD.ClearAll();
    switch(getTabItemSelect("TAB_MAIN")){
        case 1:
            dataSetId = 'DS_SKU';
            grid = GD_SKU;
            strCheckType = 1;
            DS_EXECL_LOAD.setDataHeader('<gauce:dataset name="H_SKU"/>');
            break;
        case 2:
            dataSetId = 'DS_FRESH';
            grid = GD_FRESH;
            strCheckType = 2;
            DS_EXECL_LOAD.setDataHeader('<gauce:dataset name="H_FRESH"/>');
            break;
        case 3:
            dataSetId = 'DS_ASTYLE';
            grid = GD_ASTYLE;
            strCheckType = 3;
            DS_EXECL_LOAD.setDataHeader('<gauce:dataset name="H_ASTYLE"/>');
            break;
        case 4:
            dataSetId = 'DS_BSTYLE';
            grid = GD_BSTYLE;
            strCheckType = 4;
            DS_EXECL_LOAD.setDataHeader('<gauce:dataset name="H_BSTYLE"/>');
            break;
    }
    
    if( dataSetId =="")
    	return;
    
    var dataSet = eval(dataSetId);
    var delRow = 0;
    
    for( var i=1; i<=dataSet.CountRow; i++){
    	if( dataSet.NameValue(i,"SEL")=='T'){
            dataSet.RowMark(i) = 1;
            delRow++;
    	}else{
            dataSet.RowMark(i) = 0;
    	}
    }
    
    if( delRow < 1){
    	dataSet.ClearAllMark();
        showMessage(INFORMATION, OK, "USER-1019");
        if(dataSet.CountRow < 1)
        	EM_PUMBUN_CD.Focus();
        else
            setFocusGrid(grid,dataSet,dataSet.RowPosition,"SEL");
        
        return;
    }
    dataSet.DeleteMarked();

    DS_EXECL_LOAD.ImportData( dataSet.ExportData(1, dataSet.CountRow, true));

    GD_SKU.ColumnProp('SEL','HeadCheck')= "FALSE";
    GD_FRESH.ColumnProp('SEL','HeadCheck')= "FALSE";
    GD_ASTYLE.ColumnProp('SEL','HeadCheck')= "FALSE";
    GD_BSTYLE.ColumnProp('SEL','HeadCheck')= "FALSE";
    
    if(DS_EXECL_LOAD.CountRow < 1){
        showMessage(INFORMATION , OK, "USER-1000", delRow + " 건 삭제 되었습니다.");
        EM_PUMBUN_CD.Focus();
        return;
    }
    var pumbunCd = EM_PUMBUN_CD.Text; 
    var goTo       = "checkExcelData" ;    
    var parameters = "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strCheckType="+encodeURIComponent(strCheckType);
    TR_MAIN.Action="/dps/pcod505.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(I:DS_EXECL_LOAD=DS_EXECL_LOAD,O:DS_RESULT="+dataSetId+")"; //조회는 O
    TR_MAIN.Post();
    
    showMessage(INFORMATION , OK, "USER-1000", delRow + " 건 삭제 되었습니다.");
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    var dataSetId = "";
    var grid;
    var strCheckType = "";
    switch(getTabItemSelect("TAB_MAIN")){
        case 1:
            dataSetId = 'DS_SKU';
            grid = GD_SKU;
            strCheckType = 1;
            break;
        case 2:
            dataSetId = 'DS_FRESH';
            grid = GD_FRESH;
            strCheckType = 2;
            break;
        case 3:
            dataSetId = 'DS_ASTYLE';
            grid = GD_ASTYLE;
            strCheckType = 3;
            break;
        case 4:
            dataSetId = 'DS_BSTYLE';
            grid = GD_BSTYLE;
            strCheckType = 4;
            break;
    }
    
    
    if( dataSetId =="")
        return;
    
    var dataSet = eval(dataSetId);
    if( dataSet.CountRow < 1){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        if(dataSet.CountRow < 1)
            EM_PUMBUN_CD.Focus();
        else
            setFocusGrid(grid,dataSet,dataSet.RowPosition,"SEL");        
        return;
    }
    
    var errRow = 0;
    for( var i=1; i<=dataSet.CountRow; i++){

        // 중복체크(브랜드상품코드)
    	var strModelCd = dataSet.NameValue(i, "MODEL_CD");
        if(gfnCheckDup(dataSet, strModelCd, "MODEL_CD") > 1){
        	dataSet.Rowposition = i;
            showMessage(INFORMATION, Ok, "USER-1000", "중복된 브랜드상품코드(" + strModelCd + ")가 존재합니다.");
        	errRow = i;
			return false;
        }
    	
    	
    	if( grid.VirtualString(i,"ERROR_YN")=='Y'){
        	errRow = i;
        	break;
        }
        dataSet.UserStatus(i) = 1;
    }
    
    if( errRow > 0){
    	dataSet.ResetUserStatus();
        showMessage(EXCLAMATION, Ok,  "USER-1000", "오류가 있는 데이터가 존재합니다.");
        setFocusGrid(grid,dataSet,errRow,"SEL");     
    	return;
    }

    // 마감체크 (common.js)
    if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','02','0','T') == 'TRUE'){
        showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
        dataSet.ResetUserStatus();
        grid.Focus();
        return;
    }
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1082") != 1 ){
        setFocusGrid(grid,dataSet,dataSet.RowPosition,"SEL");     
        dataSet.ResetUserStatus();
        return;     
    }
    
    var pumbunCd = EM_PUMBUN_CD.Text; 
    var pumbunType = EM_PUMBUN_TYPE.Text;
    var skuType = EM_SKU_TYPE.Text;
    var styleType = EM_STYLE_TYPE.Text;
    var goTo       = "save" ;    
    var parameters = "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strCheckType="+encodeURIComponent(strCheckType)
                   + "&strPumbunType="+encodeURIComponent(pumbunType)
                   + "&strSkuType="+encodeURIComponent(skuType)
                   + "&strStyleType="+encodeURIComponent(styleType);
    TR_MAIN.Action="/dps/pcod505.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(I:DS_EXCEL_DATA="+dataSetId+")"; //조회는 O
    TR_MAIN.Post();
    
    // 정상 처리일 경우 초기화
    if( TR_MAIN.ErrorCode == 0){
    	clearAllItem();
    }
    EM_PUMBUN_CD.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-29
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-29
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * setPumbunCode()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-29
 * 개    요 : 브랜드 팝입 및 이름 조회
 */
function setPumbunCode( evnflag){
	clearAllItem();
    var codeObj = EM_PUMBUN_CD;
    var nameObj = EM_PUMBUN_NAME;

    if(codeObj.Text == "" && evnflag != "POP" ){
        document.getElementById("A_EXCEL_DOWN").href = '#';
        nameObj.Text = "";
        return;
    }
    
    var result = null;
    if( evnflag == "POP" ){
        result = strPbnPop2(codeObj,nameObj,'Y','','','','','','','','1');        
    }else if( evnflag == "NAME" ){
        result = setStrPbnNmWithoutPop("DS_SEARCH_NM",codeObj,nameObj,"Y",1,'','','','','','','','1');
    }

    if( result == null && DS_SEARCH_NM.CountRow != 1){
        document.getElementById("A_EXCEL_DOWN").href = '#';
        codeObj.Focus();
        return;
    }
    var selectTab = 0;
    var sampleUrl = "#";
    
    getPumbunInfo("DS_SEARCH_NM",codeObj.Text);

    if( DS_SEARCH_NM.CountRow != 1){
        codeObj.Focus();
    	return;
    }
    
    var pumbunType = DS_SEARCH_NM.NameValue(1,"PUMBUN_TYPE");
    var skuType = DS_SEARCH_NM.NameValue(1,"SKU_TYPE");
    var styleType = DS_SEARCH_NM.NameValue(1,"STYLE_TYPE");
    EM_PUMBUN_TYPE.Text = pumbunType;
    EM_SKU_TYPE.Text = skuType;
    EM_STYLE_TYPE.Text = styleType;
    
    switch(skuType){
        case '1':
        	selectTab = 1;
        	sampleUrl = "/dps/samplefiles/01_STANDARD_SKU_UPLOAD(Sample).xls";
        	break;
        case '2':
        	selectTab = 2;
            sampleUrl = "/dps/samplefiles/02_FRESH_SKU_UPLOAD(Sample).xls";
        	break;
        case '3':
        	if(styleType=='1'){
        		selectTab = 3;
                sampleUrl = "/dps/samplefiles/03_ASTYLE_SKU_UPLOAD(Sample).xls";    		
        	}else if(styleType=='2'){
        		selectTab = 4;
                sampleUrl = "/dps/samplefiles/04_BSTYLE_SKU_UPLOAD(Sample).xls";
        	}
            break;
    }
    
    setTabItemIndex("TAB_MAIN",selectTab);
    document.getElementById("A_EXCEL_DOWN").href = sampleUrl;
    codeObj.Focus();
}
 
/**
 * loadExcelData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function excelDown(){
	var href = document.getElementById("A_EXCEL_DOWN").href;
	
    EM_PUMBUN_CD.Focus();
	if( href.substring(href.length-1) != "#"){
        return;
	}
    showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
}


/**
 * checkExcelTamplet()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : Excel파일 의 형식을 체크한다.
 * return값 :
 */
function checkExcelTamplet( excelFileName, dataSet, headEndRow, headNameList, sheetIndex){
	if(headNameList == null || excelFileName == null || dataSet == null || headEndRow < 1){
		return true;
	}
    //loadExcelData 옵션처리
    var strStartRow   = 0;                 //시작Row
    var strEndRow     = headEndRow;        //끝Row
    var strReadType   = 0;                 //읽기모드
    var strBlankCount = 0;                 //공백row개수
    var strLFTOCR     = 0;                 //줄바꿈처리 
    var strFireEvent  = 1;                 //이벤트발생
    var strSheetIndex = sheetIndex == null? 1:sheetIndex;                 //Sheet Index 추가
    var strOption = excelFileName
                  + "," + strStartRow + "," + strEndRow + "," + strReadType 
                  + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
                  + "," + strSheetIndex;
    
    dataSet.ClearData();
    // Excel파일 DateSet에 저장               
    dataSet.Do("Excel.Application", strOption);
    //엑셀을 닫아준다.
    dataSet.Do("Excel.Close");
    if( dataSet.CountRow < headEndRow){
        dataSet.ClearData();
        return false;    	
    }
    var tmp = "";
    for( var row=1; row<=headEndRow ; row++){
    	if( row != 1)
    		tmp += "||";
    	for(var col=1; col<=dataSet.CountColumn; col++){
    		if(col!=1)
    			tmp += ",";
    		tmp += dataSet.OrgValue(row,col);
    	}
    }
    dataSet.ClearData();
    return headNameList == tmp;    
}
/**
 * loadExcelData()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {
	 
	clearAllItem();
	
	var pumbunCd = EM_PUMBUN_CD.Text; 
    if( pumbunCd == ""){
    // ()은/는 반드시 입력해야 합니다.
	    showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
	    EM_PUMBUN_CD.Focus();
	    return;
	}
	// 파일 선택 다이얼 실행
    INF_EXCELUPLOAD.Open();
	 

    EM_FILS_LOC.text  = INF_EXCELUPLOAD.Value;  //경로명 표기
     
    var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름     
    if (strExcelFileName == "''")
        return;
    //loadExcelData 옵션처리
    var strStartRow   = 1;                 //시작Row
    var strEndRow     = 0;                 //끝Row
    var strReadType   = 0;                 //읽기모드
    var strBlankCount = 0;                 //공백row개수
    var strLFTOCR     = 0;                 //줄바꿈처리 
    var strFireEvent  = 1;                 //이벤트발생
    var strSheetIndex = 1;                 //Sheet Index 추가

     
    var strOption = strExcelFileName
                  + "," + strStartRow + "," + strEndRow + "," + strReadType 
                  + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
                  + "," + strSheetIndex;

    DS_EXECL_LOAD.ClearAll();
    var dataSetId = "";
    var strCheckType = "";
    var grid;
    var gridTamplet = "";
    switch(getTabItemSelect("TAB_MAIN")){
        case 1:
            dataSetId = 'DS_SKU';
            grid = GD_SKU;
            strCheckType = 1;
            DS_EXECL_LOAD.setDataHeader('<gauce:dataset name="H_EXCEL_SKU"/>');
//             gridTamplet =  "단품명,영수증명,품목코드,소스마킹코드,모델코드,판매단위코드,기본규격,기본규격단위코드,구성규격,구성규격단위코드,원산지코드";
            gridTamplet =  "단품명,영수증명,품목코드,소스마킹코드,브랜드상품코드,판매단위코드,기본규격,기본규격단위코드,구성규격,구성규격단위코드,원산지코드";
            break;
        case 2:
            dataSetId = 'DS_FRESH';
            grid = GD_FRESH;
            strCheckType = 2;
            DS_EXECL_LOAD.setDataHeader('<gauce:dataset name="H_EXCEL_FRESH"/>');
            gridTamplet =  "단품명,영수증명,품목코드,판매단위코드,기본규격,기본규격단위코드,구성규격,구성규격단위코드,원산지코드";
            break;
        case 3:
            dataSetId = 'DS_ASTYLE';
            grid = GD_ASTYLE;
            strCheckType = 3;
            DS_EXECL_LOAD.setDataHeader('<gauce:dataset name="H_EXCEL_ASTYLE"/>');    
            gridTamplet =  "스타일명,영수증명,스타일코드,칼라코드,사이즈코드,사이즈타입코드,성별,품목코드,소스마킹코드,업체스타일코드,판매단위코드,기본규격,기본규격단위코드,구성규격,구성규격단위코드,원산지코드";
            break;
        case 4:
            dataSetId = 'DS_BSTYLE';
            grid = GD_BSTYLE;
            strCheckType = 4;
            DS_EXECL_LOAD.setDataHeader('<gauce:dataset name="H_EXCEL_BSTYLE"/>');
            gridTamplet =  "스타일명,영수증명,브랜드코드,서브브랜드코드,관리항목코드1,관리항목코드2,관리항목코드3,관리항목코드4,관리항목코드5,사이즈타입코드,성별코드,품목코드,소스마킹코드,업체스타일코드,판매단위코드,기본규격,기본규격단위코드,구성규격,구성규격단위코드,원산지코드";
            break;
    }
    /* 템플릿 형식 체크
    if( !checkExcelTamplet( strExcelFileName, DS_EXECL_LOAD, strStartRow, gridTamplet)){
        showMessage(INFORMATION, OK, "USER-1000", "형식에 맞지않는 엑셀 템플릿 입니다.");    	
    	return;
    }
    */
    // Excel파일 DateSet에 저장               
    DS_EXECL_LOAD.Do("Excel.Application", strOption);

    //엑셀을 닫아준다.
    DS_EXECL_LOAD.Do("Excel.Close");
    
    if( dataSetId == "")
    	return;
    
    if(DS_EXECL_LOAD.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1000", "0 건 로드 되었습니다.");
        EM_PUMBUN_CD.Focus();
        return;
    }
    var goTo       = "checkExcelData" ;    
    var parameters = "&strPumbunCd="+encodeURIComponent(pumbunCd)
                   + "&strCheckType="+encodeURIComponent(strCheckType);
    TR_MAIN.Action="/dps/pcod505.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET(I:DS_EXECL_LOAD=DS_EXECL_LOAD,O:DS_RESULT="+dataSetId+")"; //조회는 O
    TR_MAIN.Post();
    
    if(eval(dataSetId).CountRow < 1){
        EM_PUMBUN_CD.Focus();
    }else{
    	showMessage(INFORMATION, OK, "USER-1000", eval(dataSetId).CountRow+ " 건 로드 되었습니다.");
        setFocusGrid(grid,eval(dataSetId),eval(dataSetId).RowPosition,"SEL");
    }
}
/**
 * clearAllItem()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : 모든 항목을 초기화한다.
 * return값 :
 */
function clearAllItem(){

    // 엑셀 파일명 초기화
    INF_EXCELUPLOAD.Value = '';
    EM_FILS_LOC.text = '';
    // 데이터셋 초기화
    DS_EXECL_LOAD.ClearData();

    DS_SKU.ClearData();
    DS_FRESH.ClearData();
    DS_ASTYLE.ClearData();
    DS_BSTYLE.ClearData();
    GD_SKU.ColumnProp('SEL','HeadCheck')= "FALSE";
    GD_FRESH.ColumnProp('SEL','HeadCheck')= "FALSE";
    GD_ASTYLE.ColumnProp('SEL','HeadCheck')= "FALSE";
    GD_BSTYLE.ColumnProp('SEL','HeadCheck')= "FALSE";
    
}
/**
 * clickGridHeadCheck()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.03.31
 * 개    요 : 그리드 헤더 클릭시 모든 로우 반영
 * return값 :
 */
function clickGridHeadCheck( dataSet, value){
	for( var i=1; i<=dataSet.CountRow; i++){
		dataSet.NameValue(i,"SEL") = value==1?"T":"F";
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
<script language="javascript"  for=GD_SKU event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_SKU,bCheck);
</script>
<script language="javascript"  for=GD_FRESH event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_FRESH,bCheck);
</script>
<script language="javascript"  for=GD_ASTYLE event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_ASTYLE,bCheck);
</script>
<script language="javascript"  for=GD_BSTYLE event=OnHeadCheckClick(Col,Colid,bCheck)>
    clickGridHeadCheck(DS_BSTYLE,bCheck);
</script>
<script language=JavaScript for=GD_SKU event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_FRESH event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_ASTYLE event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_BSTYLE event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setPumbunCode( "NAME");
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

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_EXECL_LOAD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CHECK_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_SKU"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FRESH"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_ASTYLE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_BSTYLE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 634px; top: 88px; width: 68px; height: 18px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=EM_PUMBUN_TYPE classid=<%=Util.CLSID_EMEDIT%>  
     style="position: absolute; left: 0; top: 0; width: 0; height: 0; visibility: hidden;">></object>
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=EM_SKU_TYPE classid=<%=Util.CLSID_EMEDIT%>  
     style="position: absolute; left: 0; top: 0; width: 0; height: 0; visibility: hidden;">></object>
</comment><script> _ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id=EM_STYLE_TYPE classid=<%=Util.CLSID_EMEDIT%>  
     style="position: absolute; left: 0; top: 0; width: 0; height: 0; visibility: hidden;">></object>
</comment><script> _ws_(_NSID_);</script>

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
<!-- 
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="396" class="title">
      <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05"/>
                      단품엑셀업로드
    </td>
    <td><table border="0" align="right" cellpadding="0" cellspacing="0">
      <tr>
        <td>
          <table border="0" cellspacing="0" cellpadding="0">
            <tr>    
              <td><img src="/<%=dir%>/imgs/btn/del.gif" border="0"  id="IMG_BTN_DEL"  onclick="javascript:btn_del();" ></td>
              <td><img src="/<%=dir%>/imgs/btn/apply.gif" border="0" id="IMG_BTN_APPLY" onclick="javascript:btn_apply();" ></td>
            </tr>   
          </table>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
 -->
<div id="testdiv" class="testdiv">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">브랜드</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%>  width=80 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_SEARCH_PUMBUN onclick="javascript:setPumbunCode('POP');" align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%>  width=150 tabindex=1 align="absmiddle"></object>
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
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" >
      <tr>
        <td class="PT03"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="100" >파일선택</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_FILS_LOC classid=<%=Util.CLSID_EMEDIT%> width=500 tabindex=1 align="absmiddle" ></object>
              </comment><script>_ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/file_search.gif" border="0"  id="IMG_FILE_SEARCH"  onclick="javascript:loadExcelData();" align="absmiddle" hspace="3">
              <a href="#" align="absmiddle" id=A_EXCEL_DOWN onClick="javascript:excelDown();">
                <img src="/<%=dir%>/imgs/btn/excel_down.gif" border="0" align="absmiddle" >
              </a>
            </td >
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td  class="PT10"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top">
          <div id=TAB_MAIN  width="100%" height=468 TitleWidth=110 TitleAlign="center" >
             <menu TitleName="규격단품"       DivId="tab_page1" Enable='false' />
             <menu TitleName="신선단품"       DivId="tab_page2" Enable='false' />
             <menu TitleName="의류잡화단품A"      DivId="tab_page3" Enable='false' />
             <menu TitleName="의류잡화단품B"      DivId="tab_page4" Enable='false' />
          </div>
          <div id=tab_page1 width="100%" >
            <table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%">
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_SKU width="100%" height=440 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_SKU">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </div>
          <div id=tab_page2 width="100%" >
            <table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%">
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_FRESH width="100%" height=440 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_FRESH">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </div>
          <div id=tab_page3 width="100%" >
            <table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%">
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_ASTYLE width="100%" height=440 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_ASTYLE">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </div>
          <div id=tab_page4 width="100%" >
            <table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%">
              <tr>
                <td>
                  <comment id="_NSID_"><object id=GD_BSTYLE width="100%" height=440 classid=<%=Util.CLSID_GRID%> tabindex=1>
                    <param name="DataID" value="DS_BSTYLE">
                  </object></comment><script>_ws_(_NSID_);</script>
                </td>
              </tr>
            </table>
          </div>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>
