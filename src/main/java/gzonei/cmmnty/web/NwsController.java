package gzonei.cmmnty.web;

import java.io.IOException;
import java.sql.SQLException;
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
import org.springframework.web.bind.annotation.RequestParam;
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
 * 지식 게시판 게시물 관리를 위한 컨트롤러 클래스
 * @author 개발 3팀 안중원
 * @since 2021.03.15
 * @version 1.0
 *   
 *   수정일              수정자          수정내용
 *  ----------   -------   ---------------------------
 *  2021.03.15   안중원          최초 생성
 *
 *
 */
@Controller
public class NwsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SampleController.class);
	
	@Resource(name = "CmmntyService")
	private CmmntyService cmmntyservice;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertyService;
	
	@Resource(name = "FileUtils")
	private FileUtils fileUtils;
	
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
    /**
     * 보도자료 조회 및 검색한다.
     * @param req
     * @param res
     * @return model
     * @throws SQLException , IOException
     */ 
    @RequestMapping(value="/cmmnty/nwsBbsList.do")
    public String selectNwsList(RedirectAttributes redirect,HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
    	
    	EgovMap searchVO = new EgovMap(); 
    	PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
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
			authInfo =  (EgovMap) auth.get("bbs006001");
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
        
		String orderType = "articl_de";
	      
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
		searchVO.put("bbsId","BBSMSTR_000000000005" );
		
    	List<?> resultList = cmmntyservice.selectArticleList(searchVO);	
    	
		int totCnt = cmmntyservice.selectListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);

		return  "/gzonei/cmmnty/nwsBbsList";
    }
		 /**
	     * 게시물을 상세조회한다.
	     * @param req
	     * @param res
	     * @return model
		 * @throws Exception 
	     */
	    @RequestMapping(value="/cmmnty/nwsBbsDetail.do")
	    public String selectNwsArticleDetail(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
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
				authInfo =  (EgovMap) auth.get("bbs006001");
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
			List<?> newslist = cmmntyservice.selectNewsList(searchVO);
			String pageIndex = request.getParameter("pageIndex");
			if(pageIndex == null) {
				pageIndex = "1";
			}
			model.addAttribute("pageIndex", request.getParameter("pageIndex"));
			model.addAttribute("articleNum", request.getParameter("articleNum"));
			model.addAttribute("result",result);
			model.addAttribute("newslist",newslist);
			//model.addAttribute("commentList",commentList);
			
			return "/gzonei/cmmnty/nwsBbsDetail";
	    }
	    
	    /**
	     * 게시물을 삭제한다.
	     * @param req
	     * @param res
	     * @return model
	     * @throws Exception 
	     */
	    @RequestMapping(value="/cmmnty/nwsBbsDelete.do")
	    public String deleteNwsArticle(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
	        
	    	
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
			
	    	return "redirect:/cmmnty/nwsBbsList.do";
	    }
	    /**
	     * 게시물을 등록한다.
	     * @param req
	     * @param res
	     * @return model
	     * @throws Exception 
	     */
	    @RequestMapping(value="/cmmnty/nwsBbsRgst.do")
	    public String insertNwsArticle(@RequestParam Map<String, Object> commandMap,MultipartHttpServletRequest multi , HttpServletResponse response, HttpServletRequest request, Model model) throws Exception  {
	    	
	        
	    	
	    	String date = fileUtils.getDate();
	    	System.out.println("date : "+date);
	    	String [] atchFileNm = request.getParameterValues("atchFileNm");
	    	String [] fileAuthor = request.getParameterValues("fileAuthor");
	    	// 첨부파일 아이디 가져오기
	    	if(request.getParameter("dspyAt")!=null) { 		
	    		String dspyAt = request.getParameter("dspyAt").toString();
	    			if(dspyAt.toString().equals("Y")) {
	    				commandMap.put("useAt", "Y");
	    			}else {commandMap.put("useAt", "N");}	
	    	}
	    	String atchFileId = fileUtils.insertFileInf(multi,"BBS_","",atchFileNm,date,fileAuthor);
	    	commandMap.put("atchFileId", atchFileId);
	    	String nttsj = ((String) commandMap.get("nttSj")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
	    	commandMap.replace("nttSj", nttsj);
	    	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
	    	commandMap.replace("nttCn", nttcn);
	    	
	    	commandMap.put("atchFileId", atchFileId);
	    	int insertcheck  = cmmntyservice.insertArticle(commandMap);
	    	
	    	
			model.addAttribute("insertcheck",insertcheck);
	    	return "redirect:/cmmnty/nwsBbsList.do";
	    }
	    
	    /**
	     * 등록 페이지로 이동한다.
	     * @param req
	     * @param res
	     * @return model
	     * @throws SQLException , IOException
	     */
	    @RequestMapping(value="/cmmnty/nwsBbsRegist.do")
	    public String toinsertNwsArticleList(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,Model model) throws SQLException , IOException {
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
				authInfo =  (EgovMap) auth.get("bbs006001");
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
	    	return "/gzonei/cmmnty/nwsBbsRegist";
	    }
	    
	    
	    
	    /**
	     * 수정 페이지로 이동한다.	  
	     * @param req
	     * @param res
	     * @return model
	     * @throws SQLException , IOException
	     */
	    @RequestMapping(value="/cmmnty/nwsBbsUpdate.do")
	    public String toupdateNwsArticleList(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirect,Model model) throws SQLException , IOException {
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
				authInfo =  (EgovMap) auth.get("bbs006001");
				accessAuth =  authInfo.get("infoUpdtAt").toString();
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
	    	
	    	EgovMap searchVO = new EgovMap();
	    	searchVO.put("nttId", request.getParameter("nttId"));
	    	
	    	String atchFileId = fileUtilService.selectAtchFileId(searchVO);
			System.out.println("첨부파일 Id : "+ atchFileId);
			if(!(atchFileId == "" || atchFileId == null)) {
				List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
				model.addAttribute("atchFileDetail", atchFileDetail);
			}
			
	    	EgovMap result = cmmntyservice.selectDetail(searchVO);
	    	model.addAttribute("result",result);
	    	return "/gzonei/cmmnty/nwsBbsUpdate";
	    }
	    /**
	     * 게시글 수정.
	     * @param req
	     * @param res
	     * @return model
	     * @throws Exception 
	     */
	    @RequestMapping(value="/cmmnty/nwsBbsUdt.do")
	    public String updateNwswsArticle(@RequestParam Map<String, Object> commandMap,MultipartHttpServletRequest multi,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
	        
	    	
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
	    	int updatecheck= cmmntyservice.updateArticle(commandMap);
	    	model.addAttribute("updatecheck",updatecheck);
	    	return "redirect:/cmmnty/nwsBbsDetail.do?nttId="+nttId;
	    }
	}
