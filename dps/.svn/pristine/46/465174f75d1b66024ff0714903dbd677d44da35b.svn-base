<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 당초계획
 * 작 성 일 : 2010.03.14
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal1050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 당초PC별월매출계획
 * 이    력 :2010.03.14 박종은
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
   request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
   String dir = BaseProperty.get("context.common.dir");
%>

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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 310;		//해당화면의 그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_IO_DETAIL_ORG.setDataHeader('<gauce:dataset name="H_SEL_DETAIL_ORG"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    gridCreate4(); //디테일
    
    // EMedit에 초기화
    initEmEdit(EM_PLAN_YEAR, "YYYY", PK);                                            //계획년
    EM_PLAN_YEAR.alignment = 1;
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점(조회)
    
    //팀
    initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, PK);            //팀(조회)
    
    //파트
    initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);            //파트(조회)
    
    getStore("DS_STR_CD", "Y", "", "N");                                           // 점        
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                          // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");   // 파트  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    
    //현재년도 셋팅
    EM_PLAN_YEAR.text = today.getYear();
    GD_MASTER.Focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal105","DS_IO_DETAIL,DS_O_MASTER" );
        
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                name="NO"                 width=30     align=center   </FC>'
                     + '<FC>id=CONF_FLAG               name="확정"              width=30     align=center       Edit= none     EditStyle=CheckBox        HeadCheck=false   HeadCheckShow=false</FC>'
                     + '<FC>id=STR_CD                  name="점"             width=40     align=center    Edit=none   </FC>'
                     + '<FC>id=STR_NAME                name="점명"               width=70     align=left      Edit=none   </FC>'
                     + '<FC>id=DEPT_CD                 name="팀"               width=40     align=center    Edit=none   </FC>'
                     + '<FC>id=TEAM_CD                 name="파트"             width=40     align=center    Edit=none   </FC>'
                     + '<FC>id=ORG_NAME                name="파트명"               width=80     align=left      Edit=none   SumText="합계" </FC>'
                     + '<FC>id=PLAN_YEAR               name="목표년도"           width=100    align=left      Edit=""      show=false</FC>'
                     + '<G>                            name="파트별월매출목표합계"'
                     + '<C>id=ORIGIN_NORM_SAMT_TOT     name="정상매출"     width=100     align=right      Edit=none      SumText={SubSum(ORIGIN_NORM_SAMT_TOT)}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_TOT      name="행사매출"     width=100     align=right      Edit=none      SumText={SubSum(ORIGIN_EVT_SAMT_TOT)}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_TOT     name="총매출"       width=100     align=right      Edit=none      SumText={SubSum(ORIGIN_SALE_TAMT_TOT)}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_TOT     name="이익"         width=100     align=right      Edit=none      SumText={SubSum(ORIGIN_PROF_TAMT_TOT)}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_TOT    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_TOT    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="1월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JAN     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_JAN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JAN      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_JAN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JAN     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_JAN)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JAN     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_JAN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JAN    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JAN    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="2월"'
                     + '<C>id=ORIGIN_NORM_SAMT_FEB     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_FEB)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_FEB      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_FEB)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_FEB     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_FEB)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_FEB     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_FEB)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_FEB    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_FEB    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="3월"'
                     + '<C>id=ORIGIN_NORM_SAMT_MAR     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_MAR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_MAR      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_MAR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_MAR     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_MAR)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_MAR     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_MAR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_MAR    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_MAR    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="4월"'
                     + '<C>id=ORIGIN_NORM_SAMT_APR     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_APR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_APR      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_APR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_APR     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_APR)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_APR     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_APR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_APR    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_APR    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="5월"'
                     + '<C>id=ORIGIN_NORM_SAMT_MAY     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_MAY)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_MAY      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_MAY)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_MAY     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_MAY)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_MAY     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_MAY)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_MAY    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_MAY    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="6월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JUN     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_JUN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JUN      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_JUN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JUN     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_JUN)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JUN     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_JUN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JUN    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JUN    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="7월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JUL     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_JUL)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JUL      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_JUL)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JUL     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_JUL)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JUL     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_JUL)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JUL    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JUL    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="8월"'
                     + '<C>id=ORIGIN_NORM_SAMT_AUG     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_AUG)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_AUG      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_AUG)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_AUG     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_AUG)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_AUG     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_AUG)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_AUG    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_AUG    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="9월"'
                     + '<C>id=ORIGIN_NORM_SAMT_SEP     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_SEP)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_SEP      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_SEP)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_SEP     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_SEP)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_SEP     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_SEP)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_SEP    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_SEP    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="10월"'
                     + '<C>id=ORIGIN_NORM_SAMT_OCT     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_OCT)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_OCT      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_OCT)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_OCT     name="총매출"       width=100     align=right     SumText={SubSum(ORIGIN_SALE_TAMT_OCT)}     Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_OCT     name="이익"         width=100     align=right     SumText={SubSum(ORIGIN_PROF_TAMT_OCT)}     Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_OCT    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_OCT    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                                  
                     + '<G>                            name="11월"'
                     + '<C>id=ORIGIN_NORM_SAMT_NOV     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_NOV)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_NOV      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_NOV)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_NOV     name="총매출"       width=100     align=right     SumText={SubSum(ORIGIN_SALE_TAMT_NOV)}     Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_NOV     name="이익"         width=100     align=right     SumText={SubSum(ORIGIN_PROF_TAMT_NOV)}     Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_NOV    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_NOV    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="12월"'
                     + '<C>id=ORIGIN_NORM_SAMT_DEC     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_DEC)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_DEC      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_DEC)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_DEC     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_DEC)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_DEC     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_DEC)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_DEC    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_DEC    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                                                           
                     + '<C>id=ERROR_CHECK              name="에러체크"     width=80     align=right      Edit=none    show=false </C>'
                     + '<C>id=CONF_FLAG                name="확정구분"     width=80     align=right      Edit=none    show=false </C>'
                     ;
                    
    
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
}

function gridCreate4(){
    var hdrProperies = '<FC>id={currow}            name="NO"              width=30    align=center                     </FC>'
                     + '<FC>id=STR_CD              name="점"              width=40    align=center        Edit=none    </FC>'
                     + '<FC>id=STR_NAME            name="점명"            width=80    align=left          Edit=none    </FC>'
                     + '<FC>id=ORG_CD              name="조직"        width=120    align=center        Edit=none    </FC>'
                     + '<FC>id=PLAN_YM             name="목표;년월"       width=60    align=center        Edit=none   </FC>'
                     + '<FC>id=ORG_LEVEL           name="조직;레벨"       width=40    align=center        Edit=none   </FC>'
                     + '<FC>id=DEPT_CD             name="팀"            width=40    align=center        Edit=none   </FC>'
                     + '<C>id=DEPT_ORG_NAME        name="팀명"          width=100   align=left          Edit=none   </C>'
                     + '<FC>id=TEAM_CD             name="파트"              width=40    align=center        Edit=none   </FC>'
                     + '<C>id=TEAM_ORG_NAME        name="파트명"            width=100   align=left          Edit=none   </C>'
                     + '<FC>id=PC_CD               name="PC"              width=40    align=center        Edit=none   </FC>'
                     + '<C>id=PC_ORG_NAME          name="PC명"            width=110   align=left          Edit=none   </C>'
                     + '<G>                        name="전년매출"'
                     + '<C>id=BFYY_NORM_SAMT       name="정상"            width=100    align=right         Edit=none    </C>'
                     + '<C>id=BFYY_EVT_SAMT        name="행사"            width=100    align=right         Edit=none    </C>'
                     + '<C>id=BFYY_SALE_TAMT       name="총매출"          width=100    align=right         Edit=none    </C>'
                     + '<C>id=BFYY_PROF_TAMT       name="이익"            width=100    align=right         Edit=none    </C>'
                     + '<C>id=BFYY_SALE_CRATE      name="매출구성비"      width=80    align=right Dec=2   Edit=none    </C>'
                     + '<C>id=BFYY_PROF_CRATE      name="이익구성비"      width=80    align=right Dec=2   Edit=none    </C>'
                     + '</G> '
                     + '<G>                        name="목표매출"'
                     + '<C>id=ORIGIN_NORM_SAMT     name="정상"            width=100    align=right         Edit=""      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT      name="행사"            width=100    align=right         Edit=""      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT     name="총매출"          width=100    align=right         Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT     name="이익"            width=100    align=right         Edit=""      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE    name="매출구성비"      width=80    align=right Dec=2   Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE    name="이익구성비"      width=80    align=right Dec=2   Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE    name="매출신장율"      width=80    align=right Dec=2   Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_IRATE    name="이익신장율"      width=80    align=right Dec=2   Edit=none    </C>'
                     + '</G> '
                     + '<C>id=ERROR_CHECK          name="에러체크"        width=80    align=right         Edit=none    show=false </C>'
                     + '<C>id=CONF_FLAG            name="확정구분"     width=80     align=right      Edit=none    show=false </C>'
                     ;
                    
    
    initGridStyle(GD_DETAIL_ORG, "common", hdrProperies, true);
    DS_IO_DETAIL_ORG.UseChangeInfo = false;  
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}                name="NO"           width=30     align=center     BgColor={decode(ERROR_CHECK,"","white","yellow")} </FC>'
                     + '<FC>id=STR_CD                  name="점"           width=40     align=center     Edit=none    show=false    BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</FC>'
                     + '<FC>id=DEPT_CD                 name="팀"         width=40     align=center     Edit=none    show=false    BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</FC>'
                     + '<FC>id=TEAM_CD                 name="파트"           width=40     align=center     Edit=none    show=false    BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</FC>'
                     + '<FC>id=PC_CD                   name="PC"           width=40     align=center     Edit=none    Suppress="1"     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</FC>'
                     + '<FC>id=ORG_NAME                name="PC명"         width=110     align=left       Edit=none    Suppress="1"     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</FC>'
                     + '<FC>id=GUBUN                   name="구분"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=70     align=center     Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</FC>'
                     + '<G>                            name="PC별월매출목표합계"'
                     + '<C>id=ORIGIN_NORM_SAMT_TOT     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_TOT      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_TOT     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_TOT     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_TOT    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_TOT    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="1월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JAN     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JAN      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JAN     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JAN     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JAN    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JAN    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_JAN    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_JAN    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="2월"'
                     + '<C>id=ORIGIN_NORM_SAMT_FEB     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_FEB      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_FEB     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_FEB     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_FEB    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_FEB    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_FEB    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_FEB    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="3월"'
                     + '<C>id=ORIGIN_NORM_SAMT_MAR     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_MAR      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_MAR     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}     width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_MAR     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_MAR    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_MAR    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_MAR    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_MAR    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="4월"'
                     + '<C>id=ORIGIN_NORM_SAMT_APR     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_APR      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_APR     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_APR     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_APR    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_APR    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_APR    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_APR    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="5월"'
                     + '<C>id=ORIGIN_NORM_SAMT_MAY     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_MAY      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_MAY     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_MAY     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_MAY    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_MAY    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_MAY    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_MAY    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="6월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JUN     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JUN      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JUN     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JUN     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JUN    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JUN    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_JUN    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_JUN    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="7월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JUL     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JUL      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JUL     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JUL     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JUL    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JUL    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_JUL    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_JUL    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="8월"'
                     + '<C>id=ORIGIN_NORM_SAMT_AUG     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_AUG      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_AUG     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_AUG     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))} </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_AUG    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_AUG    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_AUG    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_AUG    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="9월"'
                     + '<C>id=ORIGIN_NORM_SAMT_SEP     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_SEP      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_SEP     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_SEP     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_SEP    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_SEP    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_SEP    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_SEP    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="10월"'
                     + '<C>id=ORIGIN_NORM_SAMT_OCT     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_OCT      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_OCT     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_OCT     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_OCT    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_OCT    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_OCT    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_OCT    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                                     
                     + '<G>                            name="11월"'
                     + '<C>id=ORIGIN_NORM_SAMT_NOV     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_NOV      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_NOV     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_NOV     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_NOV    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_NOV    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_NOV    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_NOV    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                          
                     + '<G>                            name="12월"'
                     + '<C>id=ORIGIN_NORM_SAMT_DEC     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_DEC      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_DEC     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_DEC     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit={if(GUBUN="전년매출",none,if(ORG_NAME = "합계", none,if(ORG_NAME = "", none,if(ORG_NAME = "오차", none,if(CONF_FLAG = "Y" , none, "")))))}          BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_DEC    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_CRATE_DEC    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none        BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_SALE_IRATE_DEC    name="매출신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '<C>id=ORIGIN_PROF_IRATE_DEC    name="이익신장율"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    show=false     BgColor={if(ORG_NAME = "" OR ORG_NAME = "합계" OR ORG_NAME = "오차","skyblue",if(ERROR_CHECK = "","white","orange"))}</C>'
                     + '</G>'                                                           
                     + '<C>id=ERROR_CHECK              name="에러체크"     width=80     align=right      Edit=none    show=false </C>'
                     + '<C>id=CONF_FLAG                name="확정구분"     width=80     align=right      Edit=none    show=false </C>'
                     ;
                    

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
   
    DS_IO_DETAIL.UseChangeInfo = false;  
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-04
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    if (DS_IO_DETAIL.IsUpdated ){
        ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }    
    
    
    
    //점 체크
    if (isNull(LC_STR_CD.BindColVal)==true ) {
        showMessage(INFORMATION, OK, "USER-1003","점");
        return;
    }
    
    //팀 체크
    if (isNull(LC_DEPT_CD.BindColVal)==true ) {
        showMessage(INFORMATION, OK, "USER-1003","팀");
        return;
    }
    
    //계획년도
    if (isNull(EM_PLAN_YEAR.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","목표년도"); 
        return;
    }
    //계획년도 자릿수, 공백 체크
    if (EM_PLAN_YEAR.text.replace(" ","").length != 4 ) {
        showMessage(INFORMATION, OK, "USER-1027","목표년도","4");
        return;
    }
    
    //마스터 그리드 클리어
    DS_O_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPlanYear     = EM_PLAN_YEAR.text;         //계획년도
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);
    
    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    
    old_Row = 1;
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);

    // 조회결과 Return
    setPorcCount("SELECT", DS_O_MASTER.CountRow);
    //searchDetail();
    
}

/**
 * btn_New()
 * 작 성 자 : 박종은  
 * 작 성 일 : 2010-03-07
 * 개    요 :  화면 클리어
 * return값 : 
 */
function btn_New() {
    
    moveDetailOrg();
    
    if (DS_IO_DETAIL.IsUpdated ){
        ret = showMessage(QUESTION, YESNO, "USER-1085");
        if (ret != "1") {
            return false;
        } 
    }

    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();

    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';     // 로그인 점코드
    LC_STR_CD.bindcolval = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    EM_PLAN_YEAR.text = today.getYear();
    return;
    
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Delete() {

}

function change_irate(gubun) {
	
	
for(var i=1; i <= DS_IO_DETAIL.CountRow; i++){
	    
		if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차" ){
	       
	    	
	        
	        //매출신장율,이익신장율
	        
	        if(i> 1){
	        	
	        	if(gubun == "ORIGIN_NORM_SAMT_JAN" || gubun == "ORIGIN_EVT_SAMT_JAN" ) {
	            
		            //1월
		            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JAN"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
		                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JAN") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JAN"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JAN"),2))*100.00,2);
		                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JAN"),2) >= 1000.00){
		                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JAN") = 999.99;
		                }
		            }
		            else{
		                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JAN") = 0.00;
		            }
	        	
	        	}
	        	
	        	if(gubun == "ORIGIN_PROF_TAMT_JAN") {
	        		
		        	if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JAN"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
		                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JAN") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JAN"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JAN"),2))*100.00,2);
		                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JAN"),2) >= 1000.00){
		                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JAN") = 999.99;
		                }
		            }
		            else{
		                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JAN") = 0.00;
		            }
	        	}
	        	
	        	if(gubun == "ORIGIN_NORM_SAMT_FEB" || gubun == "ORIGIN_EVT_SAMT_FEB" ) {
		            //2월
		            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_FEB"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
		                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_FEB") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_FEB"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_FEB"),2))*100.00,2);
		                
		                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_FEB"),2) >= 1000.00){
		                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_FEB") = 999.99;
		                }
		            }
		            else{
		                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_FEB") = 0.00;
		            }
	        	}
	        	
	        	if(gubun == "ORIGIN_PROF_TAMT_FEB") {
	        	
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_FEB"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_FEB") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_FEB"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_FEB"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_FEB"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_FEB") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_FEB") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_NORM_SAMT_MAR" || gubun == "ORIGIN_EVT_SAMT_MAR" ) {  
	            //3월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAR"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAR") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAR"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAR"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAR"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAR") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAR") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_PROF_TAMT_MAR") { 
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAR"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAR") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAR"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAR"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAR"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAR") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAR") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_NORM_SAMT_APR" || gubun == "ORIGIN_EVT_SAMT_APR" ) {    
	            //4월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_APR"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_APR") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_APR"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_APR"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_APR"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_APR") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_APR") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_PROF_TAMT_APR") {    
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_APR"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_APR") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_APR"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_APR"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_APR"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_APR") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_APR") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_NORM_SAMT_MAY" || gubun == "ORIGIN_EVT_SAMT_MAY" ) {       
	            //5월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAY"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAY") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAY"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAY"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAY"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAY") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAY") = 0.00;
	            }
	           }
	           
	           if(gubun == "ORIGIN_PROF_TAMT_MAY") {     
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAY"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAY") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAY"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAY"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAY"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAY") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAY") = 0.00;
	            }
	           }
	           
	          if(gubun == "ORIGIN_NORM_SAMT_JUN" || gubun == "ORIGIN_EVT_SAMT_JUN" ) {         
	            //6월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUN"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUN") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUN"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUN"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUN"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUN") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUN") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_PROF_TAMT_JUN") {       
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUN"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUN") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUN"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUN"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUN"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUN") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUN") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_NORM_SAMT_JUL" || gubun == "ORIGIN_EVT_SAMT_JUL" ) {           
	            //7월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUL"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUL") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUL"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUL"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUL"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUL") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUL") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_PROF_TAMT_JUL") {         
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUL"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUL") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUL"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUL"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUL"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUL") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUL") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_NORM_SAMT_AUG" || gubun == "ORIGIN_EVT_SAMT_AUG" ) {             
	            //8월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_AUG"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_AUG") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_AUG"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_AUG"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_AUG"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_AUG") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_AUG") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_PROF_TAMT_AUG") {           
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_AUG"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_AUG") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_AUG"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_AUG"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_AUG"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_AUG") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_AUG") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_NORM_SAMT_SEP" || gubun == "ORIGIN_EVT_SAMT_SEP" ) {               
	            //9월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_SEP"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_SEP") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_SEP"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_SEP"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_SEP"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_SEP") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_SEP") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_PROF_TAMT_SEP") {              
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_SEP"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_SEP") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_SEP"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_SEP"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_SEP"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_SEP") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_SEP") = 0.00;
	            }
	          }
	          
	          if(gubun == "ORIGIN_NORM_SAMT_OCT" || gubun == "ORIGIN_EVT_SAMT_OCT" ) {                 
	            //10월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_OCT"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_OCT") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_OCT"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_OCT"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_OCT"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_OCT") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_OCT") = 0.00;
	            }
	         }
	         if(gubun == "ORIGIN_PROF_TAMT_OCT") {                 
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_OCT"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_OCT") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_OCT"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_OCT"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_OCT"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_OCT") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_OCT") = 0.00;
	            }
	         } 
	         
	         if(gubun == "ORIGIN_NORM_SAMT_NOV" || gubun == "ORIGIN_EVT_SAMT_NOV" ) {                  
	            //11월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_NOV"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_NOV") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_NOV"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_NOV"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_NOV"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_NOV") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_NOV") = 0.00;
	            }
	         }
	         if(gubun == "ORIGIN_PROF_TAMT_NOV") {                    
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_NOV"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_NOV") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_NOV"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_NOV"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_NOV"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_NOV") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_NOV") = 0.00;
	            }
	         }  
	         
	         if(gubun == "ORIGIN_NORM_SAMT_DEC" || gubun == "ORIGIN_EVT_SAMT_DEC" ) {                  
	            //12월
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_DEC"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_DEC") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_DEC"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_DEC"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_DEC"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_DEC") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_DEC") = 0.00;
	            }
	            
	         }
	         
	         if(gubun == "ORIGIN_PROF_TAMT_DEC") {        
	            
	            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_DEC"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_DEC") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_DEC"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_DEC"),2))*100.00,2);
	                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_DEC"),2) >= 1000.00){
	                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_DEC") = 999.99;
	                }
	            }
	            else{
	                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_DEC") = 0.00;
	            }
	            
	          }
	            
	        }
	        
	         
	    }
	}
}
/**
 * btn_Save()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-04
 * 개    요 : DB에 저장  / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	//preSave();
    moveDetailOrg();
    if (!DS_IO_DETAIL.IsUpdated ){
        //저장할 내용이 없습니다
        
        showMessage(QUESTION, OK, "USER-1028");
        return;
    }
   
    //당초파트별년매출계획 확정체크
    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
    var strDeptCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");        //팀코드
    var strTeamCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");        //파트코드
    var strPlanYear  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PLAN_YEAR");      //계획년도

    var goTo       = "searchConfFlag" ;    
    var action     = "O";     
    var parameters = "&strStrCd="        +encodeURIComponent(strStrCd)
                   + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="     +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKCONFFLAG=DS_CHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_CHKCONFFLAG.countRow == 0) {
        showMessage(INFORMATION, OK, "USER-1000", "당초 파트별 월 매출목표가 미확정된 데이터입니다.확정 후 다시 등록하십시오.");
        return;
    }

    var goTo       = "searchConfFlagPC" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_MCHKCONFFLAG.countRow != 0 && DS_MCHKCONFFLAG.NameValue(1,"CONF_FLAG") != "N") {
        showMessage(INFORMATION, OK, "USER-1000", "당초PC별월매출목표가 확정된 데이터입니다.확정취소 후 다시 등록하십시오.");
        return;
    }
    
    var goTo       = "searchConfFlagM" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_MCHKCONFFLAG.countRow != 0) {
        showMessage(INFORMATION, OK, "USER-1000", "당초브랜드별월매출목표가 확정된 데이터입니다.확정취소 후 다시 등록하십시오.");
        return;
    }
    
    for(i=1; i <= DS_IO_DETAIL_ORG.CountRow; i++){
        if(checkYYYYMM(DS_IO_DETAIL_ORG.NameValue(i,"PLAN_YM")) != true){
            showMessage(INFORMATION, OK, "USER-1000", "년월형식이 일치하지 않습니다. 확인하여 주십시오.");
            return;
        }
    }
    
    errorRow ="";
    errcnt = 0;
    errorchk();
    
    if(errcnt > 0){
        showMessage(INFORMATION, OK, "USER-1000",errorRow+" 행이 데이터 정합성이 일치하지 않습니다.");
        var noCheckRow = errorRow.split(",");
        for(i=1; i <= noCheckRow.length; i++){
            for(j=1; j <= DS_IO_DETAIL.CountRow; j++ ){
                if(noCheckRow[i-1] == j ){
                    DS_IO_DETAIL.NameValue(j,"ERROR_CHECK") = "TRUE";
                    break;
                }
            }
        }
        return;
    }
    
    //당초년매출계획과 월매출계획합계 비교
    if(comparecheck() != true){
    	return;
    }
    
    //중복된 데이터 체크 
    var retChk  = checkDupKey(DS_IO_DETAIL, "PLAN_YM||DEPT_CD||TEAM_CD||PC_CD||GUBUN");
    
    if (retChk != 0) {
        showMessage(INFORMATION, OK, "USER-1044",retChk);
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
        return;
    
    var parameters = "&strStrCd="        +encodeURIComponent(strStrCd)
                   + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="     +encodeURIComponent(strPlanYear);
    
    TR_MAIN.Action="/dps/psal105.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL_ORG=DS_IO_DETAIL_ORG)"; //조회는 O
    TR_MAIN.Post();

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        DS_IO_DETAIL.ResetStatus();
        btn_Search();
        DS_O_MASTER.RowPosition = DS_O_MASTER.NameValueRow("TEAM_CD",strTeamCd);
        searchDetail();
    }
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
* chkSave()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  저장
* return값 : void
*/
function chkSave(){
    
    //당초파트별년매출계획 확정체크
    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
    var strDeptCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");        //팀코드
    var strTeamCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");        //파트코드
    var strPlanYear  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PLAN_YEAR");      //계획년도

    var goTo       = "searchConfFlag" ;    
    var action     = "O";     
    var parameters = "&strStrCd="        +encodeURIComponent(strStrCd)
                   + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="     +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKCONFFLAG=DS_CHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_CHKCONFFLAG.countRow == 0) {
        showMessage(INFORMATION, OK, "USER-1000", "당초 파트별 월 매출목표가  미확정된 데이터입니다.확정 후 다시 등록하십시오.");
        return;
    }

    var goTo       = "searchConfFlagPC" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_MCHKCONFFLAG.countRow != 0 && DS_MCHKCONFFLAG.NameValue(1,"CONF_FLAG") != "N") {
        showMessage(INFORMATION, OK, "USER-1000", "당초PC별월매출목표가 확정된 데이터입니다.확정취소 후 다시 등록하십시오.");
        return;
    }
    
    var goTo       = "searchConfFlagM" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_MCHKCONFFLAG.countRow != 0) {
        showMessage(INFORMATION, OK, "USER-1000", "당초브랜드별월매출가 확정된 데이터입니다.확정취소 후 다시 등록하십시오.");
        return;
    }
    
    for(i=1; i <= DS_IO_DETAIL_ORG.CountRow; i++){
        if(checkYYYYMM(DS_IO_DETAIL_ORG.NameValue(i,"PLAN_YM")) != true){
            showMessage(INFORMATION, OK, "USER-1000", "년월형식이 일치하지 않습니다. 확인하여 주십시오.");
            return;
        }
    }
    
    errorRow ="";
    errcnt = 0;
    errorchk();
    
    if(errcnt > 0){
        showMessage(INFORMATION, OK, "USER-1000",errorRow+" 행이 데이터 정합성이 일치하지 않습니다.");
        var noCheckRow = errorRow.split(",");
        for(i=1; i <= noCheckRow.length; i++){
            for(j=1; j <= DS_IO_DETAIL.CountRow; j++ ){
                if(noCheckRow[i-1] == j ){
                    DS_IO_DETAIL.NameValue(j,"ERROR_CHECK") = "TRUE";
                    break;
                }
            }
        }
        return;
    }
    
    //당초년매출계획과 월매출계획합계 비교
    if(comparecheck() != true){return;}
    
    //중복된 데이터 체크 
    var retChk  = checkDupKey(DS_IO_DETAIL, "PLAN_YM||DEPT_CD||TEAM_CD||PC_CD||GUBUN");
    
    if (retChk != 0) {
        showMessage(Information, OK, "USER-1044",retChk);
        return;
    }
    
    var parameters = "&strStrCd="        +encodeURIComponent(strStrCd)
                   + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="     +encodeURIComponent(strPlanYear);
    
    TR_MAIN.Action="/dps/psal105.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL_ORG=DS_IO_DETAIL_ORG)"; //조회는 O
    TR_MAIN.Post();
    

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
        DS_IO_DETAIL.ResetStatus();
        DS_O_MASTER.RowPosition = DS_O_MASTER.NameValueRow("TEAM_CD",strTeamCd);
    }
}

