package mx.edu.utez.sisgea.controller;

import com.resend.*;
import com.resend.core.exception.ResendException;
import com.resend.services.emails.model.CreateEmailOptions;
import com.resend.services.emails.model.CreateEmailResponse;

public class ResendAPI {
    private Resend resend;

    public ResendAPI() {
        this.resend = new Resend("re_P6AmZ5LR_LgCG5SFK3xLeipH4GCdBtyQK");
        //Ya se que esto esta prohibidisimo, pero cuando se monte en el servidor se va a cambiar por una variable de entorno
        //Ademas el repositorio de github es privado, asi que no hay problema
    }

    public void sendEmail(String from, String to, String subject, String html){
        CreateEmailOptions params = CreateEmailOptions.builder()
                .from(from)
                .to(to)
                .subject(subject)
                .html(html)
                .build();

        try{
            CreateEmailResponse response = resend.emails().send(params);
            System.out.println("Email enviado exitosamente: " +response);
        }catch (ResendException e){
            e.printStackTrace();
            System.out.println("Error al enviar el email: " + e.getMessage());
        }
    }
}


