<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrientacionServicio.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.OrientacionServicio" %>

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
    <form id="OrientacionServicio" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Orientación a servicios
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
                            <table id="grdOrientacionServicio" class="table table-bordered table-striped">
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
                this.tabla = $("#grdOrientacionServicio").DataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [{
                        'targets': 8,
                        'orderable': false,
                        'width': "18px"
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Id Orientación', 'Identificación Participante', 'Nombre del participante', 'Fecha', 'Motivo de orientación', 'Cooridnador', 'Usuario Creación', 'Fecha Creación', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarOrientacionServicio",
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
                                    $("#grdOrientacionServicio").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function Editar(idOrientacionServicio, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nueva Orientación a Servicio' : 'Editar Orientación a Servicio',
                    'width': '900',
                    'url': './Popups/EditarOrientacionServicio.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#EditarOrientacionServicio', parent.document).isValid()) {

                                var participante = datosParticipante.find(({ numeroIdentificacion }) => numeroIdentificacion === $('#ddlParticipante', parent.document).val());

                                var form_data = new FormData();
                                form_data.append('file', $('#flArchivo', parent.document).get(0).files[0]);
                                form_data.append('TipoArchivo', 'OrientacionServicio');

                                $.ajax({
                                    url: './loadFile.aspx',  //Server script to process data
                                    type: 'POST',
                                    async: false,
                                    success: function (result, status, response) {

                                        var objOS = new Object();
                                        objOS.nuevo = nuevo;
                                        objOS.idOrientacionServicio = idOrientacionServicio;
                                        objOS.numeroIdentificacion = participante.numeroIdentificacion;
                                        objOS.fechaHora = $('#txtfechaOS', parent.document).val();
                                        objOS.numeroIdentificacionCuidador = $('#txtNumeroIdentificacionCuidador', parent.document).val();
                                        objOS.nombreCuidador = $('#txtNombreCuidador', parent.document).val();
                                        objOS.celularCuidador = $('#txtCelularCuidador', parent.document).val();
                                        objOS.idTipoOS = $('#ddlTipoOS', parent.document).val();
                                        objOS.lugarRemite = $('#txtLugarRemite', parent.document).val();
                                        objOS.observaciones = $('#txtObservaciones', parent.document).val();
                                        objOS.idMatricula = participante.idMatricula;
                                        objOS.nombreArchivoGuid = response.statusText;
                                        objOS.fileName = $('#flArchivo', parent.document).get(0).files[0].name;
                                        objOS.fechaPrimerSeguimiento = $('#txtfechaPrimerSeguimiento', parent.document).val();
                                        objOS.observacionPrimerSeguimiento = $('#txtObservacionPrimerSeguimiento', parent.document).val();
                                        objOS.fechaSegundoSeguimiento = $('#txtfechaSegundoSeguimiento', parent.document).val();
                                        objOS.observacionSegundoSeguimiento = $('#txtObservacionSegundoSeguimiento', parent.document).val();
                                        objOS.orientacionCerrada = ($('#chkOrientacionCerrada', parent.document).is(':checked') ? '1' : '0');
                                                                         
                                        ejecutarMetodoAsync2('../WebMethods.aspx/ActualizarOrientacionServicio', 'POST', objOS, function (resp) {
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
                }, function () { successPopup(idOrientacionServicio, nuevo); });

                $('input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran la validación
                parent.configFormValidate('EditarOrientacionServicio', 'date, security');
            }

            var picker;

            function successPopup(idOrientacionServicio, nuevo) {
                               
                if (nuevo == 'S') {

                    parent.loading(true);

                    error = false;

                    var refreshId = setInterval(function () {

                        if (($("#ddlParticipante option:selected", parent.document).text() != '' &&
                            $("#ddlTipoOS option:selected", parent.document).text() != '') ||
                            error
                        ) {
                            clearInterval(refreshId);
                            parent.loading(false);
                        }
                    }, 10);

                    $('#dvIdOrientacionServicio', parent.document).hide();
                    $('#flArchivo', parent.document).filestyle();

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
                    
                    picker = parent.TempusDominusDateTimePicker('fechaOS', 'dd/MM/yyyy HH:mm', true, true, 15);

                    cargarGeneralidad('TIOS', $("#ddlTipoOS", parent.document));

                    $('#ocuFechaPrimerSeguimiento', parent.document).hide();
                    $('#observacionesPrimerSeguimiento', parent.document).hide();
                    $('#ocuFechaSegundoSeguimiento', parent.document).hide();
                    $('#observacionesSegundoSeguimiento', parent.document).hide();


                }
                else {
                    $('#dvIdOrientacionServicio', parent.document).show();
                    $('#txtIdOrientacionServicio', parent.document).val(idOrientacionServicio);
                    parent.loading(true);

                    ejecutarMetodoAsync('../WebMethods.aspx/ObtenerOrientacionServicio', 'POST', 'idOrientacionServicio', idOrientacionServicio, function (resp) {
                        try {

                            error = false;

                            var refreshId = setInterval(function () {

                                if (($("#ddlParticipante option:selected", parent.document).text() != '' &&
                                    $("#ddlTipoOS option:selected", parent.document).text() != '') ||
                                    error
                                ) {
                                    clearInterval(refreshId);
                                    parent.loading(false);
                                }
                            }, 10);

                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                var datos = JSON.parse(datosJson.mensaje);

                                cargarParticipantes(datos[0].numeroIdentificacion);
                                cargarGeneralidad('TIOS', $("#ddlTipoOS", parent.document), datos[0].idTipoOS);

                                picker = parent.TempusDominusDateTimePicker('fechaOS', 'dd/MM/yyyy HH:mm', true, true, 15);
                                picker = parent.TempusDominusDateTimePicker('fechaPrimerSeguimiento', 'dd/MM/yyyy HH:mm', true, true, 15);
                                picker = parent.TempusDominusDateTimePicker('fechaSegundoSeguimiento', 'dd/MM/yyyy HH:mm', true, true, 15);

                                parent.configSelect2Control('ddlParticipante');
                                $("#ddlParticipante", parent.document).prop("disabled", true);
                                $('#txtfechaOS', parent.document).val(datos[0].fechaHora).prop("disabled", true);
                                $('#txtNumeroIdentificacionCuidador', parent.document).val(datos[0].numeroIdentificacionCuidador).prop("disabled", true);
                                $('#txtNombreCuidador', parent.document).val(datos[0].nombreCuidador).prop("disabled", true);
                                $('#txtCelularCuidador', parent.document).val(datos[0].celularCuidador).prop("disabled", true);
                                $('#ddlTipoOS', parent.document).prop("disabled", true);
                                $('#txtLugarRemite', parent.document).val(datos[0].lugarRemite).prop("disabled", true);
                                $('#txtObservaciones', parent.document).val(datos[0].observaciones).prop("disabled", true);

                                $('#txtfechaPrimerSeguimiento', parent.document).val(datos[0].fechaPrimerSeguimiento);
                                $('#txtObservacionPrimerSeguimiento', parent.document).val(datos[0].observacionPrimerSeguimiento);
                                $('#txtfechaSegundoSeguimiento', parent.document).val(datos[0].fechaSegundoSeguimiento);
                                $('#txtObservacionSegundoSeguimiento', parent.document).val(datos[0].observacionSegundoSeguimiento);

                                if (datos[0].orientacionCerrada == 'True')
                                    $('#chkOrientacionCerrada', parent.document).iCheck('check');
                                else
                                    $('#chkOrientacionCerrada', parent.document).iCheck('uncheck');

                                //$('#flArchivo', parent.document).removeAttr("data-validation");

                                $('#flArchivo', parent.document).show();
                                $('#flArchivo', parent.document).filestyle();
                                $('#hidNombreArchivoGuid', parent.document).val(datos[0].nombreArchivoGuid);

                                $('#aArchivo', parent.document).show();
                                $('#aArchivo', parent.document).html(datos[0].nombreArchivo);

                                $('#aArchivo', parent.document).on('click', function () {
                                    window.open('../ExportarDatos.aspx?exportar=OrientacionServicio&nombreArchivoGuid=' + datos[0].nombreArchivoGuid + '&nombreArchivo=' + datos[0].nombreArchivo);
                                });

                                //ejecutarMetodoAsync('../WebMethods.aspx/NoEsAdmin', 'GET', '', '', function (resp) {

                                //    var datosJson2 = JSON.parse(resp.d);

                                //    if (datosJson2.resultado) {
                                //        $('#flArchivo', parent.document).show();
                                //        $('#btnCargar', parent.document).show();
                                //        $('#flArchivo', parent.document).filestyle();

                                //        $('#btnCargar', parent.document).on('click', function () {

                                //            if ($('#flArchivo', parent.document).get(0).files.length == 0)
                                //                alerta('Debe seleccionar un archivo para cargar', 'Advertencia');
                                //            else {

                                //                var form_data = new FormData();
                                //                form_data.append('file', $('#flArchivo', parent.document).get(0).files[0]);
                                //                form_data.append('TipoArchivo', 'OrientacionServicio');
                                //                form_data.append('NombreArchivo', datos[0].nombreArchivoGuid);

                                //                $.ajax({
                                //                    url: './loadFile.aspx',  //Server script to process data
                                //                    type: 'POST',
                                //                    async: false,
                                //                    success: function (result, status, response) {

                                //                        $('.bootstrap-filestyle input', parent.document).val('');
                                //                        $('#flArchivo', parent.document).val('');
                                //                        alerta('Se ha actualizado el archivo de la orientación a servicio exitosamente.', 'Exito');

                                //                    },
                                //                    error: function (jqXHR, textStatus, errorThrown) {
                                //                        alerta("Error- Status: " + textStatus + " jqXHR Status: " + jqXHR.status + " jqXHR Response Text:" + jqXHR.responseText, 'Error');
                                //                    },
                                //                    // Form data
                                //                    data: form_data,
                                //                    //Options to tell jQuery not to process data or worry about content-type.
                                //                    cache: false,
                                //                    contentType: false,
                                //                    processData: false
                                //                });
                                //            }
                                //        });
                                //    }
                                //});                                

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


        </script>
    </form>

</body>
</html>
