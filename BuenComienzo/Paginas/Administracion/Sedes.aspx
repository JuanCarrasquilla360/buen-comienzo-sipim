<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sedes.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Sedes" %>

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
    <form id="frmSedes" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Sedes
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
                            <table id="grdSedes" class="table table-bordered table-striped">
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

                $('#btnNuevo').on('click', function () {
                    Editar('','S');
                });

            });

            function cargarDatos() {
                tabla = $("#grdSedes").DataTable({
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
                            'aoColumns': columnasJSON(['Id sede', 'Nombre', 'Código sede SIBC', 'Dirección', 'Teléfono', 'Celular', 'Comuna', 'Barrio', 'Correo', 'Tenencia Inmueble', 'Usuario creación', 'Fecha creación', 'Activo', '']),
                            "bServerSide": true,
                            "sAjaxSource": "../WebMethods.aspx/ConsultarSedes",
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
                                            var json = JSON.parse(msg.d);
                                            fnCallback(json);
                                            $("#grdSedes").show().css('width', '100%');
                                        }
                                });
                            }
                });
            }
            
            function Editar(idSede, nuevo) {
                openPopup({
                    'title': (nuevo == 'S') ? 'Nueva sede' : 'Editar sede',
                    'width': '900',
                    'url': './Popups/EditarSede.aspx',
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#frmEditarSede', parent.document).isValid()) {

                                if (ValidateEmail($('#txtCorreo', parent.document).val())) {

                                    var campos = 'nuevo,IdSede,NombreSede,CodigoSedeSIBC,Direccion,Telefono,Celular,IdComuna,IdBarrio,Correo,IdTenenciaInmueble,Activo'
                                    var valores = nuevo + ',' + $('#txtIdSede', parent.document).val() + ',' +
                                        $('#txtNombreSede', parent.document).val() + ',' +
                                        $('#txtCodigoSedeSIBC', parent.document).val() + ',' +
                                        $('#txtDireccion', parent.document).val() + ',' +
                                        $('#txtTelefono', parent.document).val() + ',' +
                                        $('#txtCelular', parent.document).val() + ',' +
                                        $('#ddlComuna option:selected', parent.document).val() + ',' +
                                        $('#ddlBarrio option:selected', parent.document).val() + ',' +
                                        $('#txtCorreo', parent.document).val() + ',' +
                                        $('#ddlTeneciaInmueble option:selected', parent.document).val() + ',' +
                                        $('#chkActivo', parent.document).is(":checked");

                                    ejecutarMetodoAsync('../WebMethods.aspx/ActualizarSede', 'POST', campos, valores, function (resp) {
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
                                else
                                    alerta('El correo digitado no es valido, por favor verificar ', 'Error');
                            }
                        }
                    }, {
                        'name': 'Cerrar',
                        'click': function () {
                            CloseModalBox();
                        }
                    }]
                }, function () { success(idSede, nuevo); });


                $('input[type="checkbox"].flat-red', parent.document).iCheck({
                    checkboxClass: 'icheckbox_flat-red'
                });

                //Se configuran la validación
                parent.configFormValidate('frmEditarSede', 'date, security');
            }

            function success(idSede, nuevo) {

                $(parent.document).find("#txtCelular").on('keypress', function (e) { keypressNumeric(e); });
                $(parent.document).find("#txtTelefono").on('keypress', function (e) { keypressNumeric(e); });
                $(parent.document).find("#txtCodigoSedeSIBC").on('keypress', function (e) { keypressNumeric(e); });

                if (nuevo == 'S') {
                    cargarComunas();
                    cargarGeneralidad('TITI', $("#ddlTeneciaInmueble", parent.document));
                    $(parent.document).find('#chkActivo').prop("checked", true);
                }
                else {
                    ejecutarMetodo('../WebMethods.aspx/ConsultarSede', 'POST', 'IdSede', idSede, function (resp) {
                        try {

                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                var datos = JSON.parse(datosJson.mensaje);
                                $(parent.document).find('#txtIdSede').val(datos[0].idSede);
                                $(parent.document).find('#txtNombreSede').val(datos[0].nombreSede);
                                $(parent.document).find('#txtCodigoSedeSIBC').val(datos[0].codigoSedeSIBC);
                                $(parent.document).find('#txtDireccion').val(datos[0].direccion);
                                $(parent.document).find('#txtTelefono').val(datos[0].telefono);
                                $(parent.document).find('#txtCelular').val(datos[0].celular);

                                cargarComunas(datos[0].idComuna, datos[0].idBarrio);
                                $(parent.document).find('#txtCorreo').val(datos[0].correo);
                                cargarGeneralidad('TITI', $(parent.document).find("#ddlTeneciaInmueble"), datos[0].idTenenciaInmueble);
                                
                                if (datos[0].activo == 'True')
                                    $(parent.document).find('#chkActivo').prop("checked", true);
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
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + XMLHttpRequest.responseText, 'Error');
                    }
                });
            }

            // con este cargamos los tipos de uba que tenemos en el sistema
            function cargarComunas(idcomuna, idBarrio) {
                $.ajax({
                    type: "POST",                                              // tipo de request que estamos generando
                    url: '../WebMethods.aspx/ConsultarComunas',                 // URL al que vamos a hacer el pedido
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
                    url: '../WebMethods.aspx/ConsultarBarrios',                 // URL al que vamos a hacer el pedido
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