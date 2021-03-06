package gzonei.gradAuth.web;


import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.gradAuth.service.GradAuthService;

/**
* 
* CmmnController
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
*  2021.01.26      김승제         		최초 생성
*  
*
*  </pre>
*/
@Controller
public class GradAuthController {
	
	/** CmmnService */
	@Resource(name = "cmmnService")
	private CmmnService cmmnService;
	
	/** GradAuthService  */
	@Resource(name = "gradAuthService")
	private GradAuthService gradAuthService;

	/** EgovCmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(GradAuthController.class);
	
	@RequestMapping(value="/admin/gradAuth/gradAuthManage.do")
	public String gradAuthManageView(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirect) throws SQLException , IOException{
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

		List<?> resultList = gradAuthService.selectGradAuthList(searchVO);
		int totCnt = gradAuthService.selectGradAuthListTotCnt(searchVO);
		searchVO.put("totCnt",totCnt);

		paginationInfo.setTotalRecordCount(totCnt);
		//코드리스트
		List<?> monthCode = cmmnService.selectCodeList("CMMN","CM00020000");//개월수코드
		

		model.addAttribute("monthCode",monthCode);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "gzonei/admin/gradAuth/gradAuthManageList";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/gradAuth/insertGradAuthManage.do",produces="application/json;charset=UTF-8")
	public String insertGradAuthManage(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//String userId = request.getParameter("userId");
		
		EgovMap gradInfoVO = new EgovMap();
		EgovMap gradAmountVO = new EgovMap();
		EgovMap gradDetailInfoVO = new EgovMap();
		
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");

		if(loginVO != null) {
			gradInfoVO.put("userId", loginVO.get("id"));
		}else {
			gradInfoVO.put("userId", "");
		}
		
		//기본정보
		String gradAuthorSn = request.getParameter("gradAuthorSn")==null?"":request.getParameter("gradAuthorSn");	//등급권한일련번호
		String gradAuthorCode = request.getParameter("gradAuthorCode")==null?"":request.getParameter("gradAuthorCode");	//등급권한코드
		String gradAuthorNm = request.getParameter("gradAuthorNm")==null?"":request.getParameter("gradAuthorNm");	//등급권한명
		String gradAuthorDc = request.getParameter("gradAuthorDc")==null?"":request.getParameter("gradAuthorDc");	//등급권한설명
		String gradAuthorUseAt = request.getParameter("gradAuthorUseAt")==null?"":request.getParameter("gradAuthorUseAt");	//사용여부
		String gradAuthorDelAt = request.getParameter("gradAuthorDelAt")==null?"":request.getParameter("gradAuthorDelAt");	//삭제여부
		
		String srvcSeCode = request.getParameter("srvcSeCode")==null?"S001":request.getParameter("srvcSeCode");	//서비스지역코드
		
		//상품 금액 정보
		String[] gradAmountSn = request.getParameterValues("gradAmountSn");	//상품금액일련번호
		String[] useMonthCoCode = request.getParameterValues("useMonthCoCode");	//개월수코드
		String[] amount = request.getParameterValues("amount");	//금액
		String[] amountUseAt = request.getParameterValues("amountUseAt");	//상품 금액 사용여부
		
		//권한정보
		String[] gradAuthorDetailSn = request.getParameterValues("gradAuthorDetailSn");	//키값
		String[] authorCode = request.getParameterValues("authorCode");	//권한코드
		String[] authorNm = request.getParameterValues("authorNm");	//권한명
		String[] authorDc = request.getParameterValues("authorDc");	//권한설명
		String[] menuAccesAt = request.getParameterValues("menuAccesAt");	//메뉴접근권한
		String[] infoInqireAt = request.getParameterValues("infoInqireAt");	//정보조회권한
		String[] infoRegistAt = request.getParameterValues("infoRegistAt");	//정보등록권한
		String[] infoUpdtAt = request.getParameterValues("infoUpdtAt");	//정보수정권한
		String[] infoDelAt = request.getParameterValues("infoDelAt");	//정보삭제권한
		String[] infoDspyAt = request.getParameterValues("infoDspyAt");	//정보전시권한
		String[] executAt = request.getParameterValues("executAt");	//실행&다운권한
		
		
	
		for (String mapkey : commandMap.keySet()){
	    //    searchVO.put(mapkey, commandMap.get(mapkey));
	    }
		
		//기본정보 입력
		gradInfoVO.put("gradAuthorSn", gradAuthorSn);
		gradInfoVO.put("gradAuthorCode", gradAuthorCode);
		gradInfoVO.put("gradAuthorNm", gradAuthorNm);
		gradInfoVO.put("gradAuthorDc", gradAuthorDc);
		gradInfoVO.put("useAt", gradAuthorUseAt);
		gradInfoVO.put("delAt", gradAuthorDelAt);
		
		gradAuthService.insertGradAuthInfo(gradInfoVO);
		
		
		int gradAmountCtn = useMonthCoCode.length;
		for(int i=0;i<gradAmountCtn; i++) {
			gradAmountVO.clear();
			gradAmountVO.put("gradAuthorSn", gradInfoVO.get("gradAuthorSn"));
			gradAmountVO.put("gradAmountSn", gradAmountSn[i]);
			gradAmountVO.put("goodsNm", gradAuthorNm);
			gradAmountVO.put("useMonthCoCode", useMonthCoCode[i]);
			gradAmountVO.put("amount", amount[i]);
			gradAmountVO.put("srvcSeCode", srvcSeCode);
			gradAmountVO.put("useAt", amountUseAt[i]);
			gradAmountVO.put("userId", gradInfoVO.get("userId"));

			gradAuthService.insertGradAmountInfo(gradAmountVO);
		}
		
		int authCtn = authorCode.length;
		for(int i=0;i<authCtn; i++) {
			gradDetailInfoVO.clear();
			gradDetailInfoVO.put("userId", gradInfoVO.get("userId"));
			gradDetailInfoVO.put("gradAuthorDetailSn", gradAuthorDetailSn[i]);
			gradDetailInfoVO.put("gradAuthorSn", gradInfoVO.get("gradAuthorSn"));
			gradDetailInfoVO.put("authorNm", authorNm[i]);
			gradDetailInfoVO.put("authorDc", authorDc[i]);
			gradDetailInfoVO.put("authorCode", authorCode[i]);
			gradDetailInfoVO.put("menuAccesAt", menuAccesAt[i]);
			gradDetailInfoVO.put("infoInqireAt", infoInqireAt[i]);
			gradDetailInfoVO.put("infoRegistAt", infoRegistAt[i]);
			gradDetailInfoVO.put("infoUpdtAt", infoUpdtAt[i]);
			gradDetailInfoVO.put("infoDelAt", infoDelAt[i]);
			gradDetailInfoVO.put("infoDspyAt", infoDspyAt[i]);
			gradDetailInfoVO.put("executAt", executAt[i]);
			
			gradAuthService.insertGradAuthDetailInfo(gradDetailInfoVO);
		}
		
		Gson gson = new Gson();
		String json = gson.toJson("1");
		
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/gradAuth/selectGradAuthInfo.do",produces="application/json;charset=UTF-8")
	public String selectGradAuthInfo(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		for (String mapkey : commandMap.keySet()){
	        searchVO.put(mapkey, commandMap.get(mapkey));
	    }

		EgovMap gradInfoVO = new EgovMap();
		gradInfoVO = gradAuthService.selectGradAuthInfo(searchVO);
		List<?> gradAmountVO = gradAuthService.selectGradAuthAmountInfo(searchVO);
		List<?> gradDetailInfoVO = gradAuthService.selectGradAuthDetailInfo(searchVO);
		
		EgovMap resultVO = new EgovMap();
		resultVO.put("gradInfoVO", gradInfoVO);
		resultVO.put("gradAmountVO", gradAmountVO);
		resultVO.put("gradDetailInfoVO", gradDetailInfoVO);
		
		Gson gson = new Gson();
		String json = gson.toJson(resultVO);
		
		return json;
	}
}
