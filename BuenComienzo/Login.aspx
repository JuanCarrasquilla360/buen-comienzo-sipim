<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BuenComienzo.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Buen Comienzo | Ingreso</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <!-- Bootstrap 3.3.5 -->
    <link href="plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <%--<link href="plugins/fonts/font-awesome.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link href="plugins/fonts/ionicons.min.css" rel="stylesheet" />

    <!-- Theme style -->
    <link href="Content/AdminLTE.min.css" rel="stylesheet" />
    <link href="Content/BuenComienzoFamiliar.css" rel="stylesheet" />
    <!-- sweetalert -->
    <link href="plugins/sweetalert2/sweetalert2.min.css" rel="stylesheet" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="Scripts/html5shiv.js"></script>
        <script src="Scripts/respond.min.js"></script>
    <![endif]-->

    <!-- jQuery 2.1.4 -->
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- sweetalert -->
    <script src="plugins/sweetalert2/sweetalert2.all.min.js"></script>
    <!-- BuenComienzoFamiliar -->
    <script src="Scripts/BuenComienzoFamiliar.js"></script>
    <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        .clearfix {
            float: none;
            clear: both;
        }


        body {
            background-color: rgb(207, 207, 207);
        }

        .fondo {
            background-image: url('img/HOME-02.svg');
            border: 1px solid transparent;
            background-repeat: no-repeat;
            background-position-x: 50%;
            min-width: 400px;
        }

        .principal {
            margin: 50px auto;
            background-color: #fff;
            height: 600px;
            padding: 10px;
            width: 800px;
            border-radius: 20px;
            box-shadow: 0px 0px 8px #b4b2b2;
        }



        .caja-login-1 {
            width: 60%;
            float: left;
            margin-top: 200px;
            border-right: 1px solid #eee;
        }

        .caja-login-2 {
            width: 30%;
            float: left;
            margin-top: 200px;
            margin-left: 20px;
        }

        .login-input__button {
            text-align: center;
        }

            .login-input__button button {
                border: none;
                border-radius: 5px;
                background-color: rgb(0, 76, 148);
                color: white;
                padding: 5px;
                text-align: center;
                margin: 0 auto;
                margin-top: 20px;
            }

                .login-input__button button:hover {
                    background-color: rgb(35, 93, 146);
                    cursor: pointer;
                }

                .login-input__button button:disabled,
                .login-input__button button[disabled] {
                    background-color: rgb(119, 151, 182);
                    cursor: wait;
                }

        .login-input_focus {
            border-bottom: 3px dotted #eee;
        }

        .login-input {
            display: flex;
            width: 100%;
            flex-direction: row;
            border-bottom: 2px dotted #eee;
            align-items: flex-end;
        }

        .login-input__input {
            width: 100%;
            height: 20px;
            border: none;
            box-shadow: none;
            background-color: transparent;
        }

            .login-input__input:focus {
                outline: none;
            }

        .login-input__icon {
            width: 30px;
            height: 30px;
        }


        .footer {
            margin-top: 75px;
            margin-left: 50px;
        }

        @media (max-width:620px) {

            .principal {
                width: 300px;
                min-height: auto;
                height: 500px;
            }

            .caja-login-1 {
                float: none;
                min-height: auto;
                line-height: 20px;
                width: 100%;
                margin-top: 50px;
            }

            .caja-login-2 {
                width: 100%;
                float: none;
                margin-top: 50px;
            }

            .login-input {
                display: flex;
                width: 90%;
                flex-direction: row;
                border-bottom: 2px dotted #eee;
                align-items: flex-end;
            }

            .footer {
                margin: 0 auto;
                height: 90px;
                margin-left: 93px;
            }

                .footer span img {
                    height: 90px;
                }
        }
    </style>
