package gzonei.gradAuth.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.gradAuth.service.BsnsDstrcService;

@Controller
public class BsnsDstrcController {
	
	@Resource(name="BsnsDstrcService")
	private BsnsDstrcService bsnsdstrcService;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;
	
    //사업지구 리스트 조회
    @RequestMapping(value="admin/bsnsDstrc/selectBsnsDstrc.do")
    public String selectDevBestList(RedirectAttributes redirect,HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
    	 //페이지 접근 권한 설정-------(admin메뉴시)
        EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
        EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
        EgovMap authInfo = new EgovMap();
        String accessAuth = "";
        String gradInfo = "";
        //반환 정보indvdlMberCode=CM00210002
        EgovMap redirectInfo = new EgovMap();
        //접근권한 
        if(auth!=null) {
			authInfo =  (EgovMap) auth.get("adm005002");
			accessAuth =  authInfo.get("menuAccesAt").toString();
        }    	
    	//로그인 세션 검사
		if(session!=null) {
			gradInfo =  session.get("indvdlMberCode").toString();
			if(!gradInfo.equals("CM00210003")) {
				redirectInfo.put("message", "관리자 로그인 시 이용가능합니다.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do";
			}
		}else{
			redirectInfo.put("message", "로그인 후 이용가능합니다.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}
		//---------
    	List<?> bsnsList = bsnsdstrcService.selectBsnsDstrc();
    	List<?> authorList = bsnsdstrcService.selectDstrcAuthor();
    	
    	model.addAttribute("bsnsList",bsnsList);
    	model.addAttribute("authorList",authorList);
    	
    	return "gzonei/admin/bsnsDstrc/bsnsDstrcMgmt";
    }
    //수정
    @RequestMapping(value="admin/bsnsDstrc/saveBsnsDstrc.do")
    public String saveDevList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
    	EgovMap insertVO = new EgovMap();
    	String gradArray[] = request.getParameterValues("applcGrad");
    	String gradString = Arrays.toString(gradArray);
    	if(gradArray!=null) {
    		gradString = gradString.substring(1, gradString.length()-1);
    		gradString = gradString.replace(" ","");
    	}else {gradString =null;}
    	insertVO.put("applcGrad", gradString);
    	insertVO.put("codeLevel", request.getParameter("codeLevel"));
    	insertVO.put("codeId", request.getParameter("codeId"));
    	insertVO.put("codeIdNm", request.getParameter("codeIdNm"));
    	insertVO.put("sortOrdr", request.getParameter("sortOrdr"));
    	insertVO.put("upperCodeAt", request.getParameter("upperCodeAt"));
    	insertVO.put("upperCodeId", request.getParameter("upperCodeId"));
    	insertVO.put("useAt", request.getParameter("useAt"));
    	insertVO.put("orgCodeId", request.getParameter("orgCodeId"));
    	if((String)request.getParameter("orgCodeId") != (String)request.getParameter("codeId")) {
    		bsnsdstrcService.updateCodeChecker(insertVO);
    	}
    	UUID uid = UUID.fromString(request.getParameter("bsnsDstrcCodeSn"));
    	insertVO.put("bsnsDstrcCodeSn", uid);
    	if(request.getParameter("useAt").toString().equals("Y"))insertVO.put("delAt", "N");
    	else insertVO.put("delAt", "Y");
    	//단위유형
    	insertVO.put("unitTy", request.getParameter("unitTy"));
    	
    	bsnsdstrcService.updateBsnsDstrc(insertVO);
    	
    	
    	return "redirect:/admin/bsnsDstrc/selectBsnsDstrc.do";
    }
    //신규
    @RequestMapping(value="admin/bsnsDstrc/saveNewBsnsDstrc.do")
    public String saveNewDevList(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
    	EgovMap createVO = new EgovMap();
    	createVO.put("codeLevel", request.getParameter("codeLevel"));
    	createVO.put("codeId", request.getParameter("codeId"));
    	createVO.put("codeIdNm", request.getParameter("codeIdNm"));
    	createVO.put("sortOrdr", request.getParameter("sortOrdr"));
    	String gradArray[] = request.getParameterValues("applcGrad");
    	String gradString = Arrays.toString(gradArray);
    	if(gradArray!=null) {
    		gradString = gradString.substring(1, gradString.length()-1);
    		gradString = gradString.replace(" ","");
    	}else {gradString =null;}
    	createVO.put("applcGrad", gradString);
    	createVO.put("upperCodeAt", request.getParameter("upperCodeAt"));
    	createVO.put("upperCodeId", request.getParameter("upperCodeId"));
    	createVO.put("useAt", request.getParameter("useAt"));
    	createVO.put("bsnsDstrcCodeSn", request.getParameter("bsnsDstrcCodeSn"));
    	//단위유형
    	createVO.put("unitTy", request.getParameter("unitTy"));
    	if(request.getParameter("useAt").toString().equals("Y"))createVO.put("delAt", "N");
    	else createVO.put("delAt", "Y");
    	
    	bsnsdstrcService.createBsnsDstrc(createVO);
    	
    	return "redirect:/admin/bsnsDstrc/selectBsnsDstrc.do";
    }
}
