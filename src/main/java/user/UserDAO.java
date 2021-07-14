package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn; // db에 접근 할 수 있게 해준다.
	private PreparedStatement pstmt;
	private ResultSet rs; // mysql에 연결

	public UserDAO() {
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

	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USERINFO WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				} else
					return 0; // 비밀번호 오류
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류

	}

	public int join(User userinfo) {
		String SQL = "INSERT INTO USERINFO VALUES (?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userinfo.getUserID());
			pstmt.setString(2, userinfo.getUserPassword());
			pstmt.setString(3, userinfo.getUserName());
			pstmt.setString(4, userinfo.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
