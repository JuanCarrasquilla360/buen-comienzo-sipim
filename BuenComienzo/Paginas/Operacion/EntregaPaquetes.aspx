<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntregaPaquetes.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.EntregaPaquetes" %>

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
    <form id="EntregaPaquetes" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Entrega de paquetes
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
                            <table id="grdEntregaPaquetes" class="table table-bordered table-striped">
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
                this.tabla = $("#grdEntregaPaquetes").DataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [{
                        'targets': 6,
                        'orderable': false,
                        'width': "18px"
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id Entrega Paquete', 'Fecha', 'Uba', 'Coordinador', 'Usuario Creación', 'Fecha Creación', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarEntregaPaquetes",
                    "drawCallback": function (settings) {
                        $('#framePrincipal', parent.document).css('height', document.body.scrollHeight + 'px');

                        $('#grdgrdEntregaPaquetes :input[type="checkbox"].flat-red').iCheck({
                            checkboxClass: 'icheckbox_flat-red'
                        });

                        $('grdgrdEntregaPaquetes :input[type="checkbox"].flat-red').parent().parent().parent().css('text-align', 'center');
                        $('grdgrdEntregaPaquetes :input[type="checkbox"].flat-red').attr('disabled', 'disabled');
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
                                    $("#grdgrdEntregaPaquetes").show().css('width', '100%');
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
                        { 'targets': 7, 'orderable': false, 'width': "20px" }
                    ],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id Entrega Paquete Detalle', 'Numero de identificacion', 'Nombre', 'Ciclo Vital', 'Paquete', 'Bienestarina', 'Complemento', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarEntregaPaquetesDetalle",
                    "drawCallback": function (settings) {

                        $('#grdParticipantes :input[type="checkbox"].flat-red', parent.document).iCheck({
                            checkboxClass: 'icheckbox_flat-red'
                        });

                        $('#grdParticipantes :input[type="checkbox"].flat-red', parent.document).parent().parent().parent().css('text-align', 'center');
                        $('#grdParticipantes :input[type="checkbox"].flat-red', parent.document).attr('disabled', 'disabled');
                    },
                    "fnServerData": function (sSource, aoData, fnCallback) {
                        //Se agrega el idEntregaPaquete
                        aoData.push({ name: 'idEntregaPaquete', value: $('#txtIdEntregaPaquete', parent.document).val() });

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

            function Editar(idEntregaPaquete, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nuevo Entrega Paquete' : 'Editar Entrega Paquete',
                    'width': '900',
                    'url': './Popups/EditarEntregaPaquete.aspx',
                    'buttons': [{
                        'name': 'Iniciar',
                        'click': function () {
                            if ($('#EditarEntregaPaquete', parent.document).isValid()) {

                                $('#txtfecha', parent.document).prop("disabled", true).css("background-color", "#eee");
                                $('#ddlCoordinador', parent.document).prop("disabled", true);
                                $('#ddlUbas', parent.document).prop("disabled", true);
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
                }, function () { successPopup(idEntregaPaquete, nuevo); });

                //Se configuran la validación
                parent.configFormValidate('EditarEntregaPaquete', 'date, security');
            }

            function btnAgregar(idEntregaPaqueteDetalle, nuevo) {
                openPopup3({
                    'title': (nuevo == 'S') ? 'Nuevo Participante' : 'Editar Participante',
                    'width': '800',
                    'url': './Popups/ParticipanteEntregaPaquete.aspx',
                    'buttons': [{
                        'name': (nuevo == 'S' ) ? 'Agregar' : 'Guardar',
                        'click': function () {

                            if ($('#ParticipanteEntregaPaquete', parent.document).isValid()) {

                                (nuevo == 'S') ? $('#Agregar', parent.document).prop('disabled', true) : $('#Guardar', parent.document).prop('disabled', true);

                                if ($('#txtIdEntregaPaquete', parent.document).val() == '') {

                                    var form_data = new FormData();
                                    form_data.append('file', $('#flArchivo', parent.document).get(0).files[0]);
                                    form_data.append('TipoArchivo', 'PlanillaPaquetes');

                                    $.ajax({
                                        url: './loadFile.aspx',  //Server script to process data
                                        type: 'POST',
                                        async: false,
                                        success: function (result, status, response) {

                                            var objEntregaPaquete = new Object();
                                            objEntregaPaquete.nuevo = nuevo;
                                            objEntregaPaquete.idEntregaPaquete = '0';
                                            objEntregaPaquete.fecha = $('#txtfecha', parent.document).val();
                                            objEntregaPaquete.idCoordinador = $('#ddlCoordinador', parent.document).val();
                                            objEntregaPaquete.idUba = $('#ddlUbas', parent.document).val();
                                            objEntregaPaquete.nombreArchivoGuid = response.statusText;
                                            objEntregaPaquete.fileName = $('#flArchivo', parent.document).get(0).files[0].name;

                                            ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarEntregaPaquete', 'POST', objEntregaPaquete, function (resp) {
                                                try {

                                                    datosJson = JSON.parse(resp.d);

                                                    if (datosJson.resultado) {
                                                        $('#dvIdEntregaPaquete', parent.document).show();
                                                        $('#txtIdEntregaPaquete', parent.document).val(datosJson.mensaje);

                                                        tabla.ajax.reload();

                                                        ActualizarParticipante('');
                                                    }
                                                    else
                                                        alerta(datosJson.mensaje, datosJson.tipoMensaje);
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
                                else {
                                    ActualizarParticipante(idEntregaPaqueteDetalle);
                                }
                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox3();
                        }
                    }]
                }, function () { successPopupParticipante($('#txtIdEntregaPaquete', parent.document).val(), $('#ddlUbas', parent.document).val(), nuevo, idEntregaPaqueteDetalle); });

                $('#ParticipanteEntregaPaquete :input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran la validación
                parent.configFormValidate('ParticipanteEntregaPaquete', 'date, security');
            }

            function ActualizarParticipante(idEntregaPaqueteDetalle) {

                var objEntregaPaqueteDetalle = new Object();
                objEntregaPaqueteDetalle.nuevo = (idEntregaPaqueteDetalle == '') ? 'S' : 'N';
                objEntregaPaqueteDetalle.idEntregaPaqueteDetalle = idEntregaPaqueteDetalle;
                objEntregaPaqueteDetalle.idEntregaPaquete = $('#txtIdEntregaPaquete', parent.document).val();
                objEntregaPaqueteDetalle.numeroIdentificacion = $('#ddlParticipante', parent.document).val();
                objEntregaPaqueteDetalle.idCicloVital = $('#ddlCicloVital', parent.document).val();
                objEntregaPaqueteDetalle.paquete = $('#ddlPaquete', parent.document).val();
                objEntregaPaqueteDetalle.bienestarina = $('#ddlBienestarina', parent.document).val();
                objEntregaPaqueteDetalle.complemento = $('#ddlComplemento', parent.document).val();

                ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarEntregaPaqueteDetalle', 'POST', objEntregaPaqueteDetalle, function (resp) {
                    try {

                        datosJson = JSON.parse(resp.d);
                        /*alerta(datosJson.mensaje, datosJson.tipoMensaje);*/

                        //Si el resultado fue exitoso
                        if (datosJson.resultado) {
                            CloseModalBox3();
                            tablaParticipantes.ajax.reload();

                            setTimeout(function () { $("#grdParticipantes", parent.document).show().css('width', '100%'); }, 200);

                            if (idEntregaPaqueteDetalle == '')
                                alerta('Se ha iniciado la entrega de paquete satisfactoriamente.', 'Exito');
                            else
                                alerta(datosJson.mensaje, datosJson.tipoMensaje)  

                        }
                    }
                    catch (e) {
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                    }
                });

            }

            function EliminarParticipante(idEntregaPaqueteDetalle, nombre) {
                if (tablaParticipantes.data().length > 1) {
                    confirmar('Está seguro que desea eliminar el participante ' + nombre + ' de la entrega de paquetes?', 'Advertencia', function () {

                        var campos = 'idEntregaPaqueteDetalle,nombre'
                        var valores = idEntregaPaqueteDetalle + ',' + nombre;

                        ejecutarMetodoAsync('../WebMethods.aspx/EliminarEntregaPaqueteDetalle', 'POST', campos, valores, function (resp) {
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
                    alerta('No se puede eliminar el registro, ya que la entrega de paquetes debe tener como mínimo un participante.', 'Advertencia');
            }

            function Eliminar(idEntregaPaquete, fecha) {
                if (fechaValida(fecha)) {
                    confirmar('Está seguro que desea eliminar la entrega de paquetes con código: ' + idEntregaPaquete + '?', 'Advertencia', function () {

                        var campos = 'idEntregaPaquete'
                        var valores = idEntregaPaquete;

                        ejecutarMetodoAsync('../WebMethods.aspx/EliminarEntregaPaquete', 'POST', campos, valores, function (resp) {
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
                    alerta('No se puede eliminar la entrega de paquetes, ya que se ha superado la fecha límite.', 'Advertencia');
            }

            function fechaValida(fecha) {

                var mfecha

                if (fecha) {
                    mfecha = moment(fecha, 'DD/MM/YYYY');

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
                else {
                    mfecha = moment();

                    if (mfecha.date() > 5)
                        return false;
                    else
                        return true;
                }

                
            }

            var pickerFechaCaracterizacion;

            function successPopup(idEntregaPaquete, nuevo) {

                if (nuevo == 'S') {
                    pickerFechaCaracterizacion = parent.TempusDominusDateTimePicker('fecha', "dd/MM/yyyy", false, false, 1, (fechaValida() ? 1 : 0), (fechaValida() ? 0 : 1));
                    cargarCoordinadores();
                    parent.configSelect2Control("ddlCoordinador").on('change', function () {

                        if ($("ddlUbas", parent.document).val() != '')
                            $("ddlUbas", parent.document).val('');

                        cargarUbas();
                    });

                    $('#dvIdEntregaPaquete', parent.document).hide();
                    $('#flArchivo', parent.document).filestyle();
                }
                else {
                    $('#dvIdEntregaPaquete', parent.document).show();
                    $('#txtIdEntregaPaquete', parent.document).val(idEntregaPaquete);

                    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerEntregaPaquete', 'POST', 'idEntregaPaquete', idEntregaPaquete, function (resp) {
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
                                                form_data.append('TipoArchivo', 'PlanillaPaquetes');
                                                form_data.append('NombreArchivo', datos[0].nombreArchivoGuid);

                                                $.ajax({
                                                    url: './loadFile.aspx',  //Server script to process data
                                                    type: 'POST',
                                                    async: false,
                                                    success: function (result, status, response) {

                                                        $('.bootstrap-filestyle input', parent.document).val('');
                                                        $('#flArchivo', parent.document).val('');
                                                        alerta('Se ha actualizado el archivo de planilla de entrega del paquete exitosamente.', 'Exito');

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
                                
                                permiteEliminar = fechaValida(datos[0].fecha);
                                cargarParticipantes();
                                cargarCoordinadores(datos[0].idCoordinador, datos[0].idUba);

                                $('#aArchivo', parent.document).show();
                                $('#aArchivo', parent.document).html(datos[0].nombreArchivo);

                                $('#aArchivo', parent.document).on('click', function () {
                                    window.open('../ExportarDatos.aspx?exportar=PlanillaPaquetes&nombreArchivoGuid=' + datos[0].nombreArchivoGuid + '&nombreArchivo=' + datos[0].nombreArchivo);
                                });

                                $('#txtfecha', parent.document).val(datos[0].fecha).prop("disabled", true).css("background-color", "#eee");
                                $('#ddlCoordinador', parent.document).prop("disabled", true);
                                $('#ddlUbas', parent.document).prop("disabled", true);
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

            function successPopupParticipante(idEntregaPaquete, idUba, nuevo, idEntregaPaqueteDetalle) {

                if (nuevo == 'S') {

                    cargarParticipantesEncuentro(idEntregaPaquete, idUba);

                    parent.configSelect2WhitOnChangeControl('ddlParticipante', function (event) {
                        if (event.target.value != '')
                            cargarCicloVital(event.target.value);
                        else
                            $('#ddlCicloVital', parent.document).val('');
                    });

                    $('#chkExtemporane', parent.document).on('ifChanged', function (event) {
                        cargarParticipantesEncuentro(idEntregaPaquete, idUba);
                    });

                    cargarGeneralidad('SINO', $('#ddlPaquete', parent.document));
                    cargarGeneralidad('SINO', $('#ddlBienestarina', parent.document));
                    cargarGeneralidad('SINO', $('#ddlComplemento', parent.document).prop('disabled', true));
                    cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document));
                }
                else {
                    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerEntregaPaqueteDetalle', 'POST', 'idEntregaPaqueteDetalle', idEntregaPaqueteDetalle, function (resp) {
                        try {
                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                var datos = JSON.parse(datosJson.mensaje);

                                if (!permiteEliminar) {
                                    $('#Guardar', parent.document).hide();
                                    $('#ddlPaquete', parent.document).prop('disabled', true);
                                    $('#ddlBienestarina', parent.document).prop('disabled', true);
                                    $('#ddlComplemento', parent.document).prop('disabled', true);
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

                                cargarGeneralidad('SINO', $('#ddlPaquete', parent.document), datos[0].paquete);
                                cargarGeneralidad('SINO', $('#ddlBienestarina', parent.document), datos[0].bienestarina);
                                cargarGeneralidad('SINO', $('#ddlComplemento', parent.document), datos[0].complemento);
                                cargarGeneralidad('TICV', $('#ddlCicloVital', parent.document), datos[0].idCicloVital);
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

            // con este cargamos los cronogramas que tenemos en el sistema
            function cargarParticipantesEncuentro(idEntregaPaquete, idUba, idParticipante) {

                var data = new Object();
                data.idCoordinador = $('#ddlCoordinador', parent.document).val();
                data.idEntregaPaquete = idEntregaPaquete;
                data.idUba = idUba;
                data.extemporaneo = ($('#chkExtemporane', parent.document).is(':checked') ? 'S' : 'N');

                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarParticipantesEntregaPaquete',                 // URL al que vamos a hacer el pedido
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

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarCoordinadores(idCoordinador, idUba) {

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
                                cargarUbas(idUba);
                            }
                            else {
                                parent.valSelect2('ddlCoordinador', '');

                                $('#EditarEntregaPaquete', parent.document).find('.error,.valid').each(function () {
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
            function cargarUbas(idUba) {

                var jsonInput = "{ idCoordinador: '" + $('#ddlCoordinador', parent.document).val() + "' }";
                var obj = eval("(" + jsonInput + ')');

                $.ajax({
                    type: ((idUba != null) ? 'GET' : 'POST'),                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/' + ((idUba != null) ? 'ObtenerUbas' : 'ConsultarCoordinadorUbas'),                 // URL al que vamos a hacer el pedido
                    data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                    // van a ser recibidos por la función del servidor
                    contentType: "application/json; charset=utf-8",            // tipo de contenido
                    dataType: "json",                                          // formato de transmición de datos
                    async: true,                                               // si es asincrónico o no
                    success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                        const data = JSON.parse(resultado.d);

                        $('#ddlUbas', parent.document).empty();
                        $('#ddlUbas', parent.document).append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                        if (data.resultado) {
                            const informacion = JSON.parse(data.mensaje);

                            $.each(informacion, function (index, value) {
                                $('#ddlUbas', parent.document).append('<option value="' + value.idUba + '">' + value.uba + '</option>');
                            });

                            if (idUba != null)
                                $('#ddlUbas', parent.document).val(idUba);
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

