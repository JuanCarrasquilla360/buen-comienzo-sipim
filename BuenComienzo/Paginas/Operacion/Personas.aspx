<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Personas.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Personas" %>

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

    <link rel="stylesheet" href="../../plugins/select2/select2.min.css" />

    <script src="../../plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <script type="text/javascript">
        $('#framePrincipal', parent.document).css('height', '0px');
    </script>
</head>
<body>
    <div id="loading" style="display: block;display: flex;text-align: center;position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="Personas" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Personas
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
                        <div>
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="col-sm-2" style="text-align: center">
                                        <label class="control-label">Documento</label>
                                    </div>
                                    <div class="col-sm-2">
                                        <input type="text" id="txtDocumento_P" runat="server" class="form-control onlyNumbers" maxlength="15" />
                                    </div>
                                    <div class="col-sm-2" style="text-align: center">
                                        <label class="control-label">Nombre</label>
                                    </div>
                                    <div class="col-sm-2">
                                        <input type="text" id="txtNombre_P" runat="server" class="form-control" maxlength="200" />
                                    </div>
                                    <div class="col-sm-2" style="text-align: center;">
                                        <span class="ion-search" title="Buscar" style="font-size: 25px; cursor: pointer" id="btnBuscar"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="grdPersonas" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <%--<th>Nro. de cédula</th>
                                        <th>Nombres y apellidos</th>
                                        <th>Nro. celular</th>
                                        <th>Perfil</th>
                                        <th>Estado</th>
                                        <th>Cambio contraseña</th>
                                        <th style="width: 25px"></th>--%>
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
        <!-- Script -->
        <script type="text/javascript">
            var first = false;
            var tabla;

            $(window).load(function () {
                setTimeout(function () {
                    $('#loading').fadeOut(300, "linear");
                }, 300);
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
                $('#btnNuevo').attr('disabled', 'disabled');

                $('#btnBuscar').click(function () {
                    var Documento = $('#txtDocumento_P').val();
                    var Nombre = $('#txtNombre_P').val();
                    if (Documento === "" && Nombre === "") {
                        alerta("Ingrese por los menos un parámetro de búsqueda", "Advertencia");
                        return;
                    }
                    else {
                        if (!first) {
                            cargarDatos();
                            first = true;
                        }
                        else {
                            tabla.ajax.reload();
                        }
                    }
                });


            });

            function cargarDatos() {
                this.tabla = $("#grdPersonas").DataTable({
                    "searching": false,
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [{
                        'targets': 6,
                        'orderable': false
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Nro de Documento', 'Nombres y apellidos', 'Fecha de Nacimiento', 'Código Familia', 'Comuna', 'Celular', 'SeguridadSocial', 'EAPB', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarPersonas",
                    "fnServerParams": function (aoData) {
                        aoData.push(
                            { "name": "Documento", "value": $('#txtDocumento_P').val() },
                            { "name": "Nombre", "value": $('#txtNombre_P').val() }
                        );
                    },
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
                                    $("#grdPersonas").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function Editar(IdDocumento, nuevo) {
                openPopup({
                    'title': 'Editar Personas',
                    'width': '900',
                    'url': './Popups/EditarPersonas.aspx?IdDocumento=' + IdDocumento,
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#EditarPersonas', parent.document).isValid()) {
                                var objPersonas = new Object();
                                objPersonas.IdDocumento = $('#txtDocumento', parent.document).val();
                                objPersonas.nuevo = nuevo;
                                objPersonas.tipoDocumento = $('#ddlTipoDocumento option:selected', parent.document).val();
                                objPersonas.primerNombre = $('#txtPrimerNombre', parent.document).val();
                                objPersonas.segundoNombre = $('#txtSegundoNombre', parent.document).val();
                                objPersonas.primerApellido = $('#txtPrimerApellido', parent.document).val();
                                objPersonas.segundoApellido = $('#txtSegundoApellido', parent.document).val();
                                objPersonas.fechaNacimiento = $('#txtFechaNacimiento', parent.document).val();
                                objPersonas.sexo = $('#ddlSexo option:selected', parent.document).val();
                                objPersonas.orientacionSexual = $('#ddlOrientacionSexual option:selected', parent.document).val();
                                objPersonas.direccion = $('#lblDireccion', parent.document).html();
                                objPersonas.direccionObservaciones = $('#txtDireccionObservaciones', parent.document).val();
                                objPersonas.zona = $('#ddlZona option:selected', parent.document).val();
                                objPersonas.comuna = $('#ddlComuna option:selected', parent.document).val();
                                objPersonas.barrio = $('#ddlBarrio option:selected', parent.document).val();
                                objPersonas.telefono = $('#txtTelefono', parent.document).val();
                                objPersonas.celular = $('#txtCelular', parent.document).val();
                                objPersonas.fichaSisben = $('#txtFichaSisben', parent.document).val();
                                objPersonas.puntajeSisben = $('#txtPuntajeSisben', parent.document).val();
                                objPersonas.tipoSeguridadSocial = $('#ddlTipoSeguridadSocial option:selected', parent.document).val();
                                objPersonas.eAPB = $('#ddlEAPB option:selected', parent.document).val();
                                objPersonas.tipoAfiliado = $('#ddlTipoAfiliado option:selected', parent.document).val();
                                objPersonas.nivelEducativo = $('#ddlNivelEducativo option:selected', parent.document).val();
                                objPersonas.ocupacion = $('#ddlOcupacion option:selected', parent.document).val();
                                objPersonas.grupoEtnia = $('#ddlGrupoEtnia option:selected', parent.document).val();

                                execMethod('../WebMethods.aspx/ActualizarPersonas', 'POST', objPersonas, function (resp) {
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


                $('#ddlComuna', parent.document).change(function () {
                    $('#ddlBarrio', parent.document).removeAttr('disabled');
                    ejecutarMetodo('../WebMethods.aspx/ConsultarBarrioByComuna', 'POST', 'idComuna', $('#ddlComuna', parent.document).val(), function (resp) {
                        try {
                            datosJson = JSON.parse(resp.d);
                            setSelectOptions($('#ddlBarrio', parent.document), datosJson, "IdBarrio", "NombreBarrio");
                        }
                        catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                });

                $('#ddlTipoSeguridadSocial', parent.document).change(function () {
                    $('#ddlEAPB', parent.document).removeAttr('disabled');
                    ejecutarMetodo('../WebMethods.aspx/ConsultarEapbByRegimen', 'POST', 'idMaeTipoSeguridadSocial', $('#ddlTipoSeguridadSocial', parent.document).val(), function (resp) {
                        try {
                            datosJson = JSON.parse(resp.d);
                            setSelectOptions($('#ddlEAPB', parent.document), datosJson, "IdEapb", "NombreEapb");
                        }
                        catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                });


                $('#txtVia1', window.parent.document).keyup(function () {
                    var viaN = $(this).val().replace(/\D/g, ''); //toma los números
                    var viaL = $(this).val().replace(/\d/g, ''); //toma las letras

                    if ((viaN != '' && viaL == '') || (viaL == '' && viaN == '')) {
                        $('#ddlApendice1', window.parent.document).removeAttr('disabled');
                        $('#ddlCardinalidad', window.parent.document).removeAttr('disabled');
                    }
                    else if (viaL != '' && viaN == '') {
                        $('#ddlApendice1', window.parent.document).val('').attr('disabled', 'disabled');
                        $('#ddlCardinalidad', window.parent.document).val('').attr('disabled', 'disabled');
                    }
                    else {
                        $('#ddlApendice1', window.parent.document).val('').attr('disabled', 'disabled');
                        $('#ddlCardinalidad', window.parent.document).val('').attr('disabled', 'disabled');
                    }
                });

                $('#ddlTipoVia', window.parent.document).change();

                $('.onlyNumbers', parent.document).keydown(function (e) {
                    // Allow: backspace, delete, tab, escape, enter and .
                    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                        // Allow: Ctrl+A,Ctrl+C,Ctrl+V, Command+A
                        ((e.keyCode == 65 || e.keyCode == 86 || e.keyCode == 67) && (e.ctrlKey === true || e.metaKey === true)) ||
                        // Allow: home, end, left, right, down, up
                        (e.keyCode >= 35 && e.keyCode <= 40)) {
                        // let it happen, don't do anything
                        return;
                    }
                    // Ensure that it is a number and stop the keypress
                    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                        e.preventDefault();
                    }
                });

                $('.onlyNumbers', parent.document).blur(function () {
                    var node = $(this);
                    node.val(node.val().replace(/[a-z]/g, ''));
                });

                $('.onlyLetters', parent.document).keypress(function (event) {
                    var inputValue = event.which;
                    // allow letters and whitespaces only.
                    if (!(inputValue >= 65 && inputValue <= 122) && (inputValue != 32 && inputValue != 0 && inputValue != 241)) {
                        event.preventDefault();
                    }
                });

                $('.onlyLetters', parent.document).blur(function () {
                    var node = $(this);
                    node.val(node.val().replace(/[^A-Z|a-z]/g, ''));
                });

                $('#ddlTipoDocumento', parent.document).change(function () {
                    $('#txtDocumento', parent.document).val('');
                    switch ($(this).val()) {
                        case "1": //cédula ciudadanía
                            $('#txtDocumento', parent.document).attr('maxlength', '10');
                            break;
                        case "2": //cédula extrangería
                            $('#txtDocumento', parent.document).attr('maxlength', '6');
                            break;
                        case "3", "4", "7": //certificado cabildo - Pasaporte - Sin documento
                            $('#txtDocumento', parent.document).attr('maxlength', '12');
                            break;
                        case "5": //registro civil
                            $('#txtDocumento', parent.document).attr('maxlength', '10');
                            break;
                        case "6": //tarjeta identidad
                            $('#txtDocumento', parent.document).attr('maxlength', '11');
                            break;
                        default:
                            $('#txtDocumento', parent.document).attr('maxlength', '12');
                            break;
                    }
                });

                parent.configChangeInput('txtFechaNacimiento', function () {
                    var FechaNacimiento = moment($('#txtFechaNacimiento', parent.document).val(), "DD/MM/YYYY");
                    var fechaActual = moment();
                    if (FechaNacimiento > fechaActual) {
                        alerta('La fecha de nacimiento no puede ser mayor a la fecha actual.', 'Error');
                        $('#txtFechaNacimiento', parent.document).val('');
                        $('#txtFechaNacimiento', parent.document).focus();
                    }
                });

                $('#txtDocumento', parent.document).change(function () {
                    switch ($('#ddlTipoDocumento', parent.document).val()) {
                        case "1": //cédula ciudadanía
                            if ($('#txtDocumento', parent.document).val().length < 7) {
                                alerta('La longitud para un documento tipo cédula debe contener almenos 7 caracteres.');
                                $('#txtDocumento', parent.document).val('');
                                $('#txtDocumento', parent.document).focus();
                                return false;
                            }
                            break;
                        case "2": //cédula extrangería
                            if ($('#txtDocumento', parent.document).val().length < 5) {
                                alerta('La longitud para un documento tipo cédula de extrangería debe contener almenos 5 caracteres.');
                                $('#txtDocumento', parent.document).val('');
                                $('#txtDocumento', parent.document).focus();
                                return false;
                            }
                            break;
                        case "5": //registro civil
                            if ($('#txtDocumento', parent.document).val().length != 10) {
                                alerta('La longitud para un documento tipo Registro civil debe contener 10 caracteres.');
                                $('#txtDocumento', parent.document).val('');
                                $('#txtDocumento', parent.document).focus();
                                return false;
                            }
                            break;
                        case "6": //tarjeta identidad
                            if ($('#txtDocumento', parent.document).val().length < 10) {
                                alerta('La longitud para un documento tipo tarjeta de identidad debe contener almenos 10 caracteres.');
                                $('#txtDocumento', parent.document).val('');
                                $('#txtDocumento', parent.document).focus();
                                return false;
                            }
                            break
                    }
                });

                //Se configuran los campos de fecha
                parent.configDateTimePicker(true);
                //Se configuran la validación
                parent.configFormValidate('EditarPersonas', 'date, security');

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

            function CargarDocumentosPersonas(IdDocumento) {
                return $("#gvDocumentos", window.parent.document).dataTable({
                    "destroy": true,
                    "columnDefs": [
                        { "className": "dt-center", "targets": "_all" }
                    ],
                    "sDom": "lfrti",
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
                var validExts = new Array('.pdf', '.png', '.jpg', '.jpeg');
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



        </script>
    </form>
</body>
</html>
