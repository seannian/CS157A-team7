<%@ page import="java.sql.*"%>
<%
    String dbPassword = System.getenv("DB_PASSWORD");
    if (dbPassword == null || dbPassword.isEmpty()) {
        System.out.println("DB_PASSWORD is not set.");
    }
%>
<html>
<head>
<title>Three Tier Architecture Demo</title>
</head>
<body>
	<h1>JDBC Connection Example</h1>

	<table border="1">
		<tr>
			<td>Uname</td>
			<td>Email</td>
			<td>Phone</td>
		</tr>
		<%
		String user; // assumes database name is the same as username
		user = "root";
		String password = dbPassword;
		try {
			java.sql.Connection con;
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/?autoReconnect=true&useSSL=false", user, password);
			out.println(" database successfully opened.<br/><br/>");

			Statement statement = con.createStatement();

			statement.executeUpdate("DROP SCHEMA IF EXISTS myFlorabase");
			statement.executeUpdate("CREATE SCHEMA myFlorabase");
			statement.executeUpdate("USE myFlorabase");
			String createMemberTable = "CREATE TABLE `User` (" + "`user_id` INT AUTO_INCREMENT PRIMARY KEY, "
			+ "`username` VARCHAR(30) NOT NULL, " + "`password` VARCHAR(45) DEFAULT NULL, "
			+ "`profile_pic` MEDIUMBLOB DEFAULT NULL, " + "`description` VARCHAR(500) DEFAULT NULL, "
			+ "`isAdmin` TINYINT(1) DEFAULT 0" + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci";
			String createMapPreferenceTable = "CREATE TABLE `MapPreference` (" + "`preference_id` INT AUTO_INCREMENT,"
			+ "`user_id` int NOT NULL," + "`filter_id` int NOT NULL," + "`location_id` int NOT NULL,"
			+ "`zoom` double DEFAULT 100," + "PRIMARY KEY (`preference_id`,`user_id`,`filter_id`,`location_id`)"
			+ ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci";
			String createFilterTable = "CREATE TABLE `Filter` (" + "`filter_id` INT AUTO_INCREMENT NOT NULL,"
			+ "`color` varchar(45) DEFAULT NULL," + "`filter_name` varchar(255) NOT NULL," + "PRIMARY KEY (`filter_id`)"
			+ ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci";
			String createLocationTable = "CREATE TABLE `Location` (" + "`location_id` INT AUTO_INCREMENT NOT NULL,"
					+ "`latitude` double DEFAULT NULL," + "`longitude` double DEFAULT NULL," + "`name` varchar(100) DEFAULT NULL," + "PRIMARY KEY (`location_id`)"
					+ ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci";
			statement.executeUpdate("DROP TABLE IF EXISTS Member");
			statement.executeUpdate("DROP TABLE IF EXISTS Users");
			statement.executeUpdate("DROP TABLE IF EXISTS MapPreference");
			statement.executeUpdate("DROP TABLE IF EXISTS Filter");
			statement.executeUpdate("DROP TABLE IF EXISTS Location");
			statement.executeUpdate(createMemberTable);
			statement.executeUpdate(createMapPreferenceTable);
			statement.executeUpdate(createFilterTable);
			statement.executeUpdate(createLocationTable);

			statement.executeUpdate("INSERT INTO myflorabase.user (username, password, profile_pic, description, isAdmin)"
			+ "VALUES ('user1', 'root', NULL, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', true);");
			statement.executeUpdate("INSERT INTO myflorabase.user (username, password, profile_pic, description, isAdmin)"
			+ "VALUES ('user2', 'root', NULL, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', false);");
			out.println("Initial entries in table \"myFlorabase\": <br/>");
			
			statement.executeUpdate("INSERT INTO myflorabase.filter (color, filter_name)"
					+ "VALUES ('green', 'All')");
			statement.executeUpdate("INSERT INTO myflorabase.location (latitude, longitude, name)"
					+ "VALUES ('37.3352', '121.8811', 'SJSU')");
			statement.executeUpdate("INSERT INTO myflorabase.mappreference (user_id, filter_id, location_id, zoom)"
					+ "VALUES ('1', '1', 1, 125)");
			out.println("Initial entries in table \"myFlorabase\": <br/>");

			ResultSet rs = statement.executeQuery("SELECT * FROM User");
			while (rs.next()) {
				out.println("<tr>" + "<td>" + rs.getString(1) + "</td>" + "<td>" + rs.getString(3) + "</td>" + "<td>"
				+ rs.getString(4) + "</td>" + "</tr>");
			}
			rs.close();
			statement.close();
			con.close();
		} catch (SQLException e) {
			out.println("SQLException caught: " + e.getMessage());
		}
		%>
	
</body>
</html>