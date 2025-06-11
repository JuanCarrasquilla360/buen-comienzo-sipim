<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Lugar.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.Lugar" %>

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
                        <div class="" style="padding-left: 10px; padding-top:10px">
                                <input id="btnNuevo" type="button" class="btn btn-cincopasitos" value="Nuevo" />
                         </div>
                        <div class="col-md-12 col-xs-12">                            
                        </div>
                        <div class="col-md-12 col-xs-12" style="margin-top: 12px">
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="grdLugares" class="table table-bordered table-striped">
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
                this.tabla = $("#grdLugares").DataTable({
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
                            'aoColumns': columnasJSON(['Código Lugar', 'Dane', 'Nit', 'Tipo Lugar', 'Nombre Lugar', 'Comuna', 'Barrio', 'Dirección', 'Responsable', '']),
                            "bServerSide": true,
                            "sAjaxSource": "../WebMethods.aspx/ConsultarLugares",
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
                                            $("#grdLugares").show().css('width', '100%');
                                        }
                                });
                            }
                });
            }

            function Editar(idLugar, nuevo) {                
                openPopup({
                    'title': 'Editar Lugar',
                    'width': '900',
                    'url': './Popups/EditarLugar.aspx?idLugar=' + idLugar,
                    'buttons': [{
                        'name': 'Guardar',
                        'click': function () {
                            if ($('#EditarLugar', parent.document).isValid()) {
                                var objLugar = new Object();
                                objLugar.idLugar = idLugar;
                                objLugar.nuevo = nuevo;
                                objLugar.dane = $('#txtDane', parent.document).val();
                                objLugar.nit = $('#txtNit', parent.document).val();
                                objLugar.tipoLugar = $('#ddlTipoLugar option:selected', parent.document).val();
                                objLugar.tipoModalidad = $('#ddlTipoModalidad option:selected', parent.document).val();
                                objLugar.nombreLugar = $('#txtNombreLugar', parent.document).val();
                                objLugar.entorno = $('#ddlEntorno option:selected', parent.document).val();
                                objLugar.comuna = $('#ddlComuna option:selected', parent.document).val();
                                objLugar.barrio = $('#ddlBarrio option:selected', parent.document).val();
                                objLugar.direccion = $('#lblDireccion', parent.document).html();
                                objLugar.telefono1 = $('#txtTelefono1', parent.document).val();
                                objLugar.telefono2 = $('#txtTelefono2', parent.document).val();
                                objLugar.nombreResponsable = $('#txtNombreResponsable', parent.document).val();

                                execMethod('../WebMethods.aspx/ActualizarLugar', 'POST', objLugar, function (resp) {
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



                //Se configuran los campos de fecha
                parent.configDateTimePicker(true);
                //Se configuran la validación
                parent.configFormValidate('EditarLugar', 'date, security');
                                                  
            }

           

        </script>
    </form>
</body>
</html>
