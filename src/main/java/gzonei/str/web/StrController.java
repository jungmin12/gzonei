package gzonei.str.web;

import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.FileUtilService;
//import gzonei.cmmn.util.FileUtils;
/*import gzonei.util.Old_FileUtils;*/
import gzonei.cmmn.util.FileUtils;
import gzonei.sample.web.SampleController;
import gzonei.str.service.StrService;


@Controller
public class StrController {
	private static final Logger LOGGER = LoggerFactory.getLogger(SampleController.class);
	
	/** SampleService */
	@Resource(name = "StrService")
	private StrService strService;
	
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertyService;
    
    @Resource(name="FileUtils")
	private FileUtils fileUtils;
    
 	// 게시판 조회
	@RequestMapping(value="/str/strBbsList.do")
	public String strBbsList(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		EgovMap searchVO = new EgovMap();
		PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        
        EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	EgovMap redirectInfo = new EgovMap();
        EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
        EgovMap authInfo = new EgovMap();
        String accessAuth = "";
        String author = "";

        //접근권한 
        if(auth!=null) {
			authInfo =  (EgovMap) auth.get("bbs002001");
			accessAuth =  authInfo.get("menuAccesAt").toString();
        }    	
    	//로그인 세션 검사
		if(session != null) {
			author =  session.get("indvdlMberCode").toString();
			if(!accessAuth.equals("Y") ) {
				redirectInfo.put("message", "등급이 낮아 열람하실 수 없습니다.");
				redirect.addFlashAttribute("bbsredircetResult",redirectInfo);
				return "redirect:/main.do";
			}
		}else {
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
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
		
		List<?> resultList = strService.strBbsList(searchVO);
		
		int totCnt = strService.selectStrListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		

		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);

		
		//샘플 페이지 이동
		
		return "gzonei/str/strBbsList";
	}
	@RequestMapping(value="/str/strSuccesBbsList.do")
	public String strSuccesBbsList(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		EgovMap searchVO = new EgovMap();
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		
		String readngAuthorCode = "002";
		String tabCd = "002";
		searchVO.put("readngAuthorCode", readngAuthorCode);
		searchVO.put("tabCd", tabCd);

		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}


		
		
	   EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	EgovMap redirectInfo = new EgovMap();
        EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
        EgovMap authInfo = new EgovMap();
        String accessAuth = "";
        String author = "";

        //접근권한 
        if(auth!=null) {
			authInfo =  (EgovMap) auth.get("bbs002001");
			accessAuth =  authInfo.get("menuAccesAt").toString();
        }    	
    	//로그인 세션 검사
		if(session != null) {
			author =  session.get("indvdlMberCode").toString();
			if(!accessAuth.equals("Y") ) {
				redirectInfo.put("message", "등급이 낮아 열람하실 수 없습니다.");
				redirect.addFlashAttribute("bbsredircetResult",redirectInfo);
				return "redirect:/main.do";
			}
		}else {
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
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
		
		List<?> resultList = strService.strBbsList(searchVO);
		
		int totCnt = strService.selectStrListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
		
		
		//샘플 페이지 이동
		
		return "gzonei/str/strSuccesBbsList";
	}
	@RequestMapping(value="/str/strFailrBbsList.do")
	public String strFailrBbsList(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		EgovMap searchVO = new EgovMap();
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		
		String readngAuthorCode = "003";
		String tabCd = "003";
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		
		
		EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	EgovMap redirectInfo = new EgovMap();
        EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
        EgovMap authInfo = new EgovMap();
        String accessAuth = "";
        String author = "";

        //접근권한 
        if(auth!=null) {
			authInfo =  (EgovMap) auth.get("bbs002001");
			accessAuth =  authInfo.get("menuAccesAt").toString();
        }    	
    	//로그인 세션 검사
		if(session != null) {
			author =  session.get("indvdlMberCode").toString();
			if(!accessAuth.equals("Y") ) {
				redirectInfo.put("message", "등급이 낮아 열람하실 수 없습니다.");
				redirect.addFlashAttribute("bbsredircetResult",redirectInfo);
				return "redirect:/main.do";
			}
		}else {
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}		
		
		
		
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		searchVO.put("readngAuthorCode", readngAuthorCode);
		searchVO.put("tabCd", tabCd);
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
		
		List<?> resultList = strService.strBbsList(searchVO);
		
		int totCnt = strService.selectStrListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
		
		
		//샘플 페이지 이동
		
		return "gzonei/str/strFailrBbsList";
	}

