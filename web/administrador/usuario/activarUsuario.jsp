<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_name");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");

    List<String> P = new ArrayList<String>();
    String Cad = "", Pr = "", CadN = "";
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT menu_rol.id_menu, menu_rol.id_rol FROM  menu_rol "
                                        +"INNER JOIN menus "
                                        +"ON menus.id = menu_rol.id_menu "
                                        +"WHERE menus.nombreMenu = 'Usuarios'");
        while(rs.next()){
            P.add(rs.getString("id_rol"));
        }
        conexion.close();
    }catch(Exception e){System.out.println(e);}
    if(P.size() > 1)
        Cad = "hasAnyRole";
    else
        Cad = "hasRole";
    for(String c : P)
        Pr = Pr + "'"+c+"',";
    Pr = Pr.substring(0,Pr.length()-1);
    Cad = Cad+"("+Pr+")";
    CadN = "!"+Cad;
%>
<security:authorize  access="<%=Cad%>">
<%
    String Usr = request.getParameter("user");
    String select01 = request.getParameter("NJGU");
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        stmt.executeUpdate("UPDATE usuario SET activo = 1 WHERE id = "+Usr+"");
        conexion.close();
    }catch(Exception e){System.out.println(e);}
    
    String estatus = "4";
    byte[]   bytesEncoded2 = Base64.encodeBase64(estatus.getBytes());//encoding part
    estatus = new String(bytesEncoded2);  
    bytesEncoded2 = Base64.encodeBase64(select01.getBytes());//encoding part
    select01 = new String(bytesEncoded2);  
    
    response.sendRedirect("usuarios.jsp?NBVF="+estatus+"&NJGU="+select01);
%>
</security:authorize>
<security:authorize  access="<%=CadN%>">
    <script src="<c:url value="/assets/js/bootstrap.min.js"/>"></script>
    <link href="<c:url value="/assets/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/assets/css/ace.min.css"/>" rel="stylesheet">
    <div class="col-sm-12" style="padding-top:2%;">
        <div class="alert alert-danger" style="font-size: 30px; text-align: center;border-radius:10px;border-bottom-width:5px;border-left-width:5px;border-color:#CC0605;">
            <strong>Acceso Denegado!</strong> Esta P&aacute;gina No Esta Disponible Para los Permisos del Usuario
        </div>
    </div>
</security:authorize>