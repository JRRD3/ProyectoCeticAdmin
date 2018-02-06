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
    String hr_salida = request.getParameter("hr_salida");
    String tipo = request.getParameter("tipo");
    String autorizado = request.getParameter("autorizado");
    String id_pase = request.getParameter("id_pase");
%>
<html>
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/estilos.css">
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

        
        <%if(fecha != null){ %>
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
                            <%if (hr_llegada.equalsIgnoreCase("null") && hr_salida.equalsIgnoreCase("null")) {%>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label> HORA LLEGADA
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input class="form-control" type="time" name="hr_llegada" id="hr_llegada">
                                    <i class="icon-file"></i>
                                </span>
                            </label>
                            <br>
                            <br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label> HORA SALIDA
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input class="form-control" type="time" name="hr_salida" id="hr_salida" required>
                                    <i class="icon-time"></i>
                                </span>
                            </label>


                            <% } else if (hr_salida.equalsIgnoreCase("null")) {%>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;              
                            <label> HORA LLEGADA
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input class="form-control" type="text" name="hr_llegada" id="hr_llegada" value="<%=hr_llegada%>" readonly="readonly">
                                    <i class="icon-time"></i>
                                </span>
                            </label>
                            <br>
                            <br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label> HORA SALIDA
                                <span class="input-icon input-icon-right"  style="width: 260px;">
                                    <input class="form-control" type="time" name="hr_salida" id="hr_salida" required>
                                    <i class="icon-time"></i>
                                </span>
                            </label>

                            <% } else if (hr_llegada.equalsIgnoreCase("null")) {%>    
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label> HORA LLEGADA
                                <span class="input-icon input-icon-right"  style="width: 260px;">
                                    <input class="form-control" type="time" name="hr_llegada" id="hr_llegada" required>
                                    <i class="icon-time"></i>
                                </span>
                            </label>
                            <br>
                            <br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label> HORA SALIDA
                                <span class="input-icon input-icon-right" style="width: 260px;">
                                    <input class="form-control" type="text" name="hr_salida" id="hr_salida" value="<%=hr_salida%>" readonly="readonly">
                                    <i class="icon-time"></i>
                                </span>
                            </label>
                            <% }%>         
                            <br>
                            <br>
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
                            
                            <%} else{ 
        String observaciones = null;   
        String consulta = "select fecha, tipo, hr_salida, hr_llegada, observaciones from pases where id_pase = "+id_pase+" ;";
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
            
        }catch (Exception e) {
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
                                <br><h5>  <b>HORA SALIDA:</b> <%=hr_salida%></h5>
                                <br><h5>  <b>HORA LLEGADA:</b> <%=hr_llegada%></h5>
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
