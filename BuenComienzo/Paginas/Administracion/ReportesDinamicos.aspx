<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportesDinamicos.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.ReportesDinamicos" %>

<!DOCTYPE html>

<html>
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
    <!-- form validator -->
    <script src="../../plugins/jqueryValidator/jquery.form-validator.min.js"></script>
    <!-- moment -->
    <script src="../../plugins/moment/moment.min.js"></script>
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <!-- inputmask -->
    <script src="../../plugins/input-mask/jquery.inputmask.js"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="../../plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <!-- timepicker -->
    <script src="../../plugins/timepicker/bootstrap-timepicker.min.js"></script>
    <!-- daterangepicker -->
    <script src="../../plugins/moment/moment.min.js"></script>
    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>
    <script type="text/javascript">
        $('#framePrincipal', parent.document).css('height', '0px');
    </script>
</head>
<body>
    <div id="loading" style="display: block;display: flex;text-align: center;position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="frmReportesDinamicos" runat="server">
        <section class="content-header">
            <h1>Informes
            </h1>
            <ol class="breadcrumb">
                <li><a href="../../Index.aspx"><i class="fa fa-home"></i>Inicio</a></li>
            </ol>
        </section>
        <section style="padding:20px">
            <div class="row">
                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                            <label class="control-label">Seleccione el reporte</label>
                        </div>
                        <div class="col-sm-10">
                            <select id="ddlReporte" class="form-control" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="row" style="padding: 4px 4px 4px 4px;">
                    <div class="col-sm-12">
                        <div class="col-sm-2">
                        </div>
                        <div class="col-sm-10">
                            <label class="control-label" id="lblDescripcion" style="font-weight: normal; font-size: x-small"></label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div id="dvFiltros" class="form-group" style="display: none;">
                    <div class="row" style="padding: 4px 4px 4px 4px;">
                        <div class="col-sm-12">
                            <div class="col-sm-2" id="dvOperador1">
                                <label class="control-label">Nombre del operador</label>
                            </div>
                            <div class="col-sm-4" id="dvOperador2">
                                <select id="ddlOperador" class="form-control" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding: 4px 4px 4px 4px;">
                        <div class="col-sm-12">
                            <div id="dvUnidadServicio">
                                <div class="col-sm-2">
                                    <label class="control-label">Coordinador</label>
                                </div>
                                <div class="col-sm-4">
                                    <select id="ddlUnidadServicio" class="form-control" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding: 4px 4px 4px 4px;" id="dvFecha">
                        <div class="col-sm-12">
                            <div class="col-sm-2">
                                <label class="control-label">Fecha inicio</label>
                            </div>
                            <div class="col-sm-2">
                                <input type="text" id="txtFechaInicio" runat="server" data-validation="required" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask>
                                <%--<input type="text" runat="server" id="txtFechaInicio" class="form-control" placeholder="dd/mm/yyyy" maxlength="10" fecha="s" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask>--%>
                            </div>
                            <div class="col-sm-2">
                            </div>
                            <div class="col-sm-2">
                                <label class="control-label">Fecha fin</label>
                            </div>
                            <div class="col-sm-2">
                                <input type="text" id="txtFechaFin" runat="server" data-validation="required" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask>
                                <%--<input type="text" runat="server" id="txtFechaFin" class="form-control" placeholder="dd/mm/yyyy" maxlength="10" fecha="s" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask>--%>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding: 4px 4px 4px 4px;" id="dvMes">
                        <div class="col-sm-12">
                            <div class="col-sm-2">
                                <label class="control-label">Mes</label>
                            </div>
                            <div class="col-sm-4">
                                <select id="ddlMeses" class="form-control" runat="server" />
                            </div>
                            <div class="col-sm-12">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="col-sm-12">
                            <button type="submit" class="btn btn-cincopasitos btn-label-left" onclick="Exportar(); return false;">
                                <span><i class="fa fa-cloud-download"></i></span>Generar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </form>
    <script type="text/javascript">
        $(window).load(function () {
            setTimeout(function () { $('#loading').fadeOut(300, "linear"); }, 300);
        });
        $(document).ready(function () {

            parent.configTimePicker();
            //Se configuran los campos de fecha
            configDateTimePicker(true);
            //Se configuran la validación
            parent.configFormValidate('frmReportesDinamicos', 'date');

            $('#ddlOperador').change(function () {
                ejecutarMetodo('../WebMethods.aspx/ConsultarUnidadesServicio', 'POST', 'idNitOperador', $('#ddlOperador').val(), function (resp) {
                    try {
                        datosJsonope = JSON.parse(resp.d);
                        //setSelectOptions($('#ddlUnidadServicio', parent.document), datosJson, "IdUnidadServicio", "Nombre");
                        setSelectOptions($('#ddlUnidadServicio'), datosJsonope, "IdUnidadServicio", "Nombre");
                    }
                    catch (e) {
                        alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                    }
                });
            });

            $('#ddlReporte').change(function () {
                if ($(this).val() != '') {
                    ejecutarMetodo('../WebMethods.aspx/ConsultarReporte', 'POST', 'idReporte', $(this).val(), function (datos) {
                        try {
                            datosJson = JSON.parse(datos.d);
                            if (datosJson.resultado != null && !datosJson.resultado) {
                                alerta(datosJson.mensaje, datosJson.tipoMensaje);
                            }
                            else {
                                $('#lblDescripcion').html(datosJson.Descripcion);

                                if (datosJson.CamposReporte != null) {

                                    $('#dvFiltros').show();
                                    $('#dvOperador1').hide();
                                    $('#dvOperador2').hide();
                                    $('#dvUnidadServicio').hide();
                                    $('#dvMes').hide();
                                    $('#dvFecha').hide();

                                    $('#ddlOperador').val('');
                                    $('#ddlUnidadServicio').val('');
                                    $('#ddlMeses').val('');
                                    $('#txtFechaInicio').val('');
                                    $('#txtFechaFin').val('');

                                    $.each(datosJson.CamposReporte, function () {

                                        switch (this.IdTipoCampo) {
                                            case 1:
                                                $('#dvOperador1').show();
                                                $('#dvOperador2').show();          
                                                $('#ddlOperador').change();
                                                break;
                                            case 3:
                                                $('#dvUnidadServicio').show();
                                                break;
                                            case 4:
                                                $('#dvMes').show();
                                                break;
                                            case 5:
                                                $('#dvFecha').show();
                                                break;
                                            default:
                                                break;
                                        }
                                    });

                                    if (datosJson.IdPerfil != 1 && $('#dvOperador2').css('display') == 'block') {
                                        $('#ddlOperador').val(datosJson.IdNitOperador);
                                        $('#ddlOperador').attr('disabled', 'disabled');
                                        $('#ddlOperador').change();
                                    }
                                }
                            }

                            if (datosJson.resultado)
                                tblSeguimiento.fnDeleteRow(tblSeguimiento.fnGetPosition(nodo.parentNode.parentNode));

                        } catch (e) {
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                }
                else {
                    $('#dvFiltros').hide();
                    $('#ddlOperador').val('');
                    $('#ddlUnidadServicio').val('');
                    $('#ddlMeses').val('');
                    $('#txtFechaInicio').val('');
                    $('#txtFechaFin').val('');
                    $('#lblDescripcion').html('');
                }
            });
        });


        //SeleccionFecha('txtFechaInicio', true, true);
        //SeleccionFecha('txtFechaFin', true, true);

        function Exportar() {
            if ($('#ddlReporte').val() != '')
                window.open('../ExportarDatos.aspx?exportar=ReporteGenerico&nombreReporte=' + $('#ddlReporte option:selected').text() + '&idReporte=' + $('#ddlReporte').val() + '&idNitOperador=' + $('#ddlOperador').val() + '&idMunicipio=' + $('#ddlMunicipio').val() + '&idUnidadServicio=' + $('#ddlUnidadServicio').val() + '&fechaInicio=' + $('#txtFechaInicio').val() + '&fechaFin=' + $('#txtFechaFin').val() + '&mes=' + $('#ddlMeses').val());
            else
                alerta('Debe seleccioinar un reporte para poder generar', 'Error');
        }

        function configDateTimePicker(showDropdowns) {
            $('[data-mask]').inputmask("dd/mm/yyyy", { "placeholder": "dd/mm/yyyy" }).daterangepicker({
                format: 'DD/MM/YYYY',
                singleDatePicker: true,
                showDropdowns: showDropdowns,
                "locale": {
                    "daysOfWeek": [
                        "Do",
                        "Lu",
                        "Ma",
                        "Mi",
                        "Ju",
                        "Vi",
                        "Sa"
                    ],
                    "monthNames": [
                        "Ene",
                        "Feb",
                        "Mar",
                        "Abr",
                        "May",
                        "Jun",
                        "Jul",
                        "Ago",
                        "Sept",
                        "Oct",
                        "Nov",
                        "Dec"
                    ],
                    "firstDay": 1
                },
            });
        }

    </script>
</body>
</html>
