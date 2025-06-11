<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeguimientoDeficitNutricional.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.SeguimientoDeficitNutricional" %>

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
    <form id="SeguimientoDeficitNutricional" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Seguimiento Déficit Nutricional
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
                            <table id="grdSeguimientoDeficitNutricional" class="table table-bordered table-striped">
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
        <!-- bootstrap-filestyle -->
        <script src="../../plugins/filestyle/bootstrap-filestyle.js?v1.0"></script>
        <!-- inputmask -->
        <script src="../../plugins/input-mask/jquery.inputmask.js"></script>
        <script src="../../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
        <script src="../../plugins/input-mask/jquery.inputmask.extensions.js"></script>

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
                this.tabla = $("#grdSeguimientoDeficitNutricional").DataTable({
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
                    'aoColumns': columnasJSON(['Id Seguimiento Déficit Nutricional', 'Número Identificación Participante', 'Nombre', 'Fecha', 'Medio realización del Seguimiento', 'Peso', 'Talla', 'DX Nutricional', 'Coordinador', "Usuario creación", "Fecha creación", '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarSeguimientoDeficitNutricional",
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
                                    $("#grdSeguimientoDeficitNutricional").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function Editar(idSeguimientoDeficitNutricional, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nuevo Seguimiento Déficit Nutricional' : 'Editar Seguimiento Déficit Nutricional',
                    'width': '900',
                    'url': './Popups/EditarSeguimientoDeficitNutricional.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {

                            if ($('#EditarSeguimientoDeficitNutricional', parent.document).isValid()) {

                                $('#Guardar', parent.document).prop('disabled', true);
                                var objSDN = new Object();

                                if (nuevo == 'S') {
                                    var participante = datosParticipante.find(({ numeroIdentificacion }) => numeroIdentificacion === $('#ddlParticipante', parent.document).val());
                                    objSDN.numeroIdentificacion = participante.numeroIdentificacion;
                                    objSDN.idMatricula = participante.idMatricula;
                                    objSDN.idCoordinador = participante.idCoordinador;
                                }
                                else {
                                    objSDN.numeroIdentificacion = $('#ddlParticipante', parent.document).val();
                                    objSDN.idMatricula = null;
                                    objSDN.idCoordinador = null;
                                }

                                var form_data = new FormData();
                                form_data.append('file', $('#flArchivo', parent.document).get(0).files[0]);
                                form_data.append('TipoArchivo', 'SeguimientoDeficitNutricional');
                                
                                $.ajax({
                                    url: './loadFile.aspx',  //Server script to process data
                                    type: 'POST',
                                    async: false,
                                    success: function (result, status, response) {

                                        objSDN.nuevo = nuevo;
                                        objSDN.idSeguimientoDeficitNutricional = idSeguimientoDeficitNutricional;
                                        objSDN.fechaHora = $('#txtfecha', parent.document).val();
                                        objSDN.idTipoAtencion = $('#ddlTipoAtencion', parent.document).val();
                                        objSDN.idCicloVital = $('#ddlCicloVital', parent.document).val();
                                        objSDN.peso = $('#txtPeso', parent.document).val();
                                        objSDN.talla = $('#txtTalla', parent.document).val();
                                        objSDN.perimetroBraquial = $('#txtPerimetroBraquial', parent.document).val();
                                        objSDN.perimetroCefalico = $('#txtPerimetroCefalico', parent.document).val();
                                        objSDN.semanasGestacion = $('#txtSemanasGestacion', parent.document).val();
                                        objSDN.dXNutricional = $('#ddlDXNutricional', parent.document).val();
                                        objSDN.tallaEdad = $('#ddlTallaEdad', parent.document).val();
                                        objSDN.cuantosSeguimientosRealizado = $('#ddlCuantosSeguimientosRealizado', parent.document).val();
                                        objSDN.remisionFisica = $('#ddlRemisionFisica', parent.document).val();
                                        objSDN.remisionEfectivaAtencionSalud = $('#ddlRemisionEfectivaAtencionSalud', parent.document).val();
                                        objSDN.describaAtencionesRecibidas = $('#txtDescribaAtencionesRecibidas', parent.document).val().trim();
                                        objSDN.notificaNutrirParaSanar = $('#ddlNotificaNutrirParaSanar', parent.document).val();
                                        objSDN.accionesImplementadas = $('#txtAccionesImplementadas', parent.document).val().trim();
                                        objSDN.huboHospitalizacion = $('#ddlHuboHospitalizacion', parent.document).val();
                                        objSDN.recibeComplementacionEntidadSalud = $('#ddlRecibeComplementacionEntidadSalud', parent.document).val();
                                        objSDN.queComplementacionRecibe = $('#ddlQueComplementacionRecibe', parent.document).val();
                                        objSDN.cualOtraComplementacion = $('#txtCualOtraComplementacion', parent.document).val().trim();
                                        objSDN.diligenciamientoSivigila = $('#ddlDiligenciamientoSivigila', parent.document).val();
                                        objSDN.recibeRacionAlimentaria365 = $('#ddlRecibeRacionAlimentaria365', parent.document).val();
                                        objSDN.recibeRacionNutrirParaSanar = $('#ddlRecibeRacionNutrirParaSanar', parent.document).val();
                                        objSDN.queTipoRacionNutrirParaSanarRecibe = $('#ddlQueTipoRacionNutrirParaSanarRecibe', parent.document).val();
                                        objSDN.clasificacionELCSA = $('#ddlClasificacionELCSA', parent.document).val();
                                        objSDN.cambioSuEstadoNutricional = $('#ddlCambioSuEstadoNutricional', parent.document).val();
                                        objSDN.nuevoDiagnostico = $('#ddlNuevoDiagnostico', parent.document).val();
                                        objSDN.aspectosAlimentarios = $('#txtAspectosAlimentarios', parent.document).val().trim();
                                        objSDN.aspectosBioquimicos = $('#txtAspectosBioquimicos', parent.document).val().trim();
                                        objSDN.aspectosClinicos = $('#txtAspectosClinicos', parent.document).val().trim();
                                        objSDN.aspectosEconomicos = $('#txtAspectosEconomicos', parent.document).val().trim();
                                        objSDN.aspectosFamiliares = $('#txtAspectosFamiliares', parent.document).val().trim();
                                        objSDN.aspectosPsicosociales = $('#txtAspectosPsicosociales', parent.document).val().trim();
                                        objSDN.devolucionFamiliaAspectosAbordadosNutricional = $('#txtDevolucionFamiliaAspectosAbordadosNutricional', parent.document).val().trim();
                                        objSDN.socializacionSeguimientoEquipo = $('#ddlSocializacionSeguimientoEquipo', parent.document).val();
                                        objSDN.activacionRutaVulneracionDerechos = $('#ddlActivacionRutaVulneracionDerechos', parent.document).val();
                                        objSDN.especificarCualVulneracion = $('#txtEspecificarCualVulneracion', parent.document).val().trim();
                                        objSDN.describaAccionesRealizadas = $('#txtDescribaAccionesRealizadas', parent.document).val().trim();
                                        objSDN.observacionesGenerales = $('#txtObservacionesGenerales', parent.document).val().trim();
                                        objSDN.compromisoEstablecidoConFamilia = $('#txtCompromisoEstablecidoConFamilia', parent.document).val().trim();
                                        objSDN.nombreArchivoGuid = response.statusText;
                                        objSDN.fileName = $('#flArchivo', parent.document).get(0).files[0].name;
                                        objSDN.casoCerrado = ($('#chkCasoCerrado', parent.document).is(':checked') ? '1' : '0');

                                        ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarSeguimientoDeficitNutricional', 'POST', objSDN, function (resp) {
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
                                    },                                
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        alerta("Error- Status: " + textStatus + " jqXHR Status: " + jqXHR.status + " jqXHR Response Text:" + jqXHR.responseText, 'Error');
                                    },
                                    // Form data
                                    data: form_data,
                                    //Options to tell jQuery not to process data or worry about content-type.
                                    cache: false,
                                    contentType: false,
                                    processData: false
                                });

                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox();
                        }
                    }]
                }, function () { successPopup(idSeguimientoDeficitNutricional, nuevo); });

                $('input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });
                
                //Se configuran la validación
                parent.configFormValidate('EditarSeguimientoDeficitNutricional', 'date, security');
            }

            var picker;

            function successPopup(idSeguimientoDeficitNutricional, nuevo) {
                
                $('#txtPeso', parent.document).on('keypress', function (e) { keypressDecimal(e, 3, 1, '.'); });
                $('#txtTalla', parent.document).on('keypress', function (e) { keypressDecimal(e, 3, 1, '.'); });
                $('#txtPerimetroBraquial', parent.document).on('keypress', function (e) { keypressDecimal(e, 2, 1, '.'); });
                $('#txtPerimetroCefalico', parent.document).on('keypress', function (e) { keypressDecimal(e, 2, 1, '.'); });

                $('#ddlCicloVital', parent.document).on('change', function (e) {
                    if ($('#ddlCicloVital', parent.document).val() == 'TICV001')
                        $("#txtSemanasGestacion", parent.document).prop("disabled", false);
                    else
                        $("#txtSemanasGestacion", parent.document).val('').prop("disabled", true);
                });

                $('#ddlCicloVital', parent.document).on('change', function (e) {
                    if ($('#ddlCicloVital', parent.document).val() == 'TICV003' || $('#ddlCicloVital', parent.document).val() == 'TICV004' || $('#ddlCicloVital', parent.document).val() == 'TICV005') {
                        $("#ddlTallaEdad", parent.document).prop("disabled", false);
                        $("#txtPerimetroBraquial", parent.document).prop("disabled", false);
                        $("#txtPerimetroCefalico", parent.document).prop("disabled", false);
                    }
                    else {
                        $("#ddlTallaEdad", parent.document).val('').prop("disabled", true);
                        $("#txtPerimetroBraquial", parent.document).val('').prop("disabled", true);
                        $("#txtPerimetroCefalico", parent.document).val('').prop("disabled", true);
                    }
                });

                $('#ddlRemisionFisica', parent.document).on('change', function (e) {
                    if ($('#ddlRemisionFisica', parent.document).val() == 'SINO001')
                        $("#ddlRemisionEfectivaAtencionSalud", parent.document).prop("disabled", false);
                    else
                        $("#ddlRemisionEfectivaAtencionSalud", parent.document).val('').prop("disabled", true);
                        $("#txtDescribaAtencionesRecibidas", parent.document).val('').prop("disabled", true);
                });


                $('#ddlRemisionEfectivaAtencionSalud', parent.document).on('change', function (e) {
                    if ($('#ddlRemisionEfectivaAtencionSalud', parent.document).val() == 'SINO001')
                        $("#txtDescribaAtencionesRecibidas", parent.document).prop("disabled", false);
                    else
                        $("#txtDescribaAtencionesRecibidas", parent.document).val('').prop("disabled", true);
                });

                $('#ddlRemisionEfectivaAtencionSalud', parent.document).on('change', function (e) {
                    if ($('#ddlRemisionEfectivaAtencionSalud', parent.document).val() == 'SINO002')
                        $("#ddlNotificaNutrirParaSanar", parent.document).prop("disabled", false);
                    else
                        $("#ddlNotificaNutrirParaSanar", parent.document).val('').prop("disabled", true);
                        $("#txtAccionesImplementadas", parent.document).val('').prop("disabled", true);
                });

                $('#ddlNotificaNutrirParaSanar', parent.document).on('change', function (e) {
                    if ($('#ddlNotificaNutrirParaSanar', parent.document).val() != '')
                        $("#txtAccionesImplementadas", parent.document).prop("disabled", false);
                    else
                        $("#txtAccionesImplementadas", parent.document).val('').prop("disabled", true);
                });

                $('#ddlRecibeComplementacionEntidadSalud', parent.document).on('change', function (e) {
                    if ($('#ddlRecibeComplementacionEntidadSalud', parent.document).val() == 'SINO001')
                        $("#ddlQueComplementacionRecibe", parent.document).prop("disabled", false);
                    else
                        $("#ddlQueComplementacionRecibe", parent.document).val('').prop("disabled", true);
                        $("#txtCualOtraComplementacion", parent.document).val('').prop("disabled", true);
                });

                $('#ddlQueComplementacionRecibe', parent.document).on('change', function (e) {
                    if ($('#ddlQueComplementacionRecibe', parent.document).val() == 'Otra')
                        $("#txtCualOtraComplementacion", parent.document).prop("disabled", false);
                    else
                        $("#txtCualOtraComplementacion", parent.document).val('').prop("disabled", true);
                });

                $('#ddlRecibeRacionNutrirParaSanar', parent.document).on('change', function (e) {
                    if ($('#ddlRecibeRacionNutrirParaSanar', parent.document).val() == 'SINO001')
                        $("#ddlQueTipoRacionNutrirParaSanarRecibe", parent.document).prop("disabled", false);
                    else
                        $("#ddlQueTipoRacionNutrirParaSanarRecibe", parent.document).val('').prop("disabled", true);
                });

                $('#ddlCambioSuEstadoNutricional', parent.document).on('change', function (e) {
                    if ($('#ddlCambioSuEstadoNutricional', parent.document).val() == 'SINO001')
                        $("#ddlNuevoDiagnostico", parent.document).prop("disabled", false);
                    else
                        $("#ddlNuevoDiagnostico", parent.document).val('').prop("disabled", true);
                });

                $('#ddlActivacionRutaVulneracionDerechos', parent.document).on('change', function (e) {
                    if ($('#ddlActivacionRutaVulneracionDerechos', parent.document).val() == 'SINO001')
                        $("#txtEspecificarCualVulneracion", parent.document).prop("disabled", false);
                    else
                        $("#txtEspecificarCualVulneracion", parent.document).val('').prop("disabled", true);
                });

                if (nuevo == 'S') {

                    parent.loading(true);

                    error = false;

                    var refreshId = setInterval(function () {

                        if (($("#ddlParticipante option:selected", parent.document).text() != '' &&
                            $("#ddlTipoAtencion option:selected", parent.document).text() != '' &&
                            $("#ddlCicloVital option:selected", parent.document).text() != '' &&
                            $("#ddlRemisionFisica option:selected", parent.document).text() != '' &&
                            $("#ddlRemisionEfectivaAtencionSalud option:selected", parent.document).text() != '' &&
                            $("#ddlHuboHospitalizacion option:selected", parent.document).text() != '' &&
                            $("#ddlRecibeComplementacionEntidadSalud option:selected", parent.document).text() != '' &&
                            $("#ddlCambioSuEstadoNutricional option:selected", parent.document).text() != '') ||
                            error
                        ) {
                            clearInterval(refreshId);
                            parent.loading(false);
                        }
                    }, 10);

                    $('#dvIdSeguimientoDeficitNutricional', parent.document).hide();
                    $('#flArchivo', parent.document).filestyle();

                    cargarParticipantes();

                    parent.configSelect2WhitOnChangeControl('ddlParticipante', function (event) {
                        if (event.target.value != '')
                            cargarCicloVital(event.target.value);
                        else
                            $('#ddlCicloVital', parent.document).val('');
                    });

                    picker = parent.TempusDominusDateTimePicker('fecha', 'dd/MM/yyyy HH:mm', true, true, 15);

                    cargarGeneralidad('TIAC', $("#ddlTipoAtencion", parent.document));

                    //$('#ddlCicloVital', parent.document).on('change', function () {
                    //    cargarGeneralidad('DXNU', $('#ddlDXNutricional', parent.document), null, $('#ddlCicloVital', parent.document).val());
                    //});

                    //$('#ddlCicloVital', parent.document).on('change', function () {
                    //    cargarGeneralidad('DXNU', $('#ddlNuevoDiagnostico', parent.document), null, $('#ddlCicloVital', parent.document).val());
                    //});

                    cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document));
                    cargarGeneralidad('SINO', $('#ddlRemisionFisica', parent.document));
                    cargarGeneralidad('SINO', $('#ddlRemisionEfectivaAtencionSalud', parent.document));
                    cargarGeneralidad('SINO', $('#ddlNotificaNutrirParaSanar', parent.document));
                    cargarGeneralidad('SINO', $('#ddlHuboHospitalizacion', parent.document));
                    cargarGeneralidad('SINO', $('#ddlRecibeComplementacionEntidadSalud', parent.document));
                    cargarGeneralidad('SINO', $('#ddlCambioSuEstadoNutricional', parent.document));
                    cargarGeneralidad('SINO', $('#ddlDiligenciamientoSivigila', parent.document));
                    cargarGeneralidad('SINO', $('#ddlRecibeRacionAlimentaria365', parent.document));
                    cargarGeneralidad('SINO', $('#ddlRecibeRacionNutrirParaSanar', parent.document));
                    cargarGeneralidad('SINO', $('#ddlSocializacionSeguimientoEquipo', parent.document));
                    cargarGeneralidad('SINO', $('#ddlActivacionRutaVulneracionDerechos', parent.document));
                    
                    $('#ddlCicloVital', parent.document).on('change', function () {
                        //var cicloVitalVal = $('#ddlCicloVital', parent.document).val();

                        // Llenar la lista ddlDXNutricional
                        cargarGeneralidad('DXNU', $('#ddlDXNutricional', parent.document), null, $('#ddlCicloVital', parent.document).val());

                        // Llenar la nueva lista según las condiciones especificadas por un cargue de generalidad personalizada
                        cargarGeneralidadPersonalizada('DXNU', $('#ddlNuevoDiagnostico', parent.document), null, $('#ddlCicloVital', parent.document).val());
                    });


                }

                //else {
                //    $('#dvIdSeguimientoDeficitNutricional', parent.document).show();
                //    $('#txtIdSeguimientoDeficitNutricional', parent.document).val(idSeguimientoDeficitNutricional);
                //    parent.loading(true);
                //    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerSeguimientoDeficitNutricional', 'POST', 'idSeguimientoDeficitNutricional', idSeguimientoDeficitNutricional, function (resp) {
                //        try {
                //
                //            error = false;
                //
                //            var refreshId = setInterval(function () {
                //
                //                if (($("#ddlParticipante option:selected", parent.document).text() != '' &&
                //                    $("#ddlTipoAtencion option:selected", parent.document).text() != '' &&
                //                    $("#ddlCicloVital option:selected", parent.document).text() != '' &&
                //                    $("#ddlRemisionFisica option:selected", parent.document).text() != '' &&
                //                    $("#ddlRemisionEfectivaAtencionSalud option:selected", parent.document).text() != '' &&
                //                    $("#ddlHuboHospitalizacion option:selected", parent.document).text() != '' &&
                //                    $("#ddlRecibeComplementacionEntidadSalud option:selected", parent.document).text() != '' &&
                //                    $("#ddlCambioSuEstadoNutricional option:selected", parent.document).text() != '') ||
                //                    error
                //                ) {
                //                    clearInterval(refreshId);
                //                    parent.loading(false);
                //                }
                //            }, 10);
                //
                //            datosJson = JSON.parse(resp.d);
                //
                //            if (datosJson.resultado) {
                //                var datos = JSON.parse(datosJson.mensaje);
                //
                //                var fecha = moment(datos[0].fechaHora, 'DD/MM/YYYY HH:mm').endOf('month').add(5, 'days');
                //                var fechaActual = moment();
                //
                //                if (fechaActual > fecha) {
                //                    $('#Guardar', parent.document).hide();
                //                    $("#txtfecha", parent.document).prop("disabled", true).css("background-color", "#eee");
                //
                //                    //$('#txtfecha', parent.document).prop("disabled", true);
                //                    //$('#ddlTipoAtencion', parent.document).prop("disabled", true);
                //                    //$('#ddlCicloVital', parent.document).prop("disabled", true);
                //                    //$('#txtPeso', parent.document).prop("disabled", true);
                //                    //$('#txtTalla', parent.document).prop("disabled", true);
                //                    //$('#txtPerimetroBraquial', parent.document).prop("disabled", true);
                //                    //$('#txtDesviacionEstandar', parent.document).prop("disabled", true);
                //                    //$('#txtIMC', parent.document).prop("disabled", true);
                //                    //$('#ddlDXNutricional', parent.document).prop("disabled", true);
                //                    //$('#chkDXAsociadoEnfermedadBase', parent.document).prop("disabled", true);
                //                    //$('#txtEnfermedades', parent.document).prop("disabled", true);
                //                    //$('#txtSignosFisicosCarenciales', parent.document).prop("disabled", true);
                //                    //$('#ddlInseguridadAlimentaria', parent.document).prop("disabled", true);
                //                    //$('#ddlAccesoServiciosPublicos', parent.document).prop("disabled", true);
                //                    //$('#ddlAccesoServiciosSalud', parent.document).prop("disabled", true);
                //                    //$('#txtCondicionesVivienda', parent.document).prop("disabled", true);
                //                    //$('#txtAspectosPsicosocialesVulneracionDerechos', parent.document).prop("disabled", true);
                //                    //$('#ddlLactancia', parent.document).prop("disabled", true);
                //                    //$('#txtAccionesRealizadas', parent.document).prop("disabled", true);
                //                }
                //
                //                ejecutarMetodoAsync('../WebMethods.aspx/ObtenerCaracterizacion', 'POST', 'numeroIdentificacion', datos[0].numeroIdentificacion, function (resp) {
                //                    try {
                //                        datosJson = JSON.parse(resp.d);
                //
                //                        if (datosJson.resultado) {
                //                            var datos2 = JSON.parse(datosJson.mensaje);
                //
                //                            $('#ddlParticipante', parent.document).append('<option value="' + datos[0].numeroIdentificacion + '" selected>' + datos[0].numeroIdentificacion + ' - ' + [datos2[0].primerNombre,
                //                            datos2[0].segundoNombre,
                //                            datos2[0].primerApellido,
                //                            datos2[0].segundoApellido].filter(Boolean).join(' ') + '</option>');
                //                        }
                //                    }
                //                    catch (e) {
                //                        error = true;
                //                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                //                    }
                //                });
                //
                //                $('#ddlCicloVital', parent.document).on('change', function () {
                //                    cargarGeneralidad('DXNU', $('#ddlDXNutricional', parent.document), datos[0].dXNutricional, $('#ddlCicloVital', parent.document).val());
                //                });
                //
                //                cargarGeneralidad('TIAC', $("#ddlTipoAtencion", parent.document), datos[0].idTipoAtencion);
                //                cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document));
                //                cargarGeneralidad('SINO', $('#ddlRemisionFisica', parent.document));
                //                cargarGeneralidad('SINO', $('#ddlRemisionEfectivaAtencionSalud', parent.document));
                //                cargarGeneralidad('SINO', $('#ddlHuboHospitalizacion', parent.document));
                //                cargarGeneralidad('SINO', $('#ddlRecibeComplementacionEntidadSalud', parent.document));
                //                cargarGeneralidad('SINO', $('#ddlCambioSuEstadoNutricional', parent.document));
                //
                //                $('#ddlCicloVital', parent.document).on('change', function () {
                //                    cargarGeneralidad('DXNU', $('#ddlNuevoDiagnostico', parent.document), null, $('#ddlCicloVital', parent.document).val());
                //                });
                //
                //                picker = parent.TempusDominusDateTimePicker('fecha', 'dd/MM/yyyy HH:mm', true, true, 15);
                //
                //                $('#txtfecha', parent.document).val(datos[0].fechaHora);
                //
                //                $('#ddlTipoAtencion', parent.document).val(datos[0].idTipoAtencion);
                //                $('#ddlCicloVital', parent.document).val(datos[0].idCicloVital);
                //                $('#txtPeso', parent.document).val(datos[0].peso);
                //                $('#txtTalla', parent.document).val(datos[0].talla);
                //                $('#txtPerimetroBraquial', parent.document).val(datos[0].perimetroBraquial);
                //                $('#txtPerimetroCefalico', parent.document).val(datos[0].perimetroCefalico);
                //                $('#txtSemanasGestacion', parent.document).val(datos[0].semanasGestacion);
                //                $('#ddlDXNutricional', parent.document).val(datos[0].dXNutricional);
                //                $('#ddlTallaEdad', parent.document).val(datos[0].tallaEdad);
                //                $('#ddlCuantosSeguimientosRealizado', parent.document).val(datos[0].cuantosSeguimientosRealizado);
                //                $('#ddlRemisionFisica', parent.document).val(datos[0].remisionFisica);
                //                $('#ddlRemisionEfectivaAtencionSalud', parent.document).val(datos[0].remisionEfectivaAtencionSalud);
                //                $('#ddlHuboHospitalizacion', parent.document).val(datos[0].huboHospitalizacion);
                //                $('#ddlRecibeComplementacionEntidadSalud', parent.document).val(datos[0].recibeComplementacionEntidadSalud);
                //                $('#ddlQueComplementacionRecibe', parent.document).val(datos[0].queComplementacionRecibe);
                //                $('#txtCualOtraComplementacion', parent.document).val(datos[0].cualOtraComplementacion);
                //                $('#ddlClasificacionELCSA', parent.document).val(datos[0].clasificacionELCSA);
                //                $('#ddlCambioSuEstadoNutricional', parent.document).val(datos[0].cambioSuEstadoNutricional);
                //                $('#ddlNuevoDiagnostico', parent.document).val(datos[0].nuevoDiagnostico);
                //                $('#txtAspectosAlimentarios', parent.document).val(datos[0].aspectosAlimentarios);
                //                $('#txtAspectosBioquimicos', parent.document).val(datos[0].aspectosBioquimicos);
                //                $('#txtAspectosClinicos', parent.document).val(datos[0].aspectosClinicos);
                //                $('#txtAspectosEconomicos', parent.document).val(datos[0].aspectosEconomicos);
                //                $('#txtAspectosFamiliares', parent.document).val(datos[0].aspectosFamiliares);
                //                $('#txtAspectosPsicosociales', parent.document).val(datos[0].aspectosPsicosociales);
                //                $('#txtDescribaAccionesRealizadas', parent.document).val(datos[0].describaAccionesRealizadas);
                //
                //                if (fechaActual <= fecha) {
                //                    if (datos[0].idCicloVital == 'TICV001' || datos[0].idCicloVital == 'TICV002') {
                //                        $('#ddlLactancia', parent.document).prop('disabled', true);
                //                        $('#txtIMC', parent.document).prop('disabled', false);
                //                        $('#txtDesviacionEstandar', parent.document).prop('disabled', true);
                //                    }
                //                    else {
                //                        $('#ddlLactancia', parent.document).prop('disabled', false);
                //                        $('#txtIMC', parent.document).prop('disabled', true);
                //                        $('#txtDesviacionEstandar', parent.document).prop('disabled', false);
                //                    }
                //                }
                //
                //                $("#ddlParticipante", parent.document).prop("disabled", true);
                //            }
                //            else {
                //                alerta(datosJson.mensaje, datosJson.tipoMensaje);
                //                CloseModalBox();
                //            }
                //
                //        }
                //        catch (e) {
                //            error = true;
                //            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                //        }
                //    });
                //}
            }

            function Eliminar(idSeguimientoDeficitNutricional, fechaHora) {

                var fecha = moment(fechaHora, 'DD/MM/YYYY HH:mm').endOf('month').add(5, 'days');
                var fechaActual = moment();

                if (fechaActual > fecha)
                    alerta('No es posible eliminar el seguimiento déficit nutricional con código ' + idSeguimientoDeficitNutricional + ' ya que está fuera de la fecha permitida.', 'Error');
                else {

                    confirmar('Está seguro que desea eliminar el seguimiento déficit nutricional con código ' + idSeguimientoDeficitNutricional + '?', 'Advertencia', function () {

                        ejecutarMetodoAsync('../WebMethods.aspx/EliminarSeguimientoDeficitNutricional', 'POST', 'idSeguimientoDeficitNutricional', idSeguimientoDeficitNutricional, function (resp) {
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

            function cargarGeneralidad(tipoGeneralidad, control, value, filtro) {
                var jsonInput = "{ idTipoGeneralidad: '" + tipoGeneralidad + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: "POST",
                    url: '../WebMethods.aspx/ConsultarGeneralidades',
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (resultado) {
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $(control).empty();
                            $(control).append('<option value="' + '' + '">Seleccione una opción</option>');

                            $.each(informacion, function (index, value) {
                                if (filtro != null) {
                                    if ((filtro == 'TICV001' || filtro == 'TICV002') && (value.IdGeneralidad == 'DXNU008')) {
                                        $(control).append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
                                    }
                                    else if ((filtro != 'TICV001' && filtro != 'TICV002') && (value.IdGeneralidad == 'DXNU001' || value.IdGeneralidad == 'DXNU002')) {
                                        $(control).append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
                                    }
                                } else {
                                    $(control).append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
                                }
                            });

                            if (value != null)
                                $(control).val(value);

                            if (tipoGeneralidad == 'TICV' && value != null) {
                                $(control).trigger('change');
                            }
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }


            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarGeneralidadPersonalizada(tipoGeneralidad, control, value, filtro) {
            
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

                            $('#EditarSeguimientoDeficitNutricional', parent.document).find('.error,.valid').each(function () {
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
