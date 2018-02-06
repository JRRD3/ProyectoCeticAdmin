<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
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
    List<String> datosUsr = new ArrayList<String>();
    datosUsr.add(request.getParameter("select02"));                                             //0
    datosUsr.add(request.getParameter("date01"));                                               //1
    datosUsr.add(new String(request.getParameter("Nombre").getBytes("ISO-8859-1"),"UTF-8"));    //2
    datosUsr.add(new String(request.getParameter("aPaterno").getBytes("ISO-8859-1"),"UTF-8"));  //3
    datosUsr.add(new String(request.getParameter("aMaterno").getBytes("ISO-8859-1"),"UTF-8"));  //4
    datosUsr.add(request.getParameter("sexo"));                                                 //5
    datosUsr.add(request.getParameter("rfcUsr"));                                               //6
    datosUsr.add(request.getParameter("curp"));                                                 //7
    datosUsr.add(request.getParameter("Username"));                                             //8
    datosUsr.add(request.getParameter("Pssw"));                                                 //9
    datosUsr.add(request.getParameter("email"));                                                //10
    datosUsr.add(request.getParameter("select01"));                                             //11
    datosUsr.add(new String(request.getParameter("calle").getBytes("ISO-8859-1"),"UTF-8"));     //12
    datosUsr.add(request.getParameter("nInt"));                                                 //13
    datosUsr.add(request.getParameter("nExt"));                                                 //14
    datosUsr.add(new String(request.getParameter("colonia").getBytes("ISO-8859-1"),"UTF-8"));   //15
    datosUsr.add(request.getParameter("cp"));                                                   //16
    datosUsr.add(request.getParameter("estado"));                                               //17
    datosUsr.add(request.getParameter("municipio"));                                            //18
    datosUsr.add(request.getParameter("nAfiliacion"));                                          //19
    datosUsr.add(request.getParameter("contrato"));                                             //20
    datosUsr.add(request.getParameter("ecivil"));                                               //21
    datosUsr.add(request.getParameter("escolaridad"));                                          //22
    datosUsr.add(request.getParameter("nacionalidad"));                                         //23
    datosUsr.add(request.getParameter("categoria"));                                            //24
    datosUsr.add(request.getParameter("estadoOrigen"));                                         //25
    datosUsr.add(request.getParameter("municipioOrigen"));                                      //26
    datosUsr.add(request.getParameter("acronimo"));                                             //27
    datosUsr.add(request.getParameter("nCuenta"));                                              //28
//    String Nombre = new String(request.getParameter("Nombre").getBytes("ISO-8859-1"),"UTF-8");
//    String aPaterno = new String(request.getParameter("aPaterno").getBytes("ISO-8859-1"),"UTF-8");
//    String aMaterno = new String(request.getParameter("aMaterno").getBytes("ISO-8859-1"),"UTF-8");
//    String FechaNac = request.getParameter("date01");
//    String User = request.getParameter("Username");
//    String Pssw = request.getParameter("Pssw");
//    String Rol = request.getParameter("select01");
//    String UPP = request.getParameter("select02");
//    String email = request.getParameter("email");
    
    SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
    DateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
    Date fecha1 = formatoFecha.parse(datosUsr.get(1));
    String strFechaNac = dateFormat1.format(fecha1);
    
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
    String strFecha = fmt.format(new Date());
    
    String repetido = "",estatus = "1", id = "";
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rfc FROM usuario WHERE rfc = '"+datosUsr.get(6)+"'");
        while(rs.next()){
            repetido = rs.getString("rfc");
        }
