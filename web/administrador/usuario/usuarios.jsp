<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String User = SecurityContextHolder.getContext().getAuthentication().getName();
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
    String logout = request.getParameter("TUOG");
    if(logout != null){
        byte[] valueDecoded= Base64.decodeBase64(logout);//decoding part
        logout = new String(valueDecoded);
    }
    if(logout == null) logout = "";
    if(logout.equals("1"))
        response.sendRedirect(request.getContextPath()+"/logout.jsp");

    String cfr = request.getParameter("cfrr");
    String rfc = request.getParameter("rfc");
    if(rfc == null) rfc = "";
    if(cfr != null){
        byte[] valueDecoded= Base64.decodeBase64(cfr);//decoding part
        cfr = new String(valueDecoded);
        rfc = cfr;
    }
//    System.out.println(rfc);
    String select01 = request.getParameter("NJGU");
    if(select01 != null){
        byte[] valueDecoded= Base64.decodeBase64(select01);//decoding part
        select01 = new String(valueDecoded);
    }
    if(select01 == null) select01 = "";
    if(select01.equals("...")) select01 = "";
    
    String rfcUser = "";
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM usuario WHERE username = '"+User+"'");
        while(rs.next()){
            rfcUser = rs.getString("upp");
        }
        conexion.close();
    }catch(Exception e){System.out.println(e);}
    
    String estatus = request.getParameter("NBVF");
    if(estatus != null){
        byte[] valueDecoded= Base64.decodeBase64(estatus);//decoding part
        estatus = new String(valueDecoded);
    }
    if (estatus == null) estatus = "0";
 %>
 <%--
    DecimalFormat df = new DecimalFormat("###,###,###,###.##");
    int Inc = 10;
    String min = request.getParameter("HJUI");
    String max = request.getParameter("FTRE");
    String pagina = request.getParameter("WSDQ");
    if(min != null){
        byte[] valueDecoded= Base64.decodeBase64(min);//decoding part
        min = new String(valueDecoded);
        valueDecoded= Base64.decodeBase64(max);//decoding part
        max = new String(valueDecoded);
        valueDecoded= Base64.decodeBase64(pagina);//decoding part
        pagina = new String(valueDecoded);
    }
    if (min == null) min = "0";
    if (max == null) max = ""+Inc;
    if (pagina == null) pagina = "1";
    int Min = Integer.parseInt(String.valueOf(min));
    int Max = Integer.parseInt(String.valueOf(max));
    int Limit = 0;
    double limit = 0;
    
    String consulta = "";
    consulta = "SELECT COUNT(1) FROM usuario ";
    if(!rfc.equals("")) {consulta+=" WHERE usuario.rfc LIKE '%"+rfc+"%' "; select01="";}
    if(!select01.equals("")){ consulta+=" WHERE usuario.upp = '"+select01+"' "; }
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery(consulta);
        while(rs.next()){
            limit = Double.parseDouble(String.valueOf(rs.getString(1)));
        }
        conexion.close();
    }catch(Exception e){System.out.println(e);}
    Limit = (int) limit;
    if(limit%Inc==0) limit = Math.round(limit / Inc); else limit = Math.round(limit / Inc+0.5);
    if(limit == 0) limit = 1;
    int Max1 = 0;
    if(Min != 0) Max1 = Inc; else Max1 = Max;