/**
* loadExcelData()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 : Excel파일 DateSet에 저장
* return값 :
*/
function loadExcelData() {


    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_DETAIL.IsUpdated || DS_IO_DETAIL_ORG.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1086");
        if (ret != "1") {
            return false;
        } 
    }

    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
    var strDeptCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");        //팀코드
    var strTeamCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");        //파트코드
    var strPlanYear  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PLAN_YEAR");      //계획년도
    
    var goTo       = "searchConfFlagPC" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_MCHKCONFFLAG.countRow != 0 && DS_MCHKCONFFLAG.NameValue(1,"CONF_FLAG") != "N") {
        showMessage(INFORMATION, OK, "USER-1000", "당초PC별월매출목표가 확정된 데이터입니다.확정취소 후 다시 등록하십시오.");
        return;
    }
    
    if(DS_O_MASTER.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1000","조회 후 업로드 가능합니다.");
        return;
    }
    
    // 엑셀 파일명 초기화
    INF_EXCELUPLOAD.Value = '';
    //Fils Open창
    INF_EXCELUPLOAD.Open();
    
    //loadExcelData 옵션처리
    var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
    if (strExcelFileName == "''")
    return;

    DS_IO_DETAIL_ORG.ClearData();
    DS_IO_DETAIL.ClearData();

    var strStartRow     = 7;    //시작Row
    var strEndRow       = 0;   //끝Row
    var strReadType     = 0;    //읽기모드
    var strBlankCount   = 0;    //공백row개수
    var strLFTOCR       = 0;    //줄바꿈처리 
    var strFireEvent    = 1;    //이벤트발생
    var strSheetIndex   = 1;    //Sheet Index 추가
    var strtrEtc        = "1";  //엑셀 컬럼에 1000단위 구분기호(,)가 있을 경우, 구분기호를 무시하고 데이터를 가져온다. (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,72    UMX: 2,0,1,72 이상버전 사용가능)
    var strtrcol        = 0;    //Excel 파일에서 읽어 들일 시작 Col 위치 (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,80    UMX: 2,0,1,80 이상버전 사용가능)
    
    
    
    var strOption = strExcelFileName
                  + "," + strStartRow + "," + strEndRow + "," + strReadType 
                  + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
                  + "," + strSheetIndex + "," + strtrEtc+ "," + strtrcol;
    
    //Excel파일 DateSet에 저장               
    DS_IO_DETAIL_ORG.Do("Excel.Application", strOption);
    
    //DateSet에 저장 후  Excel Header ROW삭제(첫행)
    DS_IO_DETAIL_ORG.DeleteRow(1);

    //전년매출데이터
    searchBFYY();
    
    GD_DETAIL.ReDraw = false;
    moveDetail();
    GD_DETAIL.ReDraw = true;

    //수식계산
    changecolumn();
    //에러체크 변경
    checkChange();
    //에러체크상태변경
    errorState();
    //합계
    GD_DETAIL.ReDraw = false;
    ln_sum();
    GD_DETAIL.ReDraw = true;
    //스크롤바 위치 조정
    GD_DETAIL.SETVSCROLLING(0);
    GD_DETAIL.SETHSCROLLING(0);
}
 

/**
* searchBFYY()
* 작 성 자 : 박종은
* 작 성 일 : 2010.03.21
* 개     요 : 전년실적 조회
* return값 :
*/
function searchBFYY(){
    var j = 0;
  
    for(i=1; i <= DS_IO_DETAIL_ORG.CountRow; i++){
        j = i;
        
        var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
        var strDeptCd       = DS_IO_DETAIL_ORG.NameValue(i,"DEPT_CD");        //팀
        var strTeamCd       = DS_IO_DETAIL_ORG.NameValue(i,"TEAM_CD");        //파트
        var strPCCd         = DS_IO_DETAIL_ORG.NameValue(i,"PC_CD");          //PC
        var strPlanYm       = DS_IO_DETAIL_ORG.NameValue(i,"PLAN_YM");        //년도

        if(strStrCd == "" || strDeptCd == "" || strTeamCd == "" || strPCCd == "" || strPlanYm == "" ) {
            showMessage(INFORMATION, OK, "USER-1000", "데이터 중 공백인 데이터가 있습니다. 확인하여 주십시오.");
            //DS_IO_DETAIL_ORG.DeleteRow(i);
            break;
        }
        var goTo       = "searchBFYY" ;    
        var action     = "O";     
        var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                       + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                       + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                       + "&strPCCd="            +encodeURIComponent(strPCCd)
                       + "&strPlanYm="          +encodeURIComponent(strPlanYm);
        
        TR_DETAIL.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
        TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_BFYY=DS_IO_BFYY)"; 
        TR_DETAIL.Post();
        
        i = j;
        
        if(DS_IO_BFYY.CountRow > 0){
            
                DS_IO_DETAIL_ORG.NameValue(i, "BFYY_NORM_SAMT")  = DS_IO_BFYY.NameValue(0,"BFYY_NORM_SAMT");
                DS_IO_DETAIL_ORG.NameValue(i, "BFYY_EVT_SAMT")   = DS_IO_BFYY.NameValue(0,"BFYY_EVT_SAMT");
                DS_IO_DETAIL_ORG.NameValue(i, "BFYY_SALE_TAMT")  = DS_IO_BFYY.NameValue(0,"BFYY_SALE_TAMT");
                DS_IO_DETAIL_ORG.NameValue(i, "BFYY_PROF_TAMT")  = DS_IO_BFYY.NameValue(0,"BFYY_PROF_TAMT");
                DS_IO_DETAIL_ORG.NameValue(i, "BFYY_SALE_CRATE") = DS_IO_BFYY.NameValue(0,"BFYY_SALE_CRATE");
                DS_IO_DETAIL_ORG.NameValue(i, "BFYY_PROF_CRATE") = DS_IO_BFYY.NameValue(0,"BFYY_PROF_CRATE");
           
        }
        else{
            DS_IO_DETAIL_ORG.NameValue(i, "BFYY_NORM_SAMT")  = 0;
            DS_IO_DETAIL_ORG.NameValue(i, "BFYY_EVT_SAMT")   = 0;
            DS_IO_DETAIL_ORG.NameValue(i, "BFYY_SALE_TAMT")  = 0;
            DS_IO_DETAIL_ORG.NameValue(i, "BFYY_PROF_TAMT")  = 0;
            DS_IO_DETAIL_ORG.NameValue(i, "BFYY_SALE_CRATE") = 0;
            DS_IO_DETAIL_ORG.NameValue(i, "BFYY_PROF_CRATE") = 0;
        }
        
    }
  
}

