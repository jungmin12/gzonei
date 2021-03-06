package gzonei.cmmn.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("FileUtilDAO")
public class FileUtilDAO extends EgovComAbstractDAO {
	
	// 첨부파일 속성 등록
	public List<?> insertFileAtrb(EgovMap map) throws Exception {
		return selectList("FileUtilDAO.insertFileAtrb", map);
	}
	
	// 첨부파일 상세정보 등록
	public List<?> insertFileDetail(EgovMap map) throws Exception {
		return selectList("FileUtilDAO.insertFileDetail", map);
	}
	// 수정할 수 있는 파일 리스트 조회
	public List<?> selectAtchFileArray(String atchFileId) {
		return selectList("FileUtilDAO.selectAtchFileArray", atchFileId);
	}
		
	// 첨부파일 아이디 조회
	public String selectAtchFileId(EgovMap map) {
		return selectOne("FileUtilDAO.selectAtchFileId", map);
	}
	
	// 첨부파일 상세정보 조회
	public List<?> selectAtchFileDetail(String atchFileId) {
		return selectList("FileUtilDAO.selectAtchFileDetail", atchFileId);
	}
	
	 //첨부파일명 조회
	public EgovMap selectAtchFileNm(EgovMap map) {
		return selectOne("FileUtilDAO.selectAtchFileNm", map);
	}

	// 첨부파일 속성 삭제
	public void deleteAtchFileAtrb(EgovMap map) {
		update("FileUtilDAO.deleteAtchFileAtrb", map);
		
	}
	// 첨부파일 삭제
	public void deleteAtchFile(EgovMap map) {
		update("FileUtilDAO.deleteAtchFile", map);
	}

	public String selectAtchFileIdByDwkNo(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("FileUtilDAO.selectAtchFileIdByDwkNo", map);
	}

	public void insertOldFileAtrb(EgovMap map) throws SQLException, IOException {
		
		insert("FileUtilDAO.insertOldFileAtrb", map);
	}

	public void updateOldFileDetail(EgovMap map) throws SQLException, IOException {
		
		update("FileUtilDAO.updateOldFileDetail", map);
	}

	public List<?> selectAtchOldFileArray(EgovMap fileVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("FileUtilDAO.selectAtchOldFileArray", fileVO);
	}
		
	
}
