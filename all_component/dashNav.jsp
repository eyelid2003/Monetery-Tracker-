<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    body {
        display: flex;
        height: 100vh;
        background-color: #f4f6f7;
    }

    .navbar {
        background-color: #2c3e50;
        padding: 1.5rem;
        width: 250px;
        display: flex;
        flex-direction: column;
        align-items: center;
        height: 100vh;
        box-sizing: border-box;
    }

    .logo-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 2rem;
    }

    .logo {
        width: 60px;
        height: 60px;
        margin-bottom: 10px;
    }

    h1 {
        color: #ecf0f1;
        font-size: 1.5rem;
        text-align: center;
    }

    .menu {
        list-style: none;
        width: 100%;
        text-align: center;
    }

    .menu li {
        margin: 1.5rem 0;
    }

    .menu a {
        text-decoration: none;
        color: #ecf0f1;
        padding: 0.5rem 1rem;
        display: block;
        transition: background 0.3s;
        border-radius: 30px;
    }

    .menu a:hover {
        background-color: #34495e;
    }
</style>

<nav class="navbar">
    <div class="logo-container">
        <img src="images/spending.png" alt="Logo" class="logo">
        <h1>Finance Tracker</h1>
    </div>
    <ul class="menu">
        <li><a href="Dashboard.jsp">Dashboard</a></li>
        <li><a href="expense.jsp">Expenses</a></li>
        <li><a href="income.jsp">Income</a></li>
        
        <li><a href="Logout">Logout</a></li>
    </ul>
</nav>
