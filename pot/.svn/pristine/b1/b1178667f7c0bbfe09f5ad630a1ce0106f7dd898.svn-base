<!-- 
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 권한관리
 * 작 성 일 : 2010.06.08
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom1045.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 조직권한(TAB) -> 권한부여 팝업
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8");  %>
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
<script language="javascript" src="/<%=dir%>/js/common.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"       type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"      type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"     type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"       type="text/javascript"></script> 

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************--> 
<script LANGUAGE="JavaScript">  
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/ 
var strUserCd    = window.dialogArguments[0];
var opener       = window.dialogArguments[1]; 
var bfRowPositionG1 = 0; 
var bfRowPositionG2 = 0; 
var bfRowPositionG3 = 0; 
var bfRowPositionG4 = 0;  

/**
 * do_Init()
 * 작 성 자 : ckj
 * 작 성 일 : 2006-08-12
 * 개    요 : 화면이 처음 로딩될때 호출되는 영역 입니다. 가우스 콤포넌트 초기화 포함
 * return값 : void
*/
function do_Init(){

    // Output Data Set Header 초기화
    DS_O_STR_CD.setDataHeader   ('<gauce:dataset name="H_STR_CD"/>');
    DS_O_DEPT_CD.setDataHeader  ('<gauce:dataset name="H_DEPT_CD"/>'); 
    DS_O_TEAM_CD.setDataHeader  ('<gauce:dataset name="H_TEAM_CD"/>'); 
    DS_O_PC_CD.setDataHeader    ('<gauce:dataset name="H_PC_CD"/>'); 
    DS_O_PUMBUN_CD.setDataHeader('<gauce:dataset name="H_PUMBUN_CD"/>'); 
    
    //그리드 초기화
    gridCreate(); 

    //조직구분(조회)
    initComboStyle(LC_O_LEVEL,   DS_O_LEVEL,  "CODE^0^20,NAME^0^90", 1, NORMAL); 
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_LEVEL", "D", "TC02", "N");
    //콤보데이터 기본값 설정( gauce.js ) 
    LC_O_LEVEL.index = 1;
    
    //조직구분(조회)
    initComboStyle(LC_O_ORG_FLAG,   DS_O_ORG_FLAG,  "CODE^0^20,NAME^0^90", 1, NORMAL); 
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_ORG_FLAG", "D", "P047", "N");
    //콤보데이터 기본값 설정( gauce.js ) 
    LC_O_ORG_FLAG.index = 0;
    
    // 점정보조회
    selectStrCd();   
  }  
    
/**
 * gridCreate()
 * 작 성 자 : 
 * 작 성 일 : 2010-06-08
 * 개    요 : Grid를 초기화한다.
 * return값 : str
 */
function gridCreate(){
    
    var hdrProperies1 = '<FC>id=STR_CD       show=false   name="점코드"    </FC>' 
                      + '<FC>id=CHK          width=30     name="선택"      editstyle=checkbox    </FC>'
                      + '<FC>id=STR_NAME     width=103    name="점"        edit=none            </FC>' ;
    initGridStyle(GD_STORE, "common", hdrProperies1, true );   
            
    var hdrProperies2 = '<FC>id=STR_CD        show=false   name="점코드"      </FC>'
                      + '<FC>id=DEPT_CD       show=false   name="팀코드"    </FC>'
                      + '<FC>id=CHK           width=30     name="선택"      editstyle=checkbox    </FC>'
                      + '<FC>id=DEPT_NAME     width=120    name="팀"        edit=none           </FC>' ;
    initGridStyle(GD_DEPT, "common", hdrProperies2, true );
    
    var hdrProperies3 = '<FC>id=STR_CD        show=false   name="점코드"      </FC>'
                      + '<FC>id=DEPT_CD       show=false   name="팀코드"    </FC>'
                      + '<FC>id=TEAM_CD       show=false   name="파트코드"      </FC>'
                      + '<FC>id=CHK           width=30     name="선택"      editstyle=checkbox    </FC>'
                      + '<FC>id=TEAM_NAME     width=130    name="파트"          edit=none           </FC>' ;
    initGridStyle(GD_TEAM, "common", hdrProperies3, true );  

    var hdrProperies4 = '<FC>id=STR_CD        show=false   name="점코드"      </FC>'
                      + '<FC>id=DEPT_CD       show=false   name="팀코드"    </FC>'
                      + '<FC>id=TEAM_CD       show=false   name="파트코드"      </FC>'
                      + '<FC>id=PC_CD         show=false   name="PC코드"      </FC>' 
                      + '<FC>id=CHK           width=30     name="선택"        editstyle=checkbox    </FC>'
                      + '<FC>id=PC_NAME       width=140    name="PC"          edit=none           </FC>' ;
    initGridStyle(GD_PC, "common", hdrProperies4, true );
    

    var hdrProperies5 = '<FC>id=STR_CD        show=false   name="점코드"      </FC>'
                      + '<FC>id=DEPT_CD       show=false   name="팀코드"    </FC>'
                      + '<FC>id=TEAM_CD       show=false   name="파트코드"      </FC>'
                      + '<FC>id=PC_CD         show=false   name="PC코드"      </FC>' 
                      + '<FC>id=PUMBUN_CD     show=false   name="품번"        </FC>' 
                      + '<FC>id=CHK           width=30     name="선택"        editstyle=checkbox    </FC>'
                      + '<FC>id=PUMBUN_NAME   width=140    name="품번"        edit=none           </FC>' ;
    initGridStyle(GD_PUMBUN, "common", hdrProperies5, true );
}

