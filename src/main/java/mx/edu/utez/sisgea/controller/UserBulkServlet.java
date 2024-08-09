package mx.edu.utez.sisgea.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import mx.edu.utez.sisgea.dao.RoleDao;
import mx.edu.utez.sisgea.dao.UserDao;
import mx.edu.utez.sisgea.dao.UserroleDao;
import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.model.UserBean;
import mx.edu.utez.sisgea.model.UserroleBean;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.WorkbookProvider;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 10
)

@WebServlet("/userBulkServlet")
public class UserBulkServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserBean userBean = new UserBean();
        UserDao userDao = new UserDao();
        UserroleDao userRoleDao = new UserroleDao();

        try {
            Part part = req.getPart("file");

            InputStream data = part.getInputStream();

            Workbook workbook = WorkbookFactory.create(data);
            Sheet sheet = workbook.getSheetAt(0);

            //Recorremos las filas de la hoja de trabajo
            Iterator<Row> rowIterator = sheet.iterator();
            while(rowIterator.hasNext()) {
                Row row = rowIterator.next();
                if (row.getRowNum() == 0) continue;

                String firstName = row.getCell(0).getStringCellValue();
                String lastNameP = row.getCell(1).getStringCellValue();
                String lastNameM = row.getCell(2).getStringCellValue();
                String email = row.getCell(3).getStringCellValue();
                String rolesStr = row.getCell(4).getStringCellValue();
                System.out.println(rolesStr);

                if (firstName.isEmpty() || lastNameP.isEmpty() || lastNameM.isEmpty() || email.isEmpty() || rolesStr.isEmpty()) {
                    throw new IllegalArgumentException("nullCamp");
                }
                if (!email.endsWith("@utez.edu.mx")) {
                    throw new IllegalArgumentException("invalidEmail");
                }

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
            resp.sendRedirect(req.getContextPath() + "/userServlet?status=bulkOk");

        }catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/userServlet?status=bulkError");
        }
    }
}

