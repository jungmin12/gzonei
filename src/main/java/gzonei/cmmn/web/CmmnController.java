package gzonei.cmmn.web;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gzonei.cmmn.util.MediaUtils;

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
public class CmmnController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CmmnController.class);
	
	@RequestMapping(value="/popup/jusoPopup.do")
	public String searchJuso(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/popup/jusoPopup";
	}
	
	//푸터-회사소개 페이지 1001
	@RequestMapping(value="/design/cmpnyIntrcnView.do")
	public String cmpnyIntrcnView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/cmpnyIntrcnView";
	}
	//푸터-연혁 페이지 1002
	@RequestMapping(value="/design/cmpnyHistView.do")
	public String cmpnyHistView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/cmpnyHistView";
	}
	//푸터-이용약관 페이지 1003
	@RequestMapping(value="/design/useStplatView.do")
	public String useStplatView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/useStplatView";
	}
	//푸터-개인정보취급방침 페이지 1004
	@RequestMapping(value="/design/indvdlinfoPolcyView.do")
	public String indvdlinfoPolcyView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/indvdlinfoPolcyView";
	}
	//푸터-광고,업무제휴문의 페이지 1005
	@RequestMapping(value="/design/advrtsCoprtnView.do")
	public String advrtsCoprtnView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/advrtsCoprtnView";
	}
	//서비스안내-서비스전체보기 페이지 0903
	@RequestMapping(value="/design/sitemapView.do")
	public String sitemapView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/sitemapView";
	}
	//부가서비스-유용한사이트 페이지 0703
	@RequestMapping(value="/design/usfulSiteView.do")
	public String usfulSiteView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/usfulSiteView";
	}
	//부가서비스-토지보상검토의뢰 페이지 0704
	@RequestMapping(value="/design/ladRewardView.do")
	public String ladRewardView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/ladRewardView";
	}
	//서비스안내-이용안내 페이지 0901
	@RequestMapping(value="/design/useGuidanceView.do")
	public String useGuidanceView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/useGuidanceView";
	}
	//서비스안내-요금안내 페이지 0902
	@RequestMapping(value="/design/chrgeGuidanceView.do")
	public String chrgeGuidanceView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/chrgeGuidanceView";
	}
	//메인-개발정보 무료정보 01 페이지 sample_0101
	@RequestMapping(value="/design/devlopFree01View.do")
	public String devlopFree01View(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/devlopFree01View";
	}
	//메인-개발정보 무료정보 02 페이지 sample_0102
	@RequestMapping(value="/design/devlopFree02View.do")
	public String devlopFree02View(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/devlopFree02View";
	}
	//메인-개발정보 무료정보 03 페이지 sample_0103
	@RequestMapping(value="/design/devlopFree03View.do")
	public String devlopFree03View(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/devlopFree03View";
	}
	//메인-개발정보 무료정보 04 페이지 sample_0104
	@RequestMapping(value="/design/devlopFree04View.do")
	public String devlopFree04View(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/devlopFree04View";
	}
	//메인-투자정보 무료정보 페이지 sample_0201
	@RequestMapping(value="/design/invtFreeView.do")
	public String invtFreeView(HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException , IOException{
		return "gzonei/design/invtFreeView";
	}
	
	@ResponseBody // view가 아닌 data리턴
    @RequestMapping(value="/file/displayFile.do")
    public ResponseEntity<byte[]> displayFile(String filePath, String fileName) throws Exception {
        // 서버의 파일을 다운로드하기 위한 스트림
        InputStream in = null; //java.io
        ResponseEntity<byte[]> entity = null;
        String name = fileName;
        String path = filePath;
        try {
            // 확장자를 추출하여 formatName에 저장
            String formatName = name.substring(name.lastIndexOf(".") + 1);
            // 추출한 확장자를 MediaUtils클래스에서  이미지파일여부를 검사하고 리턴받아 mType에 저장
            MediaType mType = MediaUtils.getMediaType(formatName);
            // 헤더 구성 객체(외부에서 데이터를 주고받을 때에는 header와 body를 구성해야하기 때문에)
            HttpHeaders headers = new HttpHeaders();
            // InputStream 생성
            String lastStr = path.substring(path.length() - 1, path.length());
            // path 마지막이 "\"이 아니면
            if(lastStr != "\\" && !lastStr.equals("\\")) {
            	in = new FileInputStream(path);
            // path 마지막이 "\"이면  
            } else {
            	in = new FileInputStream(path);
            }
            // 이미지 파일이면
            if (mType != null) { 
                headers.setContentType(mType);
            // 이미지가 아니면
            } else { 
               name = name.substring(name.indexOf("_") + 1);
                // 다운로드용 컨텐트 타입
                headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
                // 
                // 바이트배열을 스트링으로 : new String(fileName.getBytes("utf-8"),"iso-8859-1") * iso-8859-1 서유럽언어, 큰 따옴표 내부에  " \" 내용 \" "
                // 파일의 한글 깨짐 방지
                headers.add("Content-Disposition", "attachment; filename=\""+new String(name.getBytes("utf-8"), "iso-8859-1")+"\"");
                //headers.add("Content-Disposition", "attachment; filename='"+fileName+"'");
            }
            // 바이트배열, 헤더, HTTP상태코드
            entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            // HTTP상태 코드()
            entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
        } finally {
            in.close(); //스트림 닫기
        }
        return entity;
    }
	
}
