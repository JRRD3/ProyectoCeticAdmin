<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.web.util.HtmlUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="sidebar" id="sidebar"> <!--menu-min-->
    <script type="text/javascript">
        try {
            ace.settings.check('sidebar', 'fixed');
        } catch (e) {
        }
    </script>
    <ul class="nav nav-list">
        <li>    
            <a href="#" class="dropdown-toggle">
                <i class="icon-dashboard"></i>
                <span class="menu-text"> Gestión Incidencias </span>
                <b class="arrow icon-angle-down"></b>
            </a>
            <ul class="submenu">  
                <li>
                    <a href="<c:url value="/pasessalida/NuevoPermiso.jsp"/>">
                        <i class="icon-double-angle-right"></i>
                        Nuevo Permiso
                    </a>               
                </li>
                <li>
                    <a href="<c:url value="/pasessalida/reportes.jsp"/>">
                        <i class="icon-double-angle-right"></i>
                        Reportes
                    </a>               
                </li>
            </ul>
        </li>
    </ul><!-- /.nav-list -->
    <div class="sidebar-collapse" id="sidebar-collapse">
        <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
    </div>
</div>