package gzonei.mypage.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("MypageDAO")
public class MypageDAO extends EgovComAbstractDAO {

	/** 희진 */
	public List<?> selectInterestGroupList(String userId) throws SQLException, IOException {
        return selectList("MypageDAO.selectInterestGroupList", userId);
    }
	
	public List<?> selectInterestInfoList(EgovMap map) throws SQLException, IOException {
		return selectList("MypageDAO.selectInterestInfoList", map);
	}
	
	public int selectInterestInfoCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("MypageDAO.selectInterestInfoCnt", map);
	}
	
	public int memberActionUdt(Map<String, Object> map) throws SQLException, IOException {
		return update("MypageDAO.memberActionUdt", map);
	}
	
	public int selectInterProdGoupChkCount(Map<String, Object> map) throws SQLException, IOException {
		return selectOne("MypageDAO.selectInterProdGoupChkCount", map);
	}
	
	public int insertInterProd(Map<String, Object> map) throws SQLException, IOException {
		return insert("MypageDAO.insertInterProd", map);
	}
	
	public int updateInterProdGrpNm(Map<String, Object> map) throws SQLException, IOException {
		return update("MypageDAO.updateInterProdGrpNm", map);
	}
	
	
	public int deleteInterProdGrpNm(Map<String, Object> map) throws SQLException, IOException {
		return update("MypageDAO.deleteInterProdGrpNm", map);
	}
	
	public int deleteInterProd(EgovMap map) throws SQLException, IOException {
		return update("MypageDAO.deleteInterProd", map);
	}
	
	public int selectInterareaCnt(Map<String, Object> map) throws SQLException, IOException {
		return selectOne("MypageDAO.selectInterareaCnt", map);
	}

	public int insertInterarea(Map<String, Object> map) throws SQLException, IOException {
		return insert("MypageDAO.insertInterarea", map);
	}
	
	public int deleteInterarea(Map<String, Object> map) throws SQLException, IOException {
		return update("MypageDAO.deleteInterarea", map);
	}
	
	/** 다현 */
	public int secessionCheck(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("MypageDAO.secessionCheck",map);
	}


	public int insertSecessionHist(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return insert("MypageDAO.insertSecessionHist",map);
	}


	public int updateMemberSecession(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MypageDAO.updateMemberSecession",map);
	}


	public List<?> selectMypaymentList(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("MypageDAO.selectMypaymentList",map);
	}


	public int selectMypaymentListTotCnt(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("MypageDAO.selectMypaymentListTotCnt",map);
	}


	public EgovMap selectMyInfo(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("MypageDAO.selectMyInfo",map);
	}


	public List<?> selectSrvcCodeList()throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("MypageDAO.selectSrvcCodeList");
	}


	public List<?> selectGoodsCode(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("MypageDAO.selectGoodsCode",map);
	}


	public List<?> selectGradCodeList()throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("MypageDAO.selectGradCodeList");
	}


	public int insertSetleDtls(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return insert("MypageDAO.insertSetleDtls",map);
	}


	public int insertSetleDtlsHist(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return insert("MypageDAO.insertSetleDtlsHist",map);
	}


	public int insertRcpmnyDtls(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return insert("MypageDAO.insertRcpmnyDtls",map);
	}

	public EgovMap selectPayInfo(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("MypageDAO.selectPayInfo",map);
	}

	public EgovMap selectSetleSn(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("MypageDAO.selectSetleSn",map);
	}

}
