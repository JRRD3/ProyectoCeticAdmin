<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ResourceBundle"%>
<%
    String Username = SecurityContextHolder.getContext().getAuthentication().getName();
    String Id = request.getParameter("Id");
//    String ur = request.getParameter("select02");
//    String Nombre = new String(request.getParameter("Nombre").getBytes("ISO-8859-1"),"UTF-8");
//    String aPaterno = new String(request.getParameter("aPaterno").getBytes("ISO-8859-1"),"UTF-8");
//    String aMaterno = new String(request.getParameter("aMaterno").getBytes("ISO-8859-1"),"UTF-8");
//    String User = request.getParameter("Username");
//    String Pssw = request.getParameter("Pssw");
//    String Rol = request.getParameter("select01");
//    String FechaNac = request.getParameter("date01");
//    String email = request.getParameter("email");

    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_name");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    
    List<String> datosUsr = new ArrayList<String>();
    datosUsr.add(request.getParameter("select02"));
    datosUsr.add(request.getParameter("date01"));
    datosUsr.add(new String(request.getParameter("Nombre").getBytes("ISO-8859-1"),"UTF-8"));
    datosUsr.add(new String(request.getParameter("aPaterno").getBytes("ISO-8859-1"),"UTF-8"));
    datosUsr.add(new String(request.getParameter("aMaterno").getBytes("ISO-8859-1"),"UTF-8"));
    datosUsr.add(request.getParameter("sexo"));
    datosUsr.add(request.getParameter("rfcUsr"));
    datosUsr.add(request.getParameter("curp"));
    datosUsr.add(request.getParameter("Username"));
    datosUsr.add(request.getParameter("Pssw"));
    datosUsr.add(request.getParameter("email"));
    datosUsr.add(request.getParameter("select01"));
    datosUsr.add(new String(request.getParameter("calle").getBytes("ISO-8859-1"),"UTF-8"));
    datosUsr.add(request.getParameter("nInt"));
    datosUsr.add(request.getParameter("nExt"));
    datosUsr.add(new String(request.getParameter("colonia").getBytes("ISO-8859-1"),"UTF-8"));
    datosUsr.add(request.getParameter("cp"));
    datosUsr.add(request.getParameter("estado"));
    datosUsr.add(request.getParameter("municipio"));
    datosUsr.add(request.getParameter("nAfiliacion"));
    datosUsr.add(request.getParameter("contrato"));
    datosUsr.add(request.getParameter("ecivil"));
    datosUsr.add(request.getParameter("escolaridad"));
    datosUsr.add(request.getParameter("nacionalidad"));
    datosUsr.add(request.getParameter("categoria"));
    datosUsr.add(request.getParameter("estadoOrigen"));
    datosUsr.add(request.getParameter("municipioOrigen"));
    datosUsr.add(request.getParameter("acronimo"));
    datosUsr.add(request.getParameter("nCuenta"));
    
    String strFecha = "", cadenaFecha = " ";
    if(!datosUsr.get(1).equals("")){
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        Date fecha = formatoFecha.parse(datosUsr.get(1));
        strFecha = dateFormat1.format(fecha);
        cadenaFecha = ", fechaNacimiento = '"+strFecha+"' ";
    }
    
    String repetido = "",estatus = "7";
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT id_rol FROM usuario WHERE username = '"+Username+"'");
        while(rs.next()){
            repetido = rs.getString("id_rol");
        }
//        System.out.println(repetido);
//        if(repetido.equals("")){
        stmt.executeUpdate("UPDATE usuario SET "
                         + "upp = "+datosUsr.get(0)+", username = '"+datosUsr.get(8)+"', password = '"+datosUsr.get(9)+"', "
                         + "email = '"+datosUsr.get(10)+"', id_rol = "+datosUsr.get(11)+", rfc = '"+datosUsr.get(6)+"' "
                         + "WHERE id = "+Id+"");
        stmt.executeUpdate("UPDATE cat_empleados SET ur = "+datosUsr.get(0)+", primerApellido = '"+datosUsr.get(3)+"', segundoApellido = '"+datosUsr.get(4)+"', nombres = '"+datosUsr.get(2)+"', idSexo = '"+datosUsr.get(5)+"', rfc = '"+datosUsr.get(6)+"', curp = '"+datosUsr.get(7)+"', calle = '"+datosUsr.get(12)+"', numInterior = '"+datosUsr.get(13)+"', numExterior = '"+datosUsr.get(14)+"', "
                          +"colonia = '"+datosUsr.get(15)+"', cp = '"+datosUsr.get(16)+"', ciudad = "+datosUsr.get(18)+", estado = "+datosUsr.get(17)+", numeroaFiliacion = '"+datosUsr.get(19)+"', contrato = '"+datosUsr.get(20)+"', idEstadoCivil = "+datosUsr.get(21)+", idEscolaridad = "+datosUsr.get(22)+", nacionalidad = "+datosUsr.get(23)+""+cadenaFecha+", idCategoria = "+datosUsr.get(24)+", "
                          +"idestadoOrigen =  "+datosUsr.get(25)+", idmunicipioOrigen = "+datosUsr.get(26)+", preEscolaridad = '"+datosUsr.get(27)+"', noCuenta = '"+datosUsr.get(28)+"' "
                          +"WHERE rfc = '"+datosUsr.get(6)+"'");
//        }else{estatus = "7";}
        conexion.close();
    }catch(Exception e){System.out.println("Editar Usr: "+e);}
    if((!Username.equals(datosUsr.get(8))) || (!datosUsr.get(11).equals(repetido))){
        response.sendRedirect("editarUsuario.jsp?reload=exit&sw="+estatus+"&TUOG=0");
    }else{
        response.sendRedirect("editarUsuario.jsp?reload=exit&sw="+estatus+"&TUOG=1");
    }
%>