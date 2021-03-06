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
import gzonei.adisvc.service.ReqestService;
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
public class ReqestController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ReqestController.class);
	
	@Resource(name = "ReqestService")
	private ReqestService reqestService;
	
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
	@RequestMapping(value="/adisvc/reqestBbsList.do")
	public String viewBbsList(@RequestParam(value="pageNo", required=false) String pageNo, RedirectAttributes redirect,
								HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		PaginationInfo paginationInfo = new PaginationInfo();
		EgovMap searchVO = new EgovMap();
		BoardVO boardVO = new BoardVO();
		
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
		searchVO.put("searchType", request.getParameter("searchType"));
		searchVO.put("orderType", orderType);
		searchVO.put("delAt", request.getParameter("delAt"));
		searchVO.put("dspyAt", request.getParameter("dspyAt"));
		searchVO.put("startDate", request.getParameter("startDate"));
		searchVO.put("endDate", request.getParameter("endDate"));
		searchVO.put("keyword", request.getParameter("keyword"));
		
		List<?> resultList = reqestService.viewBbsList(searchVO);
		int totCnt = reqestService.viewBbsListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		
		//결재업무 게시판 리스트 페이지 이동
		return "gzonei/adisvc/reqestBbsList";
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
	@RequestMapping(value="/adisvc/reqestBbsDetail.do")
	public String viewBbsDetail(@RequestParam(value="pageNo", required=false) String pageNo, HttpServletRequest request, 
									HttpServletResponse response, Model model,RedirectAttributes rttr) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		
		String a = "CM00209998";

		String aa = "CM00200001";
		String ab = "CM00200002";
		String ac = "CM00200003";
		String ad = "CM00200004";
		
		String b = "CM00200005";
		String c = "CM00200006";
		String d = "CM00200007";
		String e = "CM00200008";
		String f = "CM00200009";
		String g = "CM00200010";
		String h = "CM00200011";
		
		ArrayList auth = new ArrayList();
		
		String readCode = "CM00209998";
		readCode = request.getParameter("readngAuthorCode");
		
		// 무료 등급 다 읽기가능
		if(readCode.equals(a) || readCode.equals("P") || readCode.equals("F")) {
			System.out.println("읽기권한 무료");
			auth.add(a);
			auth.add(aa);
			auth.add(ab);
			auth.add(ac);
			auth.add(ad);
			auth.add(b);
			auth.add(c);
			auth.add(d);
			auth.add(e);
			auth.add(f);
			auth.add(g);
			auth.add(h);
		}else if( readCode.equals(b) || readCode.equals(c) ) {
			System.out.println("읽기권한 실버");
			auth.add(aa);
			auth.add(ab);
			auth.add(ac);
			auth.add(ad);
			auth.add(b);
			auth.add(c);
			auth.add(d);
			auth.add(e);
			auth.add(f);
			auth.add(g);
			auth.add(h);
		}else if( readCode.equals(d) || readCode.equals(e) || readCode.equals(f)) {
			System.out.println("읽기권한 골드");
			auth.add(aa);
			auth.add(ab);
			auth.add(ac);
			auth.add(ad);
			auth.add(d);
			auth.add(e);
			auth.add(f);
			auth.add(g);
			auth.add(h);
		}else if( readCode.equals(g) || readCode.equals(h)) {
			System.out.println("읽기권한 프리미엄");
			auth.add(ab);
			auth.add(ad);
			auth.add(g);
			auth.add(h);
		}
		
		String userCode = "";
		String mberCode = "";

		
		if(loginVO != null) {
			userCode = (String) loginVO.get("gradCode");
			mberCode = (String) loginVO.get("indvdlMberCode");
		}

		System.out.println("gradCode "+ userCode);

		if(!userCode.equals("")) {
		
			System.out.println("readCode"+readCode);
			System.out.println("auth "+auth);
			
			
			int nttId = Integer.parseInt(request.getParameter("nttId"));
			searchVO.put("nttId", nttId);
			
			if(auth.contains(userCode) || mberCode.equals("CM00210003")) {
				String atchFileId = fileUtilService.selectAtchFileId(searchVO);
				if(!(atchFileId == "" || atchFileId == null)) {
					List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
					model.addAttribute("atchFileDetail", atchFileDetail);
				}
				
				System.out.println("권한 같음");
				reqestService.updateViewBbsCount(searchVO);

				EgovMap resultList = reqestService.viewBbsDetail(searchVO);
				List<?> commentList = reqestService.selectBbsCommentList(searchVO);
				
				model.addAttribute("searchVO",searchVO);
				model.addAttribute("resultList",resultList);
				model.addAttribute("commentList",commentList);

				
				return "gzonei/adisvc/reqestBbsDetail";
				
			}else {
				System.out.println("권한 다름");
				rttr.addFlashAttribute("msg","1");
				
				return "redirect:/adisvc/reqestBbsList.do?pageNo="+pageNo;
			}
		
		}else {
			System.out.println("로그인 안함");
			rttr.addFlashAttribute("msg","2");
			
			return "redirect:/adisvc/reqestBbsList.do";
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
	@RequestMapping(value="/adisvc/reqestWriteBbs.do")
	public String insertBbs(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//결재업무 글 등록 페이지 이동
		return "gzonei/adisvc/reqestBbsRegist";
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
	@RequestMapping(value="/adisvc/reqestInsertBbs.do", method=RequestMethod.POST)
	public String insertBbsList(@RequestParam Map<String, Object> commandMap, MultipartHttpServletRequest multi, HttpServletRequest request,
								HttpServletResponse response, Model model) throws Exception{
		//결재업무 글 등록 페이지 이동
    	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	
    	String date = fileUtils.getDate();
    	System.out.println("date : "+date);
    	String [] atchFileNm = request.getParameterValues("atchFileNm");
    	String [] fileAuthor = request.getParameterValues("fileAuthor");
    	// 첨부파일 아이디 가져오기
    	String atchFileId = fileUtils.insertFileInf(multi,"BBS_","",atchFileNm,date,fileAuthor);
    	
    	commandMap.put("atchFileId", atchFileId);
    	commandMap.replace("nttCn", nttcn);
    	reqestService.insertBbs(commandMap);
		
		return "redirect:/adisvc/reqestBbsList.do";
	}
	
	/**
     * 수정 페이지로 이동한다.
     */
    @RequestMapping(value="/adisvc/reqestBbsUpdate.do")
    public String toupdateArticleList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
    	EgovMap searchVO = new EgovMap();
    	searchVO.put("nttId", Integer.parseInt(request.getParameter("nttId")));
    	String atchFileId = fileUtilService.selectAtchFileId(searchVO);
    	if(!(atchFileId == "" || atchFileId == null)) {
			List<?> atchFileDetail = fileUtilService.selectAtchFileDetail(atchFileId);
			model.addAttribute("atchFileDetail", atchFileDetail);
		}
		
    	EgovMap result = reqestService.viewBbsDetail(searchVO);
    	model.addAttribute("result",result);
    	
    	return "gzonei/adisvc/reqestBbsUpdate";
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
	@RequestMapping(value="/adisvc/reqestUpdateBbs.do")
	public String updateBbs(@RequestParam Map<String, Object> commandMap, MultipartHttpServletRequest multi,
							HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	   	String nttcn = ((String) commandMap.get("nttCn")).replace("&amp;","&").replace("&lt;","<").replace("&gt;",">").replace("&quot;", "\"");
    	commandMap.replace("nttCn", nttcn);
    	
    	String nttId = request.getParameter("nttId");
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
    	
		reqestService.updateBbs(commandMap);
		
		return "redirect:/adisvc/reqestBbsDetail.do?nttId="+nttId+"&readngAuthorCode="+readngAuthorCode;
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
	@RequestMapping(value="/adisvc/reqestDeleteBbs.do")
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
		
		reqestService.deleteBbs(commentVO);
		
	}
	
}
