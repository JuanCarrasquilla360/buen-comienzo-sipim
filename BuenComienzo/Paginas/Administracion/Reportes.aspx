<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Reportes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administración de Informes</title>
    <!-- Bootstrap -->
    <link href="../../plugins/bootstrap/css/bootstrap.css" rel="stylesheet" />
   <!-- Ionicons -->
    <link href="../../plugins/fonts/ionicons.min.css" rel="stylesheet" />
    <!-- Theme style -->
    <link href="../../Content/AdminLTE.min.css" rel="stylesheet" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
    folder instead of downloading all of them to reduce the load. -->
    <link href="../../Content/_all-skins.min.css" rel="stylesheet" />
    <!-- DataTables -->
    <link href="../../plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" />
     <!-- Skin -->
    <link href="../../Content/skin-red-light.min.css" rel="stylesheet" />
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <!-- Daterange picker -->
    <link href="../../Content/BuenComienzoFamiliar.css" rel="stylesheet" />

    <!--jQuery -->
    <script src="../../plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Cinco Pasitos -->
    <script src="../../Scripts/BuenComienzoFamiliar.js"></script>
    <!-- DataTables -->
    <script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../../plugins/datatables/dataTables.bootstrap.min.js"></script>
    <!-- form validator -->
    <script src="../../plugins/jqueryValidator/jquery.form-validator.min.js"></script>

    <script type="text/javascript">
        $('#framePrincipal', parent.document).css('height', '0px');
    </script>
