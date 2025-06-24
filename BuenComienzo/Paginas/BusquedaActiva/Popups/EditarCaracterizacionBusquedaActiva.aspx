<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarCaracterizacionBusquedaActiva.aspx.cs" Inherits="BuenComienzo.Paginas.BusquedaActiva.Popups.EditarCaracterizacionBusquedaActiva" EnableViewState="false" ContentType="text/html; charset=utf-8" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                    <input type='date' class="form-control" id="txtFechaNacimiento" data-validation="required"/>
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
                    <select class="form-control" id="ddlComuna" data-validation="required">
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
                    <input type='text' class="form-control" id="txtTelefono" data-validation="required" maxlength="10"/>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Teléfono opcional</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtTelefono2" maxlength="10"/>
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
                    <select class="form-control" id="ddlInstitucionalizado" data-validation="required">
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
            </div>
        </div>

        <!-- Campos ocultos -->
        <input type="hidden" id="hiddenFirma" />
        <input type="hidden" id="hiddenEvidencia" />
    </div>
</form>
</body>
</html> 