--%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administración de Usuarios</title>
    </head>
    <body>
        <!--<script src="../assets/pagination/js/jquery-1.7.2.min.js"></script>-->
        <!--<script type="text/javascript" src="/portalTimbrado/assets/scripts/jquery-1.8.3.min.js"></script>-->
        <script src="<c:url value="/assets/js/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/assets/pagination/js/jquery.jqpagination.js"/>"></script>

        <script src="<c:url value="/assets/fancybox/jquery.fancybox.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/assets/fancybox/jquery.fancybox.pack.js"/>"></script>
        <script src="<c:url value="/assets/DataTables/js/jquery.dataTables.min.js"/>"></script>
        <script src="<c:url value="/assets/DataTables/js/dataTables.jqueryui.min.js"/>"></script>
        <script src="<c:url value="/assets/DataTables/js/dataTables.responsive.min.js"/>"></script>
        <script src="<c:url value="/assets/DataTables/js/responsive.jqueryui.min.js"/>"></script>       
        <script>
            $(document).ready(function(){                
                $('#example').dataTable({
                    "responsive": true,
//                    "paging":   false,
//                    "bJQueryUI": true,
//                    "sDom": 'lfrtip',
//                    "bLengthChange": false,
//                    "info":     false,
//                    "bFilter": false,
                    "bSort": true,
                    "order": [[ 0, "asc" ]],
                    "columnDefs": [{"targets": [ 0 ],"visible": false,"searchable": false}]
//                    "order": [[ 3, 'desc' ], [ 0, 'asc' ]]
//                    "order": [[ 3, "asc" ]]
                });
                $(".popupfac").fancybox({
                    closeClick    :   false,
                    autoScale     :   false,
                    transitionIn  :   'elastic',
                    transitionOut :   'elastic',
                    type          :   'iframe',
                    overlayShow   :   false,
                    width         :   1020,
                    height        :   750,
                    autoSize      :   false,
//                    'closeClick'    :   false,
//                    'autoScale'     :   true,
//                    'autoSize'      :   true,
//                    'transitionIn'  :   'elastic',
//                    'transitionOut' :	'elastic',
//                    'type'          :   'iframe',
//                    'overlayShow'   :    false,
//                    'fitToView'     :    false,
//                    'width'         :    '80%',
                    helpers   : {
                        overlay : {closeClick: true} // prevents closing when clicking OUTSIDE fancybox
                    },
                    'afterClose':function () {
                        window.location.reload();
                    }
                });
                $(".popupfacPer").fancybox({
                    'closeClick'    :   false,
                    'autoScale'     :   false,
                    'transitionIn'  :   'elastic',
                    'transitionOut' :	'elastic',
                    'type'          :   'iframe',
                    'overlayShow'   :    false,
                    helpers   : {
                        overlay : {closeClick: true} // prevents closing when clicking OUTSIDE fancybox
                    },
                    'afterClose':function () {
                        window.location.reload();
                    }
                }); 
            });
            function borrar(){
                document.getElementById("estatus").style.display = "none";
            }
        </script>
        <div class="col-sm-12">
            <div class="widget-box">
                <div class="widget-header">
                    <h4 class="smaller" style="font-weight: bold;">
                        Administraci&oacute;n de Usuarios
                    </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main">
                        <%if(estatus.equals("1")){%>
                        <div id="estatus" class="alert alert-success">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='usuarios.jsp'">×</a>
                            <strong>Usuario Creado Correctamente!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("2")){%>
                        <div id="estatus" class="alert alert-danger">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='usuarios.jsp'">×</a>
                            <strong>Usuario Desactivado Correctamente!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("3")){%>
                        <div id="estatus" class="alert alert-info">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='usuarios.jsp'">×</a>
                            <strong>Usuario Editado Correctamente!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("4")){%>
                        <div id="estatus" class="alert alert-info">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='usuarios.jsp'">×</a>
                            <strong>Usuario Activado Correctamente!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("6")){%>
                        <div id="estatus" class="alert alert-danger">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='usuarios.jsp'">×</a>
                            <strong>El Usuario Ya Existe!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("7")){%>
                        <div id="estatus" class="alert alert-success">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='usuarios.jsp'">×</a>
                            <strong>Permisos Asignados Correctamente!</strong>
                        </div>
                        <%}%>
                       <a onclick="borrar()" class="btn btn-white btn-info btn-bold popupfac" href='nuevoUsuario.jsp' style="border-right-width:3px;border-bottom-width:3px;color:#0044cc!important;border-color:#0044cc;">
                            <i class="ace-icon fa fa-plus-circle bigger-120 blue" style="color:#0044cc!important;"></i>
                            Nuevo
                        </a>
                       <br><br>
                        <%--security:authorize  access="hasRole('1')" --%> 
                        <form action="usuarios.jsp" method="post" onchange="submit()"> 
                            <label class="control-label" style="display: initial;" for="select01"><b>Direcci&oacute;n&nbsp;(UPP):</b></label>
                            <select id="NJGU" name="NJGU" style="width: 318px;text-transform: uppercase;" onclick="borrar();">
                                <option>...</option>
                                <%
                                try{
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                    Statement stmt = conexion.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_ur");
                                    while(rs.next()){
                                        byte[] bytesEncoded2 = Base64.encodeBase64(rs.getString("clave").getBytes());//encoding part
                                        String select10 = new String(bytesEncoded2);  
                                        %>
                                        <option value="<%=select10%>" 
                                        <%if(rs.getString("clave").equals(select01) && select01 != null && !select01.equals("")){out.print("selected");}%>>
                                            <%=rs.getString("descripcion")%>
                                        </option>
                                        <%
                                    }
                                    conexion.close();
                                }catch(Exception e){System.out.println(e);}
                                %>
                            </select>
                        </form>
                        <%--/security:authorize--%>
                       <br>
                        <form  class="form-horizontal" id="form" name="form" action="usuarios.jsp" method="post"> 
                            <label class="control-label"><b>Username:</b></label>
                            <input  type="text" name="rfc" id="rfc" style="width: 258px;text-transform: uppercase;">
                            <button type="submit" class="btn btn-white btn-info btn-bold" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                                <i class="ace-icon fa icon-search bigger-120 blue" style="color:#00969A!important;"></i>
                                Buscar
                            </button>
                        </form>
                        <br>
                        <table id="example" class="display responsive nowrap" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>
                                        ID
                                    </th>
                                    <th>
                                        Estatus
                                    </th>
                                    <th>
                                        UPP
                                    </th>
                                    <th>
                                        Nombre
                                    </th>
