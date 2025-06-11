<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeguridadReportes.aspx.cs" Inherits="BuenComienzo.Paginas.Administracion.SeguridadReportes" %>

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
    <style type="text/css">
                
.toggle-switch {
    position: relative;
    width: 60px;
}

    .toggle-switch input {
        display: none;
    }

    .toggle-switch label {
        display: block;
        overflow: hidden;
        cursor: pointer;
        -webkit-border-radius: 20px;
        -moz-border-radius: 20px;
        border-radius: 20px;
    }

.toggle-switch-inner {
    width: 200%;
    margin-left: -100%;
    -webkit-transition: margin 0.3s ease-in 0s;
    -moz-transition: margin 0.3s ease-in 0s;
    -o-transition: margin 0.3s ease-in 0s;
    transition: margin 0.3s ease-in 0s;
}

    .toggle-switch-inner:before, .toggle-switch-inner:after {
        float: left;
        width: 50%;
        height: 20px;
        padding: 0;
        line-height: 22px;
        font-size: 12px;
        text-shadow: 1px 1px 1px #FFFFFF;
        color: #929292;
        background-color: #F5F5F5;
        -moz-box-sizing: border-box;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        -webkit-border-radius: 20px;
        -moz-border-radius: 20px;
        border-radius: 20px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .05);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, .05);
    }

    .toggle-switch-inner:before {
        content: "SI";
        padding-left: 15px;
        height: 22px;
        -webkit-border-radius: 20px 0 0 20px;
        -moz-border-radius: 20px 0 0 20px;
        border-radius: 20px 0 0 20px;
    }

    .toggle-switch-inner:after {
        content: "NO";
        padding-right: 10px;
        height: 22px;
        text-align: right;
        -webkit-border-radius: 0 20px 20px 0;
        -moz-border-radius: 0 20px 20px 0;
        border-radius: 0 20px 20px 0;
    }

