package gzonei.invt.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.http.util.TextUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.devlopInfo.service.DevlopInfoService;
import gzonei.invt.service.InvtService;

@Controller
public class InvtController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(InvtController.class);
	
	@Resource(name = "DevlopInfoService")
	private DevlopInfoService devlopInfoService;
	
	/** invtService */
	@Resource(name = "InvtService")
	private InvtService invtService;
	
	 /** CmmnService */
    @Resource(name = "cmmnService")
    private CmmnService cmmnService;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;
    
	// 투자정보 검색리스트 ajax
	@RequestMapping(value="/invt/selectInvtList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public ModelAndView selectinvtPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
        	if(strKey.equals("bsnsMthdCode")) {
        		String[] strVals  = request.getParameterValues(strKey);
        		if(strVals[0] == null ||strVals[0].equals("")) {
        			searchVO.put(strKey, null);
        		}else searchVO.put(strKey, strVals);
        	}else {
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        	}
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
		
		List<?> resultList = invtService.selectInvtList(searchVO);
		int totCnt = resultList.size();
//		int totCnt = invtService.selectInvtListCnt(searchVO);
		//지역1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		//사업지구코드
		List<?> dsCodeList = cmmnService.selectCodeList("CMMN", "DS01000000");
		//법원
		List<?> courtList= cmmnService.selectCodeList("CMMN", "CO01000000");
		//보상여부
		List<?> rewardList= cmmnService.selectCodeList("CMMN", "CM00160000");
		//지목용도
		List<?> prposList= cmmnService.selectCodeList("US", "US00000000");
		//진행결과코드 (진행내역)
		List<?> stusList= cmmnService.selectCodeList("CMMN", "CM00130000");
		for(int i=0; i<resultList.size(); i++) {
		String ss = String.valueOf(((ListOrderedMap) resultList.get(i)).get("apasmtAmount"));
		// 프리미엄 스페셜
		if(!ss.equals("null")) {
			Float ff = Float.valueOf(ss);
			if(ff> 100000000) {
				((ListOrderedMap) resultList.get(i)).put("special", "Y");
			}
		}
		// 완료 물건 처리
		ss= String.valueOf(((ListOrderedMap) resultList.get(i)).get("smpleInqireAt"));
		if(ss.equals("Y")) {
				((ListOrderedMap) resultList.get(i)).put("free", "Y");
			}
		else {((ListOrderedMap) resultList.get(i)).put("free", "N");}
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		mv.addObject("area1List" ,area1List);
		mv.addObject("dsCodeList" ,dsCodeList);
		mv.addObject("courtList" ,courtList);
		mv.addObject("rewardList" ,rewardList);
		mv.addObject("prposList" ,prposList);
		mv.addObject("stusList" ,stusList);
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultListTotCnt",totCnt);
		mv.addObject("resultList",resultList);
		mv.addObject("paginationInfo", paginationInfo);
		
		//샘플 페이지 이동
		mv.setViewName("jsonView"); return mv;
	}
	
	// 투자정보 관리자 검색리스트 ajax
	@RequestMapping(value="/invt/selectInvtAdmList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public ModelAndView selectinvtAdm(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
			String strKey = requestEnumKey.nextElement();
			String strVal = request.getParameter(strKey);
				if(strKey.equals("beginPnttm")) {
					strVal = strVal.replace("-","");
	        	}
				else if(strKey.equals("endPnttm")) {
					strVal = strVal.replace("-","");
				}
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
		
		List<?> resultList = invtService.selectInvtAdmList(searchVO);
		int totCnt = invtService.selectInvtAdmListCnt(searchVO);
		//지역1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		//법원
		List<?> courtList= cmmnService.selectCodeList("CMMN", "CO01000000");
		//지목용도
		List<?> prposList= cmmnService.selectCodeList("CMMN", "US00000000");
		for(int i=0; i<resultList.size(); i++) {
			//법원명
			String courtNm = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) resultList.get(i)).get("courtCode")));
			//경공매 구분
			String aucYN = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) resultList.get(i)).get("aucPblsalSeCode")));
			((ListOrderedMap) resultList.get(i)).put("courtNm", courtNm);
			((ListOrderedMap) resultList.get(i)).put("aucYN", aucYN);
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		mv.addObject("area1List" ,area1List);
		mv.addObject("courtList" ,courtList);
		mv.addObject("prposList" ,prposList);
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultListTotCnt",totCnt);
		mv.addObject("resultList",resultList);
		mv.addObject("paginationInfo", paginationInfo);
		
		//샘플 페이지 이동
		mv.setViewName("jsonView"); return mv;
	}
	
	// 투자정보 클릭 상세 ajax
	@RequestMapping(value="/invt/selectDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		searchVO.put("invtInfoSn",request.getParameter("invtInfoSn"));
		EgovMap resultList = invtService.selectInvtDetail(searchVO);
		
		//DwkNo로 개발사업가져오기
		searchVO.put("dwkNo", resultList.get("dwkNo"));
		EgovMap devList = devlopInfoService.selectDevInfoSnByDwkNo(searchVO);
		
		//지역1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		List<?> courtList= cmmnService.selectCodeList("CMMN", "CO01000000");
		List<?> prposList= cmmnService.selectCodeList("CMMN", "US00000000");
		List<?> proResList= cmmnService.selectCodeList("CMMN", "CM00130000");
		
		mv.addObject("proResList",proResList);
		mv.addObject("courtList" ,courtList);
		mv.addObject("prposList" ,prposList);
		mv.addObject("area1List",area1List);
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultList",resultList);
		mv.addObject("devList",devList);
		
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
	
	// 투자 정보 등록 ajax
		@RequestMapping(value="/invt/insertInvtDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView insertInvtDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			EgovMap searchVO = new EgovMap();
			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
			String userId = (String) loginVO.get("id");
			searchVO.put("userId", userId);	
			
			Enumeration<String> requestEnumKey = request.getParameterNames();
			while(requestEnumKey.hasMoreElements()) {
	        	String strKey = requestEnumKey.nextElement();
	            String strVal = request.getParameter(strKey);
	            searchVO.put(strKey, strVal);
	        }
			searchVO.put("useAt", "Y");
			searchVO.put("delAt", "N");
			searchVO.put("userId", userId);		
			int insertResult = invtService.insertInvDetail(searchVO);
			
			EgovMap insertInvtSn = invtService.insertInvSn();
			
//			mv.addObject("insertInvtSn",insertInvtSn);
			mv.addObject("searchVO",searchVO);
			mv.addObject("insertResult",insertResult);
			
			//상세보기
			mv.setViewName("jsonView"); return mv;
		}
		
		// 투자 정보 등록 중복체크 ajax
		@RequestMapping(value="/invt/selectInvtOverlap.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView selectInvtOverlap(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			EgovMap searchVO = new EgovMap();
			
			Enumeration<String> requestEnumKey = request.getParameterNames();
			while(requestEnumKey.hasMoreElements()) {
				String strKey = requestEnumKey.nextElement();
				String strVal = request.getParameter(strKey);
				searchVO.put(strKey, strVal);
			}
			int checkResult = invtService.selectInvtOverlap(searchVO);
			
			mv.addObject("checkResult",checkResult);
			//상세보기
			mv.setViewName("jsonView"); return mv;
		}
	
	// 투자 정보 삭제 ajax
		@RequestMapping(value="/invt/deleteInvtInfo.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView deleteInvtInfo(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			EgovMap searchVO = new EgovMap();
			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
			String userId = (String) loginVO.get("id");
			searchVO.put("userId", userId);		
			
			searchVO.put("invtInfoSn",request.getParameter("invtInfoSn"));
			int updateResult = invtService.deleteInvtInfoDetail(searchVO);
			
			mv.addObject("searchVO",searchVO);
			mv.addObject("resultList",updateResult);
			//상세보기
			mv.setViewName("jsonView"); return mv;
		}
		
		// 투자 정보 수정 ajax
		@RequestMapping(value="/invt/updateInvtInfo.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView updateInvtInfo(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			EgovMap searchVO = new EgovMap();
			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
			String userId = (String) loginVO.get("id");
			searchVO.put("userId", userId);	
			
			Enumeration<String> requestEnumKey = request.getParameterNames();
			while(requestEnumKey.hasMoreElements()) {
	        	String strKey = requestEnumKey.nextElement();
	            String strVal = request.getParameter(strKey);
	            searchVO.put(strKey, strVal);
	        }
			
			int resultList = invtService.updateInvtInfoDetail(searchVO);
			mv.addObject("searchVO",searchVO);
			mv.addObject("resultList",resultList);
			//상세보기
			mv.setViewName("jsonView"); return mv;
		}
		
		
	// 용도내역 목록조희 ajax
	@RequestMapping(value="/invt/selectUseList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectUseList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		Gson gson = new Gson();
		
		EgovMap searchVO = new EgovMap();
		searchVO.put("invtInfoSn",request.getParameter("invtInfoSn"));
		List<?>  resultList = invtService.selectUseList(searchVO);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultList",resultList);
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
	
	// 진행내역 목록조희 ajax
	@RequestMapping(value="/invt/selectProList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectProList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		
		EgovMap searchVO = new EgovMap();
		searchVO.put("invtInfoSn",request.getParameter("invtInfoSn"));
		List<?>  resultList = invtService.selectProList(searchVO);
		
		for(int i=0; i<resultList.size(); i++) {
			//법원명
			String courtNm = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) resultList.get(i)).get("courtCode")));
			//상태 (cmm_진행결과코드)
			String stusNm = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) resultList.get(i)).get("progrsResultCode")));
			((ListOrderedMap) resultList.get(i)).put("courtNm", courtNm);
			((ListOrderedMap) resultList.get(i)).put("stusNm", stusNm);
		}
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultList",resultList);
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
	
	// 진행내역 상세조회 ajax
	@RequestMapping(value="/invt/selectProDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectProDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("invtProgrsDtlsSn",request.getParameter("invtProgrsDtlsSn"));
		EgovMap resultList = invtService.selectProDetail(searchVO);
		
		List<?> proResList= cmmnService.selectCodeList("CMMN", "CM00130000");
		
		mv.addObject("proResList",proResList);
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultList",resultList);
		
		//상세보기
		mv.setViewName("jsonView"); return mv;
	}
	
		// 진행내역 수정 ajax
		@RequestMapping(value="/invt/updateProDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView updateProDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			EgovMap searchVO = new EgovMap();
			
			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
			String userId = (String) loginVO.get("id");
			searchVO.put("userId", userId);		
			
			Enumeration<String> requestEnumKey = request.getParameterNames();
			while(requestEnumKey.hasMoreElements()) {
				String strKey = requestEnumKey.nextElement();
				String strVal = request.getParameter(strKey);
				searchVO.put(strKey, strVal);
			}
			
			int updateResult = invtService.updateProInfoDetail(searchVO);
			
			mv.addObject("searchVO",searchVO);
			mv.addObject("updateResult",updateResult);
			
			//상세보기
			mv.setViewName("jsonView"); return mv;
		}
		
		// 진행내역 삭제 ajax
		@RequestMapping(value="/invt/deleteProDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView deleteProDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			EgovMap searchVO = new EgovMap();
			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
			String userId = (String) loginVO.get("id");
			searchVO.put("userId", userId);		
			
			if(request.getParameter("invtProgrsDtlsSnAD")!= null) {
			searchVO.put("invtProgrsDtlsSn",request.getParameter("invtProgrsDtlsSnAD"));
			}else {
			searchVO.put("invtProgrsDtlsSn",request.getParameter("invtProgrsDtlsSnPD"));
			}
			int updateResult = invtService.deleteProInfoDetail(searchVO);
			
			mv.addObject("searchVO",searchVO);
			mv.addObject("resultList",updateResult);
			//상세보기
			mv.setViewName("jsonView"); return mv;
		}
		
		// 진행내역 추가 ajax
		@RequestMapping(value="/invt/insertProDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView insertProDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			EgovMap searchVO = new EgovMap();
			EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
			String userId = (String) loginVO.get("id");
			searchVO.put("userId", userId);		
			Enumeration<String> requestEnumKey = request.getParameterNames();
			while(requestEnumKey.hasMoreElements()) {
				String strKey = requestEnumKey.nextElement();
				String strVal = request.getParameter(strKey);
				searchVO.put(strKey, strVal);
			}
			searchVO.put("useAt", "Y");
			searchVO.put("delAt", "N");
			
			int updateResult = invtService.insertProInfoDetail(searchVO);
			
			mv.addObject("searchVO",searchVO);
			mv.addObject("resultList",updateResult);
			//상세보기
			mv.setViewName("jsonView"); return mv;
		}
		
		// 2지역 찾기 ajax
		@RequestMapping(value="/invt/selectArea2List.ajax", method=RequestMethod.POST , produces = "application/text; charset=utf8")
		@ResponseBody
		public  ModelAndView selectArea2List(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
			ModelAndView mv = new ModelAndView();
			String legaldongCode = (String)request.getParameter("legaldongCode");
			List<?> area2List = cmmnService.selectCodeList("AREA",legaldongCode);
			
			mv.addObject("area2List",area2List);
			mv.setViewName("jsonView"); return mv;
		}
	
	
	
}
