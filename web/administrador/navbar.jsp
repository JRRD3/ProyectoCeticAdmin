<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%
    String logout = request.getParameter("TUOG");
    if(logout != null){
        byte[] valueDecoded= Base64.decodeBase64(logout);//decoding part
        logout = new String(valueDecoded);
    }
    if(logout == null) logout = "";
    if(logout.equals("1"))
        response.sendRedirect(request.getContextPath()+"/logout.jsp");

    String User = SecurityContextHolder.getContext().getAuthentication().getName();
    String ID = "", urUser = "";
    ResourceBundle resource = ResourceBundle.getBundle("Propiedades");
    String bd = resource.getString("ceticAdmin.bd_name");
    String usr = resource.getString("ceticAdmin.bd_user");
    String pssw = resource.getString("ceticAdmin.bd_password");
    try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection(bd, usr, pssw);
        Statement stmt = conexion.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT id FROM usuario WHERE username = '"+User+"'");
        while(rs.next())
            ID = rs.getString(1);
        rs = stmt.executeQuery("SELECT ur FROM usuario WHERE username = '"+User+"'");
        while(rs.next()){
            urUser = rs.getString("ur");
        }
        conexion.close();
    }catch(Exception e){System.out.println(e);}
//    System.out.println(ID);
    request.setAttribute("id",ID);
%>
<div class="navbar navbar-default" id="navbar">
    <script src="<c:url value="/assets/js/bootstrap.min.js"/>"></script>
    <script type="text/javascript">
        try {
            ace.settings.check('navbar', 'fixed');
        } catch (e) {
        }
    </script>
    <script>
        $(document).ready(function(){                
            $(".popupfac1").fancybox({
                'closeClick'    :   false,
                'transitionIn'  :   'elastic',
                'transitionOut' :	'elastic',
                'type'          :   'iframe',
                'fitToView'     :    false,
                'width'         :    '70%', 
                helpers   : {
                    overlay : {closeClick: true} // prevents closing when clicking OUTSIDE fancybox
                },
                'afterClose':function () {
                    window.location.reload();
                }
            }); 
            $(".popupfacEdit").fancybox({
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
        });
    </script>
    <div class="navbar-container" id="navbar-container">
        <div class="navbar-header pull-left">
            <a href="<c:url value="/index.jsp"/>" class="navbar-brand">

                <img src="<c:url value="/assets/images/CETIC-Logo.png"/>" class="pull-left img-rounded"/>
            </a><!-- /.brand -->
        </div><!-- /.navbar-header -->
        <div class="navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">
<!--                <li class="green">
                    <a href="/padronBeneficiarios/mensajes/inbox.jsp">
                        <i class="icon-envelope icon-animated-vertical"></i>
                        <span class="badge badge-success">0</span> B00052
                    </a>
                </li> -->
                <%
                    String Rol1 = SecurityContextHolder.getContext().getAuthentication().getAuthorities().toString();
                    Rol1 = Rol1.substring(Rol1.lastIndexOf("[")+1, Rol1.lastIndexOf("]"));
                    String menuEstruct1 = "",idCategoria = "", autorizarDep = "";
                    int noLeidos = 0, idestatusAut = 100, uppUsr = 0;
                %>
                <%--li class="green" style="width: 75px;">
                    <a href="<c:url value="/operador/inboxAutorizar.jsp"/>" style="background-color:#790754!important;">
                        <i class="icon-envelope icon-animated-vertical"></i>
                        <span class="badge badge-success" style="background-color:#777!important;padding-top:4px;padding-right:8px;padding-left:8px;"><%=noLeidos%></span>
                    </a>
                </li--%> 
                <li class="red">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle" style="background: #00969A!important;">
                        <img src="<c:url value="/assets/images/member_ph.png"/>" alt="Foto Administrador" />
                        <span class="user-info">
                            BIENVENIDO,<br>
                            <b><font style="text-transform: uppercase;"><security:authentication property="principal.username"/></font></b>
                        </span>
                        <i class="icon-caret-down"></i>
                    </a>
                    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li style="width: 190px;">
                            <a class="popupfacEdit" href="<c:url value="/administrador/editaUsuario/editarUsuario.jsp?user=${id}"/>">
                                <i class="icon-edit"></i>
                                Editar
                            </a>
                        </li>
                        <li class="divider"></li>
                        <li style="width: 190px;">
                            <a href="<c:url value="/j_spring_security_logout" />">
                                <i class="icon-off"></i>
                                Salir del sistema
                            </a>
                        </li>
                    </ul>
                </li>
            </ul><!-- /.ace-nav -->
        </div><!-- /.navbar-header -->
    </div><!-- /.container -->
</div>