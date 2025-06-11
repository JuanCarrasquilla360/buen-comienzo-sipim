<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeguimientoNutricional.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.SeguimientoNutricional" %>

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
    <form id="SeguimientoNutricional" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Seguimiento Nutricional
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
                            <table id="grdSeguimientoNutricional" class="table table-bordered table-striped">
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
                this.tabla = $("#grdSeguimientoNutricional").DataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [{
                        'targets': 11,
                        'orderable': false,
                        'width': "18px"
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id Seguimiento Nutricional', 'Número Identificacion Participante', 'Nombre', 'Fecha', 'Tipo de atención', 'Peso', 'Talla', 'Perimetro braquial', 'Coordinador', "Usuario creación", "Fecha creación", '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarSeguimientoNutricional",
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
                                    $("#grdSeguimientoNutricional").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function Editar(idSeguimientoNutricional, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nuevo Seguimiento Nutricional' : 'Editar Seguimiento Nutricional',
                    'width': '900',
                    'url': './Popups/EditarSeguimientoNutricional.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {

                            if ($('#EditarSeguimientoNutricional', parent.document).isValid()) {

                                $('#Guardar', parent.document).prop('disabled', true);
                                var objSN = new Object();

                                if (nuevo == 'S') {
                                    var participante = datosParticipante.find(({ numeroIdentificacion }) => numeroIdentificacion === $('#ddlParticipante', parent.document).val());
                                    objSN.numeroIdentificacion = participante.numeroIdentificacion;
                                    objSN.idMatricula = participante.idMatricula;
                                    objSN.idCoordinador = participante.idCoordinador;
                                }
                                else {
                                    objSN.numeroIdentificacion = $('#ddlParticipante', parent.document).val();
                                    objSN.idMatricula = null;
                                    objSN.idCoordinador = null;
                                }

                                
                                objSN.nuevo = nuevo;
                                objSN.idSeguimientoNutricional = idSeguimientoNutricional;
                                objSN.fechaHora = $('#txtfecha', parent.document).val();
                                objSN.idTipoAtencion = $('#ddlTipoAtencion', parent.document).val();
                                objSN.idCicloVital = $('#ddlCicloVital', parent.document).val();
                                objSN.peso = $('#txtPeso', parent.document).val();
                                objSN.talla = $('#txtTalla', parent.document).val();
                                objSN.perimetroBraquial = $('#txtPerimetroBraquial', parent.document).val();
                                objSN.desviacionEstandar = $('#txtDesviacionEstandar', parent.document).val();
                                objSN.IMC = $('#txtIMC', parent.document).val();
                                objSN.dXNutricional = $('#ddlDXNutricional', parent.document).val();
                                objSN.dXEnfermedadBase = ($('#chkDXAsociadoEnfermedadBase', parent.document).is(':checked') ? '1' : '0');
                                objSN.enfermedades = $('#txtEnfermedades', parent.document).val();
                                objSN.signosFisicosCarenciales = $('#txtSignosFisicosCarenciales', parent.document).val();
                                objSN.idInseguridadAlimentaria = $('#ddlInseguridadAlimentaria', parent.document).val();
                                objSN.idAccesoServiciosPublicos = $('#ddlAccesoServiciosPublicos', parent.document).val();
                                objSN.idAccesoServiciosSalud = $('#ddlAccesoServiciosSalud', parent.document).val();
                                objSN.condicionesVivienda = $('#txtCondicionesVivienda', parent.document).val();
                                objSN.aspectosPsicosocialesVulneracionDerechos = $('#txtAspectosPsicosocialesVulneracionDerechos', parent.document).val();
                                objSN.idLactanciaMaterna = $('#ddlLactancia', parent.document).val();
                                objSN.accionesRealizadas = $('#txtAccionesRealizadas', parent.document).val();
                                
                                ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarSeguimientoNutricional', 'POST', objSN, function (resp) {
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
                }, function () { successPopup(idSeguimientoNutricional, nuevo); });

                $('input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran la validación
                parent.configFormValidate('EditarSeguimientoNutricional', 'date, security');
            }

            var picker;

            function successPopup(idSeguimientoNutricional, nuevo) {

                $('#chkDXAsociadoEnfermedadBase', parent.document).on('ifChanged', function (event) {
                    if (event.target.checked)
                        $('#txtEnfermedades', parent.document).prop("disabled", false).focus();
                    else
                        $('#txtEnfermedades', parent.document).val('').prop("disabled", true);
                });

                $('#txtPeso', parent.document).on('keypress', function (e) { keypressDecimal(e, 3, 1, '.'); });
                $('#txtTalla', parent.document).on('keypress', function (e) { keypressDecimal(e, 3, 1, '.'); });
                $('#txtPerimetroBraquial', parent.document).on('keypress', function (e) { keypressDecimal(e, 2, 1, '.'); });
                $('#txtIMC', parent.document).on('keypress', function (e) { keypressDecimal(e, 2, 2, '.'); });
                $('#txtDesviacionEstandar', parent.document).on('keypress', function (e) { keypressDecimal(e, 1, 2, '.'); });  

                if (nuevo == 'S') {

                    parent.loading(true);

                    error = false;

                    var refreshId = setInterval(function () {

                        if (($("#ddlParticipante option:selected", parent.document).text() != '' &&
                            $("#ddlTipoAtencion option:selected", parent.document).text() != '' &&
                            $("#ddlCicloVital option:selected", parent.document).text() != '' &&
                            $("#ddlLactancia option:selected", parent.document).text() != '' &&
                            $("#ddlInseguridadAlimentaria option:selected", parent.document).text() != '' &&
                            $("#ddlAccesoServiciosPublicos option:selected", parent.document).text() != '' &&
                            $("#ddlAccesoServiciosSalud option:selected", parent.document).text() != '') ||
                            error
                        ) {
                            clearInterval(refreshId);
                            parent.loading(false);
                        }
                    }, 10);

                    $('#dvIdSeguimientoNutricional', parent.document).hide();

                    cargarParticipantes();

                    parent.configSelect2WhitOnChangeControl('ddlParticipante', function (event) {
                        if (event.target.value != '')
                            cargarCicloVital(event.target.value);
                        else
                            $('#ddlCicloVital', parent.document).val('');
                    });

                    picker = parent.TempusDominusDateTimePicker('fecha', 'dd/MM/yyyy HH:mm', true, true, 15);

                    cargarGeneralidad('TIAC', $("#ddlTipoAtencion", parent.document));

                    $('#ddlCicloVital', parent.document).on('change', function () {
                        cargarGeneralidad('DXNU', $('#ddlDXNutricional', parent.document), null, $('#ddlCicloVital', parent.document).val());
                    });

                    cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document));
                    cargarGeneralidad('LACT', $('#ddlLactancia', parent.document));
                    cargarGeneralidad('SINO', $('#ddlInseguridadAlimentaria', parent.document));
                    cargarGeneralidad('SINO', $('#ddlAccesoServiciosPublicos', parent.document));
                    cargarGeneralidad('SINO', $('#ddlAccesoServiciosSalud', parent.document));
                }
                else {
                    $('#dvIdSeguimientoNutricional', parent.document).show();
                    $('#txtIdSeguimientoNutricional', parent.document).val(idSeguimientoNutricional);
                    parent.loading(true);
                    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerSeguimientoNutricional', 'POST', 'idSeguimientoNutricional', idSeguimientoNutricional, function (resp) {
                        try {

                            error = false;

                            var refreshId = setInterval(function () {

                                if (($("#ddlParticipante option:selected", parent.document).text() != '' &&
                                    $("#ddlTipoAtencion option:selected", parent.document).text() != '' &&
                                    $("#ddlCicloVital option:selected", parent.document).text() != '' &&
                                    $("#ddlLactancia option:selected", parent.document).text() != '' &&
                                    $("#ddlInseguridadAlimentaria option:selected", parent.document).text() != '' &&
                                    $("#ddlAccesoServiciosPublicos option:selected", parent.document).text() != '' &&
                                    $("#ddlAccesoServiciosSalud option:selected", parent.document).text() != '') ||
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
                                    $("#txtfecha", parent.document).prop("disabled", true).css("background-color", "#eee");

                                    $('#txtfecha', parent.document).prop("disabled", true);
                                    $('#ddlTipoAtencion', parent.document).prop("disabled", true);
                                    $('#ddlCicloVital', parent.document).prop("disabled", true);
                                    $('#txtPeso', parent.document).prop("disabled", true);
                                    $('#txtTalla', parent.document).prop("disabled", true);
                                    $('#txtPerimetroBraquial', parent.document).prop("disabled", true);
                                    $('#txtDesviacionEstandar', parent.document).prop("disabled", true);
                                    $('#txtIMC', parent.document).prop("disabled", true);
                                    $('#ddlDXNutricional', parent.document).prop("disabled", true);
                                    $('#chkDXAsociadoEnfermedadBase', parent.document).prop("disabled", true);
                                    $('#txtEnfermedades', parent.document).prop("disabled", true);
                                    $('#txtSignosFisicosCarenciales', parent.document).prop("disabled", true);
                                    $('#ddlInseguridadAlimentaria', parent.document).prop("disabled", true);
                                    $('#ddlAccesoServiciosPublicos', parent.document).prop("disabled", true);
                                    $('#ddlAccesoServiciosSalud', parent.document).prop("disabled", true);
                                    $('#txtCondicionesVivienda', parent.document).prop("disabled", true);
                                    $('#txtAspectosPsicosocialesVulneracionDerechos', parent.document).prop("disabled", true);
                                    $('#ddlLactancia', parent.document).prop("disabled", true);
                                    $('#txtAccionesRealizadas', parent.document).prop("disabled", true);
                                }

                                ejecutarMetodoAsync('../WebMethods.aspx/ObtenerCaracterizacion', 'POST', 'numeroIdentificacion', datos[0].numeroIdentificacion, function (resp) {
                                    try {
                                        datosJson = JSON.parse(resp.d);

                                        if (datosJson.resultado) {
                                            var datos2 = JSON.parse(datosJson.mensaje);

                                            $('#ddlParticipante', parent.document).append('<option value="' + datos[0].numeroIdentificacion + '" selected>' + datos[0].numeroIdentificacion + ' - ' + [datos2[0].primerNombre,
                                            datos2[0].segundoNombre,
                                            datos2[0].primerApellido,
                                            datos2[0].segundoApellido].filter(Boolean).join(' ') + '</option>');
                                        }
                                    }
                                    catch (e) {
                                        error = true;
                                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                    }
                                });

                                $('#ddlCicloVital', parent.document).on('change', function () {
                                    cargarGeneralidad('DXNU', $('#ddlDXNutricional', parent.document), datos[0].dXNutricional, $('#ddlCicloVital', parent.document).val());
                                });

                                cargarGeneralidad('TIAC', $("#ddlTipoAtencion", parent.document), datos[0].idTipoAtencion);
                                cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document), datos[0].idCicloVital);
                                cargarGeneralidad('LACT', $('#ddlLactancia', parent.document), datos[0].idLactanciaMaterna);
                                cargarGeneralidad('SINO', $('#ddlInseguridadAlimentaria', parent.document), datos[0].idInseguridadAlimentaria);
                                cargarGeneralidad('SINO', $('#ddlAccesoServiciosPublicos', parent.document), datos[0].idAccesoServiciosPublicos);
                                cargarGeneralidad('SINO', $('#ddlAccesoServiciosSalud', parent.document), datos[0].idAccesoServiciosSalud);

                                picker = parent.TempusDominusDateTimePicker('fecha', 'dd/MM/yyyy HH:mm', true, true, 15);

                                $('#txtfecha', parent.document).val(datos[0].fechaHora);

                                if (datos[0].dXEnfermedadBase == 'True')
                                    $('#chkDXAsociadoEnfermedadBase', parent.document).iCheck('check');
                                else
                                    $('#chkDXAsociadoEnfermedadBase', parent.document).iCheck('uncheck');
                                
                                $('#ddlTipoAtencion', parent.document).val(datos[0].idTipoAtencion);
                                $('#ddlCicloVital', parent.document).val(datos[0].idCicloVital);
                                $('#txtPeso', parent.document).val(datos[0].peso);
                                $('#txtTalla', parent.document).val(datos[0].talla);
                                $('#txtPerimetroBraquial', parent.document).val(datos[0].perimetroBraquial);
                                $('#txtDesviacionEstandar', parent.document).val(datos[0].desviacionEstandar);
                                $('#txtIMC', parent.document).val(datos[0].IMC);
                                $('#ddlDXNutricional', parent.document).val(datos[0].dXNutricional);
                                $('#txtEnfermedades', parent.document).val(datos[0].enfermedades);
                                $('#txtSignosFisicosCarenciales', parent.document).val(datos[0].signosFisicosCarenciales);
                                $('#ddlInseguridadAlimentaria', parent.document).val(datos[0].idInseguridadAlimentaria);
                                $('#ddlAccesoServiciosPublicos', parent.document).val(datos[0].idAccesoServiciosPublicos);
                                $('#ddlAccesoServiciosSalud', parent.document).val(datos[0].idAccesoServiciosSalud);
                                $('#txtCondicionesVivienda', parent.document).val(datos[0].condicionesVivienda);
                                $('#txtAspectosPsicosocialesVulneracionDerechos', parent.document).val(datos[0].aspectosPsicosocialesVulneracionDerechos);
                                $('#ddlLactancia', parent.document).val(datos[0].idLactanciaMaterna);
                                $('#txtAccionesRealizadas', parent.document).val(datos[0].accionesRealizadas);

                                if (fechaActual <= fecha) {
                                    if (datos[0].idCicloVital == 'TICV001' || datos[0].idCicloVital == 'TICV002') {
                                        $('#ddlLactancia', parent.document).prop('disabled', true);
                                        $('#txtIMC', parent.document).prop('disabled', false);
                                        $('#txtDesviacionEstandar', parent.document).prop('disabled', true);
                                    }
                                    else {
                                        $('#ddlLactancia', parent.document).prop('disabled', false);
                                        $('#txtIMC', parent.document).prop('disabled', true);
                                        $('#txtDesviacionEstandar', parent.document).prop('disabled', false);
                                    }
                                }

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

            function Eliminar(idSeguimientoNutricional, fechaHora) {

                var fecha = moment(fechaHora, 'DD/MM/YYYY HH:mm').endOf('month').add(5, 'days');
                var fechaActual = moment();

                if (fechaActual > fecha)
                    alerta('No es posible eliminar el Encuentro Educativo en el hogar con código ' + idSeguimientoNutricional + ' ya que está fuera de la fecha permitida.', 'Error');
                else {

                    confirmar('Está seguro que desea eliminar el Encuentro Educativo en el Hogar con código ' + idSeguimientoNutricional + '?', 'Advertencia', function () {

                        ejecutarMetodoAsync('../WebMethods.aspx/EliminarSeguimientoNutricional', 'POST', 'idSeguimientoNutricional', idSeguimientoNutricional, function (resp) {
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
            function cargarGeneralidad(tipoGeneralidad, control, value, filtro) {

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

                                if (filtro != null) {
                                    if ((filtro == 'TICV001' || filtro == 'TICV002') &&
                                        (value.IdGeneralidad == 'DXNU008' || value.IdGeneralidad == 'DXNU009' || value.IdGeneralidad == 'DXNU010' || value.IdGeneralidad == 'DXNU011')) {

                                        $(control).append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
                                    }
                                    else if ((filtro != 'TICV001' && filtro != 'TICV002') && (value.IdGeneralidad != 'DXNU008' && value.IdGeneralidad != 'DXNU009' && value.IdGeneralidad != 'DXNU010' && value.IdGeneralidad != 'DXNU011')) {
                                        $(control).append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
                                    }
                                }
                                else
                                    $(control).append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
                            });

                            if (value != null)
                                $(control).val(value);

                            if (tipoGeneralidad == 'TICV' && value != null) {
                                $(control).trigger('change');
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

                            $('#EditarSeguimientoNutricional', parent.document).find('.error,.valid').each(function () {
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

            // con este cargamos los cronogramas que tenemos en el sistema
            function cargarCicloVital(numeroDocumento) {

                var data = new Object();
                data.numeroDocumento = numeroDocumento;

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ObtenerCicloVitalParticipante',                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(data),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            $('#ddlCicloVital', parent.document).val(data.mensaje);
                            $('#ddlCicloVital', parent.document).trigger('change');

                            if (data.mensaje == 'TICV001' || data.mensaje == 'TICV002') {
                                $('#ddlLactancia', parent.document).val('').prop('disabled', true);
                                $('#txtIMC', parent.document).val('').prop('disabled', false);
                                $('#txtDesviacionEstandar', parent.document).val('').prop('disabled', true);
                            }
                            else {
                                $('#ddlLactancia', parent.document).prop('disabled', false);
                                $('#txtIMC', parent.document).val('').prop('disabled', true);
                                $('#txtDesviacionEstandar', parent.document).val('').prop('disabled', false);
                            }
                        }
                        else
                            $('#ddlCicloVital', parent.document).val('');
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

