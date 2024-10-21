<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Log In</title>
<link rel="stylesheet" href="css/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

</head>
<body>
	<span class="container">
		<div id="signUpPage">
			<div>
				<span id="signUpPageHeader" class="prevent-select"> <img
					src='assets/myFlorabase_Logo_Text.svg' width="59" height="98" />
					<h1 class="centerText">Log In</h1>
				</span>

				<form action="LoginServlet" method="post">
					<div class="inputGroup textfield-label">
						<label>Username</label> <span><input type="text"
							name="uname" placeholder="Enter your username" required></span>
					</div>
					<div class="inputGroup textfield-label">
						<label>Password</label> <input type="password" name="password"
							placeholder="Enter your password" required>
					</div>
					<div class="centerButtons">
						<div id="logInButtons">
							<button class="major-button primary-button" type="submit"
								value="Log In">Log In</button>
						</div>
						<label class="label prevent-select">OR</label>
						<button class="major-button secondary-button" value="Sign Up"
							onclick="window.location.href='signup.jsp'">Sign
							Up</button>
					</div>
				</form>
			</div>
		</div>

	</span>

</body>

</html>