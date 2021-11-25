package gzonei.oper.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.member.service.MemberService;
import gzonei.oper.service.GroupManageService;

@Controller
public class GroupManageController {

	/**GroupManageService*/
	@Resource(name="GroupManageService")
	private GroupManageService groupManageService;
	
	/** MemberService */
	@Resource(name = "MemberService")
	private MemberService memberService;
	
	/**
	 * 
	 * 그룹관리페이지
	 * 
	 * @param request
	 * @param response
	 * @param redirect
	 * @param model
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/oper/groupManage.do")
	public String secessionReqst(HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirect, Model model) throws SQLException , IOException{
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
		
		List<?> resultList = groupManageService.selectGroupList();
		model.addAttribute("resultList", resultList);
		return "gzonei/oper/groupManage";
		
	}
	
	/**
	 * 
	 * 
	 * 그룹상세정보조회
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/oper/selectGroupInfoDt.do")
	public void selectGroupInfoDt(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

		Gson gson = new Gson();
		String result = "";
		EgovMap resultM = new EgovMap();
		EgovMap searchVO = new EgovMap();
		
		
		searchVO.put("groupId", request.getParameter("groupId"));
		
		EgovMap resultVO = groupManageService.selectGroupInfoDt(searchVO);
		List<?> groupMemberList = groupManageService.selectGroupMember(searchVO);
		resultM.put("resultVO", resultVO);
		resultM.put("groupMList", groupMemberList);
	    
		result = gson.toJson(resultM);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);			
		
	}
	
	/**
	 * 
	 * 회원검색
	 * 
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/oper/selectMemberSearch.do")
	public void selectMemberSearch(HttpServletRequest request, HttpServletResponse response, Model model)throws SQLException,IOException{
		Gson gson = new Gson();
		String result = "";
		EgovMap searchVO = new EgovMap();
		String searchSel = request.getParameter("searchSel");
		String searchKrwd = request.getParameter("searchKrwd");
				
		if(searchSel.equals("indvdl_mber_code")) {
		   if(searchKrwd.contains("개인")) {
			   searchKrwd = "CM00210001";
		   }else if(searchKrwd.contains("법인")) {
			   searchKrwd = "CM00210002";
		   }else if(searchKrwd.contains("관리자")) {
			   searchKrwd = "CM00210003";
		   }
		}
				
				
		searchVO.put("searchSel",searchSel );
		searchVO.put("searchKrwd",searchKrwd);
		
		List<?> memberList = groupManageService.selectMemberSearch(searchVO);
		
		result = gson.toJson(memberList);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);
	}
	
	/**
	 * 
	 * 그룹 수정
	 * 
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/oper/updateGroupMember.do")
	public void updateGroupMember(HttpServletRequest request, HttpServletResponse response, Model model)throws SQLException,IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		Gson gson = new Gson();
		String result = "";
	
		EgovMap searchVO = new EgovMap();
		searchVO.put("lastUpdusrId", loginVO.get("id"));
		searchVO.put("useAt", request.getParameter("useAt"));
		searchVO.put("groupNm", request.getParameter("groupNm"));
		searchVO.put("groupDc", request.getParameter("groupDc"));
		searchVO.put("groupMem", request.getParameter("groupMem"));
		searchVO.put("groupId", request.getParameter("groupId"));
		
		int rs = groupManageService.updateGroupMember(searchVO);
	    
		result = gson.toJson(rs);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);			
	}
	
	/**
	 * 
	 * 신규그룹 생성
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/oper/insertNewGroup.do")
	public void insertNewGroup(HttpServletRequest request, HttpServletResponse response, Model model)throws SQLException,IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		Gson gson = new Gson();
		String result = "";

		EgovMap searchVO = new EgovMap();
		searchVO.put("frstRegistId", loginVO.get("id"));
		searchVO.put("useAt", request.getParameter("useAt"));
		searchVO.put("groupNm", request.getParameter("groupNm"));
		searchVO.put("groupDc", request.getParameter("groupDc"));
		searchVO.put("groupMem", request.getParameter("groupMem"));
		
		int rs = groupManageService.insertNewGroup(searchVO);
		
		result = gson.toJson(rs);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);	
	}
	
	/**
	 * 
	 * 그룹삭제
	 * 
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value="/oper/groupDelete.do")
	public void groupDelete(HttpServletRequest request, HttpServletResponse response, Model model)throws SQLException,IOException{
		EgovMap loginVO = (EgovMap) request.getSession().getAttribute("loginVO");
		Gson gson = new Gson();
		String result = "";

		EgovMap searchVO = new EgovMap();
		searchVO.put("lastUpdusrId", loginVO.get("id"));
		searchVO.put("groupId", request.getParameter("groupId"));
		
		int rs = groupManageService.groupDelete(searchVO);
		
		result = gson.toJson(rs);
		
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);	
	}
	
}
