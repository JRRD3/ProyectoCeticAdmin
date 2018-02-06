<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="es">
    <head>
        <title><sitemesh:write property='title'/></title>
        <link href="<c:url value="/assets/images/favicon.ico"/>" type="image/x-icon" rel="shortcut icon">
        <link href="<c:url value="/assets/css/bootstrap.min.css"/>" rel="stylesheet">
        <!--<link href="/ceticAdmin/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">-->
        <link href="<c:url value="/assets/css/font-awesome.min.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/css/jquery-ui-1.10.3.custom.min.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/css/jquery.gritter.css"/>"  rel="stylesheet"/>
        <link href="<c:url value="/assets/css/select2.css"/>"  rel="stylesheet" />
        <link href="<c:url value="/assets/css/bootstrap-editable.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/web/fontgalano.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/css/ace-fonts.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/css/ace.min.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/css/ace-rtl.min.css"/>"  rel="stylesheet" > 
        <link href="<c:url value="/assets/css/ace-skins.min.css"/>"  rel="stylesheet" >
        <link href="<c:url value="/assets/css/bootstrap-transfer.css"/>"  rel="stylesheet" >
        <link href="<c:url value="/assets/multiple-upload/uploadfile.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/scripts/datepicker/css/datepicker.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/scripts/datepicker/css/bootstrap-datetimepicker.min.css"/>"  rel="stylesheet">
        <link href="<c:url value="/assets/pagination/css/reset.css"/>"  rel="stylesheet"/>
        <link href="<c:url value="/assets/pagination/css/jqpagination.css"/>"  rel="stylesheet"/>
        
        <link href="<c:url value="/assets/DataTables/css/jquery-ui.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/DataTables/css/dataTables.jqueryui.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/DataTables/css/responsive.jqueryui.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/fancybox/jquery.fancybox.css"/>" rel="stylesheet" type="text/css">
        <link href="<c:url value="/assets/validate/cmxform.css"/>" rel="stylesheet">
        <link href="<c:url value="/assets/validate/cmxformTemplate.css"/>" rel="stylesheet" >
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
        
        <script src="<c:url value="/assets/js/jquery-1.7.2.min.js"/>"></script>
        <!--<script src="/ceticAdmin/assets/js/jquery-2.0.3.min.js"></script>-->
        <script src="<c:url value="/assets/js/jquery.mobile.custom.min.js"/>"></script>
        
<!--        <script src="/ceticAdmin/assets/BootstrapSelect/js/bootstrap-3.3.4.min.js"></script>
        <script src="/ceticAdmin/assets/BootstrapSelect/js/bootstrap-select.min.js"></script>
        <script src="/ceticAdmin/assets/BootstrapSelect/js/i18n/defaults-es_CL.min.js"></script>-->

        <script src="<c:url value="/assets/js/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/assets/js/typeahead-bs2.min.js"/>"></script>

        <script src="<c:url value="/assets/js/jquery-ui-1.10.3.full.min.js"/>"></script>
        <script src="<c:url value="/assets/js/jquery.ui.touch-punch.min.js"/>"></script>
        <script src="<c:url value="/assets/js/jquery.gritter.min.js"/>"></script>
        <script src="<c:url value="/assets/js/bootbox.min.js"/>"></script>
        <script src="<c:url value="/assets/js/jquery.slimscroll.min.js"/>"></script>
        <script src="<c:url value="/assets/js/jquery.easy-pie-chart.min.js"/>"></script>
        <script src="<c:url value="/assets/js/jquery.hotkeys.min.js"/>"></script>
        <script src="<c:url value="/assets/js/bootstrap-wysiwyg.min.js"/>"></script>
        <script src="<c:url value="/assets/js/select2.min.js"/>"></script>
        <script src="<c:url value="/assets/js/date-time/bootstrap-datepicker.min.js"/>"></script>
        <script src="<c:url value="/assets/js/fuelux/fuelux.spinner.min.js"/>"></script>
        <script src="<c:url value="/assets/js/x-editable/bootstrap-editable.min.js"/>"></script>
        <script src="<c:url value="/assets/js/x-editable/ace-editable.min.js"/>"></script>
        <script src="<c:url value="/assets/js/jquery.maskedinput.min.js"/>"></script>

        <script src="<c:url value="/assets/js/jquery.sparkline.min.js"/>"></script>
        <script src="<c:url value="/assets/js/flot/jquery.flot.min.js"/>"></script>
        <script src="<c:url value="/assets/js/flot/jquery.flot.pie.min.js"/>"></script>
        <script src="<c:url value="/assets/js/flot/jquery.flot.resize.min.js"/>"></script>
        
        <script src="<c:url value="/assets/js/ace/elements.scroller.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/elements.colorpicker.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/elements.fileinput.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/elements.typeahead.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/elements.wysiwyg.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/elements.spinner.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/elements.treeview.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/elements.wizard.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/elements.aside.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.ajax-content.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.touch-drag.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.sidebar.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.sidebar-scroll-1.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.submenu-hover.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.widget-box.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.settings.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.settings-rtl.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.settings-skin.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.widget-on-reload.js"/>"></script>
        <script src="<c:url value="/assets/js/ace/ace.searchbox-autocomplete.js"/>"></script>

        <!-- ace scripts -->
        <script src="<c:url value="/assets/js/ace-elements.min.js"/>"></script>
        <script src="<c:url value="/assets/js/ace.min.js"/>"></script>
        
        <script src="<c:url value="/assets/fancybox/jquery.fancybox.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/assets/fancybox/jquery.fancybox.pack.js"/>"></script>
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