/**
 * selectStrCd()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-05-30
 * 개    요 : 점리스트 셋팅
 * return값 : void
 */
function selectStrCd()
{
    var action = "O"; 
    var goTo   = "selectStrCd";    
       
    TR_TAB3_1.Action="/pot/tcom104.tc?goTo="+goTo;   
    TR_TAB3_1.KeyValue="SERVLET("+action+":DS_O_STR_CD=DS_O_STR_CD)"; //조회는 O 
    TR_TAB3_1.Post();    
}

 /**
  * selectDeptCd()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-05-30
  * 개    요 : 팀리스트 셋팅
  * return값 : void
  */
function selectDeptCd(strCd) {
     
     DS_O_TEAM_CD.ClearData();
     DS_O_PC_CD.ClearData(); 
     DS_O_PUMBUN_CD.ClearData(); 
     
     var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;                        
        
     var goTo       = "selectDeptCd" ;    
     var action     = "O";       
     var parameters = "&strStrCd="+encodeURIComponent(strCd)
                    + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag) ;
     
     TR_TAB3_2.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
     TR_TAB3_2.KeyValue="SERVLET("+action+":DS_O_DEPT_CD=DS_O_DEPT_CD)"; //조회는 O
     TR_TAB3_2.Post();
     
}  

/**
 * selectTeamCd()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-05-30
 * 개    요 : 파트리스트 셋팅
 * return값 : void
 */
function selectTeamCd(strStrCd, strDeptCd) {
	 
     DS_O_PC_CD.ClearData(); 
     DS_O_PUMBUN_CD.ClearData(); 
   
    var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;                       
       
    var goTo       = "selectTeamCd" ;    
    var action     = "O";       
    var parameters = "&strStrCd ="+encodeURIComponent(strStrCd)
                   + "&strDeptCd="+encodeURIComponent(strDeptCd)
                   + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag) ;
     
    TR_TAB3_3.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
    TR_TAB3_3.KeyValue="SERVLET("+action+":DS_O_TEAM_CD=DS_O_TEAM_CD)"; //조회는 O
    TR_TAB3_3.Post();
    
} 
/**
 * selectPcCd()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-05-30
 * 개    요 : PC리스트 셋팅
 * return값 : void
 */
function selectPcCd(strStrCd, strDeptCd, strTeamCd) {

     DS_O_PUMBUN_CD.ClearData(); 
     
    var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;                        
       
    var goTo       = "selectPcCd" ;    
    var action     = "O";       
    var parameters = "&strStrCd ="  +encodeURIComponent(strStrCd)
                   + "&strDeptCd="  +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="  +encodeURIComponent(strTeamCd) 
                   + "&strOrgFlag=" +encodeURIComponent(strBindOrgFlag) ;
     
    TR_TAB3_4.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
    TR_TAB3_4.KeyValue="SERVLET("+action+":DS_O_PC_CD=DS_O_PC_CD)"; //조회는 O
    TR_TAB3_4.Post();
    
} 

/**
 * selectPumbunCd()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-05-30
 * 개    요 : 품번리스트 셋팅
 * return값 : void
 */
function selectPumbunCd(strOrgCd) {
 
    var strBindOrgFlag  = LC_O_ORG_FLAG.BindColVal;                        
       
    var goTo       = "selectPumbunCd" ;    
    var action     = "O";       
    var parameters =  "&strOrgCd="  +encodeURIComponent(strOrgCd)
                    + "&strOrgFlag="+encodeURIComponent(strBindOrgFlag) ;
     
    TR_TAB3_5.Action="/pot/tcom104.tc?goTo="+goTo+parameters;  
    TR_TAB3_5.KeyValue="SERVLET("+action+":DS_O_PUMBUN_CD=DS_O_PUMBUN_CD)"; //조회는 O
    TR_TAB3_5.Post();
    
} 

function btn_Close(){
    this.close();
}   

