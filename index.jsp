<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense Tracker</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>

<body>
    <header>
        <div class="logo">
            <img src="images/spending.png" alt="Logo" width="50" height="50">
            <h1>Finance Tracker</h1>
        </div>
        <button id="menu-toggle" aria-label="Toggle navigation" class="menu-icon">
            <span class="bar"></span>
            <span class="bar"></span>
            <span class="bar"></span>
        </button>
        <nav class="nav-links">
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="#features">Features</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
                <li><a href="signin.jsp" class="signin">Sign In</a></li>
            </ul>
        </nav>
    </header>
    <section id="home" class="hero">
        <div class="hero-content">
            <%@include file="msg.jsp" %>
                <br>
                <h1>Track Your Expenses Effortlessly</h1>
                <p>Get insights into your spending and manage your finances effectively.</p>
                <a href="#contact" class="cta-btn">Get Started</a><br>
        </div>
    </section>
    <section id="features">
        <h2>Features</h2>
        <div class="feature-row">
            <div class="feature-box">
                <img src="images/money-bag.png" alt="Expense Tracking">
                <h3>Expense Tracking</h3>
                <p>Keep track of your daily expenses with ease and make informed financial decisions.</p>
            </div>
            <div class="feature-box">
                <img src="images/analysis.png" alt="Analytics">
                <h3>Analytics</h3>
                <p>Visualize your spending patterns through intuitive graphs and reports.</p>
            </div>
            <div class="feature-box">
                <img src="images/budget.png" alt="Budgeting">
                <h3>Budgeting</h3>
                <p>Set budgets for different categories and stay on track with your financial goals.</p>
            </div>
        </div>
    </section>
    <section id="about" class="about-bg">
        <h2>About Us</h2>
        <p>At Expense Tracker, our mission is to empower individuals to take control of their financial lives. We
            provide a user-friendly platform that simplifies expense management, helping users achieve their financial
            goals.</p>
        <img src="images/about.jpg" alt="About Us Image" class="about-image">
    </section>
    <section id="contact">
        <h2>Contact Us</h2>
        <div class="contact">
            <form action="Asking" method="post">
                <input type="text" name="name" placeholder="Your Name" required>
                <input type="email" name="email" placeholder="Your Email" required>
                <textarea name="msg" placeholder="Your Message" rows="6" required></textarea>
                <input type="submit" value="Send Message">
            </form>
        </div>
    </section>
    <footer>
        <p>&copy; 2024 Expense Tracker. All rights reserved.</p>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const menuToggle = document.getElementById('menu-toggle');
            const navLinks = document.querySelector('.nav-links');

            menuToggle.addEventListener('click', () => {
                navLinks.classList.toggle('active');
            });

        });
    </script>
</body>

</html>