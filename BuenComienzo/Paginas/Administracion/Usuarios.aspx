<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Usuarios" %>

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
    <script src="../../plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <script type="text/javascript">
        $('#framePrincipal', parent.document).css('height', '0px');
    </script>
</head>
<body>
    <div id="loading" style="display: block;display: flex;text-align: center;position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="frmUsuarios" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Talento Humano
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
                        <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                        </div>
                        <div class="col-md-12 col-xs-12">
                            <div class="col-md-12 col-xs-12" style="padding-left: 0px">
                                <input id="btnNuevo" type="button" class="btn btn-cincopasitos" value="Nuevo" />
                            </div>
                        </div>
                        <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="grdUsuarios" class="table table-bordered table-striped">
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
                tabla = $("#grdUsuarios").DataTable({
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
                            'aoColumns': columnasJSON(['Nro. de cédula', 'Nombres y apellidos', 'Nro. celular', 'Perfil', 'Estado', 'Cambio contraseña', '']),
                            "bServerSide": true,
                            "sAjaxSource": "../WebMethods.aspx/ConsultarUsuarios",
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
                                            $("#grdUsuarios").show().css('width', '100%');
                                        }
                                });
                            }
                });
            }

            function Editar(idUsuario, nuevo) {
                openPopup({
                    'title': 'Editar usuario',
                    'width': '900',
                    'url': './Popups/EditarUsuarios.aspx?idUsuario=' + idUsuario,
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#frmEditarUsuario', parent.document).isValid()) {
                                var campos = 'nuevo,idDocumento,idPerfil,password,cambioPassword,tipoDocumento,primerNombre,segundoNombre,primerApellido,segundoApellido,fechaNacimiento,telefono,celular,correoElectronico,correoElectronicoLaboral,idCoordinador,estado'
                                var valores = nuevo + ',' + $('#txtNumeroDocumento', parent.document).val() + ',' +
                                                            $('#ddlPerfil option:selected', parent.document).val() + ',' +
                                                            $('#txtClave', parent.document).val() + ',' +
                                                            $('#chkCambioClave', parent.document).is(":checked") + ',' +
                                                            $('#ddlTipoDocumento option:selected', parent.document).val() + ',' +
                                                            $('#txtPrimerNombre', parent.document).val() + ',' +
                                                            $('#txtSegundoNombre', parent.document).val() + ',' +
                                                            $('#txtPrimerApellido', parent.document).val() + ',' +
                                                            $('#txtSegundoApellido', parent.document).val() + ',' +
                                                            $('#txtFechaNacimiento', parent.document).val() + ',' +
                                                            $('#txtTelefono', parent.document).val() + ',' +
                                                            $('#txtCelular', parent.document).val() + ',' +
                                                            $('#txtCorreoElectronico', parent.document).val() + ',' +
                                                            $('#txtCorreoElectronicoLaboral', parent.document).val() + ',' +
                                                            $('#ddlCoordinador option:selected', parent.document).val() + ',' +
                                                            $('#chkActivo', parent.document).is(":checked");

                                ejecutarMetodo('../WebMethods.aspx/ActualizarUsuario', 'POST', campos, valores, function (resp) {
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

                if (nuevo != 'S')
                    $('#txtNumeroDocumento', parent.document).attr('disabled', 'disabled');

                $('input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran los campos de fecha
                parent.configDateTimePicker(true);
                //Se configuran la validación
                parent.configFormValidate('frmEditarUsuario', 'date, security');

                //$('#ddlPerfil', parent.document).change(function () {
                //    $('#ddlIdOperador', parent.document).val('');
                //    $('#ddlIdOperador', parent.document).attr('disabled', 'disabled');
                //    if ($(this).val() == '2'){
                //        $('#ddlIdOperador', parent.document).removeAttr('disabled');
                //    }
                //});
                  
            }

        </script>
    </form>
</body>
</html>