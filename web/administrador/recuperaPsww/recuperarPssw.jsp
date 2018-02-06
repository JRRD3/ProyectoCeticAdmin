<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Inicio de Sesión</title>

        <meta name="description" content="User login page" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="<c:url value="/assets/css/bootstrap.min.css"/>" rel="stylesheet" />
        <link rel="stylesheet" href="<c:url value="/assets/css/font-awesome.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace-fonts.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/assets/css/ace-rtl.min.css"/>" />
        <link href="<c:url value="/assets/images/favicon.ico"/>"  type="image/x-icon" rel="shortcut icon">
        <link rel="stylesheet" href="<c:url value="/assets/motion/MotionCAPTCHA/jquery.motionCaptcha.0.2.css"/>"/>
        <link rel="stylesheet" href="<c:url value="/assets/motion/motionCaptcha.demo.css"/>"/>
        
        <script src="<c:url value="/assets/js/jquery-2.0.3.min.js"/>"></script>
        <script src="<c:url value="/assets/js/jquery.mobile.custom.min.js"/>"></script>
        <!--<script src="/ceticAdmin/assets/scripts/jquery-1.7.2.min.js"></script>-->
    </head>
    <body class="login-layout" style=" background-image: url('../../assets/images/back_content.jpg')">
        <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="row">
                            <div class="col-sm-4"></div>
                            <div class="col-sm-4 center">
                                <br><br>
                                <img src="<c:url value="/assets/images/logoMichoacan1.png"/>" class="pull-center"/>
                                <!--<br><br>-->
                            </div>
                            <div class="col-sm-4"></div>
                        </div>  
                        <div class="login-container">
                            <div class="space-6"></div>
                            <div id="contenido" class="position-relative">
                                <div id="login-box" class="login-box visible widget-box no-border" >
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <h5 class="header red lighter bigger">
                                                Recuperar Cuenta:
                                            </h5>
                                            <div class="space-6"></div>
                                            <form class="form-horizontal" id="mc-form" method="POST" action="Recuperar.jsp">
                                                <fieldset>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <!--<input type="text" class="form-control" placeholder="Usuario" name="j_username" />-->
                                                            <input id="Usuario" class="form-control" type="text" name="Usuario" placeholder="Usuario" required>
                                                            <i class="icon-user"></i>
                                                        </span>
                                                    </label>
                                                    <label class="block clearfix">
                                                        <span class="block input-icon input-icon-right">
                                                            <!--<input type="password" class="form-control" placeholder="Contraseña" name="j_password" />-->
                                                            <input class="form-control" type="email" name="Correo" id="Correo" placeholder="Correo" required>
                                                            <i class="icon-lock"></i>
                                                        </span>
                                                    </label>
                                                    <center>
                                                        <label class="block clearfix">
                                                                <canvas id="mc-canvas">
                                                                    Su navegador no soporta el elemento canvas - Utilize un navegador mas moderno.
                                                                </canvas>
                                                                <p style="width:210px;text-align:center;">(<a onClick="window.location.reload()" href="recuperarPssw.jsp" title="Nueva Imagen">Nueva Imagen</a>)</p>
                                                        </label>
                                                    </center>
                                                    <div class="space-4"></div>
                                                    <div class="clearfix">
                                                        <a href="<c:url value="/login.jsp"/>">Regresar</a>
                                                        <input class="width-35 btn btn-white btn-info btn-bold pull-right" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A;" disabled="disabled" autocomplete="false" type="submit" value="Recuperar">
                                                    </div>
                                                    <div class="space-4"></div>
                                                </fieldset>
<!--                                                <fieldset>
                                                    <div class="control-group">
                                                        <label class="control-label" for="j_username"><b>RFC:</b></label>
                                                        <div class="controls">
                                                            <input id="inputRfc" class="input-large" type="text" name="RFC" id="RFC" style="width: 215px" required="">
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <label class="control-label" for="j_password"><b>Correo:</b></label>
                                                        <div class="controls">
                                                            <input class="input-large" type="text" name="Correo" id="Correo" style="width: 215px" required="">
                                                        </div>
                                                    </div>
                                                    <div class="control-group">
                                                        <div class="controls">
                                                            <canvas id="mc-canvas">
                                                                Su navegador no soporta el elemento canvas - Utilize un navegador mas moderno.
                                                            </canvas>
                                                            <p style="width:210px;text-align:center;">(<a onClick="window.location.reload()" href="recuperarPssw.jsp" title="Nueva Imagen">Nueva Imagen</a>)</p>
                                                        </div>
                                                    </div>
                                                </fieldset>-->
<!--                                                <fieldset>
                                                    <div class="form-actions" style="margin-bottom:0px;margin-top:0px;">
                                                        <input class="btn btn-successp ull-right" disabled="disabled" autocomplete="false" type="submit" value="Recuperar">
                                                        <a href="../login.jsp">Regresar</a>
                                                    </div>
                                                </fieldset>-->
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
        <script src="<c:url value="/assets/motion/jquery.min.js"/>" type="text/javascript"></script>
        <script src="<c:url value="/assets/motion/MotionCAPTCHA/jquery.motionCaptcha.0.2.js"/>" ></script>       
	<script type="text/javascript">
            jQuery(document).ready(function($) {
		$('#mc-form').motionCaptcha({
			shapes: ['triangle', 'x', 'rectangle', 'circle', 'check', 'zigzag', 'arrow', 'delete', 'pigtail', 'star']
		});
			$("input.placeholder").placeholder();
		});
	</script>
    </body>
</html>