package gzonei.main.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmn.service.CmmnService;
import gzonei.devlopInfo.service.DevlopInfoService;
import gzonei.sample.service.FileUploadVO;
import gzonei.sample.service.SampleService;

/**
* 
* 메인 Controller
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
*  2021.03.17      김승제         		최초 생성
*  
*
*  </pre>
*/
@Controller
public class MainController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MainController.class);
	

	/** CmmnService */
	@Resource(name = "cmmnService")
	private CmmnService cmmnService;
	
	/** SampleService */
	@Resource(name = "DevlopInfoService")
	private DevlopInfoService devlopInfoService;
	
	/** SampleService */
	@Resource(name = "SampleService")
	private SampleService sampleService;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;
    
	/**
	 * 메인 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/main.do")
	public String selectMainPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		System.out.println("여기서 가져와야됨!");
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		/*
		 * 코드 목록 가져오기 List<?> 코드리스트변수명 = cmmnService.selectCodeList("테이블종류","상위코드");
		 * 테이블종류 : CMMN -> 공통코드 , PRODUCT -> 상품코드, AREA -> 행정구역코드
		 * */
		//
		List<?> dsList = cmmnService.selectDstrcCodeList();
		//List<?> dsList = cmmnService.selectCodeList("CMMN","DS01000000");
		List<?> area1List = cmmnService.selectCodeList("AREA","0000000000");
		List<?> area2List = cmmnService.selectCodeList("AREA","1100000000");
		List<?> cpList = cmmnService.selectCodeList("CMMN","CP01000000");
		
		// 게시판 탭 페이지 조회
		List<?> noticeTab = cmmnService.selectBbsList("NOTICE","BBSMSTR_000000000001");
		List<?> mmnwsTab = cmmnService.selectBbsList("MMNWS","BBSMSTR_000000000008");
		List<?> colmnTab = cmmnService.selectBbsList("COLMN","BBSMSTR_000000000009");
		List<?> nwsTab = cmmnService.selectBbsList("NWS","BBSMSTR_000000000005");
		List<?> rewardPrcdntTab = cmmnService.selectBbsList("REWARDPRCDNT","BBSMSTR_000000000006");
		List<?> qnaTab = cmmnService.selectBbsList("QNA","BBSMSTR_000000000007");
		List<?> focusTab = cmmnService.selectBbsList("FOCUS","BBSMSTR_000000000010");
		List<?> newsTab = cmmnService.selectBbsNewsList();
		
		//Update 개발정보
		List<?> updateDevNmList = cmmnService.selectUpdateDevNmList();
		
		//New 개발정보
		List<?> devTop = cmmnService.selectDevTop();
		EgovMap devCt = cmmnService.selectDevCt();
		
		
		//팝업 배너 조회
		List<?> topSlideList = cmmnService.selectBannerList("CM00330001");
		List<?> mainSlideList = cmmnService.selectBannerList("CM00330002");
		List<?> popSlideList = cmmnService.selectBannerList("CM00330003");
		//무로샘플 조회
		List<?> freeSample = cmmnService.selectFreeSample();
		model.addAttribute("freeSample",freeSample);
		model.addAttribute("noticeTab",noticeTab);
		model.addAttribute("mmnwsTab",mmnwsTab);
		model.addAttribute("colmnTab",colmnTab);
		model.addAttribute("nwsTab",nwsTab);
		model.addAttribute("rewardPrcdntTab",rewardPrcdntTab);
		model.addAttribute("qnaTab",qnaTab);
		model.addAttribute("focusTab",focusTab);
		model.addAttribute("newsTab",newsTab);
		
		model.addAttribute("dsList",dsList);
		model.addAttribute("area1List",area1List);
		model.addAttribute("area2List",area2List);
		model.addAttribute("cpList",cpList);
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("devTop",devTop);
		model.addAttribute("devCt",devCt);
		
		//팝업배너
		model.addAttribute("topSlideList",topSlideList);
		model.addAttribute("mainSlideList",mainSlideList);
		model.addAttribute("popSlideList",popSlideList);
		//Update된 개발정보명
		model.addAttribute("updateDevNmList",updateDevNmList);
		
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		if(null == loginVO) {
			loginVO = new EgovMap();
			loginVO.put("gradCode", "CM00200017");
			List<?> authVO = cmmnService.selectAuth(loginVO);
			EgovMap authVO2 = new EgovMap();
			String json = new Gson().toJson(authVO);
			List<EgovMap> a = (List<EgovMap>) authVO;
			
			for(int z = 0; z < a.size(); z++) {
				authVO2.put((String)a.get(z).get("authorCode"), a.get(z));
			}
			
			request.getSession().setAttribute("authVO", authVO2);
			request.getSession().setAttribute("authVO2", json);
		}
		
		
		//샘플 페이지 이동
		return "gzonei/main/main";
	}
	
	//페이지 붙여야함
		@RequestMapping(value="/map.do")
		public String selectMapPage(HttpServletRequest request, RedirectAttributes redirect, HttpServletResponse response, Model model) throws SQLException , IOException{
			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
			EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
			/*Map<String, Object> resultMap = new HashMap<>();
			Gson gson = new Gson();
			String resultList = "";*/
			
			if(null == loginVO) {
				EgovMap redirectInfo = new EgovMap();
				redirectInfo.put("message", "로그인 시 이용 가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do"; 
			}
			EgovMap searchVO = new EgovMap();
//			if(null != request.getParameter("lon")) {
//				searchVO.put("lon", request.getParameter("lon"));
//				searchVO.put("lat", request.getParameter("lat"));
//				searchVO.put("address", request.getParameter("address"));
//			}else {
//				searchVO.put("lon", "");
//				searchVO.put("lat", "");
//				searchVO.put("address", "");
//			}
			
			if(null!=request.getParameter("type")) {
				String type = String.valueOf(request.getParameter("type"));
				model.addAttribute("type",type);
			}
			if(null!=request.getParameter("devlopInfoSn")) {
				String devlopInfoSn = String.valueOf(request.getParameter("devlopInfoSn"));
				model.addAttribute("devlopInfoSn",devlopInfoSn);
				/*resultMap.put("devlopInfoSn", devlopInfoSn);
				resultList = gson.toJson(resultMap);*/
				
				/*response.setContentType("text/html; charset=UTF-8");
				response.setCharacterEncoding("utf-8");
				response.getWriter().write(resultList);	*/
			}
			if(null!=request.getParameter("tabId")) {
				String tabId = String.valueOf(request.getParameter("tabId"));
				model.addAttribute("tabId",tabId);
				/*resultMap.put("devlopInfoSn", devlopInfoSn);
				resultList = gson.toJson(resultMap);*/
				
				/*response.setContentType("text/html; charset=UTF-8");
				response.setCharacterEncoding("utf-8");
				response.getWriter().write(resultList);	*/
			}
			
			
			//지도 샘플 페이지 이동
			List<?> dsList = cmmnService.selectCodeList("CMMN","DS01000000");
			List<?> area1List = cmmnService.selectCodeList("AREA","0000000000");
			List<?> area2List = cmmnService.selectCodeList("AREA","1100000000");
			List<?> cpList = cmmnService.selectCodeList("CMMN","CP01000000");
			
			model.addAttribute("area1List",area1List);
			model.addAttribute("area2List",area2List);
			model.addAttribute("cpList",cpList);
			model.addAttribute("searchVO",searchVO);
			model.addAttribute("authVO",authVO);
			model.addAttribute("loginVO",loginVO);
			return "gzonei/main/map";
		}
		
		@RequestMapping(value="/selectLayer.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView selectLayer(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			EgovMap searchVO = new EgovMap();
//			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
//			if(loginVO != null) {
//				String gradCode = String.valueOf(loginVO.get("gradCode"));
//				searchVO.put("gradCode", gradCode);
//			}
			
			Enumeration<String> requestEnumKey = request.getParameterNames();
			while(requestEnumKey.hasMoreElements()) {
	        	String strKey = requestEnumKey.nextElement();
	            String strVal = request.getParameter(strKey);
	            searchVO.put(strKey, strVal);
	        }
			List<?> LayerList = cmmnService.selectLayer(searchVO);
			List<?> dsCodeList = devlopInfoService.selectDstrcCodeListAll();
			
			mv.addObject("LayerList",LayerList);
			mv.addObject("dsCodeList",dsCodeList);
			mv.setViewName("jsonView");
			return mv;
		}
	
		
		
	
}