/**
* changecolumn()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개     요 : 데이터셋 컬럼값 변경시 수식계산 적용
* return값 :
*/
function changecolumn(){
    var bfyySaleCRateTot = 0; //전년매출
    var bfyyPorfCRateTot = 0; //전년매출
    
    var bfyySaleCRateJan = 0; //전년매출
    var bfyyPorfCRateJan = 0; //전년매출
    
    var bfyySaleCRateFeb = 0; //전년매출
    var bfyyPorfCRateFeb = 0; //전년매출
    
    var bfyySaleCRateMar = 0; //전년매출
    var bfyyPorfCRateMar = 0; //전년매출
    
    var bfyySaleCRateApr = 0; //전년매출
    var bfyyPorfCRateApr = 0; //전년매출
    
    var bfyySaleCRateMay = 0; //전년매출
    var bfyyPorfCRateMay = 0; //전년매출
    
    var bfyySaleCRateJun = 0; //전년매출
    var bfyyPorfCRateJun = 0; //전년매출
    
    var bfyySaleCRateJul = 0; //전년매출
    var bfyyPorfCRateJul = 0; //전년매출
    
    var bfyySaleCRateAug = 0; //전년매출
    var bfyyPorfCRateAug = 0; //전년매출
    
    var bfyySaleCRateSep = 0; //전년매출
    var bfyyPorfCRateSep = 0; //전년매출
    
    var bfyySaleCRateOct = 0; //전년매출
    var bfyyPorfCRateOct = 0; //전년매출
    
    var bfyySaleCRateNov = 0; //전년매출
    var bfyyPorfCRateNov = 0; //전년매출
    
    var bfyySaleCRateDec = 0; //전년매출
    var bfyyPorfCRateDec = 0; //전년매출
    
    var orgSaleCRateTot = 0;  //당초계획
    var orgPorfCRateTot = 0;  //당초계획
    
    var orgSaleCRateJan = 0;  //당초계획
    var orgPorfCRateJan = 0;  //당초계획
    
    var orgSaleCRateFeb = 0;  //당초계획
    var orgPorfCRateFeb = 0;  //당초계획
    
    var orgSaleCRateMar = 0;  //당초계획
    var orgPorfCRateMar = 0;  //당초계획
    
    var orgSaleCRateApr = 0;  //당초계획
    var orgPorfCRateApr = 0;  //당초계획
    
    var orgSaleCRateMay = 0;  //당초계획
    var orgPorfCRateMay = 0;  //당초계획
    
    var orgSaleCRateJun = 0;  //당초계획
    var orgPorfCRateJun = 0;  //당초계획
    
    var orgSaleCRateJul = 0;  //당초계획
    var orgPorfCRateJul = 0;  //당초계획
    
    var orgSaleCRateAug = 0;  //당초계획
    var orgPorfCRateAug = 0;  //당초계획
    
    var orgSaleCRateSep = 0;  //당초계획
    var orgPorfCRateSep = 0;  //당초계획
    
    var orgSaleCRateOct = 0;  //당초계획
    var orgPorfCRateOct = 0;  //당초계획
    
    var orgSaleCRateNov = 0;  //당초계획
    var orgPorfCRateNov = 0;  //당초계획
    
    var orgSaleCRateDec = 0;  //당초계획
    var orgPorfCRateDec = 0;  //당초계획
    
    for(i=1; i <= DS_IO_DETAIL.CountRow; i++){
        if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차" ){
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_FEB"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_FEB"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAR"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAR"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_APR"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_APR"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAY"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAY"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUN"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUN"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUL"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUL"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_AUG"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_AUG"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_SEP"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_SEP"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_OCT"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_OCT"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_NOV"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_NOV"),0);
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_DEC"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_DEC"),0);
    
            DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_TOT") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_FEB"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAR"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_APR"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAY"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUN"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUL"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_AUG"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_SEP"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_OCT"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_NOV"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_DEC"),0)
                                                               ;
    
            DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_TOT") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_FEB"),0)
                                                            + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAR"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_APR"),0)
                                                            + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAY"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUN"),0)
                                                            + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUL"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_AUG"),0)
                                                            + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_SEP"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_OCT"),0)
                                                            + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_NOV"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_DEC"),0)
                                                              ;
    
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_TOT"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_TOT"),0);;
    
            DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT") = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0)
                                                             + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0) + getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0)
                                                               ;
             
            if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                bfyySaleCRateJan += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0);
                bfyyPorfCRateJan += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0);
                
                bfyySaleCRateFeb += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0);
                bfyyPorfCRateFeb += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0);
                
                bfyySaleCRateMar += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0);
                bfyyPorfCRateMar += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0);
                
                bfyySaleCRateApr += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0);
                bfyyPorfCRateApr += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0);
                
                bfyySaleCRateMay += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0);
                bfyyPorfCRateMay += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0);
                
                bfyySaleCRateJun += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0);
                bfyyPorfCRateJun += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0);
                
                bfyySaleCRateJul += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0);
                bfyyPorfCRateJul += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0);
                
                bfyySaleCRateAug += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0);
                bfyyPorfCRateAug += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0);
                
                bfyySaleCRateSep += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0);
                bfyyPorfCRateSep += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0);
                
                bfyySaleCRateOct += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0);
                bfyyPorfCRateOct += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0);
                
                bfyySaleCRateNov += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0);
                bfyyPorfCRateNov += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0);
                
                bfyySaleCRateDec += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0);
                bfyyPorfCRateDec += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0);
                
                bfyySaleCRateTot += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
                bfyyPorfCRateTot += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
              
            }
            else{
                orgSaleCRateTot += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
                orgPorfCRateTot += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
                
                orgSaleCRateJan += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0);
                orgPorfCRateJan += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0);
                
                orgSaleCRateFeb += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0);
                orgPorfCRateFeb += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0);
                
                orgSaleCRateMar += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0);
                orgPorfCRateMar += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0);
                
                orgSaleCRateApr += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0);
                orgPorfCRateApr += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0);
                
                orgSaleCRateMay += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0);
                orgPorfCRateMay += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0);
                
                orgSaleCRateJun += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0);
                orgPorfCRateJun += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0);
                
                orgSaleCRateJul += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0);
                orgPorfCRateJul += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0);
                
                orgSaleCRateAug += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0);
                orgPorfCRateAug += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0);
                
                orgSaleCRateSep += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0);
                orgPorfCRateSep += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0);
                
                orgSaleCRateOct += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0);
                orgPorfCRateOct += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0);
                
                orgSaleCRateNov += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0);
                orgPorfCRateNov += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0);
                
                orgSaleCRateDec += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0);
                orgPorfCRateDec += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0);
                
            }
        }
    }

    for(i=1; i <= DS_IO_DETAIL.CountRow; i++){
        if(DS_IO_DETAIL.NameValue(i,"PC_ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"PC_ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"PC_ORG_NAME") != "오차" ){
           
        	//TOTAL
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0)/getRoundDec("1",bfyySaleCRateTot,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0)/getRoundDec("1",orgSaleCRateTot,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0)/getRoundDec("1",bfyyPorfCRateTot,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0)/getRoundDec("1",orgPorfCRateTot,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT") = 0.00;
            }
            
            //1월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0)/getRoundDec("1",bfyySaleCRateJan,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0)/getRoundDec("1",orgSaleCRateJan,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0)/getRoundDec("1",bfyyPorfCRateJan,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0)/getRoundDec("1",orgPorfCRateJan,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN") = 0.00;
            }
            
            //2월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0)/getRoundDec("1",bfyySaleCRateFeb,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0)/getRoundDec("1",orgSaleCRateFeb,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0)/getRoundDec("1",bfyyPorfCRateFeb,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0)/getRoundDec("1",orgPorfCRateFeb,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB") = 0.00;
            }
            
            //3월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0)/getRoundDec("1",bfyySaleCRateMar,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0)/getRoundDec("1",orgSaleCRateMar,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0)/getRoundDec("1",bfyyPorfCRateMar,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0)/getRoundDec("1",orgPorfCRateMar,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR") = 0.00;
            }
            
            //4월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0)/getRoundDec("1",bfyySaleCRateApr,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0)/getRoundDec("1",orgSaleCRateApr,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0)/getRoundDec("1",bfyyPorfCRateApr,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0)/getRoundDec("1",orgPorfCRateApr,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR") = 0.00;
            }
            
            //5월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0)/getRoundDec("1",bfyySaleCRateMay,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0)/getRoundDec("1",orgSaleCRateMay,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0)/getRoundDec("1",bfyyPorfCRateMay,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0)/getRoundDec("1",orgPorfCRateMay,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY") = 0.00;
            }
            
            //6월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0)/getRoundDec("1",bfyySaleCRateJun,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0)/getRoundDec("1",orgSaleCRateJun,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0)/getRoundDec("1",bfyyPorfCRateJun,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0)/getRoundDec("1",orgPorfCRateJun,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN") = 0.00;
            }
            
            //7월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0)/getRoundDec("1",bfyySaleCRateJul,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0)/getRoundDec("1",orgSaleCRateJul,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0)/getRoundDec("1",bfyyPorfCRateJul,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0)/getRoundDec("1",orgPorfCRateJul,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL") = 0.00;
            }
            
            //8월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0)/getRoundDec("1",bfyySaleCRateAug,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0)/getRoundDec("1",orgSaleCRateAug,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0)/getRoundDec("1",bfyyPorfCRateAug,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0)/getRoundDec("1",orgPorfCRateAug,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG") = 0.00;
            }
            
            //9월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0)/getRoundDec("1",bfyySaleCRateSep,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0)/getRoundDec("1",orgSaleCRateSep,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0)/getRoundDec("1",bfyyPorfCRateSep,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0)/getRoundDec("1",orgPorfCRateSep,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP") = 0.00;
            }
            
            //10월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0)/getRoundDec("1",bfyySaleCRateOct,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0)/getRoundDec("1",orgSaleCRateOct,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0)/getRoundDec("1",bfyyPorfCRateOct,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0)/getRoundDec("1",orgPorfCRateOct,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT") = 0.00;
            }
            
            //11월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0)/getRoundDec("1",bfyySaleCRateNov,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0)/getRoundDec("1",orgSaleCRateNov,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0)/getRoundDec("1",bfyyPorfCRateNov,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0)/getRoundDec("1",orgPorfCRateNov,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV") = 0.00;
            }
            
            //12월
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),2) != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0)/getRoundDec("1",bfyySaleCRateDec,0)*100.00,2);
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0)/getRoundDec("1",orgSaleCRateDec,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC") = 0.00;
            }
            
            if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),2) != 0){
                
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0)/getRoundDec("1",bfyyPorfCRateDec,0)*100.00,2);
                }
                else{
                	
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0)/getRoundDec("1",orgPorfCRateDec,0)*100.00,2);
                }
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC") = 0.00;
            }
            
            //매출신장율,이익신장율
            /*
            if(i> 1){
                //TOTAL
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_TOT"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    
                	DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_TOT") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_TOT"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_TOT"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_TOT"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_TOT") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_TOT") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_TOT"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_TOT") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_TOT"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_TOT"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_TOT"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_TOT") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_TOT") = 0.00;
                }
                
                //1월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JAN"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JAN") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JAN"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JAN"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JAN"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JAN") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JAN") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JAN"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JAN") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JAN"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JAN"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JAN"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JAN") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JAN") = 0.00;
                }
                
                //2월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_FEB"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_FEB") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_FEB"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_FEB"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_FEB"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_FEB") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_FEB") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_FEB"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_FEB") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_FEB"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_FEB"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_FEB"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_FEB") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_FEB") = 0.00;
                }
                
                //3월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAR"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAR") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAR"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAR"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAR"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAR") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAR") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAR"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAR") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAR"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAR"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAR"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAR") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAR") = 0.00;
                }
                
                //4월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_APR"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_APR") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_APR"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_APR"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_APR"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_APR") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_APR") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_APR"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_APR") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_APR"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_APR"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_APR"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_APR") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_APR") = 0.00;
                }
                
                //5월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAY"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAY") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAY"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_MAY"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAY"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAY") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_MAY") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAY"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAY") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAY"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_MAY"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAY"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAY") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_MAY") = 0.00;
                }
                
                //6월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUN"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUN") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUN"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUN"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUN"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUN") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUN") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUN"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUN") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUN"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUN"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUN"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUN") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUN") = 0.00;
                }
                
                //7월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUL"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUL") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUL"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_JUL"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUL"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUL") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_JUL") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUL"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUL") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUL"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_JUL"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUL"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUL") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_JUL") = 0.00;
                }
                
                //8월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_AUG"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_AUG") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_AUG"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_AUG"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_AUG"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_AUG") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_AUG") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_AUG"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_AUG") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_AUG"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_AUG"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_AUG"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_AUG") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_AUG") = 0.00;
                }
                
                //9월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_SEP"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_SEP") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_SEP"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_SEP"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_SEP"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_SEP") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_SEP") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_SEP"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_SEP") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_SEP"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_SEP"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_SEP"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_SEP") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_SEP") = 0.00;
                }
                
                //10월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_OCT"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_OCT") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_OCT"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_OCT"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_OCT"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_OCT") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_OCT") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_OCT"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_OCT") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_OCT"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_OCT"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_OCT"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_OCT") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_OCT") = 0.00;
                }
                
                //11월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_NOV"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_NOV") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_NOV"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_NOV"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_NOV"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_NOV") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_NOV") = 0.00;
                }
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_NOV"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_NOV") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_NOV"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_NOV"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_NOV"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_NOV") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_NOV") = 0.00;
                }
                
                //12월
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_DEC"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_DEC") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_DEC"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT_DEC"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_DEC"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_DEC") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE_DEC") = 0.00;
                }
                
                
                if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_DEC"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_DEC") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_DEC"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT_DEC"),2))*100.00,2);
                    if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_DEC"),2) >= 1000.00){
                        DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_DEC") = 999.99;
                    }
                }
                else{
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE_DEC") = 0.00;
                }
                
            }
            */
             
        }
    }
   
    
 }

 /**
  * ExcelDownData()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-03-04
  * 개     요 : 데이터 내역을 엑셀로 저장
  * return값 :
  */
  function ExcelDownData() {
      moveDetailOrg();
      if(DS_IO_DETAIL_ORG.CountRow <= 0){
        showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
          return;
      }
      var strTitle = "당초PC별월매출목표";
      GD_DETAIL_ORG.ColumnProp("PLAN_YM", "Mask") ="XXXXXX"
      var strStrCd        = LC_STR_CD.Text;      //점
      var strDeptCd       = LC_DEPT_CD.Text;     //팀
      var strTeamCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORG_NAME");        //파트코드
      //var strTeamCd       = LC_TEAM_CD.Text;     //파트
      var strPlanYear     = EM_PLAN_YEAR.text;         //계획년도
      
      var strOriginNormSamt      = GD_MASTER.VirtualString2(DS_O_MASTER.RowPosition,"ORIGIN_NORM_SAMT_TOT",0);      //정상
      var strOriginEvtSamt       = GD_MASTER.VirtualString2(DS_O_MASTER.RowPosition,"ORIGIN_EVT_SAMT_TOT",0);       //행사
      var strOriginSaleTamt      = GD_MASTER.VirtualString2(DS_O_MASTER.RowPosition,"ORIGIN_SALE_TAMT_TOT",0);      //총매출
      var strOriginProfTamt      = GD_MASTER.VirtualString2(DS_O_MASTER.RowPosition,"ORIGIN_PROF_TAMT_TOT",0);       //이익


      var parameters = "점= "       +strStrCd
             + " , 팀= "          +strDeptCd
             + " , 파트= "           +strTeamCd
             + " , 년도= "        +strPlanYear
             + " , 정상= "      +strOriginNormSamt
             + " , 행사= "   +strOriginEvtSamt
             + " , 총매출= " +strOriginSaleTamt
             + " , 이익= "   +strOriginProfTamt;
      
      GD_DETAIL_ORG.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
      openExcel2(GD_DETAIL_ORG, strTitle, parameters, true );

      GD_DETAIL_ORG.ColumnProp("PLAN_YM", "Mask") ="XXXX/XX"}

 /**
  * errorchk()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-03-04
  * 개     요 : 데이터 에러 체크
  * return값 :
  */
function errorchk(){
    var strStrCd      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");      //점
    var strDeptCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");     //팀코드
    var strTeamCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");     //파트코드
    var cntOrg        = 0;
    
    var goTo       = "searchOrgMst" ;    
    var action     = "O";     
    var parameters = "&strStrCd="        +encodeURIComponent(strStrCd)
                   + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="       +encodeURIComponent(strTeamCd);
                  
    TR_MAIN.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKORGMST=DS_CHKORGMST)"; 
    TR_MAIN.Post();
    
    for(i=1; i <= DS_IO_DETAIL.CountRow; i++){
        if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차"){
            for(j=1; j <= DS_CHKORGMST.CountRow; j++){
                if(DS_IO_DETAIL.NameValue(i,"PC_CD") == DS_CHKORGMST.NameValue(j,"PC_CD")){
                    DS_IO_DETAIL.NameValue(i,"PC_CD")    = DS_CHKORGMST.NameValue(j,"PC_CD");
                    DS_IO_DETAIL.NameValue(i,"ORG_NAME") = DS_CHKORGMST.NameValue(j,"ORG_NAME");
                    cntOrg = 1;
                }
            }
            if(cntOrg == 0){
                errcnt     += 1;
                errorRow   += i+",";
            }
            cntOrg = 0;
        }
    }
    
    
    errorRow = errorRow.substr(0,errorRow.length-1);
}

/**
 * errorState()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-04
 * 개     요 : 데이터 에러 체크 상태변경
 * return값 :
 */
function errorState(){
   
    errorRow ="";
    errcnt = 0;
    errorchk();
    
    if(errcnt > 0){
        var noCheckRow = errorRow.split(",");
        
        for(i=1; i <= noCheckRow.length; i++){
            for(j=1; j <= DS_IO_DETAIL.CountRow; j++ ){
                
                if(noCheckRow[i-1] == j ){
                    DS_IO_DETAIL.NameValue(j,"ERROR_CHECK") = "TRUE";
                    break;
                }
            }
        }
    }
}


/**
* searchDetail()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  당초파트별월매출계획 조회
* return값 : void
*/
function searchDetail(){
    var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPlanYear     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "PLAN_YEAR");        //계획년도
    
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                   + "&strDeptCd="            +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="            +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="          +encodeURIComponent(strPlanYear);
    
    TR_DETAIL.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL_ORG=DS_IO_DETAIL_ORG)"; //조회는 O
    TR_DETAIL.Post();
    
    //히든그리드의 내용을 상세그리드로 이동
    GD_DETAIL.ReDraw = false;
    moveDetail();
    GD_DETAIL.ReDraw = true;
    
    
    
    //합계표시
    if(DS_IO_DETAIL.CountRow != 0){
        GD_DETAIL.ReDraw = false;
        ln_sum();
        GD_DETAIL.ReDraw = true;
        DS_IO_DETAIL.ResetStatus();

    }
    
    
    //스크롤바 위치 조정
    GD_DETAIL.SETVSCROLLING(0);
    GD_DETAIL.SETHSCROLLING(0);
    DS_IO_DETAIL.RowPosition = 1;
    
    var goTo       = "searchOrgMst" ;    
    var action     = "O";     
    var parameters = "&strStrCd="        +encodeURIComponent(strStrCd)
                   + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="       +encodeURIComponent(strTeamCd);
                  
    TR_DETAIL.Action="/dps/psal105.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_CHKORGMST=DS_CHKORGMST)"; 
    TR_DETAIL.Post();
    // 조회결과 Return
    setPorcCount("SELECT", DS_CHKORGMST.CountRow);

    DS_IO_DETAIL.RowPosition = 1;
    
    GD_MASTER.Focus();
}

function moveDetail(){
    DS_IO_DETAIL.ClearData();
    
    var j = 1;
    var k = 2;
    var m = 1;
    
    var bfyySaleCRate = 0;
    var originSaleCRate = 0;
    var bfyyProfCRate = 0;
    var originProfCRate = 0;
    
    for(i=1; i <= DS_IO_DETAIL_ORG.CountRow;i++){
        bfyySaleCRate += getRoundDec("1",DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT"),0);
        bfyyProfCRate += getRoundDec("1",DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT"),0);
        originSaleCRate += getRoundDec("1",DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT"),0);
        originProfCRate += getRoundDec("1",DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT"),0);
        
    }
    for(i=1; i < DS_IO_DETAIL_ORG.CountRow;i++){
        
        DS_IO_DETAIL.AddRow();
        DS_IO_DETAIL.AddRow();
        m = i;
        
        DS_IO_DETAIL.NameValue(j,"STR_CD")   = DS_IO_DETAIL_ORG.NameValue(i,"STR_CD");
        DS_IO_DETAIL.NameValue(j,"DEPT_CD")  = DS_IO_DETAIL_ORG.NameValue(i,"DEPT_CD");
        DS_IO_DETAIL.NameValue(j,"TEAM_CD")  = DS_IO_DETAIL_ORG.NameValue(i,"TEAM_CD");
        DS_IO_DETAIL.NameValue(j,"PC_CD")    = DS_IO_DETAIL_ORG.NameValue(i,"PC_CD");
        DS_IO_DETAIL.NameValue(j,"ORG_NAME") = DS_IO_DETAIL_ORG.NameValue(i,"PC_ORG_NAME");
        DS_IO_DETAIL.NameValue(j,"CONF_FLAG")= DS_IO_DETAIL_ORG.NameValue(i,"CONF_FLAG");
        DS_IO_DETAIL.NameValue(j,"GUBUN")    = "전년매출";
        
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_JAN")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_JAN")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_JAN")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_JAN")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_JAN") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_JAN") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_FEB")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_FEB")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_FEB")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_FEB")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_FEB") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_FEB") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_MAR")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_MAR")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_MAR")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_MAR")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_MAR") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_MAR") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_APR")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_APR")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_APR")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_APR")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_APR") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_APR") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_MAY")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_MAY")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_MAY")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_MAY")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_MAY") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_MAY") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_JUN")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_JUN")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_JUN")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_JUN")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_JUN") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_JUN") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_JUL")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_JUL")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_JUL")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_JUL")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_JUL") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_JUL") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_AUG")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_AUG")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_AUG")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_AUG")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_AUG") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_AUG") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_SEP")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_SEP")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_SEP")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_SEP")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_SEP") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_SEP") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_OCT")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_OCT")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_OCT")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_OCT")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_OCT") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_OCT") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_NOV")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_NOV")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_NOV")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_NOV")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_NOV") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_NOV") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        i++;
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_DEC")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_DEC")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_DEC")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_DEC")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_DEC") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_DEC") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");
        
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_TOT")  = getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_JAN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_FEB"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_MAR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_APR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_MAY"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_JUN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_JUL"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_AUG"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_SEP"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_OCT"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_NOV"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT_DEC"),0);
                                                          
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_TOT")   = getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_JAN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_FEB"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_MAR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_APR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_MAY"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_JUN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_JUL"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_AUG"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_SEP"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_OCT"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_NOV"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT_DEC"),0);

        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_TOT")  = getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_JAN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_FEB"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_MAR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_APR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_MAY"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_JUN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_JUL"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_AUG"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_SEP"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_OCT"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_NOV"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_DEC"),0);

        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_TOT")  = getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_JAN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_FEB"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_MAR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_APR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_MAY"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_JUN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_JUL"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_AUG"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_SEP"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_OCT"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_NOV"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_DEC"),0);
                                                          
        
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE_TOT") = getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT_TOT")/getRoundDec("1",bfyySaleCRate,0)*100,2);
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE_TOT") = getRoundDec("1",DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT_TOT")/getRoundDec("1",bfyyProfCRate,0)*100,2);
        
        
        j = j+2;
        
        i = m;

        DS_IO_DETAIL.NameValue(k,"STR_CD") = DS_IO_DETAIL_ORG.NameValue(i,"STR_CD");
        DS_IO_DETAIL.NameValue(k,"DEPT_CD") = DS_IO_DETAIL_ORG.NameValue(i,"DEPT_CD");
        DS_IO_DETAIL.NameValue(k,"TEAM_CD") = DS_IO_DETAIL_ORG.NameValue(i,"TEAM_CD");
        
        DS_IO_DETAIL.NameValue(k,"PC_CD") = DS_IO_DETAIL_ORG.NameValue(i,"PC_CD");
        DS_IO_DETAIL.NameValue(k,"ORG_NAME") = DS_IO_DETAIL_ORG.NameValue(i,"PC_ORG_NAME");

        DS_IO_DETAIL.NameValue(k,"CONF_FLAG") = DS_IO_DETAIL_ORG.NameValue(i,"CONF_FLAG");
        DS_IO_DETAIL.NameValue(k,"GUBUN") = "당초목표";
        
        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_JAN")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_JAN")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_JAN")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_JAN")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_JAN") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_JAN") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_JAN") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_JAN") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;
        
        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_FEB")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_FEB")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_FEB")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_FEB")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_FEB") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_FEB") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_FEB") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_FEB") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_MAR")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_MAR")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_MAR")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_MAR")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_MAR") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_MAR") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_MAR") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_MAR") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_APR")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_APR")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_APR")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_APR")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_APR") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_APR") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_APR") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_APR") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_MAY")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_MAY")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_MAY")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_MAY")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_MAY") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_MAY") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_MAY") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_MAY") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_JUN")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_JUN")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_JUN")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_JUN")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_JUN") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_JUN") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_JUN") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_JUN") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_JUL")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_JUL")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_JUL")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_JUL")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_JUL") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_JUL") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_JUL") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_JUL") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_AUG")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_AUG")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_AUG")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_AUG")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_AUG") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_AUG") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_AUG") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_AUG") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_SEP")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_SEP")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_SEP")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_SEP")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_SEP") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_SEP") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_SEP") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_SEP") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_OCT")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_OCT")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_OCT")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_OCT")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_OCT") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_OCT") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_OCT") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_OCT") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_NOV")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_NOV")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_NOV")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_NOV")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_NOV") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_NOV") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_NOV") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_NOV") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        i++;

        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_DEC")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_DEC")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_DEC")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_DEC")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_DEC") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_DEC") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_IRATE_DEC") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE_DEC") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");
        
        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_TOT")  = getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_JAN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_FEB"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_MAR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_APR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_MAY"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_JUN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_JUL"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_AUG"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_SEP"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_OCT"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_NOV"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT_DEC"),0);
                                                          
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_TOT")   = getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_JAN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_FEB"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_MAR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_APR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_MAY"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_JUN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_JUL"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_AUG"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_SEP"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_OCT"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_NOV"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT_DEC"),0);

        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_TOT")  = getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_JAN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_FEB"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_MAR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_APR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_MAY"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_JUN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_JUL"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_AUG"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_SEP"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_OCT"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_NOV"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_DEC"),0);

        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_TOT")  = getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_JAN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_FEB"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_MAR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_APR"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_MAY"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_JUN"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_JUL"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_AUG"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_SEP"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_OCT"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_NOV"),0)
                                                          + getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_DEC"),0);

        
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE_TOT") = getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT_TOT")/getRoundDec("1",originSaleCRate,0)*100,2);
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE_TOT") = getRoundDec("1",DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT_TOT")/getRoundDec("1",originProfCRate,0)*100,2);
        
        
        
        k = k+2
    }
    
}

function moveDetailOrg(){
    GD_DETAIL_ORG.ReDraw = false;
    var j = 1;
    
    for(i=1; i <= DS_IO_DETAIL.CountRow;i=i+2){
        if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차" ){
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN") ;
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN");

            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_JAN");
        
            j++;
        
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB");
      
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_FEB");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_FEB");

            j++;
            
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_MAR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_MAR");
        
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_APR");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_APR");
        
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_MAY");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_MAY");
        
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_JUN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_JUN");
            
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_JUL");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_JUL");
            
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_AUG");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_AUG");
            
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_SEP");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_SEP");
            
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_OCT");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_OCT");
            
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_NOV");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_NOV");
            
            j++;
    
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC");
    
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_DEC");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_DEC");
            
            j++;
        }
    }
    GD_DETAIL_ORG.ReDraw = true;
}

