<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="es">
    <head>
        <title><sitemesh:write property='title'/></title>
        <link href="<c:url value="/assets/images/favicon.ico"/>" type="image/x-icon" rel="shortcut icon">
        <link href="<c:url value="/assets/css/bootstrap.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/css/font-awesome.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/css/jquery-ui-1.10.3.custom.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/css/jquery.gritter.css"/>" rel="stylesheet"/>
        <link href="<c:url value="/assets/css/select2.css"/>" rel="stylesheet" />
        <link href="<c:url value="/assets/css/bootstrap-editable.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/web/fontgalano.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/css/ace-fonts.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/css/ace.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/css/ace-rtl.min.css"/>" rel="stylesheet" > 
        <link href="<c:url value="/assets/css/ace-skins.min.css"/>" rel="stylesheet" >
        <link href="<c:url value="/assets/css/bootstrap-transfer.css"/>" rel="stylesheet" >
        <link href="<c:url value="/assets/scripts/datepicker/css/datepicker.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/scripts/datepicker/css/bootstrap-datetimepicker.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/validate/cmxform.css"/>" rel="stylesheet" >
        <link href="<c:url value="/assets/validate/cmxformTemplate.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/BootstrapSelect/css/bootstrap-select.min.css"/>" rel="stylesheet">
        <style>
/*            #date01-error { 
                position: absolute;
                margin-left: 5%;
            }*/
            #caret{
                color: #FFF;
            }
            #multiSelect1-error { 
                position: absolute;
                margin-left: 49%;
                margin-top: -4%;
            }
/*            input { 
                text-transform: uppercase;
            }*/
            ::-webkit-input-placeholder { /* WebKit browsers */
                text-transform: none;
            }
            :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
                text-transform: none;
            }
            ::-moz-placeholder { /* Mozilla Firefox 19+ */
                text-transform: none;
            }
            :-ms-input-placeholder { /* Internet Explorer 10+ */
                text-transform: none;
            }
        </style>
    </head>
    <body> <!--style=" background-image: url('/portalTimbrado/assets/images/back_content.jpg')" style="font-family: 'sans-serif'; font-size: 13px;"-->
        <%@include file="/administrador/navbar.jsp"%>
        <div class="main-container" id="main-container">
            <div class="main-container-inner">
                <%@include file="/administrador/sidebar.jsp"%>
                <div class="main-content">
                    <div class="page-content" style="background: #ffffff">
                        <sitemesh:write property='body'/>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>