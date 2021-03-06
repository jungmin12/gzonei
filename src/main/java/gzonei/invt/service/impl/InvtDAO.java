package gzonei.invt.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("InvtDAO")
public class InvtDAO extends EgovComAbstractDAO {

	public List<?> selectInvtList(EgovMap map) throws SQLException, IOException {
        return selectList("InvtDAO.selectInvtList", map);
    }

	public int selectInvtListCnt(EgovMap map) throws SQLException, IOException {
		 return selectOne("InvtDAO.selectInvtListCnt", map);
	}

	public EgovMap selectInvtDetail(EgovMap map) throws SQLException, IOException{
		return selectOne("InvtDAO.selectInvtDetail", map);
	}

	public List<?> selectProList(EgovMap map) throws SQLException, IOException {
		return selectList("InvtDAO.selectProList", map);
	}

	public List<?> selectUseList(EgovMap map) throws SQLException, IOException {
		return selectList("InvtDAO.selectUseList", map);
	}

	public EgovMap selectProDetail(EgovMap map) throws SQLException, IOException{
		return selectOne("InvtDAO.selectProDetail", map);
	}

	public EgovMap selectUseDetail(EgovMap map) throws SQLException, IOException{
		return selectOne("InvtDAO.selectUseDetail", map);
	}

	public int insertInvDetail(EgovMap map) throws SQLException, IOException{
		 insert("InvtDAO.insertInvDetail", map);
		 return insert("InvtDAO.insertInvDevDsp", map);
	}

	public int deleteInvtInfoDetail(EgovMap map) throws SQLException, IOException{
		return update("InvtDAO.deleteInvtInfoDetail", map);
	}

	public int updateInvtInfoDetail(EgovMap map) throws SQLException, IOException{
		return update("InvtDAO.updateInvtInfoDetail", map);
	}

	public int deleteUseInfoDetail(EgovMap map) throws SQLException, IOException{
		return update("InvtDAO.deleteUseInfoDetail", map);
	}

	public int updateUseInfoDetail(EgovMap map) throws SQLException, IOException{
		return update("InvtDAO.updateUseInfoDetail", map);
	}

	public int insertUseInfoDetail(EgovMap map) throws SQLException, IOException{
		return insert("InvtDAO.insertUseInfoDetail", map);
	}

	public int deleteProInfoDetail(EgovMap map) throws SQLException, IOException{
		return insert("InvtDAO.deleteProInfoDetail", map);
	}

	public int updateProInfoDetail(EgovMap map) throws SQLException, IOException{
		return insert("InvtDAO.updateProInfoDetail", map);
	}

	public int insertProInfoDetail(EgovMap map) throws SQLException, IOException{
		return insert("InvtDAO.insertProInfoDetail", map);
	}

	public List<?> selectInvtAdmList(EgovMap map) throws SQLException, IOException{
		return selectList("InvtDAO.selectInvtAdmList", map);
	}
	public int selectInvtAdmListCnt(EgovMap map) throws SQLException, IOException{
		return selectOne("InvtDAO.selectInvtAdmListCnt", map);
	}

	public EgovMap insertInvSn() {
		return selectOne("InvtDAO.insertInvSn");
	}

	public int selectInvtOverlap(EgovMap map) throws SQLException, IOException{
		return selectOne("InvtDAO.selectInvtOverlap", map);
	}

}
