<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarCaracterizacionBusquedaActiva.aspx.cs" Inherits="BuenComienzo.Paginas.BusquedaActiva.Popups.EditarCaracterizacionBusquedaActiva" %>
<%@ Page ResponseEncoding="UTF-8" %>
<%@ Page ContentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Caracterización Búsqueda Activa</title>
</head>
<body>
    <form id="EditarCaracterizacionBusquedaActiva">
        <div class="row">
            <!-- Fecha focalización -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Fecha focalización*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='datetime-local' class="form-control" id="txtFechaHora" data-validation="required"/>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">Fecha de nacimiento*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='date' class="form-control" id="txtFechaNacimiento" data-validation="required" onchange="calcularEdad()"/>
                    </div>
                </div>
            </div>

            <!-- Edad calculada y Tipo documento -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Edad calculada</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtEdadCalculada" readonly style="background-color: #f5f5f5"/>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">Tipo documento*</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlTipoDocumento" data-validation="required">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Identificación -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Número de identificación*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtNumeroIdentificacion" maxlength="20" data-validation="required"/>
                    </div>
                </div>
            </div>

            <!-- Nombres -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Primer nombre*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtPrimeroNombre" data-validation="required" maxlength="50" style="text-transform: uppercase"/>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">Segundo nombre</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtSegundoNombre" maxlength="50" style="text-transform: uppercase"/>
                    </div>
                </div>
            </div>

            <!-- Apellidos -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Primer apellido*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtPrimerApellido" data-validation="required" maxlength="50" style="text-transform: uppercase"/>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">Segundo apellido*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtSegundoApellido" data-validation="required" maxlength="50" style="text-transform: uppercase"/>
                    </div>
                </div>
            </div>

            <!-- Coordenadas -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Coordenada X*</label>
                    </div>
                    <div class="col-sm-3">
                        <input type='text' class="form-control" id="txtCoordenadax" data-validation="required" readonly style="background-color: #f5f5f5"/>
                    </div>
                    <div class="col-sm-1">
                        <button type="button" class="btn btn-info" id="btnObtenerUbicacion" title="Obtener ubicación">
                            <i class="fa fa-map-marker"></i>
                        </button>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">Coordenada Y*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtCoordenady" data-validation="required" readonly style="background-color: #f5f5f5"/>
                    </div>
                </div>
            </div>

            <!-- Ubicación -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Comuna de residencia*</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlComuna" data-validation="required" onchange="cargarBarriosPorComuna(this.value)">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">Barrio de residencia*</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlBarrio" data-validation="required">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Tipo participante y género -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Tipo de participante*</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlTipoParticipante" data-validation="required">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">Género*</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlGenero" data-validation="required">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Teléfonos -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Teléfono principal*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtTelefono" data-validation="required" maxlength="10" pattern="^(604|3)[0-9]{7}$"/>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">Teléfono opcional</label>
                    </div>
                    <div class="col-sm-4">
                        <input type='text' class="form-control" id="txtTelefono2" maxlength="10" pattern="^(604|3)[0-9]{7}$"/>
                    </div>
                </div>
            </div>

            <!-- Discapacidad e institucionalización -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Presenta discapacidad*</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlDiscapacidad" data-validation="required">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">¿Institucionalizado?*</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlInstitucionalizado" data-validation="required" onchange="habilitarInstitucionalizadoCual()">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Institucionalizado cual y festival -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">¿Institucionalizado en cuál?</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlInstitucionalizadoCual" disabled>
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                    <div class="col-sm-2">
                        <label class="control-label">¿Realizada en festival?*</label>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" id="ddlRealizadEnFestival" data-validation="required">
                            <option value="">Seleccione una opción</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Observaciones -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Observaciones</label>
                    </div>
                    <div class="col-sm-10">
                        <textarea class="form-control" id="txtObservaciones" maxlength="500" rows="3" placeholder="Escriba sus observaciones aquí..."></textarea>
                    </div>
                </div>
            </div>

            <!-- Firma digital -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Firma digital*</label>
                    </div>
                    <div class="col-sm-8">
                        <canvas id="canvasFirma" width="400" height="150" style="border: 1px solid #ccc; background-color: white;"></canvas>
                        <br>
                        <button type="button" class="btn btn-warning btn-sm" id="btnLimpiarFirma">Limpiar firma</button>
                    </div>
                </div>
            </div>

            <!-- Evidencia fotográfica -->
            <div class="row" style="padding: 4px;">
                <div class="col-sm-12">
                    <div class="col-sm-2">
                        <label class="control-label">Evidencia fotográfica*</label>
                    </div>
                    <div class="col-sm-4">
                        <input type="file" class="form-control" id="fileEvidencia" accept="image/png,image/jpg,image/jpeg"/>
                    </div>
                    <div class="col-sm-2">
                        <button type="button" class="btn btn-success btn-sm" id="btnTomarFoto" style="display:none;">Tomar foto</button>
                    </div>
                    <div class="col-sm-4">
                        <video id="video" width="200" height="150" style="display:none;"></video>
                        <canvas id="canvasFoto" width="200" height="150" style="display:none;"></canvas>
                    </div>
                </div>
            </div>

            <!-- Campos ocultos -->
            <input type="hidden" id="hiddenFirma" />
            <input type="hidden" id="hiddenEvidencia" />
        </div>

        <script type="text/javascript">
            console.log('Popup de Caracterización Búsqueda Activa cargado');
            
            $(document).ready(function() {
                console.log('Document ready en popup');
                
                // Configurar fecha actual por defecto
                establecerFechaActual();
                
                // Cargar datos maestros
                cargarDatosMaestros();
                
                // Configurar eventos
                configurarEventos();
                
                // Configurar geolocalización
                configurarGeorreferenciacion();
                
                // Configurar firma digital
                configurarCanvasFirma();
                
                // Configurar carga de archivos
                configurarCargaArchivos();
            });

            function establecerFechaActual() {
                var now = new Date();
                var year = now.getFullYear();
                var month = ('0' + (now.getMonth() + 1)).slice(-2);
                var day = ('0' + now.getDate()).slice(-2);
                var hours = ('0' + now.getHours()).slice(-2);
                var minutes = ('0' + now.getMinutes()).slice(-2);
                
                var dateTimeString = year + '-' + month + '-' + day + 'T' + hours + ':' + minutes;
                $('#txtFechaHora').val(dateTimeString);
                console.log('Fecha establecida:', dateTimeString);
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
                $.ajax({
                    type: "POST",
                    url: '../WebMethods.aspx/ConsultarGeneralidades',
                    data: JSON.stringify({ idTipoGeneralidad: tipo }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (resultado) {
                        try {
                            const data = JSON.parse(resultado.d);
                            if (data.resultado) {
                                const informacion = JSON.parse(data.mensaje);
                                $(selector).empty();
                                $(selector).append('<option value="">Seleccione una opción</option>');
                                
                                $.each(informacion, function (index, item) {
                                    $(selector).append('<option value="' + item.IdGeneralidad + '">' + item.Descripcion + '</option>');
                                });
                            }
                        } catch (e) {
                            console.error('Error al cargar generalidades ' + tipo + ':', e);
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
                                $('#ddlComuna').empty();
                                $('#ddlComuna').append('<option value="">Seleccione una opción</option>');
                                
                                $.each(informacion, function (index, item) {
                                    $('#ddlComuna').append('<option value="' + item.IdComuna + '">' + item.Descripcion + '</option>');
                                });
                            }
                        } catch (e) {
                            console.error('Error al cargar comunas:', e);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error AJAX al cargar comunas:', error);
                    }
                });
            }

            function cargarBarriosPorComuna(idComuna) {
                if (!idComuna) {
                    $('#ddlBarrio').empty();
                    $('#ddlBarrio').append('<option value="">Seleccione una opción</option>');
                    return;
                }
                
                $.ajax({
                    type: "POST",
                    url: '../WebMethods.aspx/ConsultarBarrios',
                    data: JSON.stringify({ idComuna: idComuna }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (resultado) {
                        try {
                            const data = JSON.parse(resultado.d);
                            if (data.resultado) {
                                const informacion = JSON.parse(data.mensaje);
                                $('#ddlBarrio').empty();
                                $('#ddlBarrio').append('<option value="">Seleccione una opción</option>');
                                
                                $.each(informacion, function (index, item) {
                                    $('#ddlBarrio').append('<option value="' + item.IdBarrio + '">' + item.Descripcion + '</option>');
                                });
                            }
                        } catch (e) {
                            console.error('Error al cargar barrios:', e);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error AJAX al cargar barrios:', error);
                    }
                });
            }

            function calcularEdad() {
                var fechaNacimiento = new Date($('#txtFechaNacimiento').val());
                var fechaActual = new Date();
                
                if (fechaNacimiento > fechaActual) {
                    $('#txtEdadCalculada').val('Fecha inválida');
                    return;
                }

                var años = fechaActual.getFullYear() - fechaNacimiento.getFullYear();
                var meses = fechaActual.getMonth() - fechaNacimiento.getMonth();
                var días = fechaActual.getDate() - fechaNacimiento.getDate();

                if (días < 0) {
                    meses--;
                    días += new Date(fechaActual.getFullYear(), fechaActual.getMonth(), 0).getDate();
                }

                if (meses < 0) {
                    años--;
                    meses += 12;
                }

                var edadTexto = años + ' años ' + meses + ' meses y ' + días + ' días';
                $('#txtEdadCalculada').val(edadTexto);
            }

            function habilitarInstitucionalizadoCual() {
                var valor = $('#ddlInstitucionalizado').val();
                if (valor === 'SINO001') { // Sí
                    $('#ddlInstitucionalizadoCual').prop('disabled', false);
                    $('#ddlInstitucionalizadoCual').attr('data-validation', 'required');
                } else {
                    $('#ddlInstitucionalizadoCual').prop('disabled', true);
                    $('#ddlInstitucionalizadoCual').removeAttr('data-validation');
                    $('#ddlInstitucionalizadoCual').val('');
                }
            }

            function configurarEventos() {
                // Validación de teléfonos
                $('#txtTelefono, #txtTelefono2').on('input', function() {
                    var valor = $(this).val();
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
            }

            function configurarGeorreferenciacion() {
                $('#btnObtenerUbicacion').click(function() {
                    if (navigator.geolocation) {
                        navigator.geolocation.getCurrentPosition(function(position) {
                            $('#txtCoordenadax').val(position.coords.latitude);
                            $('#txtCoordenady').val(position.coords.longitude);
                            console.log('Ubicación obtenida:', position.coords.latitude, position.coords.longitude);
                            alert('Ubicación obtenida correctamente');
                        }, function(error) {
                            console.error('Error al obtener ubicación:', error);
                            alert('Error al obtener la ubicación: ' + error.message);
                        });
                    } else {
                        alert('La geolocalización no es compatible con este navegador');
                    }
                });
            }

            function configurarCanvasFirma() {
                var canvas = document.getElementById('canvasFirma');
                var ctx = canvas.getContext('2d');
                var dibujando = false;

                // Eventos mouse
                canvas.addEventListener('mousedown', function(e) {
                    dibujando = true;
                    ctx.beginPath();
                    ctx.moveTo(e.offsetX, e.offsetY);
                });

                canvas.addEventListener('mousemove', function(e) {
                    if (dibujando) {
                        ctx.lineTo(e.offsetX, e.offsetY);
                        ctx.stroke();
                    }
                });

                canvas.addEventListener('mouseup', function() {
                    dibujando = false;
                    $('#hiddenFirma').val(canvas.toDataURL());
                });

                // Eventos touch para móviles
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
                    dibujando = false;
                    $('#hiddenFirma').val(canvas.toDataURL());
                });

                $('#btnLimpiarFirma').click(function() {
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                    $('#hiddenFirma').val('');
                });
            }

            function configurarCargaArchivos() {
                $('#fileEvidencia').change(function() {
                    var file = this.files[0];
                    if (file) {
                        var validExtensions = ['image/png', 'image/jpg', 'image/jpeg'];
                        if (validExtensions.indexOf(file.type) === -1) {
                            alert('Solo se permiten archivos PNG, JPG o JPEG');
                            $(this).val('');
                            return;
                        }
                        
                        // Convertir archivo a base64
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            $('#hiddenEvidencia').val(e.target.result);
                            console.log('Archivo cargado:', file.name);
                        };
                        reader.readAsDataURL(file);
                    }
                });

                // Detectar si es dispositivo móvil para mostrar opción de tomar foto
                if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                    $('#btnTomarFoto').show();
                }

                $('#btnTomarFoto').click(function() {
                    activarCamara();
                });
            }

            function activarCamara() {
                var video = document.getElementById('video');
                var canvas = document.getElementById('canvasFoto');
                var ctx = canvas.getContext('2d');

                navigator.mediaDevices.getUserMedia({ video: true })
                    .then(function(stream) {
                        video.srcObject = stream;
                        video.style.display = 'block';
                        video.play();

                        var btnCapturar = $('<button type="button" class="btn btn-success btn-sm">Capturar</button>');
                        btnCapturar.click(function() {
                            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
                            var imageData = canvas.toDataURL('image/png');
                            $('#hiddenEvidencia').val(imageData);
                            
                            stream.getTracks().forEach(track => track.stop());
                            video.style.display = 'none';
                            btnCapturar.remove();
                            
                            alert('Foto capturada correctamente');
                        });

                        $('#btnTomarFoto').after(btnCapturar);
                    })
                    .catch(function(err) {
                        console.error('Error al acceder a la cámara:', err);
                        alert('No se pudo acceder a la cámara');
                    });
            }
        </script>
    </form>
</body>
</html> 