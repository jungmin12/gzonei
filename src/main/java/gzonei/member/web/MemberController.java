package gzonei.member.web;


import java.io.IOException;

import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.jasypt.commons.CommonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.cmmn.service.FileUtilService;
import gzonei.cmmn.util.FileUtils;
import gzonei.member.service.CertificationVO;
import gzonei.member.service.MemberService;

/**
* 
* MemberController
* @author PODO 개발3팀 김승제
* @since 2021.01.26
* @version 1.0
* @see
* ************ 개발 고려사항  ************ 
*
*
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일     	 	수정자          	수정내용
*  -------    --------    ---------------------------
*  2021.01.26      김승제         		최초 생성
*  
*
*  </pre>
*/
@Controller
public class MemberController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberController.class);
	
	/** MemberService */
	@Resource(name = "MemberService")
	private MemberService memberService;
	
	/** CmmnService */
	@Resource(name = "cmmnService")
	private CmmnService cmmnService;
	
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
	 @Resource(name="FileUtils")
	private FileUtils fileUtils;
	/** 희진 */
	/**
	 * 회원가입 - step1 : 회원선택페이지 이동
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/joinStep1.do")
	public String joinStep1(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		return "gzonei/member/joinStep1";
	}
	
	/**
	 * 회원가입 - step2 : 동의 화면(약관동의)으로 이동
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/joinStep2.do")
	public String joinStep2(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		String mberGradCode = (String) request.getParameter("mberGradCode");
		model.addAttribute("mberGradCode",mberGradCode);
		
		//날짜 생성
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String day = sdf.format(today.getTime());

		java.util.Random ran = new Random();
		//랜덤 문자 길이
		int numLength = 6;
		String randomStr = "";

		for (int i = 0; i < numLength; i++) {
			//0 ~ 9 랜덤 숫자 생성
			randomStr += ran.nextInt(10);
		}

		//reqNum은 최대 40byte 까지 사용 가능
		String reqNum = day + randomStr;
		String certDate=day;
		String	serverType = "real";
		if("localhost".equals(request.getServerName())) {
			serverType="dev";
		}else if("211.172.247.32".equals(request.getServerName())) {
			serverType="dev2";
		}else if("new2.gzonei.com".equals(request.getServerName())) {
			serverType="new2";
		}else if("www.gzonei.com".equals(request.getServerName()) && "http".equals(request.getScheme())) {
			serverType="http";
		}

		String	serviceNum = CertificationVO.SERVICE_LOCAL_NUMBER;
		String	returnUrl = "32http://dev.gzonei.com:8888";
		if	("dev".equals(serverType))	{
			serviceNum	= CertificationVO.SERVICE_DEV_NUMBER;
			returnUrl		= "32http://localhost:8080";
		}else if	("real".equals(serverType))	{
			serviceNum	= CertificationVO.SERVICE_REAL_NUMBER;
			returnUrl		= "32https://www.gzonei.com";
		}else if	("dev2".equals(serverType))	{
			serviceNum	= CertificationVO.SERVICE_DEV2_NUMBER;
			returnUrl		= "32http://211.172.247.32:58080";
		}else if	("new2".equals(serverType))	{
			serviceNum	= CertificationVO.SERVICE_NEW2_NUMBER;
			returnUrl		= "32https://new2.gzonei.com";
		}else if	("http".equals(serverType))	{
			serviceNum	= CertificationVO.SERVICE_HTTP_NUMBER;
			returnUrl		= "32http://www.gzonei.com";
		}
		
		EgovMap paramVO = new EgovMap();
		paramVO.put("serviceNum", serviceNum);
		paramVO.put("reqNum", reqNum);
		paramVO.put("certDate", certDate);
		paramVO.put("returnUrl", returnUrl);
		model.addAttribute("paramVO",paramVO);
		return "gzonei/member/joinStep2";
	}
	
	/**
	 * 실명인증 보내기
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/pccSendSeed.do")
	public String pccSendSeed(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		CertificationVO	certVO	= new CertificationVO();

		try {
			BeanUtils.populate(certVO, request.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		certVO.encodeInfo(response);
		model.addAttribute("certVO",certVO);
		 
		return "gzonei/member/pccSendSeed";
	}
	/**
	 * 실명인증 요청 수신
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/pccRecieveSeed.do")
	public String pccRecieveSeed(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		CertificationVO	certVO	= new CertificationVO();
		
		try {
			BeanUtils.populate(certVO, request.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		certVO.decodeInfo(request);
		
		String param = "";
		String enc_retInfo   = certVO.getRetInfo().trim();

		param= "&retInfo="+enc_retInfo;

		String	sCheckType	= "FALSE";
		String	sMsg		= "";
		String	phoneNo		= "";
		String	userName	= "";

		if( !certVO.isPassMsg() ){
			sMsg	= "비정상적인 접근입니다.!!";
		}
		else if	( !certVO.isSuccess() )	{
			sMsg	= "본인 확인에 실패 하였습니다.!!\\n정확한 정보를 입력하시기 바랍니다.";
		}
		else	{
			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
			//탈퇴
			if	( "WITHDRAW".equals( certVO.getAddVar() ) )	{
				phoneNo		= (String)loginVO.get("mbtlnum");
				if (phoneNo == null) {
					phoneNo = "";
		        }else {
		        	phoneNo = phoneNo.replace("-", "");
		        }
				userName		= (String)loginVO.get("userNm");
				if (userName == null) {
					userName = "";
				}

				if	( phoneNo.equals( certVO.getCellNo() ) && userName.equals( certVO.getName() ) )	{
					sCheckType	= "WITHDRAW";
				}
				else	{
					sMsg	= "등록된 정보와 일치하지 않습니다.!!\\n정확한 정보를 입력하시기 바랍니다.";
				}
			}
			else	{
				sCheckType	= "JOIN";
			}
		}
		
		if("JOIN".equals(sCheckType)) {
			model.addAttribute("param",param);
			model.addAttribute("certVO",certVO);
			model.addAttribute("sMsg",sMsg);
			model.addAttribute("sCheckType",sCheckType);
			return "gzonei/member/pccRecieveSeed";
		}else {
			model.addAttribute("sMsg",sMsg);
			model.addAttribute("sCheckType",sCheckType);
			return "redirect:/joinStep1.do";
		}

	}
	/**
	 * 회원가입 - step3 : 정보입력페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/joinStep3.do", method=RequestMethod.POST)
	public String joinStep3(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		CertificationVO	certVO	= new CertificationVO();
		try {
			BeanUtils.populate(certVO, request.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String str = "";
		List<?> sidoCode = cmmnService.selectCodeList("AREA","0000000000");//시도코드
		model.addAttribute("sidoCode",sidoCode);
		// 개인 회원 가입
		if	("01".equals(certVO.getPsnMemCd()))	{
			certVO.decodeInfo(request);
			List<?> clCode = cmmnService.selectCodeList("CMMN","CM00320000");//개인회원분류코드
			model.addAttribute("clCode",clCode);
			str = "gzonei/member/joinForm";
		}else {
			str = "gzonei/member/bizJoinForm";
		}
		model.addAttribute("certVO",certVO);
		
		return str;
	}
	/**
	 * 회원가입 - 회원등록처리
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/memberActionReg.do")
	public String memberActionReg(@RequestParam Map<String, Object> commandMap,  HttpServletResponse response, Model model,MultipartHttpServletRequest request) throws Exception{
		
		commandMap.put("mberSecsnAt", "N");// 회원탈퇴여부
		commandMap.put("invtInqireAuthorAt", "N");// 경매정보조회권한
		commandMap.put("sntncRegistAuthorAt", "Y");// 쓰기권한
		commandMap.put("smtmConectAt", "N");// 동시접속여부
		
		if (CommonUtils.isEmpty((String) commandMap.get("emailRecptnAt"))) { //이메일 수신동의
			commandMap.put("emailRecptnAt", "N");
		}
		if (CommonUtils.isEmpty((String) commandMap.get("smsRecptnAt"))) { //sms 수신동의
			commandMap.put("smsRecptnAt", "N");
		}
		// 사업자회원일 경우 
		if ("CM00210002".equals(commandMap.get("indvdlMberCode"))) {
			commandMap.put("mberSttusCode", "CM00220001");	// 회원상태(승인요청)
		}
		else {// 개인 또는 관리자회원일 경우
			commandMap.put("mberSttusCode", "CM00220002");	// 회원상태(승인)
		}
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		if(loginVO != null) {
			commandMap.put("frstRegisterId", loginVO.get("id"));
			commandMap.put("lastUpdusrId", loginVO.get("id"));
		}else {
			commandMap.put("frstRegisterId", commandMap.get("emplyrId"));
			commandMap.put("lastUpdusrId", commandMap.get("emplyrId"));
		}
		// 첨부파일 아이디 가져오기
		String date = fileUtils.getDate();
		System.out.println("date : "+date);
		String [] atchFileNm = request.getParameterValues("atchFileNm");
//		String[] fileAuthor = request.getParameterValues("fileAuthor");
		String[] fileAuthor = {"CM00209998"};
//		if(fileAuthor == null || fileAuthor == "") fileAuthor = null;
		String atchFileId = fileUtils.insertFileInf(request,"BBS_","",atchFileNm,date,fileAuthor);
		commandMap.put("atchFileId", atchFileId);
		memberService.insertMemberInfo(commandMap);//회원정보 입력
		
		model.addAttribute("indvdlMberCode", commandMap.get("indvdlMberCode"));
		return "redirect:/joinStep4.do";
	}
	/**
	 * 회원가입 - step4 : 가입완료페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/joinStep4.do")
	public String joinStep4(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		String indvdlMberCode = request.getParameter("indvdlMberCode");
		model.addAttribute("indvdlMberCode", indvdlMberCode);
		return "gzonei/member/joinStep4";
	}
	/**
	 * 회원목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberList.do")
	public String selectMemberList(@RequestParam Map<String, Object> commandMap,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap redirectInfo = new EgovMap();
		if(null == loginVO) {
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}else{
			String author =(String) loginVO.get("indvdlMberCode");
			if(!"CM00210003".equals(author)) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
		}
		EgovMap searchVO = new EgovMap();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		for (String mapkey : commandMap.keySet()){
	        searchVO.put(mapkey, commandMap.get(mapkey));
	    }


		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());

		List<?> resultList = memberService.selectMemberList(searchVO);
		int totCnt = memberService.selectMemberListTotCnt(searchVO);
		int chkCnt = memberService.selectChkMemberTotCnt(searchVO);//승인대기자수
		searchVO.put("chkCnt",chkCnt);

		paginationInfo.setTotalRecordCount(totCnt);
		//코드리스트
		List<?> mberGradCode = cmmnService.selectCodeList("GRAD",null);//회원등급코드
		List<?> mberStateCode = cmmnService.selectCodeList("CMMN","CM00220000");//회원상태코드(승인)
		List<?> indvdlMberCode = cmmnService.selectCodeList("CMMN","CM00210000");//개인회원코드
		List<?> sidoCode = cmmnService.selectCodeList("AREA","0000000000");//시도코드
		
		model.addAttribute("mberGradCode",mberGradCode);
		model.addAttribute("mberStateCode",mberStateCode);
		model.addAttribute("indvdlMberCode",indvdlMberCode);
		model.addAttribute("sidoCode", sidoCode);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "gzonei/admin/member/memberList";
	}
	
	/**
	 * 회원 등급 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberManage.do")
	public String memberManageList(@RequestParam Map<String, Object> commandMap,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap redirectInfo = new EgovMap();
		if(null == loginVO) {
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}else{
			String author =(String) loginVO.get("indvdlMberCode");
			if(!"CM00210003".equals(author)) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
		}
		EgovMap searchVO = new EgovMap();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		for (String mapkey : commandMap.keySet()){
			searchVO.put(mapkey, commandMap.get(mapkey));
		}
		
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("searchKrwd", request.getParameter("searchKrwd"));
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		
		//코드리스트
		List<?> mberGradCode = cmmnService.selectCodeList("GRAD",null);//회원등급코드
		List<?> mberStateCode = cmmnService.selectCodeList("CMMN","CM00220000");//회원상태코드(승인)
		List<?> indvdlMberCode = cmmnService.selectCodeList("CMMN","CM00210000");//개인회원코드
		List<?> sidoCode = cmmnService.selectCodeList("AREA","0000000000");//시도코드
		
		
		//체크박스처리 - 회원등급조회
		String [] gradIds = request.getParameterValues("gradId");
		
		if(null == gradIds) {
			String [] gradIds2 = new String[14];
			for(int i=0; i<9; i++) {
				gradIds2[i] = "CM0020000" + String.valueOf(i+1);
			}
			gradIds2[9] = "CM00200010";
			gradIds2[10] = "CM00200011";
			gradIds2[11] = "CM00200012";
			gradIds2[12] = "CM00200018";
			gradIds2[13] = "CM00200019";
			searchVO.put("gradIds", gradIds2);
		}else{
			searchVO.put("gradIds", gradIds);
		}
		
		List<?> resultList = memberService.memberManageList(searchVO);
		int totCnt = memberService.memberManageCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("mberGradCode",mberGradCode);
		model.addAttribute("mberStateCode",mberStateCode);
		model.addAttribute("indvdlMberCode",indvdlMberCode);
		model.addAttribute("sidoCode", sidoCode);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "gzonei/admin/member/memberManage";
	}
	
	/**
	 *  회원 등급 목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value="/admin/member/memberManageListExcel.do", produces = "application/json; charset=utf8")
	public String memberManageListExcel(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		Gson gson = new Gson();
		EgovMap searchVO = new EgovMap();
		
		for (String mapkey : commandMap.keySet()){
			searchVO.put(mapkey, commandMap.get(mapkey));
		}
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("searchKrwd", request.getParameter("searchKrwd"));
		
		//체크박스처리 - 회원등급조회
		String [] gradIds = request.getParameterValues("gradId");
		
		if(null == gradIds) {
			String [] gradIds2 = new String[14];
			for(int i=0; i<9; i++) {
				gradIds2[i] = "CM0020000" + String.valueOf(i+1);
			}
			gradIds2[9] = "CM00200010";
			gradIds2[10] = "CM00200011";
			gradIds2[11] = "CM00200012";
			gradIds2[12] = "CM00200018";
			gradIds2[13] = "CM00200019";
			searchVO.put("gradIds", gradIds2);
		}else{
			searchVO.put("gradIds", gradIds);
		}
		List<?> resultList = memberService.memberManageListExcel(searchVO);
		
		String json = gson.toJson(resultList);
		
		return json;	
		
	}
	
	
	
	/**
	 * 회원정보 상세보기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberView.do")
	public String selectMemberDetail(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		EgovMap redirectInfo = new EgovMap();
		if(null == loginVO) {
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}else{
			String author =(String) loginVO.get("indvdlMberCode");
			if(!"CM00210003".equals(author)) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
		}
		EgovMap searchVO = new EgovMap();
		for (String mapkey : commandMap.keySet()){
	        searchVO.put(mapkey, commandMap.get(mapkey));
	    }

//		searchVO.put("emplyrId", request.getParameter("emplyrId"));
		List<?> mberGradCode = cmmnService.selectCodeList("GRAD","Y");//회원등급코드
		List<?> indvdlMberCode = cmmnService.selectCodeList("CMMN","CM00210000");//개인회원코드
		List<?> clCode = cmmnService.selectCodeList("CMMN","CM00320000");//개인회원분류코드
		List<?> sidoCode = cmmnService.selectCodeList("AREA","0000000000");//시도코드
		List<?> productCode = cmmnService.selectCodeList("PRODUCT","0000000000");//상품코드
		model.addAttribute("sidoCode",sidoCode);
		EgovMap resultVO = memberService.selectMemberDetail(searchVO);
		//관심지역
		if(!("".equals(resultVO.get("intrstAreaCode1"))) && (null != resultVO.get("intrstAreaCode1"))){
			String sido = "";
			if("0000000000".equals(resultVO.get("intrstAreaCode1"))) {
				sido = (String)resultVO.get("intrstAreaCode");
			}else {
				sido = (String)resultVO.get("intrstAreaCode1");
			}
			List<?> gunGuCode = cmmnService.selectCodeList("AREA",sido);//군구코드
			model.addAttribute("gunGuCode",gunGuCode);
		}
		//사업자등록증
		String atchFileId = (String)resultVO.get("bizrnoAtchFileId");
		
		System.out.println("첨부파일 Id : "+ atchFileId);
		if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
		model.addAttribute("mberGradCode",mberGradCode);
		model.addAttribute("indvdlMberCode",indvdlMberCode);
		model.addAttribute("clCode",clCode);
		model.addAttribute("sidoCode",sidoCode);
		model.addAttribute("productCode",productCode);
		model.addAttribute("resultVO",resultVO);
		model.addAttribute("searchVO",searchVO);
		
		return "gzonei/admin/member/memberView";
	}
	
	
	/**
	 *  회원목록 엑셀다운로드
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value="/admin/member/selectMemberListExcel.do", produces = "application/json; charset=utf8")
	public String selectMemberListExcel(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		Gson gson = new Gson();
		EgovMap searchVO = new EgovMap();
		
		for (String mapkey : commandMap.keySet()){
	        searchVO.put(mapkey, commandMap.get(mapkey));
	    }
		
		List<?> resultList = memberService.selectMemberListExcel(searchVO);
		
		String json = gson.toJson(resultList);
		
		return json;	

	}
	
	
	/**
	 * 회원 승인상태로 변경하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberConfirm.do")
	public void updateMemberState(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("emplyrId", request.getParameter("emplyrId"));
		
		int resultCnt = memberService.updateMemberState(searchVO);
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
	/**
	 * 결제내역, 조회이력 조회
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/infoList.do")
	public void selectInfoList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("userId", request.getParameter("userId"));
		String type = request.getParameter("type");
		
		List<?> result = new ArrayList<>();
		if("payment".equals(type)) {
			result = memberService.selectPaymentList(searchVO);
			resultMap.put("paymentList", result);
		}else if("chkInfo".equals(type)) {
			PaginationInfo paginationInfo = new PaginationInfo();
			BoardVO boardVO = new BoardVO();
			if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
				boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
			}
			paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
			paginationInfo.setPageSize(boardVO.getPageSize());

			searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
			searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
			searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
			
			result = memberService.selectChkInfoList(searchVO);
			int totCnt = memberService.selectChkInfoTotCnt(searchVO);

			paginationInfo.setTotalRecordCount(totCnt);
			
			resultMap.put("chkInfoList", result);
			resultMap.put("searchVO", searchVO);
			resultMap.put("paginationInfo", paginationInfo);
			
		}
		
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
	}
	
	/**
	 * 회원등록 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberReg.do")
	public String adminMemberReg(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		EgovMap redirectInfo = new EgovMap();
		if(null == loginVO) {
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}else{
			String author =(String) loginVO.get("indvdlMberCode");
			if(!"CM00210003".equals(author)) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
		}
		EgovMap resultVO = new EgovMap();
		if(null != request.getParameter("indvdlMberCode") && !"".equals(request.getParameter("indvdlMberCode"))) {
			resultVO.put("indvdlCode", request.getParameter("indvdlMberCode"));
		}else {
			resultVO.put("indvdlCode", "CM00210001");
		}
		
		List<?> indvdlMberCode = cmmnService.selectCodeList("CMMN","CM00210000");//개인회원코드
		List<?> sidoCode = cmmnService.selectCodeList("AREA","0000000000");//시도코드
		List<?> clCode = cmmnService.selectCodeList("CMMN","CM00320000");//개인회원분류코드
		model.addAttribute("clCode",clCode);
		model.addAttribute("indvdlMberCode",indvdlMberCode);
		model.addAttribute("sidoCode",sidoCode);
		model.addAttribute("resultVO",resultVO);
		
		return "gzonei/admin/member/memberReg";
	}
	
	/** 아이디 중복 체크
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberIdChk.do")
	public void adminMemberIdChk(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("checkId", request.getParameter("checkId"));
		
		int resultCnt = memberService.selectMemberIdChk(searchVO);
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	/**사업자 번호 중복 체크
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/bizNoChk.do")
	public void bizNoChk(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("bizrno", request.getParameter("bizrno"));
		
		int resultCnt = memberService.selectMemberbizNoChk(searchVO);
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
	/**
	 * 관심지역 구/군코드 가져오기
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/member/selectCodeList.do")
	public void selectGuGunCodeList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		
		String sidoCode = (String)request.getParameter("sidoCode");
		
		List<?> guGunCode = cmmnService.selectCodeList("AREA",sidoCode);//구/군코드
		resultMap.put("result", guGunCode);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	/**
	 * 회원 등록 처리
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberActionReg.do")
	public String adminMemberActionReg(@RequestParam Map<String, Object> commandMap,
			RedirectAttributes redirect, HttpServletResponse response, Model model, MultipartHttpServletRequest request) throws SQLException , IOException{
		
		commandMap.put("frstRegisterId", request.getParameter("userId"));
		commandMap.put("lastUpdusrId", request.getParameter("userId"));
		commandMap.put("mberSecsnAt", "N");// 회원탈퇴여부
		commandMap.put("invtInqireAuthorAt", "N");// 경매정보조회권한
		
		// 사업자회원일 경우 
		if ("CM00210002".equals(commandMap.get("indvdlMberCode"))) {
			commandMap.put("mberSttusCode", "CM00220001");	// 회원상태(승인요청)
		}
		// 개인 또는 관리자회원일 경우
		else {
			commandMap.put("mberSttusCode", "CM00220002");	// 회원상태(승인)
		}
		
		// 첨부파일 아이디 가져오기
		String date = fileUtils.getDate();
		String [] atchFileNm = request.getParameterValues("atchFileNm");
//		String[] fileAuthor = request.getParameterValues("fileAuthor");
		String[] fileAuthor = {"CM00209998"};
		String atchFileId;
		try {
			atchFileId = fileUtils.insertFileInf(request,"BBS_","",atchFileNm,date,fileAuthor);
			commandMap.put("atchFileId", atchFileId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		memberService.insertMemberInfo(commandMap);//회원정보 입력
		// 관리자일 경우 기본 등급 (관리자(일반) 등급 적용 CM00200015 )
		if ("CM00210003".equals(commandMap.get("indvdlMberCode"))) {
			commandMap.put("mberGradCode", "CM00200015");	//관리자(일반) 등급
			commandMap.put("useBgnde", "today");	//권한 시작일
			commandMap.put("useEndde", "9999-12-31");	//권한 종료일
			memberService.insertMemberGrade(commandMap);
		}
		return "redirect:/admin/member/memberList.do";
	}
	
	/** 회원 수정 처리
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberActionUdt.do")
	public String adminMemberActionUdt(@RequestParam Map<String, Object> commandMap,
			RedirectAttributes redirect, HttpServletResponse response, Model model, MultipartHttpServletRequest request) throws SQLException , IOException{
		
//		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
//		EgovMap redirectInfo = new EgovMap();
//		if(null == loginVO) {
//			redirectInfo.put("message", "로그인 시 이용가능합니다.");
//			redirect.addFlashAttribute("redircetResult",redirectInfo);
//			return "redirect:/main.do"; 
//		}else{
//			String author =(String) loginVO.get("indvdlMberCode");
//			if(!"CM00210003".equals(author)) {
//				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
//				redirect.addFlashAttribute("redircetResult",redirectInfo);
//				return "redirect:/main.do"; 
//			}
//		}
//		commandMap.put("frstRegisterId", loginVO.get("id"));
//		commandMap.put("lastUpdusrId", loginVO.get("id"));
		commandMap.put("frstRegisterId", request.getParameter("userId"));
		commandMap.put("lastUpdusrId", request.getParameter("userId"));
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("emplyrId", request.getParameter("emplyrId"));
		//메모상태변경
		EgovMap resultVO = memberService.selectMemberDetail(searchVO);
		if(!commandMap.get("setleMemo").equals(resultVO.get("setleMemo"))) {
			commandMap.put("setleMemoDt", "Y");
		}
		if(!commandMap.get("edcMemo").equals(resultVO.get("edcMemo"))) {
			commandMap.put("edcMemoDt", "Y");
		}
		if(!commandMap.get("etcMemo").equals(resultVO.get("etcMemo"))) {
			commandMap.put("etcMemoDt", "Y");
		}
		//사업자등록증 입력 및 수정
		String uploadDt = request.getParameter("uploadDt");
//		String[] fileAuthor = request.getParameterValues("fileAuthor");
		String[] fileAuthor = {"CM00209998"};
		String [] atchFileNm = request.getParameterValues("atchFileNm");
		if(uploadDt == null || uploadDt == "") {
			uploadDt = fileUtils.getDate();
		}
		String atchFileId = request.getParameter("atchFileId");
		if(null != atchFileId && !"".equals(atchFileId)) {
			searchVO.put("atchFileId", atchFileId);
			searchVO.put("useAt", "N");
			searchVO.put("delAt", "Y");
			fileUtilService.deleteAtchFileAtrb(searchVO);
		}
		try {
			atchFileId = fileUtils.insertFileInf(request,"BBS_",atchFileId,atchFileNm,uploadDt,fileAuthor);
			System.out.println("atchFileId---->" +  atchFileId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		commandMap.put("atchFileId", atchFileId);
		
		memberService.adminMemberActionUdt(commandMap);
		
		return "redirect:/admin/member/memberList.do";
	}
	
	/**
	 * 회원정보(id,이름) 가져오기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/searchMemberInfo.do")
	public void searchMemberInfo(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("searchKrwd", request.getParameter("searchKrwd"));
		searchVO.put("searchSel", request.getParameter("searchSel"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());

		List<?> result = memberService.selectSearchMemberInfo(searchVO);
		int totCnt = memberService.selectSearchMemberInfoTotCnt(searchVO);

		paginationInfo.setTotalRecordCount(totCnt);
		
		resultMap.put("result", result);
		resultMap.put("searchVO", searchVO);
		resultMap.put("paginationInfo", paginationInfo);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
	/** 다현 */
	
	/**
	 * 
	 * 접속이력목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	
	@RequestMapping(value="/admin/member/connectList.do")
	public String selectConnectList(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		EgovMap redirectInfo = new EgovMap();
		if(null == loginVO) {
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}else{
			String author =(String) loginVO.get("indvdlMberCode");
			if(!"CM00210003".equals(author)) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
		}
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("startDate",request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("searchSel", request.getParameter("searchSel"));
		searchVO.put("searchKrwd", request.getParameter("searchKrwd"));
		
//		if(null != request.getParameter("userId") && !"".equals(request.getParameter("userId"))) {
//			searchVO.put("userId", request.getParameter("userId"));
//		}else {
//			searchVO.put("userId", "");
//		}
		
	    PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
      
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());

		List<?> resultList = memberService.selectConnectList(searchVO);
		int totCnt = memberService.selectConnectListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("totCnt",totCnt);
		model.addAttribute("paginationInfo",paginationInfo);
		return "gzonei/admin/member/connectList";
		
	}
	
	
	/**
	 * 
	 * 사용자접속이력조회
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value="/admin/member/userConnectList.do",produces="application/json;charset=UTF-8")
	public String selectUserConnectHist(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
		String userId = request.getParameter("userId");
		EgovMap searchVO = new EgovMap();
		searchVO.put("userId", userId);
		
		List<?> resultList = memberService.selectUserConnectHist(searchVO);
	    
		Gson gson = new Gson();
		String json = gson.toJson(resultList);
		
		return json;
	}
	
	/**
	 * 
	 * 패널티목록조회 
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/penaltyList.do")
	public String selectPenaltyList(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		EgovMap redirectInfo = new EgovMap();
		if(null == loginVO) {
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}else{
			String author =(String) loginVO.get("indvdlMberCode");
			if(!"CM00210003".equals(author)) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
		}
		EgovMap searchVO = new EgovMap();
		searchVO.put("startDate",request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("searchSel", request.getParameter("searchSel"));
		searchVO.put("searchKrwd", request.getParameter("searchKrwd"));
//		if(null != request.getParameter("userId") && !"".equals(request.getParameter("userId"))) {
//			searchVO.put("userId", request.getParameter("userId"));
//		}else {
//			searchVO.put("userId", "");
//		}
	    PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
      
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());

		List<?> resultList = memberService.selectPenaltyList(searchVO);
		int totCnt = memberService.selectPenaltyListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("totCnt",totCnt);
		model.addAttribute("paginationInfo",paginationInfo);
		return "gzonei/admin/member/penaltyList";
		
	}
	
	/**
	 * 
	 * 사용자 패널티 해제
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/penaltyRelease.do")
	public void updatePenaltyRelease(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		searchVO.put("userId", request.getParameter("userId"));
		searchVO.put("lastUpdusrId", loginVO.get("id"));
		int resultCnt = memberService.updatePenaltyRelease(searchVO);
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
	/**
	 * 
	 * 패널티목록 회원상세정보 조회 팝업창 
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/memberDetailPopup.do")
	public void selectMemberDetailView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		
		Gson gson = new Gson();
		String result = "";
		EgovMap searchVO = new EgovMap();
		
		
		searchVO.put("emplyrId", request.getParameter("emplyrId"));
		EgovMap resultVO = memberService.selectMemberDetail(searchVO);
		
	    result = gson.toJson(resultVO);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);		
	}
	
	/**
	 * 
	 * 회원탈퇴신청 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/secessionList.do")
	public String selectSecessionList(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		EgovMap redirectInfo = new EgovMap();
		if(null == loginVO) {
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}else{
			String author =(String) loginVO.get("indvdlMberCode");
			if(!"CM00210003".equals(author)) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
		}
		EgovMap searchVO = new EgovMap();
		searchVO.put("startDate",request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("searchSel", request.getParameter("searchSel"));
		searchVO.put("searchKrwd", request.getParameter("searchKrwd"));
	    PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
      
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());

		List<?> resultList = memberService.selecSecessionList(searchVO);
		int totCnt = memberService.selectSecessionListTotCnt(searchVO);
		int secsnWaitCnt = memberService.selectSecsnWaitCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("totCnt",totCnt);
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("secsnWaitCnt",secsnWaitCnt);
		
		return "gzonei/admin/member/secessionList";
		
	}
	
	/**
	 * 
	 * 탈퇴 승인
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/secessionConfirm.do")
	public void updateSecessionConfirm(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("userId", request.getParameter("userId"));
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		searchVO.put("lastUpdusrId", loginVO.get("id"));
		
		int resultCnt = memberService.updateSecessionConfirm(searchVO);
		
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
	/**
	 * 
	 * 무통장 입금내역 확인
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/member/confirmPayment.do")
	public void confirmPayment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		
		searchVO.put("lastUpdusrId", loginVO.get("id"));
		searchVO.put("userId", request.getParameter("userId"));
		searchVO.put("setleSn", request.getParameter("setleSn"));
		searchVO.put("goodsDetailCode", request.getParameter("goodsDetailCode"));
		searchVO.put("goodsCode", request.getParameter("goodsCode"));
		searchVO.put("useMonthCo", request.getParameter("useMonthCo"));
		
		int resultCnt = memberService.confirmPayment(searchVO);
		
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
	
	/**
	 * 
	 * 배너등록페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/bannerRegist.do")
	public String paymentReqstCompt(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		
		EgovMap redirectInfo = new EgovMap();
		
		if(null == loginVO) {
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}else{
			String author =(String) loginVO.get("indvdlMberCode");
			if(!"CM00210003".equals(author)) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
		}	
		
		 EgovMap searchVO = new EgovMap();
		 if("".equals((String)request.getParameter("se")) || (String)request.getParameter("se") == null) {
			 searchVO.put("se", "CM00330001");
		 }else {
			 searchVO.put("se",(String)request.getParameter("se"));
		 }
		 PaginationInfo paginationInfo = new PaginationInfo();
        
		 BoardVO boardVO = new BoardVO();
        
        
		 if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		 }
       
		 paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		 paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		 paginationInfo.setPageSize(boardVO.getPageSize());
      
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
        
        List<?> resultList = memberService.selectHeadBanner(searchVO);
		int totCnt = memberService.selectHeadBannerCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("totCnt",totCnt);
		model.addAttribute("paginationInfo",paginationInfo);
		
		return "gzonei/admin/bannerRegist";
		
	}
	
	/**
	 * 
	 * 배너 파일 등록
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param multi
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/bannerInsert.do")
	public String bannerInsert(HttpServletResponse response, Model model,MultipartHttpServletRequest request) throws Exception{
		
		
		
		
		EgovMap searchVO = new EgovMap();
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		searchVO.put("frstRegisterId",  loginVO.get("id"));
		searchVO.put("se", request.getParameter("se"));
		searchVO.put("bgndeMan", request.getParameter("bgndeMan"));
		searchVO.put("endDe", request.getParameter("endDe"));
		searchVO.put("linkUrl", request.getParameter("linkurl"));
		searchVO.put("useAt", request.getParameter("useAt"));
		// 첨부파일 아이디 가져오기
		String date = fileUtils.getDate();
		System.out.println("date : "+date);
		String [] atchFileNm = request.getParameterValues("atchFileNm");
		String[] fileAuthor = request.getParameterValues("fileAuthor");

		String atchFileId = fileUtils.insertFileInf(request,"BBS_","",atchFileNm,date,fileAuthor);
		searchVO.put("atchFileId", atchFileId);
	
		
		memberService.bannerInsert(searchVO);//배너 입력
		
		PaginationInfo paginationInfo = new PaginationInfo();
        
		 BoardVO boardVO = new BoardVO();
       
       
		 if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		 }
      
		 paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		 paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		 paginationInfo.setPageSize(boardVO.getPageSize());
     
		 searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		 searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		 searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
       
		 List<?> resultList = memberService.selectHeadBanner(searchVO);
		int totCnt = memberService.selectHeadBannerCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("totCnt",totCnt);
		model.addAttribute("paginationInfo",paginationInfo);
		
		
		
		return "gzonei/admin/bannerRegist";
	}
	
	/**
	 * 
	 * 배너 삭제
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/bannerDelete.do")
	public void bannerDelete(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("bannerManageSn", request.getParameter("bannerManageSn"));
		searchVO.put("atchFileId", request.getParameter("atchFileId"));
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		searchVO.put("lastUpdusrId", loginVO.get("id"));
		
		int resultCnt = memberService.bannerDelete(searchVO);
		
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
	/**
	 * 
	 * 배너 디테일 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/selectBannerDetail.do")
	public void selectBannerDetail(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		
		Gson gson = new Gson();
		String result = "";
		EgovMap searchVO = new EgovMap();
		
		
		searchVO.put("bannerManageSn", request.getParameter("bannerManageSn"));
		
		EgovMap resultVO = memberService.selectBannerDetail(searchVO);
		
	    result = gson.toJson(resultVO);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);		
	}
	
	/**
	 * 
	 * 배너 수정
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/updateBannerInfo.do")
	public void updateBannerInfo(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("bannerManageSn", request.getParameter("bannerManageSn"));
		searchVO.put("useAt", request.getParameter("useAt"));
		searchVO.put("bgndeMan", request.getParameter("bgndeMan"));
		searchVO.put("endDe", request.getParameter("endDe"));
		searchVO.put("url", request.getParameter("linkurl"));		
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		searchVO.put("lastUpdusrId", loginVO.get("id"));
		
		int resultCnt = memberService.updateBannerInfo(searchVO);
		
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
}