</head>
<body class="hold-transition login-page">

    <div id="modalDialog">
        <div class="modal col-md-12" style="overflow-y: auto">
            <div class="modal-rigth"></div>
            <div class="modal-dialog" style="width: auto !important">
                <div class="modal-content" style="border-radius: 6px;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="CloseModalBox();"><span aria-hidden="true">×</span></button>
                        <h4 class="modal-title" style="font-weight: bold"></h4>
                    </div>
                    <div class="modal-body">
                        <p>One fine body…</p>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <div class="modal-left"></div>
            <!-- /.modal-dialog -->
        </div>
    </div>
    <div class="fondo">
        <div class="principal">
            <div class="caja-login-1">
                <img src="img/logo.jpg" style="width: 50%; margin-left: 25%" alt="" />
            </div>
            <div class="caja-login-2">
                <form id="frmLogin" runat="server">
                    <div class="login-input">
                        <img src="img/HOME-03.svg" class="login-input__icon" alt="" />
                        <input class="login-input__input" type="text" placeholder="Usuario" id="txtUsuario" maxlength="12" runat="server" data-validation="required" autocomplete="off" />
                    </div>
                    <div class="login-input">
                        <img src="img/HOME-04.svg" class="login-input__icon" alt="" />
                        <input class="login-input__input" type="password" id="txtPassword" maxlength="50" runat="server" data-validation="required" placeholder="Contraseña" />
                    </div>
                    <div class="login-input__button">
                        <button type="button" id="btnIngresar">Ingresar</button>
                    </div>
                </form>
                <div class="footer">
                    <span>

                        <img src="img/logo-footer.png" alt="Alcaldia de Medellin" style="height: 90px;" />
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 3.3.5 -->
    <script src="plugins/bootstrap/js/bootstrap.js"></script>
    <!-- form validator -->
    <script src="plugins/jqueryValidator/jquery.form-validator.min.js"></script>

    <script>
        $(document).ready(function () {

            $(document).bind('keypress', function (e) {
                if (e.keyCode == 13) {
                    if ($('.modal').css('display') == 'block')
                        $('#Cambiar').click();
                    else
                        $('#btnIngresar').click();
                }
            });

            $.validate({
                form: '#frmLogin',
                lang: 'es'
            });

            $('#txtUsuario').focus();

            $('#btnIngresar').click(function () {

                if ($('#frmLogin').isValid()) {

                    $('#btnIngresar').attr('disabled', 'disabled');

                    var campos = 'usuario,password'
                    var valores = $('#txtUsuario').val() + ',' +
                        $('#txtPassword').val();

                    ejecutarMetodoAsync('./Paginas/WebMethods.aspx/Ingresar', 'POST', campos, valores, function (resp) {
                        try {

                            datosJson = JSON.parse(resp.d);

                            if (datosJson.resultado) {
                                switch (datosJson.mensaje) {
                                    case 'CambiarPassword':
                                        openPopup({
                                            'title': 'Cambiar clave',
                                            'width': '400',
                                            'url': './CambiarClave.aspx',
                                            'buttons': [{
                                                'name': 'Cambiar',
                                                'click': function () {
                                                    if ($('#frmCambiarClave').isValid()) {
                                                        var campos = 'idUsuario,password'
                                                        var valores = $('#txtUsuario').val() + ',' +
                                                            $('#txtClave').val();

                                                        ejecutarMetodoAsync('./Paginas/WebMethods.aspx/CambiarClave', 'POST', campos, valores, function (resp2) {
                                                            try {

                                                                datosJson = JSON.parse(resp2.d);
                                                                alerta(datosJson.mensaje, datosJson.tipoMensaje);

                                                                if (datosJson.resultado) {
                                                                    CloseModalBox();
                                                                    window.parent.location = './Default.aspx';
                                                                }
                                                            }
                                                            catch (e) {
                                                                alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                                                            }
                                                        });
                                                    }
                                                }
                                            },
                                            {
                                                'name': 'Cerrar',
                                                'click': function () {
                                                    CloseModalBox();
                                                    $('#btnIngresar').removeAttr('disabled');
                                                }
                                            }]
                                        });

                                        $('#txtClave_confirmation').focus();

                                        $.validate({
                                            form: '#frmCambiarClave',
                                            modules: 'security',
                                            lang: 'es'
                                        });

                                        break;
                                    case 'Ingresar':
                                        window.parent.location = './Default.aspx';
                                        break;
                                }
                            }
                            else {
                                alerta(datosJson.mensaje, datosJson.tipoMensaje);
                                $('#btnIngresar').removeAttr('disabled');
                            }
                        }
                        catch (e) {
                            $('#btnIngresar').removeAttr('disabled');
                            alerta('Ha ocurrido un error inesperado. Por favor contacte al administrador del sistema. ' + e.message, 'Error');
                        }
                    });
                }
            });

        });

    </script>

</body>
</html>
