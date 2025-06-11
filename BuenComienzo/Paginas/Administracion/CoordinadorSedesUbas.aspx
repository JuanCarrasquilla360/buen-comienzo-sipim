<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CoordinadorSedesUbas.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.CoordinadorSedesUbas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../plugins/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <%--<link href="../../plugins/fonts/font-awesome.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link href="../../plugins/fonts/ionicons.min.css" rel="stylesheet" />
    <!-- Theme style -->
    <link href="../../Content/AdminLTE.min.css" rel="stylesheet" />

    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="../../Content/_all-skins.min.css" rel="stylesheet" />

    <!-- DataTables -->
    <link href="../../plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" />
    <!-- iCheck -->
    <link href="../../plugins/iCheck/all.css" rel="stylesheet" />
    <!-- Skin -->
    <link href="../../Content/skin-red-light.min.css" rel="stylesheet" />
    <!-- Daterange picker -->
    <link href="../../Content/BuenComienzoFamiliar.css" rel="stylesheet" />

    <!-- select2 -->
    <link rel="stylesheet" href="../../plugins/select2/select2.min.css" />

    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <script src="../../plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <script type="text/javascript">
        $('#framePrincipal', parent.document).css('height', '0px');
    </script>
</head>
<body>
    <div id="loading" style="display: block;display: flex;text-align: center;position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="frmCoordinadorSedesUbas" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Relación Coordinador Agentes, sedes y ubas
                    <%--<small>Control panel</small>--%>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../../Index.aspx"><i class="fa fa-home"></i>Inicio</a></li>
                    <%--<li class="active">Cargue masivo</li>--%>
                </ol>
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="box">
                        <div class="col-md-12 col-xs-12">
                        </div>

                        <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                            <div class="col-sm-4" style="padding-left: 6px;">
                                <select id="ddlCoordinador" class="form-control select2" onchange="habilitarBotones(); CargarDatos();">
                                    <option value="">Seleccione un coordinador</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-12 col-xs-12">
                        </div>
                    </div>
                </div>
                <!-- Small boxes (Stat box) -->
                <div class="row">
                    <div>

                        <div class="panel panel-default" style="margin: 10px;">
                            <div class="panel-heading" style="font-weight: bold; font-size: 16px">Sedes</div>
                            <div class="panel-body" style="padding: 0px;">
                                <div class="col-md-12 col-xs-12" style="margin-top: 7px">
                                    <div class="col-md-12 col-xs-12" style="padding-left: 0px; text-align: right; padding-right: 0px;">
                                        <input id="btnNuevaSede" type="button" class="btn btn-cincopasitos" value="Asociar sedes" />
                                    </div>
                                </div>
                                <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                                </div>
                                <div class="box-body">
                                    <table id="grdSedes" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>


                        <div class="panel panel-default" style="margin: 10px;">
                            <div class="panel-heading" style="font-weight: bold; font-size: 16px">Ubas</div>
                            <div class="panel-body" style="padding: 0px;">
                                <div class="col-md-12 col-xs-12" style="margin-top: 7px">
                                    <div class="col-md-12 col-xs-12" style="padding-left: 0px; text-align: right; padding-right: 0px;">
                                        <input id="btnNuevaUba" type="button" class="btn btn-cincopasitos" value="Asociar ubas" />
                                    </div>
                                </div>
                                <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                                </div>
                                <div class="box-body">

                                    <table id="grdUbas" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default" style="margin: 10px;">
                            <div class="panel-heading" style="font-weight: bold; font-size: 16px">Agentes Educativos</div>
                            <div class="panel-body" style="padding: 0px;">
                                <div class="col-md-12 col-xs-12" style="margin-top: 7px">
                                    <div class="col-md-12 col-xs-12" style="padding-left: 0px; text-align: right; padding-right: 0px;">
                                        <input id="btnNuevoAgente" type="button" class="btn btn-cincopasitos" value="Asociar agentes" />
                                    </div>
                                </div>
                                <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                                </div>
                                <div class="box-body">
                                    <table id="grdAgentes" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12 col-xs-12">
                            <br />
                        </div>


                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            </section>
        </div>

        <!-- Bootstrap 3.3.5 -->
        <script src="../../plugins/bootstrap/js/bootstrap.js"></script>
        <!-- form validator -->
        <script src="../../plugins/jqueryValidator/jquery.form-validator.min.js"></script>
        <!-- Cinco Pasitos -->
        <script src="../../Scripts/BuenComienzoFamiliar.js"></script>
        <!-- DataTables -->
        <script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="../../plugins/datatables/dataTables.bootstrap.min.js"></script>
        <!-- icheck -->
        <script src="../../plugins/iCheck/icheck.min.js"></script>
        <!-- select2 -->
        <script src="../../plugins/select2/select2.full.min.js"></script>
        <!-- Script -->
        <script type="text/javascript">

            var tblSedes;
            var tblUbas;
            var tblAgentes;

            $(window).load(function () {
                setTimeout(function () { $('#loading').fadeOut(300, "linear"); habilitarBotones(); CargarDatos(); }, 400);
            });

            function columnasJSON(columnas) {

                var aryJSONColTable = [];

                for (var i = 0; i < columnas.length; i++) {
                    aryJSONColTable.push({
                        "sTitle": columnas[i],
                        "aTargets": [i]
                    });
                };

                return aryJSONColTable;
            }

            $(document).ready(function () {
                cargarCoordinadores();

                $(".select2").select2();

                $.validate({
                    modules: 'date, security',
                    lang: 'es'
                });

                $('#btnNuevaSede').click(function () {
                    AsociarSedes();
                });

                $('#btnNuevaUba').click(function () {
                    AsociarUbas();
                });

                $('#btnNuevoAgente').click(function () {
                    AsociarAgentes();
                });
            });

            function habilitarBotones() {
                if ($('#ddlCoordinador').val() == '') {
                    $('#btnNuevaSede').hide();
                    $('#btnNuevaUba').hide();
                    $('#btnNuevoAgente').hide();

                }
                else {
                    $('#btnNuevaSede').show();
                    $('#btnNuevaUba').show();
                    $('#btnNuevoAgente').show();
                }
            }

            function CargarDatos() {

                if (tblSedes != null) {
                    tblSedes.clear();
                    tblUbas.clear();
                    tblAgentes.clear();
                }

                setTimeout(function () {
                    cargarUbasCoordinador();
                }, 1);

                setTimeout(function () {
                    cargarSedesCoordinador();
                }, 1);

                setTimeout(function () {
                    cargarCoordinadorAgentes();
                }, 1);
            }

            function cargarSedesCoordinador() {
                tblSedes = $("#grdSedes").DataTable({
                    "destroy": true,
                    "paging": true,
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    "searching": true,
                    'columnDefs': [{
                        'targets': 6,
                        'orderable': false
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id sede', 'Nombre', 'Código sede SIBC', 'Dirección', 'Celular', 'Comuna', 'Barrio', 'Correo', 'Activo', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarSedesCoordinador",
                    "drawCallback": function (settings) {
                        $('#framePrincipal', parent.document).css('height', document.body.scrollHeight + 'px');
                    },
                    "fnServerData": function (sSource, aoData, fnCallback) {
                        //Se agrega el idCoordinador
                        aoData.push({ name: 'idCoordinador', value: $('#ddlCoordinador').val() });

                        $.ajax({
                            "dataType": 'json',
                            "contentType": "application/json; charset=utf-8",
                            "type": "GET",
                            "url": sSource,
                            "data": aoData,
                            "success":
                                function (msg) {
                                    var json = jQuery.parseJSON(msg.d);
                                    fnCallback(json);
                                    $("#grdSedes").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function cargarUbasCoordinador() {
                tblUbas = $("#grdUbas").DataTable({
                    "destroy": true,
                    "paging": true,
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    "searching": true,
                    'columnDefs': [{
                        'targets': 5,
                        'orderable': false
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id uba', 'Uba', 'Tipo uba', 'Uba sistema', 'Activo', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarUbasCoordinador",
                    "drawCallback": function (settings) {
                        $('#framePrincipal', parent.document).css('height', document.body.scrollHeight + 'px');
                    },
                    "fnServerData": function (sSource, aoData, fnCallback) {
                        //Se agrega el idCoordinador
                        aoData.push({ name: 'idCoordinador', value: $('#ddlCoordinador').val() });

                        $.ajax({
                            "dataType": 'json',
                            "contentType": "application/json; charset=utf-8",
                            "type": "GET",
                            "url": sSource,
                            "data": aoData,
                            "success":
                                function (msg) {
                                    var json = jQuery.parseJSON(msg.d);
                                    fnCallback(json);
                                    $("#grdUbas").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function cargarCoordinadorAgentes() {
                tblAgentes = $("#grdAgentes").DataTable({
                    "destroy": true,
                    "paging": true,
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    "searching": true,
                    'columnDefs': [{
                        'targets': 5,
                        'orderable': false
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id Documento', 'Nombre', 'Celular', 'Perfil', 'Estado', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarCoordinadorAgentes2",
                    "drawCallback": function (settings) {
                        $('#framePrincipal', parent.document).css('height', document.body.scrollHeight + 'px');
                    },
                    "fnServerData": function (sSource, aoData, fnCallback) {
                        //Se agrega el idCoordinador
                        aoData.push({ name: 'idCoordinador', value: $('#ddlCoordinador').val() });

                        $.ajax({
                            "dataType": 'json',
                            "contentType": "application/json; charset=utf-8",
                            "type": "GET",
                            "url": sSource,
                            "data": aoData,
                            "success":
                                function (msg) {
                                    var json = jQuery.parseJSON(msg.d);
                                    fnCallback(json);
                                    $("#grdAgentes").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function AsociarUbas() {
                openPopup({
                    'title': 'Asociar ubas',
                    'width': '400',
                    'url': './Popups/AsociarUbas.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#frmAsociarUbas', parent.document).isValid()) {

                                var campos = 'idUbas,idCoordinador'
                                var valores = $('#ddlUbas', parent.document).val().toString().replaceAll(',', '|') + ',' +
                                    $('#ddlCoordinador').val();

                                ejecutarMetodoAsync('../WebMethods.aspx/AsociarUbas', 'POST', campos, valores, function (resp) {
                                    try {

                                        datosJson = JSON.parse(resp.d);
                                        alerta(datosJson.mensaje, datosJson.tipoMensaje);

                                        if (datosJson.resultado) {
                                            CloseModalBox();
                                            tblUbas.ajax.reload();
                                        }
                                    }
                                    catch (e) {
                                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                    }
                                });
                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox();
                        }
                    }]
                }, function () { successAsociarUbas(); });

                //Se configuran la validación
                parent.configFormValidate('frmAsociarUbas', 'date, security');
            }

            function successAsociarUbas() {
                parent.configSelect2();
                cargarUbas();
            }

            function AsociarSedes() {
                openPopup({
                    'title': 'Asociar sedes',
                    'width': '400',
                    'url': './Popups/AsociarSedes.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#frmAsociarSedes', parent.document).isValid()) {

                                var campos = 'idSedes,idCoordinador'
                                var valores = $('#ddlSedes', parent.document).val().toString().replaceAll(',', '|') + ',' +
                                    $('#ddlCoordinador').val();

                                ejecutarMetodoAsync('../WebMethods.aspx/AsociarSedes', 'POST', campos, valores, function (resp) {
                                    try {

                                        datosJson = JSON.parse(resp.d);
                                        alerta(datosJson.mensaje, datosJson.tipoMensaje);

                                        if (datosJson.resultado) {
                                            CloseModalBox();
                                            tblSedes.ajax.reload();
                                        }
                                    }
                                    catch (e) {
                                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                    }
                                });
                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox();
                        }
                    }]
                }, function () { successAsociarSedes(); });

                //Se configuran la validación
                parent.configFormValidate('frmAsociarSedes', 'date, security');
            }

            function successAsociarSedes() {
                parent.configSelect2();
                cargarSedes();
            }

            function AsociarAgentes() {
                openPopup({
                    'title': 'Asociar agentes',
                    'width': '400',
                    'url': './Popups/AsociarAgentes.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#frmAsociarAgentes', parent.document).isValid()) {

                                var campos = 'idAgentes,idCoordinador'
                                var valores = $('#ddlAgentes', parent.document).val().toString().replaceAll(',', '|') + ',' +
                                    $('#ddlCoordinador').val();

                                ejecutarMetodoAsync('../WebMethods.aspx/AsociarAgentes', 'POST', campos, valores, function (resp) {
                                    try {

                                        datosJson = JSON.parse(resp.d);
                                        alerta(datosJson.mensaje, datosJson.tipoMensaje);

                                        if (datosJson.resultado) {
                                            CloseModalBox();
                                            tblAgentes.ajax.reload();
                                        }
                                    }
                                    catch (e) {
                                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                    }
                                });
                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox();
                        }
                    }]
                }, function () { successAsociarAgentes(); });

                //Se configuran la validación
                parent.configFormValidate('frmAsociarAgentes', 'date, security');
            }

            function successAsociarAgentes() {
                parent.configSelect2();
                cargarAgentes();
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarCoordinadores() {

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarCoordinadores',                 // URL al que vamos a hacer el pedido
                    data: null,                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: false,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $('#ddlCoordinador').empty();
                            $('#ddlCoordinador').append('<option value="' + '' + '" selected>Seleccione un coordinador</option>');

                            $.each(informacion, function (index, value) {
                                $('#ddlCoordinador').append('<option value="' + value.idDocumento + '">' + value.nombre + '</option>');
                            });
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarUbas() {

                $.ajax({
                    type: "GET",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarUbasDisponibles',                 // URL al que vamos a hacer el pedido
                    data: null,                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $(window.parent.document).find('#ddlUbas').empty();

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlUbas').append('<option value="' + value.idUba + '">' + value.uba + '</option>');
                            });
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarSedes() {

                var jsonInput = "{ idCoordinador: '" + $('#ddlCoordinador').val() + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarSedesDisponibles',                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $(window.parent.document).find('#ddlSedes').empty();

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlSedes').append('<option value="' + value.idSede + '">' + value.nombreSede + '</option>');
                            });
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarAgentes() {

                $.ajax({
                    type: "GET",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarAgentes',                 // URL al que vamos a hacer el pedido
                    data: null,                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $(window.parent.document).find('#ddlAgentes').empty();

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlAgentes').append('<option value="' + value.idAgente + '">' + value.nombre + '</option>');
                            });
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            function EliminarSede(idSede, nombre) {

                confirmar('Está seguro que desea desasociar la sede ' + nombre + '?', 'Advertencia', function () {

                    var campos = 'idSede,idCoordinador,nombre'
                    var valores = idSede + ',' + $('#ddlCoordinador').val() + ',' + nombre;

                    ejecutarMetodoAsync('../WebMethods.aspx/EliminarCoordinadorSede', 'POST', campos, valores, function (resp) {
                        try {

                            datosJson = JSON.parse(resp.d);
                            setTimeout(function () { alerta(datosJson.mensaje, datosJson.tipoMensaje) }, 100);

                            if (datosJson.resultado)
                                tblSedes.ajax.reload();
                        }
                        catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                });
            }

            function EliminarUba(idUba, nombre) {

                confirmar('Está seguro que desea desasociar la uba ' + nombre + '?', 'Advertencia', function () {

                    var campos = 'idUba,nombre'
                    var valores = idUba + ',' + nombre;

                    ejecutarMetodoAsync('../WebMethods.aspx/EliminarCoordinadorUba', 'POST', campos, valores, function (resp) {
                        try {

                            datosJson = JSON.parse(resp.d);
                            setTimeout(function () { alerta(datosJson.mensaje, datosJson.tipoMensaje) }, 100);

                            if (datosJson.resultado)
                                tblUbas.ajax.reload();
                        }
                        catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                });
            }

            function EliminarAgente(idAgente, nombre) {

                confirmar('Está seguro que desea desasociar el agente ' + nombre + '?', 'Advertencia', function () {

                    var campos = 'idAgente,idCoordinador,nombre'
                    var valores = idAgente + ',' + $('#ddlCoordinador').val() + ',' + nombre;

                    ejecutarMetodoAsync('../WebMethods.aspx/EliminarCoordinadorAgente', 'POST', campos, valores, function (resp) {
                        try {

                            datosJson = JSON.parse(resp.d);
                            setTimeout(function () { alerta(datosJson.mensaje, datosJson.tipoMensaje) }, 100);

                            if (datosJson.resultado)
                                tblAgentes.ajax.reload();
                        }
                        catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                });
            }

        </script>
    </form>
</body>
</html>
