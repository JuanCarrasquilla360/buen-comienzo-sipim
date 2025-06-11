<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EncuentroEducativo.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.EncuentroEducativo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../plugins/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <%--<link href="../../plugins/fonts/font-awesome.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css" />
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
                <h1>Encuentro educativo
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
                            <table id="grdEncuentroEducativo" class="table table-bordered table-striped">
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
            var tablaParticipantes;
            var error = false;
            var permiteEliminar = true;

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
                    permiteEliminar = true;
                    Editar('', 'S');
                });
            });

            function cargarDatos() {
                this.tabla = $("#grdEncuentroEducativo").DataTable({
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
                    'aoColumns': columnasJSON(['Id Encuentro Educativo', 'Fecha', 'Tema', 'Coordinador', 'Sede', 'Tipo de Encuentro', 'Agente Educativo 1', 'Uba', "Usuario Creación", "Fecha creación", '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarEncuentroEducativo",
                    "drawCallback": function (settings) {
                        $('#framePrincipal', parent.document).css('height', document.body.scrollHeight + 'px');

                        $('#grdEncuentroEducativo :input[type="checkbox"].flat-red').iCheck({
                            checkboxClass: 'icheckbox_flat-red'
                        });

                        $('grdEncuentroEducativo :input[type="checkbox"].flat-red').parent().parent().parent().css('text-align', 'center');
                        $('grdEncuentroEducativo :input[type="checkbox"].flat-red').attr('disabled', 'disabled');
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
                                    $("#grdEncuentroEducativo").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function cargarParticipantes() {
                this.tablaParticipantes = $("#grdParticipantes", parent.document).DataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [
                        { 'targets': 0, 'visible': false },
                        { 'targets': 11, 'orderable': false, 'width': "20px" }
                    ],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id EED', 'Numero de identificacion', 'Nombre', 'Ciclo Vital', 'Asistencia', 'Motivo de inasistencia', 'Tiene de excusa', 'Peso', "Talla", "DX Nutricional", "Uba", '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarEncuentroEducativoDetalle",
                    "drawCallback": function (settings) {

                        $('#grdParticipantes :input[type="checkbox"].flat-red', parent.document).iCheck({
                            checkboxClass: 'icheckbox_flat-red'
                        });

                        $('#grdParticipantes :input[type="checkbox"].flat-red', parent.document).parent().parent().parent().css('text-align', 'center');
                        $('#grdParticipantes :input[type="checkbox"].flat-red', parent.document).attr('disabled', 'disabled');
                    },
                    "fnServerData": function (sSource, aoData, fnCallback) {
                        //Se agrega el idEncuentroEducativo
                        aoData.push({ name: 'idEncuentroEducativo', value: $('#txtIdEncuentroEducativo', parent.document).val() });

                        $.ajax({
                            "dataType": 'json',
                            "contentType": "application/json; charset=utf-8",
                            "type": "GET",
                            "url": sSource,
                            "data": aoData,
                            "async": true,
                            "success":
                                function (msg) {
                                    var json = jQuery.parseJSON(msg.d);
                                    fnCallback(json);
                                    $("#grdParticipantes", parent.document).show().css('width', '100%');

                                    if (!permiteEliminar)
                                        $("#grdParticipantes .ion-android-delete", parent.document).hide();

                                }
                        });
                    }
                });
            }

            function Editar(idEncuentroEducativo, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nuevo Encuentro Educativo' : 'Editar Encuentro Educativo',
                    'width': '900',
                    'url': './Popups/EditarEncuentroEducativo.aspx',
                    'buttons': [{
                        'name': 'Iniciar',
                        'click': function () {
                            if ($('#EditarEncuentroEducativo', parent.document).isValid()) {

                                $('#ddlProgramacion', parent.document).prop("disabled", true);
                                $('#ddlTema', parent.document).prop("disabled", true);
                                $('#flArchivo', parent.document).prop("disabled", true);
                                $('#dvAgregar', parent.document).show();
                                $('#dvGridAgregar', parent.document).show();
                                $('#Iniciar', parent.document).hide();

                                $('#btnAgregar', parent.document).off('click');
                                $('#btnAgregar', parent.document).on('click', function () { btnAgregar('', nuevo); });

                                cargarParticipantes();

                                setTimeout(function () { $('#btnAgregar', parent.document).click(); }, 100);
                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox();
                        }
                    }]
                }, function () { successPopup(idEncuentroEducativo, nuevo); });

                //Se configuran la validación
                parent.configFormValidate('EditarEncuentroEducativo', 'date, security');
            }

            function btnAgregar(idEncuentroEducativoDetalle, nuevo) {
                openPopup3({
                    'title': (nuevo == 'S') ? 'Nuevo Participante' : 'Editar Participante',
                    'width': '900',
                    'url': './Popups/ParticipanteEncuentroEducativo.aspx',
                    'buttons': [{
                        'name': (nuevo == 'S' ) ? 'Agregar' : 'Guardar',
                        'click': function () {
                            
                            if ($('#ParticipanteEncuentroEducativo', parent.document).isValid()) {

                                if ($('#ddlCicloVital', parent.document).val() == '') {
                                    alerta('El campo ciclo vital no puede estar vació. Por favor verifique', 'Error');
                                    return;
                                }

                                (nuevo == 'S') ? $('#Agregar', parent.document).prop('disabled', true) : $('#Guardar', parent.document).prop('disabled', true);

                                if ($('#txtIdEncuentroEducativo', parent.document).val() == '') {

                                    var form_data = new FormData();
                                    form_data.append('file', $('#flArchivo', parent.document).get(0).files[0]);
                                    form_data.append('TipoArchivo', 'Planilla');

                                    $.ajax({
                                        url: './loadFile.aspx',  //Server script to process data
                                        type: 'POST',
                                        async: false,
                                        success: function (result, status, response) {

                                            var objEncuentroEducativo = new Object();
                                            objEncuentroEducativo.nuevo = nuevo;
                                            objEncuentroEducativo.idEncuentroEducativo = '0';
                                            objEncuentroEducativo.idProgramacionActividades = $('#ddlProgramacion', parent.document).val();
                                            objEncuentroEducativo.idTema = $('#ddlTema', parent.document).val();
                                            objEncuentroEducativo.nombreArchivoGuid = response.statusText;
                                            objEncuentroEducativo.fileName = $('#flArchivo', parent.document).get(0).files[0].name;

                                            ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarEncuentroEducativo', 'POST', objEncuentroEducativo, function (resp) {
                                                try {

                                                    datosJson = JSON.parse(resp.d);

                                                    if (datosJson.resultado) {
                                                        $('#dvIdEncuentroEducativo', parent.document).show();
                                                        $('#txtIdEncuentroEducativo', parent.document).val(datosJson.mensaje);

                                                        tabla.ajax.reload();

                                                        ActualizarParticipante('');
                                                    }
                                                    else {
                                                        (nuevo == 'S') ? $('#Agregar', parent.document).prop('disabled', false) : $('#Guardar', parent.document).prop('disabled', false);
                                                        alerta(datosJson.mensaje, datosJson.tipoMensaje);
                                                    }
                                                }
                                                catch (e) {
                                                    (nuevo == 'S') ? $('#Agregar', parent.document).prop('disabled', false) : $('#Guardar', parent.document).prop('disabled', false);
                                                    alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                                }
                                            });

                                        },
                                        error: function (jqXHR, textStatus, errorThrown) {
                                            (nuevo == 'S') ? $('#Agregar', parent.document).prop('disabled', false) : $('#Guardar', parent.document).prop('disabled', false);
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
                                else {
                                    ActualizarParticipante(idEncuentroEducativoDetalle);
                                }
                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox3();
                        }
                    }]
                }, function () { successPopupParticipante($('#txtIdEncuentroEducativo', parent.document).val(), $('#ddlProgramacion', parent.document).val(), nuevo, idEncuentroEducativoDetalle); });

                $('#ParticipanteEncuentroEducativo :input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran la validación
                parent.configFormValidate('ParticipanteEncuentroEducativo', 'date, security');
            }

            function ActualizarParticipante(idEncuentroEducativoDetalle) {

                var objEncuentroEducativoDetalle = new Object();
                objEncuentroEducativoDetalle.nuevo = (idEncuentroEducativoDetalle == '') ? 'S' : 'N';
                objEncuentroEducativoDetalle.idEncuentroEducativoDetalle = idEncuentroEducativoDetalle;
                objEncuentroEducativoDetalle.idEncuentroEducativo = $('#txtIdEncuentroEducativo', parent.document).val();
                objEncuentroEducativoDetalle.numeroIdentificacion = $('#ddlParticipante', parent.document).val();
                objEncuentroEducativoDetalle.idCicloVital = $('#ddlCicloVital', parent.document).val();
                objEncuentroEducativoDetalle.asistencia = ($('#chkAsistencia', parent.document).is(':checked') ? '1' : '0');
                objEncuentroEducativoDetalle.idMotivoInasistencia = $('#ddlMotivoInasistencia', parent.document).val();
                objEncuentroEducativoDetalle.tieneExcusa = ($('#chkTieneExcusa', parent.document).is(':checked') ? '1' : '0');
                objEncuentroEducativoDetalle.peso = $('#txtPeso', parent.document).val();
                objEncuentroEducativoDetalle.talla = $('#txtTalla', parent.document).val();
                objEncuentroEducativoDetalle.dXNutricional = $('#ddlDXNutricional', parent.document).val();
                objEncuentroEducativoDetalle.idLactancia = $('#ddlLactancia', parent.document).val();
                objEncuentroEducativoDetalle.idMesLactanciaExclusiva = $('#ddlMesLactanciaExclusiva', parent.document).val();
                objEncuentroEducativoDetalle.idPorqueSinLactancia = $('#ddlPorqueSinLactancia', parent.document).val();
                objEncuentroEducativoDetalle.perimetroBraquial = $('#txtPerimetroBraquial', parent.document).val();
                objEncuentroEducativoDetalle.perimetroCefalico = $('#txtPerimetroCefalico', parent.document).val();
                objEncuentroEducativoDetalle.observaciones = $('#txtObservaciones', parent.document).val();

                ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarEncuentroEducativoDetalle', 'POST', objEncuentroEducativoDetalle, function (resp) {
                    try {

                        datosJson = JSON.parse(resp.d);
                        /*alerta(datosJson.mensaje, datosJson.tipoMensaje);*/

                        //Si el resultado fue exitoso
                        if (datosJson.resultado) {
                            CloseModalBox3();
                            tablaParticipantes.ajax.reload();

                            setTimeout(function () { $("#grdParticipantes", parent.document).show().css('width', '100%'); }, 200);

                            if (idEncuentroEducativoDetalle == '')
                                alerta('Se ha iniciado el encuentro educativo satisfactoriamente.', 'Exito');
                            else
                                alerta(datosJson.mensaje, datosJson.tipoMensaje)

                        }
                        else
                            alerta(datosJson.mensaje, 'Error');
                    }
                    catch (e) {
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                    }
                });

            }

            function EliminarParticipante(idEncuentroEducativoDetalle, nombre) {
                if (tablaParticipantes.data().length > 1) {
                    confirmar('Está seguro que desea eliminar el participante ' + nombre + ' del encuentro?', 'Advertencia', function () {

                        var campos = 'idEncuentroEducativoDetalle,nombre'
                        var valores = idEncuentroEducativoDetalle + ',' + nombre;

                        ejecutarMetodoAsync('../WebMethods.aspx/EliminarEncuentroEducativoDetalle', 'POST', campos, valores, function (resp) {
                            try {

                                datosJson = JSON.parse(resp.d);
                                setTimeout(function () { alerta(datosJson.mensaje, datosJson.tipoMensaje) }, 100);

                                if (datosJson.resultado)
                                    tablaParticipantes.ajax.reload();
                            }
                            catch (e) {
                                alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                            }
                        });
                    });
                }
                else
                    alerta('No se puede eliminar el registro, ya que el encuentro debe tener como mínimo un participante.', 'Advertencia');
            }

            function Eliminar(idEncuentroEducativo, fecha) {
                if (fechaValida(fecha)) {
                    confirmar('Está seguro que desea eliminar el encuentro educativo con código: ' + idEncuentroEducativo + '?', 'Advertencia', function () {

                        var campos = 'idEncuentroEducativo'
                        var valores = idEncuentroEducativo;

                        ejecutarMetodoAsync('../WebMethods.aspx/EliminarEncuentroEducativo', 'POST', campos, valores, function (resp) {
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
                else
                    alerta('No se puede eliminar el encuentro educativo, ya que se ha superado la fecha límite.', 'Advertencia');
            }

            function fechaValida(fecha) {
                var mfecha = moment(fecha, 'DD/MM/YYYY');
                var mfechaActual = moment();

                if (mfecha.month() == mfechaActual.month())
                    return true;
                else if (mfechaActual.date() <= 5 && mfecha.month() == (mfechaActual.month() - 1))
                    return true;
                else if (mfechaActual.date() > 5 && mfecha.month() < mfechaActual.month())
                    return false;
                else
                    return false;
            }

            var picker;

            function successPopup(idEncuentroEducativo, nuevo) {

                if (nuevo == 'S') {

                    parent.loading(true);

                    error = false;

                    var refreshId = setInterval(function () {

                        if (($("#ddlProgramacion option:selected", parent.document).text() != '' &&
                            $("#ddlTema option:selected", parent.document).text() != '' ) ||
                            error
                        ) {
                            clearInterval(refreshId);
                            parent.loading(false);
                        }
                    }, 10);

                    $('#dvIdEncuentroEducativo', parent.document).hide();
                    cargarCronogramaEncuentro();
                    cargarGeneralidad('TITE', $("#ddlTema", parent.document));
                    $('#flArchivo', parent.document).filestyle();
                }
                else {
                    $('#dvIdEncuentroEducativo', parent.document).show();
                    $('#txtIdEncuentroEducativo', parent.document).val(idEncuentroEducativo);
                    parent.loading(true);

                    error = false;

                    var refreshId = setInterval(function () {

                        if (($("#ddlProgramacion option:selected", parent.document).text() != '' &&
                            tablaParticipantes.data().length > 0 &&
                            $("#ddlTema option:selected", parent.document).text() != '') ||
                            error
                        ) {
                            clearInterval(refreshId);
                            parent.loading(false);
                        }
                    }, 10);

                    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerEncuentroEducativo', 'POST', 'idEncuentroEducativo', idEncuentroEducativo, function (resp) {
                        try {
                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                var datos = JSON.parse(datosJson.mensaje);

                                $('#flArchivo', parent.document).hide();
                                $('#hidNombreArchivoGuid', parent.document).val(datos[0].nombreArchivoGuid);

                                ejecutarMetodoAsync('../WebMethods.aspx/EsAdmin', 'GET', '', '', function (resp) {

                                    var datosJson2 = JSON.parse(resp.d);

                                    if (datosJson2.resultado) {
                                        $('#flArchivo', parent.document).show();
                                        $('#btnCargar', parent.document).show();
                                        $('#flArchivo', parent.document).filestyle();

                                        $('#btnCargar', parent.document).on('click', function () {

                                            if ($('#flArchivo', parent.document).get(0).files.length == 0)
                                                alerta('Debe seleccionar un archivo para cargar', 'Advertencia');
                                            else {

                                                var form_data = new FormData();
                                                form_data.append('file', $('#flArchivo', parent.document).get(0).files[0]);
                                                form_data.append('TipoArchivo', 'Planilla');
                                                form_data.append('NombreArchivo', datos[0].nombreArchivoGuid);

                                                $.ajax({
                                                    url: './loadFile.aspx',  //Server script to process data
                                                    type: 'POST',
                                                    async: false,
                                                    success: function (result, status, response) {

                                                        $('.bootstrap-filestyle input', parent.document).val('');
                                                        $('#flArchivo', parent.document).val('');
                                                        alerta('Se ha actualizado el archivo de planilla exitosamente.', 'Exito');

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
                                });
                                
                                ejecutarMetodoAsync('../WebMethods.aspx/ObtenerCronogramaEncuentroEditar', 'POST', 'idProgramacionActividades', datos[0].idProgramacionActividades, function (resp) {

                                    var datosJson2 = JSON.parse(resp.d);

                                    if (datosJson2.resultado) {
                                        var datos = JSON.parse(datosJson2.mensaje);
                                        cronogramas = datos;

                                        permiteEliminar = fechaValida(datos[0].fecha);
                                        cargarParticipantes();

                                        if (!permiteEliminar)
                                            $('#btnAgregar', parent.document).hide();

                                        $('#ddlProgramacion', parent.document).empty();
                                        $('#ddlProgramacion', parent.document).append('<option value="' + datos[0].idProgramacionActividades + '" selected>' + datos[0].fechaHora + '</option>');
                                    }
                                });


                                cargarGeneralidad('TITE', $("#ddlTema", parent.document), datos[0].idTema);
                                $('#aArchivo', parent.document).show();
                                $('#aArchivo', parent.document).html(datos[0].nombreArchivo);

                                $('#aArchivo', parent.document).on('click', function () {
                                    window.open('../ExportarDatos.aspx?exportar=Planilla&nombreArchivoGuid=' + datos[0].nombreArchivoGuid + '&nombreArchivo=' + datos[0].nombreArchivo);
                                });

                                $('#ddlProgramacion', parent.document).prop("disabled", true);
                                $('#ddlTema', parent.document).prop("disabled", true);
                                $('#dvAgregar', parent.document).show();
                                $('#dvGridAgregar', parent.document).show();
                                $('#Iniciar', parent.document).hide();

                                $('#btnAgregar', parent.document).off('click');
                                $('#btnAgregar', parent.document).on('click', function () { btnAgregar('', 'S'); });
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

            function successPopupParticipante(idEncuentroEducativo, idProgramacionActividades, nuevo, idEncuentroEducativoDetalle) {
                $('#chkAsistencia', parent.document).on('ifChanged', function (event) {
                    if (event.target.checked) {
                        $('#ddlMotivoInasistencia', parent.document).val('').prop('disabled', true);
                        $('#chkTieneExcusa', parent.document).iCheck('uncheck').prop('disabled', true);
                        $('#ddlLactancia', parent.document).val('').prop('disabled', false);
                        $('#ddlMesLactanciaExclusiva', parent.document).val('').prop('disabled', false);
                        $('#ddlPorqueSinLactancia', parent.document).val('').prop('disabled', false);
                    }
                    else {
                        $('#ddlMotivoInasistencia', parent.document).prop('disabled', false);
                        $('#chkTieneExcusa', parent.document).prop('disabled', false);
                        $('#ddlLactancia', parent.document).val('').prop('disabled', true);
                        $('#ddlMesLactanciaExclusiva', parent.document).val('').prop('disabled', true);
                        $('#ddlPorqueSinLactancia', parent.document).val('').prop('disabled', true);
                    }
                });

                $('#ddlLactancia', parent.document).on('change', function (e) {
                    if ($('#ddlLactancia', parent.document).val() == 'LACT004')
                        $("#ddlPorqueSinLactancia", parent.document).prop("disabled", false);
                    else
                        $("#ddlPorqueSinLactancia", parent.document).val('').prop("disabled", true);
                });

                $('#txtPeso', parent.document).on('keypress', function (e) { keypressDecimal(e, 3, 1, '.'); });
                $('#txtTalla', parent.document).on('keypress', function (e) { keypressDecimal(e, 3, 1, '.'); });
                $('#txtPerimetroBraquial', parent.document).on('keypress', function (e) { keypressDecimal(e, 2, 1, '.'); });
                $('#txtPerimetroCefalico', parent.document).on('keypress', function (e) { keypressDecimal(e, 2, 1, '.'); });

                var cronograma = $(cronogramas).filter(function (i, n) {
                    return n.idProgramacionActividades === $('#ddlProgramacion', parent.document).val();
                });

                if (cronograma[0].idTipoEncuentro == 'TIEN001') {
                    $('#txtPeso', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#txtTalla', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#txtPerimetroBraquial', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#txtPerimetroCefalico', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#ddlDXNutricional', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#ddlLactancia', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#ddlMesLactanciaExclusiva', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#ddlPorqueSinLactancia', parent.document).prop('disabled', true).parent().hide().prev().hide();
                }

                if (cronograma[0].idTipoEncuentro == 'TIEN003') {
                    $('#txtPeso', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#txtTalla', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#txtPerimetroBraquial', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#txtPerimetroCefalico', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    $('#ddlDXNutricional', parent.document).prop('disabled', true).parent().hide().prev().hide();
                    //$('#ddlLactancia', parent.document).prop('disabled', true).parent().hide().prev().hide();
                }

                if (nuevo == 'S') {

                    cargarParticipantesEncuentro(idEncuentroEducativo, idProgramacionActividades);

                    parent.configSelect2WhitOnChangeControl('ddlParticipante', function (event) {
                        if (event.target.value != '')
                            cargarCicloVital(event.target.value);
                        else
                            $('#ddlCicloVital', parent.document).val('');
                    });

                    $('#chkExtemporane', parent.document).on('ifChanged', function (event) {
                        cargarParticipantesEncuentro(idEncuentroEducativo, idProgramacionActividades);
                    });

                    $('#ddlMotivoInasistencia', parent.document).prop('disabled', true);
                    cargarGeneralidad('MOIN', $('#ddlMotivoInasistencia', parent.document));
                    cargarGeneralidad('LACT', $('#ddlLactancia', parent.document));
                    cargarGeneralidad('LACE', $('#ddlMesLactanciaExclusiva', parent.document));
                    cargarGeneralidad('SLAC', $('#ddlPorqueSinLactancia', parent.document));

                    $('#ddlCicloVital', parent.document).on('change', function () {
                        cargarGeneralidad('DXNU', $('#ddlDXNutricional', parent.document), null, $('#ddlCicloVital', parent.document).val());
                    });
                    
                    cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document));
                }
                else {

                    parent.loading3(true);

                    error = false;

                    var refreshId = setInterval(function () {

                        if ($("#ddlCicloVital option:selected", parent.document).val() != '' ||
                            error
                        ) {
                            clearInterval(refreshId);
                            parent.loading3(false);
                        }
                    }, 10);

                    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerEncuentroEducativoDetalle', 'POST', 'idEncuentroEducativoDetalle', idEncuentroEducativoDetalle, function (resp) {
                        try {
                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                var datos = JSON.parse(datosJson.mensaje);

                                if (!permiteEliminar) {
                                    $('#Guardar', parent.document).hide();
                                    $('#chkAsistencia', parent.document).prop('disabled', true);
                                    $('#ddlMotivoInasistencia', parent.document).prop('disabled', true);
                                    $('#chkTieneExcusa', parent.document).prop('disabled', true);
                                    $('#txtPeso', parent.document).prop('disabled', true);
                                    $('#txtTalla', parent.document).prop('disabled', true);
                                    $('#ddlDXNutricional', parent.document).prop('disabled', true);
                                    $('#ddlLactancia', parent.document).prop('disabled', true);
                                    $('#ddlMesLactanciaExclusiva', parent.document).prop('disabled', true);
                                    $('#ddlPorqueSinLactancia', parent.document).prop('disabled', true);
                                    $('#txtPerimetroBraquial', parent.document).prop('disabled', true);
                                    $('#txtPerimetroCefalico', parent.document).prop('disabled', true);
                                    $('#txtObservaciones', parent.document).prop('disabled', true);
                                }

                                $('#dvExtemporaneo', parent.document).hide();
                                $('#ddlParticipante', parent.document).prop('disabled', true);

                                ejecutarMetodoAsync('../WebMethods.aspx/ObtenerCaracterizacion', 'POST', 'numeroIdentificacion', datos[0].numeroIdentificacion, function (resp) {
                                    try {
                                        datosJson = JSON.parse(resp.d);

                                        if (datosJson.resultado) {
                                            var datos2 = JSON.parse(datosJson.mensaje);

                                            $('#ddlParticipante', parent.document).append('<option value="' + datos[0].numeroIdentificacion + '" selected>' + datos[0].numeroIdentificacion  + ' - ' + [datos2[0].primerNombre,
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

                                cargarGeneralidad('MOIN', $('#ddlMotivoInasistencia', parent.document), datos[0].idMotivoInasistencia);
                                /*cargarGeneralidad('LACT', $('#ddlDXNutricional', parent.document), datos[0].dXNutricional);*/
                                cargarGeneralidad('LACT', $('#ddlLactancia', parent.document), datos[0].idLactancia);
                                cargarGeneralidad('LACE', $('#ddlMesLactanciaExclusiva', parent.document), datos[0].idMesLactanciaExclusiva);
                                cargarGeneralidad('SLAC', $('#ddlPorqueSinLactancia', parent.document), datos[0].idPorqueSinLactancia);

                                $('#ddlCicloVital', parent.document).on('change', function () {
                                    cargarGeneralidad('DXNU', $('#ddlDXNutricional', parent.document), datos[0].dXNutricional, $('#ddlCicloVital', parent.document).val());
                                });

                                cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document), datos[0].idCicloVital);

                                if (datos[0].asistencia == 'True') {
                                    $('#chkAsistencia', parent.document).iCheck('check');
                                    $('#ddlMotivoInasistencia', parent.document).prop('disabled', true);
                                    $('#ddlLactancia', parent.document).val('').prop('disabled', false);
                                    $('#ddlMesLactanciaExclusiva', parent.document).val('').prop('disabled', false);
                                    $('#ddlPorqueSinLactancia', parent.document).val('').prop('disabled', false);
                                }
                                else {
                                    $('#chkAsistencia', parent.document).iCheck('uncheck');
                                    $('#ddlMotivoInasistencia', parent.document).prop('disabled', false);
                                    $("#ddlLactancia", parent.document).val('').prop("disabled", true);
                                    $("#ddlMesLactanciaExclusiva", parent.document).val('').prop("disabled", true);
                                    $("#ddlPorqueSinLactancia", parent.document).val('').prop("disabled", true);
                                }

                                if (datos[0].tieneExcusa == 'True')
                                    $('#chkTieneExcusa', parent.document).iCheck('check');
                                else
                                    $('#chkTieneExcusa', parent.document).iCheck('uncheck');

                                $('#txtObservaciones', parent.document).val(datos[0].observaciones);
                                $('#txtPeso', parent.document).val(datos[0].peso);
                                $('#txtTalla', parent.document).val(datos[0].talla);
                                $('#txtPerimetroBraquial', parent.document).val(datos[0].perimetroBraquial);
                                $('#txtPerimetroCefalico', parent.document).val(datos[0].perimetroCefalico);
                            }
                            else {
                                alerta(datosJson.mensaje, datosJson.tipoMensaje);
                                CloseModalBox3();
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

                            if (tipoGeneralidad == 'TICV' && value != null)
                                $(control).trigger('change');
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            var cronogramas;

            // con este cargamos los cronogramas que tenemos en el sistema
            function cargarCronogramaEncuentro(idCronograma) {

                $.ajax({
                    type: "GET",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ObtenerCronogramaEncuentro',                 // URL al que vamos a hacer el pedido
                    data: null,                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        $('#ddlProgramacion', parent.document).empty();
                        $('#ddlProgramacion', parent.document).append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            cronogramas = informacion;

                            $.each(informacion, function (index, value) {
                                $('#ddlProgramacion', parent.document).append('<option value="' + value.idProgramacionActividades + '">' + value.fechaHora + '</option>');
                            });

                            if (idCronograma != null)
                                $('#ddlProgramacion', parent.document).val(idCronograma);

                            parent.configSelect2Control('ddlProgramacion');
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                        error = true;
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los cronogramas que tenemos en el sistema
            function cargarParticipantesEncuentro(idEncuentroEducativo, idProgramacionActividades, idParticipante) {

                var data = new Object();
                data.idEncuentroEducativo = idEncuentroEducativo;
                data.idProgramacionActividades = idProgramacionActividades;
                data.extemporaneo = ($('#chkExtemporane', parent.document).is(':checked') ? 'S' : 'N');

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarParticipantesEncuentro',                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(data),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        $('#ddlParticipante', parent.document).empty();
                        $('#ddlParticipante', parent.document).append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $('#ddlParticipante', parent.document).append('<option value="' + value.numeroIdentificacion + '">' + value.nombre + '</option>');
                            });

                            parent.configSelect2Control('ddlParticipante');

                            if (idParticipante !== undefined && idParticipante != '')
                                parent.valSelect2('ddlParticipante', idParticipante);
                        }
                        else
                            parent.configSelect2Control('ddlParticipante');
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
                                $('#ddlMesLactanciaExclusiva', parent.document).val('').prop('disabled', true);
                                $('#ddlPorqueSinLactancia', parent.document).val('').prop('disabled', true);
                                $('#txtPerimetroCefalico', parent.document).val('').prop('disabled', true);
                                $('#txtPerimetroBraquial', parent.document).val('').prop('disabled', true);


                            }
                            else {

                                var cronograma = $(cronogramas).filter(function (i, n) {
                                    return n.idProgramacionActividades === $('#ddlProgramacion', parent.document).val();
                                });

                                if (cronograma[0].idTipoEncuentro != 'TIEN001' /*|| cronograma[0].idTipoEncuentro != 'TIEN003'*/) {

                                    $('#ddlLactancia', parent.document).prop('disabled', false);
                                    $('#ddlMesLactanciaExclusiva', parent.document).prop('disabled', false);
                                    $('#ddlPorqueSinLactancia', parent.document).prop('disabled', false);
                                    $('#txtPerimetroCefalico', parent.document).prop('disabled', false);
                                    $('#txtPerimetroBraquial', parent.document).prop('disabled', false);
                                }
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

