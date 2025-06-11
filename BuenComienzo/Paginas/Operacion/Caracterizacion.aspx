<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Caracterizacion.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Caracterizacion" %>

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
    <form id="Cronograma" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Caracterización
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
                            <table id="grdCaracterizacion" class="table table-bordered table-striped">
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

        <!-- filestyle -->
        <script src="../../plugins/filestyle/bootstrap-filestyle.js?v1.0"></script>
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
            var esNuevo = false;

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
                this.tabla = $("#grdCaracterizacion").DataTable({
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
                        'width': "61px"
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Número Identificaón', 'Tipo Identificación', 'Nombre', 'Fecha Nacimiento', 'Celular', 'Ciclo Vital', 'Cuentame', 'Id Matrícula', 'Coordinador', 'Sede', 'Uba', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarCaracterizacion",
                    "drawCallback": function (settings) {
                        $('#framePrincipal', parent.document).css('height', document.body.scrollHeight + 'px');
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
                                    $("#grdCaracterizacion").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function Editar(numeroIdentificacion, nuevo) {
                esNuevo = nuevo;
                openPopup({
                    'title': 'Caracterización',
                    'width': '900',
                    'url': './Popups/EditarCaracterizacion.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {

                            if ($('#EditarCaracterizacion', parent.document).isValid()) {

                                $('#Guardar', parent.document).prop('disabled', true);

                                var objCaracterizacion = new Object();
                                objCaracterizacion.nuevo = esNuevo;
                                objCaracterizacion.fechaRegistroCaracterizacion = $('#txtfechaCaracterizacion', parent.document).val();
                                objCaracterizacion.idCuentame = $('#ddlCuentame', parent.document).val();
                                objCaracterizacion.idTipoIdentificacion = $('#ddlTipoIdentificacion', parent.document).val();
                                objCaracterizacion.numeroIdentificacion = $('#txtNumeroIdentificacion', parent.document).val().trim();
                                objCaracterizacion.nombreFamiResponsable = $('#txtNombreFamiResponsable', parent.document).val().toUpperCase().trim();
                                objCaracterizacion.primerNombre = $('#txtPrimerNombre', parent.document).val().toUpperCase().trim();
                                objCaracterizacion.segundoNombre = $('#txtSegundoNombre', parent.document).val().toUpperCase().trim();
                                objCaracterizacion.primerApellido = $('#txtPrimerApellido', parent.document).val().toUpperCase().trim();
                                objCaracterizacion.segundoApellido = $('#txtSegundoApellido', parent.document).val().toUpperCase().trim();
                                objCaracterizacion.fechaNacimiento = $('#txtFechaNacimiento', parent.document).val();
                                objCaracterizacion.idSexo = $('#ddlSexo', parent.document).val();
                                objCaracterizacion.idNacionalidad = $('#ddlNacionalidad', parent.document).val();
                                objCaracterizacion.telefono = $('#txtTelefono', parent.document).val().trim();
                                objCaracterizacion.celular = $('#txtCelular', parent.document).val().trim();
                                objCaracterizacion.direccion = $('#txtDireccion', parent.document).val().toUpperCase().trim();
                                objCaracterizacion.idComuna = $('#ddlComuna', parent.document).val();
                                objCaracterizacion.idBarrio = $('#ddlBarrio', parent.document).val();
                                objCaracterizacion.observacionesDireccion = $('#txtObservacionesDireccion', parent.document).val().toUpperCase().trim();
                                objCaracterizacion.idCicloVital = $('#ddlCicloVital', parent.document).val();
                                objCaracterizacion.semanasGestacion = $('#txtSemanasGestacion', parent.document).val().trim();
                                objCaracterizacion.asisteCPNoCXNoVI = ($('#chkAsisteCPNoCXNoVI', parent.document).is(':checked') ? '1' : '0');
                                objCaracterizacion.idEsquemaVacunacion = $('#ddlEsquemaVacunacion', parent.document).val();
                                objCaracterizacion.idMadreAdolescente = $('#ddlMadreAdolescente', parent.document).val();
                                objCaracterizacion.idTipoAfiliacion = $('#ddlTipoAfiliacion', parent.document).val();
                                objCaracterizacion.idEAPB = $('#ddlEAPB', parent.document).val();
                                objCaracterizacion.idParentescoRedApoyo = $('#ddlParentescoRedApoyo', parent.document).val();
                                objCaracterizacion.nombreCompletoRedApoyo = $('#txtNombreCompletoRedApoyo', parent.document).val().toUpperCase().trim();
                                objCaracterizacion.celularRedApoyo = $('#txtCelularRedApoyo', parent.document).val().trim();

                                ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarCaracterizacion', 'POST', objCaracterizacion, function (resp) {
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
                }, function () { successPopupEditar(numeroIdentificacion, nuevo); });

                $('input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran la validación
                parent.configFormValidate('EditarCaracterizacion', 'date, security');
            }

            function loading() {
                parent.loading(true);

                error = false;

                var refreshId = setInterval(function () {

                    if (($("#ddlTipoIdentificacion option:selected", parent.document).text() != '' &&
                        $("#ddlCuentame option:selected", parent.document).text() != '' &&
                        $("#ddlSexo option:selected", parent.document).text() != '' &&
                        $("#ddlNacionalidad option:selected", parent.document).text() != '' &&
                        $("#ddlCicloVital option:selected", parent.document).text() != '' &&
                        $("#ddlEsquemaVacunacion option:selected", parent.document).text() != '' &&
                        $("#ddlParentescoRedApoyo option:selected", parent.document).text() != '' &&
                        $("#ddlTipoAfiliacion option:selected", parent.document).text() != '') ||
                        error
                    ) {
                        clearInterval(refreshId);
                        parent.loading(false);
                    }
                }, 10);
            }

            var pickerFechaCaracterizacion;
            var pickerFechaNacimiento;

            function successPopupEditar(numeroIdentificacion, nuevo) {

                esNuevo = nuevo;

                pickerFechaCaracterizacion = parent.TempusDominusDateTimePicker('fechaCaracterizacion', "dd/MM/yyyy", false, false, 1);
                pickerFechaNacimiento = parent.TempusDominusDateTimePicker('fechaNacimiento', "dd/MM/yyyy", false, false, 1);

                $('#txtCelular', parent.document).on('keypress', function (e) { keypressNumeric(e); });
                $('#txtTelefono', parent.document).on('keypress', function (e) { keypressNumeric(e); });
                $('#txtCelularRedApoyo', parent.document).on('keypress', function (e) { keypressNumeric(e); });
                //$('#txtNumeroVacunas', parent.document).on('keypress', function (e) { keypressNumeric(e); });
                $('#txtSemanasGestacion', parent.document).on('keypress', function (e) { keypressNumeric(e); });
                $('#txtNumeroIdentificacion', parent.document).on('keypress', function (e) { keypressNumeric(e); });

                $('#ddlCicloVital', parent.document).on('change', function (e) {
                    if ($('#ddlCicloVital', parent.document).val() == 'TICV001')
                        $("#txtSemanasGestacion", parent.document).prop("disabled", false);
                    else
                        $("#txtSemanasGestacion", parent.document).val('').prop("disabled", true);
                });

                //$('#ddlEsquemaVacunacion', parent.document).on('change', function (e) {
                //    if ($('#ddlEsquemaVacunacion', parent.document).val() != 'TIEV003')
                //        $("#txtNumeroVacunas", parent.document).prop("disabled", false);
                //    else
                //        $("#txtNumeroVacunas", parent.document).val('').prop("disabled", true);
                //});

                $('#ddlCuentame', parent.document).on('change', function (e) {
                    if ($('#ddlCuentame', parent.document).val() == 'TICU003')
                        $("#txtNombreFamiResponsable", parent.document).prop("disabled", false);
                    else
                        $("#txtNombreFamiResponsable", parent.document).val('').prop("disabled", true);
                });

                $('#ddlCicloVital', parent.document).on('change', function (e) {
                    if ($('#ddlCicloVital', parent.document).val() == 'TICV001' || $('#ddlCicloVital', parent.document).val() == 'TICV002')
                        $("#ddlMadreAdolescente", parent.document).prop("disabled", false);
                    else
                        $("#ddlMadreAdolescente", parent.document).val('').prop("disabled", true);
                });


                if (nuevo == 'S') {

                    loading();

                    $('#txtNumeroIdentificacion', parent.document).focus();

                    $('#txtNumeroIdentificacion', parent.document).on('blur', function (e) {
                        if ($('#txtNumeroIdentificacion', parent.document).val() != '')
                            buscarCaracterizacion($('#txtNumeroIdentificacion', parent.document).val(), true);
                    }).on('keypress', function (e) {
                        if (e.which == 13) {
                            if($('#txtNumeroIdentificacion', parent.document).val() != '')
                                $(this).blur();
                        }
                    });

                    cargarComunas();
                    cargarGeneralidad('TIID', $('#ddlTipoIdentificacion', parent.document));
                    cargarGeneralidad('TICU', $('#ddlCuentame', parent.document));
                    cargarGeneralidad('TISE', $('#ddlSexo', parent.document));
                    cargarGeneralidad('TINA', $('#ddlNacionalidad', parent.document));
                    cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document));
                    cargarGeneralidad('TIEV', $('#ddlEsquemaVacunacion', parent.document));
                    cargarGeneralidad('SINO', $('#ddlMadreAdolescente', parent.document));
                    cargarGeneralidad('TIPA', $('#ddlParentescoRedApoyo', parent.document));
                    cargarGeneralidad('TIAF', $('#ddlTipoAfiliacion', parent.document), null, cargarEAPB);
                }
                else {
                    $('#txtNumeroIdentificacion', parent.document).val(numeroIdentificacion).prop("disabled", true);
                    buscarCaracterizacion(numeroIdentificacion, false);
                }
            }

            function buscarCaracterizacion(numeroIdentificacion, desdeNuevo) {

                //Se consulta en la base de datos nuestra de caracterización
                ejecutarMetodoAsync('../WebMethods.aspx/ObtenerCaracterizacion', 'POST', 'numeroIdentificacion', numeroIdentificacion, function (resp) {
                    try {
                        datosJson = JSON.parse(resp.d);

                        if (datosJson.resultado) {

                            $('#txtNumeroIdentificacion', parent.document).prop("disabled", true);

                            esNuevo = 'N';
                            $("#ddlTipoIdentificacion option:selected", parent.document).empty();
                            $("#ddlCuentame option:selected", parent.document).empty();
                            $("#ddlSexo option:selected", parent.document).empty();
                            $("#ddlNacionalidad option:selected", parent.document).empty();
                            $("#ddlCicloVital option:selected", parent.document).empty();
                            $("#ddlMadreAdolescente option:selected", parent.document).empty();
                            $("#ddlEsquemaVacunacion option:selected", parent.document).empty();
                            $("#ddlParentescoRedApoyo option:selected", parent.document).empty();
                            $("#ddlTipoAfiliacion option:selected", parent.document).empty();

                            loading();

                            var datos = JSON.parse(datosJson.mensaje);

                            cargarComunas(datos[0].idComuna, datos[0].idBarrio);
                            cargarGeneralidad('TIID', $('#ddlTipoIdentificacion', parent.document), datos[0].idTipoIdentificacion);
                            cargarGeneralidad('TICU', $('#ddlCuentame', parent.document), datos[0].idCuentame);
                            cargarGeneralidad('TISE', $('#ddlSexo', parent.document), datos[0].idSexo);
                            cargarGeneralidad('TINA', $('#ddlNacionalidad', parent.document), datos[0].idNacionalidad);
                            cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document), datos[0].idCicloVital);
                            cargarGeneralidad('SINO', $('#ddlMadreAdolescente', parent.document), datos[0].idMadreAdolescente);
                            cargarGeneralidad('TIEV', $('#ddlEsquemaVacunacion', parent.document), datos[0].idEsquemaVacunacion);
                            cargarGeneralidad('TIPA', $('#ddlParentescoRedApoyo', parent.document), datos[0].idParentescoRedApoyo);
                            cargarGeneralidad('TIAF', $('#ddlTipoAfiliacion', parent.document), datos[0].idTipoAfiliacion, cargarEAPB, datos[0].idEAPB);


                            $('#txtfechaCaracterizacion', parent.document).val(datos[0].fechaRegistroCaracterizacion);
                            $('#txtFechaNacimiento', parent.document).val(datos[0].fechaNacimiento);

                            if (datos[0].asisteCPNoCXNoVI == 'True')
                                $('#chkAsisteCPNoCXNoVI', parent.document).iCheck('check');
                            else
                                $('#chkAsisteCPNoCXNoVI', parent.document).iCheck('uncheck');

                            $('#txtNombreFamiResponsable', parent.document).val(datos[0].nombreFamiResponsable);
                            $('#txtPrimerNombre', parent.document).val(datos[0].primerNombre);
                            $('#txtSegundoNombre', parent.document).val(datos[0].segundoNombre);
                            $('#txtPrimerApellido', parent.document).val(datos[0].primerApellido);
                            $('#txtSegundoApellido', parent.document).val(datos[0].segundoApellido);
                            $('#txtTelefono', parent.document).val(datos[0].telefono);
                            $('#txtCelular', parent.document).val(datos[0].celular);
                            $('#txtDireccion', parent.document).val(datos[0].direccion);
                            $('#txtObservacionesDireccion', parent.document).val(datos[0].observacionesDireccion);
                            $('#txtSemanasGestacion', parent.document).val(datos[0].semanasGestacion);
                            //$('#txtNumeroVacunas', parent.document).val(datos[0].numeroVacunas);
                            $('#txtNombreCompletoRedApoyo', parent.document).val(datos[0].nombreCompletoRedApoyo);
                            $('#txtCelularRedApoyo', parent.document).val(datos[0].celularRedApoyo);
                            $('#txtMatricula', parent.document).val(datos[0].idMatricula);

                            if (desdeNuevo)
                                alerta('la caracterización para el número de documento ' + numeroIdentificacion + ' ya existe. El registro quedará en modo edición.', 'Advertencia');
                        }
                        else {
                            if (!desdeNuevo) {
                                alerta(datosJson.mensaje, datosJson.tipoMensaje);
                                CloseModalBox();
                            }
                            else {

                                //Se consulta en la base de datos de Buen Comienzo
                                ejecutarMetodoAsync('../WebMethods.aspx/ObtenerCaracterizacionBuenComienzo', 'POST', 'numeroIdentificacion', numeroIdentificacion, function (resp) {
                                    try {
                                        datosJson = JSON.parse(resp.d);

                                        if (datosJson.resultado) {

                                            $('#txtNumeroIdentificacion', parent.document).prop("disabled", true);

                                            parent.loading(true);

                                            var carga = false;

                                            var refreshId = setInterval(function () {

                                                if (carga) {
                                                    clearInterval(refreshId);
                                                    parent.loading(false);
                                                }
                                            }, 10);

                                            var datos = JSON.parse(datosJson.mensaje);

                                            if (datos[0].TIPO_DOCUMENTO != '')
                                                $('#ddlTipoIdentificacion option', parent.document).filter(function () { return removeAccents($(this).html().toUpperCase()) == datos[0].TIPO_DOCUMENTO; }).prop('selected', true);

                                            if (datos[0].SEXO != '')
                                                $('#ddlSexo option', parent.document).filter(function () { return removeAccents($(this).html().toUpperCase()) == datos[0].SEXO; }).prop('selected', true);

                                            if (datos[0].NACIONALIDAD != '')
                                                $('#ddlNacionalidad option', parent.document).filter(function () { return removeAccents($(this).html().toUpperCase()) == datos[0].NACIONALIDAD; }).prop('selected', true);
                                            
                                            if (datos[0].COMUNA != '')
                                                $('#ddlComuna', parent.document).val(parseInt(datos[0].COMUNA).toString());

                                            if (datos[0].BARRIO != '')
                                                cargarBarrios(datos[0].BARRIO);

                                            if (datos[0].CICLO_VITAL != '')
                                                $('#ddlCicloVital option', parent.document).filter(function () { return removeAccents($(this).html().toUpperCase()) == datos[0].CICLO_VITAL; }).prop('selected', true).trigger('change');

                                            if (datos[0].ESQUEMA_VACUNACION != '')
                                                $('#ddlEsquemaVacunacion option', parent.document).filter(function () { return removeAccents($(this).html().toUpperCase()) == datos[0].ESQUEMA_VACUNACION; }).prop('selected', true).trigger('change');

                                            if (datos[0].AFILIACION_SGSSS != '')
                                                $('#ddlTipoAfiliacion option', parent.document).filter(function () { return removeAccents($(this).html().toUpperCase()) == datos[0].AFILIACION_SGSSS; }).prop('selected', true).trigger('change');

                                            if (datos[0].FAMILIARES_PARENTESCO != '') {
                                                $('#ddlParentescoRedApoyo option', parent.document).filter(function () {
                                                    var parentesco = datos[0].FAMILIARES_PARENTESCO.toUpperCase();

                                                    parentesco = parentesco.replace('AMIGA', 'AMIGA(O)')
                                                        .replace('AMIGO', 'AMIGA(O)')
                                                        .replace('ABUELA', 'ABUELA(O)')
                                                        .replace('ABUELO', 'ABUELA(O)')
                                                        .replace('HERMANO', 'HERMANA(O)')
                                                        .replace('HERMANA', 'HERMANA(O)')
                                                        .replace('VECINA', 'VECINA(O)')
                                                        .replace('VECINO', 'VECINA(O)')
                                                        .replace('TIO', 'TIA(O)')
                                                        .replace('TIA', 'TIA(O)');

                                                    return removeAccents($(this).html().toUpperCase()) == parentesco;
                                                }).prop('selected', true);
                                            }

                                            $('#txtFechaNacimiento', parent.document).val(datos[0].FECHA_NACIMIENTO);

                                            if (datos[0].ASISTE_PROGRAMA_CXD != '' && datos[0].ASISTE_PROGRAMA_CXD == 'SI')
                                                $('#chkAsisteCPNoCXNoVI', parent.document).iCheck('check');
                                            else
                                                $('#chkAsisteCPNoCXNoVI', parent.document).iCheck('uncheck');

                                            $('#txtPrimerNombre', parent.document).val(datos[0].PRIMER_NOMBRE);
                                            $('#txtSegundoNombre', parent.document).val(datos[0].SEGUNDO_NOMBRE);
                                            $('#txtPrimerApellido', parent.document).val(datos[0].PRIMER_APELLIDO);
                                            $('#txtSegundoApellido', parent.document).val(datos[0].SEGUNDO_APELLIDO);
                                            $('#txtTelefono', parent.document).val(datos[0].TELEFONO_FIJO);
                                            $('#txtCelular', parent.document).val(datos[0].CELULAR);
                                            $('#txtDireccion', parent.document).val(datos[0].DIRECCION);
                                            
                                            $('#txtSemanasGestacion', parent.document).val(datos[0].EDAD_GESTACIONAL);
                                            //$('#txtNumeroVacunas', parent.document).val(datos[0].NUMERO_DE_VACUNAS);
                                            $('#txtNombreCompletoRedApoyo', parent.document).val([datos[0].FAMILIARES_PRIMER_NOMBRE,
                                                datos[0].FAMILIARES_SEGUNDO_NOMBRE,
                                                datos[0].FAMILIARES_PRIMER_APELLIDO,
                                                datos[0].FAMILIARES_SEGUNDO_APELLIDO].filter(Boolean).join(' '));
                                            $('#txtCelularRedApoyo', parent.document).val(datos[0].FAMILIARES_CELULAR);

                                            carga = true;

                                            alerta('El Particiapante no existe en nuestro sistema de información, sin embargo cargamos algunos datos en el sistema de información Buen Comienzo.', 'Advertencia');
                                        }
                                    }
                                    catch (e) {
                                        carga = true;
                                        alerta('Ha ocurrido un error inesperado al intentar consultar si el particiapante existe en Buen Comienzo. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                    }
                                });
                            }
                        }
                    }
                    catch (e) {
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                    }
                });
            }

            function Matricula(numeroIdentificacion, nombre, idCicloVital) {
                openPopup({
                    'title': 'Matrícula - ' + nombre,
                    'width': '900',
                    'url': './Popups/Matricula.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {

                            if ($('#NuevaMatricula', parent.document).isValid()) {
                                var objMatricula = new Object();
                                objMatricula.numeroIdentificacion = numeroIdentificacion;
                                objMatricula.fecha = $('#txtfecha', parent.document).val();
                                objMatricula.idTipoAccion = $('#ddlTipoAccion', parent.document).val();
                                objMatricula.tipoAccion = $('#ddlTipoAccion option:selected', parent.document).text();
                                objMatricula.idMotivoRetiro = $('#ddlMotivoRetiro', parent.document).val();
                                objMatricula.idCoordinador = $('#ddlCoordinador', parent.document).val();
                                objMatricula.idSede = $('#ddlSedes', parent.document).val();
                                objMatricula.idUba = $('#ddlUbas', parent.document).val();
                                objMatricula.idCicloVital = $('#ddlCicloVital', parent.document).val();
                                objMatricula.numeroIdentificacionMadre = $('#ddlNumeroIdentificacionMadre', parent.document).val();

                                ejecutarMetodoAsync2('../WebMethods.aspx/InsertarMatricula', 'POST', objMatricula, function (resp) {
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
                }, function () { successPopup(numeroIdentificacion, idCicloVital); });

                //Se configuran la validación
                parent.configFormValidate('NuevaMatricula', 'date, security');
            }

            var picker;
            var error;

            function successPopup(numeroIdentificacion, idCicloVital) {

                parent.loading(true);

                error = false;

                var refreshId = setInterval(function () {

                    if (($("#ddlCoordinador option:selected", parent.document).text() != '' &&
                        $("#ddlNumeroIdentificacionMadre option:selected", parent.document).text() != '' &&
                        $("#ddlMotivoRetiro option:selected", parent.document).text() != '' &&
                        $("#ddlCicloVital option:selected", parent.document).text() != '' &&
                        $("#ddlTipoAccion option:selected", parent.document).text() != '') ||
                        error
                    ) {
                        clearInterval(refreshId);
                        parent.loading(false);
                    }
                }, 10);

                parent.configSelect2Control('ddlNumeroIdentificacionMadre');

                cargarCoordinadores();
                cargarMadresLactantes();
                //Se configuran las listas con buscador

                $("#txtNumeroIdentificacion", parent.document).val(numeroIdentificacion);

                $("#ddlCoordinador", parent.document).on('change', function () {
                    $(window.parent.document).find("#ddlSedes").val('');
                    $(window.parent.document).find("#ddlUbas").val('');
                    cargarSedes();
                    cargarUbas();
                });

                $("#ddlCicloVital", parent.document).on('change', function () {
                    if ($("#ddlCicloVital", parent.document).val() == 'TICV003')
                        $("#ddlNumeroIdentificacionMadre", parent.document).prop("disabled", false);
                    else {
                        $("#ddlNumeroIdentificacionMadre", parent.document).prop("disabled", true);
                        parent.valSelect2('ddlNumeroIdentificacionMadre', '');
                    }
                });

                $("#ddlTipoAccion", parent.document).on('change', function () {
                    if ($("#ddlTipoAccion", parent.document).val() == 'TIAM002') {
                        $("#ddlMotivoRetiro", parent.document).prop("disabled", false);
                        $("#ddlCoordinador", parent.document).val('').prop("disabled", true);
                        $("#ddlSedes", parent.document).val('').prop("disabled", true);
                        $("#ddlUbas", parent.document).val('').prop("disabled", true);
                        /*$("#ddlCicloVital", parent.document).val('').prop("disabled", true);*/
                        $("#ddlNumeroIdentificacionMadre", parent.document).prop("disabled", true);
                        parent.valSelect2('ddlNumeroIdentificacionMadre', '');
                    }
                    else {
                        if ($("#ddlTipoAccion", parent.document).val() == 'TIAM003')
                            cargarCoordinadores('S');

                        $("#ddlMotivoRetiro", parent.document).val('').prop("disabled", true);
                        $("#ddlCoordinador", parent.document).prop("disabled", false);
                        $("#ddlSedes", parent.document).prop("disabled", false);
                        $("#ddlUbas", parent.document).prop("disabled", false);
                        $("#ddlCicloVital", parent.document).trigger('change');
                        /*$("#ddlCicloVital", parent.document).prop("disabled", false);*/
                    }
                });

                picker = parent.TempusDominusDateTimePicker('fecha', "dd/MM/yyyy", false, false, 1);

                ConsultarTipoAccion(numeroIdentificacion);
                cargarGeneralidad('MORT', $(window.parent.document).find("#ddlMotivoRetiro"));
                cargarGeneralidad('TICV', $(window.parent.document).find("#ddlCicloVital"), idCicloVital);
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarGeneralidad(tipoGeneralidad, control, value, func, value2) {

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

                            if (func !== undefined) {
                                $(control).on("change", function () {
                                    func(value2);
                                });
                            }

                            if (value != null)
                                $(control).val(value).trigger('change');
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function ConsultarTipoAccion(numeroIdentificacion) {

                var jsonInput = "{ numeroIdentificacion: '" + numeroIdentificacion + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarTipoAccion',                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $('#ddlTipoAccion', parent.document).empty();
                            $('#ddlTipoAccion', parent.document).append('<option value="' + '' + '">Seleccione una opción</option>');

                            $.each(informacion, function (index, value) {
                                $('#ddlTipoAccion', parent.document).append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
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
            function cargarCoordinadores(esTraslado) {

                var jsonInput = "{ esTraslado: '" + ((esTraslado != null) ? esTraslado : 'N') + "' }";
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
            function cargarUbas(idUba) {

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
                        $(window.parent.document).find('#ddlUbas').append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlUbas').append('<option value="' + value.idUba + '">' + value.uba + '</option>');
                            });

                            if (idUba != null)
                                $(window.parent.document).find('#ddlUbas').val(idUba);
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos las madres lactantes que tenemos en el sistema
            function cargarMadresLactantes(idMadre) {

                $.ajax({
                    type: "GET",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ObtenerMadresLactantes',                 // URL al que vamos a hacer el pedido
                    data: null,                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        $(window.parent.document).find('#ddlNumeroIdentificacionMadre').empty();
                        $(window.parent.document).find('#ddlNumeroIdentificacionMadre').append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find('#ddlNumeroIdentificacionMadre').append('<option value="' + value.numeroIdentificacion + '">' + value.nombre + '</option>');
                            });

                            if (idMadre != null)
                                parent.valSelect2('ddlNumeroIdentificacionMadre', idMadre);
                                /*$(window.parent.document).find('#ddlNumeroIdentificacionMadre').val(idMadre);*/
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarComunas(idcomuna, idBarrio) {
                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarComunas',                 // URL al que vamos a hacer el pedido
                    data: null,                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $('#ddlComuna', parent.document).empty();
                            $('#ddlComuna', parent.document).append('<option value="' + '' + '">Seleccione una opción</option>');

                            $.each(informacion, function (index, value) {
                                $('#ddlComuna', parent.document).append('<option value="' + value.IdComuna + '">' + value.NombreComuna + '</option>');
                            });

                            $('#ddlComuna', parent.document).on("change", function () {
                                cargarBarrios();
                            });

                            if (idcomuna !== undefined) {
                                $('#ddlComuna', parent.document).val(idcomuna);
                                cargarBarrios(idBarrio);
                            }
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarBarrios(idBarrio) {

                var jsonInput = "{ idComuna: '" + $(parent.document).find('#ddlComuna option:selected').val() + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarBarrios',                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $('#ddlBarrio', parent.document).empty();
                            $('#ddlBarrio', parent.document).append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                            $.each(informacion, function (index, value) {
                                $('#ddlBarrio', parent.document).append('<option value="' + value.IdBarrio + '">' + value.NombreBarrio + '</option>');
                            });

                            if (idBarrio !== undefined) {
                                $('#ddlBarrio', parent.document).val(idBarrio);
                            }
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarEAPB(idEAPB, textEAPB) {

                var jsonInput = "{ idTipoAseguramiento: '" + $(parent.document).find('#ddlTipoAfiliacion option:selected').val() + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ObtenerEAPB',                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);
                            $('#ddlEAPB', parent.document).empty();
                            $('#ddlEAPB', parent.document).append('<option value="' + '' + '">Seleccione una opción</option>');

                            $.each(informacion, function (index, value) {
                                $('#ddlEAPB', parent.document).append('<option value="' + value.idMaeEAPB + '">' + value.nombreEapb + '</option>');
                            });

                            if (idEAPB != null)
                                $('#ddlEAPB', parent.document).val(idEAPB);

                            if (textEAPB != null)
                                $('#ddlEAPB option', parent.document).filter(function () { return removeAccents($(this).html().toUpperCase()) == textEAPB; }).prop('selected', true);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            function SubirArchivo(IdDocumento, Nombre) {
                openPopup({
                    'title': 'Subir archivo',
                    'width': '700',
                    'url': './Popups/SubirArchivoPersona?IdDocumento=' + IdDocumento + "&Nombre=" + Nombre,
                    'buttons': [
                        {
                            'name': 'Cerrar',
                            'click': function () {
                                CloseModalBox();
                            }
                        }
                    ]
                });

                CargarDocumentosPersonas(IdDocumento);


                $('#gvDocumentos tbody', window.parent.document).on('click', '#btnEliminar', function (e) {
                    e.preventDefault();
                    var IdDocumento = $('#txtIdDocumento', window.parent.document).val();
                    var IdArchivoPersona = $(this).closest('tr').find('td:eq(1)', window.parent.document).text();
                    var TipoDocumento_ = $(this).closest('tr').find('td:eq(2)', window.parent.document).text();
                    if (confirm('¿Está seguro que desea eliminar el ' + TipoDocumento_ + '?')) {
                        ejecutarMetodo('../WebMethods.aspx/EliminarDocumentoPersona', 'POST', 'IdArchivoPersona', IdArchivoPersona, function (datos) {
                            try {
                                datosJson = JSON.parse(datos.d);
                                if (!datosJson.resultado) {
                                    AddScriptParent("Mensaje('" + datosJson.mensaje + "', '" + datosJson.tipoMensaje + "', '150');");
                                } else {
                                    CargarDocumentosPersonas(IdDocumento);
                                }
                            } catch (e) {
                                AddScriptParent("Mensaje('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema.', 'Error', '150');");
                            }
                        });
                    }
                    return false;
                });

                $('#flArchivoAdjuntar', parent.document).filestyle();

                $('#addArchivo', parent.document).click(function () {
                    if (validacionesArchivoAdjuntarPersona()) {
                        var form_data = new FormData();

                        if ($('#flArchivoAdjuntar', parent.document).get(0).files.length > 0) {
                            form_data.append('file', $('#flArchivoAdjuntar', parent.document).get(0).files[0]);
                        }

                        var IdDocumento = $('#txtIdDocumento', parent.document).val();
                        var IdTipoArchivoPersona = $('#ddlTipoArchivoPersona', parent.document).val();

                        form_data.append('IdDocumento', IdDocumento);
                        form_data.append('IdTipoArchivoPersona', IdTipoArchivoPersona);
                        form_data.append('SubirArchivo', true);

                        $.ajax({
                            url: './CargarArchivoPersona.aspx',  //Server script to process data
                            type: 'POST',
                            async: false,
                            xhr: function () {  // Custom XMLHttpRequest
                                var myXhr = $.ajaxSettings.xhr();
                                if (myXhr.upload) { // Check if upload property exists
                                    //myXhr.upload.addEventListener('progress', progressHandlingFunction, false); // For handling the progress of the upload
                                }
                                return myXhr;
                            },
                            //Ajax events
                            success: function (result) {
                                if (result) {
                                    try {
                                        datosJson = JSON.parse(result);
                                        alerta(datosJson.mensaje, datosJson.tipoMensaje);

                                        if (datosJson.resultado) {
                                            //CloseModalBox();
                                            $('#ddlTipoArchivoPersona', window.parent.document).val("");
                                            $('#flArchivoAdjuntar', window.parent.document).val("");
                                            CargarDocumentosPersonas(IdDocumento);
                                        }
                                    }
                                    catch (e) {
                                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                    }
                                }
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
                });
            }

            function CambioDocumento(IdDocumento, Nombre) {
                openPopup({
                    'title': 'Cambio de documento de identidad',
                    'width': '800',
                    'url': './Popups/CambioDocumento?IdDocumento=' + IdDocumento + "&Nombre=" + Nombre,
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {

                            if ($('#CambioDocumento', parent.document).isValid()) {

                                $('#Guardar', parent.document).prop('disabled', true);

                                var objCambioDocumento = new Object();
                                objCambioDocumento.idDocumento = $('#txtIdDocumento', parent.document).val();
                                objCambioDocumento.idTipoIdentificacion = $('#ddlTipoIdentificacion', parent.document).val();
                                objCambioDocumento.numeroIdentificacion = $('#txtNumeroIdentificacion', parent.document).val().trim();

                                ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarDocumentoIdentidad', 'POST', objCambioDocumento, function (resp) {
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
                });

                CargarDocumentosPersonas(IdDocumento);
                cargarGeneralidad('TIID', $('#ddlTipoIdentificacion', parent.document));
            }


            function CargarDocumentosPersonas(IdDocumento) {
                return $("#gvDocumentos", window.parent.document).dataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bInfo": false,
                    "select": true,
                    "searching": false,
                    "bFilter": false,
                    "bProcessing": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarDocumentosPersona",
                    "fnServerParams": function (aoData) {
                        aoData.push({ "name": "IdDocumento", "value": "'" + IdDocumento + "'" });
                    },
                    "bSort": false,
                    "bLengthChange": false,
                    "oLanguage": {
                        "sZeroRecords": "No hay registros para mostrar",
                        "sProcessing": "Cargando..."
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
                                    $("#gvDocumentos", window.parent.document).show();
                                }
                        });
                    }
                });
            }

            function validacionesArchivoAdjuntarPersona() {
                var validExts = new Array('.pdf'/*, '.png', '.jpg', '.jpeg'*/);
                var fileExt = $('#flArchivoAdjuntar', parent.document).val();
                if (fileExt == "") {
                    alerta('No hay ningún archivo para adjuntar', 'Advertencia');
                    return false;
                }
                fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
                if (validExts.indexOf(fileExt.toLowerCase()) < 0) {
                    alerta('El tipo de archivo no es válido, por favor verifique que el formato sea: ' + validExts.toString(), 'Advertencia');
                    return false;
                }

                var fileSize = $('#flArchivoAdjuntar', parent.document).get(0).files[0].size;

                if (fileSize > (1024 * 1024 * 2)) {
                    alerta('El archivo no puede tener un peso mayor a 2MB. Si el archivo es de tipo PDF puede comprimirlo en la siguiente URL para que tenga un peso menor https://smallpdf.com/es/comprimir-pdf, por favor verifique.', 'Advertencia');
                    return false;
                }

                if ($('#ddlTipoArchivoPersona', parent.document).val() == "") {
                    alerta('Seleccione el tipo de archivo', 'Advertencia');
                    $('#ddlTipoArchivoPersona', parent.document).focus();
                    return false;
                }

                return true;
            }


            const removeAccents = (str) => {
                return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
            } 

        </script>
    </form>
</body>
</html>