/**
 * btn_InsertRow()
 * 작 성 자 : 
 * 작 성 일 : 2010-09-08
 * 개    요 : opener dataset에 추가
 * return값 : void
*/
function btn_InsertRow(){ 
 
    var objDs = opener.DS_IO_JJAUTH;  
    var row   = 0; 
    var cntDept = 0; 
 
    var strAuthLevel  = LC_O_LEVEL.BindColVal;       // 권한레벨
    var strOrgFlag    = LC_O_ORG_FLAG.BindColVal;    // 조직구분      
  
    var cntRow = 0;
    var cntDupRow = 0;
    
    opener.GD_JJAUTH_J.ReDraw  = false;
    
    // S레벨
    if(strAuthLevel == "S")
    {
        if( objDs.NameValueRow("AUTH_LEVEL", strAuthLevel) == 0  ) 
        {   
            objDs.AddRow();
            objDs.NameValue(objDs.CountRow, "USER_ID")      = strUserCd; 
            objDs.NameValue(objDs.CountRow, "ORG_FLAG")     = "1"; 
            objDs.NameValue(objDs.CountRow, "ORG_LEVEL")    = "0"; 
            objDs.NameValue(objDs.CountRow, "AUTH_LEVEL")   = strAuthLevel;  
            cntRow = 1;
        } 
    }

    // A레벨
    if(strAuthLevel == "A")
    {
        for(var i=1; i<=DS_O_STR_CD.CountRow; i++)
        {
            if(DS_O_STR_CD.NameValue(i,"CHK") == "T")
            {
               if( objDs.NameValueRow("ADD_GBN"
            		   , strOrgFlag + DS_O_STR_CD.NameValue(i, "AUTH_LEVEL") + DS_O_STR_CD.NameValue(i, "ORG_CD") ) == 0  ) 
               {
                    objDs.AddRow();
                    objDs.NameValue(objDs.CountRow, "USER_ID")      = strUserCd; 
                    objDs.NameValue(objDs.CountRow, "ORG_FLAG")     = strOrgFlag; 
                    objDs.NameValue(objDs.CountRow, "ORG_CD")       = DS_O_STR_CD.NameValue(i,"STR_CD") + '00000000';
                    objDs.NameValue(objDs.CountRow, "ORG_LEVEL")    = DS_O_STR_CD.NameValue(i,"ORG_LEVEL"); 
                    objDs.NameValue(objDs.CountRow, "AUTH_LEVEL")   = strAuthLevel;  
                    objDs.NameValue(objDs.CountRow, "STR_CD")       = DS_O_STR_CD.NameValue(i,"STR_CD"); 
                    objDs.NameValue(objDs.CountRow, "STR_NAME")     = DS_O_STR_CD.NameValue(i,"STR_NAME");  
                    objDs.NameValue(objDs.CountRow, "ADD_GBN")      = strOrgFlag +DS_O_STR_CD.NameValue(i, "AUTH_LEVEL") + DS_O_STR_CD.NameValue(i, "ORG_CD");   
                    
                    cntRow += 1;
               }
               else cntDupRow += 1;

               DS_O_STR_CD.NameValue(i,"CHK") = "F";
            }
        }
    } 

    // B레벨
    if(strAuthLevel == "B")
    {
        for(var i=1; i<=DS_O_DEPT_CD.CountRow; i++)
        {
            if(DS_O_DEPT_CD.NameValue(i,"CHK") == "T")
            {

                if( objDs.NameValueRow("ADD_GBN"
                		, strOrgFlag + DS_O_DEPT_CD.NameValue(i,"AUTH_LEVEL") + DS_O_DEPT_CD.NameValue(i,"ORG_CD") ) == 0  )  
                {
                    objDs.AddRow();
                    objDs.NameValue(objDs.CountRow, "USER_ID")      = strUserCd; 
                    objDs.NameValue(objDs.CountRow, "ORG_FLAG")     = strOrgFlag; 
                    objDs.NameValue(objDs.CountRow, "ORG_CD")       = DS_O_DEPT_CD.NameValue(i,"ORG_CD") ;
                    objDs.NameValue(objDs.CountRow, "ORG_LEVEL")    = DS_O_DEPT_CD.NameValue(i,"ORG_LEVEL"); 
                    objDs.NameValue(objDs.CountRow, "AUTH_LEVEL")   = strAuthLevel;  
                    objDs.NameValue(objDs.CountRow, "STR_CD")       = DS_O_DEPT_CD.NameValue(i,"STR_CD"); 
                    objDs.NameValue(objDs.CountRow, "STR_NAME")     = DS_O_DEPT_CD.NameValue(i,"STR_NAME");  
                    objDs.NameValue(objDs.CountRow, "DEPT_CD")      = DS_O_DEPT_CD.NameValue(i,"DEPT_CD"); 
                    objDs.NameValue(objDs.CountRow, "DEPT_NAME")    = DS_O_DEPT_CD.NameValue(i,"DEPT_NAME");  
                    objDs.NameValue(objDs.CountRow, "ADD_GBN")      = strOrgFlag +DS_O_DEPT_CD.NameValue(i, "AUTH_LEVEL") + DS_O_DEPT_CD.NameValue(i, "ORG_CD");  
                    
                    cntRow += 1;
                }
                else cntDupRow += 1;

                DS_O_DEPT_CD.NameValue(i,"CHK") = "F";
            }
        }
    } 

    // C레벨
    if(strAuthLevel == "C")
    {
        for(var i=1; i<=DS_O_TEAM_CD.CountRow; i++)
        {
            if(DS_O_TEAM_CD.NameValue(i,"CHK") == "T")
            {

                if( objDs.NameValueRow("ADD_GBN"
                        , strOrgFlag + DS_O_TEAM_CD.NameValue(i,"AUTH_LEVEL") + DS_O_TEAM_CD.NameValue(i,"ORG_CD") ) == 0  )   
                {
                    objDs.AddRow();
                    objDs.NameValue(objDs.CountRow, "USER_ID")      = strUserCd; 
                    objDs.NameValue(objDs.CountRow, "ORG_FLAG")     = strOrgFlag; 
                    objDs.NameValue(objDs.CountRow, "ORG_CD")       = DS_O_TEAM_CD.NameValue(i,"ORG_CD") ;
                    objDs.NameValue(objDs.CountRow, "ORG_LEVEL")    = DS_O_TEAM_CD.NameValue(i,"ORG_LEVEL"); 
                    objDs.NameValue(objDs.CountRow, "AUTH_LEVEL")   = strAuthLevel;  
                    objDs.NameValue(objDs.CountRow, "STR_CD")       = DS_O_TEAM_CD.NameValue(i,"STR_CD"); 
                    objDs.NameValue(objDs.CountRow, "STR_NAME")     = DS_O_TEAM_CD.NameValue(i,"STR_NAME");  
                    objDs.NameValue(objDs.CountRow, "DEPT_CD")      = DS_O_TEAM_CD.NameValue(i,"DEPT_CD"); 
                    objDs.NameValue(objDs.CountRow, "DEPT_NAME")    = DS_O_TEAM_CD.NameValue(i,"DEPT_NAME");  
                    objDs.NameValue(objDs.CountRow, "TEAM_CD")      = DS_O_TEAM_CD.NameValue(i,"TEAM_CD"); 
                    objDs.NameValue(objDs.CountRow, "TEAM_NAME")    = DS_O_TEAM_CD.NameValue(i,"TEAM_NAME");  
                    objDs.NameValue(objDs.CountRow, "ADD_GBN")      = strOrgFlag +DS_O_TEAM_CD.NameValue(i, "AUTH_LEVEL") + DS_O_TEAM_CD.NameValue(i, "ORG_CD"); 
                    
                    cntRow += 1;
                }
                else cntDupRow += 1;

                DS_O_TEAM_CD.NameValue(i,"CHK") = "F";
            }
        }
    } 

    // D레벨
    if(strAuthLevel == "D")
    {
        for(var i=1; i<=DS_O_PC_CD.CountRow; i++)
        {
            if(DS_O_PC_CD.NameValue(i,"CHK") == "T")
            {
                if( objDs.NameValueRow("ADD_GBN"
                        , strOrgFlag + DS_O_PC_CD.NameValue(i,"AUTH_LEVEL") + DS_O_PC_CD.NameValue(i,"ORG_CD") ) == 0  )   
                {
                    objDs.AddRow();
                    objDs.NameValue(objDs.CountRow, "USER_ID")      = strUserCd; 
                    objDs.NameValue(objDs.CountRow, "ORG_FLAG")     = strOrgFlag; 
                    objDs.NameValue(objDs.CountRow, "ORG_CD")       = DS_O_PC_CD.NameValue(i,"ORG_CD") ;
                    objDs.NameValue(objDs.CountRow, "ORG_LEVEL")    = DS_O_PC_CD.NameValue(i,"ORG_LEVEL"); 
                    objDs.NameValue(objDs.CountRow, "AUTH_LEVEL")   = strAuthLevel;  
                    objDs.NameValue(objDs.CountRow, "STR_CD")       = DS_O_PC_CD.NameValue(i,"STR_CD"); 
                    objDs.NameValue(objDs.CountRow, "STR_NAME")     = DS_O_PC_CD.NameValue(i,"STR_NAME");  
                    objDs.NameValue(objDs.CountRow, "DEPT_CD")      = DS_O_PC_CD.NameValue(i,"DEPT_CD"); 
                    objDs.NameValue(objDs.CountRow, "DEPT_NAME")    = DS_O_PC_CD.NameValue(i,"DEPT_NAME");  
                    objDs.NameValue(objDs.CountRow, "TEAM_CD")      = DS_O_PC_CD.NameValue(i,"TEAM_CD"); 
                    objDs.NameValue(objDs.CountRow, "TEAM_NAME")    = DS_O_PC_CD.NameValue(i,"TEAM_NAME");  
                    objDs.NameValue(objDs.CountRow, "PC_CD")        = DS_O_PC_CD.NameValue(i,"PC_CD"); 
                    objDs.NameValue(objDs.CountRow, "PC_NAME")      = DS_O_PC_CD.NameValue(i,"PC_NAME");  
                    objDs.NameValue(objDs.CountRow, "ADD_GBN")      = strOrgFlag + DS_O_PC_CD.NameValue(i, "AUTH_LEVEL") + DS_O_PC_CD.NameValue(i, "ORG_CD"); 
                      
                    
                    cntRow += 1;
                }
                else cntDupRow += 1;

                DS_O_PC_CD.NameValue(i,"CHK") = "F";
            }
        }
    }

    // F레벨
    if(strAuthLevel == "F")
    {
        for(var i=1; i<=DS_O_PUMBUN_CD.CountRow; i++)
        {
            if(DS_O_PUMBUN_CD.NameValue(i,"CHK") == "T")
            {
                if( objDs.NameValueRow("ADD_GBN"
                        , strOrgFlag + DS_O_PUMBUN_CD.NameValue(i,"AUTH_LEVEL") + DS_O_PUMBUN_CD.NameValue(i,"ORG_CD") + DS_O_PUMBUN_CD.NameValue(i,"PUMBUN_CD") ) == 0  )   
                {
                    objDs.AddRow();
                    objDs.NameValue(objDs.CountRow, "USER_ID")      = strUserCd; 
                    objDs.NameValue(objDs.CountRow, "ORG_FLAG")     = strOrgFlag; 
                    objDs.NameValue(objDs.CountRow, "ORG_CD")       = DS_O_PUMBUN_CD.NameValue(i,"ORG_CD") ;
                    objDs.NameValue(objDs.CountRow, "ORG_LEVEL")    = DS_O_PUMBUN_CD.NameValue(i,"ORG_LEVEL"); 
                    objDs.NameValue(objDs.CountRow, "AUTH_LEVEL")   = strAuthLevel;  
                    objDs.NameValue(objDs.CountRow, "STR_CD")       = DS_O_PUMBUN_CD.NameValue(i,"STR_CD"); 
                    objDs.NameValue(objDs.CountRow, "STR_NAME")     = DS_O_PUMBUN_CD.NameValue(i,"STR_NAME");  
                    objDs.NameValue(objDs.CountRow, "DEPT_CD")      = DS_O_PUMBUN_CD.NameValue(i,"DEPT_CD"); 
                    objDs.NameValue(objDs.CountRow, "DEPT_NAME")    = DS_O_PUMBUN_CD.NameValue(i,"DEPT_NAME");  
                    objDs.NameValue(objDs.CountRow, "TEAM_CD")      = DS_O_PUMBUN_CD.NameValue(i,"TEAM_CD"); 
                    objDs.NameValue(objDs.CountRow, "TEAM_NAME")    = DS_O_PUMBUN_CD.NameValue(i,"TEAM_NAME");  
                    objDs.NameValue(objDs.CountRow, "PC_CD")        = DS_O_PUMBUN_CD.NameValue(i,"PC_CD"); 
                    objDs.NameValue(objDs.CountRow, "PC_NAME")      = DS_O_PUMBUN_CD.NameValue(i,"PC_NAME");  
                    objDs.NameValue(objDs.CountRow, "PUMBUN_CD")    = DS_O_PUMBUN_CD.NameValue(i,"PUMBUN_CD"); 
                    objDs.NameValue(objDs.CountRow, "PUMBUN_NAME")  = DS_O_PUMBUN_CD.NameValue(i,"PUMBUN_NAME");  
                    objDs.NameValue(objDs.CountRow, "ADD_GBN")      = strOrgFlag + DS_O_PUMBUN_CD.NameValue(i, "AUTH_LEVEL") + DS_O_PUMBUN_CD.NameValue(i, "ORG_CD")+ DS_O_PUMBUN_CD.NameValue(i,"PUMBUN_CD"); 
                    
                    cntRow += 1;
                }
               else cntDupRow += 1;

               DS_O_PUMBUN_CD.NameValue(i,"CHK") = "F";
            }
        }
    } 
    opener.GD_JJAUTH_J.ReDraw  = true;
    
    var msg = "";
    if (cntDupRow > 0) msg = "<br>"+cntDupRow+"건의 중복 데이터가 존재합니다.";
    
    if  (cntRow >0)   
    {
    	if(cntRow == 1) this.close();
    	
        showMessage(EXCLAMATION, OK, "USER-1000", cntRow + " 건 추가하였습니다." + msg);
        this.close();	
    }
    else if(cntRow ==0 && cntDupRow > 0)   
        showMessage(EXCLAMATION, OK, "USER-1000", msg);
    else                  
        showMessage(EXCLAMATION, OK, "USER-1000", "추가할 대상이 없습니다.");
     
}
/**
 * setGridAble()
 * 작 성 자 : 
 * 작 성 일 : 2010-09-08
 * 개    요 : 상위 그리드의 체크박스 해제/ReadOnly
 * arguments[0] : READONLY여부
 * arguments[1] : DATASET 
 * return값 : void
*/
function setGridAble()
{
	for(var i=0; i<arguments[1].length; i++)
	{
		for(var j=1; j<=arguments[1][i].CountRow; j++)
		{ 
			  // 체크 풀기 
			  if(arguments[1][i].NameValue(j,"CHK") == "T") arguments[1][i].NameValue(j,"CHK") = "F"; 
		} 
        // 그리드 ReadOnly
        arguments[1][i].ReadOnly    = arguments[0]; 
	} 
}
function clearGrid()
{
	for(var i=0; i<arguments[0].length; i++)
    {
		arguments[0][i].ClearData();
    }
}

