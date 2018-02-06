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
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_nameNomina");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    String usrEmp = resource.getString("ceticAdmin.bd_userEmp");
    String psswEmp = resource.getString("ceticAdmin.bd_passwordEmp");
    String bdadmin = resource.getString("ceticAdmin.bd_name");
    String User = SecurityContextHolder.getContext().getAuthentication().getName();
    List<String> P = new ArrayList<String>();
    String Cad = "", Pr = "", CadN = "";
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Banco</title>
    </head>
    <body>
        <!--<script src="/ceticAdmin/assets/scripts/jquery-1.8.3.min.js"></script>-->
        <script src="<c:url value="/assets/BootstrapSelect/js/jquery-1.11.3.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-3.3.4.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-select.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/i18n/defaults-es_CL.min.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datepicker.js"/>"></script>
        <script src="<c:url value="/assets/scripts/datepicker/js/bootstrap-datetimepicker.min.js"/>"></script>
        <!--<script src="/ceticAdmin/assets/validate/jquery.js"></script>-->
	<script src="<c:url value="/assets/validate/jquery.validate.js"/>"></script>
        <style>
            .input-xlarge{
                width: 385px;
            }
            .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn){
                width: 385px;
            }
        </style>
        <script>
            $(document).ready(function(){
                var url = location.href;
                url = url.substring(url.lastIndexOf("?")+8,url.lastIndexOf("?")+12);
                var url1 = location.href;
                url1 = url1.substring(url1.lastIndexOf("sw")+3,url1.lastIndexOf("sw")+4);
                var encEstatus = window.btoa(url1);
//                var encEstatus = window.btoa(1);
//                alert(url1+" "+encEstatus);
                if(url === "exit"){
                    var urlAc = window.top.location.href;
                    urlAc = urlAc.substring(0,urlAc.lastIndexOf("jsp")+3);
                    window.top.location.href = urlAc+"?NBVF="+encEstatus;
                    parent.$.fancybox.close();
                }
            });
        </script>
<%
    List<String> datosBanco = new ArrayList<String>();
    String idBanco = request.getParameter("idBanco"); 
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM sat_c_banco "
                                        +"WHERE sat_c_Banco = "+idBanco+"");
        while(rs.next()){
            datosBanco.add(rs.getString("c_Banco"));
            datosBanco.add(rs.getString("descripcionBanco"));
            datosBanco.add(rs.getString("nombreRazonSocial"));
        }
        conexion.close();
    }catch(Exception e){System.out.println(e);}
    System.out.println(idBanco);
%>
        <div class="box-container-toggle1">
            <div class="box-content1">
                <form class="form-horizontal" method="POST" action="guardaEditar.jsp" id="myform" name="myform">
                    <fieldset>
                        <legend>Editar Banco</legend>
                        <input class="input-xlarge focused" type="hidden" name="idBanco" id="idBanco" value="<%=idBanco%>">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"><b>Clave:</b></label>
                            <div class="col-sm-9">
                                <input class="input-xlarge focused" type="text" name="claveBanco" id="claveBanco" placeholder="Escriba la Clave..." required
                                <%if(!datosBanco.get(0).equals("")) out.print("value=\""+datosBanco.get(0)+"\"");%>>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"><b>Nombre:</b></label>
                            <div class="col-sm-9">
                                <input class="input-xlarge focused" type="text" name="descripcionBanco" id="descripcionBanco" placeholder="Escriba el Nombre..." required
                                <%if(!datosBanco.get(1).equals("")) out.print("value=\""+datosBanco.get(1)+"\"");%>>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"><b>Raz&oacute;n Social:</b></label>
                            <div class="col-sm-9">
                                <textarea style="width: 385px;" class="input-xlarge focused" rows="5" name="razonSocial" id="razonSocial" placeholder="Razón Social..."><%if(!datosBanco.get(2).equals("")) out.print(datosBanco.get(2));%></textarea> 
                            </div>
                        </div>
                        <div class="clearfix form-actions">
                            <div class="col-md-offset-3 col-md-9" style="margin-left:23%;">
                                <button type="submit" class="btn btn-white btn-info btn-bold" style="border-right-width:3px;border-bottom-width:3px;color:#790754!important;border-color:#790754;">
                                    <i class="ace-icon fa fa-save bigger-120 blue" style="color:#790754!important;"></i>
                                    Guardar
                                </button>
                            </div>
                        </div>
                    </fieldset>
                </form>  
            </div>
        </div>
    </body>
</html>