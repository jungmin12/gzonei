package gzonei.sample.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
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
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmn.service.CmmnService;
import gzonei.cmmn.util.FileUtils;
import gzonei.sample.service.FileUploadVO;
import gzonei.sample.service.SampleService;

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
*  2021.01.26      김승제         		최초 생성
*  
*
*  </pre>
*/
@Controller
public class SampleController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SampleController.class);
	
	final String ckUploadPath = EgovProperties.getProperty("upload.images.ckupload.path");
	final String ckloadImgPath = EgovProperties.getProperty("load.images.ckupload.path");

	/** CmmnService */
	@Resource(name = "cmmnService")
	private CmmnService cmmnService;
	
	
	/** SampleService */
	@Resource(name = "SampleService")
	private SampleService sampleService;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;
    
    @Resource(name="FileUtils")
	private FileUtils fileUtils;
    
	/**
	 * 샘플 조회(코드리스트) 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/sample/selectSamplePage.do")
	public String selectSamplePage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		List<?> resultList = sampleService.selectSampleList(searchVO);

		/*
		 * 코드 목록 가져오기 List<?> 코드리스트변수명 = cmmnService.selectCodeList("테이블종류","상위코드");
		 * 테이블종류 : CMMN -> 공통코드 , PRODUCT -> 상품코드, AREA -> 행정구역코드
		 * */
		//
		List<?> codeList = cmmnService.selectCodeList("CMMN","CM00200000");
		model.addAttribute("codeList",codeList);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		
		//샘플 페이지 이동
		return "gzonei/sample/sampleView";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/sample/selectSampleExcel.do", produces = "application/json; charset=utf8")
	public String selectSampleExcel(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		Gson gson = new Gson();
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		List<?> resultList = sampleService.selectSampleExcel(searchVO);
		
		String json = gson.toJson(resultList);
		
		return json;	

	}
	
	@RequestMapping(value="/sample/ckuploadSamplePage.do")
	public String ckuploadSamplePage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		BoardVO boardVO = new BoardVO();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		List<?> resultList = sampleService.selectSampleList(searchVO);
		
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("boardVO",boardVO);
		model.addAttribute("resultList",resultList);
		
		//샘플 페이지 이동
		return "gzonei/sample/ckeditor_sample";
	}
	
	@RequestMapping(value="/ckupload.do", method=RequestMethod.POST)
	@ResponseBody
	public String Board_ckupload(@ModelAttribute("fileUploadVO") FileUploadVO fileUploadVO,
			HttpServletRequest req, HttpServletResponse resp, 
	            MultipartHttpServletRequest multiFile) throws Exception {
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter printWriter = null;
		OutputStream out = null;
		String Fn = fileUploadVO.getUpload().getOriginalFilename();
		MultipartFile file = multiFile.getFile("upload");
		String nowTime= fileUtils.getDate();
		
		if(file != null){
			if(file.getSize() > 0 && StringUtils.isNotBlank(file.getName())){
				if(file.getContentType().toLowerCase().startsWith("image/")){
					try{
						String fileName = file.getName();
						byte[] bytes = file.getBytes();
						//실제경로
						String uploadPath = ckUploadPath+"/ckupload/"+nowTime+"/";
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()){
							uploadFile.mkdirs();
						}
						fileName = Fn;
						String newUploadPath = uploadPath + fileName;
						int num = 0;
						String[] fileNameArray = Fn.split("[.]");
						String filenameOnly = fileNameArray[0];
						String fileExt = fileNameArray[1];
						while(fileExistChk(newUploadPath)) {
							num ++;
							String filenameOnlyOutput = filenameOnly + "(" + String.valueOf(num) + ")";
							fileName = filenameOnlyOutput + "." + fileExt;
							newUploadPath = uploadPath + fileName;
						}
						out = new FileOutputStream(new File(newUploadPath));
						out.write(bytes);
	                   
						String callback = req.getParameter("CKEditorFuncNum");
						printWriter = resp.getWriter();
						//호출경로 변환
						HttpHeaders headers = new HttpHeaders();
						headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
						String header = req.getHeader("User-Agent");
						if(header.contains("MSIE")||header.contains("Trident")) {
							fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
						}
						String fileUrl ="/file/displayFile.do?filePath=/upload/gzone/images/ck/ckupload/"+nowTime+"/"+fileName+"&fileName="+fileName;
						printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
					       + callback
					       + ",'"
					       + fileUrl
					       + "','이미지를 업로드 하였습니다.'"
					       + ")</script>");
						printWriter.flush();
						//업로드 파일권한 설정
						Runtime.getRuntime().exec("chmod -R 777 /upload/gzone/images/ck");
						
	               }catch(IOException e){
	                   e.printStackTrace();
	               }finally{
	                   if(out != null){
	                       out.close(); 
	                   }
	                   if(printWriter != null){
	                       printWriter.close();
	                   }		
					}
				}
			}
		}
		return null;
	}
	private boolean fileExistChk(String path) {
		boolean booleanValue = true;
		File newUploadfile = new File(path);
		if(newUploadfile.exists()) {
			booleanValue = true;
		}else {
			booleanValue = false;
		}
		return booleanValue;
	}
	
	/**
	 * 샘플 조회(코드리스트) 페이지
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException , IOException
	 */
	@RequestMapping(value="/sample/map.do")
	public String selectSampleMap(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//샘플 지도 이동
		return "gzonei/sample/sampleMap";
	}
	
	@ResponseBody
	@RequestMapping(value="/sample/viewLayer.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String selectViewLayer(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		Gson gson = new Gson();
		EgovMap searchVO = new EgovMap();
		searchVO.put("layer", request.getParameter("layer"));
		
		//서비스지역코드(사용자 지역코드) 테스트용
		List<Map<String, Object>> legaldongCode = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		map.put("legaldongCode","4100000000");
		map1.put("legaldongCode","4700000000");
		legaldongCode.add(map);
		legaldongCode.add(map1);
		
		searchVO.put("legaldongCode", legaldongCode);
		List<?> resultList = sampleService.selectViewLayer(searchVO);
		
		String json = gson.toJson(resultList);
		
		return json;	

	}
	
	@ResponseBody
	@RequestMapping(value="/sample/insertLayer.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public void insertLayer( HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
		EgovMap searchVO = new EgovMap();
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		sampleService.insertLayer(searchVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/sample/updateLayer.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public void updateLayer( HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
		EgovMap searchVO = new EgovMap();
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		sampleService.updateLayer(searchVO);
	}
	
	@ResponseBody
	@RequestMapping(value="/sample/deleteLayer.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public void deleteLayer( HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException {
		EgovMap searchVO = new EgovMap();
		
		Enumeration<String> requestEnumKey = request.getParameterNames();
		while(requestEnumKey.hasMoreElements()) {
        	String strKey = requestEnumKey.nextElement();
            String strVal = request.getParameter(strKey);
            searchVO.put(strKey, strVal);
        }
		sampleService.deleteLayer(searchVO);
	}
	@RequestMapping(value="/sample/selectBbsListPage.do")
	public String selectBbsListPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		List<?> resultList = sampleService.selectSampleList(searchVO);

		/*
		 * 코드 목록 가져오기 List<?> 코드리스트변수명 = cmmnService.selectCodeList("테이블종류","상위코드");
		 * 테이블종류 : CMMN -> 공통코드 , PRODUCT -> 상품코드, AREA -> 행정구역코드
		 * */
		//
		List<?> codeList = cmmnService.selectCodeList("CMMN","CM00200000");
		model.addAttribute("codeList",codeList);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		
		//샘플 페이지 이동
		return "gzonei/sample/sampleBbsList";
	}
	
	@RequestMapping(value="/sample/selectBbsDtlPage.do")
	public String selectBbsDtlPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		List<?> resultList = sampleService.selectSampleList(searchVO);
		
		/*
		 * 코드 목록 가져오기 List<?> 코드리스트변수명 = cmmnService.selectCodeList("테이블종류","상위코드");
		 * 테이블종류 : CMMN -> 공통코드 , PRODUCT -> 상품코드, AREA -> 행정구역코드
		 * */
		//
		List<?> codeList = cmmnService.selectCodeList("CMMN","CM00200000");
		model.addAttribute("codeList",codeList);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		
		//샘플 페이지 이동
		return "gzonei/sample/sampleBbsDtl";
	}
	
	@RequestMapping(value="/sample/selectGuidePage.do")
	public String selectGuidePage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		List<?> resultList = sampleService.selectSampleList(searchVO);
		
		/*
		 * 코드 목록 가져오기 List<?> 코드리스트변수명 = cmmnService.selectCodeList("테이블종류","상위코드");
		 * 테이블종류 : CMMN -> 공통코드 , PRODUCT -> 상품코드, AREA -> 행정구역코드
		 * */
		//
		List<?> codeList = cmmnService.selectCodeList("CMMN","CM00200000");
		model.addAttribute("codeList",codeList);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		
		//샘플 페이지 이동
		return "gzonei/sample/sampleGuide";
	}
	
	@RequestMapping(value="/sample/selectBbsRegPage.do")
	public String selectBbsRegPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		List<?> resultList = sampleService.selectSampleList(searchVO);
		
		/*
		 * 코드 목록 가져오기 List<?> 코드리스트변수명 = cmmnService.selectCodeList("테이블종류","상위코드");
		 * 테이블종류 : CMMN -> 공통코드 , PRODUCT -> 상품코드, AREA -> 행정구역코드
		 * */
		//
		List<?> codeList = cmmnService.selectCodeList("CMMN","CM00200000");
		model.addAttribute("codeList",codeList);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		
		//샘플 페이지 이동
		return "gzonei/sample/sampleBbsReg";
	}
	
	@RequestMapping(value="/sample/selectFormPage.do")
	public String selectFormPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		
		EgovMap searchVO = new EgovMap();
		if(null != request.getParameter("codeIdNm") && !"".equals(request.getParameter("codeIdNm"))) {
			searchVO.put("codeIdNm", request.getParameter("codeIdNm"));
		}else {
			searchVO.put("codeIdNm", "");
		}
		
		List<?> resultList = sampleService.selectSampleList(searchVO);
		
		/*
		 * 코드 목록 가져오기 List<?> 코드리스트변수명 = cmmnService.selectCodeList("테이블종류","상위코드");
		 * 테이블종류 : CMMN -> 공통코드 , PRODUCT -> 상품코드, AREA -> 행정구역코드
		 * */
		//
		List<?> codeList = cmmnService.selectCodeList("CMMN","CM00200000");
		model.addAttribute("codeList",codeList);
		
		model.addAttribute("searchVO",searchVO);
		model.addAttribute("resultList",resultList);
		
		//샘플 페이지 이동
		return "gzonei/sample/sampleForm";
	}
	
	//페이지 붙여야함
	@RequestMapping(value="/sample/selectMapPage.do")
	public String selectMapPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//지도 샘플 페이지 이동
		return "gzonei/sample/samplePMap";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectJoinPage.do")
	public String selectJoinPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//가입 샘플 페이지 이동
		return "gzonei/sample/sampleJoin";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectJoinUdtPage.do")
	public String selectJoinUdtPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//가입 수정 샘플 페이지 이동
		return "gzonei/sample/sampleJoinUdt";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectBizJoinPage.do")
	public String selectBizJoinPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//사업자 가입 샘플 페이지 이동
		return "gzonei/sample/sampleBizJoin";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectMyPage.do")
	public String selectMyPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//마이페이지 샘플 페이지 이동
		return "gzonei/sample/sampleMy";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectOutPage.do")
	public String selectOutPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//회원탈퇴 샘플 페이지 이동
		return "gzonei/sample/sampleOut";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectAgreePage.do")
	public String selectAgreePage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//가입동의 샘플 페이지 이동
		return "gzonei/sample/sampleAgree";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectPayPage.do")
	public String selectPayPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//Pay 샘플 페이지 이동
		return "gzonei/sample/samplePay";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectAugmentPage.do")
	public String selectAugmentPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//Pay 샘플 페이지 이동
		return "gzonei/sample/sampleAugment";
	}
	
	//샘플View에 링크 걸기
	@RequestMapping(value="/sample/selectBannerPage.do")
	public String selectBannerPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//Pay 샘플 페이지 이동
		return "gzonei/sample/sampleBanner";
	}
	
	//샘플코드 관리
	@RequestMapping(value="/sample/selectCodeMngPage.do")
	public String selectCodeMngPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//Pay 샘플 페이지 이동
		return "gzonei/sample/sampleCodeMng";
	}
	
	//샘플권한 관리
	@RequestMapping(value="/sample/selectAuthPage.do")
	public String selectAuthPage(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		//Pay 샘플 페이지 이동
		return "gzonei/sample/sampleAuthMng";
	}
}
