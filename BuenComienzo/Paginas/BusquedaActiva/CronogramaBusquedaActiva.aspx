<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CronogramaBusquedaActiva.aspx.cs"
    Inherits="BuenComienzo.Paginas.BusquedaActiva.CronogramaBusquedaActiva" %>

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
        <form id="CronogramaBusquedaActiva" runat="server">
            <div>
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>Cronograma - Búsqueda Activa
                        <%--<small>Control panel</small>--%>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="../../Index.aspx"><i class="fa fa-home"></i>Inicio</a></li>
                        <li><a href="#"><i class="fa fa-search"></i>Búsqueda Activa</a></li>
                        <li class="active">Cronograma</li>
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
                            'targets': 14,
                            'orderable': false
                        }],
                        "language": {
                            "url": "../../plugins/datatables/Spanish.json"
                        },
                        'aoColumns': columnasJSON(['Id cronograma', 'Fecha encuentro', 'Coordinador', 'Tipo actividad', 'Actividad', 'Comuna', 'Barrio', 'Agente educativo 1', 'Agente educativo 2', 'Punto referencia', 'Observaciones', 'Motivo reprogramación', "Usuario creación", "Fecha creación", '']),
                        "bServerSide": true,
                        "sAjaxSource": "/Paginas/WebMethods.aspx/ConsultarCronogramaBusquedaActiva",
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
                        'title': (nuevo == 'S') ? 'Nuevo cronograma - Búsqueda Activa' : 'Editar cronograma - Búsqueda Activa',
                        'width': '900',
                        'url': './Popups/EditarCronogramaBusquedaActiva.aspx',
                        'buttons': [{
                            'name': 'Guardar',
                            'click': function () {

                                var esValido = true;
                                
                                if (nuevo == 'S') {
                                    // Validación completa para modo nuevo
                                    esValido = $('#EditarCronogramaBusquedaActiva', parent.document).isValid();

                                    // Validar campos de Comuna y Barrio si están visibles
                                    if ($(window.parent.document).find("#dvComunaBarrio").is(':visible')) {
                                        if ($(window.parent.document).find("#ddlComuna").val() === '' ||
                                            $(window.parent.document).find("#ddlBarrio").val() === '') {
                                            alerta('Debe seleccionar Comuna y Barrio cuando el tipo de actividad es Territorio', 'Error');
                                            esValido = false;
                                        }
                                    }

                                    if (esValido) {
                                        // Validar fecha del encuentro
                                        var fechaEncuentro = moment($('#txtfechaEncuentro', parent.document).val(), 'DD/MM/YYYY HH:mm');
                                        var hoy = moment().startOf('day');
                                        var finDelMes = moment().endOf('month');

                                        if (!fechaEncuentro.isValid()) {
                                            alerta('La fecha del encuentro no es válida', 'Error');
                                            return;
                                        }

                                        if (fechaEncuentro.isBefore(hoy)) {
                                            alerta('La fecha del encuentro no puede ser anterior a hoy', 'Error');
                                            return;
                                        }

                                        if (fechaEncuentro.isAfter(finDelMes)) {
                                            alerta('La fecha del encuentro no puede ser posterior al final del mes actual', 'Error');
                                            return;
                                        }
                                    }
                                } else {
                                    // Validación simple para modo edición - solo reprogramación
                                    if ($('#ddlMotivoReprogramacion', parent.document).val() === '') {
                                        alerta('Debe seleccionar un motivo de reprogramación', 'Error');
                                        esValido = false;
                                    }
                                }

                                if (esValido) {
                                    $('#Guardar', parent.document).prop('disabled', true);

                                    // Validar agentes diferentes solo en modo nuevo
                                    var agentesValidos = true;
                                    if (nuevo == 'S') {
                                        if ($('#ddlAgenteEducativo1', parent.document).val() == $('#ddlAgenteEducativo2', parent.document).val()) {
                                            agentesValidos = false;
                                        }
                                    }

                                    if (agentesValidos) {

                                        var objCronograma = new Object();
                                        objCronograma.nuevo = nuevo;
                                        objCronograma.IdCronograma = idProgramacionActividades;
                                        
                                        if (nuevo == 'S') {
                                            // Modo nuevo - todos los campos
                                            objCronograma.idCoordinador = $('#ddlCoordinador', parent.document).val();
                                            objCronograma.fecha = $('#txtfechaEncuentro', parent.document).val();
                                            objCronograma.idAgenteEducativo1 = $('#ddlAgenteEducativo1', parent.document).val();
                                            objCronograma.idAgenteEducativo2 = $('#ddlAgenteEducativo2', parent.document).val();
                                            objCronograma.puntoReferencia = $('#txtPuntoReferencia', parent.document).val();
                                            objCronograma.observaciones = $('#txtObservaciones', parent.document).val();
                                            objCronograma.idActividad = $('#ddlActividades', parent.document).val();
                                            objCronograma.idTipoActividad = $('#ddlTipoActividades', parent.document).val();
                                            objCronograma.idComuna = $('#ddlComuna', parent.document).val();
                                            objCronograma.idBarrio = $('#ddlBarrio', parent.document).val();
                                            objCronograma.motivoReprogramacion = '';
                                            objCronograma.observacionesReprogramacion = '';
                                        } else {
                                            // Modo edición - solo reprogramación
                                            objCronograma.motivoReprogramacion = $('#ddlMotivoReprogramacion', parent.document).val();
                                            objCronograma.observacionesReprogramacion = $('#txtObservacionesReprogramacion', parent.document).val();
                                            
                                            // Campos vacíos para edición
                                            objCronograma.idCoordinador = '';
                                            objCronograma.fecha = '';
                                            objCronograma.idAgenteEducativo1 = '';
                                            objCronograma.idAgenteEducativo2 = '';
                                            objCronograma.puntoReferencia = '';
                                            objCronograma.observaciones = '';
                                            objCronograma.idActividad = '';
                                            objCronograma.idTipoActividad = '';
                                            objCronograma.idComuna = '';
                                            objCronograma.idBarrio = '';
                                        }

                                        console.log(objCronograma);
                                        debugger
                                        ejecutarMetodoAsync2('/Paginas/WebMethods.aspx/ActualizarCronogramaBusquedaActiva', 'POST', objCronograma, function (resp) {
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
                                    } else {
                                        alerta('El agente educativo 1 no puede ser igual al agente educativo 2. por favor verificar ', 'Error');
                                    }
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
                    validate = parent.configFormValidate('EditarCronogramaBusquedaActiva', 'date, security');
                }

                var picker;

                function successPopup(idProgramacionActividades, nuevo) {
                    console.log("successPopup llamado con nuevo=" + nuevo);

                    if (nuevo == 'S') {
                       

                        console.log("Ejecutando cargarCoordinadores...");
                        cargarCoordinadores();

                        console.log("Cargando tipos de encuentro y motivos...");
                        cargarGeneralidad('MORE', $(window.parent.document).find("#ddlMotivoReprogramacion"));
                        cargarGeneralidad('ACTI', $('#ddlActividades', parent.document));
                        cargarGeneralidad('TIAT', $('#ddlTipoActividades', parent.document));

                        // Configurar evento onChange para Tipo de actividad
                        $(window.parent.document).find("#ddlTipoActividades").on('change', function () {
                            var tipoActividad = $(this).val();
                            console.log("Tipo de actividad seleccionado:", tipoActividad);

                            if (tipoActividad === 'TIAT003') { // Territorio
                                console.log("Mostrando campos de Comuna y Barrio");
                                $(window.parent.document).find("#dvComunaBarrio").show();

                                // Hacer campos requeridos
                                $(window.parent.document).find("#ddlComuna").attr('data-validation', 'required');
                                $(window.parent.document).find("#ddlBarrio").attr('data-validation', 'required');

                                // Reinicializar validador para incluir los nuevos campos requeridos
                                parent.$.validate({
                                    modules: 'date, security',
                                    lang: 'es'
                                });

                                // Cargar comunas
                                cargarComunas();
                            } else {
                                console.log("Ocultando campos de Comuna y Barrio");
                                $(window.parent.document).find("#dvComunaBarrio").hide();

                                // Quitar validación requerida
                                $(window.parent.document).find("#ddlComuna").removeAttr('data-validation');
                                $(window.parent.document).find("#ddlBarrio").removeAttr('data-validation');

                                // Limpiar valores
                                $(window.parent.document).find("#ddlComuna").val('');
                                $(window.parent.document).find("#ddlBarrio").val('');

                                // Reinicializar validador para quitar validaciones
                                parent.$.validate({
                                    modules: 'date, security',
                                    lang: 'es'
                                });
                            }
                        });

                        // Configurar eventos de cambio para cargar datos dependientes
                        $(window.parent.document).find("#ddlCoordinador").on('change', function (e) {
                            console.log("Coordinador cambiado, cargando sedes, ubas y agentes...");
                            var tipoActividad = $(this).val();
                            console.log("tipoActividad",tipoActividad, e.target.value);

                            $(window.parent.document).find("#ddlAgenteEducativo1").val('');
                            $(window.parent.document).find("#ddlAgenteEducativo2").val('');
                            $(window.parent.document).find("#ddlSedes").val('');


                            cargarComunas();
                            cargarCoordinadorAgentes();
                        });

                        console.log("Configurando date picker...");
                        
                        // Inicializar el date picker básico primero
                        picker = parent.TempusDominusDateTimePicker('fechaEncuentro', 'dd/MM/yyyy HH:mm', true, true, 15);
                        
                        // Configurar restricciones de fecha después de la inicialización
                        setTimeout(function() {
                            var $datePicker = $(parent.document).find('#txtfechaEncuentro');
                            if ($datePicker.length > 0) {
                                // Obtener la instancia del datetimepicker
                                var datePickerInstance = $datePicker.data('DateTimePicker');
                                if (datePickerInstance) {
                                    // Configurar fechas mínima y máxima
                                    datePickerInstance.minDate(moment().startOf('day'));
                                    datePickerInstance.maxDate(moment().endOf('month'));
                                    
                                    // Deshabilitar la edición manual del input
                                    $datePicker.attr('readonly', true);
                                    
                                    console.log("Restricciones de fecha aplicadas:", moment().format('DD/MM/YYYY'), "hasta", moment().endOf('month').format('DD/MM/YYYY'));
                                }
                            }
                        }, 500);
                    }
                    else {
                        console.log("Modo edición - cargando datos del registro ID:", idProgramacionActividades);
                        console.log("Tipo de ID:", typeof idProgramacionActividades);

                        // Inicializar el date picker básico primero
                        picker = parent.TempusDominusDateTimePicker('fechaEncuentro', 'dd/MM/yyyy HH:mm', true, true, 15);
                        
                        // Configurar restricciones de fecha después de la inicialización
                        setTimeout(function() {
                            var $datePicker = $(parent.document).find('#txtfechaEncuentro');
                            if ($datePicker.length > 0) {
                                // Obtener la instancia del datetimepicker
                                var datePickerInstance = $datePicker.data('DateTimePicker');
                                if (datePickerInstance) {
                                    // Configurar fechas mínima y máxima
                                    datePickerInstance.minDate(moment().startOf('day'));
                                    datePickerInstance.maxDate(moment().endOf('month'));
                                    
                                    // Deshabilitar la edición manual del input
                                    $datePicker.attr('readonly', true);
                                    
                                    console.log("Restricciones de fecha aplicadas:", moment().format('DD/MM/YYYY'), "hasta", moment().endOf('month').format('DD/MM/YYYY'));
                                }
                            }
                        }, 500);

                        parent.loading(true);
                        ejecutarMetodoAsync('/Paginas/WebMethods.aspx/ObtenerCronogramaBusquedaActiva', 'POST', 'idCronograma', idProgramacionActividades, function (resp) {
                            console.log("Respuesta de ObtenerCronograma:", resp);
                            try {

                                error = false;

                                var refreshId = setInterval(function () {

                                    if (($("#ddlCoordinador option:selected", parent.document).text() != '' &&
                                        $("#ddlAgenteEducativo1 option:selected", parent.document).text() != '' &&
                                        $("#ddlMotivoReprogramacion option:selected", parent.document).text() != '') ||
                                        error
                                    ) {
                                        clearInterval(refreshId);
                                        parent.loading(false);
                                    }
                                }, 10);

                                datosJson = JSON.parse(resp.d);
                                console.log("Datos parseados:", datosJson);

                                if (datosJson.resultado) {
                                    var datos = JSON.parse(datosJson.mensaje);

                                    // Cargar coordinadores y datos dependientes con los valores del registro
                                    cargarCoordinadores(datos[0].idCoordinador, null, null, datos[0].idAgenteEducativo1, datos[0].idAgenteEducativo2);

                                    // Cargar tipo de actividad y actividad
                                    cargarTipoActividad(datos[0].idTipoActividad, datos[0].idActividad);
                                    
                                    // Cargar comuna y barrio
                                    cargarComunas(datos[0].idComuna, datos[0].idBarrio);

                                    // Cargar los campos de texto
                                    $(window.parent.document).find('#txtfechaEncuentro').val(datos[0].fechaEncuentro);
                                    $(window.parent.document).find('#txtPuntoReferencia').val(datos[0].puntoReferencia);
                                    $(window.parent.document).find('#txtObservaciones').val(datos[0].observaciones);
                                    $(window.parent.document).find('#txtObservacionesReprogramacion').val(datos[0].observacionesReprogramacion);

                                    // Cargar tipos de encuentro y motivos con valores seleccionados
                                    cargarGeneralidad('MORE', $(window.parent.document).find("#ddlMotivoReprogramacion"), datos[0].idMotivoReprogramacion);

                                    // Cargar actividades y tipos de actividad (si existen en los datos)
                                    cargarGeneralidad('ACTI', $(window.parent.document).find("#ddlActividades"), datos[0].idActividad);
                                    cargarGeneralidad('TIAT', $(window.parent.document).find("#ddlTipoActividades"), datos[0].idTipoActividad);

                                    // Configurar evento onChange para Tipo de actividad en modo edición
                                    $(window.parent.document).find("#ddlTipoActividades").on('change', function () {
                                        var tipoActividad = $(this).val();

                                        if (tipoActividad === 'TIAT003') { // Territorio
                                            $(window.parent.document).find("#dvComunaBarrio").show();
                                            $(window.parent.document).find("#ddlComuna").attr('data-validation', 'required');
                                            $(window.parent.document).find("#ddlBarrio").attr('data-validation', 'required');

                                            // Reinicializar validador
                                            parent.$.validate({
                                                modules: 'date, security',
                                                lang: 'es'
                                            });

                                            cargarComunas(datos[0].idComuna, datos[0].idBarrio);
                                        } else {
                                            $(window.parent.document).find("#dvComunaBarrio").hide();
                                            $(window.parent.document).find("#ddlComuna").removeAttr('data-validation');
                                            $(window.parent.document).find("#ddlBarrio").removeAttr('data-validation');

                                            // Reinicializar validador
                                            parent.$.validate({
                                                modules: 'date, security',
                                                lang: 'es'
                                            });
                                        }
                                    });

                                    // Verificar si el tipo de actividad actual es Territorio
                                    if (datos[0].idTipoActividad === 'TIAT003') {
                                        $(window.parent.document).find("#dvComunaBarrio").show();
                                        $(window.parent.document).find("#ddlComuna").attr('data-validation', 'required');
                                        $(window.parent.document).find("#ddlBarrio").attr('data-validation', 'required');

                                        // Reinicializar validador
                                        parent.$.validate({
                                            modules: 'date, security',
                                            lang: 'es'
                                        });

                                        cargarComunas(datos[0].idComuna, datos[0].idBarrio);
                                    }

                                    // Deshabilitar TODOS los campos para edición (solo permitir reprogramación)
                                    $(window.parent.document).find("#ddlCoordinador").prop("disabled", true);
                                    $(window.parent.document).find("#ddlAgenteEducativo1").prop("disabled", true);
                                    $(window.parent.document).find("#ddlAgenteEducativo2").prop("disabled", true);
                                    $(window.parent.document).find("#txtPuntoReferencia").prop("disabled", true);
                                    $(window.parent.document).find("#txtObservaciones").prop("disabled", true);
                                    $(window.parent.document).find("#txtfechaEncuentro").prop("disabled", true);
                                    $(window.parent.document).find("#ddlTipoActividades").prop("disabled", true);
                                    $(window.parent.document).find("#ddlActividades").prop("disabled", true);
                                    $(window.parent.document).find("#ddlComuna").prop("disabled", true);
                                    $(window.parent.document).find("#ddlBarrio").prop("disabled", true);
                                    
                                    // Mostrar solo la sección de reprogramación
                                    $(window.parent.document).find("#dvReprogramar").show();
                                    
                                    // Cambiar estilos para indicar campos deshabilitados
                                    $(window.parent.document).find("#txtfechaEncuentro").css("background-color", "#eee");
                                    $(window.parent.document).find("#txtPuntoReferencia").css("background-color", "#eee");
                                    $(window.parent.document).find("#txtObservaciones").css("background-color", "#eee");
                                }
                                else {
                                    console.log("Error en ObtenerCronograma:", datosJson.mensaje);
                                    alerta("No se pudieron cargar los datos del cronograma. " + datosJson.mensaje, "Error");
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

                function cargarTipoActividad(idTipoActividadSeleccionado, idActividadSeleccionada) {
                    // Cargar tipos de actividad
                    ejecutarMetodoAsync('/Paginas/WebMethods.aspx/ConsultarGeneralidades', 'POST', 'idTipoGeneralidad', '14', function (resp) {
                        if (resp.resultado) {
                            var datos = JSON.parse(resp.mensaje);
                            var ddlTipoActividad = $(window.parent.document).find('#ddlTipoActividad');
                            ddlTipoActividad.empty();
                            ddlTipoActividad.append('<option value="">Seleccione una opción</option>');
                            
                            $.each(datos, function (index, item) {
                                ddlTipoActividad.append('<option value="' + item.IdGeneralidad + '">' + item.Descripcion + '</option>');
                            });
                            
                            if (idTipoActividadSeleccionado) {
                                ddlTipoActividad.val(idTipoActividadSeleccionado);
                                // Cargar actividades después de seleccionar tipo
                                cargarActividades(idTipoActividadSeleccionado, idActividadSeleccionada);
                            }
                        }
                    });
                }

                function cargarActividades(idTipoActividad, idActividadSeleccionada) {
                    if (idTipoActividad) {
                        ejecutarMetodoAsync('/Paginas/WebMethods.aspx/ConsultarGeneralidades', 'POST', 'idTipoGeneralidad', idTipoActividad, function (resp) {
                            if (resp.resultado) {
                                var datos = JSON.parse(resp.mensaje);
                                var ddlActividad = $(window.parent.document).find('#ddlActividad');
                                ddlActividad.empty();
                                ddlActividad.append('<option value="">Seleccione una opción</option>');
                                
                                $.each(datos, function (index, item) {
                                    ddlActividad.append('<option value="' + item.IdGeneralidad + '">' + item.Descripcion + '</option>');
                                });
                                
                                if (idActividadSeleccionada) {
                                    ddlActividad.val(idActividadSeleccionada);
                                }
                            }
                        });
                    }
                }

                function cargarCoordinadores(idCoordinador, idsede, idUbas, idAgente1, idAgente2) {

                    var jsonInput = "{ esTraslado: '" + 'N' + "' }";
                    var obj = eval("(" + jsonInput + ')');

                    $.ajax({
                        type: "POST",                                              // tipo de request que estamos generando
                        url: '/Paginas/WebMethods.aspx/ConsultarCoordinadoresTransversales',                 // URL al que vamos a hacer el pedido
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
                                console.log("informacion",informacion);
                                $.each(informacion, function (index, value) {
                                    $(window.parent.document).find('#ddlCoordinador').append('<option value="' + value.IdCoordinador + '">' + value.nombre + '</option>');
                                });

                                if (idCoordinador != null) {
                                    $(window.parent.document).find('#ddlCoordinador').val(idCoordinador);

                                    cargarCoordinadorAgentes(idAgente1, idAgente2);
                                }
                                else {
                                 
                                    $('#EditarCronogramaBusquedaActiva', parent.document).find('.error,.valid').each(function () {
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
                function cargarCoordinadorAgentes(idAgente1, idAgente2) {

                    var idCoordinador = $('#ddlCoordinador', parent.document).val()
                    console.log("idCoordinador que se envía:", idCoordinador);
                    var jsonInput = "{ idCoordinador: '" + idCoordinador + "' }";
                    var obj = eval("(" + jsonInput + ')');
                    
                    $.ajax({
                        type: ((idAgente1 != null) ? 'GET' : 'POST'),                                              // tipo de request que estamos generando
                        url: '/Paginas/WebMethods.aspx/' + ((idAgente1 != null) ? 'ConsultarAgentes' : 'ConsultarCoordinadorAgentesTransversales'),                 // URL al que vamos a hacer el pedido
                        data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                        // van a ser recibidos por la función del servidor
                        contentType: "application/json; charset=utf-8",            // tipo de contenido
                        dataType: "json",                                          // formato de transmición de datos
                        async: true,                                               // si es asincrónico o no
                        success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                            const data = JSON.parse(resultado.d);
                            console.log("DATA",data);
                            
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

                function cargarGeneralidad(tipoGeneralidad, control, value) {

                    var jsonInput = "{ idTipoGeneralidad: '" + tipoGeneralidad + "' }";
                    var obj = eval("(" + jsonInput + ')');

                    $.ajax({
                        type: "POST",                                              // tipo de request que estamos generando
                        url: '/Paginas/WebMethods.aspx/ConsultarGeneralidades',                 // URL al que vamos a hacer el pedido
                        data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                        // van a ser recibidos por la función del servidor
                        contentType: "application/json; charset=utf-8",            // tipo de contenido
                        dataType: "json",                                          // formato de transmición de datos
                        async: true,                                               // si es asincrónico o no
                        success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                            const data = JSON.parse(resultado.d);
                            console.log(data);

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
                function cargarComunas(idcomuna, idBarrio) {
                    $.ajax({
                        type: "POST",                                              // tipo de request que estamos generando
                        url: '/Paginas/WebMethods.aspx/ConsultarComunas',                 // URL al que vamos a hacer el pedido
                        data: null,                                             // data es un arreglo JSON que contiene los parámetros que 
                        // van a ser recibidos por la función del servidor
                        contentType: "application/json; charset=utf-8",            // tipo de contenido
                        dataType: "json",                                          // formato de transmición de datos
                        async: true,                                               // si es asincrónico o no
                        success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                            const data = JSON.parse(resultado.d);

                            if (data.resultado) {
                                const informacion = JSON.parse(data.mensaje);
                                $(parent.document).find('#ddlComuna').empty();
                                $(parent.document).find('#ddlComuna').append('<option value="' + '' + '">Seleccione una opción</option>');

                                $.each(informacion, function (index, value) {
                                    $(parent.document).find('#ddlComuna').append('<option value="' + value.IdComuna + '">' + value.NombreComuna + '</option>');
                                });

                                $(parent.document).find('#ddlComuna').bind("change", function () {
                                    cargarBarrios();
                                });

                                if (idcomuna !== undefined) {
                                    $(parent.document).find('#ddlComuna').val(idcomuna);
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
                        url: '/Paginas/WebMethods.aspx/ConsultarBarrios',                 // URL al que vamos a hacer el pedido
                        data: JSON.stringify(obj),                                             // data es un arreglo JSON que contiene los parámetros que 
                        // van a ser recibidos por la función del servidor
                        contentType: "application/json; charset=utf-8",            // tipo de contenido
                        dataType: "json",                                          // formato de transmición de datos
                        async: true,                                               // si es asincrónico o no
                        success: function (resultado) {                          // función que va a ejecutar si el pedido fue exitoso
                            const data = JSON.parse(resultado.d);

                            if (data.resultado) {
                                const informacion = JSON.parse(data.mensaje);
                                $(parent.document).find('#ddlBarrio').empty();
                                $(parent.document).find('#ddlBarrio').append('<option value="' + '' + '" selected>Seleccione una opción</option>');

                                $.each(informacion, function (index, value) {
                                    $(parent.document).find('#ddlBarrio').append('<option value="' + value.IdBarrio + '">' + value.NombreBarrio + '</option>');
                                });

                                if (idBarrio !== undefined) {
                                    $(parent.document).find('#ddlBarrio').val(idBarrio);
                                }
                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) { // función que va a ejecutar si hubo algún tipo de error en el pedido
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                        }
                    });
                }

            </script>
        </form>
    </body>

    </html>