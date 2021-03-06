package gzonei.cmmn.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.poi.ss.formula.functions.Replace;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmn.service.FileUtilService;

@Repository("FileUtils")
public class FileUtils {
	
	@Resource(name = "FileUtilService")
	private FileUtilService fileUtilService;
	
	// 기본 경로
	final String path = EgovProperties.getProperty("Globals.SynchrnServerPath");
	
	
	
//	public List<FileVO> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
	public String insertFileInf(MultipartHttpServletRequest multi, String KeyStr, String atchFileId,String[] atchFileNm ,String storePath, String[] fileAuthor) throws Exception{
		EgovMap fileVO = new EgovMap();
		
		// 파일 업로드 변수 설정
		List<?> fileArr= null; // 파일 리스트
		String nowTime= getDate();
		int fileNum=0;
		String fileExt = ""; // 확장자
		String fileNameExtension = ""; // 확장자
		long fileSize; // 파일 크기
		String atchFileIdString = ""; // 첨부파일 ID
		String changeFileName = ""; // 바뀐 파일 명
		String newPath = path +storePath; // 저장경로
		String fileStreCours = ""; // 바뀐 파일 명
		Boolean editAt = false; // 수정여부

		File dir = new File(newPath);
		dir.setExecutable(true,false);
		dir.setReadable(true,false);
		dir.setWritable(true,false);
		if(!dir.isDirectory()) { // 파일 없을시 생성
			dir.mkdirs();
		}
		System.out.println("atchFileId : "+atchFileId);
		
		
		// 첨부파일 여부 확인
		if(atchFileId == null || atchFileId == "") {
			Iterator<String> testFiles = multi.getFileNames();				
			if(testFiles.hasNext() == false) { // 파일 널값 확인
				atchFileId = null;
				atchFileIdString = atchFileId;
				return atchFileIdString;
			}
			MultipartFile test = multi.getFile(testFiles.next());
			System.out.println("test : "+test);
			System.out.println("test Empty : "+test.isEmpty());
			if (test.isEmpty() == false) {
				atchFileId = UUID.randomUUID().toString();
				atchFileIdString = atchFileId.substring(19);			
				fileVO.put("atchFileId", atchFileIdString);
				fileUtilService.insertFileAtrb(fileVO);
			} else {
				atchFileId = null;
				atchFileIdString = atchFileId;
				return atchFileIdString; 
			}
		}else {
			atchFileIdString = atchFileId;
			editAt = true;
			fileVO.put("atchFileId", atchFileIdString);
			fileVO.put("delAt", 'Y');
			fileVO.put("useAt", 'N');
			// 수정할 수 있는 파일 리스트 가져오기
			fileArr = fileUtilService.selectAtchFileArray(atchFileIdString);
			
			// 모든 파일 다 수정 N으로 만들기
			fileUtilService.deleteAtchFile(fileVO);
			
			System.out.println("수정 활성화");
			System.out.println("첨부파일 아이디 : "+ atchFileIdString);
		}

		System.out.println("첨부파일 아이디: "+ atchFileIdString);
		System.out.println("newPath "+ newPath);
		
		
		Iterator<String> files = multi.getFileNames();
		
		// 다음 파일이 있으면 파일 첨부
		while(files.hasNext()) {
			String uploadFile = files.next();
			if(!uploadFile.equals("thumbFile")) {
				MultipartFile mFile = multi.getFile(uploadFile);
				
				// 파일 크기 가져오기
				fileSize = mFile.getSize();
				
				// 파일명 가져오기
				String filedName = mFile.getName();
				String fileName = mFile.getOriginalFilename();
				fileNum = Integer.parseInt(filedName.substring(filedName.lastIndexOf("_")+1));
							
				String acthFileNmString =  atchFileNm[fileNum-1];
				System.out.println("acthFileNmString : " + acthFileNmString);
				// 빈 파일인지 확인
				
				if(mFile.isEmpty() == false) {
					System.out.println("파일있음");
					
					// 파일 확장자 
					fileExt = fileName.substring(fileName.lastIndexOf("."));
					fileNameExtension = fileName.substring(fileName.lastIndexOf(".")+1);
					
					// 바꾼 파일 명 (BBS_+ 첨부파일 ID+ 확장자) 
					changeFileName = KeyStr + atchFileIdString + "_" + ((int)(Math.random()*1000000000)+1) + fileExt;
					
					// 파일 경로
					fileStreCours = newPath+"/"+ changeFileName;
					
					/* 시스템 출력 (테스트용) 삭제예정 START */
					
					System.out.println("파일 저장경로 : "+ newPath);
					System.out.println("실제파일이름 : "+ fileName);
					System.out.println("바뀐 파일 이름 : "+ changeFileName);
					System.out.println("파일크기 : "+ fileSize);
					System.out.println("파일확장자 : "+ fileNameExtension);
					
					/* 시스템 출력 (테스트용) 삭제예정 END */
					
					/* 파라미터 넣기 S */
					
					fileVO.put("fileStreCours", fileStreCours.replace("/upload/gzone/", ""));
					fileVO.put("streFileNm", changeFileName);
					fileVO.put("orignlFileNm", fileName);
					fileVO.put("fileExtsn", fileNameExtension);
					fileVO.put("fileSize", fileSize);
					fileVO.put("uploadDt", storePath);
					if(fileAuthor != null) {					
						fileVO.put("fileAuthor", fileAuthor[fileNum-1]);
					}
					
					/* 파라미터 넣기 E */
					
					// 수정여부 확인
					if(acthFileNmString.length() > 0) {
						if(editAt == true) {
							// 새로운 첨부파일 추가
							storePath = nowTime;
							newPath = path +storePath;
							System.out.println("newPath : "+newPath);
							fileStreCours = newPath+"/"+ changeFileName;
							
							System.out.println("새 저장 경로 : "+fileStreCours);
							fileVO.put("streFileNm", changeFileName);
							fileVO.put("uploadDt", storePath);
							fileVO.put("fileStreCours", fileStreCours.replace("/upload/gzone/", ""));
							fileUtilService.insertFileDetail(fileVO);
						}else {
							System.out.println("수정 안함");
							fileUtilService.insertFileDetail(fileVO);						
						}
						try {
							System.out.println("파일 경로 체크 1 : "+fileStreCours.replace("/upload/gzone/", ""));
							System.out.println("파일 경로 체크 2 : "+newPath);
							System.out.println("파일 경로 체크 2 : "+newPath);
							
							
							mFile.transferTo(new File(fileStreCours));
							
						} catch(Exception e) {
							e.printStackTrace();
						}
					}
				}else { // 파일 필드 명만 있을 때
					if(editAt == true) {
	
						System.out.println("atchfileNum : "+atchFileNm.length);
						System.out.println("fileNUm : "+fileNum);
						System.out.println("acthFileNmString : "+ acthFileNmString);
						System.out.println("acthFileNmString Length : "+ acthFileNmString.length());
						if(acthFileNmString.length() > 0) {
							String ss = String.valueOf(((ListOrderedMap) fileArr.get(fileNum-1)).get("fileSn"));
							System.out.println("fileSn이 "+ss+"인 파일을 수정해야 된다.");
							fileVO.put("fileSn", ss);
							fileVO.put("delAt", 'N');
							fileVO.put("fileAuthor", fileAuthor[fileNum-1]);
							fileVO.put("useAt", 'Y');
							fileUtilService.deleteAtchFile(fileVO);
						}
					}
				}
			}
		}
			
		try {
			Runtime.getRuntime().exec("chmod -R 777 /upload/gzone/images/file");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return atchFileIdString;
	}
	
	// 현재 시간 가져오기
	public String getDate() {
		String rtnStr = null;

		// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
		String pattern = "YYYY/MM/dd";

		SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern);
		Date date = new Date();

		rtnStr = sdfCurrent.format(date);

		return rtnStr;
	}
	// 현재 시간 가져오기
	public String getUploadTime() {
		String rtnStr = null;

		// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
		String pattern = "YYYYMMddhhmmss";

		SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern);
		Date date = new Date();

