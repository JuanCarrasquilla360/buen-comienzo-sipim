<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitaCabezaHogar.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.VisitaCabezaHogar" %>

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
    <form id="VisitaCabezaHogar" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Cabeza Hogar
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
                        <div class="" style="padding-left: 10px; padding-top:10px">
                                <input id="btnNuevo" type="button" class="btn btn-cincopasitos" value="Nuevo" />
                         </div>
                        <div class="col-md-12 col-xs-12">                            
                        </div>
                        <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="grdVisitaCabezaHogar" class="table table-bordered table-striped">
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

            var tabla;

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
                    Editar('','S');
                });                

            });

            function cargarDatos() {
                this.tabla = $("#grdVisitaCabezaHogar").DataTable({
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
                            'aoColumns': columnasJSON(['Código Hogar', 'Nro de Documento', 'Nombres y apellidos', 'Comuna', 'Barrio', 'Dirección', 'Telefono', 'Celular', '']),
                            "bServerSide": true,
                            "sAjaxSource": "../WebMethods.aspx/ConsultarVisitaCabezaHogar",
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
                                            $("#grdVisitaCabezaHogar").show().css('width', '100%');
                                        }
                                });
                            }
                });
            }

            function Editar(idDocumento, nuevo) {                
                openPopup({
                    'title': 'Editar Cabeza de Hogar',
                    'width': '900',
                    'url': './Popups/EditarVisitaCabezaHogar.aspx?idDocumento=' + idDocumento,
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#EditarVisitaCabezaHogar', parent.document).isValid()) {
                                var objVisitaCabezaHogar = new Object();     
                                objVisitaCabezaHogar.idDocumento = $('#txtDocumento', parent.document).val();
                                objVisitaCabezaHogar.nuevo = nuevo;
                                objVisitaCabezaHogar.tipoDocumento = $('#ddlTipoDocumento option:selected', parent.document).val();
                                objVisitaCabezaHogar.primerNombre = $('#txtPrimerNombre', parent.document).val();
                                objVisitaCabezaHogar.segundoNombre = $('#txtSegundoNombre', parent.document).val();
                                objVisitaCabezaHogar.primerApellido = $('#txtPrimerApellido', parent.document).val();
                                objVisitaCabezaHogar.segundoApellido = $('#txtSegundoApellido', parent.document).val();
                                objVisitaCabezaHogar.fechaNacimiento = $('#txtFechaNacimiento', parent.document).val();
                                objVisitaCabezaHogar.sexo = $('#ddlSexo option:selected', parent.document).val();
                                objVisitaCabezaHogar.comuna = $('#ddlComuna option:selected', parent.document).val();
                                objVisitaCabezaHogar.barrio = $('#ddlBarrio option:selected', parent.document).val();
                                objVisitaCabezaHogar.direccion = $('#lblDireccion', parent.document).html();
                                objVisitaCabezaHogar.direccionObservaciones = $('#txtDireccionObservaciones', parent.document).val();
                                objVisitaCabezaHogar.celular = $('#txtCelular', parent.document).val();
                                objVisitaCabezaHogar.telefono = $('#txtTelefono', parent.document).val();
                                objVisitaCabezaHogar.nivelEducativo = $('#ddlNivelEducativo option:selected', parent.document).val();
                                objVisitaCabezaHogar.tipologiaFamiliar = $('#ddlTipologiaFamiliar option:selected', parent.document).val();
                                objVisitaCabezaHogar.tipoSeguridadSocial = $('#ddlTipoSeguridadSocial option:selected', parent.document).val();
                                objVisitaCabezaHogar.eAPB = $('#ddlEAPB option:selected', parent.document).val();
                                objVisitaCabezaHogar.observaciones = $('#txtObservaciones', parent.document).val();

                                execMethod('../WebMethods.aspx/ActualizarVisitaCabezaHogar', 'POST', objVisitaCabezaHogar, function (resp) {
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
                            setSelectOptions($('#ddlEAPB', parent.document), datosJson, "IdMaeEAPB", "NombreEapb");
                        }
                        catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                });

                parent.configChangeInput('txtDocumento', function () {
                    if ($('#txtDocumento', parent.document).val() !== '') {
                        var objDoc = new Object();
                        objDoc.idDocumento = $('#txtDocumento', parent.document).val();
                        execMethod('../WebMethods.aspx/ConsultarPersona', 'POST', objDoc, function (resp) {
                            var objResp = resp.d;
                            var objPersona = resp.d;
                            try {
                                objPersona = resp.d;
                                if (objPersona != null) {
                                    $('#ddlTipoDocumento', parent.document).val(objPersona.IdMaeTipoDocumento);
                                    $('#txtPrimerNombre', parent.document).val(objPersona.PrimerNombre);
                                    $('#txtSegundoNombre', parent.document).val(objPersona.SegundoNombre);
                                    $('#txtPrimerApellido', parent.document).val(objPersona.PrimerApellido);
                                    $('#txtSegundoApellido', parent.document).val(objPersona.SegundoApellido);
                                    $('#txtFechaNacimiento', parent.document).val(moment(objPersona.FechaNacimiento).format("DD/MM/YYYY"));
                                    $('#ddlSexo', parent.document).val(objPersona.Sexo);
                                    $('#ddlTipoSeguridadSocial', parent.document).val(objPersona.IdMaeTipoSeguridadSocial);
                                    $('#ddlEAPB', parent.document).val(objPersona.IdMaeEAPB);
                                    $('#txtCelular', parent.document).val(objPersona.Celular);
                                    $('#txtTelefono', parent.document).val(objPersona.Telefono);

                                    $('#txtDocumento', parent.document).attr('disabled', 'disabled');
                                    $('#ddlTipoDocumento', parent.document).attr('disabled', 'disabled');
                                    $('#txtPrimerNombre', parent.document).attr('disabled', 'disabled');
                                    $('#txtSegundoNombre', parent.document).attr('disabled', 'disabled');
                                    $('#txtPrimerApellido', parent.document).attr('disabled', 'disabled');
                                    $('#txtSegundoApellido', parent.document).attr('disabled', 'disabled');
                                    $('#txtFechaNacimiento', parent.document).attr('disabled', 'disabled');
                                    $('#ddlSexo', parent.document).attr('disabled', 'disabled');
                                    $('#ddlTipoSeguridadSocial', parent.document).attr('disabled', 'disabled');
                                    $('#ddlEAPB', parent.document).attr('disabled', 'disabled');
                                    
                                }
                            }
                            catch (e) {
                                alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                            }
                        });
                    }
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
                        case "10": //Permiso especial de permanencia
                            $('#txtDocumento', parent.document).attr('maxlength', '15');
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


                parent.configChangeInput('txtFecha', function () {
                    var Fecha = moment($('#txtFecha', parent.document).val(), "DD/MM/YYYY");
                    var Fecha2 = moment(Fecha).format("M");
                    var fechaActual = moment();
                    var FechaActual2 = moment().format("M");;
                    if (Fecha > fechaActual) {
                        alerta('La fecha de la actividad no puede ser mayor a la fecha actual.', 'Error');
                        $('#txtFecha', parent.document).val('');
                        $('#txtFecha', parent.document).focus();
                    }
                    if (Fecha2 != FechaActual2) {
                        alerta('La fecha de la actividad no puede ser diferente al mes actual.', 'Error');
                        $('#txtFecha', parent.document).val('');
                        $('#txtFecha', parent.document).focus();
                    }
                });


                $('#txtDocumento', parent.document).change(function () {
                    switch ($('#ddlTipoDocumento', parent.document).val()) {
                        case "1": //cédula ciudadanía
                            if ($('#txtDocumento', parent.document).val().length < 6) {
                                alerta('La longitud para un documento tipo cédula debe contener almenos 6 caracteres.');
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
                            break;
                        case "10": //Permiso especial de permanencia
                            if ($('#txtDocumento', parent.document).val().length != 15) {
                                alerta('La longitud para un documento tipo Permiso especial de permanencia debe contener 15 caracteres.');
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
                parent.configFormValidate('EditarVisitaCabezaHogar', 'date, security');
                                                  
            }           

        </script>
    </form>
</body>
</html>
