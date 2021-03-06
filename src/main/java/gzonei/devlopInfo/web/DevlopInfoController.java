package gzonei.devlopInfo.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.ListOrderedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovBrowserUtil;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovBasicLogger;
import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.cmmn.util.FileUtils;
import gzonei.cmmnty.service.CmmntyService;
import gzonei.devlopInfo.service.DevlopInfoService;

/**
* 
* ?????? Controller
* @author PODO ??????3??? ?????????
* @since 2021.01.26
* @version 1.0
* @see
* ************ ?????? ????????????  ************ 
*
*
*
* <pre>
* << ????????????(Modification Information) >>
*
*   ?????????     	 	?????????          	????????????
*  -------    --------    ---------------------------
*  2021.01.26      ?????????         		?????? ??????
*  
*
*  </pre>
*/
@Controller
public class DevlopInfoController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DevlopInfoController.class);
	
	final String filePath = EgovProperties.getProperty("upload.files.develop.path");
	final String subFilePath = EgovProperties.getProperty("upload.files.develop_sub.path");
	final String imgPath = EgovProperties.getProperty("upload.images.develop.path");
	
	/** SampleService */
	@Resource(name = "DevlopInfoService")
	private DevlopInfoService devlopInfoService;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;
    
    /** CmmnService */
    @Resource(name = "cmmnService")
    private CmmnService cmmnService;
    
    @Resource(name = "CmmntyService")
	private CmmntyService cmmntyservice;
    
    //?????????????????? Egov ?????????
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
    
    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    
    @Resource(name = "multipartResolver")
    CommonsMultipartResolver multipartResolver;
    
	@Resource(name="FileUtils")
	private FileUtils fileUtils;
	/**
	 * ?????? ??????(???????????????) ?????????
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
    
    
    
    
    /*@RequestMapping(value="/devlopInfo/selectList.do")
	public String tcmColctListPage(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException,SQLException{
    	EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("textSearch") && !"".equals(request.getParameter("textSearch"))) {
			searchVO.put("textSearch", request.getParameter("textSearch"));
		}else {
			searchVO.put("textSearch", "");
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
		
		List<?> resultList = devlopInfoService.selectDevlopInfoList(searchVO);
		int totCnt = devlopInfoService.selectDevlopInfoListTotCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultListTotCnt",totCnt);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
    	
    	return "gzonei/devlopInfo/devlopInfoList";
	}*/
    
    /*//???????????? ??????
  	@RequestMapping(value="/devlopInfo/selectDetail.do")
  	public String tcmColctViewPage(HttpServletRequest request, HttpServletResponse response) throws IOException,SQLException{
  		return "gzonei/devlopInfo/devlopInfoDetail";
  	}*/
    @RequestMapping(value="/devlopInfo/selectDevInfoModalList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectDevInfoModalList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("textSearch") && !"".equals(request.getParameter("textSearch"))) {
			searchVO.put("textSearch", request.getParameter("textSearch"));
		}else {
			searchVO.put("textSearch", "");
		}
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
		if(null != request.getParameter("pageUnit") && !"".equals(request.getParameter("pageUnit"))) {
			boardVO.setPageUnit(Integer.parseInt(request.getParameter("pageUnit")));
		}
		if(null != request.getParameter("pageSize") && !"".equals(request.getParameter("pageSize"))) {
			boardVO.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		//
		//?????? ???????????? VO??? ??????
		List<?> resultList = devlopInfoService.selectDevlopInfoListModal(searchVO);
		int totCnt = devlopInfoService.selectDevlopInfoListModalTotCnt(searchVO);
		mv.addObject("resultList",resultList);
		paginationInfo.setTotalRecordCount(totCnt);
		mv.addObject("resultListTotCnt",totCnt);
		
		//??????1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		//??????????????????
		List<?> dsCodeListAll = devlopInfoService.selectDstrcCodeListAll();
		//?????????
		List<?> cpCodeList = cmmnService.selectCodeList("CMMN", "CP01000000");
		//????????????
		List<?> cmCodeList = cmmnService.selectCodeList("CMMN", "CM00160000");
		//??????????????????
		//List<EgovMap> rwYearList = yearMaker(devlopInfoService.selectDevInfoOldestRewardYr());
		
		mv.addObject("area1List" ,area1List);
		mv.addObject("dsCodeListAll",dsCodeListAll);
		mv.addObject("cpCodeList",cpCodeList);
		mv.addObject("cmCodeList",cmCodeList);
		//mv.addObject("rwYearList",rwYearList);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("paginationInfo", paginationInfo);
		
		//?????? ????????? ??????
		mv.setViewName("jsonView");
		return mv;
	}
    
	@RequestMapping(value="/devlopInfo/selectList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		
		
		
		if(null != request.getParameter("textSearch") && !"".equals(request.getParameter("textSearch"))) {
			searchVO.put("textSearch", request.getParameter("textSearch"));
		}else {
			searchVO.put("textSearch", "");
		}
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
		if(null != request.getParameter("pageUnit") && !"".equals(request.getParameter("pageUnit"))) {
			boardVO.setPageUnit(Integer.parseInt(request.getParameter("pageUnit")));
		}
		if(null != request.getParameter("pageSize") && !"".equals(request.getParameter("pageSize"))) {
			boardVO.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		//
		String value = request.getParameter("initVal");
		if(!String.valueOf(request.getParameter("initVal")).equals("init")) {
			//?????? ???????????? VO??? ??????
			String gradCode = String.valueOf(loginVO.get("gradCode"));
			searchVO.put("gradCode",gradCode);
			
			//?????? ????????? ???????????? ?????????
			EgovMap inputVO = new EgovMap();
			inputVO.put("applcGrad", gradCode);
			List<?> applcDstrcCodeList = devlopInfoService.selectDstrcCodeList(inputVO);
			mv.addObject("applcDstrcCodeList",applcDstrcCodeList);
			
			if(String.valueOf(request.getParameter("initVal")).equals("pageOnly")) {
				List<?> resultList = devlopInfoService.selectDevlopInfoList(searchVO);
				int totCnt = devlopInfoService.selectDevlopInfoListTotCnt(searchVO);
				mv.addObject("resultList",resultList);
				mv.addObject("resultListTotCnt",totCnt);
				paginationInfo.setTotalRecordCount(totCnt);
			}/*else if(String.valueOf(request.getParameter("initVal")).equals("topSearch")) {
				searchVO.put("textSearch",String.valueOf(request.getParameter("textSearch")));
				List<?> resultList = devlopInfoService.selectDevlopInfoList(searchVO);
				List<?> LayerList = devlopInfoService.selectDevlopInfoLayerList(searchVO);
				int totCnt = devlopInfoService.selectDevlopInfoListTotCnt(searchVO);
				mv.addObject("resultList",resultList);
				mv.addObject("LayerList",LayerList);
				mv.addObject("resultListTotCnt",totCnt);
				paginationInfo.setTotalRecordCount(totCnt);
			}*/else {
				if(request.getParameter("textSearch")!=null) {
					searchVO.put("textSearch",String.valueOf(request.getParameter("textSearch")));
				}
				List<?> resultList = devlopInfoService.selectDevlopInfoList(searchVO);
				int totCnt = devlopInfoService.selectDevlopInfoListTotCnt(searchVO);
				
				searchVO.put("applcDstrcCodeList", applcDstrcCodeList);
				List<?> LayerList = devlopInfoService.selectDevlopInfoLayerList(searchVO);
				
				mv.addObject("resultList",resultList);
				mv.addObject("LayerList",LayerList);
				
				mv.addObject("resultListTotCnt",totCnt);
				paginationInfo.setTotalRecordCount(totCnt);
			}
		}
		
		//??????1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		//??????????????????
		EgovMap inputVO = new EgovMap();
		inputVO.put("upperCodeId","DS00000000");
		inputVO.put("applcGrad","");
		List<?> dsCodeList = devlopInfoService.selectDstrcCodeList(inputVO);
		List<?> dsCodeListAll = devlopInfoService.selectDstrcCodeListAll();
		//?????????
		List<?> cpCodeList = cmmnService.selectCodeList("CMMN", "CP01000000");
		//????????????
		List<?> cmCodeList = cmmnService.selectCodeList("CMMN", "CM00160000");
		//??????????????? (????????????)
		List<?> courtList= cmmnService.selectCodeList("CMMN", "CO01000000");
		//??????????????????
		//List<EgovMap> rwYearList = yearMaker(devlopInfoService.selectDevInfoOldestRewardYr());
		
		mv.addObject("area1List" ,area1List);
		mv.addObject("dsCodeList",dsCodeList);
		mv.addObject("dsCodeListAll",dsCodeListAll);
		mv.addObject("cpCodeList",cpCodeList);
		mv.addObject("cmCodeList",cmCodeList);
		mv.addObject("courtList" ,courtList);
		//mv.addObject("rwYearList",rwYearList);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("authVO",authVO);
		mv.addObject("paginationInfo", paginationInfo);
			
		
		//?????? ????????? ??????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/selectSimpleList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectSimpleList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
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
		if(null != request.getParameter("pageUnit") && !"".equals(request.getParameter("pageUnit"))) {
			boardVO.setPageUnit(Integer.parseInt(request.getParameter("pageUnit")));
		}
		if(null != request.getParameter("pageSize") && !"".equals(request.getParameter("pageSize"))) {
			boardVO.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		
		List<?> resultList = devlopInfoService.selectSimpleDevlopInfoList(searchVO);
		
		int totCnt = devlopInfoService.selectSimpleDevlopInfoListTotCnt(searchVO);

		//??????1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		
		mv.addObject("area1List" ,area1List);
				
		paginationInfo.setTotalRecordCount(totCnt);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultListTotCnt",totCnt);
		mv.addObject("resultList",resultList);
		mv.addObject("paginationInfo", paginationInfo);
		
		//?????? ????????? ??????
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/selectAdminList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectAdminList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
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
		if(null != request.getParameter("pageUnit") && !"".equals(request.getParameter("pageUnit"))) {
			boardVO.setPageUnit(Integer.parseInt(request.getParameter("pageUnit")));
		}
		if(null != request.getParameter("pageSize") && !"".equals(request.getParameter("pageSize"))) {
			boardVO.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		}
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
		searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
		searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
		
		List<?> resultList = devlopInfoService.selectAdminList(searchVO);
		int totCnt = devlopInfoService.selectAdminListTotCnt(searchVO);
		
		//??????1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		mv.addObject("area1List" ,area1List);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultListTotCnt",totCnt);
		mv.addObject("resultList",resultList);
		mv.addObject("paginationInfo", paginationInfo);
		mv.addObject("authVO",authVO);
		//?????? ????????? ??????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/selectDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		String id = String.valueOf(loginVO.get("id"));
		String gradCode = String.valueOf(loginVO.get("gradCode"));
		String gradCodeNm = String.valueOf(loginVO.get("gradCodeNm"));
		EgovMap userVO = new EgovMap();
		userVO.put("userId",id);
		EgovMap userResult = devlopInfoService.selectUserPrintCntById(userVO);
		
		EgovMap searchVO = new EgovMap();
		searchVO.put("devlopInfoSn",request.getParameter("devlopInfoSn"));
		//searchVO.put("gradCode",gradCode);
		EgovMap resultList = devlopInfoService.selectDevlopInfoDetail(searchVO);
		
		//?????? ???????????? ?????? ?????????????????? ?????????
		searchVO.put("dwkNo",resultList.get("dwkNo"));
		EgovMap oldFileMap = devlopInfoService.selectOldFileList(searchVO);
		//???????????? ??????(?????? ????????? ??????????????? ??????)
		int InvtListCnt = devlopInfoService.selectInvtListCnt(searchVO);
		
		//??????1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		//?????????????????? (?????? ???????????? -> ??????????????? ??????)
		List<?> dsCodeList = devlopInfoService.selectDstrcCodeListAll();
		//?????????
		List<?> cpCodeList = cmmnService.selectCodeListAll("CP01");
		//????????????
		List<?> cmCodeList = cmmnService.selectCodeList("CMMN", "CM00160000");
		//????????????
		List<?> mtCodeList = cmmnService.selectCodeList("CMMN", "CM00150000");
		//?????????????????? ?????????
		List<?> mbCodeList = cmmnService.selectCodeList("GRAD",null);
		
		//????????? ?????? ?????????????????? ??????
		String dsChkVal = "false";
		EgovMap outPutMap = new EgovMap();
		for(int i=0;i<dsCodeList.size();i++) {
			EgovMap map = (EgovMap)dsCodeList.get(i);
			if(map.get("codeId").equals(resultList.get("bsnsDstrcCode"))) {
				outPutMap = map;
			}
		}
		if(String.valueOf(resultList.get("smpleInqireAt")).equals("Y")) {
			dsChkVal = "true";
		}else {
			if(String.valueOf(outPutMap.get("applcGrad")).contains(gradCode)) {
				dsChkVal = "true";
			}
		}
		
		//?????? ?????? > ????????? ??????
		EgovMap vo = new EgovMap();
		vo.put("id", id);
		vo.put("menu", "DEV");
		vo.put("iem", resultList.get("dwkNo"));
		cmmnService.insertBbscttLog(vo);
		
		EgovMap pathMap = new EgovMap();
		pathMap.put("devlopFilePath",filePath);
		pathMap.put("devlopSubFilePath",subFilePath);
		pathMap.put("devlopImagePath",imgPath);
		mv.addObject("pathMap",pathMap);
				
		mv.addObject("area1List",area1List);
		mv.addObject("dsCodeList",dsCodeList);
		mv.addObject("cpCodeList",cpCodeList);
		mv.addObject("mtCodeList",mtCodeList);
		mv.addObject("cmCodeList",cmCodeList);
		mv.addObject("mbCodeList",mbCodeList);
		
		mv.addObject("gradCode",gradCode);
		mv.addObject("gradCodeNm",gradCodeNm);
		mv.addObject("dsChkVal",dsChkVal);
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultList",resultList);
		
		mv.addObject("oldFileMap",oldFileMap);
		mv.addObject("authVO",authVO);
		mv.addObject("userResult",userResult);
		//???????????? ??????
		mv.addObject("InvtListCnt",InvtListCnt);
		//mv.addObject("oldFileListRs",oldFileListRs);

		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/showDevInfoInsert.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView showDevInfoInsert(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		//??????1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		//??????????????????
		List<?> dsCodeListAll = devlopInfoService.selectDstrcCodeListAll();
		//List<?> dsCodeList= devlopInfoService.selectDstrcCodeList()("CMMN", "DS00000000");
		//?????????
		List<?> cpCodeList = cmmnService.selectCodeList("CMMN", "CP01000000");
		//????????????
		List<?> cmCodeList = cmmnService.selectCodeList("CMMN", "CM00160000");
		//????????????
		List<?> mtCodeList = cmmnService.selectCodeList("CMMN", "CM00150000");
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("area1List",area1List);
		mv.addObject("dsCodeListAll",dsCodeListAll);
		//mv.addObject("dsCodeList",dsCodeList);
		mv.addObject("cpCodeList",cpCodeList);
		mv.addObject("cmCodeList",cmCodeList);
		mv.addObject("mtCodeList",mtCodeList);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/insertDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView insertDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		String userId = (String) loginVO.get("id");
		
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		String date = fileUtils.getDate();
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
			String strKey = requestEnumKey.nextElement();
			String strVal = request.getParameter(strKey);
			searchVO.put(strKey, strVal);
		}
		searchVO.put("useAt", "Y");
		searchVO.put("indvdlMberRegistAt", "N");
		searchVO.put("delAt", "N");
		searchVO.put("userId", userId);
		
		int insertResult = devlopInfoService.insertDevlopInfoDetail(searchVO);
		EgovMap resultMap = devlopInfoService.selectDevInfoSnByDwkNo(searchVO);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("insertResult",insertResult);
		mv.addObject("resultMap",resultMap);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	/*@RequestMapping(value="/devlopInfo/insertDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView insertDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		
		EgovMap searchVO = new EgovMap();
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		searchVO.put("useAt", "Y");
		searchVO.put("delAt", "N");		
		int insertResult = devlopInfoService.insertDevlopInfoDetail(searchVO);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("insertResult",insertResult);
		
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}*/
	
	@RequestMapping(value="/devlopInfo/updateDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView updateDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		String userId = (String) loginVO.get("id");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		searchVO.put("userId",userId);		
		int updateResult = devlopInfoService.updateDevlopInfoDetail(searchVO);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("updateResult",updateResult);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/deleteDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView deleteDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		String userId = (String) loginVO.get("id");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		searchVO.put("devlopInfoSn",request.getParameter("devlopInfoSn"));
		searchVO.put("userId",userId);		
		searchVO.put("useAt", "N");
		searchVO.put("delAt", "Y");
		int updateResult = devlopInfoService.deleteDevlopInfoDetail(searchVO);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("updateResult",updateResult);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/selectPrtnList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectPrtnList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
			
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		//searchVO.put("devlopInfoSn",request.getParameter("devlopInfoSn"));
		
		List<?> resultList = devlopInfoService.selectPrtnDevlopInfoList(searchVO);
		
		/*FileVO fvo = new FileVO();
		List<FileVO> fileList = new ArrayList();
		for(int i=0;i<resultList.size();i++) {
			resultList.get(i);
			fvo.setAtchFileId();
			FileVO file = fileMngService.selectFileInf(fvo);
			fileList.add(file);
		}*/
		//fvo.setAtchFileId((String)resultList.get("atchFileId"));
		//????????????
		List<?> seCodeList = cmmnService.selectCodeList("CMMN", "CM00170000");
		List<?> clCodeList = cmmnService.selectCodeList("CMMN", "CM00340000");
		
		
		EgovMap pathMap = new EgovMap();
		pathMap.put("devlopFilePath",filePath);
		pathMap.put("devlopSubFilePath",subFilePath);
		pathMap.put("devlopImagePath",imgPath);
		mv.addObject("pathMap",pathMap);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("seCodeList",seCodeList);
		mv.addObject("clCodeList",clCodeList);
		mv.addObject("resultList",resultList);
		//mv.addObject("fileList",fileList);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/showPrtnInsrt.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView showPrtnInsrt(HttpServletRequest request, HttpServletResponse response) throws Exception{
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
			
		//???????????? ??????
		List<?> seCodeList = cmmnService.selectCodeList("CMMN", "CM00170000");
		//???????????? ????????????
		List<?> clCodeList = cmmnService.selectCodeList("CMMN", "CM00340000");
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("seCodeList",seCodeList);
		mv.addObject("clCodeList",clCodeList);
		//mv.addObject("fileList",fileList);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/selectPrtnDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectPrtnDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
			
		searchVO.put("bsnsPrtnSttusSn",request.getParameter("bsnsPrtnSttusSn"));
		EgovMap resultList = devlopInfoService.selectPrtnDevlopInfoDetail(searchVO);
		
		/*FileVO fvo = new FileVO();
		fvo.setAtchFileId((String)resultList.get("atchFileId"));
		List<?> fileList = fileMngService.selectFileInfs(fvo);*/
		//???????????? ??????
		List<?> seCodeList = cmmnService.selectCodeList("CMMN", "CM00170000");
		//???????????? ????????????
		List<?> clCodeList = cmmnService.selectCodeList("CMMN", "CM00340000");
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("resultList",resultList);
		mv.addObject("seCodeList",seCodeList);
		mv.addObject("clCodeList",clCodeList);
		//mv.addObject("fileList",fileList);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/insertPrtnDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf-8")
	@ResponseBody
	public  ModelAndView insertPrtnDetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		String userId = (String) loginVO.get("id");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		searchVO.put("useAt", "Y");
		searchVO.put("delAt", "N");
		searchVO.put("userId",userId);
		int updateResult = devlopInfoService.insertPrtnDevlopInfoDetail(searchVO);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("updateResult",updateResult);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
/*	@RequestMapping(value="/devlopInfo/fileUpload.do", method=RequestMethod.POST , produces = "application/text; charset=utf-8")
	@ResponseBody
	public  ModelAndView fileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multi) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		EgovMap searchVO = new EgovMap();
		//????????????
		List<FileVO> result = null;
		String atchFileId = "";
		
		//???????????? ?????????
		final Map<String, MultipartFile> files = multi.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
			searchVO.put("atchFileId", atchFileId);
		}
		mv.addObject("searchVO",searchVO);
		mv.addObject("atchFileId",atchFileId);
		
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
*/	
	@RequestMapping(value="/devlopInfo/fileUpload.do", method=RequestMethod.POST , produces = "application/text; charset=utf-8")
	@ResponseBody
	public  ModelAndView fileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multi) throws Exception{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		//????????????
		String atchFileId = "";
		if(null!=request.getParameter("atchFileId") && !request.getParameter("atchFileId").equals("old") && !request.getParameter("atchFileId").equals("")) {
			atchFileId = request.getParameter("atchFileId");
		}
		String resultAtchFileId = "";
		String date = fileUtils.getDate();
		String [] atchFileNm = request.getParameterValues("atchFileNm");
    	String [] fileAuthor = request.getParameterValues("fileAuthor");
		//???????????? ?????????
    	resultAtchFileId = fileUtils.insertDevFileInf(multi,"BBS_",atchFileId,atchFileNm,date,fileAuthor);
		//searchVO.put("atchFileId", resultAtchFileId);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("atchFileId",resultAtchFileId);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/thumbFileUpload.do", method=RequestMethod.POST , produces = "application/text; charset=utf-8")
	@ResponseBody
	public  ModelAndView thumbFileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multi) throws Exception{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		//????????????
		String atchFileId = "";
		String thumbFileNm = "";
		if(null!=request.getParameter("thumbFileId") && !request.getParameter("thumbFileId").equals("old") && !request.getParameter("thumbFileId").equals("")) {
			atchFileId = request.getParameter("thumbFileId");
		}
		if(null!=request.getParameter("thumbFileNm") && !request.getParameter("thumbFileNm").equals("")) {
			thumbFileNm = request.getParameter("thumbFileNm");
		}
		
		String date = fileUtils.getDate();
		String[] atchFileNm = new String[1];
		atchFileNm[0] = thumbFileNm;
    	String [] fileAuthor = new String[1];
    	fileAuthor[0] = "CM00200010";
    	
		//???????????? ?????????
    	String resultThumbFileId = fileUtils.insertThumbFileInf(multi,"BBS_",atchFileId,atchFileNm,date,fileAuthor);
		//searchVO.put("atchFileId", resultAtchFileId);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("thumbFileId",resultThumbFileId);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/oldFileUpload.do", method=RequestMethod.POST , produces = "application/text; charset=utf-8")
	@ResponseBody
	public  ModelAndView oldFileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multi) throws Exception{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = String.valueOf(loginVO.get("id"));
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		//????????????
		String dwkNo = "";
		if(null!=request.getParameter("dwkNo") && !request.getParameter("dwkNo").equals("")) {
			dwkNo = request.getParameter("dwkNo");
		}
		String date = fileUtils.getDate();
		String [] atchFileNm = request.getParameterValues("atchFileNm");
    	devlopInfoService.insertOldFileInf(multi,"BBS_",dwkNo,atchFileNm,date,userId, "atch");
		
		mv.addObject("searchVO",searchVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/oldThumbFileUpload.do", method=RequestMethod.POST , produces = "application/text; charset=utf-8")
	@ResponseBody
	public  ModelAndView oldThumbFileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multi) throws Exception{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = String.valueOf(loginVO.get("id"));
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		//????????????
		String dwkNo = "";
		String thumbFileNm = "";
		if(null!=request.getParameter("dwkNo") && !request.getParameter("dwkNo").equals("")) {
			dwkNo = request.getParameter("dwkNo");
		}
		if(null!=request.getParameter("thumbFileNm") && !request.getParameter("thumbFileNm").equals("")) {
			thumbFileNm = request.getParameter("thumbFileNm");
		}
		String date = fileUtils.getDate();
		String[] atchFileNm = new String[1];
		atchFileNm[0] = thumbFileNm;
		
		devlopInfoService.insertOldThumbFileInf(multi,"BBS_",dwkNo,atchFileNm,date,userId, "thumb");
		
		mv.addObject("searchVO",searchVO);
		//mv.addObject("thumbFileId",resultThumbFileId);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/oldPrtnFileUpload.do", method=RequestMethod.POST , produces = "application/text; charset=utf-8")
	@ResponseBody
	public  ModelAndView oldPrtnFileUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multi) throws Exception{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = String.valueOf(loginVO.get("id"));
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		//????????????
		String prtnSn = "";
		if(null!=request.getParameter("bsnsPrtnSttusSn") && !request.getParameter("bsnsPrtnSttusSn").equals("")) {
			prtnSn = request.getParameter("bsnsPrtnSttusSn");
		}
		String date = fileUtils.getDate();
		String [] atchFileNm = request.getParameterValues("atchFileNm");
    	devlopInfoService.insertPrtnOldFileInf(multi,"BBS_",prtnSn,atchFileNm,date,userId);
		
		mv.addObject("searchVO",searchVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/devlopInfo/selectFiles.do", method=RequestMethod.POST , produces = "application/text; charset=utf-8")
	@ResponseBody
	public  ModelAndView selectFiles(HttpServletRequest request, HttpServletResponse response) throws Exception{
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		//????????????
		if(null!=request.getParameter("atchFileId") && !request.getParameter("atchFileId").equals("")) {
			searchVO.put("atchFileId", (String)request.getParameter("atchFileId"));
		}else if(null!=request.getParameter("thumbFileId") && !request.getParameter("thumbFileId").equals("")){
			searchVO.put("thumbFileId", (String)request.getParameter("thumbFileId"));
		}else {
			System.out.println("atchFileId, thumbFileId ????????????");
		}
		searchVO.put("tableNm", (String)request.getParameter("tableNm"));
		List<EgovMap> atchFiles = new ArrayList<EgovMap>();
		if(!searchVO.containsKey("atchFileId") && !searchVO.containsKey("thumbFileId")) {
			atchFiles = null;
		}else {
			atchFiles = (List<EgovMap>) devlopInfoService.selectNewFileList(searchVO);
		}
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("atchFiles",atchFiles);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/updatePrtnDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView updatePrtnDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		String userId = (String) loginVO.get("id");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		searchVO.put("userId",userId);
		int updateResult = devlopInfoService.updatePrtnDevlopInfoDetail(searchVO);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("updateResult",updateResult);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/deletePrtnDetail.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView deletePrtnDetail(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		String userId = (String) loginVO.get("id");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		searchVO.put("bsnsPrtnSttusSn",request.getParameter("bsnsPrtnSttusSn"));
		searchVO.put("useAt", "N");
		searchVO.put("delAt", "Y");
		searchVO.put("userId",userId);
		int updateResult = devlopInfoService.deletePrtnDevlopInfoDetail(searchVO);
		
		mv.addObject("searchVO",searchVO);
		mv.addObject("updateResult",updateResult);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");return mv;
	}
	
	@RequestMapping(value="/devlopInfo/selectCodeList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public ModelAndView selectCodeList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		ModelAndView mv = new ModelAndView();
		
		String codeKey = String.valueOf(request.getParameter("codeKey"));
		String codeVal = String.valueOf(request.getParameter("codeVal"));
		EgovMap inputVO = new EgovMap();
			
		List<?> codeList = null;
			if(codeKey.equals("DSTRC")) {
				//String gradCode = (String) loginVO.get("gradCode");
				String gradCode = "CM00200011";
				inputVO.put("upperCodeId",codeVal);
				inputVO.put("applcGrad",gradCode);
				codeList = devlopInfoService.selectDstrcCodeList(inputVO);
			}else if(codeKey.equals("DSTRC_UPCD")) {
				inputVO.put("upperCodeId",codeVal);
				codeList = devlopInfoService.selectDstrcCodeListByUpCd(inputVO);
			}else if(codeKey.equals("DSTRC_CD")) {
				inputVO.put("codeId",codeVal);
				codeList = devlopInfoService.selectDstrcCodeListByUpCd(inputVO);
			}else if(codeKey.equals("CMMN_UPCD")){
				inputVO.put("upperCodeId",codeVal);
				codeList = cmmnService.selectCodeListCMMNCodeId(inputVO);
			}else if(codeKey.equals("CMMN_CD")) {
				inputVO.put("codeId",codeVal);
				codeList = cmmnService.selectCodeListCMMNCodeId(inputVO);
			}else {
				codeList = cmmnService.selectCodeList(codeKey,codeVal);
			}
		//mv.addObject("authVO",authVO);
		mv.addObject("codeList",codeList);
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/selectOldImgFileList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectOldImgFileList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		searchVO.put("devlopInfoSn",String.valueOf(request.getParameter("devlopInfoSn")));
		EgovMap resultList = devlopInfoService.selectDevlopInfoDetail(searchVO);
		
		//?????? ???????????? ?????? ?????????????????? ?????????
		searchVO.put("dwkNo",resultList.get("dwkNo"));
		EgovMap oldFileMap = devlopInfoService.selectOldFileList(searchVO);
		
		mv.addObject("oldFileMap",oldFileMap);
		mv.setViewName("jsonView");
		return mv;
	}
	
	//??????
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/devlopInfo/selectMmnwsBbsListByDwkNm.do")
	public String selectMmnwsBbsListByDwkNm(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		EgovMap searchVO = new EgovMap();
		PaginationInfo paginationInfo = new PaginationInfo();
        BoardVO boardVO = new BoardVO();
        
        if(null != request.getParameter("pageIndex") && !"".equals(request.getParameter("pageIndex"))) {
			boardVO.setPageIndex(Integer.parseInt(request.getParameter("pageIndex")));
		}
        
		searchVO.put("dwkNm", (String)request.getParameter("dwkNm"));
		//???????????? --?????? ????????? ???????????? ????????? ??????
		searchVO.put("blogId", (String)request.getParameter("dwkNo"));
		//???????????? ?????????????????? ?????? ??????(05.25)
        paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
        paginationInfo.setPageSize(boardVO.getPageSize());
      
        searchVO.put("firstIndex",paginationInfo.getFirstRecordIndex());
        searchVO.put("lastIndex",paginationInfo.getLastRecordIndex());
        searchVO.put("recordCountPerPage",paginationInfo.getRecordCountPerPage());
        
		List<?> NwsList = devlopInfoService.selectMmnwsBbsListByDwkNm(searchVO);
		int totCnt = devlopInfoService.selectMmnwsBbsListByDwkNmCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		//??????(04.22) ?????????????????? ????????? ???????????? ???????????? ??????
        if(null != request.getParameter("dwkNo") && !"".equals(request.getParameter("dwkNo"))){
        	searchVO.put("keyword", (String)request.getParameter("dwkNm"));
        }
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList",NwsList);
		
		return  "/gzonei/cmmnty/mmnwsBbsList";
	}
	//????????????
	@RequestMapping(value="/devlopInfo/selectIntrstList.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectIntrstList(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		ModelAndView mv = new ModelAndView();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = (String) loginVO.get("id");
		EgovMap searchVO = new EgovMap();
		
		searchVO.put("userId", userId);
		
		List<?> IntrstList = devlopInfoService.selectIntrstList(searchVO);
		
		mv.addObject("IntrstList",IntrstList);
		mv.addObject("authVO",authVO);
		//???????????? ??????
		//mv.addObject("oldFileListRs",oldFileListRs);

		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	//???????????? ??????
	@RequestMapping(value="/devlopInfo/InsertIntrst.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView InsertIntrst(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		ModelAndView mv = new ModelAndView();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		EgovMap searchVO = new EgovMap();
		
		String userId = (String) loginVO.get("id");
		String dwkNo = request.getParameter("dwkNo");
		String intrstThingSn = request.getParameter("devlopIntrstThingSn");
		String intrstGroupNm = request.getParameter("intrstGroupNm");

		searchVO.put("userId", userId);
		searchVO.put("dwkNo", dwkNo);
		searchVO.put("intrstThingSn", intrstThingSn);
		searchVO.put("intrstGroupNm", intrstGroupNm);
		
		int insertIntrstResult;
		int intrstChk = devlopInfoService.selectIntrstChk(searchVO);
		if(intrstChk==0) {
			insertIntrstResult = devlopInfoService.InsertIntrst(searchVO);
		}else {
			insertIntrstResult = 2;
		}
		mv.addObject("authVO",authVO);
		mv.addObject("insertIntrstResult",insertIntrstResult);
		//???????????? ??????
		//mv.addObject("oldFileListRs",oldFileListRs);

		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	//???????????? ??????
	@RequestMapping(value="/devlopInfo/selectInvtListBydwkNo.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectInvtListBydwkNo(HttpServletRequest request, HttpServletResponse response) throws SQLException , IOException{
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		ModelAndView mv = new ModelAndView();
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("textSearch") && !"".equals(request.getParameter("textSearch"))) {
			searchVO.put("textSearch", request.getParameter("textSearch"));
		}else {
			searchVO.put("textSearch", "");
		}
		
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
				
		String userId = (String) loginVO.get("id");
		String dwkNo = request.getParameter("dwkNo");

		searchVO.put("userId", userId);
		searchVO.put("dwkNo", dwkNo);
		
		List<?> invtList = devlopInfoService.selectInvtListBydwkNo(searchVO);
		//??????1
		List<?> area1List= cmmnService.selectCodeList("AREA", "0000000000");
		//??????????????????
		List<?> dsCodeList = cmmnService.selectCodeList("CMMN", "DS01000000");
		for(int i=0; i<invtList.size(); i++) {
		//?????????
		String courtNm = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) invtList.get(i)).get("courtCode")));
		//????????? ??????
		String aucYN = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) invtList.get(i)).get("aucPblsalSeCode")));
		//????????????????????????
//		String progrNm = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) resultList.get(i)).get("invtProgrsSeCode")));
		//??????
		String prposNm = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) invtList.get(i)).get("prposThreeCode")));
		//?????? (cmm_??????????????????)
		String stusNm = cmmnService.selectCodeName(String.valueOf(((ListOrderedMap) invtList.get(i)).get("progrsResultCode")));
		((ListOrderedMap) invtList.get(i)).put("courtNm", courtNm);
		((ListOrderedMap) invtList.get(i)).put("aucYN", aucYN);