/**
 * diffLevel()
 * 작 성 자 : 
 * 작 성 일 : 2010-09-08
 * 개    요 : 콤보의 레벨과 그리드의 레벨 비교
 * return값 : void
*/
function diffLevel(gridLevel)
{ 
    var lcLevel = LC_O_LEVEL.BindColVal;    // 콤보레벨
    
    var lcInt , gridInt ;
	var arr = new Array(  new Array('S','A','B','C','D','F')  , new Array('1','2','3','4','5','6') );
 
	for(var i=0; i<6; i++)  
	{
		if(arr[0][i] == lcLevel)   lcInt   = arr[1][i];
        if(arr[0][i] == gridLevel) gridInt = arr[1][i];
	}
    
	// 그리드레벨 >= 콤보레벨 -> 조회불가
	if(lcInt <= gridInt) return false ;
	else                 return true;
}
-->
</script>
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
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++)  
    	showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i)); 
</script>
<script language=JavaScript for=TR_TAB3_1 event=onSuccess>
    for(i=0;i<TR_TAB3_1.SrvErrCount('UserMsg');i++)  
    	showMessage(INFORMATION, OK, "USER-1000", TR_TAB3_1.SrvErrMsg('UserMsg',i)); 
</script>
<script language=JavaScript for=TR_TAB3_2 event=onSuccess>
    for(i=0;i<TR_TAB3_2.SrvErrCount('UserMsg');i++)  
    	showMessage(INFORMATION, OK, "USER-1000", TR_TAB3_2.SrvErrMsg('UserMsg',i)); 
