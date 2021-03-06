package gzonei.oper.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("DevBestDAO")
public class DevBestDAO extends EgovComAbstractDAO {

	public List<?> selectBest() throws SQLException , IOException{
		// TODO Auto-generated method stub
		return selectList("DevBestDAO.selectBest");
	}

	public List<?> selectAlldevBestModalList(EgovMap searchVO) throws SQLException , IOException{
		// TODO Auto-generated method stub
		return selectList("DevBestDAO.selectDevlopInfoListModal",searchVO);
	}
	
	public int selectAlldevBestModalTotCnt(EgovMap searchVO) throws SQLException , IOException{
		// TODO Auto-generated method stub
		return selectOne("DevBestDAO.selectDevlopInfoListModalTotCnt",searchVO);
	}
	
	public EgovMap selectInvtInfo(EgovMap searchVO) throws SQLException , IOException{
		// TODO Auto-generated method stub
		return selectOne("DevBestDAO",searchVO);
	}

	public void insertdevBestInfo(EgovMap insertVO)throws SQLException , IOException{
		// TODO Auto-generated method stub
		update("DevBestDAO.insertdevBestInfo",insertVO);
	}
	
	public List<?> selectdevBestDstrcCodeList()throws SQLException , IOException{
		return selectList("DevBestDAO.selectDstrcCodeList");
	}

	public EgovMap selectDevBestOldFile(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectOne("DevBestDAO.selectDevBestOldFileList",searchVO);
	}

	public EgovMap selectFree(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectOne("DevBestDAO.selectFree",searchVO);
	}

	public List<?> selectSstusList(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectList("DevBestDAO.selectSstusList",searchVO);
	}

	public List<?> selectDevBestNewFile(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectOne("DevBestDAO.selectDevBestNewFileList",searchVO);
	}

	public EgovMap selectImage(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectOne("DevBestDAO.selectImage",searchVO);
	}

	public EgovMap selectLc(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return selectOne("DevBestDAO.selectLc",searchVO);
	}

}
