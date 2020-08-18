package com.park.ch.user.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
 
public class MailSendController extends Authenticator {
    
    PasswordAuthentication pa;
    
    public MailSendController() {
        String mail_id = "chungheeparkcorp@gmail.com";
        //String mail_pw = "chlgmldnjs131@icloud.com";
        String mail_pw = "acayztiuvidoibsy";
        
        pa = new PasswordAuthentication(mail_id, mail_pw);
    }
    
    public PasswordAuthentication getPasswordAuthentication() {
        return pa;
    }
}


