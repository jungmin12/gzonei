package gzonei.oper.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Repository("GroupManageDAO")
public class GroupManageDAO extends EgovComAbstractDAO {

	public List<?> selectGroupList()throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("GroupManageDAO.selectGroupList");
	}

	public EgovMap selectGroupInfoDt(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("GroupManageDAO.selectGroupInfoDt",map);
	}
	
	public List<?> selectGroupMember(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return  selectList("GroupManageDAO.selectGroupMember",map);
	}

	public List<?> selectMemberSearch(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("GroupManageDAO.selectMemberSearch",map);
	}

	public int updateGroupMember(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("GroupManageDAO.updateGroupMember",map);
	}

	public int insertNewGroup(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return insert("GroupManageDAO.insertNewGroup",map);
	}

	public int groupDelete(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("GroupManageDAO.deleteGroup",map);
	}
	
}
