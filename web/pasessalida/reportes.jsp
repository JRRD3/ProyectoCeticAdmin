
<%@page import="java.io.File"%>
<%@page import="net.sf.jasperreports.engine.JRExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JRExporter"%>
<%@page import="net.sf.jasperreports.engine.export.JRPdfExporter"%>
<%@page import="com.mysql.jdbc.PreparedStatement"%>
<%@page import="javax.xml.ws.Response"%>
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
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%
    String User = SecurityContextHolder.getContext().getAuthentication().getName();
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_nameNomina");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    String bdadmin = resource.getString("ceticAdmin.bd_name");

    List<String> P = new ArrayList<String>();
    String Cad = "", Pr = "", CadN = "";
//    String marcaVehiculo = request.getParameter("marcaVehiculo");
//    if(marcaVehiculo == null) marcaVehiculo = "";
    String refresh = "2";
    String estatus = request.getParameter("NBVF");
//    System.out.println("Estatus: "+estatus);
    if (estatus != null) {
        byte[] valueDecoded = Base64.decodeBase64(estatus);//decoding part
        estatus = new String(valueDecoded);
    }
    if (estatus == null) {
        estatus = "0";
    }
//    System.out.println("Estatus: "+estatus);
    String in = request.getParameter("date01");
    String fi = request.getParameter("date02");

    String inicio1 = null;
    String fin1 = null;
    if (in != null && fi != null && !in.equalsIgnoreCase("") && !fi.equalsIgnoreCase("")) {
        inicio1 = in.substring(in.length() - 4, in.length());
        inicio1 = inicio1 + "-" + in.substring(in.length() - 7, in.length() - 5);
        inicio1 = inicio1 + "-" + in.substring(0, 2);
        fin1 = fi.substring(fi.length() - 4, fi.length());
        fin1 = fin1 + "-" + fi.substring(fi.length() - 7, fi.length() - 5);
        fin1 = fin1 + "-" + fi.substring(0, 2);
    }

    String seleccionado = request.getParameter("seleccionado");
    if (seleccionado == null) {
        seleccionado = "uno";
    }
    String consulta;

    String id_pase = request.getParameter("id_pase");
    String hr_llegada = request.getParameter("hr_llegada");
    String hr_salida = request.getParameter("hr_salida");
    if (id_pase != null && hr_llegada != null && hr_salida != null) {
        String actualiza = "update pases Set hr_llegada = '" + hr_llegada + "', hr_salida = '" + hr_salida + "', verificar= '11' where(id_pase = " + id_pase + ")";
        //Actualización de la tabla pases, se asignan valores a las horas correspondientes.
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
            Statement stmt = conexion.createStatement();
            stmt.executeUpdate(actualiza);
        } catch (Exception e) {
            System.out.println(e);
        }
        refresh = "1";
    }
    String upp = "0";
    ArrayList ids = new ArrayList();
    //Se consulta el rol y la unidad productiva (upp)  que tiene asignado el usuario que ha ingresado.
    String rol = "select id_rol, upp from usuario where username = '" + User + "' ";
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet hh = stmt.executeQuery(rol);
        while (hh.next()) {
            rol = hh.getString("id_rol");
            upp = hh.getString("upp");
        }
    } catch (Exception e) {
        System.out.println(e);
    }
    String name = request.getParameter("nombres");
    if (name == null) {
        name = "null";
    }

    String aceptado = request.getParameter("aceptado");
    if (aceptado == null) {
        aceptado = "3";
    }
    String cn = null;
    if (!aceptado.equalsIgnoreCase("3")) {

        if (aceptado.equalsIgnoreCase("1")) {
            cn = "update pases Set autorizado = '1' where(id_pase = " + id_pase + ")";
        } else if (aceptado.equalsIgnoreCase("0")) {
            cn = "update pases Set autorizado = '0' where(id_pase = " + id_pase + ")";
        }
        //Actualización de la tabla pases, donde se asigna un nuevo valor al campo autorizado.
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = DriverManager.getConnection(bd, usr, pssw);
            Statement stmt = conexion.createStatement();
            stmt.executeUpdate(cn);
        } catch (Exception e) {
            System.out.println(e);
        }
        refresh = "1";
    }

    //Se inicializa el array contrato[]
    String[] contrato = request.getParameterValues("selectContrato");
    if (contrato == null) {
        contrato = new String[2];
        contrato[0] = "Null";
        contrato[1] = "Null";
    } else if (contrato.length == 1) {
        String j = contrato[0];
        contrato = new String[2];
        contrato[0] = j;
        contrato[1] = "Null";
    }
%>

<html>
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/estilos.css">
        <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.9.3/css/bootstrap-select.min.css">
        <!--Fancy Box-->

             <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/core.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/fullscreen.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/slideshow.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/thumbs.js"/>"> </script>
        <!--Fancy Box-->



        <title>Reportes </title>
    </head>
    <body>

        <!--Fancy Box-->
  <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/core.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/fullscreen.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/guestures.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/hash.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/media.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/slideshow.js"/>"> </script>
        <script type="text/javascript" src="<c:url value="/assets/fancybox-3.0/src/js/thumbs.js"/>"> </script>
        
        

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.9.3/js/bootstrap-select.min.js"></script>

        <script>

