<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitasPriorizadas.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.VisitasPriorizadas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Caracterización</title>
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
    <form id="VisitasPriorizadas" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Visitas priorizadas
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../../Index.aspx"><i class="fa fa-home"></i>Inicio</a></li>
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
                        <div class="box-body">
                            <table id="gvVisitaPriorizada" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Código</th>
                                        <th>Fecha</th>
                                        <th>Documento</th>
                                        <th>Nombre</th>
                                        <th>Tipo priorización</th>
                                        <th>Profesional encargado</th>
                                        <th style="width: 30px"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
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

        <script type="text/javascript">
            var tabla;
            var idVisitaPriorizada = -1;

            $(window).load(function () {
                setTimeout(function () {
                    $('#loading').fadeOut(300, "linear");
                }, 300);
            });


            $(document).ready(function () {
                $.validate({
                    modules: 'date, security',
                    lang: 'es'
                });

                $('#btnNuevo').click(function () {
                    Editar(-1, 'S');
                });
                CargarGrid();
            });

            function CargarGrid() {
                tabla = $("#gvVisitaPriorizada").DataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [{
                        'targets': [0, 1, 2],
                        'orderable': true
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarVisitaPriorizada",
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
                                    $("#gvVisitaPriorizada").show().css('width', '100%');
                                }
                        });
                    }
                });
            }


            function Editar(id, nuevo) {
                var title = 'Editar Visita Priorizada' + '   (' + id + ')';
                if (nuevo == 'S') {
                    title = 'Nueva Visita Priorizada';
                }
                idVisitaPriorizada = id;
                $('#IDVisitaPriorizadaHidden', parent.document).val(id);
                openPopup({
                    'title': title,
                    'width': '800',
                    'url': './Popups/EditarVisitasPriorizadas.aspx?idVisitaPriorizada=' + id,
                    'buttons': [{
                        'name': 'Cerrar',
                        'click': function () {
                            tabla.ajax.reload();
                            CloseModalBox();
                        }
                    }]
                });

                $('#imgBuscarPersona', parent.document).click(function () {
                    var idDocumento = $('#txtDocumento', parent.document).val();
                    if (idDocumento != "") {
                        idDocumento = idDocumento.replace(/(\r\n|\n|\r)/gm, ""); //Quitar espacios y enter
                        idDocumento = idDocumento.replace(/[^\w\s]/gi, ''); //Quitar caracteres especiales.
                        idDocumento = idDocumento.replace(/\s/g, ''); //Quitar espacios entre palabras
                        var objTrans = new Object();
                        objTrans.idDocumento = idDocumento;
                        execMethod('../WebMethods.aspx/ConsultarPersona', 'POST', objTrans, function (resp) {
                            try {
                                console.log("Respuesta de ConsultarPersona:", resp);
                                if (resp.d != null) {
                                    $('#nombrePersona1Div', parent.document).show();
                                    $('#txtDocumento', parent.document).attr('disabled', 'disabled');
                                    var objPersona = resp.d;
                                    $("#lblNombrePersona1", parent.document).html(objPersona.PrimerNombre + ' ' + (objPersona.SegundoNombre == null ? '' : objPersona.SegundoNombre) + ' ' + objPersona.PrimerApellido + ' ' + (objPersona.SegundoApellido == null ? '' : objPersona.SegundoApellido));
                                    $('#divSeccion2', parent.document).find('input, textarea, button, select')
                                        .not('#ddlConQueFrecuencia', parent.document)
                                        .not('#ddlFueAtendidoEnUrgenicasPorIntentoSuicidioReciente', parent.document)
                                        .not('#ddlAlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima', parent.document)
                                        .removeAttr('disabled');
                                    $('#divSeccion3', parent.document).find('input, textarea, button, select').removeAttr('disabled');
                                    $('#divSeccion4', parent.document).find('input, textarea, button, select').removeAttr('disabled');
                                    $('#txtFecha', parent.document).removeAttr('disabled');
                                    $('#ddlIdMaeVisitaPrioritaria', parent.document).removeAttr('disabled');
                                }
                                else {
                                    alerta('El documento que ingresó no se encuentra en la base de datos.', 'Advertencia');
                                    $('#nombrePersona1Div', parent.document).hide();
                                    $('#txtDocumentoPersona1', parent.document).removeAttr('disabled');
                                    return;
                                }
                            } catch (e) {
                                console.log('Error en la respuesta de ConsultarPersona', e);
                                alerta('Error en la respuesta de ConsultarPersona', 'Error');
                            }
                        });
                    }
                    else {
                        $('#DetalleCaracterizacionDiv', parent.document).find('input, textarea, button, select').not('#txtDocumentoBusqueda', parent.document).not('.eliminar', parent.document).attr('disabled', 'disabled');
                        limpiarCampos();
                        console.log('Respuesta a evaluar', resp.d);
                        alerta('La persona que intenta agregar ya existe en otro hogar', 'Error');
                    }
                });

                $('#imgBuscarDeNuevo', parent.document).click(function () {
                    $('#BuscarDeNuevoDiv', parent.document).css('display', 'none');
                    $('#nombrePersona1Div', parent.document).css('display', 'none');
                    $('#txtDocumento', parent.document).val('');
                    $('#txtDocumento', parent.document).removeAttr('disabled');
                    limpiarCampos()
                });


                //Se configuran los campos de fecha
                parent.configDateTimePicker(true);
                //Se configuran la validación
                parent.configFormValidate('EditarVisitaPriorizada', 'date, security');

                if (idVisitaPriorizada == -1) {
                    $('#divSeccion2', parent.document).find('input, textarea, button, select').attr('disabled', 'disabled');
                    $('#divSeccion3', parent.document).find('input, textarea, button, select').attr('disabled', 'disabled');
                    $('#divSeccion4', parent.document).find('input, textarea, button, select').attr('disabled', 'disabled');
                }
                else {
                    $('#txtFecha', parent.document).removeAttr('disabled');
                    $('#ddlIdMaeVisitaPrioritaria', parent.document).removeAttr('disabled');
                }


                function limpiarCampos() {
                    $('#txtFecha', parent.document).val('');
                    $('#txtFecha', parent.document).attr('disabled', 'disabled');
                    $('#ddlIdMaeVisitaPrioritaria', parent.document).val('');
                    $('#ddlIdMaeVisitaPrioritaria', parent.document).attr('disabled', 'disabled');
                    $('#divSeccion2', parent.document).find('input, textarea, button, select').attr('disabled', 'disabled');
                    $('#divSeccion3', parent.document).find('input, textarea, button, select').attr('disabled', 'disabled');
                    $('#divSeccion4', parent.document).find('input, textarea, button, select').attr('disabled', 'disabled');
                    $('#divHabilidadesParaLavida', parent.document).find('input, textarea, button, select').attr('disabled', 'disabled');
                    $('#divSeccion2', parent.document).find('input, textarea, button, select').val('');
                    $('#divSeccion3', parent.document).find('input, textarea, button, select').val('');
                    $('#divSeccion4', parent.document).find('input, textarea, button, select').val('');
                    $('#divHabilidadesParaLavida', parent.document).find('input, textarea, button, select').val('');
                    $('#divHabilidadesParaLavida', parent.document).hide();
                }

                $('#VisitaPriorizadaButton', parent.document).click(function () {
                    if ($('#EditarVisitaPriorizada', parent.document).isValid()) {
                        var objTrans = new Object();
                        objTrans.idVisitaPriorizada = idVisitaPriorizada;
                        objTrans.idDocumento = $('#txtDocumento', parent.document).val();
                        objTrans.Fecha = $('#txtFecha', parent.document).val();
                        objTrans.IdMaeVisitaPrioritaria = $('#ddlIdMaeVisitaPrioritaria', parent.document).val();
                        objTrans.IdDXCIE10 = $('#ddlIdDXCIE10', parent.document).val();
                        objTrans.HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida = $('#ddlHaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida', parent.document).val();
                        objTrans.EdadPrimerConsumo = $('#txtEdadPrimerConsumo', parent.document).val();
                        objTrans.HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia = $('#ddlHaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia', parent.document).val();
                        objTrans.HaVueltoAConsumir = $('#ddlHaVueltoAConsumir', parent.document).val();
                        objTrans.ConQueFrecuencia = $('#ddlConQueFrecuencia', parent.document).val();
                        objTrans.PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida = $('#ddlPresentaIdeasRecurrentesDeseoMorirQuitarseLaVida', parent.document).val();
                        objTrans.EnFamiliaOCirculoCercanoHaMuertoPorSuicidio = $('#ddlEnFamiliaOCirculoCercanoHaMuertoPorSuicidio', parent.document).val();
                        objTrans.PresentaSintomasDepresion = $('#ddlPresentaSintomasDepresion', parent.document).val();
                        objTrans.AlgunaVezHaTenidoIntentoSuicidio = $('#ddlAlgunaVezHaTenidoIntentoSuicidio', parent.document).val();
                        objTrans.TuvoIntentoSuicidioReciente = $('#ddlTuvoIntentoSuicidioReciente', parent.document).val();
                        objTrans.FueAtendidoEnUrgenicasPorIntentoSuicidioReciente = $('#ddlFueAtendidoEnUrgenicasPorIntentoSuicidioReciente', parent.document).val();
                        objTrans.OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir = $('#ddlOyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir', parent.document).val();
                        objTrans.EsVictimaConflictoArmado = $('#ddlEsVictimaConflictoArmado', parent.document).val();
                        objTrans.AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima = $('#ddlAlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima', parent.document).val();
                        objTrans.PresentaOHaPresentadoUltimoMesAlgunSintoma = $('#ddlPresentaOHaPresentadoUltimoMesAlgunSintoma', parent.document).val();
                        objTrans.AlInteriorGrupoFamiliarAlgunMiembro = $('#ddlAlInteriorGrupoFamiliarAlgunMiembro', parent.document).val();
                        objTrans.Observaciones = $('#txtObservaciones', parent.document).val();
                        objTrans.HabilidadesParaLaVida =  $('#ddlHabilidadesParaLaVida', parent.document).val();
                        objTrans.TipoOrientacion = $('#ddlTipoOrientacion', parent.document).val();
                        objTrans.SeguimientoIntervenciones = $('#ddlSeguimientoIntervenciones', parent.document).val();
                        objTrans.Desarrollo = $('#txtDesarrollo', parent.document).val();
                        objTrans.Logros = $('#txtLogros', parent.document).val();
                        objTrans.FechaIntervencionBreve = $('#txtFechaIntervencionBreve', parent.document).val();

                        execMethod('../WebMethods.aspx/ActualizarVisitaPriorizada', 'POST', objTrans, function (resp) {
                            try {

                                datosJson = JSON.parse(resp.d);
                                alerta(datosJson.mensaje, datosJson.tipoMensaje);
                                $('#IDVisitaPriorizadaHidden', parent.document).val(datosJson.datos);
                                idVisitaPriorizada = datosJson.datos;
                                if (datosJson.resultado) {
                                    tabla.ajax.reload();
                                }
                            }
                            catch (e) {
                                alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                            }
                        });
                    }
                });

                $('#ddlHaVueltoAConsumir', parent.document).change(function () {
                    var haVueltoAConsumir = $(this).val();
                    if (haVueltoAConsumir == "Si") {
                        $('#ddlConQueFrecuencia', parent.document).removeAttr('disabled');
                    }
                    else {
                        $('#ddlConQueFrecuencia', parent.document).attr('disabled', 'disabled');
                        $('#ddlConQueFrecuencia', parent.document).val('');
                    }
                });

                $('#ddlTuvoIntentoSuicidioReciente', parent.document).change(function () {
                    var tuvoIntento = $(this).val();
                    if (tuvoIntento == "Si") {
                        $('#ddlFueAtendidoEnUrgenicasPorIntentoSuicidioReciente', parent.document).removeAttr('disabled');
                    }
                    else {
                        $('#ddlFueAtendidoEnUrgenicasPorIntentoSuicidioReciente', parent.document).attr('disabled', 'disabled');
                        $('#ddlFueAtendidoEnUrgenicasPorIntentoSuicidioReciente', parent.document).val('');
                    }
                });

                $('#ddlEsVictimaConflictoArmado', parent.document).change(function () {
                    var EsVictuma = $(this).val();
                    if (EsVictuma == "Si") {
                        $('#ddlAlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima', parent.document).removeAttr('disabled');
                    }
                    else {
                        $('#ddlAlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima', parent.document).attr('disabled', 'disabled');
                        $('#ddlAlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima', parent.document).val('');
                    }
                });

                $('#ddlHaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida', parent.document).change(function () {
                    var haconsumido = $(this).val();
                    if (haconsumido == "No") {
                        $('#txtEdadPrimerConsumo', parent.document).attr('disabled', 'disabled');
                        $('#txtEdadPrimerConsumo', parent.document).val('');
                    }
                    else {
                        $('#txtEdadPrimerConsumo', parent.document).removeAttr('disabled');
                    }
                });

                $('#ddlIdMaeVisitaPrioritaria', parent.document).change(function () {
                    var TipoVisita = $(this).val();
                    $('#divSeccion2', parent.document).show();
                    $('#divHabilidadesParaLavida', parent.document).hide();
                    $('#divHabilidadesParaLavida', parent.document).find('input, textarea, button, select').val('');
                    $('#divHabilidadesParaLavida', parent.document).find('input, textarea, button, select').removeAttr('disabled');
                    if (TipoVisita != '1' && TipoVisita != '2' && TipoVisita != '4'  && TipoVisita != '6') {
                        $('#divSeccion2', parent.document).hide();
                        $('#divSeccion2', parent.document).find('input, textarea, select').val('');
                        $('#txtObservaciones', parent.document).attr('data-validation', 'required');
                    }
                    else {
                        $('#txtObservaciones', parent.document).removeAttr('data-validation');
                        if (TipoVisita == '6' || TipoVisita == '1' || TipoVisita == '2' || TipoVisita == '4') {
                            $('#divHabilidadesParaLavida', parent.document).show();
                        }
                    }
                });

                $('#ddlEsVictimaConflictoArmado', parent.document).change();
                $('#ddlHaVueltoAConsumir', parent.document).change();
                $('#ddlTuvoIntentoSuicidioReciente', parent.document).change();
                $('#ddlHaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida', parent.document).change();

                parent.configChangeInput('txtFecha', function () {
                    var Fecha = moment($('#txtFecha', parent.document).val(), "DD/MM/YYYY");
                    var Fecha2 = moment(Fecha).format("M");
                    var fechaActual = moment();
                    var FechaActual2 = moment().format("M");;
                    if (Fecha > fechaActual) {
                        alerta('La fecha no puede ser mayor a la fecha actual.', 'Error');
                        $('#txtFecha', parent.document).val('');
                        $('#txtFecha', parent.document).focus();
                    }
                    if (Fecha2 != FechaActual2) {
                        alerta('La fecha no puede ser diferente al mes actual.', 'Error');
                        $('#txtFecha', parent.document).val('');
                        $('#txtFecha', parent.document).focus();
                    }
                });

                
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

            }
        </script>
    </form>
</body>

</html>