</head>
<body>
    <div id="loading" style="display: block;display: flex;text-align: center;position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="frmReportes" runat="server">
        <section class="content-header">
            <h1>Administración de informes
            </h1>
            <ol class="breadcrumb">
                <li><a href="../../Index.aspx"><i class="fa fa-home"></i>Inicio</a></li>
            </ol>
        </section>
        <section class="content">
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
                    <div class="box-body">
                        <table id="gvReportes" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Código</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th style="width: 20px"></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                     </div>
                </div>
            </div>
            <asp:HiddenField runat="server" ID="hidIdReporte" />
            <asp:HiddenField runat="server" ID="hidNombre" />
            <asp:HiddenField runat="server" ID="hidDescripcion" />
            <asp:HiddenField runat="server" ID="hidQuery" />
            <asp:HiddenField runat="server" ID="hidtblCampos" />
        </section>
    </form>

    <script type="text/javascript">

        var tabla;

        $(window).load(function () {
            setTimeout(function () { $('#loading').fadeOut(300, "linear");}, 300);
        });

        $(document).ready(function () {
            $('#btnNuevo').click(function () {
                Nuevo();
            });

            Tablas(); 
        });
        function Tablas() {
            tabla = $("#gvReportes").DataTable({
                "destroy": true,
                "paging": true,
                "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                "pagingType": "full_numbers",
                "bLengthChange": false,
                "bProcessing": false,
                "scrollX": true,
                'columnDefs': [{
                    'targets': [0,1,2],
                    'orderable': true
                }],
                "language": {
                    "url": "../../plugins/datatables/Spanish.json"
                },
                "bServerSide": true,
                "sAjaxSource": "../WebMethods.aspx/ConsultarReportes",
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
                                $("#gvReportes").show().css('width', '100%');
                            }
                    });
                }
            });
        }

        function Nuevo() {

            openPopup({
                'title': 'Nuevo Informe',
                'width': '830',
                'url': './Popups/NuevoReporte.aspx',
                'buttons': [{
                    'name': 'Guardar',
                    'click': function () {
                        if ($('#frmNuevoReporte', parent.document).isValid()) {
                            $('#hidIdReporte').val($('#idReporte', window.parent.document).val());
                            $('#hidNombre').val($('#txtNombre', window.parent.document).val());
                            $('#hidDescripcion').val($('#txtDescripcion', window.parent.document).val());
                            $('#hidQuery').val($('#txtQuery', window.parent.document).val());

                            var filas = "";
                            $('#ddlCampos option', window.parent.document).each(function () {
                                filas += $(this).val() + ',' + $(this).text() + "|";
                            });

                            if (filas != "") {
                                filas = filas.substring(0, filas.length - 1);
                                $('#hidtblCampos').val(filas);
                            }

                            var campos = 'nombre,descripcion,query,campos';
                            var strJsonReporte = '{"nombre":"' + $('#txtNombre', parent.document).val() +
                                '","descripcion":' + JSON.stringify($('#txtDescripcion', parent.document).val()) +
                                ',"query":' + JSON.stringify($('#txtQuery', parent.document).val()) +
                                ',"Hdcampos":"' + $('#hidtblCampos').val() + '"}';

                            var objReporte = JSON.parse(strJsonReporte);

                            execMethod('../WebMethods.aspx/InsertarReporte', 'POST', objReporte, function (resp) {
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

            $('#txtNombre', window.parent.document).focus();

            $('#btnAdicionar', window.parent.document).click(function () {
                if ($('#ddlCampo', window.parent.document).val() != "" && $('#txtNombreCampo', window.parent.document).val() != "") {
                    if ($('#ddlCampos option[value="' + $('#ddlCampo', window.parent.document).val() + '"]', window.parent.document).length == 0) {
                        $('#ddlCampos', window.parent.document).append('<option value=' + $('#ddlCampo', window.parent.document).val() + '>' + $('#ddlCampo option:selected', window.parent.document).text() + ' = ' + $('#txtNombreCampo', window.parent.document).val() + '</option>');
                        $('#ddlCampo', window.parent.document).val('');
                        $('#txtNombreCampo', window.parent.document).val('');
                    }
                    else {
                        alerta('El campo que desea adicionar ya existe, por favor verifique','Error');
                    }
                }
            });

            $('#btnEliminar', window.parent.document).click(function () {
                $('#ddlCampos option:selected', window.parent.document).remove();
            });

        }

        function Editar(idReporte){
            openPopup({
                'title': 'Editar Informe',
                'width': '830',
                'url': './Popups/NuevoReporte.aspx?idReporte=' + idReporte,
                'buttons': [{
                    'name': 'Guardar',
                    'click': function () {
                        if ($('#frmNuevoReporte', parent.document).isValid()) {
                            $('#hidIdReporte').val($('#idReporte', window.parent.document).val());
                            $('#hidNombre').val($('#txtNombre', window.parent.document).val());
                            $('#hidDescripcion').val($('#txtDescripcion', window.parent.document).val());
                            $('#hidQuery').val($('#txtQuery', window.parent.document).val());
            
                            var filas = "";
                            $('#ddlCampos option', window.parent.document).each(function () {
                                filas += $(this).val() + ',' + $(this).text() + "|";
                            });

                            if (filas != "") {
                                filas = filas.substring(0, filas.length - 1);
                                $('#hidtblCampos').val(filas);
                            }

                            var campos = 'nombre,descripcion,query,campos';
                            var strJsonReporte = '{"idReporte":"' + $('#idReporte', window.parent.document).val() +
                                '","nombre":"' + $('#txtNombre', parent.document).val() +
                                '","descripcion":' + JSON.stringify($('#txtDescripcion', parent.document).val()) +
                                ',"query":' + JSON.stringify($('#txtQuery', parent.document).val()) +
                                ',"Hdcampos":"' + $('#hidtblCampos').val() + '"}';

                            var objReporte = JSON.parse(strJsonReporte);

                            execMethod('../WebMethods.aspx/ActualizarReporte', 'POST', objReporte, function (resp) {
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

            $('#txtNombre', window.parent.document).focus();

            $('#btnAdicionar', window.parent.document).click(function () {
                if ($('#ddlCampo', window.parent.document).val() != "" && $('#txtNombreCampo', window.parent.document).val() != "") {
                    if ($('#ddlCampos option[value="' + $('#ddlCampo', window.parent.document).val() + '"]', window.parent.document).length == 0) {
                        $('#ddlCampos', window.parent.document).append('<option value=' + $('#ddlCampo', window.parent.document).val() + '>' + $('#ddlCampo option:selected', window.parent.document).text() + ' = ' + $('#txtNombreCampo', window.parent.document).val() + '</option>');
                        $('#ddlCampo', window.parent.document).val('');
                        $('#txtNombreCampo', window.parent.document).val('');
                    }
                    else {
                        alerta('El campo que desea adicionar ya existe, por favor verifique','Error');
                    }
                }
            });

            $('#btnEliminar', window.parent.document).click(function () {
                $('#ddlCampos option:selected', window.parent.document).remove();
            });

        }

        function Eliminar(idReporte) {
            confirmar('Está seguro que desea eliminar el informe: ' + idReporte + '?', 'Advertencia', function () {
                var campos = 'idReporte';
                var valores = idReporte;

                    ejecutarMetodo('../WebMethods.aspx/EliminarReporte', 'POST', campos, valores, function (resp) {
                        try {

                            datosJson = JSON.parse(resp.d);
                            alerta(datosJson.mensaje, datosJson.tipoMensaje);

                            if (datosJson.resultado) {
                                tabla.ajax.reload();
                            }
                        }
                        catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
            });

        }


    </script>
</body>
</html>
