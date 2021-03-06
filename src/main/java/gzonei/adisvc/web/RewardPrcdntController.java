package gzonei.adisvc.web;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.adisvc.service.RewardPrcdntService;
import gzonei.cmmn.service.FileUtilService;
import gzonei.cmmn.util.FileUtils;


@Controller
public class RewardPrcdntController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RewardPrcdntController.class);
	
	/** SampleService */
	@Resource(name = "RewardPrcdntService")
	private RewardPrcdntService rewardPrcdntService;
	
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
	@Resource(name="FileUtils")
	private FileUtils fileUtils;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;   
    
	
	
	/**
	 * 게시판 목록 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/adisvc/rewardPrcdntBbsList.do")
	public String rewardPrdntBbsList(@RequestParam(value="pageNo", required=false) String pageNo, RedirectAttributes redirect, 
									HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        

     
        String bbsId = request.getParameter("bbsId");
        System.out.println("bbsId : "+bbsId);
        
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        
        EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	String author ="";
		EgovMap redirectInfo = new EgovMap();
		if(session != null) {
			author = (String) session.get("indvdlMberCode");
		}else {
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}
        
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
        searchVO.put("bbsId", bbsId);
        searchVO.put("indvdlMberCode",author);	
        
		
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
        
        String orderType = "frst_regist_pnttm";
		
		if(request.getParameter("orderType") != null) {
			orderType = request.getParameter("orderType");
		}
		
    	searchVO.put("searchType", request.getParameter("searchType"));
    	searchVO.put("orderType", orderType);
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		searchVO.put("keyword", request.getParameter("keyword"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		
		// test
		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		System.out.println("searchType : " + searchType);
		System.out.println("keyword : " + keyword);
		System.out.println("startDate : " + startDate);
		System.out.println("endDate : " + endDate);
		
		List<?> resultList = rewardPrcdntService.rewardPrdntBbsList(searchVO);
		
		int totCnt = rewardPrcdntService.rewardPrdntBbsListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		

		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
		
		return "gzonei/adisvc/rewardPrcdntBbsList";
	}
	
	/**
	 * 보상판례 목록 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/adisvc/rewardPrcdntList.do")
	public String rewardPrcdntList(@RequestParam(value="pageNo", required=false) String pageNo, HttpServletRequest request, 
									HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		
		String bbsId = request.getParameter("bbsId");
		searchVO.put("bbsId", bbsId);

		String seCode = "prcdnt";
		searchVO.put("seCode", seCode);

		System.out.println("bbsId : "+bbsId);
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		
		EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	String author ="";
		if(session != null) {
			author = (String) session.get("indvdlMberCode");
		}
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		searchVO.put("indvdlMberCode",author);
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		
		String orderType = "frst_regist_pnttm";
		
		if(request.getParameter("orderType") != null) {
			orderType = request.getParameter("orderType");
		}
		
    	searchVO.put("searchType", request.getParameter("searchType"));
    	searchVO.put("orderType", orderType);
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		searchVO.put("keyword", request.getParameter("keyword"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		
		// test
		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		System.out.println("searchType : " + searchType);
		System.out.println("keyword : " + keyword);
		System.out.println("startDate : " + startDate);
		System.out.println("endDate : " + endDate);
		
		List<?> resultList = rewardPrcdntService.rewardPrdntBbsList(searchVO);
		
		int totCnt = rewardPrcdntService.rewardPrdntBbsListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
		
		return "gzonei/adisvc/rewardPrcdntList";
	}
	/**
	 * 보상판례 지침 목록 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/adisvc/rewardInstructionList.do")
	public String rewardInstructionList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		EgovMap searchVO = new EgovMap();
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		
		String bbsId = request.getParameter("bbsId");
		String seCode = "instrc";
		
		System.out.println("bbsId : "+bbsId);
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		
		EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	String author ="";
		if(session != null) {
			author = (String) session.get("indvdlMberCode");
		}
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		searchVO.put("bbsId", bbsId);
		searchVO.put("seCode", seCode);	
		searchVO.put("indvdlMberCode",author);
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		
		String orderType = "frst_regist_pnttm";
		
		if(request.getParameter("orderType") != null) {
			orderType = request.getParameter("orderType");
		}
		
    	searchVO.put("searchType", request.getParameter("searchType"));
    	searchVO.put("orderType", orderType);
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		searchVO.put("keyword", request.getParameter("keyword"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		
		// test
		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		System.out.println("searchType : " + searchType);
		System.out.println("keyword : " + keyword);
		System.out.println("startDate : " + startDate);
		System.out.println("endDate : " + endDate);
		
		List<?> resultList = rewardPrcdntService.rewardPrdntBbsList(searchVO);
		
		int totCnt = rewardPrcdntService.rewardPrdntBbsListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
		
		return "gzonei/adisvc/rewardInstructionList";
	}
	/**
	 * 보상판례 규정 목록 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/adisvc/rewardRegList.do")
	public String rewardRegList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		EgovMap searchVO = new EgovMap();
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		
		String bbsId = request.getParameter("bbsId");
		String seCode = "reg";
		System.out.println("bbsId : "+bbsId);
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		
		EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	String author ="";
		if(session != null) {
			author = (String) session.get("indvdlMberCode");
		}
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		searchVO.put("bbsId", bbsId);
		searchVO.put("seCode", seCode);
		searchVO.put("indvdlMberCode",author);
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		
		String orderType = "frst_regist_pnttm";
		
		if(request.getParameter("orderType") != null) {
			orderType = request.getParameter("orderType");
		}
		
    	searchVO.put("searchType", request.getParameter("searchType"));
    	searchVO.put("orderType", orderType);
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		searchVO.put("keyword", request.getParameter("keyword"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		
		// test
		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		System.out.println("searchType : " + searchType);
		System.out.println("keyword : " + keyword);
		System.out.println("startDate : " + startDate);
		System.out.println("endDate : " + endDate);
		
		List<?> resultList = rewardPrcdntService.rewardPrdntBbsList(searchVO);
		
		int totCnt = rewardPrcdntService.rewardPrdntBbsListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
		
		return "gzonei/adisvc/rewardRegList";
	}
	
	// 게시물 글 쓰기 페이지 이동
	@RequestMapping(value="/adisvc/rewardPrcdntBbsRegist.do")
	public String rewardPrcdntBbssdRegist(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		EgovMap searchVO = new EgovMap();

		String seCode = request.getParameter("seCode");
		searchVO.put("seCode", seCode);
		
		model.addAttribute("searchVO", searchVO);
		
		return "gzonei/adisvc/rewardPrcdntBbsRegist";
	}
	
	// 게시물 글 쓰기
	@RequestMapping(value="/adisvc/rewardPrcdntBbsRgst.do")
	public String rewardPrcdntBbsRgst(HttpServletRequest request, HttpServletResponse response, Model model, MultipartHttpServletRequest multi) throws Exception{
		EgovMap writeVO = new EgovMap();
		
		String date = fileUtils.getDate();
		System.out.println("date : "+date);
		String [] atchFileNm = request.getParameterValues("atchFileNm");
		String [] fileAuthor = request.getParameterValues("fileAuthor");
//		if(fileAuthor == null || fileAuthor == "") fileAuthor = null;
		// 첨부파일 아이디 가져오기
		String atchFileId = fileUtils.insertFileInf(multi,"BBS_","",atchFileNm,date,fileAuthor);
		String nttSj = ((String) request.getParameter("nttSj")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
		String nttCn = ((String) request.getParameter("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
		System.out.println("파일아이디 : "+ atchFileId );
		System.out.println("시간 : "+ getDate() );		
		
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String mberCode = (String) loginVO.get("indvdlMberCode");
		System.out.println("mberCode : "+mberCode);
		if(mberCode.equals("CM00210003")) {		
			writeVO.put("dspyAt", request.getParameter("dspyAt"));
		}else {
			writeVO.put("freeAt", "Y");		
			writeVO.put("dspyAt", "Y");
		}
		
		writeVO.put("atchFileId", atchFileId);
		writeVO.put("bbsId", request.getParameter("bbsId"));
		writeVO.put("readngAuthorCode", request.getParameter("readngAuthorCode"));
		writeVO.put("frstRegistPnttm", request.getParameter("frstRegistPnttm"));
		writeVO.put("seCode", request.getParameter("seCode"));
		writeVO.put("nttCn", nttCn);
		writeVO.put("nttSj", nttSj);
		writeVO.put("ntceBgnde", getDate());				
		writeVO.put("frstRegisterId", request.getParameter("frstRegisterId"));
		writeVO.put("useAt", request.getParameter("useAt"));
		writeVO.put("delAt", request.getParameter("delAt"));
		writeVO.put("rdcnt", request.getParameter("rdcnt"));
		
		
		rewardPrcdntService.rewardPrcdntBbsRgst(writeVO);
		
		return "redirect:/adisvc/rewardPrcdntBbsList.do";
	}
	
	// 게시물 상세보기
	@RequestMapping(value="/adisvc/rewardPrcdntBbsDetail.do")
	public String rewardPrcdntBbsDetail(@RequestParam(value="pageNo", required=false) String pageNo, 
									RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		EgovMap searchVO = new EgovMap();
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");

		
		
		String nttId = request.getParameter("nttId");
		System.out.println("nttId : "+ nttId);
		searchVO.put("nttId", request.getParameter("nttId"));
		
		String seCode = request.getParameter("seCode");
		searchVO.put("seCode", seCode);
		
		String pageIndex = request.getParameter("pageIndex");
		searchVO.put("pageIndex", pageIndex);
		
		searchVO.put("orderType", request.getParameter("orderType"));
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		
		searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("keyword", request.getParameter("keyword"));
		
		//권한관리
    	String author ="";
		EgovMap redirectInfo = new EgovMap();
		EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
		if(session == null){
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}
		
//		else{
//			author = (String) session.get("indvdlMberCode");
//			String gradCode = (String)session.get("gradCode");
//			
//			if(author!=("CM00210003")) {
//				if(gradCode.equals("CM00209998")) {	
//					if(listGradeCd != 0) {
//						if((loginGrade == 1 || loginGrade == 3) && listGradeCd > 10){
//							redirectInfo.put("message", "권한이 부족하여 게시물을 열람할 수 없습니다.");
//							redirect.addFlashAttribute("bbsredircetResult",redirectInfo);
//							return "redirect:/main.do";
//						}else if(loginGrade < listGradeCd) {
//							redirectInfo.put("message", "권한이 부족하여 게시물을 열람할 수 없습니다.");
//							redirect.addFlashAttribute("bbsredircetResult",redirectInfo);
//							return "redirect:/main.do";
//						}						
//					}
//				}
//			}
//		}
//		
		
		// 조회수 1씩 증가
		rewardPrcdntService.updateBbsRdcnt(searchVO);
		
		EgovMap resultList = rewardPrcdntService.rewardPrcdntBbsDetail(searchVO);
		
		EgovMap test = (EgovMap) authVO.get(resultList.get("readngAuthorCode"));
		if("N".equals(test.get("menuAccesAt"))){
			redirectInfo.put("message", "권한이 부족하여 게시물을 열람할 수 없습니다.");
			redirect.addFlashAttribute("bbsredircetResult",redirectInfo);
			
			return "redirect:/main.do";
//			return "redirect:/adisvc/recsroomBbsList.do?pageIndex="+pageIndex;
		}
		
		
		String atchFileId = fileUtilService.selectAtchFileId(searchVO);
		
		System.out.println("첨부파일 Id : "+ atchFileId);
		if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
		model.addAttribute("resultList", resultList);
		model.addAttribute("articleNum", request.getParameter("articleNum"));
		model.addAttribute("searchVO",searchVO);

		return "gzonei/adisvc/rewardPrcdntBbsDetail";
	}
	
	
	
	
	// 게시물 수정 페이지 이동
	@RequestMapping(value="/adisvc/rewardPrcdntBbsUpdate.do")
	public String rewardPrcdndstBbsUpdate(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		EgovMap searchVO = new EgovMap();
		String nttId = request.getParameter("nttId");
		System.out.println("nttId : "+nttId);
		searchVO.put("nttId", nttId);
		

		String seCode = request.getParameter("seCode");
		searchVO.put("seCode", seCode);
		
		
		EgovMap result = rewardPrcdntService.rewardPrcdntBbsDetail(searchVO);
		
		String atchFileId = fileUtilService.selectAtchFileId(searchVO);
		
		System.out.println("첨부파일 Id : "+ atchFileId);
		if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
		
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("result", result);
		model.addAttribute("articleNum", request.getParameter("articleNum"));
		
		return "gzonei/adisvc/rewardPrcdntBbsUpdate";
	}
	
	// 게시물 수정
	@RequestMapping(value="/adisvc/rewardPrcdntBbsUdt.do")
	public String rewardPrcdntBbsUdt(HttpServletRequest request, HttpServletResponse response, Model model, MultipartHttpServletRequest multi) throws Exception{
		EgovMap updateVO = new EgovMap();
		String articleNum = request.getParameter("articleNum");
		String nttId = request.getParameter("nttId");
		String uploadDt = request.getParameter("uploadDt");
		String [] fileAuthor = request.getParameterValues("fileAuthor");
		String [] atchFileNm = request.getParameterValues("atchFileNm");
//		if(fileAuthor == null || fileAuthor == "") fileAuthor = null;
		String atchFileId = request.getParameter("atchFileId");
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String mberCode = (String) loginVO.get("indvdlMberCode");
		System.out.println("mberCode : "+mberCode);
		if(mberCode.equals("CM00210003")) {
			System.out.println("관리자 수정");
			String delAt = request.getParameter("delAt");		
			updateVO.put("freeAt", request.getParameter("freeAt"));		
			updateVO.put("dspyAt", request.getParameter("dspyAt"));		
			updateVO.put("delAt", delAt);
			updateVO.put("indvdlMberCode", mberCode);
			if(delAt.equals("N")) {
				updateVO.put("useAt", request.getParameter("useAt"));
				if(!(atchFileId == "" || atchFileId == null)) {
					System.out.println("삭제됐던 첨부파일 불러오기");
					fileUtilService.deleteAtchFileAtrb(updateVO);
				}
			}
		}
		System.out.println("수정전  : "+atchFileId);
		atchFileId = fileUtils.insertFileInf(multi,"BBS_",atchFileId,atchFileNm,uploadDt,fileAuthor);
		System.out.println("수정후 : "+atchFileId);
		String nttSj = ((String) request.getParameter("nttSj")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
		String nttCn = ((String) request.getParameter("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");

		updateVO.put("nttId", nttId);
		updateVO.put("atchFileId", atchFileId);
		updateVO.put("seCode", request.getParameter("seCode"));
		updateVO.put("bbsId", request.getParameter("bbsId"));
		updateVO.put("nttSj", request.getParameter("nttSj"));
		updateVO.put("frstRegistPnttm", request.getParameter("frstRegistPnttm"));
		updateVO.put("nttCn", nttCn);
		updateVO.put("nttSj", nttSj);
		updateVO.put("lastUpdusrId", request.getParameter("lastUpdusrId"));
		updateVO.put("readngAuthorCode", request.getParameter("readngAuthorCode"));
		
		rewardPrcdntService.rewardPrcdntBbsUdt(updateVO);
		System.out.println("articleNum :"+articleNum);
		
		return "redirect:/adisvc/rewardPrcdntBbsDetail.do?nttId="+nttId+"&articleNum="+articleNum+"&listGrade="+request.getParameter("readngAuthorCode");
	}
	
	// 게시물 삭제
	@RequestMapping(value="/adisvc/rewardPrcdntBbsDelete.do")
	public String rewardPrcdntBbsDelete(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		EgovMap deleteVO = new EgovMap();
		deleteVO.put("nttId", request.getParameter("nttId"));
		String atchFileId = request.getParameter("atchFileId");
		if(!(atchFileId == null || atchFileId == "")) {
			deleteVO.put("atchFileId", atchFileId);
			deleteVO.put("useAt", "N");
			deleteVO.put("delAt", "Y");
			fileUtilService.deleteAtchFileAtrb(deleteVO);			
		}
		rewardPrcdntService.rewardPrcdntBbsDelete(deleteVO);
		
		return "redirect:/adisvc/rewardPrcdntBbsList.do";
	}
	
	// 현재 시간 가져오기
	private static String getDate() {

		String rtnStr = null;

		// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
		String pattern = "YYYY-MM-dd";

		SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern);
		Date date = new Date();

		rtnStr = sdfCurrent.format(date);

		return rtnStr;
	}
}
