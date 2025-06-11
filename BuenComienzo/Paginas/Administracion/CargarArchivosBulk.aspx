<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CargarArchivosBulk.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.CargarArchivosBulk" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cargar Archivos</title>
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
    <form id="CargarArchivosBulk" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Cargar Archivos
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../../Index.aspx"><i class="fa fa-home"></i>Inicio</a></li>
                </ol>
            </section>
            <!-- Main content -->
            <section class="content">
                <!-- Small boxes (Stat box) -->

                <div class="box">
                    <div class="row" style="margin-top: 20px">
                        <div class="col-md-8 col-xs-8">
                            <div class="col-sm-2">
                                <label class="control-label">Tipo de Archivo</label>
                            </div>
                            <div class="col-sm-6">
                                <select id="ddlTipoArchivo" runat="server" class="form-control">
                                    <option value="">--Seleccione--</option>
                                    <option value="TMP_TBL_CARACTERIZACIONBUENCOMIENZO">Caracterización Buen Comienzo SIBC</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding: 4px 4px 4px 4px;">
                        <div class="col-sm-8">
                            <div class="col-sm-2">
                                <label class="control-label">Archivo</label>
                            </div>
                            <div class="col-sm-6">
                                <input id="flArchivo" class="filestyle" type="file" runat="server" data-buttontext="" data-buttonname="btn-cincopasitos" data-validation="required" />
                            </div>  
                        </div>
                    </div>
                     <div class="row" style="padding: 4px 4px 4px 4px;">
                        <div class="col-sm-8">
                             <div class="col-sm-8">
                                <input id="btnCargar" type="button" class="btn btn-cincopasitos" value="Cargar Archivo" />
                            </div>
                        </div>
                    </div>
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

        <script src="../../plugins/Merge-Cells-HTML-Table/jquery.table.marge.js"></script>
        <%-- <AutomaticRowSpan
        <script src="../../plugins/AutomaticRowSpan/jquery.rowspanizer.js"></script>--%>
        <!-- Script -->
        <script type="text/javascript">


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


                $('#flArchivo').filestyle();


                $('#btnCargar').click(function () {
                    if ($("#ddlTipoArchivo").val()== "") {
                        alerta("Seleccione un tipo de archivo", "Advertencia");
                        return;
                    }
                    if ($('#flArchivo').get(0).files.length == 0) {
                        alerta("Ingrese un archivo", "Advertencia");
                        return;
                    }

                    fileUpLoad();

                });

                

                function fileUpLoad() {
                    var form_data = new FormData();
                    var tipoArchivo = $("#ddlTipoArchivo").val();
                    //$('#DivCargandoArchivo', parent.document).css('display', 'block');
                    form_data.append('file', $('#flArchivo').get(0).files[0]);
                    form_data.append('SubirArchivo', true);
                    form_data.append('TipoArchivo', tipoArchivo);
                    form_data.append('idPadre', 0);
                    $.ajax({
                        url: '../Operacion/loadFile.aspx',  //Server script to process data
                        type: 'POST',
                        async: false,
                        success: function (result) {
                            //TODO Call Function to execute BulkInsert
                            alerta("Archivo procesado con éxito", "Exito");
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




        </script>
    </form>
</body>
</html>