/**
* ln_sum()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  합계/오차 행추가
* return값 : 
*/
function ln_sum() {
    var bfyyTotal       = 0;  //전년합계
    var originTotal     = 0;  //당초합계
    var gap             = 0;  //차이
    //전년
    var bfyyNormSAmtTot    = 0;  //정상매출합계
    var bffEvtSAmtTot      = 0;  //행사매출합계
    var bfyySaleTAmtTot    = 0;  //총매출합계
    var bfyyProfTAmtTot    = 0;  //이익합계
    var bfyySaleCRateTot   = 0;  //매출구성비합계
    var bfyyProfCRateTot   = 0;  //이익구성비합계
    
    var bfyyNormSAmtJan    = 0;  //정상매출합계
    var bffEvtSAmtJan      = 0;  //행사매출합계
    var bfyySaleTAmtJan    = 0;  //총매출합계
    var bfyyProfTAmtJan    = 0;  //이익합계
    var bfyySaleCRateJan   = 0;  //매출구성비합계
    var bfyyProfCRateJan   = 0;  //이익구성비합계

    var bfyyNormSAmtFeb    = 0;  //정상매출합계
    var bffEvtSAmtFeb      = 0;  //행사매출합계
    var bfyySaleTAmtFeb    = 0;  //총매출합계
    var bfyyProfTAmtFeb    = 0;  //이익합계
    var bfyySaleCRateFeb   = 0;  //매출구성비합계
    var bfyyProfCRateFeb   = 0;  //이익구성비합계

    var bfyyNormSAmtMar    = 0;  //정상매출합계
    var bffEvtSAmtMar      = 0;  //행사매출합계
    var bfyySaleTAmtMar    = 0;  //총매출합계
    var bfyyProfTAmtMar    = 0;  //이익합계
    var bfyySaleCRateMar   = 0;  //매출구성비합계
    var bfyyProfCRateMar   = 0;  //이익구성비합계

    var bfyyNormSAmtApr    = 0;  //정상매출합계
    var bffEvtSAmtApr      = 0;  //행사매출합계
    var bfyySaleTAmtApr    = 0;  //총매출합계
    var bfyyProfTAmtApr    = 0;  //이익합계
    var bfyySaleCRateApr   = 0;  //매출구성비합계
    var bfyyProfCRateApr   = 0;  //이익구성비합계

    var bfyyNormSAmtMay    = 0;  //정상매출합계
    var bffEvtSAmtMay      = 0;  //행사매출합계
    var bfyySaleTAmtMay    = 0;  //총매출합계
    var bfyyProfTAmtMay    = 0;  //이익합계
    var bfyySaleCRateMay   = 0;  //매출구성비합계
    var bfyyProfCRateMay   = 0;  //이익구성비합계

    var bfyyNormSAmtJun    = 0;  //정상매출합계
    var bffEvtSAmtJun      = 0;  //행사매출합계
    var bfyySaleTAmtJun    = 0;  //총매출합계
    var bfyyProfTAmtJun    = 0;  //이익합계
    var bfyySaleCRateJun   = 0;  //매출구성비합계
    var bfyyProfCRateJun   = 0;  //이익구성비합계

    var bfyyNormSAmtJul    = 0;  //정상매출합계
    var bffEvtSAmtJul      = 0;  //행사매출합계
    var bfyySaleTAmtJul    = 0;  //총매출합계
    var bfyyProfTAmtJul    = 0;  //이익합계
    var bfyySaleCRateJul   = 0;  //매출구성비합계
    var bfyyProfCRateJul   = 0;  //이익구성비합계

    var bfyyNormSAmtAug    = 0;  //정상매출합계
    var bffEvtSAmtAug      = 0;  //행사매출합계
    var bfyySaleTAmtAug    = 0;  //총매출합계
    var bfyyProfTAmtAug    = 0;  //이익합계
    var bfyySaleCRateAug   = 0;  //매출구성비합계
    var bfyyProfCRateAug   = 0;  //이익구성비합계

    var bfyyNormSAmtSep    = 0;  //정상매출합계
    var bffEvtSAmtSep      = 0;  //행사매출합계
    var bfyySaleTAmtSep    = 0;  //총매출합계
    var bfyyProfTAmtSep    = 0;  //이익합계
    var bfyySaleCRateSep   = 0;  //매출구성비합계
    var bfyyProfCRateSep   = 0;  //이익구성비합계

    var bfyyNormSAmtOct    = 0;  //정상매출합계
    var bffEvtSAmtOct      = 0;  //행사매출합계
    var bfyySaleTAmtOct    = 0;  //총매출합계
    var bfyyProfTAmtOct    = 0;  //이익합계
    var bfyySaleCRateOct   = 0;  //매출구성비합계
    var bfyyProfCRateOct   = 0;  //이익구성비합계

    var bfyyNormSAmtNov    = 0;  //정상매출합계
    var bffEvtSAmtNov      = 0;  //행사매출합계
    var bfyySaleTAmtNov    = 0;  //총매출합계
    var bfyyProfTAmtNov    = 0;  //이익합계
    var bfyySaleCRateNov   = 0;  //매출구성비합계
    var bfyyProfCRateNov   = 0;  //이익구성비합계

    var bfyyNormSAmtDec    = 0;  //정상매출합계
    var bffEvtSAmtDec      = 0;  //행사매출합계
    var bfyySaleTAmtDec    = 0;  //총매출합계
    var bfyyProfTAmtDec    = 0;  //이익합계
    var bfyySaleCRateDec   = 0;  //매출구성비합계
    var bfyyProfCRateDec   = 0;  //이익구성비합계
    
    //당초
    var originNormSAmtTot  = 0;  //정상매출합계
    var originEvtSAmtTot   = 0;  //행사매출합계
    var originSaleTAmtTot  = 0;  //총매출합계
    var originProfTAmtTot  = 0;  //이익합계
    var originSaleCRateTot = 0;  //매출구성비합계
    var originProfCRateTot = 0;  //이익구성비합계
    
    var originNormSAmtJan  = 0;  //정상매출합계
    var originEvtSAmtJan   = 0;  //행사매출합계
    var originSaleTAmtJan  = 0;  //총매출합계
    var originProfTAmtJan  = 0;  //이익합계
    var originSaleCRateJan = 0;  //매출구성비합계
    var originProfCRateJan = 0;  //이익구성비합계

    var originNormSAmtFeb  = 0;  //정상매출합계
    var originEvtSAmtFeb   = 0;  //행사매출합계
    var originSaleTAmtFeb  = 0;  //총매출합계
    var originProfTAmtFeb  = 0;  //이익합계
    var originSaleCRateFeb = 0;  //매출구성비합계
    var originProfCRateFeb = 0;  //이익구성비합계

    var originNormSAmtMar  = 0;  //정상매출합계
    var originEvtSAmtMar   = 0;  //행사매출합계
    var originSaleTAmtMar  = 0;  //총매출합계
    var originProfTAmtMar  = 0;  //이익합계
    var originSaleCRateMar = 0;  //매출구성비합계
    var originProfCRateMar = 0;  //이익구성비합계

    var originNormSAmtApr  = 0;  //정상매출합계
    var originEvtSAmtApr   = 0;  //행사매출합계
    var originSaleTAmtApr  = 0;  //총매출합계
    var originProfTAmtApr  = 0;  //이익합계
    var originSaleCRateApr = 0;  //매출구성비합계
    var originProfCRateApr = 0;  //이익구성비합계

    var originNormSAmtMay  = 0;  //정상매출합계
    var originEvtSAmtMay   = 0;  //행사매출합계
    var originSaleTAmtMay  = 0;  //총매출합계
    var originProfTAmtMay  = 0;  //이익합계
    var originSaleCRateMay = 0;  //매출구성비합계
    var originProfCRateMay = 0;  //이익구성비합계

    var originNormSAmtJun  = 0;  //정상매출합계
    var originEvtSAmtJun   = 0;  //행사매출합계
    var originSaleTAmtJun  = 0;  //총매출합계
    var originProfTAmtJun  = 0;  //이익합계
    var originSaleCRateJun = 0;  //매출구성비합계
    var originProfCRateJun = 0;  //이익구성비합계

    var originNormSAmtJul  = 0;  //정상매출합계
    var originEvtSAmtJul   = 0;  //행사매출합계
    var originSaleTAmtJul  = 0;  //총매출합계
    var originProfTAmtJul  = 0;  //이익합계
    var originSaleCRateJul = 0;  //매출구성비합계
    var originProfCRateJul = 0;  //이익구성비합계

    var originNormSAmtAug  = 0;  //정상매출합계
    var originEvtSAmtAug   = 0;  //행사매출합계
    var originSaleTAmtAug  = 0;  //총매출합계
    var originProfTAmtAug  = 0;  //이익합계
    var originSaleCRateAug = 0;  //매출구성비합계
    var originProfCRateAug = 0;  //이익구성비합계

    var originNormSAmtSep  = 0;  //정상매출합계
    var originEvtSAmtSep   = 0;  //행사매출합계
    var originSaleTAmtSep  = 0;  //총매출합계
    var originProfTAmtSep  = 0;  //이익합계
    var originSaleCRateSep = 0;  //매출구성비합계
    var originProfCRateSep = 0;  //이익구성비합계

    var originNormSAmtOct  = 0;  //정상매출합계
    var originEvtSAmtOct   = 0;  //행사매출합계
    var originSaleTAmtOct  = 0;  //총매출합계
    var originProfTAmtOct  = 0;  //이익합계
    var originSaleCRateOct = 0;  //매출구성비합계
    var originProfCRateOct = 0;  //이익구성비합계

    var originNormSAmtNov  = 0;  //정상매출합계
    var originEvtSAmtNov   = 0;  //행사매출합계
    var originSaleTAmtNov  = 0;  //총매출합계
    var originProfTAmtNov  = 0;  //이익합계
    var originSaleCRateNov = 0;  //매출구성비합계
    var originProfCRateNov = 0;  //이익구성비합계

    var originNormSAmtDec  = 0;  //정상매출합계
    var originEvtSAmtDec   = 0;  //행사매출합계
    var originSaleTAmtDec  = 0;  //총매출합계
    var originProfTAmtDec  = 0;  //이익합계
    var originSaleCRateDec = 0;  //매출구성비합계
    var originProfCRateDec = 0;  //이익구성비합계
	
    
    
    for(i=1; i <= DS_IO_DETAIL.CountRow; i++){
        if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차" ){
            bfyyNormSAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_TOT"),0);
            bffEvtSAmtTot       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_TOT"),0);
            bfyySaleTAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
            bfyyProfTAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
            bfyySaleCRateTot    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT"),2);
            bfyyProfCRateTot    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT"),2);
            
            bfyyNormSAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN"),0);
            bffEvtSAmtJan       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN"),0);
            bfyySaleTAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0);
            bfyyProfTAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0);
            bfyySaleCRateJan    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN"),2);
            bfyyProfCRateJan    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN"),2);
            
            bfyyNormSAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_FEB"),0);
            bffEvtSAmtFeb       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_FEB"),0);
            bfyySaleTAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0);
            bfyyProfTAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0);
            bfyySaleCRateFeb    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB"),2);
            bfyyProfCRateFeb    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB"),2);
            
            bfyyNormSAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAR"),0);
            bffEvtSAmtMar       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAR"),0);
            bfyySaleTAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0);
            bfyyProfTAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0);
            bfyySaleCRateMar    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR"),2);
            bfyyProfCRateMar    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR"),2);

            bfyyNormSAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_APR"),0);
            bffEvtSAmtApr       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_APR"),0);
            bfyySaleTAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0);
            bfyyProfTAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0);
            bfyySaleCRateApr    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR"),2);
            bfyyProfCRateApr    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR"),2);

            bfyyNormSAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAY"),0);
            bffEvtSAmtMay       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAY"),0);
            bfyySaleTAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0);
            bfyyProfTAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0);
            bfyySaleCRateMay    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY"),2);
            bfyyProfCRateMay    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY"),2);

            bfyyNormSAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUN"),0);
            bffEvtSAmtJun       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUN"),0);
            bfyySaleTAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0);
            bfyyProfTAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0);
            bfyySaleCRateJun    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN"),2);
            bfyyProfCRateJun    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN"),2);

            bfyyNormSAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUL"),0);
            bffEvtSAmtJul       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUL"),0);
            bfyySaleTAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0);
            bfyyProfTAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0);
            bfyySaleCRateJul    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL"),2);
            bfyyProfCRateJul    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL"),2);

            bfyyNormSAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_AUG"),0);
            bffEvtSAmtAug       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_AUG"),0);
            bfyySaleTAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0);
            bfyyProfTAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0);
            bfyySaleCRateAug    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG"),2);
            bfyyProfCRateAug    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG"),2);

            bfyyNormSAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_SEP"),0);
            bffEvtSAmtSep       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_SEP"),0);
            bfyySaleTAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0);
            bfyyProfTAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0);
            bfyySaleCRateSep    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP"),2);
            bfyyProfCRateSep    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP"),2);

            bfyyNormSAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_OCT"),0);
            bffEvtSAmtOct       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_OCT"),0);
            bfyySaleTAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0);
            bfyyProfTAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0);
            bfyySaleCRateOct    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT"),2);
            bfyyProfCRateOct    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT"),2);

            bfyyNormSAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_NOV"),0);
            bffEvtSAmtNov       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_NOV"),0);
            bfyySaleTAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0);
            bfyyProfTAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0);
            bfyySaleCRateNov    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV"),2);
            bfyyProfCRateNov    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV"),2);

            bfyyNormSAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_DEC"),0);
            bffEvtSAmtDec       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_DEC"),0);
            bfyySaleTAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0);
            bfyyProfTAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0);
            bfyySaleCRateDec    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC"),2);
            bfyyProfCRateDec    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC"),2);
            
        }
        else{
            if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차" ){
                originNormSAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_TOT"),0);
                originEvtSAmtTot      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_TOT"),0);
                originSaleTAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
                originProfTAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
                originSaleCRateTot    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT"),2);
                originProfCRateTot    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT"),2);
                
                originNormSAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN"),0);
                originEvtSAmtJan      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN"),0);
                originSaleTAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0);
                originProfTAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0);
                originSaleCRateJan    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN"),2);
                originProfCRateJan    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN"),2);
                
                originNormSAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_FEB"),0);
                originEvtSAmtFeb      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_FEB"),0);
                originSaleTAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0);
                originProfTAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0);
                originSaleCRateFeb    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB"),2);
                originProfCRateFeb    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB"),2);
                
                originNormSAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAR"),0);
                originEvtSAmtMar      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAR"),0);
                originSaleTAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0);
                originProfTAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0);
                originSaleCRateMar    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR"),2);
                originProfCRateMar    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR"),2);
    
                originNormSAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_APR"),0);
                originEvtSAmtApr      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_APR"),0);
                originSaleTAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0);
                originProfTAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0);
                originSaleCRateApr    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR"),2);
                originProfCRateApr    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR"),2);
    
                originNormSAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAY"),0);
                originEvtSAmtMay      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAY"),0);
                originSaleTAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0);
                originProfTAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0);
                originSaleCRateMay    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY"),2);
                originProfCRateMay    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY"),2);
    
                originNormSAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUN"),0);
                originEvtSAmtJun      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUN"),0);
                originSaleTAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0);
                originProfTAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0);
                originSaleCRateJun    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN"),2);
                originProfCRateJun    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN"),2);
    
                originNormSAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUL"),0);
                originEvtSAmtJul      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUL"),0);
                originSaleTAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0);
                originProfTAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0);
                originSaleCRateJul    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL"),2);
                originProfCRateJul    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL"),2);
    
                originNormSAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_AUG"),0);
                originEvtSAmtAug      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_AUG"),0);
                originSaleTAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0);
                originProfTAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0);
                originSaleCRateAug    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG"),2);
                originProfCRateAug    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG"),2);
    
                originNormSAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_SEP"),0);
                originEvtSAmtSep      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_SEP"),0);
                originSaleTAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0);
                originProfTAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0);
                originSaleCRateSep    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP"),2);
                originProfCRateSep    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP"),2);
    
                originNormSAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_OCT"),0);
                originEvtSAmtOct      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_OCT"),0);
                originSaleTAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0);
                originProfTAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0);
                originSaleCRateOct    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT"),2);
                originProfCRateOct    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT"),2);
    
                originNormSAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_NOV"),0);
                originEvtSAmtNov      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_NOV"),0);
                originSaleTAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0);
                originProfTAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0);
                originSaleCRateNov    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV"),2);
                originProfCRateNov    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV"),2);
    
                originNormSAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_DEC"),0);
                originEvtSAmtDec      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_DEC"),0);
                originSaleTAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0);
                originProfTAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0);
                originSaleCRateDec    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC"),2);
                originProfCRateDec    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC"),2);
            }
        }
    }
    
    
    DS_IO_DETAIL.Addrow();
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORG_NAME")         = "합계";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"GUBUN")            = "전년매출";
    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_TOT") = bfyyNormSAmtTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_TOT")  = bffEvtSAmtTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_TOT") = bfyySaleTAmtTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_TOT") = bfyyProfTAmtTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_TOT")= bfyySaleCRateTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_TOT")= bfyyProfCRateTot;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JAN") = bfyyNormSAmtJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JAN")  = bffEvtSAmtJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JAN") = bfyySaleTAmtJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JAN") = bfyyProfTAmtJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_JAN")= bfyySaleCRateJan; //getRoundDec("1",bfyySaleCRateJan*100/bfyySaleTAmtTot,2);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_JAN")= bfyyProfCRateJan;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_FEB") = bfyyNormSAmtFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_FEB")  = bffEvtSAmtFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_FEB") = bfyySaleTAmtFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_FEB") = bfyyProfTAmtFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_FEB")= bfyySaleCRateFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_FEB")= bfyyProfCRateFeb;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_MAR") = bfyyNormSAmtMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_MAR")  = bffEvtSAmtMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_MAR") = bfyySaleTAmtMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_MAR") = bfyyProfTAmtMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_MAR")= bfyySaleCRateMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_MAR")= bfyyProfCRateMar;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_APR") = bfyyNormSAmtApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_APR")  = bffEvtSAmtApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_APR") = bfyySaleTAmtApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_APR") = bfyyProfTAmtApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_APR")= bfyySaleCRateApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_APR")= bfyyProfCRateApr;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_MAY") = bfyyNormSAmtMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_MAY")  = bffEvtSAmtMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_MAY") = bfyySaleTAmtMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_MAY") = bfyyProfTAmtMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_MAY")= bfyySaleCRateMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_MAY")= bfyyProfCRateMay;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JUN") = bfyyNormSAmtJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JUN")  = bffEvtSAmtJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JUN") = bfyySaleTAmtJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JUN") = bfyyProfTAmtJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_JUN")= bfyySaleCRateJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_JUN")= bfyyProfCRateJun;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JUL") = bfyyNormSAmtJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JUL")  = bffEvtSAmtJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JUL") = bfyySaleTAmtJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JUL") = bfyyProfTAmtJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_JUL")= bfyySaleCRateJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_JUL")= bfyyProfCRateJul;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_AUG") = bfyyNormSAmtAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_AUG")  = bffEvtSAmtAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_AUG") = bfyySaleTAmtAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_AUG") = bfyyProfTAmtAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_AUG")= bfyySaleCRateAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_AUG")= bfyyProfCRateAug;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_SEP") = bfyyNormSAmtSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_SEP")  = bffEvtSAmtSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_SEP") = bfyySaleTAmtSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_SEP") = bfyyProfTAmtSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_SEP")= bfyySaleCRateSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_SEP")= bfyyProfCRateSep;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_OCT") = bfyyNormSAmtOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_OCT")  = bffEvtSAmtOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_OCT") = bfyySaleTAmtOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_OCT") = bfyyProfTAmtOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_OCT")= bfyySaleCRateOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_OCT")= bfyyProfCRateOct;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_NOV") = bfyyNormSAmtNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_NOV")  = bffEvtSAmtNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_NOV") = bfyySaleTAmtNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_NOV") = bfyyProfTAmtNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_NOV")= bfyySaleCRateNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_NOV")= bfyyProfCRateNov;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_DEC") = bfyyNormSAmtDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_DEC")  = bffEvtSAmtDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_DEC") = bfyySaleTAmtDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_DEC") = bfyyProfTAmtDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_DEC")= bfyySaleCRateDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_DEC")= bfyyProfCRateDec;
    
    DS_IO_DETAIL.Addrow();
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORG_NAME")         = "";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"GUBUN")            = "당초목표";

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_TOT") = originNormSAmtTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_TOT")  = originEvtSAmtTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_TOT") = originSaleTAmtTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_TOT") = originProfTAmtTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_TOT")= originSaleCRateTot;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_TOT")= originProfCRateTot;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JAN") = originNormSAmtJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JAN")  = originEvtSAmtJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JAN") = originSaleTAmtJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JAN") = originProfTAmtJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_JAN")= originSaleCRateJan;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_JAN")= originProfCRateJan;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_FEB") = originNormSAmtFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_FEB")  = originEvtSAmtFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_FEB") = originSaleTAmtFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_FEB") = originProfTAmtFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_FEB")= originSaleCRateFeb;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_FEB")= originProfCRateFeb;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_MAR") = originNormSAmtMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_MAR")  = originEvtSAmtMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_MAR") = originSaleTAmtMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_MAR") = originProfTAmtMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_MAR")= originSaleCRateMar;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_MAR")= originProfCRateMar;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_APR") = originNormSAmtApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_APR")  = originEvtSAmtApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_APR") = originSaleTAmtApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_APR") = originProfTAmtApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_APR")= originSaleCRateApr;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_APR")= originProfCRateApr;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_MAY") = originNormSAmtMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_MAY")  = originEvtSAmtMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_MAY") = originSaleTAmtMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_MAY") = originProfTAmtMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_MAY")= originSaleCRateMay;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_MAY")= originProfCRateMay;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JUN") = originNormSAmtJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JUN")  = originEvtSAmtJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JUN") = originSaleTAmtJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JUN") = originProfTAmtJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_JUN")= originSaleCRateJun;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_JUN")= originProfCRateJun;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JUL") = originNormSAmtJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JUL")  = originEvtSAmtJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JUL") = originSaleTAmtJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JUL") = originProfTAmtJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_JUL")= originSaleCRateJul;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_JUL")= originProfCRateJul;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_AUG") = originNormSAmtAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_AUG")  = originEvtSAmtAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_AUG") = originSaleTAmtAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_AUG") = originProfTAmtAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_AUG")= originSaleCRateAug;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_AUG")= originProfCRateAug;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_SEP") = originNormSAmtSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_SEP")  = originEvtSAmtSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_SEP") = originSaleTAmtSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_SEP") = originProfTAmtSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_SEP")= originSaleCRateSep;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_SEP")= originProfCRateSep;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_OCT") = originNormSAmtOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_OCT")  = originEvtSAmtOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_OCT") = originSaleTAmtOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_OCT") = originProfTAmtOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_OCT")= originSaleCRateOct;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_OCT")= originProfCRateOct;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_NOV") = originNormSAmtNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_NOV")  = originEvtSAmtNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_NOV") = originSaleTAmtNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_NOV") = originProfTAmtNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_NOV")= originSaleCRateNov;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_NOV")= originProfCRateNov;

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_DEC") = originNormSAmtDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_DEC")  = originEvtSAmtDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_DEC") = originSaleTAmtDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_DEC") = originProfTAmtDec;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE_DEC")= originSaleCRateDec;
    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE_DEC")= originProfCRateDec;
    
    //당초
    var orgNormSAmtTot  = 0;  //정상매출합계
    var orgEvtSAmtTot   = 0;  //행사매출합계
    var orgSaleTAmtTot  = 0;  //총매출합계
    var orgProfTAmtTot  = 0;  //이익합계
    var orgSaleCRateTot = 0;  //매출구성비합계
    var orgProfCRateTot = 0;  //이익구성비합계
    
    var orgNormSAmtJan  = 0;  //정상매출합계
    var orgEvtSAmtJan   = 0;  //행사매출합계
    var orgSaleTAmtJan  = 0;  //총매출합계
    var orgProfTAmtJan  = 0;  //이익합계
    var orgSaleCRateJan = 0;  //매출구성비합계
    var orgProfCRateJan = 0;  //이익구성비합계

    var orgNormSAmtFeb  = 0;  //정상매출합계
    var orgEvtSAmtFeb   = 0;  //행사매출합계
    var orgSaleTAmtFeb  = 0;  //총매출합계
    var orgProfTAmtFeb  = 0;  //이익합계
    var orgSaleCRateFeb = 0;  //매출구성비합계
    var orgProfCRateFeb = 0;  //이익구성비합계

    var orgNormSAmtMar  = 0;  //정상매출합계
    var orgEvtSAmtMar   = 0;  //행사매출합계
    var orgSaleTAmtMar  = 0;  //총매출합계
    var orgProfTAmtMar  = 0;  //이익합계
    var orgSaleCRateMar = 0;  //매출구성비합계
    var orgProfCRateMar = 0;  //이익구성비합계

    var orgNormSAmtApr  = 0;  //정상매출합계
    var orgEvtSAmtApr   = 0;  //행사매출합계
    var orgSaleTAmtApr  = 0;  //총매출합계
    var orgProfTAmtApr  = 0;  //이익합계
    var orgSaleCRateApr = 0;  //매출구성비합계
    var orgProfCRateApr = 0;  //이익구성비합계

    var orgNormSAmtMay  = 0;  //정상매출합계
    var orgEvtSAmtMay   = 0;  //행사매출합계
    var orgSaleTAmtMay  = 0;  //총매출합계
    var orgProfTAmtMay  = 0;  //이익합계
    var orgSaleCRateMay = 0;  //매출구성비합계
    var orgProfCRateMay = 0;  //이익구성비합계

    var orgNormSAmtJun  = 0;  //정상매출합계
    var orgEvtSAmtJun   = 0;  //행사매출합계
    var orgSaleTAmtJun  = 0;  //총매출합계
    var orgProfTAmtJun  = 0;  //이익합계
    var orgSaleCRateJun = 0;  //매출구성비합계
    var orgProfCRateJun = 0;  //이익구성비합계

    var orgNormSAmtJul  = 0;  //정상매출합계
    var orgEvtSAmtJul   = 0;  //행사매출합계
    var orgSaleTAmtJul  = 0;  //총매출합계
    var orgProfTAmtJul  = 0;  //이익합계
    var orgSaleCRateJul = 0;  //매출구성비합계
    var orgProfCRateJul = 0;  //이익구성비합계

    var orgNormSAmtAug  = 0;  //정상매출합계
    var orgEvtSAmtAug   = 0;  //행사매출합계
    var orgSaleTAmtAug  = 0;  //총매출합계
    var orgProfTAmtAug  = 0;  //이익합계
    var orgSaleCRateAug = 0;  //매출구성비합계
    var orgProfCRateAug = 0;  //이익구성비합계

    var orgNormSAmtSep  = 0;  //정상매출합계
    var orgEvtSAmtSep   = 0;  //행사매출합계
    var orgSaleTAmtSep  = 0;  //총매출합계
    var orgProfTAmtSep  = 0;  //이익합계
    var orgSaleCRateSep = 0;  //매출구성비합계
    var orgProfCRateSep = 0;  //이익구성비합계

    var orgNormSAmtOct  = 0;  //정상매출합계
    var orgEvtSAmtOct   = 0;  //행사매출합계
    var orgSaleTAmtOct  = 0;  //총매출합계
    var orgProfTAmtOct  = 0;  //이익합계
    var orgSaleCRateOct = 0;  //매출구성비합계
    var orgProfCRateOct = 0;  //이익구성비합계

    var orgNormSAmtNov  = 0;  //정상매출합계
    var orgEvtSAmtNov   = 0;  //행사매출합계
    var orgSaleTAmtNov  = 0;  //총매출합계
    var orgProfTAmtNov  = 0;  //이익합계
    var orgSaleCRateNov = 0;  //매출구성비합계
    var orgProfCRateNov = 0;  //이익구성비합계

    var orgNormSAmtDec  = 0;  //정상매출합계
    var orgEvtSAmtDec   = 0;  //행사매출합계
    var orgSaleTAmtDec  = 0;  //총매출합계
    var orgProfTAmtDec  = 0;  //이익합계
    var orgSaleCRateDec = 0;  //매출구성비합계
    var orgProfCRateDec = 0;  //이익구성비합계

    
    
    orgNormSAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_TOT"),0);   //당초파트정상
    orgEvtSAmtTot     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_TOT"),0);    //당초파트행사
    orgProfTAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_TOT"),0);   //당초파트이익
    orgSaleTAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_TOT"),0);   //당초파트총매출
    
    
    orgNormSAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JAN"),0);   //당초파트정상
    orgEvtSAmtJan     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JAN"),0);    //당초파트행사
    orgProfTAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JAN"),0);   //당초파트이익
    orgSaleTAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JAN"),0);   //당초파트총매출
    
    
    orgNormSAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_FEB"),0);   //당초파트정상
    orgEvtSAmtFeb     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_FEB"),0);    //당초파트행사
    orgProfTAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_FEB"),0);   //당초파트이익
    orgSaleTAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_FEB"),0);   //당초파트총매출
    
    orgNormSAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_MAR"),0);   //당초파트정상
    orgEvtSAmtMar     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_MAR"),0);    //당초파트행사
    orgProfTAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_MAR"),0);   //당초파트이익
    orgSaleTAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_MAR"),0);   //당초파트총매출
    
    orgNormSAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_APR"),0);   //당초파트정상
    orgEvtSAmtApr     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_APR"),0);    //당초파트행사
    orgProfTAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_APR"),0);   //당초파트이익
    orgSaleTAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_APR"),0);   //당초파트총매출
    
    orgNormSAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_MAY"),0);   //당초파트정상
    orgEvtSAmtMay     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_MAY"),0);    //당초파트행사
    orgProfTAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_MAY"),0);   //당초파트이익
    orgSaleTAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_MAY"),0);   //당초파트총매출
    
    orgNormSAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JUN"),0);   //당초파트정상
    orgEvtSAmtJun     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JUN"),0);    //당초파트행사
    orgProfTAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JUN"),0);   //당초파트이익
    orgSaleTAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JUN"),0);   //당초파트총매출
    
    orgNormSAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JUL"),0);   //당초파트정상
    orgEvtSAmtJul     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JUL"),0);    //당초파트행사
    orgProfTAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JUL"),0);   //당초파트이익
    orgSaleTAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JUL"),0);   //당초파트총매출
    
    orgNormSAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_AUG"),0);   //당초파트정상
    orgEvtSAmtAug     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_AUG"),0);    //당초파트행사
    orgProfTAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_AUG"),0);   //당초파트이익
    orgSaleTAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_AUG"),0);   //당초파트총매출
    
    orgNormSAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_SEP"),0);   //당초파트정상
    orgEvtSAmtSep     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_SEP"),0);    //당초파트행사
    orgProfTAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_SEP"),0);   //당초파트이익
    orgSaleTAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_SEP"),0);   //당초파트총매출
    
    orgNormSAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_OCT"),0);   //당초파트정상
    orgEvtSAmtOct     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_OCT"),0);    //당초파트행사
    orgProfTAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_OCT"),0);   //당초파트이익
    orgSaleTAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_OCT"),0);   //당초파트총매출
    
    orgNormSAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_NOV"),0);   //당초파트정상
    orgEvtSAmtNov     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_NOV"),0);    //당초파트행사
    orgProfTAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_NOV"),0);   //당초파트이익
    orgSaleTAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_NOV"),0);   //당초파트총매출
    
    orgNormSAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_DEC"),0);   //당초파트정상
    orgEvtSAmtDec     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_DEC"),0);    //당초파트행사
    orgProfTAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_DEC"),0);   //당초파트이익
    orgSaleTAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_DEC"),0);   //당초파트총매출
        
       
    
    
        
    DS_IO_DETAIL.Addrow();
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORG_NAME")         = "오차";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"GUBUN")            = "";
    
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_TOT") = getRoundDec("1",orgNormSAmtTot,0) - getRoundDec("1",originNormSAmtTot,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_TOT")  = getRoundDec("1",orgEvtSAmtTot,0) - getRoundDec("1",originEvtSAmtTot,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_TOT") = getRoundDec("1",orgSaleTAmtTot,0) - getRoundDec("1",originSaleTAmtTot,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_TOT") = getRoundDec("1",orgProfTAmtTot,0) - getRoundDec("1",originProfTAmtTot,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JAN") = getRoundDec("1",orgNormSAmtJan,0) - getRoundDec("1",originNormSAmtJan,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JAN")  = getRoundDec("1",orgEvtSAmtJan,0) - getRoundDec("1",originEvtSAmtJan,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JAN") = getRoundDec("1",orgSaleTAmtJan,0) - getRoundDec("1",originSaleTAmtJan,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JAN") = getRoundDec("1",orgProfTAmtJan,0) - getRoundDec("1",originProfTAmtJan,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_FEB") = getRoundDec("1",orgNormSAmtFeb,0) - getRoundDec("1",originNormSAmtFeb,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_FEB")  = getRoundDec("1",orgEvtSAmtFeb,0) - getRoundDec("1",originEvtSAmtFeb,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_FEB") = getRoundDec("1",orgSaleTAmtFeb,0) - getRoundDec("1",originSaleTAmtFeb,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_FEB") = getRoundDec("1",orgProfTAmtFeb,0) - getRoundDec("1",originProfTAmtFeb,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_MAR") = getRoundDec("1",orgNormSAmtMar,0) - getRoundDec("1",originNormSAmtMar,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_MAR")  = getRoundDec("1",orgEvtSAmtMar,0) - getRoundDec("1",originEvtSAmtMar,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_MAR") = getRoundDec("1",orgSaleTAmtMar,0) - getRoundDec("1",originSaleTAmtMar,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_MAR") = getRoundDec("1",orgProfTAmtMar,0) - getRoundDec("1",originProfTAmtMar,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_APR") = getRoundDec("1",orgNormSAmtApr,0) - getRoundDec("1",originNormSAmtApr,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_APR")  = getRoundDec("1",orgEvtSAmtApr,0) - getRoundDec("1",originEvtSAmtApr,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_APR") = getRoundDec("1",orgSaleTAmtApr,0) - getRoundDec("1",originSaleTAmtApr,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_APR") = getRoundDec("1",orgProfTAmtApr,0) - getRoundDec("1",originProfTAmtApr,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_MAY") = getRoundDec("1",orgNormSAmtMay,0) - getRoundDec("1",originNormSAmtMay,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_MAY")  = getRoundDec("1",orgEvtSAmtMay,0) - getRoundDec("1",originEvtSAmtMay,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_MAY") = getRoundDec("1",orgSaleTAmtMay,0) - getRoundDec("1",originSaleTAmtMay,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_MAY") = getRoundDec("1",orgProfTAmtMay,0) - getRoundDec("1",originProfTAmtMay,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JUN") = getRoundDec("1",orgNormSAmtJun,0) - getRoundDec("1",originNormSAmtJun,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JUN")  = getRoundDec("1",orgEvtSAmtJun,0) - getRoundDec("1",originEvtSAmtJun,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JUN") = getRoundDec("1",orgSaleTAmtJun,0) - getRoundDec("1",originSaleTAmtJun,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JUN") = getRoundDec("1",orgProfTAmtJun,0) - getRoundDec("1",originProfTAmtJun,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_JUL") = getRoundDec("1",orgNormSAmtJul,0) - getRoundDec("1",originNormSAmtJul,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_JUL")  = getRoundDec("1",orgEvtSAmtJul,0) - getRoundDec("1",originEvtSAmtJul,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_JUL") = getRoundDec("1",orgSaleTAmtJul,0) - getRoundDec("1",originSaleTAmtJul,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_JUL") = getRoundDec("1",orgProfTAmtJul,0) - getRoundDec("1",originProfTAmtJul,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_AUG") = getRoundDec("1",orgNormSAmtAug,0) - getRoundDec("1",originNormSAmtAug,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_AUG")  = getRoundDec("1",orgEvtSAmtAug,0) - getRoundDec("1",originEvtSAmtAug,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_AUG") = getRoundDec("1",orgSaleTAmtAug,0) - getRoundDec("1",originSaleTAmtAug,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_AUG") = getRoundDec("1",orgProfTAmtAug,0) - getRoundDec("1",originProfTAmtAug,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_SEP") = getRoundDec("1",orgNormSAmtSep,0) - getRoundDec("1",originNormSAmtSep,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_SEP")  = getRoundDec("1",orgEvtSAmtSep,0) - getRoundDec("1",originEvtSAmtSep,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_SEP") = getRoundDec("1",orgSaleTAmtSep,0) - getRoundDec("1",originSaleTAmtSep,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_SEP") = getRoundDec("1",orgProfTAmtSep,0) - getRoundDec("1",originProfTAmtSep,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_OCT") = getRoundDec("1",orgNormSAmtOct,0) - getRoundDec("1",originNormSAmtOct,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_OCT")  = getRoundDec("1",orgEvtSAmtOct,0) - getRoundDec("1",originEvtSAmtOct,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_OCT") = getRoundDec("1",orgSaleTAmtOct,0) - getRoundDec("1",originSaleTAmtOct,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_OCT") = getRoundDec("1",orgProfTAmtOct,0) - getRoundDec("1",originProfTAmtOct,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_NOV") = getRoundDec("1",orgNormSAmtNov,0) - getRoundDec("1",originNormSAmtNov,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_NOV")  = getRoundDec("1",orgEvtSAmtNov,0) - getRoundDec("1",originEvtSAmtNov,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_NOV") = getRoundDec("1",orgSaleTAmtNov,0) - getRoundDec("1",originSaleTAmtNov,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_NOV") = getRoundDec("1",orgProfTAmtNov,0) - getRoundDec("1",originProfTAmtNov,0);

    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT_DEC") = getRoundDec("1",orgNormSAmtDec,0) - getRoundDec("1",originNormSAmtDec,0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT_DEC")  = getRoundDec("1",orgEvtSAmtDec,0) - getRoundDec("1",originEvtSAmtDec,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT_DEC") = getRoundDec("1",orgSaleTAmtDec,0) - getRoundDec("1",originSaleTAmtDec,0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT_DEC") = getRoundDec("1",orgProfTAmtDec,0) - getRoundDec("1",originProfTAmtDec,0);

   
}