<!--                                    <th>
                                        Fecha Nacimiento
                                    </th>-->
                                    <th>
                                        Username
                                    </th>
                                    <th style="text-align:center;">
                                        Acciones
                                    </th>
                                    <th>
                                        Rol
                                    </th>
                                    <th>
                                        Fecha de Alta
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%--security:authorize  access="hasRole('1')" --%> 
                                    <%String consulta = "SELECT usuario.id,usuario.upp,cat_ur.descripcion, "
                                                       +"CONCAT(cat_empleados.nombres,' ',cat_empleados.primerApellido) as nombre, "
                                                       +"usuario.username,roles.nombre as rol, usuario.fechaAlta, usuario.activo "
                                                       +"FROM usuario "
                                                       +"INNER JOIN roles "
                                                       +" ON usuario.id_rol = roles.id "
                                                       +"INNER JOIN cat_ur "
                                                       +" ON usuario.upp = cat_ur.clave "
                                                       +"INNER JOIN cat_empleados "
                                                       +" ON cat_empleados.rfc = usuario.rfc ";
                                                if(!rfc.equals("")) {consulta+=" WHERE usuario.rfc LIKE '%"+rfc+"%' "; select01="";}
                                                if(!select01.equals("")){ consulta+="WHERE usuario.upp = '"+select01+"' "; }
