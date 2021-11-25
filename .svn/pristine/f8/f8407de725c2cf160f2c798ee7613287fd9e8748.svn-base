package gzonei.mypage.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasypt.commons.CommonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.google.gson.Gson;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.cmmn.service.FileUtilService;
import gzonei.cmmn.service.GzoneiLoginService;
import gzonei.cmmn.util.FileUtils;
import gzonei.member.service.MemberService;
import gzonei.mypage.service.MypageService;
import gzonei.payment.service.PaymentService;

/**
 * 
 * MypageController
 * 
 * @author PODO 개발3팀 김승제
 * @since 2021.01.26
 * @version 1.0
 * @see ************ 개발 고려사항 ************
 *
 *
 *
 *      <pre>
* << 개정이력(Modification Information) >>
*
*   수정일     	 	수정자          	수정내용
*  -------    --------    ---------------------------
*  2021.01.26      김승제         		최초 생성
 * 
 *
 *      </pre>
 */
@Controller
public class MypageController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MypageController.class);

	/** gzoneiLoginService */
	@Resource(name = "gzoneiLoginService")
	private GzoneiLoginService gzoneiLoginService;

	/** MemberService */
	@Resource(name = "MemberService")
	private MemberService memberService;

	/** MypageService */
	@Resource(name = "MypageService")
	private MypageService mypageService;

	/** CmmnService */
	@Resource(name = "cmmnService")
	private CmmnService cmmnService;

	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;

	@Resource(name = "PaymentService")
	private PaymentService paymentService;

	@Resource(name = "FileUtils")
	private FileUtils fileUtils;

	/** 희진 */
	/**
	 * 마이페이지 - 회원정보 수정
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/modifyMyInfo.do")
	public String modifyMyInfo(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,
			Model model) throws SQLException, IOException {

		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap searchVO = new EgovMap();

		if (null == loginVO) {
			EgovMap redirectInfo = new EgovMap();
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult", redirectInfo);
			return "redirect:/main.do";
		} else {
			String userId = (String) loginVO.get("id");
			searchVO.put("emplyrId", userId);
		}
		List<?> mberGradCode = cmmnService.selectCodeList("GRAD", null);// 회원등급코드
		List<?> indvdlMberCode = cmmnService.selectCodeList("CMMN", "CM00210000");// 개인회원코드
		List<?> clCode = cmmnService.selectCodeList("CMMN", "CM00320000");// 개인회원분류코드
		List<?> sidoCode = cmmnService.selectCodeList("AREA", "0000000000");// 시도코드
		List<?> productCode = cmmnService.selectCodeList("PRODUCT", "0000000000");// 상품코드
		model.addAttribute("sidoCode", sidoCode);
		EgovMap resultVO = memberService.selectMemberDetail(searchVO);
		// 관심지역
		if (!("".equals(resultVO.get("intrstAreaCode1"))) && (null != resultVO.get("intrstAreaCode1"))) {
			String sido = "";
			if ("0000000000".equals(resultVO.get("intrstAreaCode1"))) {
				sido = (String) resultVO.get("intrstAreaCode");
			} else {
				sido = (String) resultVO.get("intrstAreaCode1");
			}
			List<?> gunGuCode = cmmnService.selectCodeList("AREA", sido);// 군구코드
			model.addAttribute("gunGuCode", gunGuCode);
		}

		// 사업자등록증
		String atchFileId = (String) resultVO.get("bizrnoAtchFileId");

		System.out.println("첨부파일 Id : " + atchFileId);
		if (!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
		model.addAttribute("mberGradCode", mberGradCode);
		model.addAttribute("indvdlMberCode", indvdlMberCode);
		model.addAttribute("clCode", clCode);
		model.addAttribute("sidoCode", sidoCode);
		model.addAttribute("productCode", productCode);
		model.addAttribute("resultVO", resultVO);
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		if (null != inputFlashMap) {
			model.addAttribute("sMsg", inputFlashMap.get("sMsg"));
		}
		String str = "";
		// 사업자회원일 경우
		if ("CM00210002".equals(loginVO.get("indvdlMberCode"))) {
			str = "gzonei/mypage/bizModifyForm";
		} else {// 개인 또는 관리자회원일 경우
			str = "gzonei/mypage/modifyForm";
		}
		return str;
	}

	/**
	 * 회원 수정 처리
	 * 
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/memberActionUdt.do")
	public String memberActionUdt(@RequestParam Map<String, Object> commandMap, MultipartHttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirect) throws SQLException, IOException {

		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		if (null == loginVO) {
			EgovMap redirectInfo = new EgovMap();
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult", redirectInfo);
			return "redirect:/main.do";
		} else {
			commandMap.put("lastUpdusrId", loginVO.get("id"));
			commandMap.put("frstRegisterId", loginVO.get("id"));
		}

		if (CommonUtils.isEmpty((String) commandMap.get("emailRecptnAt"))) { // 이메일 수신동의
			commandMap.put("emailRecptnAt", "N");
		}
		if (CommonUtils.isEmpty((String) commandMap.get("smsRecptnAt"))) { // sms 수신동의
			commandMap.put("smsRecptnAt", "N");
		}
		// 사업자등록증 입력 및 수정
		String uploadDt = request.getParameter("uploadDt");
//		String[] fileAuthor = request.getParameterValues("fileAuthor");
		String[] fileAuthor = { "CM00209998" };
		String[] atchFileNm = request.getParameterValues("atchFileNm");
		if (uploadDt == null || uploadDt == "") {
			uploadDt = fileUtils.getDate();
		}
		String atchFileId = request.getParameter("atchFileId");
		EgovMap searchVO = new EgovMap();
		if (null != atchFileId && !"".equals(atchFileId)) {
			searchVO.put("atchFileId", atchFileId);
			searchVO.put("useAt", "N");
			searchVO.put("delAt", "Y");
			fileUtilService.deleteAtchFileAtrb(searchVO);
		}
		try {
			atchFileId = fileUtils.insertFileInf(request, "BBS_", atchFileId, atchFileNm, uploadDt, fileAuthor);
			commandMap.put("atchFileId", atchFileId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int result = mypageService.memberActionUdt(commandMap);
		if (result > 0) {
			redirect.addFlashAttribute("sMsg", "SUCCESS");
		} else {
			redirect.addFlashAttribute("sMsg", "FAIL");
		}

		return "redirect:/mypage/modifyMyInfo.do";
	}

	/**
	 * 마이페이지 - 나의 관심정보 리스트 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/interestList.do")
	public String selectInterestList(HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirect, Model model) throws SQLException, IOException {

		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		if (null == loginVO) {
			EgovMap redirectInfo = new EgovMap();
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult", redirectInfo);
			return "redirect:/main.do";
		}
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		if (null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		EgovMap searchVO = new EgovMap();
		searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex", paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		String userId = (String) loginVO.get("id");
		searchVO.put("userId", userId);
		searchVO.put("upperIntrstThingSn", request.getParameter("upperIntrstThingSn"));

		List<?> groupList = mypageService.selectInterestGroupList(userId);
		List<?> infoList = mypageService.selectInterestInfoList(searchVO);
		int totCnt = mypageService.selectInterestInfoCnt(searchVO);

		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("groupList", groupList);
		model.addAttribute("infoList", infoList);
		model.addAttribute("paginationInfo", paginationInfo);

		return "gzonei/mypage/interestInfo";

	}

	/**
	 * 마이페이지 - 관심정보 그룹 추가
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/interestGroupAdd.do")
	public void insertInterestGroup(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {
		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		String resultStr = "";

		searchVO.put("userId", request.getParameter("userId"));
		searchVO.put("interGroupNm", request.getParameter("interGroupNm"));
		searchVO.put("frstRegisterId", request.getParameter("frstRegisterId"));
		searchVO.put("lastUpdusrId", request.getParameter("lastUpdusrId"));
		int groupCnt = mypageService.selectInterProdGoupChkCount(searchVO);
		if (groupCnt > 4) {
			resultStr = "GROUP_CNT_OVER";
		} else {
			resultStr = mypageService.insertInterProd(searchVO);
		}
		resultMap.put("result", resultStr);
		resultList = gson.toJson(resultMap);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);

	}

	/**
	 * 마이페이지 - 관심정보 그룹명 수정
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/updateInterProdGrpNm.do")
	public void updateInterProdGrpNm(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {
		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		String resultStr = "";

		searchVO.put("userId", request.getParameter("userId"));
		searchVO.put("uuid", request.getParameter("uuid"));
		searchVO.put("interGroupNm", request.getParameter("interGroupNm"));
		searchVO.put("frstRegisterId", request.getParameter("frstRegisterId"));
		searchVO.put("lastUpdusrId", request.getParameter("lastUpdusrId"));
		int groupCnt = mypageService.updateInterProdGrpNm(searchVO);
		if (groupCnt > 0) {
			resultStr = "SUCCESS";
		} else {
			resultStr = "ERROR";
		}
		resultMap.put("result", resultStr);
		resultList = gson.toJson(resultMap);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);

	}

	/**
	 * 마이페이지 - 관심정보 삭제
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/deleteInterProdGrpNm.do")
	public void deleteInterProdGrpNm(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {
		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		String resultStr = "";

		searchVO.put("userId", request.getParameter("userId"));
		searchVO.put("uuid", request.getParameter("uuid"));
		searchVO.put("frstRegisterId", request.getParameter("frstRegisterId"));
		searchVO.put("lastUpdusrId", request.getParameter("lastUpdusrId"));
		int groupCnt = mypageService.deleteInterProdGrpNm(searchVO);
		if (groupCnt > 0) {
			resultStr = "SUCCESS";
		} else {
			resultStr = "ERROR";
		}
		resultMap.put("result", resultStr);
		resultList = gson.toJson(resultMap);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);

	}

	/**
	 * 마이페이지 - 나의관심정보 선택삭제
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/interestProdDel.do")
	public void delteInterestProd(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {
		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		int result = 0;

		searchVO.put("userId", request.getParameter("userId"));// id
		searchVO.put("frstRegisterId", request.getParameter("userId"));
		searchVO.put("lastUpdusrId", request.getParameter("userId"));
		String[] interProdSeq = request.getParameterValues("INTER_PROD_SEQ");

		if (interProdSeq == null || interProdSeq.length < 1) {
		} else {
			searchVO.put("interProdSeq", interProdSeq);
			result = mypageService.deleteInterProd(searchVO);
		}

		resultMap.put("result", result);
		resultList = gson.toJson(resultMap);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);

	}

	/** 다현 */
	/**
	 * 
	 * 회원탈퇴 신청 페이지로 이동
	 * 
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/secessionReqst.do")
	public String secessionReqst(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,
			Model model) throws SQLException, IOException {
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		if (null == loginVO) {
			EgovMap redirectInfo = new EgovMap();
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult", redirectInfo);
			return "redirect:/main.do";
		}
		return "gzonei/mypage/secessionReqst";

	}

	/**
	 * 
	 * 탈퇴신청
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/secessionCheck.do")
	public void secessionCheck(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();

		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		searchVO.put("userId", loginVO.get("id"));
		searchVO.put("secsnResn", request.getParameter("secsnResn"));
		int resultCnt = mypageService.secessionCheck(searchVO);

		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);
	}

	/**
	 * 
	 * 내 결제내역 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/mypaymentList.do")
	public String selectMypaymentList(HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirect, Model model) throws SQLException, IOException {

		EgovMap searchVO = new EgovMap();

		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		if (null == loginVO) {
			EgovMap redirectInfo = new EgovMap();
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult", redirectInfo);
			return "redirect:/main.do";
		}

		searchVO.put("userId", loginVO.get("id"));
//		searchVO.put("userId", "11");
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		if (null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex", paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		List<?> resultList = mypageService.selectMypaymentList(searchVO);
		int totCnt = mypageService.selectMypaymentListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		return "gzonei/mypage/mypaymentList";

	}

	/**
	 * 
	 * 결제연장하기 페이지 이동
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/payReqst.do")
	public String payPage(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,
			Model model) throws SQLException, IOException {
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		if (null == loginVO) {
			EgovMap redirectInfo = new EgovMap();
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult", redirectInfo);
			return "redirect:/main.do";
		}
		List<?> gradCdList = mypageService.selectGradCodeList();
//		List<?> srvcCodeList = mypageService.selectSrvcCodeList();

//		model.addAttribute("srvcCodeList",srvcCodeList);
		model.addAttribute("gradCdList", gradCdList);

		return "gzonei/mypage/payReqst";
	}

	/**
	 * 
	 * 상품 코드 정보 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/selectGoodsCode.do")
	public void selectGoodsCode(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {

		Gson gson = new Gson();
		String result = "";
		EgovMap searchVO = new EgovMap();

		searchVO.put("gradAuthorSn", request.getParameter("gradAuthorSn"));

		List<?> resultList = mypageService.selectGoodsCode(searchVO);

		result = gson.toJson(resultList);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);
	}

	/**
	 * 
	 * 탈퇴 신청 완료 페이지이동
	 * 
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/secsnReqstCompt.do")
	public String secsnReqstCompt(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {

		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		try {
			gzoneiLoginService.updateLoginLog(loginVO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getSession().setAttribute("loginVO", null);

		return "gzonei/mypage/secsnReqstCompt";

	}

	/**
	 * 
	 * 결제/요청 신청하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/paymentReqst.do")
	public void paymentReqst(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();

		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		searchVO.put("userId", loginVO.get("id"));

		// searchVO.put("goodsNm", request.getParameter("goodsNm"));
		searchVO.put("useMonthCo", request.getParameter("useMonthCo"));
		searchVO.put("setleDtls", request.getParameter("setleDtls"));
		searchVO.put("srvcCode", request.getParameter("srvcCode"));
		String setleMnSeCode = request.getParameter("setleMnSeCode");
		searchVO.put("gradAmountSn", request.getParameter("gradAmountSn"));
		searchVO.put("setleAmount", request.getParameter("setleAmount"));
		if ("CM00250001".equals(setleMnSeCode)) {
			// searchVO.put("cardSn", request.getParameter("cardSn"));
		}
		searchVO.put("setleMnSeCode", setleMnSeCode);

		int resultCnt = mypageService.paymentReqst(searchVO);

		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);
	}

	@RequestMapping(value = "/mypage/cardPayReqst.do")
	public String cardPayReqst(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,
			Model model) throws SQLException, IOException {
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		Map<String, Object> resultMap = new HashMap<>();
		EgovMap searchVO = new EgovMap();

		if (null == loginVO) {
			EgovMap redirectInfo = new EgovMap();
			redirectInfo.put("message", "로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult", redirectInfo);
			return "redirect:/main.do";
		}
		String mid = request.getParameter("MID");
		String tid = request.getParameter("TID");
		String amt = request.getParameter("Amt");
		String moid = request.getParameter("MOID");
		String authdate = request.getParameter("AuthDate");
		String authcode = request.getParameter("AuthCode");
		String resultcode = request.getParameter("ResultCode");
		String resultmsg = request.getParameter("ResultMsg");
		String errorcode = request.getParameter("ErrorCode");
		String errormsg = request.getParameter("ErrorMsg");
		String EPayCl = request.getParameter("EPayCl");
		String goodsName = request.getParameter("GoodsName");
		String buyerEmail = request.getParameter("BuyerEmail");
		String name = request.getParameter("name");

		searchVO.put("gradAmountSn", moid);
		searchVO.put("setleDtls", goodsName);
		searchVO.put("userId", loginVO.get("id"));
		searchVO.put("setleAmount", amt);
		searchVO.put("setleMnSeCode", "CM00250001");
		searchVO.put("lastUpdusrId", loginVO.get("id"));

		// resultMap
		resultMap.put("excclcTyCode", "CM00250001");
		resultMap.put("excclcPnttm", "today");
		resultMap.put("excclcAmount", amt);
		resultMap.put("excclcId", loginVO.get("id"));
		resultMap.put("excclcNm", name);
		resultMap.put("userId", loginVO.get("id"));

		List<?> gradCdList = mypageService.selectGradCodeList();
		List<?> srvcCodeList = mypageService.selectSrvcCodeList();

		model.addAttribute("srvcCodeList", srvcCodeList);
		model.addAttribute("gradCdList", gradCdList);
		if ("3001".equals(resultcode)) {
			int resultCnt = mypageService.paymentReqst(searchVO);
			EgovMap Sn = mypageService.selectSetleSn(searchVO);
//			String goodsDetailCode = mypageService.selectDetailCode(searchVO);
			if (!(Sn.isEmpty())) {
				searchVO.put("setleSn", Sn.get("setleSn"));
				searchVO.put("goodsDetailCode", Sn.get("goodsDetailCode"));
				searchVO.put("useMonthCo", Sn.get("useMonthCo"));
				resultCnt = memberService.confirmPayment(searchVO);
				// 정산관리 추가
				paymentService.insertExcclcInfo(resultMap);

				// start
				try {

					request.getSession().setAttribute("loginVO", null);
					request.getSession().setAttribute("authVO", null);
					request.getSession().setAttribute("authVO2", null);

					EgovMap resultVO = gzoneiLoginService.checkLogin(loginVO);
					/* 다중접속 체킹 종료 */
					List<?> authVO = cmmnService.selectAuth(resultVO);
					EgovMap authVO2 = new EgovMap();
					String json = new Gson().toJson(authVO);
					List<EgovMap> a = (List<EgovMap>) authVO;

					for (int z = 0; z < a.size(); z++) {
						authVO2.put((String) a.get(z).get("authorCode"), a.get(z));
					}

					request.getSession().setAttribute("authVO", authVO2);
					request.getSession().setAttribute("authVO2", json);
					// 3-1. 로그인 정보를 세션에 저장
					request.getSession().setAttribute("loginVO", resultVO);
					// 2019.10.01 로그인 인증세션 추가
