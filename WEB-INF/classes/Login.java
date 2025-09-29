import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        PrintWriter p = res.getWriter();
        String name = req.getParameter("name");
        String pass = req.getParameter("pass");
        String email = req.getParameter("email");
        RequestDispatcher dis = null;
        HttpSession htps = req.getSession();

        // Encrypt the input password using the Playfair cipher
        PlayfairCipherDecryption cipher = new PlayfairCipherDecryption();
        cipher.generateKeyMatrix("SECUREKEY"); // Replace "SECUREKEY" with your decryption key
        String encryptedPass = cipher.encrypt(pass); // Encrypt the input password to compare

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/monetory_tracker", "root", "root");

            String query = "SELECT * FROM account WHERE pass = ? AND email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, encryptedPass);
            ps.setString(2, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                htps.setAttribute("username", name);
                htps.setAttribute("email", email);
                res.sendRedirect("Dashboard.jsp");
            } else {
                htps.setAttribute("failed", "Incorrect email or password");
                res.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            htps.setAttribute("error", "Something went wrong");
            res.sendRedirect("index.jsp");
        }
    }
}

// Playfair Cipher Implementation for Decryption and Encryption
class PlayfairCipherDecryption {
    private static char[][] keyMatrix = new char[5][5];

    // Generate the key matrix
    public static void generateKeyMatrix(String key) {
        String adjustedKey = key.toUpperCase().replaceAll("[^A-Z]", "").replace("J", "I");
        boolean[] alphabetUsed = new boolean[26];
        int row = 0, col = 0;

        for (char c : adjustedKey.toCharArray()) {
            if (!alphabetUsed[c - 'A']) {
                keyMatrix[row][col++] = c;
                alphabetUsed[c - 'A'] = true;
                if (col == 5) {
                    row++;
                    col = 0;
                }
            }
        }

        for (char c = 'A'; c <= 'Z'; c++) {
            if (!alphabetUsed[c - 'A'] && c != 'J') {
                keyMatrix[row][col++] = c;
                if (col == 5) {
                    row++;
                    col = 0;
                }
            }
        }
    }

    // Locate the position of a character in the matrix
    private static int[] findPosition(char c) {
        for (int row = 0; row < 5; row++) {
            for (int col = 0; col < 5; col++) {
                if (keyMatrix[row][col] == c) {
                    return new int[]{row, col};
                }
            }
        }
        return null;
    }

    // Encrypt/Decrypt a pair of characters
    private static String processPair(char a, char b, boolean encrypt) {
        int[] posA = findPosition(a);
        int[] posB = findPosition(b);

        if (posA[0] == posB[0]) { // Same row
            return "" + keyMatrix[posA[0]][(posA[1] + (encrypt ? 1 : 4)) % 5] +
                   keyMatrix[posB[0]][(posB[1] + (encrypt ? 1 : 4)) % 5];
        } else if (posA[1] == posB[1]) { // Same column
            return "" + keyMatrix[(posA[0] + (encrypt ? 1 : 4)) % 5][posA[1]] +
                   keyMatrix[(posB[0] + (encrypt ? 1 : 4)) % 5][posB[1]];
        } else { // Rectangle swap
            return "" + keyMatrix[posA[0]][posB[1]] +
                   keyMatrix[posB[0]][posA[1]];
        }
    }

    // Encrypt text
    public String encrypt(String text) {
        return processText(text, true);
    }

    // Decrypt text
    public String decrypt(String text) {
        return processText(text, false);
    }

    // Process the text
    private String processText(String text, boolean encrypt) {
        text = text.toUpperCase().replaceAll("[^A-Z]", "").replace("J", "I");
        StringBuilder processedText = new StringBuilder();

        for (int i = 0; i < text.length(); i += 2) {
            char first = text.charAt(i);
            char second = (i + 1 < text.length() && text.charAt(i + 1) != first) ? text.charAt(i + 1) : 'X';
            processedText.append(processPair(first, second, encrypt));
        }

        return processedText.toString();
    }
}
