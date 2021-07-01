package io.github.eemin90.persistence;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTests {

	@Test
	public void test() {
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (Exception e) {
			fail();
		}
		
		String url = "jdbc:mariadb://13.125.228.102/spr1";
		String user = "root";
		String password = "wnddkdwjdqhcjfl1";
		
		try (
			Connection con = DriverManager.getConnection(url, user, password);
				) {
			
			assertNotNull(con);
			
		} catch (Exception e) {
			fail();
		}
	}

}