	// 게시물 상세보기
	@RequestMapping(value="/str/strBbsDetail.do")
	public String strBbsDetail(@RequestParam(value="pageNo", required=false) String pageNo,HttpServletRequest request, 
								HttpServletResponse response, RedirectAttributes redirect, Model model) throws Exception{
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap searchVO = new EgovMap();
		String nttId = request.getParameter("nttId");
		System.out.println("nttId : "+ nttId);
		searchVO.put("nttId", nttId);
		

        
        //페이지 접근 권한 설정-------
        EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
        EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
        EgovMap authInfo = new EgovMap();
        String accessAuth = "";
        String gradInfo = "";
        //반환 정보
        EgovMap redirectInfo = new EgovMap();
        //접근권한 
        if(auth!=null) {
			authInfo =  (EgovMap) auth.get("bbs002002");
			accessAuth =  authInfo.get("menuAccesAt").toString();
        }    	
    	//로그인 세션 검사
		if(session != null) {
			gradInfo =  session.get("indvdlMberCode").toString();
			if(!accessAuth.equals("Y") ) {
				redirectInfo.put("message", "등급이 낮아 열람하실 수 없습니다.");
				redirect.addFlashAttribute("bbsredircetResult",redirectInfo);
				return "redirect:/main.do";
			}
		}else {
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}
		//---------
		
		String readngAuthorCode = request.getParameter("readngAuthorCode");
		searchVO.put("readngAuthorCode", readngAuthorCode);
		
		searchVO.put("orderType", request.getParameter("orderType"));
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		
		searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("keyword", request.getParameter("keyword"));
		
		
		String tabCd = request.getParameter("tabCd");
		searchVO.put("tabCd", tabCd);
		
		String pageIndex = request.getParameter("pageIndex");
		searchVO.put("pageIndex", pageIndex);

		
		// 조회수 1씩 증가
		strService.updateBbsRdcnt(searchVO);
		
		EgovMap resultList = strService.strBbsDetail(searchVO);

		String atchFileId = fileUtilService.selectAtchFileId(searchVO);
		
		System.out.println("첨부파일 Id : "+ atchFileId);
		if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
//		List<Object> test= strService.selectaAtchFile(nttId);
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("articleNum", request.getParameter("articleNum"));
		
		return "gzonei/str/strBbsDetail";
	}
	
	// 게시물 등록 페이지 이동
	@RequestMapping(value="/strBbsRegist.do")
	public String strBbsRegist(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		EgovMap searchVO = new EgovMap();

		String readngAuthorCode = request.getParameter("readngAuthorCode");
		searchVO.put("readngAuthorCode", readngAuthorCode);
		
		model.addAttribute("searchVO", searchVO);

		return "gzonei/str/strBbsRegist";
	}
	
