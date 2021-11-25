package gzonei.oper.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("CodeManageDAO")
public class CodeManageDAO extends EgovComAbstractDAO {

	// 대분류 코드
	public List<?> viewUpperCode(EgovMap map) throws Exception{
		return selectList("CodeManageDAO.viewUpperCode", map);
	}
	
	// 소분류 코드
	public List<?> viewCode(EgovMap map) throws Exception{
		return selectList("CodeManageDAO.viewCode", map);
	}
	
	// 대분류 신규 등록하기
	public void insertUpCd(Map<String, Object> commandMap) throws Exception{
		insert("CodeManageDAO.insertUpCd", commandMap);
	}
	
	// 대분류 수정하기
	public void updateUpCd(Map<String, Object> commandMap) throws Exception{
		update("CodeManageDAO.updateUpCd", commandMap);
	}
	
	// 소분류 신규 등록하기
	public void insertLwCd(Map<String, Object> commandMap) throws Exception{
		insert("CodeManageDAO.insertLwCd", commandMap);
	}
	
	// 소분류 수정하기
	public void updateLwCd(Map<String, Object> commandMap) throws Exception{
		update("CodeManageDAO.updateLwCd", commandMap);
	}

}
