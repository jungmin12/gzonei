package gzonei.adisvc.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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
import gzonei.adisvc.service.RecsroomService;
import gzonei.str.service.StrService;
import gzonei.cmmn.service.FileUtilService;
import gzonei.cmmn.util.FileUtils;

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
public class RecsroomController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RecsroomController.class);
	
	@Resource(name = "RecsroomService")
	private RecsroomService recsroomService;
	
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
	@RequestMapping(value="/adisvc/recsroomBbsList.do")
	public String viewBbsList(@RequestParam(value="pageNo", required=false) String pageNo, RedirectAttributes redirect,
								HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		PaginationInfo paginationInfo = new PaginationInfo();
		EgovMap searchVO = new EgovMap();
		BoardVO boardVO = new BoardVO();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		if (null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}

		
		EgovMap redirectInfo = new EgovMap();

	      EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
	      if(session == null){
	         redirectInfo.put("message", "로그인 후 이용가능합니다.");
	         redirect.addFlashAttribute("redircetResult",redirectInfo);
	         return "redirect:/main.do"; 
	      }
		
		String indvdlMberCode = (String) loginVO.get("indvdlMberCode");
		searchVO.put("indvdlMberCode", indvdlMberCode);

		
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
		
		List<?> resultList = recsroomService.viewBbsList(searchVO);
		int totCnt = recsroomService.viewBbsListTotCnt(searchVO);
		int cmtCnt = recsroomService.selectBbsCommentCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		
		//결재업무 게시판 리스트 페이지 이동
		return "gzonei/adisvc/recsroomBbsList";
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
	@RequestMapping(value="/adisvc/recsroomBbsDetail.do")
	public String viewBbsDetail(@RequestParam(value="pageNo", required=false) String pageNo, HttpServletRequest request, 
									HttpServletResponse response, Model model,RedirectAttributes rttr) throws SQLException , IOException{
		
		
		EgovMap searchVO = new EgovMap();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
//		String a = "CM00209998";
		
		String bbsLv1 = "bbs009002";
		String bbsLv2 = "bbs009003";
		String bbsLv3 = "bbs009004";
		
		
//		String fileLv1 = "bbs009005";
//		String fileLv2 = "bbs009006";
//		String fileLv3 = "bbs009007";
//
//		System.out.println("읽기:" + authVO);
//		
//		
//		String aa = "CM00200001";
//		String ab = "CM00200002";
//		String ac = "CM00200003";
//		String ad = "CM00200004";
//		
//		String b = "CM00200005";
//		String c = "CM00200006";
//		String d = "CM00200007";
//		String e = "CM00200008";
//		String f = "CM00200009";
//		String g = "CM00200010";
//		String h = "CM00200011";
//		
//		ArrayList auth = new ArrayList();
//		
//		String readCode = "CM00209998";
//		readCode = request.getParameter("readngAuthorCode");
		
		String pageIndex = request.getParameter("pageIndex");
		
		// 무료 등급 다 읽기가능
//		if(readCode.equals(a) || readCode.equals("F")) {
//			System.out.println("읽기권한 무료");
//			auth.add(a);
//			auth.add(aa);
//			auth.add(ab);
//			auth.add(ac);
//			auth.add(ad);
//			auth.add(b);
//			auth.add(c);
//			auth.add(d);
//			auth.add(e);
//			auth.add(f);
//			auth.add(g);
//			auth.add(h);
//		}else if( readCode.equals(b) || readCode.equals(c) ) {
//			System.out.println("읽기권한 실버");
//			auth.add(aa);
//			auth.add(ab);
//			auth.add(ac);
//			auth.add(ad);
//			auth.add(b);
//			auth.add(c);
//			auth.add(d);
//			auth.add(e);
//			auth.add(f);
//			auth.add(g);
//			auth.add(h);
//		}else if( readCode.equals(d) || readCode.equals(e) || readCode.equals(f)) {
//			System.out.println("읽기권한 골드");
//			auth.add(aa);
//			auth.add(ab);
//			auth.add(ac);
//			auth.add(ad);
//			auth.add(d);
//			auth.add(e);
//			auth.add(f);
//			auth.add(g);
//			auth.add(h);
//		}else if( readCode.equals(g) || readCode.equals(h) || readCode.equals("P") ) {
//			System.out.println("읽기권한 프리미엄");
//			auth.add(ab);
//			auth.add(ad);
//			auth.add(g);
//			auth.add(h);
//		}
		
		String userCode = "";
		String mberCode = "";
		
		searchVO.put("orderType", request.getParameter("orderType"));
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		
		searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("keyword", request.getParameter("keyword"));
		
		
		if(loginVO != null) {
			userCode = (String) loginVO.get("gradCode");
			mberCode = (String) loginVO.get("indvdlMberCode");
		}

		System.out.println("gradCode "+ userCode);

		if(!userCode.equals("")) {

			
			int nttId = Integer.parseInt(request.getParameter("nttId"));
			searchVO.put("nttId", nttId);
			searchVO.put("pageIndex", pageIndex);
			
//			if(auth.contains(userCode) || mberCode.equals("CM00210003")) {
				String atchFileId = fileUtilService.selectAtchFileId(searchVO);
				if(!(atchFileId == "" || atchFileId == null)) {
					List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
					model.addAttribute("atchFileDetail", atchFileDetail);
				}
				
				System.out.println("권한 같음");
				recsroomService.updateViewBbsCount(searchVO);
				
				EgovMap resultList = recsroomService.viewBbsDetail(searchVO);
				List<?> commentList = recsroomService.selectBbsCommentList(searchVO);
				
				EgovMap test = (EgovMap) authVO.get(resultList.get("readngAuthorCode"));
				if("N".equals(test.get("menuAccesAt"))){
					System.out.println("권한 없음");
					rttr.addFlashAttribute("msg","1");
					
					return "redirect:/adisvc/recsroomBbsList.do?pageIndex="+pageIndex;
				}
				
				
				model.addAttribute("searchVO",searchVO);
				model.addAttribute("authVO",authVO);
				model.addAttribute("loginVO",loginVO);
				model.addAttribute("resultList",resultList);
				model.addAttribute("commentList",commentList);
				model.addAttribute("articleNum", request.getParameter("articleNum"));
				model.addAttribute("msg","0"); 

				
				return "gzonei/adisvc/recsroomBbsDetail";
	/*			
			}else {
				System.out.println("권한 다름");
				rttr.addFlashAttribute("msg","1");
				
				return "redirect:/adisvc/recsroomBbsList.do?pageIndex="+pageIndex;
			}
	*/	
		}else {
			System.out.println("로그인 안함");
			rttr.addFlashAttribute("msg","2");
			
			return "redirect:/adisvc/recsroomBbsList.do";
		}
		
		

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
	@RequestMapping(value="/adisvc/recsroomWriteBbs.do")
	public String insertBbs(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//결재업무 글 등록 페이지 이동
		EgovMap searchVO = new EgovMap();

		//사업지구 조회
		List<?> devInfoList = recsroomService.devInfoList(searchVO);
		model.addAttribute("devInfoList",devInfoList);

		return "gzonei/adisvc/recsroomBbsRegist";
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
	@RequestMapping(value="/adisvc/recsroomInsertBbs.do", method=RequestMethod.POST)
	public String insertBbsList(@RequestParam Map<String, Object> commandMap, MultipartHttpServletRequest multi, HttpServletRequest request,
								RedirectAttributes redirect, HttpServletResponse response, Model model) throws Exception{
	
		
		//결재업무 글 등록 페이지 이동
    	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	String detailSeCode = request.getParameter("detailSeCode");
    	
		EgovMap redirectInfo = new EgovMap();
    	EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	
		if(session == null){
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}
    	String date = fileUtils.getDate();
    	System.out.println("date : "+date);
    	String [] atchFileNm = request.getParameterValues("atchFileNm");
    	String [] fileAuthor = request.getParameterValues("fileAuthor");
    	// 첨부파일 아이디 가져오기
    	String atchFileId = fileUtils.insertFileInf(multi,"BBS_","",atchFileNm,date,fileAuthor);
    	
    	commandMap.put("atchFileId", atchFileId);
    	commandMap.put("detailSeCode", detailSeCode);
    	commandMap.replace("nttCn", nttcn);
    	recsroomService.insertBbs(commandMap);
		
		return "redirect:/adisvc/recsroomBbsList.do";
	}
	
	/**
     * 수정 페이지로 이동한다.
     */
    @RequestMapping(value="/adisvc/recsroomBbsUpdate.do")
    public String toupdateArticleList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
    	EgovMap searchVO = new EgovMap();
    	searchVO.put("nttId", Integer.parseInt(request.getParameter("nttId")));
    	String atchFileId = fileUtilService.selectAtchFileId(searchVO);
    	if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
		
    	EgovMap result = recsroomService.viewBbsDetail(searchVO);
    	model.addAttribute("result",result);

		//사업지구 조회
		List<?> devInfoList = recsroomService.devInfoList(searchVO);
		model.addAttribute("devInfoList",devInfoList);
		
		
    	return "gzonei/adisvc/recsroomBbsUpdate";
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
	@RequestMapping(value="/adisvc/recsroomUpdateBbs.do")
	public String updateBbs(@RequestParam Map<String, Object> commandMap, MultipartHttpServletRequest multi,
							HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	   	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	commandMap.replace("nttCn", nttcn);
    	
    	String nttId = request.getParameter("nttId");
    	String dwkNm = request.getParameter("dwkNm");
    	String frstRegistPnttm = request.getParameter("frstRegistPnttm");
    	String readngAuthorCode = request.getParameter("readngAuthorCode");

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
		commandMap.put("dwkNm", dwkNm);
		commandMap.put("frstRegistPnttm", frstRegistPnttm);
    	
		recsroomService.updateBbs(commandMap);
		
		return "redirect:/adisvc/recsroomBbsDetail.do?nttId="+nttId+"&readngAuthorCode="+readngAuthorCode;
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
	@RequestMapping(value="/adisvc/recsroomDeleteBbs.do")
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
		
		recsroomService.deleteBbs(commentVO);
		
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
	@RequestMapping(value="/adisvc/insertComment.do", method=RequestMethod.POST)
	public void insertComment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
		EgovMap commentVO = new EgovMap();

		int nttId = Integer.parseInt(request.getParameter("nttId"));
		String bbsId = request.getParameter("bbsId");
		String answer = request.getParameter("answer");
		String frstRegisterId = request.getParameter("loginId");

		commentVO.put("nttId", nttId);
		commentVO.put("bbsId", bbsId);
		commentVO.put("answer", answer);
		commentVO.put("frstRegisterId", frstRegisterId);

		recsroomService.insertComment(commentVO);

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
	@RequestMapping(value="/adisvc/deleteComment.do", method=RequestMethod.POST)
	@ResponseBody
	public void deleteComment(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
		EgovMap commentVO = new EgovMap();

		int nttId = Integer.parseInt(request.getParameter("nttId"));
		int answerNo = Integer.parseInt(request.getParameter("answerNo"));

		commentVO.put("nttId", nttId);
		commentVO.put("answerNo", answerNo);
	
		recsroomService.deleteComment(commentVO);

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
	@RequestMapping(value="/adisvc/updateComment.do", method=RequestMethod.POST)
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
		
		recsroomService.updateComment(commentVO);
		
	}

}
