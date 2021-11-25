package gzonei.cmmn.web;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmn.service.FileUtilService;

@Controller
public class FileUtilController {
	
	// 첨부파일 다운로드
		@RequestMapping(value = "/cmmn/downloadFile.do")
		public ResponseEntity<byte[]> downloadFile(HttpServletRequest request, HttpServletResponse response, Model model)throws Exception{
			InputStream in = null;
			ResponseEntity<byte[]> entity = null;
			String fileStreCours= request.getParameter("fileStreCours");
			String orignlFileNm= request.getParameter("orignlFileNm");
			System.out.println("다운로드 받는 파일 경로 : "+fileStreCours);
			System.out.println("진짜 파일 명 : "+orignlFileNm);
			try {
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				String header = request.getHeader("User-Agent");
				if(header.contains("MSIE")||header.contains("Trident")) {
					headers.add("Content-Disposition", "attachment; filename=" + URLEncoder.encode(orignlFileNm,"UTF-8").replaceAll("\\+", "%20")+";");
				}else {
					headers.add("Content-Disposition", "attachment; filename=\"" + new String(orignlFileNm.getBytes("UTF-8"), "ISO-8859-1")+"\"");
				}
				if(fileStreCours.substring(0, 12).contains("images/file")) {
					fileStreCours = "/upload/gzone/" + fileStreCours;
				}
				in = new FileInputStream(fileStreCours);					
				System.out.println("다운로드 받는 파일 경로 : "+fileStreCours);
				
				
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
			}catch(Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			}finally {
				in.close();
			}
			return entity;
		}
		
		
						
}
