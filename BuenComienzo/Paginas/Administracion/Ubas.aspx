<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ubas.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Ubas" %>

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
    <form id="frmUbas" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Ubas
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
                            <table id="grdUbas" class="table table-bordered table-striped">
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
        <!-- Script -->
        <script type="text/javascript">

            var tabla;

            $(window).load(function () {
                setTimeout(function () { $('#loading').fadeOut(300, "linear"); cargarDatos(); }, 400);
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
                tabla = $("#grdUbas").DataTable({
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
                            'aoColumns': columnasJSON(['Id uba', 'Uba', 'Tipo uba', 'Uba sistema', 'Usuario creación', 'Fecha creación', 'Activo', '']),
                            "bServerSide": true,
                            "sAjaxSource": "../WebMethods.aspx/ConsultarUbas",
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
                                            $("#grdUbas").show().css('width', '100%');
                                        }
                                });
                            }
                });
            }
            
            function Editar(idUba, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nueva uba' : 'Editar uba',
                    'width': '700',
                    'url': './Popups/EditarUba.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#frmEditarUba', parent.document).isValid()) {
                                var campos = 'nuevo,idUba,uba,tipoUba,ubaSistema,activo'
                                var valores = nuevo + ',' + $('#txtIdUba', parent.document).val() + ',' +
                                                            $('#txtUba', parent.document).val() + ',' +
                                                            $('#ddlTipoUba option:selected', parent.document).val() + ',' +
                                                            $('#txtUbaSistema', parent.document).val() + ',' +
                                                            $('#chkActivo', parent.document).is(":checked");
                                
                                ejecutarMetodoAsync('../WebMethods.aspx/ActualizarUba', 'POST', campos, valores, function (resp) {
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
                }, function () { success(idUba, nuevo ); });

                $('input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran la validación
                parent.configFormValidate('frmEditarUba', 'date, security');
            }

            function success(idUba, nuevo) {
                cargarTiposUba();

                $(window.parent.document).find("#txtUbaSistema").bind('keypress', function (e) { keypressAlphaNumeric(e); });

                if (nuevo == 'S') {
                    $(window.parent.document).find('#chkActivo').prop("checked", true);
                }
                else {
                    ejecutarMetodo('../WebMethods.aspx/ConsultarUba', 'POST', 'idUba', idUba, function (resp) {
                        try {

                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                var datos = JSON.parse(datosJson.mensaje);
                                $(window.parent.document).find('#txtIdUba').val(datos[0].idUba);
                                $(window.parent.document).find('#txtUba').val(datos[0].uba);
                                $(window.parent.document).find('#ddlTipoUba').val(datos[0].idTipoUba).prop('disabled', 'disabled');
                                $(window.parent.document).find('#txtUbaSistema').val(datos[0].UbaSistema).prop('disabled', 'disabled');

                                if (datos[0].Activo == 'True')
                                    $(window.parent.document).find('#chkActivo').prop("checked", true);
                            }
                            else {
                                alerta(datosJson.mensaje, datosJson.tipoMensaje);
                                CloseModalBox();
                            }
                                
                        }
                        catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                }
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarTiposUba() {

                var jsonInput = "{ idTipoGeneralidad: 'TIUB' }";
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
                            $(window.parent.document).find('#ddlTipoUba').empty();
                            var event_data = '';
                            $(window.parent.document).find("#ddlTipoUba").append('<option value="' + '' + '">Seleccione una opción</option>');

                            $.each(informacion, function (index, value) {
                                $(window.parent.document).find("#ddlTipoUba").append('<option value="' + value.IdGeneralidad + '">' + value.Descripcion + '</option>');
                            });
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