//            $(function() {
//                $(".fancyOther").fancybox({
//                    width: '70%',
//                    height: '70%',
//                    maxWidth: 800,
//                    maxHeight: 600,
//                    fitToView: false,
//                    autoSize: false,
//                    closeClick: false,
//                    openEffect: 'none',
//                    closeEffect: 'none'
//                });
//            });

        </script>
        <%if (refresh.equalsIgnoreCase("1")) {%>
        <script>

            //La siguiente funcion sirve para cerrar la ventana del fancyBox y actualizar la pagina padre.
            function lanzadera() {
                $('.fancybox').fancybox();
                parent.location.reload(true);
                parent.$.fancybox.close();
                parent.location.reload(true);
            }
            window.onload = lanzadera;
        </script>
        <% } %>
        <!--Fancy Box-->      

        <script type="text/javascript">jQuery.noConflict();</script>
        <script type="text/javascript" src="JavaScript/segmentos.js"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/jquery-1.11.3.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-3.3.4.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-select.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/i18n/defaults-es_CL.min.js"/>"></script>

        <script src="<c:url value="/assets/js/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/assets/pagination/js/jquery.jqpagination.js"/>"></script>

        <script src="<c:url value="/assets/fancybox/jquery.fancybox.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/assets/fancybox/jquery.fancybox.pack.js"/>"></script>
        <script src="<c:url value="/assets/DataTables/js/jquery.dataTables.min.js"/>"></script>
        <script src="<c:url value="/assets/DataTables/js/dataTables.jqueryui.min.js"/>"></script>
        <script src="<c:url value="/assets/DataTables/js/dataTables.responsive.min.js"/>"></script>
        <script src="<c:url value="/assets/DataTables/js/responsive.jqueryui.min.js"/>"></script>  

        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datetimepicker.min.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datepickerNew.js"/>"></script>

        <script>
            //las siguiente cuatro funciones sirven para redirigir de pagina al usuario y enviar datos extras.
            function redireccionaruno(vava) {
                var ids = document.getElementById("array").value;
                if (vava == 1) {
                    //var nombres = document.getElementById("nombres").value;
                    //location.href = "ImprimirReportes.jsp?" + "ids=" + ids + '&' + 'nombres=' + nombres + '&' + 'rol=' + vava;
                    document.getElementById("redic1").click();
                }
                else {
                    //location.href = "ImprimirReportes.jsp?" + "ids=" + ids;
                    document.getElementById("redic2").click();
                }
            }
            function redireccionardos() {

                var lista = document.getElementById("selectNames");
                location.href = "ImprimirReportes.jsp?" + "selectNames=" + lista;
            }

            function redireccionartres(vava) {
                var matriz = document.getElementById("matriz").value;
                if (vava == 1) {
//                    var nombres = document.getElementById("nombres").value;
//                    location.href = "ImprimirReportes.jsp?" + "matriz=" + matriz + '&' + 'nombres=' + nombres + '&' + 'rol=' + vava;
                    document.getElementById("redic3").click();

                } else {
//                    location.href = "ImprimirReportes.jsp?" + "matriz=" + matriz;
                    document.getElementById("redic4").click();
                }

            }
            function redireccionarcuatro(vava) {
                var selecc = document.getElementById("seleccionado").value;
                if (vava == 1) {
                    var nomb = document.getElementById("nombres").value;
                    location.href = "reportes.jsp" + "?" + "seleccionado=" + selecc + "&" + "nombres=" + nomb;
                } else {
                    location.href = "reportes.jsp" + "?" + "seleccionado=" + selecc;
                }
            }
        </script>

        <script>
            //las siguientes dos funciones se utilizan para crear clases e invocar estilos.
            $(document).ready(function() {
                $('#date01').datepicker({
                }).on('changeDate', function(ev) {
                    $(this).datepicker('hide');
                });
                $('#date02').datepicker({
                }).on('changeDate', function(ev) {
                    $(this).datepicker('hide');
                });
                $('#date03').datepicker({
                }).on('changeDate', function(ev) {
                    $(this).datepicker('hide');
                });
            });

            $(document).ready(function(e) {
                $('#selectNames').selectpicker();
                $('#selectContrato').selectpicker();
                $('#nombres').selectpicker();
                $('#seleccionado').selectpicker();
            });

        </script>

        <script>
            $(document).ready(function() {
                $('#example').dataTable({
                    "responsive": true,
//                    "paging":   false,
//                    "bJQueryUI": true,
//                    "sDom": 'lfrtip',
//                    "bLengthChange": false,
//                    "info":     false,
//                    "bFilter": false,
                    "bSort": true
//                    "order": [[ 3, 'desc' ], [ 0, 'asc' ]]
//                    "order": [[ 3, "desc" ]]
                });
                $('#example1').dataTable({
                    "responsive": true,
                    "bSort": true
                });
                $('#example2').dataTable({
                    "responsive": true,
                    "bSort": true
                });
                $(".popupfac").fancybox({
                    'closeClick': false,
                    'autoScale': true,
                    'autoSize': true,
                    'transitionIn': 'elastic',
                    'transitionOut': 'elastic',
                    'type': 'iframe',
//                    'overlayShow'   :    false,
//                    'fitToView'     :    false,
//                    width'         :    '65%',
                    helpers: {
                        overlay: {closeClick: true} // prevents closing when clicking OUTSIDE fancybox
                    }
                });
                $(".fancyOther").fancybox({
                    'closeClick': false,
                    'autoScale': true,
                    'autoSize': true,
                    'transitionIn': 'elastic',
                    'transitionOut': 'elastic',
                    'type': 'iframe',
                    helpers: {
                        overlay: {closeClick: true} // prevents closing when clicking OUTSIDE fancybox
                    }
                });
                //fancyOther
            });
            //esta funcion sirve para cambiar la configuración del estilo.
            function borrar() {
                document.getElementById("estatus").style.display = "none";
            }
            //esta funcion sirve para enviar un formulario.
            function enviaSolo() {
                document.getElementById("fofu1").submit();
            }
        </script>

        <div class="col-sm-12">
            <div class="widget-box">

                <div class="widget-header">
                    <!--se pone un titulo al recuadro central-->
                    <h4 class="smaller" style="font-weight: bold;">
                        <% if (seleccionado.equalsIgnoreCase("uno") || seleccionado.equalsIgnoreCase("null")) {%>
                        MIS PERMISOS
                        <% } else if (seleccionado.equalsIgnoreCase("dos")) {%>
                        MI REPORTE MENSUAL
                        <% } else if (seleccionado.equalsIgnoreCase("tres")) {%>
                        LISTA DE ASISTENCIA
                        <% }%>
                    </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main">
                        <!--se crea un formulario para enviar los datos a ingresar-->
                        <form method="get" name="fofu1" id="fofu1" action="reportes.jsp">  
                            <label> ELIJA &nbsp;UNA &nbsp;OPCIÓN&nbsp;</label>
                            <select data-width="260px"  id="seleccionado" name="seleccionado" onchange="redireccionarcuatro(<%=rol%>)">                                           
                                <% if (seleccionado.equalsIgnoreCase("null") || seleccionado.equalsIgnoreCase("uno")) {%>
                                <option value="uno" selected> PERMISOS</option>
                                <% } else {%>
                                <option value="uno"> PERMISOS</option>
                                <% }
                                            if (seleccionado.equalsIgnoreCase("dos")) {%>
                                <option value="dos" selected> REPORTE MENSUAL</option>
                                <% } else {%>
                                <option value="dos"> REPORTE MENSUAL</option>
                                <% }
                                            if (seleccionado.equalsIgnoreCase("tres")) {%>
                                <option value="tres" selected> LISTA DE ASISTENCIA</option>
                                <% } else {%>
                                <option value="tres"> LISTA DE ASISTENCIA</option>
                                <% }%>
                            </select>

                            <br><br>
                            <%
                                ArrayList nombres = null;
                                if (rol.equalsIgnoreCase("1")) {
                                    nombres = new ArrayList();
                                    //Se consultan los nombres completos de los empleados que se encuentren en la base de datos y que sean de la misma unidad productiva.
                                    String nono = "select primerApellido, segundoApellido, nombres from cat_empleados where activo = 1 and upp= " + upp + "  order by primerApellido;";
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();
                                        ResultSet hh = stmt.executeQuery(nono);
                                        while (hh.next()) {
                                            nombres.add(hh.getString("primerApellido") + " " + hh.getString("segundoApellido") + " " + hh.getString("nombres"));
                                        }
                                    } catch (Exception e) {
                                        System.out.println(e);
                                    }
                            %>
                            <label>NOMBRE EMPLEADO</label>
                            <select data-live-search="true" title="ESCOGE ALGÚN NOMBRE" data-width="260px"  id="nombres" name="nombres"  onchange="location = 'reportes.jsp' + '?' + 'nombres=' + nombres.value + '&' + 'seleccionado=' + seleccionado.value">                     
                                <%  // el siguiente ciclo se utiliza para pasar los datos de un arrayList y dejar seleccionado el que ya haya elegido anteriormente.
                                    for (int i = 0; i < nombres.size(); i++) {
                                        if (name.equalsIgnoreCase("" + nombres.get(i))) { %>
                                <option data-tokens="<%out.print(nombres.get(i));%>"  value="<%out.print(nombres.get(i));%>" selected> <%out.print("" + nombres.get(i));%> </option>
                                <% } else { %>
                                <option data-tokens="<%out.print(nombres.get(i));%>"  value="<%out.print(nombres.get(i));%>"> <%out.print("" + nombres.get(i));%> </option>
                                <% }
                                    }
                                    if (name.equalsIgnoreCase("null")) {
                                        name = "" + nombres.get(0);
                                    }
                                %>
                            </select>
                            <br><br>
                            <% }%>
                            <label> FECHA &nbsp;&nbsp;DEL &nbsp;INICIO&nbsp;
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input class="form-control"  type="text" data-format="dd/MM/yyyy" id="date01" name="date01" placeholder="dd/MM/dd" required/>   
                                    <i class="icon-calendar"></i>
                                </span>
                            </label>
                            <br><br>                                                         
                            <label> FECHA &nbsp;&nbsp;DEL &nbsp;&nbsp;FINAL&nbsp;
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input class="form-control" type="text" data-format="dd/MM/yyyy" id="date02" name="date02" placeholder="dd/MM/yyyy" required/>   
                                    <i class="icon-calendar"></i>
                                </span>
                            </label>
                            <br><br>        
                            <div class="clearfix">  
                                <button type="reset" id="borrar" class="btn btn-white btn-info btn-bold pull-left" style="border-right-width:3px;border-bottom-width:3px;color:#790754!important;border-color:#790754;">
                                    <i class="ace-icon fa icon-ban-circle bigger-120 blue" style="color:#790754!important;"></i>
                                    Limpiar
                                </button>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <button id="mostrar" type="submit" class="btn btn-white btn-info btn-bold pull-center" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                                    <i class="ace-icon fa icon-angle-down bigger-120 blue" style="color:#00969A!important;"></i>
                                    Mostrar
                                </button>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <% if (seleccionado.equalsIgnoreCase("uno")) {%>

                                <a  onclick="redireccionaruno(<%=rol%>)" id="ImprimirTodo" class="btn btn-white btn-info btn-bold pull-center" style="border-right-width:3px;border-bottom-width:3px;color:#067300!important;border-color:#067300;">
                                    <i class="ace-icon fa icon-download bigger-120 purple" style="color:#067300!important;"></i>
                                    Imprimir Todo
                                </a>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


                                <% } else if (seleccionado.equalsIgnoreCase("tres")) {%>
                                <a  onclick="redireccionartres(<%=rol%>)" id="ImprimirTodo" class="btn btn-white btn-info btn-bold pull-center" style="border-right-width:3px;border-bottom-width:3px;color:#067300!important;border-color:#067300;">
                                    <i class="ace-icon fa icon-download bigger-120 purple" style="color:#067300!important;"></i>
                                    Imprimir Todo
                                </a>   
                                <%}%>
                            </div>
                            <br> 


                            <% if (seleccionado.equalsIgnoreCase("dos") && rol.equalsIgnoreCase("1")) {%>
                            <div  style=" position:absolute; left:70%; top:11%; bottom:30%; width:70%; height:40%; ">

                                <select name ="selectContrato" id="selectContrato" multiple title="TIPO DE CONTRATO"  onchange="enviaSolo()">
                                    <option <%if (contrato[0].equalsIgnoreCase("confianza") || contrato[1].equalsIgnoreCase("confianza")) {%> selected <%}%>  >CONFIANZA</option>
                                    <option <%if (contrato[0].equalsIgnoreCase("eventual") || contrato[1].equalsIgnoreCase("eventual")) {%>  selected <%}%> >EVENTUAL</option>
                                </select>
                                <br> <br> 
                            </div>
                            <% }%>

                        </form> 


                        <%
