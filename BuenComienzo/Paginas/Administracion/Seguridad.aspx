<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Seguridad.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Seguridad" %>

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
    <!-- cincoPasitos -->
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
                <h1>Seguridad
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
                        <div class="box-body">
                            <%--<table id="grdBeneficiarios" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Módulo</th>
                                        <th>Tipo de documento</th>
                                        <th>Nro. de identificación</th>
                                        <th>Nombres y apellidos del participante</th>
                                        <th>Fecha de nacimiento</th>
                                        <th>Unidad de servicio</th>
                                        <th>Departamento</th>
                                        <th>Municipio</th>
                                        <th>Estado</th>
                                        <th style="width: 15px"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>--%>

                            <asp:GridView ID="grdSeguridad" ToolTip="" runat="server" AutoGenerateColumns="true" OnRowDataBound="grdSeguridad_RowDataBound"
                                CssClass="table table-bordered table-striped" DataKeyNames="IdPermiso">
                            </asp:GridView>
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
        <!-- Script -->
        <script type="text/javascript">
            var tabla;

            $(window).load(function () {
                setTimeout(function () { $('#loading').fadeOut(300, "linear"); cargarDatos(); }, 300);
            });

            function cargarDatos() {
                tabla = $("#grdSeguridad").DataTable({
                    "destroy": true,
                    "paging": false,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    'scrollX': true,
                    'columnDefs': [{
                        'targets': [1, 2, 3, 4, 5],
                        'orderable': false
                    }],
                    "aaSorting": [[0, "asc"]],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    "drawCallback": function (settings) {
                        $('#framePrincipal', parent.document).css('height', document.body.scrollHeight + 'px');

                        $('input[type="checkbox"].flat-red').iCheck({
                            checkboxClass: 'icheckbox_flat-red'
                        });

                        $('#grdSeguridad input[type="checkbox"]').on('ifChecked', function (event) {
                            guardar(true, $(this).attr('id'));
                        });

                        $('#grdSeguridad input[type="checkbox"]').on('ifUnchecked', function (event) {
                            guardar(false, $(this).attr('id'));
                        });
                    }
                });
            }

            function guardar(checked, id) {
                ejecutarMetodo('../WebMethods.aspx/ActualizarSeguridad', 'POST', 'permiso,quitar', id + ',' + checked, function (datos) {
                    try {
                        datosJson = JSON.parse(datos.d);
                        notificacion(datosJson.mensaje, datosJson.tipoMensaje, false);
                    }
                    catch (e) {
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                    }
                });
            }

        </script>
    </form>
</body>
</html>