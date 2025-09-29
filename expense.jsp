<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monetary Tracker System</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
        }

        header {
            flex-grow: 1;
            padding: 2rem;
        }
    
        header h2 {
            font-size: 2rem;
            color: #2c3e50;
        }
        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 1.5rem;
        }

        /* Expense Cards and Create Expense Box */
        .expense-card, .create-expense {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
        }

        .expense-card:hover, .create-expense:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .expense-card p {
            font-size: 1.1rem;
            color: #2c3e50;
            font-weight: bold;
        }

        .expense-card .amount {
            color: #e67e22;
            font-size: 24px;
            margin-top: 10px;
        }

        .create-expense {
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px dashed #3498db;
            color: #3498db;
            font-size: 18px;
            background-color: #e8f6ff;
            transition: background-color 0.3s ease;
        }

        .create-expense:hover {
            background-color: #d0eafc;
        }

        /* Modal Form */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
        }

        .close-btn {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 18px;
            color: #aaa;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .close-btn:hover {
            color: #333;
        }

        input[type="text"],
        input[type="number"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="date"] {
    width: 80%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-family: inherit; /* Ensures consistency with other inputs */
    font-size: 16px; /* Matches the size of text and number fields */
    color: #2c3e50; /* Neutral dark color for text */
    background-color: #f9f9f9; /* Light background for visibility */
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

input[type="date"]:focus {
    border-color: #3498db; /* Highlight color on focus */
    box-shadow: 0 0 5px rgba(52, 152, 219, 0.5); /* Soft blue glow */
    outline: none; /* Removes the default focus outline */
}

        .submit-btn {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #2980b9;
        }
        table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    padding-left: 10px;
}

thead {
    background-color: #3498db;
    color: white;
    text-align: left;
    font-weight: bold;
}

thead th {
    padding: 10px;
}

tbody tr:nth-child(odd) {
    background-color: #f9f9f9;
}

tbody tr:nth-child(even) {
    background-color: #f4f7fa;
}

tbody tr:hover {
    background-color: #e8f6ff;
    cursor: pointer;
}

td, th {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

td:last-child {
    text-align: center;
}

tbody td {
    color: #2c3e50;
}

.action-btn {
    padding: 5px 10px;
    color: white;
    background-color: #e67e22;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.action-btn:hover {
    background-color: #d35400;
}
/* Delete Button Styles */
.btn {
    display: inline-block;
    padding: 8px 15px;
    font-size: 14px;
    font-weight: bold;
    border-radius: 5px;
    text-decoration: none;
    text-align: center;
    transition: background-color 0.3s ease, transform 0.3s ease;
    border: none;
    cursor: pointer;
}

.btn-danger {
    background-color: #e74c3c;
    color: white;
    border: 1px solid #e74c3c;
}

.btn-danger:hover {
    background-color: #c0392b;
    border: 1px solid #c0392b;
    transform: translateY(-2px);
}

.btn-danger i {
    margin-right: 5px;
}

    </style>
</head>

<body>
    <%@include file="all_component/dashNav.jsp" %>

    <main class="content">
        <header>
            <h2>Welcome to your Expense, <%= session.getAttribute("username") %>
            </h2>
            <%@include file="msg.jsp" %>
        </header>
        <div class="container">
            <div class="create-expense" id="createExpense">
                <span>+ Create New Expense</span>
            </div>
            <% 
                try { 
                    Class.forName("com.mysql.cj.jdbc.Driver"); 
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker", "root", "root"); 
                    String query = "SELECT * FROM expense"; 
                    PreparedStatement ps = con.prepareStatement(query); 
                    ResultSet rs = ps.executeQuery(); 
                    while(rs.next()) { 
            %>
            <div class="expense-card">
                <p><%= rs.getString(2) %></p>
                <div class="amount"><%= rs.getString(3) %>&#8377</div>
            </div>
            <% 
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) { 
                    e.printStackTrace();
                } 
            %>
        </div>

        <!-- Table Section -->
        <table>
            <thead>
                <tr>
                    <th>Expense Name</th>
                    <th>Expense Amount</th>
                    <th>Expense Category</th>
                    <th>Expense Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker", "root", "root");
                        String query = "SELECT * FROM expense";
                        PreparedStatement ps = con.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getDouble("amount") %>&#8377</td>
                    <td><%= rs.getString("cat") %></td>
                    <td><%= rs.getString("Edate") %> </td>
                    <td>
                        <a href="UpdateExpence?id=<%= rs.getString(1) %>" class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i>Delete</a>
                    </td>
                </tr>
                <%
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </main>

    <!-- Modal for Creating Expense -->
    <div id="expenseModal" class="modal">
        <div class="modal-content">
            <span id="closeModal" class="close-btn">&times;</span>
            <h3>Add New Expense</h3>
            <form action="Expense" method="POST">
                <input type="text" name="Ename" placeholder="Expense Name" required>
                <input type="number" name="Eamount" placeholder="Amount" required>
                <input type="text" name="Ecat" placeholder="Category" required>
                <input type="date" name="Edate" required>
                <button type="submit" class="submit-btn">Submit</button>
            </form>
        </div>
    </div>

    <script>
        const createExpenseBtn = document.getElementById('createExpense');
        const modal = document.getElementById('expenseModal');
        const closeModalBtn = document.getElementById('closeModal');

        createExpenseBtn.addEventListener('click', () => {
            modal.style.display = 'flex';
        });

        closeModalBtn.addEventListener('click', () => {
            modal.style.display = 'none';
        });

        window.onclick = (event) => {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };
    </script>
</body>

</html>
