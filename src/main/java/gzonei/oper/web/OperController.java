package gzonei.oper.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.FileUtilService;
import gzonei.cmmn.util.FileUtils;
import gzonei.oper.service.OperService;
import gzonei.str.service.StrService;

/**
* 
* 샘플 Controller
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
*  2021.01.26    김승제         		최초 생성
*  2021.03.05    김용명           		결재업무 게시판		
*  
*
*  </pre>
*/
@Controller
public class OperController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(OperController.class);
	
	/** SampleService */
	@Resource(name = "OperService")
	private OperService operService;
	
	@Resource(name="FileUtils")
	private FileUtils fileUtils;
	
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
	@Resource(name = "StrService")
	private StrService strservice;
	
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;
    
    @Autowired
    private DefaultBeanValidator beanValidator;
	
	/**
	 * 게시판 목록 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/viewBbsList.do")
	public String viewBbsList(@RequestParam(value="pageNo", required=false) String pageNo, RedirectAttributes redirect,
								HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		PaginationInfo paginationInfo = new PaginationInfo();
		EgovMap searchVO = new EgovMap();
		BoardVO boardVO = new BoardVO();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		
		if(loginVO.get("indvdlMberCode") != null) {
			String indvdlMberCode = (String) loginVO.get("indvdlMberCode");
			searchVO.put("indvdlMberCode", indvdlMberCode);
		}
		
		if (null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
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
			authInfo =  (EgovMap) auth.get("adm001001");
			accessAuth =  authInfo.get("menuAccesAt").toString();
        }    	
    	//로그인 세션 검사
		if(session != null) {
			author =  session.get("indvdlMberCode").toString();
			if(!accessAuth.equals("Y") ) {
					redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
					redirect.addFlashAttribute("redircetResult",redirectInfo);
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

		searchVO.put("firstIndex", paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex", paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		String orderType = "frst_regist_pnttm";
		
		if(request.getParameter("orderType") != null) {
			orderType = request.getParameter("orderType");
		}
		
		searchVO.put("orderType", orderType);
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		
		searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("keyword", request.getParameter("keyword"));
		
		List<?> resultList = operService.viewBbsList(searchVO);
		int totCnt = operService.viewBbsListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		
		//결재업무 게시판 리스트 페이지 이동
		return "gzonei/oper/sanctnBbsList";
	}
	
	/**
	 * 게시판 글 상세보기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/viewBbsDetail.do")
	public String viewBbsDetail(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();

		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String indvdlMberCode = (String) loginVO.get("indvdlMberCode");
		searchVO.put("indvdlMberCode", indvdlMberCode);
		
		EgovMap redirectInfo = new EgovMap();

		String author =(String) loginVO.get("indvdlMberCode");
		if(!"CM00210003".equals(author)) {
			redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}
		
		
		searchVO.put("orderType", request.getParameter("orderType"));
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		
		searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("keyword", request.getParameter("keyword"));
		
		
		int nttId = Integer.parseInt(request.getParameter("nttId"));
		searchVO.put("nttId", nttId);

		String atchFileId = fileUtilService.selectAtchFileId(searchVO);
		if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
		
		EgovMap resultList = operService.viewBbsDetail(searchVO);
		
		operService.updateViewBbsCount(searchVO);
		
		List<?> commentList = operService.selectBbsCommentList(searchVO);
		
		
		model.addAttribute("articleNum", request.getParameter("articleNum"));
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("commentList",commentList);
		
		//결재업무 글 상세보기 페이지 이동
		return "gzonei/oper/sanctnBbsDetail";
	}

	
	/**
	 * 게시판 글 등록 양식 이동
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/writeBbs.do")
	public String insertBbs(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//결재업무 글 등록 페이지 이동
		return "gzonei/oper/sanctnBbsRegist";
	}
	
	/**
	 * 게시판 글 등록하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/insertBbs.do", method=RequestMethod.POST)
	public String insertBbsList(@RequestParam Map<String, Object> commandMap, MultipartHttpServletRequest multi, 
								HttpServletResponse response, HttpServletRequest request, Model model) throws Exception{
		
		//결재업무 글 등록 페이지 이동
		String date = fileUtils.getDate();
		System.out.println("date : "+date);
		String [] atchFileNm = request.getParameterValues("atchFileNm");
		String [] fileAuthor = request.getParameterValues("fileAuthor");
		// 첨부파일 아이디 가져오기
		String atchFileId = fileUtils.insertFileInf(multi,"BBS_","",atchFileNm,date,fileAuthor);

    	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	
    	commandMap.put("atchFileId", atchFileId);
    	commandMap.replace("nttCn", nttcn);
		operService.insertBbs(commandMap);
		
		return "redirect:/oper/viewBbsList.do";
	}
	
	
	/**
     * 수정 페이지로 이동한다.
     */
    @RequestMapping(value="/oper/bbsUpdate.do")
    public String toupdateArticleList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
    	EgovMap searchVO = new EgovMap();
    	searchVO.put("nttId", Integer.parseInt(request.getParameter("nttId")));
    	String atchFileId = fileUtilService.selectAtchFileId(searchVO);
      	if(!(atchFileId == "" || atchFileId == null)) {
    			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
    			model.addAttribute("atchFileDetail", atchFileDetail);
    		}
      	
    	EgovMap result = operService.viewBbsDetail(searchVO);
    	model.addAttribute("result",result);
    	System.out.println(result);
    	
    	
    	return "gzonei/oper/sanctnBbsUpdate";
    }
	
	/**
	 * 게시글 수정하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/updateBbs.do")
	public String updateBbs(@RequestParam Map<String, Object> commandMap, MultipartHttpServletRequest multi, 
							HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	commandMap.replace("nttCn", nttcn);
    	
    	String nttId = request.getParameter("nttId");
    	
    	String uploadDt = request.getParameter("uploadDt");
    	String[] fileAuthor = request.getParameterValues("fileAuthor");
    	String [] atchFileNm = request.getParameterValues("atchFileNm");
    	if(uploadDt == null || uploadDt == "") {
    		uploadDt = fileUtils.getDate();
    		System.out.println("date : "+uploadDt);
    	}
    	String atchFileId = request.getParameter("atchFileId");
    	atchFileId = fileUtils.insertFileInf(multi,"BBS_",atchFileId,atchFileNm,uploadDt,fileAuthor);
		
		commandMap.put("atchFileId", atchFileId);
    		
    		
		operService.updateBbs(commandMap);
		
		return "redirect:/oper/viewBbsDetail.do?nttId="+nttId;
	}
	
	
	/**
	 * 게시글 삭제하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/deleteBbs.do")
	@ResponseBody
	public void deleteBbs(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		EgovMap commentVO = new EgovMap();
		EgovMap deleteVO = new EgovMap();
		
		deleteVO.put("atchFileId", request.getParameter("atchFileId"));
		deleteVO.put("useAt", "N");
		deleteVO.put("delAt", "Y");

		fileUtilService.deleteAtchFileAtrb(deleteVO);

		
		int nttId = Integer.parseInt(request.getParameter("nttId"));
		
		commentVO.put("nttId", nttId);
		
		operService.deleteBbs(commentVO);
		
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
	@RequestMapping(value="/oper/insertComment.do", method=RequestMethod.POST)
	@ResponseBody
	public void insertComment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
		EgovMap commentVO = new EgovMap();

		int nttId = Integer.parseInt(request.getParameter("nttId"));
		String answer = request.getParameter("answer");
		String frstRegisterId = request.getParameter("frstRegisterId");

		commentVO.put("nttId", nttId);
		commentVO.put("answer", answer);
		commentVO.put("frstRegisterId", frstRegisterId);

		operService.insertComment(commentVO);

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
	@RequestMapping(value="/oper/deleteComment.do", method=RequestMethod.POST)
	@ResponseBody
	public void deleteComment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
		EgovMap commentVO = new EgovMap();

		int nttId = Integer.parseInt(request.getParameter("nttId"));
		int answerNo = Integer.parseInt(request.getParameter("answerNo"));

		commentVO.put("nttId", nttId);
		commentVO.put("answerNo", answerNo);
	
		operService.deleteComment(commentVO);

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
	@RequestMapping(value="/oper/updateComment.do", method=RequestMethod.POST)
	@ResponseBody
	public void updateComment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		EgovMap commentVO = new EgovMap();
		
		int nttId = Integer.parseInt(request.getParameter("nttId"));
		int answerNo = Integer.parseInt(request.getParameter("answerNo"));
		String answer = request.getParameter("answer");
	
		
		commentVO.put("nttId", nttId);
		commentVO.put("answerNo", answerNo);
		commentVO.put("answer", answer);
		
		operService.updateComment(commentVO);
		
	}

}
