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
import org.springframework.web.servlet.ModelAndView;
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
import gzonei.oper.service.CodeManageService;
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
public class CodeManageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CodeManageController.class);
	
	/** SampleService */
	@Resource(name = "CodeManageService")
	private CodeManageService codeManageService;
	
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
	 * 코드 관리 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/codeManage.do")
	public String viewUpCode(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
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
		BoardVO boardVO = new BoardVO();
		
//		if (null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
//			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
//		}
//		
//		EgovMap redirectInfo = new EgovMap();
//
//	      EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
//	      if(session == null){
//	         redirectInfo.put("message", "로그인 후 이용가능합니다.");
//	         redirect.addFlashAttribute("redircetResult",redirectInfo);
//	         return "redirect:/main.do"; 
//	      }
//
//		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
//		
		searchVO.put("searchType", request.getParameter("searchType"));
//		
		List<?> upperCodeList = codeManageService.viewUpperCode(searchVO);
		List<?> codeList = codeManageService.viewCode(searchVO);
//		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("upperCodeList",upperCodeList);
		model.addAttribute("codeList",codeList);
		
		return "gzonei/oper/codeManageList";
	}
	
	
	

	/**
	 * 소분류 코드 관리 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/code.do", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView viewCode(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		
		String upperCode = request.getParameter("upperCode");
		searchVO.put("upperCode", upperCode);
		
		System.out.println("소분류조회할코드는" + upperCode);
		
		List<?> codeList = codeManageService.viewCode(searchVO);
		
		System.out.println(codeList);
		
		mv.addObject("codeList",codeList);
		mv.addObject("searchVO",searchVO);
		
		//샘플 페이지 이동
		mv.setViewName("jsonView"); return mv;
	}
	
	/**
	 * 대분류 코드 신규 등록하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/insertUpCd.do", method=RequestMethod.POST)
	public void insertUpCd(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
		EgovMap upCdVO = new EgovMap();

		String upCdNm = request.getParameter("upCdNm");
		String upCd = request.getParameter("upCd");
		String upCdDc = request.getParameter("upCdDc");
		String upCdUseAt = request.getParameter("upCdUseAt");
		String upCdDelAt = request.getParameter("upCdDelAt");
		
		
		if(upCdUseAt.equals("true")) {
			upCdUseAt = "Y";
		}else {
			upCdUseAt = "N";
		}
		
		
		if(upCdDelAt.equals("true")) {
			upCdDelAt = "Y";
		}else {
			upCdDelAt = "N";
		}
		

		upCdVO.put("upCdNm", upCdNm);
		upCdVO.put("upCd", upCd);
		upCdVO.put("upCdDc", upCdDc);
		upCdVO.put("upCdUseAt", upCdUseAt);
		upCdVO.put("upCdDelAt", upCdDelAt);

		codeManageService.insertUpCd(upCdVO);

	}
	
	
	/**
	 * 대분류 코드 수정하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/updateUpCd.do", method=RequestMethod.POST)
	public void updateUpCd(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		EgovMap upCdVO = new EgovMap();
		
		String upCdNm = request.getParameter("upCdNm");
		String upCd = request.getParameter("upCd");
		String upCdDc = request.getParameter("upCdDc");
		String upCdUseAt = request.getParameter("upCdUseAt");
		String upCdDelAt = request.getParameter("upCdDelAt");
		
		
		if(upCdUseAt.equals("true")) {
			upCdUseAt = "Y";
		}else {
			upCdUseAt = "N";
		}
		
		
		if(upCdDelAt.equals("true")) {
			upCdDelAt = "Y";
		}else {
			upCdDelAt = "N";
		}
		
		
		upCdVO.put("upCdNm", upCdNm);
		upCdVO.put("upCd", upCd);
		upCdVO.put("upCdDc", upCdDc);
		upCdVO.put("upCdUseAt", upCdUseAt);
		upCdVO.put("upCdDelAt", upCdDelAt);
		
		codeManageService.updateUpCd(upCdVO);
		
	}
	
	
	
	/**
	 * 소분류 코드 신규 등록
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/insertLwCd.do", method=RequestMethod.POST)
	public void insertLwCd(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
		EgovMap lwCdVO = new EgovMap();
		
		String upCd = request.getParameter("upCd");
		String lwCdNm = request.getParameter("lwCdNm");
		String lwCd = request.getParameter("lwCd");
		String lwCdDc = request.getParameter("lwCdDc");
		String lwCdUseAt = request.getParameter("lwCdUseAt");
		String lwCdDelAt = request.getParameter("lwCdDelAt");
		
		
		if(lwCdUseAt.equals("true")) {
			lwCdUseAt = "Y";
		}else {
			lwCdUseAt = "N";
		}
		
		
		if(lwCdDelAt.equals("true")) {
			lwCdDelAt = "Y";
		}else {
			lwCdDelAt = "N";
		}
		
		lwCdVO.put("upCd", upCd);
		lwCdVO.put("lwCdNm", lwCdNm);
		lwCdVO.put("lwCd", lwCd);
		lwCdVO.put("lwCdDc", lwCdDc);
		lwCdVO.put("lwCdUseAt", lwCdUseAt);
		lwCdVO.put("lwCdDelAt", lwCdDelAt);

		codeManageService.insertLwCd(lwCdVO);

	}
	
	
	
	/**
	 * 소뷴류 코드 수정하기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/oper/updateLwCd.do", method=RequestMethod.POST)
	public void updateLwCd(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
//		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		
		
		EgovMap lwCdVO = new EgovMap();

		String upCd = request.getParameter("upCd");
		String lwCdNm = request.getParameter("lwCdNm");
		String lwCd = request.getParameter("lwCd");
		String lwCdDc = request.getParameter("lwCdDc");
		String lwCdUseAt = request.getParameter("lwCdUseAt");
		String lwCdDelAt = request.getParameter("lwCdDelAt");
		
		
		
		if(lwCdUseAt.equals("true")) {
			lwCdUseAt = "Y";
		}else {
			lwCdUseAt = "N";
		}
		
		
		if(lwCdDelAt.equals("true")) {
			lwCdDelAt = "Y";
		}else {
			lwCdDelAt = "N";
		}

		lwCdVO.put("lwCdNm", lwCdNm);
		lwCdVO.put("upCd", upCd);
		lwCdVO.put("lwCd", lwCd);
		lwCdVO.put("lwCdDc", lwCdDc);
		lwCdVO.put("lwCdUseAt", lwCdUseAt);
		lwCdVO.put("lwCdDelAt", lwCdDelAt);
		
		codeManageService.updateLwCd(lwCdVO);
		
	}
	
	
}
