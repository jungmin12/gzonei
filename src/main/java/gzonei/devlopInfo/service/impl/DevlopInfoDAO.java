package gzonei.devlopInfo.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("DevlopInfoDAO")
public class DevlopInfoDAO extends EgovComAbstractDAO {

	public List<?> selectDevlopInfoList(EgovMap map) throws SQLException, IOException {
        return selectList("DevlopInfoDAO.selectDevlopInfoList", map);
    }
	
	public int selectDevlopInfoListTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("DevlopInfoDAO.selectDevlopInfoListTotCnt", map);
	}

	public EgovMap selectDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectDevlopInfoDetail", map);
	}

	public int updateDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return update("DevlopInfoDAO.updateDevlopInfoDetail", map);
	}

	public int deleteDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return update("DevlopInfoDAO.deleteDevlopInfoDetail", map);
	}

	public List<?> selectPrtnDevlopInfoList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectPrtnDevlopInfoList", map);
	}

	public EgovMap selectPrtnDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectPrtnDevlopInfoDetail", map);
	}

	public int updatePrtnDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return update("DevlopInfoDAO.updatePrtnDevlopInfoDetail", map);
	}
	
	public int deletePrtnDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return update("DevlopInfoDAO.deletePrtnDevlopInfoDetail", map);
	}

	public int insertDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return insert("DevlopInfoDAO.insertDevlopInfoDetail", map);
	}

	public int insertPrtnDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return insert("DevlopInfoDAO.insertPrtnDevlopInfoDetail", map);
	}

	public List<?> selectSimpleDevlopInfoList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectSimpleDevlopInfoList", map);
	}

	public int selectSimpleDevlopInfoListTotCnt(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return  selectOne("DevlopInfoDAO.selectSimpleDevlopInfoListTotCnt", map);
	}

	public EgovMap selectOldFileList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectOldFileList", map);
	}

	public List<?> selectDevlopInfoLayerList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectDevlopInfoLayerList", map);
	}
	
	public List<?> selectMmnwsBbsListByDwkNm(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectMmnwsBbsListByDwkNm", map);
	}
	public int selectMmnwsBbsListByDwkNmCnt(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectMmnwsBbsListByDwkNmCnt", map);
	}

	public List<?> selectDstrcCodeList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectDstrcCodeList", map);
	}

	public List<?> selectDstrcCodeListAll() throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectDstrcCodeListAll");
	}

	public EgovMap selectDevInfoOldestRewardYr() throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectDevInfoOldestRewardYr");
	}

	public List<?> selectDevlopInfoListModal(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectDevlopInfoListModal", map);
	}

	public int selectDevlopInfoListModalTotCnt(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectDevlopInfoListModalTotCnt", map);
	}

	public List<?> selectIntrstList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectIntrstList", map);
	}

	public int InsertIntrst(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return insert("DevlopInfoDAO.InsertIntrst", map);
	}

	public List<?> selectInvtListBydwkNo(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectInvtListBydwkNo", map);
	}

	public List<?> selectRecDevInfoLog(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectRecDevInfoLog", map);
	}

	public List<?> selectAdminList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectAdminList", map);
	}
	
	public int selectAdminListTotCnt(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectAdminListTotCnt", map);
	}

	public List<?> selectDstrcCodeListByUpCd(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectDstrcCodeListByUpCd", map);
	}
	
	public List<?> selectDstrcCodeIdList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectDstrcCodeIdList", map);
	}
	
	public List<?> selectNewFileList(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("DevlopInfoDAO.selectNewFileList", map);
	}

	public int selectIntrstChk(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectIntrstChk", map);
	}

	public EgovMap selectUserPrintCntById(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectUserPrintCntById", map);
	}
	
	public int updateUserPrintCnt(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return update("DevlopInfoDAO.updateUserPrintCnt", map);
	}

	public int selectInvtListCnt(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectInvtListCnt", searchVO);
	}

	public void updateOldFileDetail(EgovMap fileVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		update("DevlopInfoDAO.updateOldFileDetail", fileVO);
	}

	public void updateOldPrtnFileDetail(EgovMap fileVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		update("DevlopInfoDAO.updateOldPrtnFileDetail", fileVO);
	}
	
	public EgovMap selectDevInfoSnByDwkNo(EgovMap map) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("DevlopInfoDAO.selectDevInfoSnByDwkNo", map);
	}
	
}
