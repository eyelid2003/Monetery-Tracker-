<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UrbanSync Chat Box</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            display: flex;
            background-color: #f4f6f7; /* Light background for the page */
            height: 100vh;
            justify-content: center; /* Horizontally center the content */
            align-items: center; /* Vertically center the content */
        }

        .dashboard {
            display: flex;
            width: 100%;
        }

        /* Navbar */
        .navbar {
            background-color: #2c3e50;
            padding: 1.5rem;
            width: 250px;
            display: flex;
            flex-direction: column;
            align-items: center;
            position: fixed;
            height: 100vh; /* Ensure navbar takes up full height */
            top: 0;
            left: 0;
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

        /* Chat Box Container */
        .chat-container {
            width: 400px;
            background: #fff; /* Clean white background for contrast */
            border-radius: 20px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            position: relative;
            margin-top: 50px; /* Gap at the top */
            margin-bottom: 50px; /* Gap at the bottom */
        }

        /* Chat Header */
        .chat-header {
            background-color: #4A90E2; /* UrbanSync-themed header color */
            color: #fff;
            padding: 15px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Chat Body */
        .chat-body {
            padding: 15px;
            background-color: #f7f9fc; /* Light gray background for messages */
            height: 400px;
            overflow-y: scroll;
            display: flex;
            flex-direction: column;
        }

        /* Chat Footer */
        .chat-footer {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #fff;
            border-top: 1px solid #ddd;
        }

        #chat-input {
            flex: 1;
            padding: 10px;
            border-radius: 20px;
            border: 1px solid #ccc;
            outline: none;
            font-size: 14px;
            margin-right: 10px;
            transition: border-color 0.3s ease;
        }

        #chat-input:focus {
            border-color: #4A90E2; /* Highlight input on focus */
        }

        #send-btn {
            width: 45px;
            height: 45px;
            background-color: #4A90E2; /* Send button color */
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: background-color 0.3s ease;
        }

        #send-btn:hover {
            background-color: #357ABD; /* Darker shade on hover */
        }

        .icon {
            font-size: 20px;
        }

        /* Message styling */
        .message {
            display: flex;
            flex-direction: column;
            margin-bottom: 15px;
            align-items: flex-start;
        }

        .message.user {
            align-items: flex-end;
        }

        .message .text {
            background-color: #4A90E2; /* User message color */
            padding: 12px 18px;
            border-radius: 20px;
            font-size: 14px;
            max-width: 75%;
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            word-wrap: break-word;
        }

        .message.bot .text {
            background-color: #ddd; /* Bot message color */
            color: #333;
        }

        .message .timestamp {
            font-size: 10px;
            margin-top: 5px;
            color: #888;
        }
    </style>
</head>
<body>
    <%@include file="all_component/dashNav.jsp" %>
    <div class="chat-container">
        <div class="chat-header">
            Welcome to Monetory Tracker AI Suggestion
        </div>
        <div class="chat-body" id="chat-body">
            <!-- Chat messages will appear here -->
        </div>
        <div class="chat-footer">
            <input type="text" id="chat-input" placeholder="Type your message...">
            <button id="send-btn">
                <span class="icon">✉️</span>
            </button>
        </div>
    </div>

    <script>
        document.getElementById('send-btn').addEventListener('click', function() {
            sendMessage();
        });

        document.getElementById('chat-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });

        function sendMessage() {
            const inputField = document.getElementById('chat-input');
            const message = inputField.value.trim();

            if (message !== '') {
                addMessage('user', message);
                inputField.value = ''; // Clear the input field

                // Simulate a bot response after 1 second
                setTimeout(() => {
                    addMessage('bot', 'Thanks for your message!');
                }, 1000);
            }
        }

        function addMessage(sender, text) {
            const chatBody = document.getElementById('chat-body');

            const messageDiv = document.createElement('div');
            messageDiv.classList.add('message', sender);

            const messageText = document.createElement('div');
            messageText.classList.add('text');
            messageText.textContent = text;

            const timestamp = document.createElement('div');
            timestamp.classList.add('timestamp');
            const time = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            timestamp.textContent = time;

            messageDiv.appendChild(messageText);
            messageDiv.appendChild(timestamp);
            chatBody.appendChild(messageDiv);

            chatBody.scrollTop = chatBody.scrollHeight; // Scroll to the latest message
        }
    </script>
</body>
</html>
