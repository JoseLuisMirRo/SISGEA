package mx.edu.utez.sisgea.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import mx.edu.utez.sisgea.dao.RoleDao;
import mx.edu.utez.sisgea.dao.UserDao;
import mx.edu.utez.sisgea.dao.UserroleDao;
import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.model.UserBean;
import mx.edu.utez.sisgea.model.UserroleBean;
import mx.edu.utez.sisgea.utility.EmailService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.WorkbookProvider;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 10
)

@WebServlet("/userBulkServlet")
public class UserBulkServlet extends HttpServlet {
    private static final Pattern NAME_PATTERN = Pattern.compile("^^([A-ZÁÉÍÓÚÑ][a-záéíóúñ]*\\s?)+$");
    private static final Pattern VALID_EMAIL_ADDRESS_PATTERN = Pattern.compile("^[a-z0-9._%+-]+@utez\\.edu\\.mx$");
    private static final Pattern VALID_ROLES_PATTERN =  Pattern.compile("^(Administrador,Docente|Administrador|Docente|Alumno)$");

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession activeSession = req.getSession();
        UserBean userBean = new UserBean();
        UserDao userDao = new UserDao();
        UserroleDao userRoleDao = new UserroleDao();

        try {
            Part part = req.getPart("file");
            String fileName = part.getSubmittedFileName();
            if(fileName==null||!fileName.endsWith(".xlsx")) {
                throw new IllegalArgumentException("invalidFile");
            }
            String contentType = part.getContentType();
            if (!contentType.equals("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")) {
                throw new IllegalArgumentException("invalidFile");
            }

            InputStream data = part.getInputStream();
            Workbook workbook = WorkbookFactory.create(data);
            Sheet sheet = workbook.getSheetAt(0);

            List<String> emails = new ArrayList<>();

            //Recorremos las filas de la hoja de trabajo
            Iterator<Row> rowIterator = sheet.iterator();
            while(rowIterator.hasNext()) {
                Row row = rowIterator.next();
                if (row.getRowNum() < 3) continue;

                String firstName = row.getCell(0).getStringCellValue();
                String lastNameP = row.getCell(1).getStringCellValue();
                String lastNameM = row.getCell(2).getStringCellValue();
                String email = row.getCell(3).getStringCellValue();
                String rolesStr = row.getCell(4).getStringCellValue();
                System.out.println(email);

                if (!VALID_EMAIL_ADDRESS_PATTERN.matcher(email).matches()) {
                    throw new IllegalArgumentException("invalidEmail");
                }
                if (userDao.getUserByEmail(email) != null) {
                    throw new IllegalArgumentException("emailExists");
                }
                if (emails.contains(email)) {
                    throw new IllegalArgumentException("emailRepeated");
                }
                emails.add(email);

                if (!NAME_PATTERN.matcher(firstName).matches() ||
                        !NAME_PATTERN.matcher(lastNameP).matches() ||
                        !NAME_PATTERN.matcher(lastNameM).matches()) {
                    throw new IllegalArgumentException("invalidName");
                }

                if (!VALID_ROLES_PATTERN.matcher(rolesStr).matches()) {
                    throw new IllegalArgumentException("invalidRoles");
                }
            }

            rowIterator = sheet.iterator();
            while(rowIterator.hasNext()) {
                Row row = rowIterator.next();
                if (row.getRowNum() < 3) continue;

                String firstName = row.getCell(0).getStringCellValue();
                String lastNameP = row.getCell(1).getStringCellValue();
                String lastNameM = row.getCell(2).getStringCellValue();
                String email = row.getCell(3).getStringCellValue();
                String rolesStr = row.getCell(4).getStringCellValue();

                userBean.setFirstName(firstName);
                userBean.setLastNameP(lastNameP);
                userBean.setLastNameM(lastNameM);
                userBean.setEmail(email);
                userBean.setPassword(GeneratePassword.generatePassword(2, 2, 2));
                userBean.setStatus(true);

                int createdId = userDao.insertUser(userBean);

                String[] roles = rolesStr.split(",");
                for(String role : roles ){
                    RoleDao roleDao = new RoleDao();
                    RoleBean roleObjetc = roleDao.getRoleByName(role);
                    UserroleBean userrole = new UserroleBean(createdId, roleObjetc.getId());
                    userRoleDao.insertUserRole(userrole);
                }
            }
            EmailService emailService = new EmailService();
            String to = userBean.getEmail();
            String subject = "Bienvenido a SISGEA";
            String html = "<h2>¡Hola! "+userBean.getFirstName()+" "+userBean.getLastNameP()+" "+userBean.getLastNameM()+"</h2>"+
                    "<h3>Bienvenido a SISGEA</h3><p>Tu contraseña es: "+userBean.getPassword()+"</p>"+
                    "<p>Utiliza tu correo electrónico y contraseña para iniciar sesión en SISGEA.</p>"+
                    "<p>Saludos cordiales,</p><p>Equipo de SISGEA</p>";
            emailService.sendEmail(to, subject, html);
            activeSession.setAttribute("status", "bulkOk");
            resp.sendRedirect(req.getContextPath() + "/userServlet");

        }catch (Exception e) {
            e.printStackTrace();
            String errorMessage = e.getMessage();
            activeSession.setAttribute("status", "bulkError");
            activeSession.setAttribute("errorMessage", errorMessage);
            resp.sendRedirect(req.getContextPath() + "/userServlet");
        }
    }
}

