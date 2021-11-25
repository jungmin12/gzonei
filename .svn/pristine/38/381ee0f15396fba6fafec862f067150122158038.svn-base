package gzonei.reward.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.invt.web.InvtController;
import gzonei.reward.service.RewardService;

@Controller
public class RewardController {

	private static final Logger LOGGER = LoggerFactory.getLogger(InvtController.class);
	
	/** invtService */
	@Resource(name = "RewardService")
	private RewardService rewardService;
	
	 /** CmmnService */
    @Resource(name = "cmmnService")
    private CmmnService cmmnService;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;
    
    @RequestMapping(value="/reward/selectRewardAdmList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public ModelAndView selectinvtAdm(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
    	
    	ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
			String strKey = requestEnumKey.nextElement();
				String strVal = request.getParameter(strKey);
				searchVO.put(strKey, strVal);
		}
		
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		
		List<?> resultList = rewardService.selectRewardAdmList(searchVO);
		int totCnt = rewardService.selectRewardAdmListCnt(searchVO);
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		mv.addObject("area1List" ,area1List);
		mv.addObject("resultListTotCnt",totCnt);
		mv.addObject("resultList",resultList);
		mv.addObject("paginationInfo", paginationInfo);
		
		//샘플 페이지 이동
		mv.setViewName("jsonView"); return mv;
    }
    
	@RequestMapping(value="/reward/insertRewardDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView insertRewardDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = (String) loginVO.get("id");
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            if(strKey.equals("ar")||strKey.equals("pcpnttmIndvdlzPclnd")||strKey.equals("rewardCo")) {
            	
            	strVal = strVal.replace(",", "");
            }
            searchVO.put(strKey, strVal);
        }
		searchVO.put("userId", userId);		
		int insertResult = rewardService.insertRewardDetail(searchVO);
		searchVO.put("useAt", "Y");
		searchVO.put("delAt", "N");		
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("insertResult",insertResult);
		
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
	
	@RequestMapping(value="/reward/selectRewardDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectRewardDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		searchVO.put("rewardPrecedntSn",request.getParameter("rewardPrecedntSn"));
		EgovMap resultList = rewardService.selectRewardDetail(searchVO);
		
		//지역1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		List<?> prposList= cmmnService.selectCodeList("CMMN", "US00000000");
		mv.addObject("prposList" ,prposList);
		mv.addObject("area1List",area1List);
		mv.addObject("resultList",resultList);
		
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
	
	@RequestMapping(value="/reward/updateRewardDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView updateRewardDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = (String) loginVO.get("id");
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            if(strKey.equals("ar")||strKey.equals("pcpnttmIndvdlzPclnd")||strKey.equals("rewardCo")) {
            	
            	strVal = strVal.replace(",", "");
            }
            searchVO.put(strKey, strVal);
        }
		searchVO.put("userId", userId);		
		int updateResult = rewardService.updateRewardDetail(searchVO);
		
		mv.addObject("updateResult",updateResult);
		
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
	
	@RequestMapping(value="/reward/deleteRewardDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView deleteRewardDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = (String) loginVO.get("id");
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		searchVO.put("userId", userId);		
		int deleteResult = rewardService.deleteRewardDetail(searchVO);
		
		mv.addObject("deleteResult",deleteResult);
		
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
    
	@RequestMapping(value="/reward/selectInfoReward.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectInfoReward(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		List<?> resultList = rewardService.selectInfoReward(searchVO);
		
		mv.addObject("resultList",resultList);
		
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
}