	// 게시물 글 쓰기
	@RequestMapping(value="/str/strBbsRgst.do")
	public String strBbsRgst(HttpServletRequest request, HttpServletResponse response, Model model, MultipartHttpServletRequest multi) throws Exception{
		EgovMap writeVO = new EgovMap();
		
		// 첨부파일 아이디 가져오기
		String date = fileUtils.getDate();
		System.out.println("date : "+date);
		String [] atchFileNm = request.getParameterValues("atchFileNm");
		String[] fileAuthor = request.getParameterValues("fileAuthor");
		/*System.out.println("fileAuthor : "+fileAuthor);*/
		
		String atchFileId = fileUtils.insertFileInf(multi,"BBS_","",atchFileNm,date,fileAuthor);
		String nttCn = ((String) request.getParameter("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
		String nttSj = ((String) request.getParameter("nttSj")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
		/*System.out.println("파일아이디 : "+ atchFileId );*/
		
		System.out.println("시간 : "+ getDate() );
		System.out.println("bbsId : "+ request.getParameter("bbsId"));
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String mberCode = (String) loginVO.get("indvdlMberCode");
		System.out.println("mberCode : "+mberCode);
		if(mberCode.equals("CM00210003")) {
			writeVO.put("freeAt", request.getParameter("freeAt"));		
			writeVO.put("dspyAt", request.getParameter("dspyAt"));
		}else {
			writeVO.put("freeAt", "Y");		
			writeVO.put("dspyAt", "Y");
		}
		
		writeVO.put("useAt", request.getParameter("useAt"));
		writeVO.put("delAt", request.getParameter("delAt"));
		writeVO.put("rdcnt", request.getParameter("rdcnt"));		
		writeVO.put("atchFileId", atchFileId);
		writeVO.put("bbsId", request.getParameter("bbsId"));
		writeVO.put("nttSj", nttSj);
		writeVO.put("nttCn", nttCn);
		writeVO.put("ntceBgnde", getDate());		
		writeVO.put("frstRegisterId", request.getParameter("frstRegisterId"));		
		writeVO.put("frstRegistPnttm", request.getParameter("frstRegistPnttm"));		
		writeVO.put("readngAuthorCode", request.getParameter("readngAuthorCode"));		
		strService.strBbsRgst(writeVO);

		return "redirect:/str/strBbsList.do";
	}
	
	// 게시물 수정 페이지 이동
	@RequestMapping(value="/str/strBbsUpdate.do")
	public String strBbsUpdate(HttpServletRequest request, HttpServletResponse response, Model model, MultipartHttpServletRequest multi) throws Exception{
		EgovMap searchVO = new EgovMap();
		String nttId = request.getParameter("nttId");
		System.out.println("nttId : "+nttId);
		searchVO.put("nttId", nttId);
		
		String readngAuthorCode = request.getParameter("readngAuthorCode");
		searchVO.put("readngAuthorCode", readngAuthorCode);
		

		EgovMap result = strService.strBbsDetail(searchVO);
		
		String atchFileId = fileUtilService.selectAtchFileId(searchVO);
		
		System.out.println("첨부파일 Id : "+ atchFileId);
		if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
		
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("result", result);
		model.addAttribute("articleNum", request.getParameter("articleNum"));
		return "gzonei/str/strBbsUpdate";
	}
	
	// 게시물 수정
	@RequestMapping(value="/str/strBbsUdt.do")
	public String strBbsUdt(HttpServletRequest request, HttpServletResponse response, Model model, MultipartHttpServletRequest multi) throws Exception{
		EgovMap updateVO = new EgovMap();
		String articleNum = request.getParameter("articleNum");
		String nttId = request.getParameter("nttId");
		String uploadDt = request.getParameter("uploadDt");
		String[] fileAuthor = request.getParameterValues("fileAuthor");
		String [] atchFileNm = request.getParameterValues("atchFileNm");
		/*for(String num : atchFileNm) {
			System.out.println("atchFileNm : "+num);
		}
		for(String num : fileAuthor) {
			System.out.println("fileAuthor : "+num);
		}*/
		if(uploadDt == null || uploadDt == "") {
			uploadDt = fileUtils.getDate();
			System.out.println("date : "+uploadDt);
		}
		
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
		updateVO.put("bbsId", request.getParameter("bbsId"));
		updateVO.put("nttSj", nttSj);
		updateVO.put("nttCn", nttCn);
		updateVO.put("lastUpdusrId", request.getParameter("lastUpdusrId"));
		updateVO.put("readngAuthorCode", request.getParameter("readngAuthorCode"));
		updateVO.put("frstRegistPnttm", request.getParameter("frstRegistPnttm"));
		
		strService.strBbsUdt(updateVO);
		System.out.println("articleNum :"+articleNum);
		return "redirect:/str/strBbsDetail.do?nttId="+nttId+"&articleNum="+articleNum;
	}
	

	
	// 게시물 삭제
	@RequestMapping(value="/str/strBbsDelete.do")
	public String strBbsDelete(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		EgovMap deleteVO = new EgovMap();
		String atchFileId = request.getParameter("atchFileId");
		deleteVO.put("nttId", request.getParameter("nttId"));
		deleteVO.put("useAt", "N");
		deleteVO.put("delAt", "Y");
		if(!(atchFileId == null || atchFileId == "")) {
			deleteVO.put("atchFileId", request.getParameter("atchFileId"));
			fileUtilService.deleteAtchFileAtrb(deleteVO);			
		}
		strService.strBbsDelete(deleteVO);
		return "redirect:/str/strBbsList.do";
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