.toggle-switch-switch {
    width: 20px;
    margin: 0;
    border: 2px solid #d8d8d8;
    -webkit-border-radius: 20px;
    -moz-border-radius: 20px;
    border-radius: 20px;
    position: absolute;
    top: 0;
    bottom: 0;
    right: 35px;
    color: #f8f8f8;
    line-height: 1em;
    text-shadow: 0 0px 1px #ADADAD;
    text-align: center;
    -webkit-transition: all 0.3s ease-in 0s;
    -moz-transition: all 0.3s ease-in 0s;
    -o-transition: all 0.3s ease-in 0s;
    transition: all 0.3s ease-in 0s;
    background-color: #f0f0f0;
    background-image: -webkit-linear-gradient(top, #f0f0f0, #dfdfdf);
    background-image: -moz-linear-gradient(top, #f0f0f0, #dfdfdf);
    background-image: -ms-linear-gradient(top, #f0f0f0, #dfdfdf);
    background-image: -o-linear-gradient(top, #f0f0f0, #dfdfdf);
    background-image: linear-gradient(to bottom, #f0f0f0, #dfdfdf);
}

.toggle-switch input:checked + .toggle-switch-inner {
    margin-left: 0;
}

    .toggle-switch input:checked + .toggle-switch-inner + .toggle-switch-switch {
        right: 0px;
    }

.toggle-switch-danger input:checked + .toggle-switch-inner + .toggle-switch-switch {
    border: 2px solid #D15E5E;
    background: #D15E5E;
}

.toggle-switch-warning input:checked + .toggle-switch-inner + .toggle-switch-switch {
    border: 2px solid #DFD271;
    background: #DFD271;
}

.toggle-switch-info input:checked + .toggle-switch-inner + .toggle-switch-switch {
    border: 2px solid #7BC5D3;
    background: #7BC5D3;
}

.toggle-switch-success input:checked + .toggle-switch-inner + .toggle-switch-switch {
    border: 2px solid #63CC9E;
    background: #63CC9E;
}

.toggle-switch-primary input:checked + .toggle-switch-inner + .toggle-switch-switch {
    border: 2px solid #6AA6D6;
    background: #6AA6D6;
}

.toggle-switch2 {
    position: relative;
    width: 80px;
}

    .toggle-switch2 input {
        display: none;
    }

    .toggle-switch2 label {
        display: block;
        overflow: hidden;
        cursor: pointer;
        -webkit-border-radius: 20px;
        -moz-border-radius: 20px;
        border-radius: 20px;
    }

.toggle-switch2-inner {
    width: 200%;
    margin-left: -100%;
    -webkit-transition: margin 0.3s ease-in 0s;
    -moz-transition: margin 0.3s ease-in 0s;
    -o-transition: margin 0.3s ease-in 0s;
    transition: margin 0.3s ease-in 0s;
}

    .toggle-switch2-inner:before, .toggle-switch2-inner:after {
        float: left;
        width: 50%;
        height: 20px;
        padding: 0;
        line-height: 20px;
        font-size: 12px;
        text-shadow: 1px 1px 1px #FFFFFF;
        color: #929292;
        background-color: #F5F5F5;
        -moz-box-sizing: border-box;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        -webkit-border-radius: 20px;
        -moz-border-radius: 20px;
        border-radius: 20px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .05);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, .05);
    }

    .toggle-switch2-inner:before {
        content: "Abierto";
        padding-left: 5px;
        height: 22px;
        -webkit-border-radius: 20px 0 0 20px;
        -moz-border-radius: 20px 0 0 20px;
        border-radius: 20px 0 0 20px;
    }

    .toggle-switch2-inner:after {
        content: "Cerrado";
        padding-right: 5px;
        height: 22px;
        text-align: right;
        -webkit-border-radius: 0 20px 20px 0;
        -moz-border-radius: 0 20px 20px 0;
        border-radius: 0 20px 20px 0;
    }

.toggle-switch2-switch {
    width: 20px;
    margin: 0;
    border: 2px solid #d8d8d8;
    -webkit-border-radius: 20px;
    -moz-border-radius: 20px;
    border-radius: 20px;
    position: absolute;
    top: 0;
    bottom: 0;
    right: 55px;
    color: #f8f8f8;
    line-height: 1em;
    text-shadow: 0 0px 1px #ADADAD;
    text-align: center;
    -webkit-transition: all 0.3s ease-in 0s;
    -moz-transition: all 0.3s ease-in 0s;
    -o-transition: all 0.3s ease-in 0s;
    transition: all 0.3s ease-in 0s;
    background-color: #f0f0f0;
    background-image: -webkit-linear-gradient(top, #f0f0f0, #dfdfdf);
    background-image: -moz-linear-gradient(top, #f0f0f0, #dfdfdf);
    background-image: -ms-linear-gradient(top, #f0f0f0, #dfdfdf);
    background-image: -o-linear-gradient(top, #f0f0f0, #dfdfdf);
    background-image: linear-gradient(to bottom, #f0f0f0, #dfdfdf);
    background: #D15E5E;
    border: 2px solid #D15E5E;
}

.toggle-switch2 input:checked + .toggle-switch2-inner {
    margin-left: 0;
}

    .toggle-switch2 input:checked + .toggle-switch2-inner + .toggle-switch2-switch {
        right: 0px;
    }

.toggle-switch2-danger input:checked + .toggle-switch2-inner + .toggle-switch2-switch {
    border: 2px solid #D15E5E;
    background: #D15E5E;
}

.toggle-switch2-warning input:checked + .toggle-switch2-inner + .toggle-switch2-switch {
    border: 2px solid #DFD271;
    background: #DFD271;
}

.toggle-switch2-info input:checked + .toggle-switch2-inner + .toggle-switch2-switch {
    border: 2px solid #7BC5D3;
    background: #7BC5D3;
}

.toggle-switch2-success input:checked + .toggle-switch2-inner + .toggle-switch2-switch {
    border: 2px solid #63CC9E;
    background: #63CC9E;
}

.toggle-switch2-primary input:checked + .toggle-switch2-inner + .toggle-switch2-switch {
    border: 2px solid #6AA6D6;
    background: #6AA6D6;
}

    </style>
</head>
<body>
    <div id="loading" style="display: block;display: flex;text-align: center;position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="frmSeguridadReportes" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>
                    Administrar seguridad en los informes
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
                            <div>
                                <asp:Button ID="btnGuardar" runat="server" OnClientClick="Guardar();" OnClick="btnGuardar_Click" CssClass="btn btn-cincopasitos btn-label-left" Text="Guardar" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="box">
                        <div class="box-body">
                            <div style="overflow-x: auto;">
                                <asp:GridView ID="gvSeguridad" ToolTip="" runat="server" AutoGenerateColumns="true" OnRowDataBound="gvSeguridad_RowDataBound"
                                    CssClass="table table-bordered table-striped table-hover table-heading table-datatable" DataKeyNames="IdReporte">
                                </asp:GridView>
                            </div>
                            <asp:HiddenField ID="hidSeguridad" runat="server" />
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

         <script type="text/javascript">

             $(window).load(function () {
                 setTimeout(function () { $('#loading').fadeOut(300, "linear"); }, 300);
             });

             function Guardar() {
                 var selected = [];
                 $('#gvSeguridad input:checked').each(function () {
                     selected.push($(this).attr('id'));
                 });

                 $('#<%= hidSeguridad.ClientID %>').val(selected.toString());
             }
         </script>
    </form>
    
</body>
</html>
