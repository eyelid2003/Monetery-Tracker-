<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f6fa;
        }

        .container {
            background-color: #2c3e50;
            width: 900px;
            display: flex;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }

        .form-container {
            flex: 1;
            padding: 3rem;
            background-color: #ecf0f1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-top-right-radius: 12px;
            border-bottom-right-radius: 12px;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 2rem;
            color: #2c3e50;
            font-size: 1.8rem;
        }

        .input-box {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-box input {
            width: 100%;
            padding: 12px;
            background-color: transparent;
            border: 2px solid #2c3e50;
            border-radius: 8px;
            outline: none;
            font-size: 16px;
            color: #2c3e50;
            transition: border-color 0.3s;
        }

        .input-box input:focus {
            border-color: #3498db;
        }

        .input-box label {
            position: absolute;
            top: -20px;
            left: 12px;
            background-color: #ecf0f1;
            padding: 0 5px;
            font-size: 14px;
            color: #7f8c8d;
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            border: none;
            background-color: #3498db;
            color: white;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: #2980b9;
        }

        .switch-text {
            text-align: center;
            margin-top: 1rem;
        }

        .switch-text a {
            color: #3498db;
            text-decoration: none;
        }

        .switch-text a:hover {
            text-decoration: underline;
        }

        .left-container {
            flex: 1;
            background-color: #2c3e50;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 3rem;
            border-top-left-radius: 12px;
            border-bottom-left-radius: 12px;
        }

        .left-container h1 {
            color: white;
            text-align: center;
            font-size: 2.5rem;
            margin-top: 1rem;
        }

        .left-container p {
            color: #ecf0f1;
            text-align: center;
            font-size: 1.2rem;
            margin-top: 1rem;
        }

        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-top: 1rem;
        }

        .logo {
            width: 80px;
            height: 80px;
            margin-bottom: 10px;
            display: block;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="left-container">
            <img src="images/spending.png" alt="Logo" class="logo">
            <h1>Monetory Tracker</h1>
            <p>Track your expenses, analyze trends, and get insights into your financial health.</p>
        </div>

        <div class="form-container">
            <%@include file="msg.jsp" %>
                <h2>Sign Up</h2>
                <form id="signup-form" action="Signup" method="POST" onsubmit="return validateForm()">
                    <div class="input-box">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="input-box">
                        <label for="signup-email">Email</label>
                        <input type="email" id="signup-email" name="email" required>
                    </div>
                    <div class="input-box">
                        <label for="signup-password">Password</label>
                        <input type="password" id="signup-password" name="pass" required>
                    </div>
                    <div class="input-box">
                        <label for="confirm-password">Confirm Password</label>
                        <input type="password" id="confirm-password" required>
                    </div>
                    <button type="submit" class="submit-btn">Sign Up</button>
                    <p class="switch-text">Already have an account? <a href="signin.jsp">Sign In</a></p>
                    <div class="error-message" id="error-message" style="display: none;"></div>
                </form>
        </div>
    </div>

    <script>
        function validateForm() {
            const password = document.getElementById('signup-password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const errorMessage = document.getElementById('error-message');

            if (password !== confirmPassword) {
                errorMessage.textContent = "Passwords do not match!";
                errorMessage.style.display = 'block';
                return false;
            } else {
                errorMessage.style.display = 'none';
                return true;
            }
        }
    </script>
</body>

</html>