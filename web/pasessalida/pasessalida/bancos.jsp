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
        <title>Administración de Bancos</title>
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
                        Administraci&oacute;n de Bancos
                    </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main">
                        <%if(estatus.equals("1")){%>
                        <div id="estatus" class="alert alert-success">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='bancos.jsp'">×</a>
                            <strong>Banco Creado Correctamente!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("2")){%>
                        <div id="estatus" class="alert alert-danger">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='bancos.jsp'">×</a>
                            <strong>Banco Desactivado Correctamente!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("3")){%>
                        <div id="estatus" class="alert alert-info">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='bancos.jsp'">×</a>
                            <strong>Banco Editado Correctamente!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("4")){%>
                        <div id="estatus" class="alert alert-info">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='bancos.jsp'">×</a>
                            <strong>Banco Activado Correctamente!</strong>
                        </div>
                        <%}%>
                        <%if(estatus.equals("6")){%>
                        <div id="estatus" class="alert alert-danger">
                            <a class="close" data-dismiss="alert" onclick="window.location.href='bancos.jsp'">×</a>
                            <strong>El Banco Ya Existe!</strong>
                        </div>
                        <%}%>
                       <a onclick="borrar()" class="btn btn-white btn-info btn-bold popupfac" href='nuevoBanco.jsp' style="border-right-width:3px;border-bottom-width:3px;color:#0044cc!important;border-color:#0044cc;">
                            <i class="ace-icon fa fa-plus-circle bigger-120 blue" style="color:#0044cc!important;"></i>
                            Nuevo
                        </a>
                       <br>
                       <br>
                        <%--form  class="form-horizontal" id="form" name="form" action="upp.jsp" method="post"> 
                            <label class="control-label"><b>Marca:</b></label>
                            <input  type="text" name="marcaVehiculo" id="marcaVehiculo" style="width: 258px;text-transform: uppercase;">
                            <button type="submit" class="btn btn-white btn-info btn-bold" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                                <i class="ace-icon fa icon-search bigger-120 blue" style="color:#00969A!important;"></i>
                                Buscar
                            </button>
                        </form>
                        <br--%>
                        <table id="example" class="display responsive nowrap" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>
                                        Clave
                                    </th>
                                    <th>
                                        Nombre
                                    </th>
                                    <th>
                                        Razón Social
                                    </th>
                                    <th style="text-align:center;">
                                        Acciones
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
                                <tr>
                                    <td style="text-transform: uppercase;"><%=rs.getString("c_Banco")%></td>
                                    <td style="text-transform: uppercase;"><%=rs.getString("descripcionBanco")%></td>
                                    <td style="text-transform: uppercase;"><%=rs.getString("RazonSocial")%></td>
                                    <td class="center ">
                                        <a onclick="borrar()" class="btn btn-white btn-warning btn-bold popupfac" href="editarBanco.jsp?idBanco=<%=rs.getString("sat_c_Banco")%>" style="border-right-width:3px;border-bottom-width:3px;color:#51a351!important;border-color:#51a351">
                                            <i class="ace-icon fa icon-edit bigger-120 orange" style="color:#51a351!important"></i> <!--#790754-->
                                            Editar
                                        </a>
                                        <%if(rs.getString("activo").equals("1")){%>
                                        <a onclick="borrar()" class="btn btn-white btn-default btn-round" href="eliminarBanco.jsp?idBanco=<%=rs.getString("sat_c_Banco")%>" style="border-right-width:3px;border-bottom-width:3px;color:#bd362f!important;border-color:#bd362f">
                                            <i class="ace-icon fa fa-times red2" style="color:#bd362f!important;"></i>
                                            Desactivar
                                        </a>
                                        <%}else{%>
                                        <a onclick="borrar()" class="btn btn-white btn-info btn-bold" href="activarBanco.jsp?idBanco=<%=rs.getString("sat_c_Banco")%>" style="border-right-width:3px;border-bottom-width:3px;color:#0044cc!important;border-color:#0044cc;"> 
                                            <i class="ace-icon fa icon-ok bigger-120 blue" style="color:#0044cc!important;"></i>
                                            Activar
                                        </a>
                                        <%}%>
                                    </td>
                                </tr>
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