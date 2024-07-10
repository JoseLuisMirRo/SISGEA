package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import mx.edu.utez.sisgea.dao.UserDao;
import mx.edu.utez.sisgea.dao.UserroleDao;
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

                        int createdId=userDao.insertUser(userBean); //Al ejecutar la insercion del usuario, el metodo devuelve su ID

                        //SOPORTE MULTIROL
                        String[] rolesIds = req.getParameterValues("roles[]");

                        if (rolesIds != null){
                            for (String roleID : rolesIds) {
                                UserroleBean userrole = new UserroleBean(createdId, Integer.parseInt(roleID));
                                userRoleDao.insertUserRole(userrole);
                            }
                        }
                        resp.sendRedirect(req.getContextPath() + "/views/userMan.jsp?status=registerOk");

                    } catch (Exception e) {
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/views/userMan.jsp?status=registerError");
                    }
                    break;

                case "update":
                    try{
                        userBean.setId(Integer.parseInt(req.getParameter("updateUserId")));
                        userBean.setFirstName(req.getParameter("name"));
                        userBean.setLastNameP(req.getParameter("lastNameP"));
                        userBean.setLastNameM(req.getParameter("lastNameM"));
                        userBean.setEmail(req.getParameter("email"));
                        userBean.setPassword(req.getParameter("password"));
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

                        resp.sendRedirect(req.getContextPath() + "/views/userMan.jsp?status=updateOk");

                    }catch(Exception e) {
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/views/userMan.jsp?status=updateError");
                    }
                    break;

                case "delete": //Eliminacion logica
                    try{
                        id=(Integer.parseInt(req.getParameter("deleteUserId")));
                        userDao.deleteUser(id);
                        resp.sendRedirect(req.getContextPath() + "/views/userMan.jsp?status=deleteOk");
                    } catch (Exception e) {
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/views/userMan.jsp?status=deleteError");
                    }
                    break;

                case "revertDelete": //Deshacer eliminacion logica
                    try{
                        id=(Integer.parseInt(req.getParameter("revertDeleteUserId")));
                        userDao.revertDeleteUser(id);
                        resp.sendRedirect(req.getContextPath() + "/views/userMan.jsp?status=revertDeleteOk");
                    } catch (Exception e) {
                        e.printStackTrace();
                        resp.sendRedirect(req.getContextPath() + "/views/userMan.jsp?status=revertDeleteError");
                        //req.setAttribute("usuarios", lista);
                        //req.getRequestDispatcher("jsp").forward(req, resp);
                    }
                    break;


            }
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            RequestDispatcher rd = req.getRequestDispatcher("/views/userMan.jsp");
            rd.forward(req, resp);
        }
    }
