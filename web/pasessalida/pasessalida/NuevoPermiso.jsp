<%-- 
    Document   : newjsp
    Created on : 20/04/2017, 09:15:31 AM
    Author     : MaRkOz
--%>

<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NUEVO PERMISO</title>
        <link rel="stylesheet" type="text/css" media="screen" href="style.css">
    </head>
    <body>
        <script type="text/javascript">jQuery.noConflict();</script>
        <script src="<c:url value="/assets/BootstrapSelect/js/jquery-1.11.3.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-3.3.4.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/bootstrap-select.min.js"/>"></script>
        <script src="<c:url value="/assets/BootstrapSelect/js/i18n/defaults-es_CL.min.js"/>"></script>
        <div class="col-sm-12">
            <div class="widget-box">
                <div class="widget-header">
                    <h4 class="smaller" style="font-weight: bold;">
                        NUEVO PERMISO
                    </h4>
                </div>
                <div class="widget-body">
                    <div class="widget-main">
                        <div>
                            <form>
                                <ul>
                                    <li>
                                <input type="text" id="empleado"/><br>
                                <label>EMPLEADO</label><br><br>
                                    </li>
                                <label><select name="select" id="pase-salida">
                                        <option value="pase de salida">PASE DE SALIDA</option>
                                        <option value="salida anticipada">SALIDA ANTICIPADA</option>
                                        <option value="permiso economico">PERMISO ECONOMICO</option>
                                    </select></label><br><br>
                                <label>SELECCIONE LA CATEGORIA DEL PERMISO QUE NECESITA</label><br><br>
                                <label>TIPO DE PERMISO <br><input type="radio" id="tipo-permiso" value="personal" name="personal" checked="checked"/>personal</label>
                                <label><input type="radio" id="tipo-permiso" value="oficial" name="oficial"/>oficial</label><br><br>

                                <label><textarea id="textarea" rows="5" cols="50"></textarea><br>
                                    OBSERVACION Y/O DESCRIPCION</label>
                                </ul>
                            </form>
                        </div>
                        <div class="contenedor">
                            <h1>USUARIO</h1>
                            <form>
                                <fieldset>
                                    <legend>PASE DE SALIDA</legend>
                                    <label>
                                        <input type="date" name="fecha"><br><br>
                                        FECHA 
                                    </label>        
                                    <label>
                                        <input type="time" name="hora"><br><br>
                                        HORA SALIDA
                                    </label>
                                    <label>
                                        <input type="time" name="hora"><br><br>
                                        HORA LLEGADA
                                    </label>
                                </fieldset><br><br>
                                <fieldset>
                                    <legend> PERMISO PARA LLEGAR TARDE</legend>
                                    <label> <input type="date" name="fecha"/><br>
                                        FECHA 
                                    </label>  
                                    <label>
                                        <input type="time" name="hora"/><br>
                                        HORA LLEGADA
                                    </label>        
                                </fieldset><br><br>
                                <fieldset>
                                    <legend>SALIDA ANTICIPADA</legend>
                                    <label><input type="date" value="now" name="fecha"/><br>
                                        FECHA 
                                    </label>
                                    <label><input type="time" name="hora"/><br>
                                        HORA SALIDA
                                    </label>
                                </fieldset><br><br>
                                <fieldset>
                                    <legend> PERMISO ECONOMICO</legend>
                                    <label><input type="month" value="2017-04" name="mes"/><br>
                                        FECHA INICIAL
                                    </label>
                                    <label><input type="date" name="fecha" step="1"/><br>
                                        FECHA FINAL
                                    </label>
                                </fieldset><br><br>
                                <fieldset>
                                    <legend>LICENCIAS</legend>
                                    <label><select name="select" id="licencias">
                                            <option value="con gose de sueldo">CON GOSE DE SUELDO</option>
                                            <option value="sin gose de sueldo">SIN GOSE DE SUELDO</option>
                                        </select></label><br><br>
                                    <label><select name="select" id="licencias">
                                            <option value="casos gose de sueldo">CASOS DE GOSE DE SUELDO</option>
                                            <option value="sin gose de sueldo">SIN GOSE DE SUELDO</option>
                                        </select></label><br><br>

                                    <label><input type="date" name="fecha"><br>
                                        FECHA INICIAL
                                    </label>
                                        <label><input type="date" name="fecha"><br>
                                        FECHA FINAL
                                    </label><br>
                                    <button type="submit" style="border-right-width:3px;border-bottom-width:3px;color:#00969A!important;border-color:#00969A; float: right">
                                        <i style="color:#00969A!important;"></i>
                                        GUARDAR
                                    </button> 
                                </fieldset>       
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
