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

    String fecha = request.getParameter("fecha");
    String hr_llegada = request.getParameter("hr_llegada");
    String verificar = request.getParameter("verificar");
    String hr_salida = request.getParameter("hr_salida");
    String tipo = request.getParameter("tipo");
    String autorizado = request.getParameter("autorizado");
    String id_pase = request.getParameter("id_pase");
%>
<html>
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/estilos.css">

        <!--time picker css y js-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
        <!-- final time picker css y js-->


        <title>Acciones</title>
    </head>
    <body>
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

        <!--time picker js-->
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datetimepicker.min.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datepickerNew.js"/>"></script>
        <!--final time picker js-->
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
                    },
                    'afterClose': function() {
                        window.location.reload();
                    }
                });
            });
            function borrar() {
                document.getElementById("estatus").style.display = "none";
            }


        </script>

        <script type="text/javascript">
            $(function() {
                $('#datetime').datetimepicker({
                    pickDate: false,
                    pick12HourFormat: true
                });
            });
        </script>


        <%if (fecha != null) {%>
        <div class="col-sm-12">
            <div class="widget-box">
                <div class="widget-header">
                    <h4 class="smaller" style="font-weight: bold; margin-left: 33%;">
                        INGRESAR DATOS FALTANTES
                    </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main">  
                        <form id="fechas" action="reportes.jsp">
                            <input type="text" name="id_pase" id="id_pase" value="<%=id_pase%>" style=" display: none">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <label> FECHA
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input type="text" name="fecha" id="fecha" value="<%=fecha%>" class="form-control" readonly="readonly">
                                    <i class="icon-calendar"></i>
                                </span>
                            </label>
                            <br>
                            <br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label> TIPO
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input class="form-control" type="text" name="tipo" id="tipo" value="<%=tipo%>" readonly="readonly">
                                    <i class="icon-file"></i>
                                </span>
                            </label>
                            <br>
                            <br>
                            <% if (hr_llegada.equalsIgnoreCase("null") || !verificar.equalsIgnoreCase("11")) {%> 
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label> HORA SALIDA
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input class="form-control" type="text" name="hr_salida" id="hr_salida" value="<%=hr_salida%>" readonly="readonly">
                                    <i class="icon-time"></i>
                                </span>
                            </label>
                            <br>
                            <br>
                            <div id="datetime" class="input-append">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label> HORA LLEGADA </label>
                                <input style="width: 233px;" data-format="hh:mm:ss" type="text" name="hr_llegada" id="hr_llegada" placeholder="hh:mm:ss" required>
                                <span class="add-on">
                                    <i class="icon-time"></i>
                                </span>
                            </div>
                            <br>
                            <br>
                            <% }%>         

                            <button type="reset" id="borrar" class="btn btn-white btn-info btn-bold pull-left" style="border-right-width:3px;border-bottom-width:3px;color:#790754!important;border-color:#790754;left: 233px;">
                                <i class="ace-icon fa icon-ban-circle bigger-120 blue" style="color:#790754!important;"></i>
                                Limpiar
                            </button>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button id="guardar" type="submit" class="btn btn-white btn-info btn-bold pull-center" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;left: 233px;">
                                <i class="ace-icon fa icon-save bigger-120 blue" style="color:#00969A!important;"></i>
                                Guardar
                            </button>
                        </form>
                    </div>
                </div>
            </div>         
        </div>    

        <%} else {
            String observaciones = null;
            //Consulta realizada para obtener varios campos de la tabla pases.
            String consulta = "select fecha, tipo, hr_salida, hr_llegada, observaciones from pases where id_pase = " + id_pase + " ;";
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                Statement stmt = conexion.createStatement();
                ResultSet hh = stmt.executeQuery(consulta);
                while (hh.next()) {
                    fecha = hh.getString("fecha");
                    tipo = hh.getString("tipo");
                    hr_salida = hh.getString("hr_salida");
                    hr_llegada = hh.getString("hr_llegada");
                    observaciones = hh.getString("observaciones");
                }

            } catch (Exception e) {
                System.out.println(e);
            }

        %>

        <div class="col-sm-12">
            <div class="widget-box">
                <div class="widget-header">
                    <h4 class="smaller" style="font-weight: bold; margin-left: 33%;">
                        VERIFICAR PASE
                    </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main"> 

                        <br>
                        <div id="centrar" style="  left:50%; margin-left: 230px; " >
                            <h5> <b>FECHA:</b> <%=fecha%></h5>
                            <br><h5>  <b>TIPO:</b> <%=tipo%></h5>
                            <br><h5>  <b>HORA SALIDA:</b> <%if (hr_salida != null) {
                                    out.print(hr_salida);
                                }%></h5>
                            <br><h5>  <b>HORA LLEGADA:</b> <%if (hr_llegada != null) {
                                    out.print(hr_llegada);
                                }%></h5>
                            <br><h5> <b>OBSERVACIONES:</b> <%=observaciones%></h5>
                            <br>
                        </div>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a name="rechazar" id="rechazar" href="reportes.jsp?id_pase=<%=id_pase%>&aceptado=1" class="fancyOther btn btn-white btn-info btn-bold pull-center" data-fancybox-type="iframe" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                            <i class="ace-icon fa icon-save bigger-120 blue" style="color:#00969A!important;"></i>
                            ACEPTAR
                        </a> 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a name="rechazar" id="rechazar" href="reportes.jsp?id_pase=<%=id_pase%>&aceptado=0" class="fancyOther btn btn-white btn-info btn-bold pull-center" data-fancybox-type="iframe" style="border-right-width:3px;border-bottom-width:3px;color:#790754!important;border-color:#790754;">
                            <i class="ace-icon fa icon-ban-circle bigger-120 blue" style="color:#790754!important;"></i>
                            RECHAZAR
                        </a> 
                    </div>
                </div>
            </div>         
        </div>   

        <%}%>
    </body>
</html>
