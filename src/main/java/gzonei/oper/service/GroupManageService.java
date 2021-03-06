package gzonei.oper.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


import egovframework.rte.psl.dataaccess.util.EgovMap;



public interface GroupManageService {
	
	//그룹리스트 조회
	public List<?> selectGroupList()throws SQLException, IOException;
	//그룹리스트 상세
	public EgovMap selectGroupInfoDt(EgovMap searchVO)throws SQLException,IOException;
	//그룹구성원 
	public List<?> selectGroupMember(EgovMap searchVO)throws SQLException,IOException;
	//회원검색
	public List<?> selectMemberSearch(EgovMap searchVO)throws SQLException,IOException;
	//그룹구성원 수정
	public int updateGroupMember(EgovMap searchVO)throws SQLException,IOException;
	//신규 그룹 생성
	public int insertNewGroup(EgovMap searchVO)throws SQLException,IOException;
	//그룹삭제
	public int groupDelete(EgovMap searchVO)throws SQLException,IOException;

}
