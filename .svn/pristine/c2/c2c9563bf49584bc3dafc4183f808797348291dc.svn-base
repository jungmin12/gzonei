package gzonei.payment.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jasypt.commons.CommonUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.payment.service.PaymentService;
import gzonei.today.service.TodayAdminService;


@Controller
public class PaymentController {

	/**TodayService*/
	@Resource(name="PaymentService")
	private PaymentService paymentService;
	
	/** CmmnService */
	@Resource(name = "cmmnService")
	private CmmnService cmmnService;
	
	/** 희진 */
	
	/**
	 * 정산관리 리스트 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/payment/excclcList.do")
	public String selectExcclcList(@RequestParam Map<String, Object> commandMap,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
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

		List<?> resultList = paymentService.selectExcclcList(searchVO);
		int totCnt = paymentService.selectExcclcListTotCnt(searchVO);

		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "gzonei/admin/payment/excclcList";
	}
	
	/**
	 * 정산 등록 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/payment/excclcReg.do")
	public String adminExcclcReg(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
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
		
		return "gzonei/admin/payment/excclcReg";
	}
	/**
	 * 회원정보 상세보기
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/payment/excclcView.do")
	public String selectMemberDetail(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
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

		searchVO.put("excclcManageSn", request.getParameter("excclcManageSn"));
		EgovMap resultVO = paymentService.selectExcclcDetail(searchVO);
		model.addAttribute("resultVO",resultVO);
		
		return "gzonei/admin/payment/excclcView";
	}
	
	/**
	 * 정산 등록 처리
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/payment/excclcRegAction.do")
	public String excclcRegAction(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		paymentService.insertExcclcInfo(commandMap);//정산정보 입력
		
		return "redirect:/admin/payment/excclcList.do";
	}
	
	/**
	 * 정산 수정 처리
	 * @param commandMap
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/payment/excclcUpdateAction.do")
	public String excclcUpdateAction(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		paymentService.updateExcclcInfo(commandMap);//정산정보 수정
		
		return "redirect:/admin/payment/excclcList.do";
	}
	
	/**
	 * 정산관리 리스트 조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/admin/payment/nbkkCnfirmList.do")
	public String selectnbkkCnfirmList(@RequestParam Map<String, Object> commandMap,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
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

		List<?> resultList = paymentService.selectNbkkCnfirmList(searchVO);
		int totCnt = paymentService.selectNbkkCnfirmListTotCnt(searchVO);

		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "gzonei/admin/payment/nbkkCnfirmList";
	}
	
}