</script> 
<script language=JavaScript for=TR_TAB3_3 event=onSuccess>
    for(i=0;i<TR_TAB3_3.SrvErrCount('UserMsg');i++)  
        showMessage(INFORMATION, OK, "USER-1000", TR_TAB3_3.SrvErrMsg('UserMsg',i)); 
</script> 
<script language=JavaScript for=TR_TAB3_4 event=onSuccess>
    for(i=0;i<TR_TAB3_4.SrvErrCount('UserMsg');i++)  
        showMessage(INFORMATION, OK, "USER-1000", TR_TAB3_4.SrvErrMsg('UserMsg',i)); 
</script> 
<script language=JavaScript for=TR_TAB3_5 event=onSuccess>
    for(i=0;i<TR_TAB3_5.SrvErrCount('UserMsg');i++)  
        showMessage(INFORMATION, OK, "USER-1000", TR_TAB3_5.SrvErrMsg('UserMsg',i)); 
</script> 

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_TAB3_1 event=onFail>
    trFailed(TR_TAB3_1.ErrorMsg);
</script>
<script language=JavaScript for=TR_TAB3_2 event=onFail>
    trFailed(TR_TAB3_2.ErrorMsg);
</script>
<script language=JavaScript for=TR_TAB3_3 event=onFail>
    trFailed(TR_TAB3_3.ErrorMsg);
