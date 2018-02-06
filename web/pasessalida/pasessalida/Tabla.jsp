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
    if(estatus != null){
        byte[] valueDecoded= Base64.decodeBase64(estatus);//decoding part
        estatus = new String(valueDecoded);
    }
    if (estatus == null) estatus = "0";
//    System.out.println("Estatus: "+estatus);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabla sola</title>
    </head>
    <body>
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
                    "bSort": true
//                    "order": [[ 3, 'desc' ], [ 0, 'asc' ]]
//                    "order": [[ 3, "desc" ]]
                });
                $(".popupfac").fancybox({
                    'closeClick'    :   false,
                    'autoScale'     :   true,
                    'autoSize'      :   true,
                    'transitionIn'  :   'elastic',
                    'transitionOut' :	'elastic',
                    'type'          :   'iframe',
//                    'overlayShow'   :    false,
//                    'fitToView'     :    false,
//                    width'         :    '65%',
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
                        Tabla Funcional
                    </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main">
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
                                    <th style="text-align:center;">
                                        TIPO PERMISO
                                    </th>
                                    <th>
                                        ESTADO
                                    </th>
                                    <th>
                                        AUTORIZACIÓN
                                    </th>
                                    <th>
                                        VISTO BUENO
                                    </th>
                                    <th>
                                        REPORTAR LLEGADA
                                    </th>
                                    <th>
                                        IMPRESIÓN
                                    </th>
                                    <th>
                                        BOTON DE IMPRIMIR
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                    <%
                                    String consulta = "SELECT sat_c_Banco, c_Banco, descripcionBanco, SUBSTRING(nombreRazonSocial,1,40) as RazonSocial, activo, fechaAlta FROM sat_c_banco  ";
//                                    if(!marcaVehiculo.equals("")) {consulta+=" WHERE marca LIKE '%"+marcaVehiculo+"%' ";}
                                    try{
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
                                        Statement stmt = conexion.createStatement();
                                        ResultSet rs = stmt.executeQuery(consulta);
                                        while(rs.next()){
                                %>
                                
                                <%
                                        }
                                    conexion.close();
                                    }catch(Exception e){System.out.println(e);}
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>