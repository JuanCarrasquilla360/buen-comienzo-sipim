<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BuenComienzo.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <%--<link href="plugins/fonts/font-awesome.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link href="plugins/fonts/ionicons.min.css" rel="stylesheet" />
    <!-- Theme style -->
    <link href="Content/AdminLTE.min.css" rel="stylesheet" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="Content/_all-skins.min.css" rel="stylesheet" />

    <link href="Content/skin-red-light.min.css" rel="stylesheet" />
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css" />
    <!-- Morris chart -->
    <link rel="stylesheet" href="plugins/morris/morris.css" />
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" />
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker-bs3.css" />
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <!-- cincoPasitos -->
    <link href="Content/BuenComienzoFamiliar.css" rel="stylesheet" />

    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <script type="text/javascript">
        $('#framePrincipal', parent.document).css('height', '0px');
    </script>
</head>
<body>
    <div id="loading" style="display: block;display: flex;text-align: center;position: absolute;">
        <img src="img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="form1" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header titleSP">
                <h1 >Panel de inicio
                    <%--<small>Control panel</small>--%>
                </h1>
                <%--                <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                    <li class="active">Panel de inicio</li>
                </ol>--%>
            </section>

            <!-- Main content -->
            <section class="content">
                <!-- Small boxes (Stat box) -->
                <div class="row">
                    <%--<div class="col-md-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-blue">
                            <div class="inner">
                                <h3 id="nroBeneficiarios">0</h3>
                                <p>Cantidad de beneficiarios</p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-happy"></i>
                            </div>
                            <a href="javascript:void(0);" class="small-box-footer" id="btnBeneficiarios">Más info <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-md-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-green">
                            <div class="inner">
                                <h3 id="nroLlamadas">0</h3>
                                <p>Cantidad de llamadas</p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-android-call"></i>
                            </div>
                            <a href="javascript:void(0);" class="small-box-footer" id="btnLlamadas">Más info <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-md-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-teal">
                            <div class="inner">
                                <h3 id="nroVisitasPsicosocial">0</h3>
                                <p>Cantidad de visitas psicosociales</p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-ios-home"></i>
                            </div>
                            <a href="javascript:void(0);" class="small-box-footer" id="btnVisitasPsicosocial">Más info <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <!-- ./col -->
                    <div class="col-md-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-fuchsia">
                            <div class="inner">
                                <h3 id="nroVisitasNutricion">0</h3>
                                <p>Cantidad de visitas nutricionales</p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-ios-pulse-strong"></i>
                            </div>
                            <a href="javascript:void(0);" class="small-box-footer" id="btnVisitasNutricion">Más info <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>--%>
                    <!-- ./col -->
                    <div class="col-md-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-yellow">
                            <div class="inner">
                                <h3 id="nroRemisionesPendientes">0</h3>
                                <p>Cantidad de Remisiones Pendientes</p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-android-call"></i>
                            </div>
                            <a href="javascript:void(0);" class="small-box-footer" id="btnRemisionesPendientes">Remisiones<i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>
                    <div class="col-md-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-green-custom">
                            <div class="inner">
                                <h3 id="nroUsuarios">0</h3>
                                <p>Cantidad de Usuarios Activos</p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-ios-people"></i>
                            </div>
                            <a href="../Paginas/Remision/RemisionesPendientes.aspx" class="small-box-footer" id="btnUsuarios">Más info <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>

                    <div class="col-md-3 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-purple">
                            <div class="inner">
                                <h3 id="nroVisitasHigieneOral">4</h3>
                                <p>Video tutoriales</p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-ios-home"></i>
                            </div>
                            <a href="https://drive.google.com/drive/folders/1ZgTIXEmhqt9mcmmzn0ECKpiEExjLF3b2?usp=sharing" target="_blank" class="small-box-footer" id="btnVisitasHigieneOral">Ver Videos <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div>

                    <!-- ./col -->
                </div>
                <!-- /.row -->
            </section>
            <!-- /.content -->
        </div>
    </form>
    <!-- Cinco Pasitos -->
    <script src="Scripts/BuenComienzoFamiliar.js"></script>

    <script type="text/javascript">

       <%-- var interventoria;

        $(document).ready(function () {

            interventoria = '<%= Session["Interventoria"] %>';

            if (interventoria == 'True')
                (find).attr('disabled', 'disabled');
           
        });--%>


        $(window).load(function () {
            setTimeout(function () { $('#loading').fadeOut(300, "linear"); Cargar(); }, 300);
        });

       function Cargar() {

           $('#framePrincipal', parent.document).css('height', document.body.scrollHeight);

           ejecutarMetodo('./Paginas/WebMethods.aspx/ObtenerContadoresBaseDatos', 'GET', '', '', function (result) {
               try {
                   var contadores = JSON.parse(result.d);
                   //$('#nroBeneficiarios').html(contadores.NroBeneficiarios);
                   //$('#nroLlamadas').html(contadores.NroLlamadas);
                   //$('#nroVisitasPsicosocial').html(contadores.NroVisitasPsicosocial);
                   //$('#nroVisitasNutricion').html(contadores.NroVisitasNutricion);
                   $('#nroRemisionesPendientes').html(contadores.NroRemisionesPendientes);
                   $('#nroUsuarios').html(contadores.NroUsuarios);
               }
               catch (e) {
                   alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
               }
           });

           $('.treeview-menu', parent.document).find('li').removeClass('active');
       }

       $(document).ready(function () {
           //$('#btnBeneficiarios').click(function () {
           //    $(parent.document).find('#framePrincipal').attr("src", "Paginas/Administracion/Beneficiarios.aspx");
           //});

           //$('#btnLlamadas').click(function () {
           //    $(parent.document).find('#framePrincipal').attr("src", "Paginas/Operacion/RegistroLlamadas.aspx");
           //});

           //$('#btnVisitasPsicosocial').click(function () {
           //    $(parent.document).find('#framePrincipal').attr("src", "Paginas/Operacion/VisitaPsicosocial.aspx");
           //});

           //$('#btnVisitasNutricion').click(function () {
           //    $(parent.document).find('#framePrincipal').attr("src", "Paginas/Operacion/VisitaNutricional.aspx");
           //});

           //$('#btnVisitasHigieneOral').click(function () {
           //    $(parent.document).find('#framePrincipal').attr("src", "Paginas/Operacion/VisitaHigieneOral.aspx");
           //});
       });

    </script>
</body>
</html>
