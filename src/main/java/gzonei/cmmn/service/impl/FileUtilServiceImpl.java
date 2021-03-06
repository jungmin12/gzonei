package gzonei.cmmn.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmn.service.FileUtilService;
import gzonei.cmmn.service.impl.FileUtilDAO;
import gzonei.devlopInfo.service.impl.DevlopInfoServiceImpl;

@Service("FileUtilService")
public class FileUtilServiceImpl implements FileUtilService {
	private static final Logger LOGGER = LoggerFactory.getLogger(DevlopInfoServiceImpl.class);
	
	@Resource(name="FileUtilDAO")
	private FileUtilDAO fileUtilDAO;
	
	// 첨부파일 속성 넣기
	@Override
	public List<?> insertFileAtrb(EgovMap map) throws Exception {
		return fileUtilDAO.insertFileAtrb(map);
	}
	// 파일 상세정보 넣기
	@Override
	public List<?> insertFileDetail(EgovMap map) throws Exception {
		return fileUtilDAO.insertFileDetail(map);
	}
	
	// 수정할 수 있는 파일 리스트 조회
	@Override
	public List<?> selectAtchFileArray(String atchFileId) {
		return fileUtilDAO.selectAtchFileArray(atchFileId);
	}
		
	// 첨부파일 아이디 조회
	@Override
	public String selectAtchFileId(EgovMap map) {
		return fileUtilDAO.selectAtchFileId(map);
	}
	
	// 첨부파일 상세정보 조회
	@Override
	public List<?> selectAtchFileDetail(String atchFileId) {
		return fileUtilDAO.selectAtchFileDetail(atchFileId);
	}
	
	
	//첨부파일명 조회
	@Override
	public EgovMap selectAtchFileNm(EgovMap map) {
		return fileUtilDAO.selectAtchFileNm(map);
	}
	
	// 첨부파일 속성 삭제
	@Override
	public void deleteAtchFileAtrb(EgovMap map) {
		fileUtilDAO.deleteAtchFileAtrb(map);
	}
	
	// 첨부파일 삭제
	@Override
	public void deleteAtchFile(EgovMap map) throws Exception {
		fileUtilDAO.deleteAtchFile(map);
		
	}
}
