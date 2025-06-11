<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarCronograma.aspx.cs" Inherits="BuenComienzo.Paginas.Operacion.Popups.EditarCronograma" %>

<form id="EditarCronograma">
    <div class="row">
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Coordinador*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control select2" aria-label="Default select" id="ddlCoordinador" data-validation="required">
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
                    <select class="form-control select2" aria-label="Default select" id="ddlUbas" data-validation="required" multiple="multiple">
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Tipo de encuentro*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlTipoEncuentro" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Fecha encuentro*</label>
                </div>
                <div class="col-sm-4">
                    <div class='input-group' id='fechaEncuentro'>
                        <input type='text' class="form-control" id="txtfechaEncuentro" readonly="readonly" style="background-color: white" />
                        <div class="input-group-addon">
                            <div class="input-group-text" style="cursor: pointer">
                                <span class="far fa-calendar-alt fa-lg"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Agente educativo 1*</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlAgenteEducativo1" data-validation="required">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Agente educativo 2</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlAgenteEducativo2">
                        <option value="" selected>Seleccione una opción</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row" style="padding: 4px 4px 4px 4px;">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Punto de referencia</label>
                </div>
                <div class="col-sm-4">
                    <textarea id="txtPuntoReferencia" cols="40" rows="2" class="form-control" style="resize: none" maxlength="200"></textarea>
                </div>
            </div>
        </div>
        <div id="dvReprogramar" class="row" style="padding: 4px 4px 4px 4px; display: none">
            <div class="col-sm-12">
                <div class="col-sm-2">
                    <label class="control-label">Motivo reprogramación</label>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" aria-label="Default select" id="ddlMotivoReprogramacion" data-validation="required">
                    </select>
                </div>
                <div class="col-sm-2">
                    <label class="control-label">Observaciones reprogramación</label>
                </div>
                <div class="col-sm-4">
                    <textarea id="txtObservacionesReprogramacion" cols="40" rows="2" class="form-control" style="resize: none" maxlength="200"></textarea>
                </div>
            </div>
        </div>
    </div>
</form>
