<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CaracterizacionBusquedaActiva.aspx.cs" Inherits="BuenComienzo.Paginas.BusquedaActiva.CaracterizacionBusquedaActiva" ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Caracterización Búsqueda Activa</title>
    <link href="../../plugins/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <!-- Font Awesome -->
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
    <!-- select2 -->
    <link rel="stylesheet" href="../../plugins/select2/select2.min.css" />
    <!-- tempus-dominus -->
    <link href="../../plugins/bootstrap-datetimepicker/css/tempus-dominus.min.css" rel="stylesheet" />

    <script src="../../plugins/jQuery/jQuery-2.1.4.min.js"></script>

    <script type="text/javascript">
        $('#framePrincipal', parent.document).css('height', '0px');
    </script>
</head>
<body>
    <div id="loading" style="display: block; display: flex; text-align: center; position: absolute;">
        <img src="../../img/Preloader.gif" style="height: 130px; margin: auto" alt="" />
    </div>
    <form id="CaracterizacionBusquedaActiva" runat="server">
        <div>
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Caracterización Búsqueda Activa
                    <%--<small>Control panel</small>--%>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="../../Index.aspx"><i class="fa fa-home"></i>Inicio</a></li>
                    <%--<li class="active">Caracterización Búsqueda Activa</li>--%>
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
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="grdCaracterizacionBusquedaActiva" class="table table-bordered table-striped">
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
        <!-- popper -->
        <script src="../../plugins/bootstrap-datetimepicker/popper.min.js"></script>
        <!-- tempus-dominus -->
        <script src="../../plugins/bootstrap-datetimepicker/tempus-dominus.min.js"></script>

        <!-- Script -->
        <script type="text/javascript">

            var tabla;
            var error = false;
            var esNuevo = false;

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
                    console.log('Botón Nuevo clicked');
                    console.log('openPopup function exists:', typeof openPopup);
                    console.log('parent.document modalDialog exists:', $('#modalDialog', parent.document).length);
                    Editar('', 'S');
                });

            });

            function cargarDatos() {
                this.tabla = $("#grdCaracterizacionBusquedaActiva").DataTable({
                    "destroy": true,
                    "paging": true,
                    "sDom": "<'row'<'col-sm-1'f>>" + "<'row'<'col-sm-12'tr>>" + "<'row'<'col-sm-5'i><'col-sm-7'p>>",
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bProcessing": false,
                    "scrollX": true,
                    'columnDefs': [{
                        'targets': 10,
                        'orderable': false,
                        'width': "61px"
                    }],
                    "language": {
                        "url": "../../plugins/datatables/Spanish.json"
                    },
                    'aoColumns': columnasJSON(['Fecha Focalización', 'Tipo Documento', 'Número Identificación', 'Nombre Completo', 'Fecha Nacimiento', 'Edad', 'Teléfono', 'Comuna', 'Barrio', 'Tipo Participante', '']),
                    "bServerSide": true,
                    "sAjaxSource": "../WebMethods.aspx/ConsultarCaracterizacionBusquedaActiva",
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
                                    $("#grdCaracterizacionBusquedaActiva").show().css('width', '100%');
                                }
                        });
                    }
                });
            }

            function Editar(numeroIdentificacion, nuevo) {
                console.log('Función Editar llamada con:', numeroIdentificacion, nuevo);
                esNuevo = nuevo;
                
                // Versión simplificada para debugging
                console.log('Intentando abrir popup...');
                
                var popupConfig = {
                    title: 'Caracterización Búsqueda Activa',
                    width: '900',
                    height: '700',
                    url: 'Popups/EditarCaracterizacionBusquedaActiva.aspx',
                    buttons: [
                        {
                            name: 'Guardar',
                            click: function () {
                                console.log('Botón Guardar clicked');
                                guardarCaracterizacion();
                            }
                        },
                        {
                            name: 'Cerrar',
                            click: function () {
                                console.log('Botón Cerrar clicked');
                                CloseModalBox();
                            }
                        }
                    ],
                    callBackFunction: function () {
                        console.log('Callback ejecutado');
                        successPopup(numeroIdentificacion, nuevo);
                    }
                };
                
                console.log('Configuración del popup:', popupConfig);
                
                try {
                    openPopup(popupConfig);
                    console.log('openPopup ejecutado sin errores');
                } catch (error) {
                    console.error('Error al ejecutar openPopup:', error);
                    alerta('Error al abrir el popup: ' + error.message, 'Error');
                }
            }

            // Funciones simplificadas para debugging
            console.log('Funciones auxiliares cargadas');
            
            function successPopup(numeroIdentificacion, nuevo) {
                console.log("successPopup llamado con nuevo=" + nuevo);
                
                // Establecer fecha actual
                establecerFechaActual();
                
                // Cargar datos maestros
                cargarDatosMaestros();
                
                // Configurar todos los eventos del popup
                configurarEventosPopup();
                
                console.log('successPopup completado');
            }
            
            function configurarEventosPopup() {
                console.log('Configurando eventos del popup...');
                
                // Usar timeout para asegurar que el popup esté completamente cargado
                setTimeout(function() {
                    console.log('Configurando eventos después del timeout...');
                    
                    // Configurar evento de fecha de nacimiento para calcular edad
                    $(window.parent.document).find('#txtFechaNacimiento').on('change', function() {
                        console.log('Evento change de fecha nacimiento disparado');
                        calcularEdad();
                    });
                    
                    // Configurar evento de institucionalizado
                    $(window.parent.document).find('#ddlInstitucionalizado').on('change', function() {
                        console.log('Evento change de institucionalizado disparado');
                        habilitarInstitucionalizadoCual();
                    });
                    
                    // Configurar evento de comuna para cargar barrios
                    $(window.parent.document).find('#ddlComuna').on('change', function() {
                        console.log('Evento change de comuna disparado');
                        cargarBarrios();
                    });
                    
                    // Validación de teléfonos en tiempo real
                    $(window.parent.document).find('#txtTelefono, #txtTelefono2').on('input', function() {
                        var valor = $(this).val();
                        console.log('Validando teléfono:', valor);
                        if (valor.length > 0) {
                            if (!valor.match(/^(604|3)/)) {
                                $(this).addClass('error');
                                $(this).attr('title', 'El teléfono debe iniciar con 604 o 3');
                            } else {
                                $(this).removeClass('error');
                                $(this).removeAttr('title');
                            }
                        }
                    });
                    
                    // Configurar geolocalización
                    $(window.parent.document).find('#btnObtenerUbicacion').on('click', function() {
                        console.log('Botón geolocalización clickeado');
                        obtenerUbicacion();
                    });
                    
                    // Configurar canvas de firma
                    configurarCanvasFirma();
                    
                    // Configurar carga de archivos
                    configurarCargaArchivos();
                    
                    console.log('Eventos del popup configurados correctamente');
                }, 1000); // Timeout de 1 segundo para asegurar que el popup esté listo
            }
            
            function calcularEdad() {
                console.log('Calculando edad...');
                
                var fechaNacimientoStr = $(window.parent.document).find('#txtFechaNacimiento').val();
                console.log('Fecha de nacimiento obtenida:', fechaNacimientoStr);
                
                if (!fechaNacimientoStr) {
                    console.log('No hay fecha de nacimiento');
                    $(window.parent.document).find('#txtEdadCalculada').val('');
                    return;
                }
                
                var fechaNacimiento = new Date(fechaNacimientoStr);
                var fechaActual = new Date();
                
                console.log('Fecha nacimiento parseada:', fechaNacimiento);
                console.log('Fecha actual:', fechaActual);
                
                if (!fechaNacimiento || isNaN(fechaNacimiento.getTime())) {
                    console.log('Fecha de nacimiento inválida');
                    $(window.parent.document).find('#txtEdadCalculada').val('Fecha inválida');
                    return;
                }
                
                if (fechaNacimiento > fechaActual) {
                    console.log('Fecha de nacimiento es futura');
                    $(window.parent.document).find('#txtEdadCalculada').val('Fecha inválida');
                    return;
                }

                var anios = fechaActual.getFullYear() - fechaNacimiento.getFullYear();
                var meses = fechaActual.getMonth() - fechaNacimiento.getMonth();
                var dias = fechaActual.getDate() - fechaNacimiento.getDate();

                if (dias < 0) {
                    meses--;
                    dias += new Date(fechaActual.getFullYear(), fechaActual.getMonth(), 0).getDate();
                }

                if (meses < 0) {
                    anios--;
                    meses += 12;
                }

                var edadTexto = anios + ' años ' + meses + ' meses y ' + dias + ' días';
                $(window.parent.document).find('#txtEdadCalculada').val(edadTexto);
                console.log('Edad calculada:', edadTexto);
            }
            
            function habilitarInstitucionalizadoCual() {
                console.log('Habilitando/deshabilitando institucionalizado cual...');
                
                var valor = $(window.parent.document).find('#ddlInstitucionalizado').val();
                var $ddlCual = $(window.parent.document).find('#ddlInstitucionalizadoCual');
                
                console.log('Valor institucionalizado:', valor);
                
                if (valor === 'SINO001') { // Sí
                    $ddlCual.prop('disabled', false);
                    $ddlCual.attr('data-validation', 'required');
                    console.log('Institucionalizado cual habilitado');
                } else {
                    $ddlCual.prop('disabled', true);
                    $ddlCual.removeAttr('data-validation');
                    $ddlCual.val('');
                    console.log('Institucionalizado cual deshabilitado');
                }
            }
            
            function obtenerUbicacion() {
                console.log('Obteniendo ubicación GPS...');
                
                if (!navigator.geolocation) {
                    alerta('La geolocalización no es compatible con este navegador', 'Error');
                    return;
                }
                
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        $(window.parent.document).find('#txtCoordenadax').val(position.coords.latitude);
                        $(window.parent.document).find('#txtCoordenady').val(position.coords.longitude);
                        console.log('Ubicación obtenida:', position.coords.latitude, position.coords.longitude);
                        alerta('Ubicación obtenida correctamente', 'Éxito');
                    },
                    function(error) {
                        console.error('Error al obtener ubicación:', error);
                        var mensaje = 'Error al obtener la ubicación: ';
                        switch(error.code) {
                            case error.PERMISSION_DENIED:
                                mensaje += 'Permiso denegado por el usuario';
                                break;
                            case error.POSITION_UNAVAILABLE:
                                mensaje += 'Información de ubicación no disponible';
                                break;
                            case error.TIMEOUT:
                                mensaje += 'Tiempo de espera agotado';
                                break;
                            default:
                                mensaje += error.message;
                                break;
                        }
                        alerta(mensaje, 'Error');
                    },
                    {
                        enableHighAccuracy: true,
                        timeout: 10000,
                        maximumAge: 60000
                    }
                );
            }
            
            function configurarCanvasFirma() {
                console.log('Configurando canvas de firma...');
                
                // Usar timeout para asegurar que el canvas esté disponible
                setTimeout(function() {
                    var canvas = window.parent.document.getElementById('canvasFirma');
                    if (!canvas) {
                        console.error('Canvas de firma no encontrado');
                        return;
                    }
                    
                    var ctx = canvas.getContext('2d');
                    var dibujando = false;

                    // Configurar estilo de dibujo
                    ctx.strokeStyle = '#000000';
                    ctx.lineWidth = 2;
                    ctx.lineCap = 'round';

                    // Eventos mouse
                    canvas.addEventListener('mousedown', function(e) {
                        dibujando = true;
                        ctx.beginPath();
                        var rect = canvas.getBoundingClientRect();
                        ctx.moveTo(e.clientX - rect.left, e.clientY - rect.top);
                    });

                    canvas.addEventListener('mousemove', function(e) {
                        if (dibujando) {
                            var rect = canvas.getBoundingClientRect();
                            ctx.lineTo(e.clientX - rect.left, e.clientY - rect.top);
                            ctx.stroke();
                        }
                    });

                    canvas.addEventListener('mouseup', function() {
                        if (dibujando) {
                            dibujando = false;
                            $(window.parent.document).find('#hiddenFirma').val(canvas.toDataURL());
                            console.log('Firma guardada');
                        }
                    });

                    // Eventos touch para dispositivos móviles
                    canvas.addEventListener('touchstart', function(e) {
                        e.preventDefault();
                        dibujando = true;
                        var touch = e.touches[0];
                        var rect = canvas.getBoundingClientRect();
                        ctx.beginPath();
                        ctx.moveTo(touch.clientX - rect.left, touch.clientY - rect.top);
                    });

                    canvas.addEventListener('touchmove', function(e) {
                        e.preventDefault();
                        if (dibujando) {
                            var touch = e.touches[0];
                            var rect = canvas.getBoundingClientRect();
                            ctx.lineTo(touch.clientX - rect.left, touch.clientY - rect.top);
                            ctx.stroke();
                        }
                    });

                    canvas.addEventListener('touchend', function(e) {
                        e.preventDefault();
                        if (dibujando) {
                            dibujando = false;
                            $(window.parent.document).find('#hiddenFirma').val(canvas.toDataURL());
                            console.log('Firma guardada (touch)');
                        }
                    });

                    // Botón limpiar firma
                    $(window.parent.document).find('#btnLimpiarFirma').on('click', function() {
                        ctx.clearRect(0, 0, canvas.width, canvas.height);
                        $(window.parent.document).find('#hiddenFirma').val('');
                        console.log('Firma limpiada');
                    });
                    
                    console.log('Canvas de firma configurado correctamente');
                }, 1200); // Timeout adicional para el canvas
            }
            
            function configurarCargaArchivos() {
                console.log('Configurando carga de archivos...');
                
                setTimeout(function() {
                    $(window.parent.document).find('#fileEvidencia').on('change', function() {
                        var file = this.files[0];
                        if (!file) return;
                        
                        console.log('Archivo seleccionado:', file.name, file.type, file.size);
                        
                        // Validar tipo de archivo
                        var validExtensions = ['image/png', 'image/jpg', 'image/jpeg'];
                        if (validExtensions.indexOf(file.type) === -1) {
                            alerta('Solo se permiten archivos PNG, JPG o JPEG', 'Error');
                            $(this).val('');
                            return;
                        }
                        
                        // Validar tamaño (máximo 5MB)
                        var maxSize = 5 * 1024 * 1024; // 5MB
                        if (file.size > maxSize) {
                            alerta('El archivo es demasiado grande. Máximo 5MB permitido', 'Error');
                            $(this).val('');
                            return;
                        }
                        
                        // Convertir archivo a base64
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            $(window.parent.document).find('#hiddenEvidencia').val(e.target.result);
                            console.log('Archivo cargado correctamente:', file.name);
                            alerta('Archivo cargado correctamente: ' + file.name, 'Éxito');
                        };
                        reader.onerror = function() {
                            console.error('Error al leer el archivo');
                            alerta('Error al leer el archivo', 'Error');
                        };
                        reader.readAsDataURL(file);
                    });
                    
                    console.log('Carga de archivos configurada correctamente');
                }, 1000);
            }
            
            function cargarDatosMaestros() {
                console.log('Cargando datos maestros...');
                
                // Cargar tipos de documento
                cargarGeneralidades('#ddlTipoDocumento', 'TIID');
                
                // Cargar tipos de participante
                cargarGeneralidades('#ddlTipoParticipante', 'TIPA');
                
                // Cargar géneros
                cargarGeneralidades('#ddlGenero', 'TISE');
                
                // Cargar discapacidades
                cargarGeneralidades('#ddlDiscapacidad', 'TIDD');
                
                // Cargar institucionalizado
                cargarGeneralidades('#ddlInstitucionalizado', 'SINO');
                
                // Cargar institucionalizado cual
                cargarGeneralidades('#ddlInstitucionalizadoCual', 'INST');
                
                // Cargar realizado en festival
                cargarGeneralidades('#ddlRealizadEnFestival', 'SINO');
                
                // Cargar comunas
                cargarComunas();
            }
            
            function cargarGeneralidades(selector, tipo) {
                var jsonInput = "{ idTipoGeneralidad: '" + tipo + "' }";
                var obj = eval("(" + jsonInput + ')');
                
                $.ajax({
                    type: "POST",
                    url: '../WebMethods.aspx/ConsultarGeneralidades',
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (resultado) {
                        try {
                            const data = JSON.parse(resultado.d);
                            if (data.resultado) {
                                const informacion = JSON.parse(data.mensaje);
                                
                                // Usar window.parent.document para acceder al popup
                                $(window.parent.document).find(selector).empty();
                                $(window.parent.document).find(selector).append('<option value="">Seleccione una opción</option>');
                                
                                $.each(informacion, function (index, item) {
                                    $(window.parent.document).find(selector).append('<option value="' + item.IdGeneralidad + '">' + item.Descripcion + '</option>');
                                });
                                
                                console.log('Generalidades cargadas para ' + tipo + ': ' + informacion.length + ' elementos');
                            } else {
                                console.error('Error al cargar generalidades ' + tipo + ':', data.mensaje);
                            }
                        } catch (e) {
                            console.error('Error al procesar generalidades ' + tipo + ':', e);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error AJAX al cargar generalidades ' + tipo + ':', error);
                    }
                });
            }
            
            function cargarComunas() {
                $.ajax({
                    type: "POST",
                    url: '../WebMethods.aspx/ConsultarComunas',
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (resultado) {
                        try {
                            const data = JSON.parse(resultado.d);
                            if (data.resultado) {
                                const informacion = JSON.parse(data.mensaje);
                                
                                // Usar window.parent.document para acceder al popup
                                $(window.parent.document).find('#ddlComuna').empty();
                                $(window.parent.document).find('#ddlComuna').append('<option value="">Seleccione una opción</option>');
                                
                                $.each(informacion, function (index, item) {
                                    $(window.parent.document).find('#ddlComuna').append('<option value="' + item.IdComuna + '">' + item.Descripcion + '</option>');
                                });
                                
                                console.log('Comunas cargadas:', informacion.length + ' elementos');
                            } else {
                                console.error('Error al cargar comunas:', data.mensaje);
                            }
                        } catch (e) {
                            console.error('Error al procesar comunas:', e);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error AJAX al cargar comunas:', error);
                    }
                });
            }
            
            function cargarBarrios() {
                var idComuna = $(window.parent.document).find('#ddlComuna option:selected').val();
                
                if (!idComuna) {
                    $(window.parent.document).find('#ddlBarrio').empty();
                    $(window.parent.document).find('#ddlBarrio').append('<option value="">Seleccione una opción</option>');
                    return;
                }
                
                console.log('Cargando barrios para comuna:', idComuna);
                
                var jsonInput = "{ idComuna: '" + idComuna + "' }";
                var obj = eval("(" + jsonInput + ')');
                
                $.ajax({
                    type: "POST",
                    url: '../WebMethods.aspx/ConsultarBarrios',
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (resultado) {
                        try {
                            const data = JSON.parse(resultado.d);
                            if (data.resultado) {
                                const informacion = JSON.parse(data.mensaje);
                                $(window.parent.document).find('#ddlBarrio').empty();
                                $(window.parent.document).find('#ddlBarrio').append('<option value="">Seleccione una opción</option>');
                                
                                $.each(informacion, function (index, item) {
                                    $(window.parent.document).find('#ddlBarrio').append('<option value="' + item.IdBarrio + '">' + item.Descripcion + '</option>');
                                });
                                
                                console.log('Barrios cargados:', informacion.length + ' elementos');
                            } else {
                                console.error('Error al cargar barrios:', data.mensaje);
                            }
                        } catch (e) {
                            console.error('Error al procesar barrios:', e);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error AJAX al cargar barrios:', error);
                    }
                });
            }
            
            function configurarEventos() {
                // Esta función ya no es necesaria porque los eventos se configuran en configurarEventosPopup
                console.log('configurarEventos: Los eventos se configuran en configurarEventosPopup');
            }
            
            function configurarGeorreferenciacion() {
                // Esta función ya no es necesaria porque se configura en configurarEventosPopup
                console.log('configurarGeorreferenciacion: Se configura en configurarEventosPopup');
            }
            
            function establecerFechaActual() {
                setTimeout(function() {
                    var now = new Date();
                    var year = now.getFullYear();
                    var month = ('0' + (now.getMonth() + 1)).slice(-2);
                    var day = ('0' + now.getDate()).slice(-2);
                    var hours = ('0' + now.getHours()).slice(-2);
                    var minutes = ('0' + now.getMinutes()).slice(-2);
                    
                    var dateTimeString = year + '-' + month + '-' + day + 'T' + hours + ':' + minutes;
                    
                    // Usar window.parent.document para acceder al popup
                    var txtFechaHora = window.parent.document.getElementById('txtFechaHora');
                    if (txtFechaHora) {
                        txtFechaHora.value = dateTimeString;
                        console.log('Fecha establecida en popup:', dateTimeString);
                    } else {
                        console.error('Campo txtFechaHora no encontrado en el popup');
                    }
                }, 1500); // Mantener timeout aumentado
            }
            
            function guardarCaracterizacion() {
                console.log('Iniciando guardado de caracterización...');
                
                // Usar window.parent.document para acceder al popup
                var doc = window.parent.document;
                if (!doc) {
                    alerta('Error: No se puede acceder al formulario del popup', 'Error');
                    return;
                }
                
                // Validar campos requeridos
                var camposRequeridos = [
                    'txtFechaHora', 'txtFechaNacimiento', 'ddlTipoDocumento', 'txtNumeroIdentificacion',
                    'txtPrimeroNombre', 'txtPrimerApellido', 'txtSegundoApellido', 'txtCoordenadax',
                    'txtCoordenady', 'ddlComuna', 'ddlBarrio', 'ddlTipoParticipante', 'ddlGenero',
                    'txtTelefono', 'ddlDiscapacidad', 'ddlInstitucionalizado', 'ddlRealizadEnFestival'
                ];
                
                var camposFaltantes = [];
                for (var i = 0; i < camposRequeridos.length; i++) {
                    var campo = doc.getElementById(camposRequeridos[i]);
                    if (!campo || !campo.value || campo.value.trim() === '') {
                        camposFaltantes.push(camposRequeridos[i]);
                    }
                }
                
                // Validar firma y evidencia
                var firma = doc.getElementById('hiddenFirma');
                var evidencia = doc.getElementById('hiddenEvidencia');
                
                if (!firma || !firma.value) {
                    camposFaltantes.push('Firma digital');
                }
                
                if (!evidencia || !evidencia.value) {
                    camposFaltantes.push('Evidencia fotográfica');
                }
                
                if (camposFaltantes.length > 0) {
                    alerta('Por favor complete los siguientes campos requeridos:\n' + camposFaltantes.join('\n'), 'Advertencia');
                    return;
                }
                
                // Recopilar datos del formulario
                var datos = {
                    FechaHora: doc.getElementById('txtFechaHora').value,
                    FechaNacimiento: doc.getElementById('txtFechaNacimiento').value,
                    IdTipoDocumento: doc.getElementById('ddlTipoDocumento').value,
                    NumeroIdentificacion: doc.getElementById('txtNumeroIdentificacion').value,
                    PrimeroNombre: doc.getElementById('txtPrimeroNombre').value,
                    SegundoNombre: doc.getElementById('txtSegundoNombre').value || null,
                    PrimerApellido: doc.getElementById('txtPrimerApellido').value,
                    SegundoApellido: doc.getElementById('txtSegundoApellido').value,
                    Coordenadax: doc.getElementById('txtCoordenadax').value,
                    Coordenaday: doc.getElementById('txtCoordenady').value,
                    IdComuna: doc.getElementById('ddlComuna').value,
                    IdBarrio: doc.getElementById('ddlBarrio').value,
                    IdTipoParticipante: doc.getElementById('ddlTipoParticipante').value,
                    IdGenero: doc.getElementById('ddlGenero').value,
                    Telefono: doc.getElementById('txtTelefono').value,
                    Telefono2: doc.getElementById('txtTelefono2').value || null,
                    IdDiscapacidad: doc.getElementById('ddlDiscapacidad').value,
                    IdInstitucionalizado: doc.getElementById('ddlInstitucionalizado').value,
                    IdInstitucionalizadoCual: doc.getElementById('ddlInstitucionalizadoCual').value || null,
                    IdRealizadEnFestival: doc.getElementById('ddlRealizadEnFestival').value,
                    Observaciones: doc.getElementById('txtObservaciones').value || null,
                    Firma: doc.getElementById('hiddenFirma').value,
                    EvidenciaRegistro: doc.getElementById('hiddenEvidencia').value
                };
                
                console.log('Datos a guardar:', datos);
                
                // Llamar al método de inserción
                $.ajax({
                    type: "POST",
                    url: "../WebMethods.aspx/InsertarCaracterizacionBusquedaActiva",
                    data: JSON.stringify(datos),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (resultado) {
                        try {
                            const data = JSON.parse(resultado.d);
                            if (data.resultado) {
                                alerta('Caracterización guardada exitosamente', 'Éxito');
                                CloseModalBox();
                                // Recargar la grilla
                                cargarDatos();
                            } else {
                                alerta('Error al guardar: ' + data.mensaje, 'Error');
                            }
                        } catch (e) {
                            console.error('Error al procesar respuesta:', e);
                            alerta('Error al procesar la respuesta del servidor', 'Error');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error AJAX al guardar:', error);
                        alerta('Error de comunicación con el servidor: ' + error, 'Error');
                    }
                });
            }

        </script>
    </form>
</body>
</html> 