		rtnStr = sdfCurrent.format(date);

		return rtnStr;
	}
	
	
	public String insertFileOne(MultipartFile file, String KeyStr, String atchFileId,String[] atchFileNm ,String storePath, String[] fileAuthor) throws Exception{
		EgovMap fileVO = new EgovMap();
		
		// 파일 업로드 변수 설정
		List<?> fileArr= null; // 파일 리스트
		String nowTime= getDate();
		int fileNum=0;
		String fileExt = ""; // 확장자
		String fileNameExtension = ""; // 확장자
		long fileSize; // 파일 크기
		String atchFileIdString = ""; // 첨부파일 ID
		String changeFileName = ""; // 바뀐 파일 명
		String newPath = path +storePath; // 저장경로
		String fileStreCours = ""; // 바뀐 파일 명
		Boolean editAt = false; // 수정여부
		int fileCount=1;
		File dir = new File(newPath);
		dir.setExecutable(true,false);
		dir.setReadable(true,false);
		dir.setWritable(true,false);
		if(!dir.isDirectory()) { // 파일 없을시 생성
			dir.mkdirs();
		}
		System.out.println("atchFileId : "+atchFileId);
		
		
		// 첨부파일 여부 확인
		if(atchFileId == null || atchFileId == "") {
			String testFiles = file.getOriginalFilename();				
			if(testFiles == null) { // 파일 널값 확인
				atchFileId = null;
				atchFileIdString = atchFileId;
				return atchFileIdString;
			}
			MultipartFile test = file;
			System.out.println("test : "+test);
			System.out.println("test Empty : "+test.isEmpty());
			if (test.isEmpty() == false) {
				atchFileId = UUID.randomUUID().toString();
				atchFileIdString = atchFileId.substring(19);			
				fileVO.put("atchFileId", atchFileIdString);
				fileUtilService.insertFileAtrb(fileVO);
			} else {
				atchFileId = null;
				atchFileIdString = atchFileId;
				return atchFileIdString; 
			}
		}else {
			atchFileIdString = atchFileId;
			editAt = true;
			fileVO.put("atchFileId", atchFileIdString);
			fileVO.put("delAt", 'Y');
			fileVO.put("useAt", 'N');
			// 수정할 수 있는 파일 리스트 가져오기
			fileArr = fileUtilService.selectAtchFileArray(atchFileIdString);
			
			// 모든 파일 다 수정 N으로 만들기
			fileUtilService.deleteAtchFile(fileVO);
			
			System.out.println("수정 활성화");
			System.out.println("첨부파일 아이디 : "+ atchFileIdString);
		}

		System.out.println("첨부파일 아이디: "+ atchFileIdString);
		System.out.println("newPath "+ newPath);
		
		
		
		// 다음 파일이 있으면 파일 첨부

					System.out.println(fileCount);
					String uploadFile = file.getOriginalFilename();
					MultipartFile mFile = file;
					
					// 파일 크기 가져오기
					fileSize = mFile.getSize();
					
					// 파일명 가져오기
					String fileName = mFile.getOriginalFilename();
					
					String acthFileNmString =  fileName;
					System.out.println("acthFileNmString : " + acthFileNmString);
					// 빈 파일인지 확인
					
					if(mFile.isEmpty() == false) {
						System.out.println("파일있음");
						
						// 파일 확장자 
						fileExt = fileName.substring(fileName.lastIndexOf("."));
						fileNameExtension = fileName.substring(fileName.lastIndexOf(".")+1);
						
						// 바꾼 파일 명 (BBS_+ 첨부파일 ID+ 확장자) 
						changeFileName = KeyStr + atchFileIdString + fileExt;
						
						// 파일 경로
						fileStreCours = newPath+"/"+ changeFileName;
						
						/* 시스템 출력 (테스트용) 삭제예정 START */
						
						System.out.println("파일 저장경로 : "+ newPath);
						System.out.println("실제파일이름 : "+ fileName);
						System.out.println("바뀐 파일 이름 : "+ changeFileName);
						System.out.println("파일크기 : "+ fileSize);
						System.out.println("파일확장자 : "+ fileNameExtension);
						
						/* 시스템 출력 (테스트용) 삭제예정 END */
						
						/* 파라미터 넣기 S */
						
						fileVO.put("fileStreCours", fileStreCours.replace("/upload/gzone/", ""));
						fileVO.put("streFileNm", changeFileName);
						fileVO.put("orignlFileNm", fileName);
						fileVO.put("fileExtsn", fileNameExtension);
						fileVO.put("fileSize", fileSize);
						fileVO.put("uploadDt", storePath);
						if(fileAuthor != null) {					
							fileVO.put("fileAuthor", fileAuthor[fileNum-1]);
						}
						
						/* 파라미터 넣기 E */
						
						// 수정여부 확인
						if(acthFileNmString.length() > 0) {
							if(editAt == true) {
								// 새로운 첨부파일 추가
								storePath = nowTime;
								newPath = path +storePath;
								System.out.println("newPath : "+newPath);
								fileStreCours = newPath+"/"+ changeFileName;
								
								System.out.println("새 저장 경로 : "+fileStreCours);
								fileVO.put("streFileNm", changeFileName);
								fileVO.put("uploadDt", storePath);
								fileVO.put("fileStreCours", fileStreCours.replace("/upload/gzone/", ""));
								fileUtilService.insertFileDetail(fileVO);
							}else {
								System.out.println("수정 안함");
								fileUtilService.insertFileDetail(fileVO);						
							}
							try {
								System.out.println("파일 경로 체크 1 : "+fileStreCours.replace("/upload/gzone/", ""));
								System.out.println("파일 경로 체크 2 : "+newPath);
								System.out.println("파일 경로 체크 2 : "+newPath);
								
								
								mFile.transferTo(new File(fileStreCours));
								
							} catch(Exception e) {
								e.printStackTrace();
							}
						}
					}else { // 파일 필드 명만 있을 때
						if(editAt == true) {
							
							System.out.println("atchfileNum : "+atchFileNm.length);
							System.out.println("fileNUm : "+fileNum);
							System.out.println("acthFileNmString : "+ acthFileNmString);
							System.out.println("acthFileNmString Length : "+ acthFileNmString.length());
							if(acthFileNmString.length() > 0) {
								String ss = String.valueOf(((ListOrderedMap) fileArr.get(fileNum-1)).get("fileSn"));
								System.out.println("fileSn이 "+ss+"인 파일을 수정해야 된다.");
								fileVO.put("fileSn", ss);
								fileVO.put("delAt", 'N');
								fileVO.put("fileAuthor", fileAuthor[fileNum-1]);
								fileVO.put("useAt", 'Y');
								fileUtilService.deleteAtchFile(fileVO);
							}
						}
					}
		try {
			Runtime.getRuntime().exec("chmod -R 777 /upload/gzone/images/file");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return atchFileIdString;
	}
	
	public String insertThumbFileInf(MultipartHttpServletRequest multi, String KeyStr, String thumbFileId, String[] atchFileNm ,String storePath, String[] fileAuthor) throws Exception{
		EgovMap fileVO = new EgovMap();
		
		// 파일 업로드 변수 설정
		List<?> fileArr= null; // 파일 리스트
		String nowTime= getDate();
		int fileNum=0;
		String fileExt = ""; // 확장자
		String fileNameExtension = ""; // 확장자
		long fileSize; // 파일 크기
		String atchFileIdString = ""; // 첨부파일 ID
		String changeFileName = ""; // 바뀐 파일 명
		String newPath = path +storePath; // 저장경로
		String fileStreCours = ""; // 바뀐 파일 명
		Boolean editAt = false; // 수정여부

		File dir = new File(newPath);
		dir.setExecutable(true,false);
		dir.setReadable(true,false);
		dir.setWritable(true,false);
		if(!dir.isDirectory()) { // 파일 없을시 생성
			dir.mkdirs();
		}
		System.out.println("atchFileId : "+thumbFileId);
		
		
		// 첨부파일 여부 확인
		if(thumbFileId == null || thumbFileId == "") {
			Iterator<String> testFiles = multi.getFileNames();				
			if(testFiles.hasNext() == false) { // 파일 널값 확인
				thumbFileId = null;
				atchFileIdString = thumbFileId;
				return atchFileIdString;
			}
			MultipartFile test = multi.getFile(testFiles.next());
			System.out.println("test : "+test);
			System.out.println("test Empty : "+test.isEmpty());
			if (test.isEmpty() == false) {
				thumbFileId = UUID.randomUUID().toString();
				atchFileIdString = thumbFileId.substring(19);			
				fileVO.put("atchFileId", atchFileIdString);
				fileUtilService.insertFileAtrb(fileVO);
			} else {
				thumbFileId = null;
				atchFileIdString = thumbFileId;
				return atchFileIdString; 
			}
		}else {
			atchFileIdString = thumbFileId;
			editAt = true;
			fileVO.put("atchFileId", atchFileIdString);
			fileVO.put("delAt", 'Y');
			fileVO.put("useAt", 'N');
			// 수정할 수 있는 파일 리스트 가져오기
			fileArr = fileUtilService.selectAtchFileArray(atchFileIdString);
			
			// 모든 파일 다 수정 N으로 만들기
			fileUtilService.deleteAtchFile(fileVO);
			
			System.out.println("수정 활성화");
			System.out.println("첨부파일 아이디 : "+ atchFileIdString);
		}

		System.out.println("첨부파일 아이디: "+ atchFileIdString);
		System.out.println("newPath "+ newPath);
		
		
		Iterator<String> files = multi.getFileNames();
		
		// 다음 파일이 있으면 파일 첨부
		while(files.hasNext()) {
			String uploadFile = files.next();
			if(uploadFile.equals("thumbFile")) {
				MultipartFile mFile = multi.getFile(uploadFile);
				
				// 파일 크기 가져오기
				fileSize = mFile.getSize();
				
				// 파일명 가져오기
				String filedName = mFile.getName();
				String fileName = mFile.getOriginalFilename();
				fileNum = 1;
							
				String acthFileNmString =  atchFileNm[fileNum-1];
				System.out.println("acthFileNmString : " + acthFileNmString);
				// 빈 파일인지 확인
				
				if(mFile.isEmpty() == false) {
					System.out.println("파일있음");
					
					// 파일 확장자 
					fileExt = fileName.substring(fileName.lastIndexOf("."));
					fileNameExtension = fileName.substring(fileName.lastIndexOf(".")+1);
					
					// 바꾼 파일 명 (BBS_+ 첨부파일 ID+ 확장자) 
					changeFileName = KeyStr + atchFileIdString + fileExt;
					
					// 파일 경로
					fileStreCours = newPath+"/"+ changeFileName;
					
					/* 시스템 출력 (테스트용) 삭제예정 START */
					
					System.out.println("파일 저장경로 : "+ newPath);
					System.out.println("실제파일이름 : "+ fileName);
					System.out.println("바뀐 파일 이름 : "+ changeFileName);
					System.out.println("파일크기 : "+ fileSize);
					System.out.println("파일확장자 : "+ fileNameExtension);
					
					/* 시스템 출력 (테스트용) 삭제예정 END */
					
					/* 파라미터 넣기 S */
					
					fileVO.put("fileStreCours", fileStreCours.replace("/upload/gzone/", ""));
					fileVO.put("streFileNm", changeFileName);
					fileVO.put("orignlFileNm", fileName);
					fileVO.put("fileExtsn", fileNameExtension);
					fileVO.put("fileSize", fileSize);
					fileVO.put("uploadDt", storePath);
					if(fileAuthor != null) {					
						fileVO.put("fileAuthor", fileAuthor[fileNum-1]);
					}
					
					/* 파라미터 넣기 E */
					
					// 수정여부 확인
					if(acthFileNmString.length() > 0) {
						if(editAt == true) {
							// 새로운 첨부파일 추가
							storePath = nowTime;
							newPath = path +storePath;
							System.out.println("newPath : "+newPath);
							fileStreCours = newPath+"/"+ changeFileName;
							
							System.out.println("새 저장 경로 : "+fileStreCours);
							fileVO.put("streFileNm", changeFileName);
							fileVO.put("uploadDt", storePath);
							fileVO.put("fileStreCours", fileStreCours.replace("/upload/gzone/", ""));
							fileUtilService.insertFileDetail(fileVO);
						}else {
							System.out.println("수정 안함");
							fileUtilService.insertFileDetail(fileVO);						
						}
						try {
							System.out.println("파일 경로 체크 1 : "+fileStreCours.replace("/upload/gzone/", ""));
							System.out.println("파일 경로 체크 2 : "+newPath);
							System.out.println("파일 경로 체크 2 : "+newPath);
							
							
							mFile.transferTo(new File(fileStreCours));
							
						} catch(Exception e) {
							e.printStackTrace();
						}
					}
				}else { // 파일 필드 명만 있을 때
					if(editAt == true) {
	
						System.out.println("atchfileNum : "+atchFileNm.length);
						System.out.println("fileNUm : "+fileNum);
						System.out.println("acthFileNmString : "+ acthFileNmString);
						System.out.println("acthFileNmString Length : "+ acthFileNmString.length());
						if(acthFileNmString.length() > 0) {
							String ss = String.valueOf(((ListOrderedMap) fileArr.get(fileNum-1)).get("fileSn"));
							System.out.println("fileSn이 "+ss+"인 파일을 수정해야 된다.");
							fileVO.put("fileSn", ss);
							fileVO.put("delAt", 'N');
							fileVO.put("fileAuthor", fileAuthor[fileNum-1]);
							fileVO.put("useAt", 'Y');
							fileUtilService.deleteAtchFile(fileVO);
						}
					}
				}
			}
		}
			
		try {
			Runtime.getRuntime().exec("chmod -R 777 /upload/gzone/images/file");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return atchFileIdString;
	}
	
	public String insertDevFileInf(MultipartHttpServletRequest multi, String KeyStr, String atchFileId, String[] atchFileNm ,String storePath, String[] fileAuthor) throws Exception{
		EgovMap fileVO = new EgovMap();
		
		// 파일 업로드 변수 설정
		List<?> fileArr= null; // 파일 리스트
		String nowTime= getDate();
		int fileNum=0;
		String fileExt = ""; // 확장자
		String fileNameExtension = ""; // 확장자
		long fileSize; // 파일 크기
		String atchFileIdString = ""; // 첨부파일 ID
		String changeFileName = ""; // 바뀐 파일 명
		String newPath = path +storePath; // 저장경로
		String fileStreCours = ""; // 바뀐 파일 명
		Boolean editAt = false; // 수정여부

		File dir = new File(newPath);
		dir.setExecutable(true,false);
		dir.setReadable(true,false);
		dir.setWritable(true,false);
		if(!dir.isDirectory()) { // 파일 없을시 생성
			dir.mkdirs();
		}
		System.out.println("atchFileId : "+atchFileId);
		
		
		// 첨부파일 여부 확인
		if(atchFileId == null || atchFileId == "") {
			Iterator<String> testFiles = multi.getFileNames();				
			if(testFiles.hasNext() == false) { // 파일 널값 확인
				atchFileId = null;
				atchFileIdString = atchFileId;
				return atchFileIdString;
			}
			MultipartFile test = multi.getFile("atchFile_1");
			System.out.println("test : "+test);
			System.out.println("test Empty : "+test.isEmpty());
			if (test.isEmpty() == false) {
				atchFileId = UUID.randomUUID().toString();
				atchFileIdString = atchFileId.substring(19);			
				fileVO.put("atchFileId", atchFileIdString);
				fileUtilService.insertFileAtrb(fileVO);
			}else {
				atchFileId = null;
				atchFileIdString = atchFileId;
				return atchFileIdString; 
			}
		}else {
			atchFileIdString = atchFileId;
			editAt = true;
			fileVO.put("atchFileId", atchFileIdString);
			fileVO.put("delAt", 'Y');
			fileVO.put("useAt", 'N');
			// 수정할 수 있는 파일 리스트 가져오기
			fileArr = fileUtilService.selectAtchFileArray(atchFileIdString);
			
			// 모든 파일 다 수정 N으로 만들기
			fileUtilService.deleteAtchFile(fileVO);
			
			System.out.println("수정 활성화");
			System.out.println("첨부파일 아이디 : "+ atchFileIdString);
		}

		System.out.println("첨부파일 아이디: "+ atchFileIdString);
		System.out.println("newPath "+ newPath);
		
		Iterator<String> files = multi.getFileNames();
		
		// 다음 파일이 있으면 파일 첨부
		while(files.hasNext()) {
			String uploadFile = files.next();
			if(!uploadFile.equals("thumbFile")) {
				MultipartFile mFile = multi.getFile(uploadFile);
				
				// 파일 크기 가져오기
				fileSize = mFile.getSize();
				
				// 파일명 가져오기
				String filedName = mFile.getName();
				String fileName = mFile.getOriginalFilename();
				fileNum = Integer.parseInt(filedName.substring(filedName.lastIndexOf("_")+1));
							
				String acthFileNmString =  atchFileNm[fileNum-1];
				System.out.println("acthFileNmString : " + acthFileNmString);
				// 빈 파일인지 확인
				
				if(mFile.isEmpty() == false) {
					System.out.println("파일있음");
					
					// 파일 확장자 
					fileExt = fileName.substring(fileName.lastIndexOf("."));
					fileNameExtension = fileName.substring(fileName.lastIndexOf(".")+1);
					
					// 바꾼 파일 명 (BBS_+ 첨부파일 ID+ 확장자) 
					changeFileName = KeyStr + atchFileIdString + "_" + ((int)(Math.random()*1000000000)+1) + fileExt;
					
					// 파일 경로
					fileStreCours = newPath+"/"+ changeFileName;
					
					/* 시스템 출력 (테스트용) 삭제예정 START */
					
					System.out.println("파일 저장경로 : "+ newPath);
					System.out.println("실제파일이름 : "+ fileName);
					System.out.println("바뀐 파일 이름 : "+ changeFileName);
					System.out.println("파일크기 : "+ fileSize);
					System.out.println("파일확장자 : "+ fileNameExtension);
					
					/* 시스템 출력 (테스트용) 삭제예정 END */
					
					/* 파라미터 넣기 S */
					
					fileVO.put("fileStreCours", fileStreCours.replace("/upload/gzone/", ""));
					fileVO.put("streFileNm", changeFileName);
					fileVO.put("orignlFileNm", fileName);
					fileVO.put("fileExtsn", fileNameExtension);
					fileVO.put("fileSize", fileSize);
					fileVO.put("uploadDt", storePath);
					if(fileAuthor != null) {					
						fileVO.put("fileAuthor", fileAuthor[fileNum-1]);
					}
					
					/* 파라미터 넣기 E */
					
					// 수정여부 확인
					if(acthFileNmString.length() > 0) {
						if(editAt == true) {
							// 새로운 첨부파일 추가
							storePath = nowTime;
							newPath = path +storePath;
							System.out.println("newPath : "+newPath);
							fileStreCours = newPath+"/"+ changeFileName;
							
							System.out.println("새 저장 경로 : "+fileStreCours);
							fileVO.put("streFileNm", changeFileName);
							fileVO.put("uploadDt", storePath);
							fileVO.put("fileStreCours", fileStreCours.replace("/upload/gzone/", ""));
							fileUtilService.insertFileDetail(fileVO);
						}else {
							System.out.println("수정 안함");
							fileUtilService.insertFileDetail(fileVO);						
						}
						try {
							System.out.println("파일 경로 체크 1 : "+fileStreCours.replace("/upload/gzone/", ""));
							System.out.println("파일 경로 체크 2 : "+newPath);
							System.out.println("파일 경로 체크 2 : "+newPath);
							
							
							mFile.transferTo(new File(fileStreCours));
							
						} catch(Exception e) {
							e.printStackTrace();
						}
					}
				}else { // 파일 필드 명만 있을 때
					if(editAt == true) {
	
						System.out.println("atchfileNum : "+atchFileNm.length);
						System.out.println("fileNUm : "+fileNum);
						System.out.println("acthFileNmString : "+ acthFileNmString);
						System.out.println("acthFileNmString Length : "+ acthFileNmString.length());
						if(acthFileNmString.length() > 0) {
							String ss = String.valueOf(((ListOrderedMap) fileArr.get(fileNum-1)).get("fileSn"));
							System.out.println("fileSn이 "+ss+"인 파일을 수정해야 된다.");
							fileVO.put("fileSn", ss);
							fileVO.put("delAt", 'N');
							fileVO.put("fileAuthor", fileAuthor[fileNum-1]);
							fileVO.put("useAt", 'Y');
							fileUtilService.deleteAtchFile(fileVO);
						}
					}
				}
			}
		}
			
		try {
			Runtime.getRuntime().exec("chmod -R 777 /upload/gzone/images/file");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return atchFileIdString;
	}
}