/**
* change_ln_sum()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  컬럼변경시 합계/오차 수정
* return값 : 
*/
function change_ln_sum() {
  
    //moveDetailOrg();
    /*
    for(i=1; i <= DS_IO_DETAIL.CountRow;i++){
        if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") == "합계" || DS_IO_DETAIL.NameValue(i,"ORG_NAME") == "" || DS_IO_DETAIL.NameValue(i,"ORG_NAME") == "오차" ){
            DS_IO_DETAIL.DeleteRow(i);
            DS_IO_DETAIL.DeleteRow(i);
            DS_IO_DETAIL.DeleteRow(i);
        }      
    }
    */
 
    var bfyyTotal       = 0;  //전년합계
    var originTotal     = 0;  //당초합계
    var gap             = 0;  //차이
    //전년
    var bfyyNormSAmtTot    = 0;  //정상매출합계
    var bffEvtSAmtTot      = 0;  //행사매출합계
    var bfyySaleTAmtTot    = 0;  //총매출합계
    var bfyyProfTAmtTot    = 0;  //이익합계
    var bfyySaleCRateTot   = 0;  //매출구성비합계
    var bfyyProfCRateTot   = 0;  //이익구성비합계
    
    var bfyyNormSAmtJan    = 0;  //정상매출합계
    var bffEvtSAmtJan      = 0;  //행사매출합계
    var bfyySaleTAmtJan    = 0;  //총매출합계
    var bfyyProfTAmtJan    = 0;  //이익합계
    var bfyySaleCRateJan   = 0;  //매출구성비합계
    var bfyyProfCRateJan   = 0;  //이익구성비합계

    var bfyyNormSAmtFeb    = 0;  //정상매출합계
    var bffEvtSAmtFeb      = 0;  //행사매출합계
    var bfyySaleTAmtFeb    = 0;  //총매출합계
    var bfyyProfTAmtFeb    = 0;  //이익합계
    var bfyySaleCRateFeb   = 0;  //매출구성비합계
    var bfyyProfCRateFeb   = 0;  //이익구성비합계

    var bfyyNormSAmtMar    = 0;  //정상매출합계
    var bffEvtSAmtMar      = 0;  //행사매출합계
    var bfyySaleTAmtMar    = 0;  //총매출합계
    var bfyyProfTAmtMar    = 0;  //이익합계
    var bfyySaleCRateMar   = 0;  //매출구성비합계
    var bfyyProfCRateMar   = 0;  //이익구성비합계

    var bfyyNormSAmtApr    = 0;  //정상매출합계
    var bffEvtSAmtApr      = 0;  //행사매출합계
    var bfyySaleTAmtApr    = 0;  //총매출합계
    var bfyyProfTAmtApr    = 0;  //이익합계
    var bfyySaleCRateApr   = 0;  //매출구성비합계
    var bfyyProfCRateApr   = 0;  //이익구성비합계

    var bfyyNormSAmtMay    = 0;  //정상매출합계
    var bffEvtSAmtMay      = 0;  //행사매출합계
    var bfyySaleTAmtMay    = 0;  //총매출합계
    var bfyyProfTAmtMay    = 0;  //이익합계
    var bfyySaleCRateMay   = 0;  //매출구성비합계
    var bfyyProfCRateMay   = 0;  //이익구성비합계

    var bfyyNormSAmtJun    = 0;  //정상매출합계
    var bffEvtSAmtJun      = 0;  //행사매출합계
    var bfyySaleTAmtJun    = 0;  //총매출합계
    var bfyyProfTAmtJun    = 0;  //이익합계
    var bfyySaleCRateJun   = 0;  //매출구성비합계
    var bfyyProfCRateJun   = 0;  //이익구성비합계

    var bfyyNormSAmtJul    = 0;  //정상매출합계
    var bffEvtSAmtJul      = 0;  //행사매출합계
    var bfyySaleTAmtJul    = 0;  //총매출합계
    var bfyyProfTAmtJul    = 0;  //이익합계
    var bfyySaleCRateJul   = 0;  //매출구성비합계
    var bfyyProfCRateJul   = 0;  //이익구성비합계

    var bfyyNormSAmtAug    = 0;  //정상매출합계
    var bffEvtSAmtAug      = 0;  //행사매출합계
    var bfyySaleTAmtAug    = 0;  //총매출합계
    var bfyyProfTAmtAug    = 0;  //이익합계
    var bfyySaleCRateAug   = 0;  //매출구성비합계
    var bfyyProfCRateAug   = 0;  //이익구성비합계

    var bfyyNormSAmtSep    = 0;  //정상매출합계
    var bffEvtSAmtSep      = 0;  //행사매출합계
    var bfyySaleTAmtSep    = 0;  //총매출합계
    var bfyyProfTAmtSep    = 0;  //이익합계
    var bfyySaleCRateSep   = 0;  //매출구성비합계
    var bfyyProfCRateSep   = 0;  //이익구성비합계

    var bfyyNormSAmtOct    = 0;  //정상매출합계
    var bffEvtSAmtOct      = 0;  //행사매출합계
    var bfyySaleTAmtOct    = 0;  //총매출합계
    var bfyyProfTAmtOct    = 0;  //이익합계
    var bfyySaleCRateOct   = 0;  //매출구성비합계
    var bfyyProfCRateOct   = 0;  //이익구성비합계

    var bfyyNormSAmtNov    = 0;  //정상매출합계
    var bffEvtSAmtNov      = 0;  //행사매출합계
    var bfyySaleTAmtNov    = 0;  //총매출합계
    var bfyyProfTAmtNov    = 0;  //이익합계
    var bfyySaleCRateNov   = 0;  //매출구성비합계
    var bfyyProfCRateNov   = 0;  //이익구성비합계

    var bfyyNormSAmtDec    = 0;  //정상매출합계
    var bffEvtSAmtDec      = 0;  //행사매출합계
    var bfyySaleTAmtDec    = 0;  //총매출합계
    var bfyyProfTAmtDec    = 0;  //이익합계
    var bfyySaleCRateDec   = 0;  //매출구성비합계
    var bfyyProfCRateDec   = 0;  //이익구성비합계
    
    //당초
    var originNormSAmtTot  = 0;  //정상매출합계
    var originEvtSAmtTot   = 0;  //행사매출합계
    var originSaleTAmtTot  = 0;  //총매출합계
    var originProfTAmtTot  = 0;  //이익합계
    var originSaleCRateTot = 0;  //매출구성비합계
    var originProfCRateTot = 0;  //이익구성비합계
    
    var originNormSAmtJan  = 0;  //정상매출합계
    var originEvtSAmtJan   = 0;  //행사매출합계
    var originSaleTAmtJan  = 0;  //총매출합계
    var originProfTAmtJan  = 0;  //이익합계
    var originSaleCRateJan = 0;  //매출구성비합계
    var originProfCRateJan = 0;  //이익구성비합계

    var originNormSAmtFeb  = 0;  //정상매출합계
    var originEvtSAmtFeb   = 0;  //행사매출합계
    var originSaleTAmtFeb  = 0;  //총매출합계
    var originProfTAmtFeb  = 0;  //이익합계
    var originSaleCRateFeb = 0;  //매출구성비합계
    var originProfCRateFeb = 0;  //이익구성비합계

    var originNormSAmtMar  = 0;  //정상매출합계
    var originEvtSAmtMar   = 0;  //행사매출합계
    var originSaleTAmtMar  = 0;  //총매출합계
    var originProfTAmtMar  = 0;  //이익합계
    var originSaleCRateMar = 0;  //매출구성비합계
    var originProfCRateMar = 0;  //이익구성비합계

    var originNormSAmtApr  = 0;  //정상매출합계
    var originEvtSAmtApr   = 0;  //행사매출합계
    var originSaleTAmtApr  = 0;  //총매출합계
    var originProfTAmtApr  = 0;  //이익합계
    var originSaleCRateApr = 0;  //매출구성비합계
    var originProfCRateApr = 0;  //이익구성비합계

    var originNormSAmtMay  = 0;  //정상매출합계
    var originEvtSAmtMay   = 0;  //행사매출합계
    var originSaleTAmtMay  = 0;  //총매출합계
    var originProfTAmtMay  = 0;  //이익합계
    var originSaleCRateMay = 0;  //매출구성비합계
    var originProfCRateMay = 0;  //이익구성비합계

    var originNormSAmtJun  = 0;  //정상매출합계
    var originEvtSAmtJun   = 0;  //행사매출합계
    var originSaleTAmtJun  = 0;  //총매출합계
    var originProfTAmtJun  = 0;  //이익합계
    var originSaleCRateJun = 0;  //매출구성비합계
    var originProfCRateJun = 0;  //이익구성비합계

    var originNormSAmtJul  = 0;  //정상매출합계
    var originEvtSAmtJul   = 0;  //행사매출합계
    var originSaleTAmtJul  = 0;  //총매출합계
    var originProfTAmtJul  = 0;  //이익합계
    var originSaleCRateJul = 0;  //매출구성비합계
    var originProfCRateJul = 0;  //이익구성비합계

    var originNormSAmtAug  = 0;  //정상매출합계
    var originEvtSAmtAug   = 0;  //행사매출합계
    var originSaleTAmtAug  = 0;  //총매출합계
    var originProfTAmtAug  = 0;  //이익합계
    var originSaleCRateAug = 0;  //매출구성비합계
    var originProfCRateAug = 0;  //이익구성비합계

    var originNormSAmtSep  = 0;  //정상매출합계
    var originEvtSAmtSep   = 0;  //행사매출합계
    var originSaleTAmtSep  = 0;  //총매출합계
    var originProfTAmtSep  = 0;  //이익합계
    var originSaleCRateSep = 0;  //매출구성비합계
    var originProfCRateSep = 0;  //이익구성비합계

    var originNormSAmtOct  = 0;  //정상매출합계
    var originEvtSAmtOct   = 0;  //행사매출합계
    var originSaleTAmtOct  = 0;  //총매출합계
    var originProfTAmtOct  = 0;  //이익합계
    var originSaleCRateOct = 0;  //매출구성비합계
    var originProfCRateOct = 0;  //이익구성비합계

    var originNormSAmtNov  = 0;  //정상매출합계
    var originEvtSAmtNov   = 0;  //행사매출합계
    var originSaleTAmtNov  = 0;  //총매출합계
    var originProfTAmtNov  = 0;  //이익합계
    var originSaleCRateNov = 0;  //매출구성비합계
    var originProfCRateNov = 0;  //이익구성비합계

    var originNormSAmtDec  = 0;  //정상매출합계
    var originEvtSAmtDec   = 0;  //행사매출합계
    var originSaleTAmtDec  = 0;  //총매출합계
    var originProfTAmtDec  = 0;  //이익합계
    var originSaleCRateDec = 0;  //매출구성비합계
    var originProfCRateDec = 0;  //이익구성비합계

    
    
    
    for(i=1; i <= DS_IO_DETAIL.CountRow; i++){
        if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차" ){
            bfyyNormSAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_TOT"),0);
            bffEvtSAmtTot       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_TOT"),0);
            bfyySaleTAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
            bfyyProfTAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
            bfyySaleCRateTot    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT"),2);
            bfyyProfCRateTot    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT"),2);
            
            bfyyNormSAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN"),0);
            bffEvtSAmtJan       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN"),0);
            bfyySaleTAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0);
            bfyyProfTAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0);
            bfyySaleCRateJan    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN"),2);
            bfyyProfCRateJan    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN"),2);
            
            bfyyNormSAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_FEB"),0);
            bffEvtSAmtFeb       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_FEB"),0);
            bfyySaleTAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0);
            bfyyProfTAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0);
            bfyySaleCRateFeb    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB"),2);
            bfyyProfCRateFeb    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB"),2);
            
            bfyyNormSAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAR"),0);
            bffEvtSAmtMar       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAR"),0);
            bfyySaleTAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0);
            bfyyProfTAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0);
            bfyySaleCRateMar    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR"),2);
            bfyyProfCRateMar    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR"),2);

            bfyyNormSAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_APR"),0);
            bffEvtSAmtApr       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_APR"),0);
            bfyySaleTAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0);
            bfyyProfTAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0);
            bfyySaleCRateApr    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR"),2);
            bfyyProfCRateApr    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR"),2);

            bfyyNormSAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAY"),0);
            bffEvtSAmtMay       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAY"),0);
            bfyySaleTAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0);
            bfyyProfTAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0);
            bfyySaleCRateMay    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY"),2);
            bfyyProfCRateMay    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY"),2);

            bfyyNormSAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUN"),0);
            bffEvtSAmtJun       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUN"),0);
            bfyySaleTAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0);
            bfyyProfTAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0);
            bfyySaleCRateJun    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN"),2);
            bfyyProfCRateJun    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN"),2);

            bfyyNormSAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUL"),0);
            bffEvtSAmtJul       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUL"),0);
            bfyySaleTAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0);
            bfyyProfTAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0);
            bfyySaleCRateJul    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL"),2);
            bfyyProfCRateJul    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL"),2);

            bfyyNormSAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_AUG"),0);
            bffEvtSAmtAug       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_AUG"),0);
            bfyySaleTAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0);
            bfyyProfTAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0);
            bfyySaleCRateAug    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG"),2);
            bfyyProfCRateAug    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG"),2);

            bfyyNormSAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_SEP"),0);
            bffEvtSAmtSep       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_SEP"),0);
            bfyySaleTAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0);
            bfyyProfTAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0);
            bfyySaleCRateSep    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP"),2);
            bfyyProfCRateSep    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP"),2);

            bfyyNormSAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_OCT"),0);
            bffEvtSAmtOct       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_OCT"),0);
            bfyySaleTAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0);
            bfyyProfTAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0);
            bfyySaleCRateOct    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT"),2);
            bfyyProfCRateOct    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT"),2);

            bfyyNormSAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_NOV"),0);
            bffEvtSAmtNov       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_NOV"),0);
            bfyySaleTAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0);
            bfyyProfTAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0);
            bfyySaleCRateNov    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV"),2);
            bfyyProfCRateNov    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV"),2);

            bfyyNormSAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_DEC"),0);
            bffEvtSAmtDec       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_DEC"),0);
            bfyySaleTAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0);
            bfyyProfTAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0);
            bfyySaleCRateDec    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC"),2);
            bfyyProfCRateDec    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC"),2);
            
        }
        else{
            if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차" ){
                originNormSAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_TOT"),0);
                originEvtSAmtTot      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_TOT"),0);
                originSaleTAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
                originProfTAmtTot     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
                originSaleCRateTot    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT"),2);
                originProfCRateTot    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT"),2);
                
                originNormSAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN"),0);
                originEvtSAmtJan      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN"),0);
                originSaleTAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0);
                originProfTAmtJan     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0);
                originSaleCRateJan    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN"),2);
                originProfCRateJan    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN"),2);
                
                originNormSAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_FEB"),0);
                originEvtSAmtFeb      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_FEB"),0);
                originSaleTAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0);
                originProfTAmtFeb     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0);
                originSaleCRateFeb    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB"),2);
                originProfCRateFeb    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB"),2);
                
                originNormSAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAR"),0);
                originEvtSAmtMar      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAR"),0);
                originSaleTAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0);
                originProfTAmtMar     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0);
                originSaleCRateMar    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR"),2);
                originProfCRateMar    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR"),2);
    
                originNormSAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_APR"),0);
                originEvtSAmtApr      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_APR"),0);
                originSaleTAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0);
                originProfTAmtApr     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0);
                originSaleCRateApr    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR"),2);
                originProfCRateApr    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR"),2);
    
                originNormSAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAY"),0);
                originEvtSAmtMay      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAY"),0);
                originSaleTAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0);
                originProfTAmtMay     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0);
                originSaleCRateMay    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY"),2);
                originProfCRateMay    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY"),2);
    
                originNormSAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUN"),0);
                originEvtSAmtJun      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUN"),0);
                originSaleTAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0);
                originProfTAmtJun     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0);
                originSaleCRateJun    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN"),2);
                originProfCRateJun    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN"),2);
    
                originNormSAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUL"),0);
                originEvtSAmtJul      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUL"),0);
                originSaleTAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0);
                originProfTAmtJul     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0);
                originSaleCRateJul    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL"),2);
                originProfCRateJul    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL"),2);
    
                originNormSAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_AUG"),0);
                originEvtSAmtAug      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_AUG"),0);
                originSaleTAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0);
                originProfTAmtAug     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0);
                originSaleCRateAug    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG"),2);
                originProfCRateAug    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG"),2);
    
                originNormSAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_SEP"),0);
                originEvtSAmtSep      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_SEP"),0);
                originSaleTAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0);
                originProfTAmtSep     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0);
                originSaleCRateSep    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP"),2);
                originProfCRateSep    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP"),2);
    
                originNormSAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_OCT"),0);
                originEvtSAmtOct      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_OCT"),0);
                originSaleTAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0);
                originProfTAmtOct     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0);
                originSaleCRateOct    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT"),2);
                originProfCRateOct    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT"),2);
    
                originNormSAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_NOV"),0);
                originEvtSAmtNov      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_NOV"),0);
                originSaleTAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0);
                originProfTAmtNov     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0);
                originSaleCRateNov    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV"),2);
                originProfCRateNov    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV"),2);
    
                originNormSAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_DEC"),0);
                originEvtSAmtDec      += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_DEC"),0);
                originSaleTAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0);
                originProfTAmtDec     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0);
                originSaleCRateDec    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC"),2);
                originProfCRateDec    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC"),2);
                
            }
        }
    }
    
    
    for(i=1; i <= DS_IO_DETAIL.CountRow;i++){
        if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") == "합계"){
            var profTotalRow = i;
        }    
        if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") == ""){
            var originTotalRow = i;
        }    
        if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") == "오차" ){
            var gabRow = i;
        }      
    }
    
    DS_IO_DETAIL.NameValue(profTotalRow,"ORG_NAME")         = "합계";
    DS_IO_DETAIL.NameValue(profTotalRow,"GUBUN")            = "전년매출";
    
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_TOT") = bfyyNormSAmtTot;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_TOT")  = bffEvtSAmtTot;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_TOT") = bfyySaleTAmtTot;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_TOT") = bfyyProfTAmtTot;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_TOT")= bfyySaleCRateTot;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_TOT")= bfyyProfCRateTot;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_JAN") = bfyyNormSAmtJan;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_JAN")  = bffEvtSAmtJan;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_JAN") = bfyySaleTAmtJan;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_JAN") = bfyyProfTAmtJan;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_JAN")= bfyySaleCRateJan;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_JAN")= bfyyProfCRateJan;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_FEB") = bfyyNormSAmtFeb;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_FEB")  = bffEvtSAmtFeb;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_FEB") = bfyySaleTAmtFeb;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_FEB") = bfyyProfTAmtFeb;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_FEB")= bfyySaleCRateFeb;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_FEB")= bfyyProfCRateFeb;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_MAR") = bfyyNormSAmtMar;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_MAR")  = bffEvtSAmtMar;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_MAR") = bfyySaleTAmtMar;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_MAR") = bfyyProfTAmtMar;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_MAR")= bfyySaleCRateMar;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_MAR")= bfyyProfCRateMar;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_APR") = bfyyNormSAmtApr;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_APR")  = bffEvtSAmtApr;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_APR") = bfyySaleTAmtApr;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_APR") = bfyyProfTAmtApr;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_APR")= bfyySaleCRateApr;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_APR")= bfyyProfCRateApr;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_MAY") = bfyyNormSAmtMay;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_MAY")  = bffEvtSAmtMay;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_MAY") = bfyySaleTAmtMay;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_MAY") = bfyyProfTAmtMay;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_MAY")= bfyySaleCRateMay;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_MAY")= bfyyProfCRateMay;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_JUN") = bfyyNormSAmtJun;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_JUN")  = bffEvtSAmtJun;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_JUN") = bfyySaleTAmtJun;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_JUN") = bfyyProfTAmtJun;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_JUN")= bfyySaleCRateJun;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_JUN")= bfyyProfCRateJun;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_JUL") = bfyyNormSAmtJul;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_JUL")  = bffEvtSAmtJul;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_JUL") = bfyySaleTAmtJul;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_JUL") = bfyyProfTAmtJul;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_JUL")= bfyySaleCRateJul;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_JUL")= bfyyProfCRateJul;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_AUG") = bfyyNormSAmtAug;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_AUG")  = bffEvtSAmtAug;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_AUG") = bfyySaleTAmtAug;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_AUG") = bfyyProfTAmtAug;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_AUG")= bfyySaleCRateAug;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_AUG")= bfyyProfCRateAug;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_SEP") = bfyyNormSAmtSep;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_SEP")  = bffEvtSAmtSep;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_SEP") = bfyySaleTAmtSep;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_SEP") = bfyyProfTAmtSep;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_SEP")= bfyySaleCRateSep;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_SEP")= bfyyProfCRateSep;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_OCT") = bfyyNormSAmtOct;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_OCT")  = bffEvtSAmtOct;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_OCT") = bfyySaleTAmtOct;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_OCT") = bfyyProfTAmtOct;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_OCT")= bfyySaleCRateOct;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_OCT")= bfyyProfCRateOct;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_NOV") = bfyyNormSAmtNov;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_NOV")  = bffEvtSAmtNov;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_NOV") = bfyySaleTAmtNov;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_NOV") = bfyyProfTAmtNov;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_NOV")= bfyySaleCRateNov;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_NOV")= bfyyProfCRateNov;

    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_NORM_SAMT_DEC") = bfyyNormSAmtDec;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_EVT_SAMT_DEC")  = bffEvtSAmtDec;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_TAMT_DEC") = bfyySaleTAmtDec;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_TAMT_DEC") = bfyyProfTAmtDec;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_SALE_CRATE_DEC")= bfyySaleCRateDec;
    DS_IO_DETAIL.NameValue(profTotalRow,"ORIGIN_PROF_CRATE_DEC")= bfyyProfCRateDec;
    
    
    DS_IO_DETAIL.NameValue(originTotalRow,"ORG_NAME")         = "";
    DS_IO_DETAIL.NameValue(originTotalRow,"GUBUN")            = "당초목표";
    
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_TOT") = originNormSAmtTot;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_TOT")  = originEvtSAmtTot;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_TOT") = originSaleTAmtTot;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_TOT") = originProfTAmtTot;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_TOT")= originSaleCRateTot;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_TOT")= originProfCRateTot;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_JAN") = originNormSAmtJan;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_JAN")  = originEvtSAmtJan;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_JAN") = originSaleTAmtJan;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_JAN") = originProfTAmtJan;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_JAN")= originSaleCRateJan;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_JAN")= originProfCRateJan;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_FEB") = originNormSAmtFeb;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_FEB")  = originEvtSAmtFeb;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_FEB") = originSaleTAmtFeb;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_FEB") = originProfTAmtFeb;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_FEB")= originSaleCRateFeb;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_FEB")= originProfCRateFeb;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_MAR") = originNormSAmtMar;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_MAR")  = originEvtSAmtMar;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_MAR") = originSaleTAmtMar;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_MAR") = originProfTAmtMar;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_MAR")= originSaleCRateMar;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_MAR")= originProfCRateMar;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_APR") = originNormSAmtApr;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_APR")  = originEvtSAmtApr;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_APR") = originSaleTAmtApr;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_APR") = originProfTAmtApr;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_APR")= originSaleCRateApr;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_APR")= originProfCRateApr;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_MAY") = originNormSAmtMay;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_MAY")  = originEvtSAmtMay;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_MAY") = originSaleTAmtMay;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_MAY") = originProfTAmtMay;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_MAY")= originSaleCRateMay;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_MAY")= originProfCRateMay;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_JUN") = originNormSAmtJun;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_JUN")  = originEvtSAmtJun;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_JUN") = originSaleTAmtJun;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_JUN") = originProfTAmtJun;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_JUN")= originSaleCRateJun;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_JUN")= originProfCRateJun;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_JUL") = originNormSAmtJul;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_JUL")  = originEvtSAmtJul;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_JUL") = originSaleTAmtJul;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_JUL") = originProfTAmtJul;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_JUL")= originSaleCRateJul;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_JUL")= originProfCRateJul;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_AUG") = originNormSAmtAug;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_AUG")  = originEvtSAmtAug;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_AUG") = originSaleTAmtAug;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_AUG") = originProfTAmtAug;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_AUG")= originSaleCRateAug;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_AUG")= originProfCRateAug;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_SEP") = originNormSAmtSep;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_SEP")  = originEvtSAmtSep;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_SEP") = originSaleTAmtSep;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_SEP") = originProfTAmtSep;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_SEP")= originSaleCRateSep;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_SEP")= originProfCRateSep;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_OCT") = originNormSAmtOct;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_OCT")  = originEvtSAmtOct;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_OCT") = originSaleTAmtOct;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_OCT") = originProfTAmtOct;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_OCT")= originSaleCRateOct;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_OCT")= originProfCRateOct;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_NOV") = originNormSAmtNov;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_NOV")  = originEvtSAmtNov;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_NOV") = originSaleTAmtNov;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_NOV") = originProfTAmtNov;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_NOV")= originSaleCRateNov;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_NOV")= originProfCRateNov;

    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_NORM_SAMT_DEC") = originNormSAmtDec;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_EVT_SAMT_DEC")  = originEvtSAmtDec;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_TAMT_DEC") = originSaleTAmtDec;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_TAMT_DEC") = originProfTAmtDec;
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_SALE_CRATE_DEC")= originSaleCRateDec;
    //alert(DS_IO_DETAIL.NameValue(4,"ORIGIN_PROF_CRATE_DEC"));
    DS_IO_DETAIL.NameValue(originTotalRow,"ORIGIN_PROF_CRATE_DEC")= originProfCRateDec;
    //alert("originProfCRateDec>>"+originProfCRateDec);
    //당초
    var orgNormSAmtTot  = 0;  //정상매출합계
    var orgEvtSAmtTot   = 0;  //행사매출합계
    var orgSaleTAmtTot  = 0;  //총매출합계
    var orgProfTAmtTot  = 0;  //이익합계
    var orgSaleCRateTot = 0;  //매출구성비합계
    var orgProfCRateTot = 0;  //이익구성비합계
    
    var orgNormSAmtJan  = 0;  //정상매출합계
    var orgEvtSAmtJan   = 0;  //행사매출합계
    var orgSaleTAmtJan  = 0;  //총매출합계
    var orgProfTAmtJan  = 0;  //이익합계
    var orgSaleCRateJan = 0;  //매출구성비합계
    var orgProfCRateJan = 0;  //이익구성비합계

    var orgNormSAmtFeb  = 0;  //정상매출합계
    var orgEvtSAmtFeb   = 0;  //행사매출합계
    var orgSaleTAmtFeb  = 0;  //총매출합계
    var orgProfTAmtFeb  = 0;  //이익합계
    var orgSaleCRateFeb = 0;  //매출구성비합계
    var orgProfCRateFeb = 0;  //이익구성비합계

    var orgNormSAmtMar  = 0;  //정상매출합계
    var orgEvtSAmtMar   = 0;  //행사매출합계
    var orgSaleTAmtMar  = 0;  //총매출합계
    var orgProfTAmtMar  = 0;  //이익합계
    var orgSaleCRateMar = 0;  //매출구성비합계
    var orgProfCRateMar = 0;  //이익구성비합계

    var orgNormSAmtApr  = 0;  //정상매출합계
    var orgEvtSAmtApr   = 0;  //행사매출합계
    var orgSaleTAmtApr  = 0;  //총매출합계
    var orgProfTAmtApr  = 0;  //이익합계
    var orgSaleCRateApr = 0;  //매출구성비합계
    var orgProfCRateApr = 0;  //이익구성비합계

    var orgNormSAmtMay  = 0;  //정상매출합계
    var orgEvtSAmtMay   = 0;  //행사매출합계
    var orgSaleTAmtMay  = 0;  //총매출합계
    var orgProfTAmtMay  = 0;  //이익합계
    var orgSaleCRateMay = 0;  //매출구성비합계
    var orgProfCRateMay = 0;  //이익구성비합계

    var orgNormSAmtJun  = 0;  //정상매출합계
    var orgEvtSAmtJun   = 0;  //행사매출합계
    var orgSaleTAmtJun  = 0;  //총매출합계
    var orgProfTAmtJun  = 0;  //이익합계
    var orgSaleCRateJun = 0;  //매출구성비합계
    var orgProfCRateJun = 0;  //이익구성비합계

    var orgNormSAmtJul  = 0;  //정상매출합계
    var orgEvtSAmtJul   = 0;  //행사매출합계
    var orgSaleTAmtJul  = 0;  //총매출합계
    var orgProfTAmtJul  = 0;  //이익합계
    var orgSaleCRateJul = 0;  //매출구성비합계
    var orgProfCRateJul = 0;  //이익구성비합계

    var orgNormSAmtAug  = 0;  //정상매출합계
    var orgEvtSAmtAug   = 0;  //행사매출합계
    var orgSaleTAmtAug  = 0;  //총매출합계
    var orgProfTAmtAug  = 0;  //이익합계
    var orgSaleCRateAug = 0;  //매출구성비합계
    var orgProfCRateAug = 0;  //이익구성비합계

    var orgNormSAmtSep  = 0;  //정상매출합계
    var orgEvtSAmtSep   = 0;  //행사매출합계
    var orgSaleTAmtSep  = 0;  //총매출합계
    var orgProfTAmtSep  = 0;  //이익합계
    var orgSaleCRateSep = 0;  //매출구성비합계
    var orgProfCRateSep = 0;  //이익구성비합계

    var orgNormSAmtOct  = 0;  //정상매출합계
    var orgEvtSAmtOct   = 0;  //행사매출합계
    var orgSaleTAmtOct  = 0;  //총매출합계
    var orgProfTAmtOct  = 0;  //이익합계
    var orgSaleCRateOct = 0;  //매출구성비합계
    var orgProfCRateOct = 0;  //이익구성비합계

    var orgNormSAmtNov  = 0;  //정상매출합계
    var orgEvtSAmtNov   = 0;  //행사매출합계
    var orgSaleTAmtNov  = 0;  //총매출합계
    var orgProfTAmtNov  = 0;  //이익합계
    var orgSaleCRateNov = 0;  //매출구성비합계
    var orgProfCRateNov = 0;  //이익구성비합계

    var orgNormSAmtDec  = 0;  //정상매출합계
    var orgEvtSAmtDec   = 0;  //행사매출합계
    var orgSaleTAmtDec  = 0;  //총매출합계
    var orgProfTAmtDec  = 0;  //이익합계
    var orgSaleCRateDec = 0;  //매출구성비합계
    var orgProfCRateDec = 0;  //이익구성비합계

    
    orgNormSAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_TOT"),0);   //당초파트정상
    orgEvtSAmtTot     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_TOT"),0);    //당초파트행사
    orgProfTAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_TOT"),0);   //당초파트이익
    orgSaleTAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_TOT"),0);   //당초파트총매출
    
    
    orgNormSAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JAN"),0);   //당초파트정상
    orgEvtSAmtJan     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JAN"),0);    //당초파트행사
    orgProfTAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JAN"),0);   //당초파트이익
    orgSaleTAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JAN"),0);   //당초파트총매출
    
    
    orgNormSAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_FEB"),0);   //당초파트정상
    orgEvtSAmtFeb     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_FEB"),0);    //당초파트행사
    orgProfTAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_FEB"),0);   //당초파트이익
    orgSaleTAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_FEB"),0);   //당초파트총매출
    
    orgNormSAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_MAR"),0);   //당초파트정상
    orgEvtSAmtMar     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_MAR"),0);    //당초파트행사
    orgProfTAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_MAR"),0);   //당초파트이익
    orgSaleTAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_MAR"),0);   //당초파트총매출
    
    orgNormSAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_APR"),0);   //당초파트정상
    orgEvtSAmtApr     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_APR"),0);    //당초파트행사
    orgProfTAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_APR"),0);   //당초파트이익
    orgSaleTAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_APR"),0);   //당초파트총매출
    
    orgNormSAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_MAY"),0);   //당초파트정상
    orgEvtSAmtMay     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_MAY"),0);    //당초파트행사
    orgProfTAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_MAY"),0);   //당초파트이익
    orgSaleTAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_MAY"),0);   //당초파트총매출
    
    orgNormSAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JUN"),0);   //당초파트정상
    orgEvtSAmtJun     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JUN"),0);    //당초파트행사
    orgProfTAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JUN"),0);   //당초파트이익
    orgSaleTAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JUN"),0);   //당초파트총매출
    
    orgNormSAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JUL"),0);   //당초파트정상
    orgEvtSAmtJul     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JUL"),0);    //당초파트행사
    orgProfTAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JUL"),0);   //당초파트이익
    orgSaleTAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JUL"),0);   //당초파트총매출
    
    orgNormSAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_AUG"),0);   //당초파트정상
    orgEvtSAmtAug     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_AUG"),0);    //당초파트행사
    orgProfTAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_AUG"),0);   //당초파트이익
    orgSaleTAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_AUG"),0);   //당초파트총매출
    
    orgNormSAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_SEP"),0);   //당초파트정상
    orgEvtSAmtSep     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_SEP"),0);    //당초파트행사
    orgProfTAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_SEP"),0);   //당초파트이익
    orgSaleTAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_SEP"),0);   //당초파트총매출
    
    orgNormSAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_OCT"),0);   //당초파트정상
    orgEvtSAmtOct     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_OCT"),0);    //당초파트행사
    orgProfTAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_OCT"),0);   //당초파트이익
    orgSaleTAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_OCT"),0);   //당초파트총매출
    
    orgNormSAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_NOV"),0);   //당초파트정상
    orgEvtSAmtNov     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_NOV"),0);    //당초파트행사
    orgProfTAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_NOV"),0);   //당초파트이익
    orgSaleTAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_NOV"),0);   //당초파트총매출
    
    orgNormSAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_DEC"),0);   //당초파트정상
    orgEvtSAmtDec     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_DEC"),0);    //당초파트행사
    orgProfTAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_DEC"),0);   //당초파트이익
    orgSaleTAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_DEC"),0);   //당초파트총매출
        
        
    
    DS_IO_DETAIL.NameValue(gabRow,"ORG_NAME")         = "오차";
    DS_IO_DETAIL.NameValue(gabRow,"GUBUN")            = "";
    
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_TOT") = getRoundDec("1",orgNormSAmtTot,0) - getRoundDec("1",originNormSAmtTot,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_TOT")  = getRoundDec("1",orgEvtSAmtTot,0) - getRoundDec("1",originEvtSAmtTot,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_TOT") = getRoundDec("1",orgSaleTAmtTot,0) - getRoundDec("1",originSaleTAmtTot,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_TOT") = getRoundDec("1",orgProfTAmtTot,0) - getRoundDec("1",originProfTAmtTot,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_JAN") = getRoundDec("1",orgNormSAmtJan,0) - getRoundDec("1",originNormSAmtJan,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_JAN")  = getRoundDec("1",orgEvtSAmtJan,0) - getRoundDec("1",originEvtSAmtJan,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_JAN") = getRoundDec("1",orgSaleTAmtJan,0) - getRoundDec("1",originSaleTAmtJan,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_JAN") = getRoundDec("1",orgProfTAmtJan,0) - getRoundDec("1",originProfTAmtJan,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_FEB") = getRoundDec("1",orgNormSAmtFeb,0) - getRoundDec("1",originNormSAmtFeb,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_FEB")  = getRoundDec("1",orgEvtSAmtFeb,0) - getRoundDec("1",originEvtSAmtFeb,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_FEB") = getRoundDec("1",orgSaleTAmtFeb,0) - getRoundDec("1",originSaleTAmtFeb,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_FEB") = getRoundDec("1",orgProfTAmtFeb,0) - getRoundDec("1",originProfTAmtFeb,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_MAR") = getRoundDec("1",orgNormSAmtMar,0) - getRoundDec("1",originNormSAmtMar,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_MAR")  = getRoundDec("1",orgEvtSAmtMar,0) - getRoundDec("1",originEvtSAmtMar,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_MAR") = getRoundDec("1",orgSaleTAmtMar,0) - getRoundDec("1",originSaleTAmtMar,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_MAR") = getRoundDec("1",orgProfTAmtMar,0) - getRoundDec("1",originProfTAmtMar,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_APR") = getRoundDec("1",orgNormSAmtApr,0) - getRoundDec("1",originNormSAmtApr,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_APR")  = getRoundDec("1",orgEvtSAmtApr,0) - getRoundDec("1",originEvtSAmtApr,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_APR") = getRoundDec("1",orgSaleTAmtApr,0) - getRoundDec("1",originSaleTAmtApr,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_APR") = getRoundDec("1",orgProfTAmtApr,0) - getRoundDec("1",originProfTAmtApr,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_MAY") = getRoundDec("1",orgNormSAmtMay,0) - getRoundDec("1",originNormSAmtMay,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_MAY")  = getRoundDec("1",orgEvtSAmtMay,0) - getRoundDec("1",originEvtSAmtMay,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_MAY") = getRoundDec("1",orgSaleTAmtMay,0) - getRoundDec("1",originSaleTAmtMay,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_MAY") = getRoundDec("1",orgProfTAmtMay,0) - getRoundDec("1",originProfTAmtMay,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_JUN") = getRoundDec("1",orgNormSAmtJun,0) - getRoundDec("1",originNormSAmtJun,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_JUN")  = getRoundDec("1",orgEvtSAmtJun,0) - getRoundDec("1",originEvtSAmtJun,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_JUN") = getRoundDec("1",orgSaleTAmtJun,0) - getRoundDec("1",originSaleTAmtJun,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_JUN") = getRoundDec("1",orgProfTAmtJun,0) - getRoundDec("1",originProfTAmtJun,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_JUL") = getRoundDec("1",orgNormSAmtJul,0) - getRoundDec("1",originNormSAmtJul,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_JUL")  = getRoundDec("1",orgEvtSAmtJul,0) - getRoundDec("1",originEvtSAmtJul,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_JUL") = getRoundDec("1",orgSaleTAmtJul,0) - getRoundDec("1",originSaleTAmtJul,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_JUL") = getRoundDec("1",orgProfTAmtJul,0) - getRoundDec("1",originProfTAmtJul,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_AUG") = getRoundDec("1",orgNormSAmtAug,0) - getRoundDec("1",originNormSAmtAug,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_AUG")  = getRoundDec("1",orgEvtSAmtAug,0) - getRoundDec("1",originEvtSAmtAug,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_AUG") = getRoundDec("1",orgSaleTAmtAug,0) - getRoundDec("1",originSaleTAmtAug,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_AUG") = getRoundDec("1",orgProfTAmtAug,0) - getRoundDec("1",originProfTAmtAug,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_SEP") = getRoundDec("1",orgNormSAmtSep,0) - getRoundDec("1",originNormSAmtSep,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_SEP")  = getRoundDec("1",orgEvtSAmtSep,0) - getRoundDec("1",originEvtSAmtSep,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_SEP") = getRoundDec("1",orgSaleTAmtSep,0) - getRoundDec("1",originSaleTAmtSep,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_SEP") = getRoundDec("1",orgProfTAmtSep,0) - getRoundDec("1",originProfTAmtSep,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_OCT") = getRoundDec("1",orgNormSAmtOct,0) - getRoundDec("1",originNormSAmtOct,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_OCT")  = getRoundDec("1",orgEvtSAmtOct,0) - getRoundDec("1",originEvtSAmtOct,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_OCT") = getRoundDec("1",orgSaleTAmtOct,0) - getRoundDec("1",originSaleTAmtOct,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_OCT") = getRoundDec("1",orgProfTAmtOct,0) - getRoundDec("1",originProfTAmtOct,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_NOV") = getRoundDec("1",orgNormSAmtNov,0) - getRoundDec("1",originNormSAmtNov,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_NOV")  = getRoundDec("1",orgEvtSAmtNov,0) - getRoundDec("1",originEvtSAmtNov,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_NOV") = getRoundDec("1",orgSaleTAmtNov,0) - getRoundDec("1",originSaleTAmtNov,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_NOV") = getRoundDec("1",orgProfTAmtNov,0) - getRoundDec("1",originProfTAmtNov,0);

    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_NORM_SAMT_DEC") = getRoundDec("1",orgNormSAmtDec,0) - getRoundDec("1",originNormSAmtDec,0)  ;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_EVT_SAMT_DEC")  = getRoundDec("1",orgEvtSAmtDec,0) - getRoundDec("1",originEvtSAmtDec,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_TAMT_DEC") = getRoundDec("1",orgSaleTAmtDec,0) - getRoundDec("1",originSaleTAmtDec,0);
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_TAMT_DEC") = getRoundDec("1",orgProfTAmtDec,0) - getRoundDec("1",originProfTAmtDec,0);
   
	DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_TOT")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_TOT")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_JAN")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_JAN")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_FEB")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_FEB")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_MAR")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_MAR")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_APR")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_APR")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_MAY")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_MAY")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_JUN")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_JUN")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_JUL")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_JUL")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_AUG")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_AUG")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_SEP")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_SEP")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_OCT")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_OCT")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_NOV")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_NOV")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_SALE_CRATE_DEC")= 0.00;
    DS_IO_DETAIL.NameValue(gabRow,"ORIGIN_PROF_CRATE_DEC")= 0.00;
   
}

