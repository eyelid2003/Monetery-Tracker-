import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class Signup extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        PrintWriter out = res.getWriter();
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String pass1 = req.getParameter("pass");

        // Encrypt the password using the Playfair cipher
        Lokesh playfairCipher = new Lokesh("SECUREKEY"); // Replace "SECUREKEY" with your desired cipher key
        pass1 = playfairCipher.encrypt(pass1);

        HttpSession htps = req.getSession();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker", "root", "root");
            String sql = "SELECT * FROM account WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                htps.setAttribute("failed", "Account already exists");
                res.sendRedirect("signin.jsp");
            } else {
                String query = "INSERT INTO account (name, email, pass) VALUES (?, ?, ?)";
                ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, pass1);
                int i = ps.executeUpdate();

                if (i == 1) {
                    htps.setAttribute("success", "Account created");
                    res.sendRedirect("signin.jsp");
                } else {
                    htps.setAttribute("failed", "Something went wrong");
                    res.sendRedirect("signin.jsp");
                }
            }
        } catch (Exception e) {
            htps.setAttribute("error", "Something went wrong");
            res.sendRedirect("signin.jsp");
        }
    }
}

// Playfair Cipher Implementation
class Lokesh {
    private char[][] keyTable;

    public Lokesh(String key) {
        keyTable = generateKeyTable(key);
    }

    private char[][] generateKeyTable(String key) {
        char[][] table = new char[5][5];
        boolean[] used = new boolean[26];
        key = key.toUpperCase().replaceAll("[J]", "I").replaceAll("[^A-Z]", "");
        int index = 0;

        for (char c : key.toCharArray()) {
            if (!used[c - 'A']) {
                table[index / 5][index % 5] = c;
                used[c - 'A'] = true;
                index++;
            }
        }

        for (char c = 'A'; c <= 'Z'; c++) {
            if (c == 'J') continue;
            if (!used[c - 'A']) {
                table[index / 5][index % 5] = c;
                used[c - 'A'] = true;
                index++;
            }
        }
        return table;
    }

    public String encrypt(String text) {
        text = text.toUpperCase().replaceAll("[J]", "I").replaceAll("[^A-Z]", "");
        StringBuilder preparedText = new StringBuilder();

        for (int i = 0; i < text.length(); i++) {
            char first = text.charAt(i);
            char second = (i + 1 < text.length() && text.charAt(i + 1) != first) ? text.charAt(i + 1) : 'X';
            preparedText.append(first).append(second);
            if (first == second) {
                preparedText.append('X');
            }
            i += (first == second) ? 0 : 1;
        }

        StringBuilder encryptedText = new StringBuilder();
        for (int i = 0; i < preparedText.length(); i += 2) {
            encryptedText.append(encryptPair(preparedText.charAt(i), preparedText.charAt(i + 1)));
        }
        return encryptedText.toString();
    }

    private String encryptPair(char first, char second) {
        int[] posFirst = findPosition(first);
        int[] posSecond = findPosition(second);

        if (posFirst[0] == posSecond[0]) { // Same row
            return "" + keyTable[posFirst[0]][(posFirst[1] + 1) % 5] +
                   keyTable[posSecond[0]][(posSecond[1] + 1) % 5];
        } else if (posFirst[1] == posSecond[1]) { // Same column
            return "" + keyTable[(posFirst[0] + 1) % 5][posFirst[1]] +
                   keyTable[(posSecond[0] + 1) % 5][posSecond[1]];
        } else { // Rectangle swap
            return "" + keyTable[posFirst[0]][posSecond[1]] +
                   keyTable[posSecond[0]][posFirst[1]];
        }
    }

    private int[] findPosition(char c) {
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                if (keyTable[i][j] == c) {
                    return new int[]{i, j};
                }
            }
        }
        return null;
    }
}