//        System.out.println(repetido);
        if(repetido.equals("")){
            stmt.executeUpdate("INSERT INTO usuario "
                         + "(upp, rfc, username, password, id_rol, fechaAlta,activo,email,ur,snAutoriza) "
                         + "VALUES("+datosUsr.get(0)+",'"+datosUsr.get(6)+"','"+datosUsr.get(8)+"','"+datosUsr.get(9)+"',"+datosUsr.get(11)+",'"+strFecha+"',1,'"+datosUsr.get(10)+"','"+datosUsr.get(0)+"',0)");
        }else{estatus = "6";}
        
        ResultSet rs1 = stmt.executeQuery("SELECT rfc FROM cat_empleados WHERE rfc = '"+datosUsr.get(6)+"'");
        while(rs1.next())
            repetido = rs1.getString("rfc");
        
        ResultSet rs2 = stmt.executeQuery("SELECT id FROM usuario WHERE rfc = '"+datosUsr.get(6)+"'");
        while(rs2.next())
            id = rs2.getString("id");
        
        if(repetido.equals("")){
            stmt.executeUpdate("INSERT INTO cat_empleados (ur,id_usuario,primerApellido, segundoApellido, nombres, fechaNacimiento, idSexo, rfc, curp, calle, numInterior, numExterior, colonia, cp, ciudad, estado, numeroaFiliacion, contrato, idEstadoCivil, idEscolaridad, nacionalidad, idCategoria, idestadoOrigen, idmunicipioOrigen, preEscolaridad,noCuenta) "
                              +"VALUES ("+datosUsr.get(0)+","+id+",'"+datosUsr.get(3)+"','"+datosUsr.get(4)+"','"+datosUsr.get(2)+"','"+strFechaNac+"','"+datosUsr.get(5)+"','"+datosUsr.get(6)+"','"+datosUsr.get(7)+"','"+datosUsr.get(12)+"','"+datosUsr.get(13)+"','"+datosUsr.get(14)+"',"
                              +"'"+datosUsr.get(15)+"','"+datosUsr.get(16)+"',"+datosUsr.get(18)+","+datosUsr.get(17)+",'"+datosUsr.get(19)+"','"+datosUsr.get(20)+"',"+datosUsr.get(21)+","+datosUsr.get(22)+","+datosUsr.get(23)+","+datosUsr.get(24)+","+datosUsr.get(25)+","+datosUsr.get(26)+",'"+datosUsr.get(27)+"','"+datosUsr.get(28)+"')");
        }else{
            stmt.executeUpdate("UPDATE cat_empleados SET ur = "+datosUsr.get(0)+", id_usuario = "+id+", primerApellido = '"+datosUsr.get(3)+"', segundoApellido = '"+datosUsr.get(4)+"', nombres = '"+datosUsr.get(2)+"', fechaNacimiento = '"+strFechaNac+"', idSexo = '"+datosUsr.get(5)+"', rfc = '"+datosUsr.get(6)+"', curp = '"+datosUsr.get(7)+"', calle = '"+datosUsr.get(12)+"', numInterior = '"+datosUsr.get(13)+"', numExterior = '"+datosUsr.get(14)+"', "
                              +"colonia = '"+datosUsr.get(15)+"', cp = '"+datosUsr.get(16)+"', ciudad = "+datosUsr.get(18)+", estado = "+datosUsr.get(17)+", numeroaFiliacion = '"+datosUsr.get(19)+"', contrato = '"+datosUsr.get(20)+"', idEstadoCivil = "+datosUsr.get(21)+", idEscolaridad = "+datosUsr.get(22)+", nacionalidad = "+datosUsr.get(23)+", idCategoria = "+datosUsr.get(24)+", idestadoOrigen =  "+datosUsr.get(25)+", idmunicipioOrigen = "+datosUsr.get(26)+", preEscolaridad = '"+datosUsr.get(27)+"', noCuenta = '"+datosUsr.get(28)+"' "
                              +"WHERE rfc = '"+repetido+"'");
        }
        conexion.close();
    }catch(Exception e){System.out.println(e);}
//    java.util.Properties props = new java.util.Properties();
//    props.put("comprobantesnomina@cetic.michoacan.gob.mx","Cetic.14");
//    props.put("mail.smtp.host", "smtp.michoacan.gob.mx");
//    props.put("mail.smtp.socketFactory.port", 25);
//    Session Sesion = Session.getDefaultInstance(props,null);
//    try{
//        Message message = new MimeMessage(Sesion);
//        message.setFrom(new InternetAddress("comprobantesnomina@cetic.michoacan.gob.mx"));
//        message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(""+email+""));
//        message.setRecipients(Message.RecipientType.BCC,InternetAddress.parse("macemodi10@hotmail.com"));
//        message.setSubject("Portal Timbrado de Nómina (Michoacán)");
//        message.setText("Buen día.\n\nSus Credenciales para Acceder al Portal de Timbrado de Nomina Son:\n\n Usuario: "+User+"\n\n Password: "+Pssw+"."
//                       +"\n\nSaludos.");
//        Transport.send(message);
//    }catch(MessagingException e){throw new RuntimeException(e);}
    response.sendRedirect("nuevoUsuario.jsp?reload=exit&sw="+estatus+"");   
%>
</security:authorize>
<security:authorize  access="<%=CadN%>">
    <script src="<c:url value="/assets/js/bootstrap.min.js"/>"></script>
    <div class="col-sm-12" style="padding-top:2%;">
        <div class="alert alert-danger" style="font-size: 30px; text-align: center;border-radius:10px;border-bottom-width:5px;border-left-width:5px;border-color:#CC0605;">
            <strong>Acceso Denegado!</strong> Esta P&aacute;gina No Esta Disponible Para los Permisos del Usuario
        </div>
    </div>
</security:authorize>