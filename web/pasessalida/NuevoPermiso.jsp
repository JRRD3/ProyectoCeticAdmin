<%-- 
    Document   : newjsp
    Created on : 20/04/2017, 09:15:31 AM
    Author     : Rodrigo
--%>

<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.9.3/css/bootstrap-select.min.css">

        <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
        <link rel="stylesheet" href="assets/css/wickedpicker.css">
        <script type="text/javascript" src="assets/js/wickedpicker.js"></script>
        <meta name="description" content="A lightweight, customizable jQuery timepicker plugin inspired by Google Calendar. Add a user-friendly javascript timepicker dropdown to your app in minutes." />
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

        <script type="text/javascript" src="jquery.timepicker.js"></script>
        
        
        
        <link rel="stylesheet" type="text/css" href="jquery.timepicker.css" />

        <script type="text/javascript" src="lib/bootstrap-datepicker.js"></script>
        <link rel="stylesheet" type="text/css" href="lib/bootstrap-datepicker.css" />

        <script type="text/javascript" src="lib/site.js"></script>
        <link rel="stylesheet" type="text/css" href="lib/site.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <link type="text/css" href="css/bootstrap.min.css" />
        <link type="text/css" href="css/bootstrap-timepicker.min.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-timepicker.min.js"></script>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
        <link href="jquery.datetimepicker.css" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>  
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
        <script src="js/jquery.js"></script>
        <script src="js/timepicki.js"></script>

        <link rel="stylesheet" type="text/css" href="css/timepicki.css">
        <title>NUEVO PERMISO</title>
    </head>

    <body>
        <link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
        <script src="js/script.js"></script>
        <script type="text/javascript">jQuery.noConflict();</script>
        <script src="<c:url value="/assets/BootstrapSelect/js/jquery-1.11.3.min.js"/>"></script>
        <!--aqui falta un libreria que hacia estorbo y por eso fue eliminada-->
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-select.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/i18n/defaults-es_CL.min.js"/>"></script>



        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datetimepicker.min.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datepickerNew.js"/>"></script>

        <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="./js/jquery-ui-1.8.21.custom.min.js"></script>
        <script type="text/javascript" src="./js/jquery-ui-timepicker-addon.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.js"></script>
        <script src="jquery.datetimepicker.full.js"></script>

        <script src="<c:url value="/assets/js/jquery-2.0.3.min.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datetimepicker.min.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datepickerNew.js"/>"></script>

        <!--aqui falta un libreria que hacia estorbo y por eso fue eliminada-->
        <script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.9.3/js/bootstrap-select.min.js"></script>

        <script  type="text/javascript">
            $(document).ready(function(e) {
                $('#nombres').selectpicker();
                $('#select3').selectpicker();
            });
        </script>

        <script type="text/javascript">
            $(function() {
                $('#datetimepicker1').datetimepicker({
                    pickTime: false
                });
                $('#datetimepicker2').datetimepicker({
                    pickTime: false
                });
                $('#datetimepicker3').datetimepicker({
                    pickTime: false
                });
                $('#datetimepicker8').datetimepicker({
                    pickTime: false
                });
            });</script>

        <script type="text/javascript">
            $(function() {
                $('#datetimepicker4').datetimepicker({
                    pickDate: false,
                    pick12HourFormat: true
                });
                $('#datetimepicker5').datetimepicker({
                    pickDate: false,
                    pick12HourFormat: true
                });
                $('#datetimepicker6').datetimepicker({
                    pickDate: false,
                    pick12HourFormat: true
                });
                $('#datetimepicker7').datetimepicker({
                    pickDate: false,
                    pick12HourFormat: true
                });
            });
        </script>



        <div class="col-sm-12">
            <div class="widget-box">
                <div class="widget-header">
                    <h4 class="smaller" style="font-weight: bold;">
                        NUEVO PERMISO
                    </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main">
                        <article>
                            <form method="get" action="NuevoPermiso.jsp" id="form1" name="form1">
                                <div style="width: 100%;">
                                    <%
                                        String Rol = SecurityContextHolder.getContext().getAuthentication().getAuthorities().toString();
                                        Rol = Rol.substring(Rol.lastIndexOf("[") + 1, Rol.lastIndexOf("]"));
                                        String User = SecurityContextHolder.getContext().getAuthentication().getName();
                                        ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
                                        String bd = resource.getString("ceticAdmin.bd_name");
                                        String usr = resource.getString("ceticAdmin.bd_user");
                                        String pssw = resource.getString("ceticAdmin.bd_password");
                                        String seleccion = request.getParameter("select3");

                                        if (seleccion == null) {
                                            seleccion = "null";
                                        }

                                        String nombre = request.getParameter("nombres");
                                        if (nombre == null) {
                                            nombre = "nadie";
                                        }
                                        int idU = 2;
                                        String consulta = "";
                                        if (Rol.equalsIgnoreCase("1")) {
                                            consulta = "select usuario.id from usuario inner join cat_empleados  where usuario.rfc = cat_empleados.rfc and '" + nombre + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres)";
                                        } else {
                                            consulta = "select id from usuario where username= '" + User + "' ";
                                        }

                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                            Statement stmt = conexion.createStatement();
                                            ResultSet rs = stmt.executeQuery(consulta);
                                            while (rs.next()) {
                                                idU = rs.getInt("id");
                                            }
                                        } catch (Exception e) {
                                            System.out.println("Index: " + e);
                                        }

                                        String id = "";
                                        if (Rol.equalsIgnoreCase("1")) {
                                            String lista = "";
                                            try {
                                                Class.forName("com.mysql.jdbc.Driver");
                                                Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                Statement stmt = conexion.createStatement();
                                                ResultSet jj = stmt.executeQuery("select upp from usuario where username = '" + User + "'");
                                                String upp = "";
                                                while (jj.next()) {
                                                    upp = jj.getString("upp");
                                                }
                                                ResultSet rs = stmt.executeQuery("Select idcat_empleados, primerApellido, segundoApellido, nombres from cat_empleados where activo = '1' and upp = '" + upp + "' ORDER BY primerApellido ASC");
                                    %>

                                    <select data-live-search="true" title="ESCOGE ALGÚN NOMBRE" data-width="420px" id="nombres" name="nombres" required>
                                        <%
                                            while (rs.next()) {
                                                lista = rs.getString("primerApellido") + " " + rs.getString("segundoApellido") + " " + rs.getString("nombres");
                                                id = rs.getString("idcat_empleados");
                                        %>
                                        <%if (nombre.equalsIgnoreCase(lista)) {%>
                                        <option data-tokens="<%=lista%>" value="<%=lista%>" selected> <%=lista%></option>
                                        <%} else {%>
                                        <option data-tokens="<%=lista%>" value="<%=lista%>"> <%=lista%></option>
                                        <%}%>
                                        <%} %>

                                    </select><br/><br/>

                                    <% conexion.close();
                                        } catch (Exception e) {
                                            System.out.println("Index: " + e);
                                        }
                                    } else {
                                        String lista = "";
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                            Statement stmt = conexion.createStatement();
                                            ResultSet rs = stmt.executeQuery("Select idcat_empleados, primerApellido, segundoApellido, nombres from cat_empleados inner join usuario where usuario.username = '" + User + "' and cat_empleados.rfc = usuario.rfc ORDER BY primerApellido ASC");
                                    %>
                                    <label>EMPLEADO</label><br>
                                    <select  name="select2" style="width: 420px" id="select2" required>
                                        <%
                                            while (rs.next()) {
                                                lista = rs.getString("primerApellido") + " " + rs.getString("segundoApellido") + " " + rs.getString("nombres");
                                                id = rs.getString("idcat_empleados");
                                        %>
                                        <option value="<%=lista%>"><%=lista%></option>
                                        <%}
                                        %>
                                    </select><br/><br/></br>

                                    <% conexion.close();
                                            } catch (Exception e) {
                                                System.out.println("Index: " + e);
                                            }
                                        }
                                    %>
                                    <label>SELECCIONE LA CATEGORIA DEL PERMISO QUE NECESITA</label><br>
                                    <label>
                                        <%if (Rol.equalsIgnoreCase("1")) {%>
                                        <select title="SELECCIONE UNA OPCIÓN" data-width="420px" name="select3" id="select3" style="width: 420px" onchange="location = 'NuevoPermiso.jsp' + '?' + 'select3=' + select3.value + '&' + 'nombres=' + nombres.value"> 
                                            <%if (seleccion.equalsIgnoreCase("pase de salida")) {%>
                                            <option value="pase de salida" selected>PASE DE SALIDA</option>
                                            <%} else {%>
                                            <option value="pase de salida">PASE DE SALIDA</option>
                                            <%}%>
                                            <%if (seleccion.equalsIgnoreCase("permiso para llegar tarde")) {%>
                                            <option value="permiso para llegar tarde" selected>PERMISO PARA LLEGAR TARDE</option>
                                            <%} else {%>
                                            <option value="permiso para llegar tarde">PERMISO PARA LLEGAR TARDE</option>
                                            <%}%>
                                            <%if (seleccion.equalsIgnoreCase("salida anticipada")) {%>
                                            <option value="salida anticipada" selected>SALIDA ANTICIPADA</option>
                                            <%} else {%>
                                            <option value="salida anticipada">SALIDA ANTICIPADA</option>
                                            <%}%>
                                            <%if (seleccion.equalsIgnoreCase("permiso economico")) {%>
                                            <option value="permiso economico" selected>PERMISO ECONOMICO</option>
                                            <%} else {%>
                                            <option value="permiso economico">PERMISO ECONOMICO</option>
                                            <%}%>
                                        </select>
                                        <% } else {%> 
                                        <select title="SELECCIONE UNA OPCIÓN" data-width="420px" name="select3" id="select3" style="width: 420px" onchange="location = 'NuevoPermiso.jsp' + '?' + 'select3=' + select3.value"> 
                                            <%if (seleccion.equalsIgnoreCase("pase de salida")) {%>
                                            <option value="pase de salida" selected>PASE DE SALIDA</option>
                                            <%} else {%>
                                            <option value="pase de salida">PASE DE SALIDA</option>
                                            <%}%>
                                            <%if (seleccion.equalsIgnoreCase("permiso para llegar tarde")) {%>
                                            <option value="permiso para llegar tarde" selected>PERMISO PARA LLEGAR TARDE</option>
                                            <%} else {%>
                                            <option value="permiso para llegar tarde">PERMISO PARA LLEGAR TARDE</option>
                                            <%}%>
                                            <%if (seleccion.equalsIgnoreCase("salida anticipada")) {%>
                                            <option value="salida anticipada" selected>SALIDA ANTICIPADA</option>
                                            <%} else {%>
                                            <option value="salida anticipada">SALIDA ANTICIPADA</option>
                                            <%}%>
                                            <%if (seleccion.equalsIgnoreCase("permiso economico")) {%>
                                            <option value="permiso economico" selected>PERMISO ECONOMICO</option>
                                            <%} else {%>
                                            <option value="permiso economico">PERMISO ECONOMICO</option>
                                            <%}%>
                                        </select>
                                        <%}%>



                                    </label><br><br>
                                    <label>TIPO DE PERMISO</label> <div> <label style="padding-left: 0%"><input type="radio" id="tipo-permiso" value="personal" name="tipo-permiso" checked="checked"/>personal</label>
                                        <label style="padding-left: 10%;"><input type="radio" id="tipo-permiso" value="oficial" name="tipo-permiso"/>oficial</label></div><br><br>

                                    <label><textarea id="textarea"  name="textarea" rows="5" cols="50" style="width: 420px"></textarea><br>
                                        OBSERVACION Y/O DESCRIPCION</label><br><br>
                                </div>
                                <%if (seleccion.equalsIgnoreCase("pase de salida")) {%>
                                <div id="div1" style="width: 420px;">
                                    <fieldset id="fieldset1">
                                        <legend>PASE DE SALIDA</legend>
                                        <div id="datetimepicker1" class="input-append">
                                            <input class="datepicker" data-format="dd/MM/yyyy" type="text" id="fecha" name="fecha" placeholder="dd/MM/yyyy" required>
                                            <span class="add-on">
                                                <i data-time-icon="icon-time" data-date-icon="icon-calendar">
                                                </i>
                                            </span>
                                            FECHA 
                                        </div><br><br>
                                        <div id="datetimepicker4" class="input-append">
                                            <input data-format="hh:mm:ss" type="text" id="hr_salida" name="hr_salida" placeholder="hh:mm:ss" required>
                                            <span class="add-on">
                                                <i data-time-icon="icon-time" data-date-icon="icon-calendar">
                                                </i>
                                            </span>
                                            HORA SALIDA
                                        </div><br><br>
                                        <div id="datetimepicker5" class="input-append">
                                            <input data-format="hh:mm:ss" type="text" name="hr_llegada" id="hr_llegada" placeholder="hh:mm:ss">
                                            <span class="add-on">
                                                <i data-time-icon="icon-time" data-date-icon="icon-calendar">
                                                </i>
                                            </span>
                                            HORA LLEGADA    
                                        </div>
                                    </fieldset><br>
                                </div>
                                <%}%>
                                <div class="CLEAR"></div>
                                <%if (seleccion.equalsIgnoreCase("permiso para llegar tarde")) {%>
                                <div id="div2" style="width: 420px">
                                    <fieldset id="fieldset2">
                                        <legend> PERMISO PARA LLEGAR TARDE</legend>

                                        <div id="datetimepicker2" class="input-append">
                                            <input class="datepicker" type="text" data-format="dd/MM/yyyy" id="fecha2" name="fecha2" placeholder="dd/MM/yyyy" required/>
                                            <span class="add-on">
                                                <i data-time-icon="icon-time" data-date-icon="icon-calendar">
                                                </i>
                                            </span>
                                            FECHA 
                                        </div><br><br>

                                        <div id="datetimepicker6" class="input-append">
                                            <input data-format="hh:mm:ss" type="text" name="hr_llegada2" id="hr_llegada2" placeholder="hh:mm:ss" required>
                                            <span class="add-on">
                                                <i data-time-icon="icon-time" data-date-icon="icon-calendar">
                                                </i>
                                            </span>
                                            HORA LLEGADA    
                                        </div>
                                    </fieldset>
                                </div>
                                <%}%>

                                <%if (seleccion.equalsIgnoreCase("salida anticipada")) {%>
                                <div id="div3" style="width: 420px">
                                    <fieldset id="fieldset3">
                                        <legend>SALIDA ANTICIPADA</legend>
                                        <div id="datetimepicker3" class="input-append">
                                            <input class="datepicker" type="text" data-format="dd/MM/yyyy" id="fecha3" name="fecha3" placeholder="dd/MM/yyyy" required/>
                                            <span class="add-on">
                                                <i data-date-icon="icon-calendar">
                                                </i>
                                            </span>
                                            FECHA 
                                        </div><br><br>
                                        <div id="datetimepicker7" class="input-append">
                                            <input data-format="hh:mm:ss" type="text" id="hr_salida2" name="hr_salida2" placeholder="hh:mm:ss" required>
                                            <span class="add-on">
                                                <i data-time-icon="icon-time" data-date-icon="icon-calendar">
                                                </i>
                                            </span>
                                            HORA SALIDA
                                        </div>
                                    </fieldset>
                                </div>
                                <%}%>

                                <%if (seleccion.equalsIgnoreCase("permiso economico")) {%>
                                <div id="div4" style="width: 420px ">
                                    <fieldset id="fieldset4">
                                        <legend> PERMISO ECONÓMICO</legend>
                                        <div>
                                            <label><select name="licencias" id="licencias" required>
                                                    <option value="con goce de sueldo">CON GOCE DE SUELDO</option>
                                                    <option value="sin goce de sueldo">SIN GOCE DE SUELDO</option>
                                                </select></label>
                                        </div><br>
                                        <div id="datetimepicker8" class="input-append">
                                            <input class="datepicker" type="text" data-format="dd/MM/yyyy" id="fecha4" name="fecha4" placeholder="dd/MM/yyyy" required> 
                                            <span class="add-on">
                                                <i data-time-icon="icon-time" data-date-icon="icon-calendar">
                                                </i>
                                            </span> FECHA 
                                        </div>
                                    </fieldset>
                                </div>
                                <%}%>
                                <br>
                                <%
                                    String tipo = request.getParameter("tipo-permiso");
                                    String fecha = request.getParameter("fecha");
                                    String hr_llegada = request.getParameter("hr_llegada");
                                    String hr_salida = request.getParameter("hr_salida");
                                    String observaciones = request.getParameter("textarea");
                                    String gose_sueldo = request.getParameter("licencias");
                                    String hr_llegada2 = request.getParameter("hr_llegada2");
                                    String hr_salida2 = request.getParameter("hr_salida2");
                                    String fecha2 = request.getParameter("fecha2");
                                    String fecha3 = request.getParameter("fecha3");
                                    String fecha4 = request.getParameter("fecha4");
                                    if (gose_sueldo != null) {
                                        if (gose_sueldo.equalsIgnoreCase("CON GOCE DE SUELDO")) {
                                            gose_sueldo = "1";
                                        } else {
                                            gose_sueldo = "0";
                                        }
                                    };

                                    if (seleccion.equalsIgnoreCase("pase de salida") && fecha != null) {
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                            Statement stmt = conexion.createStatement();
                                            if (hr_llegada != "" && hr_salida != "") {
                                                stmt.executeUpdate("INSERT into pases (vobo, id_autorizo, confirmacion, tipo, fecha,  hr_llegada, hr_salida, id_solicitante, autorizado, observaciones, categoria, goceSueldo, verificar) values (null, null, null,'" + tipo + "',STR_TO_DATE(REPLACE('" + fecha + "','/','.') ,GET_FORMAT(date,'EUR')),'" + hr_llegada + "','" + hr_salida + "'," + idU + ",'2','" + observaciones + "', 'PASE DE SALIDA', '0', '11')");
                                %>
                                <script>window.alert("Pase registrado correctamente");</script>
                                <%
                                } else if (hr_llegada == "" && hr_salida == "") {
                                    stmt.executeUpdate("INSERT into pases (vobo, id_autorizo, confirmacion, tipo, fecha, hr_llegada, hr_salida, id_solicitante, autorizado, observaciones, categoria, goceSueldo, verificar) values (null, null, null,'" + tipo + "',STR_TO_DATE(REPLACE('" + fecha + "','/','.') ,GET_FORMAT(date,'EUR')),'" + hr_salida + "'," + idU + ",'2','" + observaciones + "','PASE DE SALIDA', '0', '00')");
                                %>
                                <script>window.alert("Pase registrado correctamente");</script>
                                <%
                                } else if (hr_llegada == "" && hr_salida != "") {
                                    stmt.executeUpdate("INSERT into pases (vobo, id_autorizo, confirmacion, tipo, fecha, hr_llegada, hr_salida, id_solicitante, autorizado, observaciones, categoria, goceSueldo, verificar) values (null, null, null,'" + tipo + "',STR_TO_DATE(REPLACE('" + fecha + "','/','.') ,GET_FORMAT(date,'EUR')),'05:00','" + hr_salida + "'," + idU + ",'2','" + observaciones + "', 'PASE DE SALIDA', '0', '10')");
                                %>
                                <script>window.alert("Pase registrado correctamente");</script>
                                <%
                                } else {
                                    stmt.executeUpdate("INSERT into pases (vobo, id_autorizo, confirmacion, tipo, fecha, hr_llegada, hr_salida, id_solicitante, autorizado, observaciones, categoria, goceSueldo, verificar) values (null, null, null,'" + tipo + "',STR_TO_DATE(REPLACE('" + fecha + "','/','.') ,GET_FORMAT(date,'EUR')),'" + hr_llegada + "','" + hr_salida + "'," + idU + ",'2','" + observaciones + "', 'PASE DE SALIDA', '0', '01')");
                                %>
                                <script>window.alert("Pase registrado correctamente");</script>
                                <%
                                    }
                                    conexion.close();
                                } catch (Exception e) {
                                %><script>window.alert("Error: pase no registrado");</script><%
                                        System.out.println("Index: " + e);
                                    }
                                } else if (seleccion.equalsIgnoreCase("salida anticipada") && fecha3 != null) {
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();
                                        stmt.executeUpdate("INSERT into pases (hr_llegada, vobo, id_autorizo, confirmacion, tipo, fecha, hr_salida, id_solicitante, autorizado, observaciones, categoria, goceSueldo, verificar) values (null, null, null, null, '" + tipo + "',STR_TO_DATE(REPLACE('" + fecha3 + "','/','.') ,GET_FORMAT(date,'EUR')),'" + hr_salida2 + "'," + idU + ",'2','" + observaciones + "', 'SALIDA ANTICIPADA', '0' ,'11')");
                                %>
                                <script>window.alert("permiso registrado correctamente");</script>                                                
                                <%  conexion.close();
                                    } catch (Exception e) {
                                        System.out.println("Index: " + e);
                                    }
                                } else if (seleccion.equalsIgnoreCase("permiso para llegar tarde") && fecha2 != null) {
                                    System.out.println("tipo: " + tipo + " fecha: " + fecha2 + " hr_llegada: " + hr_llegada2 + " observaciones: " + observaciones);
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();
                                        stmt.executeUpdate("INSERT into pases (hr_salida, vobo, id_autorizo, confirmacion, tipo, fecha, hr_llegada, id_solicitante, autorizado, observaciones, categoria, goceSueldo, verificar) values (null, null, null, null, '" + tipo + "',STR_TO_DATE(REPLACE('" + fecha2 + "','/','.') ,GET_FORMAT(date,'EUR')),'" + hr_llegada2 + "'," + idU + ",'2','" + observaciones + "', 'PERMISO PARA LLEGAR TARDE', '0' ,'11')");
                                %> <script>window.alert("permiso registrado correctamente");</script>          
                                <%   conexion.close();
                                    } catch (Exception e) {
                                        System.out.println("Index: " + e);
                                    }

                                } else if (seleccion.equalsIgnoreCase("permiso economico") && fecha4 != null) {
                                    System.out.println("tipo: " + tipo + " fecha: " + fecha4 + " gose_sueldo: " + gose_sueldo + " observaciones: " + observaciones);
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();
                                        stmt.executeUpdate("INSERT into pases (hr_llegada, hr_salida, vobo, id_autorizo, confirmacion, tipo, fecha, id_solicitante, autorizado, observaciones, categoria, goceSueldo, verificar) values (null , null, null ,null, null, '" + tipo + "',STR_TO_DATE(REPLACE('" + fecha4 + "','/','.') ,GET_FORMAT(date,'EUR')), " + idU + " , '2' ,'" + observaciones + "', 'PERMISO ECONÓMICO','" + gose_sueldo + "', '11' )");
                                %><script>window.alert("permiso registrado correctamente");</script>
                                <% conexion.close();
                                        } catch (Exception e) {
                                            System.out.println("Index: " + e);
                                        }
                                    }
                                %>
                                <%if (!seleccion.equalsIgnoreCase("null")) {%>
                                <button type="submit" id="guardar" name="guardar" class="btn btn-white btn-info btn-bold pull-left" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;left: 300px;">
                                    <i class="ace-icon fa icon-save bigger-120 blue" style="color:#00969A!important;"></i>
                                    GUARDAR
                                </button>
                                <br><br><br>
                                <%}%>
                                <div class="CLEAR"></div>
                            </form>
                        </article>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
