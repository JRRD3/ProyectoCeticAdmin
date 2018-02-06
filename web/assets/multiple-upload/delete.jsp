<%@page import="java.util.ResourceBundle"%><%@page import="java.sql.DriverManager"%><%@page import="java.sql.Statement"%><%@page import="java.sql.Connection"%><%@page import="java.sql.Connection"%><%@page import="java.nio.file.Paths"%><%@page import="java.nio.file.Path"%><%@page import="java.nio.file.Files"%>
<%
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_name");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    
    String nombreArchivo = request.getParameter("name");
    String operacion = request.getParameter("op");
    String idViatico = request.getParameter("idViatico");
    String idEmpleado = request.getParameter("idEmpleado");
    String filePath = application.getRealPath("\\adjuntos\\")+"\\"+idViatico+"\\";

    if ("delete".equals(operacion)) {
            request.setAttribute("nombreArchivo", nombreArchivo);
            String nombreCompleto = filePath+"\\"+nombreArchivo;
//            String nombreCompleto = request.getRealPath("/upload/"+nombreArchivo);
            Path path = Paths.get(nombreCompleto);
            Files.deleteIfExists(path);
            %> Archivo Eliminado ${nombreArchivo} <br/><%
    }
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        stmt.executeUpdate("DELETE FROM cat_adjuntos WHERE idViatico = "+idViatico+" AND idEmpleado = "+idEmpleado+" "
                          +"AND nombreArchivo = '"+nombreArchivo+"'");
        stmt.executeUpdate("ALTER TABLE cat_adjuntos AUTO_INCREMENT = 1");
        conexion.close();
    }catch(Exception e){System.out.println(e);}

%>