</script>
<script language=JavaScript for=TR_TAB3_4 event=onFail>
    trFailed(TR_TAB3_4.ErrorMsg);
</script>
<script language=JavaScript for=TR_TAB3_5 event=onFail>
    trFailed(TR_TAB3_5.ErrorMsg);
</script>
 
<!--------------------- 5. DataSet 이벤트 처리  -------------------------------> 
<!-- 점 -> 팀-->
<script language=JavaScript for=GD_STORE event=OnClick(row,colid)>
	if( row < 1) 
	    sortColId( eval(this.DataID), row , colid );
	else if (row == bfRowPositionG1)
	{
	    if( DS_O_DEPT_CD.IsUpdated || DS_O_TEAM_CD.IsUpdated || DS_O_PC_CD.IsUpdated || DS_O_PUMBUN_CD.IsUpdated ) return;   
	    bfRowPositionG1 = row;  
	    if( diffLevel("A") ) selectDeptCd(DS_O_STR_CD.NameValue(row,"STR_CD")); 
	}
</script>  

<script language=JavaScript for=DS_O_STR_CD event=OnRowPosChanged(row)>  
    if(row < 1) return; 
 
    if(bfRowPositionG1 == row) return;            
    if( DS_O_DEPT_CD.IsUpdated || DS_O_TEAM_CD.IsUpdated || DS_O_PC_CD.IsUpdated || DS_O_PUMBUN_CD.IsUpdated ) {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
        	this.RowPosition = bfRowPositionG1;
            return;
        }
        this.UndoAll();
    }
    bfRowPositionG1 = row;  
 
    if( diffLevel("A") ) selectDeptCd(this.NameValue(row,"STR_CD")); 
</script> 
 
<!-- 팀 -> TEAM--> 
<script language=JavaScript for=GD_DEPT event=OnClick(row,colid)>

    if( row < 1) 
        sortColId( eval(this.DataID), row , colid );
    else if (row == bfRowPositionG2)
    {
        if( DS_O_TEAM_CD.IsUpdated || DS_O_PC_CD.IsUpdated || DS_O_PUMBUN_CD.IsUpdated ) return; 
        bfRowPositionG2 = row;  
        if(diffLevel("B")) selectTeamCd(DS_O_DEPT_CD.NameValue(row,"STR_CD"), DS_O_DEPT_CD.NameValue(row,"DEPT_CD")); 
    }