//                                       consulta+="LIMIT "+Min+","+Max1+"";
                                    %>
                                <%--/security:authorize>
                                <security:authorize  access="!hasRole('1')" > 
                                    <%consulta = "SELECT usuario.id,usuario.upp,cat_ur.descripcion,usuario.nombre,usuario.apellidoP,usuario.apellidoM,usuario.fechaNacimiento,"
                                                +"usuario.username,roles.nombre as rol, usuario.fechaAlta, usuario.activo FROM usuario "
                                                +"INNER JOIN roles"
                                                +" ON usuario.id_rol = roles.id "
                                                +"INNER JOIN cat_ur "
                                                +"ON usuariouppur = cat_ur.clave "
                                                +"WHERE usuario.upp = '"+rfcUser+"' AND id_rol <> 1 ";
                                                if(!rfc.equals("")) {consulta+=" AND usuario.username LIKE '%"+rfc+"%' ";}
                                                consulta+="LIMIT "+Min+","+Max1+"";%>
                                </security:authorize--%>
                                <%

                                    try{
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();
                                        ResultSet rs = stmt.executeQuery(consulta);
                                        while(rs.next()){
                                %>
                                <tr>
                                    <td><%=rs.getString("usuario.id")%></td>
                                    <td>
                                        <span class="<%if(rs.getString("activo").equals("1")){out.print("badge badge-success");}else{out.print("badge");}%>">
                                            <%if(rs.getString("activo").equals("1")){out.print("Activo");}else{out.print("Inactivo");}%>
                                        </span>
                                    </td>
                                    <%--td><%=rs.getString("id")%></td--%>
                                    <td style="text-transform: uppercase;"><%=rs.getString("cat_ur.descripcion")%></td>
                                    <td style="text-transform: uppercase;"><%=rs.getString("nombre")%></td>
                                    <%--td><%if(rs.getString("fechaNacimiento") == null) out.print("No Disponible"); else out.print(rs.getString("fechaNacimiento"));%></td--%>
                                    <td style="text-transform: uppercase;"><%=rs.getString("username")%></td>
                                    <td class="center ">
                                        <a onclick="borrar()" class="btn btn-white btn-warning btn-bold popupfac" href="editarUsuario.jsp?user=<%=rs.getString("id")%>" style="border-right-width:3px;border-bottom-width:3px;color:#51a351!important;border-color:#51a351">
                                            <i class="ace-icon fa icon-edit bigger-120 orange" style="color:#51a351!important"></i> <!--#790754-->
                                            Editar    
                                        </a>
                                        <%if(rs.getString("activo").equals("1")){%>
                                        <a onclick="borrar()" class="btn btn-white btn-default btn-round" href="eliminarUsuario.jsp?user=<%=rs.getString("id")%>&NJGU=<%=select01%>" style="border-right-width:3px;border-bottom-width:3px;color:#bd362f!important;border-color:#bd362f">
                                            <i class="ace-icon fa fa-times red2" style="color:#bd362f!important;"></i>
                                            Desactivar
                                        </a>
                                        <%}else{%>
                                        <a onclick="borrar()" class="btn btn-white btn-info btn-bold" href="activarUsuario.jsp?user=<%=rs.getString("id")%>&NJGU=<%=select01%>" style="border-right-width:3px;border-bottom-width:3px;color:#0044cc!important;border-color:#0044cc;"> 
                                            <i class="ace-icon fa icon-ok bigger-120 blue" style="color:#0044cc!important;"></i>
                                            Activar
                                        </a>
                                        <%}%>
                                    </td>
                                    <td><%=rs.getString("rol")%></td>
                                    <td><%=rs.getString("fechaAlta")%></td>
                                </tr>
                                <%
                                        }
                                    conexion.close();
                                    }catch(Exception e){System.out.println(e);}
                                %>
                            </tbody>
                        </table>
                        <%--div style="clear: both;position: relative;">
                            <div class="pagination" style=" width: 248px; height: 21px; margin: 20px 0; border: 1px solid #CDCDCD;float: right !important;">
                                <a style="text-decoration: none;" href="#" class="first" data-action="first">&laquo;</a>
                                <a style="text-decoration: none;" href="#" class="previous" data-action="previous">&lsaquo;</a>
                                <input style=" width: 166px; height: 18px; border-radius: 0px; border: 1px solid #ffffff; box-shadow: none; color:#000" type="text" readonly="readonly" data-max-page="<%=limit%>"/>
                                <a style="text-decoration: none;" href="#" class="next" data-action="next">&rsaquo;</a>
                                <a style="text-decoration: none;" href="#" class="last" data-action="last">&raquo;</a>
                            </div>
                            <div style="text-align: right; line-height: 0px;clear: both;position: relative;">
                                <br><br><br>&nbsp;&nbsp;Registros&nbsp;<%=df.format(Min+1)%>&nbsp;a&nbsp;<%if(Max > Limit){%><%=df.format(Limit)%><%}else{%><%=df.format(Max)%><%}%>&nbsp;de&nbsp;<%=df.format(Limit)%>&nbsp
                            </div> 
                        </div--%>
                    </div>
                </div>
            </div>
        </div>
        <%--script>
            $.jqPagination.defaultOptions = {
                current_page	: <%=pagina%>,
                link_string		: '',
                max_page		: null,
                page_string		: 'Pagina {current_page} de {max_page}',
                paged			: function () {}
            };
            $('.pagination').jqPagination({
                paged: function(page) {
                    var calcMax = page * <%=Inc%>;
                    var calcMin =  calcMax - <%=Inc%>;
                    var enccalcMax = window.btoa(calcMax);
                    var enccalcMin = window.btoa(calcMin);
                    var encpage = window.btoa(page);
                    <%
                        byte[] bytesEncoded2 = Base64.encodeBase64(select01.getBytes());//encoding part
                        String select10 = new String(bytesEncoded2); 
                        bytesEncoded2 = Base64.encodeBase64(rfc.getBytes());//encoding part
                        String rfc1 = new String(bytesEncoded2); 
                    %>
                    var select = '<%=select10%>';
                    var rfc = '<%=rfc1%>';
                    window.location.href = '../usuario/usuarios.jsp?HJUI='+enccalcMin+'&FTRE='+enccalcMax+'&WSDQ='+encpage+'&NJGU='+select+'&cfrr='+rfc;
                }
            });
        </script--%>
    </body>
</html>
</security:authorize>
<security:authorize  access="<%=CadN%>">
    <script src="<c:url value="/assets/js/bootstrap.min.js"/>"></script>
    <div class="col-sm-12" style="padding-top:2%;">
        <div class="alert alert-danger" style="font-size: 30px; text-align: center;border-radius:10px;border-bottom-width:5px;border-left-width:5px;border-color:#CC0605;">
            <strong>Acceso Denegado!</strong> Esta P&aacute;gina No Esta Disponible Para los Permisos del Usuario
        </div>
    </div>
</security:authorize>