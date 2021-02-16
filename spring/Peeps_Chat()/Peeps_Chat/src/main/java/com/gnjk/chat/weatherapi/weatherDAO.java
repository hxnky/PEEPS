package com.gnjk.chat.weatherapi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

// import static com.gnjk.chat.db.JDBCTmplate.*;

public class weatherDAO {
	
	public int insertVillageWeather(List<weather> vw) throws ClassNotFoundException {

		List<weather> vgw = new ArrayList<weather>();
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement insert_pstm = null;
		int res = 0;

	//	con = getConnection();
		
		String query = "INSERT INTO WEATHER03" + " VALUES(getdate(),?,?,?,?)";

		try {
			for (int i = 0; i < vw.size(); i++) {
				weather str = vw.get(i);

				insert_pstm = con.prepareStatement(query);
				insert_pstm.setString(1, str.getBaseDate());
				insert_pstm.setString(2, str.getBaseTime());
				insert_pstm.setString(3, str.getT3h());
				insert_pstm.setString(4, str.getReh());

				System.out.println("3.query ready");
				res = insert_pstm.executeUpdate();

				if (res > 0) {
					//commit(con);
					System.out.println("인서트 성공");
				}

				System.out.println("4.return");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("3 or 4 error");
			e.printStackTrace();
		} finally {
		//	close(insert_pstm, con);
		}
		return res;
		
		

		// else 끝

	}

}