</script>  

<script language=JavaScript for=DS_O_DEPT_CD event=OnRowPosChanged(row)>  
    if(row < 1) return; 
  
    if(bfRowPositionG2 == row) return;            
    if( DS_O_TEAM_CD.IsUpdated || DS_O_PC_CD.IsUpdated || DS_O_PUMBUN_CD.IsUpdated ) {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
        	this.RowPosition = bfRowPositionG2;
            return;
        }
        this.UndoAll();
    }
    
    bfRowPositionG2 = row;  
    if(diffLevel("B")) selectTeamCd(this.NameValue(row,"STR_CD"), this.NameValue(row,"DEPT_CD")); 
</script> 

<!-- TEAM -> PC -->
<script language=JavaScript for=GD_TEAM event=OnClick(row,colid)>

    if( row < 1) 
        sortColId( eval(this.DataID), row , colid );
    else if (row == bfRowPositionG3)
    {
        if( DS_O_PC_CD.IsUpdated || DS_O_PUMBUN_CD.IsUpdated ) return;
        bfRowPositionG3 = row;  
        if(diffLevel("C")) selectPcCd(DS_O_TEAM_CD.NameValue(row,"STR_CD"), DS_O_TEAM_CD.NameValue(row,"DEPT_CD"), DS_O_TEAM_CD.NameValue(row,"TEAM_CD"));  
    }
</script>  
<script language=JavaScript for=DS_O_TEAM_CD event=OnRowPosChanged(row)>  
    if(row < 1) return; 
  
    if(bfRowPositionG3 == row) return;            
    if( DS_O_PC_CD.IsUpdated || DS_O_PUMBUN_CD.IsUpdated ) {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            this.RowPosition = bfRowPositionG3;
            return;
        }
        this.UndoAll();
    }
    bfRowPositionG3 = row;  
    if(diffLevel("C")) selectPcCd(this.NameValue(row,"STR_CD"), this.NameValue(row,"DEPT_CD"), this.NameValue(row,"TEAM_CD")); 
    
</script>

<!-- PC-> 품번-->
<script language=JavaScript for=GD_PC event=OnClick(row,colid)>

    if( row < 1) 
        sortColId( eval(this.DataID), row , colid );
    else if (row == bfRowPositionG4)
    {
        if( DS_O_PUMBUN_CD.IsUpdated ) return;
        bfRowPositionG4 = row;  
        if(diffLevel("D")) selectPumbunCd(DS_O_PC_CD.NameValue(row,"ORG_CD")); 
    }
</script>  
<script language=JavaScript for=DS_O_PC_CD event=OnRowPosChanged(row)>  
    if(row < 1) return; 
     
    if(bfRowPositionG4 == row && row != 1) return;            
    if( DS_O_PUMBUN_CD.IsUpdated ) {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            this.RowPosition = bfRowPositionG4;
            return;
        }
        this.UndoAll();
    }
    bfRowPositionG4 = row;  
    if(diffLevel("D")) selectPumbunCd(this.NameValue(row,"ORG_CD"));  
</script>

<!-- 조직구분 선택시 팀이외의 값 클리어 -->
<script language=JavaScript for=LC_O_ORG_FLAG event=OnSelChange>
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    DS_O_PUMBUN_CD.ClearData(); 
    
    var strStrRowPosition = DS_O_STR_CD.Rowposition;
    selectStrCd();
    DS_O_STR_CD.Rowposition = strStrRowPosition;
</script>

<!-- 레벨선택시 그리드 상태설정 -->
<script language=JavaScript for=LC_O_LEVEL event=OnSelChange>
    var val = this.BindColVal;

    if(val =="S")
    {
        setGridAble(true, new Array(DS_O_STR_CD));
        clearGrid(new Array(DS_O_DEPT_CD, DS_O_TEAM_CD, DS_O_PC_CD, DS_O_PUMBUN_CD))
    } 
    else if(val =="A")
    {  
        setGridAble(false, new Array(DS_O_STR_CD));
        clearGrid(new Array(DS_O_DEPT_CD, DS_O_TEAM_CD, DS_O_PC_CD, DS_O_PUMBUN_CD));
    }
    else if(val =="B")
    {  
        setGridAble(false, new Array(DS_O_DEPT_CD));
        setGridAble(true , new Array(DS_O_STR_CD));
        clearGrid(new Array(DS_O_TEAM_CD, DS_O_PC_CD, DS_O_PUMBUN_CD));
    }
    else if(val =="C")
    {  
        setGridAble(false, new Array(DS_O_TEAM_CD));
        setGridAble(true , new Array(DS_O_STR_CD, DS_O_DEPT_CD));
        clearGrid(new Array(DS_O_PC_CD, DS_O_PUMBUN_CD)); 
    } 
    else if(val =="D")
    {   
        setGridAble(false, new Array(DS_O_PC_CD));
        setGridAble(true , new Array(DS_O_STR_CD, DS_O_DEPT_CD, DS_O_TEAM_CD));
        clearGrid(new Array(DS_O_PUMBUN_CD)); 
    } 
    else if(val =="F")  
    {
        setGridAble(false, new Array(DS_O_PUMBUN_CD));
        setGridAble(true , new Array(DS_O_STR_CD, DS_O_DEPT_CD, DS_O_TEAM_CD, DS_O_PC_CD));
    }