/**
* comparecheck()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  당초년매출계획과 당초월매출계획 합계 비교
* return값 : 
*/
function comparecheck(){

    //당초
    var originNormSAmtTot  = 0;  //정상매출합계
    var originEvtSAmtTot   = 0;  //행사매출합계
    var originSaleTAmtTot  = 0;  //총매출합계
    var originProfTAmtTot  = 0;  //이익합계
    var originSaleCRateTot = 0;  //매출구성비합계
    var originProfCRateTot = 0;  //이익구성비합계
    
    var originNormSAmtJan  = 0;  //정상매출합계
    var originEvtSAmtJan   = 0;  //행사매출합계
    var originSaleTAmtJan  = 0;  //총매출합계
    var originProfTAmtJan  = 0;  //이익합계
    var originSaleCRateJan = 0;  //매출구성비합계
    var originProfCRateJan = 0;  //이익구성비합계

    var originNormSAmtFeb  = 0;  //정상매출합계
    var originEvtSAmtFeb   = 0;  //행사매출합계
    var originSaleTAmtFeb  = 0;  //총매출합계
    var originProfTAmtFeb  = 0;  //이익합계
    var originSaleCRateFeb = 0;  //매출구성비합계
    var originProfCRateFeb = 0;  //이익구성비합계

    var originNormSAmtMar  = 0;  //정상매출합계
    var originEvtSAmtMar   = 0;  //행사매출합계
    var originSaleTAmtMar  = 0;  //총매출합계
    var originProfTAmtMar  = 0;  //이익합계
    var originSaleCRateMar = 0;  //매출구성비합계
    var originProfCRateMar = 0;  //이익구성비합계

    var originNormSAmtApr  = 0;  //정상매출합계
    var originEvtSAmtApr   = 0;  //행사매출합계
    var originSaleTAmtApr  = 0;  //총매출합계
    var originProfTAmtApr  = 0;  //이익합계
    var originSaleCRateApr = 0;  //매출구성비합계
    var originProfCRateApr = 0;  //이익구성비합계

    var originNormSAmtMay  = 0;  //정상매출합계
    var originEvtSAmtMay   = 0;  //행사매출합계
    var originSaleTAmtMay  = 0;  //총매출합계
    var originProfTAmtMay  = 0;  //이익합계
    var originSaleCRateMay = 0;  //매출구성비합계
    var originProfCRateMay = 0;  //이익구성비합계

    var originNormSAmtJun  = 0;  //정상매출합계
    var originEvtSAmtJun   = 0;  //행사매출합계
    var originSaleTAmtJun  = 0;  //총매출합계
    var originProfTAmtJun  = 0;  //이익합계
    var originSaleCRateJun = 0;  //매출구성비합계
    var originProfCRateJun = 0;  //이익구성비합계

    var originNormSAmtJul  = 0;  //정상매출합계
    var originEvtSAmtJul   = 0;  //행사매출합계
    var originSaleTAmtJul  = 0;  //총매출합계
    var originProfTAmtJul  = 0;  //이익합계
    var originSaleCRateJul = 0;  //매출구성비합계
    var originProfCRateJul = 0;  //이익구성비합계

    var originNormSAmtAug  = 0;  //정상매출합계
    var originEvtSAmtAug   = 0;  //행사매출합계
    var originSaleTAmtAug  = 0;  //총매출합계
    var originProfTAmtAug  = 0;  //이익합계
    var originSaleCRateAug = 0;  //매출구성비합계
    var originProfCRateAug = 0;  //이익구성비합계

    var originNormSAmtSep  = 0;  //정상매출합계
    var originEvtSAmtSep   = 0;  //행사매출합계
    var originSaleTAmtSep  = 0;  //총매출합계
    var originProfTAmtSep  = 0;  //이익합계
    var originSaleCRateSep = 0;  //매출구성비합계
    var originProfCRateSep = 0;  //이익구성비합계

    var originNormSAmtOct  = 0;  //정상매출합계
    var originEvtSAmtOct   = 0;  //행사매출합계
    var originSaleTAmtOct  = 0;  //총매출합계
    var originProfTAmtOct  = 0;  //이익합계
    var originSaleCRateOct = 0;  //매출구성비합계
    var originProfCRateOct = 0;  //이익구성비합계

    var originNormSAmtNov  = 0;  //정상매출합계
    var originEvtSAmtNov   = 0;  //행사매출합계
    var originSaleTAmtNov  = 0;  //총매출합계
    var originProfTAmtNov  = 0;  //이익합계
    var originSaleCRateNov = 0;  //매출구성비합계
    var originProfCRateNov = 0;  //이익구성비합계

    var originNormSAmtDec  = 0;  //정상매출합계
    var originEvtSAmtDec   = 0;  //행사매출합계
    var originSaleTAmtDec  = 0;  //총매출합계
    var originProfTAmtDec  = 0;  //이익합계
    var originSaleCRateDec = 0;  //매출구성비합계
    var originProfCRateDec = 0;  //이익구성비합계
    //당초
    var orgNormSAmtTot  = 0;  //정상매출합계
    var orgEvtSAmtTot   = 0;  //행사매출합계
    var orgSaleTAmtTot  = 0;  //총매출합계
    var orgProfTAmtTot  = 0;  //이익합계
    var orgSaleCRateTot = 0;  //매출구성비합계
    var orgProfCRateTot = 0;  //이익구성비합계
    
    var orgNormSAmtJan  = 0;  //정상매출합계
    var orgEvtSAmtJan   = 0;  //행사매출합계
    var orgSaleTAmtJan  = 0;  //총매출합계
    var orgProfTAmtJan  = 0;  //이익합계
    var orgSaleCRateJan = 0;  //매출구성비합계
    var orgProfCRateJan = 0;  //이익구성비합계

    var orgNormSAmtFeb  = 0;  //정상매출합계
    var orgEvtSAmtFeb   = 0;  //행사매출합계
    var orgSaleTAmtFeb  = 0;  //총매출합계
    var orgProfTAmtFeb  = 0;  //이익합계
    var orgSaleCRateFeb = 0;  //매출구성비합계
    var orgProfCRateFeb = 0;  //이익구성비합계

    var orgNormSAmtMar  = 0;  //정상매출합계
    var orgEvtSAmtMar   = 0;  //행사매출합계
    var orgSaleTAmtMar  = 0;  //총매출합계
    var orgProfTAmtMar  = 0;  //이익합계
    var orgSaleCRateMar = 0;  //매출구성비합계
    var orgProfCRateMar = 0;  //이익구성비합계

    var orgNormSAmtApr  = 0;  //정상매출합계
    var orgEvtSAmtApr   = 0;  //행사매출합계
    var orgSaleTAmtApr  = 0;  //총매출합계
    var orgProfTAmtApr  = 0;  //이익합계
    var orgSaleCRateApr = 0;  //매출구성비합계
    var orgProfCRateApr = 0;  //이익구성비합계

    var orgNormSAmtMay  = 0;  //정상매출합계
    var orgEvtSAmtMay   = 0;  //행사매출합계
    var orgSaleTAmtMay  = 0;  //총매출합계
    var orgProfTAmtMay  = 0;  //이익합계
    var orgSaleCRateMay = 0;  //매출구성비합계
    var orgProfCRateMay = 0;  //이익구성비합계

    var orgNormSAmtJun  = 0;  //정상매출합계
    var orgEvtSAmtJun   = 0;  //행사매출합계
    var orgSaleTAmtJun  = 0;  //총매출합계
    var orgProfTAmtJun  = 0;  //이익합계
    var orgSaleCRateJun = 0;  //매출구성비합계
    var orgProfCRateJun = 0;  //이익구성비합계

    var orgNormSAmtJul  = 0;  //정상매출합계
    var orgEvtSAmtJul   = 0;  //행사매출합계
    var orgSaleTAmtJul  = 0;  //총매출합계
    var orgProfTAmtJul  = 0;  //이익합계
    var orgSaleCRateJul = 0;  //매출구성비합계
    var orgProfCRateJul = 0;  //이익구성비합계

    var orgNormSAmtAug  = 0;  //정상매출합계
    var orgEvtSAmtAug   = 0;  //행사매출합계
    var orgSaleTAmtAug  = 0;  //총매출합계
    var orgProfTAmtAug  = 0;  //이익합계
    var orgSaleCRateAug = 0;  //매출구성비합계
    var orgProfCRateAug = 0;  //이익구성비합계

    var orgNormSAmtSep  = 0;  //정상매출합계
    var orgEvtSAmtSep   = 0;  //행사매출합계
    var orgSaleTAmtSep  = 0;  //총매출합계
    var orgProfTAmtSep  = 0;  //이익합계
    var orgSaleCRateSep = 0;  //매출구성비합계
    var orgProfCRateSep = 0;  //이익구성비합계

    var orgNormSAmtOct  = 0;  //정상매출합계
    var orgEvtSAmtOct   = 0;  //행사매출합계
    var orgSaleTAmtOct  = 0;  //총매출합계
    var orgProfTAmtOct  = 0;  //이익합계
    var orgSaleCRateOct = 0;  //매출구성비합계
    var orgProfCRateOct = 0;  //이익구성비합계

    var orgNormSAmtNov  = 0;  //정상매출합계
    var orgEvtSAmtNov   = 0;  //행사매출합계
    var orgSaleTAmtNov  = 0;  //총매출합계
    var orgProfTAmtNov  = 0;  //이익합계
    var orgSaleCRateNov = 0;  //매출구성비합계
    var orgProfCRateNov = 0;  //이익구성비합계

    var orgNormSAmtDec  = 0;  //정상매출합계
    var orgEvtSAmtDec   = 0;  //행사매출합계
    var orgSaleTAmtDec  = 0;  //총매출합계
    var orgProfTAmtDec  = 0;  //이익합계
    var orgSaleCRateDec = 0;  //매출구성비합계
    var orgProfCRateDec = 0;  //이익구성비합계

    orgNormSAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_TOT"),0);   //당초파트정상
    orgEvtSAmtTot     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_TOT"),0);    //당초파트행사
    orgProfTAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_TOT"),0);   //당초파트이익
    orgSaleTAmtTot    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_TOT"),0);   //당초파트총매출
    
    
    orgNormSAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JAN"),0);   //당초파트정상
    orgEvtSAmtJan     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JAN"),0);    //당초파트행사
    orgProfTAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JAN"),0);   //당초파트이익
    orgSaleTAmtJan    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JAN"),0);   //당초파트총매출
    
    
    orgNormSAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_FEB"),0);   //당초파트정상
    orgEvtSAmtFeb     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_FEB"),0);    //당초파트행사
    orgProfTAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_FEB"),0);   //당초파트이익
    orgSaleTAmtFeb    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_FEB"),0);   //당초파트총매출
    
    orgNormSAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_MAR"),0);   //당초파트정상
    orgEvtSAmtMar     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_MAR"),0);    //당초파트행사
    orgProfTAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_MAR"),0);   //당초파트이익
    orgSaleTAmtMar    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_MAR"),0);   //당초파트총매출
    
    orgNormSAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_APR"),0);   //당초파트정상
    orgEvtSAmtApr     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_APR"),0);    //당초파트행사
    orgProfTAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_APR"),0);   //당초파트이익
    orgSaleTAmtApr    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_APR"),0);   //당초파트총매출
    
    orgNormSAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_MAY"),0);   //당초파트정상
    orgEvtSAmtMay     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_MAY"),0);    //당초파트행사
    orgProfTAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_MAY"),0);   //당초파트이익
    orgSaleTAmtMay    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_MAY"),0);   //당초파트총매출
    
    orgNormSAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JUN"),0);   //당초파트정상
    orgEvtSAmtJun     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JUN"),0);    //당초파트행사
    orgProfTAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JUN"),0);   //당초파트이익
    orgSaleTAmtJun    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JUN"),0);   //당초파트총매출
    
    orgNormSAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_JUL"),0);   //당초파트정상
    orgEvtSAmtJul     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_JUL"),0);    //당초파트행사
    orgProfTAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_JUL"),0);   //당초파트이익
    orgSaleTAmtJul    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_JUL"),0);   //당초파트총매출
    
    orgNormSAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_AUG"),0);   //당초파트정상
    orgEvtSAmtAug     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_AUG"),0);    //당초파트행사
    orgProfTAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_AUG"),0);   //당초파트이익
    orgSaleTAmtAug    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_AUG"),0);   //당초파트총매출
    
    orgNormSAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_SEP"),0);   //당초파트정상
    orgEvtSAmtSep     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_SEP"),0);    //당초파트행사
    orgProfTAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_SEP"),0);   //당초파트이익
    orgSaleTAmtSep    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_SEP"),0);   //당초파트총매출
    
    orgNormSAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_OCT"),0);   //당초파트정상
    orgEvtSAmtOct     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_OCT"),0);    //당초파트행사
    orgProfTAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_OCT"),0);   //당초파트이익
    orgSaleTAmtOct    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_OCT"),0);   //당초파트총매출
    
    orgNormSAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_NOV"),0);   //당초파트정상
    orgEvtSAmtNov     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_NOV"),0);    //당초파트행사
    orgProfTAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_NOV"),0);   //당초파트이익
    orgSaleTAmtNov    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_NOV"),0);   //당초파트총매출
    
    orgNormSAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT_DEC"),0);   //당초파트정상
    orgEvtSAmtDec     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT_DEC"),0);    //당초파트행사
    orgProfTAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT_DEC"),0);   //당초파트이익
    orgSaleTAmtDec    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT_DEC"),0);   //당초파트총매출
        
    
    for(i=1; i <= DS_IO_DETAIL.CountRow; i++){
        if(DS_IO_DETAIL.NameValue(i,"ORG_NAME") == ""){
          originNormSAmtTot     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_TOT"),0);
          originEvtSAmtTot      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_TOT"),0);
          originSaleTAmtTot     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
          originProfTAmtTot     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
          originSaleCRateTot    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT"),2);
          originProfCRateTot    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT"),2);
          
          originNormSAmtJan     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN"),0);
          originEvtSAmtJan      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN"),0);
          originSaleTAmtJan     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN"),0);
          originProfTAmtJan     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN"),0);
          originSaleCRateJan    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN"),2);
          originProfCRateJan    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN"),2);
          
          originNormSAmtFeb     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_FEB"),0);
          originEvtSAmtFeb      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_FEB"),0);
          originSaleTAmtFeb     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_FEB"),0);
          originProfTAmtFeb     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_FEB"),0);
          originSaleCRateFeb    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_FEB"),2);
          originProfCRateFeb    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_FEB"),2);
          
          originNormSAmtMar     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAR"),0);
          originEvtSAmtMar      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAR"),0);
          originSaleTAmtMar     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAR"),0);
          originProfTAmtMar     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAR"),0);
          originSaleCRateMar    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAR"),2);
          originProfCRateMar    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAR"),2);
  
          originNormSAmtApr     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_APR"),0);
          originEvtSAmtApr      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_APR"),0);
          originSaleTAmtApr     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_APR"),0);
          originProfTAmtApr     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_APR"),0);
          originSaleCRateApr    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_APR"),2);
          originProfCRateApr    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_APR"),2);
  
          originNormSAmtMay     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_MAY"),0);
          originEvtSAmtMay      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_MAY"),0);
          originSaleTAmtMay     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_MAY"),0);
          originProfTAmtMay     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_MAY"),0);
          originSaleCRateMay    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_MAY"),2);
          originProfCRateMay    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_MAY"),2);
  
          originNormSAmtJun     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUN"),0);
          originEvtSAmtJun      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUN"),0);
          originSaleTAmtJun     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUN"),0);
          originProfTAmtJun     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUN"),0);
          originSaleCRateJun    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUN"),2);
          originProfCRateJun    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUN"),2);
  
          originNormSAmtJul     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JUL"),0);
          originEvtSAmtJul      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JUL"),0);
          originSaleTAmtJul     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JUL"),0);
          originProfTAmtJul     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JUL"),0);
          originSaleCRateJul    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JUL"),2);
          originProfCRateJul    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JUL"),2);
  
          originNormSAmtAug     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_AUG"),0);
          originEvtSAmtAug      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_AUG"),0);
          originSaleTAmtAug     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_AUG"),0);
          originProfTAmtAug     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_AUG"),0);
          originSaleCRateAug    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_AUG"),2);
          originProfCRateAug    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_AUG"),2);
  
          originNormSAmtSep     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_SEP"),0);
          originEvtSAmtSep      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_SEP"),0);
          originSaleTAmtSep     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_SEP"),0);
          originProfTAmtSep     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_SEP"),0);
          originSaleCRateSep    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_SEP"),2);
          originProfCRateSep    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_SEP"),2);
  
          originNormSAmtOct     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_OCT"),0);
          originEvtSAmtOct      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_OCT"),0);
          originSaleTAmtOct     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_OCT"),0);
          originProfTAmtOct     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_OCT"),0);
          originSaleCRateOct    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_OCT"),2);
          originProfCRateOct    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_OCT"),2);
  
          originNormSAmtNov     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_NOV"),0);
          originEvtSAmtNov      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_NOV"),0);
          originSaleTAmtNov     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_NOV"),0);
          originProfTAmtNov     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_NOV"),0);
          originSaleCRateNov    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_NOV"),2);
          originProfCRateNov    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_NOV"),2);
  
          originNormSAmtDec     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_DEC"),0);
          originEvtSAmtDec      = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_DEC"),0);
          originSaleTAmtDec     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_DEC"),0);
          originProfTAmtDec     = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_DEC"),0);
          originSaleCRateDec    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_DEC"),2);
          originProfCRateDec    = getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_DEC"),2);
            
        }
    }
    
    //1월
    if(getRoundDec("1",orgNormSAmtJan,0) != getRoundDec("1",originNormSAmtJan,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 1월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtJan,0) != getRoundDec("1",originEvtSAmtJan,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 1월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtJan,0) != getRoundDec("1",originProfTAmtJan,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 1월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //2월
    if(getRoundDec("1",orgNormSAmtFeb,0) != getRoundDec("1",originNormSAmtFeb,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 2월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtFeb,0) != getRoundDec("1",originEvtSAmtFeb,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 2월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtFeb,0) != getRoundDec("1",originProfTAmtFeb,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 2월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //3월
    if(getRoundDec("1",orgNormSAmtMar,0) != getRoundDec("1",originNormSAmtMar,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 3월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtMar,0) != getRoundDec("1",originEvtSAmtMar,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 3월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtMar,0) != getRoundDec("1",originProfTAmtMar,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 3월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //4월
    if(getRoundDec("1",orgNormSAmtApr,0) != getRoundDec("1",originNormSAmtApr,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 4월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtApr,0) != getRoundDec("1",originEvtSAmtApr,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 4월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtApr,0) != getRoundDec("1",originProfTAmtApr,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 4월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //5월
    if(getRoundDec("1",orgNormSAmtMay,0) != getRoundDec("1",originNormSAmtMay,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 5월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtMay,0) != getRoundDec("1",originEvtSAmtMay,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 5월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtMay,0) != getRoundDec("1",originProfTAmtMay,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 5월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //6월
    if(getRoundDec("1",orgNormSAmtJun,0) != getRoundDec("1",originNormSAmtJun,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 6월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtJun,0) != getRoundDec("1",originEvtSAmtJun,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 6월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtJun,0) != getRoundDec("1",originProfTAmtJun,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 6월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //7월
    if(getRoundDec("1",orgNormSAmtJul,0) != getRoundDec("1",originNormSAmtJul,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 7월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtJul,0) != getRoundDec("1",originEvtSAmtJul,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 7월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtJul,0) != getRoundDec("1",originProfTAmtJul,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 7월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //8월
    if(getRoundDec("1",orgNormSAmtAug,0) != getRoundDec("1",originNormSAmtAug,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 8월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtAug,0) != getRoundDec("1",originEvtSAmtAug,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 8월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtAug,0) != getRoundDec("1",originProfTAmtAug,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 8월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //9월
    if(getRoundDec("1",orgNormSAmtSep,0) != getRoundDec("1",originNormSAmtSep,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 9월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtSep,0) != getRoundDec("1",originEvtSAmtSep,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 9월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtSep,0) != getRoundDec("1",originProfTAmtSep,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 9월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //10월
    if(getRoundDec("1",orgNormSAmtOct,0) != getRoundDec("1",originNormSAmtOct,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 10월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtOct,0) != getRoundDec("1",originEvtSAmtOct,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 10월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtOct,0) != getRoundDec("1",originProfTAmtOct,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 10월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //11월
    if(getRoundDec("1",orgNormSAmtNov,0) != getRoundDec("1",originNormSAmtNov,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 11월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtNov,0) != getRoundDec("1",originEvtSAmtNov,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 11월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtNov,0) != getRoundDec("1",originProfTAmtNov,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 11월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    //12월
    if(getRoundDec("1",orgNormSAmtDec,0) != getRoundDec("1",originNormSAmtDec,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 12월 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmtDec,0) != getRoundDec("1",originEvtSAmtDec,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 12월 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmtDec,0) != getRoundDec("1",originProfTAmtDec,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표 12월 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    
    return true;
}

/**
* checkChange()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-17
* 개    요 :  마스터의 팀, 파트 코드로 디테일 내역의 팀, 파트 변경
* return값 : 
*/
function checkChange(){
    
    var strStrCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");           //팀
    var strDeptCd      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TEAM_CD");          //파트
        
    for(i=1; i<= DS_IO_DETAIL.CountRow;i++){
        DS_IO_DETAIL.NameValue(i, "STR_CD")   = strStrCd;
        DS_IO_DETAIL.NameValue(i, "DEPT_CD")  = strDeptCd;
        DS_IO_DETAIL.NameValue(i, "TEAM_CD")  = strTeamCd;
    }
   
    
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->

<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid GD_MASTER OnClick event 처리 -->

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
//if(row == 0){return;}
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

if(row > 0 && old_Row != row ){
        //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_DETAIL.IsUpdated ){
        ret = showMessage(QUESTION, YESNO, "USER-1074");
        if (ret != "1") {
            DS_O_MASTER.RowPosition = old_Row;
            return false;
        } 
    }
    searchDetail();
}
old_Row = row;
return;
</script>

<script language="javascript">
    var lOption = 0;
    var szTitle, szTitle2, szTitle3;
    var szName = "Sheet Name";
    var szPath = "C:\\Test\\Test";
    var today    = new Date();
    var chk_grid1 = 0;
    var errchk_flag = 0;
    var errcnt = 0;
    var errorRow = "";
    var errorRowS = "";
    var old_Row = 0;
     
</script>
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트   
    LC_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=DS_O_MASTER
   event=onColumnChanged(Row,Colid)>
old_Row = Row
</script>

<script language=Javascript for=GD_DETAIL
   event=OnExit(row,colid,olddata)>
	
    switch (colid) {
    case "ORIGIN_NORM_SAMT_JAN" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_JAN") ){
         
        	changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_JAN" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_JAN") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_JAN" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_JAN") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_FEB" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_FEB") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_FEB" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_FEB") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_FEB" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_FEB") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_MAR" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_MAR") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_MAR" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_MAR") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_MAR" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_MAR") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_APR" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_APR") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_APR" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_APR") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_APR" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_APR") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_MAY" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_MAY") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_MAY" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_MAY") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_MAY" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_MAY") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_JUN" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_JUN") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_JUN" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_JUN") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_JUN" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_JUN") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_JUL" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_JUL") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_JUL" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_JUL") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_JUL" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_JUL") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_AUG" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_AUG") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_AUG" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_AUG") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_AUG" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_AUG") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_SEP" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_SEP") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_SEP" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_SEP") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_SEP" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_SEP") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_OCT" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_OCT") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_OCT" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_OCT") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_OCT" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_OCT") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_NOV" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_NOV") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_NOV" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_NOV") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_NOV" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_NOV") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    case "ORIGIN_NORM_SAMT_DEC" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT_DEC") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_EVT_SAMT_DEC" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT_DEC") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
    case "ORIGIN_PROF_TAMT_DEC" :
        if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT_DEC") ){
            changecolumn();
            change_ln_sum();
            change_irate(colid);
        }
        break;
        
    default:
        break;
    
    }
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>

  
    
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
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_IO_BFYY" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL_ORG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKORGMST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MCHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
   <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)-top) <= top) {
    	grd_height = top+300;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

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
      <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0"
         class="o_table">
         <tr>
            <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0"
               class="s_table">
               <tr>
                  <th width="80" class="point">점</th>
                  <td width="110"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80" class="point">팀</th>
                  <td width="110"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80">파트</th>
                  <td width="110"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80" class="point">목표년도</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_PLAN_YEAR classid=<%=Util.CLSID_EMEDIT%> width=80
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  </td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

   <tr>
      <td class="dot"></td>
   </tr>


   <tr valign="top">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=186 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_O_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

   <tr>
      <td class="right PB03 PT03">
      <table width="160" border="0" cellpadding="0" cellspacing="0">
         <tr>
            <th><img src="/<%=dir%>/imgs/btn/excel_s.gif"
               onclick="loadExcelData();" align="absmiddle" /></th>
            <th><img src="/<%=dir%>/imgs/btn/excel_down.gif"
               onclick="ExcelDownData();" align="absmiddle" /></th>
         </tr>
      </table>
      </td>
   </tr>
   <tr valign="top">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                 <div style="display:none;">  
                 <comment id="_NSID_"> <object
                     id=GD_DETAIL_ORG width=100% height=130 classid=<%=Util.CLSID_GRID%>> 
                     <param name="DataID" value="DS_IO_DETAIL_ORG">
                  </object> </comment><script>_ws_(_NSID_);</script>
                  </div>
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL width=100% height=293 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_IO_DETAIL">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>


</table>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</div>
</body>
</html>
