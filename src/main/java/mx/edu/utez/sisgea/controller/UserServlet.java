package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import mx.edu.utez.sisgea.dao.UserDao;
import mx.edu.utez.sisgea.dao.UserroleDao;
import mx.edu.utez.sisgea.model.LoginBean;
import mx.edu.utez.sisgea.model.UserBean;
import mx.edu.utez.sisgea.model.UserroleBean;

@WebServlet("/userServlet")
    public class UserServlet extends HttpServlet {
        public int id;
        //PENDIENTE AGREGAR LOGGERS EN CATCH
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            resp.setContentType("text/html");
            req.setCharacterEncoding("UTF-8");

            UserBean userBean = new UserBean();
            UserDao userDao = new UserDao();
            UserroleDao userRoleDao = new UserroleDao();

            String action = req.getParameter("action");
            HttpSession activeSession = req.getSession();
            switch (action) {
                case "add":
                    try {
                        userBean.setFirstName(req.getParameter("name"));
                        userBean.setLastNameP(req.getParameter("lastNameP"));
                        userBean.setLastNameM(req.getParameter("lastNameM"));
                        userBean.setEmail(req.getParameter("email"));
                        userBean.setPassword(GeneratePassword.generatePassword(2, 2, 2));
                        userBean.setStatus(true);

                        int createdId=userDao.insertUser(userBean); //Al ejecutar la insercion del usuario, el metodo devuelve su ID

                        //SOPORTE MULTIROL
                        String[] rolesIds = req.getParameterValues("roles[]");

                        if (rolesIds != null){
                            for (String roleID : rolesIds) {
                                UserroleBean userrole = new UserroleBean(createdId, Integer.parseInt(roleID));
                                userRoleDao.insertUserRole(userrole);
                            }
                        }
                        //ResendAPI emailSender=new ResendAPI();
                        //String from = "SISGEA <email@sisgea.tech>";
                        //String to = userBean.getEmail();
                        //String subject = "Bienvenido a SISGEA";
                        //String html = "<h2>¡Hola! "+userBean.getFirstName()+" "+userBean.getLastNameP()+" "+userBean.getLastNameM()+"</h2>"+
                          //      "<h3>Bienvenido a SISGEA</h3><p>Tu contraseña es: "+userBean.getPassword()+"</p>"+
                          //      "<p>Utiliza tu correo electrónico y contraseña para iniciar sesión en SISGEA.</p>"+
                          //      "<Utiliza el siguiente hipervínculo para acceder: <a href='sisgea.tech'>SISGEA</a>"+
                          //      "<p>Saludos cordiales,</p><p>Equipo de SISGEA</p>";
                        //emailSender.sendEmail(from, to, subject, html);
                        activeSession.setAttribute("status", "registerOk");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                    } catch (Exception e) {
                        e.printStackTrace();
                        activeSession.setAttribute("status", "registerError");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                    }
                    break;

                case "update":
                    try{
                        userBean.setId(Integer.parseInt(req.getParameter("updateUserId")));
                        userBean.setFirstName(req.getParameter("name"));
                        userBean.setLastNameP(req.getParameter("lastNameP"));
                        userBean.setLastNameM(req.getParameter("lastNameM"));
                        userBean.setEmail(req.getParameter("email"));
                        userDao.updateUser(userBean);

                        //SOPORTE MULTIROL
                        String[] updateRolesIds = req.getParameterValues("updateRoles[]");
                        List<Integer> currentRolesIds = userRoleDao.getUserRoles(userBean.getId());

                        List<Integer> updateRolesIdsList = Arrays.stream(updateRolesIds).map(Integer::parseInt).collect(Collectors.toList());

                        if(!(updateRolesIdsList.equals(currentRolesIds))){ //COMPARO SI LAS LISTAS DE ROLES NO SON IGUALES
                            if(updateRolesIdsList.size()>currentRolesIds.size()){ //EN CASO DE QUE SE AGREGUE UN ROL
                                for(Integer ur : updateRolesIdsList){ //RECORRO LA LISTA DE IDS ACTUALIZADOS
                                    if(!currentRolesIds.contains(ur)){ //BUSCO LOS IDS QUE NO ESTAN EN LA LISTA SIN ACTUALIZAR
                                        userRoleDao.insertUserRole(new UserroleBean(userBean.getId(),ur)); //ASIGNO EL ID DE ROL NUEVO
                                    }
                                }
                            }
                            else{
                                for(Integer cr : currentRolesIds){ //EN CASO DE QUE SE ELIMINE UN ROL RECORRO LA LISTA DE IDS ANTIGUOS
                                    if(!updateRolesIdsList.contains(cr)){ //BUSCO LOS IDS QUE NO ESTÉN EN LA LISTA ACTUALIZADA
                                        userRoleDao.deleteUserRoles(new UserroleBean(userBean.getId(),cr)); //ELIMINO ESOS IDS
                                    }
                                }
                            }
                        }

                        activeSession.setAttribute("status", "updateOk");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");

                    }catch(Exception e) {
                        e.printStackTrace();
                        activeSession.setAttribute("status", "updateError");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                    }
                    break;
                case "updatePswd":
                    try {
                        userBean.setId(Integer.parseInt(req.getParameter("updatePswdUserId")));
                        userBean.setEmail(req.getParameter("email"));
                        userBean.setPassword(GeneratePassword.generatePassword(2, 2, 2));
                        userDao.updateUserPassword(userBean);
                        UserBean targetUser = userDao.getUserById(userBean.getId());
                        //ResendAPI emailSender = new ResendAPI();
                        //String from = "SISGEA <email@sisgea.tech>";
                        //String to = targetUser.getEmail();
                        //String subject = "Tu contraseña ha sido recuperada exitosamente";
                        //String html = "<h2>¡Hola! "+targetUser.getFirstName()+" "+targetUser.getLastNameP()+" "+targetUser.getLastNameM()+"</h2>"+
                         //       "<h3>¡Tu contraseña ha sido recuperada exitosamente!</h3><p>Nueva contraseña: "+userBean.getPassword()+"</p>"+
                          //      "<p>Saludos cordiales,</p><p>Equipo de SISGEA</p>";
                        //emailSender.sendEmail(from, to, subject, html);
                        activeSession.setAttribute("status", "updatePswdOk");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                    }catch (Exception e) {
                        e.printStackTrace();
                        activeSession.setAttribute("status", "updatePswdError");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                    }
                    break;
                case "delete": //Eliminacion logica
                    try{
                        id=(Integer.parseInt(req.getParameter("deleteUserId")));
                        userDao.deleteUser(id);
                        activeSession.setAttribute("status", "deleteOk");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                    } catch (Exception e) {
                        e.printStackTrace();
                        activeSession.setAttribute("status", "deleteError");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                    }
                    break;

                case "revertDelete": //Deshacer eliminacion logica
                    try{
                        id=(Integer.parseInt(req.getParameter("revertDeleteUserId")));
                        userDao.revertDeleteUser(id);
                        activeSession.setAttribute("status", "revertDeleteOk");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                    } catch (Exception e) {
                        e.printStackTrace();
                        activeSession.setAttribute("status", "revertDeleteError");
                        resp.sendRedirect(req.getContextPath() + "/userServlet");
                        //req.setAttribute("usuarios", lista);
                        //req.getRequestDispatcher("jsp").forward(req, resp);
                    }
                    break;
            }
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            HttpSession activeSession = req.getSession();
            LoginBean user = (LoginBean) activeSession.getAttribute("activeUser");
            RequestDispatcher rd;
            if(user!=null){
                if(user.getRole().getId()==1){
                    rd = req.getRequestDispatcher("/views/user/userMan.jsp");
                }else{
                    rd = req.getRequestDispatcher("/views/layout/error403.jsp");
                }
            }else {
                rd = req.getRequestDispatcher("/views/login/login.jsp");
            }
            rd.forward(req,resp);
        }
    }