//esta opción solo se cumple cuando el que ingresa es un administrador y la opción elegida es la de Reporte Mensual                            
                            if (seleccionado.equalsIgnoreCase("dos") && rol.equalsIgnoreCase("1")) { %>
                        <div  style=" position:absolute; left:70%; top:21%; bottom:30%; width:70%; height:40%; ">
                            
                                <%
                                    nombres.clear();
                                    //Se consultan los nombres completos de los empleados que se encuentren en la base de datos y que sean de la misma unidad productiva considerando el tipo de contrato que tiene.
                                    consulta = "select concat(primerApellido,' ', segundoApellido, ' ',nombres) as nombre from cat_empleados where contrato in ( '" + contrato[0] + "', '" + contrato[1] + "') and activo = 1 and upp= " + upp + " order by primerApellido;";
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();
                                        ResultSet hh = stmt.executeQuery(consulta);
                                        while (hh.next()) {
                                            nombres.add(hh.getString("nombre"));
                                        }
                                    } catch (Exception e) {
                                        System.out.println(e);
                                    }
                                    ArrayList contratos = new ArrayList();
                                    contratos.add(contrato[0]);
                                    contratos.add(contrato[1]);
                                %>

                                <select   name="selectNames" id="selectNames" data-live-search="true" multiple title="ESCOGE ALGÚN NOMBRE">                     
                                    <% for (int i = 0; i < nombres.size(); i++) { %>
                                    
                                    <option data-tokens="<%out.print(nombres.get(i));%>"  value="<%out.print(nombres.get(i));%>" > <%out.print("" + nombres.get(i));%> </option>
                                    
                                    <% }%>
                                </select>
                                <br> <br>
                                
                                <a onclick="href= 'ImprimirReportes.jsp?tipoContrato=<%=contratos%>&selectNames='+selectNames.value"   id="ImprimirTodo" class="btn btn-white btn-warning btn-bold popupfac"  style="border-right-width:3px;border-bottom-width:3px;color:#067300!important;border-color:#067300;">
                                    <i class="ace-icon fa icon-download bigger-120 purple" style="color:#067300!important;"></i>
                                    Imprimir Memorándum
                                </a >
