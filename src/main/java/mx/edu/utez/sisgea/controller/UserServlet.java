package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import java.util.ArrayList;
import java.util.List;
import mx.edu.utez.sisgea.dao.UserDao;
import mx.edu.utez.sisgea.model.RoleBean;
import mx.edu.utez.sisgea.model.UserBean;

@WebServlet("/userServlet")
    public class UserServlet extends HttpServlet {
        public String id;
        //PENDIENTE AGREGAR LOGGERS EN CATCH
        @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            resp.setContentType("text/html");
            req.setCharacterEncoding("UTF-8");

            UserBean userBean = new UserBean();
            UserDao userDao = new UserDao();

            String action = req.getParameter("action");
            System.out.println(action);
            switch (action) {
                case "add":
                    System.out.println("AGREGANDO USUARIO");
                    try {
                        userBean.setFirstName(req.getParameter("name"));
                        userBean.setLastNameP(req.getParameter("lastNameP"));
                        userBean.setLastNameM(req.getParameter("lastNameM"));
                        userBean.setEmail(req.getParameter("email"));
                        userBean.setPassword(req.getParameter("password"));
                        userBean.setStatus(true);

                        //SOPORTE MULTIROL
                        String[] roleIds = req.getParameterValues("roles");
                        List<Integer> roles = new ArrayList<>();
                        for (String roleId : roleIds) {
                            roles.add(Integer.parseInt(roleId));
                        }
                        userBean.setRoles(roles);

                        userDao.insertData(userBean);

                        resp.sendRedirect(req.getContextPath() + "/views/mainAdministrador.jsp?status=registerOk");

                    } catch (Exception e) {
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/views/mainAdministrador.jsp?status=registerError");
                    }
                    break;

                case "update":
                    try{
                        userBean.setId(req.getParameter("updateUserId"));
                        userBean.setFirstName(req.getParameter("name"));
                        userBean.setLastNameP(req.getParameter("lastNameP"));
                        userBean.setLastNameM(req.getParameter("lastNameM"));
                        userBean.setEmail(req.getParameter("email"));
                        userBean.setPassword(req.getParameter("password"));

                        String[] roleIds = req.getParameterValues("roles");
                        List<RoleBean> updateRoles = new ArrayList<>();
                        for (String roleId : roleIds) {
                            updateRoles.add(Integer.parseInt(roleId));
                        }
                        userBean.setRoles(updateRoles);
                        userDao.updateData(userBean);
                        resp.sendRedirect(req.getContextPath() + "/views/mainAdministrador.jsp?status=updateOk");

                    }catch(Exception e) {
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/views/mainAdministrador.jsp?status=updateError");
                    }
                    break;

                case "delete": //Eliminacion logica
                    try{
                        id=(req.getParameter("deleteUserId"));
                        userDao.deleteData(id);
                        resp.sendRedirect(req.getContextPath() + "/views/mainAdministrador.jsp?status=deleteOk");
                    } catch (Exception e) {
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/views/mainAdministrador.jsp?status=deleteError");
                    }
                    break;

                case "revertDelete": //Deshacer eliminacion logica
                    try{
                        id=(req.getParameter("revertDeleteUserId"));
                        userDao.revertDeleteData(id);
                        resp.sendRedirect(req.getContextPath() + "/views/mainAdministrador.jsp?status=revertDeleteOk");
                    } catch (Exception e) {
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/views/mainAdministrador.jsp?status=revertDeleteError");
                        //req.setAttribute("usuarios", lista);
                        //req.getRequestDispatcher("jsp").forward(req, resp);
                    }
                    break;


            }
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            RequestDispatcher rd = req.getRequestDispatcher("/views/mainAdministrador.jsp");
            rd.forward(req, resp);
        }
    }
