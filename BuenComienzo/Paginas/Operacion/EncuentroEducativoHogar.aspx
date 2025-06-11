<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EncuentroEducativoHogar.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.EncuentroEducativoHogar" %>

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
    <div id="loading" style="display: block; display: flex; text-align: center; position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="EncuentroEducativoHogar" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Encuentro educativo en el hogar
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
                            <table id="grdEncuentroEducativoHogar" class="table table-bordered table-striped">
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
            var datosParticipante;

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
                this.tabla = $("#grdEncuentroEducativoHogar").DataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [{
                        'targets': 10,
                        'orderable': false,
                        'width': "18px"
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id EEH', 'Número Identificacion Participante', 'Nombre', 'Fecha', 'Número EEH', 'Motivo EEH', 'EEH Efectivo?', 'Coordinador', "Usuario creación", "Fecha creación", '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarEncuentroEducativoHogar",
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
                                    $("#grdEncuentroEducativoHogar").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function Editar(idEncuentroEducativoHogar, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nuevo Encuentro Educativo en el Hogar' : 'Editar Encuentro Educativo en el Hogar',
                    'width': '900',
                    'url': './Popups/EditarEncuentroEducativoHogar.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {

                            if ($('#EditarEncuentroEducativoHogar', parent.document).isValid()) {

                                $('#Guardar', parent.document).prop('disabled', true);

                                var participante = datosParticipante.find(({ numeroIdentificacion }) => numeroIdentificacion === $('#ddlParticipante', parent.document).val());

                                var objEEH = new Object();
                                objEEH.nuevo = nuevo;
                                objEEH.idEncuentroEducativoHogar = idEncuentroEducativoHogar;
                                objEEH.numeroIdentificacion = participante.numeroIdentificacion;
                                objEEH.fechaHora = $('#txtfechaEEH', parent.document).val();
                                objEEH.idTipoEEH = $('#ddlTipoEEH', parent.document).val();
                                objEEH.EEHNumero = $('#txtNumeroEEH', parent.document).val();
                                objEEH.idMotivoEEH = $('#ddlMotivoEEH', parent.document).val();
                                objEEH.EEHEfectivo = ($('#chkEEHEfectivo', parent.document).is(':checked') ? '1' : '0');
                                objEEH.idMotivoNoEfectivo = $('#ddlMotivoNoEfectivo', parent.document).val();
                                objEEH.observaciones = $('#txtObservaciones', parent.document).val();
                                objEEH.idMatricula = participante.idMatricula;
                                objEEH.idCoordinador = participante.idCoordinador;

                                ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarEncuentroEducativoHogar', 'POST', objEEH, function (resp) {
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
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox();
                        }
                    }]
                }, function () { successPopup(idEncuentroEducativoHogar, nuevo); });

                $('input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran la validación
                parent.configFormValidate('EditarEncuentroEducativoHogar', 'date, security');
            }

            var picker;

            function successPopup(idEncuentroEducativoHogar, nuevo) {

                $('#chkEEHEfectivo', parent.document).on('ifChanged', function (event) {
                    if (event.target.checked)
                        $('#ddlMotivoNoEfectivo', parent.document).val('').prop("disabled", true);
                    else
                        $('#ddlMotivoNoEfectivo', parent.document).prop("disabled", false);
                });

                if (nuevo == 'S') {

                    parent.loading(true);

                    error = false;

                    var refreshId = setInterval(function () {

                        if (($("#ddlParticipante option:selected", parent.document).text() != '' &&
                            $("#ddlMotivoNoEfectivo option:selected", parent.document).text() != '' &&
                            $("#ddlMotivoEEH option:selected", parent.document).text() != '') ||
                            error
                        ) {
                            clearInterval(refreshId);
                            parent.loading(false);
                        }
                    }, 10);

                    $('#dvIdEncuentroEducativoHogar', parent.document).hide();

                    cargarParticipantes();

                    //Se detecta cuando cambie, para tomar los datos del participante
                    parent.configSelect2Control('ddlParticipante').on('change', function () {

                        if ($('#ddlParticipante', parent.document).val() != '') {
                            var participante = datosParticipante.find(({ numeroIdentificacion }) => numeroIdentificacion === $('#ddlParticipante', parent.document).val());
                            $('#txtNumeroEEH', parent.document).val(participante.EEHNumero);
                        }
                        else
                            $('#txtNumeroEEH', parent.document).val('');
                    });

                    picker = parent.TempusDominusDateTimePicker('fechaEEH', 'dd/MM/yyyy HH:mm', true, true, 15);


                    cargarGeneralidad('MOEH', $("#ddlMotivoEEH", parent.document));
                    cargarGeneralidad('MONE', $("#ddlMotivoNoEfectivo", parent.document));
                    cargarGeneralidad('TIEH', $("#ddlTipoEEH", parent.document));
                    
                }
                else {
                    $('#dvIdEncuentroEducativoHogar', parent.document).show();
                    $('#txtIdEncuentroEducativoHogar', parent.document).val(idEncuentroEducativoHogar);
                    parent.loading(true);
                    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerEncuentroEducativoHogar', 'POST', 'idEncuentroEducativoHogar', idEncuentroEducativoHogar, function (resp) {
                        try {

                            error = false;

                            var refreshId = setInterval(function () {

                                if (($("#ddlParticipante option:selected", parent.document).text() != '' &&
                                    $("#ddlMotivoEEH option:selected", parent.document).text() != '' &&
                                    $("#ddlMotivoNoEfectivo option:selected", parent.document).text() != '') ||
                                    error
                                ) {
                                    clearInterval(refreshId);
                                    parent.loading(false);
                                }
                            }, 10);

                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                var datos = JSON.parse(datosJson.mensaje);


                                var fecha = moment(datos[0].fechaHora, 'DD/MM/YYYY HH:mm').endOf('month').add(5, 'days');
                                var fechaActual = moment();

                                if (fechaActual > fecha) {
                                    $('#Guardar', parent.document).hide();
                                    $("#txtfechaEEH", parent.document).prop("disabled", true).css("background-color", "#eee");
                                    $("#ddlTipoEEH", parent.document).prop("disabled", true);
                                    $("#ddlMotivoEEH", parent.document).prop("disabled", true);
                                    $("#chkEEHEfectivo", parent.document).prop("disabled", true);
                                    $("#ddlMotivoNoEfectivo", parent.document).prop("disabled", true);
                                    $("#txtObservaciones", parent.document).prop("disabled", true);
                                }

                                cargarParticipantes(datos[0].numeroIdentificacion);
                                cargarGeneralidad('MOEH', $("#ddlMotivoEEH", parent.document), datos[0].idMotivoEEH);
                                cargarGeneralidad('MONE', $("#ddlMotivoNoEfectivo", parent.document), datos[0].idMotivoNoEfectivo);
                                cargarGeneralidad('TIEH', $("#ddlTipoEEH", parent.document), datos[0].idTipoEEH);

                                picker = parent.TempusDominusDateTimePicker('fechaEEH', 'dd/MM/yyyy HH:mm', true, true, 15);

                                parent.configSelect2Control('ddlParticipante');
                                $('#txtfechaEEH', parent.document).val(datos[0].fechaHora);
                                $('#txtNumeroEEH', parent.document).val(datos[0].EEHNumero);

                                if (datos[0].EEHEfectivo == 'True')
                                    $('#chkEEHEfectivo', parent.document).iCheck('check');
                                else
                                    $('#chkEEHEfectivo', parent.document).iCheck('uncheck');

                                $('#txtObservaciones', parent.document).val(datos[0].observaciones);


                                $("#ddlParticipante", parent.document).prop("disabled", true);
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

            function Eliminar(idEncuentroEducativoHogar, fechaHora) {

                var fecha = moment(fechaHora, 'DD/MM/YYYY HH:mm').endOf('month').add(5, 'days');
                var fechaActual = moment();

                if (fechaActual > fecha)
                    alerta('No es posible eliminar el Encuentro Educativo en el hogar con código ' + idEncuentroEducativoHogar + ' ya que está fuera de la fecha permitida.', 'Error');
                else {

                    confirmar('Está seguro que desea eliminar el Encuentro Educativo en el Hogar con código ' + idEncuentroEducativoHogar + '?', 'Advertencia', function () {

                        ejecutarMetodoAsync('../WebMethods.aspx/EliminarEncuentroEducativoHogar', 'POST', 'idEncuentroEducativoHogar', idEncuentroEducativoHogar, function (resp) {
                            try {

                                datosJson = JSON.parse(resp.d);
                                setTimeout(function () { alerta(datosJson.mensaje, datosJson.tipoMensaje) }, 100);

                                if (datosJson.resultado)
                                    tabla.ajax.reload();
                            }
                            catch (e) {
                                alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                            }
                        });
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
            function cargarParticipantes(idParticipante) {

                $.ajax({
                    type: "GET",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ObtenerParticipantesCoordinador',                 // URL al que vamos a hacer el pedido
                    data: null,                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        datosParticipante = [];

                        $('#ddlParticipante', parent.document).empty();
                        $('#ddlParticipante', parent.document).append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $('#ddlParticipante', parent.document).append('<option value="' + value.numeroIdentificacion + '">' + value.nombre + '</option>');

                                var objParticipante = new Object();
                                objParticipante.numeroIdentificacion = value.numeroIdentificacion;
                                objParticipante.nombre = value.nombre;
                                objParticipante.idMatricula = value.idMatricula;
                                objParticipante.idCoordinador = value.idCoordinador;
                                objParticipante.EEHNumero = value.EEHNumero;

                                datosParticipante.push(objParticipante);
                            });

                            if (idParticipante != null) {
                                parent.valSelect2('ddlParticipante', idParticipante);
                            }
                            else
                                parent.valSelect2('ddlParticipante', '');

                            $('#EditarEncuentroEducativoHogar', parent.document).find('.error,.valid').each(function () {
                                $(this)
                                    .removeClass('valid')
                                    .removeClass('.error')
                                    .css('border-color', '').parent().removeClass('has-error').find('.form-error').hide();
                            });
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
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarCoordinadorSedes',                 // URL al que vamos a hacer el pedido
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
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarCoordinadorUbas',                 // URL al que vamos a hacer el pedido
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
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarCoordinadorAgentes',                 // URL al que vamos a hacer el pedido
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

