<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String User = SecurityContextHolder.getContext().getAuthentication().getName();
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_name");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
//    String min = request.getParameter("HJUI");
//    if(min == null) min = "";
//    System.out.println(min);
    String Id = request.getParameter("user");
    List<String> datosEmp = new ArrayList<String>();
//    String upp = "", nombreDepto = "",Nombre = "",aPaterno = "", aMaterno = "", Usr = "", Pssw = "", Rol = "", FechaNac = "", id_rol = "", email = "";
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT cat_empleados.primerApellido, cat_empleados.segundoApellido, cat_empleados.nombres, cat_empleados.idSexo, "
                                        +"cat_empleados.rfc, cat_empleados.curp, cat_empleados.calle, cat_empleados.numInterior, cat_empleados.numExterior, "
                                        +"cat_empleados.colonia, cat_empleados.cp, cat_empleados.ciudad, cat_empleados.estado, cat_empleados.numeroaFiliacion, "
                                        +"cat_empleados.contrato, cat_empleados.idEstadoCivil, cat_empleados.idEscolaridad, cat_empleados.nacionalidad,"
                                        +"cat_empleados.fechaNacimiento, usuario.upp, cat_ur.descripcion, usuario.rfc, usuario.username, usuario.password, "
                                        +"roles.nombre as rol, usuario.email, roles.id, cat_empleados.idCategoria, cat_empleados.idestadoOrigen, "
                                        +"cat_empleados.idmunicipioOrigen, cat_empleados.preEscolaridad, cat_empleados.noCuenta "
                                        +"FROM usuario "
                                        +"INNER JOIN roles "
                                        +" ON usuario.id_rol = roles.id "
                                        +"INNER JOIN cat_ur "
                                        +" ON usuario.upp = cat_ur.clave "
                                        +"INNER JOIN cat_empleados "
                                        +" ON usuario.rfc = cat_empleados.rfc "
                                        +"WHERE usuario.id = "+Id+"");
        while(rs.next()){
            datosEmp.add(rs.getString("usuario.upp"));
            datosEmp.add(rs.getString("cat_empleados.fechaNacimiento"));
            datosEmp.add(rs.getString("cat_empleados.nombres"));
            datosEmp.add(rs.getString("cat_empleados.primerApellido"));
            datosEmp.add(rs.getString("cat_empleados.segundoApellido"));
            datosEmp.add(rs.getString("cat_empleados.idSexo"));
            datosEmp.add(rs.getString("usuario.rfc"));
            datosEmp.add(rs.getString("cat_empleados.curp"));
            datosEmp.add(rs.getString("usuario.username"));
            datosEmp.add(rs.getString("usuario.password"));
            datosEmp.add(rs.getString("usuario.email"));
            datosEmp.add(rs.getString("roles.id"));
            datosEmp.add(rs.getString("cat_empleados.calle"));
            datosEmp.add(rs.getString("cat_empleados.numInterior"));
            datosEmp.add(rs.getString("cat_empleados.numExterior"));
            datosEmp.add(rs.getString("cat_empleados.colonia"));
            datosEmp.add(rs.getString("cat_empleados.cp"));
            datosEmp.add(rs.getString("cat_empleados.estado"));
            datosEmp.add(rs.getString("cat_empleados.ciudad"));
            datosEmp.add(rs.getString("cat_empleados.numeroaFiliacion"));
            datosEmp.add(rs.getString("cat_empleados.contrato"));
            datosEmp.add(rs.getString("cat_empleados.idEstadoCivil"));
            datosEmp.add(rs.getString("cat_empleados.idEscolaridad"));
            datosEmp.add(rs.getString("cat_empleados.nacionalidad"));
            datosEmp.add(rs.getString("cat_ur.descripcion"));
            datosEmp.add(rs.getString("rol"));
            datosEmp.add(rs.getString("cat_empleados.idCategoria"));
            datosEmp.add(rs.getString("cat_empleados.idestadoOrigen"));
            datosEmp.add(rs.getString("cat_empleados.idmunicipioOrigen"));
            datosEmp.add(rs.getString("cat_empleados.preEscolaridad"));
            datosEmp.add(rs.getString("cat_empleados.noCuenta"));
        }
        conexion.close();
    }catch(Exception e){System.out.println(e);}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Usuario</title>
    </head>
    <body style="padding-top: 0px;">
        <style>
            .form-group{
                margin-bottom: 12px;
                width: 102%;
            }
        </style>
        <!--<script src="/ceticAdmin/assets/scripts/jquery-1.8.3.min.js"></script>-->
        <script src="<c:url value="/assets/BootstrapSelect/js/jquery-1.11.3.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-3.3.4.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-select.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/i18n/defaults-es_CL.min.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datepicker.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datetimepicker.min.js"/>"></script>
        <!--<script src="/ceticAdmin/assets/validate/jquery.js"></script>-->
	<script src="<c:url value="/assets/validate/jquery.validate.js"/>"></script>
        <script>
            $(document).ready(function(){
                var url = location.href;
                url = url.substring(url.lastIndexOf("?")+8,url.lastIndexOf("?")+12);
                var url1 = location.href;
                url1 = url1.substring(url1.lastIndexOf("sw")+3,url1.lastIndexOf("sw")+4);
                var logout = location.href.substring(location.href.lastIndexOf("TUOG=")+5,location.href.lastIndexOf("TUOG=")+6);
                var encLogout = window.btoa(logout);
    //                var encEstatus = window.btoa(url1);
    //                var encEstatus = window.btoa(1);
    //                var par = getUrlVars()["HJUI"];
    //                var hs = '?';
                if(url === "exit"){
                    var ctx = '<%=request.getContextPath()%>';
                    if(logout === "1")
                        window.top.location.href = ctx+"/admin/navbar.jsp?TUOG="+encLogout;
//                        parent.$.fancybox.close();
//                    }else{
                        parent.$.fancybox.close();
//                    }
//                    window.top.location.href = window.top.location.href+hs+"NBVF="+encEstatus;
                    
    //                    window.location.reload();
                }
                $.validator.addMethod("valueNotEquals", function(value, element, arg){
                return arg !== value;
                }, "Value must not equal arg.");
		$("#myform").validate({
                    rules: {
                        Nombre: "required",
                        aPaterno: "required",
                        aMaterno: "required",
                        Username: "required",
                        Pssw: {
                            required: true
//                            minlength: 5
                        },
                        select01: {
                            min:1
                        },
                        select02: {
                            min:0
                        },
                        email:{
                            required: true,
                            email: true
                        },
                        date01:{
                            required: true
                        },
                        sexo:{
                            valueNotEquals: "default"
                        },
                        rfcUsr:{
                            required: true,
                            minlength: 13,
                            maxlength: 13
                        },
                        curp:{
                            required: true,
                            minlength: 18,
                            maxlength: 18
                        },
                        calle:{
                            required: true
                        },
                        colonia:{
                            required: true
                        },
                        cp:{
                            required: true,
                            number: true,
                            minlength: 5,
                            maxlength: 5
                            
                        },
                        estado:{
                            min:1
                        },
                        estadoOrigen:{
                            min:1
                        },
                        municipioOrigen:{
                            min:1
                        },
                        municipio:{
                            min:1
                        },
                        nAfiliacion:{
                            required: true
                        },
                        nCuenta:{
                            required: true
                        },
                        contrato:{
                            valueNotEquals: "default"
                        },
                        ecivil:{
                            min:1
                        },
                        escolaridad:{
                            min:1
                        },
                        acronimo:{
                            valueNotEquals: "default"
                        },
                        nacionalidad:{
                            min:1
                        },
                        categoria:{
                            min:1
                        }
                    },
                    messages: {
                        Nombre: "Ingresa El Nombre",
                        aPaterno: "Ingresa El Apllido Paterno",
                        aMaterno: "Ingresa El Apellido Materno",
                        Username: "Ingresa El Nombre de Usuario",
                        Pssw: {
                            required: "Ingresa La Contraseña"
//                            minlength: "La Contraseña debe Contener Al Menos 5 Caracteres"
                        },
                        select01: {
                            min: "Selecciona un Rol"
                        },
                        select02: {
                            min: "Selecciona una Dirección (UPP)"
                        },
                        email:{
                            required: "Ingresa Un e-Mail",
                            email: "Formato de E-Mail Incorrecto"
                        },
                        date01:{
                            required: "Ingresa La Fecha De Nacimiento"
                        },
                        sexo:{
                            valueNotEquals: "Ingresa El Sexo"
                        },
                        rfcUsr:{
                            required: "Ingresa El RFC",
                            minlength: "Minimo 13 Caracteres",
                            maxlength: "Maximo 13 Caracteres"
                        },
                        curp:{
                            required: "Ingresa El CURP",
                            minlength: "Minimo 18 Caracteres",
                            maxlength: "Maximo 18 Caracteres"
                        },
                        calle:{
                            required: "Ingresa La Calle"
                        },
                        colonia:{
                            required: "Ingresa La Colonia"
                        },
                        cp:{
                            required: "Ingresa El Código Postal",
                            number: "Solo Caracteres Numericos",
                            minlength: "Minimo 5 Caracteres",
                            maxlength: "Maximo 5 Caracteres"
                        },
                        estado:{
                            min: "Ingresa El Estado"
                        },
                        estadoOrigen:{
                            min: "Ingresa El Estado de Origen"
                        },
                        municipioOrigen:{
                            min: "Ingresa El Municipio de Origen"
                        },
                        municipio:{
                            min: "Ingresa El Municipio"
                        },
                        nAfiliacion:{
                            required: "Ingresa El No Afiliación"
                        },
                        nCuenta:{
                            required: "Ingresa El No de Cuenta"
                        },
                        contrato:{
                            valueNotEquals: "Ingresa El Tipo de Contrato"
                        },
                        ecivil:{
                            min: "Ingresa El Estado Civil"
                        },
                        escolaridad:{
                            min: "Ingresa La Escolaridad Máxima"
                        },
                        acronimo:{
                            valueNotEquals: "Ingresa el Título"
                        },
                        nacionalidad:{
                            min: "Ingresa La Nacionalidad"
                        },
                        categoria:{
                            min: "Ingresa La Categoria"
                        }
                    }
		});
                $('.selectpicker').selectpicker();
                $("#estado").on('change', function () {
                    var selected = $('#estado').val();
                    $.ajax({type: "GET",url: "ajax/cargarMunicipios.jsp?selected="+selected})
                        .done(function(data) {
                        var respuesta = $.parseJSON(data);
                        var tot = respuesta.TotMun;
                        var Mun = "<option>...</option>";
                        for (var i = 0; i<tot; i++){
                            Mun = Mun+"<option value=\""+respuesta.id_cat_municipios[i]+"\">"+respuesta.descripcionMunicipio[i]+"</option>";
                        }
                        $("#municipio").html(Mun).selectpicker('refresh');
                    });
                });
                $("#estadoOrigen").on('change', function () {
                    var selected = $('#estadoOrigen').val();
                    $.ajax({type: "GET",url: "ajax/cargarMunicipios.jsp?selected="+selected})
                        .done(function(data) {
                        var respuesta = $.parseJSON(data);
                        var tot = respuesta.TotMun;
                        var Mun = "<option>...</option>";
                        for (var i = 0; i<tot; i++){
                            Mun = Mun+"<option value=\""+respuesta.id_cat_municipios[i]+"\">"+respuesta.descripcionMunicipio[i]+"</option>";
                        }
                        $("#municipioOrigen").html(Mun).selectpicker('refresh');
                    });
                });
            });
            $(function() {
                $('#datetimepicker4').datetimepicker({
                    pickTime: false
                });
            });
            function getUrlVars(){ 
                var vars = [], hash; 
                var hashes = window.top.document.referrer.slice(window.top.document.referrer.indexOf('?') + 1).split('&');
                for(var i = 0; i < hashes.length; i++){
                    hash = hashes[i].split('='); vars.push(hash[0]); vars[hash[0]] = hash[1]; 
                } 
                return vars; 
            }
        </script>
