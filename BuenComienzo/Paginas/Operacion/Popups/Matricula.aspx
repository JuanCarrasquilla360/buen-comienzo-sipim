<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Matricula.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.Matricula" %>

<form id="NuevaMatricula">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Número Identificación*</label>
                </div>
                <div class="col-sm-4">
                    <input type='text' class="form-control" id="txtNumeroIdentificacion" disabled="disabled" />
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Fecha*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fecha'>
                        <input type='text' class="form-control" id="txtfecha" readonly="readonly" style="background-color: white" data-validation="required" />
                        <div class="input-group-addon">
                            <div class="input-group-text" style="cursor: pointer">
                                <span class="far fa-calendar-alt fa-lg"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Tipo Acción*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control select2" aria-label="Default select" id="ddlTipoAccion" data-validation="required">
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Motivo Retiro</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlMotivoRetiro" data-validation="required" disabled="disabled">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Coordinador*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlCoordinador" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Sede de atención*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlSedes" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">UBA*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlUbas" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Ciclo Vital*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlCicloVital" data-validation="required" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Numero Identificación Madre*</label>
                </div>
                <div class="col-sm-4 group">
                    <select class="form-control" aria-label="Default select" id="ddlNumeroIdentificacionMadre" data-validation="required" disabled="disabled">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</form>
