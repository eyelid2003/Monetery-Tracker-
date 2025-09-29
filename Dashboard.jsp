<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense Tracker Dashboard</title>
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

        .content {
            flex-grow: 1;
            padding: 2rem;
            background-color: #ecf0f1;
        }

        header h2 {
            font-size: 2rem;
            color: #2c3e50;
        }

        header p {
            font-size: 1.2rem;
            color: #7f8c8d;
        }

        .stats {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        .stat-box {
            background-color: #fff;
            padding: 1.5rem;
            width: 30%;
            margin: 1rem 0;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .stat-box h3 {
            font-size: 1.5rem;
            color: #2c3e50;
        }

        .stat-box p {
            font-size: 2rem;
            color: #e67e22;
        }

        .chart-container {
            display: flex;
            justify-content: space-between;
            margin-top: 2rem;
        }

        #expenseChart,
        #incomeChart {
            height: 300px;
            width: 48%;
        }
    </style>
    <script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
    <script src="https://cdn.canvasjs.com/jquery.canvasjs.min.js"></script>
    <script>
        window.onload = function () {
            // Expense Chart Data
            var expenseChartOptions = {
                animationEnabled: true,
                title: {
                    text: "Expense Breakdown"
                },
                axisY: {
                    title: "Amount (in \u20B9)",
                    prefix: "\u20B9"
                },

                axisX: {
                    title: "Categories"
                },
                data: [{
                    type: "column",
                    yValueFormatString: "#,##0.00",
                    dataPoints: [
                        <% 
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker", "root", "root");
                            String query = "SELECT cat, amount FROM expense";
                            PreparedStatement ps = con.prepareStatement(query);
                            ResultSet rs = ps.executeQuery();
                            while (rs.next()) {
                        %>
                        { label: "<%= rs.getString("cat") %>", y: <%= rs.getDouble("amount") %> },
                        <% 
                            }
                            rs.close();
                            ps.close();
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } 
                        %>
                    ]
                }]
            };
            $("#expenseChart").CanvasJSChart(expenseChartOptions);

            // Income Chart Data
            var incomeChartOptions = {
                animationEnabled: true,
                title: {
                    text: "Income Breakdown"
                },
                axisY: {
                    title: "Amount (in \u20B9)",
                    prefix: "\u20B9"
                },
                axisX: {
                    title: "Sources"
                },
                data: [{
                    type: "column",
                    yValueFormatString: "$#,##0.00",
                    dataPoints: [
                        <% 
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker", "root", "root");
                            String query = "SELECT cat, amount FROM income";
                            PreparedStatement ps = con.prepareStatement(query);
                            ResultSet rs = ps.executeQuery();
                            while (rs.next()) {
                        %>
                        { label: "<%= rs.getString("cat") %>", y: <%= rs.getDouble("amount") %> },
                        <% 
                            }
                            rs.close();
                            ps.close();
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } 
                        %>
                    ]
                }]
            };
            $("#incomeChart").CanvasJSChart(incomeChartOptions);
        };
    </script>
</head>

<body>
    <%@include file="all_component/dashNav.jsp" %>

    <main class="content">
        <header>
            <h2>Welcome to your Dashboard <%= session.getAttribute("username") %>
            </h2>
            <p>Track and manage your expenses easily.</p>
        </header>
        <section class="stats">
            <%
    double totalExpense = 0;
    double totalIncome = 0;
    double totalSaving = 0;

    try {
        // Load MySQL driver and establish a connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker", "root", "root");
        
        // Query to calculate total expense
        String expenseQuery = "SELECT SUM(amount) AS totalExpense FROM expense";
        PreparedStatement psExpense = con.prepareStatement(expenseQuery);
        ResultSet rsExpense = psExpense.executeQuery();
        if (rsExpense.next()) {
            totalExpense = rsExpense.getDouble("totalExpense");
        }
        rsExpense.close();
        psExpense.close();

        // Query to calculate total income
        String incomeQuery = "SELECT SUM(amount) AS totalIncome FROM income";
        PreparedStatement psIncome = con.prepareStatement(incomeQuery);
        ResultSet rsIncome = psIncome.executeQuery();
        if (rsIncome.next()) {
            totalIncome = rsIncome.getDouble("totalIncome");
        }
        rsIncome.close();
        psIncome.close();

        // Calculate total savings
        totalSaving = totalIncome - totalExpense;

        // Close connection
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

    <div class="stat-box">
        <h3>Total Expense</h3>
        <p>
            <%= totalExpense %> &#8377;
        </p>
    </div>
    <div class="stat-box">
        <h3>Total Income</h3>
        <p>
            <%= totalIncome %> &#8377;
        </p>
    </div>
    <div class="stat-box">
        <h3>Total Saving</h3>
        <p>
            <%= totalSaving %> &#8377;
        </p>
    </div>
</section>

        <!-- Chart Section -->
        <div class="chart-container">
            <div id="expenseChart"></div>
            <div id="incomeChart"></div>
        </div>
    </main>
</body>

</html>
