package gzonei.member.service.impl;


import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("MemberDAO")
public class MemberDAO extends EgovComAbstractDAO {

	//용명 사용자 관리 추가
	public List<?> memberManageList(EgovMap map) throws SQLException, IOException {
		return selectList("MemberDAO.memberManageList", map);
	}
	
	public int memberManageCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("MemberDAO.memberManageCnt", map);
	}
	
	public List<?> memberManageListExcel(EgovMap map) throws SQLException, IOException {
		return selectList("MemberDAO.memberManageListExcel", map);
	}

	/** 희진 */
	public List<?> selectMemberList(EgovMap map) throws SQLException, IOException {
        return selectList("MemberDAO.selectMemberList", map);
    }

	public int selectMemberListTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("MemberDAO.selectMemberListTotCnt", map);
	}
	
	public int selectChkMemberTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("MemberDAO.selectChkMemberTotCnt", map);
	}
	
	public List<?> selectMemberListExcel(EgovMap map) throws SQLException, IOException {
		return selectList("MemberDAO.selectMemberListExcel", map);
	}
	
	public int updateMemberState(EgovMap map) throws SQLException, IOException {
		return update("MemberDAO.updateMemberState", map);
	}
	
	public List<?> selectPaymentList(EgovMap map) throws SQLException, IOException {
        return selectList("MemberDAO.selectPaymentList", map);
    }
	
	public List<?> selectChkInfoList(EgovMap map) throws SQLException, IOException {
        return selectList("MemberDAO.selectChkInfoList", map);
    }
	
	
	public int selectChkInfoTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("MemberDAO.selectChkInfoTotCnt", map);
	}
	
	public EgovMap selectMemberDetail(EgovMap map) throws SQLException, IOException {
		return selectOne("MemberDAO.selectMemberDetail", map);
	}

	public int selectMemberIdChk(EgovMap map) throws SQLException, IOException {
		return selectOne("MemberDAO.selectMemberIdChk", map);
	}
	
	public int selectMemberbizNoChk(EgovMap map) throws SQLException, IOException {
		return selectOne("MemberDAO.selectMemberbizNoChk", map);
	}
	
	public int insertMemberInfo(Map<String, Object> map) throws SQLException, IOException {
		return insert("MemberDAO.insertMemberInfo", map);
	}

	public int selectInterareaCnt(Map<String, Object> map) throws SQLException, IOException {
		return selectOne("MemberDAO.selectInterareaCnt", map);
	}

	public int insertInterarea(Map<String, Object> map) throws SQLException, IOException {
		return insert("MemberDAO.insertInterarea", map);
	}
	
	public int deleteInterarea(Map<String, Object> map) throws SQLException, IOException {
		return update("MemberDAO.deleteInterarea", map);
	}
	
	public int adminMemberActionUdt(Map<String, Object> map) throws SQLException, IOException {
		return update("MemberDAO.adminMemberActionUdt", map);
	}
	
	public int insertMemberGrade(Map<String, Object> map) throws SQLException, IOException {
		return insert("MemberDAO.insertMemberGrade", map);
	}
	
	public int updateMemberGrade(Map<String, Object> map) throws SQLException, IOException {
		return update("MemberDAO.updateMemberGrade", map);
	}
	
	public List<?> selectSearchMemberInfo(EgovMap map) throws SQLException, IOException {
        return selectList("MemberDAO.selectSearchMemberInfo", map);
    }
	
	public int selectSearchMemberInfoTotCnt(EgovMap map) throws SQLException, IOException {
		return selectOne("MemberDAO.selectSearchMemberInfoTotCnt", map);
	}
	
	
	/** 다현 */
	public List<?> selectConnectList(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("MemberDAO.selectConnectList",map);
	}


	public int selectConnectListTotCnt(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		int result =  selectOne("MemberDAO.selectConnectListTotCnt",map);
		return result;
	}


	public List<?> selectUserConnectHist(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectList("MemberDAO.selectUserConnectHist",map);
	}


	public List<?> selectPenaltyList(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("MemberDAO.selectPenaltyList",map);
	}


	public int selectPenaltyListTotCnt(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("MemberDAO.selectPenaltyListTotCnt",map);
	}


	public int updatePenaltyRelease(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.updatePenaltyRelease",map);
	}
	

	public int updateConnectListLogoutdt(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return update ("MemberDAO.updateConnectListLogoutdt",map);
	}

	public List<?> selectSecessionList(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("MemberDAO.selectSecessionList",map);
	}


	public int selectSecessionListTotCnt(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("MemberDAO.selectSecessionListTotCnt",map);
	}


	public int selectSecsnWaitCnt(EgovMap map) throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("MemberDAO.selectSecsnWaitCnt",map);
	}


	public int updateSecessionConfirm(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.updateSecessionConfirm",map);
	}


	public int updateSecessionHist(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.updateSecessionHist",map);
	}


	public int secessionCheck(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("MemberDAO.secessionCheck",map);
	}


	public int insertSecessionHist(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return insert("MemberDAO.insertSecessionHist",map);
	}

	public int confirmPayment(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.confirmPayment",map);
	}

	public int updateMberSetle(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.updateMberSetle",map);
	}

	public int updateMberSetleHist(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return insert("MemberDAO.updateMberSetleHist",map);
	}

	public int updateMemberGradCd(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.updateMemberGradCd",map);
	}

	public int insertMberGrade(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return insert("MemberDAO.insertMberGrade",map);
	}

	public List<?> selectHeadBanner(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectList("MemberDAO.selectHeadBanner",map);
	}

	public int selectHeadBannerCnt(EgovMap map)throws SQLException, IOException {
		// TODO Auto-generated method stub
		return selectOne("MemberDAO.selectHeadBannerCnt",map);
	}

	public int bannerInsert(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return insert("MemberDAO.bannerInsert",map);
	}

	public int bannerDelete(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.bannerDelete",map);
	}

	public int bannerFileDel(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.bannerFileDel",map);
	}

	public EgovMap selectBannerDetail(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return selectOne("MemberDAO.selectBannerDetail",map);
	}

	public int updateBannerInfo(EgovMap map)throws SQLException,IOException {
		// TODO Auto-generated method stub
		return update("MemberDAO.updateBannerInfo",map);
	}
	//현재 서비스 만료전인지 조회
	public int selectSrvcCnt(EgovMap map) {
		// TODO Auto-generated method stub
		return selectOne("MemberDAO.selectSrvcCnt",map);
	}
	
	//서비스 이용 만료 전 결제내역 업데이트

	public int updateSetleAfter(EgovMap map) {
		// TODO Auto-generated method stub
		return update("MemberDAO.updateSetleAfter",map);
	}




}
