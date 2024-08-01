package mx.edu.utez.sisgea.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sisgea.dao.ClassDao;
import mx.edu.utez.sisgea.dao.ProgramDao;
import mx.edu.utez.sisgea.model.ClassBean;
import mx.edu.utez.sisgea.model.LoginBean;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/classServlet")
public class ClassServlet extends HttpServlet {
    private int id;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ClassBean classBean = new ClassBean();
        ClassDao classDao = new ClassDao();
        ProgramDao programDao = new ProgramDao();

        String action = req.getParameter("action");

        switch(action){
            case "add":
                try{
                    classBean.setName(req.getParameter("name"));
                    classBean.setProgram(programDao.getProgram(Integer.parseInt(req.getParameter("programId"))));
                    classBean.setStatus(true);
                    classDao.insertClass(classBean);
                    resp.sendRedirect(req.getContextPath() + "/classServlet?status=registerOk");
                }catch (Exception e){
                    e.printStackTrace();
                    String errorMessage = e.getMessage();
                    if(errorMessage.contains("Duplicate entry")){
                        errorMessage = "duplicateEntry";
                    }
                    resp.sendRedirect(req.getContextPath() + "/classServlet?status=registerError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                }
                break;

                case "update":
                    try{
                        classBean.setId(Integer.parseInt(req.getParameter("updateClasseId")));
                        classBean.setName(req.getParameter("updateName"));
                        classBean.setProgram(programDao.getProgram(Integer.parseInt(req.getParameter("updateProgramId"))));
                        classDao.updateClass(classBean);
                        resp.sendRedirect(req.getContextPath() + "/classServlet?status=updateOk");
                    }catch (Exception e){
                        e.printStackTrace();
                        String errorMessage = e.getMessage();
                        if(errorMessage.contains("Duplicate entry")){
                            errorMessage = "duplicateEntry";
                        }
                        resp.sendRedirect(req.getContextPath() + "/classServlet?status=updateError&errorMessage=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
                    }
                    break;

                    case "delete":
                        try{
                            id=Integer.parseInt(req.getParameter("deleteClassId"));
                            classDao.deleteClass(id);
                            resp.sendRedirect(req.getContextPath() + "/classServlet?status=deleteOk");
                        }catch (Exception e){
                            e.printStackTrace();
                            resp.sendRedirect(req.getContextPath() + "/classServlet?status=deleteError");
                        }
                        break;

            case "revertDelete":
                try{
                    id=Integer.parseInt(req.getParameter("revertDeleteClassId"));
                    classDao.revertDeleteClass(id);
                    resp.sendRedirect(req.getContextPath() + "/classServlet?status=revertDeleteOk");
                }catch (Exception e){
                    e.printStackTrace();
                    resp.sendRedirect(req.getContextPath() + "/classServlet?status=revertDeleteError");
                }
                break;
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession activeSession = req.getSession();
        LoginBean user = (LoginBean)activeSession.getAttribute("activeUser");
        RequestDispatcher rd;
        if(user!=null){
            if(user.getRole().getId()==1){
                rd = req.getRequestDispatcher("/views/schedule/classe/classMan.jsp");
            }else{
                rd = req.getRequestDispatcher("/views/layout/error403.jsp");
            }
        }else {
            rd = req.getRequestDispatcher("/views/login/login.jsp");
        }
        rd.forward(req,resp);
    }
    }
