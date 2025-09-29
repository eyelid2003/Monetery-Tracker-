<% 
String msg1=(String) session.getAttribute("sucess"); 
String msg2=(String) session.getAttribute("failed"); 
String msg3=(String) session.getAttribute("error"); 
	%>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Alert Messages</title>
        <style>
            .alert {
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                position: relative;
                opacity: 1;
                transition: opacity 0.6s ease-out;
                font-family: 'Poppins', sans-serif;
            }

            .alert-success {
                background-color: #3498db;
                color: white;
            }

            .alert-failed {
                background-color: #FF4C4C;
                color: white;
            }

            .alert-error {
                background-color: #FFA500;
                color: white;
            }

            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                color: white;
                font-size: 20px;
                cursor: pointer;
                background: none;
                border: none;
                outline: none;
            }

            .close-btn:hover {
                color: black;
            }
        </style>
    </head>

    <body>
        <% if (msg1 !=null) { %>
            <div class="alert alert-success">
                <strong>
                    <%= msg1 %>
                </strong>
                <button class="close-btn" onclick="this.parentElement.style.display='none';">&times;</button>
            </div>
            <% session.removeAttribute("sucess"); } else if (msg2 !=null) { %>
                <div class="alert alert-failed">
                    <strong>
                        <%= msg2 %>
                    </strong>
                    <button class="close-btn" onclick="this.parentElement.style.display='none';">&times;</button>
                </div>
                <% session.removeAttribute("failed"); } else if (msg3 !=null) { %>
                    <div class="alert alert-error">
                        <strong>
                            <%= msg3 %>
                        </strong>
                        <button class="close-btn" onclick="this.parentElement.style.display='none';">&times;</button>
                    </div>
                    <% session.removeAttribute("error"); } %>
    </body>

    </html>