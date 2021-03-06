package gzonei.cmmnty.web;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.FileUtilService;
import gzonei.cmmn.util.FileUtils;
import gzonei.cmmnty.service.CmmntyService;
import gzonei.sample.web.SampleController;
import gzonei.str.service.StrService;

/**
 * 커뮤니티 게시물 관리를 위한 컨트롤러 클래스
 * @author 개발 3팀 안중원
 * @since 2021.03.04
 * @version 1.0
 *   
 *   수정일              수정자          수정내용
 *  ----------   -------   ---------------------------
 *  2021.03.04   안중원          최초 생성
 *
 *
 */
@Controller
public class QnaController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SampleController.class);
	
	@Resource(name = "CmmntyService")
	private CmmntyService cmmntyservice;
	
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
	@Resource(name = "FileUtils")
	private FileUtils fileUtils;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertyService;
    
    /**
     * 게시판 목록 조회 및 검색한다.
     * 
     * @param req
     * @param res
     * @return model
     * @throws 
     */ 
    @RequestMapping(value="/cmmnty/qnaBbsList.do")
    public String selectQnaArticleList(RedirectAttributes redirect,HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
    	
    	EgovMap searchVO = new EgovMap(); 
    	PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        
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
			authInfo =  (EgovMap) auth.get("bbs008001");
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

		String orderType = "frst_regist_pnttm";
	      
	      if(request.getParameter("orderType") != null) {
	         orderType = request.getParameter("orderType");
	      }
	      
	      searchVO.put("orderType", orderType);
	      searchVO.put("delAt", request.getParameter("delAt"));
	      searchVO.put("dspyAt", request.getParameter("dspyAt"));

        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
      
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
        
    	searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("keyword", request.getParameter("keyword"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("indvdlMberCode",gradInfo);		
		searchVO.put("bbsId", "BBSMSTR_000000000007");
    	//** 일반 게시물
    	List<?> resultList = cmmntyservice.selectArticleList(searchVO);	
		int totCnt = cmmntyservice.selectListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
		model.addAttribute("menuType","all");
		return "/gzonei/cmmnty/qnaBbsList";
    }
    
    /**
     * 
     * 게시물을 상세조회한다.
     * 
     * @param req
     * @param res
     * @return model
     * @throws Exception 
     */
    @RequestMapping(value="/cmmnty/qnaBbsDetail.do")
    public String selectQnaArticleDetail(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
    	EgovMap searchVO = new EgovMap();
		searchVO.put("nttId", request.getParameter("nttId"));
		searchVO.put("startDate",request.getParameter("startDate"));
		searchVO.put("endDate",request.getParameter("endDate"));
		searchVO.put("searchType",request.getParameter("searchType"));
		searchVO.put("keyword",request.getParameter("keyword"));
		searchVO.put("orderType",request.getParameter("orderType"));
		model.addAttribute("searchVO", searchVO);
		
		 //페이지 접근 권한 설정
        EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
        EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
        EgovMap authInfo = new EgovMap();
        String accessAuth = "";
        String gradInfo = "";
        //반환 정보
        EgovMap redirectInfo = new EgovMap();
        //접근권한 
        if(auth!=null) {
			authInfo =  (EgovMap) auth.get("bbs008001");
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
		
    	String atchFileId = fileUtilService.selectAtchFileId(searchVO);		
    	System.out.println("첨부파일 Id : "+ atchFileId);
    	if(!(atchFileId == "" || atchFileId == null)) {
    		List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
    		model.addAttribute("atchFileDetail", atchFileDetail);
    	}
    	
		int rdcntUpdt = cmmntyservice.updateBbsRdcnt(searchVO);
		EgovMap result = cmmntyservice.selectDetail(searchVO);
		List<?> commentList = cmmntyservice.selectComment(searchVO);
		System.out.println(rdcntUpdt);
		String pageIndex = request.getParameter("pageIndex");
		if(pageIndex == null) {
			pageIndex = "1";
		}
		model.addAttribute("pageIndex", request.getParameter("pageIndex"));
		
		model.addAttribute("articleNum", request.getParameter("articleNum"));
		model.addAttribute("commentList",commentList);
		model.addAttribute("result",result);
		
		
		return "/gzonei/cmmnty/qnaBbsDetail";
    }
    
    /**
     * @throws Exception 
     * 게시물을 삭제한다.
     * 
     * @param req
     * @param res
     * @return model
     * @throws 
     */
    @RequestMapping(value="/cmmnty/qnaBbsDelete.do")
    public String deleteQnaArticle(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
   
    	
    	EgovMap deleteVO = new EgovMap();
    	deleteVO.put("nttId", request.getParameter("nttId"));
		String atchFileId = request.getParameter("atchFileId");
		if(!(atchFileId == null || atchFileId == "")) {
			deleteVO.put("nttId", request.getParameter("nttId"));
			deleteVO.put("atchFileId", request.getParameter("atchFileId"));
			deleteVO.put("useAt", "N");
			deleteVO.put("delAt", "Y");
			fileUtilService.deleteAtchFileAtrb(deleteVO);			
		}

		int check = cmmntyservice.deleteArticle(deleteVO);
		model.addAttribute(check);
		
		
    	return "redirect:/cmmnty/qnaBbsList.do";
    }
    /**
     * @throws Exception 
     * 게시물을 등록한다.
     * 
     * @param req
     * @param res
     * @return model
     * @throws 
     */
    @RequestMapping(value="/cmmnty/qnaBbsRgst.do")
    public String insertQnaArticle(@RequestParam Map<String, Object> commandMap,MultipartHttpServletRequest multi , HttpServletResponse response, HttpServletRequest request, Model model) throws Exception  {
//    	SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
//    	Date time = new Date();
//    	String realtime = format1.format(time);
    	String date = fileUtils.getDate();
		System.out.println("date : "+date);
		String [] atchFileNm = request.getParameterValues("atchFileNm");
		String[] fileAuthor = request.getParameterValues("fileAuthor");
    	// 첨부파일 아이디 가져오기
    	String atchFileId = fileUtils.insertFileInf(multi,"BBS_","",atchFileNm,date,fileAuthor);
    	String nttsj = ((String) commandMap.get("nttSj")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	commandMap.replace("nttSj", nttsj);
    	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	commandMap.replace("nttCn", nttcn);
    	commandMap.put("atchFileId", atchFileId);
//    	commandMap.put("frstRegistPnttm", realtime);
    	if(request.getParameter("dspyAt")!=null) { 		
    		String dspyAt = request.getParameter("dspyAt").toString();
    			if(dspyAt.toString().equals("Y")) {
    				commandMap.put("useAt", "Y");
    			}else {commandMap.put("useAt", "N");}	
    	}
    	int insertcheck = cmmntyservice.insertArticle(commandMap);
		if(insertcheck==1) {
			System.out.println("게시글 등록");
		}
    	return "redirect:/cmmnty/qnaBbsList.do";
    }
    
    /**
     * 등록 페이지로 이동한다.
     */
    @RequestMapping(value="/cmmnty/qnaBbsRegist.do")
    public String toinsertArticleList(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException {
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
			authInfo =  (EgovMap) auth.get("bbs008001");
			accessAuth =  authInfo.get("infoRegistAt").toString();
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
    	String menuType = request.getParameter("menuType");
    	model.addAttribute("menuType", menuType);
    	return "gzonei/cmmnty/qnaBbsRegist";
    }
    
    
    /**
     * 경매페이지로 이동한다.
     */
    @RequestMapping(value="/cmmnty/qnaAucList.do")
    public String toAucList(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException {
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
			authInfo =  (EgovMap) auth.get("bbs008001");
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
    	EgovMap searchVO = new EgovMap(); 
    	PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        
		
		String orderType = "frst_regist_pnttm";
	      
	      if(request.getParameter("orderType") != null) {
	         orderType = request.getParameter("orderType");
	      }
	      
	    searchVO.put("orderType", orderType);
	    searchVO.put("delAt", request.getParameter("delAt"));
	    searchVO.put("dspyAt", request.getParameter("dspyAt"));
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());

        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
        
    	searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("keyword", request.getParameter("keyword"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));

		searchVO.put("bbsId", "BBSMSTR_000000000007");
    	searchVO.put("seCode", "002");

    	
    	//** 일반 게시물
    	List<?> resultList = cmmntyservice.selectTabArticleList(searchVO);	

    	int totCnt = cmmntyservice.selectTabListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("menuType","auc");
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
    	return "gzonei/cmmnty/qnaAucList";
    }
    /**
     * 공매 페이지로 이동한다.
     */
    @RequestMapping(value="/cmmnty/qnaPblsalList.do")
    public String toanmchArticleList(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,Model model) throws SQLException , IOException {
    	
    	
    	EgovMap searchVO = new EgovMap();

    	PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        
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
			authInfo =  (EgovMap) auth.get("bbs008001");
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
//		페이징 정보
		String orderType = "frst_regist_pnttm";
		   if(request.getParameter("orderType") != null) {
		         orderType = request.getParameter("orderType");
		      }
		      
		      searchVO.put("orderType", orderType);
		      searchVO.put("delAt", request.getParameter("delAt"));
		      searchVO.put("dspyAt", request.getParameter("dspyAt"));
		      
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
      
//        searchVO.put("pageSize",boardVO.getPageSize());
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
        
    	searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("keyword", request.getParameter("keyword"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));

		searchVO.put("bbsId", "BBSMSTR_000000000007");
    	searchVO.put("seCode", "003");

    	//** 일반 게시물
    	List<?> resultList = cmmntyservice.selectTabArticleList(searchVO);	
    	
    	int totCnt = cmmntyservice.selectTabListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		model.addAttribute("menuType","amch");
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
    	return "gzonei/cmmnty/qnaPblsalList";
    }
    /**
     * 개발정보 관련 페이지로 이동한다.
     */
    @RequestMapping(value="/cmmnty/qnaDevinfoList.do")
    public String tosecsnArticleList(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,Model model) throws SQLException , IOException {
    	
    	
    	EgovMap searchVO = new EgovMap(); 
    	PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
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
			authInfo =  (EgovMap) auth.get("bbs008001");
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
//		페이징 정보
		String orderType = "frst_regist_pnttm";
		   if(request.getParameter("orderType") != null) {
		         orderType = request.getParameter("orderType");
		      }
		      
		      searchVO.put("orderType", orderType);
		      searchVO.put("delAt", request.getParameter("delAt"));
		      searchVO.put("dspyAt", request.getParameter("dspyAt"));
		      
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
      
//        searchVO.put("pageSize",boardVO.getPageSize());
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
        
    	searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("keyword", request.getParameter("keyword"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));

		searchVO.put("bbsId", "BBSMSTR_000000000007");
    	searchVO.put("seCode", "001");

    	//** 일반 게시물
    	List<?> resultList = cmmntyservice.selectTabArticleList(searchVO);	
    	
    	int totCnt = cmmntyservice.selectTabListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		model.addAttribute("menuType","dev");
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);
    	return "gzonei/cmmnty/qnaDevinfoList";
    }
    /**
     * 수정 페이지로 이동한다.
     */
    @RequestMapping(value="/cmmnty/qnaBbsUpdate.do")
    public String toupdateArticleList(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,Model model) throws SQLException , IOException {
        //페이지 접근 권한 설정-------
        EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
        EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
        EgovMap authInfo = new EgovMap();
        String accessAuth = "";
        String gradInfo = "";
        //반환 정보
        EgovMap redirectInfo = new EgovMap();
        //접근권한 
        String userId = request.getParameter("userId").toString();
        String orgId  = request.getParameter("frstRegisterId").toString();
        if(auth!=null) {
			authInfo =  (EgovMap) auth.get("bbs008001");
			accessAuth =  authInfo.get("infoUpdtAt").toString();
        }    	
    	//로그인 세션 검사
		if(session != null) {
			gradInfo =  session.get("indvdlMberCode").toString();
			if(!orgId.equals(userId) && !gradInfo.equals("CM00210003") && !accessAuth.equals("Y")) {
				redirectInfo.put("message", "수정 할 수 있는 권한이 없습니다.");
				redirect.addFlashAttribute("bbsredircetResult",redirectInfo);
				return "redirect:/main.do";
			}
		}else {
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}
		//---------
    	EgovMap searchVO = new EgovMap();
    	searchVO.put("nttId", request.getParameter("nttId"));
    	String atchFileId = fileUtilService.selectAtchFileId(searchVO);
		
		System.out.println("첨부파일 Id : "+ atchFileId);
		if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
    	EgovMap result = cmmntyservice.selectDetail(searchVO);
    	
    	String menuType = request.getParameter("menuType");
    	model.addAttribute("menuType", menuType);
    	
    	model.addAttribute("result",result);
    	return "gzonei/cmmnty/qnaBbsUpdate";
    }
    /**
     * @throws Exception 
     * 게시글 수정.
     * 
     * @param req
     * @param res
     * @return model
     * @throws 
     */
    @RequestMapping(value="/cmmnty/qnaBbsUdt.do")
    public String updateArticle(@RequestParam Map<String, Object> commandMap,MultipartHttpServletRequest multi,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
        
    	
    	
    	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	commandMap.replace("nttCn", nttcn);
    	String nttsj = ((String) commandMap.get("nttSj")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	commandMap.replace("nttSj", nttsj);
    	String nttId = request.getParameter("nttId");
    	String uploadDt = request.getParameter("uploadDt");
    	String[] fileAuthor = request.getParameterValues("fileAuthor");
    	String [] atchFileNm = request.getParameterValues("atchFileNm");
    	if(uploadDt == null || uploadDt == "") {
    		uploadDt = fileUtils.getDate();
    		System.out.println("date : "+uploadDt);
    	}
    	String atchFileId = request.getParameter("atchFileId");
    	System.out.println("수정전 :"+atchFileId);
    	atchFileId = fileUtils.insertFileInf(multi,"BBS_",atchFileId,atchFileNm,uploadDt,fileAuthor);
    	System.out.println("수정후 :"+atchFileId);
    	commandMap.put("atchFileId", atchFileId);
    	commandMap.put("nttId",nttId);
    	if(request.getParameter("dspyAt")!=null) { 		
    		String dspyAt = request.getParameter("dspyAt").toString();
    			if(dspyAt.toString().equals("Y")) {
    				commandMap.put("useAt", "Y");
    			}else {commandMap.put("useAt", "N");}	
    	}
    	int updatecheck = cmmntyservice.updateArticle(commandMap);
		if(updatecheck==1) {
			System.out.println("게시글 등록");
		}
		model.addAttribute("updatecheck",updatecheck);
    	return "redirect:/cmmnty/qnaBbsDetail.do?nttId="+nttId;
    }
    
    
    /**
	 * 게시판 댓글 등록하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/cmmnty/insertComment.do", method=RequestMethod.POST)
	@ResponseBody
	public void qnainsertComment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{


		EgovMap commentVO = new EgovMap();

		int nttId = Integer.parseInt(request.getParameter("nttId"));
		String bbsId = request.getParameter("bbsId");
		String answer = request.getParameter("answer");
		String frstRegisterId = request.getParameter("loginId");

		commentVO.put("nttId", nttId);
		commentVO.put("bbsId", bbsId);
		commentVO.put("answer", answer);
		commentVO.put("frstRegisterId", frstRegisterId);
		

		cmmntyservice.insertComment(commentVO);

	}
	

	/**
	 * 게시판 댓글 삭제하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/cmmnty/deleteComment.do", method=RequestMethod.POST)
	@ResponseBody
	public void qnadeleteComment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
		EgovMap commentVO = new EgovMap();

		int nttId = Integer.parseInt(request.getParameter("nttId"));
		int answerNo = Integer.parseInt(request.getParameter("answerNo"));

		commentVO.put("nttId", nttId);
		commentVO.put("answerNo", answerNo);
	
		cmmntyservice.deleteComment(commentVO);

	}
	
	/**
	 * 게시판 댓글 수정하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/cmmnty/updateComment.do", method=RequestMethod.POST)
	@ResponseBody
	public void qnaupdateComment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		EgovMap commentVO = new EgovMap();
		
		int nttId = Integer.parseInt(request.getParameter("nttId"));
		int answerNo = Integer.parseInt(request.getParameter("answerNo"));
		String answer = request.getParameter("answer");
	
		
		commentVO.put("nttId", nttId);
		commentVO.put("answerNo", answerNo);
		commentVO.put("answer", answer);
		
		cmmntyservice.updateComment(commentVO);
		
	}
}