<%    
    Date fechaNac = null;
    DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
    if(!datosEmp.isEmpty()){
        if(!datosEmp.get(18).equals(""))
            fechaNac = fmt.parse(datosEmp.get(1));
        request.setAttribute("fechaNac", fechaNac);    
    }
%>
        <div class="box-container-toggle1">
            <div class="box-content1">
                 <form class="form-horizontal" method="POST" action="guardaEditar.jsp" id="myform" name="myform">
                    <fieldset>
                    <legend>Edici&oacute;n de Usuarios</legend>
                    </fieldset>
                    <input class="input-xlarge focused" type="hidden" name="Id" id="Id" value="<%=Id%>">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right" for="select02"><b>Direcci&oacute;n&nbsp;(UPP):</b></label>
                                <div class="col-sm-9">
                                    <select id="select02" name="select02" style="width: 285px;text-transform: uppercase;">
                                        <option value="-1">...</option>
                                        <%
                                        try{
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                            Statement stmt = conexion.createStatement();
                                            ResultSet rs = stmt.executeQuery("SELECT * FROM cat_ur");
                                            while(rs.next()){
                                        %>
                                        <option value="<%=rs.getString("clave")%>" <%if((!datosEmp.isEmpty()) && (datosEmp.get(0).equals(rs.getString("clave")))) 
                                        out.print("selected");%>><%=rs.getString("descripcion")%></option>
                                        <%
                                            }
                                            conexion.close();
                                        }catch(Exception e){System.out.println(e);}
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>F. Nacimiento:</b></label>
                                <div class="col-sm-9">
                                    <div id="datetimepicker4" class="input-append">
                                        <span class="add-on" style="margin-left: 0px;">
                                            <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
                                        </span>
                                        <input style="margin-left: -2%;width: 258px;" data-format="dd/MM/yyyy" type="text" id="date01" name="date01" placeholder=" dd/MM/yyyy"
                                        <%if(!datosEmp.isEmpty()){%>value="<fmt:formatDate pattern="dd/MM/yyyy" value="${fechaNac}"/>"<%}%> required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Nombre:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="Nombre" id="Nombre" placeholder="Escriba el Nombre..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(2)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>A. Paterno:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="aPaterno" id="aPaterno" placeholder="Escriba el Apellido Paterno..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(3)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>A. Materno:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="aMaterno" id="aMaterno" placeholder="Escriba el Apellido Materno..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(4)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Sexo:</b></label>
                                <div class="col-sm-9">
                                    <select id="sexo" name="sexo" style="width: 285px;text-transform: uppercase;">
                                        <option value="default">...</option>
                                        <option value="M" <%if((!datosEmp.isEmpty()) && (datosEmp.get(5).equals("M"))) 
                                        out.print("selected");%>>Masculino</option>
                                        <option value="F" <%if((!datosEmp.isEmpty()) && (datosEmp.get(5).equals("F"))) 
                                        out.print("selected");%>>Femenino</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>RFC:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="rfcUsr" id="rfcUsr" placeholder="Escribe el RFC..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(6)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>CURP:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="curp" id="curp" placeholder="Escribe la CURP..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(7)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Usuario:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="Username" id="Username" placeholder="Nombre de Usuario..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(8)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Contraseña:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="password" name="Pssw" id="Pssw" placeholder="Escriba la Contraseña..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(9)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>E-Mail:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="email" id="email" placeholder="Escriba el Correo Electrónico..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(10)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right" for="select01"><b>Roles:</b></label>
                                <div class="col-sm-9">
                                    <select id="select01" name="select01" style="width: 285px;">
                                        <option>...</option>
                                        <%
                                        try{
                                            String altaRol = "";
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                            Statement stmt = conexion.createStatement();
                                            ResultSet rs1 = stmt.executeQuery("SELECT roles.altaRol FROM roles "
                                                                             +"INNER JOIN usuario "
                                                                             +"ON usuario.id_rol = roles.id "
                                                                             +"WHERE usuario.username = '"+User+"'");
                                            while(rs1.next())
                                                altaRol = rs1.getString("altaRol");
                                            ResultSet rs = stmt.executeQuery("SELECT * FROM roles WHERE activo = 1 AND id IN ("+altaRol+")");
                                            while(rs.next()){
                                        %>
                                        <option value="<%=rs.getString("id")%>" <%if((!datosEmp.isEmpty()) && (datosEmp.get(11).equals(rs.getString("id")))) 
                                        out.print("selected");%>><%=rs.getString("nombre")%></option>
                                        <%
                                            }
                                            conexion.close();
                                        }catch(Exception e){System.out.println(e);}
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Edo. Origen:</b></label>
                                <div class="col-sm-9">
                                    <select id="estadoOrigen" name="estadoOrigen" style="width: 285px;" class="selectpicker show-tick" data-live-search="true" onchange="cambioMunOr()">
                                        <option>...</option>
                                            <%
                                            if(!datosEmp.isEmpty()){
                                                try{
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                    Statement stmt = conexion.createStatement();
                                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_estados_mexico");
                                                    while(rs.next()){
                                                %>
                                                <option data-tokens="<%=rs.getString("nombreEstado")%>" value="<%=rs.getString("claveEstado")%>" 
                                                <%if((!datosEmp.isEmpty()) && (datosEmp.get(27).equals(rs.getString("claveEstado")))) out.print("selected");%>><%=rs.getString("nombreEstado")%>
                                                </option>
                                                <%
                                                    }
                                                    conexion.close();
                                                }catch(Exception e){System.out.println(e);}
                                            }else{
                                                try{
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                    Statement stmt = conexion.createStatement();
                                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_estados_mexico");
                                                    while(rs.next()){
                                                %>
                                                <option value="<%=rs.getString("claveEstado")%>"><%=rs.getString("nombreEstado")%></option>
                                                <%
                                                    }
                                                    conexion.close();
                                                }catch(Exception e){System.out.println(e);}
                                            }
                                            %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Mpio. Origen:</b></label>
                                <div class="col-sm-9">
                                    <select id="municipioOrigen" name="municipioOrigen" style="width: 285px;" class="selectpicker show-tick"  data-live-search="true">
                                        <option>...</option>
                                            <%
                                            if(!datosEmp.isEmpty()){
                                                try{
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                    Statement stmt = conexion.createStatement();
                                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_municipios WHERE claveEntidad = "+datosEmp.get(27)+" ORDER BY descripcionMunicipio");
                                                    while(rs.next()){
                                                %>
                                                <option data-tokens="<%=rs.getString("descripcionMunicipio")%>" value="<%=rs.getString("claveMunicipio")%>" 
                                                <%if((!datosEmp.isEmpty()) && (datosEmp.get(28).equals(rs.getString("claveMunicipio")))) out.print("selected");%>><%=rs.getString("descripcionMunicipio")%>
                                                </option>
                                                <%
                                                    }
                                                    conexion.close();
                                                }catch(Exception e){System.out.println(e);}
                                            }%>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Calle:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="calle" id="calle" placeholder="Escribe la Dirección..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(12)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>No Interior:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="nInt" id="nInt" placeholder="Escribe el No Interior..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(13)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>No Exterior:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="nExt" id="nExt" placeholder="Escribe el No Exterior..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(14)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Colonia:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="colonia" id="colonia" placeholder="Escribe la Colonia..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(15)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>C.P.:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="cp" id="cp" placeholder="Escribe el Código Postal..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(16)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Estado:</b></label>
                                <div class="col-sm-9">
                                    <select id="estado" name="estado" style="width: 285px;" class="selectpicker show-tick" data-live-search="true" onchange="cambioMun()">
                                        <option>...</option>
                                            <%
                                            if(!datosEmp.isEmpty()){
                                                try{
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                    Statement stmt = conexion.createStatement();
                                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_estados_mexico");
                                                    while(rs.next()){
                                                %>
                                                <option data-tokens="<%=rs.getString("nombreEstado")%>" value="<%=rs.getString("claveEstado")%>" 
                                                <%if((!datosEmp.isEmpty()) && (datosEmp.get(17).equals(rs.getString("claveEstado")))) out.print("selected");%>><%=rs.getString("nombreEstado")%>
                                                </option>
                                                <%
                                                    }
                                                    conexion.close();
                                                }catch(Exception e){System.out.println(e);}
                                            }else{
                                                try{
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                    Statement stmt = conexion.createStatement();
                                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_estados_mexico");
                                                    while(rs.next()){
                                                %>
                                                <option value="<%=rs.getString("claveEstado")%>"><%=rs.getString("nombreEstado")%></option>
                                                <%
                                                    }
                                                    conexion.close();
                                                }catch(Exception e){System.out.println(e);}
                                            }
                                            %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Municipio:</b></label>
                                <div class="col-sm-9">
                                    <select id="municipio" name="municipio" style="width: 285px;" class="selectpicker show-tick"  data-live-search="true">
                                        <option>...</option>
                                            <%
                                            if(!datosEmp.isEmpty()){
                                                try{
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                    Statement stmt = conexion.createStatement();
                                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_municipios WHERE claveEntidad = "+datosEmp.get(17)+" ORDER BY descripcionMunicipio");
                                                    while(rs.next()){
                                                %>
                                                <option data-tokens="<%=rs.getString("descripcionMunicipio")%>" value="<%=rs.getString("claveMunicipio")%>" 
                                                <%if((!datosEmp.isEmpty()) && (datosEmp.get(18).equals(rs.getString("claveMunicipio")))) out.print("selected");%>><%=rs.getString("descripcionMunicipio")%>
                                                </option>
                                                <%
                                                    }
                                                    conexion.close();
                                                }catch(Exception e){System.out.println(e);}
                                            }%>
                                    </select>
                                </div>
                            </div>
                            <!--<select id="selectElementId"></select>-->
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>No Afiliaci&oacute;n:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="nAfiliacion" id="nAfiliacion" placeholder="Escribe el No Afiliación..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(19)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>No Cuenta:</b></label>
                                <div class="col-sm-9">
                                    <input class="input-xlarge focused" type="text" name="nCuenta" id="nCuenta" placeholder="Escribe el No de Cuenta..."
                                    <%if(!datosEmp.isEmpty()) out.print("value=\""+datosEmp.get(30)+"\"");%>>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Tipo Contrato:</b></label>
                                <div class="col-sm-9">
                                    <select id="contrato" name="contrato" style="width: 285px;">
                                        <option value="default">...</option>
                                        <option value="EVENTUAL" <%if((!datosEmp.isEmpty()) && (datosEmp.get(20).equals("EVENTUAL"))) 
                                        out.print("selected");%>>EVENTUAL</option>
                                        <option value="CONFIANZA" <%if((!datosEmp.isEmpty()) && (datosEmp.get(20).equals("CONFIANZA"))) 
                                        out.print("selected");%>>CONFIANZA</option>
                                        <option value="BASE" <%if((!datosEmp.isEmpty()) && (datosEmp.get(20).equals("BASE"))) 
                                        out.print("selected");%>>BASE</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right" for="select01"><b>Categoria:</b></label>
                                <div class="col-sm-9">
                                    <select id="categoria" name="categoria" style="width: 285px;" class="selectpicker show-tick" data-live-search="true">
                                        <option>...</option>
                                        <%
                                        try{
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                            Statement stmt = conexion.createStatement();
                                            ResultSet rs = stmt.executeQuery("SELECT * FROM cat_categoria WHERE status = 1 ORDER BY descripcion");
                                            while(rs.next()){
                                        %>
                                        <option data-tokens="<%=rs.getString("descripcion")%>" value="<%=rs.getString("id_cat_categoria")%>"
                                                <%if((!datosEmp.isEmpty()) && (datosEmp.get(26).equals(rs.getString("id_cat_categoria")))) 
                                                out.print("selected");%>>
                                            <%=rs.getString("descripcion")%>
                                        </option>
                                        <%
                                            }
                                            conexion.close();
                                        }catch(Exception e){System.out.println(e);}
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Estado Civil:</b></label>
                                <div class="col-sm-9">
                                    <select id="ecivil" name="ecivil" style="width: 285px;text-transform: uppercase;">
                                        <option>...</option>
                                        <option value="1" <%if((!datosEmp.isEmpty()) && (datosEmp.get(21).equals("1"))) 
                                        out.print("selected");%>>Soltero(a)</option>
                                        <option value="2" <%if((!datosEmp.isEmpty()) && (datosEmp.get(21).equals("2"))) 
                                        out.print("selected");%>>Casado(a)</option>
                                        <option value="3" <%if((!datosEmp.isEmpty()) && (datosEmp.get(21).equals("3"))) 
                                        out.print("selected");%>>Divorciado(a)</option>
                                        <option value="4" <%if((!datosEmp.isEmpty()) && (datosEmp.get(21).equals("4"))) 
                                        out.print("selected");%>>Viudo(a)</option>
                                        <option value="5" <%if((!datosEmp.isEmpty()) && (datosEmp.get(21).equals("5"))) 
                                        out.print("selected");%>>Union libre(a)</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Escolaridad:</b></label>
                                <div class="col-sm-9">
                                    <select id="escolaridad" name="escolaridad" style="width: 285px;text-transform: uppercase;">
                                        <option>...</option>
                                            <%
                                            if(!datosEmp.isEmpty()){
//                                                if(datosEmp.get(16).equals("P")) datosEmp.set(16, "3");
//                                                if(datosEmp.get(16).equals("S")) datosEmp.set(16, "4");
//                                                if(datosEmp.get(16).equals("B")) datosEmp.set(16, "5");
//                                                if(datosEmp.get(16).equals("L")) datosEmp.set(16, "10");
//                                                if(datosEmp.get(16).equals("O")) datosEmp.set(16, "11");
                                                try{
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                    Statement stmt = conexion.createStatement();
                                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_escolaridad");
                                                    while(rs.next()){
                                                %>
                                                <option value="<%=rs.getString("id_cat_escolaridad")%>" 
                                                <%if((!datosEmp.isEmpty()) && (datosEmp.get(22).equals(rs.getString("id_cat_escolaridad")))) out.print("selected");%>><%=rs.getString("descripcion")%>
                                                </option>
                                                <%
                                                    }
                                                    conexion.close();
                                                }catch(Exception e){System.out.println(e);}
                                            }else{
                                                try{
                                                    Class.forName("com.mysql.jdbc.Driver");
                                                    Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                                    Statement stmt = conexion.createStatement();
                                                    ResultSet rs = stmt.executeQuery("SELECT * FROM cat_escolaridad");
                                                    while(rs.next()){
                                                %>
                                                <option value="<%=rs.getString("id_cat_escolaridad")%>" ><%=rs.getString("descripcion")%>
                                                </option>
                                                <%
                                                    }
                                                    conexion.close();
                                                }catch(Exception e){System.out.println(e);}
                                            }    
                                            %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right" for="acronimo"><b>Título:</b></label>
                                <div class="col-sm-9">
                                    <select id="acronimo" name="acronimo" style="width: 285px;text-transform: uppercase;" class="selectpicker show-tick" data-live-search="true">
                                        <option value="default">...</option>
                                        <%
                                        try{
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                            Statement stmt = conexion.createStatement();
                                            ResultSet rs = stmt.executeQuery("SELECT * FROM cat_acronimos");
                                            while(rs.next()){
                                        %>
                                        <option data-tokens="<%=rs.getString("nombre")%>" value="<%=rs.getString("acronimo")%>"
                                            <%if((!datosEmp.isEmpty()) && (datosEmp.get(29).equals(rs.getString("acronimo")))) 
                                            out.print("selected");%>>
                                            <%=rs.getString("nombre").toUpperCase()%>
                                        </option>
                                        <%
                                            }
                                            conexion.close();
                                        }catch(Exception e){System.out.println(e);}
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right"><b>Nacionalidad:</b></label>
                                <div class="col-sm-9">
                                    <select id="nacionalidad" name="nacionalidad" style="width: 285px;text-transform: uppercase;">
                                        <option>...</option>
                                        <option value="1" <%if((!datosEmp.isEmpty()) && (datosEmp.get(23).equals("1"))) 
                                        out.print("selected");%>>Nacional</option>
                                        <option value="2" <%if((!datosEmp.isEmpty()) && (datosEmp.get(23).equals("2"))) 
                                        out.print("selected");%>>Extranjera</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix form-actions" style="margin-top:5px;margin-bottom:0px;">
                        <div class="col-md-offset-3 col-md-9" style="margin-left:11%;">
                            <button type="submit" class="btn btn-white btn-info btn-bold" style="border-right-width:3px;border-bottom-width:3px;color:#790754!important;border-color:#790754;">
                                <i class="ace-icon fa fa-save bigger-120 blue" style="color:#790754!important;"></i>
                                Guardar
                            </button>
                        </div>
                    </div>
                    <!--</fieldset>-->
                </form>   
            </div>
        </div>
    </body>
</html>