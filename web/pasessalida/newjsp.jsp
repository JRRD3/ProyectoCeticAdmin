<%-- 
    Document   : newjsp
    Created on : 25/01/2018, 02:54:34 PM
    Author     : JR
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%String bd = "jdbc:mysql://localhost:3306/nomina";
    String usr = "root";
    String pssw ="admin123"; 
    try{ Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);  
    } catch(Exception e){
       System.out.println(e); 
    }
    
    %>

    <body>
        <h1>Bienvenido a Gestión de Incidencias del CETIC</h1>
    </body>
</html>
