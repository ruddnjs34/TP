package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private ResultSet rs;

	public BbsDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:myoracle";
			String dbID = "ora_user";
			String dbPassword = "1111";
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getDate() {
		String SQL = "SELECT SYSDATE FROM DUAL";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류

	}

	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물 작성시 매겨지는 번호
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류

	}

	public int write(String bbsTitle, String userID, String bbsContent) { // 실제로 데이터 베이스에 넣어주기
		String SQL = "INSERT INTO BBS VALUES(?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext());   // 하나씩 값을 넣어주기 
			pstmt.setString(2,bbsTitle);
			pstmt.setString(3,userID);
			pstmt.setString(4,bbsContent);
			pstmt.setInt(5,1); // 첫번째 작성시 삭제 상태가 아니여야 하기 때문에 1로 표기

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 AND ROWNUM <= 10 ORDER BY bbsID DESC";
		ArrayList<Bbs> list = new ArrayList<Bbs>(); // bbs에서 나오는 인스턴스를 보관 할 수 있는 리스트를 만듬
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // getnext = 다음글에 작성될 게시글 번호
			rs = pstmt.executeQuery(); // 실제로 실행 했을때의 결과를 가져올 수 있게 해줌
			while (rs.next()) { // 결과가 있는 경우
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsContent(rs.getString(4));
				bbs.setBbsAvailable(rs.getInt(5));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 데이터베이스 오류
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // getnext = 다음글에 작성될 게시글 번호
			rs = pstmt.executeQuery(); // 실제로 실행 했을때의 결과를 가져올 수 있게 해줌
			if (rs.next()) { // 결과가 있는 경우
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // 데이터베이스 오류
	}

	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID  = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID); // getnext = 다음글에 작성될 게시글 번호
			rs = pstmt.executeQuery(); // 실제로 실행 했을때의 결과를 가져올 수 있게 해줌
			if (rs.next()) { // 결과가 있는 경우
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsContent(rs.getString(4));
				bbs.setBbsAvailable(rs.getInt(5));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}

	public int update(int bbsID, String bbsTitle, String bbsContent) { // 제목과 내용으로 바꿔준다.
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID LIKE ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle); // 하나씩 값을 넣어주기 다음번에 쓰여야 할 게시물 번호가 됨
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID); // 첫번째 작성시 삭제 상태가 아니여야 하기 때문에 1로 표기

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류

	}

	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID LIKE ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID); // 하나씩 값을 넣어주기 다음번에 쓰여야 할 게시물 번호가 됨
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
}
