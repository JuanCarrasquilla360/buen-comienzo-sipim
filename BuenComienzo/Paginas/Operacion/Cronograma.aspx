<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cronograma.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Cronograma" %>

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
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <!-- select2 -->
    <link rel="stylesheet" href="../../plugins/select2/select2.min.css" />
    <!-- tempus-dominus -->
    <link href="../../plugins/bootstrap-datetimepicker/css/tempus-dominus.min.css" rel="stylesheet" />

    <script src="../../plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <script type="text/javascript">
        $('#framePrincipal', parent.document).css('height', '0px');
    </script>
</head>
<body>
    <div id="loading" style="display: block;display: flex;text-align: center;position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="Cronograma" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Cronograma
                    <%--<small>Control panel</small>--%>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../../Index.aspx"><i class="fa fa-home"></i>Inicio</a></li>
                    <%--<li class="active">Cargue masivo</li>--%>
                </ol>
            </section>

            <!-- Main content -->
            <section class="content">
                <!-- Small boxes (Stat box) -->
                <div class="row">
                    <div class="box">
                        <div class="" style="padding-left: 10px; padding-top: 10px">
                            <input id="btnNuevo" type="button" class="btn btn-cincopasitos" value="Nuevo" />
                        </div>
                        <div class="col-md-12 col-xs-12">
                        </div>
                        <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="grdCronograma" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
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
        <!-- icheck -->
        <script src="../../plugins/select2/select2.full.min.js"></script>
        <!-- moment -->
        <script src="../../plugins/moment/moment.min.js"></script>
        <!-- popper -->
        <script src="../../plugins/bootstrap-datetimepicker/popper.min.js"></script>
        <!-- tempus-dominus -->
        <script src="../../plugins/bootstrap-datetimepicker/tempus-dominus.min.js"></script>

        <!-- Script -->
        <script type="text/javascript">

            var tabla;
            var error = false;
            var validate;

            $(window).load(function () {
                setTimeout(function () { $('#loading').fadeOut(300, "linear"); cargarDatos(); }, 300);
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
                $.validate({
                    modules: 'date, security',
                    lang: 'es'
                });

                $('#btnNuevo').click(function () {
                    Editar('', 'S');
                });

            });

            function cargarDatos() {
                this.tabla = $("#grdCronograma").DataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [{
                        'targets': 11,
                        'orderable': false
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id programación actividades', 'Coordinador', 'Sede', 'Tipo encuentro', 'Ubas', 'Fecha hora', 'Agente educativo 1', 'Agente educativo 2', 'Motivo reprogramación', "Usuario creación", "Fecha creación", '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarCronograma",
                    "drawCallback": function (settings) {
                        $('#framePrincipal', parent.document).css('height', document.body.scrollHeight + 'px');

                        $('input[type="checkbox"].flat-red').iCheck({
                            checkboxClass: 'icheckbox_flat-red'
                        });

                        $('input[type="checkbox"].flat-red').parent().parent().parent().css('text-align', 'center');
                        $('input[type="checkbox"].flat-red').attr('disabled', 'disabled');
                    },
                    "fnServerData": function (sSource, aoData, fnCallback) {
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
                                    $("#grdCronograma").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function Editar(idProgramacionActividades, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nuevo cronograma' : 'Editar cronograma',
                    'width': '900',
                    'url': './Popups/EditarCronograma.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {

                            if ($('#EditarCronograma', parent.document).isValid()) {

                                $('#Guardar', parent.document).prop('disabled', true);

                                if ($('#ddlAgenteEducativo1', parent.document).val() != $('#ddlAgenteEducativo2', parent.document).val()) {

                                    var objCronograma = new Object();
                                    objCronograma.nuevo = nuevo;
                                    objCronograma.idProgramacionActividades = idProgramacionActividades;
                                    objCronograma.idCoordinador = $('#ddlCoordinador', parent.document).val();
                                    objCronograma.idSede = $('#ddlSedes', parent.document).val();
                                    objCronograma.idUbas = $('#ddlUbas', parent.document).val().toString().replaceAll(',', '|');
                                    objCronograma.idTipoEncuentro = $('#ddlTipoEncuentro', parent.document).val();
                                    objCronograma.fecha = $('#txtfechaEncuentro', parent.document).val();
                                    objCronograma.idAgenteEducativo1 = $('#ddlAgenteEducativo1', parent.document).val();
                                    objCronograma.idAgenteEducativo2 = $('#ddlAgenteEducativo2', parent.document).val();
                                    objCronograma.puntoReferencia = $('#txtPuntoReferencia', parent.document).val();
                                    objCronograma.motivoReprogramacion = $('#ddlMotivoReprogramacion', parent.document).val();
                                    objCronograma.observacionesReprogramacion = $('#txtObservacionesReprogramacion', parent.document).val();

                                    console.log(objCronograma);

                                    ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarCronograma', 'POST', objCronograma, function (resp) {
                                        try {

                                            datosJson = JSON.parse(resp.d);
                                            alerta(datosJson.mensaje, datosJson.tipoMensaje);

                                            if (datosJson.resultado) {
                                                CloseModalBox();
                                                tabla.ajax.reload();
                                            }
                                        }
                                        catch (e) {
                                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                        }
                                    });
                                }
                                else
                                    alerta('El agente educativo 1 no puede ser igual al agente educativo 2. por favor verificar ', 'Error');
                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox();
                        }
                    }]
                }, function () { successPopup(idProgramacionActividades, nuevo); });

                //Se configuran la validación
                validate = parent.configFormValidate('EditarCronograma', 'date, security');
            }

            var picker;

            function successPopup(idProgramacionActividades, nuevo) {
                if (nuevo == 'S') {
                    cargarCoordinadores();
                    //Se configuran las listas con buscador
                    parent.configSelect2Control('ddlUbas');

                    parent.configSelect2Control("ddlCoordinador").on('change', function () {
                        if (parent.configSelect2Control("ddlUbas").val() != '')
                            parent.valSelect2('ddlUbas', '');


                        $(window.parent.document).find("#ddlAgenteEducativo1").val('');
                        $(window.parent.document).find("#ddlAgenteEducativo2").val('');
                        $(window.parent.document).find("#ddlSedes").val('');
                        cargarSedes();
                        cargarUbas();
                        cargarCoordinadorAgentes();
                    });

                    picker = parent.TempusDominusDateTimePicker('fechaEncuentro', 'dd/MM/yyyy HH:mm', true, true, 15);

                    cargarGeneralidad('TIEN', $(window.parent.document).find("#ddlTipoEncuentro"));
                    cargarGeneralidad('MORE', $(window.parent.document).find("#ddlMotivoReprogramacion"));
                }
                else {
                    parent.loading(true);
                    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerCronograma', 'POST', 'idProgramacionActividades', idProgramacionActividades, function (resp) {
                        try {

                            error = false;

                            var refreshId = setInterval(function () {

                                if (($("#ddlCoordinador option:selected", parent.document).text() != '' &&
                                    $("#ddlSedes option:selected", parent.document).text() != '' &&
                                    $("#ddlUbas option:selected", parent.document).text() != '' &&
                                    $("#ddlAgenteEducativo1 option:selected", parent.document).text() != '' &&
                                    $("#ddlTipoEncuentro option:selected", parent.document).text() != '' &&
                                    $("#ddlMotivoReprogramacion option:selected", parent.document).text() != '') ||
                                    error
                                ) {
                                    clearInterval(refreshId);
                                    parent.loading(false);
                                }
                            }, 10);

                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                var datos = JSON.parse(datosJson.mensaje);
                                parent.configSelect2Control('ddlUbas');
                                cargarCoordinadores(datos[0].idCoordinador, datos[0].idSede, datos[0].idUbas, datos[0].idAgenteEducativo1, datos[0].idAgenteEducativo2);
                                $(window.parent.document).find('#txtfechaEncuentro').val(datos[0].fechaHora);
                                $(window.parent.document).find('#txtPuntoReferencia').val(datos[0].puntoReferencia);
                                $(window.parent.document).find('#txtObservacionesReprogramacion').val(datos[0].observacionesReprogramacion);

                                cargarGeneralidad('TIEN', $(window.parent.document).find("#ddlTipoEncuentro"), datos[0].idTipoEncuentro);
                                cargarGeneralidad('MORE', $(window.parent.document).find("#ddlMotivoReprogramacion"), datos[0].idMotivoReprogramacion);
                                
                                $(window.parent.document).find("#ddlCoordinador").prop("disabled", true);
                                $(window.parent.document).find("#ddlSedes").prop("disabled", true);
                                $(window.parent.document).find("#ddlUbas").prop("disabled", true);
                                $(window.parent.document).find("#ddlTipoEncuentro").prop("disabled", true);
                                $(window.parent.document).find("#ddlAgenteEducativo1").prop("disabled", true);
                                $(window.parent.document).find("#ddlAgenteEducativo2").prop("disabled", true);
                                $(window.parent.document).find("#txtPuntoReferencia").prop("disabled", true);
                                $(window.parent.document).find("#txtfechaEncuentro").prop("disabled", true);
                                $(window.parent.document).find("#dvReprogramar").show();
                                $(window.parent.document).find("#txtfechaEncuentro").css("background-color", "#eee");
                            }
                            else {
                                alerta(datosJson.mensaje, datosJson.tipoMensaje);
                                CloseModalBox();
                            }

                        }
                        catch (e) {
                            error = true;
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                }
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarGeneralidad(tipoGeneralidad, control, value) {

                var jsonInput = "{ idTipoGeneralidad: '" + tipoGeneralidad + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarGeneralidades',                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $(control).empty();
                            $(control).append('<option value="' + '' + '">Seleccione una opción</option>');

                            $.each(informacion, function (index, value) {
                                $(control).append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
                            });

                            if (value != null)
                                $(control).val(value);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarCoordinadores(idCoordinador, idsede, idUbas, idAgente1, idAgente2) {

                var jsonInput = "{ esTraslado: '" + 'N' + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarCoordinadoresAgente',                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        $(window.parent.document).find('#ddlCoordinador').empty();
                        $(window.parent.document).find('#ddlCoordinador').append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlCoordinador').append('<option value="' + value.idCoordinador + '">' + value.nombre + '</option>');
                            });

                            if (idCoordinador != null) {
                                $(window.parent.document).find('#ddlCoordinador').val(idCoordinador);
                                cargarSedes(idsede);
                                cargarUbas(idUbas);
                                cargarCoordinadorAgentes(idAgente1, idAgente2);
                            }
                            else {
                                parent.valSelect2('ddlCoordinador', '');

                                $('#EditarCronograma', parent.document).find('.error,.valid').each(function () {
                                    $(this)
                                        .removeClass('valid')
                                        .removeClass('.error')
                                        .css('border-color', '').parent().removeClass('has-error').find('.form-error').hide();
                                });
                            }
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarSedes(idSede) {

                var jsonInput = "{ idCoordinador: '" + $(window.parent.document).find('#ddlCoordinador').val() + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: ((idSede != null) ? 'GET' : 'POST'),                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/' + ((idSede != null)  ? 'ObtenerSedes' : 'ConsultarCoordinadorSedes'),                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        $(window.parent.document).find('#ddlSedes').empty();
                        $(window.parent.document).find('#ddlSedes').append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlSedes').append('<option value="' + value.idSede + '">' + value.nombreSede + '</option>');
                            });

                            if (idSede != null)
                                $(window.parent.document).find('#ddlSedes').val(idSede);
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarUbas(idUbas) {

                var jsonInput = "{ idCoordinador: '" + $(window.parent.document).find('#ddlCoordinador').val() + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: ((idUbas != null) ? 'GET' : 'POST'),                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/' + ((idUbas != null) ? 'ObtenerUbas' : 'ConsultarCoordinadorUbas'),                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        $(window.parent.document).find('#ddlUbas').empty();

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlUbas').append('<option value="' + value.idUba + '">' + value.uba + '</option>');
                            });

                            if (idUbas != null)
                                parent.valSelect2('ddlUbas', idUbas.split('|'));
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarCoordinadorAgentes(idAgente1, idAgente2) {

                var jsonInput = "{ idCoordinador: '" + $(window.parent.document).find('#ddlCoordinador').val() + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: ((idAgente1 != null) ? 'GET' : 'POST'),                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/' + ((idAgente1 != null) ? 'ConsultarAgentes' : 'ConsultarCoordinadorAgentes'),                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        $(window.parent.document).find('#ddlAgenteEducativo1').empty();
                        $(window.parent.document).find('#ddlAgenteEducativo1').append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        $(window.parent.document).find('#ddlAgenteEducativo2').empty();
                        $(window.parent.document).find('#ddlAgenteEducativo2').append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlAgenteEducativo1').append('<option value="' + value.idAgente + '">' + value.nombre + '</option>');
                                $(window.parent.document).find('#ddlAgenteEducativo2').append('<option value="' + value.idAgente + '">' + value.nombre + '</option>');
                            });

                            if (idAgente1 != null) {
                                $(window.parent.document).find('#ddlAgenteEducativo1').val(idAgente1);
                                $(window.parent.document).find('#ddlAgenteEducativo2').val(idAgente2);
                            }
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

        </script>
    </form>
</body>
</html>

