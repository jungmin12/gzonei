package gzonei.oper.web;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MultiHashMap;
import org.apache.commons.collections.MultiMap;
import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import gzonei.cmmn.service.CmmnService;
import gzonei.cmmn.service.FileUtilService;
import gzonei.cmmn.util.FileUtils;
import gzonei.oper.service.DevBestService;

@Controller
public class DevBestController {
	
	
    /** CmmnService */
    @Resource(name = "cmmnService")
    private CmmnService cmmnService;
    
	@Resource(name="DevBestService")
	private DevBestService devbestservice;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    private EgovPropertyService propertiesService;
    
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
    @Resource(name="FileUtils")
	private FileUtils fileUtils;
    
	final String gPath = EgovProperties.getProperty("upload.files.develop.path");
	final String gSubPath = EgovProperties.getProperty("upload.files.develop_sub.path");

    //?????? best????????? ??????
    @RequestMapping(value="/oper/selectDevBestList.do")
    public String selectDevBestList(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
   	 //????????? ?????? ?????? ??????-------(admin?????????)
        EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
        EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
        EgovMap authInfo = new EgovMap();
        String accessAuth = "";
        String gradInfo = "";
        //?????? ??????indvdlMberCode=CM00210002
        EgovMap redirectInfo = new EgovMap();
        //???????????? 
        if(auth!=null) {
			authInfo =  (EgovMap) auth.get("adm004004");
			accessAuth =  authInfo.get("menuAccesAt").toString();
        }    	
    	//????????? ?????? ??????
		if(session!=null) {
			gradInfo =  session.get("indvdlMberCode").toString();
			if(!gradInfo.equals("CM00210003")) {
				redirectInfo.put("message", "????????? ????????? ??? ?????????????????????.");
				redirect.addFlashAttribute("redircetResult",redirectInfo);
				return "redirect:/main.do";
			}
		}else{
			redirectInfo.put("message", "????????? ??? ?????????????????????.");
			redirect.addFlashAttribute("redircetResult",redirectInfo);
			return "redirect:/main.do"; 
		}
		//---------
    	List<?> bestList = devbestservice.selectBest();
    	model.addAttribute("bestList",bestList);
    	
    	return "gzonei/oper/devBestMgmt";
    }
    //?????? best????????? ??????
    @RequestMapping(value="/oper/selectInvtBestList.do")
    public String selectInvtBestList(RedirectAttributes redirect, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
    	//????????? ?????? ?????? ??????-------(admin?????????)
    	EgovMap session = (EgovMap) request.getSession().getAttribute("loginVO");
    	EgovMap auth = (EgovMap)request.getSession().getAttribute("authVO");
    	EgovMap authInfo = new EgovMap();
    	String accessAuth = "";
    	String gradInfo = "";
    	//?????? ??????indvdlMberCode=CM00210002
    	EgovMap redirectInfo = new EgovMap();
    	//???????????? 
    	if(auth!=null) {
    		authInfo =  (EgovMap) auth.get("adm004004");
    		accessAuth =  authInfo.get("menuAccesAt").toString();
    	}    	
    	//????????? ?????? ??????
    	if(session!=null) {
    		gradInfo =  session.get("indvdlMberCode").toString();
    		if(!gradInfo.equals("CM00210003")) {
    			redirectInfo.put("message", "????????? ????????? ??? ?????????????????????.");
    			redirect.addFlashAttribute("redircetResult",redirectInfo);
    			return "redirect:/main.do";
    		}
    	}else{
    		redirectInfo.put("message", "????????? ??? ?????????????????????.");
    		redirect.addFlashAttribute("redircetResult",redirectInfo);
    		return "redirect:/main.do"; 
    	}
    	//---------
    	List<?> bestList = devbestservice.selectBest();
    	model.addAttribute("bestList",bestList);
    	
    	return "gzonei/oper/InvtBestMgmt";
    }
    // best????????? ??????
    @RequestMapping(value="/oper/updateDevBestList.do")
    public String updateDevBestList(MultipartHttpServletRequest multi,HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
    	EgovMap insertVO = new EgovMap();
    	EgovMap oldVO = new EgovMap();
    	List<?> old = devbestservice.selectBest();
    	String date = fileUtils.getDate();
    	System.out.println("date : "+date);
    	multi.setAttribute("type", "1");
    	for(int i=1;i<=old.size();i++) {
    		MultipartHttpServletRequest multi_new = multi;
    		insertVO.clear();
    		//oldVO.clear();
    		String [] atchFileNm = request.getParameterValues("atchFileNm"+i);
//    		String atchFileNm = request.getParameter("atchFileNm"+i);
    		String [] fileAuthor = request.getParameterValues("fileAuthor"+i);
    		String atchFileId="";
    		String oldfile="";
    		String fileNm = "";
    		MultipartFile file = null;
    		MultipartHttpServletRequest requestFile = multi_new;
//    		MultipartHttpServletRequest test  = (MultipartHttpServletRequest) multi.getAttribute("atchFile_1");
    		int size = requestFile.getMultiFileMap().size();
			for(int j = 1 ; j <=size;j++) {
//				if(j != i) {
//					requestFile.getMultiFileMap().remove("atchFile_"+j);						
//				}
				fileNm = request.getParameter("atchFileNm"+i);
				oldVO = (EgovMap) old.get(j-1);
				oldfile = oldVO.get("fileNm").toString();
				System.out.println(fileNm);
				System.out.println(oldfile);
				if( j==i) {//!oldfile.equals(fileNm)&&
					//????????? ???????????? ????????? ?????? ????????? setAttribute??? ????????? ?????? ????????? ????????????
					 file = requestFile.getFile("atchFile_"+j);
					
				}
			}
			System.out.println(size);
			if(file != null) {
				atchFileId = fileUtils.insertFileOne(file,"BBS_","",atchFileNm,date,fileAuthor);				
			}
			System.out.println("test"+i +"atchFileId=" +atchFileId);
    		// ???????????? ????????? ????????????
    		String bsnsSn = request.getParameter("bsnsSn"+i);
    		String dwkNm = request.getParameter("dwkNm"+i);
    		String dwkNo = request.getParameter("dwkNo"+i);
    		String flpth = request.getParameter("flpth"+i);
    		String frstRegisterId = request.getParameter("frstRegisterId"+i);
    		String lastUpdusrId = request.getParameter("lastUpdusrId"+i);
    		String smpleManageNo = request.getParameter("smpleManageNo"+i);
    		fileNm  = request.getParameter("atchFileNm"+i);
    		oldVO = (EgovMap) old.get(i-1);
    		String oldname = "";
    		if(oldVO.get("filename") != null) {oldname=oldVO.get("filename").toString();}
    		if(atchFileId != null &&(!oldname.equals(atchFileId) || !oldVO.get("bsnsSn").toString().equals(bsnsSn))) {
    		if(bsnsSn!=null || bsnsSn != "")insertVO.put("bsnsSn", bsnsSn);    			
    		if(dwkNm!=null || dwkNm != "")insertVO.put("dwkNm", dwkNm);
    		if(dwkNo!=null || dwkNo != "")insertVO.put("dwkNo", dwkNo);
    		if(fileNm!=null || fileNm != "")insertVO.put("fileNm", fileNm);
    		if(flpth!=null || flpth != "")insertVO.put("flpth", date);
    		if(atchFileId!=null || atchFileId != "")insertVO.put("atchFileId", atchFileId);
    		System.out.println(atchFileId);
    		if(frstRegisterId!=null || frstRegisterId != "")insertVO.put("frstRegisterId", frstRegisterId);
    		if(lastUpdusrId!=null || lastUpdusrId != "")insertVO.put("lastUpdusrId", lastUpdusrId);
    		insertVO.put("smpleManageNo",smpleManageNo ); 
    		insertVO.put("seCode", "??????");
    		devbestservice.insertdevBestInfo(insertVO);
    		}
    		
    		
    	}
    	
    	return "redirect:/oper/selectDevBestList.do";
    }

	
    //?????? best????????? ??????(?????????)
    @RequestMapping(value="/free/devFreeView.do")
    public String selectDevBest(RedirectAttributes redirect,HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{

    	String smpleNo = request.getParameter("smpleNo");
    	EgovMap searchVO = new EgovMap();
    	searchVO.put("smpleManageNo", Integer.parseInt(smpleNo));
    	//?????? ??????
    	EgovMap bestFree = devbestservice.selectFree(searchVO);
    	EgovMap imageLink = devbestservice.selectImage(searchVO);
    	searchVO.put("dwkNo",bestFree.get("dwkNo"));
    	searchVO.put("cntsNo",bestFree.get("dwkNo"));
    	searchVO.put("atchFileId", bestFree.get("atchFileId"));
    	//?????? ??????
    	List<?> sttusList = devbestservice.selectSstusList(searchVO);
    	EgovMap lcNm = devbestservice.selectLc(searchVO);
    	EgovMap oldfileInfo = new EgovMap();
    	
    	String fileid = bestFree.get("devinfofileid").toString();
    	//?????? db??? ???????????? ????????? ??????
    	if(fileid.equals("old")) {
    		oldfileInfo = devbestservice.selectDevBestOldFile(searchVO);
    		model.addAttribute("oldfileInfo", oldfileInfo);
    	}else {//??? ????????? ??????
    		List<?> newfileInfo = devbestservice.selectDevBestNewFile(searchVO);
    		model.addAttribute("newfileInfo", newfileInfo);
    	}
    	model.addAttribute("lcNm", lcNm);
    	model.addAttribute("imageLink",imageLink);
    	model.addAttribute("bestFree", bestFree);
    	model.addAttribute("sttusList", sttusList);
    	return "gzonei/free/devFreeView";
    }

    //?????? ????????????
    @RequestMapping(value="/free/devFreedownload.do")
    public ResponseEntity<byte[]> downloadDevBest(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String fileStreCours= request.getParameter("filePath");
		String fullPath = gPath+fileStreCours;
		String orignlFileNm= request.getParameter("fileNm");
		System.out.println("???????????? ?????? ?????? ?????? : "+fullPath);
		System.out.println("?????? ?????? ??? : "+orignlFileNm);
		try {
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(fullPath+"/"+orignlFileNm);					
			System.out.println("???????????? ?????? ?????? ?????? : "+fullPath+"/"+orignlFileNm);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; filename=\"" + new String(orignlFileNm.getBytes("UTF-8"), "ISO-8859-1")+"\""); 
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
		return entity;
	}
    //?????? ????????????
    @RequestMapping(value="/free/devFreeSubdownload.do")
    public ResponseEntity<byte[]> subDownloadDevBest(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
    	InputStream in = null;
//    	String fileId = request.getParameter("atchFileId").toString();
    	ResponseEntity<byte[]> entity = null;
    	String fileStreCours=null;
    	String fullPath = null;
    	String orignlFileNm = null;
//    	if(fileId == "old") {
    		fileStreCours= request.getParameter("filePath");
    		fullPath = gSubPath+fileStreCours;
    		orignlFileNm= request.getParameter("fileNm");
    		System.out.println("???????????? ?????? ?????? ?????? : "+fullPath);
    		System.out.println("?????? ?????? ??? : "+orignlFileNm);
    		try {
        		HttpHeaders headers = new HttpHeaders();
        		in = new FileInputStream(fullPath+"/"+orignlFileNm);					
        		System.out.println("???????????? ?????? ?????? ?????? : "+fullPath+"/"+orignlFileNm);
        		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        		headers.add("Content-Disposition", "attachment; filename=\"" + new String(orignlFileNm.getBytes("UTF-8"), "ISO-8859-1")+"\""); 
        		entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
        	}catch(Exception e) {
        		e.printStackTrace();
        		entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
        	}finally {
        		in.close();
        	}
//    	}else {
//    		EgovMap searchVO = new EgovMap();
//    		searchVO.put("atchFileId", fileId);
//    		List<?> newFileList = devbestservice.selectDevBestNewFile(searchVO);
//    		EgovMap fileInfo = (EgovMap) newFileList.get(0);
//    			fileStreCours = fileInfo.get("atchFilePath").toString();
//    	    	fullPath = gSubPath+fileStreCours;
//    	    	orignlFileNm = fileInfo.get("fileNm").toString();
//    			try {
//    				HttpHeaders headers = new HttpHeaders();
//    				in = new FileInputStream(fullPath+"/"+orignlFileNm);					
//   					System.out.println("???????????? ?????? ?????? ?????? : "+fullPath+"/"+orignlFileNm);
//   					headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//   					headers.add("Content-Disposition", "attachment; filename=\"" + new String(orignlFileNm.getBytes("UTF-8"), "ISO-8859-1")+"\""); 
//   					entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
//   				}catch(Exception e) {
//   					e.printStackTrace();
//   					entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
//   				}finally {
//   					in.close();
//   				}
//    	}
    	return entity;
    }
         
    

    
}