//					request.getSession().setAttribute("accessUser", resultVO.get("userSe")+(resultVO.get("id").toString()));

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				// end

			} else {

				resultCnt = 0;
			}

			if (resultCnt > 0) {

				return "redirect:/mypage/paymentReqstCompt2.do";
			} else {
				EgovMap redirectInfo = new EgovMap();
				redirectInfo.put("message", errormsg);
				redirect.addFlashAttribute("redircetResult", redirectInfo);
				return "redirect:/mypage/payReqst.do";
			}

		} else {
			EgovMap redirectInfo = new EgovMap();
			redirectInfo.put("message", errormsg);
			redirect.addFlashAttribute("redircetResult", redirectInfo);
			return "redirect:/mypage/payReqst.do";
		}
	}
//	@Requestmapping(value="/card/result.do")
//	asdafaf {
//		if(결과 == success) {
//			int resultCnt = mypageService.paymentReqst(searchVO);
//			int resultCnt = mypageService.무톤장입금확인(searchVO);
//			int resultCnt = mypageService.정산내역(searchVO);
//			int resultCnt = mypageService.권한 세션 날려주고 다시 조회해서 넣어주고 ;
//			redirect -> 결제내역
//		}else {
//			error->
//			redic->결제/연장하기
//			}
//	}

	/**
	 * 
	 * 결제완료페이지이동
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/paymentReqstCompt.do")
	public String paymentReqstCompt(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {

		return "gzonei/mypage/payReqstCompt";

	}

	@RequestMapping(value = "/mypage/paymentReqstCompt2.do")
	public String paymentReqstCompt2(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {

		return "gzonei/mypage/payReqstCompt2";

	}

	/**
	 * 
	 * 상품정보 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/mypage/selectPayInfo.do")
	public void selectPayInfo(HttpServletRequest request, HttpServletResponse response, Model model)
			throws SQLException, IOException {
		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String result = "";
		EgovMap searchVO = new EgovMap();

		searchVO.put("gradAmountSn", request.getParameter("gradAmountSn"));

		EgovMap resultVO = mypageService.selectPayInfo(searchVO);

		result = gson.toJson(resultVO);

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);
	}

}
