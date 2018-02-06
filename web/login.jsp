<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Inicio de Sesión</title>

        <meta name="description" content="User login page" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="<c:url value="/assets/css/bootstrap.min.css"/>" rel="stylesheet" />
        <link rel="stylesheet" href="<c:url value="/assets/css/font-awesome.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace-fonts.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace-rtl.min.css"/>" />
        <link href="<c:url value="/assets/images/favicon.ico"/>"  type="image/x-icon" rel="shortcut icon">
        
        <script src="<c:url value="/assets/js/jquery-2.0.3.min.js"/>"></script>
        <script src="<c:url value="/assets/js/jquery.mobile.custom.min.js"/>"></script>
    </head>
    <body class="login-layout" style=" background-image: url('./assets/images/back_content.jpg')">
        <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="row">
                            <div class="col-sm-4">
                                <!--<img src="./assets/images/logoMichoacanDeOcampo.png" class="pull-right" />-->
                            </div>
                            <div class="col-sm-4 center">
<!--                                <h1>
                                    <span class="red">Padr&oacute;n de Beneficiarios</span>
                                </h1>-->
                                <br><br>
                                <img src="<c:url value="/assets/images/logoMichoacan.png"/>" class="pull-center"/>
                                <br> 
<!--                                Titulo centrado despues de las imagenes.-->
                                <div style="padding-right: 20px;"><h3 >Sistema de la Delegaci&oacute;n Administrativa (CETIC)</h3></div>
                                    ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
                            </div>
                            <div class="col-sm-4">
                                <!--<img src="./assets/images/LogoTrabajoDesarrollo.png" class="pull-left"/>-->
                            </div>
                        </div>  
                        <div class="login-container">
                            <div class="space-6"></div>
                            <div id="contenido" class="position-relative"> <!--style="position: absolute; right:180px;"-->
                                <div id="login-box" class="login-box visible widget-box no-border" >
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <!--titulo dentro del recuadro del formulario para logearse.-->
                                            <h5 class="header red lighter bigger">
                                                Iniciar Sesi&oacuten:
                                            </h5>
                                            <div class="space-6"></div>
                                            <form method="POST" id="form" action="<c:url value='/j_spring_security_check'/>">
                                                <fieldset>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <input type="text" class="form-control" placeholder="Usuario" name="j_username" />
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <input type="password" class="form-control" placeholder="Contraseña" name="j_password" />
                                                            <i class="icon-lock"></i>
                                                        </span>
                                                    </label>
                                                    <div class="space-4"></div>
                                                    <div class="clearfix">
                                                        
                                                        <a href="administrador/recuperaPsww/recuperarPssw.jsp">Recuperar Contraseña</a>
                                                        <!--boton para ingresar-->
                                                        <button type="submit" class="width-35 btn btn-white btn-info btn-bold pull-right" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;">
                                                            <i class="ace-icon fa icon-key bigger-120 blue" style="color:#00969A!important;"></i>
                                                            Ingresar
                                                        </button> 
                                                    </div>
                                                    <div class="space-4"></div>
                                                </fieldset>
                                            </form>
                                        </div><!-- /widget-main -->
                                        <div class="toolbar clearfix " style="padding: 15px;">
                                            <h4 class=" white" style=" text-align: center;">&copy; Gobierno del Estado de Michoac&aacute;n</h4>
                                        </div>
                                    </div><!-- /widget-body -->
                                </div><!-- /login-box -->
                            </div><!-- /position-relative -->
                        </div>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div>
        </div><!-- /.main-container -->
        <div id="progress" style="display: none; color: green; position: absolute; left: 0; top: 0; width: 100%; height: 100%; background: transparent url(./assets/img/cargando1.GIF) no-repeat center center"></div>
        <script src="<c:url value="/assets/js/jquery-1.7.2.min.js"/>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#form').submit(function() {
                    $('#progress').show();
                    $('#contenido').hide();
                });
            });
        </script>
    </body>
</html>