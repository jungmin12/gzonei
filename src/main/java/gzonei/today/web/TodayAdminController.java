package gzonei.today.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.today.service.TodayAdminService;


@Controller
public class TodayAdminController {

	/**TodayService*/
	@Resource(name="TodayAdminService")
	private TodayAdminService todayAdminService;
	
	/** CmmnService */
	@Resource(name = "cmmnService")
	private CmmnService cmmnService;
	
	/** 희진 */
	
	/**
	 * 오늘의 취재 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/today/prtnSttus.do")
	public String selectPrtnSttusList(@RequestParam Map<String, Object> commandMap,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
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
		
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		for (String mapkey : commandMap.keySet()){
	        searchVO.put(mapkey, commandMap.get(mapkey));
	    }

		if(null == request.getParameter("orderType") || "".equals(request.getParameter("orderType"))) {
			searchVO.put("orderType", "DESC");
		}

		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());

		List<?> resultList = todayAdminService.selectPrtnSttusList(searchVO);
		int totCnt = todayAdminService.selectPrtnSttusListTotCnt(searchVO);

		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "gzonei/admin/today/prtnSttusList";
	}
	
	/**
	 *  오늘의 취재 엑셀다운로드
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value="/admin/today/prtnSttusExcel.do", produces = "application/json; charset=utf8")
	public String selectMemberListExcel(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		Gson gson = new Gson();
		EgovMap searchVO = new EgovMap();
		for (String mapkey : commandMap.keySet()){
	        searchVO.put(mapkey, commandMap.get(mapkey));
	    }
		if(null == request.getParameter("orderType") || "".equals(request.getParameter("orderType"))) {
			searchVO.put("orderType", "DESC");
		}
		List<?> resultList = todayAdminService.selectPrtnSttusListExcel(searchVO);
		
		String json = gson.toJson(resultList);
		
		return json;	

	}
	
	/**
	 * 오늘의 취재 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/today/developGosi.do")
	public String selectDevelopGosiList(@RequestParam Map<String, Object> commandMap,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
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
		
		PaginationInfo paginationInfo = new PaginationInfo();
		BoardVO boardVO = new BoardVO();
		if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		for (String mapkey : commandMap.keySet()){
	        searchVO.put(mapkey, commandMap.get(mapkey));
	    }


		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());

		List<?> resultList = todayAdminService.selectDevelopGosiList(searchVO);
		int totCnt = todayAdminService.selectDevelopGosiListTotCnt(searchVO);

		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "gzonei/admin/today/developGosiList";
	}
	
	/** 다현*/
	/**
	 * 
	 * 오늘의정보(개발정보필수정보) 리스트조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param redirect
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="admin/today/reqDevelopInfo.do")
	public String todayDevelopInfo(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirect) throws SQLException , IOException{
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
		searchVO.put("searchKrwd", request.getParameter("searchKrwd"));
		searchVO.put("type", request.getParameterValues("type"));
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
		
		List<?> resultList = todayAdminService.selectTodayDevInfoList(searchVO);
		int totCnt = todayAdminService.selectTodayDevInfoTotCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt",totCnt);

		return "gzonei/admin/today/reqDevelopInfo";
	}
	
	/**
	 * 
	 * 오늘의정보(개발정보필수정보) 상세조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/today/selectReqDevInfo.do")
	public void selectReqDevInfo(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Gson gson = new Gson();
		String result = "";
		EgovMap searchVO = new EgovMap();
		
		
		searchVO.put("devlopInfoSn", request.getParameter("devlopInfoSn"));
		
		EgovMap resultVO = todayAdminService.selectReqDevInfo(searchVO);
		
	    result = gson.toJson(resultVO);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);			
		
	}
	
	@RequestMapping(value="/admin/today/udtDevlopInfo.do")
	public void udtDevlopInfo(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Map<String, Object> resultMap = new HashMap<>();
		Gson gson = new Gson();
		String resultList = "";
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("devlopInfoSn", request.getParameter("devlopInfoSn"));
		searchVO.put("bsnsBgnde", request.getParameter("bsnsBgnde"));
		searchVO.put("bsnsEndde", request.getParameter("bsnsEndde"));
		searchVO.put("dscssRewardBeginDe", request.getParameter("dscssRewardBeginDe"));
		searchVO.put("bsnsrcognNtfcDe", request.getParameter("bsnsrcognNtfcDe"));
		searchVO.put("wct", request.getParameter("wct"));
		searchVO.put("lct", request.getParameter("lct"));
//		if(request.getParameter("wct") != "" ) {
//			String wct = request.getParameter("wct").toString();
//			wct = wct.replace(",", "");	
//			int wct2 =Integer.parseInt(wct);
//			searchVO.put("wct", wct2);	
//		}
//		
//		if(request.getParameter("lct") != "") {
//			String lct = request.getParameter("lct").toString();
//			lct = lct.replace(",", "");	
//			int lct2 =Integer.parseInt(lct);
//			searchVO.put("lct", lct2);
//		}	
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		searchVO.put("lastUpdusrId", loginVO.get("id"));
		
		int resultCnt = todayAdminService.udtDevlopInfo(searchVO);
		
		resultMap.put("result", resultCnt);
		resultList = gson.toJson(resultMap);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(resultList);		
		
	}
	
	
}
