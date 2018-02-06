<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%
    String Rol = SecurityContextHolder.getContext().getAuthentication().getAuthorities().toString();
    Rol = Rol.substring(Rol.lastIndexOf("[")+1, Rol.lastIndexOf("]"));
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_name");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    String principal = "";
    //Consulta realizada para obtener la página principal a la cual será redirigido al momento de autentificarse. 
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM roles WHERE id = "+Rol);
        while(rs.next()){
            principal = rs.getString("paginaPrincipal");
        }
        conexion.close();
    }catch(Exception e){System.out.println("Index: "+e);}
//    System.out.println(principal);
%>


<security:authorize access="isAuthenticated()">
    <c:redirect url="<%=principal%>"/>
</security:authorize>
<c:redirect url="login.jsp"/>