</script>

<!---------------------------- 가우스 이벤트 처리 끝     ----------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_LEVEL"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_ORG_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_CD"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM_CD"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC_CD"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PUMBUN_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
 
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_"><object id="TR_MAIN"  classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_TAB3_1" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_TAB3_2" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_TAB3_3" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_TAB3_4" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="TR_TAB3_5" classid=<%=Util.CLSID_TRANSACTION%>><param name="KeyName" value="Toinb_dataid4"></object></comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-----------------------------------------------------------------------------
  화면영역 시작
------------------------------------------------------------------------------>
</head>
<body onload="do_Init()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="pop01"></td>
        <td class="pop02"></td>
        <td class="pop03"></td>
    </tr>
    <tr>
        <td class="pop04"></td>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="" class="title"><img
                            src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13"
                            align="absmiddle" class="popR05 PL03" /> <SPAN id="title1"
                            class="PL03">사용자별 조직권한</SPAN></td>
                        <td>
                        <table border="0" align="right" cellpadding="0" cellspacing="0">
                            <tr>
                                <td><img src="/<%=dir%>/imgs/btn/add.gif"   width="50" height="22"   onClick="btn_InsertRow()"/></td>
                                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
                                
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr><td class="PT01 PB03">
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            	<tr>
            	<td >
	            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	            	<tr><td class="PB03">
	            			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
			                    <tr><td width="170">
			                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">  
			                        <tr>
			                         <th width="50" >등급</th>
			                         <td width="150">
			                            <comment id="_NSID_"> 
			                                <object id=LC_O_LEVEL classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 align="absmiddle"  tabindex=1 > </object> 
			                            </comment><script>_ws_(_NSID_);</script></td>
			                        </tr>  
			                        <tr>
			                         <th width="50" >조직</th>
			                         <td width="150">
			                            <comment id="_NSID_"> 
			                                <object id=LC_O_ORG_FLAG classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=100 align="absmiddle"  tabindex=2 > </object> 
			                            </comment><script>_ws_(_NSID_);</script></td>
			                        </tr>   
			                         </table> 
			                    <td></td>
							</table> 
	            	</td></tr>
	            	
					<tr><td class="dot" ></td></tr>
					
	            	<tr><td > 
	                    <!-- 점 -->
	                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A"> 
	                    <tr><td>
	                  		<comment id="_NSID_">
	                  			<OBJECT id=GD_STORE width="168" height="395" classid=<%=Util.CLSID_GRID%>>
	                      			<param name="DataID" value="DS_O_STR_CD">
	                  			</OBJECT></comment><script>_ws_(_NSID_);</script>
	                    </td></tr>   
	                    </table>
					</td></tr>
	            	</table>
	            </td>
	            <td width="2"></td>
	            <td width="190" valign="top">
	                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A"> 
	                <tr><td>
	                    <!-- 팀 -->
	                    <comment id="_NSID_">
	                    <OBJECT id=GD_DEPT width="168" height="463" classid=<%=Util.CLSID_GRID%>>
	                        <param name="DataID" value="DS_O_DEPT_CD">
	                    </OBJECT></comment><script>_ws_(_NSID_);</script>
	                </td></tr>   
	                </table>
				</td>
				
	            <td width="2"></td>
	            <td width="190" valign="top">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A"> 
                    <tr><td>
                        <!-- TEAM -->
                        <comment id="_NSID_">
                        <OBJECT id=GD_TEAM width="180" height="463" classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_O_TEAM_CD">
                        </OBJECT></comment><script>_ws_(_NSID_);</script>
                    </td></tr>   
                    </table>
                </td>
                
	            <td width="2"></td>
	            <td width="190" valign="top">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A"> 
                    <tr><td>
                        <!-- PC -->
                        <comment id="_NSID_">
                        <OBJECT id=GD_PC width="190" height="463" classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_O_PC_CD">
                        </OBJECT></comment><script>_ws_(_NSID_);</script>
                    </td></tr>   
                    </table>
                </td>
                
	            <td width="2"></td>
	            <td width="190" valign="top"> 
                     <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A"> 
                     <tr><td>
                         <!-- 품번 -->
                         <comment id="_NSID_">
                         <OBJECT id=GD_PUMBUN width="190" height="463" classid=<%=Util.CLSID_GRID%>>
                             <param name="DataID" value="DS_O_PUMBUN_CD">
                         </OBJECT></comment><script>_ws_(_NSID_);</script>
                     </td></tr>   
                     </table>
                 </td>
                    
                </tr>
                </table>
            </td>
              </tr>
        </table>
        </td>
        <td class="pop06"></td>
    </tr>
    <tr>
        <td class="pop07"></td>
        <td class="pop08"></td>
        <td class="pop09"></td>
    </tr>
</table>
</body>

</html>