//		((ListOrderedMap) resultList.get(i)).put("progrNm", progrNm);
		((ListOrderedMap) invtList.get(i)).put("prposNm", prposNm);
		((ListOrderedMap) invtList.get(i)).put("stusNm", stusNm);
//		mv.addObject("aucYN", aucYN);
//		mv.addObject("progrNm", progrNm);
//		mv.addObject("prposNm", prposNm);
//		mv.addObject("stusNm", stusNm);
		}

		mv.addObject("area1List" ,area1List);
		mv.addObject("dsCodeList" ,dsCodeList);
		mv.addObject("searchVO",searchVO);
		mv.addObject("invtList",invtList);
		mv.addObject("authVO",authVO);
		//?????? ????????? ??????
		mv.setViewName("jsonView"); 
		return mv;
	}
	
	@RequestMapping(value="/devlopInfo/selectRecDevInfoLog.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView selectRecDevInfoLog(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = String.valueOf(loginVO.get("id"));
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		EgovMap searchVO = new EgovMap();
		searchVO.put("userId", userId);
		searchVO.put("logCount", 5);
		
		List<?> recLogList = devlopInfoService.selectRecDevInfoLog(searchVO);
		mv.addObject("recLogList",recLogList);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value="/devlopInfo/updatePrintCnt.do", method=RequestMethod.POST , produces = "application/text; charset=utf8")
	@ResponseBody
	public  ModelAndView updatePrintCnt(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView();
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		String userId = String.valueOf(loginVO.get("id"));
		EgovMap authVO = (EgovMap) request.getSession().getAttribute("authVO");
		
		EgovMap searchVO = new EgovMap();
		searchVO.put("userId", userId);
		searchVO.put("outptCo", request.getParameter("outptCo"));
		
		int updateResult = devlopInfoService.updateUserPrintCnt(searchVO);
		EgovMap UserCntMap = devlopInfoService.selectUserPrintCntById(searchVO);
		
		mv.addObject("UserCntMap",UserCntMap);
		mv.addObject("updateResult",updateResult);
		mv.addObject("authVO",authVO);
		//????????????
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	
	
	@RequestMapping(value = "/FileDown.do") 
	public void fileDownload(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String atchFileId = (String) commandMap.get("atchFileId");
		String fileSn = (String) commandMap.get("fileSn");
		
//		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
//		if (isAuthenticated) {

			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			fileVO.setFileSn(fileSn);
			FileVO fvo = fileMngService.selectFileInf(fileVO);
			File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
			long fSize = uFile.length();

			if (fSize > 0) {
				String mimetype = "application/x-msdownload";
				
				String userAgent = request.getHeader("User-Agent");
				HashMap<String,String> result = EgovBrowserUtil.getBrowser(userAgent);
				if ( !EgovBrowserUtil.MSIE.equals(result.get(EgovBrowserUtil.TYPEKEY)) ) {
					mimetype = "application/x-stuff";
				}

				String contentDisposition = EgovBrowserUtil.getDisposition(fvo.getOrignlFileNm(),userAgent,"UTF-8");
				//response.setBufferSize(fSize);	// OutOfMemeory ??????
				response.setContentType(mimetype);
				//response.setHeader("Content-Disposition", "attachment; filename=\"" + contentDisposition + "\"");
				response.setHeader("Content-Disposition", contentDisposition);
				response.setContentLengthLong(fSize);

				/*
				 * FileCopyUtils.copy(in, response.getOutputStream());
				 * in.close();
				 * response.getOutputStream().flush();
				 * response.getOutputStream().close();
				 */
				BufferedInputStream in = null;
				BufferedOutputStream out = null;

				try {
					in = new BufferedInputStream(new FileInputStream(uFile));
					out = new BufferedOutputStream(response.getOutputStream());

					FileCopyUtils.copy(in, out);
					out.flush();
				} catch (IOException ex) {
					// ?????? Exception ?????? ??????
					// Connection reset by peer: socket write error
					EgovBasicLogger.ignore("IO Exception", ex);
				} finally {
					EgovResourceCloseHelper.close(in, out);
				}

			} else {
				response.setContentType("application/x-msdownload");

				PrintWriter printwriter = response.getWriter();
				
				printwriter.println("<html>");
				printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fvo.getOrignlFileNm() + "</h2>");
				printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
				printwriter.println("<br><br><br>&copy; webAccess");
				printwriter.println("</html>");
				
				printwriter.flush();
				printwriter.close();
			}
			
		}
	
	
	/*@SuppressWarnings("deprecation")
	private List<EgovMap> yearMaker(EgovMap map){
		List<EgovMap> list = new ArrayList<EgovMap>();
		EgovMap returnMap = new EgovMap();
		Timestamp ts = (Timestamp)map.get("expectRewardEra");
		SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(new Date(ts.getTime()));
		int val = Integer.valueOf(date.substring(0,4));
		//String year = 
		for(int i = val; i>val;i--) {
			returnMap.put("codeId", i);
			returnMap.put("codeIdNm", i);
			list.add(returnMap);
		}
		return list;
	}*/
}