<!--                                <a  class="btn btn-white btn-warning btn-bold popupfac" href="ImprimirReportes.jsp?tipoContrato=<%//=contratos%>&selectNames=ARIAS TORRES ISRAEL" style="border-right-width:3px;border-bottom-width:3px;color:#51a351!important;border-color:#51a351">
                                    <i class="ace-icon fa icon-edit bigger-120 purple" style="color:#51a351!important"></i> #790754
                                    Editar    
                                </a>-->

                                <!--Este campo se usa para pasar los tipos de contrato-->
                                <input type="text" id="tipoContrato" name="tipoContrato" value="<%=contratos%>" style="visibility:hidden"/>
                            </div>

                        <% }%>



                        <%
//La siguiente tabla solo se realiza en caso de que haya elegido la opción de Permisos.
                            if (seleccionado.equalsIgnoreCase(
                                    "null") || seleccionado.equalsIgnoreCase("uno")) { %> 
                        <table id="example" class="display responsive nowrap" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>
                                        FECHA
                                    </th>
                                    <th>
                                        HORA LLEGADA
                                    </th>
                                    <th>
                                        HORA SALIDA
                                    </th>
                                    <th>
                                        TIPO PERMISO
                                    </th>
                                    <th>
                                        ESTADO
                                    </th>
                                    <th>
                                        Categoria
                                    </th>
                                    <th>
                                        Goce de Sueldo
                                    </th>
                                    <th>
                                        Acciones
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    //Las siguientes consultas se realizan en caso de ser administrador o de no ser lo, se aplican otras consultas.
                                    if (rol.equalsIgnoreCase("1")) {

                                        if (inicio1 != null) {
                                            //Consulta de algunos campos de la tabla pases, filtrados por las dos fechas ingresadas y por el nombre del empleado que ha escogido el administrador.
                                            consulta = "select categoria, verificar, goceSueldo, fecha, hr_llegada, hr_salida, tipo, autorizado, id_pase from pases inner join usuario inner join cat_empleados where ('" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and usuario.rfc = cat_empleados.rfc and id = id_solicitante and fecha >= '" + inicio1 + "' and fecha <= '" + fin1 + "');";
                                        } else {
                                            //Consulta de algunos campos de la tabla pases, filtrados por el nombre del empleado que ha escogido el administrador.
                                            consulta = "select categoria, verificar, goceSueldo, fecha, hr_llegada, hr_salida, tipo, autorizado, id_pase from pases inner join usuario inner join cat_empleados where (usuario.rfc = cat_empleados.rfc and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and id = id_solicitante);";
                                        }
                                    } else {
                                        if (inicio1 != null) {
                                            //Consulta de algunos campos de la tabla pases, filtrados por las dos fechas ingresadas y por el nombre del empleado que ha ingresado.
                                            consulta = "select categoria, verificar, goceSueldo, fecha, hr_llegada, hr_salida, tipo, autorizado, id_pase from pases inner join usuario where (id = id_solicitante and username = '" + User + "' and fecha >= '" + inicio1 + "' and fecha <= '" + fin1 + "');";
                                        } else {
                                            //Consulta de algunos campos de la tabla pases, filtrado por el nombre del empleado que ha ingresado.
                                            consulta = "select categoria, verificar, goceSueldo, fecha, hr_llegada, hr_salida, tipo, autorizado, id_pase from pases inner join usuario where (id = id_solicitante and username = '" + User + "');";
                                        }
                                    }
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();
                                        ResultSet rs = stmt.executeQuery(consulta);
                                        while (rs.next()) {
                                %>
                                <tr>
                                    <td><%if (rs.getString("fecha") != null) {
                                            out.print(rs.getString("fecha"));
                                        }%></td>

                                    <td><% if (rs.getString("hr_llegada") == null) {
                                            if (!rs.getString("categoria").equalsIgnoreCase("permiso económico") && !rs.getString("categoria").equalsIgnoreCase("salida anticipada")) { %> PENDIENTE 
                                        <% }
                                            } else if (rs.getString("hr_llegada") != null) {
                                                out.print(rs.getString("hr_llegada"));
                                            } %></td>


                                    <td><% if (rs.getString("hr_salida") == null) {
                                            if (!rs.getString("categoria").equalsIgnoreCase("permiso económico") && !rs.getString("categoria").equalsIgnoreCase("permiso para llegar tarde")) { %> PENDIENTE 
                                        <% }
                                            } else if (rs.getString("hr_salida") != null) {
                                                out.print(rs.getString("hr_salida"));
                                            }%></td>


                                    <td><%=rs.getString("tipo")%></td>
                                    <td><% if (rs.getString("autorizado").equalsIgnoreCase("1")) {%> ACEPTADO <%} else if (rs.getString("autorizado").equalsIgnoreCase("0")) {%> RECHAZADO <% } else {%> PENDIENTE <% }%></td>
                                    <td><% if (rs.getString("categoria") == null) {%> NO TIENE <%} else {%>   <%=rs.getString("categoria")%> <%}%></td>
                                    <td><% if (rs.getString("goceSueldo") == null || rs.getString("goceSueldo").equalsIgnoreCase("0")) {%> No  <%} else if (rs.getString("goceSueldo").equalsIgnoreCase("1")) {%>  Si <%}%></td>

                                    <td> 

                                        <%
                                            if (rs.getString("autorizado").equalsIgnoreCase("0")) { /*Aquí no debe mostrarse nada ctrl z*/
                                        %>

                                        <% } else if (!rs.getString("verificar").equalsIgnoreCase("11") && rs.getString("categoria").equalsIgnoreCase("pase de salida")) {%>
                                        <a name="completar" id="completar" href="Acciones.jsp?fecha=<%=rs.getString("fecha")%>&hr_llegada=<%=rs.getString("hr_llegada")%>&hr_salida=<%=rs.getString("hr_salida")%>&tipo=<%=rs.getString("tipo")%>&autorizado=<%=rs.getString("autorizado")%>&id_pase=<%=rs.getString("id_pase")%>&verificar=<%=rs.getString("verificar")%>" class="fancyOther btn btn-white btn-info btn-bold pull-right" data-fancybox-type="iframe" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                                            <i class="ace-icon fa icon-edit bigger-120 blue" style="color:#00969A!important;"></i>
                                            COMPLETAR
                                        </a> 
                                        <%
                                        } else if (rs.getString("verificar").equalsIgnoreCase("11")) {

                                            if (rol.equalsIgnoreCase("1")) {
                                                if (rs.getString("autorizado").equalsIgnoreCase("2")) {%>

                                        <a name="revisar" id="revisar" href="Acciones.jsp?id_pase=<%=rs.getString("id_pase")%>" class="fancyOther btn btn-white btn-info btn-bold pull-right" data-fancybox-type="iframe" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                                            <i class="ace-icon fa icon-edit bigger-120 blue" style="color:#00969A!important;"></i>
                                            REVISAR
                                        </a> 

                                        <%} else if (rs.getString("autorizado").equalsIgnoreCase("1")) {%>

                                        <a href="ImprimirReportes.jsp?ids=<%=rs.getString("id_pase")%>&nombres=<%=name%>&rol=1" name="reportar" id="reportar" class="fancyOther btn btn-white btn-info btn-bold pull-right" data-fancybox-type="iframe" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                                            <i class="ace-icon fa icon-book bigger-120 blue" style="color:#00969A!important;"></i>
                                            REPORTE
                                        </a> 

                                        <% }
                                        } else if (rs.getString("autorizado").equalsIgnoreCase("1")) {%>
                                        <a href="ImprimirReportes.jsp?ids=<%=rs.getString("id_pase")%>" name="reportar" id="reportar" class="fancyOther btn btn-white btn-info btn-bold pull-right" data-fancybox-type="iframe" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                                            <i class="ace-icon fa icon-book bigger-120 blue" style="color:#00969A!important;"></i>
                                            REPORTE
                                        </a>    

                                        <%}
                                            }
                                            ids.add(rs.getString("id_pase"));
                                        %>
                                    </td>
                                </tr>
                                <%
                                        }
                                        conexion.close();
                                    } catch (Exception e) {
                                        System.out.println(e);
                                    }
                                %>
                            </tbody>

                        </table>
                        <!--Este campo se usa para pasar el Array de Ids-->
                        <input type="text" id="array" name="array" value="<%=ids%>"  style="visibility:hidden"/>   


                        <% }
                            //Esta tabla solo se muestra en caso de haber seleccionado la opción de Reporte Mensual.
                            if (seleccionado.equalsIgnoreCase(
                                    "dos")) { %>
                        <table id="example1" class="display responsive nowrap" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>
                                        No. EMPLEADO
                                    </th>
                                    <th>
                                        NOMBRE
                                    </th>
                                    <th>
                                        UR
                                    </th>
                                    <th>
                                        No. PERMISOS
                                    </th>
                                    <th>
                                        FALTAS
                                    </th>
                                    <th>
                                        RETARDOS
                                    </th>
                                    <th>
                                        EXTRAORDINARIAS
                                    </th>
                                    <th>
                                        TOTAL FALTAS
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    String consulta1 = "";
                                    String consulta2 = "";
                                    String consulta3 = "";
                                    int NoPermisos = 0;
                                    int NoFaltas = 0;
                                    int NoRetardos = 0;
                                    int Extraordinarias = 0;
                                    int NoTotalFaltas = 0;

                                    if (rol.equalsIgnoreCase("1")) {
                                        //Estático
                                        //Consulta de algunos campos de la tabla cat_empleados, filtrados por el nombre del empleado que ha escogido el administrador.
                                        consulta1 = "select cat_empleados.idcat_empleados, cat_empleados.nombres, cat_empleados.ur from cat_empleados inner join usuario where(cat_empleados.rfc = usuario.rfc and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres)); ";
                                        if (inicio1 != null) {
                                            //Dinámico
                                            //Consulta del tipo de asistencia de la tabla asistencias que tiene el empleado que escogió el administrador, filtrado por las fechas establecías por el mismo.
                                            consulta2 = "select asistencias.tipo from asistencias inner join cat_empleados inner join usuario where(asistencias.idnominaemp = cat_empleados.idcat_empleados and cat_empleados.rfc = usuario.rfc and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and asistencias.fecha >= '" + inicio1 + "' and asistencias.fecha <= '" + fin1 + "');";
                                            //Consulta del campo autorizado de la tabla pases  que tiene el empleado que escogió el administrador, filtrado por las fechas establecías por el mismo.
                                            consulta3 = "select pases.autorizado from usuario inner join pases inner join cat_empleados where( usuario.rfc = cat_empleados.rfc and usuario.id = pases.id_solicitante and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres) and pases.fecha >= '" + inicio1 + "' and pases.fecha <= '" + fin1 + "');";
                                        } else {
                                            //Dinámico  
                                            //Consulta del tipo de asistencia de la tabla asistencias que tiene el empleado que escogió el administrador.
                                            consulta2 = "select asistencias.tipo from asistencias inner join cat_empleados inner join usuario where(asistencias.idnominaemp = cat_empleados.idcat_empleados and cat_empleados.rfc = usuario.rfc and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres));";
                                            //Consulta del campo autorizado de la tabla pases  que tiene el empleado que escogió el administrador.
                                            consulta3 = "select pases.autorizado from usuario inner join pases inner join cat_empleados where(usuario.id = pases.id_solicitante and usuario.rfc = cat_empleados.rfc and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres));";
                                        }
                                    } else {
                                        //Estático
                                        //Consulta de algunos campos de la tabla cat_empleados, filtrados por el nombre del empleado que ha ingresado.
                                        consulta1 = "select cat_empleados.idcat_empleados, cat_empleados.nombres, cat_empleados.ur from cat_empleados inner join usuario where(cat_empleados.rfc = usuario.rfc and usuario.username = '" + User + "'); ";
                                        if (inicio1 != null) {
                                            //Dinámico
                                            //Consulta del tipo de asistencia de la tabla asistencias que tiene el empleado que ha ingresado, filtrado por las fechas establecías por el mismo.
                                            consulta2 = "select asistencias.tipo from asistencias inner join cat_empleados inner join usuario where(asistencias.idnominaemp = cat_empleados.idcat_empleados and cat_empleados.rfc = usuario.rfc and usuario.username = '" + User + "' and asistencias.fecha >= '" + inicio1 + "' and asistencias.fecha <= '" + fin1 + "');";
                                            //Consulta del campo autorizado de la tabla pases  que tiene el empleado que ha ingresado, filtrado por las fechas establecías por el mismo.
                                            consulta3 = "select pases.autorizado from usuario inner join pases where(usuario.id = pases.id_solicitante and usuario.username = '" + User + "' and pases.fecha >= '" + inicio1 + "' and pases.fecha <= '" + fin1 + "');";
                                        } else {
                                            //Dinámico 
                                            //Consulta del tipo de asistencia de la tabla asistencias que tiene el empleado que ha ingresado.
                                            consulta2 = "select asistencias.tipo from asistencias inner join cat_empleados inner join usuario where(asistencias.idnominaemp = cat_empleados.idcat_empleados and cat_empleados.rfc = usuario.rfc and usuario.username = '" + User + "');";
                                            //Consulta del campo autorizado de la tabla pases  que tiene el empleado que ha ingresado.
                                            consulta3 = "select pases.autorizado from usuario inner join pases where(usuario.id = pases.id_solicitante and usuario.username = '" + User + "');";
                                        }
                                    }

                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();

                                        ResultSet asis = stmt.executeQuery(consulta2);
                                        while (asis.next()) {
                                            if (asis.getString("asistencias.tipo").equalsIgnoreCase("F")) {
                                                NoFaltas = NoFaltas + 1;
                                            } else if (asis.getString("asistencias.tipo").equalsIgnoreCase("R")) {
                                                NoRetardos = NoRetardos + 1;
                                            } else if (asis.getString("asistencias.tipo").equalsIgnoreCase("EX")) {
                                                Extraordinarias = Extraordinarias + 1;
                                            }
                                        }

                                        ResultSet perm = stmt.executeQuery(consulta3);
                                        while (perm.next()) {
                                            if (perm.getString("pases.autorizado").equalsIgnoreCase("1")) {
                                                NoPermisos = NoPermisos + 1;
                                            }
                                        }

                                        NoTotalFaltas = NoFaltas + NoRetardos / 3 + Extraordinarias / 3;
                                        ResultSet rs = stmt.executeQuery(consulta1);
                                        while (rs.next()) {
                                %>
                                <tr>
                                    <td><%=rs.getString("cat_empleados.idcat_empleados")%></td>
                                    <td><%=rs.getString("cat_empleados.nombres")%></td>
                                    <td><%=rs.getString("cat_empleados.ur")%></td>
                                    <td><%=NoPermisos%></td>
                                    <td><%=NoFaltas%></td>
                                    <td><%=NoRetardos%></td>
                                    <td><%=Extraordinarias%></td>
                                    <td><%=NoTotalFaltas%></td>
                                </tr>
                                <%
                                        }
                                        conexion.close();
                                    } catch (Exception e) {
                                        System.out.println("Consulta: " + e);
                                    }
                                %>
                            </tbody>
                        </table>
                        <% }
                            ArrayList matri = null;
                            //Esta tabla solo se muestra  en caso de haber elegido la opción de Lista de Asistencia.
                            if (seleccionado.equalsIgnoreCase(
                                    "tres")) { %>
                        <table id="example2" class="display responsive nowrap" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>
                                        No. EMPLEADO
                                    </th>
                                    <th>
                                        NOMBRE
                                    </th>
                                    <th>
                                        UR
                                    </th>
                                    <th>
                                        FECHA
                                    </th>
                                    <th>
                                        HORA LLEGADA
                                    </th>
                                    <th>
                                        HORA SALIDA
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    matri = new ArrayList();
                                    String fecha = null;
                                    String hora = null;
                                    String tipo = null;
                                    String numero = null;
                                    String nombre = null;
                                    String ur = null;
                                    String consulta1 = null;
                                    int numeroEntradas = 0;

                                    if (rol.equalsIgnoreCase("1")) {
                                        //Consulta de algunos campos de la tabla cat_empleados pertenecientes al empleado que ha elegido el administrador.
                                        consulta1 = "select cat_empleados.idcat_empleados, cat_empleados.nombres, cat_empleados.ur from cat_empleados inner join usuario where(usuario.rfc = cat_empleados.rfc and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres));";

                                        if (inicio1 != null) {
                                            //Consulta de algunos campos de la tabla asistencias pertenecientes al empleado que ha elegido el administrador y filtrado por las fechas elegidas por el mismo.
                                            consulta = "select asistencias.fecha, asistencias.hora, asistencias.tipo from asistencias inner join cat_empleados inner join usuario where(asistencias.idnominaemp = cat_empleados.idcat_empleados and usuario.rfc = cat_empleados.rfc and asistencias.fecha >= '" + inicio1 + "' and asistencias.fecha <= '" + fin1 + "' and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres));";
                                        } else {
                                            //Consulta de algunos campos de la tabla asistencias pertenecientes al empleado que ha elegido el administrador.
                                            consulta = "select asistencias.fecha, asistencias.hora, asistencias.tipo from asistencias inner join cat_empleados inner join usuario where(asistencias.idnominaemp = cat_empleados.idcat_empleados and usuario.rfc = cat_empleados.rfc and '" + name + "' = concat(primerApellido,' ', segundoApellido, ' ',nombres));";
                                        }

                                    } else {
                                        //Consulta algunos campos de la tabla cat_empleados que tiene el empleado que ha ingresado.
                                        consulta1 = "select cat_empleados.idcat_empleados, cat_empleados.nombres, cat_empleados.ur from cat_empleados inner join usuario where(usuario.username = '" + User + "' and usuario.rfc = cat_empleados.rfc);";

                                        if (inicio1 != null) {
                                            //Consulta algunos campos de la tabla asistencias que tiene el empleado que ha ingresado, filtrado por las fechas establecidas por el mismo.
                                            consulta = "select asistencias.fecha, asistencias.hora, asistencias.tipo from asistencias inner join cat_empleados inner join usuario where(username = '" + User + "' and asistencias.idnominaemp = cat_empleados.idcat_empleados and usuario.rfc = cat_empleados.rfc and asistencias.fecha >= '" + inicio1 + "' and asistencias.fecha <= '" + fin1 + "');";
                                        } else {
                                            //Consulta algunos campos de la tabla asistencias que tiene el empleado que ha ingresado.                                            //
                                            consulta = "select asistencias.fecha, asistencias.hora, asistencias.tipo from asistencias inner join cat_empleados inner join usuario where(username = '" + User + "' and asistencias.idnominaemp = cat_empleados.idcat_empleados and usuario.rfc = cat_empleados.rfc);";
                                        }
                                    }

                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();

                                        ResultSet ss = stmt.executeQuery(consulta1);
                                        while (ss.next()) {
                                            numero = ss.getString("cat_empleados.idcat_empleados");
                                            nombre = ss.getString("cat_empleados.nombres");
                                            ur = ss.getString("cat_empleados.ur");
                                        }

                                        ResultSet cc = stmt.executeQuery(consulta);
                                        while (cc.next()) {
                                            if (cc.getString("asistencias.tipo").equalsIgnoreCase("R") || cc.getString("asistencias.tipo").equalsIgnoreCase("EP")) {
                                                numeroEntradas = numeroEntradas + 1;
                                            }
                                        }
                                        String matriz[][] = new String[numeroEntradas][4];

                                        ResultSet pp = stmt.executeQuery(consulta);
                                        while (pp.next()) {
                                            fecha = pp.getString("asistencias.fecha");
                                            hora = pp.getString("asistencias.hora");
                                            tipo = pp.getString("asistencias.tipo");

                                            if (tipo.equalsIgnoreCase("R") || tipo.equalsIgnoreCase("EP")) {
                                                for (int dd = 0; dd < numeroEntradas; dd++) {
                                                    if (matriz[dd][0] == null) {
                                                        matriz[dd][0] = fecha;
                                                        matriz[dd][1] = hora;
                                                        matriz[dd][2] = "Pendiente";
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                        ResultSet ex = stmt.executeQuery(consulta);
                                        while (ex.next()) {
                                            fecha = ex.getString("asistencias.fecha");
                                            hora = ex.getString("asistencias.hora");
                                            tipo = ex.getString("asistencias.tipo");

                                            if (tipo.equalsIgnoreCase("EX") || tipo.equalsIgnoreCase("SP")) {
                                                for (int aa = 0; aa < numeroEntradas; aa++) {
                                                    if (fecha.equalsIgnoreCase(matriz[aa][0])) {
                                                        matriz[aa][2] = hora;
                                                    }
                                                }
                                            }
                                        }

                                        for (int yy = 0; yy < numeroEntradas; yy++) {
                                            matri.add(matriz[yy][0]);
                                %>

                                <tr>
                                    <td><%=numero%></td>
                                    <td><%=nombre%></td>
                                    <td><%=ur%></td>
                                    <td><% out.print(matriz[yy][0]); %></td>
                                    <td><% out.print(matriz[yy][1]); %></td>
                                    <td><% out.print(matriz[yy][2]); %></td>
                                </tr>
                                <%
                                    }
                                %>

                                <!--Este campo se usa para pasar la matriz de Ids-->
                            <input type="text" id="matriz" name="matriz" value="<%=matri%>"  style="visibility:hidden"/>

                            <%
                                } catch (Exception e) {
                                    System.out.println("Consulta: " + e);
                                }
                            %>
                            </tbody>
                        </table>
                        <% }%>

                        <!--Este campo se usa para pasar datos a otra pagina, abriendo un fancy box, como administrador -->
                        <a href="ImprimirReportes.jsp?ids=<%=ids%>&nombres=<%=name%>&rol=1"  id="redic1" name="redic1" class="fancyOther btn btn-white btn-info btn-bold pull-right" data-fancybox-type="iframe"  style="visibility:hidden"/>  no tuve elección :( </a>

                        <!--Este campo se usa para pasar datos a otra pagina, abriendo un fancy box, como usuario normal -->
                        <a href="ImprimirReportes.jsp?ids=<%=ids%>"  id="redic2" name="redic2" class="fancyOther btn btn-white btn-info btn-bold pull-right" data-fancybox-type="iframe"  style="visibility:hidden"/>  no tuve elección :( </a>

                        <!--Este campo se usa para pasar datos a otra pagina, abriendo un fancy box, como administrador -->
                        <a href="ImprimirReportes.jsp?matriz=<%=matri%>&nombres=<%=name%>&rol=1"  id="redic3" name="redic3" class="fancyOther btn btn-white btn-info btn-bold pull-right" data-fancybox-type="iframe"  style="visibility:hidden"/>  no tuve elección :( </a>

                        <!--Este campo se usa para pasar datos a otra pagina, abriendo un fancy box, como usuario normal -->
                        <a href="ImprimirReportes.jsp?matriz=<%=matri%>"  id="redic4" name="redic4" class="fancyOther btn btn-white btn-info btn-bold pull-right" data-fancybox-type="iframe"  style="visibility:hidden"/>  no tuve elección :( </a>
                        
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
