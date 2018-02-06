<%@page import="java.util.ResourceBundle"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recuperación de Contraseñas</title>
    </head>
    <body>
        <%
            ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
            String bd = resource.getString("ceticAdmin.bd_name");
            String usr = resource.getString("ceticAdmin.bd_user");
            String pssw = resource.getString("ceticAdmin.bd_password");
            String Usuario = request.getParameter("Usuario");
            String Correo = request.getParameter("Correo");
            String pwd = "", usuario = "", email = "", band="";
            System.out.println(Usuario+" "+Correo);
            
            //try{ 
                DriverManager.registerDriver(new org.gjt.mm.mysql.Driver()); 
                Connection conexion = DriverManager.getConnection(bd, usr, pssw); 
                Statement sentencia = conexion.createStatement();
                ResultSet rs = sentencia.executeQuery("SELECT password FROM usuario WHERE username = '"+Usuario+"' AND email = '"+Correo+"'");
                while(rs.next()){
                    pwd = String.valueOf(rs.getString(1));
                    System.out.println(pwd);
                }
                if(pwd.equals("")){
                    band="0";
                        %>  
                        <jsp:forward page="Errores.jsp">
                            <jsp:param name="Band" value="<%=band%>"/>
                        </jsp:forward> 
                        <%
                }else{
                    band = "2";
                    %>  
                    <jsp:forward page="Errores.jsp">
                        <jsp:param name="Band" value="<%=band%>"/>
                        <jsp:param name="pwd" value="<%=pwd%>"/>
                    </jsp:forward> 
                    <%    
                }
                conexion.close();
            //}catch (Exception e){System.out.println(e);}
        %>
    </body>
</html>
