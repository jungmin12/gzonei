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
import gzonei.devlopInfo.service.DevlopInfoService;
import gzonei.sample.web.SampleController;

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
public class MmnwsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SampleController.class);
	
	@Resource(name = "CmmntyService")
	private CmmntyService cmmntyservice;
	
	@Resource(name = "DevlopInfoService")
	private DevlopInfoService devlopInfoService;
	
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
	@Resource(name = "FileUtils")
	private FileUtils fileUtils;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertyService;
    
    /**
     *  조회 및 검색한다.
     * @param req
     * @param res
     * @return model
     * @throws SQLException , IOException
     */ 
    @RequestMapping(value="/cmmnty/mmnwsBbsList.do")
    public String selectMmnwsList(RedirectAttributes redirect,HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
    	
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
			authInfo =  (EgovMap) auth.get("bbs005001");
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
		searchVO.put("blogId", request.getParameter("blogId"));
		searchVO.put("indvdlMberCode",gradInfo);
		searchVO.put("bbsId","BBSMSTR_000000000008" );
		
		if(request.getParameter("dwkNo") != null) {
			searchVO.put("dwkNm", (String)request.getParameter("dwkNm"));
			searchVO.put("blogId",request.getParameter("dwkNo"));
			List<?> resultList = devlopInfoService.selectMmnwsBbsListByDwkNm(searchVO);
			int totCnt = devlopInfoService.selectMmnwsBbsListByDwkNmCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("searchVO",searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("totCnt", totCnt);
			model.addAttribute("resultList",resultList);
			model.addAttribute("dwkNo",(String)request.getParameter("dwkNo"));
			model.addAttribute("dwkNm",(String)request.getParameter("dwkNm"));
			return  "/gzonei/cmmnty/mmnwsBbsList";
		}
		
    	List<?> resultList = cmmntyservice.selectArticleList(searchVO);	
    	
		int totCnt = cmmntyservice.selectListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",resultList);


		return  "/gzonei/cmmnty/mmnwsBbsList";
    }
		 /**
	     * 게시물을 상세조회한다.
	     * @param req
	     * @param res
	     * @return model
		 * @throws Exception 
	     */
	    @RequestMapping(value="/cmmnty/mmnwsBbsDetail.do")
	    public String selectMmnwsArticleDetail(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
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
				authInfo =  (EgovMap) auth.get("bbs005001");
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
			String pageIndex = request.getParameter("pageIndex");
			if(pageIndex == null) {
				pageIndex = "1";
			}
			model.addAttribute("pageIndex", request.getParameter("pageIndex"));
			model.addAttribute("articleNum", request.getParameter("articleNum"));
			model.addAttribute("result",result);
			//model.addAttribute("commentList",commentList);
			
			return "/gzonei/cmmnty/mmnwsBbsDetail";
	    }
	    
	    /**
	     * 게시물을 삭제한다.
	     * @param req
	     * @param res
	     * @return model
	     * @throws Exception 
	     */
	    @RequestMapping(value="/cmmnty/mmnwsBbsDelete.do")
	    public String deleteMmnwsArticle(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
	    	
	    	EgovMap deleteVO = new EgovMap();
			String atchFileId = request.getParameter("atchFileId");
			if(!(atchFileId == null || atchFileId == "")) {
				deleteVO.put("nttId", request.getParameter("nttId"));
				deleteVO.put("atchFileId", request.getParameter("atchFileId"));
				deleteVO.put("useAt", "N");
				deleteVO.put("delAt", "Y");
				fileUtilService.deleteAtchFileAtrb(deleteVO);			
			}
			
			deleteVO.put("nttId", request.getParameter("nttId"));
			int check = cmmntyservice.deleteArticle(deleteVO);
			
			System.out.println(check);
			
	    	return "redirect:/cmmnty/mmnwsBbsList.do";
	    }
	    /**
	     * 게시물을 등록한다.
	     * @param req
	     * @param res
	     * @return model
	     * @throws Exception 
	     */
	    @RequestMapping(value="/cmmnty/mmnwsBbsRgst.do")
	    public String insertMmnwsArticle(@RequestParam Map<String, Object> commandMap,MultipartHttpServletRequest multi, HttpServletRequest request,HttpServletResponse response, Model model) throws Exception  {
	    	
	    	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
	    	commandMap.replace("nttCn", nttcn);
	    	String nttsj = ((String) commandMap.get("nttSj")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
	    	commandMap.replace("nttSj", nttsj);
	    	String date = fileUtils.getDate();
	    	System.out.println("date : "+date);
	    	String [] atchFileNm = request.getParameterValues("atchFileNm");
	    	String [] fileAuthor = request.getParameterValues("fileAuthor");
	    	// 첨부파일 아이디 가져오기
	    	String atchFileId = fileUtils.insertFileInf(multi,"BBS_","",atchFileNm,date,fileAuthor);
	    	if(request.getParameter("dspyAt")!=null) { 		
	    		String dspyAt = request.getParameter("dspyAt").toString();
	    			if(dspyAt.toString().equals("Y")) {
	    				commandMap.put("useAt", "Y");
	    			}else {commandMap.put("useAt", "N");}	
	    	}
	    	String nsprcCode = request.getParameter("nsprcCode");
	    	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+nsprcCode);
	    	String nsprcNm= "";
	    	commandMap.put("atchFileId", atchFileId);
	    	commandMap.put("articlDe", request.getParameter("articlDe"));
	    	int insertcheck = 0;
	    	
	    	switch(nsprcCode) {
	    		case "CM00090002": nsprcNm = "디지털 조선"  ;commandMap.put("nsprcNm",nsprcNm); insertcheck= cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090003": nsprcNm = "재경일보"  ;commandMap.put("nsprcNm",nsprcNm);	 insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090004": nsprcNm = "한겨레 신문"  ;commandMap.put("nsprcNm",nsprcNm);	 insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090005": nsprcNm = "조선일보"  ;commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090006": nsprcNm = "중앙일보"  ;commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090007": nsprcNm = "경향신문"  ;commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090008": nsprcNm = "동아일보"  ;commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090009": nsprcNm = "SBS TV"  ;commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090010": nsprcNm = "KBS TV"  ;commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090011": nsprcNm = "YTN TV"  ;commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090012": nsprcNm = "MBC TV"  ;commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    		case "CM00090001": nsprcNm = request.getParameter("selboxDirect"); commandMap.put("nsprcNm",nsprcNm);insertcheck = cmmntyservice.insertArticle(commandMap);break;
	    	}
//	    	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+nsprcNm);
			model.addAttribute("insertcheck",insertcheck);
	    	return "redirect:/cmmnty/mmnwsBbsList.do";
	    }
	    
	    /**
	     * 등록 페이지로 이동한다.
	     * @param req
	     * @param res
	     * @return model
	     * @throws SQLException , IOException
	     */
	    @RequestMapping(value="/cmmnty/mmnwsBbsRegist.do")
	    public String toinsertMmnwsArticleList(HttpServletRequest request, RedirectAttributes redirect,HttpServletResponse response, Model model) throws SQLException , IOException {
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
				authInfo =  (EgovMap) auth.get("bbs005001");
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
			//---
	    	return "/gzonei/cmmnty/mmnwsBbsRegist";
	    }
	    
	    
	    
	    /**
	     * 수정 페이지로 이동한다.	  
	     * @param req
	     * @param res
	     * @return model
	     * @throws SQLException , IOException
	     */
	    @RequestMapping(value="/cmmnty/mmnwsBbsUpdate.do")
	    public String toupdateMmnwsArticleList(HttpServletRequest request, RedirectAttributes redirect,HttpServletResponse response, Model model) throws SQLException , IOException {
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
				authInfo =  (EgovMap) auth.get("bbs005001");
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
			//---
	    	EgovMap searchVO = new EgovMap();
	    	searchVO.put("nttId", request.getParameter("nttId"));
	         String atchFileId = fileUtilService.selectAtchFileId(searchVO);      
	          System.out.println("첨부파일 Id : "+ atchFileId);
	          if(!(atchFileId == "" || atchFileId == null)) {
	             List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
	             model.addAttribute("atchFileDetail", atchFileDetail);
	          }
	    	EgovMap result = cmmntyservice.selectDetail(searchVO);
	    	//개발사업정보 
	    	searchVO.put("dwkNo", result.get("blogId"));
	    	EgovMap devResult = devlopInfoService.selectDevInfoSnByDwkNo(searchVO);
	    	model.addAttribute("result",result);
	    	model.addAttribute("devResult",devResult);
	    	return "/gzonei/cmmnty/mmnwsBbsUpdate";
	    }
	    /**
	     * 게시글 수정.
	     * @param req
	     * @param res
	     * @return model
	     * @throws Exception 
	     */
	    @RequestMapping(value="/cmmnty/mmnwsBbsUdt.do")
	    public String updateCmmnwsArticle(@RequestParam Map<String, Object> commandMap,MultipartHttpServletRequest multi, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception  {
	    	
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
	    	
	    	String nsprcCode = request.getParameter("nsprcCode");
	    	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+nsprcCode);
	    	String nsprcNm= "";
	    	int updatecheck = 0;
	    	switch(nsprcCode) {
    		case "CM00090002": nsprcNm = "디지털 조선"  ;commandMap.replace("nsprcNm",nsprcNm); updatecheck= cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090003": nsprcNm = "재경일보"  ;commandMap.replace("nsprcNm",nsprcNm);	 updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090004": nsprcNm = "한겨레 신문"  ;commandMap.replace("nsprcNm",nsprcNm);	 updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090005":nsprcNm = "조선일보"  ;commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap); System.out.println("************"+nsprcNm);break;
    		case "CM00090006": nsprcNm = "중앙일보"  ;commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090007": nsprcNm = "경향신문"  ;commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090008": nsprcNm = "동아일보"  ;commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090009": nsprcNm = "SBS TV"  ;commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090010": nsprcNm = "KBS TV"  ;commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090011": nsprcNm = "YTN TV"  ;commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090012": nsprcNm = "MBC TV"  ;commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap);break;
    		case "CM00090001": nsprcNm = request.getParameter("selboxDirect"); commandMap.replace("nsprcNm",nsprcNm);updatecheck = cmmntyservice.updateArticle(commandMap);break;
    	}
			if(updatecheck==1) {
				System.out.println("게시글 등록");
			}
			model.addAttribute("updatecheck",updatecheck);
	    	return "redirect:/cmmnty/mmnwsBbsDetail.do?nttId="+nttId;
	    }
	}
